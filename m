Return-Path: <linux-fsdevel+bounces-17104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4E8A7BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 07:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6900B281FC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23950A7A;
	Wed, 17 Apr 2024 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YevWvGwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB44EB5F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330394; cv=fail; b=cHnf0L7LZvIMY38tCo9HI6VFAFGjdoyMcrT1nvRw+yFmteOwtCTX33wos5mF1QA8EuctgKhOGztubyhklqHSdrX4g6w6IVM6eQVKlQs/d+uy4JbfP5i2HBxTP9FAmwa0v0YlvTYQ7XmNqMinmV8D76xdaPi014+OaXwmWTeWlZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330394; c=relaxed/simple;
	bh=0/yB8IKaMiNwbsBoyXcaCKfYQFab1ZeesNqFG1zcq58=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4npiEgzV3vgSOQBaXDMkSvspwIUgQtfYgPTYbtyAfZZ/U0wVK/n1nKfZrEB19U3da4H65cUA2IyEggK9txbnEXceHQnmGVyjREzGaLTMLXrWGkxHCKd+JgnHfJis/YK5J3j6WJdGZhmv+GqdSsKtO3wk36de5/wLtnCEBj6YjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YevWvGwj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713330392; x=1744866392;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=0/yB8IKaMiNwbsBoyXcaCKfYQFab1ZeesNqFG1zcq58=;
  b=YevWvGwjqR1lOUKvDfB1koUVn9fpYpOUSWj2agCRBIZkApcykHJaekLE
   OkiqlVrrjk+07Bzhwcj661kszwf4VSLslVItvHASzdu6qFqPC/AWSe0jV
   evlY+LAW/aME66SRwzutgTQSXz1OvbnvJgolHoioJ8FFUEMf98/OkfUe1
   Hytly43/kbRX9C5ffx7TWc2qNn9iN5BNbmfR0zJ8jG2gTfkgn4b/FNvEu
   qe3RiOvLQWRbA2hRDyHEFQnN5SxhBn5n7ywqadZRG18cFV0NUFKvfHks0
   u505Cbmwj/6vRxXn5eH5ZT3HCU09LImJdds+4Bi8fljyreK35LdlPAvGQ
   Q==;
X-CSE-ConnectionGUID: e+jGRciNTVqsdYMxg/6FEg==
X-CSE-MsgGUID: 2VQfXD5tSnSvjsEQfdbB0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8664859"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8664859"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:06:31 -0700
X-CSE-ConnectionGUID: nxDgt3TLSCefl5Z3jlQTvw==
X-CSE-MsgGUID: MJUwmSbRRUqujSZV17A7Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22561501"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 22:06:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 22:06:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 22:06:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 22:06:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 22:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXXUyku2rjU2VizeK0E9pH81oZLXnV/E2C3L+ZxoIbQ7hurSit3ZjcilXN1mML/mIlrtD8NQuQ2nR19S8g+hcueNKHCuObEmyiUH5k2LH6pZNZd7utXPcN0f4QhXvilhkwZkTuNaKP77T0hyEb0vubKlpbvdNXDFgsXFTHTpYb929QxjQbBa17Xk2IYm87LmRGSdnMVsAgfURe4+SOatAORPDcqesc/EEGKRdDW89g/1/0XIEVQztzsSUjYT21GU/YiohVcQRhT8k+WmB/B9uyR7OGEwankUyQ3aEcZY6w5r4uzzHKGcBPnxj9ZT4wGQ05Y8jLnJay5Ahl7EmpW2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE7bFgUU31N1dJRB2J1dVLCSGFQzlIprDALlX3jhQnE=;
 b=lwqFsBlZ7Gq91FCb/6gwDkvrbDc+rw14DOr2FTyUbgjRp4jUEcgkM5nnw1RAP31gZETnwqsG9MUFIAES+YAS2+eVriB5z4k1jaWbQv9QkB/HT9i9VHDiQvlxXaVH153Oe8/qzxnm0ozApAbxJLuM/7GTTVX9wgCU3+jjx2UkKHK/aJSZ+IolyvCOAfnW99SJskYpb/nR+I/Xy6todJh7XsCjsiTW2Qknzem35Xflnl9ZK9ImivvRdJJ4jBY7/Kp2bN2sVJrQIQYyH3wFw2TvOOmAA1kBzbpcrVeiOxwCMtZ3F8CZd0KQdQglZj0kjJ2zBIxZEfwx+76sboly/Byicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6491.namprd11.prod.outlook.com (2603:10b6:208:3a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Wed, 17 Apr
 2024 05:06:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 05:06:27 +0000
Date: Wed, 17 Apr 2024 13:06:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Groves <John@groves.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, John Groves <john@groves.net>,
	<linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, John Groves
	<jgroves@micron.com>, <john@jagalactic.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored
 via stack address
Message-ID: <202404171222.628d7c98-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e368c6-ab93-402f-edae-08dc5e9c22f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyT/vH99I6ZEhjekojVedRnCUfDxRN8P2pJ/p+z0EzmRrUS7aFCkjkc9/roZdhX1HU3C2bxrCVgxFL+LuoaEDuVeKaiFrFSQm0lM9v4ZYcJYYXzeiE9nIac+fjLdViRe1mugfsVMLiA9rBZcRJeVbjIUOh01EPRXIsM6rXRZ5ZzOyvXH2Ija2wMzuw1vLYhnA+aVK/GhVXvMlGTn46iR9wUhV/fwx+E/6r+Yvsc51BF5CmQ5/7yjsnmVLa8D+VoYd7jK1UvWaJ8WxFscLpr9gnF2XQBG91Ilv+PGVKiEE6GWSPxcYPgZJ7gQJDHlyopnwR/JEHtjqMXutJ5qZ3mjwGV5DUboqcAQTxzQDsapB1S2uN5MiFxHA32jl5M/vestsFT9ul37SXHL6UPb8aq3LJkvnlLw8gVTuPnN7A4hwLvPaeqfhhUy5DAs58jh39ZwsAkfARZ5HsTrxTX4WgzxC4gGSjVydCR2bIFBeZ2FufuY/6nc0Zkoq4B3xSs7jUknhV47SWDDDVepn1TPMfM3rV81zP2Tm4QIInDn0+hoJ94cm3IyUAuhVxmtaKL0naraAyx8sbIFu60OeemE8zugE8WSVpA4mPH9nnhVieNs/83jex1kmQRID5BtV4OWzops
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFwEFPqLv4ErX+OKdT3ogm1JQuM3lqs6lgVfC9/a9b0J5KdRPVCq+yJi5oa6?=
 =?us-ascii?Q?aegGQeGw+BhwFDXOHoIA7IREieM+ga4NGHokdxu9LuBOnji6Vcx9erDBxxMw?=
 =?us-ascii?Q?5EN8oik4bHNlmhcNsVC3PCZTqqxnvQQ5/ZUN0WjUeijMNAx7AQD4m1hVTzSk?=
 =?us-ascii?Q?PYzRpcdXMXZ9yimuxp7TsoAME5WgW2gn+i2TWpru1veVl2LyFH5sRzOjOYEc?=
 =?us-ascii?Q?8tjc5IiB6EhJ+XTNnsfiP7tKJZ4M8HfXpUnooNtCfyNIKhVmJyZL9O4mBsA0?=
 =?us-ascii?Q?k+5SaNHVjraMWMJY81R+ctpRVQvt4havr9mlLlG9n5LYnvcjeiSvDOH5Xy7g?=
 =?us-ascii?Q?hZPcEYZ6nv8TPGTXXkUykCkwpi6Jz8DbbVZvq07Shhc/bJrJTuieVgs7/DBS?=
 =?us-ascii?Q?Em4nz5qhFlwKZ2Fp+jsTJ9m8aQSQ7QubMJUU1MXizTvtW6AXvELH0BuNGZLe?=
 =?us-ascii?Q?bDU2SWLoTOmmYDFD5ysldMpGxCdPxwX5DS8aRwHdsnibHWjroyyintwZq432?=
 =?us-ascii?Q?wixj0IlUYVC6q8CFVu29BBPfxk2ORx5mSnLf0FNdlXHIg10u0i1PWjpKRDWD?=
 =?us-ascii?Q?jWb0sH0xukEfaErH+43DwsAr+E4oca5AGUhDhvBJIt8ZJcgSF8v/26IK98mO?=
 =?us-ascii?Q?jf1/v5uM8n9xXmnkqrLYLD022N/r1yfzeQczX3oLSmO3cRJhscALPGc+QUGH?=
 =?us-ascii?Q?8ITVkJRdBeiOiY2LQn5HX+XN4XTtyiwzS89BDzM1woaV8uf7xT5ZKkNZ2ibW?=
 =?us-ascii?Q?qKS0KdnVyB3OHoBgsiY7fMJ2oRxLEnsZEFEmVz6IWoPyR44dAsFzQiMxIN6v?=
 =?us-ascii?Q?Z1UH87MxZeQWsbsJxWNHBbuaTVMiX+DX9dMirlONkZlFsycq+6tWM2IzyEYi?=
 =?us-ascii?Q?BYreK3CqPNnJh5FtIDoynWrlLcdLsVG0OxXBGFTR9k+18nWSeXUADxVXri2d?=
 =?us-ascii?Q?EV3wLv/ohqtukdjxynHCu68oCSVqfVmImYsnPeSRUPc8H2phb4uZD9wId2dz?=
 =?us-ascii?Q?QjF+FQiDq52KRwEara6UnNoNZ1DKgEENj+QiMIeHV3BjLySi0UID2wUucO03?=
 =?us-ascii?Q?Ip9Eta1TlKbnrm3JQQUL5pCBfNSXlrxXhViqCg2VywPB+Nok1wp/v+ejxEfx?=
 =?us-ascii?Q?6cuiZhv7rM1PXpf5izmhWHJvH2l5AjZWuZD6SXKc3L0x/qiAYCoibTgLfpEX?=
 =?us-ascii?Q?69x1dvbCRKwncCzkeQw7Ml6DUxhM625im3fDzSjHeDcd2v8gzXZ5vrWSW2Wz?=
 =?us-ascii?Q?PCvF8NmviEmL6GenT0OhTCvZ9oANFRRL5W0erf/D1nQfuw0zXz2sgs1PZIvF?=
 =?us-ascii?Q?Mtpce7h97UgsWzsRezEmPIdZH4O9QQrqfsbsT70/wKImyeR83/h89CqIPNud?=
 =?us-ascii?Q?X+EiQBuZmemM5cwOkDfX3cS7l/5sOCgBKVE/bPfL+2h3kcJnL9T+xbNK1uxh?=
 =?us-ascii?Q?ZdOESw2USCWpRoWKN7/WQeuoMeJdkAWkGQEe66y15Xy490C21SBjBx1vmMOh?=
 =?us-ascii?Q?ZL8ruaGNRdz1bR7Opvd+mPlrrD6A2AUXjBh/Wdp4m7C0nINhApLBWrTafJLh?=
 =?us-ascii?Q?VxRlMoPf8luB0HJkOpO7u1RhkTLrsenS6ymXDiTSHioXqCcZ3CRunbrENn5l?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e368c6-ab93-402f-edae-08dc5e9c22f3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 05:06:27.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vf5tEVPOEbTEJ1iwpjtsPRRJ2aIr4MesTSH6fsZ3oOPSQx+NwPbwh4Xkvdq//6nP+7dfH7o+fuSWAEw8jDQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6491
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: 22170ab79e39d9675bf9aa8d8e08c28759e14533 ("[PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored via stack address")
url: https://github.com/intel-lab-lkp/linux/commits/John-Groves/sget_dev-bug-fix-dev_t-passed-by-value-but-stored-via-stack-address/20240410-073305
patch link: https://lore.kernel.org/all/7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net/
patch subject: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored via stack address

in testcase: xfstests
version: xfstests-x86_64-e72e052d-1_20240415
with following parameters:

	disk: 4HDD
	fs: f2fs
	test: generic-group-15



compiler: gcc-13
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404171222.628d7c98-oliver.sang@intel.com



[   42.142026][ T1384] general protection fault, probably for non-canonical address 0xdffffc0000100000: 0000 [#1] PREEMPT SMP KASAN PTI
[   42.153892][ T1384] KASAN: probably user-memory-access in range [0x0000000000800000-0x0000000000800007]
[   42.163241][ T1384] CPU: 1 PID: 1384 Comm: mount Tainted: G S                 6.9.0-rc3-00001-g22170ab79e39 #1
[   42.173196][ T1384] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
[ 42.181248][ T1384] RIP: 0010:test_bdev_super (kbuild/src/consumer/fs/super.c:1636 (discriminator 1)) 
[ 42.186453][ T1384] Code: 8d 7b 10 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03 7e 3a 48 b8 00 00 00 00 00 fc ff df 48 89 f2 8b 5b 10 48 c1 ea 03 <0f> b6 14 02 48 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 20 31
All code
========
   0:	8d 7b 10             	lea    0x10(%rbx),%edi
   3:	48 89 fa             	mov    %rdi,%rdx
   6:	48 c1 ea 03          	shr    $0x3,%rdx
   a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   e:	84 c0                	test   %al,%al
  10:	74 04                	je     0x16
  12:	3c 03                	cmp    $0x3,%al
  14:	7e 3a                	jle    0x50
  16:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1d:	fc ff df 
  20:	48 89 f2             	mov    %rsi,%rdx
  23:	8b 5b 10             	mov    0x10(%rbx),%ebx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx		<-- trapping instruction
  2e:	48 89 f0             	mov    %rsi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 04                	jl     0x3f
  3b:	84 d2                	test   %dl,%dl
  3d:	75 20                	jne    0x5f
  3f:	31                   	.byte 0x31

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   4:	48 89 f0             	mov    %rsi,%rax
   7:	83 e0 07             	and    $0x7,%eax
   a:	83 c0 03             	add    $0x3,%eax
   d:	38 d0                	cmp    %dl,%al
   f:	7c 04                	jl     0x15
  11:	84 d2                	test   %dl,%dl
  13:	75 20                	jne    0x35
  15:	31                   	.byte 0x31
[   42.205827][ T1384] RSP: 0018:ffffc90000e1fba8 EFLAGS: 00010206
[   42.211722][ T1384] RAX: dffffc0000000000 RBX: 0000000000800001 RCX: ffffffff83bf0f85
[   42.219517][ T1384] RDX: 0000000000100000 RSI: 0000000000800002 RDI: ffff888161ef1010
[   42.227310][ T1384] RBP: ffffffffc1739580 R08: 0000000000000001 R09: fffff520001c3f6d
[   42.235103][ T1384] R10: 0000000000000003 R11: ffffffff85fecd94 R12: ffffffff81b413b0
[   42.242896][ T1384] R13: ffffffff84b229a0 R14: 0000000000800002 R15: ffff888161ef1000
[   42.250692][ T1384] FS:  00007fed4c83a840(0000) GS:ffff888635080000(0000) knlGS:0000000000000000
[   42.259435][ T1384] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.265846][ T1384] CR2: 0000560fcf853018 CR3: 000000074c9ac001 CR4: 00000000003706f0
[   42.273641][ T1384] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.281432][ T1384] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.289224][ T1384] Call Trace:
[   42.292350][ T1384]  <TASK>
[ 42.295131][ T1384] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 42.299126][ T1384] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:702 kbuild/src/consumer/arch/x86/kernel/traps.c:644) 
[ 42.304501][ T1384] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:617) 
[ 42.310049][ T1384] ? __pfx_test_bdev_super (kbuild/src/consumer/fs/super.c:1635) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240417/202404171222.628d7c98-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


