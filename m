Return-Path: <linux-fsdevel+bounces-15190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCD88A515
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4018ABA22C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0FD6EB6D;
	Mon, 25 Mar 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijK01UGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E31C1BE5;
	Mon, 25 Mar 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341584; cv=fail; b=JeSkcICAGs2384AaJW2vX/bTLMLAHbzcU1cSAcsLFwVB7Jv8jLbMKAUPIeKCsqk1lQo/Yv6dtvwDUcQOEs99oR1uQqBY56usiIKv8K8bduQgac3oNLhTGWv0kLGWwVAFS41Z0SHTZcu5hQ53zJXIK07VNxSGghlUACU+vyYAYcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341584; c=relaxed/simple;
	bh=JMimwhBtI1CVkjvE58gD6q7KEUU8eD5hfTLSc9ohZbg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OOgUcu888KRbmOcE4j32IaKKdTVm+di4MgzZ5/W46ffsr7k6J6V8sFWpxHUcrVNvFqVfLfngKmR9Q4PBq796Z7IPmcBp/HFKHRGIC031Jw5pIzIvg2bcITpZmIJ2SiQZSHdcBCe/zTzw1H5t1xBJnmGYvxag9I3hcKdzggZ6pX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijK01UGN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711341583; x=1742877583;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=JMimwhBtI1CVkjvE58gD6q7KEUU8eD5hfTLSc9ohZbg=;
  b=ijK01UGNCIEG13qoSLHU+rsQ3K9rogj9WxQf7INRSIv1gRmwuSbOO2u4
   NeqGpQNB1NcWt9W4qJZr3NRIdz2yLbG3q7XoN6z9Tpv7w11ohiZ5OSZNj
   0XxNkXIAmpV77VOj0q3URcn39o+YtvnhoMAx63v41wwWzs7QLj5fewePJ
   xFNXOqZc/GukR/PqGthhTMJPmhopaiZbdLr5IRBsahaQL1LuHF8me20W6
   R2AjHIuLssinLzgg8z2BvyszuSj9ulHh8tNaOxE5IXlula2IXnqeLnIL3
   ptOqd8JJb3Iu3IMADzrd/Db/CxR9sHCFRVcGugIIzVSGdPUQ+ZPsSVixW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="31762813"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="31762813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 21:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15930504"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2024 21:39:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 21:39:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 21:39:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Mar 2024 21:39:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 21:39:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7CGKB1OGlDg2hDzuK/3aNe6QehjSK7/2CpWKL4kZ/PMBkbssp7cBqhxYL3gGMsFPes3MxaEA+SpuAJx8KXEZDUaJvw2jJj1sKCJwARGqzLGkmLahcfCop26JNjYs2cAK0u2V9InSWPieK682Y205XiPsilz10MshrvQ4/lPQNkK4yNaH9L2ObhMMVCDEiVxdD6cdYPhTNiOKDwW/N8QfPAxCx9oYhhBrOo9SgIehyepPbO1zi24oQ67Qz7GM57di+RjAV4fy8ac2biWtQvrZu5+/R/iWDNybf76nsm6Lj+RaMjUtAso82OYq5XpGly0Hns3TvK2BojJ/Xk8IrtDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfPIitLhuALSKW0NIvjNqk3murQ+BbkiwLcuwClEf14=;
 b=YR/ieKuNkEt5ERKU89YwJNd0DOs9IwPRphdXj61Akf494S2LCTdBVQyMedl1poEG10e3y7fHAjK0EuDSWa4jamFD1lhTtvQQYcNTEau+68ci7z0r809sGPPaOTeUIZIwNHFalhuRGafCxwRWTjaISar+f3pYuhZQA0L95FovsV/80QlmaX4zyPgUzksxo60Pm52SCiiVejQbTm3xiVXuXGP/b8xNHhowZ5PFtk568GmqNBM/wUOEc2Ca7qhFRUPZHpT9kFzlP6yDD5pvrD1GqGkJvkKnU8fZwFmdIMTTtMGEm0DNDf95VqvlR9UL4XdlOF1uvtXJwchHx2BLmdZnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 04:39:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 04:39:35 +0000
Date: Mon, 25 Mar 2024 12:39:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Luis Henriques <lhenriques@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, <linux-ext4@vger.kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miklos Szeredi
	<miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Luis Henriques <lhenriques@suse.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/3] ext4: fix the parsing of empty string mount
 parameters
Message-ID: <202403251019.50cab6c8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240307160225.23841-3-lhenriques@suse.de>
X-ClientProxiedBy: SG2PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: c0248016-8551-4f49-f979-08dc4c85928e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdVEdKvRDP0prX1xgRoObAluNbe5wgZK6hSaCderRxghZRkF0nZ2Iyv9qwPw0c69sOmL3mfSA8KSIsRCrM10Jp6uGuaWyHbd4yzSM33DF0GrizLE8xRW8XxpFY2Cu3965AjhQE9EORmYwC0tvgQ5l11AY6JsRCR4ERIlBP99dckH9pg00MZGGiVpPqa+Jxeu6ckXYdx5r11adIBsi0WimldzRxbbjHJFWe0j85EuwENrA8ZWSvjYT2rFEXWe5GKVswdBveE+cvp7/hNR8tMYxUMWc4PokRTMz2dA1+m7Q7wB2zSGiZb+8n3DB8SrhoaOh7eoAIZpyT7s33dbkVADh7LBwiRFvWqivrZlHnAJFBj05ZlXVdJd9eZzoKd0cC5fODioZ0nE/D6S2xiJNzOIPUcS6kYOzapM4MCs6gOkC5m2rniIuwabnSe31N2s63nGgsYHCfD1FSe0l3jHRqPS7QJ4nYXaHXhsQ0bi9z3+PTWbQUQGuXdGcG6XDbKQxz8RBeQnJT2ghYTuV26yR5j441BTLL3Oys65Xfk67DmhLUIrEGitfbf3GdoLWzIypqIjdRgHbGqM3z7VHI+Q8EaBUO6j3E9ezk2ZfguUhbyjqolNvUUpwK0F8MgyNcshNNFh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lL1vAZto1Jku2mils8JlkNCc+P0EaFYPmcAUGhgBnGgBHUwEC6Mo491lQANt?=
 =?us-ascii?Q?l9go9k2ErrR7juHWfw8r9oj6Dv8aEEWs977/65RfvwKY89zWeZdHlK5go3I+?=
 =?us-ascii?Q?0us79jZPwHqg7XkmEK3lN7yJ+58ShmywAkhfqDgav75NtzWnJYLUxlZiiscj?=
 =?us-ascii?Q?OvU+3koiPKfGsvD4sy8xwJyCXzvRWLThwDfVPHt+9mb6sBA1FyaxXm1Z+uqj?=
 =?us-ascii?Q?BpSqSJv569XM9QbTdZEsa28tZVgZOt4v9ogSph5j+7xLh67WXUYX9EftmBLD?=
 =?us-ascii?Q?a5LSQXd8VxeRIUWF8+1kXF0LC3I3CNaKBNOUXb4i8gL8LQoFAuSr/yckAjqv?=
 =?us-ascii?Q?mMrEpZrPnIjm4OOWG2YAR3UkQMI+nRBzPTwIHZjjHL9IsbmFAVzBr1jMMv3H?=
 =?us-ascii?Q?k3c5ZFuWW5cYlKzVNPPWmqFTSuT2vr5Nhkcnus9ph6y4z8ufBcaeTMTnVg57?=
 =?us-ascii?Q?IvnqLbv72Z9jRa/nknU92h3FbjJt3nO+9bOv4sCQk7VndfhXCk22+4goX36y?=
 =?us-ascii?Q?oOH9o16DN/187bHMw3XfkKm3ZNaNkoHfzM+P+AQU4qC7CBNrh0/+b3Uwuhd3?=
 =?us-ascii?Q?tPdz1UIh93xUIkbFF7zv7zucSAeEi0TD6h1JlXIqCHjb+rgGSmmdbgTV7Vzq?=
 =?us-ascii?Q?44p1fKkK70Kckd/wpTLs+J1MXp2aBepOL7ZC2Zt8VTM3txTiBNWTsy2E+zlr?=
 =?us-ascii?Q?Iv5Q4ePPG1ehp+qz7rVYiirX7nCWxChvDntfe3ZR9PzQjGW9zHtAHWpRUDP0?=
 =?us-ascii?Q?21DRxe+y4DL/nyCP0ktBZjMEmJuo7WXjK9XV6OsKZTDlOtr1lz8LjbqwZT/m?=
 =?us-ascii?Q?/XRq/Rm9ARKr0zxSxg440j3I2N2zu9GcnWGGG7QaaB26f76zIbidG9EfYrXd?=
 =?us-ascii?Q?azKEKAP39b3KsrXGTELpLRA0PG2vPI2q/8xfHpPoW0tg251QfTZfJpzbMrmn?=
 =?us-ascii?Q?pQNFRx664Q3InAjMxTN/OftccKJ2piXVSsmv4XyghXEVg/OHd6AHd/92LdZ4?=
 =?us-ascii?Q?tctv1FsTMTnHJl8BQ1EtscEt9/BYh1SiR+HRsAspx6eFav03Mao3PGTlOw//?=
 =?us-ascii?Q?FVzb9nyOdwMyx8jUUmLREAbQQmPaIQJt3RZHsE3ReBEN+9qt71E9IxM4K8hM?=
 =?us-ascii?Q?o21RsnAHwnFZTMYCGwQMSWTVohdaiOTV00hp2wFdMF9X1Tgit65jvhAOqSBf?=
 =?us-ascii?Q?iXtT3ICIYg8Mnqv3l+qyiTy02k+6BseJ6PjIU0qGg5qDVRLBatI5SCJhZM/C?=
 =?us-ascii?Q?VmSsDZDUHi07HnWjx/8Ok3kcU3dbBad0PDp+WX9U5DKhoQULoUkuyHuqP35q?=
 =?us-ascii?Q?73qhD7A8kxRzlPDS5VdWyRbKJWDxMISQLV9rcrAGgyjt7vjljX7FRffh20N0?=
 =?us-ascii?Q?DlpwCaUZf/sdtRtMJT0TMqJ7ZswvWf8cs0UOFG8gHzNJe1qC1CzhwAGkrccT?=
 =?us-ascii?Q?4I/aa7B7b8lJ7O+LxSwkc2CNd3yRQ7TVYHtzlLPH2eg+VoM2+0uO/8ZPDMor?=
 =?us-ascii?Q?g+O3nJt03lizO10qrsCw9XQxY2Z2JuABtJivrTiN7cN2CaLszOLJH0Qz6IBU?=
 =?us-ascii?Q?q1fYxzsDHFFimJv3dTTwZypThBuSRuZnV6t9xJ2Z0Ob4kAdNADcUCqGHiZ7a?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0248016-8551-4f49-f979-08dc4c85928e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 04:39:35.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRoxbRkO4/zbLLLhRH4ohZer2JduXuYdNHwLi4XioIgLmEBxdNYAzOlwrydG6M/KeL6LsMQrV/yUKw8S+JI4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
X-OriginatorOrg: intel.com


hi, Luis Henriques,

we noticed in
https://lore.kernel.org/all/20240307160225.23841-1-lhenriques@suse.de/
it was mentioned this patch is for "ext4/053 fstest failure",
however, in our tests, 053 can pass on parent but fail on this commit.


12dbddcebcb8e fs_parser: add helper to define parameters with string and flag types
2de45c422fe6a ext4: fix the parsing of empty string mount parameters

12dbddcebcb8e3e1 2de45c422fe6ae4f64d35df99cd
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     xfstests.ext4.053.fail

not sure if there is a xfstests patch works with this patch? Thanks!

below report just FYI.


Hello,

kernel test robot noticed "xfstests.ext4.053.fail" on:

commit: 2de45c422fe6ae4f64d35df99cdaf2c6fee2a5ac ("[PATCH v2 2/3] ext4: fix the parsing of empty string mount parameters")
url: https://github.com/intel-lab-lkp/linux/commits/Luis-Henriques/fs_parser-add-helper-to-define-parameters-with-string-and-flag-types/20240308-104759
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20240307160225.23841-3-lhenriques@suse.de/
patch subject: [PATCH v2 2/3] ext4: fix the parsing of empty string mount parameters

in testcase: xfstests
version: xfstests-x86_64-9b6df9a0-1_20240318
with following parameters:

	disk: 4HDD
	fs: ext4
	test: ext4-053



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403251019.50cab6c8-oliver.sang@intel.com

2024-03-22 09:38:10 export TEST_DIR=/fs/sdb1
2024-03-22 09:38:10 export TEST_DEV=/dev/sdb1
2024-03-22 09:38:10 export FSTYP=ext4
2024-03-22 09:38:10 export SCRATCH_MNT=/fs/scratch
2024-03-22 09:38:10 mkdir /fs/scratch -p
2024-03-22 09:38:10 export SCRATCH_DEV=/dev/sdb4
2024-03-22 09:38:10 echo ext4/053
2024-03-22 09:38:10 ./check -E tests/exclude/ext4 ext4/053
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.8.0-rc3-00019-g2de45c422fe6 #1 SMP PREEMPT_DYNAMIC Sat Mar 16 03:20:13 CST 2024
MKFS_OPTIONS  -- -F /dev/sdb4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb4 /fs/scratch

ext4/053       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//ext4/053.out.bad)
    --- tests/ext4/053.out	2024-03-18 16:30:59.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//ext4/053.out.bad	2024-03-22 09:44:06.379217460 +0000
    @@ -1,2 +1,3 @@
     QA output created by 053
     Silence is golden.
    +SHOULD FAIL mounting ext4 "test_dummy_encryption=" (mount unexpectedly succeeded) FAILED
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/ext4/053.out /lkp/benchmarks/xfstests/results//ext4/053.out.bad'  to see the entire diff)
Ran: ext4/053
Failures: ext4/053
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240325/202403251019.50cab6c8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


