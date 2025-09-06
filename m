Return-Path: <linux-fsdevel+bounces-60451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D8B46E2E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CA37B8BC6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47442ECEAB;
	Sat,  6 Sep 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cubhjgF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4800286D7C;
	Sat,  6 Sep 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165511; cv=none; b=HT0xoVF2OYN1Y9fmvfMm4uO4HH78GopbuMd49cdqjcDmglvQbVU0NUPYFnz+8MzzBDFnJ9Il0xmO9D8p+c/+3fVe2I70NcN5KG240O73/HqK2oVlEWFZIQ54NUeWq/1uymRRe5O++30Kz9/HUe7eZYWGG7B/7w8pySYQZF8dUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165511; c=relaxed/simple;
	bh=JxpVAPprCj1/cOsB/r2kwrJ/LKeJT1ayD6hStYXR2fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBERHgr9tu8poS1WRtAvJcFYKHOurTnPWFkKx7qkm85G0CsMkDbzCP8p34xEa6oKFWQdVPrtn5SoCjnzeEMG8l4DGrzWtMdIkKm6kys37UE9RWjiWcm5KutCuwOjTgKOOHTTYzilfT2wrbWw+/vAfScLqE9vFvKn1lpNO9BpgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cubhjgF3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757165509; x=1788701509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JxpVAPprCj1/cOsB/r2kwrJ/LKeJT1ayD6hStYXR2fA=;
  b=cubhjgF3QLTm7UQokG7wB3RQijmLoQnj7zxf1gEWuTmqxnFcmlRtuA1I
   KWAiUo0pZVIKedauK/bxh1h46kD3N1jgDBaWQRtwRti8JiBhLgCe6EM+k
   qhN2rfRiJtoc+7bb6LMtyQKamdgW516mAzJbIQb6kWrmx2qyf4Z5kdnUi
   sz6hOBLx0j2grXBngd0RPB+qFaOq57o/ZKDBi64SDhOLgVztfhh7jHT/c
   DoJR1ZKCoun8s0tYPBXl441pe87JAZhDsz9+oro/PZ2rk2KglkAMPQ+aI
   DFkFJByiIOqI90decw/5PnZht08rs5xo4aEha+e1z5EXneG6Y6f6vPWL1
   g==;
X-CSE-ConnectionGUID: caiaVO1xSbK0CsYOoBP5JQ==
X-CSE-MsgGUID: Wk3xLB3RQzellvnFLYPpaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82083292"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82083292"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 06:31:48 -0700
X-CSE-ConnectionGUID: 3JrKiGFBTfW5BencZrBXMw==
X-CSE-MsgGUID: 9JDGkvDmT02J1DrNzFJAng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="176730549"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2025 06:31:42 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uut12-0001VP-0c;
	Sat, 06 Sep 2025 13:31:40 +0000
Date: Sat, 6 Sep 2025 21:31:09 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Wei Xu <weixugc@google.com>, David Hildenbrand <david@redhat.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v9 2/5] mm: uffd_wp: Add pte_uffd_wp_available()
Message-ID: <202509062145.1ipU0q7y-lkp@intel.com>
References: <20250905103651.489197-3-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905103651.489197-3-zhangchunyan@iscas.ac.cn>

Hi Chunyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.17-rc4]
[cannot apply to akpm-mm/mm-everything arnd-asm-generic/master next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunyan-Zhang/mm-softdirty-Add-pte_soft_dirty_available/20250905-184138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250905103651.489197-3-zhangchunyan%40iscas.ac.cn
patch subject: [PATCH v9 2/5] mm: uffd_wp: Add pte_uffd_wp_available()
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20250906/202509062145.1ipU0q7y-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509062145.1ipU0q7y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509062145.1ipU0q7y-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/../mm/internal.h:13,
                    from fs/exec.c:82:
   include/linux/mm_inline.h: In function 'pte_install_uffd_wp_if_needed':
>> include/linux/mm_inline.h:573:56: error: implicit declaration of function 'pte_uffd_wp_available'; did you mean 'pte_soft_dirty_available'? [-Wimplicit-function-declaration]
     573 |         if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) || !pte_uffd_wp_available())
         |                                                        ^~~~~~~~~~~~~~~~~~~~~
         |                                                        pte_soft_dirty_available
   In file included from include/asm-generic/bug.h:7,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/exec.c:27:
>> include/linux/mm_inline.h:579:23: error: implicit declaration of function 'pte_none'; did you mean 'p4d_none'? [-Wimplicit-function-declaration]
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |                       ^~~~~~~~
   include/linux/once_lite.h:28:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/linux/mm_inline.h:579:9: note: in expansion of macro 'WARN_ON_ONCE'
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |         ^~~~~~~~~~~~
>> include/linux/mm_inline.h:579:32: error: implicit declaration of function 'ptep_get' [-Wimplicit-function-declaration]
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |                                ^~~~~~~~
   include/linux/once_lite.h:28:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/linux/mm_inline.h:579:9: note: in expansion of macro 'WARN_ON_ONCE'
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |         ^~~~~~~~~~~~
   In file included from include/linux/file.h:9,
                    from include/linux/kernel_read_file.h:5,
                    from fs/exec.c:26:
>> include/linux/mm_inline.h:591:22: error: implicit declaration of function 'pte_present'; did you mean 'p4d_present'? [-Wimplicit-function-declaration]
     591 |         if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
         |                      ^~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> include/linux/mm_inline.h:591:45: error: implicit declaration of function 'pte_uffd_wp' [-Wimplicit-function-declaration]
     591 |         if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
         |                                             ^~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> include/linux/mm_inline.h:602:17: error: implicit declaration of function 'set_pte_at'; did you mean 'user_path_at'? [-Wimplicit-function-declaration]
     602 |                 set_pte_at(vma->vm_mm, addr, pte,
         |                 ^~~~~~~~~~
         |                 user_path_at
>> include/linux/mm_inline.h:603:28: error: implicit declaration of function 'make_pte_marker' [-Wimplicit-function-declaration]
     603 |                            make_pte_marker(PTE_MARKER_UFFD_WP));
         |                            ^~~~~~~~~~~~~~~
>> include/linux/mm_inline.h:603:44: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     603 |                            make_pte_marker(PTE_MARKER_UFFD_WP));
         |                                            ^~~~~~~~~~~~~~~~~~
   include/linux/mm_inline.h:603:44: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from fs/splice.c:27:
   include/linux/mm_inline.h: In function 'pte_install_uffd_wp_if_needed':
>> include/linux/mm_inline.h:573:56: error: implicit declaration of function 'pte_uffd_wp_available'; did you mean 'pte_soft_dirty_available'? [-Wimplicit-function-declaration]
     573 |         if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) || !pte_uffd_wp_available())
         |                                                        ^~~~~~~~~~~~~~~~~~~~~
         |                                                        pte_soft_dirty_available
   In file included from include/asm-generic/bug.h:7,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/vfsdebug.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from fs/splice.c:21:
>> include/linux/mm_inline.h:579:23: error: implicit declaration of function 'pte_none'; did you mean 'p4d_none'? [-Wimplicit-function-declaration]
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |                       ^~~~~~~~
   include/linux/once_lite.h:28:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/linux/mm_inline.h:579:9: note: in expansion of macro 'WARN_ON_ONCE'
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |         ^~~~~~~~~~~~
>> include/linux/mm_inline.h:579:32: error: implicit declaration of function 'ptep_get' [-Wimplicit-function-declaration]
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |                                ^~~~~~~~
   include/linux/once_lite.h:28:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/linux/mm_inline.h:579:9: note: in expansion of macro 'WARN_ON_ONCE'
     579 |         WARN_ON_ONCE(!pte_none(ptep_get(pte)));
         |         ^~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5:
>> include/linux/mm_inline.h:591:22: error: implicit declaration of function 'pte_present'; did you mean 'p4d_present'? [-Wimplicit-function-declaration]
     591 |         if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
         |                      ^~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> include/linux/mm_inline.h:591:45: error: implicit declaration of function 'pte_uffd_wp' [-Wimplicit-function-declaration]
     591 |         if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
         |                                             ^~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/mm_inline.h:602:17: error: implicit declaration of function 'set_pte_at' [-Wimplicit-function-declaration]
     602 |                 set_pte_at(vma->vm_mm, addr, pte,
         |                 ^~~~~~~~~~
>> include/linux/mm_inline.h:603:28: error: implicit declaration of function 'make_pte_marker' [-Wimplicit-function-declaration]
     603 |                            make_pte_marker(PTE_MARKER_UFFD_WP));
         |                            ^~~~~~~~~~~~~~~
>> include/linux/mm_inline.h:603:44: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     603 |                            make_pte_marker(PTE_MARKER_UFFD_WP));
         |                                            ^~~~~~~~~~~~~~~~~~
   include/linux/mm_inline.h:603:44: note: each undeclared identifier is reported only once for each function it appears in


vim +573 include/linux/mm_inline.h

   556	
   557	/*
   558	 * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
   559	 * replace a none pte.  NOTE!  This should only be called when *pte is already
   560	 * cleared so we will never accidentally replace something valuable.  Meanwhile
   561	 * none pte also means we are not demoting the pte so tlb flushed is not needed.
   562	 * E.g., when pte cleared the caller should have taken care of the tlb flush.
   563	 *
   564	 * Must be called with pgtable lock held so that no thread will see the none
   565	 * pte, and if they see it, they'll fault and serialize at the pgtable lock.
   566	 *
   567	 * Returns true if an uffd-wp pte was installed, false otherwise.
   568	 */
   569	static inline bool
   570	pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
   571				      pte_t *pte, pte_t pteval)
   572	{
 > 573		if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) || !pte_uffd_wp_available())
   574			return false;
   575	
   576		bool arm_uffd_pte = false;
   577	
   578		/* The current status of the pte should be "cleared" before calling */
 > 579		WARN_ON_ONCE(!pte_none(ptep_get(pte)));
   580	
   581		/*
   582		 * NOTE: userfaultfd_wp_unpopulated() doesn't need this whole
   583		 * thing, because when zapping either it means it's dropping the
   584		 * page, or in TTU where the present pte will be quickly replaced
   585		 * with a swap pte.  There's no way of leaking the bit.
   586		 */
   587		if (vma_is_anonymous(vma) || !userfaultfd_wp(vma))
   588			return false;
   589	
   590		/* A uffd-wp wr-protected normal pte */
 > 591		if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
   592			arm_uffd_pte = true;
   593	
   594		/*
   595		 * A uffd-wp wr-protected swap pte.  Note: this should even cover an
   596		 * existing pte marker with uffd-wp bit set.
   597		 */
   598		if (unlikely(pte_swp_uffd_wp_any(pteval)))
   599			arm_uffd_pte = true;
   600	
   601		if (unlikely(arm_uffd_pte)) {
 > 602			set_pte_at(vma->vm_mm, addr, pte,
 > 603				   make_pte_marker(PTE_MARKER_UFFD_WP));
   604			return true;
   605		}
   606	
   607		return false;
   608	}
   609	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

