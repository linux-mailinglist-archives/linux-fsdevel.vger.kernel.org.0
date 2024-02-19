Return-Path: <linux-fsdevel+bounces-11974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B06859BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 06:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991992826FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 05:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0311F952;
	Mon, 19 Feb 2024 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGPUymvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E91CD2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708321461; cv=fail; b=KLMoanoME8oD40qc63MY+M2KtLvHWeqPvluyKVPjQYUAW9Q8EifEtnWo4+52u5S2K/FSk7fLsKmjw841WEP4q2/TnH2w3uzQs0UhLvFmBl1Z0mW4bMWUGwS0r20ODwFnC5CazZvwy1N8wdmvmH2Hl066ATL2Fiey+3zqS03qAI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708321461; c=relaxed/simple;
	bh=/2qWWAZRnH0OhxeM68a4fqVKFC2Nb5g/xKBVN9pWtvs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=X1CRiRuZpbWjMs7a91/zRaUKbuCKRrSV9tJmmLF9EMsxRIrnNePVpKZJk48M9LQBm8IshhqkiK0q+qvGVStyiy+FLOOmVRS3JhS5xnJsVIAh52KthX8SWi3UJl1iNeU+bsmjIM9KBJQMIXCotTMQ4T4oQUr4LwTWlvZnW+88F6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGPUymvw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708321458; x=1739857458;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=/2qWWAZRnH0OhxeM68a4fqVKFC2Nb5g/xKBVN9pWtvs=;
  b=nGPUymvwFRKqTz87KJ5P/0ynWf27+QzVBLE81kDnfNOoKB77Roiv8nwh
   I1LlRlDrC+rNdooL4IDNv2gCm03XxXeHSzun6ioX1n9whBK8bpCdmREA0
   ahKu5JuPDqJrZligM15a4TatNZasXS7jJoHB6am2G+FjBLrAkK8YBrz79
   qJHyPh2CQyweV2/UjhwKsDGwUQSiBBkhMXd8Fm/JnAp6r7hvxK3ZZQ+Fa
   q9IxjeXHinIpiu9Vq6QhUlfFEE9Kgo7073FcgdYTnFEo5FN6dUX4OxoP+
   PUsLJGE0R9g4rWS5KENARWKmqAYqmFRofuHLq143x9SozzSvRuDDs5utl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2249528"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2249528"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 21:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4537220"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 21:44:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 21:44:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 21:44:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 21:44:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 21:44:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE1sTZt5DRRrlbMwPbu++YeHpkqFUFX6fKAfIIdQfLf5YSBlNjbGUfX+PaJkZso8ZBbH93MeC99p6B+GNHkPAiAANHczbL9KyOxXME2jR0gXe/NgqzFOyvDFxYOjTYxKgbxcSHhJf4a650ubwzWAT2JbW+juljSQpyXVGgLSeMTtO0gzo7JNdGE9OET+qhJDrxfPpf/3to1knfajDDfnQ5+F6ma+A7TFFBzZ9jITUtY/C89mNDH+G8jfA7tHORhIzZb2ZC/1DC8gU9f+olabNnsqmZSX6o+VCvSfOgFD4JpWEYAFKOxIvWoa3Zw129jH7uVCBCRDUGwHYtOvOKZyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxw5QGFljkw7GWlD9sMyZkA9Ct0HIkdFzFmb9DbnYMk=;
 b=JbjyG1/tDF9PmjsHrQ0JvYfQgN9k26bBJG7Rd/uFzR5r+tJmTwjZni9Y49Z1bHMSVUD9vkOtzLX5NhUzLXAZwv2Z+EwuR5ULtWpOeVqQst2Xt1W6WWgD6a8MX0C91ekGmKmsCtfuU9snk/vkTZ6j83vkilauoHPpeo41Vbfl6aMsSveJ3rnPqUgwn81Nmk9WS+/u9dgddSjGEuh6E/qg4FTuhFgtxF22aClCM30amjiNnIcfUveCnEZENUGP555C36EHLg36sR4mz4fLaQXHYCuLqDhHaKq95a3M8AiE98h7hMMCX+kExQXY6bD4LmxAneOqNRKuEi8KU7NoU2D/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:44:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 05:44:13 +0000
Date: Mon, 19 Feb 2024 13:44:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Matthew Wilcox
	<willy@infradead.org>, kernel test robot <oliver.sang@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: [cel:simple-offset-maple] [libfs]  a616bc6667:
 aim9.disk_src.ops_per_sec 11.8% improvement
Message-ID: <202402191308.8e7ee8c7-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: df903f8a-fa0e-4a10-1834-08dc310dcd4b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bZw77i3bsgpLYM/oniqQuBgs5wO+njg4fHJgzD5uH0L5Uc54eLq/7DhQi8MnNrHggCMbZbmDkmL7CL34/uEcjs0tXPpDfQINRmd8Hpd/H3AwEYY+mwYIWcHP4X9bZgC77Db+LhHN6N+9e96Bodexhp4Zo9/8xlrv4FoVv+uIPwDyemt3QH9Us3QqG5jItEPWXriTGKHuKyGSgo9Pvrd9Z9AjPdg407ytM6A3n8Beh6yiLYRMLvrae1SIINU3ChzN07zy3gDs1Hu4ypS25CFrZO3iaLZvATNcIAEbbGFpbWQrpUhFGXVdYhX3HenRs3ESyV+dWvcKUh6/KXRhWHyRNho0EYJowIbzx++CqG15FYNEVszOm6bREzq1xaxsr5zPchvBwavDMZm0nzW7Kek+nlT/7THJDz8F8z2hLGXrvJVxx4iUCdRosGau0xr+3rMakcCTFC8nDO62o8C+hwYtwDpxUCU2uYEJ8ho6bxQTEjZWw/f8yLqeEOgOzwtqrIGoFI9xBVV5gh0T73J6eO/ilBjaS9ap3WdABgQGmm/cxwLEG9KJbvyu9I1Nd0GAxl2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(230473577357003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(26005)(107886003)(1076003)(8936002)(316002)(66476007)(6916009)(4326008)(66946007)(66556008)(2616005)(41300700001)(83380400001)(8676002)(86362001)(38100700002)(478600001)(54906003)(6666004)(6512007)(6506007)(6486002)(966005)(36756003)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YvS1BfXjCKnGKjjzx3/ZNHCrzQjCpjNf04nAwLn7rshx0WqudCKqDri6MI?=
 =?iso-8859-1?Q?yhivBbZNikfyV46wE5EHzfkyYLFFJK2r+Df+11omZpvzIM4nWrBQpzaFNS?=
 =?iso-8859-1?Q?pyYVlJvDhNFzVRWJjpiDC3ptdNa+XwfHKFiMOPlIIBGym5riZ0+9unbsVg?=
 =?iso-8859-1?Q?79CIS/LkqDInrhKcGMjvRAf7+IM7nfL9nv3OEKQhqPv0VUF9avcZqBlXBP?=
 =?iso-8859-1?Q?jTiBAwiqTwuxD2wLQm3En6vQdUH4oL6gmm1jTJpQdF3vqM+jmSfwgXKAB4?=
 =?iso-8859-1?Q?qSKhijFQNXKc6DaC+03A9mjto1tLngn852/zgP6NFl19h7hVLLJixbHS4u?=
 =?iso-8859-1?Q?ct5grH8ITs2t5vanZ53aILYXffSKbr8pW3y4OLYVOv8drJWZPT3Ml6vTZ4?=
 =?iso-8859-1?Q?iSBR/Bk4/RF34OY6pUGE0OpZs1rkDjQcQIKAyzKqRdDsv4PNT5b4ZtFsc/?=
 =?iso-8859-1?Q?2OBxsJe2jbQBW4kBrcKr33f5bdCA2/R7JXFyMZEAZE/OaF+vM6bf+jyGMV?=
 =?iso-8859-1?Q?z5GWKvIYhIU21PJiHvgz6b6085zxqVxEYO9BuIRaRu/WOLdlNq8UqEJQE7?=
 =?iso-8859-1?Q?F66zweT3xOvgOtJnpWNbv3eF6ZRkF0hBvazwnvdnk5Vu+XRw6uBwjMfnpK?=
 =?iso-8859-1?Q?Fe4x3ap9LRGi29KamG5YpqsebMCHKHdxsjU8r2X8Y/ll2Qul5zSHJkCyhO?=
 =?iso-8859-1?Q?gI2TsTJebw1gUhzIUOftQpRBmAqEmyQiXr9kNZFkKefhB89VlKAwHuBiH8?=
 =?iso-8859-1?Q?4c02fU6OjZAt1MgGkcOyIlOKcEUJVgTqxeaQhZYNBSPIGHGiINWHub7HS3?=
 =?iso-8859-1?Q?WcCW9WRgpFPj1QFE2YV72gJ3RuBr5hzdyMfwA/lLHN12+gW3KPNdBtfEEb?=
 =?iso-8859-1?Q?uW66+4iE3qcWcDt5pfZUAljp1KPD568dSxtfDWvTGjgl+CRukl2Yzm0rdk?=
 =?iso-8859-1?Q?mJ0bh+ajfNsibkl1mzDqpEI91/kf9DfahKmMcwRmyy1qdhtIeSZK4Z1qfq?=
 =?iso-8859-1?Q?osxJv2zsXzKOFYu3dDZniohgrOU/OhXT83LOfiDoSKMILntkEZT78L4YEE?=
 =?iso-8859-1?Q?pT1/r328eR0moDpM7KALW7qM8zrnD6l7DnhX5xu0oaA5xHj1rOB8/EMAhV?=
 =?iso-8859-1?Q?DPKuzs/2WT5r0CbgoTkJe3ohaGNeGUDLtGDiKJpmzBmHbaHYaDSvhSOT9X?=
 =?iso-8859-1?Q?Qjl00N3rjej5+Y5oQ0Bw40IjtF4qkRpfCYic856WvY2ERbTjLGoU16Gmoz?=
 =?iso-8859-1?Q?YpgkVi9nOiJWZ7AZuIQmdOrdEyTnzgIbz71/zTlDpKhJp32r41dl8qhLPd?=
 =?iso-8859-1?Q?K6U/QxkzxzW1hLud8qdSeby9m8kSztEqitBxOY9J4AnqNT+mtztOpDdjfv?=
 =?iso-8859-1?Q?Jae0gPlLKEC/AwH8fv5rIHAu6dzNmbBuuJZK8r80LCEoqgv8kOk3cNoQ7P?=
 =?iso-8859-1?Q?RWsDhuVg4YJGVjcPMp++AQ2TAl3uYwU5fhjpdu4G7mXGLBuvVAvXNhh9Wi?=
 =?iso-8859-1?Q?JfZMoVVaGmH++JeyBB0fw8yK1ZJLkp+COqJaxjqYZVTosJJJym86HvonCC?=
 =?iso-8859-1?Q?bTDFyVeuD/y1lLTJPeAGjsleIUQ3+DkeQnlyvFjuRZjUw08mIQkPZLEXLP?=
 =?iso-8859-1?Q?zIPfx8JypZQ/j3LyQW01I5mEF97fka+QnN0pyLUtdr9nXv0QhVfK8J3w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df903f8a-fa0e-4a10-1834-08dc310dcd4b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:44:13.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGu3jDeyVN7GfUvk0u4Yv/fk1PHGsKwSAqwwjFcXWlVXwZC+jIVIWyl9IPEeeIk2XEQ0d4uxz+Gch2zb/mxe4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.8% improvement of aim9.disk_src.ops_per_sec on:


commit: a616bc666748063733c62e15ea417a90772a40e0 ("libfs: Convert simple directory offsets to use a Maple Tree")
git://git.kernel.org/cgit/linux/kernel/git/cel/linux simple-offset-maple

testcase: aim9
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
parameters:

	testtime: 300s
	test: disk_src
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240219/202402191308.8e7ee8c7-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/disk_src/aim9/300s

commit: 
  f3f24869a1 ("test_maple_tree: testing the cyclic allocation")
  a616bc6667 ("libfs: Convert simple directory offsets to use a Maple Tree")

f3f24869a1d7cde1 a616bc666748063733c62e15ea4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.34 ±  4%      -0.1        0.20 ±  4%  mpstat.cpu.all.soft%
      0.00 ± 28%     +58.3%       0.00 ± 17%  perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      1464 ±  2%     +14.0%       1668 ±  4%  vmstat.system.cs
    164231           +11.8%     183678        aim9.disk_src.ops_per_sec
      1309 ± 15%   +2643.5%      35915 ± 23%  aim9.time.involuntary_context_switches
     91.00            +5.5%      96.00        aim9.time.percent_of_cpu_this_job_got
    212.54            +3.5%     220.06        aim9.time.system_time
     62.58           +10.2%      68.94        aim9.time.user_time
     21685            -7.1%      20144        proc-vmstat.nr_slab_reclaimable
   6611541           -88.6%     750673 ±  7%  proc-vmstat.numa_hit
   6561447           -89.3%     700947 ±  7%  proc-vmstat.numa_local
      5747            +3.7%       5960        proc-vmstat.pgactivate
  26113963           -93.7%    1648373 ± 17%  proc-vmstat.pgalloc_normal
  26042963           -93.7%    1628178 ± 18%  proc-vmstat.pgfree
      2.07            -1.2%       2.04        perf-stat.i.MPKI
 6.738e+08            +3.0%   6.94e+08        perf-stat.i.branch-instructions
      2.94            -0.2        2.70        perf-stat.i.branch-miss-rate%
  20408670            -5.1%   19363031        perf-stat.i.branch-misses
     15.11            +2.7       17.77        perf-stat.i.cache-miss-rate%
  46824224           -14.7%   39962840        perf-stat.i.cache-references
      1419 ±  2%     +14.4%       1623 ±  5%  perf-stat.i.context-switches
      1.88            -1.3%       1.85        perf-stat.i.cpi
 9.453e+08            +2.2%  9.659e+08        perf-stat.i.dTLB-loads
      0.22 ±  5%      +0.0        0.25 ±  3%  perf-stat.i.dTLB-store-miss-rate%
   8.8e+08            -6.8%  8.205e+08        perf-stat.i.dTLB-stores
   1536484            +7.9%    1657233        perf-stat.i.iTLB-load-misses
      2279            -6.0%       2142        perf-stat.i.instructions-per-iTLB-miss
      0.54            +1.3%       0.54        perf-stat.i.ipc
    786.95            +7.1%     843.12        perf-stat.i.metric.K/sec
     47.07            +1.1       48.17        perf-stat.i.node-load-miss-rate%
     87561 ±  4%     +17.2%     102647 ±  6%  perf-stat.i.node-load-misses
      2.01            -1.2%       1.99        perf-stat.overall.MPKI
      3.03            -0.2        2.79        perf-stat.overall.branch-miss-rate%
     15.07            +2.6       17.67        perf-stat.overall.cache-miss-rate%
      1.84            -1.2%       1.82        perf-stat.overall.cpi
      0.22 ±  5%      +0.0        0.24 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      2283            -6.1%       2144        perf-stat.overall.instructions-per-iTLB-miss
      0.54            +1.2%       0.55        perf-stat.overall.ipc
     44.15            +1.8       45.93        perf-stat.overall.node-load-miss-rate%
 6.715e+08            +3.0%  6.917e+08        perf-stat.ps.branch-instructions
  20340341            -5.1%   19299968        perf-stat.ps.branch-misses
  46667379           -14.7%   39829580        perf-stat.ps.cache-references
      1414 ±  2%     +14.4%       1618 ±  5%  perf-stat.ps.context-switches
 9.421e+08            +2.2%  9.627e+08        perf-stat.ps.dTLB-loads
 8.771e+08            -6.8%  8.178e+08        perf-stat.ps.dTLB-stores
   1531338            +7.9%    1651678        perf-stat.ps.iTLB-load-misses
     87275 ±  4%     +17.3%     102341 ±  6%  perf-stat.ps.node-load-misses
      5.62 ± 13%      -1.9        3.69 ± 12%  perf-profile.calltrace.cycles-pp.shmem_mknod.lookup_open.open_last_lookups.path_openat.do_filp_open
      7.87 ± 13%      -1.9        5.95 ± 11%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      8.47 ± 13%      -1.9        6.59 ± 10%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      2.97 ± 12%      -1.8        1.16 ± 13%  perf-profile.calltrace.cycles-pp.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups.path_openat
      0.00            +1.0        0.98 ± 13%  perf-profile.calltrace.cycles-pp.mas_alloc_cyclic.mtree_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open
      0.00            +1.0        1.00 ± 40%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      0.00            +1.0        1.03 ± 40%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00            +1.1        1.06 ± 40%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +1.1        1.06 ± 40%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.1        1.10 ± 39%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.1        1.10 ± 14%  perf-profile.calltrace.cycles-pp.mtree_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups
      0.00            +1.2        1.20 ± 13%  perf-profile.calltrace.cycles-pp.mas_erase.mtree_erase.simple_offset_remove.shmem_unlink.vfs_unlink
      0.00            +1.3        1.27 ± 38%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.3        1.27 ± 38%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00            +1.3        1.27 ± 38%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +1.4        1.35 ± 12%  perf-profile.calltrace.cycles-pp.mtree_erase.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat
     15.22 ±  8%      -2.8       12.40 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     14.50 ±  8%      -2.8       11.72 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.73 ± 13%      -2.8        1.97 ± 15%  perf-profile.children.cycles-pp.irq_exit_rcu
      3.50 ± 12%      -2.1        1.41 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      5.63 ± 13%      -1.9        3.70 ± 12%  perf-profile.children.cycles-pp.shmem_mknod
      7.88 ± 13%      -1.9        5.97 ± 11%  perf-profile.children.cycles-pp.lookup_open
      8.49 ± 13%      -1.9        6.62 ± 10%  perf-profile.children.cycles-pp.open_last_lookups
      2.97 ± 12%      -1.8        1.16 ± 13%  perf-profile.children.cycles-pp.simple_offset_add
      2.90 ± 22%      -1.8        1.15 ± 41%  perf-profile.children.cycles-pp.rcu_do_batch
      4.47 ± 14%      -1.7        2.76 ± 24%  perf-profile.children.cycles-pp.__do_softirq
      1.85 ± 15%      -1.7        0.14 ± 28%  perf-profile.children.cycles-pp.___slab_alloc
      3.00 ± 22%      -1.7        1.34 ± 38%  perf-profile.children.cycles-pp.rcu_core
      1.66 ± 15%      -1.6        0.05 ± 68%  perf-profile.children.cycles-pp.allocate_slab
      0.92 ± 18%      -0.6        0.31 ± 19%  perf-profile.children.cycles-pp.__call_rcu_common
      0.88 ± 27%      -0.6        0.31 ± 43%  perf-profile.children.cycles-pp.__slab_free
      0.28 ± 15%      -0.2        0.12 ± 25%  perf-profile.children.cycles-pp.xas_load
      0.20 ± 18%      -0.1        0.08 ± 30%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.12 ± 30%      -0.1        0.05 ± 65%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.00            +0.2        0.18 ± 24%  perf-profile.children.cycles-pp.mtree_range_walk
      0.00            +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.mas_anode_descend
      0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.mas_wr_walk
      0.00            +0.3        0.31 ± 23%  perf-profile.children.cycles-pp.mas_update_gap
      0.00            +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.mas_wr_append
      0.00            +0.4        0.37 ± 15%  perf-profile.children.cycles-pp.mas_empty_area
      0.00            +0.5        0.47 ± 18%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +1.0        0.99 ± 13%  perf-profile.children.cycles-pp.mas_alloc_cyclic
      0.05 ± 82%      +1.0        1.10 ± 39%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.01 ±264%      +1.0        1.06 ± 40%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.22 ± 36%      +1.1        1.28 ± 38%  perf-profile.children.cycles-pp.ret_from_fork
      0.22 ± 36%      +1.1        1.28 ± 38%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.21 ± 38%      +1.1        1.27 ± 38%  perf-profile.children.cycles-pp.kthread
      0.00            +1.1        1.11 ± 14%  perf-profile.children.cycles-pp.mtree_alloc_cyclic
      0.00            +1.2        1.21 ± 14%  perf-profile.children.cycles-pp.mas_erase
      0.00            +1.4        1.35 ± 12%  perf-profile.children.cycles-pp.mtree_erase
      0.87 ± 27%      -0.6        0.31 ± 42%  perf-profile.self.cycles-pp.__slab_free
      0.53 ± 19%      -0.4        0.18 ± 23%  perf-profile.self.cycles-pp.__call_rcu_common
      0.57 ± 10%      -0.3        0.26 ± 21%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.89 ± 14%      -0.3        0.59 ± 15%  perf-profile.self.cycles-pp.kmem_cache_free
      0.19 ± 21%      -0.1        0.06 ± 65%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.10 ± 20%      -0.1        0.04 ± 81%  perf-profile.self.cycles-pp.xas_load
      0.08 ± 19%      -0.0        0.04 ± 61%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.mtree_erase
      0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.mtree_alloc_cyclic
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.00            +0.1        0.12 ± 38%  perf-profile.self.cycles-pp.mas_empty_area
      0.00            +0.1        0.14 ± 38%  perf-profile.self.cycles-pp.mas_update_gap
      0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.mas_wr_append
      0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.00            +0.2        0.18 ± 24%  perf-profile.self.cycles-pp.mtree_range_walk
      0.00            +0.2        0.18 ± 29%  perf-profile.self.cycles-pp.mas_alloc_cyclic
      0.00            +0.2        0.22 ± 32%  perf-profile.self.cycles-pp.mas_erase
      0.00            +0.2        0.24 ± 22%  perf-profile.self.cycles-pp.mas_anode_descend
      0.00            +0.3        0.27 ± 16%  perf-profile.self.cycles-pp.mas_wr_walk
      0.00            +0.3        0.34 ± 20%  perf-profile.self.cycles-pp.mas_wr_node_store




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


