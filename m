Return-Path: <linux-fsdevel+bounces-50900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39119AD0CD7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677DC3A88D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898F21B185;
	Sat,  7 Jun 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsZSWq4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7E1E8338;
	Sat,  7 Jun 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749292184; cv=none; b=WcsQofITzE+9/8Aigf3sTC06I+dcTOD6aa9XbRLjLU+4mpBTXv0FOZ+AWm06tYRw4W9TVxX91yzj+4c1nspGj3VlZNBTEvc+aqDGPUxfxZG1ME8vVyLicq02ARXdrR8tKvGEjvmO4kSUWiWA3GNB8edvKKiK+yMuGwq0tBbo4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749292184; c=relaxed/simple;
	bh=HUErItk+IykV8jb9k+DxC8wOGdpP83t+IkeVHoy1mbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBxfk3C1cTRrV3dRMziOLo7fIUYSD08Aal9YDqq85jQYjhZfeFvyXu3JnwM7vaWBV/TeGLUKVRJ2WTrKHU0MjAhZvXsoXgQyMKuiidqbnNSyc2+n8IhIRObiToKMMsC/RD8cCy7rdhReiz2qS3lXhZcQXUOnVGljkJyD0aQ5FP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsZSWq4m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749292182; x=1780828182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUErItk+IykV8jb9k+DxC8wOGdpP83t+IkeVHoy1mbE=;
  b=FsZSWq4mn3Up4nOpSt3PSFYWW0a7Fv14gYkTWQ5Qcb3sY7nHY88cpL5Y
   YJQU/3YSPNKW3l5LoTfAsTojNU/HQey9xRHVPvAz/J11aA1hLAMixdrAR
   b4pCM1vT40wspJWMQ8DP+c6dEDaggdb95YmRMIIzKybueIVDE7xNPUQxK
   V8l2OpTWFYDMzNxxtiUK/OcMCqi31wOrvYY5On5l5LBkJ/hOyYq21hopi
   7RJ9sNG1TYGAzpbOEeN5Aku79xFSFWCn0oinya+ySXJ3imfnlHmSx48ua
   eQMQaXKdNspkpbPGw4lRx/74GQhJO7C1NrznK1EMBn2NDKES5hGTYShHO
   w==;
X-CSE-ConnectionGUID: XDGHLUpcT6C41EGMVAkmwA==
X-CSE-MsgGUID: JQVDAluKSpaLhwbIWysq4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51430862"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51430862"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 03:29:41 -0700
X-CSE-ConnectionGUID: //5h4T4EQHy8JqBmwILrZg==
X-CSE-MsgGUID: cSCGMFoJQxaOHhvnzWtjPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="146401279"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Jun 2025 03:29:38 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNqnv-0005in-2o;
	Sat, 07 Jun 2025 10:29:35 +0000
Date: Sat, 7 Jun 2025 18:29:34 +0800
From: kernel test robot <lkp@intel.com>
To: wangfushuai <wangfushuai@baidu.com>, akpm@linux-foundation.org,
	david@redhat.com, andrii@kernel.org, osalvador@suse.de,
	Liam.Howlett@oracle.com, christophe.leroy@csgroup.eu
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	wangfushuai <wangfushuai@baidu.com>
Subject: Re: [PATCH] fs/proc/task_mmu: add VM_SHADOW_STACK for arm64 when
 support GCS
Message-ID: <202506071806.mshFK42h-lkp@intel.com>
References: <20250607060741.69902-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607060741.69902-1-wangfushuai@baidu.com>

Hi wangfushuai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.15 next-20250606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wangfushuai/fs-proc-task_mmu-add-VM_SHADOW_STACK-for-arm64-when-support-GCS/20250607-141047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250607060741.69902-1-wangfushuai%40baidu.com
patch subject: [PATCH] fs/proc/task_mmu: add VM_SHADOW_STACK for arm64 when support GCS
config: x86_64-buildonly-randconfig-001-20250607 (https://download.01.org/0day-ci/archive/20250607/202506071806.mshFK42h-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506071806.mshFK42h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506071806.mshFK42h-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/proc/task_mmu.c:994:42: warning: extra tokens at end of #ifdef directive [-Wextra-tokens]
     994 | #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK || defined(CONFIG_ARM64_GCS)
         |                                          ^
         |                                          //
   1 warning generated.


vim +994 fs/proc/task_mmu.c

   920	
   921	static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
   922	{
   923		/*
   924		 * Don't forget to update Documentation/ on changes.
   925		 *
   926		 * The length of the second argument of mnemonics[]
   927		 * needs to be 3 instead of previously set 2
   928		 * (i.e. from [BITS_PER_LONG][2] to [BITS_PER_LONG][3])
   929		 * to avoid spurious
   930		 * -Werror=unterminated-string-initialization warning
   931		 *  with GCC 15
   932		 */
   933		static const char mnemonics[BITS_PER_LONG][3] = {
   934			/*
   935			 * In case if we meet a flag we don't know about.
   936			 */
   937			[0 ... (BITS_PER_LONG-1)] = "??",
   938	
   939			[ilog2(VM_READ)]	= "rd",
   940			[ilog2(VM_WRITE)]	= "wr",
   941			[ilog2(VM_EXEC)]	= "ex",
   942			[ilog2(VM_SHARED)]	= "sh",
   943			[ilog2(VM_MAYREAD)]	= "mr",
   944			[ilog2(VM_MAYWRITE)]	= "mw",
   945			[ilog2(VM_MAYEXEC)]	= "me",
   946			[ilog2(VM_MAYSHARE)]	= "ms",
   947			[ilog2(VM_GROWSDOWN)]	= "gd",
   948			[ilog2(VM_PFNMAP)]	= "pf",
   949			[ilog2(VM_LOCKED)]	= "lo",
   950			[ilog2(VM_IO)]		= "io",
   951			[ilog2(VM_SEQ_READ)]	= "sr",
   952			[ilog2(VM_RAND_READ)]	= "rr",
   953			[ilog2(VM_DONTCOPY)]	= "dc",
   954			[ilog2(VM_DONTEXPAND)]	= "de",
   955			[ilog2(VM_LOCKONFAULT)]	= "lf",
   956			[ilog2(VM_ACCOUNT)]	= "ac",
   957			[ilog2(VM_NORESERVE)]	= "nr",
   958			[ilog2(VM_HUGETLB)]	= "ht",
   959			[ilog2(VM_SYNC)]	= "sf",
   960			[ilog2(VM_ARCH_1)]	= "ar",
   961			[ilog2(VM_WIPEONFORK)]	= "wf",
   962			[ilog2(VM_DONTDUMP)]	= "dd",
   963	#ifdef CONFIG_ARM64_BTI
   964			[ilog2(VM_ARM64_BTI)]	= "bt",
   965	#endif
   966	#ifdef CONFIG_MEM_SOFT_DIRTY
   967			[ilog2(VM_SOFTDIRTY)]	= "sd",
   968	#endif
   969			[ilog2(VM_MIXEDMAP)]	= "mm",
   970			[ilog2(VM_HUGEPAGE)]	= "hg",
   971			[ilog2(VM_NOHUGEPAGE)]	= "nh",
   972			[ilog2(VM_MERGEABLE)]	= "mg",
   973			[ilog2(VM_UFFD_MISSING)]= "um",
   974			[ilog2(VM_UFFD_WP)]	= "uw",
   975	#ifdef CONFIG_ARM64_MTE
   976			[ilog2(VM_MTE)]		= "mt",
   977			[ilog2(VM_MTE_ALLOWED)]	= "",
   978	#endif
   979	#ifdef CONFIG_ARCH_HAS_PKEYS
   980			/* These come out via ProtectionKey: */
   981			[ilog2(VM_PKEY_BIT0)]	= "",
   982			[ilog2(VM_PKEY_BIT1)]	= "",
   983			[ilog2(VM_PKEY_BIT2)]	= "",
   984	#if VM_PKEY_BIT3
   985			[ilog2(VM_PKEY_BIT3)]	= "",
   986	#endif
   987	#if VM_PKEY_BIT4
   988			[ilog2(VM_PKEY_BIT4)]	= "",
   989	#endif
   990	#endif /* CONFIG_ARCH_HAS_PKEYS */
   991	#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
   992			[ilog2(VM_UFFD_MINOR)]	= "ui",
   993	#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 > 994	#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK || defined(CONFIG_ARM64_GCS)
   995			[ilog2(VM_SHADOW_STACK)] = "ss",
   996	#endif
   997	#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
   998			[ilog2(VM_DROPPABLE)] = "dp",
   999	#endif
  1000	#ifdef CONFIG_64BIT
  1001			[ilog2(VM_SEALED)] = "sl",
  1002	#endif
  1003		};
  1004		size_t i;
  1005	
  1006		seq_puts(m, "VmFlags: ");
  1007		for (i = 0; i < BITS_PER_LONG; i++) {
  1008			if (!mnemonics[i][0])
  1009				continue;
  1010			if (vma->vm_flags & (1UL << i))
  1011				seq_printf(m, "%s ", mnemonics[i]);
  1012		}
  1013		seq_putc(m, '\n');
  1014	}
  1015	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

