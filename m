Return-Path: <linux-fsdevel+bounces-66680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F04C28867
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 00:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB5F3B1B67
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD92750FE;
	Sat,  1 Nov 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6ZjKzGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714431F5423;
	Sat,  1 Nov 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762038465; cv=none; b=rwPSrc5qj2HoQmODsSEUGvXFWlHBg/wp4ch2KZrnSQ0b37lTi/17jZda2y6Bkjib7e8dfe5qSgS1uKN+2X/QzR9CgUEHlUNcwhsXzrgdezqamke0+fUmlR1wMbyZXhuhOkH64Nv6A8pvovqpzkTvnhea8tOdzewh2fIVs1hm1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762038465; c=relaxed/simple;
	bh=8yy2OwXHcmHDE60teumXEGJ4XusSN4xuKXSB1M2WVz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6Ps3LuvoNKmkvlZi2LUBQXlvRCgeIoqi+lqjT9Pn6nKSCjS/4/CAR65uYWagfIpBimzTihNV6orvhxo26PgXvm1lH+hmBgNYeSMzhrlrygRtGr2kYERn7jVjLneh3gnOPl5gQE7Du0Ka63xgePVc/v8VkrB+6G1yemnoNn30gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6ZjKzGh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762038464; x=1793574464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8yy2OwXHcmHDE60teumXEGJ4XusSN4xuKXSB1M2WVz8=;
  b=j6ZjKzGhKor0aC5ik5385iFjZkn2+5UwB+Wcsoc1ZqkD5Dsa5s1yD7Cz
   DgfAOu5IQDgvNiXsGbwNfQKifiajO957jLDkgz+43IAeG/PLWDclThhSy
   EEO4sW4FcgkvXPiQdFB01ho0ISPDWaYqZwRVrC1/kZHNm+XcRTXO7ZnkW
   omR4abfcwygfXtYnivTklSj3LXSKJv26fqBqPRBqhXNdrXIwaQnXoo63/
   eS5innNty+hfYSTkvsdGAT6k8hNZAwUPVOrxrjLxc+Wb63VOtfRw7P5Oc
   uvRpQzMjhx3vVrmaMIyOTmfmEbIKUiWuwVpI52baEPkChUpFd31MDIT/z
   w==;
X-CSE-ConnectionGUID: u9NVyL+aRdmvMdxxGB5zvg==
X-CSE-MsgGUID: ugY0tFeKRuCC7RV9RISDpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="75278201"
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="75278201"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 16:07:44 -0700
X-CSE-ConnectionGUID: hHiXN5eDSiizEp5zIFxBoQ==
X-CSE-MsgGUID: sP+pOzMMRy6aLsXQyfusOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="186677906"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2025 16:07:41 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFKh8-000Okm-1G;
	Sat, 01 Nov 2025 23:07:38 +0000
Date: Sun, 2 Nov 2025 07:06:43 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <202511020603.NRNONOtT-lkp@intel.com>
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
[also build test ERROR on linus/master linux/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-hide-names_cachep-behind-runtime-access-machinery/20251101-054539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251030105242.801528-1-mjguzik%40gmail.com
patch subject: [PATCH v4] fs: hide names_cachep behind runtime access machinery
config: riscv-randconfig-r111-20251102 (https://download.01.org/0day-ci/archive/20251102/202511020603.NRNONOtT-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511020603.NRNONOtT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511020603.NRNONOtT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/runtime-const.h:7,
                    from include/linux/fs.h:53,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1016,
                    from arch/riscv/kernel/asm-offsets.c:8:
   arch/riscv/include/asm/cacheflush.h: In function 'flush_cache_vmap':
   arch/riscv/include/asm/cacheflush.h:49:13: error: implicit declaration of function 'is_vmalloc_or_module_addr' [-Werror=implicit-function-declaration]
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
                    from arch/riscv/include/asm/runtime-const.h:9,
                    from include/linux/fs.h:53,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1016,
                    from arch/riscv/kernel/asm-offsets.c:8:
   include/uapi/linux/aio_abi.h: At top level:
   include/uapi/linux/aio_abi.h:79:9: error: unknown type name '__kernel_rwf_t'
      79 |         __kernel_rwf_t aio_rw_flags;    /* RWF_* flags */
         |         ^~~~~~~~~~~~~~
   In file included from arch/riscv/kernel/asm-offsets.c:8:
>> include/linux/mm.h:1092:19: error: static declaration of 'is_vmalloc_or_module_addr' follows non-static declaration
    1092 | static inline int is_vmalloc_or_module_addr(const void *x)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/include/asm/runtime-const.h:7,
                    from include/linux/fs.h:53,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1016,
                    from arch/riscv/kernel/asm-offsets.c:8:
   arch/riscv/include/asm/cacheflush.h:49:13: note: previous implicit declaration of 'is_vmalloc_or_module_addr' with type 'int()'
      49 |         if (is_vmalloc_or_module_addr((void *)start)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:182: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/is_vmalloc_or_module_addr +1092 include/linux/mm.h

98b1917cdef92c David Hildenbrand       2025-04-10  1015  
71e3aac0724ffe Andrea Arcangeli        2011-01-13 @1016  #include <linux/huge_mm.h>
^1da177e4c3f41 Linus Torvalds          2005-04-16  1017  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1018  /*
^1da177e4c3f41 Linus Torvalds          2005-04-16  1019   * Methods to modify the page usage count.
^1da177e4c3f41 Linus Torvalds          2005-04-16  1020   *
^1da177e4c3f41 Linus Torvalds          2005-04-16  1021   * What counts for a page usage:
^1da177e4c3f41 Linus Torvalds          2005-04-16  1022   * - cache mapping   (page->mapping)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1023   * - private data    (page->private)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1024   * - page mapped in a task's page tables, each mapping
^1da177e4c3f41 Linus Torvalds          2005-04-16  1025   *   is counted separately
^1da177e4c3f41 Linus Torvalds          2005-04-16  1026   *
^1da177e4c3f41 Linus Torvalds          2005-04-16  1027   * Also, many kernel routines increase the page count before a critical
^1da177e4c3f41 Linus Torvalds          2005-04-16  1028   * routine so they can be sure the page doesn't go away from under them.
^1da177e4c3f41 Linus Torvalds          2005-04-16  1029   */
^1da177e4c3f41 Linus Torvalds          2005-04-16  1030  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1031  /*
da6052f7b33abe Nicholas Piggin         2006-09-25  1032   * Drop a ref, return true if the refcount fell to zero (the page has no users)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1033   */
7c8ee9a86340db Nicholas Piggin         2006-03-22  1034  static inline int put_page_testzero(struct page *page)
7c8ee9a86340db Nicholas Piggin         2006-03-22  1035  {
fe896d1878949e Joonsoo Kim             2016-03-17  1036  	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
fe896d1878949e Joonsoo Kim             2016-03-17  1037  	return page_ref_dec_and_test(page);
7c8ee9a86340db Nicholas Piggin         2006-03-22  1038  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1039  
b620f63358cd35 Matthew Wilcox (Oracle  2020-12-06  1040) static inline int folio_put_testzero(struct folio *folio)
b620f63358cd35 Matthew Wilcox (Oracle  2020-12-06  1041) {
b620f63358cd35 Matthew Wilcox (Oracle  2020-12-06  1042) 	return put_page_testzero(&folio->page);
b620f63358cd35 Matthew Wilcox (Oracle  2020-12-06  1043) }
b620f63358cd35 Matthew Wilcox (Oracle  2020-12-06  1044) 
^1da177e4c3f41 Linus Torvalds          2005-04-16  1045  /*
7c8ee9a86340db Nicholas Piggin         2006-03-22  1046   * Try to grab a ref unless the page has a refcount of zero, return false if
7c8ee9a86340db Nicholas Piggin         2006-03-22  1047   * that is the case.
8e0861fa3c4edf Alexey Kardashevskiy    2013-08-28  1048   * This can be called when MMU is off so it must not access
8e0861fa3c4edf Alexey Kardashevskiy    2013-08-28  1049   * any of the virtual mappings.
^1da177e4c3f41 Linus Torvalds          2005-04-16  1050   */
c25303281d7929 Matthew Wilcox (Oracle  2021-06-05  1051) static inline bool get_page_unless_zero(struct page *page)
7c8ee9a86340db Nicholas Piggin         2006-03-22  1052  {
fe896d1878949e Joonsoo Kim             2016-03-17  1053  	return page_ref_add_unless(page, 1, 0);
7c8ee9a86340db Nicholas Piggin         2006-03-22  1054  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1055  
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1056) static inline struct folio *folio_get_nontail_page(struct page *page)
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1057) {
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1058) 	if (unlikely(!get_page_unless_zero(page)))
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1059) 		return NULL;
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1060) 	return (struct folio *)page;
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1061) }
3c1ea2c729ef8e Vishal Moola (Oracle    2023-01-30  1062) 
53df8fdc15fb64 Wu Fengguang            2010-01-27  1063  extern int page_is_ram(unsigned long pfn);
124fe20d94630b Dan Williams            2015-08-10  1064  
124fe20d94630b Dan Williams            2015-08-10  1065  enum {
124fe20d94630b Dan Williams            2015-08-10  1066  	REGION_INTERSECTS,
124fe20d94630b Dan Williams            2015-08-10  1067  	REGION_DISJOINT,
124fe20d94630b Dan Williams            2015-08-10  1068  	REGION_MIXED,
124fe20d94630b Dan Williams            2015-08-10  1069  };
124fe20d94630b Dan Williams            2015-08-10  1070  
1c29f25bf5d6c5 Toshi Kani              2016-01-26  1071  int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
1c29f25bf5d6c5 Toshi Kani              2016-01-26  1072  		      unsigned long desc);
53df8fdc15fb64 Wu Fengguang            2010-01-27  1073  
48667e7a43c1a1 Christoph Lameter       2008-02-04  1074  /* Support for virtually mapped pages */
b3bdda02aa547a Christoph Lameter       2008-02-04  1075  struct page *vmalloc_to_page(const void *addr);
b3bdda02aa547a Christoph Lameter       2008-02-04  1076  unsigned long vmalloc_to_pfn(const void *addr);
48667e7a43c1a1 Christoph Lameter       2008-02-04  1077  
0738c4bb8f2a8b Paul Mundt              2008-03-12  1078  /*
0738c4bb8f2a8b Paul Mundt              2008-03-12  1079   * Determine if an address is within the vmalloc range
0738c4bb8f2a8b Paul Mundt              2008-03-12  1080   *
0738c4bb8f2a8b Paul Mundt              2008-03-12  1081   * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
0738c4bb8f2a8b Paul Mundt              2008-03-12  1082   * is no special casing required.
0738c4bb8f2a8b Paul Mundt              2008-03-12  1083   */
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1084  #ifdef CONFIG_MMU
186525bd6b83ef Ingo Molnar             2019-11-29  1085  extern bool is_vmalloc_addr(const void *x);
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1086  extern int is_vmalloc_or_module_addr(const void *x);
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1087  #else
186525bd6b83ef Ingo Molnar             2019-11-29  1088  static inline bool is_vmalloc_addr(const void *x)
186525bd6b83ef Ingo Molnar             2019-11-29  1089  {
186525bd6b83ef Ingo Molnar             2019-11-29  1090  	return false;
186525bd6b83ef Ingo Molnar             2019-11-29  1091  }
934831d060ccd5 David Howells           2009-09-24 @1092  static inline int is_vmalloc_or_module_addr(const void *x)
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1093  {
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1094  	return 0;
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1095  }
81ac3ad9061dd9 KAMEZAWA Hiroyuki       2009-09-22  1096  #endif
9e2779fa281cfd Christoph Lameter       2008-02-04  1097  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

