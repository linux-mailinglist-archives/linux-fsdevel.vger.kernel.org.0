Return-Path: <linux-fsdevel+bounces-13392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB486F504
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8196B21B80
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A8D26D;
	Sun,  3 Mar 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7u89XzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26998C153;
	Sun,  3 Mar 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471702; cv=fail; b=vADSOSvMueVKE8+NU4Ju9ebT4qBX3OTchRtTm9eViFHe8zMjwGsWdXNORPU1m3e7rgvjaH6EoR+M1oqNSufTwjl+YWMnYgTVztBG/O+cW3Llo21f+WDLR9sPZzOOqPAGYQbG++2WGsSWwypkHivuSm+Fo4Np3o/VaJP2aDqMX+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471702; c=relaxed/simple;
	bh=UlL4o9If2lcMejr/VBFV42hBfl+SZrEf1XkwzFBZ5VU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uqcoMoI9O99UUZiRz7/QutbglmqZ4dooesekQppCvVRQKf2yOyLU1xwuh3SChgEVDFhTC/8DJxfpLLVtfrSfZj3uIQWZH9BBJqZ5Lc/eA73MA+Vx1YH6/5qghhyPpmI1KP/bM3BVGeEGThEPAbcvBASHzyx2Jr8Skp7CvJWS7kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7u89XzO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709471698; x=1741007698;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=UlL4o9If2lcMejr/VBFV42hBfl+SZrEf1XkwzFBZ5VU=;
  b=Y7u89XzOYWPRF40ihkQXGWVc1af7gzzGif4tWsOLS8FzsHNLQbbFw7NU
   5tLOGrYh9JQdgTUeY+3AUxqxrP+IvsFaLTQGDBl/ebtx874Xi+/Nmcl+5
   NY7u5HSIV4kDhdzPp9gKVaBHoyGKUs4FE+46i7AHHsRiU8nUhrVwtri8b
   5y1O4TBaM5B0HBp9BwMZnUSuBetgU9Iohpphg0BgJuMuC2zfA0cQo/dFB
   K5jza2oIYuHD4S4Blpmp8b4Kjo62NqtfSGYCQ8XAhrdEoIx1yHZPPGZJW
   A5qwd8kcqN87QBs00P5hX8oBEdZi0AkBuuVQIEq7G/kA4FoKgHbJtYTAe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="4133824"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="xz'341?scan'341,208,341";a="4133824"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 05:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="xz'341?scan'341,208,341";a="8590929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 05:14:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 05:14:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 05:14:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 05:14:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6mxYic1CJmoOUrIDEglsDPSndn1EwOY7vXZ2quRwz/fPbLGHlcDsfM1FXSYVwCuGx4Ha3X4SZQ6emQvlDC73/IDmxvU5RiF84TyYtfTKfVeqChwiFlDNOCTd6/CvzJ5ge9RwnROvr3lb7HaxuwIluZ6r4ljErcCgO+OOWCN+BT8jKFMCG/CRXhgSQp7t2ECkQN+lakX15xKXIIe5sWOZsc2rztnQyhX9ImJTxp8j9GPB0/CJGpimIdY68Fpk/XAJ1EBNgFD3vTfNWxMpwD+xBICLBkvDmKKSxoFJitUjIhGPTomWakOEdCxs8yE43dUzI9INx/7spmQdoVvHijYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGef6BhCw9wW0c01CW9YQIJ6s2pKe6l6diM40jFuLRQ=;
 b=jJ0SP4fzy2UaWu22VoLChEuCnH/kS7itYjkntRQOh1rOoQwGPLv+yb/ER0UW6BcopArUHig0GouhrB8gmTEijhM+CbXYPO0OVWXkSmMBXnp77bUlKMYo2Deaqz4yrA0VLx157m7Xuy9o9+Jz1SvLKAWdNkAFEr4zPlr3cjtsno4H0WfLkjZf//EsKbs3KxQdr0RnZpJGFFf+yF+kAapx3ahTnOPsegvJyqhq0U3XzS/zGdFN7+HOByrhoEOHzCAW9kRcyBVr4WUdqfZZqGOuvOQ9EM74EQdv/5642rZZma9/YOmZN0YzbpTU4u8f4I5etBXy2uqrxVq4y1iyqFJ+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sun, 3 Mar
 2024 13:14:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Sun, 3 Mar 2024
 13:14:52 +0000
Date: Sun, 3 Mar 2024 21:14:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [viro-vfs:work.simple_recursive_removal] [rpc_pipe]  1d8f830b7f:
 fsmark.app_overhead 17.5% regression
Message-ID: <202403011849.c1afb89c-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="/o6zIcgQ5Xur3JQC"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: ef51ab44-bdc4-403f-a341-08dc3b83e968
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpucYZEj8/jVP5pHQjW/2Np+D1f8E74euIJoiwHSoiwdO+kngEWBFGsllFLEqixCGoePyt48F206dKwsjQ1Kj4GSxF8v3feLwtCawB5hFJ1gGCj9dmDypGYP4KJS63jwvtM2+2IC7b0E6v66CpCvS9sffA6uOkOY82gSWi1XT8g64VGBheKTp2W/53kr5Cub86UlLvFe/IzXV0Tvjctbeu0RSntA1FUynYCxePJi0XdLpizxkE7qNnkIMYFphWEtraxVp1T8cnFw51TlXJLul44UAr/XysBUIjmmnqLwj6Zsb6/G8rcfuDe0kw1YHfmI87YK6YuX/ILvIbG5dTRNOX78KDhKF3eWIG3jKRGLLUn6jNsMNjhaaWPrJP3ua7AcXnYImvJfi4aeIu3gIirmvIM9DelxOR93Dmd4Rs7KnWIjwgrgeZOTnnda+YqzlOiuW3u6azf+zwyNzUKjoj0sGFIFWOt3EJX0zRU6QRerQRd0XfHOh/qfEqCPrKuk89vzDhhsZF/tnn84o50alEyIhIjPQBalIZpElfwIDe5NyzoJCpzSmloMqhv46flWNin9l+1JrFzSTZRohqUjQ+qecg8fPsayiJzEqL+kIOujCCMhO35bd4UMj5ubrmaW2htA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qrDZdLC89JpqggxK3vLZsq660zAbPyrxk7DsubLycrVTf+qZgzIg0Kl+cN?=
 =?iso-8859-1?Q?qrbGGozbT2i0F58AnZ1t5VxqZXLiV6Q7R+TRvF4X8/Lf/ecmoWKTt+bjK7?=
 =?iso-8859-1?Q?en5L9h7BIqw9eH6ba45Q63G3XhychHLu5feGoVQyPGKfnH5YF8siUw7FvS?=
 =?iso-8859-1?Q?U1TWSK5VAATjG35sbYKWAXJwuYdt6Nj/axnX3BkFUH0TTsPokZvtEqb6Vc?=
 =?iso-8859-1?Q?W86ywFgX0z4sIwNh8w7qYrIguoJ29yjCC9ByohWz3kHj49ce7jHDUNaSlZ?=
 =?iso-8859-1?Q?kYmA3TNehPbXdwujxzpEdR2+ugzmzu9IbPQB31/+xs8x1TxMXGss61nyoJ?=
 =?iso-8859-1?Q?wgovIMEEFET2vjkFPF8Yu2g724epLfvrGf+OkrYUW+3Vtgm59l42YDeDMw?=
 =?iso-8859-1?Q?qcNvgf1cJb9BJ9jq7RybY+aBWPKHFo+a4oAXSp9eIovX0D1zWFWTwCGhSe?=
 =?iso-8859-1?Q?Qre+an6OinYuVypcdOAyeMz15QUhJPFGqD24jYEieQyOd2BXu1LL7dOxn4?=
 =?iso-8859-1?Q?YWgV36CMNt+hcBnKFrkERlFgKNzSmI8lXxldK62l2iPZ7QANHY/ZP1A/AW?=
 =?iso-8859-1?Q?weXNAdUkNWjZXioPwB8UEy7e8j/V4zaV8aJTJ4oJ+WgKnBG2V6CRRHVyC1?=
 =?iso-8859-1?Q?Iy7fywu/vM1YmudHyGdM8UVZSePKYpnktad+JC0o3mnfmUgIvZv2dOEwYF?=
 =?iso-8859-1?Q?zLb6Tbi1drT/NmR6rH2rcJ7PZH/LZ8NSic2H0Ay0RIA/AMvRVmJ3YdGzWW?=
 =?iso-8859-1?Q?ZdJ4lY9mmAur/Am1XO/iH/6ZJL/7kllErdomqIdLQ3IKSKK3/9yj4GswW7?=
 =?iso-8859-1?Q?W9cJjeBJUgBGcfz93mEvfqnrIpnHT08Eej3000+DQ7wvgoHnsrJqyTHy2D?=
 =?iso-8859-1?Q?RCRImXmXpbB/4AfgI+ocApEDRoosJFyjJ5zrlZIIBg/HPb/Qb7a4iCWDSb?=
 =?iso-8859-1?Q?2dm/UPc/HZu3YpuhZXSpYvL3j2FlYzsPu6aGKvGj9rine3ZzDTVB3Vg78+?=
 =?iso-8859-1?Q?tG8zlCwceq6ep3QxN2hBY3EkrUdGN8KeUiky8TR0LzVT4tEm4+3Kmlnw9X?=
 =?iso-8859-1?Q?/6Sr9D8nIIx8CMdQUPNU5WdvWpCk1tsbaZz7rzcK43AryA3YCUpveXYR6N?=
 =?iso-8859-1?Q?iI3660T34G+sWWGvFcUxU1vLdIs+525VxPKt6lSVIWY05FJ4fRwcl06m0g?=
 =?iso-8859-1?Q?xqRmXjbSGn0IAn41Z6U3638QN1HXjMNzENllEn76eiSqqS6NPi4wbD9DT0?=
 =?iso-8859-1?Q?zq8OwHCkp7OKIBsFayY+jtj1HlBWSANG65kFjPYyL60+NMMnaCYHaZnuoY?=
 =?iso-8859-1?Q?2zhmV8ZkGj0XpqGtB5m100hRSZntfqJ68tWU02OVsN4ij/0d1JCjUv+cA2?=
 =?iso-8859-1?Q?bI94kpH/x+9AZp66oO/ZafDO2lbjvdFSAGxnbesB0uAXiYIIDEt1+De3+x?=
 =?iso-8859-1?Q?IEtwZsQJAPdkTqu/LUN1X41c55vRf/TND1JVtyFbxu5johZCdTC/l+1T39?=
 =?iso-8859-1?Q?IdKjRYeRQVwcxDeOvzBcK13rr8dT7PjblItyIDriCD+VxHH9+l9glG4xoj?=
 =?iso-8859-1?Q?XP+estp5rLrQvomEExouf5ddY0gkb0tb3JzrrjEUi5e9eqPw0n0IfE468q?=
 =?iso-8859-1?Q?kkUaxzFG0YgazZ7axYkgUTFhp7rm/2I4MJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef51ab44-bdc4-403f-a341-08dc3b83e968
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2024 13:14:52.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdKujdQHW6c+Xw4mYbPtTEav6n46lVjRK5vVVHmJDoGOCsAvPmXDFI8UzuWrbkeoj9+0defQnHl54yKRVRcd9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com

--/o6zIcgQ5Xur3JQC
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


hi, Al Viro,

besides below performance report, we noticed stderr
"A_dependency_job_for_nfs-idmapd.service_failed.See'journalctl-xe'for_details"
while testing which we didn't observe on parent.

we also noticed there are something like below in attached kmsg.xz:
kern  :warn  : [   61.938032] NFSD: Unable to initialize client recovery tracking! (-110)
kern  :info  : [   61.946579] NFSD: starting 90-second grace period (net f0000000)
kern  :warn  : [   63.146060] NFSD: Unable to initialize client recovery tracking! (-110)
kern  :info  : [   63.154531] NFSD: starting 90-second grace period (net f0000000)

which we didn't observed in parent tests, either.

we are not sure whether these impact the performance results, all these FYI.


Hello,

kernel test robot noticed a 17.5% regression of fsmark.app_overhead on:


commit: 1d8f830b7f27ba92a700a86988695e965f73b15a ("rpc_pipe: get rid of __rpc_lookup_create_exclusive()")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.simple_recursive_removal

testcase: fsmark
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
parameters:

	iterations: 1x
	nr_threads: 32t
	disk: 1SSD
	fs: xfs
	fs2: nfsv4
	filesize: 8K
	test_size: 400M
	sync_method: fsyncBeforeClose
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.app_overhead 20.3% regression                                                    |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | disk=1SSD                                                                                       |
|                  | filesize=9B                                                                                     |
|                  | fs2=nfsv4                                                                                       |
|                  | fs=xfs                                                                                          |
|                  | iterations=1x                                                                                   |
|                  | nr_directories=16d                                                                              |
|                  | nr_files_per_directory=256fpd                                                                   |
|                  | nr_threads=32t                                                                                  |
|                  | sync_method=fsyncBeforeClose                                                                    |
|                  | test_size=400M                                                                                  |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403011849.c1afb89c-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240301/202403011849.c1afb89c-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/8K/nfsv4/xfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep1/400M/fsmark

commit: 
  82a439e321 ("rpc_pipe: fold __rpc_mkpipe_dentry() into its sole caller")
  1d8f830b7f ("rpc_pipe: get rid of __rpc_lookup_create_exclusive()")

82a439e3213e7095 1d8f830b7f27ba92a700a869886 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     stderr.A_dependency_job_for_nfs-idmapd.service_failed.See'journalctl-xe'for_details
           :6          100%           6:6     stderr.has_stderr
         %stddev     %change         %stddev
             \          |                \  
   2398327           +12.3%    2692538        cpuidle..usage
    107204          +140.2%     257509 ± 16%  meminfo.AnonHugePages
    304743            +9.2%     332637 ±  2%  vmstat.system.cs
    413300 ±  6%     +14.4%     472827 ±  3%  numa-numastat.node0.local_node
    445362 ±  5%     +12.9%     502812 ±  2%  numa-numastat.node0.numa_hit
    445128 ±  5%     +13.1%     503240 ±  2%  numa-vmstat.node0.numa_hit
    413066 ±  6%     +14.6%     473254 ±  3%  numa-vmstat.node0.numa_local
     66.15 ±  2%    +164.6%     175.04        uptime.boot
      2769 ±  2%    +188.3%       7983        uptime.idle
  65542525           +17.5%   77003387        fsmark.app_overhead
     55.33            +4.2%      57.67        fsmark.time.percent_of_cpu_this_job_got
    288191            +5.1%     302810        fsmark.time.voluntary_context_switches
     74.50            +2.9%      76.68        iostat.cpu.idle
     17.01           -10.9%      15.15 ±  2%  iostat.cpu.iowait
      2.59           -14.6%       2.21        iostat.cpu.user
     19.75            -2.3       17.47 ±  2%  mpstat.cpu.all.iowait%
      2.63            -0.4        2.23        mpstat.cpu.all.usr%
     12.34 ±  2%     -17.5%      10.18 ±  2%  mpstat.max_utilization_pct
     53999 ±  2%    +201.1%     162576        sched_debug.cpu_clk
     53400 ±  2%    +203.3%     161979 ±  2%  sched_debug.ktime
     54525 ±  2%    +199.2%     163131 ±  2%  sched_debug.sched_clk
     52.21          +140.6%     125.62 ± 16%  proc-vmstat.nr_anon_transparent_hugepages
      8420            -3.2%       8154        proc-vmstat.nr_mapped
     41883            +2.1%      42754        proc-vmstat.nr_slab_reclaimable
     31420            +8.4%      34074        proc-vmstat.nr_slab_unreclaimable
    704537            +7.9%     760346        proc-vmstat.numa_hit
    654821            +8.5%     710630        proc-vmstat.numa_local
   1039627            +6.1%    1103455        proc-vmstat.pgalloc_normal
    729116 ±  6%     +16.2%     846939        proc-vmstat.pgfree
      1.13 ±  3%      +9.8%       1.24 ±  2%  perf-stat.i.MPKI
 2.134e+09            -5.1%  2.026e+09        perf-stat.i.branch-instructions
      4.84            -0.2        4.63        perf-stat.i.branch-miss-rate%
  1.03e+08            -8.7%   94072597        perf-stat.i.branch-misses
      6.16 ±  2%      -0.3        5.86 ±  3%  perf-stat.i.cache-miss-rate%
  11302040 ±  2%      +6.8%   12067382 ±  3%  perf-stat.i.cache-misses
 2.199e+08            +9.6%  2.409e+08        perf-stat.i.cache-references
    360033           +14.8%     413385        perf-stat.i.context-switches
      2239 ±  4%     +13.0%       2530 ±  4%  perf-stat.i.cpu-migrations
      1472 ±  2%      -6.0%       1384 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.039e+10            -5.7%  9.795e+09        perf-stat.i.instructions
      0.64            -5.0%       0.60        perf-stat.i.ipc
      7.68           +14.3%       8.78        perf-stat.i.metric.K/sec
      9527 ±  3%     -13.3%       8258 ±  7%  perf-stat.i.minor-faults
      9528 ±  3%     -13.3%       8258 ±  7%  perf-stat.i.page-faults
      1.09 ±  3%     +13.1%       1.23 ±  2%  perf-stat.overall.MPKI
      4.83            -0.2        4.65        perf-stat.overall.branch-miss-rate%
      1.59            +6.5%       1.70        perf-stat.overall.cpi
      1464 ±  2%      -5.9%       1378 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.63            -6.1%       0.59        perf-stat.overall.ipc
 1.955e+09            -5.0%  1.857e+09        perf-stat.ps.branch-instructions
  94404569            -8.6%   86246777        perf-stat.ps.branch-misses
  10360850 ±  2%      +6.8%   11061496 ±  3%  perf-stat.ps.cache-misses
 2.017e+08            +9.5%  2.209e+08        perf-stat.ps.cache-references
    330250           +14.8%     379036        perf-stat.ps.context-switches
      2054 ±  4%     +12.9%       2320 ±  4%  perf-stat.ps.cpu-migrations
 9.517e+09            -5.7%  8.979e+09        perf-stat.ps.instructions
      8697 ±  3%     -13.1%       7557 ±  7%  perf-stat.ps.minor-faults
      8697 ±  3%     -13.1%       7558 ±  7%  perf-stat.ps.page-faults
 1.151e+11            -6.0%  1.082e+11        perf-stat.total.instructions


***************************************************************************************************
lkp-ivb-2ep1: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/9B/nfsv4/xfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep1/400M/fsmark

commit: 
  82a439e321 ("rpc_pipe: fold __rpc_mkpipe_dentry() into its sole caller")
  1d8f830b7f ("rpc_pipe: get rid of __rpc_lookup_create_exclusive()")

82a439e3213e7095 1d8f830b7f27ba92a700a869886 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     stderr.A_dependency_job_for_nfs-idmapd.service_failed.See'journalctl-xe'for_details
           :6          100%           6:6     stderr.has_stderr
         %stddev     %change         %stddev
             \          |                \  
   4652582           +12.3%    5226642        cpuidle..usage
      1.26 ± 74%      +2.3        3.56 ± 31%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
    188802 ±  2%     +63.3%     308290 ± 19%  meminfo.AnonHugePages
    140056           +10.9%     155322        meminfo.SUnreclaim
      5.50            +0.6        6.05 ±  2%  mpstat.cpu.all.sys%
     12.67           -16.1%      10.63        mpstat.max_utilization_pct
    655519 ±  2%     +14.2%     748457 ±  2%  numa-numastat.node0.local_node
    680860           +14.6%     779999 ±  2%  numa-numastat.node0.numa_hit
    681047           +14.6%     780819 ±  2%  numa-vmstat.node0.numa_hit
    655706 ±  2%     +14.3%     749281 ±  2%  numa-vmstat.node0.numa_local
     77.80 ±  3%    +133.7%     181.80        uptime.boot
      3182 ±  4%    +156.6%       8168        uptime.idle
    349730           +15.0%     402139        vmstat.system.cs
     71199            +5.9%      75404        vmstat.system.in
 1.219e+08           +20.3%  1.467e+08        fsmark.app_overhead
     55.83            +3.3%      57.67        fsmark.time.percent_of_cpu_this_job_got
    574683            +3.9%     597195        fsmark.time.voluntary_context_switches
     18.20            -5.0%      17.30        iostat.cpu.iowait
      6.17            +8.8%       6.72        iostat.cpu.system
      2.48           -11.1%       2.21        iostat.cpu.user
     56144 ±  4%    +184.2%     159591        sched_debug.cpu_clk
     55548 ±  4%    +186.2%     158995        sched_debug.ktime
     56677 ±  4%    +182.5%     160122        sched_debug.sched_clk
     91.96 ±  2%     +64.1%     150.93 ± 18%  proc-vmstat.nr_anon_transparent_hugepages
      8527            -4.7%       8128        proc-vmstat.nr_mapped
     35029           +10.9%      38832        proc-vmstat.nr_slab_unreclaimable
    980307           +11.0%    1087887        proc-vmstat.numa_hit
    930596           +11.4%    1036273        proc-vmstat.numa_local
   1446464            +7.9%    1560287        proc-vmstat.pgalloc_normal
      1.06 ±  2%      +8.4%       1.15 ±  3%  perf-stat.i.MPKI
      5.00            -0.2        4.83        perf-stat.i.branch-miss-rate%
 1.016e+08            -2.9%   98670000        perf-stat.i.branch-misses
  10378740 ±  2%      +9.1%   11323437 ±  3%  perf-stat.i.cache-misses
 2.348e+08            +9.3%  2.566e+08        perf-stat.i.cache-references
    396967           +13.9%     452135        perf-stat.i.context-switches
      1.70            +2.9%       1.74        perf-stat.i.cpi
 1.647e+10            +4.9%  1.728e+10        perf-stat.i.cpu-cycles
      2382           +13.4%       2702 ±  2%  perf-stat.i.cpu-migrations
      0.61            -4.0%       0.58        perf-stat.i.ipc
      8.36           +14.0%       9.52        perf-stat.i.metric.K/sec
      1.05 ±  3%      +9.2%       1.14 ±  3%  perf-stat.overall.MPKI
      4.98            -0.2        4.83        perf-stat.overall.branch-miss-rate%
      1.66            +5.1%       1.75        perf-stat.overall.cpi
      0.60            -4.8%       0.57        perf-stat.overall.ipc
  96867729            -2.8%   94186227        perf-stat.ps.branch-misses
   9895781 ±  2%      +9.2%   10807588 ±  3%  perf-stat.ps.cache-misses
 2.239e+08            +9.4%  2.449e+08        perf-stat.ps.cache-references
    378576           +14.0%     431601        perf-stat.ps.context-switches
 1.571e+10            +5.0%   1.65e+10        perf-stat.ps.cpu-cycles
      2271           +13.5%       2579 ±  2%  perf-stat.ps.cpu-migrations





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--/o6zIcgQ5Xur3JQC
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--/o6zIcgQ5Xur3JQC--

