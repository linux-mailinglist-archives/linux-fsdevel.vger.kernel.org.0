Return-Path: <linux-fsdevel+bounces-15847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A4894AAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 06:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CD0B23B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 04:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC717C9B;
	Tue,  2 Apr 2024 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETrrinmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1A17C6A;
	Tue,  2 Apr 2024 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033729; cv=fail; b=VfN/ob1IPUxIlLmd6jYwNLVYy9WZn022KwGQr7BByGi+YdpwXKZxOjf50sHyuHWdrrIOFJ3JyS5jmXpjKTZZcc4UdP6MXkK5RCcIOiidKLvtLTHN6d6t5J1qPjk+NEuL9mTiMTrKJWg5EysQqLGtC8j9LOAnQmIxGc9wgDuwm3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033729; c=relaxed/simple;
	bh=PqJAW9GvI8S1Add2UuCAZnDrxjC4XCzKcuCEyACzBLE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YHnhpYIR5rEvNi6k8wODbu9ivxGGt9KV3OaJwpDp/sUxvVVlx0skxDCzAJ5IBYa/fknjCYCQNbcztqUUKVF9DwHNaPfTbnI7i15c+SAGXke/FoyIZH2gzARGFT6LSsFg4PtWNwwxD8dkRUElcQCoAMUlCO+X1WTuJbecnF7anZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETrrinmP; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712033726; x=1743569726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PqJAW9GvI8S1Add2UuCAZnDrxjC4XCzKcuCEyACzBLE=;
  b=ETrrinmPGzKSFZPU+UDuMi2OoJpLtVQIN3U9Pf7FfhCZZt6sYQiEsMEN
   lZb0IVEXW56A7b3F+hUpi/d0WkdUI5EgE13ChK0c56NPrNqjryE0KruBB
   jcDPZebWDG7LMwl+OK3nGRhXp3j4KYbytp4UJRbZSap0VnLVU8iUje0hL
   NYJovtPIPpySLgETAz2qIKMdLvJhDOFd3HWQ3eRjA+D761q0ZYsSbiFTu
   Qizxq8g/RqCg+pDDuivjN1+RYph+ZPSPa7PvK/JfWg29u5sp9spDWUyxe
   VLsSqfcq/DV77u64AFOEw5LTT1/hYS8q5zSfCUuAzb5Nqthrkz+CcHBNp
   Q==;
X-CSE-ConnectionGUID: zsw5NMNSQkuortpNBlmvPQ==
X-CSE-MsgGUID: H+OP5osxTyGYyg/mbIAgRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18632690"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18632690"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 21:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17846074"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 21:55:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:55:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 21:55:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 21:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtmRWJmlwLIrhmOjGQvasMxC+IPI0IYaHioUJhBYdbiPZikCFPDpKT3slxRqsmGQCiCTCfM9rNT3bhD5UurmaG9OFWX68tH5kl4avV1j1fMs0igiapCxsdQJYlwubC/e0MdrESuBjQYxNEUdfXDEygpK+XcRfY5aSRS7gl+7NdIhxORhWif5wBGKbYjN+hhe7LACilT0slw+nygzYL2i+Dw1WY4Bz7JsAwuRvA1PJ9E/ZBtXqElVhhxvVwK9wfWxYw/+TpxBD58BznedmcJkTJ4qTio9h0D1LDf9Tc2kROIio7PsPUBx6iUHaEDUnixyQmRZdLj/1jR0EBw0pBJ25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd+g9/AgC5TrCtMaXIpU0whXedTHehghdoTSE8tphyI=;
 b=VcXnjSKl6+qbUvO00Mh6TGfzPj0OATfsvt91YKVwde1OlhUxvm2F0EG3jD9RbPY4z94Gr8buC8zvtlA5B3t42E1v9zMDJgMhxiE8NSBn9ZwpckRIjzr6GtB2l5u5gBs1RyQ74N8tSAWYosuXwxgNltTMsAaz4jLIdkE6MUYyTf48XACF2FB8ZTksRSE4AFTpfc+wpBsWObw0NQf/XNuSGvg0lGTsOctidOC4NgfTHNM0qF7jCWOIsZ80T/cskoHrwslXNIGBUiar3Z09R0P1Zh55fLqMV394spfRGYj1qqBLSLT54ie+h1kcR4Ka9n5tPcczQzaZ700Gidjvb59phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 04:55:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 04:55:21 +0000
Date: Tue, 2 Apr 2024 12:55:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kairui Song <kasong@tencent.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox" <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [lib/xarray]  e6c71d0899:
 WARNING:suspicious_RCU_usage
Message-ID: <202404021026.f28e44bb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB7153:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aS2lay9s//JPFtIF2v/0rO6dmpzfaO5iRt1O3UrkAD3G4nRV/lZFchmSr1/WHPPAjfEyh+zogH+iujj0o4fOmNq2KVvjQ7glN7yYDkOhPIDwgK3M1/Y8Q6/+lVusnmZOTbKKqMLqHvtptWO9Ac095hXdSBbeANau8jaqq2L/n1rLQ6SFaK3SaK0k5/yru6CUrmDKrfgIvLCbTJmgqpwmwfPZOsO2bydNh9dgmD10uP0BGjqxGcL+xvV4LFRN2F7HUcC79PpYweniRsN37D19QV4e3sx/waiLQ/YwWVcwdHC7h34eq0PbnvjfXyuNVWQuKXbLNIjB2QwUDA367mx2+lRRGPJpa0vXFGr+xsOg6Rm17k0mnGLkjOR6/QAnr/aycq67JXNaAVPw7SHUFvzRxrWwwh0NKvvy5qECVzVZ/3ksRPGbX2ls0NJNueoBNPdVTz2KMdDmurEaCLNlqlV+j04OmuFXVHpEN4w2Nhp6hOD2wyhEfpQ+KaF/dRYWjP5wanmQ5tmOHGYnM8hfbxohSrOrJBaIjZz50md/xPHTanQLnb5dIQfv77xMo4MlqEPMWjWAC8bQAFr6QtB4WmGgPk/2aht0ec25S4OYfPoxxFHFSRd4K9fJF780XxDD03p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WM4SmOHq0ir79Pvy3rHVmcSRk3e46sIR7YP9pIXxffU+gP1McVvsugC41qZz?=
 =?us-ascii?Q?x2IBOrOfND8V96uxrWgTEqvnqDASF9PeIo9CCtCi2TKH6/9+4i0UHnIkYoqN?=
 =?us-ascii?Q?02w2nZto+JoyyNiPI2LaVe91ME0ckPCF+Avvm1udHLu9+a532CoK9AFmOotA?=
 =?us-ascii?Q?kNo8ETGDtDSnQFe7QyTcrJ6rthdJvfIEpqWyn+lZ8xChYlI7geMnxexY06fm?=
 =?us-ascii?Q?mtFC6+gZIT6x1nuwOn+beVJ/kh3iM9y0BdAL5W13IA1jaFcWZUHqaaW8nYmB?=
 =?us-ascii?Q?q+5Ta7K/m78VDpkbhWDtdx+AGgm3hxW5y8qZh3NQt8abe35+py6ouVm2wDcp?=
 =?us-ascii?Q?eBMBskWGZTXpELH2WK1vAUixnzSAxhDj87nh+y0FbwJA50zmEAYefWDpDHJi?=
 =?us-ascii?Q?0Rx4ZHoRGpZyP59tXOZ364hcUnfLiCjw8sq3p/Vha3Vf+jjt42yp44zN5KPx?=
 =?us-ascii?Q?1NaK++IJTT5s1uK1Bx4I4J5slJteGyvY5qoO9z76g2XtYyW7hD9k/IZw4MlY?=
 =?us-ascii?Q?7zq1Xgc/WxlnZVrYpwwlJgCRy8sUT7J6FHUCDciGbb0//Q2KILdPobrHnysZ?=
 =?us-ascii?Q?ND58jiUuuAoxIq8q0Y9rEa2RQXY9KI3aDdSSCGyvj7iHvySrCpgY/CV9n2mj?=
 =?us-ascii?Q?q9u01x0F8t0iG1mRZpx/3QVzt8dG+pfJG/usLB7TEDJ0dS1+EVB+PuEDdKX5?=
 =?us-ascii?Q?4Ub295GuYnr3lRDcpwS+CGlXd85Uj5YDlQVJyMxIIroCPPTMKyBs+CHB0oom?=
 =?us-ascii?Q?H6wWahbX+3QLx86ei5xVzG+kPdEwpHMzD8uuW0SDNFbltJ5YcaAzCioE3j75?=
 =?us-ascii?Q?Bc9FJ44gYTmsJ2oHarrxSlL3cJHk28SkmmDVdRXNFPqLvgjwFmeOjhdAcZMg?=
 =?us-ascii?Q?4aDlVHMYVng8qqDxTzr3oEWiHgB/WnkAl/gwjReYuGMkOnbzjCnXvt5IRMKV?=
 =?us-ascii?Q?fuZ1dDQH4eQnMVWqUbEMQI78kngzTtpSsp139MtR5rawqW7mA/WZDijjiO+o?=
 =?us-ascii?Q?dHmZqGuBxw8cpPHipR/VmJ4yHI8WsUC30ePQiLlZEipYYZwwIQur0xNbNBBs?=
 =?us-ascii?Q?FauO5rlXm6KJw9A4XtmP7jvSFSaROWf73hoabm1Ta70Hh6sc96u5LENzTQKu?=
 =?us-ascii?Q?qlgXgkfXhIGMt+JRVWSN9rZyKUIQXakXdNEphGErNkeRwPUX2iXPfEvSCeyv?=
 =?us-ascii?Q?mLYnNSfAZf+w4gH4EhYPGrD57LDoDap6ZxlMqoDleAzoUEOGETfkq7B/+fzr?=
 =?us-ascii?Q?K4hBJ+YnMzNvPWBikvdhOWtHMnzS8jhcTvBwf40XuoVJfmFmm4z5M8Su+fCg?=
 =?us-ascii?Q?OvgwQijkUThF1PD+atkXEdvaVl4uU7xhfOxhxOQ/iCNA5vZ2H9TL67ehqGJ2?=
 =?us-ascii?Q?/V7gyqG8SB1b361IlX3AO/SqqeX7xK0awLjc7jCcaCSxfVKyDgqreRDvggTj?=
 =?us-ascii?Q?NQgmU4UhFbmtHpKk9v+Cm65nZJvRSqDyKN437htoi517rxfngb5novkM6AXg?=
 =?us-ascii?Q?DipBqVmqfaSk8+YMpfnU3TNFk8cOAb7bJjYhriOxrLXrNWHiZGmOIUp6QDMk?=
 =?us-ascii?Q?rU0v5oyGZHbO8b/u40J26pqlsh32w84BEjvtzijz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14586f51-31cc-42ec-bfd9-08dc52d1196b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 04:55:21.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfH8cDD3GOJA2XiAzTPFWKWqgffbOABJKgvchEbjSDBQ02wY3s9q3FibbgwiX1KKv6rZGP5sClJFUNGbvMFPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: e6c71d0899e7b0e0b120dcc1ddb8613aa1e1cd93 ("lib/xarray: introduce a new helper xas_get_order")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a6bd6c9333397f5a0e2667d4d82fef8c970108f2]

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------+------------+------------+
|                                                                     | 5fb1b791b3 | e6c71d0899 |
+---------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                        | 0          | 6          |
| include/linux/xarray.h:#suspicious_rcu_dereference_check()usage     | 0          | 6          |
| include/linux/xarray.h:#suspicious_rcu_dereference_protected()usage | 0          | 6          |
+---------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404021026.f28e44bb-lkp@intel.com


[   86.993728][    T1] WARNING: suspicious RCU usage
[   86.994316][    T1] 6.9.0-rc1-00150-ge6c71d0899e7 #1 Tainted: G        W       T
[   86.995290][    T1] -----------------------------
[   86.995922][    T1] include/linux/xarray.h:1201 suspicious rcu_dereference_check() usage!
[   86.997044][    T1]
[   86.997044][    T1] other info that might help us debug this:
[   86.997044][    T1]
[   86.998358][    T1]
[   86.998358][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   86.999400][    T1] no locks held by swapper/0/1.
[   87.000056][    T1]
[   87.000056][    T1] stack backtrace:
[   87.000880][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       T  6.9.0-rc1-00150-ge6c71d0899e7 #1 e72961bb2bc89a324b194b20c4b2a631d7a91742
[   87.002620][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   87.003373][    T1] Call Trace:
[ 87.003373][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 87.003373][ T1] dump_stack (lib/dump_stack.c:123) 
[ 87.003373][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 87.003373][ T1] xas_start (include/linux/xarray.h:?) 
[ 87.003373][ T1] xas_store (lib/xarray.c:237 lib/xarray.c:789) 
[ 87.006845][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 87.006845][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 87.006845][ T1] do_one_initcall (init/main.c:1238) 
[ 87.006845][ T1] ? xa_dump (lib/test_xarray.c:2054) 
[ 87.006845][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 87.006845][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.006845][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.006845][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.006845][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.006845][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.006845][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.006845][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 87.006845][ T1] ? ktime_get (kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.014859][ T1] ? ktime_get (kernel/time/timekeeping.c:? kernel/time/timekeeping.c:255 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.014859][ T1] ? clockevents_program_event (kernel/time/clockevents.c:336) 
[ 87.014859][ T1] ? update_process_times (kernel/time/timer.c:2494) 
[ 87.014859][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.014859][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.014859][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 87.014859][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.014859][ T1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1043) 
[ 87.014859][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.014859][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 87.014859][ T1] ? next_arg (lib/cmdline.c:273) 
[ 87.014859][ T1] ? parse_args (kernel/params.c:153) 
[ 87.022841][ T1] do_initcall_level (init/main.c:1299) 
[ 87.022841][ T1] ? kernel_init (init/main.c:1439) 
[ 87.022841][ T1] do_initcalls (init/main.c:1313) 
[ 87.022841][ T1] do_basic_setup (init/main.c:1336) 
[ 87.022841][ T1] kernel_init_freeable (init/main.c:1552) 
[ 87.022841][ T1] ? rest_init (init/main.c:1429) 
[ 87.022841][ T1] kernel_init (init/main.c:1439) 
[ 87.022841][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.022841][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 87.022841][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   87.029403][    T1]
[   87.029696][    T1] =============================
[   87.030321][    T1] WARNING: suspicious RCU usage
[   87.030934][    T1] 6.9.0-rc1-00150-ge6c71d0899e7 #1 Tainted: G        W       T
[   87.031864][    T1] -----------------------------
[   87.032486][    T1] include/linux/xarray.h:1217 suspicious rcu_dereference_check() usage!
[   87.033492][    T1]
[   87.033492][    T1] other info that might help us debug this:
[   87.033492][    T1]
[   87.034805][    T1]
[   87.034805][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   87.035815][    T1] no locks held by swapper/0/1.
[   87.036445][    T1]
[   87.036445][    T1] stack backtrace:
[   87.037223][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       T  6.9.0-rc1-00150-ge6c71d0899e7 #1 e72961bb2bc89a324b194b20c4b2a631d7a91742
[   87.038825][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   87.038825][    T1] Call Trace:
[ 87.038825][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 87.038825][ T1] dump_stack (lib/dump_stack.c:123) 
[ 87.038825][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 87.038825][ T1] xas_descend (include/linux/xarray.h:?) 
[ 87.038825][ T1] xas_store (lib/xarray.c:244 lib/xarray.c:789) 
[ 87.038825][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 87.038825][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 87.038825][ T1] do_one_initcall (init/main.c:1238) 
[ 87.038825][ T1] ? xa_dump (lib/test_xarray.c:2054) 
[ 87.038825][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 87.038825][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.046853][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.046853][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.046853][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.046853][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.046853][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.046853][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 87.046853][ T1] ? ktime_get (kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.046853][ T1] ? ktime_get (kernel/time/timekeeping.c:? kernel/time/timekeeping.c:255 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.046853][ T1] ? clockevents_program_event (kernel/time/clockevents.c:336) 
[ 87.046853][ T1] ? update_process_times (kernel/time/timer.c:2494) 
[ 87.046853][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.046853][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.054842][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 87.054842][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.054842][ T1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1043) 
[ 87.054842][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.054842][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 87.054842][ T1] ? next_arg (lib/cmdline.c:273) 
[ 87.054842][ T1] ? parse_args (kernel/params.c:153) 
[ 87.054842][ T1] do_initcall_level (init/main.c:1299) 
[ 87.054842][ T1] ? kernel_init (init/main.c:1439) 
[ 87.054842][ T1] do_initcalls (init/main.c:1313) 
[ 87.054842][ T1] do_basic_setup (init/main.c:1336) 
[ 87.054842][ T1] kernel_init_freeable (init/main.c:1552) 
[ 87.054842][ T1] ? rest_init (init/main.c:1429) 
[ 87.062852][ T1] ? rest_init (init/main.c:1429) 
[ 87.062852][ T1] kernel_init (init/main.c:1439) 
[ 87.062852][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.062852][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 87.062852][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   87.065984][    T1]
[   87.066262][    T1] =============================
[   87.066890][    T1] WARNING: suspicious RCU usage
[   87.067483][    T1] 6.9.0-rc1-00150-ge6c71d0899e7 #1 Tainted: G        W       T
[   87.068496][    T1] -----------------------------
[   87.069138][    T1] include/linux/xarray.h:1226 suspicious rcu_dereference_protected() usage!
[   87.070297][    T1]
[   87.070297][    T1] other info that might help us debug this:
[   87.070297][    T1]
[   87.071603][    T1]
[   87.071603][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   87.072655][    T1] no locks held by swapper/0/1.
[   87.073281][    T1]
[   87.073281][    T1] stack backtrace:
[   87.074029][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       T  6.9.0-rc1-00150-ge6c71d0899e7 #1 e72961bb2bc89a324b194b20c4b2a631d7a91742
[   87.075575][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   87.075575][    T1] Call Trace:
[ 87.075575][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 87.075575][ T1] dump_stack (lib/dump_stack.c:123) 
[ 87.075575][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 87.078848][ T1] xas_store (include/linux/xarray.h:?) 
[ 87.078848][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 87.078848][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 87.078848][ T1] do_one_initcall (init/main.c:1238) 
[ 87.078848][ T1] ? xa_dump (lib/test_xarray.c:2054) 
[ 87.078848][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 87.078848][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.078848][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.078848][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.078848][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.078848][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.078848][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.086847][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 87.086847][ T1] ? ktime_get (kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.086847][ T1] ? ktime_get (kernel/time/timekeeping.c:? kernel/time/timekeeping.c:255 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.086847][ T1] ? clockevents_program_event (kernel/time/clockevents.c:336) 
[ 87.086847][ T1] ? update_process_times (kernel/time/timer.c:2494) 
[ 87.086847][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.086847][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.086847][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 87.086847][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.086847][ T1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1043) 
[ 87.086847][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.086847][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 87.094846][ T1] ? next_arg (lib/cmdline.c:273) 
[ 87.094846][ T1] ? parse_args (kernel/params.c:153) 
[ 87.094846][ T1] do_initcall_level (init/main.c:1299) 
[ 87.094846][ T1] ? kernel_init (init/main.c:1439) 
[ 87.094846][ T1] do_initcalls (init/main.c:1313) 
[ 87.094846][ T1] do_basic_setup (init/main.c:1336) 
[ 87.094846][ T1] kernel_init_freeable (init/main.c:1552) 
[ 87.094846][ T1] ? rest_init (init/main.c:1429) 
[ 87.094846][ T1] kernel_init (init/main.c:1439) 
[ 87.094846][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.094846][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 87.094846][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   87.102597][    T1]
[   87.102922][    T1] =============================
[   87.103563][    T1] WARNING: suspicious RCU usage
[   87.104180][    T1] 6.9.0-rc1-00150-ge6c71d0899e7 #1 Tainted: G        W       T
[   87.105106][    T1] -----------------------------
[   87.105698][    T1] include/linux/xarray.h:1242 suspicious rcu_dereference_protected() usage!
[   87.106878][    T1]
[   87.106878][    T1] other info that might help us debug this:
[   87.106878][    T1]
[   87.108138][    T1]
[   87.108138][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   87.109159][    T1] no locks held by swapper/0/1.
[   87.109742][    T1]
[   87.109742][    T1] stack backtrace:
[   87.110445][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       T  6.9.0-rc1-00150-ge6c71d0899e7 #1 e72961bb2bc89a324b194b20c4b2a631d7a91742
[   87.110844][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   87.110844][    T1] Call Trace:
[ 87.110844][ T1] dump_stack_lvl (lib/dump_stack.c:116) 
[ 87.110844][ T1] dump_stack (lib/dump_stack.c:123) 
[ 87.110844][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 87.110844][ T1] xas_store (include/linux/xarray.h:? lib/xarray.c:759 lib/xarray.c:844) 
[ 87.110844][ T1] check_xas_get_order (lib/test_xarray.c:?) 
[ 87.110844][ T1] xarray_checks (lib/test_xarray.c:2070) 
[ 87.110844][ T1] do_one_initcall (init/main.c:1238) 
[ 87.110844][ T1] ? xa_dump (lib/test_xarray.c:2054) 
[ 87.110844][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 87.118849][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.118849][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.118849][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.118849][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 87.118849][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 87.118849][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 87.118849][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 87.118849][ T1] ? ktime_get (kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:254 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.118849][ T1] ? ktime_get (kernel/time/timekeeping.c:? kernel/time/timekeeping.c:255 kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848) 
[ 87.118849][ T1] ? clockevents_program_event (kernel/time/clockevents.c:336) 
[ 87.118849][ T1] ? update_process_times (kernel/time/timer.c:2494) 
[ 87.118849][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.118849][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.126855][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 87.126855][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 87.126855][ T1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1043) 
[ 87.126855][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 87.126855][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 87.126855][ T1] ? next_arg (lib/cmdline.c:273) 
[ 87.126855][ T1] ? parse_args (kernel/params.c:153) 
[ 87.126855][ T1] do_initcall_level (init/main.c:1299) 
[ 87.126855][ T1] ? kernel_init (init/main.c:1439) 
[ 87.126855][ T1] do_initcalls (init/main.c:1313) 
[ 87.134850][ T1] do_basic_setup (init/main.c:1336) 
[ 87.134850][ T1] kernel_init_freeable (init/main.c:1552) 
[ 87.134850][ T1] ? rest_init (init/main.c:1429) 
[ 87.134850][ T1] kernel_init (init/main.c:1439) 
[ 87.134850][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.134850][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 87.134850][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240402/202404021026.f28e44bb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


