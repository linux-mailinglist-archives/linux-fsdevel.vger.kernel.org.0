Return-Path: <linux-fsdevel+bounces-63822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DFBCECD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 02:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B450519A44B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16918C2C;
	Sat, 11 Oct 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZR3PGBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2562163;
	Sat, 11 Oct 2025 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760141932; cv=none; b=eowNIN85gwlCRMXHXgRZ0XD2/mh/FypT7GAT+G1UCzkZ6bjVAFsnxZUknGt3Z1Te5+iTDi+EMYRp1cRiqjR8B/MU8cD8Agey2WfZ8vVQ5KPjjCZhtM2tEN5kfw++k5ZXqDj6QBU7qxt/f5vKAEWvsMAE4D2MPy32sH3INSWaKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760141932; c=relaxed/simple;
	bh=Z1HLkPNLXqEx6CBzT/O1i1dvLfQ37fBJBeUJtUKcJZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFyt+N3EmREpN2rwf5p5ni4tpNEcXS9NyyAUkwBkyU/txtHmzGVirYdbthzakITrLxN3OaQu5nqp3IROexa4uhnnDJKaSqCl7jPuq81R5C8cvWlWhGZqwaAUy2mnXrkPgjTiUgLDWmNIuCo3U2lq9gELv2o7Bu9FLc0tNJKANio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZR3PGBL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760141929; x=1791677929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1HLkPNLXqEx6CBzT/O1i1dvLfQ37fBJBeUJtUKcJZI=;
  b=AZR3PGBLALf4+ZUkdtbzR02d7pLr2IadsnPkR2/FveAsBX676eoaMkiI
   dhdZIQDfICJRMZ37Tw+EVsBPj/5tu3HoPF/K6mHWmKBtE/QXr0qwl6w9t
   /5QYSBHFJ4/t8RZBR/9joiZvlxEmrZH0Nj5xrqsKtHwOg6GNKV1fnumYJ
   Vz6926cdZKyqIPKheDUPLCn13qJCorVZqX8kMR5DPXXF2R4eA7vXORuc6
   byyL56czldn5A0Fjy6MOs750MS+EAi7uxRko44vZX/q9aWUf2m/bWonvG
   ycFfVtvCFICrr2JWMnkYVZIzHWqNIQb+0E1VoDGEFBTvUFXZHb7NQ4Qfu
   g==;
X-CSE-ConnectionGUID: rYnolmNYRHaiOfvUHCVR7Q==
X-CSE-MsgGUID: 9O9cZeRFT+6/wvP+PTCchQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="64985411"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="64985411"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 17:18:49 -0700
X-CSE-ConnectionGUID: oiYJHhVPRGaaZ9r7c+Bjnw==
X-CSE-MsgGUID: P4E/t/uQToq3ZX6uIrXbbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="186217447"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2025 17:18:44 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7NJq-0003K3-0l;
	Sat, 11 Oct 2025 00:18:42 +0000
Date: Sat, 11 Oct 2025 08:18:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Acs <acsjakub@amazon.de>, aliceryhl@google.com, djwong@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jhubbard@nvidia.com, acsjakub@amazon.de,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	chengming.zhou@linux.dev, david@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, peterx@redhat.com,
	rust-for-linux@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <202510110743.9G4osLTr-lkp@intel.com>
References: <20251008125427.68735-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008125427.68735-1-acsjakub@amazon.de>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Acs/mm-use-enum-for-vm_flags/20251010-124738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251008125427.68735-1-acsjakub%40amazon.de
patch subject: [PATCH] mm: use enum for vm_flags
config: s390-randconfig-001-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110743.9G4osLTr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110743.9G4osLTr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110743.9G4osLTr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h: In function 'p4d_alloc_one_noprof':
>> arch/s390/include/asm/pgalloc.h:62:2: error: implicit declaration of function 'pagetable_p4d_ctor' [-Werror=implicit-function-declaration]
      62 |  pagetable_p4d_ctor(virt_to_ptdesc(table));
         |  ^~~~~~~~~~~~~~~~~~
>> arch/s390/include/asm/pgalloc.h:62:21: error: implicit declaration of function 'virt_to_ptdesc'; did you mean 'virt_to_kpte'? [-Werror=implicit-function-declaration]
      62 |  pagetable_p4d_ctor(virt_to_ptdesc(table));
         |                     ^~~~~~~~~~~~~~
         |                     virt_to_kpte
   arch/s390/include/asm/pgalloc.h: In function 'p4d_free':
>> arch/s390/include/asm/pgalloc.h:73:2: error: implicit declaration of function 'pagetable_dtor'; did you mean 'page_table_free'? [-Werror=implicit-function-declaration]
      73 |  pagetable_dtor(virt_to_ptdesc(p4d));
         |  ^~~~~~~~~~~~~~
         |  page_table_free
   arch/s390/include/asm/pgalloc.h: In function 'pud_alloc_one_noprof':
>> arch/s390/include/asm/pgalloc.h:84:2: error: implicit declaration of function 'pagetable_pud_ctor' [-Werror=implicit-function-declaration]
      84 |  pagetable_pud_ctor(virt_to_ptdesc(table));
         |  ^~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/pgalloc.h: In function 'pmd_alloc_one_noprof':
>> arch/s390/include/asm/pgalloc.h:106:7: error: implicit declaration of function 'pagetable_pmd_ctor' [-Werror=implicit-function-declaration]
     106 |  if (!pagetable_pmd_ctor(mm, virt_to_ptdesc(table))) {
         |       ^~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/pgalloc.h: In function 'pgd_alloc_noprof':
>> arch/s390/include/asm/pgalloc.h:143:2: error: implicit declaration of function 'pagetable_pgd_ctor' [-Werror=implicit-function-declaration]
     143 |  pagetable_pgd_ctor(virt_to_ptdesc(table));
         |  ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   include/linux/mm.h: At top level:
>> include/linux/mm.h:3011:30: error: conflicting types for 'virt_to_ptdesc'
    3011 | static inline struct ptdesc *virt_to_ptdesc(const void *x)
         |                              ^~~~~~~~~~~~~~
   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h:62:21: note: previous implicit declaration of 'virt_to_ptdesc' was here
      62 |  pagetable_p4d_ctor(virt_to_ptdesc(table));
         |                     ^~~~~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
>> include/linux/mm.h:3152:20: warning: conflicting types for 'pagetable_dtor'
    3152 | static inline void pagetable_dtor(struct ptdesc *ptdesc)
         |                    ^~~~~~~~~~~~~~
>> include/linux/mm.h:3152:20: error: static declaration of 'pagetable_dtor' follows non-static declaration
   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h:73:2: note: previous implicit declaration of 'pagetable_dtor' was here
      73 |  pagetable_dtor(virt_to_ptdesc(p4d));
         |  ^~~~~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
>> include/linux/mm.h:3274:20: error: conflicting types for 'pagetable_pmd_ctor'
    3274 | static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h:106:7: note: previous implicit declaration of 'pagetable_pmd_ctor' was here
     106 |  if (!pagetable_pmd_ctor(mm, virt_to_ptdesc(table))) {
         |       ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
>> include/linux/mm.h:3303:20: warning: conflicting types for 'pagetable_pud_ctor'
    3303 | static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
         |                    ^~~~~~~~~~~~~~~~~~
>> include/linux/mm.h:3303:20: error: static declaration of 'pagetable_pud_ctor' follows non-static declaration
   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h:84:2: note: previous implicit declaration of 'pagetable_pud_ctor' was here
      84 |  pagetable_pud_ctor(virt_to_ptdesc(table));
         |  ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
>> include/linux/mm.h:3308:20: warning: conflicting types for 'pagetable_p4d_ctor'
    3308 | static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
         |                    ^~~~~~~~~~~~~~~~~~
>> include/linux/mm.h:3308:20: error: static declaration of 'pagetable_p4d_ctor' follows non-static declaration
   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h:62:2: note: previous implicit declaration of 'pagetable_p4d_ctor' was here
      62 |  pagetable_p4d_ctor(virt_to_ptdesc(table));
         |  ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
>> include/linux/mm.h:3313:20: warning: conflicting types for 'pagetable_pgd_ctor'
    3313 | static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
         |                    ^~~~~~~~~~~~~~~~~~
>> include/linux/mm.h:3313:20: error: static declaration of 'pagetable_pgd_ctor' follows non-static declaration
   In file included from arch/s390/include/asm/mmu_context.h:11,
                    from arch/s390/include/asm/elf.h:178,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/s390/include/asm/stacktrace.h:7,
                    from arch/s390/kernel/asm-offsets.c:15:
   arch/s390/include/asm/pgalloc.h:143:2: note: previous implicit declaration of 'pagetable_pgd_ctor' was here
     143 |  pagetable_pgd_ctor(virt_to_ptdesc(table));
         |  ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:182: arch/s390/kernel/asm-offsets.s] Error 1 shuffle=2098624972
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=2098624972
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2098624972
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2098624972
   make: Target 'prepare' not remade because of errors.


vim +/virt_to_ptdesc +3011 include/linux/mm.h

522abd92279a8e Matthew Wilcox (Oracle  2025-09-08  3010) 
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07 @3011) static inline struct ptdesc *virt_to_ptdesc(const void *x)
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3012) {
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3013) 	return page_ptdesc(virt_to_page(x));
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3014) }
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3015) 
90ec2df9dd3165 Matthew Wilcox (Oracle  2025-09-08  3016) /**
90ec2df9dd3165 Matthew Wilcox (Oracle  2025-09-08  3017)  * ptdesc_address - Virtual address of page table.
90ec2df9dd3165 Matthew Wilcox (Oracle  2025-09-08  3018)  * @pt: Page table descriptor.
90ec2df9dd3165 Matthew Wilcox (Oracle  2025-09-08  3019)  *
90ec2df9dd3165 Matthew Wilcox (Oracle  2025-09-08  3020)  * Return: The first byte of the page table described by @pt.
90ec2df9dd3165 Matthew Wilcox (Oracle  2025-09-08  3021)  */
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3022) static inline void *ptdesc_address(const struct ptdesc *pt)
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3023) {
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3024) 	return folio_address(ptdesc_folio(pt));
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3025) }
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3026) 
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3027) static inline bool pagetable_is_reserved(struct ptdesc *pt)
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3028) {
522abd92279a8e Matthew Wilcox (Oracle  2025-09-08  3029) 	return test_bit(PT_reserved, &pt->pt_flags.f);
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3030) }
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3031) 
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3032) /**
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3033)  * pagetable_alloc - Allocate pagetables
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3034)  * @gfp:    GFP flags
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3035)  * @order:  desired pagetable order
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3036)  *
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3037)  * pagetable_alloc allocates memory for page tables as well as a page table
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3038)  * descriptor to describe that memory.
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3039)  *
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3040)  * Return: The ptdesc describing the allocated page tables.
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3041)  */
2c321f3f70bc28 Suren Baghdasaryan      2024-04-14  3042  static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3043) {
2c321f3f70bc28 Suren Baghdasaryan      2024-04-14  3044  	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3045) 
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3046) 	return page_ptdesc(page);
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3047) }
2c321f3f70bc28 Suren Baghdasaryan      2024-04-14  3048  #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3049) 
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3050) /**
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3051)  * pagetable_free - Free pagetables
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3052)  * @pt:	The page table descriptor
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3053)  *
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3054)  * pagetable_free frees the memory of all page tables described by a page
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3055)  * table descriptor and the memory for the descriptor itself.
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3056)  */
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3057) static inline void pagetable_free(struct ptdesc *pt)
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3058) {
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3059) 	struct page *page = ptdesc_page(pt);
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3060) 
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3061) 	__free_pages(page, compound_order(page));
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3062) }
bf2d4334f72e4e Vishal Moola (Oracle    2023-08-07  3063) 
394290cba9664e David Hildenbrand       2024-07-26  3064  #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
597d795a2a786d Kirill A. Shutemov      2013-12-20  3065  #if ALLOC_SPLIT_PTLOCKS
b35f1819acd924 Kirill A. Shutemov      2014-01-21  3066  void __init ptlock_cache_init(void);
f5ecca06b3a5d0 Vishal Moola (Oracle    2023-08-07  3067) bool ptlock_alloc(struct ptdesc *ptdesc);
6ed1b8a09deb0b Vishal Moola (Oracle    2023-08-07  3068) void ptlock_free(struct ptdesc *ptdesc);
539edb5846c740 Peter Zijlstra          2013-11-14  3069  
1865484af6b2ce Vishal Moola (Oracle    2023-08-07  3070) static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
539edb5846c740 Peter Zijlstra          2013-11-14  3071  {
1865484af6b2ce Vishal Moola (Oracle    2023-08-07  3072) 	return ptdesc->ptl;
539edb5846c740 Peter Zijlstra          2013-11-14  3073  }
597d795a2a786d Kirill A. Shutemov      2013-12-20  3074  #else /* ALLOC_SPLIT_PTLOCKS */
b35f1819acd924 Kirill A. Shutemov      2014-01-21  3075  static inline void ptlock_cache_init(void)
b35f1819acd924 Kirill A. Shutemov      2014-01-21  3076  {
b35f1819acd924 Kirill A. Shutemov      2014-01-21  3077  }
b35f1819acd924 Kirill A. Shutemov      2014-01-21  3078  
f5ecca06b3a5d0 Vishal Moola (Oracle    2023-08-07  3079) static inline bool ptlock_alloc(struct ptdesc *ptdesc)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3080  {
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3081  	return true;
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3082  }
539edb5846c740 Peter Zijlstra          2013-11-14  3083  
6ed1b8a09deb0b Vishal Moola (Oracle    2023-08-07  3084) static inline void ptlock_free(struct ptdesc *ptdesc)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3085  {
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3086  }
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3087  
1865484af6b2ce Vishal Moola (Oracle    2023-08-07  3088) static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3089  {
1865484af6b2ce Vishal Moola (Oracle    2023-08-07  3090) 	return &ptdesc->ptl;
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3091  }
597d795a2a786d Kirill A. Shutemov      2013-12-20  3092  #endif /* ALLOC_SPLIT_PTLOCKS */
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3093  
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3094  static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3095  {
1865484af6b2ce Vishal Moola (Oracle    2023-08-07  3096) 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3097  }
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3098  
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3099  static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3100  {
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3101  	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3102  	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3103  	return ptlock_ptr(virt_to_ptdesc(pte));
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3104  }
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3105  
75b25d49ca6638 Vishal Moola (Oracle    2023-08-07  3106) static inline bool ptlock_init(struct ptdesc *ptdesc)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3107  {
4c21e2f2441dc5 Hugh Dickins            2005-10-29  3108  	/*
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3109  	 * prep_new_page() initialize page->private (and therefore page->ptl)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3110  	 * with 0. Make sure nobody took it in use in between.
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3111  	 *
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3112  	 * It can happen if arch try to use slab for page table allocation:
1d798ca3f16437 Kirill A. Shutemov      2015-11-06  3113  	 * slab code uses page->slab_cache, which share storage with page->ptl.
4c21e2f2441dc5 Hugh Dickins            2005-10-29  3114  	 */
75b25d49ca6638 Vishal Moola (Oracle    2023-08-07  3115) 	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
75b25d49ca6638 Vishal Moola (Oracle    2023-08-07  3116) 	if (!ptlock_alloc(ptdesc))
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3117  		return false;
75b25d49ca6638 Vishal Moola (Oracle    2023-08-07  3118) 	spin_lock_init(ptlock_ptr(ptdesc));
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3119  	return true;
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3120  }
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3121  
394290cba9664e David Hildenbrand       2024-07-26  3122  #else	/* !defined(CONFIG_SPLIT_PTE_PTLOCKS) */
4c21e2f2441dc5 Hugh Dickins            2005-10-29  3123  /*
4c21e2f2441dc5 Hugh Dickins            2005-10-29  3124   * We use mm->page_table_lock to guard all pagetable pages of the mm.
4c21e2f2441dc5 Hugh Dickins            2005-10-29  3125   */
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3126  static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3127  {
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3128  	return &mm->page_table_lock;
49076ec2ccaf68 Kirill A. Shutemov      2013-11-14  3129  }
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3130  static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3131  {
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3132  	return &mm->page_table_lock;
5f75cfbd6bb022 David Hildenbrand       2024-08-01  3133  }
b35f1819acd924 Kirill A. Shutemov      2014-01-21  3134  static inline void ptlock_cache_init(void) {}
75b25d49ca6638 Vishal Moola (Oracle    2023-08-07  3135) static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
6ed1b8a09deb0b Vishal Moola (Oracle    2023-08-07  3136) static inline void ptlock_free(struct ptdesc *ptdesc) {}
394290cba9664e David Hildenbrand       2024-07-26  3137  #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
4c21e2f2441dc5 Hugh Dickins            2005-10-29  3138  
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3139) static inline unsigned long ptdesc_nr_pages(const struct ptdesc *ptdesc)
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3140) {
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3141) 	return compound_nr(ptdesc_page(ptdesc));
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3142) }
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3143) 
11e2400b21a3e2 Kevin Brodsky           2025-01-03  3144  static inline void __pagetable_ctor(struct ptdesc *ptdesc)
2f569afd9ced9e Martin Schwidefsky      2008-02-08  3145  {
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3146) 	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
7e11dca14b27e1 Vishal Moola (Oracle    2023-08-07  3147) 
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3148) 	__SetPageTable(ptdesc_page(ptdesc));
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3149) 	mod_node_page_state(pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
2f569afd9ced9e Martin Schwidefsky      2008-02-08  3150  }
2f569afd9ced9e Martin Schwidefsky      2008-02-08  3151  
db6b435d731a8d Qi Zheng                2025-01-08 @3152  static inline void pagetable_dtor(struct ptdesc *ptdesc)
7e11dca14b27e1 Vishal Moola (Oracle    2023-08-07  3153) {
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3154) 	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
7e11dca14b27e1 Vishal Moola (Oracle    2023-08-07  3155) 
7e11dca14b27e1 Vishal Moola (Oracle    2023-08-07  3156) 	ptlock_free(ptdesc);
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3157) 	__ClearPageTable(ptdesc_page(ptdesc));
f0c92726e89f5c Matthew Wilcox (Oracle  2025-09-08  3158) 	mod_node_page_state(pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc));
7e11dca14b27e1 Vishal Moola (Oracle    2023-08-07  3159) }
7e11dca14b27e1 Vishal Moola (Oracle    2023-08-07  3160) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

