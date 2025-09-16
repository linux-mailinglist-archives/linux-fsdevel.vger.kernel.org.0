Return-Path: <linux-fsdevel+bounces-61695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF8FB58E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 07:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC45C1891DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 05:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C52DF137;
	Tue, 16 Sep 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJo06bH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB090288535;
	Tue, 16 Sep 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002163; cv=none; b=hJa93T6VkzjoYrmwAa01xIqD6niez8I+mg7h+mer/bCPUpO+UXLHOCdW3Suro0ephbFViThcfIJ4rPsOvkqhXAfFfezYAwuj7m2B0NLR8+rC+g1g7kWLCCvMTw1irhb+qUMndc9U325qfk8GmtDqPP8zUYREz/XFBYLajF9W4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002163; c=relaxed/simple;
	bh=TI1GQ9/fie5SEXhyuw4/SGhlUqJfUF1ZYY8Qg3rWUHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQiOoWuY6OMmFiF3EvJfubkZGuFhxKWIeIZDBoIhg5J+ao2CkkoOfmeECsHgZMcTim2FkRvMxHZ9MO4RTql1VNAzMGmo0GPy7ZV+mqiHvZE0RiAUnDmLJ8wC22GeGWO5ABqbBwxnpqqOczj5DmYZN1n1BrDt4MFuUo5Ia/SKV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJo06bH6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758002162; x=1789538162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TI1GQ9/fie5SEXhyuw4/SGhlUqJfUF1ZYY8Qg3rWUHs=;
  b=FJo06bH6bqzuS5uSaHL3Ijc5v4cw/C2Sw+NZNuOJDxq4YvJjj9I4OZGO
   aKrljr+HE6G/t3yVQU8n3N27+MLaBUP/c6WFOxexVEzhzy9Illj0Dd0nW
   gfLob23lFA0uv7oMqaRL63/3erqEaoR4Ahw4Ui2FDPYARHj60HhUMnGbF
   9gBHNUAmx2PCZhBMssDlywO1qQeRjZQHVXUQBjd90FXVUKbXsWxbniag8
   ZbdtY5CBmJicIXMi4zhOqvttPB6a+//kBUa83mVHdOMpuEF32J1YP4DGx
   Jwm4XrXviKxhJESIJx/Cp6Jk8k3gcWfG8WaN+t4khC0rWAabVUPoM/mKl
   Q==;
X-CSE-ConnectionGUID: zKeu0PKxR12hERrQwX1sZA==
X-CSE-MsgGUID: yvtgK+C/SeuyrZBWbI6Vzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70520770"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70520770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 22:56:01 -0700
X-CSE-ConnectionGUID: 4bV9z9nLQ3WfqI99ueea9g==
X-CSE-MsgGUID: LxHVe4F5R4ioJetCgS766w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2025 22:55:55 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyOfQ-00012O-2o;
	Tue, 16 Sep 2025 05:55:52 +0000
Date: Tue, 16 Sep 2025 13:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V12 2/5] mm: userfaultfd: Add pgtable_supports_uffd_wp()
Message-ID: <202509161304.mQnxOxhS-lkp@intel.com>
References: <20250915101343.1449546-3-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915101343.1449546-3-zhangchunyan@iscas.ac.cn>

Hi Chunyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on kees/for-next/execve linus/master v6.17-rc6]
[cannot apply to akpm-mm/mm-everything next-20250915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunyan-Zhang/mm-softdirty-Add-pgtable_supports_soft_dirty/20250915-181826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250915101343.1449546-3-zhangchunyan%40iscas.ac.cn
patch subject: [PATCH V12 2/5] mm: userfaultfd: Add pgtable_supports_uffd_wp()
config: riscv-randconfig-002-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161304.mQnxOxhS-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161304.mQnxOxhS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509161304.mQnxOxhS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_inline.h:10,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:441:9: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     441 |  return is_pte_marker_entry(entry) &&
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:442:10: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     442 |         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |          ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:442:34: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     442 |         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:442:34: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/userfaultfd_k.h: In function 'pte_marker_uffd_wp':
>> include/linux/userfaultfd_k.h:452:7: error: implicit declaration of function 'is_swap_pte'; did you mean 'is_swap_pmd'? [-Werror=implicit-function-declaration]
     452 |  if (!is_swap_pte(pte))
         |       ^~~~~~~~~~~
         |       is_swap_pmd
>> include/linux/userfaultfd_k.h:455:10: error: implicit declaration of function 'pte_to_swp_entry' [-Werror=implicit-function-declaration]
     455 |  entry = pte_to_swp_entry(pte);
         |          ^~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:455:10: error: incompatible types when assigning to type 'swp_entry_t' from type 'int'
   In file included from include/linux/mm_inline.h:11,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
   include/linux/swapops.h: At top level:
>> include/linux/swapops.h:124:19: error: static declaration of 'is_swap_pte' follows non-static declaration
     124 | static inline int is_swap_pte(pte_t pte)
         |                   ^~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
   include/linux/userfaultfd_k.h:452:7: note: previous implicit declaration of 'is_swap_pte' was here
     452 |  if (!is_swap_pte(pte))
         |       ^~~~~~~~~~~
   In file included from include/linux/mm_inline.h:11,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
>> include/linux/swapops.h:133:27: error: conflicting types for 'pte_to_swp_entry'
     133 | static inline swp_entry_t pte_to_swp_entry(pte_t pte)
         |                           ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
   include/linux/userfaultfd_k.h:455:10: note: previous implicit declaration of 'pte_to_swp_entry' was here
     455 |  entry = pte_to_swp_entry(pte);
         |          ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:11,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
>> include/linux/swapops.h:429:20: error: conflicting types for 'is_pte_marker_entry'
     429 | static inline bool is_pte_marker_entry(swp_entry_t entry)
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
   include/linux/userfaultfd_k.h:441:9: note: previous implicit declaration of 'is_pte_marker_entry' was here
     441 |  return is_pte_marker_entry(entry) &&
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:11,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
>> include/linux/swapops.h:434:26: error: conflicting types for 'pte_marker_get'
     434 | static inline pte_marker pte_marker_get(swp_entry_t entry)
         |                          ^~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/internal.h:13,
                    from mm/page_frag_cache.c:21:
   include/linux/userfaultfd_k.h:442:10: note: previous implicit declaration of 'pte_marker_get' was here
     442 |         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |          ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/mm_inline.h:10,
                    from mm/mremap.c:12:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:441:9: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     441 |  return is_pte_marker_entry(entry) &&
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:442:10: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     442 |         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |          ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:442:34: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     442 |         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:442:34: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/userfaultfd_k.h: In function 'pte_marker_uffd_wp':
>> include/linux/userfaultfd_k.h:452:7: error: implicit declaration of function 'is_swap_pte'; did you mean 'is_swap_pmd'? [-Werror=implicit-function-declaration]
     452 |  if (!is_swap_pte(pte))
         |       ^~~~~~~~~~~
         |       is_swap_pmd
>> include/linux/userfaultfd_k.h:455:10: error: implicit declaration of function 'pte_to_swp_entry' [-Werror=implicit-function-declaration]
     455 |  entry = pte_to_swp_entry(pte);
         |          ^~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:455:10: error: incompatible types when assigning to type 'swp_entry_t' from type 'int'
   In file included from include/linux/mm_inline.h:11,
                    from mm/mremap.c:12:
   include/linux/swapops.h: At top level:
>> include/linux/swapops.h:124:19: error: static declaration of 'is_swap_pte' follows non-static declaration
     124 | static inline int is_swap_pte(pte_t pte)
         |                   ^~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/mremap.c:12:
   include/linux/userfaultfd_k.h:452:7: note: previous implicit declaration of 'is_swap_pte' was here
     452 |  if (!is_swap_pte(pte))
         |       ^~~~~~~~~~~
   In file included from include/linux/mm_inline.h:11,
                    from mm/mremap.c:12:
>> include/linux/swapops.h:133:27: error: conflicting types for 'pte_to_swp_entry'
     133 | static inline swp_entry_t pte_to_swp_entry(pte_t pte)
         |                           ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/mremap.c:12:
   include/linux/userfaultfd_k.h:455:10: note: previous implicit declaration of 'pte_to_swp_entry' was here
     455 |  entry = pte_to_swp_entry(pte);
         |          ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:11,
                    from mm/mremap.c:12:
>> include/linux/swapops.h:429:20: error: conflicting types for 'is_pte_marker_entry'
     429 | static inline bool is_pte_marker_entry(swp_entry_t entry)
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/mremap.c:12:
   include/linux/userfaultfd_k.h:441:9: note: previous implicit declaration of 'is_pte_marker_entry' was here
     441 |  return is_pte_marker_entry(entry) &&
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:11,
                    from mm/mremap.c:12:
>> include/linux/swapops.h:434:26: error: conflicting types for 'pte_marker_get'
     434 | static inline pte_marker pte_marker_get(swp_entry_t entry)
         |                          ^~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/mremap.c:12:
   include/linux/userfaultfd_k.h:442:10: note: previous implicit declaration of 'pte_marker_get' was here
     442 |         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |          ^~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/mremap.c:12:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
   include/linux/userfaultfd_k.h:443:1: warning: control reaches end of non-void function [-Wreturn-type]
     443 | }
         | ^
   cc1: some warnings being treated as errors


vim +/is_pte_marker_entry +441 include/linux/userfaultfd_k.h

2bad466cc9d9b4c Peter Xu      2023-03-09  435  
1db9dbc2ef05205 Peter Xu      2022-05-12  436  static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
1db9dbc2ef05205 Peter Xu      2022-05-12  437  {
564509f441b4695 Chunyan Zhang 2025-09-15  438  	if (!uffd_supports_wp_marker())
564509f441b4695 Chunyan Zhang 2025-09-15  439  		return false;
564509f441b4695 Chunyan Zhang 2025-09-15  440  
1db9dbc2ef05205 Peter Xu      2022-05-12 @441  	return is_pte_marker_entry(entry) &&
1db9dbc2ef05205 Peter Xu      2022-05-12 @442  	       (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
1db9dbc2ef05205 Peter Xu      2022-05-12  443  }
1db9dbc2ef05205 Peter Xu      2022-05-12  444  
1db9dbc2ef05205 Peter Xu      2022-05-12  445  static inline bool pte_marker_uffd_wp(pte_t pte)
1db9dbc2ef05205 Peter Xu      2022-05-12  446  {
1db9dbc2ef05205 Peter Xu      2022-05-12  447  	swp_entry_t entry;
1db9dbc2ef05205 Peter Xu      2022-05-12  448  
564509f441b4695 Chunyan Zhang 2025-09-15  449  	if (!uffd_supports_wp_marker())
564509f441b4695 Chunyan Zhang 2025-09-15  450  		return false;
564509f441b4695 Chunyan Zhang 2025-09-15  451  
1db9dbc2ef05205 Peter Xu      2022-05-12 @452  	if (!is_swap_pte(pte))
1db9dbc2ef05205 Peter Xu      2022-05-12  453  		return false;
1db9dbc2ef05205 Peter Xu      2022-05-12  454  
1db9dbc2ef05205 Peter Xu      2022-05-12 @455  	entry = pte_to_swp_entry(pte);
1db9dbc2ef05205 Peter Xu      2022-05-12  456  
1db9dbc2ef05205 Peter Xu      2022-05-12  457  	return pte_marker_entry_uffd_wp(entry);
1db9dbc2ef05205 Peter Xu      2022-05-12  458  }
1db9dbc2ef05205 Peter Xu      2022-05-12  459  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

