Return-Path: <linux-fsdevel+bounces-14289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013487A89C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C201C222C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952954205B;
	Wed, 13 Mar 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sh5t83Hn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FA43AAF;
	Wed, 13 Mar 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337333; cv=fail; b=np8WCeeQOMZEoVg0e2IeCYHiR+FxlIBft6DoF19dQpFJQAwtlKnFv7x6sEPNz/ZXrGNet4J6gzjRki3F0kS3UM0VUQhHXPI2Mm8AgyVbHqVRB3pMDECNBjzT+IQ2cu0XAXUSxCCz8p42jHSAqbFjw22bVdHSOOEvVfIwLRwMmy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337333; c=relaxed/simple;
	bh=hhv/AmdAjVR4gQjTbqSacr3QAyHzu7yhivg/skJk/aQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fIrREe/Qpi7ZXbcHjV3a4fYtqmk6mnmDHHVwYCVYVh5vnyIRJJElgkZtLYtNzkrjC7posRpcCTI9XXBQNY+MTgxTq7to+bQjg7ytSk8XQQoiN9f79xnP7bZ5ZOruWtFHCwFaMArGsZwtFpQpP6a++7dfL3GL85Qgz0LUgE/SRR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sh5t83Hn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710337330; x=1741873330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hhv/AmdAjVR4gQjTbqSacr3QAyHzu7yhivg/skJk/aQ=;
  b=Sh5t83HnENf4aRbrkufD0qHULn+me9JWAk2PKNGg30GHCN1ziUvBvk0J
   6Th56wZQ/DdxwcSj7kubXR88thz/4Y1jx9nNgAENEdk9gnzK37qncFirM
   FjQspfNX/gq/jlprCBfZEZk92K6whxhqM98Bir/EOG2kB8fNd1LdjPCdf
   BRoGi6pQB/R6/dJgLsMVyHhPThJwA8yI3P2WH36BJwwOQMlxbPglC4j9g
   QAHR2b5SBhCcaXpDAxudxPHNWXDAV73OHTHdettHYX6Nbe66RGW2qrQ8N
   iTndstQiznleOfDHRu+EtIW4uC0HGwJsyye7wekFIGHbHydwJQrwTS0b8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8043374"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8043374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="42861424"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 06:42:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 06:42:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 06:42:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 06:42:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 06:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nti9xnOBtiAFT+DQyr7VIiM2XqiB2QAbyeahaiUbS45STX9F4nBWyP+UhAx6cFFL+6vtTAdh6sfiru+LFZBYu3TrR9CdOg7vENoK7F11EHsiSDsxOIRZ/j7Zg9hFq/lEHnAWHno784dx5ITz806h5NlyA7NmgTvsQBy8Me1FkQUFQX+CEujg/BKqV3P8mmeL+fx7INbKIT3/D9FRADfSudkRWp148a4Is3tXSb0lDCjlhMG4J/p/10Zq3pG3g8Nffv5etdYClseVrJ2dKMeK9LG3t6heNKs0drJtd3A+WMdoPuSjAT31kJOkRRUObp2C01TkU6sWroB1KHMbSod3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuW8OAslwXFzxeAlh7Q76fgInLP9ioMADH34LzNZ4nY=;
 b=W6BoO/khXZZWCd+M/4rqRrvZ6VIy7G/Gfo3jdK9bbpAL++9+0gepB+ZccJHSCSfatVt3S5s5FUOrL1cqWs/fyj1iY+bpRV1uqAvPWXwaFU16VwkBuD2v1z2u4lQa5C23fUxqFYZ9XwBE4gGV//av4fSbPsRGiR6yCssvf0wthqZ7ltbnnhD9iK1o9lie3c3iDQZJ13Hq/23MgtF1U39JjVduPYtK/a5hzpOteO3A3Y4GKVZXsX2zR66I8eo+fTaCrSw8jr2+eLzYmHXg/h+CLTc2QBZVMnzqZregTx6O5JoO+oipNxW3cv6V6cDX86NWkuTiiz/ayZWEvNDqmxOFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Wed, 13 Mar
 2024 13:42:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 13:42:05 +0000
Date: Wed, 13 Mar 2024 21:41:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, <v9fs@lists.linux.dev>,
	<linux-afs@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [netfs]  c9c4ff12df:
 BUG:KASAN:wild-memory-access_in__fscache_use_cookie
Message-ID: <202403131625.ef8a3315-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d87c9e-bd68-47b8-6e53-08dc43635edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gj3sYT0wWFFceUPS1k/CpEJRiKsemlWc+Hl2m/J3lFpX/2GomYYzlwSsmadFCvl/4fCl1NG7aY390AnI+wsK1DBdOgoua0FlM/ZqNNzgLOPI4eY2Xv0uIioS5eZPm2GxhF2DUatjPv4Qpf0TiX0qAKzRhaggEAATPXLjqVz14KSOqmjXnPcjBP8htgsGXP5L34RpgHiord1MWmVwYgHfihf+q+gGYx/d6tsQDDdfHgYaqYWXNQmtrx201dQCzEtrnFO19E1qYOV3dHnpwAt9oOfHPeNVvWJNuingU6yqNAOkPEfw8iuFKIgyywp94/B6UZblQwH2yB8DV4H9ijcmKrPv0rmzVr1+j1pdIaWZqiuOi9OiM+sFzm+ydfr/kO8uHG0CVm+x+6YJWxcy90m/sLdAuFf8rTmQap46+PeUjC3eqyPVNoc8pJb7LTa7kzVK/4hlZXsdeyuw19qsNdIiqZSCOybPDnMmkWZZ5BGB7gkoQ42NgB7onuiLHrkDQXiEEDIUpuaRUw8Bf2vYcX0X4C4l5rHnR2gd15Oa9c3/2HQq9sJGRFwfSO9A81bme5TjuhFCbCKE2jhHdmbASnNL45Fb3/acRfxaa0sgCxJmpEPTLFRQ82P9OeILk5YS7/oM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vl/ZMHsY95Q2PDmBoZ5kFJBTE1Rl5POQCpABANFDvdW7VAMn5kF6rHrUApie?=
 =?us-ascii?Q?CXQ6X2JIhvvSp/N4h025OhIVHCL0Qp6Stl/Mxggo+FMKdnhbLBIrMyhekK1N?=
 =?us-ascii?Q?MavZoiUPJMLzOR38aLk2XnPOqh3bSxQqfvKWlmf+0VHUreVqrOxH7zDNwhMn?=
 =?us-ascii?Q?/bBdAQbUvNGo5YkrIJiE6COKEL1ZedXEoQu8I6MaXi81VpCatXPcWGA+RmIu?=
 =?us-ascii?Q?5KHxO8DrSOTWFRxrObHJdIjT1BGwULCe32z/GgNwmr8V0GWJNRQeEG/p6OAc?=
 =?us-ascii?Q?kA8Yu0Gb3FNZOJBdBQ6Ggj9CxF/0FgoOb3xP0Cjf95/8XcAenWWuKfBO9klh?=
 =?us-ascii?Q?5i2JJKfaCm1Zb4fWyWIc+QtJF0ivZi2HYeWEg0Y6rpagyl2gsHM6eEqZYBzy?=
 =?us-ascii?Q?lIZuLfQ5Httlkv4UdpIqkx3yh+xwaqWYxBYiGN4xaIy5DQaAxCeCXdjB0Hsw?=
 =?us-ascii?Q?Q8uCV+GhbaoSLHM6PBL9SdDlp9Si2AaVYjB5FXi1yPu9Pf4FG8JRsTEqXDW3?=
 =?us-ascii?Q?Kodaqo8TPGW70gHyyr0c+vvesqkNZqvbU8KnWXswCsXjpfpVzpbl7xS0NU3c?=
 =?us-ascii?Q?X8gK0ZjTwNFx6oqyYBsZT5h3m5QUeipr2FUFCE5vD4XCQs4OC9LVwCezVjNo?=
 =?us-ascii?Q?GsxjcVAOlrELJyNKC/cBeuyEfddHW4bMJkCyyvT5euCGTcTTYMNX6pHYjjCe?=
 =?us-ascii?Q?ZlrX75kYafmatw1DPvHgwXbB0i5SIZ+Gdw7sXLj6oyudKHEUD58APWnvtVIM?=
 =?us-ascii?Q?zKgahGgEsKx32Nj9C07ZLjwxjRDvuIexl4J+ARsbLSe8mMSK2tqfDxsPu+8i?=
 =?us-ascii?Q?ZbNMAdOLSOoW//cGxdswQ/gsnDWl9ssDPhbrv5eglkIwphoMXTH5HjhJZbMj?=
 =?us-ascii?Q?wDiMqkSTL9Ndja52JgsMWX5MRhy4lZ9FqkFJd5j92qkOSzO/S2Ofzx+6Yz3D?=
 =?us-ascii?Q?x1SY3R4TjaV5UYSfclVvkC9LhvXLzXYMlpTXNiBzqTvXxy0BWtcN7L2IluUW?=
 =?us-ascii?Q?C1++PtYwHhusxprrbkv8WQmV8hBS7wnh10tJEtB0/S4uxiRLz+i2Fg2OFIUW?=
 =?us-ascii?Q?oGRYUO6FSzgPmyEOmajkiFhyee7+gnaBAb+BI2MIhRP8qMpAZLoeaG24ctWH?=
 =?us-ascii?Q?PZ9tJ6LAok8/G4gVA/sJ2RUgAM1I7bk+rFMjG6D0osuSOi2+M0JMKGXOhu2Z?=
 =?us-ascii?Q?xGFRnROZ1LN7UiW08Rj5xmUsxFyFuszOC1biFLDsmNE2SAox14m50fzMupGI?=
 =?us-ascii?Q?p5MgI4Kbbug/doqMv0OH+BiK6V8HnGVpaTnhNodPI9Q46A44nVkr9nTVLrZr?=
 =?us-ascii?Q?Y7zxRXss69Im4XGt0BOJ9R6OpQz6MzS6O9VLdiFdxrsaG8/EHo+LlpBcz9T4?=
 =?us-ascii?Q?4C+KQOnB7uiLGzLBBsqpMlfy6Q8c64aKHtzR+QG38y8rd6133uEQmiDDJk+K?=
 =?us-ascii?Q?9kwU5hBdkVVwcNYcLi4MKEQCw90DMotNQ4yjtdDofu5EP5o7mJH+CrIbTZxs?=
 =?us-ascii?Q?T1SHmgy6VzxkFHQPMe/OwWsnoH6gD3TPRJjSSki+V4noSeTXD15+ird8Czoi?=
 =?us-ascii?Q?MLiSXpowcDYE7jE+gzEma20Gohnkr+gqnXxGtQjlpIumAkWBEQ1X6yVbeRx/?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d87c9e-bd68-47b8-6e53-08dc43635edb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:42:05.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+QpWSoGHFHBBfYZ6rLAIpi8Ilm2VJQ4mOXEOVy9UcBb7AR+qJEcxocBvY4L3pABxPu+EZlGXhdoWVJswMrPyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:wild-memory-access_in__fscache_use_cookie" on:

commit: c9c4ff12df110feb1b91951010f673f4b16e49e8 ("netfs: Move pinning-for-writeback from fscache to netfs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 3aaa8ce7a3350d95b241046ae2401103a4384ba2]
[test failed on linux-next/master 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd]

in testcase: xfstests
version: xfstests-x86_64-386c7b6a-1_20240304
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-group-60



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403131625.ef8a3315-oliver.sang@intel.com


[ 188.580903][ T3137] BUG: KASAN: wild-memory-access in __fscache_use_cookie (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/netfs/fscache_cookie.c:577) 
[  188.588776][ T3137] Read of size 8 at addr cccccccccccccd54 by task xfs_io/3137
[  188.596127][ T3137]
[  188.598326][ T3137] CPU: 3 PID: 3137 Comm: xfs_io Tainted: G S                 6.7.0-rc7-00007-gc9c4ff12df11 #1
[  188.608454][ T3137] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  188.616571][ T3137] Call Trace:
[  188.619723][ T3137]  <TASK>
[ 188.622527][ T3137] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 188.626903][ T3137] kasan_report (mm/kasan/report.c:590) 
[ 188.631192][ T3137] ? __fscache_use_cookie (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/netfs/fscache_cookie.c:577) 
[ 188.636349][ T3137] kasan_check_range (mm/kasan/generic.c:181 mm/kasan/generic.c:187) 
[ 188.641069][ T3137] __fscache_use_cookie (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/netfs/fscache_cookie.c:577) 
[ 188.646051][ T3137] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 188.651036][ T3137] ? fscache_cookie_worker (fs/netfs/fscache_cookie.c:570) 
[ 188.656367][ T3137] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 188.661262][ T3137] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 188.665810][ T3137] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 188.670790][ T3137] ? wb_wakeup_delayed (include/linux/spinlock.h:401 mm/backing-dev.c:397) 
[ 188.675600][ T3137] netfs_dirty_folio (include/linux/fscache.h:273 fs/netfs/misc.c:45) 
[ 188.680409][ T3137] cifs_write_end (fs/smb/client/file.c:3091) cifs
[ 188.685652][ T3137] ? cifs_write (fs/smb/client/file.c:3045) cifs
[ 188.690724][ T3137] ? cifs_readpage_worker (fs/smb/client/file.c:4764) cifs
[ 188.696664][ T3137] ? is_valid_gup_args (mm/gup.c:1979) 
[ 188.701662][ T3137] ? inode_owner_or_capable (fs/inode.c:2499) 
[ 188.707093][ T3137] ? cap_task_fix_setuid (security/commoncap.c:1142) 
[ 188.712165][ T3137] generic_perform_write (mm/filemap.c:3929) 
[ 188.717323][ T3137] ? folio_add_wait_queue (mm/filemap.c:3882) 
[ 188.722565][ T3137] ? file_update_time (fs/inode.c:2170) 
[ 188.727373][ T3137] cifs_strict_writev (fs/smb/client/file.c:3730 fs/smb/client/file.c:3760) cifs
[ 188.732941][ T3137] vfs_write (include/linux/fs.h:2020 fs/read_write.c:491 fs/read_write.c:584) 
[ 188.737054][ T3137] ? kernel_write (fs/read_write.c:565) 
[ 188.741600][ T3137] ? __get_file_rcu (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2569 include/linux/atomic/atomic-arch-fallback.h:4529 include/linux/atomic/atomic-arch-fallback.h:4558 include/linux/atomic/atomic-arch-fallback.h:4578 include/linux/atomic/atomic-long.h:1731 include/linux/atomic/atomic-instrumented.h:4654 fs/file.c:869) 
[ 188.746148][ T3137] ? __fget_light (fs/file.c:1140) 
[ 188.750708][ T3137] __x64_sys_pwrite64 (fs/read_write.c:699 fs/read_write.c:709 fs/read_write.c:706 fs/read_write.c:706) 
[ 188.755602][ T3137] ? vfs_write (fs/read_write.c:706) 
[ 188.759887][ T3137] ? do_user_addr_fault (include/linux/rcupdate.h:779 include/linux/mm.h:688 arch/x86/mm/fault.c:1366) 
[ 188.764959][ T3137] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 188.769245][ T3137] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  188.775012][ T3137] RIP: 0033:0x7f7f3ffd43b7
[ 188.779296][ T3137] Code: 08 89 3c 24 48 89 4c 24 18 e8 05 f4 f8 ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 55 f4 f8 ff 48 8b
All code
========
   0:	08 89 3c 24 48 89    	or     %cl,-0x76b7dbc4(%rcx)
   6:	4c 24 18             	rex.WR and $0x18,%al
   9:	e8 05 f4 f8 ff       	callq  0xfffffffffff8f413
   e:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
  13:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  18:	41 89 c0             	mov    %eax,%r8d
  1b:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  20:	8b 3c 24             	mov    (%rsp),%edi
  23:	b8 12 00 00 00       	mov    $0x12,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 31                	ja     0x63
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 04 24          	mov    %rax,(%rsp)
  39:	e8 55 f4 f8 ff       	callq  0xfffffffffff8f493
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 31                	ja     0x39
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 04 24          	mov    %rax,(%rsp)
   f:	e8 55 f4 f8 ff       	callq  0xfffffffffff8f469
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
[  188.798823][ T3137] RSP: 002b:00007ffcffb5da70 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
[  188.807116][ T3137] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f3ffd43b7
[  188.814977][ T3137] RDX: 0000000000001000 RSI: 00005644520fa000 RDI: 0000000000000004
[  188.822846][ T3137] RBP: 0000000000000000 R08: 0000000000000000 R09: 00005644520f9f80
[  188.830716][ T3137] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  188.838583][ T3137] R13: 0000000000001000 R14: 0000000000001000 R15: 00000000ffffffff
[  188.846449][ T3137]  </TASK>
[  188.849338][ T3137] ==================================================================
[  188.857341][ T3137] Disabling lock debugging due to kernel taint
[  188.863392][ T3137] general protection fault, probably for non-canonical address 0xf9999599999999aa: 0000 [#1] PREEMPT SMP KASAN PTI
[  188.875344][ T3137] KASAN: maybe wild-memory-access in range [0xcccccccccccccd50-0xcccccccccccccd57]
[  188.884508][ T3137] CPU: 3 PID: 3137 Comm: xfs_io Tainted: G S  B              6.7.0-rc7-00007-gc9c4ff12df11 #1
[  188.894630][ T3137] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[ 188.902765][ T3137] RIP: 0010:__fscache_use_cookie (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/netfs/fscache_cookie.c:577) 
[ 188.908533][ T3137] Code: f1 f1 f1 f1 c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 e0 00 00 00 31 c0 e8 4a 41 cf ff 4c 89 e8 48 c1 e8 03 <80> 3c 28 00 0f 85 67 07 00 00 49 8b 87 88 00 00 00 83 e0 01 88 44
All code
========
   0:	f1                   	icebp  
   1:	f1                   	icebp  
   2:	f1                   	icebp  
   3:	f1                   	icebp  
   4:	c7 40 0c f3 f3 f3 f3 	movl   $0xf3f3f3f3,0xc(%rax)
   b:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
  12:	00 00 
  14:	48 89 84 24 e0 00 00 	mov    %rax,0xe0(%rsp)
  1b:	00 
  1c:	31 c0                	xor    %eax,%eax
  1e:	e8 4a 41 cf ff       	callq  0xffffffffffcf416d
  23:	4c 89 e8             	mov    %r13,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)		<-- trapping instruction
  2e:	0f 85 67 07 00 00    	jne    0x79b
  34:	49 8b 87 88 00 00 00 	mov    0x88(%r15),%rax
  3b:	83 e0 01             	and    $0x1,%eax
  3e:	88                   	.byte 0x88
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   4:	0f 85 67 07 00 00    	jne    0x771
   a:	49 8b 87 88 00 00 00 	mov    0x88(%r15),%rax
  11:	83 e0 01             	and    $0x1,%eax
  14:	88                   	.byte 0x88
  15:	44                   	rex.R


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240313/202403131625.ef8a3315-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


