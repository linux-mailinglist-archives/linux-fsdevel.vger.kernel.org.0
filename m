Return-Path: <linux-fsdevel+bounces-10845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C684EADD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5401C22B6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BB54F60E;
	Thu,  8 Feb 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahQc+2zm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEA4F5EC;
	Thu,  8 Feb 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429152; cv=fail; b=fepadHiuB+T1/pGL/u8kbadsHMAciNZKCKOf4IQ7sH0UYQs+PZwv1wU9MjMK2ycBkIlFBxndtAk283VVd5BuoqF2eSIxtWJZL0mwbdz2pEEtXUb7q0MvBnJZKPN1qr6vQo5GPIb8jpajZBxD2y5HiOJnKClFSKVAP7nSt9XFxIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429152; c=relaxed/simple;
	bh=qZBCTLRcAXhm+HQuluhgrj9RExVwS0LWi/tZ+uQbWR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=linN4e961puOYW8km5t/o1xwi9xB0lYaOjwmTTYouhk8u0G0aivT5jBEgiLQGMrPW01a/1em1IK6GUzcJTABdlOsSzfB7gQwa3yWdPKM0K6G/t35hQuuxhttVTtWoqEzGJ/roI34OF5+N+UAzQVLRvHAFG2EUkqK0/8Ny4X79Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahQc+2zm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707429151; x=1738965151;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qZBCTLRcAXhm+HQuluhgrj9RExVwS0LWi/tZ+uQbWR0=;
  b=ahQc+2zmOg5b5idWsI+ag8ny9mNMJTSVD7AAZKnqjda1h+ekbEBcyXbd
   E0xuqjOy1BAByF5xX0tiPkA+wvEiZtdQh196L3WKtA3OP0h2lMjw5+rtW
   9OuDuCyVGJ18CAfvo3SBXuibBwxCXuuZgHVGHl7Nt/S8i3+edKmh7XuIf
   NBHpAPfvQdb0nTDEKVFbvICCmdieJR7eYxvYGlnsEah+dV4oFQ0DcWh/Z
   RNoQu9rXY2wYnrUg0NMRnQ+CgN6eDu+CxkD8mhwCu6XZcMQIjq3bdIGlt
   NMHaUOrUx61TZi5TKO5cReNdu8s1WIBuEOszazb8OqVOIqWg9NN3KN05u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12692819"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="12692819"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="2149563"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:52:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:52:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:52:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:52:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATS9V0a2hkf2rgLt+WnZwY3hM7kiT3AjTpEqWcJwdYMNmRe3XqGIKKr7KNI3lLuB/xaCqFIGwV25Hx6w2PjNquwFS9J7I0WSEGf3cUUgxhlfiC6y5MmetAGvgXyeWVRlRRoOHQCw8RY5Clg31qxTCzjTlJAcYtCYObaDyPRN8uYqmRmIwvnQfzX77h7490GiK7PKFRekw+pHSNMbXmd/R93XPz95yDFUuaVXTmr4jKqczSnRJU77zmuRegjHfJtrrWKUu1UlPdSk4sbLuJyvU4RR0uCn4Q6WOZ2+3jg1qouB50+Dr4mif0oKEy9ZvZE02+AKqVJOtDcISrFj93gwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8RMCZOpV2Kf8Hy8vbBAAt5mk+/34WK8fBA7NRi+4mQ=;
 b=SmYrsIOTPYfcE2ExZflHR2il5A+m+VSKNsLfZSrUdfMMG96kLlCYBRcnZ0jfqPNXVRHW8aporYkNowgmP/S3irAYJ8SoeYeODePdJ+bRMGowBq1bAKuAIkeiHdaJgyk2+9gx3PsCsFiLgbZwVtGgkSUD5btTpruLodIsMONQw06Lt7ad2Ch9eRV3CFJrH0/dynyOxgdwi2p1jtZXVlT/NrtSpXbAlY8IG9V5XO5BDm39FiD+FLQ10BlmYz/gcZfOo3o3Gtpv1do2S5OndyG/NROytdEcDbKMBJxqmSPPSbSwORi/xUB3P3kggIw+YbuubUsW9mAcQ9csFQqVkiGizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 21:52:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:52:09 +0000
Date: Thu, 8 Feb 2024 13:52:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>
Subject: RE: [PATCH v4 07/12] Introduce cpu_dcache_is_aliasing() across all
 architectures
Message-ID: <65c54d06e2258_afa429450@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-8-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-8-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ea16f4-123f-42fe-fe85-08dc28f03310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMlO6mqZzAaFfjkh51IOFdvogLmBL4y80jau7UjfJxZTrgNQl1HJrQ1V2/w1zVQ7bm+jQzAkI6mRzveXGZCLX2bwR8kf8G0zNB1dtjYODiq7OH7o0RAsHs3nSfTpJ5fouNRRE5YzO6I8jZFDQW1ij5ZtVMpx5L2nMWxDx8Bc3H9oyS6Vmbg5hBjuvAsb5PlDPjI/ICFFOXSdPipMuFm0r5QHYn4SAkLKQiEMBz50IALMYqiibyAd/aOQkoUaSu4+5zEmfIeaLaETgl5KBIOehdNsRH+oCY7M67KK6WB6wrVyjSOCq2MIFRFl2IEsvirI4oKyUcVUEq1IYFgKZ3Bl87dYJd5uSY/0sBo4OGbaOuRffrggmoiwZ8SBvrIQeetxbHPB5q2C0HPEBG5P0TcZh45/NGyJdeW61v7MVT9Fbtmupnw0UaM69A0qOQ9BCjg9CDxUIkZA72mm++4ViK5z+xvbjmwJMFdCcEdWksv+kZuPxqCeq7nSFbLaXpe0CGOTW4tdP+hQihf7arHbikdq6GGAiEfa2/FYezSUnzbWe28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(5660300002)(41300700001)(86362001)(9686003)(966005)(26005)(83380400001)(54906003)(6666004)(6512007)(478600001)(316002)(110136005)(6486002)(8676002)(4326008)(66556008)(66946007)(82960400001)(6506007)(66476007)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O4BwINp93Wtz2QMD1qFbnI7P5JPUuOX6FlmDqWhboKR6krexHQyzi2js5Eq4?=
 =?us-ascii?Q?X2P3zAh6Sa9UWkiOqQiu6OZ9zlaIVObPwuyU8f4zPs4EEO7rcdi0Bh22rtpJ?=
 =?us-ascii?Q?sK3zWdGjt7vuyYPMV5eioWwdPJNSb7++h1wjLUsYEh98dxUGlqv0d5/DjxxX?=
 =?us-ascii?Q?UMlphSY5X0+FGeVLkpiFO1dx4X/X0Yof6ylK6Ue1RdW/ag/opN4UDmI2FVAg?=
 =?us-ascii?Q?nHoicPIW+J5RcK/Y94/byho8CUk4I+4h9BxVkIuQe0eoaCFiJrX400U++P2Q?=
 =?us-ascii?Q?pUSFPQC8v/UV6KNodaf09ytGcx0kZFAWkPFx0+Dh5gR/31m/syF5GwTqoXye?=
 =?us-ascii?Q?/fLkMpyuMKkfD1rD/u2DIJ1ey2wo7tiYRXRh1lJK0Ay7Z7NGboOQGLCquM3N?=
 =?us-ascii?Q?7lxzIBKrLUWScvpwFh+jKW4keKmmbovmvw5nU0MV8+bSnBsGvQYDUSLHVVeJ?=
 =?us-ascii?Q?71CTJUwvcSyI9z6IZM4gnqDy+38+zF+OA1Gfdmg0l32IlSeCsoJ427xmXn1W?=
 =?us-ascii?Q?P4qvEiopziHFwB4HqUh8b4HOH/TEG8UfF6/rI5sdt9+mYAJgEKZ9Sxwxmjzd?=
 =?us-ascii?Q?tpg8TG7k3pcX4W+HZvV/nNVsI+0Zsocaq7K6ujTKdGZrHx8Hof2OOxVGFTAN?=
 =?us-ascii?Q?+S0icDYvf4PrmW7POdtmqixy4ymL83LVEdcSS1ug+vxl8ECn7MoNCWdIZug8?=
 =?us-ascii?Q?PcR3gIuq1IPuECMX90hsgIOEXbVXJrQl/zwpMU+Rv74xxer2LLV2uz/CGb2d?=
 =?us-ascii?Q?g7/Tyyb8eU+KQ9Xe4o5Hu9y1dIqb+L8xQhpYsaQexa6o1EBd//GQ1vn3zDwX?=
 =?us-ascii?Q?O78iPiLAJAVZGIWEVBpvZNcx0Z040CCk6VmtZ4l2IQr4j12od6TeVo39R7ws?=
 =?us-ascii?Q?T3DSIzyey1D77SpqVZc4kKPfqbC9mfBuUNbHA9IF/F68cHWZPwl+yQB24cFo?=
 =?us-ascii?Q?NddD98mqG48A175e3rY4x7Xim470pgjVK3L7zV0SWvFHjArLyJceWhJzUhl5?=
 =?us-ascii?Q?rGifCCLJmk2oEclxjcl3/c9Duv0RzOEo+xmpwKGqDsUSzZadccTtUmQ2Oynb?=
 =?us-ascii?Q?mh+In2Y2vM78/jVRw4DBccib0R7W79S4sCa1UtCggny14XtSVT5ix3XwkYHH?=
 =?us-ascii?Q?r6Gk8nGQz5gI7y5lSlQUSS7bOP+ZHVD07URkOUqn+mW2W92lx1llmQWHhj8k?=
 =?us-ascii?Q?GNEJO7OmBylHMX/URlRZMxgEoEv/ZWQ+cZj+WVuKw6Dqg2KUkEEeD10r0lNB?=
 =?us-ascii?Q?yHa6YYFt1gYOpMd3k1mO/QnQ2kKBaWiDnxlQrr/NeinYyT6757vbbGytfPiq?=
 =?us-ascii?Q?Q6tt7Bt50WF07PK5sjrJcNEBtfGcFTgjrgAhQHF3KVJn5WCox2CBvHdW5ZJ6?=
 =?us-ascii?Q?Edr7dPTaeNCqfTCRP/PbvZICpzqu84gJOMWsgLf86if7ajbiEvpp2lcbQ+Zo?=
 =?us-ascii?Q?7MahwHsgTWaQJsPSLGD5h0mY1dyPGJOaHWEBWiePU2Ol2fB/ckk6KpR3BQjw?=
 =?us-ascii?Q?ZSeJkZJo4B9t9QyxUTbW/qSlfbKiPkNTiSv/ILP00l/2eJguB8rfmgW2R8hx?=
 =?us-ascii?Q?uCtMCHExCfkCvVK9VBqST6qqbgVPYlP4d6JX5NJORKkBGDtkAyo0yUdOm+hN?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ea16f4-123f-42fe-fe85-08dc28f03310
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:52:09.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZOUzoxDlJaCHU8ppw3mXfI4PFNtBaggJt5M7uKu6dGcKLwXxDlXhBf2+ZauvdRcvaS18SWCysB3aaj4nf1sKZdlpnaRqCtKsl6Ddp5a9Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6734
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> Introduce a generic way to query whether the data cache is virtually
> aliased on all architectures. Its purpose is to ensure that subsystems
> which are incompatible with virtually aliased data caches (e.g. FS_DAX)
> can reliably query this.
> 
> For data cache aliasing, there are three scenarios dependending on the
> architecture. Here is a breakdown based on my understanding:
> 
> A) The data cache is always aliasing:
> 
> * arc
> * csky
> * m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
> * sh
> * parisc
> 
> B) The data cache aliasing is statically known or depends on querying CPU
>    state at runtime:
> 
> * arm (cache_is_vivt() || cache_is_vipt_aliasing())
> * mips (cpu_has_dc_aliases)
> * nios2 (NIOS2_DCACHE_SIZE > PAGE_SIZE)
> * sparc32 (vac_cache_size > PAGE_SIZE)
> * sparc64 (L1DCACHE_SIZE > PAGE_SIZE)
> * xtensa (DCACHE_WAY_SIZE > PAGE_SIZE)
> 
> C) The data cache is never aliasing:
> 
> * alpha
> * arm64 (aarch64)
> * hexagon
> * loongarch (but with incoherent write buffers, which are disabled since
>              commit d23b7795 ("LoongArch: Change SHMLBA from SZ_64K to PAGE_SIZE"))
> * microblaze
> * openrisc
> * powerpc
> * riscv
> * s390
> * um
> * x86
> 
> Require architectures in A) and B) to select ARCH_HAS_CPU_CACHE_ALIASING and
> implement "cpu_dcache_is_aliasing()".
> 
> Architectures in C) don't select ARCH_HAS_CPU_CACHE_ALIASING, and thus
> cpu_dcache_is_aliasing() simply evaluates to "false".
> 
> Note that this leaves "cpu_icache_is_aliasing()" to be implemented as future
> work. This would be useful to gate features like XIP on architectures
> which have aliasing CPU dcache-icache but not CPU dcache-dcache.
> 
> Use "cpu_dcache" and "cpu_cache" rather than just "dcache" and "cache"
> to clarify that we really mean "CPU data cache" and "CPU cache" to
> eliminate any possible confusion with VFS "dentry cache" and "page
> cache".
> 
> Link: https://lore.kernel.org/lkml/20030910210416.GA24258@mail.jlokier.co.uk/
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> Cc: nvdimm@lists.linux.dev
> ---
>  arch/arc/Kconfig                    |  1 +
>  arch/arc/include/asm/cachetype.h    |  9 +++++++++
>  arch/arm/Kconfig                    |  1 +
>  arch/arm/include/asm/cachetype.h    |  2 ++
>  arch/csky/Kconfig                   |  1 +
>  arch/csky/include/asm/cachetype.h   |  9 +++++++++
>  arch/m68k/Kconfig                   |  1 +
>  arch/m68k/include/asm/cachetype.h   |  9 +++++++++
>  arch/mips/Kconfig                   |  1 +
>  arch/mips/include/asm/cachetype.h   |  9 +++++++++
>  arch/nios2/Kconfig                  |  1 +
>  arch/nios2/include/asm/cachetype.h  | 10 ++++++++++
>  arch/parisc/Kconfig                 |  1 +
>  arch/parisc/include/asm/cachetype.h |  9 +++++++++
>  arch/sh/Kconfig                     |  1 +
>  arch/sh/include/asm/cachetype.h     |  9 +++++++++
>  arch/sparc/Kconfig                  |  1 +
>  arch/sparc/include/asm/cachetype.h  | 14 ++++++++++++++
>  arch/xtensa/Kconfig                 |  1 +
>  arch/xtensa/include/asm/cachetype.h | 10 ++++++++++
>  include/linux/cacheinfo.h           |  6 ++++++
>  mm/Kconfig                          |  6 ++++++
>  22 files changed, 112 insertions(+)
>  create mode 100644 arch/arc/include/asm/cachetype.h
>  create mode 100644 arch/csky/include/asm/cachetype.h
>  create mode 100644 arch/m68k/include/asm/cachetype.h
>  create mode 100644 arch/mips/include/asm/cachetype.h
>  create mode 100644 arch/nios2/include/asm/cachetype.h
>  create mode 100644 arch/parisc/include/asm/cachetype.h
>  create mode 100644 arch/sh/include/asm/cachetype.h
>  create mode 100644 arch/sparc/include/asm/cachetype.h
>  create mode 100644 arch/xtensa/include/asm/cachetype.h
> 
[..]
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index d504eb4b49ab..2cb15fe4fe12 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -138,4 +138,10 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
>  #define use_arch_cache_info()	(false)
>  #endif
>  
> +#ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
> +#define cpu_dcache_is_aliasing()	false
> +#else
> +#include <asm/cachetype.h>
> +#endif
> +
>  #endif /* _LINUX_CACHEINFO_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 57cd378c73d6..db09c9ad15c9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1016,6 +1016,12 @@ config IDLE_PAGE_TRACKING
>  	  See Documentation/admin-guide/mm/idle_page_tracking.rst for
>  	  more details.
>  
> +# Architectures which implement cpu_dcache_is_aliasing() to query
> +# whether the data caches are aliased (VIVT or VIPT with dcache
> +# aliasing) need to select this.
> +config ARCH_HAS_CPU_CACHE_ALIASING
> +	bool
> +
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	bool

I can't speak to the specific arch changes, but the generic support
above looks ok.

If you get any pushback on the per arch changes then maybe this could be
split into a patch that simply does the coarse grained select of
CONFIG_ARCH_HAS_CPU_CACHE_ALIASING for ARM, MIPS, and SPARC. Then,
follow-on with patches per-arch to do the more fine grained option.

Certainly Andrew's tree is great for simultaneous cross arch changes
like this.

