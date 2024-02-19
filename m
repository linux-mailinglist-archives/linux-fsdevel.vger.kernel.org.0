Return-Path: <linux-fsdevel+bounces-11977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB94859C68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 07:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED61B21395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F12031E;
	Mon, 19 Feb 2024 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMXXkw7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C661CD38
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325764; cv=fail; b=O97Hqvqfl87+MLYTFylAYyDjXoU30jrTDWspD6gPAsK+gjpOzZg928k1IC+JXhX+kZu5OSUKDS/v0gEpgsyC1JRXUeHbkItzd1LhLw14nUPGJBnuRsPEVU68+XDKTsWwV7ABnfa2oRGobWCDpTLwYcOJ1uTsKlki1ohhWX2J0no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325764; c=relaxed/simple;
	bh=57zrmeDi7D2p5F86HpfP+hyJluDoN0IzaI4fzP1m7wY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WiOnleHze3BC2UEIIFYPZR/3nHNlMWp3NEXunLfxzwx1/jA1187cm2OVc2cxHLw1sDstzeomdOeeGkRPt0z3rUYHk95yqwYJOOE9fhBqXi1aJ0aVQjV93AAOhdU0iMoadB1JJzMFCzClg8fl+LmTmx5O8AhMkzWLryQ4usiVhHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMXXkw7Q; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708325763; x=1739861763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=57zrmeDi7D2p5F86HpfP+hyJluDoN0IzaI4fzP1m7wY=;
  b=dMXXkw7Q5C+ppTozP4CLlIcK7lzsDu/koNLhFaTr8wB61MJ59fmror4o
   cs+cACWrlBH5pPLDrXrGdXvF+/1Eo0TriEFQ+WCKYrHFT6B0DPUgS6w3U
   PMgEqhCo5ECtn0v2k177rs8WUc3+gIpkE4pykIx08L08na1MGn7o78+pq
   jZ96A9MhzmUDyM8C+9MirYlr+ZxM9Wuweifjh5U8VCPiCk/4jxyG8M9GV
   CtBco8rbmHwyjdm3DQ6o1LnAQpdvJFs9/5MmEAkOadivym+LxAN+/IMSk
   iVww/jVtpoBiiJb8SQPS18r7oZr23pWgDXjQn19tX9KGVhfjRw5tMYM++
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13498475"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13498475"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4310838"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 22:55:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 22:55:53 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 22:55:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 22:55:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 22:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfkjgqkYMookEuV3xfoFfYnl51ld6c2PNv9xG6tHVyBhmoVI9Nl6i2HlR2rGJ5mOKWEYfX9uCDcvY6yauFIpDHS3BKnz1pibGOEpo/FF8wUr8N6zIZZTAihG0bzEoqUcnGxtvJCrApTsMPl2kSUZPk6IkHM8nK02HiPRKhJACEqLsDVfyjBUeeB+KXUACx5bsd5l4X7wKEvmS9pwId7MauZojVLWjVz6tpTgGFc/cVkVXybUZZEZaDOZcAYzXHloCYJGV/8yhzMDN5qtEg4zAAhxqhdKNoPCj/hjmtKOpmihuoPIUOr1fzSDmqUSpNUQp4xDBSEfmeZZgVf2M2rPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeAJwSDnV5F1YI5U1T9N3uLtJpsOVx3DlHxNcw4JBE8=;
 b=NHrw/7QcMAl0Sv/X9qCvbBJ3BxTqKDCfDGwPT9TNWVFMFvHIQ5J4Kz0cjcRM+Bxy1yyJ9jpfY+0ZEqTPe0uC0fTuw/NUlSArQCL6uXXA0IxlP2aKvsTguiQxtENczwKlBf2rlOsvo5IhJdEy0hZVt2WzYiExUy5dxUY93XYtXnacHK9DGfGtFMtuYI5Jx9EjVLxRY3MBKHUBUYr74NqB/U9qsCXn0Q27VVxUY2OnHQmLdn1iYbzXRArasv1v6TXgfbfBQXMD7rZoAxs8v0q0LGYjsb/0fRJwc+C64me7+gvbAXsYUXoAZUh2DXoWRUn5ugi38MbAnWCjfC6X+e4iCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 06:55:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 06:55:50 +0000
Date: Mon, 19 Feb 2024 14:55:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Taylor Jackson <taylor.a.jackson@me.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs/mnt_idmapping.c]  b4291c7fd9:
 xfstests.generic.645.fail
Message-ID: <202402191416.17ec9160-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e4b9e8-f843-4047-3d54-08dc3117cec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7H0s8mHRByh2Kez6xRxGYPw2rvUMbeuaoxoOYUJiX42I0pcrJ4kiNCLfy7yKWXdB3f1laE0aRPDVonELipkRd+v1OS1ExMCtmS1mFYwF+DewGPrexhoZp2VibTnOq1yUeIyNNo9cccmlQ2XK4beNKzXHswBr721khf4JAptKSuma3W7TbytL7uv7u/VGXAk7056/Z3rVUS9fh/ZzP9KGGT7zZwXJnSVA30w2lCqW4YpKSgzv3ztK6g0sq+x6szEa9Oavw1a8fqmd/xY5eQuvCtI7zy5lnKzg3Q0iBF+Ech6Rf4XbpGh8prMGM+j4opBfe19m0vIYtfAh57xxSUihygyAxQEvyLs7vU5K8QPEzjJfgYlnVFtxOukVHWxyxf83xW5C7Rp1y0btswRPym8vBWocQxwIANLMEI47cjfZ+OfZVYcC0hOha8QI58i1jO/bCEo+7iHkIhqnmE0YjWTlMtROJCG85eutUDVrMdWj+38Je3w7uRxkpPZEx2tGPAv19dV46xj4OFb9SFETwPN5vQz7B7uN7PHmt5J1+hM2wI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(2906002)(41300700001)(8936002)(8676002)(4326008)(38100700002)(83380400001)(82960400001)(86362001)(26005)(54906003)(107886003)(2616005)(66946007)(6506007)(6666004)(6916009)(6486002)(316002)(66556008)(478600001)(966005)(1076003)(66476007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DpN4+u+D+4jzMuazc3mK0mvPedKeJJ1XQEJtN79lyiEqbgndlvja5lslbR97?=
 =?us-ascii?Q?V9vTvJs5J8wNdJMf6MEjmikdUM1LyfAGB0kuBLbFh1/4UPDM6fHmMKz4EXDn?=
 =?us-ascii?Q?IB4pussWsr3mzbnrw/IqMwtvD3UIufr5M4aOvPouhgMdh5i3qek8v/uR2DEM?=
 =?us-ascii?Q?0pSmMXV/5frPYPZwOXVotHtOC+RtnjfetMi657jSYGLX78r96RFDZIrg6Hxs?=
 =?us-ascii?Q?HnPxM6xKa+U1IgPKxUmXWU7Xc15Kt8+kCSsJGfjeF5atmEAGJBWjVhQoLgN9?=
 =?us-ascii?Q?psvkG+5NMtIUYEFntb0ccyg9GsrjlngbnkxtJ8vS5ceJBSGH5TFevLv7lTzJ?=
 =?us-ascii?Q?ji7wZqw7Z0JtXTVgji3/hs25nzRfghwzOnnaZFEZCBmE8IYqz2wkCtSu8t6+?=
 =?us-ascii?Q?mKfuz7Si69GNToUyZn/77VF8swR+rYmHN1Semb2lFtab5BeC4fTYY1EwU7H4?=
 =?us-ascii?Q?66UIk8TppOoU9euxxmCnaQoiFAJWweVrsrJ/6NI/1MTblawOH89Qk48MCAWx?=
 =?us-ascii?Q?kFm14hpCB9m0tDB15SdWiyQhpsKHW8HYOh8bOAsaS9PF0/2iCuhSMWOgZMqG?=
 =?us-ascii?Q?r6S77IbYwN/V+cPET26faSuS8GEU2+MQA7EYTCSnyUy8Uk4czQD/nWhphVll?=
 =?us-ascii?Q?NZz/PTM9kB9wUuKCYoKTopKQa0wBEfEw1dCZIULSu5X+W6ywELO9ejWl8xV/?=
 =?us-ascii?Q?8k9ARNDZtuOp7N9vKQHJ1PaX/mP0paAYVhtH3JfmRaO4ot95DowlWRA1Rmyz?=
 =?us-ascii?Q?ya377mcaXzoRzNPu5iC0J6U5RC91mM1iG2SkA7OEYL8+h9l9J/LATOL5r/+t?=
 =?us-ascii?Q?XHMnIRycUWySS35o6WgD0+k7+iRGVHhpf7yMZ/MIsJqPhrzj7LsJOQX9wOLA?=
 =?us-ascii?Q?P1qZex1JmCYPh/G1wS+0wPItKnDKB+5REsxaSRPsN5XmXlRCK+h3Ciy/4zNv?=
 =?us-ascii?Q?Uqq6C9PqOTsl1x2qa/LFDKfOMerRLmljAHUQVBgJ4HFLVo7oCbeIekQ+ydzI?=
 =?us-ascii?Q?ekeIKaGbTuNlF7lIqcTTN3xF94LWe9QO25hEVzz1KEh6xuL/TbWLQ64JFwEj?=
 =?us-ascii?Q?iWsBnMwomKMJawXYCadCcVV2/RWRwhKve10Bpp8eRdS6DtH9mJaxw5jIgEtG?=
 =?us-ascii?Q?rCXl9h5ey77z5excsT3cGbv5cHgTgyB7fwxha5TN6GHoFtbuqgvmXu5Bf+Pv?=
 =?us-ascii?Q?axpU2xoXcfrnpOiMogD2H8IMIRBVPJN4yY32cidWT1XEv8ehquq/nKfBBFe1?=
 =?us-ascii?Q?MYmwrAAm2+kTgZ9nbRHp56f5n8C9bc3nTAkPeumHJJY+ohOj0QSBYswO8ptL?=
 =?us-ascii?Q?oOQ2Rb1SVw4IZolvEl3xUzOYZABQ3KaBrv8of2NiAZKkNg1l9HiUUBvkB3qn?=
 =?us-ascii?Q?u2cSQpyOEcjmQDTlzwdkvvwmlRGQZQPPdR9nxZgO+BkBQclfnazMufNYPl8/?=
 =?us-ascii?Q?RA/n7Cxc2SEWnwkL2IK2U3q1oGzwqVFTex/4XQHg8N9gJSVit6zxVlqAoSXS?=
 =?us-ascii?Q?WfGRhLxJlx7ZysO9Va0sDf0RWIV54+xd7EPBHnmWM1bARoagkOlYTXhVRybT?=
 =?us-ascii?Q?CAKOtmN+63NO4iIaHgKinyMtT0fVGtTcbZBO/3Ip5zalunTCVmGfkoaArRFa?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e4b9e8-f843-4047-3d54-08dc3117cec8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:55:50.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVQ/9A9ATJLtBSSRP/zqA8HfmMhlvsmjwtZeRp/GR0eQbc3huMcRY2i0cCdHVEIEqke7D6XW+LSsbUclWmrohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.645.fail" on:

commit: b4291c7fd9e550b91b10c3d7787b9bf5be38de67 ("fs/mnt_idmapping.c: Return -EINVAL when no map is written")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d37e1e4c52bc60578969f391fb81f947c3e83118]

in testcase: xfstests
version: xfstests-x86_64-c46ca4d1-1_20240205
with following parameters:

	disk: 4HDD
	fs: f2fs
	test: generic-645



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402191416.17ec9160-oliver.sang@intel.com

2024-02-17 15:04:19 export TEST_DIR=/fs/sda1
2024-02-17 15:04:19 export TEST_DEV=/dev/sda1
2024-02-17 15:04:19 export FSTYP=f2fs
2024-02-17 15:04:19 export SCRATCH_MNT=/fs/scratch
2024-02-17 15:04:19 mkdir /fs/scratch -p
2024-02-17 15:04:19 export SCRATCH_DEV=/dev/sda4
2024-02-17 15:04:19 export MKFS_OPTIONS=-f
2024-02-17 15:04:19 echo generic/645
2024-02-17 15:04:19 ./check generic/645
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.8.0-rc1-00033-gb4291c7fd9e5 #1 SMP PREEMPT_DYNAMIC Sat Feb 17 22:11:35 CST 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/645       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/645.out.bad)
    --- tests/generic/645.out	2024-02-05 17:37:40.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/645.out.bad	2024-02-17 15:07:42.613312168 +0000
    @@ -1,2 +1,4 @@
     QA output created by 645
     Silence is golden
    +idmapped-mounts.c: 6671: nested_userns - Invalid argument - failure: sys_mount_setattr
    +vfstest.c: 2418: run_test - Invalid argument - failure: test that nested user namespaces behave correctly when attached to idmapped mounts
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/645.out /lkp/benchmarks/xfstests/results//generic/645.out.bad'  to see the entire diff)
Ran: generic/645
Failures: generic/645
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240219/202402191416.17ec9160-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


