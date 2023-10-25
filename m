Return-Path: <linux-fsdevel+bounces-1133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1367D624B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F8281CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCF168C0;
	Wed, 25 Oct 2023 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBXG6jyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624A125A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:19:38 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 00:19:36 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E60AF;
	Wed, 25 Oct 2023 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698218376; x=1729754376;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KVKGkZgMbYitBG+biiVxCiWkd2XJnazRqsmEKg+bkDw=;
  b=QBXG6jyiPW/kRDARje3E3UK4NE2oy+hVWUkZLzwTc3FP+SKZ8xGb5cFN
   6FP3tmAm5lU+6l5b63Ub4hpZ90FXEkjF2YgAHyEjMEoMR/ytUqxWOp/vO
   S84wjJ5W8FqzLsp7M7C+2kyRQv9ezx6L/0C2A4zPOJmL+i7sjdsQRIilN
   Wg/zp8q+kXIRmgJaycsC01AMxRHlboVJ0BeqmRKl4I7bqbqkaohnHw+qR
   a4P7D7FR0X5VElIJ1JjYTr9UzfUp1KZTEKiS1Z1uuqFA25BLjcy9r8/w7
   4ArV37PWpFD15DhCMQs4Cn4UPxraXr+EsbvaLTF8YggZqqP313JgWeOsX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="15521"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="15521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="6436255"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:17:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:18:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 00:18:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 00:18:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyuxm9/sOW6DUhNwm7BarhNhAs46AhjE7a8sQmmGPNxNIgGULvdIeo/1m2Wmg+jNAAmwV1zxDvhPUEHSkRLRdgox/RF0H9Z09hXWZYIzX9vMbszi3//s5SxnVJGVr0s2rgNKu1a6jth+qybgAZtikGbU1/X60VyynzYSiB23M8AuzK8XTK4Lqc0hsVJfkFo0lao/sxQBVWdMJHNwVaXglnm/wmKqLQ9GaDryRQHtMrcVQcQBwJ8M7gTKZBViRneUkISTsrtfOzVkxaCe/+n1VevuKZowtN44rh5cXFVEBZ/gqkzOahQKvonpyKXsYZlUCD4wKIkO3BYSf7ZgeaJOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1+8Aj6Xe8jEQ+Q75klfIJq0+aPkx1JhTkdk9DpiL5E=;
 b=ZXpNpuBmiHaGpwBmT9/rlv7KdEAKdvu/tHiRqUqCW3Qcovicx9GdNK8q/spAAv5JVmUYIlUTgzz8dAZZTa0THeYxum1aYb3qAHvNSaDLNqTmfWNKD9C8Z/LVPw9PDvmIETMdVXJIcmhTjAo6bm5W+DjNqKPTgoPf3EuUSfWzgt1kfCCtkQzJfEemKF9NZ04fkQQl9hy6dW1xoDyxDUHY685rnf5aRfQri9dUBvJ6mFbdzWPOed+6HxD6mAISeDvms/yj10p2UFN2bas/HboCOKRUddrBRYiyzzrT9vYP10Ht//ze18zVorU62mRiq4WD4Z47R4jp7oUpM6+qLvCYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:18:27 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:18:27 +0000
Date: Wed, 25 Oct 2023 15:18:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Yury Norov
	<yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <202310251458.48b4452d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011150252.32737-1-jack@suse.cz>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f92d30-97fc-48f1-23ba-08dbd52a94f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfFrzYw7H+p2vsCNE9B22Gg1x5aLxbNmZ7H+TCXY8dbsrBNanDbz0uAV8JAdcN1FNzUT2KSi3fTdceL7zkVDYRYVxd53oJmTOEaViZWH/agRwrQDDhuA6jVDq6ZWCpxSDoHX0A0JHGK4gpzGx5mWmOyWXeooQWJYQH8lQ/MSdzzJIAd9LUSyP0hAYibIlPJlRD69t8I7WL7cgfotuDkJmD1yt2VL2nZTwjBOivkE/nbUi4/S+31nqrqEJICSMu6yWaREEPZGPltrACV5duLVclpqB0IPimZfAvdBeVek+9sW4IL/n2P8uMFLJoaGB1rPAhGe6OOcvLhJ6CNUjmgY+wTC/sXMnTf24KZURdqFDIr+sGzg1x0CwSQtpVhTYyyEy1eLcjTPHbUuKIXtV88Qd5N8PfPWNtlkJPnHqCkYh2ZDrSeXCltAoU6jO4eybBT0BbyE48UuJOS5gB2nN/vvnwkA5hD1/sngWaO3P3BnFObTLc3jVeaLaZz2I4z6zdyfhVeROMcyobqwqtvpAklf06YU94PZfEPl3PlrruCT2IvQbQUmiTcgiebTv72txdc2l9CPIkzX5TuTSyywpJui4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(30864003)(2906002)(86362001)(38100700002)(41300700001)(6916009)(54906003)(66476007)(66556008)(316002)(82960400001)(6666004)(6506007)(478600001)(1076003)(6486002)(966005)(6512007)(83380400001)(5660300002)(36756003)(4326008)(2616005)(8676002)(8936002)(66946007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gq3orDJ7/rch/a2ieWfmOTBu+YMxm1pHGQK4MhkU+2J+Sk51qgQmbLyam7?=
 =?iso-8859-1?Q?SxibXLedaM2YUOMjUGN8Oe8MwBn1tMdE1Z0oKOxCyUgS7iB66p099Knf/H?=
 =?iso-8859-1?Q?3kko1M/lbEecZY+wAuvYjONohJEgw/QPNb94fSmWeVSYEHr15dGj6bvcKo?=
 =?iso-8859-1?Q?MvFBt/H27S5y5IrbXHo6fNC+DqjZnykRlKG4P9QEtS1BjKN9KSe68qsOQF?=
 =?iso-8859-1?Q?w+Wov7ABLyr08RN0UnDJyPG3xiteodzi2pC77ZskRKaZC3qRQZp/GS8HYy?=
 =?iso-8859-1?Q?txOH117l3E/cTLX6ANLr5Fj0iRedz1Hge02t//JFjy4dbcPXq2v18dBQMn?=
 =?iso-8859-1?Q?c5gneRWh4I3y57nkAgewgPIDgUxLQhGbMh61PI0/gM48f3WmXlL0jY83QF?=
 =?iso-8859-1?Q?SfjO57ARG7pIhUV5gztFYL59MmrcF5PRY48eYFN6rerbDW6yTVlxwju/9G?=
 =?iso-8859-1?Q?qlKc5yFcpyAyF9FJ0j3ifubSK3k/x/GZe7mNnABrztOkzUwaGcWTi95man?=
 =?iso-8859-1?Q?haAYZIZ46/4jAxe+vHyWmdqB77i9kOP/WNOZDQs/Pf9pDuSkQoNQFjfCaF?=
 =?iso-8859-1?Q?VYtAgEvf7hA+3YryKij74B5x+Uk61TXV8J0+9ik1ZTUc9H1BRvmIpgZLMI?=
 =?iso-8859-1?Q?k9L9wrhhcY/WK2JN8If4dOToIiO9OcoHh2GivgkgWWn34aM0ldgEynSv+E?=
 =?iso-8859-1?Q?JOaaTE1vot+3ej4HqtgGOYsW6jXMrP9qUFmVVlE2+2P/GcskJBywxIIZCE?=
 =?iso-8859-1?Q?/uaOwV1kZyhK3cbcXZ9QIkC/hYK5PfnozFPh1vAygKUvqXELVaZ7ZNpdwM?=
 =?iso-8859-1?Q?knFo30rFjEgJ84qIbOjVGXDwFWEab1WWiwKhWAhVSGOY/Y8JD/qivAuqGJ?=
 =?iso-8859-1?Q?q7Gb+gqMnW8+OedeT+YZXFxk9YNbhCmDcfP69bh6DlaGkxGsIlWeUUfuGn?=
 =?iso-8859-1?Q?I84MeG1bgRYP1Ixl0BSGu+/LQZ4xKgMVP7tFEdrP/7bJJHyRecx8gndEbH?=
 =?iso-8859-1?Q?BYBk1nLeI0Eh3MaXa/sWXatXHGiYYbVugxbe5Em3LNoY3cXyKREi2LS2f9?=
 =?iso-8859-1?Q?8OH68TutcWid7KN31VfTfjn5wEDM0bXobTr+8cFroh6JdkjAyhZfCwuFFB?=
 =?iso-8859-1?Q?qinGfiuJU4HGY6WZjowSTJZtEl3L523uqj5IB06p9ZgCyw/q+V2X9Mqex9?=
 =?iso-8859-1?Q?wneZSlOuC1M/G3IYG85sAX4PFeQ2pR7rQXWriE2aMouhcJq3GR9N6XDVjL?=
 =?iso-8859-1?Q?BQK+nndVw9CtEaY2iCajCQqCbqeDjHPGsFKJl67011ZzfTBnAmRtF8eX5f?=
 =?iso-8859-1?Q?tpIYfJsQSAdKdFbcjA/bmlRVjVccYcvQLlGzAUwFNotG6NusanFydEeViX?=
 =?iso-8859-1?Q?fU5d13doRKtRVJSnASjqBnETKPxXOP/rbfdnHw/D0INT4jx1+1+0lOuPLR?=
 =?iso-8859-1?Q?lopPO5jFW+ra4BtNwosywtPLKkXay6sXh5A4uWA3MiyjF4ZsVwKJ3iHZTB?=
 =?iso-8859-1?Q?gIeyCqwz0jG/YZrQn002KZ2mBW5dijV/aI54uFgvMJ8Icyd4jNHQm8XXoO?=
 =?iso-8859-1?Q?gT4lB6Kz2KzR2tSt962PKdToYDC4NEyDKN8BVmY/skXEwFdo5LAMjBtRfc?=
 =?iso-8859-1?Q?8x1wry54XUZE0/WA1cIRcIythSRspho+ZEGAyYs3/ahGSh8tKcfuY8jw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f92d30-97fc-48f1-23ba-08dbd52a94f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:18:27.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M38II46/D+BkUcWllBcYJQydgmBbg3QpnYW7C3Z7L9gmFSExT/5VbKi4V7clrmfxVEFPDHFGzaSDKiZPQ8oj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.7% improvement of will-it-scale.per_thread_ops on:


commit: df671b17195cd6526e029c70d04dfb72561082d7 ("[PATCH 1/2] lib/find: Make functions safe on changing bitmaps")
url: https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/lib-find-Make-functions-safe-on-changing-bitmaps/20231011-230553
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
patch link: https://lore.kernel.org/all/20231011150252.32737-1-jack@suse.cz/
patch subject: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 50%
	mode: thread
	test: tlb_flush3
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310251458.48b4452d-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/tlb_flush3/will-it-scale

commit: 
  1c8b86a379 ("Merge tag 'xsa441-6.6-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip")
  df671b1719 ("lib/find: Make functions safe on changing bitmaps")

1c8b86a3799f7e5b df671b17195cd6526e029c70d04 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.14 ± 19%     +36.9%       0.19 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
  2.26e+08            +3.6%  2.343e+08        proc-vmstat.pgfault
      0.04           +25.0%       0.05        turbostat.IPC
     32666           -15.5%      27605 ±  2%  turbostat.POLL
      7856            +2.2%       8025        vmstat.system.cs
   6331931            +2.3%    6478704        vmstat.system.in
    700119            +3.7%     725931        will-it-scale.52.threads
     13463            +3.7%      13959        will-it-scale.per_thread_ops
    700119            +3.7%     725931        will-it-scale.workload
      8.36            -7.3%       7.74        perf-stat.i.MPKI
 4.591e+09            +3.4%  4.747e+09        perf-stat.i.branch-instructions
 1.832e+08            +2.8%  1.883e+08        perf-stat.i.branch-misses
     26.70            -0.3       26.40        perf-stat.i.cache-miss-rate%
      7852            +2.2%       8021        perf-stat.i.context-switches
      6.43            -7.2%       5.97        perf-stat.i.cpi
    769.61            +1.8%     783.29        perf-stat.i.cpu-migrations
  6.39e+09            +3.4%  6.606e+09        perf-stat.i.dTLB-loads
  2.94e+09            +3.2%  3.035e+09        perf-stat.i.dTLB-stores
     78.29            -0.9       77.44        perf-stat.i.iTLB-load-miss-rate%
  18959450            +3.5%   19621273        perf-stat.i.iTLB-load-misses
   5254435            +8.7%    5713444        perf-stat.i.iTLB-loads
 2.236e+10            +7.7%  2.408e+10        perf-stat.i.instructions
      1181            +4.0%       1228        perf-stat.i.instructions-per-iTLB-miss
      0.16            +7.7%       0.17        perf-stat.i.ipc
      0.02 ± 36%     -49.6%       0.01 ± 53%  perf-stat.i.major-faults
    485.08            +3.0%     499.67        perf-stat.i.metric.K/sec
    141.71            +3.2%     146.25        perf-stat.i.metric.M/sec
    747997            +3.7%     775416        perf-stat.i.minor-faults
   3127957           -13.9%    2693728        perf-stat.i.node-loads
  26089697            +3.4%   26965335        perf-stat.i.node-store-misses
    767569            +3.7%     796095        perf-stat.i.node-stores
    747997            +3.7%     775416        perf-stat.i.page-faults
      8.35            -7.3%       7.74        perf-stat.overall.MPKI
     26.70            -0.3       26.40        perf-stat.overall.cache-miss-rate%
      6.43            -7.1%       5.97        perf-stat.overall.cpi
     78.30            -0.9       77.45        perf-stat.overall.iTLB-load-miss-rate%
      1179            +4.0%       1226        perf-stat.overall.instructions-per-iTLB-miss
      0.16            +7.7%       0.17        perf-stat.overall.ipc
   9644584            +3.8%   10011125        perf-stat.overall.path-length
 4.575e+09            +3.4%  4.731e+09        perf-stat.ps.branch-instructions
 1.825e+08            +2.8%  1.876e+08        perf-stat.ps.branch-misses
      7825            +2.2%       7995        perf-stat.ps.context-switches
    767.16            +1.8%     780.76        perf-stat.ps.cpu-migrations
 6.368e+09            +3.4%  6.583e+09        perf-stat.ps.dTLB-loads
  2.93e+09            +3.2%  3.025e+09        perf-stat.ps.dTLB-stores
  18896725            +3.5%   19555325        perf-stat.ps.iTLB-load-misses
   5236456            +8.7%    5693636        perf-stat.ps.iTLB-loads
 2.229e+10            +7.6%  2.399e+10        perf-stat.ps.instructions
    745423            +3.7%     772705        perf-stat.ps.minor-faults
   3117663           -13.9%    2684861        perf-stat.ps.node-loads
  26002765            +3.4%   26875267        perf-stat.ps.node-store-misses
    764789            +3.7%     793098        perf-stat.ps.node-stores
    745423            +3.7%     772705        perf-stat.ps.page-faults
 6.752e+12            +7.6%  7.267e+12        perf-stat.total.instructions
     19.21            -1.0       18.18        perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
     17.00            -0.9       16.09        perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
     65.30            -0.6       64.69        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     65.34            -0.6       64.75        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.98            -0.5       65.45        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     65.96            -0.5       65.42        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      9.72 ±  2%      -0.5        9.20        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
     66.33            -0.5       65.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     66.46            -0.5       65.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     31.88            -0.4       31.43        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
     67.72            -0.4       67.28        perf-profile.calltrace.cycles-pp.__madvise
     32.15            -0.4       31.73        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
     32.60            -0.4       32.21        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
     32.93            -0.3       32.58        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     31.07            -0.3       30.74        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
     31.58            -0.3       31.28        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior
     31.61            -0.3       31.30        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise
     31.80            -0.3       31.51        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      8.34            -0.1        8.22        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask
      8.06            -0.1        7.95        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond
      7.98            -0.1        7.87        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch
      0.59 ±  3%      +0.1        0.65 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.testcase
      1.46            +0.1        1.53        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.48            +0.1        1.55        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.53            +0.1        1.62        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.92            +0.1        3.02        perf-profile.calltrace.cycles-pp.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      1.26 ±  2%      +0.1        1.36        perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      1.84            +0.1        1.96        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      7.87            +0.1        8.00        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      2.03 ±  2%      +0.1        2.17        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      2.90            +0.2        3.06        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      2.62 ±  3%      +0.2        2.80        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      2.58 ±  3%      +0.2        2.76        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      2.95 ±  3%      +0.2        3.14        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      2.75            +0.2        2.94        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
      4.96            +0.3        5.29        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask
      4.92            +0.3        5.25        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond
      5.13            +0.3        5.46        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      5.08            +0.4        5.44        perf-profile.calltrace.cycles-pp.testcase
     37.25            -2.0       35.24        perf-profile.children.cycles-pp.llist_add_batch
     62.82            -0.8       62.04        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
     62.82            -0.8       62.04        perf-profile.children.cycles-pp.smp_call_function_many_cond
     63.70            -0.7       62.98        perf-profile.children.cycles-pp.flush_tlb_mm_range
     65.30            -0.6       64.70        perf-profile.children.cycles-pp.zap_page_range_single
     65.34            -0.6       64.75        perf-profile.children.cycles-pp.madvise_vma_behavior
     65.98            -0.5       65.45        perf-profile.children.cycles-pp.__x64_sys_madvise
     65.96            -0.5       65.43        perf-profile.children.cycles-pp.do_madvise
     66.52            -0.5       66.01        perf-profile.children.cycles-pp.do_syscall_64
     66.65            -0.5       66.16        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.79            -0.4       67.36        perf-profile.children.cycles-pp.__madvise
     32.94            -0.3       32.60        perf-profile.children.cycles-pp.tlb_finish_mmu
     31.74            -0.3       31.43        perf-profile.children.cycles-pp.zap_pte_range
     31.76            -0.3       31.46        perf-profile.children.cycles-pp.zap_pmd_range
     31.95            -0.3       31.66        perf-profile.children.cycles-pp.unmap_page_range
      0.42 ±  2%      +0.0        0.46        perf-profile.children.cycles-pp.error_entry
      0.20 ±  3%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.up_read
      0.69            +0.0        0.74        perf-profile.children.cycles-pp.native_flush_tlb_local
      1.47            +0.1        1.55        perf-profile.children.cycles-pp.filemap_map_pages
      1.48            +0.1        1.56        perf-profile.children.cycles-pp.do_read_fault
      1.54            +0.1        1.62        perf-profile.children.cycles-pp.do_fault
      2.75            +0.1        2.86        perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      1.85            +0.1        1.98        perf-profile.children.cycles-pp.__handle_mm_fault
      2.04 ±  2%      +0.1        2.18        perf-profile.children.cycles-pp.handle_mm_fault
      2.63 ±  3%      +0.2        2.81        perf-profile.children.cycles-pp.exc_page_fault
      2.62 ±  3%      +0.2        2.80        perf-profile.children.cycles-pp.do_user_addr_fault
      3.24 ±  3%      +0.2        3.44        perf-profile.children.cycles-pp.asm_exc_page_fault
      3.83            +0.2        4.04        perf-profile.children.cycles-pp.flush_tlb_func
      0.69 ±  2%      +0.2        0.92        perf-profile.children.cycles-pp._find_next_bit
      9.92            +0.3       10.23        perf-profile.children.cycles-pp.llist_reverse_order
      5.45            +0.4        5.81        perf-profile.children.cycles-pp.testcase
     18.42            +0.5       18.96        perf-profile.children.cycles-pp.asm_sysvec_call_function
     16.24            +0.5       16.78        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     15.78            +0.5       16.32        perf-profile.children.cycles-pp.__sysvec_call_function
     16.36            +0.5       16.90        perf-profile.children.cycles-pp.sysvec_call_function
     27.92            -1.9       26.04        perf-profile.self.cycles-pp.llist_add_batch
      0.16 ±  2%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.up_read
      0.42 ±  2%      +0.0        0.45        perf-profile.self.cycles-pp.error_entry
      0.21 ±  4%      +0.0        0.24 ±  5%  perf-profile.self.cycles-pp.down_read
      0.26 ±  2%      +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.tlb_finish_mmu
      2.01            +0.0        2.05        perf-profile.self.cycles-pp.default_send_IPI_mask_sequence_phys
      0.68            +0.0        0.73        perf-profile.self.cycles-pp.native_flush_tlb_local
      3.10            +0.2        3.26        perf-profile.self.cycles-pp.flush_tlb_func
      0.50 ±  2%      +0.2        0.68        perf-profile.self.cycles-pp._find_next_bit
      9.92            +0.3       10.22        perf-profile.self.cycles-pp.llist_reverse_order
     16.10            +0.5       16.64        perf-profile.self.cycles-pp.smp_call_function_many_cond




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


