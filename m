Return-Path: <linux-fsdevel+bounces-12105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940BE85B50A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B14282533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7B5C903;
	Tue, 20 Feb 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlBWowaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82A5C614;
	Tue, 20 Feb 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417559; cv=fail; b=nLr1AhIAU9KiPAZFzted3UwjHKBc8iLo23iyWrQ1lbi/T1IWX+shZd3/K6bEJ2qkEN9XKAl2Jqpk4lxMgDkjAqxZAG2fjQ58bjJlwXI+Pj9fFn2cNy2skm0Zj/THk+iDcyF1iY366UiUK1e0G1ACtTlc+eqtSSox2RTrHWWQmYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417559; c=relaxed/simple;
	bh=92y3dO887+h0nSx/7/iW9EPSKzZ0sf0MNrhq06kWcBo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cdPjgJY1zjcg/+f6UYep7d/rcAEi9euJf5L0d1Ot1BQDR5/1x9hPtB9QwUZilUOyCV0kL6KT9cAZ3aZbhYNatzasKqF6loCHuxwMi/AUUDIAx4joSW7EBzLNKERSZPhu4uBQoqW7nQ92Lbz7CAuRHovAtdv/lY4C90xex3y2ByY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlBWowaz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708417555; x=1739953555;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=92y3dO887+h0nSx/7/iW9EPSKzZ0sf0MNrhq06kWcBo=;
  b=NlBWowazDwHUFWHYjhAoEvFc945vU5Dd8NdZiuqpsHUjbiLKBfDh4yMv
   YVeFq0JXdNno5Nf2PvHG+5Fvx7+edbTJ3HiFA8F+X7sUj5icXo3aaYfQL
   KDIhDR8F42iYi93FNEefdDwMPNxch2h2Cm48DCeJ9KlrfGyB3GZBEgQv7
   DyOXugeXn7F0weg5QYw87vUJJjBhXvOaTGPjQNHr2TNpTdzwQKk8in0Bx
   ZLospkyeMI+TCu1OQI2kiiEGLlQbs5OzqxAAZ6qw+mmM0GjwRPmi4KUZF
   ziFtJ+dR5H+6Ca0CVblYdM09IxxRF4PVyat+ysJ6VndLAxZELbSCVpjgh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13064107"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13064107"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="27872623"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 00:25:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:25:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 00:25:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 00:25:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HesdU7rAFU8zuOKmBligVVbLtyi3Vlhh4us8gC2ca/SPYS5R6ECPOmL0iqfZ4icMbpNzFepC/ELFflj4gtwBYqYcmD/xCAhvgpQNEUKGne3DZ+fVFS4uwCVNEAohChm6nNq/C31nMVK2yQhnPmDP7NdhImbrXrrpbWRvS6Wi5x8H32o7i4yxJHPrPH5v8hdkqAnT3ODF8RUhE19fPXK8LnIzY84UBp2LvhLIiJE0q5WvbnqeSnVkIptQYixI8bWVOzF+P0w5j2ARsCfVpJ6QoMYJw4hmK9PbpwcPO6AzSo/Y95o45aTu8FacgV4UBs4ZLOYtj7UPxv3Ggi0izNpzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ozhEjGhGlS31nxBDIg66h8mmFqoEQSgNRkwoM81IIE=;
 b=XBx7CwXHWpjC910btEgHR4+dAT6xjaOIeFyvXa48FQ1uLyddBSRHiSttw5TJNMjliAtpz40uaeRdzudKHbIb119cz9KIJlTa7m8bDSwtrekBF4MbN2KTG0xzNjd/A8hOsbE2cYp1DG3D7iBCJj8H5Q7Hfki33SPOLSdyrMWu7akaRtdAVFbPWls2ju6XwIeV5TVzqfogl/hhnwrpwfjtwiFTGvEGDtKL47pfjzYjawHDBd9im0/6oO4rqyDfkrny5hpsxkdVE2PB8O5SRmdPQb2dnEXnRKWoncKJJxQSWPdKqhQsMp13MWyrCEllVB1t3Jka3GH4midFoDy+oCWQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 08:25:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:25:46 +0000
Date: Tue, 20 Feb 2024 16:25:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, Guo Xuenan <guoxuenan@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [readahead]  ab4443fe3c:  vm-scalability.throughput
 -21.4% regression
Message-ID: <202402201642.c8d6bbc3-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 176b9f62-a9af-44b5-60c8-08dc31ed8977
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDbbjqqOQQl6x77Zs17KmNue9NlAuKoSuOK7GBqSlvXKWCWVwGmLbnRPnHHAO6uab6weTH5DRc8lXBgG+HnRcuRE7ShU5B+84Njk4rSH/eS1iV6iRhe8TqRwOy1IHZLIqMNLbrZJyYi+VURcH/6CheFwTlRRH+NjveVmHaLrbYKDiI+/wqIJ9GlvFsXhW3f5ea1yT2v8CvGch+00pe7q7K1KjxOlxu4g0WqZaKEQ6B45DN5nx2PfO1cviPQ5S/bF2G7ahFPzxigGLXeQsPujiAFZ/Na6xl5J/cDetR00uVQS7yyQdtm4//u3OQ0ETBYy9NEQOyATU7oOSuYlSg19MIPINhkLNot+r75hEbIxBSSt0Ka6gwdLDAUmd7LixGw1P5ZsmkM5YQzCWMezJZgqn1jZeHtF8EHrtCtHk+7KFWBxrBJByD3vIbd/CrUqYtDjoBMbZRTVQY8tg5fV8pEfYxjQWRHBBxInBckPxlGJ9bZtr+3jxo3l2ZnbC5qcdcLWO+mVCXy6BobP11lmNL5Fahs0AtJjx5syiAi/gWu5imMoV4mw9Hjjc4Rdkmmwkrc5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IjtD5xnnaDn5rT0stwsNVUmZmgVBF5rAjakEUnw9uz+3xCTXBY9Agkd6DZ?=
 =?iso-8859-1?Q?kyB7sU9nZQsW/463cS/JmrZMIvTEgBjdkO69ES7PxGbWZcSS+8oTWwwgdR?=
 =?iso-8859-1?Q?oagPtmogvaZTcy/0UHC94LMfQaSaX5MPM+uE01cjbVEzf3uZ9IwmN/8Al8?=
 =?iso-8859-1?Q?pYfrYWuXbOpludnudC9YxO4Z0yEaSpO6QpJ2LH9bx67Clixud0DLCeTOCN?=
 =?iso-8859-1?Q?QUbQjG9B4L+WMuOyN8LA5yEqZW7unIC6wTcEDIo70zHbnq3+KBCmSu6+F6?=
 =?iso-8859-1?Q?pLiESqsQlLqFpPorueyE45y/GGEvUNqrrxvNDNHjc19wvLdWTiK/SmXIrq?=
 =?iso-8859-1?Q?3YwrH5f7xNSakkbRAfH7CXg6izKhVd2z68hf/XH0Bm+TQlzkUqH/ezPH9F?=
 =?iso-8859-1?Q?Ftn0Jo7hWMKsNzCkFKD83dZU28e0kwMf7QUCAKT1pZ5GUI5Vf5Q/PjGZA2?=
 =?iso-8859-1?Q?bhWmkRUNv+iXFg3f8ZwtHf9+4NiOMusSt+Eba6uQ78/0z/p+J10AHu6w1s?=
 =?iso-8859-1?Q?kwdUsDpNTH1ynzhwei0htJv/Ngf6H8WOq2LRUkSgKg5zzbk/l5EivopXtt?=
 =?iso-8859-1?Q?T4Ol59LQz2zFi2gchbgOo/9+0IRDsQXzChFlDxwdZqp+FnvCMhPYf9IWMS?=
 =?iso-8859-1?Q?IllyVw2Iq4hiPYIPEXakl2q+cJDbjrvizpHyLYJm++Q0vGCs6BWZQVXxl9?=
 =?iso-8859-1?Q?B1kfd1gOYpCbo1Nd4kz8VNXIemP02i1E/qpttLYBb4iZ2tDqPaK6nbIkFP?=
 =?iso-8859-1?Q?RXl7BvdFlA4ekOIrE/3Da6c5g3AG5GsbFh12tYjqcx7lpX1QO8l7VIzZvw?=
 =?iso-8859-1?Q?MaApUHgjFGNz6aRrdITRIPV7KmOtWWET6KNUnK09PJdThoeb2kyTN+cD+2?=
 =?iso-8859-1?Q?+au9lNNaKqNqNDC4VOVU4J73JXU/L28UYprbIZJvHGZ0axWd8sNrPJlgqF?=
 =?iso-8859-1?Q?zQwu+Im5OWWx5cQWDDi2BVkOR1SLGcGJLOwex0BLJRRSoZV1DZsMmuzvyE?=
 =?iso-8859-1?Q?N0iuPrGxbJBG/TUyIVjklt4PIchJIO2X6pnKEY5cS5Us4WHPaeNMstvOWd?=
 =?iso-8859-1?Q?at2AfRpYBMq+dZff+SN1b+ONbgEMXvb2aTvgK9sqg1gV90BAlNWfqOPfuw?=
 =?iso-8859-1?Q?AZqN6byYh9d76d5g4upU6IRfLoVucElqF8T6e3Wna+ZK8mLwI5l+STEqw0?=
 =?iso-8859-1?Q?sauwcpZVLcXdcdDdqHgo+Ox9dZfNKANF17uD/j7u/jhAchoq8PDJ7TiqL2?=
 =?iso-8859-1?Q?vY3OeAuGenAHu8XxDaobsKcnOYWBsRwXTIZ0A/B25sJ+W+NSz/Lyei+rPX?=
 =?iso-8859-1?Q?5laMfjtFUMCfa8+eYoo/Gfxi8LpTUfOCTcbGnzCsg5dfnAoeOj+6CPfokX?=
 =?iso-8859-1?Q?+R9NHOOB72DuYajAdILRDGVFZBzjClHL9a3F52Sg7uSXon7W7PXN4g4HH6?=
 =?iso-8859-1?Q?hYh7zi5lDip7wi71mQWJz746cCxcLgz1g9BI4wH7r79QNE49zNLzlIzFxz?=
 =?iso-8859-1?Q?BY1OIU8agvrpDfIiLWahSD2OxFzyfmOfLrmtFpuPunySAAywKwOxiAaq4W?=
 =?iso-8859-1?Q?mBo8UHXQXXqhtosuiIiB2FqmJDqynCs2kH+pjjcN4TJNtLm2FEFo/Rcbvs?=
 =?iso-8859-1?Q?9G12PLINVbIXm0CWc3hFfQZDnN9s6clA56ebwDzQklNAfPdIwIW5W1Rg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b9f62-a9af-44b5-60c8-08dc31ed8977
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:25:46.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnUIA8YExkOY7KQlLuvkiS9162+VgHrYmifZH2fMEkVNttOMwvj1JE7Usf7hU8MudfHzg1k6dNnTzXzyZYMbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -21.4% regression of vm-scalability.throughput on:


commit: ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ("readahead: avoid multiple marked readahead pages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	runtime: 300s
	test: lru-file-readtwice
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402201642.c8d6bbc3-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240220/202402201642.c8d6bbc3-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/lkp-spr-2sp4/lru-file-readtwice/vm-scalability

commit: 
  f0b7a0d1d4 ("Merge branch 'master' into mm-hotfixes-stable")
  ab4443fe3c ("readahead: avoid multiple marked readahead pages")

f0b7a0d1d46625db ab4443fe3ca6298663a55c4a70e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12.33 ±  8%     +74.7%      21.54 ±  3%  vmstat.procs.b
 6.641e+09 ±  7%     +43.4%  9.522e+09 ±  3%  cpuidle..time
   7219825 ±  7%     +40.7%   10156643 ±  3%  cpuidle..usage
     87356 ± 44%    +130.7%     201564 ± 12%  meminfo.Active(anon)
    711730           +26.7%     901680        meminfo.SUnreclaim
    198.25           +23.7%     245.26        uptime.boot
     18890 ±  2%     +14.7%      21667 ±  2%  uptime.idle
      0.17 ± 62%      +0.5        0.70 ± 34%  mpstat.cpu.all.iowait%
      0.03 ±  5%      -0.0        0.02 ±  2%  mpstat.cpu.all.soft%
      0.83 ±  3%      -0.2        0.65 ±  4%  mpstat.cpu.all.usr%
    347214 ± 10%     +19.9%     416202 ±  2%  numa-meminfo.node0.SUnreclaim
 1.525e+08 ±  4%     +13.4%  1.728e+08 ±  4%  numa-meminfo.node1.Active
 1.524e+08 ±  4%     +13.3%  1.727e+08 ±  4%  numa-meminfo.node1.Active(file)
  71750516 ± 10%     -24.9%   53877171 ± 13%  numa-meminfo.node1.Inactive
  71127836 ± 10%     -25.1%   53268721 ± 13%  numa-meminfo.node1.Inactive(file)
    364797 ± 10%     +33.0%     485106 ±  2%  numa-meminfo.node1.SUnreclaim
   3610954 ±  6%     +40.2%    5062891 ±  3%  turbostat.C1E
   3627684 ±  7%     +40.9%    5111624 ±  3%  turbostat.C6
     12.35 ± 55%     -61.0%       4.82 ± 50%  turbostat.IPC
  31624764 ±  2%     +33.5%   42205318        turbostat.IRQ
      3.60 ± 24%      -1.7        1.94 ± 28%  turbostat.PKG_%
     12438 ±  4%     +90.4%      23687 ± 23%  turbostat.POLL
     48.81           -12.6%      42.65        turbostat.RAMWatt
  24934637 ±  9%     +83.8%   45836252 ±  5%  numa-numastat.node0.local_node
   3271697 ± 22%     +70.7%    5586210 ± 22%  numa-numastat.node0.numa_foreign
  25077126 ±  9%     +83.3%   45969061 ±  5%  numa-numastat.node0.numa_hit
   4703977 ± 10%    +159.8%   12220561 ±  7%  numa-numastat.node0.numa_miss
   4847049 ±  9%    +154.8%   12350702 ±  7%  numa-numastat.node0.other_node
  26364328 ±  5%    +111.3%   55706473 ±  3%  numa-numastat.node1.local_node
   4704476 ± 10%    +159.7%   12219530 ±  7%  numa-numastat.node1.numa_foreign
  26458496 ±  5%    +110.9%   55813309 ±  3%  numa-numastat.node1.numa_hit
   3271887 ± 22%     +70.7%    5586065 ± 22%  numa-numastat.node1.numa_miss
   3363897 ± 20%     +69.2%    5691334 ± 22%  numa-numastat.node1.other_node
    186286 ±  2%     -24.3%     140930 ±  2%  vm-scalability.median
      6476 ± 20%   +2723.0        9199 ± 11%  vm-scalability.stddev%
  88930342 ±  5%     -21.4%   69899439 ±  3%  vm-scalability.throughput
    135.95 ±  2%     +35.0%     183.51        vm-scalability.time.elapsed_time
    135.95 ±  2%     +35.0%     183.51        vm-scalability.time.elapsed_time.max
   3898231 ±  7%     +22.7%    4784231 ±  7%  vm-scalability.time.involuntary_context_switches
    246538            +1.2%     249586        vm-scalability.time.minor_page_faults
     17484            -3.0%      16967        vm-scalability.time.percent_of_cpu_this_job_got
     23546 ±  2%     +31.3%      30915        vm-scalability.time.system_time
    125622 ±  7%    +232.5%     417746 ±  7%  vm-scalability.time.voluntary_context_switches
      7.10 ± 31%     -26.9%       5.19 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.folio_alloc.page_cache_ra_order
     14.80 ± 42%     -42.0%       8.58 ± 11%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      6.01 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     11652 ± 37%    +480.5%      67637 ± 21%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.alloc_pages_mpol.folio_alloc.page_cache_ra_order
      1328 ± 86%    +760.2%      11431 ± 31%  perf-sched.wait_and_delay.count.__cond_resched.__kmalloc.ifs_alloc.isra.0
     10417 ± 30%    +223.8%      33728 ± 30%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      2529 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1336 ±133%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      6.74 ± 26%     -24.9%       5.06 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.folio_alloc.page_cache_ra_order
      3.12 ± 31%     -48.8%       1.60 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc.ifs_alloc.isra.0
      1.68 ± 23%     -70.2%       0.50 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.page_cache_ra_unbounded.filemap_get_pages.filemap_read
      0.54 ±133%    +441.1%       2.94 ± 33%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.13 ± 40%     -42.8%       7.51 ± 12%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      1.47 ±122%    +359.5%       6.78 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.47 ± 50%     -75.4%       1.10 ±134%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
     86841 ± 10%     +19.8%     104069 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
   3271697 ± 22%     +70.7%    5586210 ± 22%  numa-vmstat.node0.numa_foreign
  25076787 ±  9%     +83.3%   45969300 ±  5%  numa-vmstat.node0.numa_hit
  24934299 ±  9%     +83.8%   45836491 ±  5%  numa-vmstat.node0.numa_local
   4703977 ± 10%    +159.8%   12220561 ±  7%  numa-vmstat.node0.numa_miss
   4847048 ±  9%    +154.8%   12350702 ±  7%  numa-vmstat.node0.numa_other
  38159902 ±  4%     +13.2%   43207654 ±  4%  numa-vmstat.node1.nr_active_file
  17768992 ± 10%     -25.1%   13307850 ± 13%  numa-vmstat.node1.nr_inactive_file
     91228 ± 10%     +33.0%     121288 ±  2%  numa-vmstat.node1.nr_slab_unreclaimable
  38159860 ±  4%     +13.2%   43207611 ±  4%  numa-vmstat.node1.nr_zone_active_file
  17768981 ± 10%     -25.1%   13307832 ± 13%  numa-vmstat.node1.nr_zone_inactive_file
   4704476 ± 10%    +159.7%   12219530 ±  7%  numa-vmstat.node1.numa_foreign
  26458450 ±  5%    +110.9%   55813002 ±  3%  numa-vmstat.node1.numa_hit
  26364282 ±  5%    +111.3%   55706167 ±  3%  numa-vmstat.node1.numa_local
   3271887 ± 22%     +70.7%    5586065 ± 22%  numa-vmstat.node1.numa_miss
   3363897 ± 20%     +69.2%    5691333 ± 22%  numa-vmstat.node1.numa_other
  90826607 ±109%     -65.8%   31040624 ± 32%  proc-vmstat.compact_daemon_free_scanned
  96602657 ±103%     -65.4%   33447362 ± 32%  proc-vmstat.compact_free_scanned
      1184 ± 92%     -95.5%      52.75 ± 29%  proc-vmstat.kswapd_low_wmark_hit_quickly
     21460 ± 47%    +137.3%      50924 ± 12%  proc-vmstat.nr_active_anon
      3576 ±  3%     -29.3%       2528 ±  3%  proc-vmstat.nr_isolated_file
    178094           +26.5%     225368        proc-vmstat.nr_slab_unreclaimable
     21460 ± 47%    +137.3%      50924 ± 12%  proc-vmstat.nr_zone_active_anon
   7976174 ±  8%    +123.2%   17805741 ±  6%  proc-vmstat.numa_foreign
  51538988 ±  3%     +97.5%  1.018e+08        proc-vmstat.numa_hit
  51302328 ±  3%     +97.9%  1.015e+08        proc-vmstat.numa_local
   7975865 ±  8%    +123.3%   17806626 ±  6%  proc-vmstat.numa_miss
   8210948 ±  7%    +119.7%   18042039 ±  6%  proc-vmstat.numa_other
      1208 ± 92%     -93.1%      83.38 ± 24%  proc-vmstat.pageoutrun
      2270            +4.9%       2381        proc-vmstat.pgpgin
     51647 ±  9%     +24.2%      64144 ± 19%  proc-vmstat.pgreuse
  12722105 ± 16%     +51.8%   19317724 ± 27%  proc-vmstat.workingset_activate_file
   8714025          +122.7%   19406236 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.avg
  14306847 ±  4%    +105.2%   29360984 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
    909251 ± 71%    +426.4%    4786321 ± 57%  sched_debug.cfs_rq:/.avg_vruntime.min
   2239402 ± 12%     +77.5%    3975146 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      7790 ±  9%     +27.6%       9939 ±  6%  sched_debug.cfs_rq:/.load.avg
    536737           +35.6%     727628 ± 20%  sched_debug.cfs_rq:/.load.max
     52392 ±  6%     +31.7%      68975 ± 15%  sched_debug.cfs_rq:/.load.stddev
   8714025          +122.7%   19406236 ± 13%  sched_debug.cfs_rq:/.min_vruntime.avg
  14306847 ±  4%    +105.2%   29360984 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
    909251 ± 71%    +426.4%    4786321 ± 57%  sched_debug.cfs_rq:/.min_vruntime.min
   2239402 ± 12%     +77.5%    3975147 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
    263.62           -37.2%     165.56 ± 16%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     34.46 ± 20%     -36.9%      21.75 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    263.62           -37.2%     165.56 ± 16%  sched_debug.cfs_rq:/.removed.util_avg.max
     34.46 ± 20%     -36.9%      21.75 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     24033 ± 20%    +132.7%      55928 ± 31%  sched_debug.cpu.avg_idle.min
     90800           +46.2%     132766 ± 10%  sched_debug.cpu.clock.avg
     90862           +46.2%     132821 ± 10%  sched_debug.cpu.clock.max
     90743           +46.2%     132681 ± 10%  sched_debug.cpu.clock.min
     90382           +46.0%     131999 ± 10%  sched_debug.cpu.clock_task.avg
     90564           +46.0%     132188 ± 10%  sched_debug.cpu.clock_task.max
     75846 ±  2%     +54.3%     117026 ± 11%  sched_debug.cpu.clock_task.min
      8008           +20.9%       9683 ±  8%  sched_debug.cpu.curr->pid.max
      7262           +96.3%      14257 ± 11%  sched_debug.cpu.nr_switches.avg
      1335 ± 25%    +147.2%       3301 ± 46%  sched_debug.cpu.nr_switches.min
      0.04 ± 51%     +99.6%       0.07 ± 16%  sched_debug.cpu.nr_uninterruptible.avg
      6.94 ± 10%     +28.9%       8.94 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
     90747           +46.2%     132684 ± 10%  sched_debug.cpu_clk
     89537           +46.8%     131475 ± 10%  sched_debug.ktime
     91651           +45.8%     133586 ± 10%  sched_debug.sched_clk
     12.03           -19.4%       9.70        perf-stat.i.MPKI
 1.752e+10 ±  2%     -11.2%  1.556e+10        perf-stat.i.branch-instructions
     78.57            -3.0       75.62        perf-stat.i.cache-miss-rate%
 1.081e+09 ±  2%     -27.8%  7.811e+08        perf-stat.i.cache-misses
  1.28e+09 ±  2%     -23.4%    9.8e+08        perf-stat.i.cache-references
      5.60            +6.0%       5.94        perf-stat.i.cpi
 5.076e+11 ±  2%      -3.6%  4.895e+11        perf-stat.i.cpu-cycles
    505.00 ±  3%     +14.2%     576.55 ±  2%  perf-stat.i.cpu-migrations
 2.087e+10 ±  2%     -12.9%  1.818e+10        perf-stat.i.dTLB-loads
      0.04 ±  2%      +0.0        0.06 ±  3%  perf-stat.i.dTLB-store-miss-rate%
   1787964 ±  3%     +30.8%    2339432        perf-stat.i.dTLB-store-misses
 6.896e+09 ±  2%     -21.0%  5.448e+09        perf-stat.i.dTLB-stores
 7.872e+10 ±  2%     -12.2%   6.91e+10        perf-stat.i.instructions
      0.27 ±  3%      +5.9%       0.28 ±  2%  perf-stat.i.ipc
      0.12 ± 27%     -52.0%       0.06 ± 20%  perf-stat.i.major-faults
    646.66 ±  8%     +31.4%     849.88 ±  2%  perf-stat.i.metric.K/sec
    201.93 ±  2%     -13.2%     175.35        perf-stat.i.metric.M/sec
      8279 ± 10%     -19.5%       6667 ±  8%  perf-stat.i.minor-faults
  76148688 ±  6%     -25.0%   57102562 ±  4%  perf-stat.i.node-load-misses
 1.996e+08 ±  6%     -27.3%  1.451e+08 ±  4%  perf-stat.i.node-loads
      8279 ± 10%     -19.5%       6667 ±  8%  perf-stat.i.page-faults
     13.78           -17.3%      11.40        perf-stat.overall.MPKI
      0.11 ±  2%      +0.0        0.12        perf-stat.overall.branch-miss-rate%
     84.62            -4.7       79.91        perf-stat.overall.cache-miss-rate%
      6.47            +9.8%       7.10        perf-stat.overall.cpi
    469.58 ±  2%     +32.7%     623.15        perf-stat.overall.cycles-between-cache-misses
      0.03 ±  2%      +0.0        0.04        perf-stat.overall.dTLB-store-miss-rate%
      0.15            -8.9%       0.14        perf-stat.overall.ipc
      1265 ±  2%     +19.2%       1507        perf-stat.overall.path-length
 1.757e+10 ±  2%     -10.1%   1.58e+10        perf-stat.ps.branch-instructions
 1.088e+09 ±  2%     -26.5%  7.996e+08        perf-stat.ps.cache-misses
 1.285e+09 ±  2%     -22.1%  1.001e+09        perf-stat.ps.cache-references
    490.77 ±  4%     +15.5%     566.82 ±  3%  perf-stat.ps.cpu-migrations
 2.094e+10 ±  2%     -11.8%  1.847e+10        perf-stat.ps.dTLB-loads
   1746391 ±  2%     +32.3%    2310550        perf-stat.ps.dTLB-store-misses
  6.91e+09 ±  2%     -19.9%  5.536e+09        perf-stat.ps.dTLB-stores
 7.892e+10 ±  2%     -11.1%  7.017e+10        perf-stat.ps.instructions
      0.12 ± 28%     -55.6%       0.05 ± 21%  perf-stat.ps.major-faults
      7608 ±  9%     -18.1%       6231 ±  7%  perf-stat.ps.minor-faults
  76550152 ±  5%     -24.5%   57810813 ±  4%  perf-stat.ps.node-load-misses
 2.022e+08 ±  5%     -26.0%  1.495e+08 ±  4%  perf-stat.ps.node-loads
      7608 ±  9%     -18.1%       6231 ±  7%  perf-stat.ps.page-faults
 1.087e+13 ±  2%     +19.2%  1.295e+13        perf-stat.total.instructions
     19.35 ± 18%     -19.3        0.00        perf-profile.calltrace.cycles-pp.__libc_start_main
     19.35 ± 18%     -19.3        0.00        perf-profile.calltrace.cycles-pp.main.__libc_start_main
     19.35 ± 18%     -19.3        0.00        perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
     18.24 ± 41%     -18.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.24 ± 41%     -18.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.85 ± 12%     -16.8        0.00        perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main.__libc_start_main
     16.85 ± 12%     -16.8        0.00        perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
     16.79 ± 20%     -16.8        0.00        perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
     16.61 ± 16%     -16.6        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.__libc_write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn.perf_mmap__push
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     16.60 ± 18%     -16.6        0.00        perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
     16.55 ± 20%     -16.6        0.00        perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
     16.27 ± 17%     -16.3        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
     16.59 ± 42%     -15.9        0.66 ±126%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     16.59 ± 42%     -15.9        0.66 ±126%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     16.59 ± 42%     -15.9        0.73 ±111%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     16.59 ± 42%     -15.9        0.73 ±111%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     16.59 ± 42%     -15.8        0.76 ±112%  perf-profile.calltrace.cycles-pp.read
      9.60 ± 77%      -9.6        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.60 ± 77%      -9.6        0.00        perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      9.47 ± 75%      -9.5        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.47 ± 75%      -9.5        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      9.47 ± 75%      -9.5        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      9.47 ± 75%      -9.5        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.47 ± 75%      -9.5        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.40 ± 37%      -9.4        0.00        perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      9.20 ± 38%      -9.2        0.00        perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
      8.39 ± 40%      -8.4        0.00        perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      8.39 ± 40%      -8.4        0.00        perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      8.24 ± 36%      -8.2        0.00        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.24 ± 36%      -8.2        0.00        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      7.29 ± 87%      -7.3        0.00        perf-profile.calltrace.cycles-pp.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      7.01 ± 49%      -7.0        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      6.40 ± 57%      -6.4        0.00        perf-profile.calltrace.cycles-pp.open64
      6.23 ± 44%      -6.2        0.00        perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
      6.23 ± 44%      -6.2        0.00        perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      6.23 ± 44%      -6.2        0.00        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.23 ± 44%      -6.2        0.00        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      6.08 ± 31%      -6.1        0.00        perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
      6.05 ± 63%      -6.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      6.05 ± 63%      -6.0        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      6.05 ± 63%      -6.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      6.05 ± 63%      -6.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      5.86 ± 28%      -5.9        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      5.82 ± 48%      -5.8        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.82 ± 48%      -5.8        0.00        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.82 ± 48%      -5.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.82 ± 48%      -5.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      5.82 ± 48%      -5.8        0.00        perf-profile.calltrace.cycles-pp.execve
      5.79 ± 47%      -5.8        0.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.75 ± 66%      -5.7        0.00        perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write
      5.60 ± 55%      -5.6        0.00        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      4.97 ± 49%      -5.0        0.00        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      4.30 ± 60%      -4.3        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      3.87 ± 70%      -3.9        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      3.87 ± 70%      -3.9        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00            +0.7        0.71 ± 23%  perf-profile.calltrace.cycles-pp.__free_pages_ok.release_pages.__folio_batch_release.truncate_inode_pages_range.evict
      0.00            +0.7        0.72 ± 21%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.00            +0.7        0.73 ± 22%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.destroy_large_folio.release_pages.__folio_batch_release.truncate_inode_pages_range
      0.00            +0.7        0.73 ± 23%  perf-profile.calltrace.cycles-pp.free_unref_page_prepare.free_unref_page.release_pages.__folio_batch_release.truncate_inode_pages_range
      0.00            +0.8        0.80 ± 17%  perf-profile.calltrace.cycles-pp.xas_load.truncate_folio_batch_exceptionals.truncate_inode_pages_range.evict.do_unlinkat
      0.00            +0.9        0.86 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.9        0.86 ± 21%  perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.00            +0.9        0.89 ± 18%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu
      0.00            +0.9        0.89 ± 14%  perf-profile.calltrace.cycles-pp.workingset_update_node.xas_store.truncate_folio_batch_exceptionals.truncate_inode_pages_range.evict
      0.00            +0.9        0.94 ± 63%  perf-profile.calltrace.cycles-pp.fast_imageblit.sys_imageblit.drm_fbdev_generic_defio_imageblit.bit_putcs.fbcon_putcs
      0.00            +1.0        0.95 ± 63%  perf-profile.calltrace.cycles-pp.sys_imageblit.drm_fbdev_generic_defio_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw
      0.00            +1.0        0.95 ± 63%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_defio_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll
      0.00            +1.1        1.06 ± 31%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes
      0.00            +1.1        1.14 ± 39%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.13 ±264%      +1.3        1.38 ± 45%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.3        1.26 ± 58%  perf-profile.calltrace.cycles-pp.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll
      0.00            +1.3        1.31 ± 59%  perf-profile.calltrace.cycles-pp.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll.lf
      0.00            +1.5        1.45 ± 24%  perf-profile.calltrace.cycles-pp.destroy_large_folio.release_pages.__folio_batch_release.truncate_inode_pages_range.evict
      0.00            +1.5        1.49 ± 60%  perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
      0.00            +1.5        1.52 ± 22%  perf-profile.calltrace.cycles-pp.free_unref_page.release_pages.__folio_batch_release.truncate_inode_pages_range.evict
      0.00            +1.5        1.55 ± 58%  perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.console_flush_all.console_unlock
      0.00            +1.5        1.55 ± 58%  perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.console_flush_all
      0.00            +1.5        1.55 ± 58%  perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_flush_all.console_unlock.vprintk_emit
      0.00            +1.6        1.58 ± 57%  perf-profile.calltrace.cycles-pp.vt_console_print.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      0.00            +1.8        1.77 ± 41%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.8        1.81 ± 27%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq
      0.13 ±264%      +2.0        2.08 ± 30%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.0        1.97 ± 17%  perf-profile.calltrace.cycles-pp.rcu_segcblist_enqueue.__call_rcu_common.xas_store.truncate_folio_batch_exceptionals.truncate_inode_pages_range
      0.00            +2.0        2.04 ± 19%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.00            +2.2        2.17 ± 17%  perf-profile.calltrace.cycles-pp.__call_rcu_common.xas_store.truncate_folio_batch_exceptionals.truncate_inode_pages_range.evict
      0.55 ±134%      +2.2        2.78 ± 18%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.75 ±132%      +2.5        3.22 ± 10%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +2.6        2.64 ± 19%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      0.75 ±132%      +2.7        3.40 ± 10%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +2.7        2.66 ± 19%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00            +2.7        2.67 ± 19%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +2.7        2.67 ± 19%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +2.8        2.76 ± 13%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all
      0.17 ±264%      +2.8        2.97 ± 10%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.00            +2.8        2.83 ± 13%  perf-profile.calltrace.cycles-pp.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +2.8        2.83 ± 13%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.00            +3.7        3.67 ± 15%  perf-profile.calltrace.cycles-pp.xas_find.find_lock_entries.truncate_inode_pages_range.evict.do_unlinkat
      0.30 ±175%      +4.2        4.48 ±  8%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.30 ±175%      +4.3        4.60 ±  8%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +4.4        4.40 ± 22%  perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.evict.do_unlinkat
      0.50 ±132%      +4.4        4.90 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +4.4        4.41 ± 21%  perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.00            +4.7        4.72 ± 33%  perf-profile.calltrace.cycles-pp.io_serial_out.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.00            +4.8        4.76 ± 15%  perf-profile.calltrace.cycles-pp.find_lock_entries.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      1.06 ±125%      +4.9        5.96 ± 10%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.00            +5.3        5.34 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.28 ±100%      +5.5        6.82 ± 10%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      1.28 ±100%      +5.6        6.87 ± 10%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.28 ±100%      +6.1        7.36 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +6.9        6.86 ± 15%  perf-profile.calltrace.cycles-pp.xas_store.truncate_folio_batch_exceptionals.truncate_inode_pages_range.evict.do_unlinkat
      0.00            +7.7        7.69 ± 12%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +7.9        7.90 ± 12%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.00            +8.3        8.34 ± 15%  perf-profile.calltrace.cycles-pp.truncate_folio_batch_exceptionals.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      1.28 ±100%      +8.4        9.71 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.26 ±264%     +11.4       11.67 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.26 ±264%     +11.8       12.06 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.00 ±102%     +15.9       16.89 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +16.1       16.11 ± 13%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      0.17 ±264%     +17.4       17.59 ± 12%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.17 ±264%     +17.4       17.59 ± 12%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.17 ±264%     +17.4       17.60 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.17 ±264%     +17.4       17.60 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.17 ±264%     +17.4       17.62 ± 12%  perf-profile.calltrace.cycles-pp.write
      0.00           +17.5       17.47 ± 13%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      0.00           +17.5       17.48 ± 13%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      1.60 ± 88%     +17.5       19.11 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +17.5       17.53 ± 12%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      0.00           +17.5       17.55 ± 13%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      0.00           +17.5       17.55 ± 13%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      0.00           +17.6       17.55 ± 13%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +18.0       17.98 ± 12%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.00           +18.0       17.98 ± 12%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      0.00           +18.0       18.02 ± 12%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.00           +18.0       18.02 ± 12%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      0.00           +18.0       18.02 ± 12%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      0.00           +18.0       18.02 ± 12%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.00           +18.0       18.03 ± 12%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.00           +18.0       18.03 ± 12%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.00           +18.0       18.03 ± 12%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.00           +18.7       18.67 ± 12%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00           +18.7       18.67 ± 12%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.00           +18.7       18.72 ± 12%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +18.8       18.77 ± 12%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +19.3       19.26 ± 15%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.00           +19.3       19.28 ± 15%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +19.3       19.29 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00           +19.3       19.29 ± 15%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00           +19.3       19.29 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00           +19.3       19.29 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00           +19.3       19.29 ± 15%  perf-profile.calltrace.cycles-pp.unlinkat
      0.89 ±100%     +22.5       23.36 ± 15%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.89 ±100%     +22.5       23.36 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.89 ±100%     +22.5       23.36 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      3.26 ±101%     +26.4       29.63 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      6.41 ± 88%     +26.4       32.84 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.41 ± 88%     +26.4       32.85 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.41 ± 88%     +26.4       32.85 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.56 ± 99%     +26.6       30.12 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      6.41 ± 88%     +26.6       33.04 ±  7%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.68 ± 96%     +28.8       32.52 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     75.17 ± 12%     -36.3       38.83 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
     75.17 ± 12%     -36.3       38.84 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.35 ± 18%     -19.2        0.10 ± 84%  perf-profile.children.cycles-pp.__libc_start_main
     19.35 ± 18%     -19.2        0.10 ± 84%  perf-profile.children.cycles-pp.main
     19.35 ± 18%     -19.2        0.10 ± 84%  perf-profile.children.cycles-pp.run_builtin
     19.35 ± 18%     -19.2        0.10 ± 90%  perf-profile.children.cycles-pp.cmd_record
     18.76 ± 18%     -18.8        0.00        perf-profile.children.cycles-pp.perf_mmap__push
     18.76 ± 18%     -18.8        0.00        perf-profile.children.cycles-pp.record__mmap_read_evlist
     18.63 ± 28%     -18.4        0.18 ± 46%  perf-profile.children.cycles-pp.do_exit
     18.63 ± 28%     -18.4        0.18 ± 46%  perf-profile.children.cycles-pp.do_group_exit
     16.81 ± 19%     -16.8        0.00        perf-profile.children.cycles-pp.__libc_write
     16.80 ± 20%     -16.8        0.00        perf-profile.children.cycles-pp.record__pushfn
     16.60 ± 18%     -16.6        0.00        perf-profile.children.cycles-pp.writen
     16.60 ± 18%     -16.6        0.01 ±264%  perf-profile.children.cycles-pp.shmem_file_write_iter
     16.42 ± 19%     -16.4        0.00        perf-profile.children.cycles-pp.generic_perform_write
     16.42 ± 41%     -16.1        0.29 ± 13%  perf-profile.children.cycles-pp.seq_read_iter
     16.81 ± 41%     -15.9        0.94 ± 79%  perf-profile.children.cycles-pp.read
     16.59 ± 42%     -15.6        0.96 ± 69%  perf-profile.children.cycles-pp.vfs_read
     16.59 ± 42%     -15.6        0.96 ± 69%  perf-profile.children.cycles-pp.ksys_read
     19.35 ± 18%     -15.4        3.98 ±173%  perf-profile.children.cycles-pp.__cmd_record
     14.11 ± 37%     -14.1        0.00        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     14.11 ± 37%     -14.1        0.00        perf-profile.children.cycles-pp.get_signal
     10.35 ± 37%     -10.1        0.27 ± 64%  perf-profile.children.cycles-pp.asm_exc_page_fault
     10.10 ± 32%     -10.0        0.07 ±100%  perf-profile.children.cycles-pp.__fput
      9.93 ± 74%      -9.9        0.01 ±264%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      9.60 ± 77%      -9.6        0.00        perf-profile.children.cycles-pp.proc_reg_read_iter
      9.58 ± 36%      -9.6        0.00        perf-profile.children.cycles-pp.task_work_run
      9.10 ± 54%      -8.9        0.16 ± 53%  perf-profile.children.cycles-pp.exit_mmap
      9.10 ± 54%      -8.9        0.16 ± 53%  perf-profile.children.cycles-pp.__mmput
      8.57 ± 35%      -8.5        0.09 ± 78%  perf-profile.children.cycles-pp.do_sys_openat2
      8.57 ± 35%      -8.5        0.10 ± 78%  perf-profile.children.cycles-pp.__x64_sys_openat
      8.39 ± 40%      -8.3        0.06 ±101%  perf-profile.children.cycles-pp.perf_event_release_kernel
      8.39 ± 40%      -8.3        0.06 ±101%  perf-profile.children.cycles-pp.perf_release
      8.24 ± 36%      -8.2        0.09 ± 78%  perf-profile.children.cycles-pp.do_filp_open
      8.24 ± 36%      -8.2        0.09 ± 78%  perf-profile.children.cycles-pp.path_openat
      8.36 ± 29%      -8.1        0.23 ± 62%  perf-profile.children.cycles-pp.exc_page_fault
      8.16 ± 33%      -7.9        0.23 ± 62%  perf-profile.children.cycles-pp.do_user_addr_fault
      7.12 ± 84%      -7.1        0.00        perf-profile.children.cycles-pp.show_interrupts
      6.98 ± 79%      -7.0        0.00        perf-profile.children.cycles-pp.seq_printf
      7.01 ± 49%      -6.9        0.15 ± 54%  perf-profile.children.cycles-pp.exit_mm
      6.95 ± 36%      -6.7        0.22 ± 61%  perf-profile.children.cycles-pp.handle_mm_fault
      6.23 ± 44%      -6.2        0.00        perf-profile.children.cycles-pp.proc_pid_status
      6.23 ± 44%      -6.2        0.00        perf-profile.children.cycles-pp.proc_single_show
      6.22 ± 60%      -6.2        0.00        perf-profile.children.cycles-pp.open64
      6.08 ± 31%      -6.1        0.00        perf-profile.children.cycles-pp.event_function_call
      6.23 ± 42%      -6.0        0.21 ± 62%  perf-profile.children.cycles-pp.__handle_mm_fault
      6.23 ± 44%      -6.0        0.25 ± 15%  perf-profile.children.cycles-pp.seq_read
      5.86 ± 28%      -5.9        0.00        perf-profile.children.cycles-pp.smp_call_function_single
      5.72 ± 54%      -5.7        0.00        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      5.82 ± 48%      -5.6        0.20 ± 46%  perf-profile.children.cycles-pp.do_execveat_common
      5.82 ± 48%      -5.6        0.20 ± 46%  perf-profile.children.cycles-pp.execve
      5.82 ± 48%      -5.6        0.20 ± 46%  perf-profile.children.cycles-pp.__x64_sys_execve
      5.60 ± 55%      -5.6        0.00        perf-profile.children.cycles-pp.fault_in_readable
      5.83 ± 57%      -5.0        0.83 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock
      4.97 ± 49%      -5.0        0.00        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      4.65 ± 60%      -4.5        0.13 ± 47%  perf-profile.children.cycles-pp.bprm_execve
      4.47 ± 64%      -4.4        0.10 ± 54%  perf-profile.children.cycles-pp.load_elf_binary
      4.47 ± 64%      -4.4        0.10 ± 54%  perf-profile.children.cycles-pp.exec_binprm
      4.47 ± 64%      -4.4        0.10 ± 54%  perf-profile.children.cycles-pp.search_binary_handler
      4.52 ± 42%      -4.3        0.18 ± 46%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.52 ± 57%      -3.5        0.06 ± 83%  perf-profile.children.cycles-pp.kernel_clone
      3.28 ± 47%      -3.2        0.09 ± 80%  perf-profile.children.cycles-pp.do_fault
      3.12 ± 46%      -3.0        0.08 ± 80%  perf-profile.children.cycles-pp.do_read_fault
      2.33 ± 42%      -2.3        0.07 ± 80%  perf-profile.children.cycles-pp.filemap_map_pages
      1.99 ± 34%      -1.9        0.05 ± 78%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.uncharge_folio
      0.00            +0.1        0.07 ± 19%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.free_tail_page_prepare
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.08 ± 38%  perf-profile.children.cycles-pp.console_conditional_schedule
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.__libc_read
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.xa_load
      0.00            +0.1        0.09 ± 16%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.1        0.10 ± 46%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.1        0.10 ± 46%  perf-profile.children.cycles-pp._printk
      0.00            +0.1        0.10 ± 46%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.1        0.10 ± 46%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.1        0.10 ± 46%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.1        0.11 ± 39%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.11 ± 54%  perf-profile.children.cycles-pp.drm_fb_helper_damage_area
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.12 ± 35%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.00            +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.00            +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.__put_partials
      0.00            +0.1        0.14 ± 31%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.2        0.16 ± 67%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.16 ± 24%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.00            +0.2        0.16 ± 12%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.2        0.17 ± 14%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.2        0.17 ± 25%  perf-profile.children.cycles-pp.delay_halt_tpause
      0.00            +0.2        0.19 ± 35%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.00            +0.2        0.19 ± 35%  perf-profile.children.cycles-pp.rest_init
      0.00            +0.2        0.19 ± 35%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.2        0.19 ± 35%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +0.2        0.19 ± 35%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.2        0.21 ± 19%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.free_one_page
      0.00            +0.2        0.22 ± 14%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.24 ± 17%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.2        0.24 ± 17%  perf-profile.children.cycles-pp.list_lru_del
      0.00            +0.2        0.24 ± 19%  perf-profile.children.cycles-pp.radix_tree_node_rcu_free
      0.00            +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.get_slabinfo
      0.00            +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.slab_show
      0.00            +0.3        0.25 ± 21%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.3        0.28 ± 24%  perf-profile.children.cycles-pp.delay_halt
      0.00            +0.3        0.29 ± 18%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.3        0.30 ±  9%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.3        0.31 ± 18%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.3        0.31 ± 18%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +0.3        0.32 ± 16%  perf-profile.children.cycles-pp.__mod_lruvec_kmem_state
      0.00            +0.3        0.32 ± 15%  perf-profile.children.cycles-pp.xas_start
      0.00            +0.3        0.32 ± 16%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.3        0.32 ± 10%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.4        0.37 ± 11%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.00            +0.4        0.38 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.4        0.40 ± 17%  perf-profile.children.cycles-pp.ifs_free
      0.00            +0.4        0.40 ± 14%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.4        0.40 ± 18%  perf-profile.children.cycles-pp.__page_cache_release
      0.00            +0.4        0.42 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.4        0.43 ± 13%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.4        0.45 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_from_slab_obj
      0.00            +0.5        0.46 ± 12%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.5        0.48 ±  7%  perf-profile.children.cycles-pp.perf_rotate_context
      0.00            +0.5        0.52 ± 23%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.5        0.52 ± 58%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.5        0.55 ± 25%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.6        0.56 ± 14%  perf-profile.children.cycles-pp.list_lru_del_obj
      0.00            +0.6        0.59 ± 21%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.6        0.64 ± 24%  perf-profile.children.cycles-pp.drm_fbdev_generic_damage_blit_real
      0.00            +0.6        0.64 ± 93%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.7        0.66 ± 89%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.7        0.69 ± 40%  perf-profile.children.cycles-pp.xas_descend
      0.00            +0.7        0.69 ± 22%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.7        0.70 ± 25%  perf-profile.children.cycles-pp.folio_undo_large_rmappable
      0.00            +0.7        0.73 ± 22%  perf-profile.children.cycles-pp.__free_pages_ok
      0.00            +0.7        0.73 ± 21%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.00            +0.7        0.74 ± 22%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.00            +0.8        0.78 ± 14%  perf-profile.children.cycles-pp.xas_clear_mark
      0.00            +0.9        0.87 ± 21%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.00            +0.9        0.95 ± 13%  perf-profile.children.cycles-pp.workingset_update_node
      0.00            +1.0        0.96 ± 62%  perf-profile.children.cycles-pp.fast_imageblit
      0.00            +1.0        0.98 ± 61%  perf-profile.children.cycles-pp.sys_imageblit
      0.00            +1.0        0.98 ± 61%  perf-profile.children.cycles-pp.drm_fbdev_generic_defio_imageblit
      0.13 ±264%      +1.1        1.20 ± 54%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +1.2        1.16 ± 38%  perf-profile.children.cycles-pp.clockevents_program_event
      0.13 ±264%      +1.3        1.40 ± 45%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +1.3        1.29 ± 57%  perf-profile.children.cycles-pp.bit_putcs
      0.00            +1.3        1.34 ± 57%  perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +1.5        1.46 ± 23%  perf-profile.children.cycles-pp.destroy_large_folio
      0.00            +1.5        1.52 ± 59%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +1.5        1.55 ± 58%  perf-profile.children.cycles-pp.con_scroll
      0.00            +1.5        1.55 ± 58%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +1.5        1.55 ± 58%  perf-profile.children.cycles-pp.lf
      0.00            +1.6        1.58 ± 57%  perf-profile.children.cycles-pp.vt_console_print
      0.00            +1.7        1.67 ± 20%  perf-profile.children.cycles-pp.free_unref_page
      0.00            +1.9        1.86 ± 39%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.13 ±264%      +2.0        2.12 ± 29%  perf-profile.children.cycles-pp.menu_select
      0.55 ±134%      +2.2        2.78 ± 18%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +2.7        2.67 ± 19%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +2.8        2.83 ± 13%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.75 ±132%      +2.9        3.64 ± 10%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.30 ±175%      +3.1        3.40 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +3.2        3.24 ± 30%  perf-profile.children.cycles-pp.ktime_get
      0.44 ±173%      +3.7        4.11 ± 15%  perf-profile.children.cycles-pp.rcu_core
      0.00            +3.7        3.72 ± 14%  perf-profile.children.cycles-pp.xas_find
      0.22 ±264%      +3.8        4.01 ± 16%  perf-profile.children.cycles-pp.rcu_do_batch
      0.30 ±175%      +4.4        4.68 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.30 ±175%      +4.4        4.70 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +4.4        4.41 ± 21%  perf-profile.children.cycles-pp.__folio_batch_release
      0.50 ±132%      +4.4        4.93 ±  8%  perf-profile.children.cycles-pp.intel_idle
      0.00            +4.8        4.79 ± 15%  perf-profile.children.cycles-pp.find_lock_entries
      0.00            +5.0        5.01 ± 20%  perf-profile.children.cycles-pp.io_serial_out
      1.06 ±125%      +5.2        6.25 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +5.4        5.37 ±  8%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.75 ±132%      +5.4        6.12 ± 13%  perf-profile.children.cycles-pp.__do_softirq
      1.28 ±100%      +5.9        7.18 ± 10%  perf-profile.children.cycles-pp.update_process_times
      1.28 ±100%      +5.9        7.22 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      1.28 ±100%      +6.5        7.78 ±  9%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.22 ±264%      +7.4        7.62 ± 12%  perf-profile.children.cycles-pp.xas_store
      0.00            +8.4        8.39 ± 15%  perf-profile.children.cycles-pp.truncate_folio_batch_exceptionals
      1.28 ±100%      +9.0       10.25 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00           +10.6       10.65 ± 12%  perf-profile.children.cycles-pp.io_serial_in
      0.00           +10.8       10.80 ± 12%  perf-profile.children.cycles-pp.wait_for_lsr
      1.28 ±100%     +11.0       12.30 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.28 ±100%     +11.4       12.71 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.02 ± 85%     +15.8       17.80 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00           +15.9       15.94 ± 14%  perf-profile.children.cycles-pp.serial8250_console_write
      0.17 ±264%     +17.5       17.64 ± 12%  perf-profile.children.cycles-pp.write
      0.00           +17.5       17.55 ± 13%  perf-profile.children.cycles-pp.devkmsg_emit
      0.00           +17.6       17.55 ± 13%  perf-profile.children.cycles-pp.devkmsg_write
      0.00           +17.6       17.56 ± 12%  perf-profile.children.cycles-pp.console_flush_all
      0.00           +17.6       17.56 ± 12%  perf-profile.children.cycles-pp.console_unlock
      0.00           +17.6       17.65 ± 12%  perf-profile.children.cycles-pp.vprintk_emit
      0.00           +18.0       17.98 ± 12%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.00           +18.0       17.98 ± 12%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.00           +18.0       17.98 ± 12%  perf-profile.children.cycles-pp.memcpy_toio
      0.00           +18.0       18.02 ± 12%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.00           +18.0       18.02 ± 12%  perf-profile.children.cycles-pp.commit_tail
      0.00           +18.0       18.02 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.00           +18.0       18.02 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.00           +18.0       18.03 ± 12%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.00           +18.0       18.03 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.00           +18.0       18.03 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.00           +18.7       18.67 ± 12%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.00           +18.7       18.67 ± 12%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.00           +18.7       18.72 ± 12%  perf-profile.children.cycles-pp.process_one_work
      0.00           +18.8       18.77 ± 12%  perf-profile.children.cycles-pp.worker_thread
      0.00           +19.3       19.28 ± 15%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.00           +19.3       19.28 ± 15%  perf-profile.children.cycles-pp.evict
      0.00           +19.3       19.29 ± 15%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.00           +19.3       19.29 ± 15%  perf-profile.children.cycles-pp.do_unlinkat
      0.00           +19.3       19.29 ± 15%  perf-profile.children.cycles-pp.unlinkat
      1.04 ± 79%     +22.3       23.38 ± 15%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.89 ±100%     +22.5       23.36 ± 15%  perf-profile.children.cycles-pp.kthread
      0.89 ±100%     +22.5       23.38 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      6.41 ± 88%     +26.4       32.85 ±  7%  perf-profile.children.cycles-pp.start_secondary
      6.41 ± 88%     +26.6       33.04 ±  7%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.41 ± 88%     +26.6       33.04 ±  7%  perf-profile.children.cycles-pp.do_idle
      6.41 ± 88%     +26.6       33.04 ±  7%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.56 ± 99%     +26.7       30.28 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.56 ± 99%     +26.7       30.30 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter
      3.68 ± 96%     +29.0       32.73 ±  7%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.46 ± 30%      -5.5        0.00        perf-profile.self.cycles-pp.smp_call_function_single
      5.44 ± 65%      -4.6        0.80 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
      4.63 ± 59%      -4.6        0.00        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.00            +0.1        0.06 ± 32%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.06 ± 10%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.08 ± 15%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.uncharge_batch
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.__page_cache_release
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.delay_halt
      0.00            +0.1        0.10 ± 24%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.00            +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.workingset_update_node
      0.00            +0.1        0.13 ± 32%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.15 ± 71%  perf-profile.self.cycles-pp.fbcon_redraw
      0.00            +0.2        0.15 ± 67%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.15 ±  9%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.2        0.16 ± 55%  perf-profile.self.cycles-pp.bit_putcs
      0.00            +0.2        0.17 ± 25%  perf-profile.self.cycles-pp.delay_halt_tpause
      0.00            +0.2        0.18 ± 13%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.2        0.19 ± 16%  perf-profile.self.cycles-pp.list_lru_del_obj
      0.00            +0.2        0.21 ± 12%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.2        0.22 ± 15%  perf-profile.self.cycles-pp.truncate_folio_batch_exceptionals
      0.00            +0.2        0.22 ± 16%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.23 ± 16%  perf-profile.self.cycles-pp.radix_tree_node_rcu_free
      0.00            +0.2        0.23 ± 30%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.00            +0.2        0.25 ± 15%  perf-profile.self.cycles-pp.get_slabinfo
      0.00            +0.2        0.25 ± 20%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.3        0.27 ± 16%  perf-profile.self.cycles-pp.xas_start
      0.00            +0.3        0.33 ± 54%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.4        0.36 ± 10%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.4        0.38 ± 16%  perf-profile.self.cycles-pp.ifs_free
      0.00            +0.4        0.40 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.4        0.43 ± 13%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.4        0.44 ± 13%  perf-profile.self.cycles-pp.mem_cgroup_from_slab_obj
      0.00            +0.4        0.45 ± 11%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.4        0.45 ± 22%  perf-profile.self.cycles-pp.__free_pages_ok
      0.00            +0.5        0.48 ± 23%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +0.5        0.52 ± 23%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.5        0.52 ± 15%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.5        0.53 ± 25%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.6        0.59 ± 48%  perf-profile.self.cycles-pp.xas_descend
      0.00            +0.6        0.62 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.6        0.62 ± 14%  perf-profile.self.cycles-pp.xas_clear_mark
      0.00            +0.7        0.69 ± 25%  perf-profile.self.cycles-pp.folio_undo_large_rmappable
      0.00            +1.0        0.96 ± 62%  perf-profile.self.cycles-pp.fast_imageblit
      0.00            +1.1        1.10 ± 23%  perf-profile.self.cycles-pp.find_lock_entries
      0.13 ±264%      +1.2        1.38 ± 12%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.30 ±175%      +1.3        1.62 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.48 ±132%      +1.8        2.28 ± 16%  perf-profile.self.cycles-pp.__slab_free
      0.00            +2.8        2.85 ± 34%  perf-profile.self.cycles-pp.ktime_get
      0.30 ±175%      +3.1        3.40 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +3.2        3.19 ± 14%  perf-profile.self.cycles-pp.xas_store
      0.00            +3.5        3.54 ± 15%  perf-profile.self.cycles-pp.xas_find
      0.50 ±132%      +4.4        4.93 ±  8%  perf-profile.self.cycles-pp.intel_idle
      0.00            +5.0        5.01 ± 20%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +5.3        5.34 ±  8%  perf-profile.self.cycles-pp.intel_idle_xstate
      0.00           +10.6       10.65 ± 12%  perf-profile.self.cycles-pp.io_serial_in
      0.00           +17.6       17.56 ± 12%  perf-profile.self.cycles-pp.memcpy_toio



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


