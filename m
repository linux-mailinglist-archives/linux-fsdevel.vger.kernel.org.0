Return-Path: <linux-fsdevel+bounces-1228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB557D7E72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 10:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F1281EEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEE1A5A2;
	Thu, 26 Oct 2023 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjnLOxdX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA21A587
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 08:26:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A5192
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698308789; x=1729844789;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=mD1p3m0hSVxx2PFGKEYhwCbQQNX2zKi1WYhn+utPyic=;
  b=PjnLOxdXlfCTVLE1kMxY2ArcgFpyDJAtMW35KEsmg5Y8hC+G2Kfi1xGR
   WptKQU3zGTpEmAesFJ7xtYKwPPcUoWj8OTr8QR4C1idq21eRTtDpXk1qo
   bnE88XXHOlwoxJcMxgV/OD1GSq1C2wVFtDPw2zIsmG78OPUQxRVzJjFrY
   xmVE0wDeWAgJqAvKDj6ktA7ERvzSq89qhxhNR6z1xJw2lIVUG+BVehbv4
   quotrh1dKaXswOL6hRx/TDYteCN/xdiLR+zbqCspM8oLDbRozr5w2Reae
   1Qe+RPo50+qn5mdo0fLli4hABe46WL7NY0klz3QN+UTjrvqvyrp9rQ/uE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366836193"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366836193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875845040"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="875845040"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 01:26:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:26:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:26:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 01:26:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 01:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTwUf1HUyrfr5NMfHedRnqt+MHbwJ5wkswMFc+zUNIXk/2A3TB04qogvAQsmRM8uBfpiKXCI4Qljtav4aRXpVfMaFpHZtxoSgGpx5SYX6QfNNFP11IUUD92EBAOPbHUgK9LUnsyMDzBUblgYPsAbHk1JMIQegiiXIyaPtqdbjK+MeJVMWup5lvVE7jbxHDTLoJN+15lwA/u/F25zlrCv6hY3nYfuKGszfg6x4e49I08iI4d7MBQf3xzeKMht3NKlLsTixAuGS9GVl+qT9yq3h1U9edJYERHdq3YgoKIIIlDU7/TD8PD2C6bBqSzwCGw7Qxm7Bpdb/zNDZO+yjHpuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsfHxyVh1MACboiFOrR43p7uCExhwRddYz8o/EebjeA=;
 b=i5lutMuNhpQ14qv2hYwu/L4FZhMYqaf1sOXituEhdMXLTWLTfMAWilFlOfFnv2jMdD4y5yS0olT0MV4uiaY/P4McOVm6m1arTc8LHG+KnUHE16u0atVMzO9zopUQsObuoMBEMIMZNqx9QP4RDtWwdGkF8SjBWUFCG7aY0FrOM5sS+FwGJFlJ/XNBtwW6s/4libqlPEirPH/dNPpT/xLNXwYLZZNcKey0BiYubHPyfNoYr5DYUuVBz/q5GeAnw7pbF5ckG+PIwW/W9YS0tdAghreMclUQraDubVRUNNrOynV3bATsKEJA0UgNEFju875gf7HnEtAykjMZ1cKJCRGKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 08:26:10 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:26:09 +0000
Date: Thu, 26 Oct 2023 16:26:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.misc.backing_file] [fs/pipe]  cc03a5d65a:
 stress-ng.pipeherd.ops_per_sec -22.9% regression
Message-ID: <202310261611.90b9e38c-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: adec3b21-2d38-4c49-fa7c-08dbd5fd34b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fZ+D8goxIASsZ3Sy4HntH6I3x6UOjGy5/DdEReUW36sXETBqZI0VP44nHKWpt7GeXeg02bocXm+OesJc82VEhITVcSWl3S6aYSPKRGjXNC+oRXYs8NWcabxo6xxNW2XdjlYb99eHXdcustpC+4unU6yMCRW9YiPX798/VbNSV/b5+zV6zgvgSfkOnDFeOrPPIcaE65B3yOaO/eTaoDMlNICJu2z7ue4KxqS5cOB70NNGKd08OABqKhkWT0n46cHkFPnouAVQSbkpxkgqirgbr7z3k273a3T+jmASJFu/4fgaYusp1dk21F75GuFDx+5KMdXMlaE7H89J7VoMfRDVxI+ntG6ij6qzhoiXc1VikWBareS9J/CR2OSnbXNujzSw0xnv2OZIdy2WwQbor6aCtE6776g35l03m9aQV3YHFffpjUDgNXRFTvKMplCge+lRYtqONsoK2axShXtelCEYFt01OjwN7ffFhNCBuWDkzF2o3ubWp/v02U7sKH0Uwjd1rs3wohBqEPN10akddu8cXxn0psBHuGv8vVWu9W/Z0QvqZwfkqIxX5hW976QZvqdNVA20ZOjv9QV7cC+FepqzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(36756003)(6506007)(6666004)(6512007)(26005)(1076003)(107886003)(86362001)(38100700002)(2616005)(82960400001)(54906003)(8936002)(966005)(8676002)(41300700001)(4326008)(478600001)(5660300002)(2906002)(30864003)(6486002)(66946007)(66556008)(66476007)(6916009)(316002)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Xf+6ggiVwNxl2XmKJeAHo8QoK/W8IsF7g/XiraMtRqczW+2EHUV7S3qlMw?=
 =?iso-8859-1?Q?P7Utw+VzaZ0k0JxexcL83RDPzVlTXctTtawsD8D799FFq2w3Xz6oKrkG+i?=
 =?iso-8859-1?Q?r+/NYn3IBg8u1g9feOeGfup3KNF2x1iA4SPo2iwBNh19NFfl3lQhnMuzzZ?=
 =?iso-8859-1?Q?2JOpPJJvm96XYo8MpWV6/Y0nOJ8PXaid/varHdSQVGMWgl7YXm54cR7LWF?=
 =?iso-8859-1?Q?MDMJGAuahxnwp9oHhdEgy0A3vgrFS2keDff63MkL21hvqCOt3CbS+rT5Oy?=
 =?iso-8859-1?Q?qVWKLokNcDPJH2S3lisnC59hClJAdkfe/ln5NYcZ+NuWqW0GkkY3Mgm9YF?=
 =?iso-8859-1?Q?FUFBAsTX9PGOmdNkukgJR+iQEt0iwB6/a5gwSICJgQ4ZEkTWD1gx300wE5?=
 =?iso-8859-1?Q?ixt1UlAYaBVR63yA0LIGyMuAu/tYlPNMra8hsezfcw2At1VB1O2jO96hoX?=
 =?iso-8859-1?Q?uD8GoWULdtRfnJxj2Lo0UXbjU1XFZ73YIf1HaoqtppKYo982UvslwKcFIc?=
 =?iso-8859-1?Q?4pDZlnaoZW8QtETDQszOGhPr9Gp1/eaL46/ckNvkn6XsfwueZBjdu79FKs?=
 =?iso-8859-1?Q?hokyQD42VH/u363TTdcfpHBoThRUdzF/tiQ72gIufu6WLYFXGqPmCNNJwb?=
 =?iso-8859-1?Q?k5Dfdhoz193zD9XbEpGpfmt3OKpVXMiT39mlIf/9aoUSgqsTO8UemTV+Ly?=
 =?iso-8859-1?Q?EapxsUEwmWDUNXlGUSRJHNGA4jVad56FEvl54CrBuGVDVqSWvwrMn+T9Xk?=
 =?iso-8859-1?Q?Oxr6lJPF5xHf3gVoPyjlcdju5RQwe1mJ44Fxvn0M2Z4bnFup7e3NRiCuIp?=
 =?iso-8859-1?Q?HsZ5r8jsrJzr332VAm6Kq8nLosAH4C4HMMYXjIN70FU3P84U8IC0vQrA6h?=
 =?iso-8859-1?Q?IMv56PzrbVLTVKIBrUe9qFfb2F7eLTXKAaKTQSkg6yWvX+BOG9foUKBUUp?=
 =?iso-8859-1?Q?gcmD0Bcs1IOO/pmzWEYcTjemVgnBVj0/hEmjr8rujO2w+ugQDhjvUaprci?=
 =?iso-8859-1?Q?ZYSiXezo6OKvGMdYtQ+qY8lB0+RTA1lotyXThbhWVOwCWTxWPe4QwHboaw?=
 =?iso-8859-1?Q?pw8Wx2yTsSJwpYSmksqHllTDb+iBkVKkQSHeKFcGxLZZLnJEO4BXZLhfmu?=
 =?iso-8859-1?Q?tSZrQ7blK0ehI+LiQ5nvixE8j0UGtP6MCuIniniTdVr2ShJt+Zo/4dPQLK?=
 =?iso-8859-1?Q?jlDYRmTyj7cVXh+gMlkqK2svEpB+ejaITMTh3LBM3DwEDPaZKybxjIsdH1?=
 =?iso-8859-1?Q?C9R53n7PXw2JOjFKU2b5gx9Wp85o9Phk/0rnjl3cEJfQZnHaPopiJCe4KO?=
 =?iso-8859-1?Q?BXNKJ2CEGJdAbUSuQyPL+RYcdcZseMmnTHGiG8XHy9+6+kE2LiHSoy7UyU?=
 =?iso-8859-1?Q?AkptNe8OzMMY3PfJ+/giza9jQstFmPezwo0WMXgl0N7o2s8pHwCTJ2d8EG?=
 =?iso-8859-1?Q?9u46TO2aukbLWgcX1AhxGrZZ1+fhs8suWclc+ZhkNFkMIdbMWBKkhz8ipP?=
 =?iso-8859-1?Q?2pQ3r1JKwm8oXymqlctydeM3GGQlOBogjPnWWhI/SYZmDyK6h14G1FiMem?=
 =?iso-8859-1?Q?7N0tlvvaPmgun7nK61zRSr5EoMqZEhgt40RO057pxwhMjtNuaWa3/Qvx2w?=
 =?iso-8859-1?Q?xcH/EDtKDGOxs7ew+hsUupbS6+9FhbDp1uddOkxCjyAw7+eD2DSFQXIg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adec3b21-2d38-4c49-fa7c-08dbd5fd34b5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:26:09.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32tZsgQ8GAEXOv+pPk4jCRX2xxj0akVKZIfzVwxw+Q1BJJhMkvi0vwDOyb50QakNFovd7HwF/Sj123FoF3LPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -22.9% regression of stress-ng.pipeherd.ops_per_sec on:


commit: cc03a5d65a4032f8c53940927343c1795f2d2c53 ("fs/pipe: remove unnecessary spinlock from pipe_write()")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.backing_file

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: pipeherd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec -34.2% regression                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=memory                                                                                    |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec -36.9% regression                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=pipe                                                                                      |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261611.90b9e38c-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261611.90b9e38c-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/pipeherd/stress-ng/60s

commit: 
  c2da67ba32 ("fs/pipe: move check to pipe_has_watch_queue()")
  cc03a5d65a ("fs/pipe: remove unnecessary spinlock from pipe_write()")

c2da67ba32de1205 cc03a5d65a4032f8c5394092734 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    778.00 ± 10%     +30.1%       1011 ± 13%  perf-c2c.HITM.remote
 2.662e+09           -11.5%  2.356e+09        cpuidle..time
 1.026e+08           -22.9%   79040167        cpuidle..usage
     72.78           -11.7%      64.28        iostat.cpu.idle
     25.57           +33.4%      34.11        iostat.cpu.system
     72.02            -8.8       63.26        mpstat.cpu.all.idle%
     25.25            +8.8       34.02        mpstat.cpu.all.sys%
    787485 ±  8%     -52.5%     373825 ± 22%  numa-meminfo.node1.Inactive
    784808 ±  8%     -52.9%     369663 ± 21%  numa-meminfo.node1.Inactive(anon)
    717330 ± 14%     -31.2%     493788 ± 11%  numa-meminfo.node1.Mapped
    196064 ±  8%     -52.9%      92385 ± 21%  numa-vmstat.node1.nr_inactive_anon
    178925 ± 14%     -31.2%     123180 ± 11%  numa-vmstat.node1.nr_mapped
    196064 ±  8%     -52.9%      92385 ± 21%  numa-vmstat.node1.nr_zone_inactive_anon
     72.81           -11.7%      64.32        vmstat.cpu.id
     17.55           +28.3%      22.51        vmstat.procs.r
   3092838           -22.8%    2386725        vmstat.system.cs
   1065579 ±  6%     -45.1%     584852 ±  4%  meminfo.Inactive
   1052573 ±  6%     -45.6%     572348 ±  5%  meminfo.Inactive(anon)
   1007116 ± 10%     -26.2%     742992 ±  8%  meminfo.Mapped
   3463885           -13.9%    2984003        meminfo.Shmem
    283758           -22.9%     218806        stress-ng.pipeherd.context_switches_per_sec
 1.022e+08           -22.9%   78780775        stress-ng.pipeherd.ops
   1701727           -22.9%    1312011        stress-ng.pipeherd.ops_per_sec
      2103 ± 11%     +39.6%       2937 ±  4%  stress-ng.time.involuntary_context_switches
     21062 ±  2%      +4.9%      22098        stress-ng.time.minor_page_faults
      1696           +30.0%       2205        stress-ng.time.percent_of_cpu_this_job_got
      1027           +30.7%       1343        stress-ng.time.system_time
 1.022e+08           -22.9%   78774202        stress-ng.time.voluntary_context_switches
   1576409            -7.6%    1456298        proc-vmstat.nr_file_pages
    262943 ±  6%     -45.6%     143033 ±  5%  proc-vmstat.nr_inactive_anon
    251413 ± 10%     -26.3%     185193 ±  8%  proc-vmstat.nr_mapped
    866081           -13.8%     746129        proc-vmstat.nr_shmem
     26465            -1.2%      26152        proc-vmstat.nr_slab_reclaimable
    262943 ±  6%     -45.6%     143033 ±  5%  proc-vmstat.nr_zone_inactive_anon
   1670139           -10.1%    1501215        proc-vmstat.numa_hit
   1603701           -10.5%    1434878        proc-vmstat.numa_local
    507432 ±  4%     -54.6%     230184 ±  6%  proc-vmstat.pgactivate
   1720388            -9.8%    1551151        proc-vmstat.pgalloc_normal
      1219           +16.3%       1418        turbostat.Avg_MHz
     39.46            +6.5       45.91        turbostat.Busy%
    658896           -28.0%     474622 ±  3%  turbostat.C1
      0.29            -0.1        0.23 ±  5%  turbostat.C1%
 1.016e+08           -23.0%   78286180        turbostat.C1E
     58.43            -6.9       51.50        turbostat.C1E%
     60.16           -10.7%      53.74        turbostat.CPU%c1
      0.11           -18.2%       0.09        turbostat.IPC
     62151 ±  2%     -14.8%      52979 ±  4%  turbostat.POLL
      0.05            -0.0        0.04        turbostat.POLL%
    195.43            +1.3%     197.92        turbostat.PkgWatt
      0.01 ± 19%     -41.7%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.00 ±102%    +159.1%       0.01 ± 19%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.73           +18.9%       0.87        perf-sched.total_wait_and_delay.average.ms
   5060558           -16.6%    4220876 ±  2%  perf-sched.total_wait_and_delay.count.ms
      0.73           +18.9%       0.86        perf-sched.total_wait_time.average.ms
      0.60           +18.9%       0.71        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.04 ± 12%     +22.2%      15.94 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
   5057970           -16.6%    4218184 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     44.00 ±  8%     +15.2%      50.67 ±  6%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    379.17 ± 11%     -18.9%     307.67 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.58 ±  5%     +17.8%       0.69 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.56           +20.0%       0.67 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.59           +19.0%       0.71        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.04 ± 11%     +22.2%      15.93 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.32 ± 97%    +147.0%       0.79 ± 13%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.88 ±  4%     +12.3%       0.99 ±  3%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    166297           +61.3%     268240        sched_debug.cfs_rq:/.avg_vruntime.avg
    231329 ±  9%     +44.3%     333772 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
    150766 ±  2%     +66.4%     250808        sched_debug.cfs_rq:/.avg_vruntime.min
     10725 ± 49%     +80.4%      19346 ±  9%  sched_debug.cfs_rq:/.left_vruntime.avg
    172975 ±  5%     +57.8%     272988 ±  2%  sched_debug.cfs_rq:/.left_vruntime.max
     38807 ± 28%     +77.8%      68992 ±  4%  sched_debug.cfs_rq:/.left_vruntime.stddev
    166297           +61.3%     268240        sched_debug.cfs_rq:/.min_vruntime.avg
    231329 ±  9%     +44.3%     333772 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
    150766 ±  2%     +66.4%     250808        sched_debug.cfs_rq:/.min_vruntime.min
     10725 ± 49%     +80.4%      19346 ±  9%  sched_debug.cfs_rq:/.right_vruntime.avg
    172975 ±  5%     +57.8%     272988 ±  2%  sched_debug.cfs_rq:/.right_vruntime.max
     38807 ± 28%     +77.8%      68992 ±  4%  sched_debug.cfs_rq:/.right_vruntime.stddev
     90.17 ± 13%     +52.7%     137.67 ± 12%  sched_debug.cfs_rq:/.runnable_avg.min
     90.00 ± 13%     +52.8%     137.50 ± 12%  sched_debug.cfs_rq:/.util_avg.min
   1508534           -22.9%    1162519        sched_debug.cpu.nr_switches.avg
   1640132           -22.9%    1264186        sched_debug.cpu.nr_switches.max
     97105 ± 15%     -43.9%      54506 ± 13%  sched_debug.cpu.nr_switches.stddev
      0.54 ±  6%     +32.4%       0.71 ±  9%  perf-stat.i.MPKI
 5.147e+09            -7.2%  4.778e+09        perf-stat.i.branch-instructions
      1.09            +0.2        1.26        perf-stat.i.branch-miss-rate%
  52417466            +7.9%   56552058        perf-stat.i.branch-misses
 2.124e+08           +12.3%  2.386e+08        perf-stat.i.cache-references
   3264917           -23.0%    2513625        perf-stat.i.context-switches
      3.51           +23.1%       4.32        perf-stat.i.cpi
 8.662e+10           +13.1%  9.794e+10        perf-stat.i.cpu-cycles
    442935            +6.8%     472961        perf-stat.i.cpu-migrations
 6.922e+09            -8.7%  6.321e+09        perf-stat.i.dTLB-loads
      0.00 ± 19%      +0.0        0.01 ± 11%  perf-stat.i.dTLB-store-miss-rate%
  3.81e+09           -15.5%   3.22e+09        perf-stat.i.dTLB-stores
 2.547e+10            -8.0%  2.342e+10        perf-stat.i.instructions
      0.32           -16.2%       0.27        perf-stat.i.ipc
      1.35           +13.0%       1.53        perf-stat.i.metric.GHz
    251.40            -9.5%     227.40        perf-stat.i.metric.M/sec
   6819916 ±  9%     +27.5%    8696988 ± 10%  perf-stat.i.node-load-misses
     21.95            +3.4       25.34        perf-stat.i.node-store-miss-rate%
   1122377 ±  8%     +48.0%    1660751 ±  9%  perf-stat.i.node-store-misses
      0.60 ±  6%     +28.3%       0.77 ±  8%  perf-stat.overall.MPKI
      1.02            +0.2        1.18        perf-stat.overall.branch-miss-rate%
      3.40           +22.9%       4.18        perf-stat.overall.cpi
      0.00 ± 20%      +0.0        0.01 ± 12%  perf-stat.overall.dTLB-store-miss-rate%
      0.29           -18.7%       0.24        perf-stat.overall.ipc
     15.98 ±  3%      +4.7       20.64 ±  2%  perf-stat.overall.node-store-miss-rate%
 5.065e+09            -7.2%  4.701e+09        perf-stat.ps.branch-instructions
  51610014            +7.8%   55649750        perf-stat.ps.branch-misses
 2.092e+08           +12.3%  2.349e+08        perf-stat.ps.cache-references
   3213077           -23.0%    2474071        perf-stat.ps.context-switches
 8.526e+10           +13.1%   9.64e+10        perf-stat.ps.cpu-cycles
    436083            +6.8%     465607        perf-stat.ps.cpu-migrations
 6.812e+09            -8.7%   6.22e+09        perf-stat.ps.dTLB-loads
 3.749e+09           -15.5%  3.169e+09        perf-stat.ps.dTLB-stores
 2.506e+10            -8.0%  2.305e+10        perf-stat.ps.instructions
   6717977 ±  9%     +27.4%    8558009 ± 10%  perf-stat.ps.node-load-misses
   1104522 ±  8%     +47.9%    1633578 ±  9%  perf-stat.ps.node-store-misses
 1.574e+12            -8.2%  1.444e+12        perf-stat.total.instructions
     35.82           -10.1       25.74        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     35.35           -10.0       25.32        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     35.33           -10.0       25.31        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.30           -10.0       25.29        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.64            -6.5       15.14        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     20.29            -6.1       14.15        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.14            -6.1       14.04        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     18.74            -5.8       12.98        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     14.01            -2.0       11.98        perf-profile.calltrace.cycles-pp.write
     13.62            -2.0       11.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     13.56            -2.0       11.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.39            -2.0       11.43        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.24            -1.9       11.30        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.94            -1.9       11.08        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.78 ±  2%      -1.8        5.93        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.03 ±  2%      -1.6        5.42 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.00 ± 14%      -1.5        1.50 ± 40%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      3.02 ± 14%      -1.5        1.51 ± 39%  perf-profile.calltrace.cycles-pp.__cmd_record
      3.01 ± 14%      -1.5        1.50 ± 39%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      2.99 ± 14%      -1.5        1.49 ± 40%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      4.96            -1.4        3.57        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.88            -1.4        3.52        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      6.05 ±  2%      -1.3        4.75 ±  2%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      5.96            -1.3        4.68        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      6.18            -1.2        4.94        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      5.73            -1.2        4.50        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      4.84 ±  2%      -1.0        3.87 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      4.75 ±  2%      -1.0        3.80 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      4.28 ±  3%      -0.9        3.37 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
     11.45 ±  3%      -0.9       10.56 ±  2%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.05 ±  3%      -0.9        3.18 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      3.94 ±  3%      -0.9        3.08 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
     11.15 ±  3%      -0.8       10.30 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      3.63 ±  3%      -0.8        2.82 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.34 ± 14%      -0.8        0.55 ± 78%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      1.34 ± 14%      -0.8        0.55 ± 78%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      1.10 ± 14%      -0.8        0.32 ±104%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      1.31 ± 14%      -0.8        0.54 ± 78%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      1.62 ±  4%      -0.6        1.06 ±  4%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entity.dequeue_task_fair.__schedule.schedule
      2.04            -0.6        1.49        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.39 ±  4%      -0.5        0.91 ±  3%  perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.66            -0.4        1.24        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.12            -0.4        0.71 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.15 ±  3%      -0.4        0.78 ±  4%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.85 ±  2%      -0.3        0.57 ±  2%  perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.52            -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
      1.08            -0.3        0.82        perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
      1.17 ±  2%      -0.2        0.92 ±  2%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.78 ±  2%      -0.2        0.54 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.53 ±  3%      -0.2        1.31 ±  4%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.90 ±  2%      -0.2        0.68 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.20            -0.2        7.00        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.49 ±  2%      -0.1        1.38        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.19            -0.1        1.09        perf-profile.calltrace.cycles-pp.__list_add_valid_or_report.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      0.67            -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.62            -0.0        0.57 ±  2%  perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.81            +0.0        0.84 ±  2%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.66 ±  2%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.52 ±  2%      +0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.04            +0.3        1.35 ±  2%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.24            +0.4        1.69        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      0.00            +0.7        0.65        perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.finish_wait.pipe_read.vfs_read.ksys_read
     12.14            +0.7       12.89        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.97            +1.0        3.96        perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_read.vfs_read.ksys_read
      0.86            +1.0        1.86 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.83 ±  2%      +1.1        1.88        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      0.94 ±  2%      +1.1        2.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      7.71            +1.1        8.80        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      6.43            +1.3        7.72        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      0.00            +1.3        1.34 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_write.vfs_write.ksys_write
      2.92            +1.4        4.29        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read
      3.37            +1.4        4.74        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.55            +4.6        7.13        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      4.79            +5.0        9.76        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
      4.96            +5.2       10.16        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      5.30            +5.5       10.85        perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.64            +6.6       13.20        perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
     45.63           +13.8       59.44        perf-profile.calltrace.cycles-pp.read
     43.85           +14.0       57.82        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     43.66           +14.0       57.66        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     44.60           +14.0       58.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     44.75           +14.0       58.75        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     43.30           +14.1       57.37        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.82           -10.1       25.74        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.82           -10.1       25.74        perf-profile.children.cycles-pp.cpu_startup_entry
     35.80           -10.1       25.72        perf-profile.children.cycles-pp.do_idle
     35.35           -10.0       25.32        perf-profile.children.cycles-pp.start_secondary
     21.94            -6.5       15.40        perf-profile.children.cycles-pp.cpuidle_idle_call
     20.57            -6.2       14.38        perf-profile.children.cycles-pp.cpuidle_enter
     20.46            -6.2       14.30        perf-profile.children.cycles-pp.cpuidle_enter_state
     18.98            -5.8       13.19        perf-profile.children.cycles-pp.intel_idle
     16.17 ±  2%      -2.2       13.94        perf-profile.children.cycles-pp.__schedule
     14.09            -2.1       12.04        perf-profile.children.cycles-pp.write
     13.42            -2.0       11.45        perf-profile.children.cycles-pp.ksys_write
     13.27            -1.9       11.32        perf-profile.children.cycles-pp.vfs_write
     12.97            -1.9       11.10        perf-profile.children.cycles-pp.pipe_write
      7.88            -1.9        6.03        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      7.22 ±  2%      -1.6        5.59        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.04 ± 14%      -1.5        1.53 ± 39%  perf-profile.children.cycles-pp.__cmd_record
      3.01 ± 14%      -1.5        1.50 ± 39%  perf-profile.children.cycles-pp.record__finish_output
      3.01 ± 14%      -1.5        1.50 ± 39%  perf-profile.children.cycles-pp.perf_session__process_events
      3.00 ± 14%      -1.5        1.50 ± 39%  perf-profile.children.cycles-pp.reader__read_event
      5.04            -1.4        3.64        perf-profile.children.cycles-pp.schedule_idle
      6.20 ±  2%      -1.3        4.89 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      5.96            -1.3        4.68        perf-profile.children.cycles-pp.autoremove_wake_function
      6.19            -1.2        4.94        perf-profile.children.cycles-pp.__wake_up_common
      5.75            -1.2        4.52        perf-profile.children.cycles-pp.try_to_wake_up
      3.09 ±  4%      -1.0        2.06 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      4.98 ±  2%      -1.0        3.99 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.89 ±  2%      -1.0        3.94 ±  2%  perf-profile.children.cycles-pp.activate_task
      5.70            -0.9        4.78        perf-profile.children.cycles-pp._raw_spin_lock_irq
      4.23 ±  3%      -0.9        3.33 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
     11.47 ±  3%      -0.9       10.57 ±  2%  perf-profile.children.cycles-pp.schedule
      4.31 ±  3%      -0.9        3.41 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      4.00 ±  3%      -0.8        3.15 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      3.78 ±  3%      -0.8        2.96 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      1.34 ± 14%      -0.7        0.68 ± 39%  perf-profile.children.cycles-pp.perf_session__process_user_event
      1.34 ± 14%      -0.7        0.69 ± 39%  perf-profile.children.cycles-pp.__ordered_events__flush
      1.32 ± 14%      -0.6        0.68 ± 39%  perf-profile.children.cycles-pp.perf_session__deliver_event
      1.10 ± 15%      -0.6        0.50 ± 36%  perf-profile.children.cycles-pp.process_simple
      2.05            -0.6        1.50        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.95 ± 16%      -0.5        0.47 ± 45%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.80 ± 16%      -0.5        0.34 ± 34%  perf-profile.children.cycles-pp.ordered_events__queue
      0.78 ± 16%      -0.5        0.32 ± 33%  perf-profile.children.cycles-pp.queue_event
      1.66            -0.4        1.24        perf-profile.children.cycles-pp.__smp_call_single_queue
      1.65 ±  2%      -0.4        1.23 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
      0.82 ± 16%      -0.4        0.43 ± 44%  perf-profile.children.cycles-pp.evsel__parse_sample
      2.08 ±  2%      -0.4        1.70 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      3.20 ±  3%      -0.4        2.82 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.69 ±  8%      -0.3        0.36 ± 21%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.86 ±  2%      -0.3        0.59 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      1.09            -0.3        0.83        perf-profile.children.cycles-pp.llist_add_batch
      1.21            -0.2        0.96 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.42 ±  8%      -0.2        0.19 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.92            -0.2        0.70        perf-profile.children.cycles-pp.menu_select
      0.38 ±  8%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp._copy_from_iter
      7.22            -0.2        7.01        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.55 ±  2%      -0.2        0.36 ±  4%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.37 ±  9%      -0.2        0.18 ± 20%  perf-profile.children.cycles-pp.perf_tp_event
      0.56 ±  2%      -0.2        0.40 ±  2%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.94 ±  3%      -0.1        0.80 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.78 ±  3%      -0.1        0.65 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.65 ±  3%      -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.42            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.40 ±  3%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.73            -0.1        0.61        perf-profile.children.cycles-pp.__switch_to_asm
      0.83 ±  2%      -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      1.22            -0.1        1.11        perf-profile.children.cycles-pp.__list_add_valid_or_report
      1.49 ±  2%      -0.1        1.39        perf-profile.children.cycles-pp.select_task_rq
      0.37 ±  3%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.22 ± 17%      -0.1        0.12 ± 32%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.32 ±  3%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.32            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.ktime_get
      1.06 ±  2%      -0.1        0.98        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.29 ±  2%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.97 ±  2%      -0.1        0.90        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.21 ±  5%      -0.1        0.14        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.12 ± 20%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.machines__deliver_event
      0.22 ±  4%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.27 ±  3%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.18 ±  4%      -0.1        0.12        perf-profile.children.cycles-pp.read_tsc
      0.20 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      0.18 ±  5%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.10 ± 13%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.machine__findnew_thread
      0.18 ±  2%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.09 ± 13%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.handle_mm_fault
      0.08 ± 21%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.perf_env__arch
      0.18 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.70 ±  2%      -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.70 ±  2%      -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.09 ± 14%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.18 ±  4%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.intel_idle_irq
      0.13 ± 11%      -0.1        0.08 ± 21%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.61 ±  2%      -0.0        0.56 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.80 ±  2%      -0.0        0.75        perf-profile.children.cycles-pp.available_idle_cpu
      0.17 ± 20%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.copyin
      0.08 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.do_fault
      0.64            -0.0        0.59 ±  2%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.29 ±  4%      -0.0        0.25 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.15 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.10 ± 14%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.exc_page_fault
      0.10 ± 14%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.do_read_fault
      0.19 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.reweight_entity
      0.08 ± 20%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.thread__find_map
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ± 10%      -0.0        0.08 ± 22%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.16 ±  4%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.23 ±  4%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.22 ±  6%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.20 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.13 ±  3%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.get_cpu_device
      0.11 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.ct_idle_exit
      0.15 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.20 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.11            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.touch_atime
      0.10            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.atime_needs_update
      0.10            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.18 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.call_cpuidle
      0.10 ±  3%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.09 ±  7%      -0.0        0.06        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__dequeue_entity
      0.10 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.16 ±  6%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.avg_vruntime
      0.18 ±  3%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.12            -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.place_entity
      0.08 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__calc_delta
      0.15 ±  6%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.07 ±  8%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.pick_eevdf
      0.11 ±  5%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.wake_affine
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.file_update_time
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.cpus_share_cache
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.06 ± 11%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.30 ±  3%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.07 ± 10%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp._find_next_bit
      0.26 ± 10%      +0.0        0.30 ±  5%  perf-profile.children.cycles-pp.cpu_util
      0.25            +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.03 ±100%      +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.perf_swevent_event
      0.41            +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.40 ±  7%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      0.35 ±  6%      +0.2        0.56 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
      1.72            +0.2        1.96 ±  2%  perf-profile.children.cycles-pp.mutex_lock
      0.27            +0.3        0.55        perf-profile.children.cycles-pp.osq_unlock
      0.55            +0.3        0.84        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      2.06            +0.5        2.54        perf-profile.children.cycles-pp.mutex_unlock
     12.16            +0.7       12.91        perf-profile.children.cycles-pp.prepare_to_wait_event
      3.02            +1.0        4.03        perf-profile.children.cycles-pp.mutex_spin_on_owner
      3.02 ±  2%      +5.5        8.48        perf-profile.children.cycles-pp.osq_lock
      5.31            +5.6       10.86        perf-profile.children.cycles-pp.finish_wait
     16.99            +6.7       23.71        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     14.52            +7.1       21.63        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      7.51            +7.6       15.08        perf-profile.children.cycles-pp.__mutex_lock
     58.54           +12.0       70.56        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     58.36           +12.0       70.39        perf-profile.children.cycles-pp.do_syscall_64
     45.74           +13.8       59.49        perf-profile.children.cycles-pp.read
     43.86           +14.0       57.82        perf-profile.children.cycles-pp.ksys_read
     43.68           +14.0       57.67        perf-profile.children.cycles-pp.vfs_read
     43.36           +14.1       57.42        perf-profile.children.cycles-pp.pipe_read
     18.98            -5.8       13.18        perf-profile.self.cycles-pp.intel_idle
      3.08 ±  4%      -1.0        2.05 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.77 ± 16%      -0.5        0.32 ± 33%  perf-profile.self.cycles-pp.queue_event
      2.04 ±  2%      -0.4        1.64 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.82 ± 16%      -0.4        0.42 ± 45%  perf-profile.self.cycles-pp.evsel__parse_sample
      0.80            -0.3        0.49 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.90 ±  4%      -0.3        0.60 ±  6%  perf-profile.self.cycles-pp.prepare_task_switch
      0.86            -0.3        0.59 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      1.08            -0.3        0.82        perf-profile.self.cycles-pp.llist_add_batch
      3.16            -0.2        2.91        perf-profile.self.cycles-pp.prepare_to_wait_event
      1.19            -0.2        0.95 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.72            -0.2        0.49        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      1.83 ±  3%      -0.2        1.62 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      2.47            -0.2        2.26        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.52            -0.2        1.31 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.54 ±  3%      -0.2        0.35 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.21 ±  2%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp._copy_from_iter
      0.55 ±  2%      -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.76 ±  2%      -0.1        0.62 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.24 ±  8%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.perf_tp_event
      0.92 ±  4%      -0.1        0.79 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.76 ±  2%      -0.1        0.64        perf-profile.self.cycles-pp.__switch_to
      0.34            -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.50 ±  7%      -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.72            -0.1        0.61        perf-profile.self.cycles-pp.__switch_to_asm
      0.39 ±  2%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      1.21            -0.1        1.10        perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.24 ±  6%      -0.1        0.14 ± 22%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.12 ± 14%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.evlist__parse_sample
      0.59 ±  2%      -0.1        0.50 ±  2%  perf-profile.self.cycles-pp.pipe_write
      0.44 ±  2%      -0.1        0.35        perf-profile.self.cycles-pp.menu_select
      0.33 ±  3%      -0.1        0.25 ±  3%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.24 ±  2%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.do_idle
      0.11 ±  8%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.select_task_rq
      0.17 ±  5%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.29            -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.17 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.read_tsc
      0.08 ± 21%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.perf_env__arch
      0.09 ± 11%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.16 ±  3%      -0.1        0.11        perf-profile.self.cycles-pp.cpuidle_idle_call
      0.28 ±  3%      -0.0        0.24 ±  6%  perf-profile.self.cycles-pp.dequeue_entity
      0.17 ±  5%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.17 ± 22%      -0.0        0.12        perf-profile.self.cycles-pp.copyin
      0.64            -0.0        0.59 ±  2%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.16 ±  4%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.13 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.vfs_write
      0.46            -0.0        0.42 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.21 ± 11%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.19            -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.reweight_entity
      0.15            -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.12 ± 10%      -0.0        0.08 ± 22%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.26            -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.schedule
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.intel_idle_irq
      0.12 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.get_cpu_device
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.call_cpuidle
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.14 ±  6%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.16 ±  2%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.try_to_wake_up
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__dequeue_entity
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__entry_text_start
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.19 ±  4%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.vfs_read
      0.17 ±  5%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.24 ±  3%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.select_idle_sibling
      0.11 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.09            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.10 ±  8%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.09            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.11 ±  8%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.28 ±  4%      -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.10 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__calc_delta
      0.07 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.cpus_share_cache
      0.17 ±  4%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.09 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.10 ±  7%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.pick_eevdf
      0.06 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.08 ±  6%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.poll_idle
      0.13 ±  3%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      0.06 ± 11%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp._find_next_bit
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.select_idle_cpu
      0.25            +0.0        0.28 ±  3%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.22 ±  2%      +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.__wake_up_common
      0.24 ±  8%      +0.0        0.28 ±  5%  perf-profile.self.cycles-pp.cpu_util
      0.02 ±141%      +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.perf_swevent_event
      0.40 ±  7%      +0.1        0.50 ±  6%  perf-profile.self.cycles-pp.idle_cpu
      1.66            +0.2        1.90 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.26            +0.3        0.54 ±  2%  perf-profile.self.cycles-pp.osq_unlock
      0.54 ±  2%      +0.3        0.83        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      2.03            +0.5        2.51        perf-profile.self.cycles-pp.mutex_unlock
      1.19            +0.8        1.99        perf-profile.self.cycles-pp.__mutex_lock
      3.00            +1.0        4.00        perf-profile.self.cycles-pp.mutex_spin_on_owner
      3.01 ±  2%      +5.4        8.44        perf-profile.self.cycles-pp.osq_lock
     16.97            +6.7       23.69        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  c2da67ba32 ("fs/pipe: move check to pipe_has_watch_queue()")
  cc03a5d65a ("fs/pipe: remove unnecessary spinlock from pipe_write()")

c2da67ba32de1205 cc03a5d65a4032f8c5394092734 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  41263002           -31.9%   28090525 ±  3%  cpuidle..usage
      6.68            +4.1       10.73 ±  8%  mpstat.cpu.all.sys%
      6363 ±  7%     +27.7%       8129 ± 14%  perf-c2c.HITM.local
      2.94           +53.9%       4.52 ±  6%  vmstat.procs.r
   1200914           -33.7%     796488 ±  3%  vmstat.system.cs
   1027306           -17.1%     851649 ±  3%  meminfo.Active
   1027163           -17.1%     851501 ±  3%  meminfo.Active(anon)
   1175787           -15.3%     996307 ±  3%  meminfo.Shmem
    640740           -34.2%     421613 ±  4%  stress-ng.pipeherd.context_switches_per_sec
  38435052           -34.2%   25283532 ±  4%  stress-ng.pipeherd.ops
    640459           -34.2%     421306 ±  4%  stress-ng.pipeherd.ops_per_sec
      9121 ±  5%     +37.8%      12565 ± 10%  stress-ng.time.involuntary_context_switches
    260.67           +54.9%     403.83 ±  8%  stress-ng.time.percent_of_cpu_this_job_got
    157.63           +56.9%     247.39 ±  8%  stress-ng.time.system_time
  38435368           -34.2%   25284435 ±  4%  stress-ng.time.voluntary_context_switches
    256797           -17.1%     212877 ±  3%  proc-vmstat.nr_active_anon
    980499            -4.6%     935621        proc-vmstat.nr_file_pages
     32157            -7.5%      29729 ±  2%  proc-vmstat.nr_mapped
    293962           -15.3%     249082 ±  3%  proc-vmstat.nr_shmem
    256797           -17.1%     212877 ±  3%  proc-vmstat.nr_zone_active_anon
    659800            -9.7%     596114        proc-vmstat.numa_hit
    659800            -9.6%     596130        proc-vmstat.numa_local
    325950            -2.8%     316752 ±  2%  proc-vmstat.pgactivate
    690432            -9.2%     626933        proc-vmstat.pgalloc_normal
    467.67           +22.2%     571.50 ±  5%  turbostat.Avg_MHz
     12.35            +2.8       15.11 ±  5%  turbostat.Busy%
  13578516 ±  2%     -67.1%    4469624 ±  9%  turbostat.C1
     22.17           -12.6        9.54 ±  8%  turbostat.C1%
  27449797           -14.7%   23403867 ±  2%  turbostat.C1E
     61.09            +9.0       70.10        turbostat.C1E%
      0.18 ±  2%     -33.0%       0.12 ±  5%  turbostat.IPC
     87822           -27.9%      63321 ±  2%  turbostat.POLL
      0.07 ±  7%      -0.0        0.04 ± 11%  turbostat.POLL%
     11894           +70.3%      20253 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.avg
     32868 ±  2%     +29.3%      42488 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
      7652 ±  2%    +106.7%      15819 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.min
     11894           +70.3%      20253 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
     32868 ±  2%     +29.3%      42488 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
      7652 ±  2%    +106.7%      15819 ± 14%  sched_debug.cfs_rq:/.min_vruntime.min
   1042949           -33.1%     697944 ±  3%  sched_debug.cpu.nr_switches.avg
   1196298           -35.9%     766842 ±  4%  sched_debug.cpu.nr_switches.max
    908550 ±  2%     -30.6%     630908 ±  4%  sched_debug.cpu.nr_switches.min
     68138 ±  5%     -57.2%      29178 ± 15%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 10%     +84.6%       0.01 ± 31%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          +100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 22%    +108.8%       0.01 ± 45%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 14%     +63.3%       0.04 ± 16%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.49           +19.4%       0.59 ±  3%  perf-sched.total_wait_and_delay.average.ms
   1861307           -16.3%    1558477 ±  3%  perf-sched.total_wait_and_delay.count.ms
      3006           +30.3%       3916 ± 10%  perf-sched.total_wait_and_delay.max.ms
      0.49           +19.5%       0.58 ±  3%  perf-sched.total_wait_time.average.ms
      3006           +30.3%       3916 ± 10%  perf-sched.total_wait_time.max.ms
      4.44 ± 71%    +599.6%      31.09 ±113%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.30           +19.3%       0.36 ±  3%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    154.24 ±  5%     -23.3%     118.32 ±  9%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.00           -91.7%       0.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
   1782997           -17.0%    1479460 ±  3%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      1200 ±  5%     +34.0%       1609 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.53 ± 55%     -87.6%       2.43 ±169%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
     11.58 ± 73%    +598.3%      80.85 ± 98%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      2338 ± 20%     +56.9%       3669 ± 12%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.27 ±  4%     +15.9%       0.31 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      4.44 ± 71%    +599.6%      31.09 ±113%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.27           +13.6%       0.31 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.30           +19.4%       0.36 ±  3%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    154.16 ±  5%     -23.3%     118.28 ±  9%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.29           +25.9%       0.37 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
     19.53 ± 55%     -87.6%       2.43 ±168%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.34 ±  6%     +28.0%       0.44 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.28 ±  2%     +37.2%       0.39 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.30           +30.3%       0.39 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
     11.58 ± 73%    +598.3%      80.85 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.28           +27.3%       0.35 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.31           +57.9%       0.49 ± 31%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.28 ±  4%     +27.4%       0.35 ±  8%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      2338 ± 20%     +56.9%       3669 ± 12%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
 1.894e+09           -16.5%  1.582e+09        perf-stat.i.branch-instructions
      1.79            +0.2        2.00        perf-stat.i.branch-miss-rate%
  34430485            -5.8%   32433729        perf-stat.i.branch-misses
      2.96 ±  2%      -0.5        2.46 ±  8%  perf-stat.i.cache-miss-rate%
   2065706           -11.6%    1826870        perf-stat.i.cache-misses
  92392172 ±  2%     +17.3%  1.084e+08 ± 14%  perf-stat.i.cache-references
   1260156           -33.4%     838779 ±  3%  perf-stat.i.context-switches
      2.01           +50.1%       3.01 ±  5%  perf-stat.i.cpi
  1.75e+10           +20.3%  2.105e+10 ±  5%  perf-stat.i.cpu-cycles
     14454           +19.2%      17229 ±  8%  perf-stat.i.cpu-migrations
    246142 ±  6%     +21.5%     299091 ±  9%  perf-stat.i.cycles-between-cache-misses
   1195574           -20.8%     946957 ±  5%  perf-stat.i.dTLB-load-misses
  2.43e+09           -19.2%  1.963e+09        perf-stat.i.dTLB-loads
      0.00 ±  9%      +0.0        0.01 ± 12%  perf-stat.i.dTLB-store-miss-rate%
 1.362e+09           -26.3%  1.004e+09 ±  2%  perf-stat.i.dTLB-stores
     35.73            +1.4       37.17        perf-stat.i.iTLB-load-miss-rate%
   5293780           -22.0%    4130730 ±  4%  perf-stat.i.iTLB-load-misses
   9567612           -27.7%    6918328 ±  3%  perf-stat.i.iTLB-loads
  9.27e+09           -17.5%  7.646e+09        perf-stat.i.instructions
      2114            +4.4%       2207 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.54           -29.2%       0.38 ±  4%  perf-stat.i.ipc
      0.49           +20.3%       0.58 ±  5%  perf-stat.i.metric.GHz
    332.54           -25.5%     247.76 ±  3%  perf-stat.i.metric.K/sec
    160.46           -19.4%     129.35        perf-stat.i.metric.M/sec
      2888            -2.5%       2817        perf-stat.i.minor-faults
    263034 ±  2%     -11.7%     232290 ±  4%  perf-stat.i.node-stores
      2889            -2.5%       2817        perf-stat.i.page-faults
      0.22 ±  2%      +7.2%       0.24        perf-stat.overall.MPKI
      1.82            +0.2        2.05        perf-stat.overall.branch-miss-rate%
      2.24 ±  3%      -0.5        1.72 ± 13%  perf-stat.overall.cache-miss-rate%
      1.89           +45.9%       2.75 ±  5%  perf-stat.overall.cpi
      8465           +36.2%      11529 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  9%      +0.0        0.01 ± 13%  perf-stat.overall.dTLB-store-miss-rate%
     35.62            +1.8       37.38        perf-stat.overall.iTLB-load-miss-rate%
      0.53           -31.3%       0.36 ±  5%  perf-stat.overall.ipc
 1.864e+09           -16.5%  1.557e+09        perf-stat.ps.branch-instructions
  33895543            -5.8%   31931731        perf-stat.ps.branch-misses
   2034769           -11.6%    1799223        perf-stat.ps.cache-misses
  90927826 ±  2%     +17.3%  1.066e+08 ± 14%  perf-stat.ps.cache-references
   1240065           -33.4%     825430 ±  3%  perf-stat.ps.context-switches
 1.722e+10           +20.3%  2.072e+10 ±  5%  perf-stat.ps.cpu-cycles
     14224           +19.2%      16955 ±  8%  perf-stat.ps.cpu-migrations
   1176661           -20.8%     932029 ±  5%  perf-stat.ps.dTLB-load-misses
 2.391e+09           -19.2%  1.932e+09        perf-stat.ps.dTLB-loads
  1.34e+09           -26.2%  9.885e+08 ±  2%  perf-stat.ps.dTLB-stores
   5209751           -22.0%    4065298 ±  4%  perf-stat.ps.iTLB-load-misses
   9415103           -27.7%    6808264 ±  3%  perf-stat.ps.iTLB-loads
 9.124e+09           -17.5%  7.526e+09        perf-stat.ps.instructions
      2843            -2.5%       2773        perf-stat.ps.minor-faults
    258957 ±  2%     -11.7%     228693 ±  4%  perf-stat.ps.node-stores
      2843            -2.5%       2773        perf-stat.ps.page-faults
 5.757e+11           -17.3%  4.761e+11        perf-stat.total.instructions
     68.49           -10.0       58.50        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     15.72 ±  2%      -9.9        5.82 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     66.24            -9.5       56.75        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     66.23            -9.5       56.74        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.18            -9.5       56.71        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     59.41            -6.5       52.94        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     59.14            -6.0       53.10        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     57.30            -5.7       51.58        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.54            -1.6        1.94 ±  8%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.19            -1.4        1.74 ±  8%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.19 ±  3%      -1.2        1.95 ±  5%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.10 ±  3%      -1.2        1.89 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      2.45 ±  2%      -1.1        1.37 ±  8%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      2.40 ±  2%      -1.1        1.33 ±  8%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.45 ±  2%      -1.1        1.39 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.85 ±  2%      -1.0        6.81 ±  5%  perf-profile.calltrace.cycles-pp.write
      2.30 ±  2%      -1.0        1.28 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      2.34 ±  2%      -1.0        1.32 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      2.65 ±  2%      -1.0        1.67 ±  7%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      7.52            -0.9        6.60 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      7.48            -0.9        6.58 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.87 ±  2%      -0.9        2.00 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      7.36            -0.9        6.51 ±  5%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.22            -0.8        6.42 ±  5%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.90            -0.7        6.22 ±  4%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.50 ±  3%      -0.6        0.85 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      1.48 ±  4%      -0.6        0.86 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      1.40 ±  3%      -0.6        0.79 ±  8%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      1.33 ±  3%      -0.6        0.74 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.08 ±  4%      -0.6        0.50 ± 44%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.32 ±  5%      -0.5        0.78 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      1.61            -0.5        1.10 ±  9%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.16 ±  4%      -0.5        0.66 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.66 ±  6%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.__list_add_valid_or_report.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      0.65 ±  7%      +0.3        0.91 ±  4%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.87 ±  5%      +0.3        1.15 ±  4%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.76 ±  4%      +0.9        2.64 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.76 ±  5%      +0.9        1.67 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      1.41 ±  2%      +1.0        2.37 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read
      0.00            +1.0        0.96 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_write.vfs_write.ksys_write
      0.91 ±  6%      +1.0        1.89 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.34 ±  4%      +1.1        2.42 ±  2%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_read.vfs_read.ksys_read
      0.37 ± 70%      +1.2        1.53 ±  6%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      6.65            +1.6        8.23 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.12 ±  4%      +1.7        4.78 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      4.13 ±  2%      +1.7        5.83 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      2.43 ±  3%      +3.6        6.04 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
      2.80 ±  3%      +3.7        6.48 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      3.02 ±  3%      +3.9        6.96 ±  9%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.08 ± 10%      +4.1        5.20 ± 15%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
     40.77            +4.6       45.34        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.43 ±  5%      +6.1        9.48 ±  9%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.76           +11.3       34.07 ±  4%  perf-profile.calltrace.cycles-pp.read
     21.84           +11.7       33.53 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     21.74           +11.7       33.45 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.40           +11.8       33.17 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.30           +11.8       33.11 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     20.98           +11.9       32.91 ±  4%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.26 ±  2%     -10.3        6.92 ±  9%  perf-profile.children.cycles-pp.intel_idle_irq
     68.49           -10.0       58.50        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     68.49           -10.0       58.50        perf-profile.children.cycles-pp.cpu_startup_entry
     68.44           -10.0       58.47        perf-profile.children.cycles-pp.do_idle
     66.24            -9.5       56.75        perf-profile.children.cycles-pp.start_secondary
     61.41            -6.8       54.57        perf-profile.children.cycles-pp.cpuidle_idle_call
     59.21            -6.1       53.16        perf-profile.children.cycles-pp.cpuidle_enter
     59.20            -6.1       53.14        perf-profile.children.cycles-pp.cpuidle_enter_state
      5.65 ±  3%      -2.3        3.36 ±  5%  perf-profile.children.cycles-pp.__schedule
      3.68            -1.7        2.00 ±  8%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.30            -1.5        1.80 ±  8%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.28 ±  3%      -1.3        2.02 ±  5%  perf-profile.children.cycles-pp.schedule
      2.49 ±  2%      -1.1        1.38 ±  8%  perf-profile.children.cycles-pp.sched_ttwu_pending
      2.54 ±  3%      -1.1        1.44 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      7.94 ±  2%      -1.1        6.86 ±  5%  perf-profile.children.cycles-pp.write
      2.45 ±  2%      -1.1        1.38 ±  8%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.36 ±  2%      -1.0        1.32 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      2.65 ±  2%      -1.0        1.67 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
      7.37            -0.8        6.52 ±  5%  perf-profile.children.cycles-pp.ksys_write
      7.24            -0.8        6.43 ±  5%  perf-profile.children.cycles-pp.vfs_write
      1.59 ±  3%      -0.7        0.91 ±  8%  perf-profile.children.cycles-pp.ttwu_do_activate
      6.91            -0.7        6.23 ±  4%  perf-profile.children.cycles-pp.pipe_write
      1.48 ±  3%      -0.6        0.85 ±  8%  perf-profile.children.cycles-pp.activate_task
      1.41 ±  3%      -0.6        0.79 ±  9%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.51 ±  4%      -0.6        0.89 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      3.25 ±  3%      -0.6        2.65 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.69            -0.6        1.14 ±  9%  perf-profile.children.cycles-pp.menu_select
      1.37 ±  5%      -0.6        0.82 ±  8%  perf-profile.children.cycles-pp.dequeue_entity
      1.26 ±  4%      -0.5        0.72 ±  9%  perf-profile.children.cycles-pp.enqueue_entity
      1.09 ±  3%      -0.5        0.58 ± 10%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.24            -0.5        1.74 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.88 ±  2%      -0.4        0.48 ± 10%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.99 ±  5%      -0.4        0.62 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.74 ±  6%      -0.3        0.40 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.70 ±  2%      -0.3        0.38 ± 10%  perf-profile.children.cycles-pp.llist_add_batch
      0.68 ±  3%      -0.3        0.38 ±  6%  perf-profile.children.cycles-pp.prepare_task_switch
      0.70            -0.3        0.40 ±  6%  perf-profile.children.cycles-pp.select_task_rq
      0.72 ±  5%      -0.3        0.44 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.66            -0.3        0.38 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.79 ±  3%      -0.3        0.52 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.63 ±  4%      -0.3        0.35 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.51 ±  2%      -0.2        0.28 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.48 ± 10%      -0.2        0.28 ± 10%  perf-profile.children.cycles-pp.__switch_to
      0.43 ±  7%      -0.2        0.23 ± 10%  perf-profile.children.cycles-pp.update_curr
      0.39 ±  3%      -0.2        0.19 ± 11%  perf-profile.children.cycles-pp.llist_reverse_order
      0.53            -0.2        0.34 ± 10%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.37 ±  4%      -0.2        0.21 ±  9%  perf-profile.children.cycles-pp.available_idle_cpu
      0.95 ±  3%      -0.1        0.80 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.35 ±  6%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp.native_sched_clock
      0.31 ±  6%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.33 ±  7%      -0.1        0.19 ±  9%  perf-profile.children.cycles-pp.set_next_entity
      0.75 ±  3%      -0.1        0.61 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.75 ±  3%      -0.1        0.61 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.25            -0.1        0.13 ± 11%  perf-profile.children.cycles-pp.poll_idle
      0.62 ±  2%      -0.1        0.50 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.69 ±  6%      -0.1        0.57 ±  5%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.27 ±  3%      -0.1        0.15 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      0.31 ± 11%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.24 ± 15%      -0.1        0.12 ± 15%  perf-profile.children.cycles-pp.avg_vruntime
      0.26 ±  9%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.reweight_entity
      0.29            -0.1        0.18 ± 13%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.26 ±  3%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.26 ±  4%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp.sched_clock
      0.30 ±  2%      -0.1        0.20 ± 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.17 ±  2%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.__enqueue_entity
      0.26 ± 14%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.ktime_get
      0.25 ±  5%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.24 ±  3%      -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.security_file_permission
      0.21 ±  3%      -0.1        0.13 ± 13%  perf-profile.children.cycles-pp.update_rq_clock
      0.11            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.cpuacct_charge
      0.18 ±  2%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.44 ±  6%      -0.1        0.36 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.18 ±  7%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.place_entity
      0.18 ±  9%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.16 ± 10%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.15 ± 10%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__calc_delta
      0.40 ±  5%      -0.1        0.32 ±  8%  perf-profile.children.cycles-pp.update_process_times
      0.20 ±  2%      -0.1        0.13 ± 15%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.17 ± 12%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.40 ±  6%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
      0.19 ± 11%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.finish_task_switch
      0.18 ± 10%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.18 ±  7%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.17 ±  5%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.18 ±  6%      -0.1        0.12 ± 14%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.18 ±  5%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.10 ±  4%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.cpus_share_cache
      0.34 ±  7%      -0.1        0.28 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.13 ± 16%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.12 ± 11%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.32 ±  4%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.26 ±  5%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.09            -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.16 ± 10%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ±  9%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.call_cpuidle
      0.26 ±  6%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.09 ± 14%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.touch_atime
      0.14 ±  8%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp._copy_from_iter
      0.15 ± 11%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.__fdget_pos
      0.09 ±  9%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.copyin
      0.15 ± 13%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.09            -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.07            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.12 ± 10%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.get_cpu_device
      0.25 ±  4%      -0.0        0.22 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.10 ± 12%      -0.0        0.06 ± 23%  perf-profile.children.cycles-pp.ct_idle_exit
      0.11 ± 15%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.10 ±  4%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__dequeue_entity
      0.09 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.07 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.09 ±  5%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.12 ± 10%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.__fget_light
      1.00 ±  4%      +0.2        1.20 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      0.34 ±  4%      +0.2        0.54 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      1.30 ±  4%      +0.2        1.51        perf-profile.children.cycles-pp.mutex_lock
      0.18 ±  9%      +0.2        0.39 ±  4%  perf-profile.children.cycles-pp.osq_unlock
      1.36 ±  5%      +1.1        2.48 ±  2%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      6.65            +1.6        8.24 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_event
      3.03 ±  3%      +3.9        6.96 ±  9%  perf-profile.children.cycles-pp.finish_wait
     40.77            +4.6       45.34        perf-profile.children.cycles-pp.intel_idle
      1.27 ± 11%      +4.9        6.16 ± 12%  perf-profile.children.cycles-pp.osq_lock
      8.98 ±  4%      +5.9       14.86 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.41 ±  2%      +6.1       14.54 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.94 ±  6%      +7.1       11.02 ±  6%  perf-profile.children.cycles-pp.__mutex_lock
     29.56           +10.8       40.31 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     29.41           +10.8       40.20 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     22.84           +11.3       34.12 ±  4%  perf-profile.children.cycles-pp.read
     21.41           +11.8       33.18 ±  4%  perf-profile.children.cycles-pp.ksys_read
     21.30           +11.8       33.11 ±  4%  perf-profile.children.cycles-pp.vfs_read
     21.01           +11.9       32.94 ±  4%  perf-profile.children.cycles-pp.pipe_read
     16.73 ±  2%     -10.1        6.59 ±  9%  perf-profile.self.cycles-pp.intel_idle_irq
      0.98 ±  5%      -0.4        0.61 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.73 ±  6%      -0.3        0.39 ±  9%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.70 ±  2%      -0.3        0.38 ± 10%  perf-profile.self.cycles-pp.llist_add_batch
      0.58 ±  4%      -0.3        0.28 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.94            -0.3        0.66 ± 10%  perf-profile.self.cycles-pp.menu_select
      0.63 ±  4%      -0.3        0.35 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.55            -0.2        0.34 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.44 ±  2%      -0.2        0.23 ± 14%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.38            -0.2        0.18 ± 11%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.46 ±  9%      -0.2        0.27 ± 11%  perf-profile.self.cycles-pp.__switch_to
      0.38 ±  3%      -0.2        0.19 ± 10%  perf-profile.self.cycles-pp.llist_reverse_order
      0.37 ±  2%      -0.2        0.20 ±  9%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.37 ±  5%      -0.2        0.21 ±  9%  perf-profile.self.cycles-pp.available_idle_cpu
      0.37 ±  2%      -0.2        0.22 ±  7%  perf-profile.self.cycles-pp.prepare_task_switch
      0.34 ±  6%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      0.28 ±  6%      -0.1        0.15 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.69 ±  6%      -0.1        0.57 ±  5%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.26 ±  6%      -0.1        0.15 ± 13%  perf-profile.self.cycles-pp.do_idle
      0.24 ± 13%      -0.1        0.12 ± 15%  perf-profile.self.cycles-pp.avg_vruntime
      0.26 ±  9%      -0.1        0.14 ± 17%  perf-profile.self.cycles-pp.reweight_entity
      0.29 ±  7%      -0.1        0.18 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.30 ± 12%      -0.1        0.19 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.22 ±  2%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.poll_idle
      0.24 ±  3%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.25 ±  3%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  5%      -0.1        0.08 ± 21%  perf-profile.self.cycles-pp.__enqueue_entity
      0.16 ± 13%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.24 ±  5%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.18 ±  2%      -0.1        0.10 ± 17%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.14 ±  5%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.18 ± 10%      -0.1        0.11 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.16 ±  8%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.cpuacct_charge
      0.15 ±  8%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__calc_delta
      0.18 ±  7%      -0.1        0.10 ± 16%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.17 ±  4%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.dequeue_entity
      0.14 ± 17%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.15 ± 16%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.vfs_write
      0.17 ±  2%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.19 ±  7%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.16 ± 10%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.finish_task_switch
      0.17 ±  2%      -0.1        0.12 ± 14%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.14 ±  5%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.vfs_read
      0.09 ±  9%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.cpus_share_cache
      0.15 ±  6%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.read
      0.09            -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.08 ±  6%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.schedule
      0.10 ±  4%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.call_cpuidle
      0.13 ±  3%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.write
      0.11 ±  4%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.__entry_text_start
      0.15 ± 15%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.11 ± 11%      -0.0        0.06 ± 18%  perf-profile.self.cycles-pp.try_to_wake_up
      0.12 ± 10%      -0.0        0.07 ± 45%  perf-profile.self.cycles-pp.get_cpu_device
      0.12 ± 10%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.14 ± 13%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.15 ± 17%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.12 ± 18%      -0.0        0.08 ± 15%  perf-profile.self.cycles-pp.ktime_get
      0.09 ±  5%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.__dequeue_entity
      0.10            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.10 ±  9%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.schedule_idle
      0.10 ± 14%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.08 ± 10%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.stress_pipeherd_read_write
      0.20 ±  4%      +0.1        0.29 ±  9%  perf-profile.self.cycles-pp.__wake_up_common
      1.00 ±  3%      +0.2        1.20 ±  4%  perf-profile.self.cycles-pp.mutex_unlock
      0.33 ±  3%      +0.2        0.54 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.17 ± 11%      +0.2        0.39 ±  5%  perf-profile.self.cycles-pp.osq_unlock
      1.25 ±  4%      +0.2        1.48 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      1.12 ±  7%      +0.9        1.98        perf-profile.self.cycles-pp.__mutex_lock
      1.36 ±  4%      +1.1        2.46        perf-profile.self.cycles-pp.mutex_spin_on_owner
     40.77            +4.6       45.34        perf-profile.self.cycles-pp.intel_idle
      1.27 ± 10%      +4.9        6.15 ± 12%  perf-profile.self.cycles-pp.osq_lock
      8.95 ±  4%      +5.9       14.85 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pipe/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  c2da67ba32 ("fs/pipe: move check to pipe_has_watch_queue()")
  cc03a5d65a ("fs/pipe: remove unnecessary spinlock from pipe_write()")

c2da67ba32de1205 cc03a5d65a4032f8c5394092734 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  40782571           -34.5%   26722190 ±  2%  cpuidle..usage
      6.71            +5.3       12.05 ±  3%  mpstat.cpu.all.sys%
      3.14 ±  2%     +55.5%       4.88 ±  3%  vmstat.procs.r
   1198732           -36.6%     759821 ±  3%  vmstat.system.cs
   1014388           -20.7%     804558 ±  2%  meminfo.Active
   1014240           -20.7%     804410 ±  2%  meminfo.Active(anon)
     35584 ± 16%     +33.7%      47565 ± 20%  meminfo.AnonHugePages
   1162594           -18.8%     944222 ±  2%  meminfo.Shmem
    632754           -36.9%     399152 ±  2%  stress-ng.pipeherd.context_switches_per_sec
  37956331           -36.9%   23934072 ±  2%  stress-ng.pipeherd.ops
    632481           -36.9%     398822 ±  2%  stress-ng.pipeherd.ops_per_sec
      8640           +63.2%      14105 ±  3%  stress-ng.time.involuntary_context_switches
    258.33           +73.7%     448.83 ±  3%  stress-ng.time.percent_of_cpu_this_job_got
    156.30           +76.3%     275.60 ±  3%  stress-ng.time.system_time
  37956662           -36.9%   23935206 ±  2%  stress-ng.time.voluntary_context_switches
    464.33           +32.8%     616.50        turbostat.Avg_MHz
     12.26            +4.0       16.27        turbostat.Busy%
  13210272           -70.4%    3905828 ±  7%  turbostat.C1
     21.86           -13.3        8.52 ±  6%  turbostat.C1%
  27336233           -17.3%   22605226        turbostat.C1E
     61.68            +8.7       70.38        turbostat.C1E%
      0.17 ±  2%     -36.5%       0.11        turbostat.IPC
     94214           -26.9%      68893 ±  2%  turbostat.POLL
      0.07 ±  7%      -0.0        0.04        turbostat.POLL%
     95.53            +2.2%      97.64        turbostat.PkgWatt
    253563           -20.7%     201103 ±  2%  proc-vmstat.nr_active_anon
    977204            -5.6%     922608        proc-vmstat.nr_file_pages
     32243            -8.5%      29507        proc-vmstat.nr_mapped
    290666           -18.8%     236070 ±  2%  proc-vmstat.nr_shmem
    253563           -20.7%     201103 ±  2%  proc-vmstat.nr_zone_active_anon
    657180           -11.7%     579999        proc-vmstat.numa_hit
    657180           -11.2%     583256 ±  2%  proc-vmstat.numa_local
    323157            -6.1%     303598 ±  2%  proc-vmstat.pgactivate
    685287           -10.8%     610962        proc-vmstat.pgalloc_normal
    253863            +0.9%     256096        proc-vmstat.pgfree
      8160            +3.0%       8409        proc-vmstat.pgreuse
     11779           +99.1%      23449 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
     34264 ±  4%     +42.6%      48864 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
      7683 ±  4%    +144.6%      18796 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
      5806 ±  5%     +12.5%       6530 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     11779           +99.1%      23449 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
     34264 ±  4%     +42.6%      48864 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
      7683 ±  4%    +144.6%      18796 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
      5806 ±  5%     +12.5%       6530 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
    359.90 ±  4%     +10.8%     398.86 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
    358.18 ±  4%     +10.8%     396.99 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
     13406 ± 10%     +25.7%      16850 ± 12%  sched_debug.cpu.avg_idle.min
   1030572           -35.7%     662694 ±  2%  sched_debug.cpu.nr_switches.avg
   1177328           -37.9%     730901 ±  2%  sched_debug.cpu.nr_switches.max
    887692 ±  2%     -33.7%     588629 ±  4%  sched_debug.cpu.nr_switches.min
     69552           -60.9%      27216 ±  6%  sched_debug.cpu.nr_switches.stddev
      0.00          +100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  8%     -59.4%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.50           +23.9%       0.62 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1843860           -19.9%    1476521 ±  2%  perf-sched.total_wait_and_delay.count.ms
      0.50           +23.9%       0.62 ±  2%  perf-sched.total_wait_time.average.ms
      8.94 ± 14%    +218.5%      28.46 ±103%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    250.02 ±  5%     +12.5%     281.31 ±  6%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     67.34 ± 34%     -71.9%      18.90 ±141%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.30           +24.4%       0.38 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    152.13 ±  2%     -33.3%     101.49 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.33 ± 10%     -92.3%       0.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
   1765446           -20.9%    1397168 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      1246           +47.1%       1832 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     22.02 ± 23%    +214.7%      69.29 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      1001           -66.5%     335.30 ±140%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      4005           -37.5%       2503 ± 38%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.28 ±  2%     +20.1%       0.33 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.23 ± 18%     +40.8%       0.32 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      8.94 ± 14%    +218.5%      28.46 ±103%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    250.02 ±  5%     +12.5%     281.30 ±  6%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     67.34 ± 34%     -71.8%      19.02 ±140%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.30           +24.4%       0.38 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.20 ±  7%     +17.7%       0.24 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
    152.12 ±  2%     -33.3%     101.43 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.32 ±  2%     +24.7%       0.40 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.35 ±  3%     +17.9%       0.42 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.31 ±  3%     +33.2%       0.41 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.02 ± 23%    +214.7%      69.29 ±100%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      1001           -66.4%     336.82 ±139%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.33 ±  2%     +26.3%       0.42 ±  5%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.28           +31.7%       0.37 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      4005           -37.5%       2503 ± 38%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.16            +4.4%       0.17        perf-stat.i.MPKI
 1.875e+09           -15.2%  1.591e+09        perf-stat.i.branch-instructions
      1.77            +0.2        1.98        perf-stat.i.branch-miss-rate%
  33849840            -4.1%   32451085        perf-stat.i.branch-misses
      2.90 ±  4%      -0.5        2.36 ±  5%  perf-stat.i.cache-miss-rate%
   2047264           -10.5%    1832514        perf-stat.i.cache-misses
  93003981 ± 12%     +33.5%  1.242e+08 ± 10%  perf-stat.i.cache-references
   1245148           -36.0%     797265 ±  2%  perf-stat.i.context-switches
      2.01           +59.9%       3.22 ±  2%  perf-stat.i.cpi
 1.734e+10           +30.4%  2.261e+10        perf-stat.i.cpu-cycles
     14356           +34.8%      19358 ±  3%  perf-stat.i.cpu-migrations
    263224 ±  5%     +18.2%     311030 ±  7%  perf-stat.i.cycles-between-cache-misses
 2.403e+09           -18.3%  1.964e+09        perf-stat.i.dTLB-loads
      0.00 ±  9%      +0.0        0.01 ± 12%  perf-stat.i.dTLB-store-miss-rate%
 1.346e+09           -27.9%  9.704e+08        perf-stat.i.dTLB-stores
     36.14            +0.6       36.77        perf-stat.i.iTLB-load-miss-rate%
   5320981           -27.4%    3863621 ±  2%  perf-stat.i.iTLB-load-misses
   9453348           -30.3%    6585163 ±  2%  perf-stat.i.iTLB-loads
 9.177e+09           -16.4%  7.672e+09        perf-stat.i.instructions
      2074           +12.8%       2339        perf-stat.i.instructions-per-iTLB-miss
      0.54           -33.3%       0.36 ±  2%  perf-stat.i.ipc
      0.48           +30.4%       0.63        perf-stat.i.metric.GHz
    328.91           -28.1%     236.49 ±  2%  perf-stat.i.metric.K/sec
    158.78           -18.7%     129.12        perf-stat.i.metric.M/sec
      2912            -2.4%       2841        perf-stat.i.minor-faults
    258109 ±  2%     -11.1%     229499        perf-stat.i.node-stores
      2912            -2.4%       2841        perf-stat.i.page-faults
      0.22            +7.1%       0.24        perf-stat.overall.MPKI
      1.81            +0.2        2.04        perf-stat.overall.branch-miss-rate%
      2.23 ± 11%      -0.7        1.49 ±  9%  perf-stat.overall.cache-miss-rate%
      1.89           +56.0%       2.95 ±  2%  perf-stat.overall.cpi
      8466           +45.7%      12338 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.00 ± 10%      +0.0        0.01 ± 15%  perf-stat.overall.dTLB-store-miss-rate%
     36.02            +1.0       36.98        perf-stat.overall.iTLB-load-miss-rate%
      1725           +15.2%       1986        perf-stat.overall.instructions-per-iTLB-miss
      0.53           -35.8%       0.34 ±  2%  perf-stat.overall.ipc
 1.846e+09           -15.2%  1.566e+09        perf-stat.ps.branch-instructions
  33323456            -4.1%   31948762        perf-stat.ps.branch-misses
   2016438           -10.5%    1804771        perf-stat.ps.cache-misses
  91528863 ± 12%     +33.5%  1.222e+08 ± 10%  perf-stat.ps.cache-references
   1225280           -36.0%     784569 ±  2%  perf-stat.ps.context-switches
 1.707e+10           +30.4%  2.225e+10        perf-stat.ps.cpu-cycles
     14127           +34.8%      19050 ±  3%  perf-stat.ps.cpu-migrations
 2.365e+09           -18.3%  1.933e+09        perf-stat.ps.dTLB-loads
 1.325e+09           -27.9%  9.551e+08        perf-stat.ps.dTLB-stores
   5236452           -27.4%    3802367 ±  2%  perf-stat.ps.iTLB-load-misses
   9302547           -30.3%    6480331 ±  2%  perf-stat.ps.iTLB-loads
 9.033e+09           -16.4%  7.551e+09        perf-stat.ps.instructions
      2867            -2.5%       2797        perf-stat.ps.minor-faults
    254103 ±  2%     -11.1%     225941        perf-stat.ps.node-stores
      2867            -2.5%       2797        perf-stat.ps.page-faults
 5.699e+11           -16.4%  4.765e+11        perf-stat.total.instructions
     68.18           -11.4       56.76        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     65.82           -10.9       54.92        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     65.81           -10.9       54.92        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     65.76           -10.9       54.89        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     15.82 ±  2%     -10.8        4.98 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     59.13            -7.7       51.48        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     58.95            -7.0       51.90        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     56.98            -6.7       50.29        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.47 ±  2%      -1.7        1.75 ±  5%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.13 ±  3%      -1.6        1.56 ±  5%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      7.89            -1.5        6.40 ±  2%  perf-profile.calltrace.cycles-pp.write
      7.54            -1.3        6.22 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      7.50            -1.3        6.20 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.13            -1.3        1.84 ±  4%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      7.38            -1.3        6.13 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.45            -1.2        1.21 ±  6%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      3.03            -1.2        1.80 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      7.24            -1.2        6.06 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.65            -1.2        1.49 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      2.36 ±  3%      -1.2        1.20 ±  5%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.41 ±  3%      -1.1        1.27 ±  4%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.27            -1.1        1.13 ±  6%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      2.31 ±  3%      -1.1        1.21 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      2.99 ±  2%      -1.1        1.90 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.93            -1.0        5.90 ±  3%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ±  3%      -0.7        0.96 ±  6%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.05            -0.7        0.36 ± 70%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.47 ±  5%      -0.7        0.78 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      1.47            -0.7        0.80 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      1.37 ±  6%      -0.6        0.72 ±  6%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      1.30 ±  6%      -0.6        0.68 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.32 ±  2%      -0.6        0.72 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      1.15 ±  6%      -0.6        0.60 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.65 ±  4%      -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__list_add_valid_or_report.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      0.68 ±  4%      +0.2        0.87 ±  3%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.82 ±  6%      +0.3        1.16 ±  2%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.52 ±  2%      +1.0        1.48 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +1.0        0.97 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_write.vfs_write.ksys_write
      1.73            +1.0        2.78        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.42 ±  4%      +1.1        2.49 ±  3%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_read.vfs_read.ksys_read
      0.69 ±  7%      +1.1        1.82 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      1.38 ±  2%      +1.1        2.51 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read
      0.84 ±  6%      +1.2        2.02 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      6.50            +2.5        9.00 ±  3%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.99            +2.7        6.68 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      2.92            +2.8        5.74 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      2.47 ±  2%      +4.4        6.85 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
      2.83 ±  2%      +4.5        7.29 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
     40.56            +4.5       45.09        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.09 ±  2%      +4.7        7.79 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.06 ±  4%      +5.3        6.34 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      3.49 ±  3%      +7.2       10.71        perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
     23.03           +13.2       36.28        perf-profile.calltrace.cycles-pp.read
     22.07           +13.7       35.78        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     21.97           +13.8       35.73        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.63           +13.9       35.50        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.52           +13.9       35.45        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.19           +14.1       35.27        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     68.18           -11.4       56.76        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     68.18           -11.4       56.76        perf-profile.children.cycles-pp.cpu_startup_entry
     68.14           -11.4       56.73        perf-profile.children.cycles-pp.do_idle
     17.26           -11.2        6.04 ±  6%  perf-profile.children.cycles-pp.intel_idle_irq
     65.82           -10.9       54.92        perf-profile.children.cycles-pp.start_secondary
     61.27            -8.1       53.20        perf-profile.children.cycles-pp.cpuidle_idle_call
     59.02            -7.1       51.96        perf-profile.children.cycles-pp.cpuidle_enter
     59.00            -7.1       51.94        perf-profile.children.cycles-pp.cpuidle_enter_state
      5.55            -2.4        3.16 ±  3%  perf-profile.children.cycles-pp.__schedule
      3.61 ±  2%      -1.8        1.81 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.25 ±  3%      -1.6        1.63 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      7.97            -1.5        6.45 ±  2%  perf-profile.children.cycles-pp.write
      3.22            -1.3        1.92 ±  4%  perf-profile.children.cycles-pp.schedule
      7.39            -1.2        6.14 ±  3%  perf-profile.children.cycles-pp.ksys_write
      2.45            -1.2        1.21 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.45 ±  3%      -1.2        1.25 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      7.25            -1.2        6.06 ±  3%  perf-profile.children.cycles-pp.vfs_write
      2.50 ±  2%      -1.2        1.32 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      2.65            -1.2        1.49 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      2.34            -1.2        1.19 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      6.93            -1.0        5.90 ±  3%  perf-profile.children.cycles-pp.pipe_write
      1.77 ±  3%      -0.8        1.00 ±  5%  perf-profile.children.cycles-pp.menu_select
      1.57 ±  4%      -0.7        0.84 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.32            -0.7        1.63 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.46 ±  5%      -0.7        0.78 ±  5%  perf-profile.children.cycles-pp.activate_task
      1.51            -0.7        0.83 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.39 ±  5%      -0.7        0.73 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.38 ±  2%      -0.6        0.76 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      1.26 ±  5%      -0.6        0.66 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      1.05            -0.5        0.51 ±  9%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.84 ±  4%      -0.4        0.43 ±  9%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.97            -0.4        0.62 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.71            -0.4        0.36 ±  4%  perf-profile.children.cycles-pp.select_task_rq
      0.84 ±  3%      -0.4        0.49 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      3.14 ±  3%      -0.4        2.79        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.76 ±  4%      -0.3        0.42 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.68 ±  3%      -0.3        0.34 ± 10%  perf-profile.children.cycles-pp.llist_add_batch
      0.67            -0.3        0.34 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.69            -0.3        0.37 ±  5%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.63 ±  5%      -0.3        0.34 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      0.60 ±  4%      -0.3        0.30 ±  8%  perf-profile.children.cycles-pp.__switch_to_asm
      0.98            -0.3        0.70 ±  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.52            -0.3        0.26 ±  6%  perf-profile.children.cycles-pp.select_idle_sibling
      0.55 ±  2%      -0.2        0.30 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.48            -0.2        0.25 ± 11%  perf-profile.children.cycles-pp.__switch_to
      0.77            -0.2        0.54 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.76            -0.2        0.54 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.42            -0.2        0.21 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.38 ±  3%      -0.2        0.18 ±  4%  perf-profile.children.cycles-pp.llist_reverse_order
      0.39 ±  3%      -0.2        0.18 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.63            -0.2        0.45 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.34 ±  3%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.33            -0.2        0.16 ± 11%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.34 ±  8%      -0.2        0.18 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      0.29 ±  5%      -0.2        0.14 ±  8%  perf-profile.children.cycles-pp.__entry_text_start
      0.32 ± 13%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.45 ±  2%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      0.29 ±  3%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.27 ±  6%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.security_file_permission
      0.67 ±  4%      -0.1        0.54 ±  6%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.27 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.sched_clock
      0.28 ±  4%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.ktime_get
      0.28 ±  8%      -0.1        0.16 ± 11%  perf-profile.children.cycles-pp.___perf_sw_event
      0.23 ± 14%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.avg_vruntime
      0.27 ±  4%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.25            -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.41 ±  2%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.25 ±  3%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.poll_idle
      0.23 ±  8%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.27 ±  6%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.40 ±  4%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.20 ±  8%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.20 ±  4%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.33 ±  5%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.17 ± 10%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.__enqueue_entity
      0.18 ±  4%      -0.1        0.09 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.21 ±  6%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.33 ±  3%      -0.1        0.25 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ±  6%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.18 ±  9%      -0.1        0.09 ± 11%  perf-profile.children.cycles-pp.newidle_balance
      0.17 ±  7%      -0.1        0.09 ± 11%  perf-profile.children.cycles-pp.place_entity
      0.19 ±  9%      -0.1        0.11 ± 13%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.16 ±  7%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp._copy_from_iter
      0.16 ±  2%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.16            -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__fdget_pos
      0.16 ±  7%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.11 ± 11%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.25            -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.26 ±  3%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.15 ±  8%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.__calc_delta
      0.25            -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.09 ± 13%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.update_min_vruntime
      0.16 ± 10%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.10 ± 12%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.cpus_share_cache
      0.12 ±  4%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.12 ± 18%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.18 ±  4%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.finish_task_switch
      0.15 ± 10%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.11 ± 11%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.__dequeue_entity
      0.09 ±  5%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.21 ±  6%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.switch_fpu_return
      0.12 ± 11%      -0.1        0.06 ± 17%  perf-profile.children.cycles-pp.get_cpu_device
      0.11            -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.ct_idle_exit
      0.15 ±  8%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.13 ±  3%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__fget_light
      0.09 ± 10%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.call_cpuidle
      0.09 ±  5%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.07 ± 14%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.23 ±  4%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.07 ±  7%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.os_xsave
      0.18 ±  5%      -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.clock_nanosleep
      0.10 ±  8%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.stress_pipeherd_read_write
      0.09 ±  9%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.10 ±  9%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.12 ±  7%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.13 ±  3%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.12 ±  6%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.10 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.__do_softirq
      1.04            +0.1        1.14 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
      0.40            +0.2        0.57 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.18 ±  6%      +0.2        0.37 ±  3%  perf-profile.children.cycles-pp.osq_unlock
      1.25 ±  6%      +0.2        1.49        perf-profile.children.cycles-pp.mutex_lock
      1.45 ±  4%      +1.1        2.52 ±  2%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      6.51            +2.5        9.01 ±  3%  perf-profile.children.cycles-pp.prepare_to_wait_event
     40.56            +4.5       45.09        perf-profile.children.cycles-pp.intel_idle
      3.09 ±  2%      +4.7        7.80 ±  4%  perf-profile.children.cycles-pp.finish_wait
      1.27 ±  4%      +6.1        7.32 ±  2%  perf-profile.children.cycles-pp.osq_lock
      8.23            +8.1       16.29 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      4.01 ±  3%      +8.2       12.21        perf-profile.children.cycles-pp.__mutex_lock
      8.58 ±  2%      +8.3       16.92 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     29.81           +12.4       42.17        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     29.67           +12.4       42.09        perf-profile.children.cycles-pp.do_syscall_64
     23.13           +13.2       36.32        perf-profile.children.cycles-pp.read
     21.64           +13.9       35.50        perf-profile.children.cycles-pp.ksys_read
     21.52           +13.9       35.45        perf-profile.children.cycles-pp.vfs_read
     21.22           +14.1       35.30        perf-profile.children.cycles-pp.pipe_read
     16.71           -10.9        5.78 ±  6%  perf-profile.self.cycles-pp.intel_idle_irq
      1.20            -0.5        0.66 ± 10%  perf-profile.self.cycles-pp.pipe_read
      0.99 ±  3%      -0.4        0.58 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.65 ±  2%      -0.4        0.27 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.96            -0.4        0.60 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.68 ±  3%      -0.3        0.33 ±  9%  perf-profile.self.cycles-pp.llist_add_batch
      0.69            -0.3        0.36 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.59 ±  4%      -0.3        0.30 ±  9%  perf-profile.self.cycles-pp.__switch_to_asm
      2.15 ±  3%      -0.3        1.88 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.40 ±  7%      -0.3        0.14 ± 27%  perf-profile.self.cycles-pp.pipe_write
      0.54            -0.2        0.30 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.47 ±  2%      -0.2        0.25 ± 10%  perf-profile.self.cycles-pp.__switch_to
      0.42 ±  2%      -0.2        0.20 ±  8%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.38 ±  3%      -0.2        0.18 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      0.37            -0.2        0.17 ±  6%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.38 ±  4%      -0.2        0.18 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
      0.37 ±  2%      -0.2        0.19 ±  5%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.36 ±  6%      -0.2        0.18 ±  5%  perf-profile.self.cycles-pp.prepare_task_switch
      0.33 ±  3%      -0.2        0.17 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.31 ±  6%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.67 ±  4%      -0.1        0.54 ±  6%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.30 ± 13%      -0.1        0.17 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.23 ± 13%      -0.1        0.11 ± 12%  perf-profile.self.cycles-pp.avg_vruntime
      0.26 ±  4%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.25            -0.1        0.13 ±  7%  perf-profile.self.cycles-pp.reweight_entity
      0.16 ± 12%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.23 ±  7%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.do_idle
      0.23 ±  2%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.22 ±  3%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.poll_idle
      0.24 ±  6%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.25 ±  4%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.19 ±  2%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  9%      -0.1        0.09 ± 10%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.16 ± 11%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.__enqueue_entity
      0.21 ±  2%      -0.1        0.12 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.17 ±  2%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.read
      0.14 ±  5%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.vfs_write
      0.17 ±  4%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.dequeue_entity
      0.18 ±  4%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.update_curr
      0.16 ±  2%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.18 ±  9%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.apparmor_file_permission
      1.83            -0.1        1.76        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.14 ±  5%      -0.1        0.07 ± 13%  perf-profile.self.cycles-pp.__calc_delta
      0.13 ±  6%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.11 ± 11%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.__entry_text_start
      0.13 ± 14%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.write
      0.15 ±  6%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.16 ± 10%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.09 ±  9%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.call_cpuidle
      0.12 ±  4%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±  4%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.try_to_wake_up
      0.13 ±  3%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.09 ± 18%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.cpus_share_cache
      0.09 ± 14%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__dequeue_entity
      0.14 ±  8%      -0.1        0.09 ± 18%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.12 ± 11%      -0.1        0.06 ± 17%  perf-profile.self.cycles-pp.get_cpu_device
      0.13 ±  7%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.vfs_read
      0.16 ±  3%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.finish_task_switch
      0.09 ± 10%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.schedule_idle
      0.12 ± 11%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.11 ±  8%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.15 ±  3%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.12 ±  6%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.__fget_light
      0.14 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.os_xsave
      0.10 ± 12%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.switch_fpu_return
      0.12 ±  7%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.09 ±  9%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.10 ±  9%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.09 ± 10%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.08 ±  5%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.stress_pipeherd_read_write
      0.20 ±  4%      +0.1        0.28 ±  6%  perf-profile.self.cycles-pp.__wake_up_common
      1.03            +0.1        1.14 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
      0.39            +0.2        0.56 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.18 ±  6%      +0.2        0.37 ±  3%  perf-profile.self.cycles-pp.osq_unlock
      1.20 ±  5%      +0.3        1.46        perf-profile.self.cycles-pp.mutex_lock
      1.10 ±  2%      +0.9        1.99 ±  2%  perf-profile.self.cycles-pp.__mutex_lock
      1.44 ±  4%      +1.1        2.51 ±  2%  perf-profile.self.cycles-pp.mutex_spin_on_owner
     40.56            +4.5       45.09        perf-profile.self.cycles-pp.intel_idle
      1.26 ±  4%      +6.0        7.30 ±  2%  perf-profile.self.cycles-pp.osq_lock
      8.55 ±  2%      +8.4       16.92 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


