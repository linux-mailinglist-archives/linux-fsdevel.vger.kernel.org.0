Return-Path: <linux-fsdevel+bounces-63824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A0BCED57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 02:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD20E19E2450
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5E45038;
	Sat, 11 Oct 2025 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEeqoph7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946434BA54;
	Sat, 11 Oct 2025 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760143852; cv=none; b=OGpIEEgMXiYsOm3GPa6vrH+n2YlSFkDJcq0QFjVDrqhUKWC2n2n+87CuUbgyZO5Z3zufk+XRDVmX2Iz6gblDvAxihH8VI/JyW2FkFe5uFCy4nAXv85os+ZVtA4UsLsGDqrwk0riMYGV56tmZS2De/8+cuqZ+zY+7xof24xBydN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760143852; c=relaxed/simple;
	bh=9mgsASjVFIeADDVrI9fvFoRPP0l3FSfJJNlhNk/Q2lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8MmPCle69wOpCRvP2NKGYjR7TZnDZSzBICcdLbykPzWwL1Wp6+LO9sOf9CJvn33911SeeWNMbMvsiK727EnWOeu/tVO46n4c4ustAvPX4fJmj8QAUMMpLExKs/Ii32oeeozZBWoQvArdnolm+uNy1/FLVeh83WzsOJekrgV3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEeqoph7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760143851; x=1791679851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9mgsASjVFIeADDVrI9fvFoRPP0l3FSfJJNlhNk/Q2lY=;
  b=XEeqoph7gRAkA4rrZXR3jJnqF6on56XjUr9bKB/kuDbnbknQ86IHfIfv
   FIdbXENInCIb/9vM8rbK/nHC9EBAP1f0pj51ap0E5EZEuH45ISVV8T6TZ
   bRBs3+IqK31nrl5EUKYHozi7amTKIjJs4EhHo5J/CHY2AqxzlPM4K//tp
   TO/IhP819iuhDqoia+r2FaVOaRq0hRhODagxnwZcIGUva0Er8kzW7Vxj9
   3Gz2qkxLcFmlsOM21iPYBWaP8tve+uJY872QcAnGiAiRKLkdMcBi64UB2
   u6m1Vzyf9uMgUwOMg4Dsk8SbG2sI4ljdVfMH06Xt2XH31oLv8lpaquu8h
   g==;
X-CSE-ConnectionGUID: /sj7BvMlTIOwkKzOI3ShXg==
X-CSE-MsgGUID: wbVqwJVGS4CO+a4TYvIiNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66194856"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66194856"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 17:50:50 -0700
X-CSE-ConnectionGUID: XAAY603OTAq3vXDWwrrrVg==
X-CSE-MsgGUID: j9ZDNPDASAWyNKWZhItqmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181529200"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Oct 2025 17:50:46 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Noq-0003LT-2A;
	Sat, 11 Oct 2025 00:50:44 +0000
Date: Sat, 11 Oct 2025 08:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, acsjakub@amazon.de
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, chengming.zhou@linux.dev,
	david@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
	xu.xin16@zte.com.cn, rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <202510110850.4VXzbsF7-lkp@intel.com>
References: <20251007162136.1885546-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007162136.1885546-1-aliceryhl@google.com>

Hi Alice,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/mm-use-enum-for-vm_flags/20251010-095004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251007162136.1885546-1-aliceryhl%40google.com
patch subject: [PATCH] mm: use enum for vm_flags
config: powerpc64-randconfig-r111-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110850.4VXzbsF7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110850.4VXzbsF7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110850.4VXzbsF7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/proc/task_mmu.c:1184:5: sparse: sparse: undefined preprocessor identifier 'VM_HIGH_ARCH_3'
>> fs/proc/task_mmu.c:1187:5: sparse: sparse: undefined preprocessor identifier 'VM_HIGH_ARCH_4'
   fs/proc/task_mmu.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'proc_get_vma' - unexpected unlock
   fs/proc/task_mmu.c:309:9: sparse: sparse: context imbalance in 'm_start' - different lock contexts for basic block
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'm_stop' - unexpected unlock

vim +/VM_HIGH_ARCH_3 +1184 fs/proc/task_mmu.c

e070ad49f31155 Mauricio Lin       2005-09-03  1120  
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1121  static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1122  {
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1123  	/*
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1124  	 * Don't forget to update Documentation/ on changes.
5778ace04e6f07 Brahmajit Das      2024-10-05  1125  	 *
5778ace04e6f07 Brahmajit Das      2024-10-05  1126  	 * The length of the second argument of mnemonics[]
5778ace04e6f07 Brahmajit Das      2024-10-05  1127  	 * needs to be 3 instead of previously set 2
5778ace04e6f07 Brahmajit Das      2024-10-05  1128  	 * (i.e. from [BITS_PER_LONG][2] to [BITS_PER_LONG][3])
5778ace04e6f07 Brahmajit Das      2024-10-05  1129  	 * to avoid spurious
5778ace04e6f07 Brahmajit Das      2024-10-05  1130  	 * -Werror=unterminated-string-initialization warning
5778ace04e6f07 Brahmajit Das      2024-10-05  1131  	 *  with GCC 15
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1132  	 */
5778ace04e6f07 Brahmajit Das      2024-10-05  1133  	static const char mnemonics[BITS_PER_LONG][3] = {
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1134  		/*
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1135  		 * In case if we meet a flag we don't know about.
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1136  		 */
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1137  		[0 ... (BITS_PER_LONG-1)] = "??",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1138  
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1139  		[ilog2(VM_READ)]	= "rd",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1140  		[ilog2(VM_WRITE)]	= "wr",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1141  		[ilog2(VM_EXEC)]	= "ex",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1142  		[ilog2(VM_SHARED)]	= "sh",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1143  		[ilog2(VM_MAYREAD)]	= "mr",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1144  		[ilog2(VM_MAYWRITE)]	= "mw",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1145  		[ilog2(VM_MAYEXEC)]	= "me",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1146  		[ilog2(VM_MAYSHARE)]	= "ms",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1147  		[ilog2(VM_GROWSDOWN)]	= "gd",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1148  		[ilog2(VM_PFNMAP)]	= "pf",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1149  		[ilog2(VM_LOCKED)]	= "lo",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1150  		[ilog2(VM_IO)]		= "io",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1151  		[ilog2(VM_SEQ_READ)]	= "sr",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1152  		[ilog2(VM_RAND_READ)]	= "rr",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1153  		[ilog2(VM_DONTCOPY)]	= "dc",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1154  		[ilog2(VM_DONTEXPAND)]	= "de",
8614d6c5eda005 Jason A. Donenfeld 2022-12-05  1155  		[ilog2(VM_LOCKONFAULT)]	= "lf",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1156  		[ilog2(VM_ACCOUNT)]	= "ac",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1157  		[ilog2(VM_NORESERVE)]	= "nr",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1158  		[ilog2(VM_HUGETLB)]	= "ht",
b6fb293f2497a9 Jan Kara           2017-11-01  1159  		[ilog2(VM_SYNC)]	= "sf",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1160  		[ilog2(VM_ARCH_1)]	= "ar",
d2cd9ede6e193d Rik van Riel       2017-09-06  1161  		[ilog2(VM_WIPEONFORK)]	= "wf",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1162  		[ilog2(VM_DONTDUMP)]	= "dd",
424037b77519d1 Daniel Kiss        2020-03-16  1163  #ifdef CONFIG_ARM64_BTI
424037b77519d1 Daniel Kiss        2020-03-16  1164  		[ilog2(VM_ARM64_BTI)]	= "bt",
424037b77519d1 Daniel Kiss        2020-03-16  1165  #endif
ec8e41aec13005 Naoya Horiguchi    2013-11-12  1166  #ifdef CONFIG_MEM_SOFT_DIRTY
ec8e41aec13005 Naoya Horiguchi    2013-11-12  1167  		[ilog2(VM_SOFTDIRTY)]	= "sd",
ec8e41aec13005 Naoya Horiguchi    2013-11-12  1168  #endif
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1169  		[ilog2(VM_MIXEDMAP)]	= "mm",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1170  		[ilog2(VM_HUGEPAGE)]	= "hg",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1171  		[ilog2(VM_NOHUGEPAGE)]	= "nh",
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1172  		[ilog2(VM_MERGEABLE)]	= "mg",
16ba6f811dfe44 Andrea Arcangeli   2015-09-04  1173  		[ilog2(VM_UFFD_MISSING)]= "um",
16ba6f811dfe44 Andrea Arcangeli   2015-09-04  1174  		[ilog2(VM_UFFD_WP)]	= "uw",
9f3419315f3cdc Catalin Marinas    2019-11-27  1175  #ifdef CONFIG_ARM64_MTE
9f3419315f3cdc Catalin Marinas    2019-11-27  1176  		[ilog2(VM_MTE)]		= "mt",
9f3419315f3cdc Catalin Marinas    2019-11-27  1177  		[ilog2(VM_MTE_ALLOWED)]	= "",
9f3419315f3cdc Catalin Marinas    2019-11-27  1178  #endif
5212213aa5a235 Ram Pai            2018-03-27  1179  #ifdef CONFIG_ARCH_HAS_PKEYS
c1192f84284146 Dave Hansen        2016-02-12  1180  		/* These come out via ProtectionKey: */
c1192f84284146 Dave Hansen        2016-02-12  1181  		[ilog2(VM_PKEY_BIT0)]	= "",
c1192f84284146 Dave Hansen        2016-02-12  1182  		[ilog2(VM_PKEY_BIT1)]	= "",
c1192f84284146 Dave Hansen        2016-02-12  1183  		[ilog2(VM_PKEY_BIT2)]	= "",
9f82f15ddfdd60 Joey Gouly         2024-08-22 @1184  #if VM_PKEY_BIT3
c1192f84284146 Dave Hansen        2016-02-12  1185  		[ilog2(VM_PKEY_BIT3)]	= "",
9f82f15ddfdd60 Joey Gouly         2024-08-22  1186  #endif
2c9e0a6fa2bb75 Ram Pai            2018-03-27 @1187  #if VM_PKEY_BIT4
2c9e0a6fa2bb75 Ram Pai            2018-03-27  1188  		[ilog2(VM_PKEY_BIT4)]	= "",
c1192f84284146 Dave Hansen        2016-02-12  1189  #endif
5212213aa5a235 Ram Pai            2018-03-27  1190  #endif /* CONFIG_ARCH_HAS_PKEYS */
7677f7fd8be766 Axel Rasmussen     2021-05-04  1191  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
7677f7fd8be766 Axel Rasmussen     2021-05-04  1192  		[ilog2(VM_UFFD_MINOR)]	= "ui",
7677f7fd8be766 Axel Rasmussen     2021-05-04  1193  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
bcc9d04e749a8c Mark Brown         2024-10-01  1194  #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
54007f818206dc Yu-cheng Yu        2023-06-12  1195  		[ilog2(VM_SHADOW_STACK)] = "ss",
399ab86ea55039 Jeff Xu            2024-06-14  1196  #endif
d175ee98fe545d Christophe Leroy   2024-09-02  1197  #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
9651fcedf7b92d Jason A. Donenfeld 2022-12-08  1198  		[ilog2(VM_DROPPABLE)] = "dp",
d175ee98fe545d Christophe Leroy   2024-09-02  1199  #endif
d175ee98fe545d Christophe Leroy   2024-09-02  1200  #ifdef CONFIG_64BIT
399ab86ea55039 Jeff Xu            2024-06-14  1201  		[ilog2(VM_SEALED)] = "sl",
54007f818206dc Yu-cheng Yu        2023-06-12  1202  #endif
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1203  	};
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1204  	size_t i;
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1205  
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1206  	seq_puts(m, "VmFlags: ");
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1207  	for (i = 0; i < BITS_PER_LONG; i++) {
c1192f84284146 Dave Hansen        2016-02-12  1208  		if (!mnemonics[i][0])
c1192f84284146 Dave Hansen        2016-02-12  1209  			continue;
5778ace04e6f07 Brahmajit Das      2024-10-05  1210  		if (vma->vm_flags & (1UL << i))
5778ace04e6f07 Brahmajit Das      2024-10-05  1211  			seq_printf(m, "%s ", mnemonics[i]);
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1212  	}
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1213  	seq_putc(m, '\n');
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1214  }
834f82e2aa9a8e Cyrill Gorcunov    2012-12-17  1215  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

