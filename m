Return-Path: <linux-fsdevel+bounces-66451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD4C1F977
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FC14209AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BC733C510;
	Thu, 30 Oct 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2fcxNj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954223321D8;
	Thu, 30 Oct 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820559; cv=none; b=XAaJvOHvsUb04glHRbc6rudSCWaKr9XsNRynSXl+GWsM+HPTDyY50ABBHrK/mlE4Q6/k7vl19remtdxqAHZSJkF4bsmY5VIxnX1z/FB764i5ruhQeF35GzAEgGjqfJgtARj9tfql3N+eeUDWfAKU0jZtAdqne1B7PwcbDVMKN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820559; c=relaxed/simple;
	bh=by0w7O7HoK/w+fE/pIQpFafY70tU8ouLMgrp2oBT7os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhDD6uej7MpGDtUUmkoYFItymaYrffxLCdskOQPMhrrx2Gipdu6tUujPY3Lk5vI5frhzYzUo7AqI7af/nc+PITep8DZZ9CaH8Iyf79KRQn9RAh4IMQZvX6Eyk4tycGe8pHs4eSntwMBitfFcen5rv99N9Wa0jLU3WgBQKvBjn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2fcxNj0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761820558; x=1793356558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=by0w7O7HoK/w+fE/pIQpFafY70tU8ouLMgrp2oBT7os=;
  b=T2fcxNj0aE9QNIxaCjwpXhcTOWmI1CxMDy51ic7ODcyE57JfvcMjLrwb
   7CVDuTcq9hxUcgEQRGitmfLLBjcnpvRuf3TG4ByyExImcJ249kid/fCC+
   qb0fhcnrUXB4llbwTuuw9GcSxc00ZP2s8P6/HORinCVbfgxBw0Ee9nIKi
   mxELDdLZzoKqs8+LQnX1RnWSWRvfBei3IoCnO1uYeqcnvE8M0CYFzLBx7
   /5XXqkoF+UivBFY7Kf+jK/ey5MBRi1xHkJ1ct1x2LpO3SwFqOb0q3i6Va
   nEmsEHFOTRVSYG4OKaH+G9qk2Zur8V5jWOumh2pEvo2TTZPNGAVaopBIv
   A==;
X-CSE-ConnectionGUID: 0fSjNgkFSnqBzqY4Ikx6Lg==
X-CSE-MsgGUID: HPzrtYUER5CDBh23gfITyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86585158"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="86585158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:35:57 -0700
X-CSE-ConnectionGUID: 6hq54BEsQV6ZdY1xUhrlJg==
X-CSE-MsgGUID: 5MQcglm8S4Kh6/k10x0mbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="191085941"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2025 03:35:54 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEQ0W-000Lpw-1X;
	Thu, 30 Oct 2025 10:35:52 +0000
Date: Thu, 30 Oct 2025 18:34:55 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2] fs: hide names_cachep behind runtime access machinery
Message-ID: <202510301846.5be7UPQy-lkp@intel.com>
References: <20251030085949.787504-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030085949.787504-1-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on linus/master brauner-vfs/vfs.all linux/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-hide-names_cachep-behind-runtime-access-machinery/20251030-170230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251030085949.787504-1-mjguzik%40gmail.com
patch subject: [PATCH v2] fs: hide names_cachep behind runtime access machinery
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20251030/202510301846.5be7UPQy-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301846.5be7UPQy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301846.5be7UPQy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/percpu.h:5,
                    from include/linux/radix-tree.h:16,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from drivers/base/firmware_loader/main.c:14:
   drivers/base/firmware_loader/main.c: In function 'fw_get_filesystem_firmware':
   include/linux/fs.h:2965:33: error: implicit declaration of function 'runtime_const_ptr' [-Werror=implicit-function-declaration]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   drivers/base/firmware_loader/main.c:509:16: note: in expansion of macro '__getname'
     509 |         path = __getname();
         |                ^~~~~~~~~
>> include/linux/fs.h:2965:33: warning: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   drivers/base/firmware_loader/main.c:509:16: note: in expansion of macro '__getname'
     509 |         path = __getname();
         |                ^~~~~~~~~
   In file included from include/linux/mm.h:34,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/base/firmware_loader/main.c:14:
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
   In file included from include/linux/percpu.h:5,
                    from include/linux/radix-tree.h:16,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from drivers/base/firmware_loader/main.c:14:
>> include/linux/fs.h:2965:33: warning: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:243:24: note: in definition of macro 'alloc_hooks_tag'
     243 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   drivers/base/firmware_loader/main.c:509:16: note: in expansion of macro '__getname'
     509 |         path = __getname();
         |                ^~~~~~~~~
   In file included from include/linux/mm.h:34,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/base/firmware_loader/main.c:14:
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
   In file included from include/linux/percpu.h:5,
                    from include/linux/radix-tree.h:16,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from drivers/base/firmware_loader/main.c:14:
>> include/linux/fs.h:2965:33: warning: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:246:24: note: in definition of macro 'alloc_hooks_tag'
     246 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   drivers/base/firmware_loader/main.c:509:16: note: in expansion of macro '__getname'
     509 |         path = __getname();
         |                ^~~~~~~~~
   In file included from include/linux/mm.h:34,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/base/firmware_loader/main.c:14:
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
   In file included from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1016,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/base/firmware_loader/main.c:14:
>> include/linux/fs.h:2965:33: warning: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   drivers/base/firmware_loader/main.c:591:9: note: in expansion of macro '__putname'
     591 |         __putname(path);
         |         ^~~~~~~~~
   In file included from include/linux/mm.h:34,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/base/firmware_loader/main.c:14:
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
   cc1: some warnings being treated as errors


vim +/kmem_cache_alloc_noprof +2965 include/linux/fs.h

  2958	
  2959	/*
  2960	 * XXX The runtime_const machinery does not support modules at the moment.
  2961	 */
  2962	#ifdef MODULE
  2963	#define __names_cachep		names_cachep
  2964	#else
> 2965	#define __names_cachep		runtime_const_ptr(names_cachep)
  2966	#endif
  2967	
> 2968	#define __getname()		kmem_cache_alloc(__names_cachep, GFP_KERNEL)
  2969	#define __putname(name)		kmem_cache_free(__names_cachep, (void *)(name))
  2970	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

