Return-Path: <linux-fsdevel+bounces-4325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047917FE92B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3800281F48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABFE20DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVnuQM0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841CD6C;
	Wed, 29 Nov 2023 20:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701320060; x=1732856060;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=EkO/zOLiLsJb7Z1Bba6k1sjynlE91Khm0qHU+H2nays=;
  b=JVnuQM0ivIz6nYL/eY6yvgQf4k+AlbngHf+Ovr7Yt82Ce625A6uUNxGv
   uF0HPQTKe4wpOKDpsQX8MD2X5TTgV193RbAe+noDnPr1Q6XGzK7l0WqOa
   gh0G9Fa2jhFEu+2aBXLIYWcfh+geNdjJGgBQ+Gb3KkmaaW3bGuZGV33bW
   KttLkJndczQDqGgw1qFMd6i8elC+ghQ8+3q8xv4hR9IRcwJ2FlJychu9k
   KgOvdvdbK0adbpUeSJIlPEAIz1dYRs1jwZZ5f+nvvO8daDErpHtbCT8N3
   YXxLAEmyNlwME+E2Y9o8hgHns+1nqGvuyoN1NUJf5wsSadK2GX7+Omrmr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373452048"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="373452048"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 20:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887105342"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887105342"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 20:54:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 20:54:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 20:54:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 20:54:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 20:54:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNL+D8SOH7sXi2zzTBBM0KO9cUEEDSYWwij5xTGVOhqi/H5PKTMwnIrCZ5HfMOadRtzt1bk8j84tyLaUj6uDMEThSH4+u+WKyXNdhKkMVhB0ZvHdjy6MIpLleuW9j1vEmIfATy3eXm3xIyN8OwdifO7effplrhcZs8UqAgWQaMRcViavBuegq9u79dBD4GMJ7MEChgq02G0da4ZlHoG6flqEyYZ1pm3GxZZZpWd0nUM7z/Coo4uvsskUPs9GachxMhAQ9MxGaDENuoRRqXBzJNPEHOr7/nPqtuLAroAgzM6hVTC5R+eTqDQ2R9CEdaA2YzrTbnrYFgkCF0fM7nO0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG7hPMOapUjoF8RJhJIwXYDifoCqovWc2K85cXUFJtE=;
 b=T4dXB9bp1gN09UhxpWXbBLTLh2v2LCDAtGMUmIIs/Mk5+uvX11AVj2qS2NimCekagig6BQyemd6gvRxSfcSD45rzpXHKLwLDJ7IHzMjfpczml1F5Y+G45GLHV6VK+OgrhsjNA2K36McdbiNe4rvuggt7R7g11A2KBvqMtMhzfA0mkYJWppgaeKlLMGmlUtxTXJEs1VXvD1JOzQFo8D5vBN6HG7ExHxE8uOxR/yXwC4QEKF9CEpSG7FCeB2jSPRnuYlW8lw2lzRq1guV/OJjKSLDnPUju0UCJheF0uHpIRPJYhlyCZfacanFfGQrSS0i5wF0grpTEivSOatf9wNODUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 04:54:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 04:54:11 +0000
Date: Thu, 30 Nov 2023 12:54:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	<linux-doc@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <202311300906.1f989fa8-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dac5ce-b5ea-41ea-4a5d-08dbf1606425
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLn8/fvSsg6q459tyknA0QT32VmNaXlNNdBy74oJgZk2aJFJVTgyfPfc3GcfLBPflDn2iN+AV6dXSG0QhbpVPxp2mfq1FJaGs+VgMP2EI79FTU596eBFouPU07Uo2VuEGGqWz7UyrHv6Snn3lLkxJETxXBhYvBP9LW3Ko0AJFF8qfc0YMBZZVqtwMhL2aVXLmnGYuJAnmvAX0fQM7QtthhzJ5ajBzw+iawfUMzxdBuUHhzmLb0Yt0vtUV2X9v8wfyt5xUyXC1lw5F5kLfvV2+jiDds/fI+JQSEsTsTrtQFQQe0eY7MEyi4eSvucmQFwojRqhvSqm1tFq8Mb6OCSNu8yyg5LFfPZWKMjXEudq/Jg6q5VcmWWWdC3Ge5f0BQBAzW6m8RWMNTMPpaD/OS3j2MCK4fTxqimVeARcKIF6K6vBaplgVdP1PuaSukCkXyMAuhFbBeJKA5NUzH8enom63x5PE7VHLTLIsyCoVqipjBtWfnJNUUnlV6v3K1SqzVM3+2iiJ3QCfg2x3x7U270OGTNuzz2X72lr0oGI6xWJuN4lemrhOXFBMfI4zM2IkhuRbfEatSdT+3Sfs6wfphDAABixZ9sPXTaHnvexSM0sOqHAPiOFw+dvIu39x2ElHz1TlRCr5qNVQN4sGR/9SiGjmHRT9NnzL+7NfDqI45gJHwMS042e+cXyV5tyLUYD8IwL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(230473577357003)(230373577357003)(451199024)(64100799003)(186009)(1800799012)(86362001)(6916009)(316002)(8676002)(66476007)(66556008)(8936002)(4326008)(5660300002)(41300700001)(36756003)(30864003)(66946007)(202311291699003)(2906002)(38100700002)(82960400001)(83380400001)(6512007)(26005)(1076003)(2616005)(107886003)(6486002)(966005)(478600001)(6666004)(6506007)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dMk912DYSwaOhfFYCoyZxj3Hgx2z1fopKGG+Dg7r2ffyEY86G30Pqp9LAr?=
 =?iso-8859-1?Q?xU9+yeZryGurbAoeq3b1WdsP+ppkCEyu0M2jDVKUTuXRpGxNoHrCaksJ+t?=
 =?iso-8859-1?Q?Tsrg6zioPzqnP4gOXkqVFxes9oO6qPxCrXc7WKT9gKf90rCQ7W/b7YDqyC?=
 =?iso-8859-1?Q?f35/Z7F6RipUDkrw5UQgmNCfFH8tqU5gfVRTNYGT1Ay9ARkv0A1X/FngKg?=
 =?iso-8859-1?Q?1JwMyjXHtxXuNspUGpieN59Fu8QN172U2z5U1Yldr0fsz11ETe52lAX+LM?=
 =?iso-8859-1?Q?QIywvLqartsSa2uU9q6WJhkfvqgJxeO02f0w9ovhT5CBr9AWLMC3vlSw0X?=
 =?iso-8859-1?Q?hgMnYw8eMDVasd86pCZDDry/IqpuOXWfMvadPaQmNqDE4lahlEvGgJCynt?=
 =?iso-8859-1?Q?1FY0IAiVsCul0R4wMGQyn1YbTPd32r2Y5BuF4wBKarDx303ZkBKAHq+rcZ?=
 =?iso-8859-1?Q?LhhJ0K6IHE8vGTXpg2hLtUVdtFQ6gxy7TooSawQKKm1/fhs1GYPzkE5TYh?=
 =?iso-8859-1?Q?zn3+iz+b0lfrns+mOIKIK3OMw9kKz/0duUlr5MRw53lXxx8hvGLhmvreqF?=
 =?iso-8859-1?Q?wLWet1NrlCuEkgpCISosbJ/Uun0W4eA8W9x/78Q36CZUNQWUu9Qwa/RKEw?=
 =?iso-8859-1?Q?ulfoyxVOIxSPeD/B/WwuX0MW/J/PwciLTRDKuJx+sxyROgE3JxYvUdKt6A?=
 =?iso-8859-1?Q?zjvlAJoCwRndtvOYv/nJgIGadpZFtghUHTUxFZOOm/n1xE3GD4WqUJ4di6?=
 =?iso-8859-1?Q?BqOM6NZcBaJY/Vz1r1gJUkyofjnMzPWPx0dZrXR+A6pnOUVc1Tp8Xa9690?=
 =?iso-8859-1?Q?yOd4jfTKbpz7/nkR9gDh2NPU4Tnm2PA0NFIlsotG/SC21oKyIl6oEMMz4d?=
 =?iso-8859-1?Q?ujVz+SsiulLESypnoYMR4nmeDNagUp54X7KfexeDVWFK3iNxpIXodA0WSi?=
 =?iso-8859-1?Q?ixp5wdkSpgJO09gZeGteuKCoNe5GBibzSUKuFYegmC8KXDheb77pwW1vdU?=
 =?iso-8859-1?Q?RNMoA5DYoVUZmb26x859wCN8wQqKN6WI1qfk9Fu+He3oy48J8eOmO8HpFF?=
 =?iso-8859-1?Q?7yqFBjUASYcrJOskDwok6Y+YVdlpWa/oOGR5gRJtAkdNyF6UJqieWEkNcu?=
 =?iso-8859-1?Q?/+iLq6WSx0+lVgT4n1sYkoUk9ru2d9EcpWgt30kHBdBZruJQFrrzCgZWum?=
 =?iso-8859-1?Q?0xyRZ0wBmG0qcceS5xz9bb3Rn3J5T+5H+OkvtnNKbzKjEJm9LU98BipE2L?=
 =?iso-8859-1?Q?LnCYbzmKzmljnMaR6rgNeIjcJ6s4LcSTclVIZewhtcwZWKsAn/QDNW1ch1?=
 =?iso-8859-1?Q?SkUn+YoRKQMj/F4DfaNwEm7c4llhsxWjOaq9NrC38uoANt7Cb84RGwmFUt?=
 =?iso-8859-1?Q?3shssGPLfXtjF+FHWqY3tiUIiBx7bL/NDw9aa1vBUV8dpZaSnbFHhsQN4V?=
 =?iso-8859-1?Q?Un9Mz81JrgjGF2smQIUCXBO0BhgB8rbU48eIaNC50dzkPzhuBNvzxcKXzH?=
 =?iso-8859-1?Q?faThaAAzn2hMgbM0pRcaGzb6At9ItMTpa2X6eT+ijyxOTWPLZ0T9eLIKQZ?=
 =?iso-8859-1?Q?qoenVHLLBO7REng4Rl06QkvT1RNOc5z/89nJmba+b+ro0cfEXQ8kjtEPP/?=
 =?iso-8859-1?Q?5FhHXcu5FCo4qeEUQ5ApDhRFC2UxrTRydFd8siGTl89Yo0TrwPJ3Yf3Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dac5ce-b5ea-41ea-4a5d-08dbf1606425
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 04:54:10.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrD6eH/5Zuwt/0udNrfRZOn/p5z8BNFaonX0yt5u+H0Yq9tHvpoZ5xn5HbIndFsrqGULE520ebew5HOt5J1q6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -27.2% regression of stress-ng.sysinfo.ops_per_sec on:


commit: 1b738f196eacb71a3ae1f1039d7e43e0226b5a70 ("__dentry_kill(): new locking scheme")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.dcache2

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: sysinfo
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.score -14.0% regression                                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=shell1                                                                               |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311300906.1f989fa8-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231130/202311300906.1f989fa8-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s

commit: 
  e3640d37d0 ("d_prune_aliases(): use a shrink list")
  1b738f196e ("__dentry_kill(): new locking scheme")

e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20.33 ±  7%     -30.3%      14.17 ± 17%  perf-c2c.DRAM.local
      7172 ± 44%     -50.3%       3565 ± 83%  numa-meminfo.node0.Active
      4948 ± 55%     -55.6%       2199 ±126%  numa-meminfo.node0.Active(file)
      1237 ± 55%     -55.6%     549.77 ±126%  numa-vmstat.node0.nr_active_file
      1237 ± 55%     -55.6%     549.77 ±126%  numa-vmstat.node0.nr_zone_active_file
    319149           -27.2%     232325        stress-ng.sysinfo.ops
      5319           -27.2%       3872        stress-ng.sysinfo.ops_per_sec
     25802            +1.5%      26178        proc-vmstat.nr_slab_reclaimable
    543109 ±  6%     +16.2%     630992        proc-vmstat.pgalloc_normal
    503144 ±  6%     +17.7%     592014        proc-vmstat.pgfree
      1.57 ± 14%     +16.7%       1.83 ±  2%  perf-stat.i.MPKI
      3.74 ±  5%     +19.1%       4.46        perf-stat.i.cpi
      0.29 ±  6%     -13.5%       0.25 ±  2%  perf-stat.i.ipc
    496.95 ± 10%      -8.9%     452.89 ±  2%  perf-stat.i.metric.K/sec
      1.59 ±  4%     +10.0%       1.75 ±  3%  perf-stat.overall.MPKI
      3.69           +15.0%       4.24 ±  3%  perf-stat.overall.cpi
      0.27           -13.0%       0.24 ±  3%  perf-stat.overall.ipc
     87.32            +1.7       88.99        perf-stat.overall.node-store-miss-rate%
 3.372e+11 ±  3%     -12.7%  2.944e+11 ±  3%  perf-stat.total.instructions
    335.84 ±139%     +49.9%     503.58 ± 98%  perf-sched.total_sch_delay.max.ms
      3819           +11.8%       4271        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.20 ± 28%     -83.2%       0.03 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      0.18 ± 66%     -89.6%       0.02 ± 85%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
      0.22 ±100%     -77.5%       0.05 ±142%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      0.22 ± 60%     -88.2%       0.03 ± 66%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.31 ± 90%     -90.3%       0.03 ±148%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
      0.84 ± 11%     -90.0%       0.08 ± 68%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      0.42 ±104%     -92.2%       0.03 ±135%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.65 ± 57%     -92.7%       0.05 ± 84%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
      0.39 ± 86%     -80.6%       0.08 ±117%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      0.69 ± 45%     -89.9%       0.07 ± 84%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      3819           +11.8%       4271        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     19.22           -19.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
     18.71           -18.7        0.00        perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lookupat.filename_lookup
     17.39           -17.4        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_lookupat
      8.59            -7.8        0.74 ±  7%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
     16.96            -4.5       12.47        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup
     17.17            -4.1       13.04        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      9.21            -2.4        6.85        perf-profile.calltrace.cycles-pp.open64
      9.13            -2.3        6.79        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      9.11            -2.3        6.78        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      9.09            -2.3        6.76        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      9.08            -2.3        6.76        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      8.57            -2.2        6.40        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.53            -2.2        6.38        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      7.74            -2.1        5.68        perf-profile.calltrace.cycles-pp.__xstat64
      7.66            -2.0        5.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      7.65            -2.0        5.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.62            -2.0        5.60        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.29            -1.9        5.37        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      6.75            -1.8        4.97 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      6.51            -1.7        4.79        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.24 ±  2%      -1.7        5.52        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
      6.48            -1.7        4.77        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      6.01            -1.5        4.54        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat
      6.04            -1.4        4.60 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup
      4.09 ±  2%      -1.0        3.12 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.77 ±  5%      -0.9        0.84 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      3.23 ±  2%      -0.8        2.39        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.18            -0.8        2.34 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      1.64 ±  2%      -0.7        0.97 ±  2%  perf-profile.calltrace.cycles-pp.__close
      1.56            -0.6        0.91 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.54            -0.6        0.90 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.52 ±  2%      -0.6        0.89        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.52            -0.6        1.89        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.50            -0.6        1.88        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      2.31 ±  4%      -0.6        1.70 ±  7%  perf-profile.calltrace.cycles-pp.syscall
      2.22 ±  4%      -0.6        1.64 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      2.21 ±  4%      -0.6        1.62 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.18 ±  4%      -0.6        1.61 ±  7%  perf-profile.calltrace.cycles-pp.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.19 ±  2%      -0.6        1.63 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      1.25 ±  2%      -0.6        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.18 ±  2%      -0.6        1.62 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      1.94 ±  3%      -0.5        1.41 ±  4%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.72 ±  2%      -0.5        1.22 ±  5%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.99 ±  2%      -0.5        1.50        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      2.00 ±  2%      -0.5        1.52        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      2.01 ±  2%      -0.5        1.53        perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.97 ±  2%      -0.5        1.49 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.33 ±  4%      -0.4        0.90 ±  7%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.11 ±  3%      -0.4        0.68 ±  8%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
      1.41 ±  4%      -0.4        0.99 ±  3%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.67 ±  7%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.78 ± 11%      -0.4        0.38 ± 71%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      0.98 ± 18%      -0.4        0.63 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      1.21 ±  5%      -0.3        0.86 ±  2%  perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      1.20 ±  6%      -0.3        0.85 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.20 ±  6%      -0.3        0.86 ±  6%  perf-profile.calltrace.cycles-pp.user_get_super.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.01 ±  4%      -0.3        0.73 ±  4%  perf-profile.calltrace.cycles-pp.fstatfs64
      0.84 ±  2%      -0.2        0.60 ± 10%  perf-profile.calltrace.cycles-pp.shmem_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
      0.84 ±  4%      -0.2        0.62 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.82 ±  4%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.82 ±  2%      -0.2        0.60 ±  4%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
      0.77 ±  4%      -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__do_sys_fstatfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.89 ±  2%      -0.2        0.68 ±  5%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.87 ±  2%      -0.2        0.66 ±  4%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.62 ±  5%      +0.2        0.84 ±  6%  perf-profile.calltrace.cycles-pp.down_read.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.56 ±  5%      +0.2        0.80 ±  5%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.00            +0.7        0.67 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.00            +0.7        0.73 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.00            +1.2        1.18 ±  2%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lookup
     31.75            +1.4       33.16        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      0.00            +1.7        1.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00            +1.7        1.74        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      5.76 ±  2%      +2.6        8.32        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      6.42 ±  2%      +2.7        9.09        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      6.91 ±  2%      +2.7        9.63        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      7.16            +2.8        9.94 ±  2%  perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      6.63            +2.9        9.54 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.path_lookupat.filename_lookup.user_path_at_empty
     17.51            +4.1       21.57        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     16.61            +5.2       21.82        perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
     16.57            +5.2       21.78        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty
     13.43            +5.4       18.82        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
     11.40            +5.7       17.08        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
     10.81            +5.8       16.60        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
     11.99            +5.9       17.91        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.path_lookupat.filename_lookup
     11.97            +5.9       17.89        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.path_lookupat
     69.26            +6.0       75.26        perf-profile.calltrace.cycles-pp.__statfs
     68.98            +6.1       75.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
     68.93            +6.1       74.99        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     68.82            +6.1       74.91        perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     68.56            +6.2       74.73        perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     66.10            +6.9       72.96        perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.05            +7.1       71.11        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
     63.88            +7.1       71.00        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs
      0.00            +7.4        7.39 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
      0.00            +8.6        8.57 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.path_lookupat
      0.09 ±223%      +9.2        9.33 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_lookupat.filename_lookup
      0.00           +21.8       21.78        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      0.00           +22.1       22.06        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
     29.29           -29.3        0.00        perf-profile.children.cycles-pp.fast_dput
      8.52            -8.5        0.00        perf-profile.children.cycles-pp.lock_for_kill
     16.99            -4.5       12.50        perf-profile.children.cycles-pp.d_alloc_parallel
     17.20            -4.1       13.07        perf-profile.children.cycles-pp.__lookup_slow
     13.31            -3.5        9.83        perf-profile.children.cycles-pp.link_path_walk
      9.24            -2.4        6.87        perf-profile.children.cycles-pp.open64
      9.28            -2.4        6.92        perf-profile.children.cycles-pp.do_sys_openat2
      9.28            -2.4        6.93        perf-profile.children.cycles-pp.__x64_sys_openat
      8.76            -2.2        6.57        perf-profile.children.cycles-pp.do_filp_open
      8.73            -2.2        6.54        perf-profile.children.cycles-pp.path_openat
      7.77            -2.1        5.70        perf-profile.children.cycles-pp.__xstat64
      7.68            -2.0        5.64        perf-profile.children.cycles-pp.__do_sys_newstat
      7.34            -1.9        5.41        perf-profile.children.cycles-pp.vfs_statx
     38.79            -1.7       37.05        perf-profile.children.cycles-pp.dput
      2.69 ±  4%      -0.9        1.81 ±  5%  perf-profile.children.cycles-pp.inode_permission
      3.02 ±  3%      -0.8        2.18 ±  5%  perf-profile.children.cycles-pp.statfs_by_dentry
      1.67 ±  2%      -0.7        0.99 ±  2%  perf-profile.children.cycles-pp.__close
      1.53 ±  2%      -0.6        0.89        perf-profile.children.cycles-pp.__x64_sys_close
      2.34 ±  4%      -0.6        1.72 ±  7%  perf-profile.children.cycles-pp.syscall
      2.50 ±  3%      -0.6        1.89 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
      2.20 ±  5%      -0.6        1.62 ±  3%  perf-profile.children.cycles-pp.complete_walk
      2.18 ±  4%      -0.6        1.61 ±  7%  perf-profile.children.cycles-pp.__do_sys_ustat
      2.18 ±  4%      -0.6        1.61 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_sum
      1.26 ±  2%      -0.6        0.70 ±  2%  perf-profile.children.cycles-pp.__fput
      1.65 ±  9%      -0.5        1.11 ±  6%  perf-profile.children.cycles-pp.kernfs_iop_permission
      1.94 ±  3%      -0.5        1.42 ±  4%  perf-profile.children.cycles-pp.do_open
      1.41 ±  4%      -0.4        1.00 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
      1.48 ±  2%      -0.4        1.07 ±  7%  perf-profile.children.cycles-pp.shmem_statfs
      1.50 ±  2%      -0.4        1.10 ±  8%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.39 ±  3%      -0.4        1.00 ±  3%  perf-profile.children.cycles-pp.lockref_get
      0.50 ±  5%      -0.4        0.14 ± 23%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.60 ±  4%      -0.4        0.25 ±  6%  perf-profile.children.cycles-pp.dcache_dir_close
      1.20 ±  6%      -0.3        0.86 ±  6%  perf-profile.children.cycles-pp.user_get_super
      1.20 ±  2%      -0.3        0.87 ±  2%  perf-profile.children.cycles-pp.getname_flags
      2.37 ±  4%      -0.3        2.07 ±  3%  perf-profile.children.cycles-pp.down_read
      1.06 ±  4%      -0.3        0.77 ±  4%  perf-profile.children.cycles-pp.fstatfs64
      0.99 ±  7%      -0.3        0.73 ±  4%  perf-profile.children.cycles-pp.ext4_statfs
      1.06 ±  8%      -0.2        0.82 ±  6%  perf-profile.children.cycles-pp.up_read
      0.99 ±  2%      -0.2        0.76 ±  2%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.78 ±  5%      -0.2        0.56 ±  5%  perf-profile.children.cycles-pp.__do_sys_fstatfs
      0.78 ±  5%      -0.2        0.56 ±  5%  perf-profile.children.cycles-pp.__traverse_mounts
      0.77 ±  3%      -0.2        0.57 ±  4%  perf-profile.children.cycles-pp.strncpy_from_user
      0.82 ±  4%      -0.2        0.63 ±  3%  perf-profile.children.cycles-pp.path_put
      0.68 ±  6%      -0.2        0.50 ±  4%  perf-profile.children.cycles-pp.fd_statfs
      0.64 ±  5%      -0.2        0.46 ±  5%  perf-profile.children.cycles-pp._find_next_or_bit
      0.56 ±  6%      -0.2        0.40 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.41 ±  8%      -0.2        0.26 ±  3%  perf-profile.children.cycles-pp.path_init
      0.44 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.57 ±  6%      -0.1        0.44 ± 15%  perf-profile.children.cycles-pp.__d_lookup
      0.51 ±  5%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.dcache_dir_open
      0.51 ±  5%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.33 ± 11%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.nd_jump_root
      0.43 ±  3%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.58 ±  9%      -0.1        0.46 ± 10%  perf-profile.children.cycles-pp.alloc_empty_file
      0.51 ±  3%      -0.1        0.40 ± 12%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.33 ± 11%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.super_lock
      0.38 ±  6%      -0.1        0.30 ±  7%  perf-profile.children.cycles-pp.__check_object_size
      0.27 ±  5%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp._copy_to_user
      0.19 ± 12%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.set_root
      0.21 ±  4%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.security_file_free
      0.20 ±  3%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.20 ±  5%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.do_statfs_native
      0.30 ±  2%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.25 ±  6%      -0.1        0.19 ± 12%  perf-profile.children.cycles-pp.ioctl
      0.18 ±  4%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.simple_statfs
      0.16 ± 12%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.vfs_statfs
      0.18 ±  5%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.generic_permission
      0.21 ±  5%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  3%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.apparmor_file_open
      0.13 ±  2%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.security_file_open
      0.40 ±  9%      -0.1        0.35 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.26 ±  6%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp.open_last_lookups
      0.18 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.check_heap_object
      0.12 ±  7%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.may_open
      0.14 ± 11%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.filp_flush
      0.10 ±  8%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.dnotify_flush
      0.08 ± 11%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.08 ±  8%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.rcu_all_qs
      0.09 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.09 ±  9%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.10 ±  4%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.stress_sysinfo
      0.12 ± 12%      -0.0        0.09 ± 13%  perf-profile.children.cycles-pp.security_inode_getattr
      0.11 ±  9%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__check_heap_object
      0.24 ±  8%      +0.0        0.28 ± 10%  perf-profile.children.cycles-pp.__slab_free
      0.11 ± 15%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.___d_drop
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__wake_up
      0.03 ±101%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__d_lookup_unhash
      0.07 ± 14%      +0.2        0.23 ± 29%  perf-profile.children.cycles-pp.__d_rehash
      0.11 ±  6%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.2        0.22 ± 14%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.19 ±  9%      +0.3        0.52 ± 14%  perf-profile.children.cycles-pp.__d_add
      0.20 ±  9%      +0.3        0.54 ± 14%  perf-profile.children.cycles-pp.simple_lookup
     33.77            +1.0       34.74        perf-profile.children.cycles-pp.walk_component
      8.14            +2.5       10.60        perf-profile.children.cycles-pp.step_into
      6.94 ±  2%      +2.7        9.66        perf-profile.children.cycles-pp.d_alloc
     22.77            +2.8       25.55        perf-profile.children.cycles-pp.lockref_get_not_dead
     23.21            +3.2       26.42        perf-profile.children.cycles-pp.__legitimize_path
     22.31            +3.4       25.72        perf-profile.children.cycles-pp.try_to_unlazy
     21.40            +4.0       25.42        perf-profile.children.cycles-pp.terminate_walk
     15.46            +5.0       20.41        perf-profile.children.cycles-pp.lookup_fast
     63.74            +5.0       68.71        perf-profile.children.cycles-pp._raw_spin_lock
     59.43            +5.3       64.68        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     70.62            +5.3       75.95        perf-profile.children.cycles-pp.filename_lookup
     70.43            +5.4       75.82        perf-profile.children.cycles-pp.path_lookupat
     69.39            +6.0       75.34        perf-profile.children.cycles-pp.__statfs
     68.83            +6.1       74.91        perf-profile.children.cycles-pp.__do_sys_statfs
     68.58            +6.2       74.74        perf-profile.children.cycles-pp.user_statfs
     66.12            +6.9       72.97        perf-profile.children.cycles-pp.user_path_at_empty
      0.84 ±  4%      +9.5       10.33        perf-profile.children.cycles-pp.__dentry_kill
      2.67 ±  3%      -1.0        1.63 ±  2%  perf-profile.self.cycles-pp.lockref_get_not_dead
      2.47 ±  3%      -0.6        1.87 ±  2%  perf-profile.self.cycles-pp.lockref_put_return
      1.47 ±  2%      -0.4        1.07 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.50 ±  5%      -0.4        0.14 ± 24%  perf-profile.self.cycles-pp._raw_spin_trylock
      1.36 ±  5%      -0.3        1.02 ±  9%  perf-profile.self.cycles-pp.__percpu_counter_sum
      4.31            -0.3        4.00 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.88 ±  6%      -0.3        0.59 ± 10%  perf-profile.self.cycles-pp.inode_permission
      2.32 ±  4%      -0.3        2.02 ±  3%  perf-profile.self.cycles-pp.down_read
      1.04 ±  8%      -0.2        0.81 ±  7%  perf-profile.self.cycles-pp.up_read
      0.74 ±  5%      -0.2        0.51 ±  6%  perf-profile.self.cycles-pp.lockref_get
      0.56 ±  6%      -0.2        0.42 ±  6%  perf-profile.self.cycles-pp.user_get_super
      0.50 ±  6%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp._find_next_or_bit
      0.40 ±  7%      -0.1        0.25 ±  8%  perf-profile.self.cycles-pp.do_dentry_open
      0.43 ±  7%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.38 ±  4%      -0.1        0.27 ±  6%  perf-profile.self.cycles-pp.strncpy_from_user
      0.27 ±  5%      -0.1        0.19 ±  8%  perf-profile.self.cycles-pp.shmem_statfs
      0.26 ±  2%      -0.1        0.18 ± 10%  perf-profile.self.cycles-pp.link_path_walk
      0.27 ±  3%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.26 ±  4%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp._copy_to_user
      0.20 ±  5%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.18 ±  5%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.simple_statfs
      0.20 ± 11%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.statfs_by_dentry
      0.28 ±  2%      -0.1        0.22 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.16 ±  9%      -0.1        0.10 ± 20%  perf-profile.self.cycles-pp.vfs_statfs
      0.18 ±  6%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.filename_lookup
      0.14 ±  7%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.lookup_fast
      0.17 ±  6%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.__statfs
      0.12 ±  6%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.apparmor_file_open
      0.14 ±  8%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.generic_permission
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.fstatfs64
      0.35 ±  7%      -0.0        0.31 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  9%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      0.11 ±  6%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.getname_flags
      0.18 ±  2%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.step_into
      0.09 ± 12%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.10 ±  7%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.__do_sys_statfs
      0.11 ±  9%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__check_heap_object
      0.12 ± 10%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.10 ± 11%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ± 15%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__check_object_size
      0.06 ±  6%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.dput
      0.11 ± 14%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.___d_drop
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__d_add
      0.03 ±102%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.__d_lookup_unhash
      0.06 ± 17%      +0.2        0.22 ± 28%  perf-profile.self.cycles-pp.__d_rehash
      0.00            +0.2        0.22 ± 12%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.08 ±  6%      +0.3        0.38 ±  3%  perf-profile.self.cycles-pp.__dentry_kill
      0.51 ±  3%      +0.9        1.37        perf-profile.self.cycles-pp.d_alloc_parallel
     58.90            +5.2       64.08        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit: 
  e3640d37d0 ("d_prune_aliases(): use a shrink list")
  1b738f196e ("__dentry_kill(): new locking scheme")

e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.326e+08 ±  2%     +24.6%  1.653e+08 ±  8%  cpuidle..usage
      0.00 ± 20%      -0.0        0.00 ± 31%  mpstat.cpu.all.iowait%
 4.868e+08           -13.8%  4.198e+08        numa-numastat.node0.local_node
 4.868e+08           -13.8%  4.198e+08        numa-numastat.node0.numa_hit
 4.852e+08           -13.8%   4.18e+08        numa-numastat.node1.local_node
 4.851e+08           -13.8%   4.18e+08        numa-numastat.node1.numa_hit
 4.868e+08           -13.8%  4.198e+08        numa-vmstat.node0.numa_hit
 4.868e+08           -13.8%  4.198e+08        numa-vmstat.node0.numa_local
 4.851e+08           -13.8%   4.18e+08        numa-vmstat.node1.numa_hit
 4.852e+08           -13.8%   4.18e+08        numa-vmstat.node1.numa_local
   1065776 ±  5%     -16.9%     885990 ± 16%  sched_debug.cpu.curr->pid.avg
   2252396 ±  5%     +24.7%    2808907 ± 17%  sched_debug.cpu.nr_switches.avg
   2308234 ±  5%     +24.6%    2875321 ± 17%  sched_debug.cpu.nr_switches.max
   2137887 ±  6%     +25.8%    2689356 ± 19%  sched_debug.cpu.nr_switches.min
 1.323e+08 ±  2%     +24.6%  1.649e+08 ±  8%  turbostat.C1
      0.20 ±  2%      -7.7%       0.18        turbostat.IPC
 1.767e+08           +17.5%  2.077e+08 ±  6%  turbostat.IRQ
    271093 ±  2%     +20.1%     325488        turbostat.POLL
     34960           -14.0%      30076        unixbench.score
   9707435           -11.2%    8623074        unixbench.time.involuntary_context_switches
    941389 ±  4%     -29.2%     666927 ±  2%  unixbench.time.major_page_faults
 1.414e+09           -14.1%  1.215e+09        unixbench.time.minor_page_faults
      3664           -11.8%       3230 ± 18%  unixbench.time.percent_of_cpu_this_job_got
     17917            -2.3%      17500        unixbench.time.system_time
      5493 ±  2%     -13.6%       4747        unixbench.time.user_time
 1.407e+08           +21.8%  1.713e+08        unixbench.time.voluntary_context_switches
  93485624           -14.0%   80383391        unixbench.workload
      0.57 ±  3%      -9.5%       0.51 ±  7%  perf-stat.i.ipc
      1407 ±  8%     -31.3%     966.27 ± 18%  perf-stat.i.major-faults
      2.79            +3.7%       2.90        perf-stat.overall.MPKI
      1.82            +0.0        1.86        perf-stat.overall.branch-miss-rate%
     21.19            -0.3       20.93        perf-stat.overall.cache-miss-rate%
      1.71            +9.7%       1.87        perf-stat.overall.cpi
    611.78            +5.8%     647.06        perf-stat.overall.cycles-between-cache-misses
      0.59            -8.9%       0.53        perf-stat.overall.ipc
     37.95            +1.5       39.41        perf-stat.overall.node-store-miss-rate%
    577254            +2.5%     591885        perf-stat.overall.path-length
      1407 ±  8%     -31.3%     966.36 ± 18%  perf-stat.ps.major-faults
 5.396e+13           -11.8%  4.758e+13        perf-stat.total.instructions
    541433            +6.1%     574449 ±  4%  proc-vmstat.nr_active_anon
   1244231            +2.7%    1277302        proc-vmstat.nr_file_pages
    562875            +5.9%     596142 ±  3%  proc-vmstat.nr_shmem
     46484            -1.7%      45671        proc-vmstat.nr_slab_unreclaimable
    541433            +6.1%     574449 ±  4%  proc-vmstat.nr_zone_active_anon
  9.72e+08           -13.8%  8.379e+08        proc-vmstat.numa_hit
  9.72e+08           -13.8%  8.378e+08        proc-vmstat.numa_local
   1616185            -6.8%    1506542        proc-vmstat.pgactivate
 1.027e+09           -13.8%  8.852e+08        proc-vmstat.pgalloc_normal
 1.419e+09           -14.1%  1.219e+09        proc-vmstat.pgfault
 1.026e+09           -13.8%  8.845e+08        proc-vmstat.pgfree
  56010484           -13.9%   48217446        proc-vmstat.pgreuse
     49104           -14.1%      42170        proc-vmstat.thp_fault_alloc
  20652818           -13.9%   17786115        proc-vmstat.unevictable_pgs_culled
      0.02 ± 15%     -38.7%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.03 ± 19%     -34.9%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.00 ± 27%    +629.6%       0.03 ±103%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.unmap_region
      0.02 ± 19%     -46.6%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.05 ±164%     -93.7%       0.00 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 11%     +24.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.02 ± 16%     -29.9%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.03 ± 21%     -61.8%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.02 ± 17%     -60.9%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.03 ± 14%     -35.4%       0.02 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.01           -12.5%       0.01        perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 13%     -43.6%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.03 ±  3%      -9.5%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 13%     -44.3%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.02 ±  7%     -44.6%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±  8%     -39.3%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.02 ±  8%     -42.5%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.02 ±  2%     -33.7%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  3%     -45.7%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.02           -22.5%       0.01 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.01 ±  3%     -34.7%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.01 ±  9%     -28.3%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.01 ±  3%     -28.4%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  9%     -25.3%       0.02 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ±  4%     -40.5%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ±  2%     -13.5%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 55%     -35.6%       0.03 ±  2%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.14 ± 12%     -30.2%       0.79 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.82 ± 15%     -60.3%       0.33 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      1.50 ± 12%     -40.2%       0.90 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.37 ±168%     -94.6%       0.02 ±104%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.04 ± 31%     -68.6%       0.33 ± 80%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.85 ± 21%     -71.0%       0.25 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      1.40 ± 15%     -49.0%       0.72 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.73 ± 59%     -63.9%       0.26 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      1.96 ± 12%     -39.8%       1.18 ± 20%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.52 ±  8%     -40.1%       0.91 ± 29%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.37 ±109%     -76.8%       0.09 ±124%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.73 ± 19%     -37.4%       1.08 ± 19%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.02 ±  2%     -23.3%       0.02 ±  3%  perf-sched.total_sch_delay.average.ms
      1.54           -11.5%       1.36        perf-sched.total_wait_and_delay.average.ms
   1415991           +15.3%    1632971        perf-sched.total_wait_and_delay.count.ms
      1.52           -11.4%       1.35        perf-sched.total_wait_time.average.ms
      7.98 ± 14%     +48.2%      11.82 ± 41%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      2.88 ±  4%     +22.3%       3.53 ± 22%  perf-sched.wait_and_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      3.54           +16.6%       4.13        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.56           +12.2%       7.36        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.89 ±  3%     +23.8%       2.34        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.26           -17.2%       0.22        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.24           -12.5%       0.21        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.24           -17.6%       0.20        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.16           -19.0%       0.13        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.31 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.13 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.25 ±  3%     -15.2%       0.21 ±  6%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
    101.17 ±  9%     -28.3%      72.50 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    144.67 ± 10%     -28.7%     103.17 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
    697.83 ±  5%     -31.9%     475.33 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
     12.67 ± 11%     +47.4%      18.67 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
     50.33 ± 14%     -23.5%      38.50 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      4171           -19.0%       3377 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     43094           -11.7%      38068        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    470.00 ±  8%     -17.5%     387.67 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
    767.83 ±  3%      -9.9%     691.83 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     94251            -9.2%      85615        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     74776            -9.5%      67707        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     40594 ±  2%     -22.8%      31343        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     73475 ±  2%     +11.3%      81792        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
    813985           +34.3%    1093285        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
     12982 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
     15029 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     21012            -9.2%      19084        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10470            -9.2%       9508        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.09 ± 20%     -64.7%       1.80 ±104%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.alloc_pipe_info.create_pipe_files
     31.67 ± 10%     +12.8%      35.71 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
     24.60 ± 27%     +28.6%      31.64 ±  4%  perf-sched.wait_and_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
     32.65 ±  5%    +505.8%     197.81 ±181%  perf-sched.wait_and_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
     33.27 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      4.30 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.16 ± 18%     -36.7%       0.10 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.do_cow_fault.do_fault.__handle_mm_fault
      0.20 ±  2%     -21.7%       0.16 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.23 ±  8%     -19.2%       0.19 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
      0.22 ± 32%     -29.4%       0.15 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.01 ± 42%     -88.2%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.get_arg_page.copy_string_kernel.load_script
      0.21 ±  4%     -14.1%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.21 ±  2%     -16.4%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.20 ±  6%     -15.7%       0.17 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.22 ±  4%     -16.7%       0.19 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.18 ± 92%     -62.5%       0.07 ± 57%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.19 ± 35%     -56.0%       0.08 ± 59%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±  2%     -11.5%       0.19        perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.26 ±  5%     -26.8%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.22           -13.7%       0.19        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.21 ±  5%     -13.3%       0.18 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.21 ±  4%     -13.6%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.21 ±  8%     -16.4%       0.17 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.22 ± 14%     -21.3%       0.17 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.19 ±  7%     -20.5%       0.15 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.24 ±  2%     -18.0%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      7.94 ± 14%     +48.8%      11.81 ± 41%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.31 ± 15%     -49.4%       0.16 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.03 ± 84%     -77.2%       0.01 ± 94%  perf-sched.wait_time.avg.ms.__cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages.load_elf_binary
      0.23           -13.9%       0.20 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.49 ± 59%    +214.4%       1.54 ± 41%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.86 ±  4%     +22.8%       3.51 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.23 ± 12%     -20.3%       0.18 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
      0.25 ±  4%     -23.5%       0.19 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.20 ±  2%     -19.1%       0.17 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.25 ±  5%     -19.0%       0.20 ±  2%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      3.51           +16.8%       4.10        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.53           +12.3%       7.33        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.68 ± 64%     -77.8%       0.15 ± 54%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.14 ±  2%     -21.5%       0.11 ±  3%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.87 ±  3%     +24.4%       2.33        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.24           -14.6%       0.21        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.23           -11.9%       0.20        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.23           -16.7%       0.19        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.12 ±  4%     -33.4%       0.08 ± 12%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.15           -17.9%       0.12        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.12 ±  4%     -31.5%       0.08 ±  6%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.23 ±  3%     -13.2%       0.20 ±  6%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±139%    +162.1%       0.24 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_string_kernel
      5.08 ± 20%     -61.2%       1.97 ± 87%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.alloc_pipe_info.create_pipe_files
      1.81 ±  6%     -25.0%       1.35 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      1.61 ± 22%     -48.7%       0.82 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.70 ± 23%     -59.5%       0.29 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vma_modify.mprotect_fixup
      1.21 ± 25%     -46.7%       0.64 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.41 ± 75%     -56.6%       0.18 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.80 ±126%     -75.3%       0.69 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      1.70 ± 12%     -39.1%       1.04 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.65 ± 59%     -43.5%       0.37 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
     31.66 ± 10%     +12.8%      35.70 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      1.30 ± 49%     -49.8%       0.65 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      1.90 ± 25%     -42.1%       1.10 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
     24.59 ± 27%     +28.6%      31.63 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      2.35 ± 93%    +142.8%       5.71 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     32.42 ±  3%    +510.0%     197.80 ±181%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      1.73 ± 58%     -47.8%       0.90 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      5.53 ± 74%     -90.4%       0.53 ± 82%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      4.41 ± 45%     -55.3%       1.97 ± 41%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      4.38 ± 12%     -40.2%       2.62 ± 29%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      4.29 ± 13%     -42.1%       2.48 ± 23%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     15.38 ±  5%      -6.9        8.50 ±  3%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.11 ±  5%      -6.8        8.26 ±  4%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     13.78 ±  6%      -6.6        7.14 ±  4%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.80 ±  6%      -6.6        7.16 ±  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.97 ±  6%      -5.4        4.58 ±  4%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      7.35 ±  8%      -4.5        2.80 ± 14%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
      6.69 ±  9%      -4.5        2.22 ±  6%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
      9.07 ±  6%      -4.5        4.61 ±  4%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      5.75 ±  9%      -4.0        1.80 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      5.31 ±  8%      -3.3        2.04 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      5.96 ±  2%      -2.9        3.03        perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      5.76 ±  7%      -2.8        2.97 ±  4%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      5.11 ±  7%      -2.7        2.44 ±  6%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      4.69 ±  8%      -2.6        2.09 ±  6%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      4.66 ±  8%      -2.6        2.06 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      4.04 ±  7%      -2.5        1.51 ±  5%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      3.82 ±  7%      -2.5        1.35 ±  6%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      3.75 ±  7%      -2.4        1.32 ±  6%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.68 ±  7%      -2.4        1.30 ±  6%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
      3.64 ±  8%      -2.4        1.27 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
      9.84            -2.3        7.50        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.84            -2.3        7.50        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.84            -2.3        7.50        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.27            -2.2        6.03        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      8.29            -2.2        6.05        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      8.30            -2.2        6.06        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.80 ±  9%      -2.1        1.67 ± 19%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      3.93 ±  9%      -2.1        1.84 ± 14%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      8.80            -1.9        6.89        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.21            -1.9        7.36        perf-profile.calltrace.cycles-pp.execve
      9.20            -1.8        7.35        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      9.19            -1.8        7.34        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      9.20            -1.8        7.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      9.20            -1.8        7.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      8.21            -1.8        6.37        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      8.19            -1.8        6.36        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      8.10            -1.8        6.27        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      4.42 ±  2%      -1.6        2.80        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      3.88 ±  4%      -1.6        2.28 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.24 ±  2%      -1.6        2.65        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      4.74 ±  3%      -1.5        3.21 ±  9%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.90 ±  6%      -1.5        2.40 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      3.56 ±  5%      -1.5        2.05 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      2.57 ±  8%      -1.4        1.14 ±  6%  perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      2.53 ±  8%      -1.4        1.11 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      2.50 ±  8%      -1.4        1.09 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      3.12 ±  7%      -1.4        1.72 ±  4%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      2.32 ±  9%      -1.4        0.96 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      3.61 ±  8%      -1.2        2.43        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      3.60 ±  8%      -1.2        2.42        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      4.86 ±  3%      -1.2        3.68        perf-profile.calltrace.cycles-pp.__libc_fork
      7.30            -1.1        6.19        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      4.31 ±  3%      -1.1        3.20        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.31 ±  3%      -1.1        3.20        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.30 ±  3%      -1.1        3.20        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.30 ±  3%      -1.1        3.20        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      6.63 ±  2%      -1.0        5.62        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      6.59 ±  2%      -1.0        5.58        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.85            -0.9        4.94        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.57 ±  2%      -0.9        4.70        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.76 ±  6%      -0.8        0.99 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
      1.23 ± 13%      -0.8        0.47 ± 45%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
      1.49 ± 12%      -0.7        0.76 ±  6%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      1.08 ±  8%      -0.7        0.36 ± 70%  perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.42 ± 13%      -0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      1.39 ± 13%      -0.7        0.68 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      0.94 ±  7%      -0.7        0.26 ±100%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.27 ±  8%      -0.7        0.59 ±  5%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
      3.67 ±  2%      -0.6        3.08        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      3.34 ±  2%      -0.5        2.80        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.29 ±  4%      -0.5        0.78 ±  2%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.28 ±  4%      -0.5        0.76 ±  3%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.17 ±  2%      -0.5        2.66        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.75 ±  2%      -0.5        1.24        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ±  2%      -0.5        1.24        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.22 ±  5%      -0.5        0.72 ±  3%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.60 ±  2%      -0.5        1.12        perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±  2%      -0.5        0.99 ±  2%  perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.42 ±  2%      -0.5        0.96 ±  2%  perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      2.83 ±  2%      -0.4        2.40        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.66 ±  2%      -0.4        2.24        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      0.98 ±  4%      -0.4        0.59 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      2.26 ±  2%      -0.4        1.90        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      2.12 ±  2%      -0.3        1.78        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.86 ±  3%      -0.3        1.55 ±  2%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.30            -0.3        1.01        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.31            -0.3        1.02        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±  2%      -0.3        1.52        perf-profile.calltrace.cycles-pp.__mmap
      1.34 ±  2%      -0.3        1.07        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.77 ±  2%      -0.3        1.50        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.37 ±  2%      -0.3        1.10        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.77 ±  2%      -0.3        1.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.74 ±  2%      -0.3        1.47        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.72 ±  2%      -0.3        1.45        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.58 ±  2%      -0.3        1.32        perf-profile.calltrace.cycles-pp.setlocale
      0.59 ±  2%      -0.3        0.34 ± 70%  perf-profile.calltrace.cycles-pp._IO_default_xsputn
      1.26 ±  2%      -0.2        1.02 ±  7%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      1.26 ±  2%      -0.2        1.03 ±  7%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.07 ±  2%      -0.2        0.85 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.77 ±  2%      -0.2        0.54        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  2%      -0.2        0.54        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ±  3%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat
      0.64 ±  3%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.86 ±  2%      -0.2        0.66 ±  3%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.41 ±  2%      -0.2        1.22        perf-profile.calltrace.cycles-pp._dl_addr
      0.60 ±  3%      -0.2        0.42 ± 44%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.02 ±  2%      -0.2        0.85        perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      0.97 ±  2%      -0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.98 ±  2%      -0.2        0.82        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.98 ±  2%      -0.2        0.82        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.97 ±  2%      -0.2        0.81        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.82 ±  2%      -0.1        0.67 ±  8%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.79 ±  2%      -0.1        0.65 ±  8%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary
      0.77 ±  2%      -0.1        0.63 ±  8%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp
      0.79 ±  2%      -0.1        0.65        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.70 ±  3%      -0.1        0.56        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat.do_filp_open
      0.71 ±  3%      -0.1        0.58        perf-profile.calltrace.cycles-pp.down_read.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.06 ±  2%      -0.1        0.94        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.70            -0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.wait4
      0.88 ±  2%      -0.1        0.75        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.69            -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.69            -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.83            -0.1        0.71        perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.06 ±  2%      -0.1        0.94        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.82 ±  2%      -0.1        0.70        perf-profile.calltrace.cycles-pp.__strcoll_l
      1.02 ±  2%      -0.1        0.91        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.78 ±  3%      -0.1        0.67        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.75 ±  2%      -0.1        0.64        perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.72 ±  2%      -0.1        0.61        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.84 ±  2%      -0.1        0.76        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.68 ±  2%      -0.1        0.60        perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ±  3%      +0.0        0.67 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.77 ±  3%      +0.0        0.81        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.99 ±  2%      +0.1        1.05        perf-profile.calltrace.cycles-pp.open64
      0.97            +0.1        1.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.97            +0.1        1.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.96            +0.1        1.03        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.96            +0.1        1.03        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.30 ±  2%      +0.1        1.38 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      1.33 ±  2%      +0.1        1.45 ±  2%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.72 ±  2%      +0.1        0.85 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.73 ±  2%      +0.1        0.86 ±  2%  perf-profile.calltrace.cycles-pp.unlinkat
      0.72 ±  2%      +0.1        0.85 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.72 ±  2%      +0.1        0.85 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.52 ±  2%      +0.1        0.66        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.71 ±  2%      +0.1        0.85 ±  2%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.62            +0.2        0.78        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.64 ±  2%      +0.2        0.82        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.76            +0.2        0.96        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.34 ± 70%      +0.2        0.55        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.73 ±  3%      +0.2        0.94        perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.70 ±  3%      +0.2        0.92        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.70 ±  3%      +0.2        0.91        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      0.70 ±  3%      +0.2        0.91        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      0.62 ±  4%      +0.2        0.86 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.64 ±  4%      +0.2        0.88 ±  2%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.56 ±  2%      +0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.52 ±  3%      +0.3        0.78 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      1.63 ±  2%      +0.3        1.91        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.44 ± 44%      +0.3        0.77 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
      1.91 ±  2%      +0.4        2.29 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.08 ±223%      +0.5        0.54        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      2.16 ±  3%      +0.5        2.69 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      2.80 ±  2%      +0.6        3.36        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.90 ±  2%      +0.6        3.49        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.91 ±  2%      +0.6        3.50        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.61 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_lookupat
      3.16 ±  2%      +0.6        3.78        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
      3.51 ±  2%      +0.7        4.16        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open
      3.78 ±  2%      +0.7        4.46        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.79 ±  2%      +0.7        4.48        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.79 ±  2%      +0.7        4.48        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      3.85 ±  2%      +0.7        4.55        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.39 ±  2%      +0.7        2.10        perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.00            +0.7        0.72 ±  3%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      0.00            +0.8        0.75 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_lookups
      0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
      1.54 ±  2%      +0.8        2.31        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      1.56 ±  2%      +0.8        2.35        perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      2.57 ±  2%      +0.8        3.36        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      2.87 ±  2%      +0.9        3.72 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74 ±  3%      +0.9        3.61 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74 ±  2%      +0.9        3.62 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.72 ±  3%      +0.9        3.60 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      2.47 ± 11%      +1.0        3.44        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath
      2.07 ±  2%      +1.0        3.10        perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      2.27 ±  2%      +1.1        3.39        perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled
      3.75 ±  2%      +1.2        4.91 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      3.11 ±  2%      +1.4        4.50        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      3.12 ±  2%      +1.4        4.50        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk
      3.44 ±  3%      +1.6        5.08        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk.path_openat
      3.52 ±  2%      +1.7        5.22        perf-profile.calltrace.cycles-pp.down_read.walk_component.link_path_walk.path_openat.do_filp_open
      8.79 ±  2%      +2.0       10.76        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
      8.87 ±  2%      +2.1       10.96        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +2.9        2.85        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      0.00            +2.9        2.94        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.00            +3.0        3.01        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      1.25            +3.0        4.30 ±  2%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.22            +3.0        4.27 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      2.23 ±  2%      +3.8        5.99        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.95 ±  2%      +3.8        5.74        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      2.37 ±  2%      +4.0        6.32        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      0.00            +4.0        3.99 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      0.00            +4.2        4.17 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
      2.43 ±  2%      +4.2        6.66 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      2.84 ±  3%      +4.2        7.08        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      1.91 ±  2%      +4.3        6.23        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      2.98 ±  3%      +4.4        7.35        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      1.94 ±  2%      +4.4        6.34        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      3.40 ±  2%      +4.5        7.87        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      3.42 ±  2%      +4.5        7.89        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.24 ±  3%      +4.6        7.80        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.00            +4.6        4.56 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
     57.32            +5.4       62.75        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     57.28            +5.4       62.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.77 ±  2%      +7.6       22.32        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +7.6        7.62        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00            +7.7        7.67        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
     16.16 ±  2%     +10.6       26.74        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     25.79 ±  2%     +15.2       40.99        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.72 ±  2%     +15.2       40.92        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     24.66 ±  2%     +15.2       39.87        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.64 ±  2%     +15.2       39.86        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.04 ±  8%     -10.2        9.83 ±  4%  perf-profile.children.cycles-pp.down_write
     19.21 ±  8%     -10.1        9.14 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     18.64 ±  8%      -9.9        8.70 ±  5%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     16.79 ±  9%      -9.5        7.31 ±  6%  perf-profile.children.cycles-pp.osq_lock
      7.93 ±  2%      -7.9        0.00        perf-profile.children.cycles-pp.fast_dput
     18.24 ±  5%      -7.7       10.58 ±  2%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     18.05 ±  5%      -7.6       10.42 ±  3%  perf-profile.children.cycles-pp.do_mmap
     17.69 ±  5%      -7.6       10.10 ±  3%  perf-profile.children.cycles-pp.mmap_region
     15.53 ±  5%      -6.9        8.63 ±  3%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     11.12 ±  6%      -5.1        6.00 ±  3%  perf-profile.children.cycles-pp.do_vmi_munmap
     11.02 ±  6%      -5.1        5.92 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      9.95 ±  6%      -4.5        5.43 ±  3%  perf-profile.children.cycles-pp.free_pgtables
      8.52 ±  7%      -4.3        4.24 ±  4%  perf-profile.children.cycles-pp.unlink_file_vma
      7.23 ±  7%      -3.6        3.59 ±  5%  perf-profile.children.cycles-pp.vma_prepare
     12.23            -3.4        8.81        perf-profile.children.cycles-pp.__mmput
     12.20            -3.4        8.77        perf-profile.children.cycles-pp.exit_mmap
      7.54 ±  5%      -3.3        4.23 ±  3%  perf-profile.children.cycles-pp.__split_vma
     10.00            -2.4        7.63        perf-profile.children.cycles-pp.do_exit
     10.00            -2.4        7.64        perf-profile.children.cycles-pp.__x64_sys_exit_group
     10.00            -2.4        7.64        perf-profile.children.cycles-pp.do_group_exit
      8.32            -2.2        6.07        perf-profile.children.cycles-pp.exit_mm
      4.60 ±  6%      -2.2        2.40 ±  4%  perf-profile.children.cycles-pp.unmap_region
     10.51            -2.1        8.37        perf-profile.children.cycles-pp.__x64_sys_execve
     10.49            -2.1        8.36        perf-profile.children.cycles-pp.do_execveat_common
      8.86            -1.9        6.94        perf-profile.children.cycles-pp.bprm_execve
      9.21            -1.9        7.36        perf-profile.children.cycles-pp.execve
      8.21            -1.8        6.37        perf-profile.children.cycles-pp.exec_binprm
      8.19            -1.8        6.36        perf-profile.children.cycles-pp.search_binary_handler
      8.10            -1.8        6.27        perf-profile.children.cycles-pp.load_elf_binary
     10.39 ±  2%      -1.6        8.80        perf-profile.children.cycles-pp.asm_exc_page_fault
      9.33 ±  2%      -1.4        7.89        perf-profile.children.cycles-pp.exc_page_fault
      9.29 ±  2%      -1.4        7.85        perf-profile.children.cycles-pp.do_user_addr_fault
      5.50 ±  3%      -1.4        4.13        perf-profile.children.cycles-pp.kernel_clone
      8.55 ±  2%      -1.3        7.20        perf-profile.children.cycles-pp.handle_mm_fault
      5.07 ±  3%      -1.3        3.74        perf-profile.children.cycles-pp.__do_sys_clone
      4.97 ±  3%      -1.3        3.67        perf-profile.children.cycles-pp.copy_process
      8.17 ±  2%      -1.3        6.88        perf-profile.children.cycles-pp.__handle_mm_fault
      4.42 ±  2%      -1.3        3.17        perf-profile.children.cycles-pp.begin_new_exec
      4.24 ±  2%      -1.2        3.01        perf-profile.children.cycles-pp.exec_mmap
      3.88 ±  4%      -1.2        2.67 ±  2%  perf-profile.children.cycles-pp.dup_mm
      4.90 ±  2%      -1.2        3.72        perf-profile.children.cycles-pp.__libc_fork
      3.56 ±  5%      -1.2        2.41 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      5.43 ±  2%      -0.9        4.54        perf-profile.children.cycles-pp.do_fault
      4.99 ±  3%      -0.8        4.16        perf-profile.children.cycles-pp.do_read_fault
      4.83 ±  3%      -0.8        4.02        perf-profile.children.cycles-pp.filemap_map_pages
      1.12 ±  7%      -0.6        0.54 ±  6%  perf-profile.children.cycles-pp.vma_expand
      3.46 ±  2%      -0.5        2.94        perf-profile.children.cycles-pp.unmap_vmas
      1.75 ±  2%      -0.5        1.24        perf-profile.children.cycles-pp.__x64_sys_mprotect
      1.75 ±  2%      -0.5        1.24        perf-profile.children.cycles-pp.do_mprotect_pkey
      2.84 ±  3%      -0.5        2.35 ±  2%  perf-profile.children.cycles-pp.next_uptodate_folio
      3.20 ±  2%      -0.5        2.71        perf-profile.children.cycles-pp.unmap_page_range
      1.60 ±  2%      -0.5        1.12        perf-profile.children.cycles-pp.mprotect_fixup
      3.10 ±  2%      -0.5        2.63        perf-profile.children.cycles-pp.zap_pmd_range
      1.46 ±  2%      -0.5        0.99 ±  2%  perf-profile.children.cycles-pp.vma_modify
      3.04 ±  2%      -0.5        2.58        perf-profile.children.cycles-pp.zap_pte_range
      1.54            -0.4        1.13        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      2.35            -0.4        1.95 ±  4%  perf-profile.children.cycles-pp.elf_load
      2.11 ±  2%      -0.4        1.72        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.90 ±  2%      -0.4        1.54        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      1.59 ±  2%      -0.3        1.28        perf-profile.children.cycles-pp.release_pages
      1.81 ±  2%      -0.3        1.53        perf-profile.children.cycles-pp.__mmap
      1.41 ±  2%      -0.3        1.14 ±  7%  perf-profile.children.cycles-pp.load_elf_interp
      1.21 ±  2%      -0.3        0.95 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      1.84            -0.3        1.58        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.59 ±  2%      -0.3        1.33        perf-profile.children.cycles-pp.setlocale
      1.66            -0.2        1.43        perf-profile.children.cycles-pp.vma_interval_tree_insert
      1.33 ±  2%      -0.2        1.11        perf-profile.children.cycles-pp.__open64_nocancel
      1.45 ±  2%      -0.2        1.23        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.86 ±  3%      -0.2        0.65 ±  3%  perf-profile.children.cycles-pp.init_file
      1.38 ±  2%      -0.2        1.18        perf-profile.children.cycles-pp.__alloc_pages
      0.74 ±  3%      -0.2        0.55 ±  3%  perf-profile.children.cycles-pp.security_file_alloc
      1.42 ±  2%      -0.2        1.23        perf-profile.children.cycles-pp._dl_addr
      1.14 ±  2%      -0.2        0.95        perf-profile.children.cycles-pp.page_remove_rmap
      0.65 ±  3%      -0.2        0.46 ±  4%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.04 ±  2%      -0.2        0.86 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      0.86            -0.2        0.70 ±  2%  perf-profile.children.cycles-pp.vma_complete
      0.46 ±  3%      -0.2        0.30 ±  6%  perf-profile.children.cycles-pp.security_file_free
      0.45 ±  3%      -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.apparmor_file_free_security
      1.28 ±  2%      -0.2        1.12        perf-profile.children.cycles-pp.ret_from_fork_asm
      1.25 ±  2%      -0.2        1.09        perf-profile.children.cycles-pp.ret_from_fork
      0.73 ±  2%      -0.2        0.58 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.00 ±  3%      -0.1        0.85        perf-profile.children.cycles-pp.set_pte_range
      0.96 ±  2%      -0.1        0.81        perf-profile.children.cycles-pp.get_page_from_freelist
      0.93            -0.1        0.79        perf-profile.children.cycles-pp.perf_event_mmap
      1.04            -0.1        0.90        perf-profile.children.cycles-pp.do_anonymous_page
      0.90            -0.1        0.76        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.94 ±  2%      -0.1        0.80        perf-profile.children.cycles-pp.wp_page_copy
      0.88 ±  4%      -0.1        0.75 ±  3%  perf-profile.children.cycles-pp._compound_head
      1.50            -0.1        1.37        perf-profile.children.cycles-pp.kmem_cache_free
      0.94 ±  2%      -0.1        0.81        perf-profile.children.cycles-pp.mas_store_prealloc
      0.69 ±  2%      -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.71            -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.wait4
      0.68            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.kernel_wait4
      0.21            -0.1        0.08 ±  5%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.67 ±  2%      -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.do_wait
      0.82 ±  2%      -0.1        0.70        perf-profile.children.cycles-pp.__strcoll_l
      1.02 ±  2%      -0.1        0.91        perf-profile.children.cycles-pp.kthread
      0.54 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.release_empty_file
      0.68 ±  5%      -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.mm_init
      0.64 ±  2%      -0.1        0.54 ±  2%  perf-profile.children.cycles-pp._IO_default_xsputn
      0.60            -0.1        0.51        perf-profile.children.cycles-pp.perf_iterate_sb
      0.80 ±  2%      -0.1        0.71        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.64 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.54 ±  2%      -0.1        0.45        perf-profile.children.cycles-pp.vma_alloc_folio
      0.47 ±  3%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.do_open
      0.85 ±  2%      -0.1        0.76        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.60            -0.1        0.51        perf-profile.children.cycles-pp.sync_regs
      0.59 ±  3%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.52 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.vfs_read
      1.58 ±  2%      -0.1        1.49        perf-profile.children.cycles-pp.__do_softirq
      0.64 ±  2%      -0.1        0.56        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.53 ±  2%      -0.1        0.44        perf-profile.children.cycles-pp.ksys_read
      0.78 ±  2%      -0.1        0.69        perf-profile.children.cycles-pp.copy_strings
      0.58 ±  2%      -0.1        0.50        perf-profile.children.cycles-pp.copy_page_range
      1.40 ±  2%      -0.1        1.32        perf-profile.children.cycles-pp.rcu_core
      0.48 ±  2%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.__fput
      0.57 ±  2%      -0.1        0.49        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.56 ±  2%      -0.1        0.48        perf-profile.children.cycles-pp.copy_p4d_range
      0.48 ±  2%      -0.1        0.40        perf-profile.children.cycles-pp.read
      1.36 ±  2%      -0.1        1.28        perf-profile.children.cycles-pp.rcu_do_batch
      0.48 ±  3%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.task_work_run
      0.50            -0.1        0.42        perf-profile.children.cycles-pp.clear_page_erms
      0.96 ±  2%      -0.1        0.88        perf-profile.children.cycles-pp.__slab_free
      0.27 ±  5%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      1.71            -0.1        1.64        perf-profile.children.cycles-pp.up_write
      0.54 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.46 ±  3%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.62 ±  2%      -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.50 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.vm_area_alloc
      0.41            -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.56            -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.getname_flags
      0.35 ±  4%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.do_dentry_open
      0.54 ±  2%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.44 ±  2%      -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.dup_task_struct
      0.46 ±  3%      -0.1        0.39 ±  3%  perf-profile.children.cycles-pp.alloc_bprm
      0.47            -0.1        0.40        perf-profile.children.cycles-pp.vm_area_dup
      0.41 ±  3%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.40 ±  3%      -0.1        0.34        perf-profile.children.cycles-pp.do_task_dead
      0.38 ±  3%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.66 ±  2%      -0.1        0.59        perf-profile.children.cycles-pp.mod_objcg_state
      0.50 ±  3%      -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.44 ±  2%      -0.1        0.37        perf-profile.children.cycles-pp.mas_wr_node_store
      0.36 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.free_swap_cache
      0.39 ±  3%      -0.1        0.33        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.43 ±  3%      -0.1        0.37        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.34 ±  3%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.58 ±  2%      -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.63 ±  3%      -0.1        0.57 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.42 ±  4%      -0.1        0.36        perf-profile.children.cycles-pp.do_cow_fault
      0.48 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.__vfork
      0.45            -0.1        0.39        perf-profile.children.cycles-pp.strnlen_user
      0.39 ±  6%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc
      0.46 ±  2%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.44 ±  2%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.get_arg_page
      0.39 ±  2%      -0.1        0.34        perf-profile.children.cycles-pp.setup_arg_pages
      0.31 ±  2%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.pipe_read
      0.40 ±  3%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.41 ±  3%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.wake_up_new_task
      0.30 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.30 ±  3%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.34 ±  2%      -0.1        0.29        perf-profile.children.cycles-pp.free_unref_page_commit
      0.30 ±  4%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
      0.47 ±  3%      -0.1        0.42        perf-profile.children.cycles-pp.run_ksoftirqd
      0.39            -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.pte_alloc_one
      0.43 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.__x64_sys_vfork
      0.40 ±  3%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.mas_split
      0.31            -0.1        0.26 ±  3%  perf-profile.children.cycles-pp._IO_padn
      0.38 ±  4%      -0.0        0.33 ±  3%  perf-profile.children.cycles-pp.mtree_range_walk
      0.30 ±  4%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.30 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.27 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__do_wait
      0.40            -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.create_elf_tables
      0.40 ±  3%      -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.sched_exec
      0.39 ±  3%      -0.0        0.34        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.37 ±  2%      -0.0        0.32 ±  4%  perf-profile.children.cycles-pp.__vm_area_free
      0.35 ±  4%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.27 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.39 ±  2%      -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      0.36            -0.0        0.31 ±  3%  perf-profile.children.cycles-pp.__get_user_pages
      0.36            -0.0        0.32 ±  3%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.29 ±  4%      -0.0        0.25        perf-profile.children.cycles-pp.write
      0.22 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.39 ±  3%      -0.0        0.35        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.33 ±  3%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.shift_arg_pages
      0.32 ±  3%      -0.0        0.28        perf-profile.children.cycles-pp.copy_pte_range
      0.24 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__fxstat64
      0.43 ±  3%      -0.0        0.39        perf-profile.children.cycles-pp.__cond_resched
      0.36            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.36 ±  3%      -0.0        0.31        perf-profile.children.cycles-pp.mas_preallocate
      0.28 ±  2%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.copy_string_kernel
      0.28 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.31 ±  4%      -0.0        0.26        perf-profile.children.cycles-pp.vfs_write
      0.27 ±  4%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp._IO_fwrite
      0.34 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.__perf_sw_event
      0.32 ±  5%      -0.0        0.28        perf-profile.children.cycles-pp.ksys_write
      0.30 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__pte_alloc
      0.28 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.28 ±  4%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.25            -0.0        0.21        perf-profile.children.cycles-pp.__wp_page_copy_user
      0.21 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.schedule_tail
      0.32 ±  3%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.get_unmapped_area
      0.30 ±  4%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.28 ±  2%      -0.0        0.24        perf-profile.children.cycles-pp.memset_orig
      0.27 ±  2%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__rb_erase_color
      0.11 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.apparmor_file_open
      0.19 ±  6%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.28 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.22 ±  4%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__pmd_alloc
      0.16 ±  4%      -0.0        0.13        perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.security_file_open
      0.23 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.22 ±  3%      -0.0        0.19        perf-profile.children.cycles-pp.copy_page_to_iter
      0.58 ±  2%      -0.0        0.55        perf-profile.children.cycles-pp.tick_sched_handle
      0.28 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.26 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__close
      0.21 ±  6%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.19 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.d_path
      0.19 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.memmove
      0.70 ±  2%      -0.0        0.66        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.59            -0.0        0.56        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.26 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.26 ±  2%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.18 ±  2%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.24            -0.0        0.21        perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.23 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.22 ±  3%      -0.0        0.19        perf-profile.children.cycles-pp._copy_to_iter
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.wait_task_zombie
      0.61 ±  2%      -0.0        0.58        perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.22            -0.0        0.19        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.21 ±  4%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.map_vdso
      0.19 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_find
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.exit_notify
      0.24            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
      0.58 ±  2%      -0.0        0.55        perf-profile.children.cycles-pp.update_process_times
      0.18 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.40 ±  3%      -0.0        0.37 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.24 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.filemap_read
      0.24 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.20 ±  3%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.20            -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.do_open_execat
      0.19 ±  3%      -0.0        0.16        perf-profile.children.cycles-pp.__pud_alloc
      0.17 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.release_task
      0.16 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.lru_add_fn
      0.27 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp.__check_object_size
      0.26 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.___slab_alloc
      0.19 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.18            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.mas_store_gfp
      0.18 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.14 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.do_notify_parent
      0.22 ±  4%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.22 ±  3%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.flush_tlb_func
      0.20            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.19 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp._exit
      0.16 ±  5%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__cxa_atexit
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__put_user_4
      0.48 ±  2%      -0.0        0.46 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__install_special_mapping
      0.19 ±  3%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp._IO_file_xsputn
      0.18            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_store
      0.10            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.security_mmap_file
      0.12 ± 10%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.fopen
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.malloc
      0.13 ±  5%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__do_fault
      0.17 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.move_page_tables
      0.16 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.wmemchr
      0.14 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__sysconf
      0.19 ±  2%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.15 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.prepend_path
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.apparmor_mmap_file
      0.15 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.__put_anon_vma
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.vfs_fstat
      0.11 ±  6%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.process_one_work
      0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.17 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.worker_thread
      0.15 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
      0.11 ±  6%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.prepare_creds
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.filemap_fault
      0.13 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.18 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.15 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.generic_perform_write
      0.15 ±  6%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.17 ±  5%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.17 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__get_free_pages
      0.17 ±  4%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
      0.16 ±  4%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.16 ±  4%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.brk
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._setjmp
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.free_pud_range
      0.17 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.balance_fair
      0.15 ±  5%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.free_p4d_range
      0.15 ±  4%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.__do_sys_brk
      0.12 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.12 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.handle_pte_fault
      0.11 ±  5%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.free_percpu
      0.09 ±  7%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.11 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.user_path_at_empty
      0.13 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__get_user_8
      0.13 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.prepend_copy
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.security_inode_getattr
      0.22 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__memcpy
      0.10 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_prev_slot
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      0.10 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.pipe_write
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp._IO_setb
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sched_move_task
      0.12 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.mas_update_gap
      0.12 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.do_faccessat
      0.37 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.___perf_sw_event
      0.15 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.insert_vm_struct
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__wait_for_common
      0.07            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.complete_signal
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__put_task_struct
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.remove_vma
      0.12 ±  4%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.mas_wr_walk
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.mas_push_data
      0.11 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.strchrnul@plt
      0.11 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.10 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.getenv
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.acct_collect
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.vfree
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__send_signal_locked
      0.10            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.count
      0.11 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.expand_downwards
      0.11 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.alloc_fd
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__exit_signal
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__munmap
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__free_one_page
      0.09 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.__snprintf_chk
      0.09 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.fput
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.11            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.do_wp_page
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.08 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.07            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      0.07            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.uncharge_batch
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.wait_for_completion_state
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.mas_pop_node
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.06 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__pipe
      0.12 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.mas_topiary_replace
      0.08 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.copy_present_pte
      0.08            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_get_entry
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.__x64_sys_rt_sigsuspend
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.get_sigframe
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.__update_blocked_fair
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.reweight_entity
      0.10 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.sched_clock
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.update_min_vruntime
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.llist_reverse_order
      0.17 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      0.11            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.05 ±  7%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.resched_curr
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.wakeup_preempt
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.irqentry_enter
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.21 ±  3%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.20 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.update_blocked_averages
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.09            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.llist_add_batch
      0.10 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.wake_affine
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.09            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.16 ±  2%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.find_busiest_queue
      0.31 ±  2%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.select_task_rq
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.16 ±  3%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.23 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp._find_next_and_bit
      0.19            +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.complete_walk
      0.16 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.51 ±  2%      +0.0        0.56        perf-profile.children.cycles-pp.schedule_idle
      0.64 ±  3%      +0.0        0.68        perf-profile.children.cycles-pp.update_load_avg
      0.16 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.lockref_get
      0.23 ±  2%      +0.0        0.28        perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.15 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.copy_fs_struct
      0.33 ±  3%      +0.1        0.38        perf-profile.children.cycles-pp.cpu_util
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.path_parentat
      0.02 ±141%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__filename_parentat
      0.48 ±  2%      +0.1        0.54 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__d_lookup_unhash
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.___d_drop
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__wake_up
      0.28            +0.1        0.34        perf-profile.children.cycles-pp.__d_alloc
      0.99 ±  2%      +0.1        1.05        perf-profile.children.cycles-pp.open64
      0.84            +0.1        0.90        perf-profile.children.cycles-pp.try_to_wake_up
      0.62 ±  2%      +0.1        0.70        perf-profile.children.cycles-pp.enqueue_task_fair
      0.26            +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.__call_rcu_common
      0.47            +0.1        0.55        perf-profile.children.cycles-pp.dequeue_entity
      0.71 ±  2%      +0.1        0.78        perf-profile.children.cycles-pp.activate_task
      0.10 ±  3%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__d_rehash
      0.63 ±  2%      +0.1        0.72        perf-profile.children.cycles-pp.dequeue_task_fair
      0.34 ±  2%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.idle_cpu
      0.78 ±  2%      +0.1        0.88 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.68            +0.1        0.78        perf-profile.children.cycles-pp.wake_up_q
      0.30 ±  4%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.60 ±  2%      +0.1        0.71        perf-profile.children.cycles-pp.ttwu_do_activate
      0.19 ±  5%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.exit_fs
      0.72 ±  2%      +0.1        0.85 ±  2%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.73 ±  2%      +0.1        0.86 ±  2%  perf-profile.children.cycles-pp.unlinkat
      0.71 ±  2%      +0.1        0.85 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      0.25 ±  5%      +0.1        0.39 ±  5%  perf-profile.children.cycles-pp.path_put
      0.13 ±  3%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__d_add
      0.61 ±  2%      +0.1        0.75        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.31 ± 10%      +0.1        0.46 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.14 ±  3%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.simple_lookup
      0.72            +0.2        0.90        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.74 ±  2%      +0.2        0.93        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.76 ±  3%      +0.2        0.97 ±  2%  perf-profile.children.cycles-pp.lookup_open
      0.87            +0.2        1.09        perf-profile.children.cycles-pp.sysvec_call_function_single
      1.81 ±  2%      +0.5        2.33        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.57 ±  2%      +0.6        3.14        perf-profile.children.cycles-pp.update_sg_lb_stats
      2.84 ±  2%      +0.6        3.42        perf-profile.children.cycles-pp.acpi_idle_enter
      2.82 ±  2%      +0.6        3.41        perf-profile.children.cycles-pp.acpi_safe_halt
      2.78 ±  2%      +0.6        3.38        perf-profile.children.cycles-pp.update_sd_lb_stats
      2.94 ±  2%      +0.6        3.54        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.95 ±  2%      +0.6        3.56        perf-profile.children.cycles-pp.cpuidle_enter
      2.82 ±  2%      +0.6        3.42        perf-profile.children.cycles-pp.find_busiest_group
      3.73 ±  2%      +0.6        4.35        perf-profile.children.cycles-pp.open_last_lookups
      3.20 ±  2%      +0.6        3.84        perf-profile.children.cycles-pp.cpuidle_idle_call
      3.79 ±  2%      +0.7        4.48        perf-profile.children.cycles-pp.start_secondary
      3.85 ±  2%      +0.7        4.55        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.85 ±  2%      +0.7        4.55        perf-profile.children.cycles-pp.cpu_startup_entry
      3.84 ±  2%      +0.7        4.54        perf-profile.children.cycles-pp.do_idle
      3.74 ±  2%      +0.8        4.51        perf-profile.children.cycles-pp.load_balance
      4.06 ±  2%      +0.8        4.90        perf-profile.children.cycles-pp.newidle_balance
      3.10 ±  2%      +0.9        3.95 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      3.08 ±  2%      +0.9        3.94 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      3.23 ±  2%      +0.9        4.10 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
      4.09 ±  2%      +0.9        4.96        perf-profile.children.cycles-pp.pick_next_task_fair
      3.09 ±  2%      +0.9        3.98 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      6.07 ±  2%      +1.0        7.08        perf-profile.children.cycles-pp.__schedule
      5.11 ±  2%      +1.0        6.16        perf-profile.children.cycles-pp.schedule
      4.10 ±  2%      +1.2        5.30        perf-profile.children.cycles-pp.schedule_preempt_disabled
      4.14 ±  3%      +1.5        5.64        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      4.27 ±  2%      +1.6        5.83        perf-profile.children.cycles-pp.down_read
     78.98            +1.8       80.75        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     78.93            +1.8       80.70        perf-profile.children.cycles-pp.do_syscall_64
     10.39 ±  2%      +2.2       12.60        perf-profile.children.cycles-pp.__lookup_slow
     10.93 ±  2%      +2.3       13.21        perf-profile.children.cycles-pp.d_alloc_parallel
      2.13            +3.4        5.56        perf-profile.children.cycles-pp.step_into
      3.78 ±  2%      +4.2        7.98        perf-profile.children.cycles-pp.lookup_fast
      3.28 ±  2%      +4.4        7.66        perf-profile.children.cycles-pp.__legitimize_path
      3.31 ±  2%      +4.4        7.68        perf-profile.children.cycles-pp.try_to_unlazy
      3.43 ±  2%      +4.5        7.90        perf-profile.children.cycles-pp.lockref_get_not_dead
      4.12 ±  3%      +4.5        8.66        perf-profile.children.cycles-pp.d_alloc
      3.91 ±  2%      +4.8        8.70        perf-profile.children.cycles-pp.terminate_walk
     12.58 ±  2%      +5.7       18.23        perf-profile.children.cycles-pp.dput
     17.07 ±  2%      +7.9       24.99        perf-profile.children.cycles-pp.walk_component
      0.34 ±  2%      +8.5        8.81        perf-profile.children.cycles-pp.__dentry_kill
     18.66 ±  2%     +11.1       29.71        perf-profile.children.cycles-pp.link_path_walk
     18.51 ±  2%     +14.5       33.04        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     19.65 ±  2%     +14.6       34.28        perf-profile.children.cycles-pp._raw_spin_lock
     26.86 ±  2%     +15.1       41.93        perf-profile.children.cycles-pp.do_sys_openat2
     26.88 ±  2%     +15.1       41.95        perf-profile.children.cycles-pp.__x64_sys_openat
     26.24 ±  2%     +15.1       41.37        perf-profile.children.cycles-pp.do_filp_open
     26.16 ±  2%     +15.1       41.30        perf-profile.children.cycles-pp.path_openat
     16.59 ±  9%      -9.4        7.23 ±  6%  perf-profile.self.cycles-pp.osq_lock
      2.65 ±  3%      -0.5        2.18 ±  2%  perf-profile.self.cycles-pp.next_uptodate_folio
      1.50 ±  2%      -0.4        1.10        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.63            -0.2        1.41        perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.98 ±  3%      -0.2        0.79        perf-profile.self.cycles-pp.release_pages
      0.63 ±  3%      -0.2        0.44 ±  4%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      1.06 ±  2%      -0.2        0.88        perf-profile.self.cycles-pp.page_remove_rmap
      1.27 ±  2%      -0.2        1.10        perf-profile.self.cycles-pp._dl_addr
      0.94            -0.2        0.78 ±  2%  perf-profile.self.cycles-pp.up_write
      0.44 ±  2%      -0.2        0.29 ±  6%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.97            -0.2        0.82        perf-profile.self.cycles-pp.filemap_map_pages
      0.76            -0.1        0.62 ±  2%  perf-profile.self.cycles-pp.down_write
      0.87 ±  2%      -0.1        0.74        perf-profile.self.cycles-pp.zap_pte_range
      0.80 ±  4%      -0.1        0.67 ±  3%  perf-profile.self.cycles-pp._compound_head
      0.20 ±  4%      -0.1        0.08        perf-profile.self.cycles-pp._raw_spin_trylock
      0.80 ±  2%      -0.1        0.69        perf-profile.self.cycles-pp.__strcoll_l
      1.02            -0.1        0.93        perf-profile.self.cycles-pp.kmem_cache_free
      0.60            -0.1        0.50        perf-profile.self.cycles-pp.sync_regs
      0.59 ±  2%      -0.1        0.50 ±  2%  perf-profile.self.cycles-pp._IO_default_xsputn
      0.56 ±  2%      -0.1        0.48 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.55 ±  2%      -0.1        0.47        perf-profile.self.cycles-pp.lockref_get_not_dead
      0.60 ±  2%      -0.1        0.53 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.94 ±  2%      -0.1        0.87        perf-profile.self.cycles-pp.__slab_free
      0.48            -0.1        0.41        perf-profile.self.cycles-pp.clear_page_erms
      0.58 ±  2%      -0.1        0.52 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.37 ±  2%      -0.1        0.31        perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.19 ±  3%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.26 ± 20%      -0.1        0.21 ±  5%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.44            -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.strnlen_user
      0.32 ±  3%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.free_swap_cache
      0.48 ±  2%      -0.1        0.43        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.44 ±  2%      -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.53 ±  2%      -0.1        0.48        perf-profile.self.cycles-pp.mod_objcg_state
      0.27 ±  3%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.28 ±  3%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp._IO_padn
      0.36 ±  4%      -0.0        0.32 ±  3%  perf-profile.self.cycles-pp.mtree_range_walk
      0.31 ±  3%      -0.0        0.26        perf-profile.self.cycles-pp.set_pte_range
      0.36 ±  3%      -0.0        0.31        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.25 ±  3%      -0.0        0.21        perf-profile.self.cycles-pp.mas_next_slot
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.27 ±  2%      -0.0        0.23        perf-profile.self.cycles-pp.memset_orig
      0.26 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.25 ±  3%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp._IO_fwrite
      0.21 ±  2%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.24            -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.18 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.21 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mmap_region
      0.11 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.apparmor_file_open
      0.58            -0.0        0.54        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.20 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.21 ±  5%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.link_path_walk
      0.18 ±  4%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.apparmor_mmap_file
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp._IO_file_xsputn
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.24 ±  4%      -0.0        0.21        perf-profile.self.cycles-pp.try_charge_memcg
      0.22 ±  4%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.16 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.14 ±  2%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.down_read_trylock
      0.07 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.mm_init
      0.19 ±  3%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.15 ±  2%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.strncpy_from_user
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.malloc
      0.13 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__get_user_8
      0.10 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.11 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.11 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.09 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp._IO_setb
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__perf_sw_event
      0.13 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.09 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_prev_slot
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp._copy_to_iter
      0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.unmap_page_range
      0.09            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.__virt_addr_valid
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.mas_pop_node
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__snprintf_chk
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.d_path
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.lru_add_fn
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.dequeue_entity
      0.12 ±  3%      +0.0        0.13        perf-profile.self.cycles-pp.native_sched_clock
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.resched_curr
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.llist_reverse_order
      0.11 ±  6%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      0.09 ±  5%      +0.0        0.11        perf-profile.self.cycles-pp.enqueue_task_fair
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.18 ±  5%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.13 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.13            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.11 ±  6%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.release_empty_file
      0.23 ±  3%      +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.llist_add_batch
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.load_balance
      0.14 ±  4%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.find_busiest_queue
      0.13 ±  2%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp._find_next_and_bit
      0.08 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.29 ±  4%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__d_add
      0.12 ±  3%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.down_read
      0.11 ± 12%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.17 ±  6%      +0.1        0.23 ±  3%  perf-profile.self.cycles-pp.d_alloc
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__d_lookup_unhash
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.___d_drop
      0.10 ±  3%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__d_rehash
      0.32 ±  2%      +0.1        0.41        perf-profile.self.cycles-pp.idle_cpu
      1.72 ±  2%      +0.1        1.83        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.2        0.15 ±  2%  perf-profile.self.cycles-pp.__dentry_kill
      0.20 ±  3%      +0.3        0.47 ±  2%  perf-profile.self.cycles-pp.d_alloc_parallel
      1.30 ±  2%      +0.3        1.62        perf-profile.self.cycles-pp.acpi_safe_halt
      1.84 ±  2%      +0.4        2.23        perf-profile.self.cycles-pp.update_sg_lb_stats
     18.27 ±  2%     +14.4       32.63        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


