Return-Path: <linux-fsdevel+bounces-66591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72AC254B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7F293513FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9722A4F6;
	Fri, 31 Oct 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i460M6Ew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AB221D96;
	Fri, 31 Oct 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918113; cv=none; b=Q0dxaosR4+OeVhQ25crenR4CP8TVkvfg3i8PYxwsy4l5cnykduF2dP/DpwBmHWNA6T8k3tX/jQ0FyxkvJnksSIi/z21Evu4yay0rygnmdr2/ZfQOGykcQR2RWH9p5QjJBQDIoaomehRweHs8izZOmCsZlT4+C5LtwYQmaMErFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918113; c=relaxed/simple;
	bh=+7JeA8EZr9HLPcHjEwbm5n0PUPh3LAFAtmmlSTL8SOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGDRQVz7GchpOClyFQDhvvwMxNvsf+VLf/oxZ9XAz038I3ceLJhvzJocNLgCLr1RxeloJ5lcT3hnislZqkoXj2GCCQ9n8znUzbShhB//V2mzaxY9UmDHvF+h0EmHr0V08tdqwo4psQjO815lQnac2LXOITBxv82S5q4c90iQg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i460M6Ew; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761918112; x=1793454112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+7JeA8EZr9HLPcHjEwbm5n0PUPh3LAFAtmmlSTL8SOs=;
  b=i460M6Ew8i30gT4Q3OxLFHaAS1zdXcQHSWayto1AByxi8E8B7OG4QYJu
   LwYEUJNl3uHQAfAKNqkRQ/3pEeHHcaMjowq+nwnpxWV+6ZL7yUvsNJqZK
   wO3T7JCe79NT2iyOZo7ruRCV1NxaRzuhPP/j3u9URtPG6MJlP4/ht4TPG
   h+NOZ3L1lcsu0Jbg3nclNvFsshbO0f3i39koBnCgOpJtUApCiYzd6VS78
   8MQvMNaWt5EMH2y4Z/ubTuD9x+b9h7M/CI649NPWGIjRBaERLwopNDVhc
   4WlIwJ8z709cZvjopTlGdIC8md50yFdyA89QZfcodqU5aXUH1HMc44G6j
   Q==;
X-CSE-ConnectionGUID: uRhRC+zTTRC2jKspjh/aHQ==
X-CSE-MsgGUID: 0IAioraWS8OxfiNgoCBc9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75428204"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="75428204"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:41:51 -0700
X-CSE-ConnectionGUID: qyH/wK3MTgOitXoVX+1LZw==
X-CSE-MsgGUID: bZuYGIG0TdWFYRB4T80rHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185925369"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 31 Oct 2025 06:41:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEpNK-000N9A-1r;
	Fri, 31 Oct 2025 13:41:27 +0000
Date: Fri, 31 Oct 2025 21:30:56 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	pfalcato@suse.de, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <202510312143.SvwwhqVp-lkp@intel.com>
References: <20251030105242.801528-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030105242.801528-1-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on linus/master brauner-vfs/vfs.all linux/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-hide-names_cachep-behind-runtime-access-machinery/20251030-185523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251030105242.801528-1-mjguzik%40gmail.com
patch subject: [PATCH v4] fs: hide names_cachep behind runtime access machinery
config: riscv-randconfig-002-20251031 (https://download.01.org/0day-ci/archive/20251031/202510312143.SvwwhqVp-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510312143.SvwwhqVp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510312143.SvwwhqVp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:8:
   In file included from include/linux/mm.h:1016:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:53:
   In file included from arch/riscv/include/asm/runtime-const.h:7:
>> arch/riscv/include/asm/cacheflush.h:49:6: error: call to undeclared function 'is_vmalloc_or_module_addr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      49 |         if (is_vmalloc_or_module_addr((void *)start)) {
         |             ^
   In file included from arch/riscv/kernel/asm-offsets.c:8:
   In file included from include/linux/mm.h:1016:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:53:
   In file included from arch/riscv/include/asm/runtime-const.h:9:
   In file included from include/linux/memory.h:19:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/riscv/include/asm/elf.h:12:
   In file included from include/linux/compat.h:18:
   include/uapi/linux/aio_abi.h:79:2: error: unknown type name '__kernel_rwf_t'; did you mean '__kernel_off_t'?
      79 |         __kernel_rwf_t aio_rw_flags;    /* RWF_* flags */
         |         ^~~~~~~~~~~~~~
         |         __kernel_off_t
   include/uapi/asm-generic/posix_types.h:87:25: note: '__kernel_off_t' declared here
      87 | typedef __kernel_long_t __kernel_off_t;
         |                         ^
   2 errors generated.
   make[3]: *** [scripts/Makefile.build:182: arch/riscv/kernel/asm-offsets.s] Error 1 shuffle=1341192968
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2 shuffle=1341192968
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1341192968
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1341192968
   make: Target 'prepare' not remade because of errors.


vim +/is_vmalloc_or_module_addr +49 arch/riscv/include/asm/cacheflush.h

08f051eda33b51e Andrew Waterman 2017-10-25  42  
7e3811521dc3934 Alexandre Ghiti 2023-07-25  43  #ifdef CONFIG_64BIT
503638e0babf364 Alexandre Ghiti 2024-07-17  44  extern u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
503638e0babf364 Alexandre Ghiti 2024-07-17  45  extern char _end[];
503638e0babf364 Alexandre Ghiti 2024-07-17  46  #define flush_cache_vmap flush_cache_vmap
503638e0babf364 Alexandre Ghiti 2024-07-17  47  static inline void flush_cache_vmap(unsigned long start, unsigned long end)
503638e0babf364 Alexandre Ghiti 2024-07-17  48  {
503638e0babf364 Alexandre Ghiti 2024-07-17 @49  	if (is_vmalloc_or_module_addr((void *)start)) {
503638e0babf364 Alexandre Ghiti 2024-07-17  50  		int i;
503638e0babf364 Alexandre Ghiti 2024-07-17  51  
503638e0babf364 Alexandre Ghiti 2024-07-17  52  		/*
503638e0babf364 Alexandre Ghiti 2024-07-17  53  		 * We don't care if concurrently a cpu resets this value since
503638e0babf364 Alexandre Ghiti 2024-07-17  54  		 * the only place this can happen is in handle_exception() where
503638e0babf364 Alexandre Ghiti 2024-07-17  55  		 * an sfence.vma is emitted.
503638e0babf364 Alexandre Ghiti 2024-07-17  56  		 */
503638e0babf364 Alexandre Ghiti 2024-07-17  57  		for (i = 0; i < ARRAY_SIZE(new_vmalloc); ++i)
503638e0babf364 Alexandre Ghiti 2024-07-17  58  			new_vmalloc[i] = -1ULL;
503638e0babf364 Alexandre Ghiti 2024-07-17  59  	}
503638e0babf364 Alexandre Ghiti 2024-07-17  60  }
7a92fc8b4d20680 Alexandre Ghiti 2023-12-12  61  #define flush_cache_vmap_early(start, end)	local_flush_tlb_kernel_range(start, end)
7e3811521dc3934 Alexandre Ghiti 2023-07-25  62  #endif
7e3811521dc3934 Alexandre Ghiti 2023-07-25  63  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

