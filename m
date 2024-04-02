Return-Path: <linux-fsdevel+bounces-15854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E41894DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE51C228BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000852F70;
	Tue,  2 Apr 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8VfwohO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDDA5813B;
	Tue,  2 Apr 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047824; cv=fail; b=Omsgc9xVbuzkg7Ujuz/Aelen2/D22UjA7niW3G1Jut6W5eZX9ddcs0XuPr6XGVXGIYzbYwm2XusrqPeGl662J78NmWErtgT4uzbaYyaeZOnR5i0XFQMlQxB4mtg/qfZc/Xgs9wfHekKWqADL/ztRPIXGzTNqv6hHmuaz6qowOyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047824; c=relaxed/simple;
	bh=eJUHdRqv4mu8lLIA28EaDS1x41ZwubdRIhJEmp3c28k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LL0PjF2yvBwDVAMyA1255BjnuEWAfLQ/1QCPDt0TqLpCE9cRjFgE/0I5u5eK+7jOR9tFk2pGlmWHvL4fRLANW/s+weyP5srxUcU23HqPr+CLN/gT9lU1eEmlm/I2RERayfbmpMp6fgMogHr0bBW1Lta1G+Ds0ZdpYZZQB3C/ciM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8VfwohO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712047820; x=1743583820;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=eJUHdRqv4mu8lLIA28EaDS1x41ZwubdRIhJEmp3c28k=;
  b=Q8VfwohOAt+H7pzG/TdTe+RpdL/ACJOyCN1Oeoq8VJ+OPXPYX9cLeB0o
   4xvSx0eCunXWosGPMs98MDyRpH3Bdj3BshoDUgGCxVt5QPo4ECu9vvG6F
   bzvZsZmWJ2ceXCACBve15QymXpSPV+WQbPzKXxGltVthhQOw+OmhL7Hne
   6KEMk83zKONZ8I2Pf6xoY3gggdPsZMWNubbEPevqSLcJ4Mm+Ani8bA1xd
   Qxv36RwUYC4xAkEI+dse0Gu3YTBlAEcP52SmrUul67iL+i8Gmof/UJVO2
   NSSN8cD1aH9CbXo1sh6AaP0ghjEzs6tIZ02mftbcqMIA1T2gx/CqwzV21
   g==;
X-CSE-ConnectionGUID: b7cuHGpAThC0uepuqC/Qpg==
X-CSE-MsgGUID: LhN0JVqJTHGmhLGejyHKyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17930324"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17930324"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18598264"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 01:50:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 01:50:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 01:50:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 01:50:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 01:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5dMCWWm/6OwI29xtpbI9ImQypbtxAv9W8oP1zeJhu8Jhtl2NwUiqa64gEJAHMHiY74Bz4JdoUk4l8qqPVIkHFiQxeySkNaFpKirrzL37xV/oP+aR9/eda1mf229o5IOwzeNuM/zLRcOfmzm5vCL7PlLdpLNy3Svu2+/YTroKqZ/MoLsblRPfiyku3uMRyu8GoM7BH8flInGB8KsIDvd3wPc3BcW07RhuhN14mjg/cO/eJ1weRNN8QdklzJ7jmfsa6Rqt/Ce2xZ/bgHGft8RT84tjTTEsvRFYQjqX4Xh8+IyF9YJYIqpGpAUM4NToRt1TROo4qwfKZjbQJ76XVd9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcCRzoErcdE1u0FjlGyBXHEfWJ2ij65sU5tx/0HKub8=;
 b=YvOTRLvseY/YPtjsKSwDtgQskdSucHm2Sn0rZUWohLdG/oT0rp0m/ffTluF8hGWPGA1NDASSix9kFqIixpHAzeu8mkIvHUu0jfBcPO3/dQw5PqaEjDIUDZ3/az/bAlbu++Q0M370UJlOCUZ0dV5i8yVH6cK+8i67EObj+L/FmZgwLQn19zqTftRBL+XYSBodRde8t4KtV6DC+f/gOQvHDbltPlgT8KEILnVSaruQvEB65z5STUDCXqJjqCzlBglPu892jwYs4oa0I2evPQ1EzMed9OwTQtjMnA3POWDGTIhwff/YTOcXzzKszpqnOVd1c8u1pKr3plvj5yxRJ2yHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 2 Apr
 2024 08:50:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 08:50:14 +0000
Date: Tue, 2 Apr 2024 16:50:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [dhowells-fs:cifs-netfs] [cifs]  22ac9f5a2e:
 filebench.sum_operations/s -83.5% regression
Message-ID: <202404021622.5b0a96b3-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7980:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q23UsacqdX09TZLqRfS2YKWDq4/zh1VliwJzj/uuuBmPf8ei598TljDT1j2d3JkUog8i+DSVo70AMPmS9GPuxP2Zjcf70kmtNiXtGMyLdioLOItCWr2KCgkYmIXinn5tPXKr9Ep/XmuIGPpEAeDLQ9TqrSWVP7wJSUtwd0lrT4pwot/7F+RrFHHtC2Qt078+XXzmarlSy6j1Z2dmjaShfKDMtdW2rO1EkrYqFjDod9wpsayqYD8HpyQUNARF6LifzZEHWWCCEJMSCBeVaOBbd5ajOwRK3KlxIChnEVHh/feWHpTCT2wfKpySB576LjuN9Ax3YbVoOwi4rA/wwBHglYKXoGZxVS1dVq8h5BPozEqenxuBXwMepCwUQjh0TBM6nd+yzO7Xvqt652WCSsNgnMUXwjysBzIy6IC+6E2ghLCANI8nLfQFRb1c3QC/G9Z9q9vLD3Y0bnRFb86i8jz5JUVK7tWHCRNKvNYeokTpvBFg8YlCfMt3PPuLZrANh06yWq3hXBB6zOytwGD5TbMN2Kp8fwh3hIyXp48NP/wkZ2GbFEQrB6FY5TRpgyeWUkfAU0d32EoVlSLnUjAR8Xp8SnmrufPuTDzFKbkQeBjMp/Xac6KIZrFGrJDFMW/teqOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?puHqx/kk9+/myWwkm1UUEQgb2okm7kJO7tG1fMdvgoor4CSR9f1bAZ8k6s?=
 =?iso-8859-1?Q?FNVuHmiavqWh6D+zaKxC2mz3ukgy+8xXS/c5UeM2P4fMxd4MaKREASkQMI?=
 =?iso-8859-1?Q?QttCPbLIGhPEN+6UNI+ChBD5RnnJ35IFkJAPT2Oi8l5bzaKOwQQdPf5i2R?=
 =?iso-8859-1?Q?IibdqBTuhyLJhG0ZaEovTEN86wWkNoAB6nkkPcqr0fEEJHpcrcjj3jBZYE?=
 =?iso-8859-1?Q?Kp2sZrjsiqsnJPJOYOpLGIxihr0cR+tYUdHb79yBKHwsaB7UYA7JiYUqcy?=
 =?iso-8859-1?Q?ZzTs/GJBwExpFRAxrYeeoqDag4x0DW+e7yFVqJQiHdIfvqJZtCobxzXt8b?=
 =?iso-8859-1?Q?TuPMIZ5xXDCDoNtnND9bASTfHzdTKszJcuaDOyHtMAHEzeCaLgrMmrQmeV?=
 =?iso-8859-1?Q?FQJbM11PC/mqzikNubdVrWAE+/cUNWqJMmODv/fU64tk8FsefFjHpiLz7Q?=
 =?iso-8859-1?Q?OXzdZINiEQOk+C8piMFl44RER8aeLCXDi/nahbJcU+ECfrl50zfmZbRER7?=
 =?iso-8859-1?Q?BU6v9eFxgTqWXvprRSeiK27Lxe7bJKEQdHfBHj7mpgSSM81xzD5oqlOmv+?=
 =?iso-8859-1?Q?VTDYG9v/0FXiq8ymZz19Nn7bqiXQYuGZ/3XeIx+tzF9fnuXJ37qCuIfgrb?=
 =?iso-8859-1?Q?7oY6CZCbC/1arh+wWkTK1Egwmi9/ICAwnoeGjrGguGJthrzDkcdmjk1Wai?=
 =?iso-8859-1?Q?R3D32V74aUl0d7gcirQ01wyZd12aIktPZSfwGHflNgYVz8vKsHuPBVv5NG?=
 =?iso-8859-1?Q?QdcXu3JYbSQwSopQw6grjtAlfVP2UpVbxbo+xPLh2iAcDHgxzYU5cz+++C?=
 =?iso-8859-1?Q?aFutNn78XLDRuAevZu2CRkOEljKiUPvsDlsYsbLJ+WUCZMEcyiMdEOzPwh?=
 =?iso-8859-1?Q?Y4QdHW2o2kERa6B4mY+quZIpKkF64fFTVIZBzrb1q8s/jXpCMaGbYiZDtn?=
 =?iso-8859-1?Q?mUYQQ4EsuMaT4Gm2LEeXFXuP+tQHKmo23XTwM5xf36XkLNyuVBDOEKuyva?=
 =?iso-8859-1?Q?EMG127R00BXSPTCkTuflItsP+2byuo+MS9mhBQrna+oAilq1JCLnzbiMIl?=
 =?iso-8859-1?Q?3Otzvjt7GmfeCnrhnvBuaJzuzGYPOMrqAG355fnDhadE1GHfpLuyENfeYf?=
 =?iso-8859-1?Q?hTf35RJ5oUanxiXLaBBJGRF8gb1I2uvUqMyCtTewY/W4/99aFMZBcREK8y?=
 =?iso-8859-1?Q?VmJOe9gkQA++gAKH0fUAIU7ahcXRW8+RE1LBd4MlgLzeAPUqLJLpH2OUXN?=
 =?iso-8859-1?Q?kEtHWh9YPMYzU3WUoNc/RQ1EzG3b9gEMpox/mIYrym0fWA7gDWkn2XhuQc?=
 =?iso-8859-1?Q?a1mb37l0d00j4L5Gg0S3Ywx5zO4cJ1eWC1N4FrqV8BsUHpGBIaMrXeUZ6b?=
 =?iso-8859-1?Q?uFevFHe4CLg7KOeePE3TfxsOtCNWRaVp8MrjIQAd/R2g5CPpkU6mnkotsa?=
 =?iso-8859-1?Q?0wR6U/CqJncCRfmZvxkS+kK6MFR6TfW5s2tjJuksEowtm+tca/mM8e0hPQ?=
 =?iso-8859-1?Q?V81qdD8Vvr9PEG44EsIheyVMBG/cfAA+7rIRXzcqAPMXySSIBbgo71H60r?=
 =?iso-8859-1?Q?RWDjItsdtukIwuuv4SghUzA8TRmvE6EfD8E6DR9WZTfKpwF15GmPdr43sx?=
 =?iso-8859-1?Q?fzPebN3AcIkngE+lxDDhpkBURgBucj3DLMmRDU0qaTW44Nw6BO7WOJwA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33361f24-b13b-45da-eadb-08dc52f1e951
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 08:50:14.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wpfx09sHkQOkhE1kI2XukKMldrsnYKY6dzSOMdQSNWCdKEuf2AsyzVLgRXvU7igQ1u9fIKqMj1Dun4P8SX6Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -83.5% regression of filebench.sum_operations/s on:


commit: 22ac9f5a2eef790caf9f972ee12c30488377e968 ("cifs: Cut over to using netfslib")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git cifs-netfs

testcase: filebench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: cifs
	test: randomwrite.f
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s -49.4% regression                                            |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs2=cifs                                                                                           |
|                  | fs=btrfs                                                                                           |
|                  | test=filemicro_seqwriterandvargam.f                                                                |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404021622.5b0a96b3-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240402/202404021622.5b0a96b3-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomwrite.f/filebench

commit: 
  d1e875ff9b ("cifs: When caching, try to open O_WRONLY file rdwr on server")
  22ac9f5a2e ("cifs: Cut over to using netfslib")

d1e875ff9bdc18ba 22ac9f5a2eef790caf9f972ee12 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1990716 ±  3%    +539.1%   12722278 ±  2%  cpuidle..usage
      1.34 ±  8%     -27.8%       0.96 ±  2%  iostat.cpu.system
     31.29            -1.0%      30.99        boot-time.boot
      3411            -0.8%       3384        boot-time.idle
    670.00 ±  7%     -33.4%     446.17 ±  8%  perf-c2c.DRAM.local
      2600 ± 19%    +105.4%       5342 ±  4%  perf-c2c.HITM.local
      1212 ± 46%     +60.6%       1946 ±  5%  perf-c2c.HITM.remote
      3812 ± 28%     +91.2%       7289 ±  3%  perf-c2c.HITM.total
     68785            -3.2%      66555        vmstat.io.bo
      0.80 ±  3%     +21.7%       0.98 ±  3%  vmstat.procs.b
     19461 ±  2%    +735.4%     162571 ±  3%  vmstat.system.cs
      8751 ±  5%    +143.5%      21307 ±  2%  vmstat.system.in
      0.61 ±  3%      +0.2        0.80        mpstat.cpu.all.iowait%
      0.02 ±  4%      +0.0        0.03 ±  2%  mpstat.cpu.all.irq%
      0.03 ±  4%      +0.0        0.06 ±  2%  mpstat.cpu.all.soft%
      1.29 ±  8%      -0.4        0.87 ±  3%  mpstat.cpu.all.sys%
      0.15            +0.2        0.31 ±  3%  mpstat.cpu.all.usr%
     36.56 ± 13%     -86.7%       4.87        mpstat.max_utilization_pct
      3052           -83.5%     505.07 ±  2%  filebench.sum_bytes_mb/s
  23448470           -83.5%    3879395 ±  2%  filebench.sum_operations
    390774           -83.5%      64651 ±  2%  filebench.sum_operations/s
      0.00          +658.3%       0.02 ±  2%  filebench.sum_time_ms/op
    390774           -83.5%      64651 ±  2%  filebench.sum_writes/s
  96273016          -100.0%       0.00        filebench.time.file_system_outputs
      1095 ± 13%     -96.4%      39.50 ± 49%  filebench.time.involuntary_context_switches
     37.00           -59.5%      15.00 ±  3%  filebench.time.percent_of_cpu_this_job_got
     59.21           -58.5%      24.54 ±  4%  filebench.time.system_time
     43518 ± 28%   +2043.6%     932871 ±  4%  filebench.time.voluntary_context_switches
     17222 ± 64%     -75.0%       4301 ± 52%  numa-meminfo.node0.Writeback
    105418          +516.0%     649363 ±  9%  numa-meminfo.node1.Active
    102029 ±  2%    +534.2%     647054 ±  9%  numa-meminfo.node1.Active(anon)
    334142 ± 58%     -90.4%      32026 ±180%  numa-meminfo.node1.AnonHugePages
    929786 ± 41%     -64.3%     331584 ± 54%  numa-meminfo.node1.AnonPages
   1763324 ± 61%     -76.4%     415608 ± 44%  numa-meminfo.node1.AnonPages.max
   2064209 ± 34%     -50.7%    1017576 ± 72%  numa-meminfo.node1.Dirty
    942849 ± 42%     -60.5%     372842 ± 49%  numa-meminfo.node1.Inactive(anon)
    115241 ±  8%    +497.5%     688515 ±  8%  numa-meminfo.node1.Shmem
     19635 ± 61%     -82.4%       3449 ± 67%  numa-meminfo.node1.Writeback
      4231 ± 63%     -74.6%       1074 ± 50%  numa-vmstat.node0.nr_writeback
     25483 ±  2%    +534.7%     161734 ±  9%  numa-vmstat.node1.nr_active_anon
    232493 ± 41%     -64.3%      82901 ± 54%  numa-vmstat.node1.nr_anon_pages
    163.27 ± 58%     -90.4%      15.66 ±180%  numa-vmstat.node1.nr_anon_transparent_hugepages
   7572414 ± 79%     -84.8%    1151325 ± 73%  numa-vmstat.node1.nr_dirtied
    516238 ± 34%     -50.8%     254063 ± 72%  numa-vmstat.node1.nr_dirty
    235773 ± 42%     -60.4%      93289 ± 49%  numa-vmstat.node1.nr_inactive_anon
     28801 ±  8%    +497.8%     172173 ±  8%  numa-vmstat.node1.nr_shmem
      4928 ± 57%     -82.8%     846.55 ± 65%  numa-vmstat.node1.nr_writeback
     25483 ±  2%    +534.7%     161734 ±  9%  numa-vmstat.node1.nr_zone_active_anon
    235773 ± 42%     -60.4%      93288 ± 49%  numa-vmstat.node1.nr_zone_inactive_anon
    521167 ± 34%     -51.1%     254913 ± 72%  numa-vmstat.node1.nr_zone_write_pending
    115538 ±  2%    +498.3%     691216        meminfo.Active
    111844          +512.9%     685443        meminfo.Active(anon)
    765912 ± 11%     -80.8%     147382 ± 20%  meminfo.AnonHugePages
   1777592 ±  9%     -62.5%     665718        meminfo.AnonPages
   2163363 ±  7%     -15.5%    1828365        meminfo.Committed_AS
   3951343           -41.3%    2319988        meminfo.Dirty
  12039166            -9.0%   10955753        meminfo.Inactive
   1801603 ±  9%     -60.3%     715347        meminfo.Inactive(anon)
     65874           +39.4%      91849 ±  3%  meminfo.Mapped
      8388 ±  3%     -23.5%       6417        meminfo.PageTables
    139252          +430.4%     738547        meminfo.Shmem
     36887           -79.9%       7418 ±  3%  meminfo.Writeback
  19184898           -10.7%   17141138        meminfo.max_used_kB
     48457 ± 25%     -85.6%       6971 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
    225935 ± 17%     -80.6%      43862 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
      4062 ± 10%     -60.5%       1606 ± 30%  sched_debug.cfs_rq:/.avg_vruntime.min
     24804 ± 13%     -71.2%       7142 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     48457 ± 25%     -85.6%       6971 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
    225935 ± 17%     -80.6%      43862 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
      4062 ± 10%     -60.5%       1606 ± 30%  sched_debug.cfs_rq:/.min_vruntime.min
     24804 ± 13%     -71.2%       7142 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
     15265 ±  3%    +721.7%     125441 ± 13%  sched_debug.cpu.nr_switches.avg
    121188 ± 10%    +597.0%     844734 ± 25%  sched_debug.cpu.nr_switches.max
    921.00 ± 19%   +3123.4%      29687 ± 40%  sched_debug.cpu.nr_switches.min
     16799 ±  3%    +599.8%     117560 ± 13%  sched_debug.cpu.nr_switches.stddev
     49.67 ±  2%     -49.9%      24.89 ± 17%  sched_debug.cpu.nr_uninterruptible.max
     10.39 ±  6%     -46.3%       5.58 ± 15%  sched_debug.cpu.nr_uninterruptible.stddev
      6.62 ±  6%     -61.3%       2.56 ±  3%  perf-stat.i.MPKI
 6.288e+08 ±  4%     +21.6%  7.649e+08 ±  2%  perf-stat.i.branch-instructions
      2.71            +0.9        3.64        perf-stat.i.branch-miss-rate%
  12268581          +111.9%   26002908 ±  3%  perf-stat.i.branch-misses
     13.41 ±  6%      -7.9        5.50 ±  3%  perf-stat.i.cache-miss-rate%
  25751568 ±  6%     -41.8%   14997189 ±  7%  perf-stat.i.cache-misses
 1.045e+08           +44.3%  1.508e+08 ±  4%  perf-stat.i.cache-references
     19656 ±  2%    +742.4%     165581 ±  3%  perf-stat.i.context-switches
      1.78            -3.7%       1.72 ±  2%  perf-stat.i.cpi
 3.058e+09 ±  4%     +21.4%  3.714e+09 ±  2%  perf-stat.i.instructions
      0.08 ± 11%   +1466.5%       1.28 ±  3%  perf-stat.i.metric.K/sec
      5659 ±  5%     -34.1%       3728        perf-stat.i.minor-faults
      5660 ±  5%     -34.1%       3728        perf-stat.i.page-faults
      8.41 ±  2%     -52.0%       4.04 ±  7%  perf-stat.overall.MPKI
      1.95 ±  2%      +1.4        3.40 ±  2%  perf-stat.overall.branch-miss-rate%
     24.63 ±  5%     -14.7        9.93 ±  3%  perf-stat.overall.cache-miss-rate%
      2.12 ±  2%     -22.8%       1.64 ±  2%  perf-stat.overall.cpi
    252.30           +61.5%     407.44 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.47 ±  2%     +29.4%       0.61 ±  2%  perf-stat.overall.ipc
 6.262e+08 ±  4%     +21.7%   7.62e+08 ±  2%  perf-stat.ps.branch-instructions
  12206692          +112.2%   25898104 ±  3%  perf-stat.ps.branch-misses
  25643672 ±  6%     -41.7%   14944490 ±  7%  perf-stat.ps.cache-misses
 1.041e+08           +44.4%  1.503e+08 ±  4%  perf-stat.ps.cache-references
     19574 ±  2%    +743.0%     165023 ±  3%  perf-stat.ps.context-switches
 3.046e+09 ±  4%     +21.5%  3.699e+09 ±  2%  perf-stat.ps.instructions
      5628 ±  5%     -34.3%       3699        perf-stat.ps.minor-faults
      5629 ±  5%     -34.3%       3699        perf-stat.ps.page-faults
 5.206e+11 ±  4%     +17.6%  6.123e+11 ±  2%  perf-stat.total.instructions
     27965          +512.0%     171147        proc-vmstat.nr_active_anon
    444415 ±  9%     -62.6%     166426        proc-vmstat.nr_anon_pages
    374.00 ± 11%     -80.8%      71.75 ± 20%  proc-vmstat.nr_anon_transparent_hugepages
  14887427           -82.0%    2673997        proc-vmstat.nr_dirtied
    987235           -41.1%     581715        proc-vmstat.nr_dirty
   3370424            +4.9%    3535725        proc-vmstat.nr_file_pages
    450433 ±  9%     -60.3%     178904        proc-vmstat.nr_inactive_anon
     22949            +3.7%      23799        proc-vmstat.nr_kernel_stack
     16730           +39.2%      23292 ±  2%  proc-vmstat.nr_mapped
      2097 ±  3%     -23.6%       1602        proc-vmstat.nr_page_table_pages
     34832          +429.7%     184493        proc-vmstat.nr_shmem
     63413            +1.7%      64470        proc-vmstat.nr_slab_reclaimable
     80555            -1.4%      79456        proc-vmstat.nr_slab_unreclaimable
      9211 ±  2%     -79.0%       1938 ±  4%  proc-vmstat.nr_writeback
  14887426           -21.1%   11743505        proc-vmstat.nr_written
     27965          +512.0%     171147        proc-vmstat.nr_zone_active_anon
    450433 ±  9%     -60.3%     178904        proc-vmstat.nr_zone_inactive_anon
    996446           -41.4%     583663        proc-vmstat.nr_zone_write_pending
    162852 ± 10%     -89.2%      17623 ± 23%  proc-vmstat.numa_hint_faults
     96533 ± 31%     -88.2%      11378 ± 34%  proc-vmstat.numa_hint_faults_local
   5076102            -7.6%    4688195        proc-vmstat.numa_local
    118116 ± 12%     -94.8%       6172 ±103%  proc-vmstat.numa_pages_migrated
    676035 ±  5%     -79.5%     138844 ± 26%  proc-vmstat.numa_pte_updates
     31514 ±  2%    +498.0%     188460        proc-vmstat.pgactivate
  16311792           -18.1%   13358695        proc-vmstat.pgalloc_normal
   1078246 ±  5%     -32.5%     727877        proc-vmstat.pgfault
  15566121           -18.3%   12719604 ±  2%  proc-vmstat.pgfree
    118116 ± 12%     -94.8%       6172 ±103%  proc-vmstat.pgmigrate_success
  11896158            -6.0%   11187157        proc-vmstat.pgpgout
     67550 ± 20%     -56.0%      29696 ±  3%  proc-vmstat.pgreuse
     18.92 ± 11%      -7.1       11.79 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     17.56 ± 11%      -6.9       10.62 ± 17%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      9.14 ± 21%      -4.6        4.56 ± 34%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      9.21 ± 21%      -4.5        4.73 ± 32%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      5.18 ± 41%      -3.1        2.08 ± 53%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      5.02 ± 41%      -3.0        2.00 ± 55%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      4.40 ± 46%      -2.7        1.72 ± 62%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu
      4.10 ± 48%      -2.5        1.58 ± 62%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq
      3.79 ±  4%      -1.5        2.25 ± 16%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.72 ±  3%      -1.5        2.23 ± 22%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.97 ±  6%      -1.4        3.55 ±  3%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.00 ±  7%      -1.4        3.58 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.00 ±  7%      -1.4        3.58 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.00 ±  7%      -1.4        3.58 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      5.00 ±  7%      -1.4        3.58 ±  4%  perf-profile.calltrace.cycles-pp.execve
      7.13 ±  9%      -1.4        5.76 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.10 ±  9%      -1.3        5.76 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.98 ± 10%      -1.3        1.64 ± 17%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      2.98 ± 10%      -1.3        1.65 ± 18%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.62            -1.3        1.33 ± 23%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.56 ±  2%      -1.3        1.30 ± 23%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.26 ± 17%      -1.2        1.04 ± 18%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.54 ± 11%      -1.2        1.31 ± 16%  perf-profile.calltrace.cycles-pp.newidle_balance.balance_fair.__schedule.schedule.smpboot_thread_fn
      2.28 ± 16%      -1.2        1.07 ± 16%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.54 ± 11%      -1.2        1.32 ± 16%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      1.43 ±  6%      -1.2        0.26 ±100%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.readn
      2.32 ± 10%      -1.1        1.20 ± 16%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.balance_fair.__schedule.schedule
      2.22 ± 11%      -1.1        1.14 ± 18%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.balance_fair
      2.22 ± 11%      -1.1        1.15 ± 19%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.balance_fair.__schedule
      5.35 ±  8%      -1.0        4.36 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.50 ±  2%      -1.0        1.55 ± 23%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      5.14 ±  6%      -0.9        4.22 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.28            -0.9        2.38 ±  7%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      2.94 ± 17%      -0.9        2.06 ± 13%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.80 ± 16%      -0.9        1.94 ± 12%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.70 ± 10%      -0.8        0.91 ± 56%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      2.18 ±  7%      -0.8        1.40 ± 14%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05 ±  4%      -0.8        0.27 ±100%  perf-profile.calltrace.cycles-pp.read.readn.evsel__read_counter.read_counters.process_interval
      1.05 ±  4%      -0.8        0.28 ±100%  perf-profile.calltrace.cycles-pp.readn.evsel__read_counter.read_counters.process_interval.dispatch_events
      2.18 ±  7%      -0.8        1.41 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.64 ± 12%      -0.8        0.87 ± 58%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ±  2%      -0.8        1.34 ± 28%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      3.20 ± 19%      -0.8        2.43 ±  9%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.20 ± 19%      -0.8        2.44 ± 10%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.33 ± 10%      -0.7        0.59 ± 46%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      3.54 ± 19%      -0.7        2.81 ± 10%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.78 ±  8%      -0.7        1.06 ± 34%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      3.13 ±  9%      -0.7        2.42 ± 14%  perf-profile.calltrace.cycles-pp.read
      2.84            -0.7        2.14 ±  7%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      3.04 ± 12%      -0.7        2.34 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.04 ± 12%      -0.7        2.34 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.87 ±  8%      -0.7        1.18 ± 37%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      1.87 ±  8%      -0.7        1.18 ± 37%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      1.03 ±  6%      -0.7        0.34 ±102%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.03 ±  6%      -0.7        0.34 ±102%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.03 ±  6%      -0.7        0.34 ±102%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.01 ±  4%      -0.7        0.33 ±101%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      2.81            -0.7        2.14 ±  7%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      2.74            -0.6        2.08 ±  8%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      1.54 ± 19%      -0.6        0.89 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      2.82 ± 10%      -0.6        2.18 ± 18%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.22 ±  9%      -0.6        0.58 ± 49%  perf-profile.calltrace.cycles-pp._Fork
      1.38 ± 19%      -0.6        0.74 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.96 ± 19%      -0.6        0.34 ±104%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.96 ± 19%      -0.6        0.34 ±104%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.96 ± 19%      -0.6        0.34 ±104%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      0.96 ± 19%      -0.6        0.34 ±104%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      5.49 ±  9%      -0.6        4.87 ±  9%  perf-profile.calltrace.cycles-pp.ext4_finish_bio.ext4_end_bio.blk_update_request.scsi_end_request.scsi_io_completion
      1.06 ±  9%      -0.6        0.44 ± 74%  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      5.56 ±  9%      -0.6        4.96 ±  9%  perf-profile.calltrace.cycles-pp.ext4_end_bio.blk_update_request.scsi_end_request.scsi_io_completion.blk_complete_reqs
      0.92 ± 14%      -0.6        0.33 ±100%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu
      1.34 ± 17%      -0.6        0.78 ± 15%  perf-profile.calltrace.cycles-pp.__vfork
      2.64 ±  4%      -0.5        2.10 ± 14%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.82 ±  4%      -0.5        0.30 ±100%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.82 ± 21%      -0.5        0.33 ±100%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      1.15 ± 16%      -0.5        0.68 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.15 ± 16%      -0.5        0.68 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__vfork
      1.84 ±  6%      -0.5        1.38 ± 15%  perf-profile.calltrace.cycles-pp.setlocale
      1.12 ± 14%      -0.5        0.67 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.10 ± 16%      -0.4        0.67 ± 15%  perf-profile.calltrace.cycles-pp.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.92 ±  4%      -0.4        0.49 ± 72%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.82 ± 17%      -0.4        0.44 ± 71%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.80 ± 15%      -0.4        0.42 ± 72%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.66 ± 16%      -0.4        0.28 ±100%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ±  2%      -0.4        0.61 ± 49%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.59 ± 13%      +0.7        1.25 ± 25%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.31 ±100%      +0.7        1.02 ± 24%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.26 ±100%      +0.8        1.05 ± 13%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.26 ±100%      +0.8        1.06 ± 13%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.59 ± 13%      +0.8        1.38 ± 14%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.61 ±  9%      +0.8        1.41 ± 13%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.82 ± 10%      +0.8        1.63 ± 20%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.28 ±100%      +0.8        1.10 ± 13%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.00            +0.8        0.82 ± 12%  perf-profile.calltrace.cycles-pp.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.00            +0.9        0.86 ± 13%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn
      0.31 ±100%      +0.9        1.17 ± 13%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.worker_thread
      0.31 ±100%      +0.9        1.17 ± 13%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.worker_thread.kthread
      0.00            +1.0        1.04 ± 38%  perf-profile.calltrace.cycles-pp.ata_qc_complete_multiple.ahci_qc_complete.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu
      4.55 ±  8%      +1.1        5.64 ±  4%  perf-profile.calltrace.cycles-pp.ext4_bio_write_folio.mpage_submit_folio.mpage_process_page_bufs.mpage_prepare_extent_to_map.ext4_do_writepages
      0.00            +1.3        1.26 ± 12%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work
      0.00            +1.3        1.26 ± 12%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread
      0.00            +1.3        1.26 ± 12%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread.kthread
      0.00            +1.3        1.26 ± 12%  perf-profile.calltrace.cycles-pp.blk_mq_run_work_fn.process_one_work.worker_thread.kthread.ret_from_fork
      5.56 ±  4%      +1.5        7.08 ±  5%  perf-profile.calltrace.cycles-pp.mpage_submit_folio.mpage_process_page_bufs.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages
     14.52 ±  4%      +1.5       16.07 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     14.52 ±  4%      +1.5       16.07 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +1.6        1.55 ± 20%  perf-profile.calltrace.cycles-pp.ahci_qc_complete.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event
     14.50 ±  5%      +1.6       16.06 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      2.10 ±  2%      +1.6        3.74 ± 15%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      9.68 ±  4%      +1.7       11.34 ±  5%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.8        1.76 ±  9%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct_nocheck.ext4_bio_write_folio.mpage_submit_folio.mpage_process_page_bufs
      0.00            +1.8        1.83 ±  8%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.ext4_bio_write_folio.mpage_submit_folio.mpage_process_page_bufs.mpage_prepare_extent_to_map
     10.28 ±  4%      +2.6       12.84 ±  5%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +2.6        2.59 ±  7%  perf-profile.calltrace.cycles-pp.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.00            +3.3        3.31 ±  6%  perf-profile.calltrace.cycles-pp.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt
      0.00            +3.4        3.38 ±  5%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
      0.00            +3.6        3.56 ±  7%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      0.00            +3.8        3.83 ±  8%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.00            +3.9        3.91 ±  7%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
     15.17            +4.1       19.24 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     45.38            +5.5       50.87 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     50.90            +7.8       58.66 ±  4%  perf-profile.calltrace.cycles-pp.common_startup_64
     48.80            +8.6       57.44 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     48.80            +8.7       57.45 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     48.70            +8.7       57.40 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     25.16 ±  3%      -7.2       17.94 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     25.12 ±  3%      -7.2       17.91 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
     19.06 ± 10%      -7.1       11.93 ± 14%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     18.22 ± 10%      -7.0       11.19 ± 15%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     15.56 ±  7%      -4.7       10.86 ± 42%  perf-profile.children.cycles-pp.irq_exit_rcu
      5.38 ± 41%      -3.3        2.07 ± 47%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.18 ± 41%      -3.1        2.11 ± 52%  perf-profile.children.cycles-pp.tmigr_handle_remote
      5.02 ± 41%      -3.0        2.03 ± 54%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      4.82 ± 44%      -2.9        1.93 ± 57%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     15.59 ±  8%      -2.5       13.06 ± 14%  perf-profile.children.cycles-pp.__do_softirq
      4.98 ±  3%      -1.8        3.17 ± 15%  perf-profile.children.cycles-pp.cmd_stat
      4.96 ±  2%      -1.8        3.15 ± 15%  perf-profile.children.cycles-pp.process_interval
      4.84 ±  2%      -1.8        3.04 ± 15%  perf-profile.children.cycles-pp.read_counters
      4.96 ±  2%      -1.8        3.17 ± 15%  perf-profile.children.cycles-pp.dispatch_events
      3.80            -1.7        2.12 ± 11%  perf-profile.children.cycles-pp.__x64_sys_openat
      3.77 ±  2%      -1.7        2.12 ± 12%  perf-profile.children.cycles-pp.do_sys_openat2
      3.49 ±  2%      -1.6        1.85 ± 15%  perf-profile.children.cycles-pp.do_filp_open
      3.40 ±  3%      -1.6        1.81 ± 14%  perf-profile.children.cycles-pp.path_openat
      4.86 ±  5%      -1.6        3.31 ± 11%  perf-profile.children.cycles-pp.read
      4.50 ± 15%      -1.5        2.99 ± 10%  perf-profile.children.cycles-pp.__handle_mm_fault
      3.72 ±  3%      -1.5        2.23 ± 22%  perf-profile.children.cycles-pp.smpboot_thread_fn
      4.67 ± 16%      -1.5        3.19 ±  9%  perf-profile.children.cycles-pp.handle_mm_fault
      4.40 ± 10%      -1.4        2.96 ± 15%  perf-profile.children.cycles-pp.ksys_read
      4.92 ± 20%      -1.4        3.50 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
      4.92 ± 20%      -1.4        3.51 ±  7%  perf-profile.children.cycles-pp.exc_page_fault
      4.99 ±  6%      -1.4        3.59 ±  4%  perf-profile.children.cycles-pp.do_execveat_common
      5.00 ±  7%      -1.4        3.59 ±  4%  perf-profile.children.cycles-pp.execve
      5.02 ±  6%      -1.4        3.62 ±  4%  perf-profile.children.cycles-pp.__x64_sys_execve
      3.93 ±  2%      -1.4        2.56 ± 28%  perf-profile.children.cycles-pp.sched_setaffinity
      4.18 ± 11%      -1.3        2.88 ± 14%  perf-profile.children.cycles-pp.vfs_read
      5.36 ± 19%      -1.3        4.11 ±  8%  perf-profile.children.cycles-pp.asm_exc_page_fault
      4.80 ±  6%      -1.2        3.56 ± 10%  perf-profile.children.cycles-pp.load_balance
      2.56 ± 12%      -1.2        1.32 ± 16%  perf-profile.children.cycles-pp.balance_fair
      5.84 ±  7%      -1.2        4.66 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.62 ±  6%      -1.1        4.54 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      4.10 ± 10%      -1.1        3.03 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      2.60            -1.0        1.59 ± 22%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      3.99 ± 11%      -1.0        3.01 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      5.95 ±  2%      -1.0        4.97 ± 11%  perf-profile.children.cycles-pp.__schedule
      3.40            -1.0        2.42 ±  8%  perf-profile.children.cycles-pp.bprm_execve
      2.10 ±  2%      -0.9        1.21 ± 25%  perf-profile.children.cycles-pp.rebalance_domains
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.children.cycles-pp.rest_init
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.children.cycles-pp.start_kernel
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.children.cycles-pp.x86_64_start_kernel
      2.10 ± 13%      -0.9        1.22 ±  9%  perf-profile.children.cycles-pp.x86_64_start_reservations
      2.84 ± 12%      -0.9        1.99 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      2.09 ± 16%      -0.9        1.24 ± 10%  perf-profile.children.cycles-pp.kernel_clone
      3.52 ±  8%      -0.8        2.72 ±  8%  perf-profile.children.cycles-pp.update_sg_lb_stats
      2.43 ± 17%      -0.8        1.67 ± 16%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.69 ±  4%      -0.8        0.93 ± 15%  perf-profile.children.cycles-pp.readn
      2.38 ± 19%      -0.8        1.62 ± 16%  perf-profile.children.cycles-pp.tick_irq_enter
      2.02 ±  6%      -0.8        1.26 ± 16%  perf-profile.children.cycles-pp.link_path_walk
      1.62 ± 12%      -0.7        0.87 ± 13%  perf-profile.children.cycles-pp.walk_component
      2.86            -0.7        2.15 ±  7%  perf-profile.children.cycles-pp.exec_binprm
      1.26 ± 27%      -0.7        0.55 ± 32%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      3.00 ±  2%      -0.7        2.31 ± 14%  perf-profile.children.cycles-pp.update_process_times
      2.81            -0.7        2.14 ±  7%  perf-profile.children.cycles-pp.search_binary_handler
      1.36 ±  8%      -0.7        0.70 ± 23%  perf-profile.children.cycles-pp.__open64_nocancel
      2.74            -0.6        2.08 ±  8%  perf-profile.children.cycles-pp.load_elf_binary
      2.04 ±  9%      -0.6        1.40 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.33 ± 10%      -0.6        0.72 ± 16%  perf-profile.children.cycles-pp.evsel__read_counter
      1.80 ±  7%      -0.6        1.19 ± 25%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      3.33 ± 10%      -0.6        2.74 ± 10%  perf-profile.children.cycles-pp.newidle_balance
      5.56 ±  9%      -0.6        4.97 ±  9%  perf-profile.children.cycles-pp.ext4_finish_bio
      1.24 ±  7%      -0.6        0.67 ± 25%  perf-profile.children.cycles-pp._Fork
      1.48 ± 16%      -0.6        0.91 ± 16%  perf-profile.children.cycles-pp.copy_process
      1.34 ± 17%      -0.6        0.78 ± 15%  perf-profile.children.cycles-pp.__vfork
      1.64 ± 12%      -0.6        1.08 ± 32%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.91 ± 26%      -0.5        0.37 ± 51%  perf-profile.children.cycles-pp.wp_page_copy
      0.98 ± 11%      -0.5        0.45 ± 22%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.21 ± 28%      -0.5        0.68 ± 30%  perf-profile.children.cycles-pp.next_uptodate_folio
      5.56 ±  9%      -0.5        5.03 ±  9%  perf-profile.children.cycles-pp.ext4_end_bio
      1.64 ±  4%      -0.5        1.15 ± 26%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      1.14 ±  3%      -0.5        0.66 ± 20%  perf-profile.children.cycles-pp.__lookup_slow
      1.84 ±  6%      -0.5        1.38 ± 15%  perf-profile.children.cycles-pp.setlocale
      1.12 ± 14%      -0.5        0.67 ± 15%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.88 ±  8%      -0.5        0.43 ± 37%  perf-profile.children.cycles-pp.affine_move_task
      0.80 ±  8%      -0.4        0.35 ± 24%  perf-profile.children.cycles-pp.find_idlest_cpu
      1.84 ± 17%      -0.4        1.40 ± 24%  perf-profile.children.cycles-pp.seq_read_iter
      0.72            -0.4        0.30 ± 24%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.77 ±  5%      -0.4        0.34 ± 21%  perf-profile.children.cycles-pp.find_idlest_group
      0.96 ± 19%      -0.4        0.56 ± 30%  perf-profile.children.cycles-pp.__do_sys_clone
      1.10 ±  8%      -0.4        0.69 ± 28%  perf-profile.children.cycles-pp.rcu_core
      1.12 ± 14%      -0.4        0.73 ± 37%  perf-profile.children.cycles-pp.write
      0.61 ± 32%      -0.4        0.23 ± 37%  perf-profile.children.cycles-pp.lookup_fast
      0.84 ±  7%      -0.4        0.47 ± 29%  perf-profile.children.cycles-pp.__cond_resched
      0.68 ±  5%      -0.4        0.30 ± 34%  perf-profile.children.cycles-pp.__wait_for_common
      1.26 ±  5%      -0.4        0.89 ± 16%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.58 ±  9%      -0.4        0.23 ± 29%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
      0.68 ± 22%      -0.3        0.34 ± 30%  perf-profile.children.cycles-pp.__mmdrop
      1.22 ±  9%      -0.3        0.87 ± 25%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.58 ± 25%      -0.3        0.24 ± 32%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      1.20 ±  3%      -0.3        0.86 ± 18%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.84 ± 20%      -0.3        0.52 ± 20%  perf-profile.children.cycles-pp.enqueue_entity
      0.58 ±  5%      -0.3        0.27 ± 26%  perf-profile.children.cycles-pp.alloc_empty_file
      0.54 ± 14%      -0.3        0.23 ± 50%  perf-profile.children.cycles-pp.wake_up_new_task
      0.82            -0.3        0.52 ± 25%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.86            -0.3        0.57 ± 22%  perf-profile.children.cycles-pp.__split_vma
      0.74 ± 16%      -0.3        0.45 ± 11%  perf-profile.children.cycles-pp.finish_task_switch
      0.40 ± 30%      -0.3        0.12 ± 45%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.96 ± 15%      -0.3        0.68 ± 18%  perf-profile.children.cycles-pp.activate_task
      0.86 ± 22%      -0.3        0.58 ± 16%  perf-profile.children.cycles-pp.perf_read
      0.35 ±  8%      -0.3        0.07 ±107%  perf-profile.children.cycles-pp.open64
      0.63 ± 15%      -0.3        0.36 ± 50%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.76 ± 27%      -0.3        0.48 ± 25%  perf-profile.children.cycles-pp.rcu_do_batch
      0.38 ± 63%      -0.3        0.11 ± 99%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.46 ± 29%      -0.3        0.20 ± 69%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.49 ± 12%      -0.3        0.23 ± 25%  perf-profile.children.cycles-pp.rcu_pending
      0.94 ±  6%      -0.3        0.68 ± 25%  perf-profile.children.cycles-pp.update_blocked_averages
      0.47 ± 12%      -0.2        0.22 ± 43%  perf-profile.children.cycles-pp.mod_objcg_state
      0.44 ±  7%      -0.2        0.20 ± 61%  perf-profile.children.cycles-pp.do_open
      0.40 ± 16%      -0.2        0.15 ± 60%  perf-profile.children.cycles-pp.irqentry_enter
      0.46 ± 18%      -0.2        0.23 ± 56%  perf-profile.children.cycles-pp.perf_event_read
      0.71 ± 28%      -0.2        0.48 ± 37%  perf-profile.children.cycles-pp.do_anonymous_page
      0.30 ± 40%      -0.2        0.09 ± 76%  perf-profile.children.cycles-pp.__close
      0.33 ± 15%      -0.2        0.11 ± 77%  perf-profile.children.cycles-pp.__x64_sys_close
      0.64 ± 27%      -0.2        0.42 ± 11%  perf-profile.children.cycles-pp.filename_lookup
      0.44 ± 25%      -0.2        0.22 ± 53%  perf-profile.children.cycles-pp.smp_call_function_single
      0.49 ± 16%      -0.2        0.27 ± 31%  perf-profile.children.cycles-pp.dup_mm
      0.72 ±  7%      -0.2        0.51 ± 22%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.68            -0.2        0.47 ± 19%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.32            -0.2        0.12 ± 70%  perf-profile.children.cycles-pp.__fput
      0.40 ± 39%      -0.2        0.19 ± 46%  perf-profile.children.cycles-pp.__perf_event_read
      0.47 ± 12%      -0.2        0.28 ± 32%  perf-profile.children.cycles-pp.dput
      0.36 ± 35%      -0.2        0.16 ± 26%  perf-profile.children.cycles-pp.call_timer_fn
      0.35 ±  8%      -0.2        0.16 ± 28%  perf-profile.children.cycles-pp.fstatat64
      0.38 ± 26%      -0.2        0.19 ± 27%  perf-profile.children.cycles-pp.__run_timers
      0.24 ±  2%      -0.2        0.05 ±116%  perf-profile.children.cycles-pp.__get_free_pages
      0.47 ±  2%      -0.2        0.29 ± 18%  perf-profile.children.cycles-pp.get_arg_page
      0.44 ± 28%      -0.2        0.26 ± 52%  perf-profile.children.cycles-pp.vma_complete
      0.49 ± 12%      -0.2        0.31 ± 37%  perf-profile.children.cycles-pp.move_queued_task
      0.21 ± 14%      -0.2        0.03 ±108%  perf-profile.children.cycles-pp.affinity__set
      0.26 ± 11%      -0.2        0.08 ± 61%  perf-profile.children.cycles-pp.up_write
      0.35 ± 17%      -0.2        0.18 ± 47%  perf-profile.children.cycles-pp.rw_verify_area
      0.38 ± 14%      -0.2        0.20 ± 39%  perf-profile.children.cycles-pp.sched_exec
      0.54 ± 14%      -0.2        0.38 ± 30%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.26 ± 25%      -0.2        0.09 ± 49%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.40 ±  7%      -0.2        0.24 ± 30%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.30 ±  8%      -0.2        0.15 ± 53%  perf-profile.children.cycles-pp.do_dentry_open
      0.56 ±  9%      -0.2        0.42 ± 22%  perf-profile.children.cycles-pp.vfs_fstatat
      0.40 ± 19%      -0.1        0.25 ± 38%  perf-profile.children.cycles-pp.select_task_rq
      0.47 ± 21%      -0.1        0.32 ± 27%  perf-profile.children.cycles-pp.__alloc_pages
      0.26 ± 11%      -0.1        0.12 ± 39%  perf-profile.children.cycles-pp.__d_add
      0.30 ± 24%      -0.1        0.16 ± 48%  perf-profile.children.cycles-pp.__memcpy
      0.30 ± 36%      -0.1        0.16 ± 42%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.30 ± 21%      -0.1        0.16 ± 61%  perf-profile.children.cycles-pp.schedule_tail
      0.24 ± 19%      -0.1        0.09 ± 74%  perf-profile.children.cycles-pp.format_decode
      0.22 ± 34%      -0.1        0.08 ± 99%  perf-profile.children.cycles-pp.__x64_sys_readlink
      0.23 ± 39%      -0.1        0.09 ± 91%  perf-profile.children.cycles-pp.all_vm_events
      0.22 ± 34%      -0.1        0.08 ± 99%  perf-profile.children.cycles-pp.do_readlinkat
      0.30 ± 21%      -0.1        0.16 ± 47%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.30 ± 21%      -0.1        0.16 ± 31%  perf-profile.children.cycles-pp.shift_arg_pages
      0.24 ±  2%      -0.1        0.10 ± 51%  perf-profile.children.cycles-pp.security_file_alloc
      0.24 ± 23%      -0.1        0.10 ± 86%  perf-profile.children.cycles-pp.user_path_at_empty
      0.21 ± 14%      -0.1        0.07 ± 78%  perf-profile.children.cycles-pp.aa_file_perm
      0.28            -0.1        0.15 ± 38%  perf-profile.children.cycles-pp.record__pushfn
      0.30 ± 36%      -0.1        0.16 ± 60%  perf-profile.children.cycles-pp.wake_up_q
      0.28            -0.1        0.15 ± 34%  perf-profile.children.cycles-pp.init_file
      0.38 ± 14%      -0.1        0.24 ± 30%  perf-profile.children.cycles-pp.__get_user_pages
      0.26 ±  7%      -0.1        0.13 ± 42%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.33 ± 12%      -0.1        0.20 ± 38%  perf-profile.children.cycles-pp.copy_string_kernel
      0.42 ±  9%      -0.1        0.29 ± 41%  perf-profile.children.cycles-pp.___perf_sw_event
      0.30 ±  8%      -0.1        0.17 ± 44%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.47 ±  8%      -0.1        0.34 ± 14%  perf-profile.children.cycles-pp.getname_flags
      0.28 ± 14%      -0.1        0.15 ± 35%  perf-profile.children.cycles-pp.check_cpu_stall
      0.28 ± 14%      -0.1        0.15 ± 36%  perf-profile.children.cycles-pp.security_file_permission
      0.28            -0.1        0.16 ± 37%  perf-profile.children.cycles-pp.writen
      0.30 ± 36%      -0.1        0.17 ± 63%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.18 ± 24%      -0.1        0.06 ± 76%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.44 ±  3%      -0.1        0.32 ± 19%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.16 ± 12%      -0.1        0.04 ±121%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.30 ±  4%      -0.1        0.18 ± 29%  perf-profile.children.cycles-pp.perf_mmap__push
      0.30 ±  4%      -0.1        0.18 ± 29%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.35 ±  5%      -0.1        0.23 ± 23%  perf-profile.children.cycles-pp.strncpy_from_user
      0.14            -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__p4d_alloc
      0.33 ± 12%      -0.1        0.22 ± 28%  perf-profile.children.cycles-pp.get_jiffies_update
      0.42 ± 12%      -0.1        0.31 ± 29%  perf-profile.children.cycles-pp.__cmd_record
      0.16 ± 12%      -0.1        0.05 ±111%  perf-profile.children.cycles-pp.__dequeue_entity
      0.42 ± 12%      -0.1        0.31 ± 29%  perf-profile.children.cycles-pp.cmd_record
      0.16 ± 12%      -0.1        0.05 ±111%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.40 ±  7%      -0.1        0.29 ± 21%  perf-profile.children.cycles-pp.tmigr_update_events
      0.40 ±  3%      -0.1        0.29 ± 36%  perf-profile.children.cycles-pp.dup_task_struct
      0.26 ±  7%      -0.1        0.16 ± 41%  perf-profile.children.cycles-pp.__switch_to_asm
      0.28 ± 17%      -0.1        0.18 ± 40%  perf-profile.children.cycles-pp.devkmsg_read
      0.14 ± 28%      -0.1        0.04 ±130%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.21 ± 33%      -0.1        0.11 ± 83%  perf-profile.children.cycles-pp.note_gp_changes
      0.16 ± 39%      -0.1        0.07 ± 60%  perf-profile.children.cycles-pp.unlink_file_vma
      0.21 ±  9%      -0.1        0.12 ± 56%  perf-profile.children.cycles-pp.irq_work_tick
      0.28 ± 14%      -0.1        0.19 ± 39%  perf-profile.children.cycles-pp.open_last_lookups
      0.40 ± 16%      -0.1        0.30 ± 26%  perf-profile.children.cycles-pp.show_stat
      0.16 ± 15%      -0.1        0.08 ± 88%  perf-profile.children.cycles-pp.mutex_unlock
      0.21 ±  9%      -0.1        0.12 ± 37%  perf-profile.children.cycles-pp.simple_lookup
      0.12 ± 16%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.security_inode_getattr
      0.16 ± 15%      -0.1        0.08 ± 81%  perf-profile.children.cycles-pp.vm_area_dup
      0.21 ±  9%      -0.1        0.12 ± 43%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14            -0.1        0.06 ± 76%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.26 ± 29%      -0.1        0.17 ± 46%  perf-profile.children.cycles-pp.get_unmapped_area
      0.12 ± 21%      -0.1        0.03 ±108%  perf-profile.children.cycles-pp.num_to_str
      0.12 ± 21%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.scnprintf
      0.16 ± 12%      -0.1        0.08 ± 59%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.12 ± 21%      -0.1        0.04 ±107%  perf-profile.children.cycles-pp.lockref_put_return
      0.19 ± 26%      -0.1        0.12 ± 38%  perf-profile.children.cycles-pp.try_charge_memcg
      0.16 ± 12%      -0.1        0.10 ± 27%  perf-profile.children.cycles-pp.task_work_run
      0.14            -0.1        0.09 ± 46%  perf-profile.children.cycles-pp.update_cfs_group
      0.02 ±100%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.__blk_bios_map_sg
      0.00            +0.1        0.11 ± 38%  perf-profile.children.cycles-pp.__blk_mq_alloc_driver_tag
      0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.ata_scsi_qc_complete
      0.05            +0.1        0.17 ± 28%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.12 ± 53%  perf-profile.children.cycles-pp.dma_unmap_sg_attrs
      0.02 ±100%      +0.1        0.15 ± 35%  perf-profile.children.cycles-pp.__blk_rq_map_sg
      0.10 ±  5%      +0.1        0.22 ± 30%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.05            +0.1        0.20 ± 22%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.2        0.16 ± 48%  perf-profile.children.cycles-pp.blk_account_io_done
      0.00            +0.2        0.16 ± 31%  perf-profile.children.cycles-pp.poll_idle
      0.00            +0.2        0.16 ± 52%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      0.00            +0.2        0.17 ± 33%  perf-profile.children.cycles-pp.ata_qc_issue
      0.02 ±100%      +0.2        0.20 ± 35%  perf-profile.children.cycles-pp.dd_insert_requests
      0.16 ± 39%      +0.2        0.35 ± 14%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.02 ±100%      +0.2        0.21 ± 31%  perf-profile.children.cycles-pp.mempool_alloc
      0.00            +0.2        0.25 ± 31%  perf-profile.children.cycles-pp.wbt_done
      0.02 ±100%      +0.3        0.28 ± 21%  perf-profile.children.cycles-pp.scsi_finish_command
      0.00            +0.3        0.26 ± 26%  perf-profile.children.cycles-pp.__ata_scsi_queuecmd
      0.00            +0.3        0.27 ± 30%  perf-profile.children.cycles-pp.__rq_qos_done
      0.08 ± 33%      +0.3        0.36 ± 33%  perf-profile.children.cycles-pp.scsi_complete
      0.02 ±100%      +0.3        0.31 ± 39%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.02 ±100%      +0.3        0.32 ± 33%  perf-profile.children.cycles-pp.bio_free
      0.05            +0.3        0.35 ± 46%  perf-profile.children.cycles-pp.__ata_qc_complete
      0.00            +0.3        0.30 ± 23%  perf-profile.children.cycles-pp.blk_mq_free_request
      0.30 ± 24%      +0.3        0.62 ± 36%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.28            +0.3        0.61 ± 33%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.3        0.32 ± 31%  perf-profile.children.cycles-pp.ata_scsi_queuecmd
      0.09 ±100%      +0.3        0.42 ± 21%  perf-profile.children.cycles-pp.mod_zone_page_state
      0.02 ±100%      +0.3        0.36 ± 31%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.10 ± 47%      +0.3        0.44 ± 18%  perf-profile.children.cycles-pp.blk_add_rq_to_plug
      0.08 ± 33%      +0.4        0.43 ± 12%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.26 ± 45%      +0.4        0.61 ± 17%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.4        0.37 ± 19%  perf-profile.children.cycles-pp.scsi_dispatch_cmd
      0.00            +0.4        0.40 ± 32%  perf-profile.children.cycles-pp.scsi_prepare_cmd
      0.02 ±100%      +0.4        0.44 ± 62%  perf-profile.children.cycles-pp.__blk_mq_end_request
      0.02 ±100%      +0.4        0.48 ± 63%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
      0.02 ±100%      +0.5        0.49 ± 30%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.02 ±100%      +0.5        0.50 ± 57%  perf-profile.children.cycles-pp.blk_mq_complete_request
      0.05            +0.5        0.54 ± 30%  perf-profile.children.cycles-pp.ahci_scr_read
      0.05            +0.5        0.54 ± 28%  perf-profile.children.cycles-pp.sata_async_notification
      0.05            +0.5        0.55 ± 29%  perf-profile.children.cycles-pp.ahci_handle_port_interrupt
      0.64 ±  5%      +0.5        1.16 ± 14%  perf-profile.children.cycles-pp.ktime_get
      1.22 ±  5%      +0.6        1.82 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.47 ±  2%      +0.7        1.12 ± 31%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.64 ±  5%      +0.7        1.29 ± 26%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.02 ±100%      +0.7        0.73 ± 24%  perf-profile.children.cycles-pp.io_schedule
      0.77            +0.7        1.49 ± 49%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.77            +0.7        1.52 ± 48%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.05            +0.8        0.82 ± 23%  perf-profile.children.cycles-pp.rq_qos_wait
      0.12 ± 58%      +0.8        0.90 ± 18%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.12 ± 58%      +0.8        0.91 ± 19%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.05            +0.8        0.84 ± 24%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.05            +0.8        0.84 ± 24%  perf-profile.children.cycles-pp.wbt_wait
      0.87 ±  4%      +0.8        1.69 ± 22%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.12 ± 16%      +0.9        1.05 ± 37%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
      0.22 ± 34%      +1.0        1.17 ±  9%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.08 ± 33%      +1.1        1.14 ±  9%  perf-profile.children.cycles-pp.scsi_queue_rq
      4.57 ±  7%      +1.1        5.68 ±  4%  perf-profile.children.cycles-pp.ext4_bio_write_folio
      0.14 ± 35%      +1.1        1.26 ± 12%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
     14.88 ±  4%      +1.4       16.23 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     14.83 ±  4%      +1.4       16.23 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.22 ± 34%      +1.4        1.63 ±  8%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.22 ± 34%      +1.4        1.63 ±  8%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.14            +1.4        1.59 ± 17%  perf-profile.children.cycles-pp.ahci_qc_complete
      5.58 ±  5%      +1.5        7.10 ±  5%  perf-profile.children.cycles-pp.mpage_submit_folio
      0.08 ± 33%      +1.5        1.61 ±  9%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
     14.50 ±  5%      +1.6       16.06 ±  2%  perf-profile.children.cycles-pp.kthread
      2.22 ±  5%      +1.6        3.79 ± 15%  perf-profile.children.cycles-pp.menu_select
      0.22 ± 34%      +1.7        1.88 ± 10%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      9.68 ±  4%      +1.7       11.34 ±  5%  perf-profile.children.cycles-pp.process_one_work
      0.22 ± 34%      +1.7        1.94 ± 10%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      5.98 ± 11%      +1.9        7.92 ± 10%  perf-profile.children.cycles-pp.blk_complete_reqs
      0.26 ±  7%      +2.5        2.74 ±  5%  perf-profile.children.cycles-pp.ahci_handle_port_intr
     10.28 ±  4%      +2.6       12.84 ±  5%  perf-profile.children.cycles-pp.worker_thread
      0.30 ± 21%      +3.2        3.50 ±  5%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      0.30 ± 21%      +3.3        3.57 ±  5%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.30 ± 21%      +3.5        3.77 ±  6%  perf-profile.children.cycles-pp.handle_irq_event
      0.30 ± 21%      +3.7        4.03 ±  7%  perf-profile.children.cycles-pp.handle_edge_irq
      0.30 ± 21%      +3.8        4.12 ±  6%  perf-profile.children.cycles-pp.__common_interrupt
     15.38 ±  2%      +4.3       19.66 ±  6%  perf-profile.children.cycles-pp.intel_idle
     46.92 ±  2%      +4.9       51.80 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
     50.90            +7.8       58.66 ±  4%  perf-profile.children.cycles-pp.common_startup_64
     50.90            +7.8       58.66 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     50.87            +7.8       58.66 ±  4%  perf-profile.children.cycles-pp.do_idle
     48.80            +8.7       57.45 ±  4%  perf-profile.children.cycles-pp.start_secondary
      5.38 ± 41%      -3.3        2.07 ± 47%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.66 ±  2%      -0.9        0.75 ± 35%  perf-profile.self.cycles-pp.mpage_process_page_bufs
      2.44 ± 13%      -0.6        1.82 ± 11%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.38 ±  6%      -0.6        0.79 ± 18%  perf-profile.self.cycles-pp.ext4_bio_write_folio
      1.92 ± 14%      -0.6        1.34 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.55            -0.5        1.05 ± 24%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.66 ±  5%      -0.5        0.20 ± 32%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      1.05 ± 22%      -0.4        0.61 ± 28%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.44 ± 34%      -0.3        0.16 ± 66%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.53 ± 37%      -0.3        0.24 ± 32%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.38 ± 63%      -0.3        0.11 ± 99%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.36 ± 35%      -0.2        0.11 ± 48%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.30 ± 53%      -0.2        0.07 ± 95%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.51 ± 25%      -0.2        0.28 ± 45%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.68 ± 19%      -0.2        0.47 ± 22%  perf-profile.self.cycles-pp.ext4_finish_bio
      0.35 ±  8%      -0.2        0.14 ± 62%  perf-profile.self.cycles-pp.mod_objcg_state
      0.33 ± 12%      -0.2        0.12 ± 94%  perf-profile.self.cycles-pp.read_counters
      1.73 ±  8%      -0.2        1.53 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock
      0.42 ± 21%      -0.2        0.24 ± 32%  perf-profile.self.cycles-pp.update_load_avg
      0.26 ± 11%      -0.2        0.08 ± 68%  perf-profile.self.cycles-pp.up_write
      0.26 ± 25%      -0.2        0.09 ± 49%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.42 ± 21%      -0.2        0.26 ± 49%  perf-profile.self.cycles-pp.load_balance
      0.28 ± 32%      -0.2        0.12 ± 62%  perf-profile.self.cycles-pp.update_process_times
      0.24 ± 19%      -0.2        0.08 ± 70%  perf-profile.self.cycles-pp.format_decode
      0.23 ± 39%      -0.1        0.08 ± 91%  perf-profile.self.cycles-pp.all_vm_events
      0.21 ±  9%      -0.1        0.06 ±120%  perf-profile.self.cycles-pp.scheduler_tick
      0.24 ± 57%      -0.1        0.09 ± 85%  perf-profile.self.cycles-pp.tick_do_update_jiffies64
      0.26 ± 25%      -0.1        0.11 ± 82%  perf-profile.self.cycles-pp.timerqueue_add
      0.21 ±  9%      -0.1        0.07 ± 60%  perf-profile.self.cycles-pp.rcu_pending
      0.64 ± 13%      -0.1        0.50 ± 18%  perf-profile.self.cycles-pp.intel_idle_irq
      0.21 ± 33%      -0.1        0.07 ± 83%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.19 ± 47%      -0.1        0.06 ±125%  perf-profile.self.cycles-pp.timerqueue_del
      0.28 ± 14%      -0.1        0.15 ± 35%  perf-profile.self.cycles-pp.check_cpu_stall
      0.44 ±  3%      -0.1        0.32 ± 21%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.18 ±  2%      -0.1        0.06 ±108%  perf-profile.self.cycles-pp.aa_file_perm
      0.21 ± 14%      -0.1        0.08 ± 63%  perf-profile.self.cycles-pp.rebalance_domains
      0.16 ± 12%      -0.1        0.04 ±121%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.33 ± 12%      -0.1        0.21 ± 33%  perf-profile.self.cycles-pp.get_jiffies_update
      0.26 ±  7%      -0.1        0.15 ± 36%  perf-profile.self.cycles-pp.__switch_to_asm
      0.14            -0.1        0.03 ±108%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.19 ± 26%      -0.1        0.09 ± 38%  perf-profile.self.cycles-pp.try_charge_memcg
      0.26 ± 11%      -0.1        0.16 ± 51%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.14 ± 28%      -0.1        0.04 ±130%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.16 ± 15%      -0.1        0.07 ±105%  perf-profile.self.cycles-pp.get_slabinfo
      0.14            -0.1        0.05 ± 80%  perf-profile.self.cycles-pp.read
      0.12 ± 21%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__kmalloc
      0.16 ± 15%      -0.1        0.08 ± 88%  perf-profile.self.cycles-pp.mutex_unlock
      0.21 ± 14%      -0.1        0.12 ± 46%  perf-profile.self.cycles-pp.newidle_balance
      0.60 ±  5%      -0.1        0.52 ± 14%  perf-profile.self.cycles-pp.idle_cpu
      0.16 ± 12%      -0.1        0.08 ± 59%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.12 ± 21%      -0.1        0.04 ±107%  perf-profile.self.cycles-pp.lockref_put_return
      0.12 ± 21%      -0.1        0.04 ±107%  perf-profile.self.cycles-pp.vfs_read
      0.14            -0.1        0.07 ± 72%  perf-profile.self.cycles-pp.update_cfs_group
      0.10            -0.1        0.03 ±108%  perf-profile.self.cycles-pp.getname_flags
      0.00            +0.1        0.11 ± 34%  perf-profile.self.cycles-pp.ata_scsi_qc_complete
      0.00            +0.1        0.12 ± 53%  perf-profile.self.cycles-pp.dma_unmap_sg_attrs
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.__blk_bios_map_sg
      0.00            +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.2        0.16 ± 48%  perf-profile.self.cycles-pp.handle_edge_irq
      0.00            +0.2        0.16 ± 55%  perf-profile.self.cycles-pp.blk_mq_submit_bio
      0.00            +0.2        0.16 ± 31%  perf-profile.self.cycles-pp.poll_idle
      0.07 ±100%      +0.3        0.38 ± 31%  perf-profile.self.cycles-pp.mod_zone_page_state
      0.24 ± 23%      +0.3        0.58 ± 31%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.4        0.35 ± 35%  perf-profile.self.cycles-pp.scsi_prepare_cmd
      0.05            +0.5        0.54 ± 30%  perf-profile.self.cycles-pp.ahci_scr_read
      0.02 ±100%      +0.5        0.55 ± 22%  perf-profile.self.cycles-pp.ahci_qc_complete
      0.07 ± 28%      +0.5        0.60 ± 25%  perf-profile.self.cycles-pp.ahci_handle_port_intr
      1.00 ± 18%      +0.6        1.65 ± 14%  perf-profile.self.cycles-pp.menu_select
      0.04 ±100%      +0.7        0.74 ± 14%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
     15.38 ±  2%      +4.3       19.66 ±  6%  perf-profile.self.cycles-pp.intel_idle


***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-csl-2sp3/filemicro_seqwriterandvargam.f/filebench

commit: 
  d1e875ff9b ("cifs: When caching, try to open O_WRONLY file rdwr on server")
  22ac9f5a2e ("cifs: Cut over to using netfslib")

d1e875ff9bdc18ba 22ac9f5a2eef790caf9f972ee12 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1633648           +53.0%    2500040        cpuidle..usage
   1546800 ±  9%     -53.7%     716539 ± 64%  numa-meminfo.node0.Inactive
   1173526 ± 16%     -59.1%     479661 ± 84%  numa-meminfo.node0.Inactive(file)
    311552 ± 15%     -65.1%     108860 ± 74%  numa-vmstat.node0.nr_dirtied
    293396 ± 16%     -59.1%     119930 ± 84%  numa-vmstat.node0.nr_inactive_file
    293396 ± 16%     -59.1%     119930 ± 84%  numa-vmstat.node0.nr_zone_inactive_file
      6407 ±  2%      -3.4%       6191 ±  2%  vmstat.io.bo
      8854           +97.0%      17441        vmstat.system.cs
     16019           +14.6%      18351        vmstat.system.in
      0.28            +0.1        0.35        mpstat.cpu.all.irq%
      0.03 ±  2%      +0.0        0.04 ±  6%  mpstat.cpu.all.soft%
      0.13 ±  8%      +0.0        0.16 ±  9%  mpstat.cpu.all.sys%
      4.57 ±  4%      -5.8%       4.30 ±  2%  mpstat.max_utilization_pct
    117.55           -49.4%      59.50 ± 15%  filebench.sum_bytes_mb/s
     21843           -49.4%      11054 ± 15%  filebench.sum_operations/s
      0.03 ±  4%    +133.8%       0.08 ± 21%  filebench.sum_time_ms/op
     21843           -49.4%      11054 ± 15%  filebench.sum_writes/s
    107.08            +5.8%     113.28        filebench.time.elapsed_time
    107.08            +5.8%     113.28        filebench.time.elapsed_time.max
   1444608          -100.0%       0.00        filebench.time.file_system_outputs
     30803         +1350.1%     446683        meminfo.Active
     30591           +13.6%      34753        meminfo.Active(anon)
    212.37 ±  7%  +1.9e+05%     411929        meminfo.Active(file)
    128206 ± 16%     -16.3%     107267 ± 10%  meminfo.AnonHugePages
    399213 ±  3%     -18.4%     325750 ±  6%  meminfo.Dirty
   2057508 ±  2%     -23.2%    1579514        meminfo.Inactive
   1360377           -32.2%     922769        meminfo.Inactive(file)
     40708           +15.1%      46851        meminfo.Shmem
    324.25 ±  4%     -54.7%     146.91 ± 20%  sched_debug.cfs_rq:/.avg_vruntime.min
     87.85 ± 24%     -48.3%      45.46 ± 35%  sched_debug.cfs_rq:/.load_avg.avg
    251.78 ± 12%     -33.9%     166.32 ± 24%  sched_debug.cfs_rq:/.load_avg.stddev
    324.25 ±  4%     -54.7%     146.91 ± 20%  sched_debug.cfs_rq:/.min_vruntime.min
     60.85 ± 32%     -62.8%      22.62 ± 62%  sched_debug.cfs_rq:/.removed.load_avg.avg
    232.32 ± 15%     -52.1%     111.34 ± 59%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     23.22 ± 31%     -54.6%      10.53 ± 62%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     96.98 ± 14%     -45.1%      53.29 ± 61%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     23.22 ± 31%     -54.6%      10.53 ± 62%  sched_debug.cfs_rq:/.removed.util_avg.avg
     96.98 ± 14%     -45.1%      53.29 ± 61%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    319.89           -26.1%     236.32 ± 28%  sched_debug.cfs_rq:/.util_avg.avg
    266756 ±  5%     -20.3%     212575 ± 18%  sched_debug.cpu.avg_idle.stddev
      9356          +769.1%      81316 ± 89%  sched_debug.cpu.nr_switches.max
      1587 ±  3%    +828.9%      14743 ± 88%  sched_debug.cpu.nr_switches.stddev
      3.06            +6.5%       3.26 ±  2%  perf-stat.i.MPKI
      5.03            +0.3        5.29        perf-stat.i.branch-miss-rate%
  15636680           +22.6%   19163261 ±  2%  perf-stat.i.cache-references
      8709 ±  2%    +102.1%      17605        perf-stat.i.context-switches
      2.19           +10.9%       2.43        perf-stat.i.cpi
 2.066e+09 ±  4%     +17.4%  2.427e+09        perf-stat.i.cpu-cycles
      0.66            -4.3%       0.63        perf-stat.i.ipc
      0.09           +96.4%       0.18 ±  2%  perf-stat.i.metric.K/sec
      5.98            -0.2        5.79        perf-stat.overall.branch-miss-rate%
      1.18           +10.2%       1.30        perf-stat.overall.cpi
      0.85            -9.3%       0.77        perf-stat.overall.ipc
  15508634           +22.4%   18984326 ±  2%  perf-stat.ps.cache-references
      8831           +98.5%      17535        perf-stat.ps.context-switches
 2.055e+09 ±  4%     +17.2%  2.408e+09        perf-stat.ps.cpu-cycles
 1.886e+11 ±  5%     +12.6%  2.124e+11        perf-stat.total.instructions
      7656           +13.6%       8696        proc-vmstat.nr_active_anon
     53.72 ±  7%  +1.9e+05%     102991        proc-vmstat.nr_active_file
    361452           -50.0%     180892        proc-vmstat.nr_dirtied
     99704 ±  3%     -18.4%      81380 ±  6%  proc-vmstat.nr_dirty
    340104           -32.2%     230710        proc-vmstat.nr_inactive_file
     13103            +3.6%      13575        proc-vmstat.nr_mapped
     10202           +14.4%      11675        proc-vmstat.nr_shmem
     51878            +1.9%      52847        proc-vmstat.nr_slab_unreclaimable
    350859           +39.6%     489703        proc-vmstat.nr_written
      7656           +13.6%       8696        proc-vmstat.nr_zone_active_anon
     53.72 ±  7%  +1.9e+05%     102991        proc-vmstat.nr_zone_active_file
    340104           -32.2%     230710        proc-vmstat.nr_zone_inactive_file
    102688 ±  3%     -17.4%      84778 ±  6%  proc-vmstat.nr_zone_write_pending
     61.00 ± 14%  +21767.2%      13339 ± 83%  proc-vmstat.numa_hint_faults
     38.00 ± 21%   +6645.6%       2563 ±200%  proc-vmstat.numa_hint_faults_local
    874700            +3.0%     901167        proc-vmstat.numa_hit
    775337            +3.4%     801665        proc-vmstat.numa_local
      8902           +92.6%      17142 ±  3%  proc-vmstat.pgactivate
   1127002            +7.1%    1207125        proc-vmstat.pgalloc_normal
    430015            +5.7%     454334 ±  2%  proc-vmstat.pgfault
    867503           +34.3%    1164851 ±  5%  proc-vmstat.pgfree
     19925           +17.0%      23306 ±  7%  proc-vmstat.pgreuse
     27.44            -0.7       26.75        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     23.96            -0.6       23.32        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      7.58 ±  2%      -0.5        7.04 ±  6%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.30            -0.5        0.78 ± 54%  perf-profile.calltrace.cycles-pp.get_jiffies_update.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      1.63 ±  3%      -0.4        1.19 ± 24%  perf-profile.calltrace.cycles-pp.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      2.98 ±  9%      -0.3        2.69 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.62 ±  6%      -0.3        3.36 ±  3%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.81 ± 11%      -0.2        1.63 ±  8%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.68 ±  4%      -0.1        0.60 ±  6%  perf-profile.calltrace.cycles-pp.update_irq_load_avg.update_rq_clock_task.scheduler_tick.update_process_times.tick_nohz_handler
      0.87            -0.1        0.79 ±  8%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.94            -0.1        0.86 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     96.38            +0.9       97.32        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     96.38            +0.9       97.32        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     96.32            +1.0       97.28        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     95.22            +1.0       96.20        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     97.10            +1.2       98.28        perf-profile.calltrace.cycles-pp.common_startup_64
     86.95            +1.5       88.48        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     58.68            +1.9       60.60        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.66 ±  7%      -0.7        0.94 ±  7%  perf-profile.children.cycles-pp.do_syscall_64
      1.66 ±  7%      -0.7        0.94 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.70 ±  2%      -0.5        7.18 ±  7%  perf-profile.children.cycles-pp.update_process_times
      1.31            -0.4        0.88 ± 35%  perf-profile.children.cycles-pp.get_jiffies_update
      1.65 ±  3%      -0.4        1.22 ± 24%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.43 ±  2%      -0.3        0.10 ± 40%  perf-profile.children.cycles-pp.worker_thread
      0.60            -0.3        0.26 ± 17%  perf-profile.children.cycles-pp.kthread
      0.60            -0.3        0.28 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      0.60            -0.3        0.28 ± 15%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.42 ±  6%      -0.3        0.09 ± 46%  perf-profile.children.cycles-pp.process_one_work
      3.06 ±  9%      -0.3        2.74 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      3.71 ±  6%      -0.3        3.40 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.24 ±  6%      -0.2        0.04 ± 75%  perf-profile.children.cycles-pp.write
      1.84 ± 10%      -0.2        1.65 ±  8%  perf-profile.children.cycles-pp.rebalance_domains
      0.79 ±  2%      -0.1        0.67 ±  6%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.90            -0.1        0.80 ±  8%  perf-profile.children.cycles-pp.timerqueue_add
      0.96            -0.1        0.87 ±  9%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.28 ± 12%      -0.1        0.22 ± 19%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.73 ±  4%      -0.1        0.66 ±  5%  perf-profile.children.cycles-pp.update_blocked_averages
      0.24 ±  2%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.exc_page_fault
      0.16 ± 25%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.do_exit
      0.16 ± 25%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.do_group_exit
      0.22 ±  2%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.68 ±  5%      -0.1        0.64 ±  7%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.76 ±  5%      -0.1        0.72 ±  4%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.18 ±  2%      -0.0        0.14 ± 16%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.14 ±  7%      -0.0        0.09 ± 21%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.25 ±  4%      -0.0        0.20 ± 10%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.08 ±  6%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.unmap_page_range
      0.08 ±  6%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.zap_pmd_range
      0.14 ±  7%      -0.0        0.10 ± 27%  perf-profile.children.cycles-pp.__mmput
      0.12 ± 13%      -0.0        0.07 ± 29%  perf-profile.children.cycles-pp.exit_mm
      0.14 ±  7%      -0.0        0.10 ± 27%  perf-profile.children.cycles-pp.exit_mmap
      0.11 ± 18%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.note_gp_changes
      0.23 ±  8%      -0.0        0.19 ± 11%  perf-profile.children.cycles-pp.execve
      0.20 ±  2%      -0.0        0.16 ± 11%  perf-profile.children.cycles-pp.handle_mm_fault
      0.23 ±  8%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.14 ± 21%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.17 ± 11%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.rcu_core
      0.20 ±  2%      -0.0        0.16 ± 11%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.08 ±  6%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.unmap_vmas
      0.22 ±  6%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.do_execveat_common
      0.15 ±  6%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.bprm_execve
      0.08 ±  5%      -0.0        0.05 ± 49%  perf-profile.children.cycles-pp.kernel_clone
      0.13            +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.20 ±  2%      +0.0        0.24 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.16 ±  3%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.idle_cpu
      0.59 ±  3%      +0.1        0.65 ±  4%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
     96.38            +0.9       97.32        perf-profile.children.cycles-pp.start_secondary
     97.10            +1.2       98.28        perf-profile.children.cycles-pp.common_startup_64
     97.10            +1.2       98.28        perf-profile.children.cycles-pp.cpu_startup_entry
     97.10            +1.2       98.28        perf-profile.children.cycles-pp.do_idle
     96.04            +1.2       97.24        perf-profile.children.cycles-pp.cpuidle_idle_call
     89.00            +1.2       90.23        perf-profile.children.cycles-pp.cpuidle_enter
     88.68            +1.3       89.96        perf-profile.children.cycles-pp.cpuidle_enter_state
     58.80            +1.8       60.64        perf-profile.children.cycles-pp.intel_idle
      1.30            -0.4        0.86 ± 36%  perf-profile.self.cycles-pp.get_jiffies_update
      0.61            -0.2        0.45 ± 18%  perf-profile.self.cycles-pp.update_process_times
      0.79 ±  2%      -0.1        0.67 ±  6%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.72            -0.1        0.62 ±  8%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.66            -0.1        0.59 ±  4%  perf-profile.self.cycles-pp.__get_next_timer_interrupt
      0.28 ± 12%      -0.1        0.21 ± 18%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.44 ±  3%      -0.1        0.37 ± 10%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.23 ±  8%      -0.1        0.18 ± 10%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.68 ±  5%      -0.1        0.64 ±  7%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.14 ±  7%      -0.0        0.09 ± 21%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.53            -0.0        0.48 ±  4%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.18 ± 13%      -0.0        0.14 ± 15%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.29 ±  3%      -0.0        0.25 ±  9%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.12 ±  4%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.12            +0.0        0.15 ± 11%  perf-profile.self.cycles-pp.clockevents_program_event
      0.13            +0.0        0.16 ± 10%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.10            +0.0        0.15 ± 17%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.22 ±  4%      +0.0        0.27 ± 12%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.16 ±  3%      +0.1        0.22 ±  8%  perf-profile.self.cycles-pp.idle_cpu
     58.80            +1.8       60.64        perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


