Return-Path: <linux-fsdevel+bounces-16247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B4689A8A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3240282BCD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 03:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE31798F;
	Sat,  6 Apr 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVSCryqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39E107B3;
	Sat,  6 Apr 2024 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712373957; cv=fail; b=UR3e2/kjcA35IuiHQXLbiqWLJtLXBjWGPMhQuEE2sIglMO7QxMjnGdNl196LumHf2Vm73LArS6gbZToiGguDjRJc3McX6N1ouSOESTzJXLaaOZ1HW9sEPeGl6xiomvLOMokiwOOxR/as2VG3bXGOocae67X3+PMI3KxazYRtVWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712373957; c=relaxed/simple;
	bh=oU1xbXgAMZa3qirPexkBv4LYJUpaUek7ax6BVVhqAXA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OSh7KmIkCDu+ZBGZMrUZR5HnaLJbu/0z3UtcM4JDKT7ozNv0EJlgFaI3yYVDbMyLGDc4oP+khzJakUPrV7WV4XlbZPwGPhvFxotonhtYXiWaYzDSmiFd2rutF28DzCVRlWNwjs0gxfvsTBEYXWuZo7ogEhy50oNxiF8Sx3RC1b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVSCryqd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712373955; x=1743909955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oU1xbXgAMZa3qirPexkBv4LYJUpaUek7ax6BVVhqAXA=;
  b=LVSCryqdzDvIfCSjRtqgeO6DzyQ/xeNEBY++P+Btev92/4E7T5Z7m0U9
   U3g2VdHiWTgJbu4mvmXLWS294z2qZYIFl/7iWVoJvHLE6OOXxHCNicrl3
   WO/m05Zy0/36l1nnPnSq8hACrAZItSqC4rGlLWVype6EXwYhpshuOkopK
   +X6KY0ZKjwmL+W18/DkRwNW68xjhE4LVx9syIOKY8KbWnMgjyFXL5QVmh
   XN1qxp+JMlFX7moXW2lEjuEJvJZ3AqRFRVVzDFgbG+Q7GignJQgTTWX2y
   N5ImfnlyBYxR+lWmZAZOaE47UrlwZ0JvFD8cHtzUXiVDvSPaxjimGK6Kf
   w==;
X-CSE-ConnectionGUID: VQRUuZRBRwiRK3q9rwhbcQ==
X-CSE-MsgGUID: LiVDw5bzQsuvaJxwDdDLzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7949325"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7949325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 20:25:54 -0700
X-CSE-ConnectionGUID: oi0xzVRoRW2EpyGP+yISig==
X-CSE-MsgGUID: RdKmaZ7gQOWMpQLa7GmW7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23833273"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 20:25:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 20:25:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 20:25:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 20:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnNNz4l5WN33qgqWmZKrP7baK9LKFFPHA3FnTKfY0B45ALh+9a9DfKk/WxwSmjmVL1+v4hFvzg0jsovLR0wzvAhJMl/JsqgRxJGk1nqL/W2gPqGsjOfvt8ANkWLAVzmF/fNmeWlZYmYpdWtmgSuAa1dRFIkwq/XrUIFyeGlJLrIAg7J7InMTCqYCaD/urdIIBJ/50M2va3HBKlLDAbaHMfNRqYuwY1SXNBhpMT+HhWedmlUDgM0SzqVpJt29Svwk/amBELTZmRWCZx1/b0w0Hw+/jIy6ArtKv93eeemSWTHkgFD6nGfiuQLg3EAOUbGPp8ElcZp/sAdCqbnAGNkgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG+065KyDOk8K2qC2U2taBTUWZGbHDkTZYxYSd/M/i8=;
 b=Q4f2xSVnOAYjEAfz4J9cGCFNGp9RnNqqHqWZoPHeHKAGJXPvrlZas+IHgh+2sefgDujqZvEbBi1mYq+2QW/2hpLWGfEqVQPW7G38Z+iqUSkuWPYWYbA8Nvbues+IVEo5u7ZPZYHeZ8ItsFUBDLv20s2k5ysTwlFdEbAjISEoS0zjdKdvM77IrPZxTUmnndkjW0dT3p+D2eXKapFw0Npn+uo559xmBaFeb/SiMPRkA0QjYpXiFeWdImpclBFsTrwPR7vNPNC0mo8PpHaDVc2pTSFG6FttDggkKQHcU9pEbQq3diV6cVneDww7edgfVLpSBEcL4W4FSXczhHofQr5S8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sat, 6 Apr
 2024 03:25:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Sat, 6 Apr 2024
 03:25:50 +0000
Date: Sat, 6 Apr 2024 11:25:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kairui Song <kasong@tencent.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox" <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [lib/xarray]  5053ab0c89:
 WARNING:suspicious_RCU_usage
Message-ID: <202404061058.f2256e40-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQbi1fnAwgb25f/1vDBiOhQyGG6lTvwfu1XKLURxtYrYZ1yU2pCOTJBuKiz2Q5xhc8xvSi1ldng1vAcYwfRagwrs+thpuhdCrrKtwyNRRooAdb3WqWBJT7U06tJ8jPJ1osJDOHNFzDxgAZkFDZs9St9PsYQ2k/sUwDSbSWLETK6eHHpiHh/YC+qOWYdyOwZSorrGWu3Ru0PTEgrJoNanJLwrHfbFAovTy11uAay2X9WsKOiyCkZ2+7J37pQQ9KXAmltqO9z6QiXrUsyv1hCK5tAnrthaed+jgplJvPyUfd4MtaoBV5phhqwFkGanVmv/7sAsaR82qKMc+EGfboBw8MPNBkilUQa7gskKZXclI0GMvOfA/wVV3NxZkdrFzz/13Jnj5YiaYxKtoycfAd0zpGsHYbvoYXkQAgg8UCWESMuPRscRWehz+4ZHQz/A6yjzqGKDk9G0uQX+3dnTKO7cJ+iqcqMtX7sQXXkxmbBvwjUBra9ArcN7wzeq+SWXJxk1KGoPuSi/NtriUaESONX7FUWmQUx0Aemj3/x1bfJdog8brTDxk4LSIOj+aFx11ynYxP8Kei0ByH0/1kvOGP+WMgiif6A7uroJWVIpEoTLcfbgtVgjHctbjbvSUXQgC+dP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DbZQBmbPpeHU9bVw+SIseXjIWofnOfLVd21G61pwtbDjgo6cuCNjs0YTIxk?=
 =?us-ascii?Q?v79WHsObsLI9bVKajUGnzkFz7pFqaFW3mjVxEl0grDWViqqaV2RQVHS12Jj4?=
 =?us-ascii?Q?0cmeELlO3xAB4yTRjavHImR2CRT50eN94KwJGYVMigJcZ/G6nfAOysxJQCQF?=
 =?us-ascii?Q?5dIku1crd8KKYiVeJ+mUiSW8y0NYb5CT36iM7Ni3fA6TvaHdkTllPo4g8QYb?=
 =?us-ascii?Q?cTFjgD1qUmwQ9bnVnXjLDx40XG0qPxJWa5JXZ+GBsMbj7OCmMnzG5pIlWlyk?=
 =?us-ascii?Q?FIFtBW/tSgf1Lm8Ikz+F5IGpWr0yItFVXwc2f8gSyMIY8sBM6i47CnKTBsm+?=
 =?us-ascii?Q?U5vBO6nvOorHfxoebCPJhUsvi4A/4LoAYmcALqjcTkoyhXe8PRu8xCv6+LS0?=
 =?us-ascii?Q?FW7K9dHtJrYjROoo/REhRzbf0A6F9f3dSB49HGcpSs/jIc/wEmtUwMtSNIl6?=
 =?us-ascii?Q?ek8Oyayv3p11vri71qY8q7kbAg78Zymjr0nRAgOqYuG43/T+xKnXkc96HurL?=
 =?us-ascii?Q?6UzzxA8Dan49jheyS7y55Evh7Jgl7og4tp052kP/GzetJgc71aonkxh4gomk?=
 =?us-ascii?Q?m1Kln5c+bIWgxLT9zdCtF7IvXffjqpZqI1q3aRxrQ2188FFk0+E4x9SVT18G?=
 =?us-ascii?Q?6RKqxTr6drPcbnsbvgD/5Ntj2uCjiWdRj1+CoaSvVqLhPauPz4F+1xlattQ+?=
 =?us-ascii?Q?XVvxbE8OmCWc3GxRgnWdk4gcSTmz554Vu41VxwgEfw2OSyNTRaQyy+islPt2?=
 =?us-ascii?Q?yNZcx3fXKdAKj2/oFObGiGCixF5bJIbtK5aSrOZJ0sbnBW+lCM2t3JFx9KvY?=
 =?us-ascii?Q?aTMUqz9DnaRn33eaH0oMCXFV4wD1wOkDIBlqVTR7MYaCZ/mVHyLMEU5qEuAs?=
 =?us-ascii?Q?AyD/W7qF+yGAONaFrJQebZvoqGmkaGt+GH+V6BVLYhfzlMRKG6m1Ow20FHtf?=
 =?us-ascii?Q?44Xdy/il0Z0XPBE2Emk8WqrtEC1jBJb50OswlOJA3PrK0cLtCwBfLKX7ZhCj?=
 =?us-ascii?Q?oQOiTDgmzrPzbg81g0js70uI+frQcZVY00eFEDrNvA6pbEjib38Eo6A+ChHo?=
 =?us-ascii?Q?eTrui//AP/YSAYaCWyRCYt2P2a87UJHVRPTo3eMxPUhH0+WZQVGDYNmgkbQI?=
 =?us-ascii?Q?oYS6jsgkzLoxngp1fbN37slyER/H+vyGx2MA1/AEBooizfGBe1MztuLshxwD?=
 =?us-ascii?Q?HHOagDl0dmR4w2GhaPacStKvorztmh9Gl7qEdN1GrpLwmX4lYzD7FJsm8hVR?=
 =?us-ascii?Q?Ke96L/L3FcNOzYqCex79w3UoKJQ10Y+ykNrfncnDtXZPRPdELJW+ZiMkW/EB?=
 =?us-ascii?Q?t65/Upp4eDTFfL1gdhic1yYwldOLLsCMQLAkdIdwqCGPIt+zdmSsLjtGi3ex?=
 =?us-ascii?Q?FLimzkRVaddLC9nVRa9Lrp5HmTHAMoeLvPwFz0IaU3Gfb6lluSqk/bZTz2he?=
 =?us-ascii?Q?Il361QNjaic5S+oDNFgsaMwOfgoZsKAR0HH5FnBR4J86LPGQX8gTx1DJlFzi?=
 =?us-ascii?Q?IGFWGvO8l+JE/dm89b34o90AtzaXsyLHwMf7ExllW5X7MoiCnaEagHUKUsne?=
 =?us-ascii?Q?xoezbsWors2BBqIY4oKmqU9ZzJrq28MfKakzYatF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 231b567d-c9a2-42ec-248c-08dc55e94224
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 03:25:50.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTzFEL/V+TJiyQZC8wLTgPVVY7xTOSTlGjzuNyQMB25BRsR2/onsRLPoD2spOBJm/JXUXdUlAAZ9AMyGtV25nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 5053ab0c89ee4ba827db6a4453af277321cb1a2e ("lib/xarray: introduce a new helper xas_get_order")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 8568bb2ccc278f344e6ac44af6ed010a90aa88dc]

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------+------------+------------+
|                                                                     | cc93de5055 | 5053ab0c89 |
+---------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                        | 0          | 6          |
| include/linux/xarray.h:#suspicious_rcu_dereference_check()usage     | 0          | 6          |
| include/linux/xarray.h:#suspicious_rcu_dereference_protected()usage | 0          | 6          |
+---------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404061058.f2256e40-lkp@intel.com


[  242.400377][    T1] WARNING: suspicious RCU usage
[  242.401381][    T1] 6.9.0-rc2-00150-g5053ab0c89ee #1 Tainted: G        W        N
[  242.402989][    T1] -----------------------------
[  242.404031][    T1] include/linux/xarray.h:1201 suspicious rcu_dereference_check() usage!
[  242.405805][    T1]
[  242.405805][    T1] other info that might help us debug this:
[  242.405805][    T1]
[  242.407877][    T1]
[  242.407877][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  242.409774][    T1] no locks held by swapper/0/1.
[  242.410827][    T1]
[  242.410827][    T1] stack backtrace:
[  242.412091][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.9.0-rc2-00150-g5053ab0c89ee #1
[  242.413055][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  242.413055][    T1] Call Trace:
[  242.413055][    T1]  <TASK>
[ 242.413055][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 242.413055][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 242.413055][ T1] xas_start (include/linux/xarray.h:?) 
[ 242.413055][ T1] xas_store (lib/xarray.c:237 lib/xarray.c:789) 
[ 242.413055][ T1] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23) 
[ 242.413055][ T1] ? xas_load (lib/xarray.c:237) 
[ 242.413055][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 242.413055][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 242.413055][ T1] do_one_initcall (init/main.c:1238) 
[ 242.413055][ T1] ? __cfi_xarray_checks (lib/test_xarray.c:2054) 
[ 242.413055][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 242.413055][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 242.413055][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.413055][ T1] ? __kmalloc_noprof (include/linux/kasan.h:211 mm/slub.c:4186 mm/slub.c:4199) 
[ 242.413055][ T1] ? do_initcalls (init/main.c:1310) 
[ 242.432382][ T1] ? kernel_init_freeable (init/main.c:1552) 
[ 242.432382][ T1] ? kernel_init (init/main.c:1439) 
[ 242.432382][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.432382][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[ 242.432382][ T1] ? parameq (kernel/params.c:81) 
[ 242.432382][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 242.432382][ T1] ? __cfi_ignore_unknown_bootoption (init/main.c:1285) 
[ 242.432382][ T1] ? parse_args (kernel/params.c:?) 
[ 242.432382][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.432382][ T1] do_initcall_level (init/main.c:1299) 
[ 242.432382][ T1] do_initcalls (init/main.c:1313) 
[ 242.432382][ T1] kernel_init_freeable (init/main.c:1552) 
[ 242.432382][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.432382][ T1] kernel_init (init/main.c:1439) 
[ 242.432382][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.432382][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.432382][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.432382][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[  242.432382][    T1]  </TASK>
[  242.451896][    T1]
[  242.452554][    T1] =============================
[  242.453552][    T1] WARNING: suspicious RCU usage
[  242.454581][    T1] 6.9.0-rc2-00150-g5053ab0c89ee #1 Tainted: G        W        N
[  242.456217][    T1] -----------------------------
[  242.457261][    T1] include/linux/xarray.h:1217 suspicious rcu_dereference_check() usage!
[  242.458920][    T1]
[  242.458920][    T1] other info that might help us debug this:
[  242.458920][    T1]
[  242.461156][    T1]
[  242.461156][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  242.462797][    T1] no locks held by swapper/0/1.
[  242.463791][    T1]
[  242.463791][    T1] stack backtrace:
[  242.465126][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.9.0-rc2-00150-g5053ab0c89ee #1
[  242.467116][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  242.468617][    T1] Call Trace:
[  242.468617][    T1]  <TASK>
[ 242.468617][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 242.468617][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 242.468617][ T1] xas_descend (include/linux/xarray.h:?) 
[ 242.468617][ T1] xas_store (lib/xarray.c:244 lib/xarray.c:789) 
[ 242.468617][ T1] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23) 
[ 242.468617][ T1] ? xas_load (lib/xarray.c:244) 
[ 242.468617][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 242.468617][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 242.468617][ T1] do_one_initcall (init/main.c:1238) 
[ 242.468617][ T1] ? __cfi_xarray_checks (lib/test_xarray.c:2054) 
[ 242.468617][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 242.468617][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 242.468617][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.468617][ T1] ? __kmalloc_noprof (include/linux/kasan.h:211 mm/slub.c:4186 mm/slub.c:4199) 
[ 242.468617][ T1] ? do_initcalls (init/main.c:1310) 
[ 242.468617][ T1] ? kernel_init_freeable (init/main.c:1552) 
[ 242.468617][ T1] ? kernel_init (init/main.c:1439) 
[ 242.468617][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.488373][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[ 242.488373][ T1] ? parameq (kernel/params.c:81) 
[ 242.488373][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 242.488373][ T1] ? __cfi_ignore_unknown_bootoption (init/main.c:1285) 
[ 242.488373][ T1] ? parse_args (kernel/params.c:?) 
[ 242.488373][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.488373][ T1] do_initcall_level (init/main.c:1299) 
[ 242.488373][ T1] do_initcalls (init/main.c:1313) 
[ 242.488373][ T1] kernel_init_freeable (init/main.c:1552) 
[ 242.488373][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.488373][ T1] kernel_init (init/main.c:1439) 
[ 242.488373][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.488373][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.488373][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.488373][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[  242.488373][    T1]  </TASK>
[  242.505758][    T1]
[  242.506807][    T1] =============================
[  242.507842][    T1] WARNING: suspicious RCU usage
[  242.508960][    T1] 6.9.0-rc2-00150-g5053ab0c89ee #1 Tainted: G        W        N
[  242.510512][    T1] -----------------------------
[  242.511564][    T1] include/linux/xarray.h:1226 suspicious rcu_dereference_protected() usage!
[  242.513461][    T1]
[  242.513461][    T1] other info that might help us debug this:
[  242.513461][    T1]
[  242.515528][    T1]
[  242.515528][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  242.517330][    T1] no locks held by swapper/0/1.
[  242.518364][    T1]
[  242.518364][    T1] stack backtrace:
[  242.519666][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.9.0-rc2-00150-g5053ab0c89ee #1
[  242.520702][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  242.520702][    T1] Call Trace:
[  242.520702][    T1]  <TASK>
[ 242.520702][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 242.520702][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 242.520702][ T1] xas_store (include/linux/xarray.h:?) 
[ 242.520702][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 242.520702][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 242.520702][ T1] do_one_initcall (init/main.c:1238) 
[ 242.520702][ T1] ? __cfi_xarray_checks (lib/test_xarray.c:2054) 
[ 242.520702][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 242.520702][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 242.520702][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.520702][ T1] ? __kmalloc_noprof (include/linux/kasan.h:211 mm/slub.c:4186 mm/slub.c:4199) 
[ 242.520702][ T1] ? do_initcalls (init/main.c:1310) 
[ 242.520702][ T1] ? kernel_init_freeable (init/main.c:1552) 
[ 242.520702][ T1] ? kernel_init (init/main.c:1439) 
[ 242.520702][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.520702][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[ 242.520702][ T1] ? parameq (kernel/params.c:81) 
[ 242.520702][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 242.520702][ T1] ? __cfi_ignore_unknown_bootoption (init/main.c:1285) 
[ 242.520702][ T1] ? parse_args (kernel/params.c:?) 
[ 242.520702][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.520702][ T1] do_initcall_level (init/main.c:1299) 
[ 242.520702][ T1] do_initcalls (init/main.c:1313) 
[ 242.520702][ T1] kernel_init_freeable (init/main.c:1552) 
[ 242.520702][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.520702][ T1] kernel_init (init/main.c:1439) 
[ 242.520702][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.520702][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.520702][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.520702][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[  242.520702][    T1]  </TASK>
[  242.560253][    T1]
[  242.560872][    T1] =============================
[  242.561861][    T1] WARNING: suspicious RCU usage
[  242.562854][    T1] 6.9.0-rc2-00150-g5053ab0c89ee #1 Tainted: G        W        N
[  242.564501][    T1] -----------------------------
[  242.565558][    T1] include/linux/xarray.h:1242 suspicious rcu_dereference_protected() usage!
[  242.567300][    T1]
[  242.567300][    T1] other info that might help us debug this:
[  242.567300][    T1]
[  242.569488][    T1]
[  242.569488][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  242.571117][    T1] no locks held by swapper/0/1.
[  242.572108][    T1]
[  242.572108][    T1] stack backtrace:
[  242.573465][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.9.0-rc2-00150-g5053ab0c89ee #1
[  242.575431][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  242.576938][    T1] Call Trace:
[  242.576938][    T1]  <TASK>
[ 242.576938][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 242.576938][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 242.576938][ T1] xas_store (include/linux/xarray.h:?) 
[ 242.576938][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 242.576938][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 242.576938][ T1] do_one_initcall (init/main.c:1238) 
[ 242.576938][ T1] ? __cfi_xarray_checks (lib/test_xarray.c:2054) 
[ 242.576938][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 242.576938][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 242.576938][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.576938][ T1] ? __kmalloc_noprof (include/linux/kasan.h:211 mm/slub.c:4186 mm/slub.c:4199) 
[ 242.576938][ T1] ? do_initcalls (init/main.c:1310) 
[ 242.576938][ T1] ? kernel_init_freeable (init/main.c:1552) 
[ 242.576938][ T1] ? kernel_init (init/main.c:1439) 
[ 242.576938][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.576938][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[ 242.576938][ T1] ? parameq (kernel/params.c:81) 
[ 242.576938][ T1] ? parameq (include/linux/fortify-string.h:250 kernel/params.c:99) 
[ 242.576938][ T1] ? __cfi_ignore_unknown_bootoption (init/main.c:1285) 
[ 242.576938][ T1] ? parse_args (kernel/params.c:?) 
[ 242.576938][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 242.576938][ T1] do_initcall_level (init/main.c:1299) 
[ 242.576938][ T1] do_initcalls (init/main.c:1313) 
[ 242.576938][ T1] kernel_init_freeable (init/main.c:1552) 
[ 242.576938][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.576938][ T1] kernel_init (init/main.c:1439) 
[ 242.576938][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.576938][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 242.576938][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 242.576938][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[  242.576938][    T1]  </TASK>
[  260.158718][    T1] XArray: 158742827 of 158742827 tests passed
[  260.160114][    T1]
[  260.160114][    T1] TEST STARTING
[  260.160114][    T1]
BUG: kernel hang in boot stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240406/202404061058.f2256e40-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


