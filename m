Return-Path: <linux-fsdevel+bounces-2789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BF27E97BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838A41C20934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7C171D8;
	Mon, 13 Nov 2023 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BibegijC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CB1799A;
	Mon, 13 Nov 2023 08:31:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7510F5;
	Mon, 13 Nov 2023 00:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699864313; x=1731400313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hZzR1pT7d3GB/JdxyWr/kwp/ZwUZ5OQN+RNJJgrimIU=;
  b=BibegijCD11Wo4UY55fO6V+YFs75oS4SkkKOHwasQoh3Ta6/oTjm6OFG
   XQWPRJpyWQsSix7pxFnNyh1s8LvjVjMxKxcnHpQR5iQXGK7288Q6QF9+4
   5FCduB9y3kxmsyyJYz+6xnyBUiSzdwla7iuthNz5RQRHmcOPMK5NS9GiQ
   6x4/NPRjJ5ykfXMGwhldPtMdqcEdzqkmMVc+QBomLmvZElf26kfB2LCAV
   sx8gGoO8aUrinJnL+99P6dtfawtP8u0usUrp3hj+SD0zkbRsGu6bnVaiP
   OWRjbqV70JGa4s5ML2Klq+A+CSfEgOl4ECux5lL99+dk/M7mFjHUvmt59
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="394295942"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394295942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="764273849"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="764273849"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 00:31:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 00:31:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 00:31:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 00:31:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvG4U1FCd3wfsbaqMYjxxlSHivHtu+DXFsrdnttcI5kCPy5KwJWiVEEHFcmXhh/idlKMQrG8OOgISY8t6vrHp3Q8i5wa6YO0WY8GKpkIm5bB+4vWjzCYKXhxNyK/2goahnMw5TEXv1uaQqf8s8vH42fPCejATKpOX23oZcyvyE9TAToGmBniC5ScTVMmsP5482koQONYsj3JwAxFIdAarEhAGHR6p4aUZqYXYHxT75fXa7aSERx3HGMHRcfNf8L800/Mn1ASKOeFsXmJ3PdOMuawC6ujr9u4AKO5c3S13lK5kHcJ19qLMZ2V8daB41nvgvdRI7XJnkmcUaP2vSBFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRnVoMsj22my0+ZwhRQo1DLM2E2MjT47XKA4UjkPFDA=;
 b=oENVTAcfYTg1qktnywELrcS40whls6cUTyFeXAJbI+nCqflaaO6XbVl96Dj+j88Jq3eMEOy/tJJ58S+soY1VHM92TWduamyAWyjPNEQ/e6hzHvxaNP8k1D0TmD+m7jnUplHN2ye6OwPvjbRhp4dr1coXK9ja+Sau2dc1i/pXZ4aCNcNPFTLlh1BvkkNarF6G+dmxrI35RDrL0Ze5+WaN3klvdRP5JoRsEo82fpK4Qui8EO4jft79/qiM/AczVM3R7GV7oC6mV5+FXHy6eAKVFTFUerd33EapwvrtlFLdB4nGtGljCBrGJUIE4H4zi3U4yz8BHb7d5QaJlYVerLmKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 08:31:46 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 08:31:46 +0000
Date: Mon, 13 Nov 2023 16:31:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alexey Gladkov <legion@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [legion:patchset/meminfo/v2.1] [proc]  8dade3a353:
 WARNING:suspicious_RCU_usage
Message-ID: <202311131653.14708bb6-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b566bb2-6030-4757-0640-08dbe422f8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsQgq5PiG1vAOzQiaEP+gR2pU+sveZbFihEgMZI+hBQFswrTSr1poSIhidpWpxqevQRQAZwjSELC/I0i8hYCGr2e39JCtznaefEkPDYRo06W2jAe4jjcCvGciOTkYeHOmJ9JIKjQzwybDq1X3986aT0ytssy2Th0pkjNJ3EwiTeh6GGGo2OUtQq/aMFn5Dt9FI+Yg/ijXAGIHxyJvU6MI9uujuRnwMMOHxJ+eukUjnkwWe/MW1zbS2MzylxazmoEGgMUGUilD2PQP1Z3UaPcu9ri2nTlAvWj1NR4nbOLhTMZ+6gKM4NHVkvDjLunaDTrIQr4u9U2GC8qI97AHa6rN9TXvWdy/xIAxo2Xksj0nyOYgBGk814DWtYwFX9mmqZkniSYyiDB11cqiigHZ2lmXZS9vCoqYzS7pIlHXgWHrC3ig4KRCQTsWgUpOxsGz9bhU8hO6rR3aBHQruM3uzUBHTOqwfuSLApXQJqafVDfeRBIQLBRq+SanAoDQw+cmlKV4DcbJ7ZPyTxKLdex4aNwQTMlZ308cp15gowZatGdDkH3Zm6UwszKxQN45+Q0EVyG3sb08f4/zLJ0+VVl5asVt3Wk27wUpAnrAAcLtO8UGlygUuWafxH4LKsUnNA9z/8u1brmOf50nKVhH9DhTkqqhvjqsLDtme+sOh00PM5n0xL7GhhtkTasBgJnRvOeB2wZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(2616005)(107886003)(1076003)(8676002)(8936002)(4326008)(6512007)(6506007)(83380400001)(26005)(82960400001)(6666004)(6486002)(966005)(478600001)(316002)(66946007)(6916009)(66556008)(66476007)(36756003)(41300700001)(2906002)(5660300002)(86362001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekZeHa/ow196J86/K0lAfFJlgUdCve24yYXtJHmW1a/iVJMkw5wQKQ9cl5G3?=
 =?us-ascii?Q?6gnSpSiyKG3YkQf1CkdGnRl1eZ7eBmpV8wtD8zVK1+e+lr+Vk0bjhTJQOBMM?=
 =?us-ascii?Q?G4YcVVi/ToAJO4puwLHI8FN0aUVFEA11ttlUnSd815KuuLCprgfrOBX8cYEs?=
 =?us-ascii?Q?MSN+cBOdGCliLfjhdSCEFWBywhV8Wwe3eQN1pyDa55a2z331iG2eny7tsBtX?=
 =?us-ascii?Q?msSSNER5UDDQAgNOZKFmMmpiq7Cv/NYNokjZP6X/ATBZSVIbsYnCKalE17hj?=
 =?us-ascii?Q?LoOQf/X9Uu18qv1Rb2q+5YVTwYu++NhWSvoqndk02dV45V5McfICtSDNsZtB?=
 =?us-ascii?Q?JQVygXHBQWVg9CCua77qc5u94CJcK7eU/Z+uviE2LMaL1e3TCREWt23rNqUb?=
 =?us-ascii?Q?ZF2SpWf99D2/cw+0+OGtxrD1ajgeuHhR2RswIqQoS27otmXPG15BzCZvjcRT?=
 =?us-ascii?Q?HCQsb1OLq/e90p9hDkhN0Ebmdwe8kkmS7G3aj94dXFyc4scc8tqJRYIaK1kk?=
 =?us-ascii?Q?I+CCQtzKEooJ+IQUdaFkhqYVV5jZcrHYeY/cSPTpb81y+p4WRS9t3nuGTH3x?=
 =?us-ascii?Q?hiZsYXXs3j8CgTRz8KpwhxrbdX/JIHKpZj4Dterhv70j4Il7sqwKHz32QJGu?=
 =?us-ascii?Q?NEzoqxRnnWxmpNUVdmFx5SfKLFmIKkTVIA+4Ur05di9er4a+elEmizWz367n?=
 =?us-ascii?Q?uxZqXCZNzXwgE5mbYQbDMFB4ab+RqtPaFnqzMRejVJEDGa1Qpq63BgKzTk60?=
 =?us-ascii?Q?4zQ1Q+MLUoEodxfBUU8/SAQDUvEGZg7gCq/SKmJzlSQ5KhdFuAFrFfKJNp/6?=
 =?us-ascii?Q?VBWtoPH/xNOoxe32iqJQZyo8zaBWHefPBtB4CW/tECYmXCJ5xSRRM7AvNItp?=
 =?us-ascii?Q?aMxGYjr+NINozW5G/nZb1opdorMYs08ntHV5yEWsCsaDZpwDIzKYsiPI8swT?=
 =?us-ascii?Q?DMbUQj4WW1MicBEvDEelxMTaczDwIzZiW0TPAZC6SkwHAX3VakSaYPpe1wKZ?=
 =?us-ascii?Q?KmrhmEX7ErBymQOHeqQN5+AGZvblxfmouqwMcODozlltnF5QNhVVvgDg/bZZ?=
 =?us-ascii?Q?/TuYDZwcXQW637uu0d5do8XXSTn6lvPqYmtpBBtFDY7mzeeBDlrjoOBbbkxY?=
 =?us-ascii?Q?G5nVPStKH0TFf1G25iOmpDSslDHEsDQd4TZACgBkbxOgzuPFwZQtIRCmR2Un?=
 =?us-ascii?Q?plzMy+8ud8yOwl4q8569/3W9R88sDsFDqeRjixoa/Y3OYRUp1nF1JH2RbGt+?=
 =?us-ascii?Q?4hxuUECrBd3EGsayQ0+H3ik9+TTEdJV8TzYTBuzrx++JUtsGqXWdlaC/LCDq?=
 =?us-ascii?Q?Ty81zAV4SE8QHx+K6nX71NDzf582eDqs/LleVsCp7o6YsTuvgljunY355Csb?=
 =?us-ascii?Q?cnY9yej0303J5NVbJQzm/iOZ5ksf1fslaE5oKzr35pwmRet3e5nMnOgTc2La?=
 =?us-ascii?Q?o+g75BalTS3cc9c7OIAFSh6So0wnXMxEXHSiOwMWf1KFeOpH/7ABONUoEEwe?=
 =?us-ascii?Q?EYlnPE3TJ+SsDJ1dvayCDDFXSlKxWwEsNCVuiZeZGeiP1GOrP+jxU6KvvvXl?=
 =?us-ascii?Q?fGKw9xMGuiPPeR9OIDKfSsd30M8uBAcuL7ZmZAksXVqS4dRkvsH8zSt+0Js/?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b566bb2-6030-4757-0640-08dbe422f8e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 08:31:46.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syiPG5mTggH1bPevReiHKEO7Z5gdL/8aQ1boA2KO0XQeTqK+ezq1j8J78L6MzbKNWHehVmXue/D1GLp7RMni1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 8dade3a353290abfbfd3c38279c29c3c4ecd7356 ("proc: Implement /proc/self/meminfo")
https://git.kernel.org/cgit/linux/kernel/git/legion/linux.git patchset/meminfo/v2.1

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311131653.14708bb6-oliver.sang@intel.com


the issue doesn't always happen, as below, we observed it 21 times out of 50
runs, but keeps clean on parent.

        v6.6-rc7 8dade3a353290abfbfd3c38279c
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          42%          21:50    dmesg.WARNING:suspicious_RCU_usage
           :50          42%          21:50    dmesg.include/linux/cgroup.h:#suspicious_rcu_dereference_check()usage



[  366.327498][ T3447] WARNING: suspicious RCU usage
[  366.328145][ T3447] 6.6.0-rc7-00001-g8dade3a35329 #1 Not tainted
[  366.329177][ T3447] -----------------------------
[  366.329833][ T3447] include/linux/cgroup.h:436 suspicious rcu_dereference_check() usage!
[  366.330891][ T3447]
[  366.330891][ T3447] other info that might help us debug this:
[  366.330891][ T3447]
[  366.332203][ T3447]
[  366.332203][ T3447] rcu_scheduler_active = 2, debug_locks = 1
[  366.333484][ T3447] 2 locks held by trinity-c5/3447:
[ 366.334175][ T3447] #0: ffff88814ee10858 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos (fs/file.c:1066) 
[ 366.335356][ T3447] #1: ffff88814f3836c0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter (fs/seq_file.c:188) 
[  366.336736][ T3447]
[  366.336736][ T3447] stack backtrace:
[  366.337562][ T3447] CPU: 1 PID: 3447 Comm: trinity-c5 Not tainted 6.6.0-rc7-00001-g8dade3a35329 #1 10f1bfacea84478d84947570355f5fbda1b33451
[  366.339032][ T3447] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  366.340233][ T3447] Call Trace:
[  366.340701][ T3447]  <TASK>
[ 366.341175][ T3447] dump_stack_lvl (lib/dump_stack.c:107) 
[ 366.341814][ T3447] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
[ 366.342512][ T3447] mem_fill_meminfo (include/linux/cgroup.h:436 mm/memcontrol.c:4133) 
[ 366.343143][ T3447] proc_meminfo_show (fs/proc/meminfo.c:202) 
[ 366.343745][ T3447] ? meminfo_proc_show (fs/proc/meminfo.c:197) 
[ 366.344423][ T3447] ? get_pid_task (include/linux/rcupdate.h:308 include/linux/rcupdate.h:782 kernel/pid.c:458) 
[ 366.345071][ T3447] proc_single_show (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 include/linux/sched/task.h:125 fs/proc/base.c:779) 
[ 366.345750][ T3447] seq_read_iter (fs/seq_file.c:230) 
[ 366.346411][ T3447] seq_read (fs/seq_file.c:163) 
[ 366.346973][ T3447] ? seq_read_iter (fs/seq_file.c:152) 
[ 366.347621][ T3447] ? seq_read_iter (fs/seq_file.c:152) 
[ 366.348247][ T3447] do_loop_readv_writev+0x130/0x440 
[ 366.349039][ T3447] do_iter_read (fs/read_write.c:748 fs/read_write.c:797) 
[ 366.349683][ T3447] vfs_readv (fs/read_write.c:916) 
[ 366.350285][ T3447] ? vfs_iter_read (fs/read_write.c:907) 
[ 366.350879][ T3447] ? __fdget_pos (fs/file.c:1066) 
[ 366.351470][ T3447] ? mutex_lock_io_nested (kernel/locking/mutex.c:746) 
[ 366.352216][ T3447] ? preempt_count_sub (kernel/sched/core.c:5863 kernel/sched/core.c:5859 kernel/sched/core.c:5881) 
[ 366.352916][ T3447] do_readv (fs/read_write.c:952) 
[ 366.356628][ T3447] ? vfs_readv (fs/read_write.c:942) 
[ 366.357285][ T3447] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
[ 366.357972][ T3447] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
[ 366.358626][ T3447] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:122) 
[  366.359427][ T3447] RIP: 0023:0xf7f2a579
[ 366.360000][ T3447] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	cc                   	int3
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
[  366.362302][ T3447] RSP: 002b:00000000ffa75f8c EFLAGS: 00000296 ORIG_RAX: 0000000000000091
[  366.363394][ T3447] RAX: ffffffffffffffda RBX: 00000000000000f7 RCX: 00000000580da6e0
[  366.364419][ T3447] RDX: 000000000000005c RSI: 00000000710d3b51 RDI: 00000000ffffffff
[  366.365453][ T3447] RBP: 00000000ffff0100 R08: 0000000000000000 R09: 0000000000000000
[  366.366492][ T3447] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  366.367518][ T3447] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  366.368584][ T3447]  </TASK>
[  382.029705][ T3448] trinity-c6 (3448): attempted to duplicate a private mapping with mremap.  This is not supported.
[  393.577743][ T3063] [main] 10786 iterations. [F:8083 S:2663 HI:1623]



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231113/202311131653.14708bb6-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


