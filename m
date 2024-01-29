Return-Path: <linux-fsdevel+bounces-9320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA183FF96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7979D1F232C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56615524D6;
	Mon, 29 Jan 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5Iww0aW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A045524C0;
	Mon, 29 Jan 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515551; cv=fail; b=XnBNUTuDnO70swKL92+YpQgMW91HBXFc5AZyJye1rLEef0W+PoDtFknIduIl2jy1o6u4awzAoF58nd4imA+q5+b17ZPbGMGM4fcYzg9fTVOtj2uW+L0aZU+BnICtbX/rzONBLadShZ6KfZ6P6ZmUBnoimdC7MoKv4P9EkOgyJ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515551; c=relaxed/simple;
	bh=8YycDnGusdi4WzzDm1feknDw6nzmghueppw6sfIzw8Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RosTO41cwOoX+CQGXYEpYOVz+ZvQ10E/9XU1NVxLLSgq7lMfUBZYN8ubPlZMU4xxs2gMoJ9HO4YHk3ncAjkq56g1JM8+q29OXzMSRn0DDFiI4FEApu4KRxzJNz5tAgi/uoufohQ2rM+vCtxyFY/LdZ+D/QI/gef9LEgKQceBeoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5Iww0aW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706515550; x=1738051550;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=8YycDnGusdi4WzzDm1feknDw6nzmghueppw6sfIzw8Y=;
  b=d5Iww0aWkMqFtXS08R0YGDC9IN1kxBh2I6kjzzcDyjWiYaauHZ+Hm0C4
   DMPq4tJ4asuHUXJhcJAQhUSID4pJsFqCeguwNcn7Toy6BNPetsK8uePEE
   ZZQViV4IXtOwiZ/BNDwbNxF3waN1QTIwnKZUz0LicaeOxgEc3S/1KmUox
   87UR/ZAx21dMV8EB4+iDgCKONH2K7IbKEiMm+QmUmOPzqzte79EjyW0UH
   bWhS/FNS7VOzB+x5Jt3k5SwC7YwUbXKc6lgxPvadWIEljwJNEk/lQNOY5
   TyX1vioJLmrdvmhNxK1cKEs66PsFfDRwDdlPvDl78oCsOG/0SQeS9N9c9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16238532"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="16238532"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3213770"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 00:05:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:05:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 00:05:45 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 00:05:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvR52nw/tVSjve2F4woPht8Mbyk+0aemUZPsO47io/59pRUVsqNOIggS0mx7v96CTtxcNSFK+zmDA8wgUabRDm3fQdY4ScerP0Qif3ODMGC2ZSz3IEPqkcqmfrk0wmOnw8kTNZvzy7otvgbXjeabW7Skifcdjfv1gf29/4AE0xr3Fr5tH0flKvLyzxSHqSomYD9JEpBFGXu0Yi+MPvBpGcXDDFQSHZnYRQ22zO3Zc2AIYTL88bn6DGB4mBK91/F7QWB3ws7YqbqRlB12nkXRIYEXqLq6xfeVO8LWcKZVGUpLrZgheLqUtKknu3YojWVFySI32JoRIvrJXLOrr9pJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W12SmmOzePjVc22IomEofLko2HjO+pEpplvSiw8KZZA=;
 b=K2lLNv60tqWDQ5R5hz77UrRF4x5klZc6YG/hXnaeJ67hgYynNNiiJEjpUb9AFOY+JJ2d+JSJuQ8dd/EQjF1yvZ0Pr90UtHaKuNHgYTxF5dxXMg70enK/MPG8GYsHn7I/vlxHZjtIBydega+NO1ndxJbCYol+RUNDRZcm2+HZrkVh0Ps+XzyX6tnwtlExK+AD+JvtjDvtVi1tDtbpnPlmZQSFm6uN6++J53yYdrrElrcc/i7cX1MJqSCcvQ1cP6hHiKvWda6MgQXHp4hurIUMbPDYA1OAZ8Q5pSXN8t9Y8txtvuICHE6sOqul/dYu+etlCegRfRS1cuX89QN2B53ahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:05:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:05:42 +0000
Date: Mon, 29 Jan 2024 16:05:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [vfs]  93faf426e3:  stress-ng.dynlib.ops_per_sec 7.2%
 improvement
Message-ID: <202401291500.8546fbc3-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: 414b40ff-1645-47d8-1c4f-08dc20a11686
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5nVyHygJxSqsVLAtMCD0L2fRsuKiIaYvxzIentfMWgm4WjJxzCLedsvTcIjLsZreagpi9s3If7ouqTUhDcHD1SqtQJszoKYCStPMT+sTIN/kZxWN2zoIVLRDHbuOmd6gemef9R+b5cjTqX1DuzYXn/nLFJcfhS2Wk8QCHNMF17p9bsOkKT8tr2njMf7EPEHSA/oY5jnnUflLhpbxz4ys+qTfIezo/2choNaZL7AH+Z00V+ydccSpyG8svmckPMaQzzOR4wXAFHu81ZUrSdk4aZf1xiAysjgH46UlwI3XnofZiSbsVis+cm/1OhIECHn0ftOmzNQjx/NJietlEbV33X8tLXokKvNcL4MTg0O/TzSgzILNyembUDAObaDarYjfpkk3hMt9R8vgXxmnqLFn/d1dUT1SvDlTm6x0CMT7+Fkl3pWmaav0HVE/V5UEjcZcpO/xbi3M+BT4gGr1w+rMFwX2qufBYtTulN3Phsy8TB5AdY0FJzA2w9+AjsChiDuhQJdo4OAB8NZJX54iafZ9Lfh79qefEYnhvpD3KCay6dxdPvOL8pamMXDq7fncFHNSsribh0mDzQ/MUEcsRciXW6P3NiEY69x/G+xnpyD48P1GnW4rETWbMOP7Fup/XqP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(230373577357003)(230473577357003)(1800799012)(186009)(64100799003)(451199024)(6916009)(316002)(86362001)(66946007)(66556008)(66476007)(83380400001)(966005)(6486002)(478600001)(6506007)(6666004)(38100700002)(1076003)(2616005)(107886003)(6512007)(26005)(8936002)(8676002)(82960400001)(4326008)(5660300002)(30864003)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Qt0S87MZVM1wcSziZejshGYc+StfajVn0AVmx7WsRPbLC8rE7uYusqpvL2?=
 =?iso-8859-1?Q?G6YIcGJtOjCImcEj3lPerl/+H4BUWs3xABuuURcyxgKg+LRfNOogX6O6Ho?=
 =?iso-8859-1?Q?vHfIUeBT2OQITO/BIxmeHvFGbuJYJ9frz8Dk5ZtQWemZo6xp3kS0ihxEnN?=
 =?iso-8859-1?Q?Q0t92MNU+Xdv6KXW4TWzyIVvWicllEshNXFnOtijKNZVHrfPaYSBAKhAk2?=
 =?iso-8859-1?Q?luC7ew/2P4FvNxXRNfCQaNpBIWaK5geg0YpFuysnlb4P5yT66uTTe1VgsD?=
 =?iso-8859-1?Q?D1hu9I8SeZgg6DspwjVQkbgovzREsKnIDtw75FIVKPBEbClQJbeJK8xvCL?=
 =?iso-8859-1?Q?qesrhBnSklh3x7KiBvIktzunFZDuVHaI91jBEEJtMTQ4ER3PZk7RlyoFix?=
 =?iso-8859-1?Q?xHU5aQ7mzde9jiqAH4Q8wP3dBT8d4xeNlBzdgo0syyjLuD2gxenB8xUOTK?=
 =?iso-8859-1?Q?xD8PqZFa6U+5m0hNMaog0DFCDipSccxYm73W5MnVbFW0TCqsKtlsY2/IX8?=
 =?iso-8859-1?Q?JeNbv9tUYfufBnbhRejDdiEV7FXE3ug5WBogJ5TraeWQh7HiK4JLsHNosY?=
 =?iso-8859-1?Q?cKslh08iEZ5TlspnJ14lN6mCcLlC26RKe0TBCSTSyGHHDmBxhTsHigcqOk?=
 =?iso-8859-1?Q?7sHCF9KKjn95pHxxftc2OweaFYkCWj4101v4PdvDkkUsif8ak5Sw/qJ0nt?=
 =?iso-8859-1?Q?4Cd2RNgDGlJNqgB2d8rQ4yz6SXutwCQJDNQTuJAKNJue0ioEZvGLHMpDB8?=
 =?iso-8859-1?Q?R3dCeqTitsl+qBUdc2Gw/aDmCD/hySOz+bZALtGDzg/cwrOU3UG+OmfJBh?=
 =?iso-8859-1?Q?F39ZPQV2hkiiSDbsMjNuLBX4KJ8eIAz8UMdqo2poDBbq4f+yr1t1D6RV3h?=
 =?iso-8859-1?Q?TEsVl4YEU6mdiTdhPdMP1oEJ32A15zF7HA17RC6+1Tpv3cSKLmpOsVN+x8?=
 =?iso-8859-1?Q?r1fslMnmr1RRBIXH+ifrdtfB2yBntYCGBx//fPWWVKg2qjMjDNhOXc0cSn?=
 =?iso-8859-1?Q?NtlFwaqLE7rU4Mvwr55lkDzkDctxI0eod1YENb+z3/IImGMbHUYic8STnw?=
 =?iso-8859-1?Q?r8hG20y8p5cXa0/dDziMr14gcQR+lT0G0x0F7mIT4qGyQs4QilviFTrVah?=
 =?iso-8859-1?Q?iZeHEsBvjVT9rDSe9lAM7i1ief4loM8g1Emvx+Go9UegLsAZ1f0aQ9yKcL?=
 =?iso-8859-1?Q?iIZGBNFk312B2mxoWfc8iQYUJ0vQFZLrzk6qEqohXCFCntJUTroaSNMtQV?=
 =?iso-8859-1?Q?T/WprcMSnP10rJJjCtSfzPgVT2oQOcNonHvcmeuSQ4rqwhU+PuosK7Mn7a?=
 =?iso-8859-1?Q?z42OziOrwGvWqw6xOMwxiweoy+tDIzIH3VyI/kjqLmcAAuxVyHOzgCbini?=
 =?iso-8859-1?Q?d6a40dnwzn4Gy0y9SGTUMONk8ChfXk651Mm8GZ6zPir/OXHnaFOGFXC0V8?=
 =?iso-8859-1?Q?oQ6Z1x9U890IU7ncwSntGkx9e4Oh3jPmGMs7KRp5lnOlhpOTYegdPbDO+q?=
 =?iso-8859-1?Q?E2oc75sKo601QF6LpSR4TF9b5xpmf71eZZcbPQnvx+X+sg5xnkXq0l3kWO?=
 =?iso-8859-1?Q?skRbv9DudZEeptkLblm3RDGIK+YPA77ly3GMYY/0pbaIG7Os8jDdmp8+XD?=
 =?iso-8859-1?Q?Fe0fBgdJqLhgkBpOTu3U+HAavsYvrAPWP9mrSUU+yBw657NY1XKBfDmg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 414b40ff-1645-47d8-1c4f-08dc20a11686
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:05:42.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96uK77c7R+VqDuu38ak4EAOibgL6zxrWaOSUyK4jU+AIQ8K3kXE6hq5xohHYpnRRgo7hYqHathyLljVY/Q+H3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 7.2% improvement of stress-ng.dynlib.ops_per_sec on:


commit: 93faf426e3cc000c95f1a5d3510b77ce99adac52 ("vfs: shave work on failed file open")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: dynlib
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240129/202401291500.8546fbc3-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/dynlib/stress-ng/60s

commit: 
  6036c5f131 ("fs: simplify misleading code to remove ambiguity regarding ihold()/iput()")
  93faf426e3 ("vfs: shave work on failed file open")

6036c5f131752689 93faf426e3cc000c95f1a5d3510 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8.49            -0.9%       8.41        iostat.cpu.system
      0.61            -0.2        0.39        mpstat.cpu.all.soft%
     55.50 ± 11%     -44.7%      30.67 ± 21%  perf-c2c.DRAM.local
    165542 ±  2%      -9.7%     149471        numa-meminfo.node1.Active
    161615            -9.0%     147100 ±  2%  numa-meminfo.node1.Active(anon)
     40405            -9.0%      36775 ±  2%  numa-vmstat.node1.nr_active_anon
     40405            -9.0%      36775 ±  2%  numa-vmstat.node1.nr_zone_active_anon
     51245 ± 35%     -42.9%      29277 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
      9910 ± 54%     -48.0%       5156 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     51247 ± 35%     -42.9%      29277 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
      9911 ± 54%     -48.0%       5156 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
    249.51            -6.7%     232.83        stress-ng.dynlib.nanosecs_per_dlsym_lookup
    287979            +7.2%     308763        stress-ng.dynlib.ops
      4799            +7.2%       5146        stress-ng.dynlib.ops_per_sec
      2343 ±  5%     -39.9%       1409 ±  5%  stress-ng.time.involuntary_context_switches
  20176141            +7.4%   21671738        stress-ng.time.minor_page_faults
    535.17            +2.6%     548.83        stress-ng.time.percent_of_cpu_this_job_got
    291.91            +2.2%     298.23        stress-ng.time.system_time
     40770            -7.3%      37774 ±  2%  proc-vmstat.nr_active_anon
      3098 ±  2%      +3.4%       3204        proc-vmstat.nr_inactive_file
     34934            -5.1%      33139        proc-vmstat.nr_mapped
     70157            -6.1%      65866        proc-vmstat.nr_shmem
     42286            -3.3%      40888        proc-vmstat.nr_slab_unreclaimable
     40770            -7.3%      37774 ±  2%  proc-vmstat.nr_zone_active_anon
      3098 ±  2%      +3.4%       3204        proc-vmstat.nr_zone_inactive_file
  15514950            -3.9%   14905053        proc-vmstat.numa_hit
  15448751            -3.9%   14838822        proc-vmstat.numa_local
    124008            -5.2%     117617        proc-vmstat.pgactivate
  18884464           -11.2%   16772814        proc-vmstat.pgalloc_normal
  20593501            +7.2%   22078068        proc-vmstat.pgfault
  18735781           -11.2%   16638429        proc-vmstat.pgfree
      0.36 ±179%     -94.5%       0.02 ± 44%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    165.10 ±215%     -97.9%       3.40 ± 37%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.13 ± 25%     -39.4%       0.08 ± 21%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     23.83 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    545.33 ±  4%     -14.0%     468.83 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.19 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.46 ±124%     -99.3%       0.00 ±146%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.09 ± 63%     -92.8%       0.01 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.11 ± 23%     -37.4%       0.07 ± 20%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      2.02 ±  6%     -29.8%       1.42 ± 44%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.56 ±104%     -99.3%       0.00 ±156%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.44 ± 81%     -98.5%       0.01 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      4.02 ±  6%     -12.3%       3.53 ±  8%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.18 ± 42%     -63.7%       0.43 ± 83%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.24 ± 22%     -44.2%       1.81 ± 19%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      4.05 ±  6%     -29.8%       2.84 ± 44%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.58           -12.8%       0.51 ±  3%  perf-stat.i.MPKI
   9185336 ±  2%     -11.2%    8152378 ±  3%  perf-stat.i.cache-misses
  51941695           -13.4%   44958941        perf-stat.i.cache-references
      1.29            -2.8%       1.26        perf-stat.i.cpi
 2.039e+10            -0.9%  2.022e+10        perf-stat.i.cpu-cycles
    107.66 ±  3%      -8.6%      98.35 ±  5%  perf-stat.i.cpu-migrations
      2258           +11.1%       2508 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.05 ±  2%      +0.0        0.06 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   2224314 ±  2%      +5.6%    2349507 ±  2%  perf-stat.i.dTLB-load-misses
      0.08            +0.0        0.08        perf-stat.i.dTLB-store-miss-rate%
   1755339            +7.6%    1889357        perf-stat.i.dTLB-store-misses
      0.78            +2.8%       0.80        perf-stat.i.ipc
      0.32            -0.8%       0.32        perf-stat.i.metric.GHz
    965.70           -11.8%     851.51        perf-stat.i.metric.K/sec
    326896            +7.3%     350610        perf-stat.i.minor-faults
     89.04            +3.5       92.53        perf-stat.i.node-load-miss-rate%
    617886 ±  7%     -34.0%     407524 ± 12%  perf-stat.i.node-loads
     49.79 ±  3%      +6.2       56.00        perf-stat.i.node-store-miss-rate%
   1915596 ±  3%      -9.6%    1731427 ±  4%  perf-stat.i.node-store-misses
   2010814 ±  4%     -29.8%    1410941 ±  2%  perf-stat.i.node-stores
    327425            +7.3%     351195        perf-stat.i.page-faults
      0.58           -13.1%       0.51 ±  3%  perf-stat.overall.MPKI
      1.30            -2.9%       1.26        perf-stat.overall.cpi
      2219           +11.8%       2482 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.05 ±  2%      +0.0        0.06 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.08            +0.0        0.08        perf-stat.overall.dTLB-store-miss-rate%
      0.77            +3.0%       0.79        perf-stat.overall.ipc
     87.69            +5.5       93.21 ±  3%  perf-stat.overall.node-load-miss-rate%
     48.82 ±  3%      +6.3       55.14 ±  2%  perf-stat.overall.node-store-miss-rate%
   9052155 ±  2%     -11.3%    8027092 ±  3%  perf-stat.ps.cache-misses
  51114488           -13.4%   44240106        perf-stat.ps.cache-references
 2.008e+10            -0.9%  1.991e+10        perf-stat.ps.cpu-cycles
    106.26 ±  3%      -8.7%      97.05 ±  5%  perf-stat.ps.cpu-migrations
   2190693 ±  2%      +5.6%    2313598 ±  2%  perf-stat.ps.dTLB-load-misses
   1728462            +7.6%    1860472        perf-stat.ps.dTLB-store-misses
    321900            +7.3%     345241        perf-stat.ps.minor-faults
    621192 ±  7%     -34.3%     407816 ± 12%  perf-stat.ps.node-loads
   1885823 ±  3%      -9.6%    1703871 ±  4%  perf-stat.ps.node-store-misses
   1978205 ±  4%     -30.0%    1385178 ±  2%  perf-stat.ps.node-stores
    322420            +7.3%     345817        perf-stat.ps.page-faults
      6.48            -4.9        1.63 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.66            -4.8        1.81 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.41            -4.8        1.57 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.06            -4.5        1.53 ±  4%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.03            -3.6        1.41 ±  5%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      9.04 ±  2%      -2.3        6.78        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      6.84 ±  2%      -1.6        5.24        perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
     72.38            -0.9       71.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     72.16            -0.9       71.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.99 ±  3%      -0.7        1.31 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.65 ±  6%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.69 ±  5%      -0.3        0.38 ± 70%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.37 ±  4%      -0.1        1.22 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      1.45 ±  4%      -0.1        1.32 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      1.69 ±  3%      -0.1        1.57 ±  6%  perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.74 ±  5%      -0.1        0.63 ±  9%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      0.67 ±  3%      +0.1        0.72        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.94 ±  3%      +0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.94 ±  3%      +0.1        1.01        perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.75 ±  4%      +0.1        0.83 ±  2%  perf-profile.calltrace.cycles-pp.rcu_segcblist_enqueue.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.89 ±  3%      +0.1        0.97 ±  2%  perf-profile.calltrace.cycles-pp.up_write.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.06 ±  4%      +0.1        1.14 ±  3%  perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.10 ±  2%      +0.1        1.20 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      1.06 ±  4%      +0.1        1.16 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.74            +0.1        1.88        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.44            +0.2        2.58 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      2.43 ±  2%      +0.2        2.60        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.79            +0.2        2.96 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe._dl_catch_exception
      2.84            +0.2        3.01 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._dl_catch_exception
      2.78            +0.2        2.95 ±  3%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe._dl_catch_exception
      2.17 ±  2%      +0.2        2.34        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.unmap_region
      2.82            +0.2        3.00 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._dl_catch_exception
      2.91 ±  2%      +0.2        3.09 ±  3%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.58 ±  6%      +0.2        1.76 ±  6%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.22 ±  2%      +0.2        2.40        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      0.26 ±100%      +0.3        0.54 ±  3%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.86 ±  4%      +0.3        2.14 ±  4%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      3.32 ±  2%      +0.3        3.60 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      2.44 ±  3%      +0.3        2.73 ±  4%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      4.31            +0.3        4.62        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.40            +0.3        5.73 ±  3%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      8.33 ±  3%      +0.4        8.68 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      8.40 ±  3%      +0.4        8.75 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.06            +0.4        7.47 ±  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      7.11            +0.4        7.53 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      8.33            +0.4        8.78 ±  2%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.94 ± 12%      +0.5        2.40 ±  3%  perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      9.37            +0.5        9.84 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     15.46            +0.5       15.94        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      9.70            +0.5       10.20        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     10.75            +0.5       11.30        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     10.79            +0.5       11.34        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      7.83            +0.6        8.43        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
     11.55            +0.6       12.16        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     20.74            +0.7       21.44        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     20.88            +0.7       21.58        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.95            +0.7       21.67        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.95            +0.7       21.67        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.74 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_free.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.49 ±  2%      +0.8        4.31        perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      3.96            +0.8        4.78        perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
     11.55            +0.9       12.50 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
     11.78            +1.0       12.74 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     23.77            +1.3       25.09        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.46            +1.3       22.79        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     22.25            +1.3       23.58        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.91            +1.3       25.25        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.68            +1.5       16.19        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     14.99            +1.6       16.54        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.95            +1.7       19.64        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.05            +1.7       19.74        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.5        2.54 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.release_empty_file.path_openat.do_filp_open
      0.00            +2.6        2.56 ±  5%  perf-profile.calltrace.cycles-pp.security_file_free.release_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.00            +3.2        3.21 ±  4%  perf-profile.calltrace.cycles-pp.release_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      6.53            -4.9        1.67 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      6.44            -4.9        1.58 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      6.72            -4.8        1.88 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      6.10            -4.6        1.54 ±  4%  perf-profile.children.cycles-pp.task_work_run
      5.05            -3.6        1.42 ±  5%  perf-profile.children.cycles-pp.__fput
      7.18 ±  2%      -2.6        4.60 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      6.77 ±  2%      -2.6        4.20 ±  4%  perf-profile.children.cycles-pp.rcu_core
      6.72 ±  2%      -2.6        4.17 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      7.08 ±  2%      -2.5        4.59 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      9.07 ±  2%      -2.3        6.81        perf-profile.children.cycles-pp.alloc_empty_file
     10.42            -2.1        8.34 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     10.17            -2.1        8.09 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      6.86 ±  2%      -1.6        5.26        perf-profile.children.cycles-pp.init_file
      3.66 ±  4%      -0.9        2.80 ±  4%  perf-profile.children.cycles-pp.apparmor_file_free_security
      3.70 ±  4%      -0.9        2.84 ±  5%  perf-profile.children.cycles-pp.security_file_free
      1.21 ±  3%      -0.7        0.50 ±  7%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      1.55 ±  2%      -0.6        0.94 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      4.97 ±  2%      -0.6        4.38 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.62 ±  2%      -0.6        2.05 ±  4%  perf-profile.children.cycles-pp.__slab_free
      2.26            -0.5        1.71        perf-profile.children.cycles-pp.__call_rcu_common
      0.58 ±  6%      -0.5        0.10 ± 19%  perf-profile.children.cycles-pp.file_free_rcu
      0.63 ±  2%      -0.4        0.18 ±  4%  perf-profile.children.cycles-pp.fput
      0.38 ±  4%      -0.3        0.08 ± 12%  perf-profile.children.cycles-pp.task_work_add
      0.66 ±  2%      -0.3        0.37 ±  7%  perf-profile.children.cycles-pp.allocate_slab
      0.46 ±  3%      -0.2        0.27 ±  8%  perf-profile.children.cycles-pp.shuffle_freelist
      0.29 ±  5%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.inc_slabs_node
      0.18 ±  5%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.17 ± 10%      -0.1        0.07 ± 48%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.15 ± 10%      -0.1        0.06 ± 51%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.20 ±  3%      -0.1        0.12 ±  9%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.20 ±  7%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__unfreeze_partials
      1.16 ±  2%      -0.1        1.10        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.29 ±  5%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.refill_obj_stock
      0.22 ±  4%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.14 ± 10%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.setup_object
      0.18 ±  7%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.09 ± 14%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.free_unref_page
      0.09 ±  7%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.cp_new_stat
      0.20 ±  9%      +0.0        0.24 ±  9%  perf-profile.children.cycles-pp.generic_file_mmap
      0.53 ±  4%      +0.0        0.57 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.27 ±  5%      +0.0        0.31 ±  6%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.16 ± 12%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.put_unused_fd
      0.24 ±  6%      +0.1        0.29 ±  7%  perf-profile.children.cycles-pp.path_init
      0.26 ±  7%      +0.1        0.31 ± 10%  perf-profile.children.cycles-pp.inode_permission
      0.01 ±223%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.62 ±  3%      +0.1        0.67 ±  3%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.11 ± 31%      +0.1        0.18 ± 17%  perf-profile.children.cycles-pp.tick_sched_do_timer
      1.06 ±  4%      +0.1        1.15 ±  3%  perf-profile.children.cycles-pp.vma_expand
      0.12 ± 22%      +0.1        0.21 ± 28%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.14 ±  2%      +0.1        1.24 ±  2%  perf-profile.children.cycles-pp.release_pages
      1.09 ±  4%      +0.1        1.19 ±  2%  perf-profile.children.cycles-pp.link_path_walk
      2.12 ±  2%      +0.1        2.24 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.51 ±  5%      +0.1        0.64 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      1.75            +0.1        1.90        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      3.61 ±  2%      +0.2        3.77 ±  2%  perf-profile.children.cycles-pp._dl_catch_exception
      2.66 ±  2%      +0.2        2.83        perf-profile.children.cycles-pp.flush_tlb_mm_range
      2.91 ±  2%      +0.2        3.09 ±  3%  perf-profile.children.cycles-pp.mprotect_fixup
      3.36            +0.2        3.54        perf-profile.children.cycles-pp.vma_complete
      2.28            +0.2        2.46        perf-profile.children.cycles-pp.kmem_cache_free
      2.32 ±  2%      +0.2        2.51        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      3.38            +0.2        3.58 ±  2%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      3.38            +0.2        3.58 ±  2%  perf-profile.children.cycles-pp.do_mprotect_pkey
      2.41 ±  2%      +0.2        2.62        perf-profile.children.cycles-pp.flush_tlb_func
      3.09 ±  2%      +0.2        3.33 ±  2%  perf-profile.children.cycles-pp.up_write
      3.12 ±  2%      +0.3        3.37 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      4.52            +0.3        4.83        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.21 ± 62%      +0.4        0.57 ± 60%  perf-profile.children.cycles-pp.tick_irq_enter
      5.76            +0.4        6.13 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      4.70 ±  2%      +0.5        5.15 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      7.52            +0.5        7.98 ±  2%  perf-profile.children.cycles-pp.filemap_map_pages
      7.56            +0.5        8.03 ±  2%  perf-profile.children.cycles-pp.do_read_fault
      8.78            +0.5        9.27 ±  2%  perf-profile.children.cycles-pp.do_fault
      9.84            +0.5       10.37        perf-profile.children.cycles-pp.__handle_mm_fault
     10.18            +0.6       10.74        perf-profile.children.cycles-pp.handle_mm_fault
     11.30            +0.6       11.90        perf-profile.children.cycles-pp.exc_page_fault
     11.27            +0.6       11.87        perf-profile.children.cycles-pp.do_user_addr_fault
     12.10            +0.7       12.76        perf-profile.children.cycles-pp.asm_exc_page_fault
     20.95            +0.7       21.67        perf-profile.children.cycles-pp.__vm_munmap
     20.95            +0.7       21.67        perf-profile.children.cycles-pp.__x64_sys_munmap
     10.11            +0.7       10.85        perf-profile.children.cycles-pp.__split_vma
     18.12            +0.8       18.88        perf-profile.children.cycles-pp.unmap_region
      3.51 ±  2%      +0.8        4.34        perf-profile.children.cycles-pp.apparmor_file_alloc_security
      3.98            +0.8        4.81        perf-profile.children.cycles-pp.security_file_alloc
     24.22            +1.3       25.56        perf-profile.children.cycles-pp.vm_mmap_pgoff
     22.69            +1.3       24.04        perf-profile.children.cycles-pp.do_mmap
     21.92            +1.4       23.27        perf-profile.children.cycles-pp.mmap_region
     23.92            +1.4       25.27        perf-profile.children.cycles-pp.ksys_mmap_pgoff
     14.74            +1.5       16.27        perf-profile.children.cycles-pp.path_openat
     15.02            +1.6       16.58        perf-profile.children.cycles-pp.do_filp_open
     32.60            +1.7       34.26        perf-profile.children.cycles-pp.do_vmi_align_munmap
     32.93            +1.7       34.60        perf-profile.children.cycles-pp.do_vmi_munmap
     18.02            +1.7       19.71        perf-profile.children.cycles-pp.do_sys_openat2
     18.07            +1.7       19.77        perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +3.2        3.22 ±  4%  perf-profile.children.cycles-pp.release_empty_file
      2.63 ±  4%      -2.2        0.41 ±  6%  perf-profile.self.cycles-pp.init_file
      3.44 ±  4%      -0.8        2.68 ±  4%  perf-profile.self.cycles-pp.apparmor_file_free_security
      1.20 ±  3%      -0.7        0.49 ±  7%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.54 ±  2%      -0.5        2.01 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.57 ±  6%      -0.5        0.09 ± 13%  perf-profile.self.cycles-pp.file_free_rcu
      0.78 ±  3%      -0.3        0.44 ±  4%  perf-profile.self.cycles-pp.__call_rcu_common
      0.30 ±  6%      -0.2        0.07 ± 14%  perf-profile.self.cycles-pp.task_work_add
      0.42 ±  6%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.___slab_alloc
      0.28 ±  5%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.inc_slabs_node
      0.34 ±  6%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.shuffle_freelist
      0.23 ±  3%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.fput
      0.16 ±  5%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ±  4%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.rcu_nocb_try_bypass
      1.13 ±  2%      -0.1        1.08        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.27 ±  4%      -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.refill_obj_stock
      0.10 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.11 ±  8%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.rcu_do_batch
      0.11 ±  4%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.mas_walk
      0.07 ± 16%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.atime_needs_update
      0.21 ±  5%      +0.0        0.25 ±  6%  perf-profile.self.cycles-pp.vm_area_dup
      0.89            +0.0        0.93        perf-profile.self.cycles-pp.zap_pte_range
      0.40 ±  5%      +0.0        0.44 ±  2%  perf-profile.self.cycles-pp.__split_vma
      0.44 ±  3%      +0.0        0.48 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.15 ±  8%      +0.0        0.20 ±  7%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.17 ± 11%      +0.0        0.22 ±  7%  perf-profile.self.cycles-pp.path_init
      0.52 ±  3%      +0.0        0.57 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.20 ±  8%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.01 ±223%      +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.49 ±  4%      +0.1        0.55 ±  4%  perf-profile.self.cycles-pp.free_swap_cache
      0.60 ±  5%      +0.1        0.66 ±  3%  perf-profile.self.cycles-pp.mmap_region
      0.74 ±  3%      +0.1        0.81        perf-profile.self.cycles-pp._raw_spin_lock
      0.08 ± 53%      +0.1        0.15 ± 20%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.11 ± 24%      +0.1        0.19 ± 29%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.35 ± 11%      +0.1        0.44 ±  5%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.44 ±  7%      +0.1        0.58 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      1.33 ±  2%      +0.2        1.48 ±  3%  perf-profile.self.cycles-pp.down_write
      1.92 ±  2%      +0.2        2.09 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      2.29 ±  2%      +0.2        2.48        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      1.34            +0.2        1.58 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      2.90 ±  2%      +0.2        3.14 ±  2%  perf-profile.self.cycles-pp.up_write
      0.00            +0.3        0.26 ±  3%  perf-profile.self.cycles-pp.release_empty_file
      2.89            +0.3        3.20 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      2.54 ±  3%      +0.3        2.85 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      5.28            +0.4        5.73 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      3.22            +0.9        4.07        perf-profile.self.cycles-pp.apparmor_file_alloc_security




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


