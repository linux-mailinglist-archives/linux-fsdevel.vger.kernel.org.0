Return-Path: <linux-fsdevel+bounces-66468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDDC202FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6F44E94CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67514354AF6;
	Thu, 30 Oct 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8Xdn32Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C633F38A;
	Thu, 30 Oct 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830054; cv=none; b=UEPuuoUR4Y+CUyMWVKCbdC+NL//cPhkL6zREbDnPI4BIaOGJ8k6Nbc5gMNfKPVMVwrmHcphewwXm7Q33ubxUTPkkICLCBCPNzo3JOSgGeX44RT3sQMVjPdgNUUT262u1bLlgkk9+wLcpd5nypttCgoDjJljJkORlStD2CMivRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830054; c=relaxed/simple;
	bh=vgYy0YR7cxPz/F9MMecj8OAQXS2Eto8/k7VHrXsHgkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ9rmERyLa0Qt9MtW79VpxbY7yp8B8ryYP8Iv0GSKmroCR6OGf336j07SpxqesbG+xbiTYx5pfrNcEVc9BHQ0nb5DXQh6kVdll/FllysuI32PZvZ3s1dedhxFz4ndLYCo/cVFrlAIitxawj7bpUC02cOlG2Xm6Hxway6OsyQqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8Xdn32Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830053; x=1793366053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgYy0YR7cxPz/F9MMecj8OAQXS2Eto8/k7VHrXsHgkk=;
  b=R8Xdn32Q7aYMBnOzmUaaTFnGesONoyxohLjpPjBiL2v95cztLrnFz1Cy
   oUktrKB2E8GKwYnwYoWyTYHnOV878S+n5KAR9+DlUR3KaM/6ZGeUCUQmz
   u4PjGaJOMGOyoUjrm+13X+x3v8ZUnc7RwXdVAUUCc5nMk8QNRbwGYN4R7
   w4EqSJe6vevX7d3AnYYrYl3estUnkUCfuAvHeqliitWo90g8WN/k5T2DZ
   /TpxAbxQb+YxTcQMDkSn27NdomqSEq6ftDlWHJ3kQpsk548QQOgdpKBvo
   bzaXBfhD/vI0dF769Sh7ZoG2dT62fV/RgXgcF8oq0OcN4wCidN4SRoqD0
   g==;
X-CSE-ConnectionGUID: ZZSO5RAtSbGQ9fRFvjOJnA==
X-CSE-MsgGUID: wqw4RIYqTbiwdbuPnutv1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81598766"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81598766"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:14:13 -0700
X-CSE-ConnectionGUID: 3BWR6up0RKK7QmzhDHseXg==
X-CSE-MsgGUID: 1Hep8LgGReGevykNIjiKfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186045472"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2025 06:14:10 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vESTb-000M0S-1B;
	Thu, 30 Oct 2025 13:14:07 +0000
Date: Thu, 30 Oct 2025 21:13:34 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <202510302004.OdLRz1Wy-lkp@intel.com>
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
[also build test ERROR on linus/master brauner-vfs/vfs.all linux/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-hide-names_cachep-behind-runtime-access-machinery/20251030-185523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251030105242.801528-1-mjguzik%40gmail.com
patch subject: [PATCH v4] fs: hide names_cachep behind runtime access machinery
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20251030/202510302004.OdLRz1Wy-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510302004.OdLRz1Wy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510302004.OdLRz1Wy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/runtime-const.h:7,
                    from include/linux/fs.h:53,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1016,
                    from arch/riscv/kernel/asm-offsets.c:8:
   arch/riscv/include/asm/cacheflush.h: In function 'flush_cache_vmap':
>> arch/riscv/include/asm/cacheflush.h:49:13: error: implicit declaration of function 'is_vmalloc_or_module_addr' [-Wimplicit-function-declaration]
      49 |         if (is_vmalloc_or_module_addr((void *)start)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compat.h:18,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/memory.h:19,
                    from arch/riscv/include/asm/runtime-const.h:9:
   include/uapi/linux/aio_abi.h: At top level:
>> include/uapi/linux/aio_abi.h:79:9: error: unknown type name '__kernel_rwf_t'; did you mean '__kernel_off_t'?
      79 |         __kernel_rwf_t aio_rw_flags;    /* RWF_* flags */
         |         ^~~~~~~~~~~~~~
         |         __kernel_off_t
   make[3]: *** [scripts/Makefile.build:182: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/is_vmalloc_or_module_addr +49 arch/riscv/include/asm/cacheflush.h

08f051eda33b51 Andrew Waterman 2017-10-25  42  
7e3811521dc393 Alexandre Ghiti 2023-07-25  43  #ifdef CONFIG_64BIT
503638e0babf36 Alexandre Ghiti 2024-07-17  44  extern u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
503638e0babf36 Alexandre Ghiti 2024-07-17  45  extern char _end[];
503638e0babf36 Alexandre Ghiti 2024-07-17  46  #define flush_cache_vmap flush_cache_vmap
503638e0babf36 Alexandre Ghiti 2024-07-17  47  static inline void flush_cache_vmap(unsigned long start, unsigned long end)
503638e0babf36 Alexandre Ghiti 2024-07-17  48  {
503638e0babf36 Alexandre Ghiti 2024-07-17 @49  	if (is_vmalloc_or_module_addr((void *)start)) {
503638e0babf36 Alexandre Ghiti 2024-07-17  50  		int i;
503638e0babf36 Alexandre Ghiti 2024-07-17  51  
503638e0babf36 Alexandre Ghiti 2024-07-17  52  		/*
503638e0babf36 Alexandre Ghiti 2024-07-17  53  		 * We don't care if concurrently a cpu resets this value since
503638e0babf36 Alexandre Ghiti 2024-07-17  54  		 * the only place this can happen is in handle_exception() where
503638e0babf36 Alexandre Ghiti 2024-07-17  55  		 * an sfence.vma is emitted.
503638e0babf36 Alexandre Ghiti 2024-07-17  56  		 */
503638e0babf36 Alexandre Ghiti 2024-07-17  57  		for (i = 0; i < ARRAY_SIZE(new_vmalloc); ++i)
503638e0babf36 Alexandre Ghiti 2024-07-17  58  			new_vmalloc[i] = -1ULL;
503638e0babf36 Alexandre Ghiti 2024-07-17  59  	}
503638e0babf36 Alexandre Ghiti 2024-07-17  60  }
7a92fc8b4d2068 Alexandre Ghiti 2023-12-12  61  #define flush_cache_vmap_early(start, end)	local_flush_tlb_kernel_range(start, end)
7e3811521dc393 Alexandre Ghiti 2023-07-25  62  #endif
7e3811521dc393 Alexandre Ghiti 2023-07-25  63  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

