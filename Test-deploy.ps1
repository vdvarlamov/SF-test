[string]$sfendpoint = 'localhost:19000'
[string]$packagePath= ".\TestApp"
[string]$appName = "TestApp"
[string]$ServiceName = "FirstService"
$AppParameter = @{
    Memory = "1024"
    CpuCores = "1"
    $($serviceName+'_InstanceCount') = "1"
    }

Test-ServiceFabricApplicationPackage -ApplicationPackagePath $packagePath -ApplicationParameter $AppParameter
Connect-ServiceFabricCluster -ConnectionEndpoint $SFendPoint -KeepAliveIntervalInSec 10
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $packagePath -ImageStoreConnectionString fabric:ImageStore -ApplicationPackagePathInImageStore $appName
Register-ServiceFabricApplicationType -ApplicationPathInImageStore $appName
Remove-ServiceFabricApplicationPackage -ImageStoreConnectionString fabric:ImageStore -ApplicationPackagePathInImageStore $appName
New-ServiceFabricApplication -ApplicationName $('fabric:/'+$AppName) -ApplicationTypeName $($appname+'Type') -ApplicationTypeVersion "1.1.0" -ApplicationParameter $AppParameter
