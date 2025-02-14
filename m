Return-Path: <linux-fsdevel+bounces-41710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BBA35844
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 08:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B63AB394
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67B21CA0D;
	Fri, 14 Feb 2025 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwoS6ikI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EB21518D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519757; cv=fail; b=WGrws+Zk+2ecA7fXnzMP9xK5Yf3r6Kxczp00w3QFTDX5WORqqPKAze1VX0cuU2BiFQSgKVVAYY6ENYlzXklpzonWNR01LvKugn9OAEaM0H1TR2xK0N1fNEOFFgt6cCEyFitGd0t8yVKxCtUyjgChWiAVFtD9ip1EXVyaedtfaR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519757; c=relaxed/simple;
	bh=TnSGZYsT0N+cqXdH2pPN2y+k90QHHuq0oWfNzx5Bppo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KehN9XN/0PUaGo7F/KsHk2TbuH+f5O1X1QNsn9ko9dRc/VboO6tHlBONQTILBrLjImT3g9fEDT5AZBNReQB1aCRr4cegzIVEH+0y7AXY5v7EbUvhveTI3qH7d5HRfPholAtDTZNSgUjcndJzu7CIhd78Dq0jwiBIDx0SHEoBul4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwoS6ikI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739519755; x=1771055755;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=TnSGZYsT0N+cqXdH2pPN2y+k90QHHuq0oWfNzx5Bppo=;
  b=EwoS6ikIbogbwsanOqP/WEOsJe1+Bz1oYhl3mkny34pUsMc32YmgjY7k
   6ohB+M3Pc19SaynPqHcIiD/yHX9CsPkOBVgCtcSgH0xJQtxMBv61FpTXI
   DWDZcqrpUP3mdtCxvey8SWxUmxfCnlspOOi+2kqLBkvvgrzihcNXTm8Yx
   nvDXFkwyBOiYOH0VDB8WaOC1gYiRGjccE7piUZwiYSvj+ELbks9kZYX9k
   VrpeR2YVe8R/DPuzMis+i0uR/dm5rICPjcjH6/saknC3QHNBAkuehWGeM
   ygmrQpJXMma4qqibUi+KtYQvV87cu5Ll/k8IvvQ8oBqYWy+Y2vY/GW6Ls
   w==;
X-CSE-ConnectionGUID: TQQn2HigQNKuZtGBd3d1sg==
X-CSE-MsgGUID: 5gHDX/r1Rua6jWZ38e1x9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40182744"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40182744"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 23:55:53 -0800
X-CSE-ConnectionGUID: vaqrp1e9R/WnQC+Cx9gTiA==
X-CSE-MsgGUID: oGHDgizUSVq9nybBLpUVDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113256093"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 23:53:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Feb 2025 23:53:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 23:53:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 23:53:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA/Yk2RcexqQUnWIhoLbv3E+XVYqs5YVWdFK7rk7V/EUTwlzmep+ExmLX9cx6MENKm1o+1wk3yttoaQvskGh6/CgIYMrxn1ROyEOr+lnOMNnMCKuVCK0Apj0cQyoHNBUZnbtRSjhW3im2aNzpUesyP7QVnNDBWc9MLzD1SXB7931YpO4diOnw4JjjpBcNxzCrw3F3Ym77Tabi3TNLIYUgtVdBZR/ofztlGBg2Gq0qY9Z8CCcd7a4KBosHT6XY0H+OSIb00gs0gW4Vyh7T18uoC0GiliNXKkbGWhWLwjEYawptcgb9V9aGoeymadF3iOvUvbAYkrzid9dcs8ZUfM1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbYI4RDR5gOw7GHvA3Pl19d1it1x7a1r5Nna0Vw2eu8=;
 b=jbt+KOw6DVnY2NIYAt8e/LnOxnny0lDPz4oyjOYlrKazHRSx2QSMDQpee+ssfzjaPpx5cVqzpZXt/4E5nzcVngwqOZ9oOCoVuqaDBUKY4fv+0UjqYh13vZx96qfj05C2EETl2b3C7jb4yUTT0OfUysUCBfGfgh1aTvmGbj6btZq0FWuDdma/ykzKHGpMCf0KD0WEGk/VoUpXVl56IxB/VqYkeB06mzNXZ4ld8AWAxlfHcWaUoSwzBJjWhwnwLhM2g4r40sHyYDf2T0khEsoP/Y+42Xg70j08ueOmNSFInANR+apsiZoOIwxAhXlxHMBmM4kNe6/eXhqdiNtfkibo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 07:53:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 07:53:18 +0000
Date: Fri, 14 Feb 2025 15:53:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [pipe]  f017b0a495:  hackbench.throughput 10.5%
 improvement
Message-ID: <202502141548.9fa68773-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b706cc-19d9-41e9-e305-08dd4ccca4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uIIQ3pLsbVT4TriKt1AFr7F29twNFgLtXovgy2YxGGaCLJQ/Xoi93L7f++?=
 =?iso-8859-1?Q?KSpV3OEax/NnsCZLewn44vpLw9b2ZPDUORWecxNcsmbqlBDqgYqW3c3Ckc?=
 =?iso-8859-1?Q?A0g/1msoLtdPtx3ElfnhR1Mi+1TWKQ0skhHX8sG6VryEOpaNdqGn3M8LPf?=
 =?iso-8859-1?Q?L5hAGYYlzyr6YpVvY4k602Cl3k/MuNisOricEwwCZm99aWwidi2abxRgid?=
 =?iso-8859-1?Q?7AQTpOvHiLmZ4reuT7x/sB6HLFPALOkX6/jNVoMGrG0QblNdObZ7dm8BF1?=
 =?iso-8859-1?Q?cj3uT7nV+7Q0yfLJA+UHJ6MauF2MBSM1ZpuWOkc2MxIvQJjh2FHDBiEmLN?=
 =?iso-8859-1?Q?V8dSOP8DpYrsm3D6vurICMLxdKl43X2b3YNIh38JS28p2fMAebO+LWBFGi?=
 =?iso-8859-1?Q?cyHujKt8R9sfbW+54Q9pzPJbOvNxjmryiWJOaQKxc4XENolbUuHPhY+0F0?=
 =?iso-8859-1?Q?HMODJOINWNhAvu5V/HLyVBrUCqk/TYNnBt+zpv31SyHsnam4z6XIUPi/Fv?=
 =?iso-8859-1?Q?1GRuZnMG8SWGFvmrL+6yQkI9jN0XpyAxdXYeoeU9Bf093MI0r2Ype/7htD?=
 =?iso-8859-1?Q?/ujtSBTRNPJtXgrLW7sC9Wt+9AdsjDXn2QG8f1rtCvCJDRpAOqkIDkeK+7?=
 =?iso-8859-1?Q?SI+7nly/nH0Cbif087SUspY3Ja8mCJXGq7nbb05ofNRRQI6tl6gAG99fpy?=
 =?iso-8859-1?Q?NxWOMJs02m7lxQRMQQRc5QsjusZr0dkmKleEwMniwp1/8vS67DwVvov85T?=
 =?iso-8859-1?Q?qS86bLXqfhcVlW/0HrpvPeVQM4X7aXpcTYPZ/VTtr7d/OMnj1Patqyt2Bq?=
 =?iso-8859-1?Q?cXXpyqrr11yxhKt+xtPwd2KM50wXOLnfC/eu9UhzzjllTfjbko133pff/P?=
 =?iso-8859-1?Q?HX5vlYTvfAw8uTURCab5bUjHAsF8lLzP5v2l3lfoJOn34zTBfPvywT+aQu?=
 =?iso-8859-1?Q?1CMBbHGQaDKmwV8w2mL24FFJ/bVki9rl4aoKR4d4qzIhxW9kf2D8cMEltB?=
 =?iso-8859-1?Q?NgRpuL3JuEyuP3ZngSEeP0w9yKEa0sj9XhJExSq9pw0hFcMzH6c2/VFcO+?=
 =?iso-8859-1?Q?mhPQ2n2/67XCW3vbYTsRNFWeJXtL4UHJvwW4DQPVrHlBL80Gh6oH0ctj42?=
 =?iso-8859-1?Q?9cKjL2boFsHFZ/h614vMF41CoucsVFcR3KKdUYxpVx6kcYCIihFPRXmUyc?=
 =?iso-8859-1?Q?MWV2tySNinmZp4gGmM6oaTivawAs/DZ5rXMnvD8Kw85Sh7VPhUQep9w6ZM?=
 =?iso-8859-1?Q?I+M5LuEbJSx80VFNCt651/pakeObzWlb3xd+dXK6+ic7RumLnxYsi7RoLs?=
 =?iso-8859-1?Q?prAx7n9RQTHNUP8sdLv3zbD1h83hzb0izxdN8UlUO4jCKpU1fM3hxfB/d8?=
 =?iso-8859-1?Q?AcHODssxqsInBK2WQ6/gZ1HxkxcZAtOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n6vRHD72S3cCMIhfDlO6LxVTyA8CNT9M21WZ/6CCXil2Wq/IynNo5HksUd?=
 =?iso-8859-1?Q?VZNcKZT9oGkhPpXgWIo+rM7w/5B/W2O+YNcnEyc2ov1vXLqhCBYzfRMoyO?=
 =?iso-8859-1?Q?lu4KOrmFDtVp3/MgL1RRzzeTo2IuMnJ0qJEW7Qwpm6RW5Ljq9TeTPkeSAd?=
 =?iso-8859-1?Q?blGCJVRQsrYLzeKZrvOEBVm2P0JY1UJICVx0Pegw1Ei2RetGlXOlhm4/Jh?=
 =?iso-8859-1?Q?ux1DFq5vZJCYEsfrPqVFDJzvFfSss8cxnJ5nf0aN6kxeyOVYkS79uYSUpz?=
 =?iso-8859-1?Q?iI/AEuQKP144hRKWH5+f0rxJxm1KDXCXr0sHEbLgA2jCYeN3C4Y1JgB/UF?=
 =?iso-8859-1?Q?1QMS/yYIW+7MCP+hm6bvXN2BIjstf3BJrBmb83VjdNO+VTWIamljvo5Z6h?=
 =?iso-8859-1?Q?2RLBH2CXoSpackQVNa2Kah3/sjMX8zkK8q5d17Xxl3H8IOs9RdoKSnIi4i?=
 =?iso-8859-1?Q?RYJa597Ts/ZjP484VLXQZp6Wft8k4fKFq2gq/BnMUSEpP0ENVo1Mu8JhSc?=
 =?iso-8859-1?Q?YS4vJm6/5tOQ6vIwmvXeUueNddgMCMwoFzKfAFvT69kLfwiRj8Kt2orkFi?=
 =?iso-8859-1?Q?irBTOOWZnBw6YsqMEgyv7ND/sjgQXbP9MIc89O1q55UZENSVX/pKvzQA/Z?=
 =?iso-8859-1?Q?ii/nwyRS3+FEGw1C8eSRHgF/qI8hphZPWMBg7nNg+s1HDtavUM6fGusJj9?=
 =?iso-8859-1?Q?mNf3yRJCGkVDIIxQnc9VHSEQV6mfp/2SoZxj3u09Ndf2yYgZavF+H+vFfu?=
 =?iso-8859-1?Q?upJSmA3zc/PywjZEAtdA4yYv5DMO9au6/35qQL7vpJ0SCxQ9A3DtSxmScn?=
 =?iso-8859-1?Q?4yg10tudXrNTEG5wC3XfjfSTB4+asUCGN9/ekIhDtU1f7I/pWF3o7sExdL?=
 =?iso-8859-1?Q?KgZw85uMDWolu0eMmLK5mp9RdaSS2YuzmWgloWhJqnC7awapu5WkGcAqxE?=
 =?iso-8859-1?Q?Kg5WWJzE7wgWaO3pL4m7moiEK027NicvpSlPjEAon6BAFw1WBQodZmR6DF?=
 =?iso-8859-1?Q?KeQqSc6b9LkynSJZ78st/HedCFHayAGAl9Ko6wuTxOUVOj8VaKgA5VK+iz?=
 =?iso-8859-1?Q?mM2JdHFirm9bHI6aK6BCr/fCHQioySGNfftXy6s0V7fTCQ/45mcSKRucfq?=
 =?iso-8859-1?Q?PrQCi6PNRlE2AnksunJSyTu+xmLxwmyJdGRCnhOC8z6M0GcFKXLOQltNfC?=
 =?iso-8859-1?Q?bHlqlt/HPnGZnDxjKdOtv3DppnrJtOjdyNTIa9Ap8Y3xcp90GoxnY9pTXW?=
 =?iso-8859-1?Q?JbhLYqBQsak50D8Ik65OEFIIy4FLNu5Q3fmWELVHCDr3KNHNDzgP3nh9fW?=
 =?iso-8859-1?Q?yXliRaHJy+/9H6HuBF7vGtNwPYPF+dLYb1V7lTLr++IZUd4JuWoW5Tumr1?=
 =?iso-8859-1?Q?q8diMX+Uie/PJEJmfI0WH5SetZLVAwHtFHXpfmZh9LMjRPaWTDqW5kkUv7?=
 =?iso-8859-1?Q?3e4b//QNSm+nTN0eC9hxaNNODsUkteXYPVUTiP9AYCW18AUGD6r5kGGhGT?=
 =?iso-8859-1?Q?LjwjbXa+Gy+3YInuJgTPFu+PwzhHV+tt7/VLA5RVFiIijWtoeYKSAqBoXW?=
 =?iso-8859-1?Q?XDl1BxfvqWyRd8gnsFZpUiqebLJ1HGoOjN+YoHhMfWMgXbNn0N2j6B4AYA?=
 =?iso-8859-1?Q?Uh53Gz+C7SSRNfGTCxjpup+lDYknnZm8PLcoHR74xDwZg59+PyDxDl5Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b706cc-19d9-41e9-e305-08dd4ccca4d3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 07:53:17.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxb23pKEiMCKiQdOwjNvTTd1KBA6jaC9/jHoaeh7kFu90OQDUCfhVJL8VMQczeBA0lpEiD9lp89WzVFotvx66A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.5% improvement of hackbench.throughput on:


commit: f017b0a4951fac8f150232661b2cc0b67e0c57f0 ("pipe: don't update {a,c,m}time for anonymous pipes")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: hackbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 800%
	iterations: 4
	mode: threads
	ipc: pipe
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250214/202502141548.9fa68773-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-9.4/threads/800%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  262b2fa99c ("pipe: introduce struct file_operations pipeanon_fops")
  f017b0a495 ("pipe: don't update {a,c,m}time for anonymous pipes")

262b2fa99cbe02a7 f017b0a4951fac8f150232661b2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    319054            -2.8%     310139        proc-vmstat.nr_active_anon
    319054            -2.8%     310139        proc-vmstat.nr_zone_active_anon
    549457 ± 92%     -94.4%      30640 ± 30%  sched_debug.cfs_rq:/.load.max
     49885 ± 87%     -88.9%       5535 ± 17%  sched_debug.cfs_rq:/.load.stddev
   1266298           +10.5%    1399088        hackbench.throughput
   1237971 ±  2%     +10.0%    1361485 ±  2%  hackbench.throughput_avg
   1266298           +10.5%    1399088        hackbench.throughput_best
      4837 ±  2%     -11.3%       4289 ±  2%  hackbench.time.system_time
 6.114e+10            -4.2%   5.86e+10        perf-stat.i.branch-instructions
  2.74e+11            -2.0%  2.686e+11        perf-stat.i.cpu-cycles
      1167 ±  3%      -7.4%       1080 ±  3%  perf-stat.i.cycles-between-cache-misses
 2.527e+11            -6.0%  2.376e+11        perf-stat.i.instructions
      0.87 ±  3%     +15.0%       1.00 ±  4%  perf-stat.overall.MPKI
      1.07            +4.2%       1.12        perf-stat.overall.cpi
      1233 ±  3%      -9.3%       1118 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.93            -4.0%       0.89        perf-stat.overall.ipc
  6.45e+10            -4.5%  6.161e+10        perf-stat.ps.branch-instructions
 2.318e+08 ±  2%      +7.7%  2.496e+08 ±  4%  perf-stat.ps.cache-misses
 2.856e+11            -2.4%  2.788e+11        perf-stat.ps.cpu-cycles
 2.662e+11            -6.3%  2.494e+11        perf-stat.ps.instructions
     10565 ±  3%      +8.0%      11409 ±  2%  perf-stat.ps.minor-faults
     10565 ±  3%      +8.0%      11409 ±  2%  perf-stat.ps.page-faults
 1.435e+13           -14.2%  1.232e+13        perf-stat.total.instructions
    299.84 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
     35.32 ± 24%     -46.6%      18.84 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    169.52 ± 79%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
    308.81 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    308.90 ± 30%     -47.0%     163.58 ± 19%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     10.16 ±210%     -99.7%       0.03 ±115%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     85.33 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    209.12 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     85.21 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
    374.84 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     39.29 ± 55%     -55.1%      17.63 ± 13%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5455 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
      6980 ± 12%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      8278 ±  8%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      8110 ±  9%     -36.9%       5114 ± 16%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      8143 ± 12%    -100.0%       0.00        perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      8560 ±  9%    -100.0%       0.00        perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      2455 ±109%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      7556 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      8543 ± 11%     -37.6%       5332 ± 16%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     96.49 ± 28%     -44.7%      53.38 ± 12%  perf-sched.total_sch_delay.average.ms
      8719 ± 10%     -37.3%       5462 ± 15%  perf-sched.total_sch_delay.max.ms
    261.40 ± 29%     -46.0%     141.08 ± 12%  perf-sched.total_wait_and_delay.average.ms
     17438 ± 10%     -37.9%      10828 ± 16%  perf-sched.total_wait_and_delay.max.ms
    164.90 ± 30%     -46.8%      87.70 ± 13%  perf-sched.total_wait_time.average.ms
      8862 ± 11%     -35.6%       5710 ± 15%  perf-sched.total_wait_time.max.ms
    846.91 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
    846.15 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    858.41 ± 34%     -50.4%     426.01 ± 19%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    227.96 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    576.02 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    983.53 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     67.17 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
      7320 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    752867 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     96327 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
      1106 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     11731 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
     16557 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     16104 ±  9%     -36.4%      10235 ± 16%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     16318 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     17121 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     15123 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      8275 ± 15%     -33.0%       5544 ± 15%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     17047 ± 11%     -37.3%      10687 ± 16%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    547.07 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
    374.49 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
     36.27 ± 19%     -44.7%      20.06 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    280.11 ± 85%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
    537.34 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.35 ±138%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
    549.51 ± 37%     -52.2%     262.43 ± 20%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     10.16 ±210%     -99.6%       0.04 ±134%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    142.63 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    366.89 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     39.52 ± 95%     -73.6%      10.44 ± 53%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    149.09 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
    608.70 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     11.89 ±178%  +22112.3%       2641 ± 61%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
     43.32 ± 27%     -61.1%      16.86 ± 29%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      6944 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pipe_write
      1676 ±126%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
      7277 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      8328 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      3.54 ±175%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      8192 ±  9%     -37.5%       5122 ± 16%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      7035 ±  5%     -68.5%       2216 ± 81%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      8490 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      8581 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    915.16 ±118%     -86.0%     127.99 ± 79%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      4449 ± 64%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      8142 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     11.89 ±178%  +27553.2%       3288 ± 58%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      8275 ± 15%     -33.0%       5544 ± 15%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8719 ± 11%     -36.0%       5584 ± 16%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8432 ± 10%     -36.3%       5373 ± 19%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


