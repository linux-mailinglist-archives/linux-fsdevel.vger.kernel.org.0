Return-Path: <linux-fsdevel+bounces-2945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436DF7EDD08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0FA280FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16758D2E4;
	Thu, 16 Nov 2023 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDw6eL/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422DA1;
	Thu, 16 Nov 2023 00:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700124176; x=1731660176;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=VtHvLd+/XliXo+iLvx11nNesokYVbGT8vfD3tc5BNRQ=;
  b=kDw6eL/gPmZ7RUemp82pDjoVuo67GrkbAU3c3Htiz6j2RBZd6DfzW5rY
   lX7jbVp8aFrzqiHPx6JKWAhMDlsh/oUV8sC/kASNqn4u+0B6mSfzIu2YQ
   J7zFgNHZREyI0ZM1VoR+ItblSnBUOvre1m+bu+Yr1boxff+FVlkMYQaTg
   QwNOZxjfQCz/qSML7ElQG2exr4L6Vq7HK0p8T8yKtjaJI3sxFtvWT5z2z
   /nG3HSBtCM0VjEjUxUvQcT9AFAe3umr1qPS1Rdm35IGC9umuaZyfnbNFR
   VBfuxxevAdKzqSkSeyjtWsj9bSgGwOyR1DrtyeECppb6jFlB3UmeQXgXI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394963001"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="394963001"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="888849716"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="888849716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 00:42:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:42:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:42:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:42:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:42:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH0J5zefoIVsfi0WfVdBJamN2uw/ZYef3Fy4caugaZ8HaCRZR4V0lR8m49qMkTye7voc3TvojjG9j3WVBfTsUT55QzOa+yecpQf5qEihxa9j7IN4txve3WV+ps6zFSVDvro8u1v59w6XqO4KDLopVOtDMLEnIFKAsKrPBt47TTHfCHgoaRhnZkeFKeKlSTcSe2x9mVcMsB11OlTQMOCIPJ806yqsXq+HY2oVnSDC1oQfHjwyQQ0a6FU+FLkAphGDQYNXoO/v0cUqWyHf4IkIErYJnGdEGKmpa/CTu9lEK8G0eq/pWktsoop3m6F7dATNXIwkDXwKPW6f2CG6UXz1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmVqlMMbp9cRX84mZ203PB0/byCiP1OeVh+16zGIMu8=;
 b=XVZCVfyPqDcWATLlGa3l1+STCL/qDpSZuT+41Tn06IurPn/l/UyFSWal6JSRAXlRSowjje4+zBDwyo+6092WE/w7r/iBqr1R/u5j6f75cz047S6XosQ34SjeBY0oFjEUMqDcjHyjdRzE55O5OUFDwbkv86n3iKcpbPFyT9sr5r0obsmZSmhJ3gnucpWWQd4hazJFaJp9rnPFDaS96u5MyeNR40P4s77SggaEYOb/57AenMwtPrAH/MEp4E1ynWSu+/HLLxy28IGc8EVCz0vTBXEivi/MoIKmGClgZUX3ep3YnaF+UW4sgP1v3TyaimKDbekO5iCwOZVd/rBEfAvBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 08:42:52 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:42:51 +0000
Date: Thu, 16 Nov 2023 16:42:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<zhoujifeng@kylinos.com.cn>, <linux-kernel@vger.kernel.org>,
	<miklos@szeredi.hu>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2] fuse: Track process write operations in both direct
 and writethrough modes
Message-ID: <202311161627.5a936995-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 385d85e2-3d61-486c-dda9-08dbe6800434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o20SqHryagJ2qlbO3alXkL1cxR4Bnz8fBA0+RCB8uCsgoix7EBxa5yE0vvPIJpvQmDG8uTLcK8tJ8KlJNw1rf38s3lAU3gHa44sk08cCbUR/frjA/rbP82OjXDuriJ1IXzycumeA9/JOiDTFgk1++GgFrj+P17AvfINgRSPEiap7uXYZHW43ngvmBhLgQAUs8QSbaLo4v+tvqs7WtlyP9T2+n2AvJjSPBCPX0XvhZMH4OTYlWkYhinBP4hZ7gZyrHKF8PziLc6bD6/9Zse+4rtJ/qnO45XhHGm/JhiCfMpLb1h6Kp4V4I46sipIwYLR+Cql4E8J10iKDTmdrwiu6SH/e5itHZXxVxWUaa+BVne/a2kfud26oiZSFGIr3KSTiZ0Iipec7IA85SDOcVJckWo2chyHEd79JxNsbmAkwcu4DTsN2WEprhKnIsmJIX2pE6lglt79zsgkKboyDSk405F7ImtG1vj2CfUn12pFe6TMbxPd9lsjP9ZUdCwV3V1Co2CDFRzAdhF+0MESIvqJnCCZgh64HRq4l/3lNbRAAEl2X4TeNMaXwmWMTqlFUrOQSk0fiQLbtwWHfEQogELpvrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66556008)(66476007)(6512007)(316002)(6916009)(36756003)(66946007)(26005)(1076003)(107886003)(2616005)(966005)(478600001)(6506007)(6666004)(86362001)(5660300002)(82960400001)(38100700002)(2906002)(83380400001)(6486002)(8936002)(41300700001)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rkSx/oFC960qxpzp70tji+vs8+SHhAK+E4DHd9OpBFsR4lQMVImLLf/0wDvh?=
 =?us-ascii?Q?7AkjE2ni6iuDlJimxN/INmETTwi2I8EidmYuYwm3KRiywm+NY+JKivsnD+TH?=
 =?us-ascii?Q?qtzAA4TPoNdPiCERm9tXt6RwY7L6v9Afb7OpNU57hnN3c9UpLCRq5DbrPwo+?=
 =?us-ascii?Q?Ij6/spiqboJJPM6j2dR1pFzEnKsSWn/gl+l8dpuncr7/Y6ii/3mNFHvCxjK0?=
 =?us-ascii?Q?pD6Ez/OYwKcUm0+4Gbdf+xIs71UeZlbdM/Qt3hKfUtlpDA8gzGWMLrP6zlZ9?=
 =?us-ascii?Q?h1OtQHyFXanJxIzMOudGIouKuTYQskYqNQhd0sR3wcjybmUTOQpK2PWecljY?=
 =?us-ascii?Q?qECshkj8buPyzwPXe1Z8dIhnGyofnvhKyluknOz4Rx9+rFI8qO5a2epAAC0j?=
 =?us-ascii?Q?337hdaTdnhz/+GcJacAjEfDsiNjZbUMfRz9J+beWhj7VroIVNYkVg6+PTbpt?=
 =?us-ascii?Q?vgXRmsq9/pSrKDqWDpJGN2iWT7W5Won9QM/QNtLhKYHdHD/sY7K9oo3D1XG4?=
 =?us-ascii?Q?kN2PKjEQTe4JzEx7xNu4dngJ5lwTweSQY7t7Cyt6xSNzLpW9Q7QduL0mRxfk?=
 =?us-ascii?Q?gY3JoHblalrapGCvAAswABRwfv9VyApMxXvKPmgfADivTbmbRO8S8Oncloqy?=
 =?us-ascii?Q?PH+rnn8kw2plQ4z/7kDZ59IMTGFwNkJd9hAO3md/6hvPm3TgS05AzLxye00H?=
 =?us-ascii?Q?y+jwidXSva3D7mmz+pamVb2xj7hssUilvlFzaDa7DNW2DAyOQNYQbts89CW9?=
 =?us-ascii?Q?omA+yMHRcyJSmKdd+N48smcUrC9cUdJgF6d5LouAm8BuCEaSYvbpP7KAyP5W?=
 =?us-ascii?Q?35j+fKT9AbGEuJRpWSsHb4Z5b5c4V2DWkvSFkhpU2UNEgQnq04pxNAJ7o8fJ?=
 =?us-ascii?Q?n5h7GT2vvLYyFzjzWdFG5lZhVVv9FH22YKLTq2qUEet3RDxvCdx1zbsUXpcM?=
 =?us-ascii?Q?Db/1OLmJV7TP9bkaHH0fe6Q3rXBnM33OyoET4VLyndle2zzcaQpSVdjwQQcI?=
 =?us-ascii?Q?T7ApcG34HxjFmwVKr87AWYzPhKGWgqylXC+QZXDdo5PWtjFem/o4D90zOK2X?=
 =?us-ascii?Q?8FUVoSycBBfM1DTIIih2Wq/EWIfZN4tyn/qbNVDfyz+CPIapE7M3ccYSclE5?=
 =?us-ascii?Q?dn4YnhNEh4hYlESnnG240ijOTiq9RM9lIYUOmf+FF7C89ITwVVGQazuTM4ri?=
 =?us-ascii?Q?jDlWiRCQW+ukLOU75dDkSWaXQ3S2ezUpW1pPqMMopBUys1NoYDqv3/q3UBIr?=
 =?us-ascii?Q?gWvGMIuOuCD4SkoKNT/C+bixW0J4uzEgGNsM9etceWZgXXVznlLAVF5BREyi?=
 =?us-ascii?Q?Yyu3HAyPRNpCP2OqKBZSvNBpK128avb9Gn9XjWMorNHtEAMICvpX9sTBS8+I?=
 =?us-ascii?Q?nDOJlpe6WGd+zQJDeC28q3Znnc5otctKK2VUS2YjRJwakG8NhZU4u1KIeGM8?=
 =?us-ascii?Q?KgF8gzpZGbSBw9F3nVg17XFyrlxUJcO3NLuCOwxVOuruiHhyNDzunzaE0qxq?=
 =?us-ascii?Q?Drx7rFL2uS0xbZvIZfbOd6QRqXgXdlvYNqt+Ct6mwkE260J4ElHyT/6hoj45?=
 =?us-ascii?Q?XeUWBlt28Nvy6pB9/vXLaNqiNWVZ5zCl16VItfAuNXiqz7VnSTDc2PVzfRcG?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 385d85e2-3d61-486c-dda9-08dbe6800434
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 08:42:50.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRz8aVKwDcoS/86b06iGPiRz/BZNrMfgbo4B3g8jP19uY7Yl3cWFzEuBVyg7A51V+OvypsTFGbB4jZpX36fC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_fuse_evict_inode" on:

commit: 6772e9ddfc996544d6a22e72eddf7510ac2999fc ("[PATCH v2] fuse: Track process write operations in both direct and writethrough modes")
url: https://github.com/intel-lab-lkp/linux/commits/Zhou-Jifeng/fuse-Track-process-write-operations-in-both-direct-and-writethrough-modes/20231107-163300
base: https://git.kernel.org/cgit/linux/kernel/git/mszeredi/fuse.git for-next
patch link: https://lore.kernel.org/all/20231107081350.14472-1-zhoujifeng@kylinos.com.cn/
patch subject: [PATCH v2] fuse: Track process write operations in both direct and writethrough modes

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	fs: xfs
	test: fs-03



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311161627.5a936995-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231116/202311161627.5a936995-oliver.sang@intel.com


[  608.279527][ T5411] ==================================================================
[  608.279697][ T5411] BUG: KASAN: slab-out-of-bounds in fuse_evict_inode+0x15c/0x4a0 [fuse]
[  608.279871][ T5411] Write of size 4 at addr ffff888092af0dc8 by task fs_fill/5411
[  608.280019][ T5411] 
[  608.280082][ T5411] CPU: 1 PID: 5411 Comm: fs_fill Not tainted 6.6.0-rc2-00004-g6772e9ddfc99 #1
[  608.280252][ T5411] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
[  608.280409][ T5411] Call Trace:
[  608.280494][ T5411]  <TASK>
[  608.280570][ T5411]  dump_stack_lvl+0x36/0x50
[  608.280674][ T5411]  print_address_description+0x2c/0x3a0
[  608.280808][ T5411]  ? fuse_evict_inode+0x15c/0x4a0 [fuse]
[  608.280935][ T5411]  print_report+0xba/0x2b0
[  608.281034][ T5411]  ? kasan_addr_to_slab+0xd/0x90
[  608.281140][ T5411]  ? fuse_evict_inode+0x15c/0x4a0 [fuse]
[  608.281266][ T5411]  kasan_report+0xc7/0x100
[  608.281604][ T5411]  ? fuse_evict_inode+0x15c/0x4a0 [fuse]
[  608.281763][ T5411]  kasan_check_range+0xfc/0x1a0
[  608.281871][ T5411]  fuse_evict_inode+0x15c/0x4a0 [fuse]
[  608.281994][ T5411]  evict+0x29b/0x5e0
[  608.282086][ T5411]  ? lookup_one_qstr_excl+0x23/0x150
[  608.282201][ T5411]  do_unlinkat+0x34f/0x5a0
[  608.282300][ T5411]  ? __x64_sys_rmdir+0xf0/0xf0
[  608.282404][ T5411]  ? 0xffffffff81000000
[  608.282498][ T5411]  ? strncpy_from_user+0x6a/0x230
[  608.282611][ T5411]  ? getname_flags+0x8d/0x430
[  608.282724][ T5411]  __x64_sys_unlink+0xa9/0xf0
[  608.282827][ T5411]  do_syscall_64+0x38/0x80
[  608.282928][ T5411]  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
[  608.283052][ T5411] RIP: 0033:0x7f6ba18898a7
[  608.283574][ T5411] Code: f0 ff ff 73 01 c3 48 8b 0d 56 85 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 85 0d 00 f7 d8 64 89 01 48
[  608.283947][ T5411] RSP: 002b:00007f6ba178ae48 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[  608.284142][ T5411] RAX: ffffffffffffffda RBX: 00007f6b94000b70 RCX: 00007f6ba18898a7
[  608.284321][ T5411] RDX: 0000000000000000 RSI: 0000000000000039 RDI: 00007f6ba178ae90
[  608.284503][ T5411] RBP: 00007f6ba178ae90 R08: 0000000000000000 R09: 0000000000000073
[  608.284681][ T5411] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562b20532004
[  608.284862][ T5411] R13: 0000000000000039 R14: 0000000000000000 R15: 00007f6ba178ae90
[  608.285050][ T5411]  </TASK>
[  608.285150][ T5411] 
[  608.285237][ T5411] The buggy address belongs to the object at ffff888092af0b40
[  608.285237][ T5411]  which belongs to the cache fuse_inode of size 824
[  608.285514][ T5411] The buggy address is located 648 bytes inside of
[  608.285514][ T5411]  allocated 824-byte region [ffff888092af0b40, ffff888092af0e78)
[  608.285794][ T5411] 
[  608.285883][ T5411] The buggy address belongs to the physical page:
[  608.286036][ T5411] page:00000000c8edd8aa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x92af0
[  608.286258][ T5411] head:00000000c8edd8aa order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  608.286455][ T5411] memcg:ffff8881f087ff01
[  608.286572][ T5411] flags: 0xfffffc0000840(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
[  608.286753][ T5411] page_type: 0xffffffff()
[  608.286867][ T5411] raw: 000fffffc0000840 ffff8881019c9e00 dead000000000122 0000000000000000
[  608.287685][ T5411] raw: 0000000000000000 0000000080110011 00000001ffffffff ffff8881f087ff01
[  608.287877][ T5411] page dumped because: kasan: bad access detected
[  608.288035][ T5411] 
[  608.288121][ T5411] Memory state around the buggy address:
[  608.288261][ T5411]  ffff888092af0c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  608.288443][ T5411]  ffff888092af0d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  608.288624][ T5411] >ffff888092af0d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  608.288803][ T5411]                                               ^
[  608.288932][  T291] tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
[  608.288950][ T5411]  ffff888092af0e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  608.288953][ T5411]  ffff888092af0e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  608.288984][  T291] 
[  608.289107][ T5411] ==================================================================
[  608.289285][ T5411] Disabling lock debugging due to kernel taint

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


