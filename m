Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2877B216
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHNHJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 03:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjHNHJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:09:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72897E73
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691996965; x=1723532965;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=gagBAPdXwZD0GAP0fgPVmMq6TWPa9WnjQgud2Tr6Pmc=;
  b=JiCoEtqs7Z/sLfMpuijLFYK6VitPoehI+zG+HWzPkPn1tLpZlM0PAFQg
   9ueJYxdX4O8oV625OC3qEpmXWDFUncJTfPvwWH/GgucBMtl/Y83Pqfrhs
   q0jte4IyFqm9nPSalek0HXLLA7ZuKsq1QmmRkELR7+VQjBlbN+FZMVVNa
   iv3T65LjUaZzVehIZytaifEoI+tSS4KbAnpN9tByIqZ8540Su/RFwSmgc
   NP3bPL0FbwZza6g4d/RiDKIqbEg7FzNCexl+u/64CZR7bioEaU8hOo+F4
   /80YqbdEES85TE7ztsJAxiwMMHR4ZOtNr5f19gDm7mH6eQKrO3tQe2W5E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="374746492"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="374746492"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="768342837"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="768342837"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2023 00:09:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 00:09:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 00:09:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 00:09:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 00:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNf+GTq4nyvZFQRj23ncym2w7BtXOJbpa9h7OQiDL+KQOeEZiE6fvWjvY9Dq1LK16viEExZQThKdT6eLSRhh3zZWmzheHU9sKJPzg631FCZe3A16hleLus6v8wAUjV+TxJVyECJUEaWjVLixHu/2HiGT/Sf3on7OTBFREAqd5NQDvboY31ZFu0SBdHZuiuSvaxAiMILI0jrQ170UxED2bJSSKma2dwVAa58n2YZ8wtYW2O0Vn0LS2cATtdOPqRMYMkdLD+i3bxOOjo1ja4YTV176cABSnkIFXvbNiwih/VX1OHoLqIG8hAokssr/qBM8A3nJb3YVN4XxmZt09qQpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i37NQOzqU3YJR8p7ogW7aiQxJxZ38ff815SvywEDseI=;
 b=WkKeckRVLqkxpk0/htU+7m5l/fPbtwbUP6Ah8SLFPHDU6/NZYcPGPWaMsbA4tUsFirqAxXzNAuHZAWIBHlnTsboV+5e872z3V14SCRCyd/NrI5F0KUsGV3VvYDA1Z6S1r3T20bBzamSoMTda5peK01QYvwchqhtcFpVvpJtCZaLptG1KmlIsfcmXSI+ym1winDgaOzloJPn8MqIjkM5zzFYFHvh7dLsYPU8eH3uCW3v32iPNCcrfcjjPuowdOySlQk22PqDTOQNxMyaY/Rr21V1ETkzOGAg4q1hgs1bqn3bhdLQUgsWbIMJwFV8JyObj21SnaSl+r360V9t3rHFH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7285.namprd11.prod.outlook.com (2603:10b6:8:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 07:09:14 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 07:09:14 +0000
Date:   Mon, 14 Aug 2023 15:09:03 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Christian Brauner <christianvanbrauner@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.fdget_pos] [file]  3d04e89a11:
 stress-ng.seek.ops_per_sec -4.8% regression
Message-ID: <202308141149.d38fdf91-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3330b838-ef34-4fa6-c3c8-08db9c955dc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WyIPAcgjpMEUzRm6xj6LaECCxpmBeqprwbdUbbyQJ7QQUcB/SCPkMT2MvnFP1Axp0nTzFVo53akhKS9+Za4SUoHiYvIdEbjxvJ/oPuzdTruOkMvAYz/og3DxgbSGbbY0XqKCtHiBr1NO9fW3rLrufesKMJ/LtkT+RVHdSKartvK56/9Wch1MJ5NreuTTrMyDXxwV1FQV+PNKzpCErI4cZTonduoCIyTI1udFPSxhb733T1B9jfYd+cf0F+7JgbJhQh5pE6TZmzBJ1nzYF5xA+3i0jkcAehFm+76VmK8OsRE9euXcCQGQ3BcGb9CS1UAkLzNGPJBPqHkk71zKEWzHgdEU+NRDfKWvA8imVx7rFpiHVqmyXqKh0KQIpI4f5Mp0AswM2tDIJsS46xQwUwyUGe8lr+q9NfBcMkMznfi5RwiHcfKNPbzpbmkkRX1r+ZKn+T4xXrrLxjF98msjSXf4SnIxALLUVYhhe2R/K3VdoCdbAnj+4R6YsKrF8bHvH2hUaFbaBgfM0ptRYIC6zCtnXHp3J17nLHNV1OU1i7rn1eLQWn8niDp3ILw2XJkq3fTTn6D6MT9nh4olsSYSZDfww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(186006)(1800799006)(6666004)(6486002)(966005)(6506007)(82960400001)(478600001)(83380400001)(36756003)(86362001)(2906002)(6512007)(1076003)(107886003)(26005)(66946007)(2616005)(38100700002)(316002)(4326008)(8676002)(66476007)(6916009)(66556008)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?riU2qDDDgYx7B3GyZo5FJKmnsHIXXKg7fMIE9gpS3W1Tc/yXM/jXJNE+Cz?=
 =?iso-8859-1?Q?uimfAf1ZoGu6iDnTktjzsUYHYV5AhME6WWcxnIV58O/KV34f5pw4GVuMSj?=
 =?iso-8859-1?Q?6Dz4bAaoKO1X0DOyyOCFg//9Y5KvLqaCu6+dxQVaxKjjfvrNfBcLCkaoNJ?=
 =?iso-8859-1?Q?T0rQbwtJCr1SiKwTtnXpfljBvfHViIojhMpFK4pJ/QL9oOe4M6+C6bqk9r?=
 =?iso-8859-1?Q?zOtG6fzccG8OzQgu2+cJengDYTJ/MoLI4bcEK1QSwc4RdlShShYt4mw+EY?=
 =?iso-8859-1?Q?Z7e79JN0vI/skb4kpOdxcVMycsYw1u8d9dzFbnzF43N2qe3wjGNwsYKrqh?=
 =?iso-8859-1?Q?b9ss/eTf/LCa1WQwD4SLOeZzcwqVWQzvTLvAGd+9Cuj4kO9GKqhpBoGtyI?=
 =?iso-8859-1?Q?/Wf0558AeQH2T7tO5SOduADcsnTErpWvwQOF/ZU2DzlQ3AE8pAmTh+e4vR?=
 =?iso-8859-1?Q?AspK0w6QsFq8Xg5fZJsQPHmvz2oXYyolBgS2YK1bUm05uU7P1oJYLZF+S+?=
 =?iso-8859-1?Q?jjohkO8jswZHJ+s3ADuC4gFMEo5/+gA2eOSZjvaAEvsWHFyyTxTlXu2Qa4?=
 =?iso-8859-1?Q?D5qseGM9K+5Tc4yXHp50mfBrS0Blv5PPPAGv9xjaIWUlTrSuUnJywm+3bn?=
 =?iso-8859-1?Q?7wjr6jhuEv2Vj3GtnEdmkaHVHXW+tIDBWxyWCXjT8X+HQT1mXpHGn/P9gQ?=
 =?iso-8859-1?Q?INuY5gurR4qz5OCNzXgh7p8aJ7Ox3VGNrm7Wb8ZGsyZbX9MOZCyQAQkMgS?=
 =?iso-8859-1?Q?Sbs6PtTQxesrzSooctbAXRcBcTigTFjV2hMsi3ffgitwcl1ipkp8UwdJNr?=
 =?iso-8859-1?Q?J62hBwbRbltQqVzvlygYhjCT0me93J3C5p7o4NGANUPAy8IPiU99AH5SWM?=
 =?iso-8859-1?Q?tM6w6FyYhPRQ9RBv4oDA1IyjVw54xEav3aTFvLQpsOszw9OOVOg4iQGoYU?=
 =?iso-8859-1?Q?x2SdDS/3g5mAFnQbJcUVCE9mPO1XRM/XaqTliVz9Wf51lhCBrvlosrjYPJ?=
 =?iso-8859-1?Q?U7ydfYvIVtCa8RdkaDXykfgN0lK0p1BhmiYYdP/LWRZo8l+Jnco8nddcUG?=
 =?iso-8859-1?Q?7FvDUDNWgrbRjHFWez3JeQuwMuhITdb7k4XiC/p06oFWF8shn+PHqDVQMm?=
 =?iso-8859-1?Q?njT0jHYHLTA7h6U8u+pllm9fjS4KINy8KVXVfH7SgO1Bu2kZJdYP0U337M?=
 =?iso-8859-1?Q?9Nm09JUpG+y9wqGFEOzliNASLBDehiZoczClOSEMZIiOAUZ/N+bbr0zA/Y?=
 =?iso-8859-1?Q?2uaOdeait8pEHKsgoEspcijcTzLD6S/KveSK0ESnAPuLpf8Hzx+3QR0Jsy?=
 =?iso-8859-1?Q?NuAN7OcgqQoRAJDS8BJam3h6+rt8pioAvdiBAaX8lsGYcKtKkUl5bVJJU8?=
 =?iso-8859-1?Q?DHpg86Xks3awxC4B9W2VrsCt5rkmjOmXeDWfLkqSm8U5XK4xAPZLKmGS/m?=
 =?iso-8859-1?Q?EG/uCT7txIVtafH11BOWBQHONRyrZ0eLxbq0u9acnUXRUheY4j4us5qC5g?=
 =?iso-8859-1?Q?fF1dcSeIUdDvrlLTA2hjVN9iF4vcIXpkWIa+cKEQazlWCqpT4K5MM4FOaa?=
 =?iso-8859-1?Q?AqzkHZab/Se1hk5LnebMx328iBeOA5fBWv2P7lx2GjRk1H165xKF25xsFG?=
 =?iso-8859-1?Q?FLOzvCSSXPoQ90W+PVlbYifmhSfagFVp/TEJ8zjsd/y+2j4OVaxcGBjQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3330b838-ef34-4fa6-c3c8-08db9c955dc1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 07:09:14.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W93uf1vcjjundsC7zAcaHOrRnMMLSTJvGDSCKmrEsso6++LxnNiW5MUFJUpd81J99e4Nfjml//xj58DItj9EKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed a -4.8% regression of stress-ng.seek.ops_per_sec on:


commit: 3d04e89a11244255549fe838e9c6126e0e64729b ("file: don't optimize for f_count equal 1")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.fdget_pos

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	nr_threads: 1
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: seek
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308141149.d38fdf91-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230814/202308141149.d38fdf91-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/seek/stress-ng/60s

commit: 
  v6.5-rc1
  3d04e89a11 ("file: don't optimize for f_count equal 1")

        v6.5-rc1 3d04e89a11244255549fe838e9c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.35            +2.6%       2.41        iostat.cpu.system
      1.16            -6.2%       1.08        iostat.cpu.user
    163.48            +5.2%     172.02        stress-ng.seek.nanosecs_per_seek
  22830283            -4.8%   21730866        stress-ng.seek.ops
    380493            -4.8%     362170        stress-ng.seek.ops_per_sec
      1.61            -3.8%       1.55 ±  2%  perf-stat.i.MPKI
      1.32 ±  4%      -0.1        1.20 ±  3%  perf-stat.i.branch-miss-rate%
  16447081 ±  4%      -7.0%   15288768 ±  2%  perf-stat.i.branch-misses
   9058578            -3.9%    8705166        perf-stat.i.cache-references
 8.886e+08            +1.2%  8.989e+08        perf-stat.i.dTLB-stores
  10392601 ±  6%     -12.3%    9113713 ±  3%  perf-stat.i.iTLB-load-misses
    753.71 ±  4%      +9.6%     826.21 ±  4%  perf-stat.i.instructions-per-iTLB-miss
    275.76            -3.1%     267.08        perf-stat.i.metric.K/sec
      1.61            -3.7%       1.55        perf-stat.overall.MPKI
      1.43 ±  4%      -0.1        1.32 ±  2%  perf-stat.overall.branch-miss-rate%
    544.45 ±  6%     +13.4%     617.59 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
  16185644 ±  4%      -7.0%   15046357 ±  2%  perf-stat.ps.branch-misses
   8914660            -3.9%    8567102        perf-stat.ps.cache-references
 8.745e+08            +1.2%  8.846e+08        perf-stat.ps.dTLB-stores
  10227957 ±  6%     -12.3%    8969124 ±  3%  perf-stat.ps.iTLB-load-misses
     15.97 ±  5%      -2.1       13.85 ±  4%  perf-profile.calltrace.cycles-pp.ext4_llseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.43 ±  7%      -0.6        0.80 ± 12%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.12 ±  7%      -0.3        0.80 ± 12%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.llseek
      0.00            +1.7        1.66 ±  6%  perf-profile.calltrace.cycles-pp.mutex_unlock.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +2.3        2.30 ± 10%  perf-profile.calltrace.cycles-pp.mutex_lock.__fdget_pos.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.90 ±  4%      +2.4       22.28 ±  6%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      2.41 ±  5%      +2.5        4.92 ± 10%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
     16.09 ±  4%      -2.1       13.97 ±  4%  perf-profile.children.cycles-pp.ext4_llseek
      1.84 ±  4%      -0.6        1.22 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.40 ±  5%      -0.3        1.10 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.66 ±  3%      -0.2        0.45 ± 14%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.78 ±  7%      -0.2        1.57 ±  7%  perf-profile.children.cycles-pp.iomap_iter_advance
      0.51 ± 11%      -0.2        0.34 ± 14%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.__x64_sys_read
      0.00            +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.__f_unlock_pos
      0.28 ± 13%      +0.2        0.50 ± 17%  perf-profile.children.cycles-pp.rcu_all_qs
      0.56 ±  9%      +0.5        1.09 ± 12%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +2.0        1.99 ±  6%  perf-profile.children.cycles-pp.mutex_unlock
     20.08 ±  5%      +2.4       22.49 ±  6%  perf-profile.children.cycles-pp.ksys_lseek
      0.00            +2.7        2.70 ±  9%  perf-profile.children.cycles-pp.mutex_lock
      3.19 ±  5%      +2.8        6.02 ±  9%  perf-profile.children.cycles-pp.__fdget_pos
      3.39 ±  5%      -1.9        1.53 ±  2%  perf-profile.self.cycles-pp.ext4_llseek
      1.31 ±  6%      -0.3        1.00 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.74 ±  5%      -0.2        0.49 ± 14%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.57 ±  5%      -0.2        0.35 ± 16%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.46 ± 15%      -0.2        0.25 ± 10%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.76 ±  6%      -0.2        1.55 ±  6%  perf-profile.self.cycles-pp.iomap_iter_advance
      0.00            +0.1        0.12 ± 24%  perf-profile.self.cycles-pp.__x64_sys_read
      0.22 ± 16%      +0.2        0.37 ± 20%  perf-profile.self.cycles-pp.rcu_all_qs
      0.33 ±  9%      +0.3        0.67 ± 12%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +2.0        1.97 ±  6%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +2.1        2.08 ± 10%  perf-profile.self.cycles-pp.mutex_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

