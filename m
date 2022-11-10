Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F26237E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 01:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiKJAEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 19:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiKJAEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:04:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726912D27;
        Wed,  9 Nov 2022 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038655; x=1699574655;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=rLMjj1g7bego1UL9ymtRYyhekWiHomryVWCjpfJwyjE=;
  b=La3xGssbr0aygwEJE95kCzZ/sfkI4AzBszdTILStipRL/YfHKJOPAPs3
   OsV2PofnU+OsYWqWXDhJDBjyDSbUAcH9AyQCwLIssEmHPczWLgaGlL7T0
   UKKfd/7gkMnWWvn1rDPfnqcFP3NOzOcDqZ9RyJMUenxWQtqHecWMCzi5X
   swokVQKndMSbwDEFjKN2XVXxgkxINiie7EbLMY/bRjStTbDE1xH/zAUsA
   +tParEBWL/aaWfT2bP/YtZrW1SJaOg2kJc42UmQK09kaVvQESun7x8F2U
   YubyhjXWfAcvYSNZZ2AoHii2SchDDJlZDvC2zgJpOBQNQnyXOuK70ZVnf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="294501013"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="xz'?scan'208";a="294501013"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:04:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631441463"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="xz'?scan'208";a="631441463"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2022 16:04:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:04:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:04:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 16:04:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 16:04:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9Q3uGTPqUy9C3u9qfulxsW2xxyBZO4N3Bmazrqy0prHwDo/3kIoqWQxZjaNuZyHRFUwIynHKiE1H7QZOOk7jzb4K3DXdmjpMtMkbaWJo7DCW6UvZxMiRDKMa7jxbmIHooPQ4YuLbRfmOB25xtAAYYTyFaDXJpruQZ7esIt06B5G+gJeK36lctxAXGr0AnolbHxX+8Oa+Ab/aARkUhbTEfrrdOWWld/V374moAcoqCRx4Py3M+nZSM0uF2M6odQwPbuPBnSOC4l/fgChey2gg4FPX7fFizyZxcUJPqD5FuFb9PGG4SKBG922my4TpSFb4ghCrYLLyu7dHfMG+6as2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieCbqGlcOeH0u8NDuaBZWUrqXYaV44AjjMUf3aIJG0U=;
 b=DDj9QVCyNwrik/PDaySQSvli2Iv5o2cCsxXBWIDYraMfMs3kRrr5H2YWYUh0dPVC4U1BNn9yZRQDR6knt30WLd3QatfWWkRNne4wffzSqOSyhSRsEDqG7xIih9++ZhPIkZZZUhnKDTw2UY3kFUYd8zi89rQ4tOqp9ZbizdJmILVZtNryR1YDLap2J1iA8xSrqIbBgHA3rMTOpFITmjZ4dCT+6fXdQ4goHjE5NC0MUVTg4rjJkDy6prcPYXFueoddsqDSqgIU3CD/HHW4oIeLyvQJx+ZZpcIzz6NqyC1b5Ery/HHHVERBuq4xlW9zyKr5Hi0P1Gcc6K2Hn5D+1MHzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 00:04:05 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:04:05 +0000
Date:   Thu, 10 Nov 2022 08:03:55 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v3 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
Message-ID: <202211092324.f48c2e93-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="r978uPbPUtykBIg/"
Content-Disposition: inline
In-Reply-To: <20221028001016.332663-3-stephen.s.brennan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL1PR11MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c28d74f-48e1-4b39-ded5-08dac2af14b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/tZrSqoyV/xW0EeHDrqwct7LYB3pHdcmzwbNeuQxx/iELlevy7CwSqOVW+LDUl7WkDMHackACTzMgrzmADq6FPZx8spYXWUX71QpPRnVyCW1jyO/d4MBqxqmbKEac8C++JhPxJXgdsijtjekGQyXYJecClUtZ1gNpmykhgboj3FxLaZ6rETJx7AAuQf2biWkcd2ruGSjB3ygOaS/F+27Arr5Bmae6OF4cYSBN3//jUmggPExLHIYs2qmK3Kw9llIGfW9NhvcSvwYy4YbVp9orbtWJG+vOpHuAZohDRZxuECpu+sRLk7PsB0HtM874CT3h5VReVgmPzEdzg6f6YT+P627oYjAs1xrVWCdQpyVXENZpB4n0ii1FFaRAO7L43q4ZhbmSW5gZvSo2zOlvifDXh+JAwU+R0CG9M6LzAGsTO/5UpvLFZPptiYl7z72WJ1cM+6kxGmKDS77DVnFYjGS8VLkM424YjSMXDWYCvvXu4Quuy8BbiCJrZFrdnmk5GO1/A4S6Acjg/n9i5S3zHX25LXwbceI3ie90hlXJ7HGvXhEed2VmXYXXSzUqI4S8JLYi8i5BlkfD9eYqDlNfd5zvAyCIhg0/U55t+w+hzzZUolHepX3Gzh3I4snNkfvueEADp7/CVYFxECQVUbMCTqJazfBDtbIERcC+FoiKaFq3C8AmMVH43x+u2moL2LX7O6tDOtBJ4ZgDf1zwJtZbL+GjgbN0+PRF0IBtxG4wiTIBZnLRvRduVDwT9Hqjtr8BcjMbbiGHTijgUyKVf1UmrNiROhSAZVr0vYYqO9VrCqmfMnSFOF3e6WCLJXJUwo2vc2ROjrL98iRuLdpM4+bGkpHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(6916009)(54906003)(316002)(6506007)(8936002)(66476007)(83380400001)(30864003)(1076003)(186003)(2616005)(5660300002)(66574015)(235185007)(2906002)(8676002)(66556008)(66946007)(44144004)(36756003)(41300700001)(6512007)(26005)(86362001)(4326008)(82960400001)(478600001)(38100700002)(6486002)(966005)(45080400002)(6666004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EsUD3HWKe+AwmK9WgJ1HJr3Hfb5EYA8W9JVxUe+9en6iUomHLC5nXvz8k8uE?=
 =?us-ascii?Q?G25UZMxlxvRjkjbzTjPNsmvvRH+iZPUSqZKOBzqCvUaLfYBbO4L1A1ICbFzn?=
 =?us-ascii?Q?aZU5jmCz7LiWxOkID4KZ5h3WQlYOC4QaG7uGD6FwkBtOW9HfQgxX84+5OSVy?=
 =?us-ascii?Q?jDyGj6QTle6ybBi9Mg37/NSX/1dXCH6tKkO9K0J/pwZEi+uFTNE9hdNVIO30?=
 =?us-ascii?Q?yGd6Q9WtQVjTo6Nqu7ZPX2oq3Dg1geO7ptiAUjRFMjGXpeSqMBW1XSucumNZ?=
 =?us-ascii?Q?vj/vwBvpLf7808Uy8tp0kDhtUWOh3jtt3wyrMsQYPC+svEDm4/SBQIcNi8aN?=
 =?us-ascii?Q?YeL4vlfwknO42KesvlbTZh7YWo+rR1sNL1OOAwR/aqPumZByrUkBYc4yH79I?=
 =?us-ascii?Q?WzY+cPFEwQDkwVTsg1Zwfvx/K16DYDbkgR7JKdj3d5vgLoBN6tCGYLzw8+Jj?=
 =?us-ascii?Q?ZKkjbUUghH/K/maYnwrGhfWE+/hKXHd9iAYLh4OZdDIW+3xP4RtEo343kA+j?=
 =?us-ascii?Q?7SCr4jYa/cuxH4y0/kJ9EUtsDCwIJ6a3XJT6R4cM+xLXjyDXKkxJRDccyNps?=
 =?us-ascii?Q?ynmRA8cep6QBdNPMdBe7Z8uEhij8M0YqdYHMGx/t77AzSt0TP7Whn3FpWSy4?=
 =?us-ascii?Q?IUF/netIiPFk/8tmopecR+vLbideAtaj9QZMi/tcUa8QjXb2jwJ8JZZqkUz4?=
 =?us-ascii?Q?h3RgkBCaNzFGQfSp+Ev9d/OWuhHuau8wTWiFWt4TgJdi/c/HXenreAtisKZi?=
 =?us-ascii?Q?ChLsocFPo+69yrfB+SfyvgA2OPNLJ9Gv6tz07ILucH2iFzrz26+rCTjZjYku?=
 =?us-ascii?Q?EbFu2WJrQ076Kssnzh2/m7eeyS5aT8ig59M5BVRYzAhPGoTXarAQSbtYO3ME?=
 =?us-ascii?Q?OpWskvISuO1PgweAbcICth2ebV9VoCrcP/e5iy/DMNApRj1dyavPidwU2O4M?=
 =?us-ascii?Q?e9EI+/JBry7YO8ce7viOaToctTqD2HxH8kninyWtK+zapGug0/4CvstY3zbv?=
 =?us-ascii?Q?6cK+1BspwyFPM5k2ZqLJkbrEX0JZ0YRlkhKjFGUlW0t/VW5BrFMEQwGImSCt?=
 =?us-ascii?Q?DJiFUy4v3QsKOHnxNPPYpWdtuzkSCsR9VPURmpMzhX+LmrKRRlh1uOr7RxIG?=
 =?us-ascii?Q?R7Bp7lPFg+1JpxMPaG8U/hH6S2TcxQylRRQcUf1Ju8dIKEtpLSvLLBQ9v74k?=
 =?us-ascii?Q?bxeePkHaeLaRhAAaoi7nTj/vzV0YlfGscKyxDVIm+TDXtz2czhBSYjDP40D8?=
 =?us-ascii?Q?deIQNCA66Cs4zbhDAhlE3PU0QWqSdAYgtuP1Xol36aGNhfUvoQtwc6P+OPtR?=
 =?us-ascii?Q?Y8Z8jw4SpEHO54vAdYv47FCJJ07sB0IbqwrLXbF2yR42PUZmPsCnU3/FqdjN?=
 =?us-ascii?Q?6lPPXVB6zWrF0yfCxs5r0sZ91HDkZkXEVi5ZYJq02SFrq6BVz2wfhUYtWLvO?=
 =?us-ascii?Q?tA/hHvl4UJrtwbQegm/JQgJr68jJ6G80A8sYIBXCQYNjXFwVksY+QI8xbLN+?=
 =?us-ascii?Q?b3nOGGBi7VlgIbKGXyc71hpVXjDvt73icfViJ98S4rHMKB8F/PAAKeo2LF8q?=
 =?us-ascii?Q?g53O0r9f0JUUzWelHLbPyTHTZX60wBP+0efSVAVCH8g+GLZU6KcTYyKoeKrH?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c28d74f-48e1-4b39-ded5-08dac2af14b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 00:04:05.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vygyC51sC/Ou2rWXvoArHnfjImbAj1zj7WR5Szk/4M/nl7v6DThCl+U9H4bdT7P4a8dlI6THbjDkiZ4K2QPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--r978uPbPUtykBIg/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Greeting,

FYI, we noticed BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c due to commit (built with gcc-11):

commit: 74b597a37f4b510772a2bab12572dd927bbd170a ("[PATCH v3 2/3] fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem")
url: https://github.com/intel-lab-lkp/linux/commits/Stephen-Brennan/fsnotify-Use-d_find_any_alias-to-get-dentry-associated-with-inode/20221028-091105
base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
patch subject: [PATCH v3 2/3] fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem

in testcase: trinity
version: trinity-x86_64-e63e4843-1_20220913
with following parameters:

	runtime: 300s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211092324.f48c2e93-oliver.sang@intel.com


[  283.143463][ T4865] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1551
[  283.148457][ T4865] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4865, name: trinity-c7
[  283.153170][ T4865] preempt_count: 1, expected: 0
[  283.157458][ T4865] CPU: 1 PID: 4865 Comm: trinity-c7 Not tainted 6.0.0-rc4-00066-g74b597a37f4b #1
[  283.162972][ T4865] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[  283.167954][ T4865] Call Trace:
[  283.172139][ T4865]  <TASK>
[ 283.175500][ T4865] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 283.178943][ T4865] __might_resched.cold (kernel/sched/core.c:9893) 
[ 283.182892][ T4865] down_write (kernel/locking/rwsem.c:1551) 
[ 283.186762][ T4865] ? down_write_killable (kernel/locking/rwsem.c:1550) 
[ 283.189986][ T4865] ? do_lock_file_wait (fs/locks.c:2553) 
[ 283.193205][ T4865] ? remove_vma (mm/mmap.c:149) 
[ 283.196860][ T4865] ? kmem_cache_free (mm/slub.c:1780 mm/slub.c:3534 mm/slub.c:3551) 
[ 283.200531][ T4865] ? shm_close (ipc/shm.c:381) 
[ 283.204199][ T4865] fsnotify_update_children_dentry_flags (include/linux/spinlock.h:349 fs/notify/fsnotify.c:150) 
[ 283.207950][ T4865] ? __fsnotify_recalc_mask (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:57 fs/notify/mark.c:177) 
[ 283.211611][ T4865] fsnotify_recalc_mask (fs/notify/mark.c:214) 
[ 283.215233][ T4865] ? fsnotify_conn_mask (fs/notify/mark.c:201) 
[ 283.218760][ T4865] ? dnotify_flush (fs/notify/dnotify/dnotify.c:179) 
[ 283.222189][ T4865] ? kmem_cache_free (mm/slub.c:1780 mm/slub.c:3534 mm/slub.c:3551) 
[ 283.225528][ T4865] ? dnotify_recalc_inode_mask (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:57 fs/notify/dnotify/dnotify.c:72) 
[ 283.228807][ T4865] dnotify_flush (fs/notify/dnotify/dnotify.c:180) 
[ 283.231957][ T4865] filp_close (fs/open.c:1425) 
[ 283.234989][ T4865] put_files_struct (fs/file.c:433 fs/file.c:447 fs/file.c:444) 
[ 283.238153][ T4865] do_exit (kernel/exit.c:791) 
[ 283.241154][ T4865] do_group_exit (kernel/exit.c:906) 
[ 283.244104][ T4865] __x64_sys_exit_group (kernel/exit.c:934) 
[ 283.247136][ T4865] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 283.252034][ T4865] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  283.256890][ T4865] RIP: 0033:0x7fcb25ee8699
[ 283.261328][ T4865] Code: Unable to access opcode bytes at RIP 0x7fcb25ee866f.

Code starting with the faulting instruction
===========================================
[  283.265148][ T4865] RSP: 002b:00007fffc51051e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[  283.268268][ T4865] RAX: ffffffffffffffda RBX: 00007fcb24882000 RCX: 00007fcb25ee8699
[  283.271388][ T4865] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[  283.274101][ T4865] RBP: 00007fcb24882000 R08: ffffffffffffff80 R09: 00007fcb25fdb240
[  283.276067][ T4865] R10: 00007fcb26008440 R11: 0000000000000206 R12: 0000000000000117
[  283.277999][ T4865] R13: 00000000000001b8 R14: 00007fcb24882058 R15: 00007fcb24882000
[  283.281274][ T4865]  </TASK>
[  283.308653][  T275] [main] kernel became tainted! (512/0) Last seed was 1931948248
[  283.308671][  T275]
[  283.318578][  T275] trinity: Detected kernel tainting. Last seed was 1931948248
[  283.318598][  T275]
[  283.326725][  T275] [main] exit_reason=7, but 7 children still running.
[  283.326741][  T275]
[  285.606969][  T275] [main] Bailing main loop because kernel became tainted..
[  285.606998][  T275]
[  285.696149][  T452] ==================================================================
[ 285.697615][ T452] BUG: KASAN: null-ptr-deref in _raw_spin_lock (include/linux/instrumented.h:101 include/linux/atomic/atomic-instrumented.h:542 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[  285.698950][  T452] Write of size 4 at addr 0000000000000058 by task trinity-main/452
[  285.700228][  T452]
[  285.701209][  T452] CPU: 0 PID: 452 Comm: trinity-main Tainted: G        W          6.0.0-rc4-00066-g74b597a37f4b #1
[  285.702599][  T452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[  285.703988][  T452] Call Trace:
[  285.705018][  T452]  <TASK>
[ 285.706003][ T452] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 285.707087][ T452] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:497) 
[ 285.708158][ T452] ? _raw_spin_lock (include/linux/instrumented.h:101 include/linux/atomic/atomic-instrumented.h:542 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 285.709231][ T452] kasan_check_range (mm/kasan/generic.c:190) 
[ 285.710311][ T452] _raw_spin_lock (include/linux/instrumented.h:101 include/linux/atomic/atomic-instrumented.h:542 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 285.711389][ T452] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 285.712490][ T452] ? d_find_any_alias (include/linux/list.h:876 fs/dcache.c:1002 fs/dcache.c:1021) 
[ 285.713575][ T452] fsnotify_update_children_dentry_flags (fs/notify/fsnotify.c:128 fs/notify/fsnotify.c:154) 
[ 285.714752][ T452] fsnotify_update_object (fs/notify/mark.c:333) 
[ 285.716178][ T452] fsnotify_put_mark (fs/notify/mark.c:372 (discriminator 2)) 
[ 285.717262][ T452] ? _atomic_dec_and_lock_irqsave (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-arch-fallback.h:1242 include/linux/atomic/atomic-arch-fallback.h:1267 include/linux/atomic/atomic-instrumented.h:608 lib/dec_and_lock.c:41) 
[ 285.718393][ T452] ? fsnotify_add_mark_list+0xc90/0xc90 
[ 285.720761][ T452] ? put_ucounts (kernel/ucount.c:211) 
[ 285.721857][ T452] ? inotify_remove_from_idr (fs/notify/inotify/inotify_user.c:511) 
[ 285.722994][ T452] fsnotify_clear_marks_by_group (include/linux/fsnotify_backend.h:266 fs/notify/mark.c:855) 
[ 285.724149][ T452] ? fsnotify_add_mark (fs/notify/mark.c:827) 
[ 285.725254][ T452] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 285.726355][ T452] ? do_wp_page (mm/memory.c:3301 mm/memory.c:3401) 
[ 285.727446][ T452] fsnotify_destroy_group (fs/notify/group.c:68) 
[ 285.728571][ T452] ? fsnotify_group_stop_queueing (fs/notify/group.c:51) 
[ 285.729719][ T452] ? locks_remove_file (arch/x86/include/asm/paravirt.h:596 arch/x86/include/asm/qspinlock.h:57 include/linux/spinlock.h:202 include/linux/spinlock_api_smp.h:142 include/linux/spinlock.h:389 fs/locks.c:2654) 
[ 285.730844][ T452] ? fcntl_setlk (fs/locks.c:2634) 
[ 285.731942][ T452] inotify_release (fs/notify/inotify/inotify_user.c:312) 
[ 285.733034][ T452] __fput (fs/file_table.c:320) 
[ 285.734087][ T452] task_work_run (kernel/task_work.c:179 (discriminator 1)) 
[ 285.735629][ T452] exit_to_user_mode_loop (include/linux/resume_user_mode.h:49 kernel/entry/common.c:169) 
[ 285.736785][ T452] exit_to_user_mode_prepare (kernel/entry/common.c:201) 
[ 285.737897][ T452] syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:27 include/linux/context_tracking_state.h:106 include/linux/context_tracking.h:41 kernel/entry/common.c:132 kernel/entry/common.c:296) 
[ 285.739000][ T452] do_syscall_64 (arch/x86/entry/common.c:87) 
[ 285.740040][ T452] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  285.741147][  T452] RIP: 0033:0x7fcb25f0c6c3
[ 285.742176][ T452] Code: e9 37 ff ff ff e8 4d e0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
All code
========
   0:	e9 37 ff ff ff       	jmpq   0xffffffffffffff3c
   5:	e8 4d e0 01 00       	callq  0x1e057
   a:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  11:	00 00 00 
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 45                	ja     0x77
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 18          	sub    $0x18,%rsp
  3b:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 45                	ja     0x4d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 18          	sub    $0x18,%rsp
  11:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  15:	e8                   	.byte 0xe8
[  285.744865][  T452] RSP: 002b:00007fffc5105bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  285.746155][  T452] RAX: 0000000000000000 RBX: 00000000000031c0 RCX: 00007fcb25f0c6c3
[  285.747456][  T452] RDX: 000055b1cd7aaf80 RSI: 000055b1cfa68000 RDI: 0000000000000111
[  285.748732][  T452] RBP: 000055b1cfa67fc0 R08: 0000000000000007 R09: 0000000000000039
[  285.749982][  T452] R10: 00007fcb26008440 R11: 0000000000000246 R12: 000000000000000c
[  285.751254][  T452] R13: 000055b1cfa68000 R14: 000055b1cfa68040 R15: 000000000000000c
[  285.752618][  T452]  </TASK>
[  285.753630][  T452] ==================================================================
[  285.754950][  T452] Disabling lock debugging due to kernel taint
[  285.756126][  T452] BUG: kernel NULL pointer dereference, address: 0000000000000058
[  285.757361][  T452] #PF: supervisor write access in kernel mode
[  285.758500][  T452] #PF: error_code(0x0002) - not-present page
[  285.759641][  T452] PGD 80000001d16fa067 P4D 80000001d16fa067 PUD 0
[  285.760811][  T452] Oops: 0002 [#1] SMP KASAN PTI
[  285.761858][  T452] CPU: 0 PID: 452 Comm: trinity-main Tainted: G    B   W          6.0.0-rc4-00066-g74b597a37f4b #1
[  285.763289][  T452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 285.764646][ T452] RIP: 0010:_raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 285.765766][ T452] Code: be 04 00 00 00 c7 44 24 20 00 00 00 00 e8 ae 63 3f fe be 04 00 00 00 48 8d 7c 24 20 e8 9f 63 3f fe ba 01 00 00 00 8b 44 24 20 <f0> 0f b1 55 00 75 29 48 b8 00 00 00 00 00 fc ff df 48 c7 04 03 00
All code
========
   0:	be 04 00 00 00       	mov    $0x4,%esi
   5:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   c:	00 
   d:	e8 ae 63 3f fe       	callq  0xfffffffffe3f63c0
  12:	be 04 00 00 00       	mov    $0x4,%esi
  17:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
  1c:	e8 9f 63 3f fe       	callq  0xfffffffffe3f63c0
  21:	ba 01 00 00 00       	mov    $0x1,%edx
  26:	8b 44 24 20          	mov    0x20(%rsp),%eax
  2a:*	f0 0f b1 55 00       	lock cmpxchg %edx,0x0(%rbp)		<-- trapping instruction
  2f:	75 29                	jne    0x5a
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df 
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	04 03                	add    $0x3,%al
	...

Code starting with the faulting instruction
===========================================
   0:	f0 0f b1 55 00       	lock cmpxchg %edx,0x0(%rbp)
   5:	75 29                	jne    0x30
   7:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   e:	fc ff df 
  11:	48                   	rex.W
  12:	c7                   	.byte 0xc7
  13:	04 03                	add    $0x3,%al
	...
[  285.768539][  T452] RSP: 0018:ffffc90000fb7ad8 EFLAGS: 00010297
[  285.769791][  T452] RAX: 0000000000000000 RBX: 1ffff920001f6f5b RCX: ffffffff834964d1
[  285.771150][  T452] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90000fb7af8
[  285.772495][  T452] RBP: 0000000000000058 R08: 0000000000000001 R09: ffffc90000fb7afb
[  285.773839][  T452] R10: fffff520001f6f5f R11: 0000000000000001 R12: ffff8881dd241d40
[  285.775201][  T452] R13: 0000000000000000 R14: ffff8881cef5bde6 R15: ffff8881cef5bde0
[  285.776555][  T452] FS:  00007fcb25fe3600(0000) GS:ffff88839d600000(0000) knlGS:0000000000000000
[  285.777961][  T452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  285.779265][  T452] CR2: 0000000000000058 CR3: 00000001d642e000 CR4: 00000000000406f0
[  285.780646][  T452] DR0: 00007fcb24182000 DR1: 0000000000000000 DR2: 0000000000000000
[  285.782004][  T452] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  285.783371][  T452] Call Trace:
[  285.784516][  T452]  <TASK>
[ 285.785622][ T452] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 285.786879][ T452] ? d_find_any_alias (include/linux/list.h:876 fs/dcache.c:1002 fs/dcache.c:1021) 
[ 285.788089][ T452] fsnotify_update_children_dentry_flags (fs/notify/fsnotify.c:128 fs/notify/fsnotify.c:154) 
[ 285.789394][ T452] fsnotify_update_object (fs/notify/mark.c:333) 
[ 285.790616][ T452] fsnotify_put_mark (fs/notify/mark.c:372 (discriminator 2)) 
[ 285.791835][ T452] ? _atomic_dec_and_lock_irqsave (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-arch-fallback.h:1242 include/linux/atomic/atomic-arch-fallback.h:1267 include/linux/atomic/atomic-instrumented.h:608 lib/dec_and_lock.c:41) 
[ 285.793096][ T452] ? fsnotify_add_mark_list+0xc90/0xc90 
[ 285.794401][ T452] ? put_ucounts (kernel/ucount.c:211) 
[ 285.795619][ T452] ? inotify_remove_from_idr (fs/notify/inotify/inotify_user.c:511) 
[ 285.796885][ T452] fsnotify_clear_marks_by_group (include/linux/fsnotify_backend.h:266 fs/notify/mark.c:855) 
[ 285.798164][ T452] ? fsnotify_add_mark (fs/notify/mark.c:827) 
[ 285.799439][ T452] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 285.800686][ T452] ? do_wp_page (mm/memory.c:3301 mm/memory.c:3401) 
[ 285.801899][ T452] fsnotify_destroy_group (fs/notify/group.c:68) 
[ 285.803161][ T452] ? fsnotify_group_stop_queueing (fs/notify/group.c:51) 
[ 285.804443][ T452] ? locks_remove_file (arch/x86/include/asm/paravirt.h:596 arch/x86/include/asm/qspinlock.h:57 include/linux/spinlock.h:202 include/linux/spinlock_api_smp.h:142 include/linux/spinlock.h:389 fs/locks.c:2654) 
[ 285.805651][ T452] ? fcntl_setlk (fs/locks.c:2634) 
[ 285.806797][ T452] inotify_release (fs/notify/inotify/inotify_user.c:312) 
[ 285.807937][ T452] __fput (fs/file_table.c:320) 
[ 285.809029][ T452] task_work_run (kernel/task_work.c:179 (discriminator 1)) 
[ 285.810138][ T452] exit_to_user_mode_loop (include/linux/resume_user_mode.h:49 kernel/entry/common.c:169) 
[ 285.811303][ T452] exit_to_user_mode_prepare (kernel/entry/common.c:201) 
[ 285.812468][ T452] syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:27 include/linux/context_tracking_state.h:106 include/linux/context_tracking.h:41 kernel/entry/common.c:132 kernel/entry/common.c:296) 
[ 285.813631][ T452] do_syscall_64 (arch/x86/entry/common.c:87) 
[ 285.814731][ T452] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  285.815922][  T452] RIP: 0033:0x7fcb25f0c6c3
[ 285.817006][ T452] Code: e9 37 ff ff ff e8 4d e0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
All code
========
   0:	e9 37 ff ff ff       	jmpq   0xffffffffffffff3c
   5:	e8 4d e0 01 00       	callq  0x1e057
   a:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  11:	00 00 00 
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 45                	ja     0x77
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 18          	sub    $0x18,%rsp
  3b:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 45                	ja     0x4d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 18          	sub    $0x18,%rsp
  11:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  15:	e8                   	.byte 0xe8
[  285.819779][  T452] RSP: 002b:00007fffc5105bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  285.821140][  T452] RAX: 0000000000000000 RBX: 00000000000031c0 RCX: 00007fcb25f0c6c3
[  285.822465][  T452] RDX: 000055b1cd7aaf80 RSI: 000055b1cfa68000 RDI: 0000000000000111
[  285.823807][  T452] RBP: 000055b1cfa67fc0 R08: 0000000000000007 R09: 0000000000000039
[  285.825104][  T452] R10: 00007fcb26008440 R11: 0000000000000246 R12: 000000000000000c
[  285.826387][  T452] R13: 000055b1cfa68000 R14: 000055b1cfa68040 R15: 000000000000000c
[  285.827658][  T452]  </TASK>
[  285.828661][  T452] Modules linked in: bridge 8021q garp stp mrp llc af_key mpls_router ip_tunnel vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci can_bcm can_raw can crypto_user ib_core nfnetlink scsi_transport_iscsi atm sctp ip6_udp_tunnel udp_tunnel libcrc32c sr_mod cdrom bochs sg drm_vram_helper drm_ttm_helper intel_rapl_msr ttm ppdev intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ata_generic rapl drm_kms_helper syscopyarea parport_pc ipmi_devintf ata_piix parport ipmi_msghandler joydev sysfillrect libata sysimgblt i2c_piix4 serio_raw fb_sys_fops drm fuse ip_tables
[  285.836095][  T452] CR2: 0000000000000058
[  285.837309][  T452] ---[ end trace 0000000000000000 ]---
[ 285.838565][ T452] RIP: 0010:_raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 285.839819][ T452] Code: be 04 00 00 00 c7 44 24 20 00 00 00 00 e8 ae 63 3f fe be 04 00 00 00 48 8d 7c 24 20 e8 9f 63 3f fe ba 01 00 00 00 8b 44 24 20 <f0> 0f b1 55 00 75 29 48 b8 00 00 00 00 00 fc ff df 48 c7 04 03 00
All code
========
   0:	be 04 00 00 00       	mov    $0x4,%esi
   5:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   c:	00 
   d:	e8 ae 63 3f fe       	callq  0xfffffffffe3f63c0
  12:	be 04 00 00 00       	mov    $0x4,%esi
  17:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
  1c:	e8 9f 63 3f fe       	callq  0xfffffffffe3f63c0
  21:	ba 01 00 00 00       	mov    $0x1,%edx
  26:	8b 44 24 20          	mov    0x20(%rsp),%eax
  2a:*	f0 0f b1 55 00       	lock cmpxchg %edx,0x0(%rbp)		<-- trapping instruction
  2f:	75 29                	jne    0x5a
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df 
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	04 03                	add    $0x3,%al
	...

Code starting with the faulting instruction
===========================================
   0:	f0 0f b1 55 00       	lock cmpxchg %edx,0x0(%rbp)
   5:	75 29                	jne    0x30
   7:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   e:	fc ff df 
  11:	48                   	rex.W
  12:	c7                   	.byte 0xc7
  13:	04 03                	add    $0x3,%al


To reproduce:

        # build kernel
	cd linux
	cp config-6.0.0-rc4-00066-g74b597a37f4b .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--r978uPbPUtykBIg/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.0.0-rc4-00066-g74b597a37f4b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--r978uPbPUtykBIg/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export nr_vm=300
	export submit_id='636bb4420b9a938d9a65aad8'
	export job_file='/lkp/jobs/scheduled/vm-meta-8/trinity-300s-debian-11.1-x86_64-20220510.cgz-74b597a37f4b510772a2bab12572dd927bbd170a-20221109-36250-3ne8eb-69.yaml'
	export id='321c60bf6d4e62414532b762e04f97909c1914f6'
	export queuer_version='/lkp/xsang/.src-20221109-211623'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export commit='74b597a37f4b510772a2bab12572dd927bbd170a'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-11-09 22:08:02 +0800'
	export _id='636bb4450b9a938d9a65ab1d'
	export _rt='/result/trinity/300s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/74b597a37f4b510772a2bab12572dd927bbd170a'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='e2b17d9f104438ddb3d4798a322bb53c48106d28'
	export base_commit='f0c4d9fc9cc9462659728d168387191387e903cc'
	export branch='linux-review/Stephen-Brennan/fsnotify-Use-d_find_any_alias-to-get-dentry-associated-with-inode/20221028-091105'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/trinity/300s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/74b597a37f4b510772a2bab12572dd927bbd170a/166'
	export scheduler_version='/lkp/lkp/.src-20221109-191645'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/300s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/74b597a37f4b510772a2bab12572dd927bbd170a/166
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/74b597a37f4b510772a2bab12572dd927bbd170a/vmlinuz-6.0.0-rc4-00066-g74b597a37f4b
branch=linux-review/Stephen-Brennan/fsnotify-Use-d_find_any_alias-to-get-dentry-associated-with-inode/20221028-091105
job=/lkp/jobs/scheduled/vm-meta-8/trinity-300s-debian-11.1-x86_64-20220510.cgz-74b597a37f4b510772a2bab12572dd927bbd170a-20221109-36250-3ne8eb-69.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=74b597a37f4b510772a2bab12572dd927bbd170a
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/74b597a37f4b510772a2bab12572dd927bbd170a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/trinity-x86_64-e63e4843-1_20220913.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-8'
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/74b597a37f4b510772a2bab12572dd927bbd170a/vmlinuz-6.0.0-rc4-00066-g74b597a37f4b'
	export dequeue_time='2022-11-09 22:15:24 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-8/trinity-300s-debian-11.1-x86_64-20220510.cgz-74b597a37f4b510772a2bab12572dd927bbd170a-20221109-36250-3ne8eb-69.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--r978uPbPUtykBIg/
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--r978uPbPUtykBIg/--
