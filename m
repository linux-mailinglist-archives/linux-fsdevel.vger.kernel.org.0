Return-Path: <linux-fsdevel+bounces-834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA357D1160
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0763282510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339E11D539;
	Fri, 20 Oct 2023 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXQ3HSGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A41D532
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 14:17:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E4D4C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697811431; x=1729347431;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=NOiG/QjUwvsyWcPt0x/yJI28vsX8zue1Tp8J2WFal2w=;
  b=JXQ3HSGGZlVUKeAqoTE/ELKO+sP19V5qNVmwlO6xrXRYYE6E4PE19KX7
   S5Uqt1GaezqDUigqord2XLcpz7Oxs61LSlhbL9ohfQWogr9p4wmJ3FxA+
   Otcl+SS90H7zh73fcjieM5/li7TPoo3uzfyJHjj00GGXtcdZ25oaj3tp0
   dT635OCeVZzAhtNZ6w6zH/fwhu8ki/lDcC7JLhSZY8qblxMLoMa4O9aWe
   253PYhEKWVfF0S9WFUwx9I+jhlsSQ8do2s9YTMy7TCi2WU2hz5U4j+8ST
   nul4wcE7uBhPVBHDNgtlwfycUY0xkHEdnzMYHF2ebB1VB4XTp2GACldR0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371576198"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="371576198"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="901143652"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="901143652"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 07:15:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 07:17:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 07:17:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 07:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkmBUpSPc6sB4cLqpg2/bBZc3Im2sPy8sweCdtIf8/rgu/fTOGVsCni9UNhsbJ9Tta2x+kjU9xU23arWsuiE92I8mMA/u5kMuR72DjTr4YdeUHw6b0p8a8ilwp018Vwd4GhpJU9KFQAHo44KDWURJci/mgIUlppIYFibqQj7yckqnJgd/i1sdj1VI5Ez5d+NY74ucjap2ZffM0D6LDcxBbdtVNaaH3p5P43p6bgQ2apt7nnft4vy2AzWodPi0G9YEvH5UkakxoOANg6R3915KlTF4Yf7AvfZniYwLtmlHoV3Ou9Weovwt2YOcRXU88iSQsox05XVnlluJgtbLvIM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNxRlnn53Ur0GaAd/TMUtqQfJaPKlwGW3UXjXPCUVmA=;
 b=UywjzGm3T0ij/M4tiAJvEKHQLvLxCvZJOulKgqAVi+F5Xxpfd8mjDs39ELBdMK+Y7/ZuSDAeSmRALwqubow7Bf+g87jvY3lu9fS5qOi0iBFn4pXG5NXL0/BpVM6S9qEtISQd5aLmLkWpZ0q9YcQVoBpkeCy8zGPoqT2C4kAJzKJkEKNQagZSBeXB6Km3bYL31RQ7OmCfL9RiKt7J6ORJD71qh0KskbVUOUP5nBfbOc6J3bKlrT0XhcGYlT+pVdHBKaITIb8tZ23RaamfP//mTQ3HINqjBRs+bNxc6mCQgy0bUs1ep5y2+Hj6F5ahVcqYFNVtN5EhTSs7U6Rq8IH+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 14:17:03 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 14:17:03 +0000
Date: Fri, 20 Oct 2023 22:16:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.misc.backing_file] [fs/pipe]  8114dc703a:
 stress-ng.pipeherd.ops_per_sec 70.9% improvement
Message-ID: <202310202136.48fa5db-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7935d0b2-7c0a-4c70-c2f3-08dbd1773ad8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91zuHApHSXE/t7/tYBDLkkyQdquHZJxRsm/nDpBKzSGtTmmjeSskJCk/O/aFrxWVz0i7MdMiOZ7AiCFnG2H7/7H8Z8g8rGX8ApyJs3JwH44z21oW6bgYjA8LG9eW8qXbYMfhgar8MHgMT/qUECfOvJqcaTtrhppZljHKjEKwLSsQ4b2yosua+hDVAz34VZU4w1Si0vwEMbPAPVuk5/qbKwY+3wURL0T8GOsDnev4XffEcm4T3fDqy58yzo6iX+swrypExNOzKxyhz+kENiVudGQIQaGvdN+1nRDG7gfbZtVIXBPqudRl+sDwHN2PYO+LJcBL6lZbVWO7ax0CzFEyWvENNH15RyHq6nOXRkyLxTnaAS2mkXpKoSTjt4ynmZlDgvhDYu6E/MrXo2N7GSe/EGJnBi6FvAvSEH30aidHucIm5epnhb3JFoy210hpyHy0geAvobENF9gpA3sv/BYenLM38L2Y/1+AwoDwxngASay7sQ0SaG5f7eNrbtrFhMoEQeskB3CJ11PFw0MS5NgHjwSeM5vsTY7wYQkMQjlSeKkT9ygaBBjMgkeNmPOfnmoLGRFPnUbZiMlLoRrTuq9h1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(30864003)(2906002)(6916009)(6486002)(4326008)(8676002)(8936002)(36756003)(6666004)(5660300002)(41300700001)(54906003)(316002)(66946007)(966005)(86362001)(478600001)(6506007)(107886003)(6512007)(2616005)(1076003)(83380400001)(82960400001)(38100700002)(66476007)(66556008)(26005)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9fOuqQ8NDvTGmj02n3Xkj1FIfS5ay4LMCJIhFQlhNi/sPyD3zKOkZfbG1t?=
 =?iso-8859-1?Q?NDjMuTT8XnL0/8uYvwcZKzyYceDgkhnVj+lIUGiESuhoOpL0Zye6hGYVry?=
 =?iso-8859-1?Q?eT2UvFnOlMQs/HGjYGkR4DKjQ+zY0ho1mYsgClidCH+Ht8Qb8cLEBmjLwb?=
 =?iso-8859-1?Q?F3zTdjyC5ylgBCgQ4p+a0jKmK3QMW9gW9P5xUQ264wxtKFPzdQ5ISG3WhW?=
 =?iso-8859-1?Q?+X0Qkqtz+vyjJZ3zEKDHP7ZvEwdDbAUFDnTukqFMvRdmZUcXKZvnQN/qhR?=
 =?iso-8859-1?Q?Ceqfx3/DazHYkWGJZOdOgtcqvFKLFdneimMmtnCk0NVdI1NPbp5MfNtbH0?=
 =?iso-8859-1?Q?GVA24s9ZeNcEM05szhRXmPgCJRUSq5xO9oCLHm6ujOEb8MdaB5RNVe6fMu?=
 =?iso-8859-1?Q?9rdPJmurS84eSHt/UuO7HIjPe1lzd/gtQUGD7rqsH8o1iPocaMuFU70V6n?=
 =?iso-8859-1?Q?m9QwXh+wOdVURLtyYmTPW7anDZkX0G5AeSRQqxeeGxpF2uBA64CtdDWeeb?=
 =?iso-8859-1?Q?NPYrMiZjRCya/OSWl6EOp+ZaJVLpS2xUYDWie7qF7FwLlKu1f9dcceza7X?=
 =?iso-8859-1?Q?th+HnBDJQjJWqqam3U68Ny6+qOka2tYKpDSdzLy0D865DFWnO8rcG9T3pe?=
 =?iso-8859-1?Q?dAnCXptBuH01D/EI/Q2VbhU2zXxRQ/nXqiz9X+sBY39fUnWsY0M+Qf1JpN?=
 =?iso-8859-1?Q?u6R+aIgzINA03BL2lpLlYsuMvSW+a3BTa5iMsYSqy/29j2RdBOC6npTQKH?=
 =?iso-8859-1?Q?AYGAffM0TkSFasj8F0eknNUBYXs93ojqSuQq2KglewPYcOXfd/blBAr6PJ?=
 =?iso-8859-1?Q?oYPCznPI6XczTw5pmb7+THwnIqcKPE/QVpMeOPBNEfBeSBbOiWaWUBRaAP?=
 =?iso-8859-1?Q?2nLKJEK89iGczsu/iWwtC1CL/LNjb2jvF/7XpSQVCVYQizssW7KE34R0mY?=
 =?iso-8859-1?Q?bYS2lexkx+7Sc1RCm9NAm7zwg54pkhJZxc10KXIrPfzav8XdXXvx3aAew/?=
 =?iso-8859-1?Q?nhgtI7Eq+hxqbHSwmDndA8DY+fJdTcRSa/NzZMBw3Mvl1ziu8+KYAvVu6W?=
 =?iso-8859-1?Q?eGGMjXUCCiqgij9Ik8SwqD9e0QTHh6oDpWC8l0BBZTiNU9SoK5BCDHRi9c?=
 =?iso-8859-1?Q?1T0+MSGAziTXPnfd4ANKVKvqjeiWnwVtt2NN/2c5MiYp3vdmr4+9RiDKO1?=
 =?iso-8859-1?Q?owf7XfIjNGF5tYeEAbEnLCT30uS2eacHOxl0Qg5Z0DDbD87qtgNSUNMstn?=
 =?iso-8859-1?Q?VRAqMnJCpfDhaKUF/eg7La1zbXhwSnJ0LvdCGRoyHzRy9QKHP7qpxaWltx?=
 =?iso-8859-1?Q?yqsvgwlBDog8ur7n4MqF3Zwe132TRx4BEZ7iJY86HOzTREfSj2hcx4nNI1?=
 =?iso-8859-1?Q?f34kgyjfnb4D2QA0I75FXdq1aSQbgdvXfXPUrgeLh7yuiEjpErfzeVQLKJ?=
 =?iso-8859-1?Q?a1wo7X7uzppPTYVUq3BM0PNBPHIAoMruFVyDudw76KkO9Q0Qw3/pmCAzp2?=
 =?iso-8859-1?Q?h4jZNjEQHnDUmIXJi193SG2GUWMwteWMpBCWoHWmjOGMIbESx/OlH/ZTIb?=
 =?iso-8859-1?Q?6tsXyG8SdVJD6aNTpnhoGTReXsvDQPGpBjLlYin20Cuxbo0vG0xA8MzveL?=
 =?iso-8859-1?Q?fGF1cc7ldmQ8Kac/RPq0l10Ytue2VPY+vKLh+O9vd/HnsiVfPvsTlaxw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7935d0b2-7c0a-4c70-c2f3-08dbd1773ad8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:17:02.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgK7kloJl4SNbbNtVThCC0nqTrZIGBM6oBs8gpPKs0ZQxbWueVHSafmPL3OMSwV/vpd/pumld1P/tNlD6xOBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5488
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 70.9% improvement of stress-ng.pipeherd.ops_per_sec on:


commit: 8114dc703a4833be4a98a37f5ed0a3abb55dcb34 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.backing_file

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	nr_threads: 1
	testtime: 60s
	class: pipe
	test: pipeherd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec 64.1% improvement                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=memory                                                                                    |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231020/202310202136.48fa5db-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pipe/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  cc03a5d65a ("fs/pipe: remove unnecessary spinlock from pipe_write()")
  8114dc703a ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")

cc03a5d65a4032f8 8114dc703a4833be4a98a37f5ed 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2662           -68.4%     841.59        uptime.idle
  1.96e+09           -92.7%  1.427e+08 ±  6%  cpuidle..time
  26722190 ±  2%     -99.2%     211047 ±  3%  cpuidle..usage
     86.45           -81.2        5.26 ± 13%  mpstat.cpu.all.idle%
      0.02 ±  9%      -0.0        0.00 ± 34%  mpstat.cpu.all.soft%
     12.05 ±  3%     +81.1       93.19        mpstat.cpu.all.sys%
     86.80           -90.5%       8.29 ±  7%  vmstat.cpu.id
     12.32 ±  2%    +637.7%      90.90        vmstat.cpu.sy
   3777392           -14.4%    3235329        vmstat.memory.cache
      4.88 ±  3%   +1753.7%      90.47        vmstat.procs.r
    759821 ±  3%     -76.8%     176114 ±  8%  vmstat.system.cs
     57282           +58.2%      90632        vmstat.system.in
      1.00           -73.0%       0.27 ± 19%  stress-ng.pipeherd.context_switches_per_bogo_op
    399152 ±  2%     -54.8%     180363 ±  8%  stress-ng.pipeherd.context_switches_per_sec
  23934072 ±  2%     +70.9%   40914905 ± 10%  stress-ng.pipeherd.ops
    398822 ±  2%     +70.9%     681769 ± 10%  stress-ng.pipeherd.ops_per_sec
     14105 ±  3%  +15176.6%    2154810        stress-ng.time.involuntary_context_switches
    448.83 ±  3%    +665.7%       3436        stress-ng.time.percent_of_cpu_this_job_got
    275.60 ±  3%    +671.8%       2127        stress-ng.time.system_time
  23935206 ±  2%     -63.8%    8667217 ± 11%  stress-ng.time.voluntary_context_switches
    804558 ±  2%     -55.3%     359243 ±  2%  meminfo.Active
    804410 ±  2%     -55.4%     359101 ±  2%  meminfo.Active(anon)
     47565 ± 20%     -22.3%      36948 ± 11%  meminfo.AnonHugePages
   3690350           -14.5%    3154124        meminfo.Cached
   2366174           -22.8%    1827058        meminfo.Committed_AS
    450238           -21.1%     355264        meminfo.Inactive
    450058           -21.1%     355078        meminfo.Inactive(anon)
    117976           -38.6%      72400        meminfo.Mapped
   4473104           -12.4%    3919536        meminfo.Memused
    944222 ±  2%     -56.8%     407996 ±  2%  meminfo.Shmem
   4641483           -12.3%    4068866        meminfo.max_used_kB
    616.50          +478.8%       3568        turbostat.Avg_MHz
     16.27           +77.7       93.93        turbostat.Busy%
   3905828 ±  7%     -99.8%       9270 ± 27%  turbostat.C1
      8.52 ±  6%      -8.5        0.02 ± 17%  turbostat.C1%
  22605226           -99.7%      61106 ±  4%  turbostat.C1E
     70.38           -70.2        0.22 ±  6%  turbostat.C1E%
     82.93           -93.8%       5.18 ±  3%  turbostat.CPU%c1
      0.11           -72.7%       0.03        turbostat.IPC
   3750696           +58.4%    5939978        turbostat.IRQ
     68893 ±  2%     -95.1%       3352 ±  5%  turbostat.POLL
      0.04            -0.0        0.00        turbostat.POLL%
     41.00            +5.7%      43.33 ±  2%  turbostat.PkgTmp
     97.64           +48.3%     144.76        turbostat.PkgWatt
     10.24            -1.4%      10.10        turbostat.RAMWatt
    201103 ±  2%     -55.4%      89775 ±  2%  proc-vmstat.nr_active_anon
     77504            -1.4%      76431        proc-vmstat.nr_anon_pages
    922608           -14.5%     788573        proc-vmstat.nr_file_pages
    112532           -21.1%      88805        proc-vmstat.nr_inactive_anon
     29507           -38.5%      18149        proc-vmstat.nr_mapped
    236070 ±  2%     -56.8%     102035 ±  2%  proc-vmstat.nr_shmem
     19797            -1.7%      19458        proc-vmstat.nr_slab_reclaimable
    201103 ±  2%     -55.4%      89775 ±  2%  proc-vmstat.nr_zone_active_anon
    112532           -21.1%      88805        proc-vmstat.nr_zone_inactive_anon
    579999           -32.9%     389134        proc-vmstat.numa_hit
    583256 ±  2%     -33.3%     389117        proc-vmstat.numa_local
    303598 ±  2%     -53.8%     140238 ±  2%  proc-vmstat.pgactivate
    610962           -31.6%     417639        proc-vmstat.pgalloc_normal
    272733            -3.4%     263482        proc-vmstat.pgfault
    256096            -3.6%     246831        proc-vmstat.pgfree
      8409            -4.5%       8033        proc-vmstat.pgreuse
     23449 ±  4%   +4249.9%    1020036        sched_debug.cfs_rq:/.avg_vruntime.avg
     48864 ±  5%   +2132.2%    1090754        sched_debug.cfs_rq:/.avg_vruntime.max
     18796 ±  5%   +5228.8%    1001644        sched_debug.cfs_rq:/.avg_vruntime.min
      6530 ±  5%    +187.4%      18766 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.29 ±  4%    +465.6%       1.64 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.17 ± 20%    +157.1%       3.00 ± 19%  sched_debug.cfs_rq:/.h_nr_running.max
      0.44 ±  3%     +45.9%       0.65 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
      0.83 ± 28%    +820.0%       7.67 ± 36%  sched_debug.cfs_rq:/.load_avg.min
     23449 ±  4%   +4249.9%    1020036        sched_debug.cfs_rq:/.min_vruntime.avg
     48864 ±  5%   +2132.2%    1090754        sched_debug.cfs_rq:/.min_vruntime.max
     18796 ±  5%   +5228.8%    1001644        sched_debug.cfs_rq:/.min_vruntime.min
      6530 ±  5%    +187.4%      18766 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.29 ±  3%    +147.6%       0.71 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.44 ±  3%     -31.3%       0.30 ± 14%  sched_debug.cfs_rq:/.nr_running.stddev
    398.86 ±  4%    +326.4%       1700 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    993.17 ± 10%    +186.3%       2843 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
     17.08 ± 32%   +3470.7%     610.00 ± 39%  sched_debug.cfs_rq:/.runnable_avg.min
    224.04 ±  7%    +131.7%     519.15 ± 10%  sched_debug.cfs_rq:/.runnable_avg.stddev
    396.99 ±  4%    +107.1%     822.14 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    990.17 ± 10%     +57.1%       1556 ±  9%  sched_debug.cfs_rq:/.util_avg.max
     17.00 ± 33%   +1357.8%     247.83 ± 21%  sched_debug.cfs_rq:/.util_avg.min
    223.09 ±  8%     +38.0%     307.92 ±  9%  sched_debug.cfs_rq:/.util_avg.stddev
     42.74 ±  5%   +1003.6%     471.69 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    411.92 ± 15%    +135.5%     970.00 ± 14%  sched_debug.cfs_rq:/.util_est_enqueued.max
    107.34 ±  8%     +77.5%     190.57 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     16850 ± 12%     -51.9%       8099 ± 25%  sched_debug.cpu.avg_idle.min
      0.78 ±  7%    +148.6%       1.93 ± 28%  sched_debug.cpu.clock.stddev
    986.99 ± 11%    +145.8%       2426        sched_debug.cpu.curr->pid.avg
      1503 ±  4%     -42.4%     865.59 ± 13%  sched_debug.cpu.curr->pid.stddev
      0.31 ± 10%    +436.1%       1.65 ±  4%  sched_debug.cpu.nr_running.avg
      1.17 ± 20%    +157.1%       3.00 ± 19%  sched_debug.cpu.nr_running.max
      0.45 ±  4%     +43.3%       0.65 ±  7%  sched_debug.cpu.nr_running.stddev
    662694 ±  2%     -76.2%     157727 ±  7%  sched_debug.cpu.nr_switches.avg
    730901 ±  2%     -71.1%     211353 ±  3%  sched_debug.cpu.nr_switches.max
    588629 ±  4%     -76.6%     137816 ± 10%  sched_debug.cpu.nr_switches.min
     27216 ±  6%     -36.3%      17323 ± 18%  sched_debug.cpu.nr_switches.stddev
      0.17           -52.5%       0.08 ±  4%  perf-stat.i.MPKI
 1.591e+09          +107.7%  3.304e+09        perf-stat.i.branch-instructions
      1.98            -1.2        0.75        perf-stat.i.branch-miss-rate%
  32451085           -25.8%   24094321        perf-stat.i.branch-misses
      2.36 ±  5%      -0.3        2.04 ±  2%  perf-stat.i.cache-miss-rate%
   1832514           -34.8%    1194385 ±  4%  perf-stat.i.cache-misses
    797265 ±  2%     -76.9%     184467 ±  8%  perf-stat.i.context-switches
      3.22 ±  2%    +188.0%       9.27        perf-stat.i.cpi
 2.261e+10          +479.8%  1.311e+11        perf-stat.i.cpu-cycles
    311030 ±  7%    +440.7%    1681617 ±  9%  perf-stat.i.cycles-between-cache-misses
      0.05 ±  8%      -0.0        0.01 ± 14%  perf-stat.i.dTLB-load-miss-rate%
   1006370 ± 10%     -69.6%     305743 ± 15%  perf-stat.i.dTLB-load-misses
 1.964e+09           +82.1%  3.577e+09        perf-stat.i.dTLB-loads
     61148 ± 14%     -44.2%      34119 ±  9%  perf-stat.i.dTLB-store-misses
 9.704e+08           -30.7%   6.72e+08 ±  2%  perf-stat.i.dTLB-stores
     36.77           +39.1       75.84 ±  3%  perf-stat.i.iTLB-load-miss-rate%
   6585163 ±  2%     -81.6%    1214954 ±  8%  perf-stat.i.iTLB-loads
 7.672e+09           +84.7%  1.417e+10        perf-stat.i.instructions
      2339           +65.5%       3871 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.36 ±  2%     -58.9%       0.15        perf-stat.i.ipc
      0.63          +479.8%       3.64        perf-stat.i.metric.GHz
    236.49 ±  2%     -72.7%      64.64 ±  5%  perf-stat.i.metric.K/sec
    129.12           +64.8%     212.85        perf-stat.i.metric.M/sec
      2841            -4.5%       2712        perf-stat.i.minor-faults
    283421 ±  2%     -38.8%     173569 ±  3%  perf-stat.i.node-loads
    229499           -24.6%     173089 ±  3%  perf-stat.i.node-stores
      2841            -4.5%       2712        perf-stat.i.page-faults
      0.24           -64.7%       0.08 ±  5%  perf-stat.overall.MPKI
      2.04            -1.3        0.73        perf-stat.overall.branch-miss-rate%
      1.49 ±  9%      -0.4        1.08 ±  5%  perf-stat.overall.cache-miss-rate%
      2.95 ±  2%    +213.9%       9.25        perf-stat.overall.cpi
     12338 ±  3%    +792.2%     110078 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.05 ± 10%      -0.0        0.01 ± 15%  perf-stat.overall.dTLB-load-miss-rate%
     36.98           +39.7       76.67 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
      1986           +78.5%       3546 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.34 ±  2%     -68.2%       0.11        perf-stat.overall.ipc
 1.566e+09          +107.6%  3.252e+09        perf-stat.ps.branch-instructions
  31948762           -25.8%   23700932        perf-stat.ps.branch-misses
   1804771           -34.9%    1174750 ±  4%  perf-stat.ps.cache-misses
    784569 ±  2%     -76.9%     181522 ±  8%  perf-stat.ps.context-switches
 2.225e+10          +479.8%   1.29e+11        perf-stat.ps.cpu-cycles
    990666 ± 10%     -69.6%     301054 ± 15%  perf-stat.ps.dTLB-load-misses
 1.933e+09           +82.1%   3.52e+09        perf-stat.ps.dTLB-loads
     60212 ± 14%     -44.3%      33564 ±  9%  perf-stat.ps.dTLB-store-misses
 9.551e+08           -30.8%  6.614e+08 ±  2%  perf-stat.ps.dTLB-stores
   6480331 ±  2%     -81.6%    1195545 ±  8%  perf-stat.ps.iTLB-loads
 7.551e+09           +84.7%  1.394e+10        perf-stat.ps.instructions
      2797            -4.6%       2668        perf-stat.ps.minor-faults
    279235 ±  2%     -38.8%     170754 ±  3%  perf-stat.ps.node-loads
    225941           -24.4%     170732 ±  3%  perf-stat.ps.node-stores
      2797            -4.6%       2669        perf-stat.ps.page-faults
 4.765e+11           +84.7%    8.8e+11        perf-stat.total.instructions
      0.00 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.00         +2066.7%       0.06 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 17%  +26530.8%       0.58 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00        +17154.2%       0.69 ± 44%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 43%  +16828.6%       0.99 ±125%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00         +1283.3%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00        +18950.0%       0.38 ± 25%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +4054.2%       0.17 ± 18%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 38%    +127.3%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00         +5075.0%       0.10 ± 10%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 12%    +427.3%       0.02 ± 21%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±  9%  +25143.5%       0.97 ± 42%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ± 14%    +196.6%       0.01 ± 24%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 13%   +9488.2%       0.27 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00           +66.7%       0.01 ± 29%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ± 14%    +730.0%       0.03 ± 43%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 29%    +953.8%       0.07 ± 68%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 20%  +21554.5%       0.40 ± 29%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00 ±  7%    +289.7%       0.02 ± 24%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 69%  +43684.2%       2.77 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 41%  +43520.5%      10.98 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 70%  +57461.5%       2.49 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ± 19%  +34219.4%       2.06 ± 32%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 50%  +13909.1%       1.03 ±118%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.10 ±102%   +4712.8%       5.02 ± 17%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 54%  +30528.3%       3.06 ± 31%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  7%  +19300.0%       1.55 ± 50%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.99 ± 63%    +895.9%       9.90 ± 22%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.13 ± 12%    +543.6%      13.70 ± 12%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±  9%   +1363.9%       0.09 ± 28%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 33%  +19865.2%       1.53 ± 49%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 10%  +35717.9%       1.67 ± 70%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 62%    +423.0%       0.06 ± 34%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 65%  +28549.2%       3.01 ± 47%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 11%  +10415.4%       0.68 ± 94%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     83.01 ±104%     -98.5%       1.28 ± 52%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 31%   +1049.1%       0.11 ± 87%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 20%  +1.1e+05%       2.59 ± 27%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.05 ± 37%   +1383.7%       0.81 ± 74%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 17%   +3800.0%       0.08 ± 12%  perf-sched.total_sch_delay.average.ms
      0.62 ±  2%    +126.8%       1.41 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1476521 ±  2%     -61.2%     573478 ±  3%  perf-sched.total_wait_and_delay.count.ms
      0.62 ±  2%    +114.2%       1.32 ±  3%  perf-sched.total_wait_time.average.ms
      5.46 ± 67%    +130.3%      12.58 ± 22%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.11 ±  4%     +74.0%       0.20 ± 10%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    281.31 ±  6%     -13.6%     243.07 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.38 ±  2%    +138.1%       0.90 ±  3%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.10 ±  8%     -23.7%       3.13 ±  5%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     27.03 ±  4%    +150.7%      67.77 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     97.23 ±  6%     -32.0%      66.15 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    101.49 ±  6%     +97.0%     199.95 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    578.13 ±  3%     +16.0%     670.87 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     17.83 ± 32%    +562.6%     118.17 ± 43%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      3.67 ± 60%   +1022.7%      41.17 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     75116           -41.9%      43673 ±  3%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     89.33 ±223%  +71413.1%      63885 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
   1397168 ±  2%     -69.8%     422092 ±  5%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     15.00 ±  3%     +21.1%      18.17 ±  5%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    578.33 ±  2%     -62.3%     218.17 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     49.17 ±  7%     +53.6%      75.50 ± 11%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1832 ±  5%     -47.7%     959.00 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    227.50           -13.8%     196.00 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     10.50 ± 67%   +1100.6%     126.04 ± 53%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    166.68 ±223%    +501.3%       1002        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.00           -15.1%       4.24 ±  7%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      2503 ± 38%     +41.0%       3528 ± 13%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.34 ±  8%     -47.1%       0.18 ± 30%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.00 ±100%   +2335.0%       0.08 ± 76%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      5.46 ± 67%    +130.3%      12.58 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.33 ±  2%     +31.4%       0.44 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.32 ±  4%     -38.2%       0.20 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.11 ±  4%     +51.2%       0.17 ± 12%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    281.30 ±  6%     -13.7%     242.69 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.24          +257.3%       0.86 ± 20%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±223%  +40360.0%       4.05 ±202%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.66 ±101%     -54.8%       0.30 ±  8%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.38 ±  2%    +112.2%       0.80 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.09 ±  8%     -24.1%       3.11 ±  5%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     27.03 ±  4%    +150.7%      67.76 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.27 ± 23%     -58.2%       0.11 ± 55%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.33 ±  2%    +356.1%       1.48 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     97.23 ±  6%     -32.0%      66.12 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    101.43 ±  6%     +97.1%     199.93 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 50%  +10655.6%       0.16 ± 72%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    578.12 ±  3%     +16.0%     670.85 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±100%  +13881.8%       0.51 ± 72%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     10.50 ± 67%   +1100.6%     126.04 ± 53%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.42 ±  4%   +2499.7%      10.86 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.32 ± 44%    +486.3%       1.88 ±110%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.71 ±  2%    +416.0%       3.68 ± 20%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±223%  +1.8e+06%     180.76 ±203%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    185.31 ±196%    +440.6%       1001        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.99           -16.0%       4.20 ±  8%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.42 ±  5%    +351.1%       1.89 ± 51%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.74 ±  3%    +680.0%       5.73 ± 30%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2503 ± 38%     +41.0%       3528 ± 13%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  9%  +18576.1%       1.43 ± 79%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     56.76           -56.8        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     54.92           -54.9        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     54.92           -54.9        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     54.89           -54.9        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.90           -51.9        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     51.48           -51.5        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.29           -50.3        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     45.09           -45.1        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.71           -10.4        0.29 ±100%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.34 ±  2%      -6.3        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      4.98 ±  7%      -5.0        0.00        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.84 ±  4%      -1.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.80 ±  4%      -1.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      1.49 ±  5%      +0.3        1.84        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.21 ±  6%      +0.4        1.56 ±  2%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      1.13 ±  6%      +0.4        1.53 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      0.00            +0.7        0.74 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      7.79 ±  4%     +12.5       20.33 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      7.29 ±  4%     +13.0       20.27 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      6.85 ±  4%     +13.4       20.20 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
     36.28           +16.4       52.68 ±  6%  perf-profile.calltrace.cycles-pp.read
     35.78           +16.7       52.52 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     35.73           +16.8       52.50 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     35.50           +16.9       52.44 ±  6%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     35.45           +17.0       52.41 ±  6%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     35.27           +17.0       52.30 ±  6%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.00 ±  3%     +21.0       29.98 ±  7%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.68 ±  4%     +22.9       29.63 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      5.74 ±  4%     +23.8       29.52 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      6.40 ±  2%     +40.8       47.23 ±  7%  perf-profile.calltrace.cycles-pp.write
      6.13 ±  3%     +40.9       46.99 ±  7%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.06 ±  3%     +40.9       46.96 ±  7%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.22 ±  3%     +40.9       47.13 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.20 ±  3%     +40.9       47.12 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      5.90 ±  3%     +41.0       46.88 ±  7%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.02 ±  3%     +42.2       44.26 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.82 ±  4%     +42.3       44.14 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      3.54 ±  3%     +42.7       46.23 ±  7%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     56.76           -56.8        0.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     56.76           -56.8        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     56.73           -56.7        0.00        perf-profile.children.cycles-pp.do_idle
     54.92           -54.9        0.00        perf-profile.children.cycles-pp.start_secondary
     53.20           -53.2        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     51.96           -52.0        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     51.94           -51.9        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.09           -45.1        0.00        perf-profile.children.cycles-pp.intel_idle
     12.21           -11.6        0.57 ± 23%  perf-profile.children.cycles-pp.__mutex_lock
      7.32 ±  2%      -7.1        0.20 ± 28%  perf-profile.children.cycles-pp.osq_lock
      6.04 ±  6%      -6.0        0.00        perf-profile.children.cycles-pp.intel_idle_irq
      3.16 ±  3%      -2.6        0.57 ±  9%  perf-profile.children.cycles-pp.__schedule
      2.52 ±  2%      -2.4        0.11 ± 41%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      1.92 ±  4%      -1.4        0.54 ±  9%  perf-profile.children.cycles-pp.schedule
      1.63 ±  4%      -1.4        0.26 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.49            -1.0        0.48 ±  4%  perf-profile.children.cycles-pp.mutex_lock
      1.14 ±  2%      -0.8        0.35 ±  3%  perf-profile.children.cycles-pp.mutex_unlock
      0.76 ±  6%      -0.7        0.10 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
      0.83 ±  5%      -0.6        0.20 ± 10%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.62 ±  3%      -0.6        0.07 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.84 ±  5%      -0.5        0.32 ± 12%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.66 ±  5%      -0.5        0.15 ± 10%  perf-profile.children.cycles-pp.enqueue_entity
      0.78 ±  5%      -0.5        0.28 ± 12%  perf-profile.children.cycles-pp.activate_task
      0.57 ±  3%      -0.5        0.08 ±  9%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.54 ±  6%      -0.5        0.05 ± 45%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.70 ±  9%      -0.5        0.23 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.73 ±  5%      -0.5        0.27 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.54 ±  9%      -0.3        0.22 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.54 ±  9%      -0.3        0.22 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.37 ±  5%      -0.3        0.07 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.42 ±  7%      -0.3        0.12 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.49 ±  4%      -0.3        0.20 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      0.45 ±  8%      -0.3        0.19 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  4%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.select_task_rq
      0.34 ±  5%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.32 ±  9%      -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.29 ±  7%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.29 ±  5%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.16 ±  8%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.18 ±  5%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.25 ±  7%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ±  5%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.15 ±  8%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.21 ±  6%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.update_curr
      0.14 ±  8%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      0.22 ±  7%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.18 ± 10%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.14 ± 11%      -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      0.13 ±  7%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.reweight_entity
      0.18 ±  7%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.10 ± 11%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ± 10%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.10 ± 14%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.17 ±  9%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp._copy_to_iter
      0.08 ± 11%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__fdget_pos
      0.16 ±  7%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.copyout
      0.14 ± 10%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.wake_affine
      1.49 ±  5%      +0.3        1.84        perf-profile.children.cycles-pp.__wake_up_common
      1.19 ±  5%      +0.4        1.54        perf-profile.children.cycles-pp.try_to_wake_up
      1.21 ±  6%      +0.4        1.57        perf-profile.children.cycles-pp.autoremove_wake_function
      7.80 ±  4%     +12.5       20.33 ±  4%  perf-profile.children.cycles-pp.finish_wait
     36.32           +16.4       52.70 ±  6%  perf-profile.children.cycles-pp.read
     35.50           +16.9       52.44 ±  6%  perf-profile.children.cycles-pp.ksys_read
     35.45           +17.0       52.41 ±  6%  perf-profile.children.cycles-pp.vfs_read
     35.30           +17.0       52.31 ±  6%  perf-profile.children.cycles-pp.pipe_read
      9.01 ±  3%     +21.0       30.00 ±  7%  perf-profile.children.cycles-pp.prepare_to_wait_event
      6.45 ±  2%     +40.8       47.26 ±  7%  perf-profile.children.cycles-pp.write
      6.14 ±  3%     +40.9       47.00 ±  7%  perf-profile.children.cycles-pp.ksys_write
      6.06 ±  3%     +40.9       46.97 ±  7%  perf-profile.children.cycles-pp.vfs_write
      5.90 ±  3%     +41.0       46.88 ±  7%  perf-profile.children.cycles-pp.pipe_write
      3.54 ±  3%     +42.7       46.25 ±  7%  perf-profile.children.cycles-pp.__wake_up_common_lock
     42.17           +57.5       99.70        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.09           +57.6       99.67        perf-profile.children.cycles-pp.do_syscall_64
     16.92 ±  3%     +76.9       93.87        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     16.29 ±  3%     +78.6       94.91        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     45.09           -45.1        0.00        perf-profile.self.cycles-pp.intel_idle
      7.30 ±  2%      -7.1        0.20 ± 28%  perf-profile.self.cycles-pp.osq_lock
      5.78 ±  6%      -5.8        0.00        perf-profile.self.cycles-pp.intel_idle_irq
      2.51 ±  2%      -2.4        0.11 ± 41%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      1.99 ±  2%      -1.8        0.23 ± 12%  perf-profile.self.cycles-pp.__mutex_lock
      1.76            -1.5        0.24 ±  8%  perf-profile.self.cycles-pp.prepare_to_wait_event
      1.46            -1.0        0.44 ±  5%  perf-profile.self.cycles-pp.mutex_lock
      1.88 ±  2%      -0.8        1.05 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.14 ±  2%      -0.8        0.35 ±  3%  perf-profile.self.cycles-pp.mutex_unlock
      0.60 ±  4%      -0.5        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      0.54 ±  6%      -0.5        0.05 ± 45%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.56 ±  3%      -0.5        0.08 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.66 ± 10%      -0.5        0.20 ± 26%  perf-profile.self.cycles-pp.pipe_read
      0.36 ±  6%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.30 ±  5%      -0.2        0.06 ±  8%  perf-profile.self.cycles-pp.__schedule
      0.15 ±  8%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.17 ±  4%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      0.15 ±  7%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.09 ± 13%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ± 27%      -0.1        0.08 ± 39%  perf-profile.self.cycles-pp.pipe_write
      0.10 ± 13%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.09 ± 14%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.12 ±  7%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.04 ± 71%      +0.2        0.28 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
     16.92 ±  3%     +76.9       93.87        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  cc03a5d65a ("fs/pipe: remove unnecessary spinlock from pipe_write()")
  8114dc703a ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")

cc03a5d65a4032f8 8114dc703a4833be4a98a37f5ed 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2709           -69.3%     830.62        uptime.idle
     2e+09           -93.2%  1.357e+08 ±  2%  cpuidle..time
  28090525 ±  3%     -99.3%     203996 ±  2%  cpuidle..usage
     87.74           -82.7        5.02 ± 13%  mpstat.cpu.all.idle%
      0.03 ± 10%      -0.0        0.00 ± 37%  mpstat.cpu.all.soft%
     10.73 ±  8%     +82.7       93.44        mpstat.cpu.all.sys%
     88.01           -91.1%       7.83 ±  8%  vmstat.cpu.id
     11.03 ±  8%    +728.1%      91.38        vmstat.cpu.sy
   3828646           -15.5%    3234352        vmstat.memory.cache
      4.52 ±  6%   +1924.7%      91.56        vmstat.procs.r
    796488 ±  3%     -78.0%     174864 ±  6%  vmstat.system.cs
     57177           +60.1%      91552 ±  3%  vmstat.system.in
      1.00           -73.7%       0.26 ± 16%  stress-ng.pipeherd.context_switches_per_bogo_op
    421613 ±  4%     -57.7%     178307 ±  7%  stress-ng.pipeherd.context_switches_per_sec
  25283532 ±  4%     +64.1%   41497127 ±  9%  stress-ng.pipeherd.ops
    421306 ±  4%     +64.1%     691477 ±  9%  stress-ng.pipeherd.ops_per_sec
     12565 ± 10%  +17024.2%    2151679        stress-ng.time.involuntary_context_switches
    403.83 ±  8%    +751.1%       3436        stress-ng.time.percent_of_cpu_this_job_got
    247.39 ±  8%    +759.9%       2127        stress-ng.time.system_time
  25284435 ±  4%     -66.2%    8546895 ±  9%  stress-ng.time.voluntary_context_switches
    851649 ±  3%     -58.0%     357966 ±  3%  meminfo.Active
    851501 ±  3%     -58.0%     357818 ±  3%  meminfo.Active(anon)
   3742441           -15.7%    3153275        meminfo.Cached
   2409010           -24.0%    1831617        meminfo.Committed_AS
    451343           -21.6%     353822        meminfo.Inactive
    451163           -21.6%     353642        meminfo.Inactive(anon)
    118870 ±  2%     -38.5%      73112        meminfo.Mapped
   4514553           -13.3%    3913828        meminfo.Memused
    996307 ±  3%     -59.1%     407148 ±  3%  meminfo.Shmem
   4682131           -13.2%    4062916        meminfo.max_used_kB
    212877 ±  3%     -58.0%      89455 ±  3%  proc-vmstat.nr_active_anon
    935621           -15.7%     788336        proc-vmstat.nr_file_pages
    112796           -21.6%      88425        proc-vmstat.nr_inactive_anon
     29729 ±  2%     -38.4%      18302        proc-vmstat.nr_mapped
    249082 ±  3%     -59.1%     101798 ±  3%  proc-vmstat.nr_shmem
     19817            -2.0%      19424        proc-vmstat.nr_slab_reclaimable
    212877 ±  3%     -58.0%      89455 ±  3%  proc-vmstat.nr_zone_active_anon
    112796           -21.6%      88425        proc-vmstat.nr_zone_inactive_anon
    596114           -34.8%     388508        proc-vmstat.numa_hit
    596130           -34.8%     388478        proc-vmstat.numa_local
    316752 ±  2%     -55.6%     140488 ±  4%  proc-vmstat.pgactivate
    626933           -33.3%     418232        proc-vmstat.pgalloc_normal
    271840            -3.8%     261580        proc-vmstat.pgfault
      8141            -2.6%       7930        proc-vmstat.pgreuse
    571.50 ±  5%    +526.2%       3578        turbostat.Avg_MHz
     15.11 ±  5%     +79.1       94.20        turbostat.Busy%
   4469624 ±  9%     -99.8%       9104 ± 19%  turbostat.C1
      9.54 ±  8%      -9.5        0.02 ± 20%  turbostat.C1%
  23403867 ±  2%     -99.7%      60893 ±  3%  turbostat.C1E
     70.10           -69.9        0.21 ±  5%  turbostat.C1E%
    150042 ±  8%     -15.6%     126569 ±  3%  turbostat.C6
      6.59 ±  7%      -1.0        5.62 ±  2%  turbostat.C6%
     83.84           -94.0%       5.02        turbostat.CPU%c1
      0.12 ±  5%     -74.6%       0.03        turbostat.IPC
   3762229           +58.7%    5970483 ±  3%  turbostat.IRQ
     63321 ±  2%     -94.2%       3649 ± 10%  turbostat.POLL
      0.04 ± 11%      -0.0        0.00        turbostat.POLL%
     41.00            +6.5%      43.67 ±  2%  turbostat.PkgTmp
     96.48           +50.2%     144.88        turbostat.PkgWatt
     10.23            -1.5%      10.08        turbostat.RAMWatt
     20253 ± 11%   +4934.8%    1019726        sched_debug.cfs_rq:/.avg_vruntime.avg
     42488 ±  7%   +2500.3%    1104832 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
     15819 ± 14%   +6224.0%    1000401        sched_debug.cfs_rq:/.avg_vruntime.min
      6095 ±  3%    +246.2%      21099 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.29 ±  9%    +475.8%       1.65 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.25 ± 20%    +113.3%       2.67 ±  8%  sched_debug.cfs_rq:/.h_nr_running.max
      0.58 ± 31%   +1600.0%       9.92 ±  5%  sched_debug.cfs_rq:/.load_avg.min
     20253 ± 11%   +4934.8%    1019726        sched_debug.cfs_rq:/.min_vruntime.avg
     42488 ±  7%   +2500.3%    1104832 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
     15819 ± 14%   +6224.0%    1000401        sched_debug.cfs_rq:/.min_vruntime.min
      6095 ±  3%    +246.2%      21099 ± 26%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.28 ± 11%    +146.3%       0.70 ±  3%  sched_debug.cfs_rq:/.nr_running.avg
      0.45 ±  6%     -41.7%       0.26 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
    371.87 ±  7%    +351.1%       1677 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
      1049 ± 15%    +152.8%       2652 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
      9.33 ± 36%   +8476.8%     800.50 ± 33%  sched_debug.cfs_rq:/.runnable_avg.min
    224.61 ± 14%     +92.7%     432.74 ± 10%  sched_debug.cfs_rq:/.runnable_avg.stddev
    369.83 ±  7%    +115.1%     795.51 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1046 ± 15%     +37.1%       1435 ±  7%  sched_debug.cfs_rq:/.util_avg.max
      8.92 ± 36%   +3443.0%     315.92 ± 18%  sched_debug.cfs_rq:/.util_avg.min
     33.93 ± 34%   +1322.2%     482.56 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    401.08 ± 21%    +144.0%     978.75 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.max
     99.29 ± 25%     +75.4%     174.17 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    589817 ±  5%     -12.9%     513465 ±  3%  sched_debug.cpu.avg_idle.max
     17625 ± 11%     -51.8%       8492 ± 20%  sched_debug.cpu.avg_idle.min
      0.73 ±  4%    +182.0%       2.07 ± 28%  sched_debug.cpu.clock.stddev
    889.48 ± 17%    +175.5%       2450        sched_debug.cpu.curr->pid.avg
      1441 ±  8%     -41.2%     847.75 ±  9%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 14%     +98.0%       0.00 ± 20%  sched_debug.cpu.next_balance.stddev
      0.29 ± 17%    +455.1%       1.63 ±  4%  sched_debug.cpu.nr_running.avg
      1.25 ± 20%    +120.0%       2.75 ± 13%  sched_debug.cpu.nr_running.max
    697944 ±  3%     -77.7%     155957 ±  6%  sched_debug.cpu.nr_switches.avg
    766842 ±  4%     -73.1%     206139 ±  5%  sched_debug.cpu.nr_switches.max
    630908 ±  4%     -78.9%     133104 ± 10%  sched_debug.cpu.nr_switches.min
     29178 ± 15%     -42.1%      16903 ± 22%  sched_debug.cpu.nr_switches.stddev
      0.17 ±  2%     -52.1%       0.08 ±  2%  perf-stat.i.MPKI
 1.582e+09          +109.1%  3.308e+09        perf-stat.i.branch-instructions
      2.00            -1.3        0.75        perf-stat.i.branch-miss-rate%
  32433729           -25.7%   24102582        perf-stat.i.branch-misses
      2.46 ±  8%      -0.4        2.07 ±  2%  perf-stat.i.cache-miss-rate%
   1826870           -34.1%    1203961 ±  2%  perf-stat.i.cache-misses
    838779 ±  3%     -78.3%     182290 ±  7%  perf-stat.i.context-switches
      3.01 ±  5%    +206.9%       9.25        perf-stat.i.cpi
 2.105e+10 ±  5%    +522.7%  1.311e+11        perf-stat.i.cpu-cycles
     17229 ±  8%     +16.1%      19996 ±  7%  perf-stat.i.cpu-migrations
    299091 ±  9%    +529.6%    1883163 ± 10%  perf-stat.i.cycles-between-cache-misses
      0.05 ±  4%      -0.0        0.01 ±  9%  perf-stat.i.dTLB-load-miss-rate%
    946957 ±  5%     -63.0%     350764 ±  8%  perf-stat.i.dTLB-load-misses
 1.963e+09           +82.5%  3.584e+09        perf-stat.i.dTLB-loads
     53749 ± 13%     -32.4%      36351 ± 10%  perf-stat.i.dTLB-store-misses
 1.004e+09 ±  2%     -32.7%  6.756e+08 ±  2%  perf-stat.i.dTLB-stores
     37.17           +39.2       76.33 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   6918328 ±  3%     -82.7%    1198409 ±  6%  perf-stat.i.iTLB-loads
 7.646e+09           +85.6%  1.419e+10        perf-stat.i.instructions
      2207 ±  4%     +73.4%       3828 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.38 ±  4%     -61.3%       0.15        perf-stat.i.ipc
      0.58 ±  5%    +522.7%       3.64        perf-stat.i.metric.GHz
    247.76 ±  3%     -74.1%      64.28 ±  4%  perf-stat.i.metric.K/sec
    129.35           +64.8%     213.17        perf-stat.i.metric.M/sec
      2817            -4.5%       2690        perf-stat.i.minor-faults
    287862 ±  2%     -40.8%     170491 ±  2%  perf-stat.i.node-loads
    232290 ±  4%     -26.6%     170522 ±  6%  perf-stat.i.node-stores
      2817            -4.5%       2690        perf-stat.i.page-faults
      0.24           -64.5%       0.08 ±  2%  perf-stat.overall.MPKI
      2.05            -1.3        0.73        perf-stat.overall.branch-miss-rate%
      1.72 ± 13%      -0.6        1.11        perf-stat.overall.cache-miss-rate%
      2.75 ±  5%    +235.6%       9.24        perf-stat.overall.cpi
     11529 ±  7%    +845.4%     109003 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.05 ±  4%      -0.0        0.01 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
     37.38           +39.8       77.16 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      1855 ±  4%     +88.8%       3503 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.36 ±  5%     -70.3%       0.11        perf-stat.overall.ipc
 1.557e+09          +109.0%  3.256e+09        perf-stat.ps.branch-instructions
  31931731           -25.8%   23706440        perf-stat.ps.branch-misses
   1799223           -34.2%    1184288 ±  2%  perf-stat.ps.cache-misses
    825430 ±  3%     -78.3%     179378 ±  7%  perf-stat.ps.context-switches
 2.072e+10 ±  5%    +522.7%   1.29e+11        perf-stat.ps.cpu-cycles
     16955 ±  8%     +16.0%      19676 ±  7%  perf-stat.ps.cpu-migrations
    932029 ±  5%     -62.9%     345425 ±  8%  perf-stat.ps.dTLB-load-misses
 1.932e+09           +82.5%  3.527e+09        perf-stat.ps.dTLB-loads
     52911 ± 13%     -32.4%      35765 ± 10%  perf-stat.ps.dTLB-store-misses
 9.885e+08 ±  2%     -32.7%  6.649e+08 ±  2%  perf-stat.ps.dTLB-stores
   6808264 ±  3%     -82.7%    1179244 ±  6%  perf-stat.ps.iTLB-loads
 7.526e+09           +85.5%  1.396e+10        perf-stat.ps.instructions
      2773            -4.6%       2647        perf-stat.ps.minor-faults
    283598 ±  2%     -40.8%     167758 ±  2%  perf-stat.ps.node-loads
    228693 ±  4%     -26.4%     168245 ±  6%  perf-stat.ps.node-stores
      2773            -4.6%       2647        perf-stat.ps.page-faults
 4.761e+11           +84.6%  8.788e+11        perf-stat.total.instructions
      0.01 ± 75%    +929.7%       0.06 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 20%  +36754.5%       0.68 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 14%  +16358.6%       0.80 ± 23%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00         +1250.0%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 20%  +19114.3%       0.45 ± 16%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +3366.7%       0.14 ± 36%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 56%    +188.5%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00         +5083.3%       0.10 ±  9%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 14%    +980.0%       0.04 ±134%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 14%  +26266.7%       0.92 ± 45%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ±  8%    +956.0%       0.04 ± 82%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 19%  +14193.3%       0.36 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00           +66.7%       0.01 ± 29%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±  9%    +387.0%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 18%   +1119.0%       0.09 ±147%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00        +13975.0%       0.28 ± 41%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00 ± 10%    +239.3%       0.02 ± 46%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 29%   +3763.8%       0.30 ±185%  perf-sched.sch_delay.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.00 ± 23%  +40978.3%       1.57 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.45 ±131%   +1924.0%       9.21 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 17%  +1.3e+05%       2.79 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 21%  +36733.3%       2.21 ± 34%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 45%   +2469.0%       0.30 ±134%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 16%  +11181.6%       4.61 ± 10%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 19%  +34075.9%       3.08 ± 24%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 30%  +15051.8%       1.41 ± 63%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.43 ±137%   +2356.9%      10.45 ± 33%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.08 ± 13%    +540.7%      13.32 ± 24%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 17%   +7221.9%       0.39 ±190%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 18%  +14615.0%       0.98 ± 45%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ±  7%  +31034.5%       1.50 ± 40%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 10%   +5090.9%       0.38 ±114%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 55%  +34995.7%       2.69 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 27%   +3184.0%       0.27 ±109%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     49.15 ±138%     -94.6%       2.64 ±174%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 25%   +1541.8%       0.15 ±169%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 76%  +47250.0%       1.58 ± 35%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.05 ± 24%    +625.5%       0.34 ±109%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 17%   +3800.0%       0.08 ± 10%  perf-sched.total_sch_delay.average.ms
      0.59 ±  3%    +138.6%       1.40 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1558477 ±  3%     -63.4%     570364 ±  3%  perf-sched.total_wait_and_delay.count.ms
      0.58 ±  3%    +125.1%       1.31 ±  3%  perf-sched.total_wait_time.average.ms
      0.12           +66.1%       0.19 ±  9%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.36 ±  3%    +152.2%       0.91 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.02 ±  9%     -21.7%       3.15 ±  5%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     25.74 ±  7%    +162.9%      67.68 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    101.37 ±  5%     -30.7%      70.21 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    118.32 ±  9%     +63.5%     193.49 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    569.65 ±  2%     +14.6%     653.05        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.83 ±128%    +960.0%       8.83 ± 61%  perf-sched.wait_and_delay.count.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      4.00 ± 32%    +970.8%      42.83 ± 22%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     75183           -41.6%      43888 ±  2%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    153.50 ±142%  +41336.4%      63604 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
   1479460 ±  3%     -71.6%     419944 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    598.17 ±  2%     -63.1%     220.50 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     47.83 ±  4%     +47.7%      70.67 ±  7%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1609 ±  9%     -40.3%     960.00 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    221.00 ±  4%     -10.6%     197.50 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    333.52 ±141%    +200.3%       1001        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.31 ±  4%     +37.1%       0.43 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.11           +43.8%       0.16 ± 11%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.24 ±  2%    +248.2%       0.82 ± 16%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.36 ±  3%    +124.9%       0.80 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.02 ±  9%     -22.6%       3.11 ±  5%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     25.74 ±  7%    +162.9%      67.67 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.32 ±  2%    +374.5%       1.53 ± 12%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    101.36 ±  5%     -30.8%      70.19 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    118.28 ±  9%     +63.6%     193.47 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 99%  +23733.3%       0.12 ± 54%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    569.65 ±  2%     +14.6%     653.04        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.44 ± 22%   +1755.3%       8.17 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.39 ± 19%    +370.3%       1.83 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.39 ±  7%    +407.5%       1.98 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.71 ±  2%    +343.6%       3.16 ± 21%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.19 ± 90%  +14957.4%      28.81 ±136%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.49 ± 31%    +337.6%       2.14 ± 56%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.70 ±  3%    +711.4%       5.71 ± 20%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 52%  +14837.8%       0.92 ± 33%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     58.50           -58.5        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     56.75           -56.8        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     56.74           -56.7        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     56.71           -56.7        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     53.10           -53.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     52.94           -52.9        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.58           -51.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     45.34           -45.3        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.48 ±  9%      -9.2        0.28 ±100%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.82 ± 10%      -5.8        0.00        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.95 ±  5%      -1.7        0.27 ±100%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.89 ±  4%      -1.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      1.67 ±  7%      +0.2        1.84        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.37 ±  8%      +0.2        1.58        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      1.28 ±  7%      +0.3        1.54        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      0.00            +0.8        0.75 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      6.96 ±  9%     +13.3       20.28 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.48 ± 10%     +13.7       20.22 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      6.04 ± 11%     +14.1       20.16 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
     34.07 ±  4%     +18.3       52.39 ±  5%  perf-profile.calltrace.cycles-pp.read
     33.53 ±  4%     +18.7       52.24 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     33.45 ±  4%     +18.8       52.22 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.17 ±  4%     +19.0       52.16 ±  5%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.11 ±  4%     +19.0       52.12 ±  5%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     32.91 ±  4%     +19.1       52.01 ±  5%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.23 ±  5%     +21.5       29.75 ±  6%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.83 ±  9%     +23.6       29.41 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      4.78 ± 14%     +24.5       29.30 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      6.81 ±  5%     +40.7       47.52 ±  6%  perf-profile.calltrace.cycles-pp.write
      6.51 ±  5%     +40.8       47.28 ±  6%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.60 ±  5%     +40.8       47.42 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.58 ±  5%     +40.8       47.40 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.42 ±  5%     +40.8       47.24 ±  6%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.22 ±  4%     +40.9       47.16 ±  6%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.89 ±  4%     +42.6       44.53 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.67 ±  6%     +42.7       44.41 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      3.59           +42.9       46.51 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     58.50           -58.5        0.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     58.50           -58.5        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     58.47           -58.5        0.00        perf-profile.children.cycles-pp.do_idle
     56.75           -56.8        0.00        perf-profile.children.cycles-pp.start_secondary
     54.57           -54.6        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     53.16           -53.2        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     53.14           -53.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.34           -45.3        0.00        perf-profile.children.cycles-pp.intel_idle
     11.02 ±  6%     -10.5        0.55 ± 24%  perf-profile.children.cycles-pp.__mutex_lock
      6.92 ±  9%      -6.9        0.00        perf-profile.children.cycles-pp.intel_idle_irq
      6.16 ± 12%      -6.0        0.19 ± 30%  perf-profile.children.cycles-pp.osq_lock
      3.36 ±  5%      -2.8        0.57 ±  8%  perf-profile.children.cycles-pp.__schedule
      2.48 ±  2%      -2.4        0.11 ± 40%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      2.02 ±  5%      -1.5        0.54 ±  9%  perf-profile.children.cycles-pp.schedule
      1.74 ±  4%      -1.5        0.26 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.51            -1.0        0.50 ±  5%  perf-profile.children.cycles-pp.mutex_lock
      1.20 ±  4%      -0.8        0.36 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
      0.82 ±  8%      -0.7        0.10 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
      0.89 ±  7%      -0.7        0.20 ± 10%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.91 ±  8%      -0.6        0.32 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.85 ±  8%      -0.6        0.28 ±  9%  perf-profile.children.cycles-pp.activate_task
      0.80 ±  7%      -0.6        0.23 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.72 ±  9%      -0.6        0.15 ± 11%  perf-profile.children.cycles-pp.enqueue_entity
      0.62 ±  5%      -0.6        0.07 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.79 ±  9%      -0.5        0.26 ±  9%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.57 ±  5%      -0.5        0.05 ± 45%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.54 ±  4%      -0.5        0.08 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.61 ±  7%      -0.4        0.22 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.61 ±  7%      -0.4        0.22 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.38 ±  6%      -0.4        0.02 ± 99%  perf-profile.children.cycles-pp.prepare_task_switch
      0.40 ±  8%      -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.52 ±  6%      -0.3        0.20 ±  8%  perf-profile.children.cycles-pp.update_load_avg
      0.44 ±  6%      -0.3        0.12 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.50 ±  7%      -0.3        0.19 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.40 ±  6%      -0.3        0.12 ± 11%  perf-profile.children.cycles-pp.select_task_rq
      0.38 ±  6%      -0.3        0.12 ±  8%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.36 ±  8%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.33 ±  8%      -0.2        0.15 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.32 ±  8%      -0.2        0.14 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.28 ±  7%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.20 ±  8%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.20 ±  8%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.16 ±  9%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.26 ±  6%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  7%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.23 ± 10%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.update_curr
      0.16 ±  7%      -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.15 ± 11%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.__entry_text_start
      0.16 ± 15%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.security_file_permission
      0.14 ± 17%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.reweight_entity
      0.20 ±  8%      -0.1        0.13 ± 11%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.19 ±  8%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp._copy_to_iter
      0.10 ± 15%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.13 ± 15%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.10 ± 17%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.__fdget_pos
      0.17 ±  9%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.copyout
      0.11 ± 16%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.16 ± 13%      -0.0        0.11 ± 13%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.wake_affine
      1.67 ±  7%      +0.2        1.84        perf-profile.children.cycles-pp.__wake_up_common
      1.38 ±  8%      +0.2        1.58        perf-profile.children.cycles-pp.autoremove_wake_function
      1.32 ±  7%      +0.2        1.56        perf-profile.children.cycles-pp.try_to_wake_up
      6.96 ±  9%     +13.3       20.28 ±  4%  perf-profile.children.cycles-pp.finish_wait
     34.12 ±  4%     +18.3       52.42 ±  5%  perf-profile.children.cycles-pp.read
     33.18 ±  4%     +19.0       52.16 ±  5%  perf-profile.children.cycles-pp.ksys_read
     33.11 ±  4%     +19.0       52.12 ±  5%  perf-profile.children.cycles-pp.vfs_read
     32.94 ±  4%     +19.1       52.02 ±  5%  perf-profile.children.cycles-pp.pipe_read
      8.24 ±  5%     +21.5       29.77 ±  6%  perf-profile.children.cycles-pp.prepare_to_wait_event
      6.86 ±  5%     +40.7       47.55 ±  6%  perf-profile.children.cycles-pp.write
      6.52 ±  5%     +40.8       47.29 ±  6%  perf-profile.children.cycles-pp.ksys_write
      6.43 ±  5%     +40.8       47.26 ±  6%  perf-profile.children.cycles-pp.vfs_write
      6.23 ±  4%     +40.9       47.16 ±  6%  perf-profile.children.cycles-pp.pipe_write
      3.59           +42.9       46.53 ±  6%  perf-profile.children.cycles-pp.__wake_up_common_lock
     40.31 ±  3%     +59.4       99.70        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.20 ±  3%     +59.5       99.67        perf-profile.children.cycles-pp.do_syscall_64
     14.86 ± 10%     +79.0       93.86        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     14.54 ±  8%     +80.4       94.93        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     45.34           -45.3        0.00        perf-profile.self.cycles-pp.intel_idle
      6.59 ±  9%      -6.6        0.00        perf-profile.self.cycles-pp.intel_idle_irq
      6.15 ± 12%      -6.0        0.19 ± 30%  perf-profile.self.cycles-pp.osq_lock
      2.46            -2.4        0.10 ± 41%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      1.98            -1.8        0.22 ± 13%  perf-profile.self.cycles-pp.__mutex_lock
      1.80 ±  3%      -1.6        0.23 ±  7%  perf-profile.self.cycles-pp.prepare_to_wait_event
      1.48 ±  2%      -1.0        0.44 ±  4%  perf-profile.self.cycles-pp.mutex_lock
      2.04 ±  9%      -1.0        1.07 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.14 ± 28%      -0.9        0.20 ± 27%  perf-profile.self.cycles-pp.pipe_read
      1.20 ±  4%      -0.8        0.36        perf-profile.self.cycles-pp.mutex_unlock
      0.61 ±  5%      -0.5        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      0.57 ±  5%      -0.5        0.05 ± 45%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.54 ±  4%      -0.5        0.08 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.39 ±  9%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.34 ±  6%      -0.3        0.05 ± 44%  perf-profile.self.cycles-pp.__schedule
      0.28 ± 33%      -0.2        0.08 ± 29%  perf-profile.self.cycles-pp.pipe_write
      0.16 ±  9%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.18 ±  9%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.update_load_avg
      0.16 ±  9%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.10 ± 16%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.10 ± 18%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.12 ± 14%      -0.1        0.06 ± 15%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.08 ± 20%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.vfs_read
      0.14 ± 13%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.06 ± 18%      +0.2        0.28 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
     14.85 ± 10%     +79.0       93.86        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


