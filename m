Return-Path: <linux-fsdevel+bounces-3186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58397F0C97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 08:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72FC1C2105A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 07:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03B63DD;
	Mon, 20 Nov 2023 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpYFf6Ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CAACA;
	Sun, 19 Nov 2023 23:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700464305; x=1732000305;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=8MfPpg6EnfveR7hre4clJNQSoI7fbs5iLJQbPTbleOw=;
  b=OpYFf6Ek/S/zVIol+h4ZjukFMN1cpwaZOM1TOa/YyTIsuaqtnYv4EE3z
   rBwch6eS++g3BVxmitgcCELag+rE+MaaYmbf+2yJcR6aqp/LUShiQF7tk
   ma3V/11Z/mVTEVLhLTPIZKPIEEEOL+gq7CH0tvN7A6swvN3jvXamX4+RX
   XFZn5d4mBQ+9Ls8sp4a3LJqafy04krsVeCd9PnMFD3DB4n22EmvHnICxw
   MS/LegzSKPe8pxgImmaM2nbEwTZXuPxIxYT9UFGEcbJzjNxSWatCeIt80
   0DmM+/uWD6sSYEJVsm6kPop6UYtx2HPBmv7jaR7e0LoI7P4Ll4gW9V1ue
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="391348737"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="391348737"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="883770861"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="883770861"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 23:11:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 23:11:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 23:11:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 23:11:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT7GWvzqAaYujmAgsK0MmhJkUorfOnHmH9rsO0JsZ7ODlzK/5KaKoEYeYaSEB6UPrX5YkiA9TjsFi9V3qBhwnclmYlYgsFTLpT9TWIHwgWjaa/O2FeyHW0nUqazEIhdWHvG0gKHILDHLM+8sA1Li2mQO8/Se8s/jqGYRe1EtZu/W3vyXQobuO5WR6ZTTLKlPL+APUMjeMa7KpUU6WbfaVu/9bTejMhIbBssADPrUcft9CR9bH1VkemYQoP7jpf9vOTG6jsp/BejhDkNJlkbUL5Ov/dt96SgTx2V9W0JmiGc+SifqogeFv7zkNeUF2ZmYH6Al8xZkJv2mQ9g+DjFkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azFQSXFTkkVoT7Zb0XkdG5vNFg9g/leUdm1uo+UmPmU=;
 b=FAJH0gxPCmOMeLygcqwJ0TGj/yZ4Uui6s/4tZ2qLNAhROuhbALSRNf6mbXHhFHVWnTmCzHAnne8Uxyd3R/sw1atDuFF0WqjnfoPbUasKyIELDc0X8ie3Ae0cHp47S9+S/cHyPzqe4li53bQ57UYJ5PidLO9lkajWN31Z8m8Q9E6KR33acrnKduXTVA0041mg4cUp3AhExjL+k/W/QfHWyNzROio8+dSLUMNY3qmlNN0g8F/lf/nDexDCIC+hiJSuBEdtoEiq04N3K3BIV4fll400ejmzMixX9eNWm4gzT0/gTFeyLbKfakzmdF58mONdoCvWAhGiJKKqEvqIF2/QKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 07:11:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 07:11:42 +0000
Date: Mon, 20 Nov 2023 15:11:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-doc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<intel-gfx@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <bpf@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [file]  0ede61d858:  will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <202311201406.2022ca3f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f7e93c-0af9-4224-4cc4-08dbe997f229
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+/FGfnjrWeIbuVQcjRB6aSBcGzGMmx/aNRm7R5iRLwDjtQ8r/oW7DJKIZwanREWUTV18pJiszG+q45XeMoRYrgaa6NypVErpkNCb0tmJO+6/FpR/rayCsfAuvuFlrWiji1LZo2xh1avzHpZzIEbiulZAEydL99J6Fb/ZV6NOOw9SSVyOBMIay0S6LMegAd/yK81ncdl505v8oEHPJjMNZq5eIUgRINGAsUtzWynQu9agJOnPMjclF0n2pMiR2xi5UzRoTlJbq+34QVLudDmBLDxo1KjKqnFmJ/6Vq2c+Y6fWGWUxKyjbHQryFS4njKcgql+4gNRL64Sd35Mvm8XSD1mSW0Jucp8EDTdmKmnUdaumvB8IbRCo/MFZih48rd5DzsN+b+xfCRPO3RaItY8grxlmVDpUTLgsTmyVibqZothtb4q8Tg2r038HMmQRFH/PEF2c4+wQSTpnf6HzkAb10wRScAZCCxbK7hMVYFeo1Yx9T5d5In2BbUnrF+eRNjOjyKNGyAAG02JbibH1tkT4H5ZOC1zYVhO5qBc6NC6LI1+240CEU3iuF5rH2Fnt19J1uJBaMwQqYQ3z+4BzWHXls26cv3w/mh1PVMIsMvoKYe6C2dAqe0nOSPS+A4VPAV/9gfTUpaTZso9GtP7czlmoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(230473577357003)(230373577357003)(186009)(64100799003)(1800799012)(451199024)(54906003)(66556008)(66476007)(66946007)(38100700002)(36756003)(86362001)(82960400001)(6512007)(6506007)(83380400001)(26005)(1076003)(2616005)(107886003)(6666004)(966005)(6486002)(2906002)(6916009)(316002)(478600001)(8676002)(5660300002)(7416002)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zdP7vedzQPZboc5zyQ94hR7zNiruH0FmXJwF+aQ1igacheFcZ7utLrUzyu?=
 =?iso-8859-1?Q?6so06iYfOETr7L7sM2r9ngASJUpuudFDgxGExffJzre89OLmn6MDCfSP14?=
 =?iso-8859-1?Q?EEmV9KXbTHJqG1xZqmLJ53HQrM+JMZmjPyKt5lU8nnhpiXqbPAth6YrMrD?=
 =?iso-8859-1?Q?mlKVWr+iBf2HnT4TuUhr8t+fBWlNTBmrQ4vXk70jVFIzcgW8RTksPhFSdY?=
 =?iso-8859-1?Q?9QpiBGM8klgD7vJjrmG+JIdjmuPwPddCQTPJ7F1ACCYqZF5on2H+Taw5Xm?=
 =?iso-8859-1?Q?4O9GqxQR9dLRqAQnNTXnl//z6gRNR/AB+YMc41NSguu1B/AECSz0qN0mZs?=
 =?iso-8859-1?Q?kaXtCq57z5uZxQexGs58rIvodjSrmL4srFT6wy5qrJiSwX2Hm/h8rJcwJj?=
 =?iso-8859-1?Q?8jp2mB12LbA6CuWWyjRG+TeYm9IxH+VIQmJ/NgtWdNqmfzNb+zEXZn487V?=
 =?iso-8859-1?Q?FDjHbGeOrOMsvB62Qz90pkvk8ZBG5vut3zzt4yjc9GfYd0OZQN6P+/pgfq?=
 =?iso-8859-1?Q?icmWpep2EGX0Sb4/XvhNDexAcjKaFj1yRmD0cFObnAz2zlaKyNFWW0XgX/?=
 =?iso-8859-1?Q?ICykdL6wtEanP6o6/X+aEvKHehL3TLoBVyM+an/EkMLhwnsP8eyByAJhKK?=
 =?iso-8859-1?Q?NDSFcKx5cxvpSi6ySAudgW7/bLXN4Gz2bAu41DfPfLAuH0HLvnj1npaU58?=
 =?iso-8859-1?Q?VFol9mHWhtNo9v2SSMCKAXzRZTgC18UXv9LurPORAiO4s3HjU8NzDLwCa1?=
 =?iso-8859-1?Q?lupEvfXWTUFpwdjPXuLxFLLDqquZVv6UZJ76eBmZNTdbtOH80hXNT/TtgH?=
 =?iso-8859-1?Q?uxvuA+huBrWIPGVExcG0ge0XGcJbhwG8k2nFSsw4cXoXRu6u288SyilFFB?=
 =?iso-8859-1?Q?maqDrWm9no9bQLeHtb642YjpOaUTnLdiFZTLQ78hkjp40samAJbHCvq1Zh?=
 =?iso-8859-1?Q?qRk60C+6hLGXhLl5bf8Lg4oRjGHFt4N0rf7g+QToeLBQNJp47UdSCxpqzP?=
 =?iso-8859-1?Q?CS2Bl5sxh3lhKYcBy2BZDgRgbq06KkxbTnAQtrxGWPGZVq22LuIAKp1/bK?=
 =?iso-8859-1?Q?wUuaaeuO+4uzlp2yweAkCe98RDq6lsTuAGWkIMcBCmPL7kOtxAiMBFtzrV?=
 =?iso-8859-1?Q?D4jIXgWZ0O/6HFU11RwPS1ks6DByY0dcF2ZHeJqH4m9xGiHNYKTCJ48koP?=
 =?iso-8859-1?Q?R0ADP1Qu795p3yOkBWq5mtvZ5B0G0YJkwq7ob7kjywwy/Fo9eQzCZB0G5N?=
 =?iso-8859-1?Q?OoxjBE4oJukBDEkXRVMB6WrWjcrbZGGIttBEKcYQ4nQPTKmr1zr4v3WaIW?=
 =?iso-8859-1?Q?CHtYI0WUhYY50z0p9+qXfWexvNAT7mNu/ep5DFTjqtpu0X+7+03wsbZ6lU?=
 =?iso-8859-1?Q?U2U8ZXEoIRX0sAfKJ8ejMrb2ZvJlyVmHykorGkR9DRw8gRiMuWXR/hBlLv?=
 =?iso-8859-1?Q?zwoqFvAIngO6iPAYMSh3Bo1QvUwBE/zw2vNOubClmnZ64ROjfRs8Hxb/JH?=
 =?iso-8859-1?Q?9C6d4lJ4DSbL/P1L1jubooitSKKW0uKGb1PaMvsPOmjeF+lmJSpMc2a4Mk?=
 =?iso-8859-1?Q?LLER+Mnm5ME+cwjc0B60kKYiMPtFiyaNAUaV05xonXki/X7Mt2ydN+nkGr?=
 =?iso-8859-1?Q?jmtbTDdPQeL60s+iC43PQ/mu173YtpfiA0k5DIBRyy8+2dG7VcEXhf7A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f7e93c-0af9-4224-4cc4-08dbe997f229
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 07:11:41.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoQe5vsYPaBla6nEHJN7mSe/FD1QmAnvQu6V7aOFTdAaScvKbeyzRVnl0tJa8EyKE5TYVxEQxpNHPd28HLpthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -2.9% regression of will-it-scale.per_thread_ops on:


commit: 0ede61d8589cc2d93aa78230d74ac58b5b8d0244 ("file: convert to SLAB_TYPESAFE_BY_RCU")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 16
	mode: thread
	test: poll2
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311201406.2022ca3f-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231120/202311201406.2022ca3f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/poll2/will-it-scale

commit: 
  93faf426e3 ("vfs: shave work on failed file open")
  0ede61d858 ("file: convert to SLAB_TYPESAFE_BY_RCU")

93faf426e3cc000c 0ede61d8589cc2d93aa78230d74 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01 ±  9%  +58125.6%       4.17 ±175%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     89056            -2.0%      87309        proc-vmstat.nr_slab_unreclaimable
     97958 ±  7%      -9.7%      88449 ±  4%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 12%     +24.2%       0.00 ± 17%  sched_debug.cpu.next_balance.stddev
   6391048            -2.9%    6208584        will-it-scale.16.threads
    399440            -2.9%     388036        will-it-scale.per_thread_ops
   6391048            -2.9%    6208584        will-it-scale.workload
     19.99 ±  4%      -2.2       17.74        perf-profile.calltrace.cycles-pp.fput.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.27 ±  5%      +0.8        2.11 ±  3%  perf-profile.calltrace.cycles-pp.__fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     32.69 ±  4%      +5.0       37.70        perf-profile.calltrace.cycles-pp.__fget_light.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.00           +27.9       27.85        perf-profile.calltrace.cycles-pp.__get_file_rcu.__fget_light.do_poll.do_sys_poll.__x64_sys_poll
     20.00 ±  4%      -2.3       17.75        perf-profile.children.cycles-pp.fput
      0.24 ± 10%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.48 ±  5%      +0.5        1.98 ±  3%  perf-profile.children.cycles-pp.__fdget
     31.85 ±  4%      +6.0       37.86        perf-profile.children.cycles-pp.__fget_light
      0.00           +27.7       27.67        perf-profile.children.cycles-pp.__get_file_rcu
     30.90 ±  4%     -20.6       10.35 ±  2%  perf-profile.self.cycles-pp.__fget_light
     19.94 ±  4%      -2.4       17.53        perf-profile.self.cycles-pp.fput
      9.81 ±  4%      -2.4        7.42 ±  2%  perf-profile.self.cycles-pp.do_poll
      0.23 ± 11%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00           +26.5       26.48        perf-profile.self.cycles-pp.__get_file_rcu
 2.146e+10 ±  2%      +8.5%  2.329e+10 ±  2%  perf-stat.i.branch-instructions
      0.22 ± 14%      -0.0        0.19 ± 14%  perf-stat.i.branch-miss-rate%
 1.404e+10 ±  2%      +8.7%  1.526e+10 ±  2%  perf-stat.i.dTLB-stores
     70.87            -2.3       68.59        perf-stat.i.iTLB-load-miss-rate%
   5267608            -5.5%    4979133 ±  2%  perf-stat.i.iTLB-load-misses
   2102507            +5.4%    2215725        perf-stat.i.iTLB-loads
     18791 ±  3%     +10.5%      20757 ±  2%  perf-stat.i.instructions-per-iTLB-miss
    266.67 ±  2%      +6.8%     284.75 ±  2%  perf-stat.i.metric.M/sec
      0.01 ± 10%     -10.5%       0.01 ±  5%  perf-stat.overall.MPKI
      0.19            -0.0        0.17        perf-stat.overall.branch-miss-rate%
      0.65            -3.1%       0.63        perf-stat.overall.cpi
      0.00 ±  4%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     71.48            -2.3       69.21        perf-stat.overall.iTLB-load-miss-rate%
     18757           +10.0%      20629        perf-stat.overall.instructions-per-iTLB-miss
      1.54            +3.2%       1.59        perf-stat.overall.ipc
   4795147            +6.4%    5100406        perf-stat.overall.path-length
  2.14e+10 ±  2%      +8.5%  2.322e+10 ±  2%  perf-stat.ps.branch-instructions
   1.4e+10 ±  2%      +8.7%  1.522e+10 ±  2%  perf-stat.ps.dTLB-stores
   5253923            -5.5%    4966218 ±  2%  perf-stat.ps.iTLB-load-misses
   2095770            +5.4%    2208605        perf-stat.ps.iTLB-loads
 3.065e+13            +3.3%  3.167e+13        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


