Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B39725309
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 06:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjFGEu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 00:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFGEuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:50:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C311B0;
        Tue,  6 Jun 2023 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686113419; x=1717649419;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+fLpd07yME+CN2tjIBRGufwWpPox/aKQzn5QMWmvBGc=;
  b=SM8usNw0Cpuzc3arPzlth5MvkNJ3PgzKcy+g4we8UQE7LOBqepkbsPee
   MH7Y0B8TimLq1fqat88x+e26eoiKVLG1ChDxag3cLUKjqGQecf4ldC6Ih
   ouqXCaTZRh0rpHnSIjWPfokNPPdLvUt9n/97q294GSfvG5QO9eI+8TFfw
   522eSDU/r6cDfJFe+fWmt+4zDFtWTnToFu4IDfzYqygEPV4VWcrnxWJiV
   VRnh2lp68tEONZZHu0Vv1wv2tc2BdxxbDau92EF0geM8NVmWpgoxA7XKh
   mFCNPn17VK7jsij8D/J15ZUDAzTVr+UtQP7KU4zeAhUgdTH+qGSj8yU2d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341534731"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="xz'341?scan'341,208,341";a="341534731"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 21:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774365940"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="xz'341?scan'341,208,341";a="774365940"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 21:50:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 21:50:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 21:50:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 21:50:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 21:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqnLGI8weOyihXvgNFkgs/EdkmG/1spiJSsZobW+nzVrdVWk2TwVFuOP+7fyYnPdUFHxih6MQ1LT38UTA5wtSHKwqjs74ml0eHAa6hyiE9L6oQjbemjbx8g30Ix9jmMw70oImGrBEUbJBe4diyHGZ/2XZtnN0ENvXJztDUmrYMEqI/lFbrU9xZKuK+CFEl1IhncpV2DPZY4kEKO4hKYtjiYZv58XLwy/zLmp2GbVvKYVGAJtu5lhBQYBC8+j++sDQajG5I44LmVl3qskQSxV/csHyYW9EZN7qWyldDyfxq4egr5g4r8LolwiEyp3lZVE/rb3F7ycrkfo3wdoFiUoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyDl7EFhNAU4xKnb44ETMFq5+6XL6FUeRjh4u16yw70=;
 b=d3JLft8+bePUV6nJMHrv29GbBSywdfwp6iOw12ck/JCeb0FFZVAR4S7+Fea0Atmbf6THsEmTZxw+H2sYEsU3zaf3JDrPup3w9GwH+SHhkVFVZReRMzJvYiOd71wL4A6G4XM/0DGghEXiPyt0j6XLy5Of7HS0xg4EYBvbaMAszBlCc+rgd+/yoJfkWGy9t02jT9++JknsA60I4CSlI1322eGOFUp0TP++uN62i6QWLj4X2XiOdDtQzwJBSKaqvZBWtEP/En+DqgbGTNOJwiUMWoKRNPxMNfpCGw8JiWUJSBdGbdOcaJUJoGcrkmbsa71DIdE1ymSFm/S0Bh+21ai/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 04:50:10 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 04:50:09 +0000
Date:   Wed, 7 Jun 2023 12:49:55 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Kirill Tkhai <tkhai@ya.ru>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <tkhai@ya.ru>,
        <roman.gushchin@linux.dev>, <vbabka@suse.cz>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <djwong@kernel.org>, <hughd@google.com>, <paulmck@kernel.org>,
        <muchun.song@linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <zhengqi.arch@bytedance.com>,
        <david@fromorbit.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow
 part
Message-ID: <202306071000.4ad4e5ba-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="b4QVloPWdQpFKqQ+"
Content-Disposition: inline
In-Reply-To: <168599179360.70911.4102140966715923751.stgit@pro.pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f24f5ab-3877-4785-c504-08db6712ab3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MDgMjJ4f7OZEWHud2cC73vyaVc2A2mA2xOKi6g8/wF9q6uM/3wwPwBKLNY9EI3wpI7dJoIaqBoTiHNry6O6ZHHnPHGj+wimNeSINsv5qLL3um5V8/WLqJ8lWRxy/R7lelaPD1X9m0Ndt+RNiNInDqGIGlWvcOgIszXzTd2jlYMhbvpSUpr/er1YqFcrg1QC3Wb9b+Lkb5/bJl4hPS9fO9uz83vZykL09eotCU0eWhEosC/xx6+ILbyp4sKvPlXTRP4X8oe2s8rDf2zTYAYUJmcOmzkMNCVVss9HX1bDPIN/QLuXXIhLZatoKKfP5ccI4/UvdIWrkYJXJT2vb/n5Ze1Q+h8bgyqnGiyWSELMoaaF8vK6oQKeOCVctnaCq0T6bjeki4lrQqBVX0xWp5wsbKSloGAMvNZUdGZx5EeBU7k32SeW2ztme/g2uP1oSwWkDuo/KxjuYqzVM3kwSxFZ9YX1TNjRDqiV+BrswCBDZRkhB1VzOZ2ED6dBjUDdSbkIf2SBbhMEJ9ab9LZbbHssFky8BCfrmcQiAqNbozzmTmRVxlwjzA5Mw8LFCs23GW5yImqezrMGmkN0H9lfq/vqioB2uiliRBMTopiGgH1TL2f98UDNDS8YlV+J9YTMGusgHUmsog4Bau5JXg4px6tJTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(478600001)(45080400002)(6916009)(66556008)(235185007)(8936002)(8676002)(7416002)(2906002)(36756003)(5660300002)(86362001)(4326008)(66476007)(66946007)(316002)(82960400001)(38100700002)(6506007)(2616005)(1076003)(41300700001)(6512007)(107886003)(26005)(83380400001)(966005)(186003)(44144004)(6486002)(6666004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBscih/lLYLZtYpOlTY5rrtISvkkewVkm3nTEFwAlUeIDzDBLv0DX7dNwEBV?=
 =?us-ascii?Q?eA5tTpN0XMRxF5F7YBgz47vFv3aB+dCPkgAW1N2S9QVwnKqqJ04eQWFhxcCq?=
 =?us-ascii?Q?uoKl/5znHfsBbHQ7Cq9xQNWm/M0DDgH1WkoQSiVE5k5V3dxUTjJBK9MJ2XQa?=
 =?us-ascii?Q?zSi+kYkDmyYvvi2HW8mSTkR67tFjIjU4hneLtgk1gzJ7hKsm3W/1U7cZGGQf?=
 =?us-ascii?Q?lcc8d/fccKJJ4QhuL8/s7rjQfjfMuA50SbcRQASMoyWyOJBg/ykIVEnMWKlV?=
 =?us-ascii?Q?Mu2f+Ifi9B92+bqoSiGnnyXRwHIOeo85+asvdVvEHs7QTSjWRPHRKQVZ18MX?=
 =?us-ascii?Q?aTtTquE4A9gyo8pStt2dyD3QMNENWQ5GhMEjxhP8Ve656djR4+wqSi4DDFXL?=
 =?us-ascii?Q?zcbAXREEf7sW3/97bQhdLoGPiuH0r83pxJoLLMZ0xKkyl13kDN9szC6CWqNF?=
 =?us-ascii?Q?HKfQnIoI0NhLLdYV0HZ9Prrvs/LKI52D+rGdScrmmDnUnFpnAXI+hxMtW0WA?=
 =?us-ascii?Q?90OZqwHpSr9Mw0JJt1voq3doi9RobTGNmcFmjs/YsYzZBKtuhbSbpxttJ10X?=
 =?us-ascii?Q?YqgYH7jr7BGHG3MWoD757f1G8w2mv9kS8Lr3dARxsUwX5tg79yc3Ea+YxFhy?=
 =?us-ascii?Q?9vAKfqq9Lt+g6iqQbANu1J2LXTPUoDyvaJDP4tWPEQdcwUJzn3vHqgyDysMt?=
 =?us-ascii?Q?grdAIDfbijuPxQjHxgJcDy6/5+mT67fl1ATrFi6PeVX8dSOxyaU2Srwvh4t0?=
 =?us-ascii?Q?KvFRKJm8r3/GsnoLeBVjYj5myzrP2YNNp3fx0q03NltBPYWCK2GTqTA84UB+?=
 =?us-ascii?Q?qiTqNx9U/8X8i3lNvHdR5qDNy7ItVMoGUkkz126t7rMKBRWgzyHlFahrKbf2?=
 =?us-ascii?Q?qSfd4g5mqurW/+SNRfruBjEj60bHBJn87rsvjIzHYFBCVcX9jqLWcH+/FFlF?=
 =?us-ascii?Q?D0AuL7WLiimofv6gDHzKYkUEU2LN34RiPhpokWBfvpSn6gdIZx42pQ7ejtvl?=
 =?us-ascii?Q?u5/fHlH8ugj5YTRlJK5nVHsXFS/O5RuyuNIs2dTpSElNAUQ7b/AO1bVRIg3l?=
 =?us-ascii?Q?HHndSx/ohq2GX8uSzQThIscqTt9FnlxdgvG/W8LiyNgu96LyRXlSjJTgLcRg?=
 =?us-ascii?Q?zSIie13x2Jh6NEUPWOg1AK3l/9hSiSWZjJG0SPhaGSzjeLg39DFuOZUnkoTS?=
 =?us-ascii?Q?jM9OQF9mTwo3vyGZFbzeuhy/kcQPjPBNMU78ROzgTOwK555FtoNZd5+z0rvD?=
 =?us-ascii?Q?mjYUb5MQEGCbJsxEvoxfScYcxw+6JoHF+l0Pxy2Jqfwk4gPqwsjjY9dUy+88?=
 =?us-ascii?Q?MbmIYAeuh3kSob5N0GiLfJxQKnVUsdxmVby8OWYmIUlC/MIYEjLTwPOZKJfk?=
 =?us-ascii?Q?vyKb9OotsM0waWdIhx05kTwTS8MA++gJb5Pt8jwAoosjjz4xEeC2TN4KDv9s?=
 =?us-ascii?Q?r1TOP0hAwR2RtgCXgB3QpttEC5EXS/KEE6xJNYw1l6r7GGoWG21Sr6WlAVo3?=
 =?us-ascii?Q?DkD8vDFAQA3xe8V7S14MBJStswZ71cQQMGtSfPHcN9ONMBeflLEyLxNY210c?=
 =?us-ascii?Q?E9bE89dD0QED/AZzkDZD6hxPLdR/Lu0lAYfo30wXrF3/hQZdPgsNLfJW1gxM?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f24f5ab-3877-4785-c504-08db6712ab3e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 04:50:09.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqu7sKKOdb6SrEWuqyF4BO90LqlNfhQ5ui/YwUCNb29swDfrtVHxIqlNwQ/SoV/XC7q+BAD+3uU0Csn3JUmTww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--b4QVloPWdQpFKqQ+
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: 107ed33204f77282d67b90f5c37f34c4b1ec9ffb ("[PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow part")
url: https://github.com/intel-lab-lkp/linux/commits/Kirill-Tkhai/mm-vmscan-move-shrinker_debugfs_remove-before-synchronize_srcu/20230606-030419
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git f8dba31b0a826e691949cd4fdfa5c30defaac8c5
patch link: https://lore.kernel.org/all/168599179360.70911.4102140966715923751.stgit@pro.pro/
patch subject: [PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow part

in testcase: boot

compiler: clang-15
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202306071000.4ad4e5ba-oliver.sang@intel.com


[    0.538549][    T0] INFO: trying to register non-static key.
[    0.539249][    T0] The code is fine but needs lockdep annotation, or maybe
[    0.539385][    T0] you didn't initialize this object before use?
[    0.539385][    T0] turning off the locking correctness validator.
[    0.539385][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc5-00004-g107ed33204f7 #1
[    0.539385][    T0] Call Trace:
[ 0.539385][ T0] dump_stack_lvl (??:?) 
[ 0.539385][ T0] dump_stack (??:?) 
[ 0.539385][ T0] assign_lock_key (lockdep.c:?) 
[ 0.539385][ T0] register_lock_class (lockdep.c:?) 
[ 0.539385][ T0] __lock_acquire (lockdep.c:?) 
[ 0.539385][ T0] ? lock_acquire (??:?) 
[ 0.539385][ T0] ? register_shrinker_prepared (??:?) 
[ 0.539385][ T0] ? __might_resched (??:?) 
[ 0.539385][ T0] lock_acquire (??:?) 
[ 0.539385][ T0] ? register_shrinker_prepared (??:?) 
[ 0.539385][ T0] ? __might_resched (??:?) 
[ 0.539385][ T0] down_write (??:?) 
[ 0.539385][ T0] ? register_shrinker_prepared (??:?) 
[ 0.539385][ T0] register_shrinker_prepared (??:?) 
[ 0.539385][ T0] sget_fc (??:?) 
[ 0.539385][ T0] ? kill_litter_super (??:?) 
[ 0.539385][ T0] ? shmem_reconfigure (shmem.c:?) 
[ 0.539385][ T0] get_tree_nodev (??:?) 
[ 0.539385][ T0] shmem_get_tree (shmem.c:?) 
[ 0.539385][ T0] vfs_get_tree (??:?) 
[ 0.539385][ T0] vfs_kern_mount (??:?) 
[ 0.539385][ T0] kern_mount (??:?) 
[ 0.539385][ T0] shmem_init (??:?) 
[ 0.539385][ T0] mnt_init (??:?) 
[ 0.539385][ T0] vfs_caches_init (??:?) 
[ 0.539385][ T0] start_kernel (??:?) 
[ 0.539385][ T0] i386_start_kernel (??:?) 
[ 0.539385][ T0] startup_32_smp (??:?) 
[    0.539391][    T0] ------------[ cut here ]------------
[    0.540097][    T0] DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0x81d77c00, curr 0x81d77c00, list not empty
[ 0.540405][ T0] WARNING: CPU: 0 PID: 0 at kernel/locking/rwsem.c:1364 up_write (??:?) 
[    0.541389][    T0] Modules linked in:
[    0.542390][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc5-00004-g107ed33204f7 #1
[ 0.543389][ T0] EIP: up_write (??:?) 
[ 0.543920][ T0] Code: ee 8f c6 81 39 c1 74 05 bb 7f 8b c4 81 53 52 ff 74 24 08 57 ff 74 24 14 68 44 a3 cb 81 68 6d 1a ce 81 e8 32 68 fb ff 83 c4 1c <0f> 0b 39 f7 0f 85 a8 fe ff ff e9 a8 fe ff ff 0f 0b e9 db fe ff ff
All code
========
   0:	ee                   	out    %al,(%dx)
   1:	8f c6                	pop    %rsi
   3:	81 39 c1 74 05 bb    	cmpl   $0xbb0574c1,(%rcx)
   9:	7f 8b                	jg     0xffffffffffffff96
   b:	c4 81 53 52          	(bad)  
   f:	ff 74 24 08          	pushq  0x8(%rsp)
  13:	57                   	push   %rdi
  14:	ff 74 24 14          	pushq  0x14(%rsp)
  18:	68 44 a3 cb 81       	pushq  $0xffffffff81cba344
  1d:	68 6d 1a ce 81       	pushq  $0xffffffff81ce1a6d
  22:	e8 32 68 fb ff       	callq  0xfffffffffffb6859
  27:	83 c4 1c             	add    $0x1c,%esp
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	39 f7                	cmp    %esi,%edi
  2e:	0f 85 a8 fe ff ff    	jne    0xfffffffffffffedc
  34:	e9 a8 fe ff ff       	jmpq   0xfffffffffffffee1
  39:	0f 0b                	ud2    
  3b:	e9 db fe ff ff       	jmpq   0xffffffffffffff1b

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	39 f7                	cmp    %esi,%edi
   4:	0f 85 a8 fe ff ff    	jne    0xfffffffffffffeb2
   a:	e9 a8 fe ff ff       	jmpq   0xfffffffffffffeb7
   f:	0f 0b                	ud2    
  11:	e9 db fe ff ff       	jmpq   0xfffffffffffffef1
[    0.544391][    T0] EAX: e6de3575 EBX: 81c48b7f ECX: e6de3575 EDX: 81d67dd0
[    0.545388][    T0] ESI: 831f4c4c EDI: 00000000 EBP: 81d67ed0 ESP: 81d67ea8
[    0.546389][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210292
[    0.547388][    T0] CR0: 80050033 CR2: ffd98000 CR3: 02280000 CR4: 00040690
[    0.548392][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.549388][    T0] DR6: fffe0ff0 DR7: 00000400
[    0.549947][    T0] Call Trace:
[ 0.550391][ T0] ? show_regs (??:?) 
[ 0.550910][ T0] ? up_write (??:?) 
[ 0.551389][ T0] ? __warn (??:?) 
[ 0.551869][ T0] ? up_write (??:?) 
[ 0.552389][ T0] ? up_write (??:?) 
[ 0.552921][ T0] ? report_bug (??:?) 
[ 0.553390][ T0] ? exc_overflow (??:?) 
[ 0.554390][ T0] ? handle_bug (traps.c:?) 
[ 0.554923][ T0] ? exc_invalid_op (??:?) 
[ 0.555390][ T0] ? handle_exception (init_task.c:?) 
[ 0.556022][ T0] ? arch_report_meminfo (??:?) 
[ 0.556389][ T0] ? exc_overflow (??:?) 
[ 0.557389][ T0] ? up_write (??:?) 
[ 0.557927][ T0] ? exc_overflow (??:?) 
[ 0.558389][ T0] ? up_write (??:?) 
[ 0.558904][ T0] register_shrinker_prepared (??:?) 
[ 0.559390][ T0] sget_fc (??:?) 
[ 0.559887][ T0] ? kill_litter_super (??:?) 
[ 0.560390][ T0] ? shmem_reconfigure (shmem.c:?) 
[ 0.561390][ T0] get_tree_nodev (??:?) 
[ 0.562390][ T0] shmem_get_tree (shmem.c:?) 
[ 0.563390][ T0] vfs_get_tree (??:?) 
[ 0.563914][ T0] vfs_kern_mount (??:?) 
[ 0.564390][ T0] kern_mount (??:?) 
[ 0.564908][ T0] shmem_init (??:?) 
[ 0.565389][ T0] mnt_init (??:?) 
[ 0.565892][ T0] vfs_caches_init (??:?) 
[ 0.566390][ T0] start_kernel (??:?) 
[ 0.567390][ T0] i386_start_kernel (??:?) 
[ 0.568009][ T0] startup_32_smp (??:?) 
[    0.568392][    T0] irq event stamp: 1613
[ 0.568888][ T0] hardirqs last enabled at (1613): _raw_spin_unlock_irqrestore (??:?) 
[ 0.569389][ T0] hardirqs last disabled at (1612): _raw_spin_lock_irqsave (??:?) 
[ 0.570389][ T0] softirqs last enabled at (1480): do_softirq_own_stack (??:?) 
[ 0.571389][ T0] softirqs last disabled at (1473): do_softirq_own_stack (??:?) 
[    0.572389][    T0] ---[ end trace 0000000000000000 ]---
[    0.573889][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.574391][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0


To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-rc5-00004-g107ed33204f7 .config
	make HOSTCC=clang-15 CC=clang-15 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-15 CC=clang-15 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--b4QVloPWdQpFKqQ+
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc5-00004-g107ed33204f7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.4.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=150007
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=150007
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=150007
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
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
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
CONFIG_VMSPLIT_2G=y
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_RETPOLINE is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_ELAN_CPUFREQ=y
CONFIG_SC520_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=m
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
# CONFIG_X86_LONGHAUL is not set
CONFIG_X86_E_POWERSAVER=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
CONFIG_TS5500=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
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
CONFIG_ARCH_32BIT_OFF_T=y
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
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
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
CONFIG_HAS_LTO_CLANG=y
CONFIG_LTO_NONE=y
# CONFIG_LTO_CLANG_FULL is not set
# CONFIG_LTO_CLANG_THIN is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_MAX_SKB_FRAGS=17
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
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
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# Cadence-based PCIe controllers
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

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
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_CBMEM is not set
CONFIG_GOOGLE_COREBOOT_TABLE=m
CONFIG_GOOGLE_MEMCONSOLE=m
# CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
CONFIG_GOOGLE_VPD=m

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_CS5535_MFGPT is not set
# CONFIG_HI6421V600_IRQ is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
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

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=m
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
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
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
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
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
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
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
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
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
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
# CONFIG_PHYLIB is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=m
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
# CONFIG_SSIF_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_DTLK is not set
CONFIG_APPLICOM=m
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_CHT_WC is not set
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_PCA_ISA=m
CONFIG_SCx200_ACB=m
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TANGIER=m
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_TS5500=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=m
# CONFIG_GPIO_CS5535 is not set
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM8350 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_MERRIFIELD=m
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=m
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=m
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=m
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_RK817 is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_RT9467 is not set
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_MAX77620_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_SMPRO is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_MAX597X is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_CHTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS65219 is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_RSMU_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AS3711=m
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP87565=m
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=m
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6357 is not set
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT4803 is not set
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5739 is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_VCTRL=m
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8400 is not set
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_GPIO_CIR is not set
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_ITE_CIR is not set
CONFIG_IR_NUVOTON=y
CONFIG_IR_SERIAL=y
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_WINBOND_CIR=y
# CONFIG_RC_LOOPBACK is not set

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_DT3155 is not set
# CONFIG_VIDEO_IVTV is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CX18 is not set
# CONFIG_VIDEO_CX25821 is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_SAA7164 is not set

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
# CONFIG_DVB_DDBRIDGE is not set
# CONFIG_DVB_DM1105 is not set
# CONFIG_MANTIS_CORE is not set
# CONFIG_DVB_NGENE is not set
# CONFIG_DVB_PLUTO2 is not set
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
CONFIG_RADIO_ADAPTERS=m
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_SI4713=m
CONFIG_RADIO_TEA5764=m
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_TIMBERDALE is not set
CONFIG_RADIO_WL1273=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_PLATFORM_SI4713 is not set
CONFIG_I2C_SI4713=m
# CONFIG_V4L_RADIO_ISA_DRIVERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX296 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_IMX412 is not set
# CONFIG_VIDEO_IMX415 is not set
# CONFIG_VIDEO_MT9M001 is not set
CONFIG_VIDEO_MT9M111=m
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV08X40 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8858 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9282 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_ST_VGXY61 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
CONFIG_VIDEO_ADV7183=m
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_ISL7998X is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_MAX9286 is not set
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TC358746 is not set
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18212=m
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
# CONFIG_MEDIA_TUNER_TEA5767 is not set
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
# CONFIG_MEDIA_TUNER_XC5000 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
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
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
CONFIG_DRM_I915_USERPTR=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
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
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_AST is not set
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_QXL is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_DSI_CM is not set
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_EDP is not set
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_HIMAX_HX8394 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_NEWVISION_NV3051D is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SONY_TD4353_JDI is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
# CONFIG_DRM_PANEL_VISIONOX_VTDR6130 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CHIPONE_ICN6211 is not set
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NWL_MIPI_DSI is not set
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SAMSUNG_DSIM is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
# CONFIG_DRM_TI_DLPC3433 is not set
CONFIG_DRM_TI_TFP410=m
# CONFIG_DRM_TI_SN65DSI83 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=m
CONFIG_FB_GEODE_GX=y
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_SM501=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=m
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=m
# CONFIG_SND is not set
CONFIG_HID_SUPPORT=y
# CONFIG_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=m
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=m
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_SDHCI_MILBEAUT is not set
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=y
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=m
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2606MVV is not set
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_KTD2692=m
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_RT4505 is not set
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=m
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_AS3722=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX77686=y
# CONFIG_RTC_DRV_NCT3018Y is not set
# CONFIG_RTC_DRV_RK808 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=m
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_PALMAS=m
CONFIG_RTC_DRV_TPS6586X=m
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_RC5T583 is not set
# CONFIG_RTC_DRV_RC5T619 is not set
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_R7301=m

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
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_DW_AXI_DMAC is not set
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_TIMB_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_HSU_DMA_PCI=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=m
# CONFIG_LCD2S is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_HV_GENERIC=m
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
CONFIG_SURFACE_PRO3_BUTTON=y
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
# CONFIG_WMI_BMOF is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_FUJITSU_LAPTOP=m
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
CONFIG_THINKPAD_ACPI_DEBUG=y
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
# CONFIG_THINKPAD_ACPI_VIDEO is not set
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_BYTCRC_PWRSRC is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=y
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=m
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=m
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=m
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_AXI_CLKGEN=y
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_SI521XX is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_VC7 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
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
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_IOMMUFD is not set
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
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
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

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

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_INTEL_CHT_WC=m
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=m
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
# CONFIG_IIO_KX022A_I2C is not set
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=m
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=m
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=y
# CONFIG_PALMAS_GPADC is not set
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_RN5T618_ADC is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7924 is not set
# CONFIG_TI_ADS1100 is not set
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=m
# CONFIG_PMS7003 is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=m
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_TI_DAC5571 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=y
CONFIG_HDC100X=m
# CONFIG_HDC2010 is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=y
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=m
CONFIG_CM3323=y
CONFIG_CM3605=m
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
# CONFIG_ROHM_BU27034 is not set
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
# CONFIG_LTRF216A is not set
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=m
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=m
# CONFIG_TSL2591 is not set
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_TI_TMAG5273 is not set
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_T5403 is not set
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=m
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
# CONFIG_MAX30208 is not set
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CRC is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_FSL_FTM=m
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
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
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
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
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=m
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
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
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
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
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
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
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
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
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_KMSAN_COMPILER=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
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

CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
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
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--b4QVloPWdQpFKqQ+
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-i386'
	export tbox_group='vm-snb-i386'
	export branch='linux-devel/devel-catchup-20230606-033337'
	export commit='107ed33204f77282d67b90f5c37f34c4b1ec9ffb'
	export kconfig='i386-randconfig-i056-20230605'
	export nr_vm=300
	export submit_id='647f41e73239f5f996b11945'
	export job_file='/lkp/jobs/scheduled/vm-meta-322/boot-1-debian-11.1-i386-20220923.cgz-107ed33204f77282d67b90f5c37f34c4b1ec9ffb-20230606-129430-1bvs1hb-0.yaml'
	export id='3e35b971ba178a621d0377b5a9b48bae0df26065'
	export queuer_version='/zday/lkp'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23400
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='clang-15'
	export enqueue_time='2023-06-06 22:25:43 +0800'
	export _id='647f41e73239f5f996b11945'
	export _rt='/result/boot/1/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-i056-20230605/clang-15/107ed33204f77282d67b90f5c37f34c4b1ec9ffb'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-i056-20230605/clang-15/107ed33204f77282d67b90f5c37f34c4b1ec9ffb/3'
	export scheduler_version='/lkp/lkp/.src-20230606-135444'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-i056-20230605/clang-15/107ed33204f77282d67b90f5c37f34c4b1ec9ffb/3
BOOT_IMAGE=/pkg/linux/i386-randconfig-i056-20230605/clang-15/107ed33204f77282d67b90f5c37f34c4b1ec9ffb/vmlinuz-6.4.0-rc5-00004-g107ed33204f7
branch=linux-devel/devel-catchup-20230606-033337
job=/lkp/jobs/scheduled/vm-meta-322/boot-1-debian-11.1-i386-20220923.cgz-107ed33204f77282d67b90f5c37f34c4b1ec9ffb-20230606-129430-1bvs1hb-0.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-i056-20230605
commit=107ed33204f77282d67b90f5c37f34c4b1ec9ffb
initcall_debug
mem=4G
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
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
	export modules_initrd='/pkg/linux/i386-randconfig-i056-20230605/clang-15/107ed33204f77282d67b90f5c37f34c4b1ec9ffb/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export meta_host='vm-meta-322'
	export kernel='/pkg/linux/i386-randconfig-i056-20230605/clang-15/107ed33204f77282d67b90f5c37f34c4b1ec9ffb/vmlinuz-6.4.0-rc5-00004-g107ed33204f7'
	export dequeue_time='2023-06-06 23:15:47 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-322/boot-1-debian-11.1-i386-20220923.cgz-107ed33204f77282d67b90f5c37f34c4b1ec9ffb-20230606-129430-1bvs1hb-0.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--b4QVloPWdQpFKqQ+
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--b4QVloPWdQpFKqQ+--
