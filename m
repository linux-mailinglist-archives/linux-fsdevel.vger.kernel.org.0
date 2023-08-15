Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036977C85A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjHOHML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjHOHMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:12:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E82CE;
        Tue, 15 Aug 2023 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083522; x=1723619522;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Xbdy6lvyoNmlfa08WzjyLWRfh6IWtA21tIRCKsTiq58=;
  b=S43UBuRkp/xqGpmDUTqtzbWuRKze1scIoNueC9I40DYJ9/cu2ZRQVAQ+
   EPclGbxWh6lq1vziRm22kr5bqzAnpTUyyrMTdxeUu2dLhA123P8CZtTG+
   0aUviYyJXC7GWRJ9TKog/eJCT8MCHd0c6O2n1PImq1lXKSiZaYSCMkT7x
   OYL+6fTx/xlOJNGdrjZHGIgBV21CtE3wSPcdaruC9NnxN7VR7+Za6aS5Z
   z2ArXNjYLTxpW7+lS95ZP4g8N52CDozg0PDxxmpswoc0PwuakAJbQD1Uq
   qX4bfFkZTvGA973lLo7iNr3oGY+Gh3L9Byi1e9h3dmbu2ScpkkGWDqzWA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375950712"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375950712"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847956646"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="847956646"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 00:12:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 00:12:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 00:12:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 00:12:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 00:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8cXuuRfkvzPllkTr2uTqrj28CUAGCusK0aiT6FdmsgNstRZrwRnsmJDRiMQrwyfmLx8gdJQZQ3fT0qg0eXfQI0a5KBsBHlSjHpE0URKWgZZcMNzTjwCji6KZGm/PoLb2GsspxZO7oIAGm69HtCMNQ5Nk8oRQbIkThRqhXh51Y/0JxvW9v7C8fqAH4M4Y1gHfVRc4u5hRdVt+nj0PuQPmsiB+mULzXtFcZVYgKFbGwTcRxI8I9u994mqyFuCPBaLfFL99fTDOx0nbB9jMROwFeQdV5Gd7LQuuv8sOJW8xwD78Rd45DJHACINnk3gtHEvO+ByewjlAOb7KKLhpMfVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRtYTm4f+pTbkX36fHqe0ujGo4qTZh9xtft4DG2Oyfc=;
 b=lBaTbluhBecWlbWA7ewsRaX2F5E+eQgAaCvk9lIb4rIAq7/00sg+PdiaIyq2xPH+2ztekIHeJeW7U5JrxnfsJEQnRP57WBthKah5kRYgw2gHCzYCScLw7xvl+GHdIXlbjaI++o/Cx5WSWuFAwhjP2EHoVFSk0/5UFwcUy/93N6EcKEQoLARIc+QtgRS18+IY9mkYgsfXCdFmYqzDxhyhS8m1XHTElT65ExA6RrAJue5UwymtKrDoTH8fuqyB1cB/Jr+ZY/Sup0isIl7rq/ElCwk07wm8D4pBZSgw5i+gu1tW9RqAKB5Gy8v8CJmwGHo0+lu4Rkg2p3S2xb2tlI2V0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7404.namprd11.prod.outlook.com (2603:10b6:208:430::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 07:11:57 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 07:11:56 +0000
Date:   Tue, 15 Aug 2023 15:11:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <sparclinux@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [locking]  c8afaa1b0f:  stress-ng.zero.ops_per_sec
 6.3% improvement
Message-ID: <202308151426.97be5bd8-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: f5829375-b7e0-44f6-e4d2-08db9d5ee8e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uq1y8gcV4qZLOBICuUSAK6PHtdP3W8xAUej5L9Vauo0W7wVDtAaDX4AV3OAjnPvBfjEGVDE5tQZtyB8GxCPmnG9A+ep5wYRgVaRirwoifuns0arVfQLNV0EkjjYuy0UHrGEp/u1k/Yuq+nC8W2lfwjkiP/Dws2s8kCPDlCcJ6rQoLLZUExnilQqcHXzntCgP8kRnwAGHYIIAi9CXiorUHvdnlA7qzNhe9bCT4vKeLl2Kcyy/Kngn9j/4Ssc0cSR6pwZTkcbz9a/HkaiM6HDEXzrlEpzYA2mayuFcvCYxybr725CS4LpTNmERufNQj6dJcgdIcCpjHXJ3HNo1kPF57yo09edPx65+AUr2SPFNYv5ORNaGiFhSSI/IcdOuZiwRTNlclPWfy8iApNYYh06E1JyHn8y+pAV5d2lkBXydi+5VTA6UWToWWUd0EdnLWURhlSEy2Qzax7aBEe1yNpq54K4Acd9OwexQOG+MDrygookBBJH0uXu1I711Xp9IpmPVQ4o4oNBVVJTr2x4mWbqL3CMJe6HBvtPJbhDezL095zr7UnEJq+1l4o6H7jicY39aShbal8nCjypP5IPpEZWbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(186006)(1800799006)(36756003)(7416002)(5660300002)(2906002)(30864003)(86362001)(83380400001)(316002)(6916009)(66556008)(66946007)(66476007)(38100700002)(41300700001)(1076003)(26005)(107886003)(2616005)(6512007)(6486002)(6506007)(8936002)(8676002)(6666004)(82960400001)(966005)(4326008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?e62SS0sVewWfZcmtvM1QB3bWSYhs7BDpDJ0HTm4GKvOiYK94XUD/eOM9lC?=
 =?iso-8859-1?Q?4BB3mjDBeUsYBUIGB3mE8Xe2j/qkV3PG8Nqit3T/mHlOhNnPDkia0UTNgs?=
 =?iso-8859-1?Q?/8+dQD2gZzcVUXDT3mCvwDkvtg3QaLsz0r6oQi3qo2TXWZskVU3Na1yl5J?=
 =?iso-8859-1?Q?pK9t7maCyFFTgaanjj++QOMzsDDaiEf3bpvSoVh+3hBY8QrLK1XtLBHckt?=
 =?iso-8859-1?Q?QclhnFK9YkW8mwhhJejltCND9qHGS+DwcOlPCteaGlFNaoYIMmYC91+SUz?=
 =?iso-8859-1?Q?FH08PbUGz+s4Fg+YwgFRhSV6Rf5wDifLEOpNwNr9lcixGtuggVWgyznttZ?=
 =?iso-8859-1?Q?5WtKN7kHolQ8qG/615JQrY0zWRN+f9LTRQXZShDB1g4eDlTjALimL4p25T?=
 =?iso-8859-1?Q?C4w/+dJ5dvlb5R9/93ZCSYVr/jJD8UsHCivn2FKV8tMWQseLc2taxcu411?=
 =?iso-8859-1?Q?n4svESPAvDIC5hZ0/wNjxFPU/0UM3tGP56zVvvmbgN2WCBK0pSq/Aw+eUa?=
 =?iso-8859-1?Q?kCyw5o+rkk1uiuD/hvXJ4D/WeaneWeWMjq825gZccdZdH44qOKBZtxPNSN?=
 =?iso-8859-1?Q?cc8xZt6pmrvAtAz2WFSZO9oP9KeVLCMEJVk4tYtUGnWsGN7bdlq916BRIY?=
 =?iso-8859-1?Q?rSQjNu1TN+SHJWo0YuG8wdPq+YOV8nd3BgNNsP0mXmIm63kY2ZQId07BGh?=
 =?iso-8859-1?Q?5c0ikalDCAIUC8oNMXzJEVVS0wKCx6iMJ1r1VhsX6X7qf4xvGNRgJEYc7c?=
 =?iso-8859-1?Q?HVfcOH3+SpD6OCGvgwjbNB8S+4UxLp1/vmyCA3hMX0NV9935bPMpASrXbz?=
 =?iso-8859-1?Q?FXiwkcQ49CdXyGov3pzy4jAD0y5y4Pmmca6GfHEFUCWkKiEAeY542UolbL?=
 =?iso-8859-1?Q?hMdh+vP7/oFVLCamXSMFmWPp0UD1yHRJUUJ2COIhUdwcQEIr99zQNIbAPh?=
 =?iso-8859-1?Q?JQIH6xx6tYYAskKSY6Q4eDAR/rRYQAEdTYnhjlIMu5TSaHrIpwHSlQ0i1c?=
 =?iso-8859-1?Q?4u/Y/l2kXe9jALZl4gYPw9G9dpGUKaf8EyeMDj3O7waAO+OKLMueA08OxC?=
 =?iso-8859-1?Q?q6gH3pTKUAmojvytExC8KFgV28Kk2xNqnCCOxxTJVKSDB9SqfvsZfNB8mJ?=
 =?iso-8859-1?Q?mJgZX0qKi9TDDKQbHePfa7Kbke7AG1cqsJUsyjRK9sTxcHhEVrM6HJc7xD?=
 =?iso-8859-1?Q?TprrvPB328Z52SeV0HBtyp+cZEEuU5LZH9wtW5KNDtWs4d3K81WShuNd2E?=
 =?iso-8859-1?Q?bQPrizbKljxKEN+1ifMmy/8e6s7UNXe7d6Z0GtJGB0uQoo2WFm5AW9C27p?=
 =?iso-8859-1?Q?iWDNr8ZXUkE7rtc8t13tOgkkB6b7K/YT/ANBeEf7+5IdQHrZD0dtJRm69Q?=
 =?iso-8859-1?Q?orGukTqegv4q5YnDX1abPtwD96Nz1ioknwzf3R+FMOrFvEycVNWXNV0N0a?=
 =?iso-8859-1?Q?LORv0Woaoelv+V41tBZtV43vCIKUP56ym3964+m3dpRZhGQGcOrXLmwJmf?=
 =?iso-8859-1?Q?/PxEoGSatAfNFzNrY9U6Gw2k3IvRM0lNr9wW8vO2UtkZy/wZ4vor8JGrzj?=
 =?iso-8859-1?Q?47JDohk/lylJ52HkYKHQhh1SB/SZChuUfZG6yDO5JHsx+R+aHWbJhYtkv8?=
 =?iso-8859-1?Q?J+RMuWyKYNM1IMHgCGiWY70NdxmbS58T5RdqlNKGUp1QYqo77bkYjyMQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5829375-b7e0-44f6-e4d2-08db9d5ee8e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 07:11:56.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIc2azX+dQ6hdupYtljW+OFG+ouiAj08Twv6+5lbho/syD4pJr/GG7azwzgOC1M1UThUkSpCGpcEqrqHSaYWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed a 6.3% improvement of stress-ng.zero.ops_per_sec on:


commit: c8afaa1b0f8bc93d013ab2ea6b9649958af3f1d3 ("locking: remove spin_lock_prefetch")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	class: memory
	test: zero
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230815/202308151426.97be5bd8-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/zero/stress-ng/60s

commit: 
  3feecb1b84 ("Merge tag 'char-misc-6.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")
  c8afaa1b0f ("locking: remove spin_lock_prefetch")

3feecb1b848359b1 c8afaa1b0f8bc93d013ab2ea6b9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20.98 ±  8%     +12.7%      23.65 ±  4%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     21.05 ±  8%    +803.4%     190.14 ±196%  perf-sched.total_sch_delay.max.ms
     46437            +2.4%      47564        stress-ng.time.involuntary_context_switches
  87942414            +6.3%   93441484        stress-ng.time.minor_page_faults
  21983137            +6.3%   23357886        stress-ng.zero.ops
    366380            +6.3%     389295        stress-ng.zero.ops_per_sec
    100683            +4.1%     104861 ±  2%  proc-vmstat.nr_shmem
  60215587            +6.2%   63957836        proc-vmstat.numa_hit
  60148996            +6.2%   63889951        proc-vmstat.numa_local
  22046746            +6.2%   23421583        proc-vmstat.pgactivate
  83092777            +6.3%   88309102        proc-vmstat.pgalloc_normal
  88854159            +6.1%   94276960        proc-vmstat.pgfault
  82294936            +6.3%   87489838        proc-vmstat.pgfree
  21970411            +6.3%   23344438        proc-vmstat.unevictable_pgs_culled
  21970116            +6.3%   23344165        proc-vmstat.unevictable_pgs_mlocked
  21970115            +6.3%   23344164        proc-vmstat.unevictable_pgs_munlocked
  21970113            +6.3%   23344161        proc-vmstat.unevictable_pgs_rescued
 1.455e+10            +4.2%  1.517e+10        perf-stat.i.branch-instructions
  58358654            +5.0%   61304729        perf-stat.i.branch-misses
  1.12e+08            +5.2%  1.179e+08        perf-stat.i.cache-misses
 2.569e+08            +5.1%  2.698e+08        perf-stat.i.cache-references
      3.32            -4.4%       3.17        perf-stat.i.cpi
      2031 ±  2%      -5.0%       1930 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.603e+10            +4.4%  1.674e+10        perf-stat.i.dTLB-loads
 7.449e+09            +6.1%  7.901e+09        perf-stat.i.dTLB-stores
  6.52e+10            +4.4%  6.807e+10        perf-stat.i.instructions
      0.31            +5.7%       0.33 ±  3%  perf-stat.i.ipc
    825.05            +4.8%     864.24        perf-stat.i.metric.K/sec
    598.07            +4.7%     626.06        perf-stat.i.metric.M/sec
  12910790            +4.3%   13471810        perf-stat.i.node-load-misses
   7901301 ±  2%      +5.7%    8348185        perf-stat.i.node-loads
  21890957 ±  3%      +6.9%   23410670 ±  2%  perf-stat.i.node-stores
      3.38            -4.3%       3.23        perf-stat.overall.cpi
      1964            -5.1%       1864        perf-stat.overall.cycles-between-cache-misses
      0.30            +4.5%       0.31        perf-stat.overall.ipc
 1.431e+10            +4.3%  1.493e+10        perf-stat.ps.branch-instructions
  57370846            +5.0%   60264193        perf-stat.ps.branch-misses
 1.103e+08            +5.3%   1.16e+08        perf-stat.ps.cache-misses
 2.528e+08            +5.1%  2.657e+08        perf-stat.ps.cache-references
 1.577e+10            +4.5%  1.647e+10        perf-stat.ps.dTLB-loads
  7.33e+09            +6.1%  7.776e+09        perf-stat.ps.dTLB-stores
 6.415e+10            +4.4%  6.699e+10        perf-stat.ps.instructions
  12704753            +4.4%   13259951        perf-stat.ps.node-load-misses
   7778242 ±  2%      +5.7%    8224062        perf-stat.ps.node-loads
  21539559 ±  3%      +7.0%   23044455 ±  2%  perf-stat.ps.node-stores
 4.005e+12            +5.0%  4.205e+12        perf-stat.total.instructions
     38.85            -0.8       38.07        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.dentry_kill
     39.12            -0.8       38.34        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.dentry_kill.dput
     41.16            -0.7       40.44        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
     42.07            -0.7       41.39        perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
     42.09            -0.7       41.42        perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_loop
     42.13            -0.7       41.46        perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
     42.59            -0.6       41.94        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     42.69            -0.6       42.04        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     42.77            -0.6       42.12        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.75            -0.6       42.10        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.74            -0.6       42.10        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.04            -0.4       46.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     46.97            -0.4       46.55        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     47.20            -0.4       46.79        perf-profile.calltrace.cycles-pp.__munmap
     39.35            -0.3       39.09        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.__shmem_file_setup.shmem_zero_setup
     39.08            -0.2       38.84        perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode.__shmem_file_setup
      0.60            +0.0        0.63        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.64 ±  2%      +0.0        0.66        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.62            +0.0        0.65        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
      0.64            +0.0        0.67        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.59 ±  2%      +0.0        0.62        perf-profile.calltrace.cycles-pp.shmem_alloc_inode.alloc_inode.new_inode.shmem_get_inode.__shmem_file_setup
      0.80            +0.0        0.84        perf-profile.calltrace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            +0.0        0.75        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.59 ±  2%      +0.0        0.62        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru.shmem_alloc_inode.alloc_inode.new_inode.shmem_get_inode
      0.88 ±  2%      +0.0        0.92        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.94 ±  2%      +0.0        0.98        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.82            +0.0        0.86        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range
      0.79 ±  2%      +0.0        0.84        perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.22            +0.0        1.26        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.81            +0.0        0.85        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages
      0.97            +0.1        1.02        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate
      0.63            +0.1        0.68        perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      1.07            +0.1        1.12        perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
      0.61            +0.1        0.66        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.shmem_undo_range.shmem_evict_inode.evict
      0.83 ±  2%      +0.1        0.88        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode.shmem_get_inode.__shmem_file_setup.shmem_zero_setup
      0.58            +0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      0.95 ±  3%      +0.1        1.01        perf-profile.calltrace.cycles-pp.alloc_file.alloc_file_pseudo.__shmem_file_setup.shmem_zero_setup.mmap_region
      0.61            +0.1        0.67        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.31            +0.1        1.38        perf-profile.calltrace.cycles-pp.stress_zero
      1.20            +0.1        1.27        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill.dentry_kill
      1.63            +0.1        1.70        perf-profile.calltrace.cycles-pp.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.do_syscall_64
      1.37            +0.1        1.44        perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.__dentry_kill.dentry_kill.dput
      0.95 ±  2%      +0.1        1.02        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.32 ±  3%      +0.1        1.40        perf-profile.calltrace.cycles-pp.alloc_file_pseudo.__shmem_file_setup.shmem_zero_setup.mmap_region.do_mmap
      1.82 ±  2%      +0.1        1.93        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.18            +0.1        2.32        perf-profile.calltrace.cycles-pp.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.35            +0.1        2.49        perf-profile.calltrace.cycles-pp.__mm_populate.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.34 ± 70%      +0.2        0.52        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      3.82            +0.2        4.03        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      4.01 ±  2%      +0.2        4.23        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.16 ±  2%      +0.2        4.39        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      4.17 ±  2%      +0.2        4.40        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     50.50            +0.3       50.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     50.40            +0.3       50.70        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     50.53            +0.3       50.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     50.71            +0.3       51.02        perf-profile.calltrace.cycles-pp.__mmap
     78.82            -1.0       77.78        perf-profile.children.cycles-pp._raw_spin_lock
     78.20            -0.9       77.29        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     41.17            -0.7       40.44        perf-profile.children.cycles-pp.evict
     42.07            -0.7       41.39        perf-profile.children.cycles-pp.__dentry_kill
     42.10            -0.7       41.42        perf-profile.children.cycles-pp.dentry_kill
     42.13            -0.7       41.46        perf-profile.children.cycles-pp.dput
     42.70            -0.6       42.05        perf-profile.children.cycles-pp.task_work_run
     42.60            -0.6       41.95        perf-profile.children.cycles-pp.__fput
     42.84            -0.6       42.20        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     42.78            -0.6       42.14        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     42.74            -0.6       42.10        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     47.25            -0.4       46.85        perf-profile.children.cycles-pp.__munmap
     39.36            -0.3       39.10        perf-profile.children.cycles-pp.inode_sb_list_add
     40.21            -0.2       40.01        perf-profile.children.cycles-pp.new_inode
     40.58            -0.2       40.38        perf-profile.children.cycles-pp.shmem_get_inode
     97.92            -0.1       97.83        perf-profile.children.cycles-pp.do_syscall_64
     98.05            -0.1       97.96        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15 ±  2%      +0.0        0.16        perf-profile.children.cycles-pp.mas_prev_slot
      0.19 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.ksys_read
      0.14 ±  4%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.inode_init_owner
      0.20 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.errseq_sample
      0.35            +0.0        0.37        perf-profile.children.cycles-pp.shmem_get_unmapped_area
      0.46            +0.0        0.48        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.48            +0.0        0.50        perf-profile.children.cycles-pp.__destroy_inode
      0.22            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.49            +0.0        0.51        perf-profile.children.cycles-pp.destroy_inode
      0.49 ±  2%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.25 ±  3%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__munlock_folio
      0.64            +0.0        0.66        perf-profile.children.cycles-pp.shmem_fault
      0.50 ±  2%      +0.0        0.53        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.63            +0.0        0.66        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.22 ±  4%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.inode_init_always
      0.24 ±  3%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.61 ±  2%      +0.0        0.64        perf-profile.children.cycles-pp.perf_iterate_sb
      0.65            +0.0        0.68        perf-profile.children.cycles-pp.vm_unmapped_area
      0.29 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.clear_nlink
      0.64            +0.0        0.68        perf-profile.children.cycles-pp.__do_fault
      0.73            +0.0        0.76        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.20 ±  4%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.folio_lruvec_lock_irq
      0.36 ±  2%      +0.0        0.40        perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.20 ±  8%      +0.0        0.24 ±  9%  perf-profile.children.cycles-pp.free_unref_page
      0.18 ±  9%      +0.0        0.21 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.80            +0.0        0.84        perf-profile.children.cycles-pp.get_unmapped_area
      1.23            +0.0        1.27        perf-profile.children.cycles-pp.mas_store_prealloc
      0.88 ±  2%      +0.0        0.92        perf-profile.children.cycles-pp.___slab_alloc
      1.14            +0.0        1.18        perf-profile.children.cycles-pp.mas_wr_node_store
      0.94 ±  2%      +0.0        0.98        perf-profile.children.cycles-pp.perf_event_mmap
      0.89 ±  2%      +0.0        0.93        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.82            +0.0        0.86        perf-profile.children.cycles-pp.do_read_fault
      0.80 ±  2%      +0.0        0.84        perf-profile.children.cycles-pp.vm_area_alloc
      0.82            +0.0        0.86        perf-profile.children.cycles-pp.do_fault
      0.41 ±  2%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.mlock_drain_local
      1.16            +0.0        1.21        perf-profile.children.cycles-pp.mas_wr_modify
      0.44            +0.0        0.49 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.40 ±  2%      +0.0        0.45        perf-profile.children.cycles-pp.mlock_folio_batch
      0.63 ±  2%      +0.0        0.68        perf-profile.children.cycles-pp.__folio_batch_release
      0.82 ±  2%      +0.0        0.86        perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.fput
      0.98            +0.1        1.03        perf-profile.children.cycles-pp.__handle_mm_fault
      1.07            +0.1        1.13        perf-profile.children.cycles-pp.handle_mm_fault
      0.83 ±  2%      +0.1        0.89        perf-profile.children.cycles-pp.alloc_inode
      0.73 ±  2%      +0.1        0.78        perf-profile.children.cycles-pp.release_pages
      0.58            +0.1        0.64        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.96 ±  2%      +0.1        1.02        perf-profile.children.cycles-pp.alloc_file
      0.61            +0.1        0.67        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      1.34 ±  2%      +0.1        1.40        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.33            +0.1        1.40        perf-profile.children.cycles-pp.stress_zero
      1.21            +0.1        1.28        perf-profile.children.cycles-pp.shmem_undo_range
      0.95 ±  2%      +0.1        1.02        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.64            +0.1        1.71        perf-profile.children.cycles-pp.__get_user_pages
      1.38            +0.1        1.45        perf-profile.children.cycles-pp.shmem_evict_inode
      0.68            +0.1        0.76 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.72            +0.1        0.80 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
      1.32 ±  2%      +0.1        1.40        perf-profile.children.cycles-pp.alloc_file_pseudo
      0.49            +0.1        0.57 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.67            +0.1        0.78 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.83 ±  2%      +0.1        1.94        perf-profile.children.cycles-pp.unmap_region
      2.18            +0.1        2.32        perf-profile.children.cycles-pp.populate_vma_page_range
      2.35            +0.1        2.49        perf-profile.children.cycles-pp.__mm_populate
      3.87 ±  2%      +0.2        4.08        perf-profile.children.cycles-pp.do_vmi_align_munmap
      4.17 ±  2%      +0.2        4.39        perf-profile.children.cycles-pp.__vm_munmap
      4.19 ±  2%      +0.2        4.42        perf-profile.children.cycles-pp.do_vmi_munmap
      4.17 ±  2%      +0.2        4.40        perf-profile.children.cycles-pp.__x64_sys_munmap
     50.41            +0.3       50.71        perf-profile.children.cycles-pp.vm_mmap_pgoff
     50.75            +0.3       51.07        perf-profile.children.cycles-pp.__mmap
     75.97            -1.0       74.99        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.02 ±  2%      -0.0        0.98        perf-profile.self.cycles-pp._raw_spin_lock
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.get_random_u32
      0.19 ±  2%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mas_wr_walk
      0.18 ±  2%      +0.0        0.20        perf-profile.self.cycles-pp.memcg_list_lru_alloc
      0.19            +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.errseq_sample
      0.28 ±  2%      +0.0        0.30        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.18 ±  4%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.inode_init_always
      0.42            +0.0        0.44        perf-profile.self.cycles-pp.__destroy_inode
      0.50            +0.0        0.53 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.29 ±  2%      +0.0        0.32        perf-profile.self.cycles-pp.clear_nlink
      0.21 ±  3%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__fput
      1.31            +0.1        1.37        perf-profile.self.cycles-pp.stress_zero




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

