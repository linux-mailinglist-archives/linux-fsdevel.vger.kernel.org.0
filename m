Return-Path: <linux-fsdevel+bounces-16900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BCA8A470E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 04:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EC2B2113A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 02:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C317BAA;
	Mon, 15 Apr 2024 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4OeN4gr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9C17556;
	Mon, 15 Apr 2024 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148973; cv=fail; b=XdkAJ0Oxz7P3SfzhMWHbN+XYRxBoJHJ+PQMj4EYwpDogOyk2ug7hw0e4BImLv2AL00FNZlwo1OA1Dt9uJTTYbqHEBdWel74jcDdZG8MMkL2n8KUiIeWXoZaI0FF4pJYC1QKiK3tHU/sOGFpS6SE31jgEJDEJgL19Ln2l36Hj1fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148973; c=relaxed/simple;
	bh=IvXziEMakqLfLp19eNC08sj44TC74viLs3V+mDMaSPA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NOJXFDX4Fge0cfXVMKy96p58y43RQQtK7J5ulyaomCgn2ZfizYG0Xmk2jhNp1stw3pgdQKFIsSQKl9hLHnTSHgmIHT0undmM3reCSrY3ddDMHagrtLGzscGMdTxU8CEIlWwuxQttOKZK5DPBoc8WrsRNCpd+IDdqRtGugsEaK4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4OeN4gr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713148970; x=1744684970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IvXziEMakqLfLp19eNC08sj44TC74viLs3V+mDMaSPA=;
  b=l4OeN4gr02jSq9v0PyzP1rqPtcY6t2C6kCpntEPgoPmYB/P3wItkmoFn
   TWVtxkHMZK9eXksAp7TJpG18wM0UZarhHK26rXSK2oP2zrFsOIwQqpajs
   f5CB6KTS3QKi+P9C3G7CwPy6QJyX7NR4gfm5Cu7q5TKOV4nwAJxyA6AfY
   HcElJiqKWtzdQjWGQXNx/aFA7Guys6wIkThQOs3La10msaJL0mENVhsux
   ld2McopuV/CC7hrpt8h0IXeoO3kem7B4f1XYrdfmBseLmEvOPFZzLM5EV
   fEvyzsj9q1IKuIgzvpQebJ86WfgWcNawA3sXmtjrMkpqE6j03F+uBsvCT
   A==;
X-CSE-ConnectionGUID: XxRidbYuTTuVoyOTDsVikA==
X-CSE-MsgGUID: p7bqjY3MQ0CyGu0xi0Nvmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12299143"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12299143"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:42:50 -0700
X-CSE-ConnectionGUID: rt0di2EAT8iTtdxFVOqn1A==
X-CSE-MsgGUID: wuOLIa9RQqSjEioOiqud+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21762118"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 19:42:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:42:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:42:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 19:42:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 19:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV33E4pcGHxttHuRYWWOktAp/RZD5QzQIsE8WHffixfCZILcUqKYbGY17n83RxtJvIR9ZtPInoexs//jSJknZDu8+LzLhRn6qk8LGjYtoJFID+5z+NM4eiYWEvtcU1PPE3blyD9ScGukzjhkw96OzdQgfvXEg7viISYwZTGKHnm0Y8EMWpZKHTbBX6CIjsE7iyNW/TH3RADNeMq0tqanGeCzL8kjC+FTEi2QsnTPzhnHGNVoDHKvmtrGrdpVfJBzOYfLZpLdB1CmMnuBl8FZqWlBx+pI3PwfzunNvyIJHdyVer1gMDsXlRGAPe8MO8JpeH9ZT8MGB5ODzCjwAke9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzgUVmoOI5k7z6YbzR/q44TvcjK1F1QeEQJ5/VSxZ4E=;
 b=lPj2TbElDGNN7fMevgk+a0Lx3xHwaiKEANJ3RVmmj6EDhQqOR3nj/mhaLYiLTE00lyZ1TYJVPtOJyUVBLC9i+g7FRF+N+e3Ph3mIPE9o8bfTALp6XEiUHNs33Xy0IDOpT7aJ7ntXCgOm1wEwVfOEwrPxsV2APER6SxsId/NC2eEsio8ZTsNNk6qrkIEU1nhHbI6eh845+Y3/iKETmZudZ3T7KSLfzTmQhFvmnfJ3qOYmfoG8LVB6M9tEcxIGtnJ/kRM3GjGtQPGLRxJjmLILn06Z/ynPOQY+TXTa0zhPKOv2PfKyZmMPZw7c5l5dWxJPCPPWUTd+8pb/JRS/48pMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 15 Apr
 2024 02:42:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 02:42:46 +0000
Date: Mon, 15 Apr 2024 10:42:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kairui Song <kasong@tencent.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [akpm-mm:mm-unstable] [lib/xarray]  ecc70b3e0b:
 WARNING:suspicious_RCU_usage
Message-ID: <202404151046.448e2d6e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 2607b378-b1bf-4902-a4de-08dc5cf5bb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCjEnlQW2Orzb2qGKvB+1lSuJw6DRZPJY7pZXCgmrtIR/Syyefg+AlQUBvbw3o0LTtB/9igvG3wR5gmKNB3KpqeBz22sRfIhVyWYEKdfJv57LpzyAVItp4uRNFF2BlMWiXavd4By1mGQxFo5udaVC97//pJtYmwthJNPjWXySODlDxKVxraveAuP8dH/nmROByKfSkY39JubuV+KxCBafdNlDog0g2y2Wkkgyuxa+pbaDBO3eBHo9xrF8VgP6afIS8QXZX+tlouRsOTIRRxSKnZE+L53sEyl2PSNjwvFTlQlZGFt3RqzV+cHp7LOfT1vWQTfqIRz5gU8bw61oloL88xDYnubL0/MtuE427xF9QRe1zGKAkcD9KT/jGoWZN7iZxf7/AQD2rMFStUd1iVehjavHczi9A+wzZmLwRylFlbDo3n7G1HVkU+kqFIpwt5kvnm1UJ0xJ0fOHichDy7yQLYRlLA/sJSND5X9eXZAsVw0GUY2rTYo+cZO4mfZHTxBq9ubaUq9HG7v1cJZSF/W+3e/0lrnROMIdQetetP3ptos0IDack8T1sVskdN8wgllaZBZzlGv1bt+CCuMd7HGN8OuQ7D0uFeqLkIOqJ8ezKcsR88k9LgjLKvDV+IXRNaB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brjqnkZAuUUq6ZZmMvyLcDSuRcgCs+F525qG4Ph808l6DKWThzV6HHXh6pbI?=
 =?us-ascii?Q?6jLzVryF6Jq8S31rD4iNJk5Pe0RivhlE2JFTz162elyHUvV2JXRqlHgHW22C?=
 =?us-ascii?Q?8yfMzvgMw8f3cUa8IT77hNQOAdPA1eIPpR+g9ol9Uc0roLHgoOjxeEDHPru+?=
 =?us-ascii?Q?+GlEOLJhSxMJAEKN5FlstzC2BHYF6Cq6pPA8IJlIeZ7Ni5YCTlHtCvvtj4TN?=
 =?us-ascii?Q?Z3QxfLlnC9lyB6mfhg2ZZu+ycel+9WnIxhjNgSfiynZB5vkjIcXnSr0tfRmD?=
 =?us-ascii?Q?7VThgQe73mubM/7MysnDNknyGPPiNKal4hURETPdDSvRtQER5YTZ/n9NafB5?=
 =?us-ascii?Q?LqVA4gDpoxse4QB2KPKETGzKduFShRr1ADHQ+LYSiHTdgrmg6G0FTaDXHEZJ?=
 =?us-ascii?Q?LZXkrkYDdNFIo9LAfUiOFUFRLNxJLC//uMcttSuyPatfTZyhPN1N0gIxBzLv?=
 =?us-ascii?Q?UX9O6mjAkpmZntGYBkCmkL07cFFVqbJtzHFdur3VgyHTy1ayLsTX1ChVVn9Z?=
 =?us-ascii?Q?O9ldCoubPnO9DDiYg8yq7mxDdeLsjlT1ikIkLIhq+R6ElqtJ5auOI/gxkbSu?=
 =?us-ascii?Q?eq1g14qu4oYLcr6QimL9h4Sz8i0+jVFcWRMOI/Q3xu0GtLnbU2WP1LZobxmy?=
 =?us-ascii?Q?afdg6QTzCZoEFvca+HOC53Snt/c8sX5iT0ycJq4LaCkXSV0tuiP+kel2tDEV?=
 =?us-ascii?Q?GXj394TekxpguL9EKHQKqFmdcjeRVNmJmoBkbqoBOYsGfyKicl03SyLbbAWF?=
 =?us-ascii?Q?W/ivR8QhkFhu9fhYYqA0VOa5nAlRGOOO4X37MKrSq5t1y3+dXL7YZNx9SD9c?=
 =?us-ascii?Q?0r1axTKMEnEh7n3UwLSNjhvV7/kW8kMNXz5H0FBArVfGJQxDIvVy7P1tZTUI?=
 =?us-ascii?Q?nC/EIyv5yim59kMek3B+PhP2FPFd9pnBuzdi+i9L3f3ZKQccxMEPb5KUD20j?=
 =?us-ascii?Q?EqTN+TMWOO4yRKrawgG/DQZceGz6OPlTLgYpSeUMJJsG+m9doBVAMDbi9h9U?=
 =?us-ascii?Q?9+CbiZLvpxOv4OhB2cV8TPyxvycO3kfCPLnRFNRQaK0QZk+j9kmUQA1bF5Ld?=
 =?us-ascii?Q?MS54b6441JlYHaAOCy28l1w4MVwr/aFzPB8dBGx4+dkfHE31Hjl0YUm1rC9l?=
 =?us-ascii?Q?dLYCJEf4qiGf10zeWrzkyCa8oZbLjdwceWNWYWqYJ1FtayyTm4hogoRqyzod?=
 =?us-ascii?Q?pgpvBLrV2fGJ0o6+5zYcT8j4TRTSsHfOg8eakHIbx+WXeEia3tjISOYCAC1F?=
 =?us-ascii?Q?2yskkjxziVsnWd99414XeQaMrnu1/Ix0jJF4rFwqpxdMV5Jov62pIQSCqlJ8?=
 =?us-ascii?Q?GiWGGAtvFslKpI4Oyq5oghZlnR9yXIxFW3wJuhYtpbcT3v1tASew4jAUKUoM?=
 =?us-ascii?Q?CFnEj0ydqnIChPuiz0tDJbO01KBkP9awT+rNhZiU4xY+d8bjere9L3aeaSAa?=
 =?us-ascii?Q?vBslHCPiMLw/m7yUemtIN3jagAQjwqsX97KVNRYIRqumvFlI+5A2DYFX5M/O?=
 =?us-ascii?Q?SREQwOp9f2QqiL+ZqYVw4z/M6u0XhtSDcqRX73nEyJ0AxgoyevNOY/wgEF8v?=
 =?us-ascii?Q?2aLsgHvKJX3h++Gv40FbhjHU4wqxf0B0T8iWz7OKLj9jyp3NFBYyJ0SJNZia?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2607b378-b1bf-4902-a4de-08dc5cf5bb1f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:42:45.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv6gWMLVaRjLHnS/qrXFF8ZKmq6P1TZxSpCvTVhT7FAWndyX10nRyTkGWjv8k6/qIrtngAEHxw8SVsI2ea587Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7862
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: ecc70b3e0b318995571df44b14e05ff75aed9c71 ("lib/xarray: introduce a new helper xas_get_order")
https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unstable

in testcase: boot

compiler: gcc-13
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------+------------+------------+
|                                                                     | 24b488a793 | ecc70b3e0b |
+---------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                        | 0          | 18         |
| include/linux/xarray.h:#suspicious_rcu_dereference_check()usage     | 0          | 18         |
| include/linux/xarray.h:#suspicious_rcu_dereference_protected()usage | 0          | 18         |
+---------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404151046.448e2d6e-lkp@intel.com


[    9.238389][    T1] WARNING: suspicious RCU usage
[    9.238967][    T1] 6.9.0-rc2-00175-gecc70b3e0b31 #1 Not tainted
[    9.239710][    T1] -----------------------------
[    9.240287][    T1] include/linux/xarray.h:1200 suspicious rcu_dereference_check() usage!
[    9.241252][    T1]
[    9.241252][    T1] other info that might help us debug this:
[    9.241252][    T1]
[    9.242399][    T1]
[    9.242399][    T1] rcu_scheduler_active = 2, debug_locks = 1
[    9.243291][    T1] no locks held by swapper/1.
[    9.243821][    T1]
[    9.243821][    T1] stack backtrace:
[    9.244507][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.0-rc2-00175-gecc70b3e0b31 #1
[    9.245242][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.245242][    T1] Call Trace:
[ 9.245242][ T1] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1) lib/dump_stack.c:97 (discriminator 1)) 
[ 9.245242][ T1] dump_stack (lib/dump_stack.c:124) 
[ 9.245242][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 9.245242][ T1] xas_start (include/linux/xarray.h:1200 (discriminator 11) include/linux/xarray.h:1198 (discriminator 11) lib/xarray.c:190 (discriminator 11)) 
[ 9.245242][ T1] xas_load (lib/xarray.c:237) 
[ 9.245242][ T1] xas_store (lib/xarray.c:789) 
[ 9.245242][ T1] ? check_xas_get_order+0xab/0xd8 
[ 9.245242][ T1] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 9.245242][ T1] check_xas_get_order+0xbf/0xd8 
[ 9.245242][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 9.245242][ T1] do_one_initcall (init/main.c:1238) 
[ 9.245242][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 9.245242][ T1] ? check_move+0xbe8/0xbe8 
[ 9.245242][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 9.245242][ T1] ? rest_init (init/main.c:1429) 
[ 9.245242][ T1] kernel_init_freeable (init/main.c:1552) 
[ 9.245242][ T1] kernel_init (init/main.c:1439) 
[ 9.245242][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.245242][ T1] ? rest_init (init/main.c:1429) 
[ 9.245242][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.245242][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    9.258425][    T1]
[    9.258700][    T1] =============================
[    9.259264][    T1] WARNING: suspicious RCU usage
[    9.259829][    T1] 6.9.0-rc2-00175-gecc70b3e0b31 #1 Not tainted
[    9.260521][    T1] -----------------------------
[    9.261082][    T1] include/linux/xarray.h:1216 suspicious rcu_dereference_check() usage!
[    9.262017][    T1]
[    9.262017][    T1] other info that might help us debug this:
[    9.262017][    T1]
[    9.263197][    T1]
[    9.263197][    T1] rcu_scheduler_active = 2, debug_locks = 1
[    9.264126][    T1] no locks held by swapper/1.
[    9.264678][    T1]
[    9.264678][    T1] stack backtrace:
[    9.265386][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.0-rc2-00175-gecc70b3e0b31 #1
[    9.266369][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.267564][    T1] Call Trace:
[ 9.267954][ T1] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1) lib/dump_stack.c:97 (discriminator 1)) 
[ 9.268481][ T1] dump_stack (lib/dump_stack.c:124) 
[ 9.268937][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 9.269375][ T1] xas_load (include/linux/xarray.h:1216 (discriminator 11) include/linux/xarray.h:1212 (discriminator 11) lib/xarray.c:206 (discriminator 11) lib/xarray.c:244 (discriminator 11)) 
[ 9.269375][ T1] xas_store (lib/xarray.c:789) 
[ 9.269375][ T1] ? check_xas_get_order+0xab/0xd8 
[ 9.269375][ T1] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 9.269375][ T1] check_xas_get_order+0xbf/0xd8 
[ 9.269375][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 9.269375][ T1] do_one_initcall (init/main.c:1238) 
[ 9.269375][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 9.269375][ T1] ? check_move+0xbe8/0xbe8 
[ 9.269375][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 9.269375][ T1] ? rest_init (init/main.c:1429) 
[ 9.269375][ T1] kernel_init_freeable (init/main.c:1552) 
[ 9.269375][ T1] kernel_init (init/main.c:1439) 
[ 9.269375][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.269375][ T1] ? rest_init (init/main.c:1429) 
[ 9.269375][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.269375][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    9.278798][    T1]
[    9.279064][    T1] =============================
[    9.279608][    T1] WARNING: suspicious RCU usage
[    9.280153][    T1] 6.9.0-rc2-00175-gecc70b3e0b31 #1 Not tainted
[    9.280831][    T1] -----------------------------
[    9.281417][    T1] include/linux/xarray.h:1225 suspicious rcu_dereference_protected() usage!
[    9.282418][    T1]
[    9.282418][    T1] other info that might help us debug this:
[    9.282418][    T1]
[    9.283603][    T1]
[    9.283603][    T1] rcu_scheduler_active = 2, debug_locks = 1
[    9.284523][    T1] no locks held by swapper/1.
[    9.285076][    T1]
[    9.285076][    T1] stack backtrace:
[    9.285746][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.0-rc2-00175-gecc70b3e0b31 #1
[    9.286734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.287903][    T1] Call Trace:
[ 9.288288][ T1] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1) lib/dump_stack.c:97 (discriminator 1)) 
[ 9.288812][ T1] dump_stack (lib/dump_stack.c:124) 
[ 9.289065][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 9.289065][ T1] xas_store (include/linux/xarray.h:1225 (discriminator 7) lib/xarray.c:835 (discriminator 7)) 
[ 9.289065][ T1] check_xas_get_order+0xbf/0xd8 
[ 9.289065][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 9.289065][ T1] do_one_initcall (init/main.c:1238) 
[ 9.289065][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 9.289065][ T1] ? check_move+0xbe8/0xbe8 
[ 9.289065][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 9.289065][ T1] ? rest_init (init/main.c:1429) 
[ 9.289065][ T1] kernel_init_freeable (init/main.c:1552) 
[ 9.289065][ T1] kernel_init (init/main.c:1439) 
[ 9.289065][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.289065][ T1] ? rest_init (init/main.c:1429) 
[ 9.289065][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.289065][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    9.297406][    T1]
[    9.297671][    T1] =============================
[    9.298216][    T1] WARNING: suspicious RCU usage
[    9.298766][    T1] 6.9.0-rc2-00175-gecc70b3e0b31 #1 Not tainted
[    9.299454][    T1] -----------------------------
[    9.300019][    T1] include/linux/xarray.h:1241 suspicious rcu_dereference_protected() usage!
[    9.301031][    T1]
[    9.301031][    T1] other info that might help us debug this:
[    9.301031][    T1]
[    9.302212][    T1]
[    9.302212][    T1] rcu_scheduler_active = 2, debug_locks = 1
[    9.303143][    T1] no locks held by swapper/1.
[    9.303682][    T1]
[    9.303682][    T1] stack backtrace:
[    9.304357][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.0-rc2-00175-gecc70b3e0b31 #1
[    9.305021][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.305021][    T1] Call Trace:
[ 9.305021][ T1] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1) lib/dump_stack.c:97 (discriminator 1)) 
[ 9.305021][ T1] dump_stack (lib/dump_stack.c:124) 
[ 9.305021][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 9.305021][ T1] xas_store (include/linux/xarray.h:1241 (discriminator 7) lib/xarray.c:492 (discriminator 7) lib/xarray.c:759 (discriminator 7) lib/xarray.c:844 (discriminator 7)) 
[ 9.305021][ T1] check_xas_get_order+0xbf/0xd8 
[ 9.305021][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 9.305021][ T1] do_one_initcall (init/main.c:1238) 
[ 9.305021][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 9.305021][ T1] ? check_move+0xbe8/0xbe8 
[ 9.305021][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 9.305021][ T1] ? rest_init (init/main.c:1429) 
[ 9.305021][ T1] kernel_init_freeable (init/main.c:1552) 
[ 9.305021][ T1] kernel_init (init/main.c:1439) 
[ 9.305021][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.305021][ T1] ? rest_init (init/main.c:1429) 
[ 9.305021][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.305021][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   10.414008][    T1] XArray: 6781276 of 6781276 tests passed
[   10.414757][    T1]
[   10.414757][    T1] TEST STARTING
[   10.414757][    T1]
[   94.791459][    T1] maple_tree: 3808238 of 3808238 tests passed
[   94.792303][    T1] test_free_pages: Testing with GFP_KERNEL
[  109.502131][    T1] test_free_pages: Testing with GFP_KERNEL | __GFP_COMP
[  115.289105][    T1] test_free_pages: Test completed
[  115.289894][    T1] ref_tracker: reference already released.
[  115.290608][    T1] ref_tracker: allocated in:
[ 115.291146][ T1] alloctest_ref_tracker_alloc1+0x14/0x18 
[ 115.291955][ T1] test_ref_tracker_init (lib/test_ref_tracker.c:74) 
[ 115.292546][ T1] do_one_initcall (init/main.c:1238) 
[ 115.292922][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 115.292922][ T1] kernel_init_freeable (init/main.c:1552) 
[ 115.292922][ T1] kernel_init (init/main.c:1439) 
[ 115.292922][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 115.292922][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 115.292922][ T1] restore_all_switch_stack (arch/x86/entry/entry_32.S:944) 
[  115.292922][    T1] ref_tracker: freed in:
[ 115.292922][ T1] alloctest_ref_tracker_free+0xf/0x14 
[ 115.292922][ T1] test_ref_tracker_init (lib/test_ref_tracker.c:93 (discriminator 1)) 
[ 115.292922][ T1] do_one_initcall (init/main.c:1238) 
[ 115.292922][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 115.292922][ T1] kernel_init_freeable (init/main.c:1552) 
[ 115.292922][ T1] kernel_init (init/main.c:1439) 
[ 115.292922][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 115.292922][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 115.292922][ T1] restore_all_switch_stack (arch/x86/entry/entry_32.S:944) 
[  115.302044][    T1] ------------[ cut here ]------------
[ 115.302692][ T1] WARNING: CPU: 0 PID: 1 at lib/ref_tracker.c:255 ref_tracker_free (lib/ref_tracker.c:255 (discriminator 1)) 
[  115.303724][    T1] Modules linked in:
[  115.304188][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.0-rc2-00175-gecc70b3e0b31 #1
[  115.305200][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 115.306397][ T1] EIP: ref_tracker_free (lib/ref_tracker.c:255 (discriminator 1)) 
[ 115.307007][ T1] Code: e8 43 54 fc ff eb 96 68 8c dd f0 c1 e8 ef e4 d1 ff 8b 47 0c 5b 85 c0 75 4d 8b 57 10 85 d2 75 31 8b 55 b0 89 f0 e8 4a 9a 4c 00 <0f> 0b b8 ea ff ff ff e9 69 ff ff ff 8d 4e 28 b8 ff ff ff ff 0f c1
All code
========
   0:	e8 43 54 fc ff       	call   0xfffffffffffc5448
   5:	eb 96                	jmp    0xffffffffffffff9d
   7:	68 8c dd f0 c1       	push   $0xffffffffc1f0dd8c
   c:	e8 ef e4 d1 ff       	call   0xffffffffffd1e500
  11:	8b 47 0c             	mov    0xc(%rdi),%eax
  14:	5b                   	pop    %rbx
  15:	85 c0                	test   %eax,%eax
  17:	75 4d                	jne    0x66
  19:	8b 57 10             	mov    0x10(%rdi),%edx
  1c:	85 d2                	test   %edx,%edx
  1e:	75 31                	jne    0x51
  20:	8b 55 b0             	mov    -0x50(%rbp),%edx
  23:	89 f0                	mov    %esi,%eax
  25:	e8 4a 9a 4c 00       	call   0x4c9a74
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
  31:	e9 69 ff ff ff       	jmp    0xffffffffffffff9f
  36:	8d 4e 28             	lea    0x28(%rsi),%ecx
  39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  3e:	0f                   	.byte 0xf
  3f:	c1                   	.byte 0xc1

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
   7:	e9 69 ff ff ff       	jmp    0xffffffffffffff75
   c:	8d 4e 28             	lea    0x28(%rsi),%ecx
   f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  14:	0f                   	.byte 0xf
  15:	c1                   	.byte 0xc1
[  115.309186][    T1] EAX: 091e2aa9 EBX: c1f0dd8c ECX: 00000000 EDX: 00000000
[  115.309982][    T1] ESI: c2dc76c0 EDI: c3787200 EBP: c0209edc ESP: c0209e88
[  115.310795][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
[  115.311659][    T1] CR0: 80050033 CR2: ffbff000 CR3: 024a0000 CR4: 000406b0
[  115.312468][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  115.313308][    T1] DR6: fffe0ff0 DR7: 00000400
[  115.313846][    T1] Call Trace:
[ 115.314236][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 115.314744][ T1] ? ref_tracker_free (lib/ref_tracker.c:255 (discriminator 1)) 
[ 115.315318][ T1] ? __warn (kernel/panic.c:694) 
[ 115.315788][ T1] ? ref_tracker_free (lib/ref_tracker.c:255 (discriminator 1)) 
[ 115.316375][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 115.316886][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 115.317426][ T1] ? handle_bug (arch/x86/kernel/traps.c:218) 
[ 115.317938][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 115.318487][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 115.319063][ T1] ? tcp_net_metrics_exit_batch (net/ipv4/tcp_metrics.c:1032) 
[ 115.319705][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 115.320206][ T1] ? ref_tracker_free (lib/ref_tracker.c:255 (discriminator 1)) 
[ 115.320784][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 115.321327][ T1] ? ref_tracker_free (lib/ref_tracker.c:255 (discriminator 1)) 
[ 115.321902][ T1] ? alloctest_ref_tracker_free+0xf/0x14 
[ 115.322651][ T1] ? test_ref_tracker_init (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 lib/test_ref_tracker.c:99) 
[ 115.323267][ T1] ? do_one_initcall (init/main.c:1238) 
[ 115.323834][ T1] ? do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 115.324359][ T1] ? kernel_init_freeable (init/main.c:1552) 
[ 115.325001][ T1] ? kernel_init (init/main.c:1439) 
[ 115.325523][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 115.326035][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 115.326587][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[ 115.327143][ T1] alloctest_ref_tracker_free+0xf/0x14 
[ 115.327913][ T1] test_ref_tracker_init (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 lib/test_ref_tracker.c:99) 
[ 115.328534][ T1] do_one_initcall (init/main.c:1238) 
[ 115.329118][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 115.329609][ T1] ? maple_tree_seed (lib/test_ref_tracker.c:64) 
[ 115.330189][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 115.330717][ T1] ? rest_init (init/main.c:1429) 
[ 115.331253][ T1] kernel_init_freeable (init/main.c:1552) 
[ 115.331867][ T1] kernel_init (init/main.c:1439) 
[ 115.332370][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 115.332868][ T1] ? rest_init (init/main.c:1429) 
[ 115.333404][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 115.333966][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  115.334513][    T1] irq event stamp: 152972385
[ 115.335040][ T1] hardirqs last enabled at (152972393): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050) 
[ 115.336083][ T1] hardirqs last disabled at (152972400): console_unlock (kernel/printk/printk.c:339 (discriminator 3) kernel/printk/printk.c:2731 (discriminator 3) kernel/printk/printk.c:3050 (discriminator 3)) 
[ 115.337125][ T1] softirqs last enabled at (152972420): __do_softirq (kernel/softirq.c:401 (discriminator 2) kernel/softirq.c:583 (discriminator 2)) 
[ 115.338129][ T1] softirqs last disabled at (152972409): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[  115.339208][    T1] ---[ end trace 0000000000000000 ]---
[  115.339922][    T1] ref_tracker: selftest@(ptrval) has 1/2 users at
[ 115.339922][ T1] test_ref_tracker_timer_func (lib/test_ref_tracker.c:61) 
[ 115.339922][ T1] call_timer_fn (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/timer.h:127 kernel/time/timer.c:1794) 
[ 115.339922][ T1] __run_timers (kernel/time/timer.c:1845 kernel/time/timer.c:2418) 
[ 115.339922][ T1] run_timer_softirq (kernel/time/timer.c:2430 kernel/time/timer.c:2438 kernel/time/timer.c:2448) 
[ 115.339922][ T1] __do_softirq (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[  115.339922][    T1]
[  115.341107][    T1] ref_tracker: selftest@(ptrval) has 1/2 users at
[ 115.341107][ T1] alloctest_ref_tracker_alloc1+0x14/0x18 
[ 115.341107][ T1] test_ref_tracker_init (lib/test_ref_tracker.c:73) 
[ 115.341107][ T1] do_one_initcall (init/main.c:1238) 
[ 115.341107][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 115.341107][ T1] kernel_init_freeable (init/main.c:1552) 
[ 115.341107][ T1] kernel_init (init/main.c:1439) 
[ 115.341107][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 115.341107][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 115.341107][ T1] restore_all_switch_stack (arch/x86/entry/entry_32.S:944) 
[  115.341107][    T1]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240415/202404151046.448e2d6e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


