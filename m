Return-Path: <linux-fsdevel+bounces-29167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BFD97696A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805391F246CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121B1AB6C3;
	Thu, 12 Sep 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAgQKien"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932541A7254;
	Thu, 12 Sep 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145110; cv=none; b=Aodp9funEDKEtdEETScXZAAHWw3/XqJ4k9cIStYOVmxLiU+zo8qyMkw/3Y57RLbUcQs4RybKb2FNVvRllHVwM7JIw0vrPItq5Z9851xREBF641dMfQJdH9O2dO50JYBqM9Oe4iHRGya3OfEZCimtF8icsZMOAMCANCDHfhGBIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145110; c=relaxed/simple;
	bh=wQ+7itKzPx0/AmRlbXpugZGEXX5dWhZJAHl3QzZ4WHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om27fDht8eQGvrn+RJSvYF0QqB3BjKBqmocvgSlXAbMbWL0oe9xOH0wghUKGrQcpRc32qNSFMvJ5aGkkdXjTK5qvIHwka2Nkp2X4cctuqGBBtSlij7n6JIcuH8zc4BNGNjaFwxxHDgDhNZN0CaEOjDYTFN98qHzJIPV8Il1kP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAgQKien; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726145108; x=1757681108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wQ+7itKzPx0/AmRlbXpugZGEXX5dWhZJAHl3QzZ4WHM=;
  b=eAgQKienUeVetXVmpemPP01Aspyh7kmuPVH/CnYKISJOWpCTldqBWnX0
   pwde8qWNsPywZgZq8uiS2MYeZ+4OHyTTrAHAxPQt86nBRsPFaa/mb+vBp
   nZMNj3x5rgpA8rH0rEwMut9SjFWLXP9Wp3Rlu9RUqe8JTFrHy9NOWoXWl
   G3sBgDmtjdpABOGv5f8uYTIjbw1bIjy9NoDmjMqvbfaAAfYafTp/snc48
   NDuBzSKjC3B2v2i12jyxD/GrcNGVtWYyKsC8VkiExfeGnwwlgPvKi/Ca9
   7oepR88rcMFvXaif8stHt6Fikek5/PjKQ2/dMIQn23V8FfHHqQngbGKbg
   A==;
X-CSE-ConnectionGUID: QxvlPIlzQRChxcJjDITZHA==
X-CSE-MsgGUID: jCX1QW0oRTiX/1opFPpmUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35658188"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35658188"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:45:05 -0700
X-CSE-ConnectionGUID: 3u5JwDbVQFOQVl5w4unWDA==
X-CSE-MsgGUID: mvoL5Y7SRQGlyX/DzQ7g7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72062360"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Sep 2024 05:44:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sojBv-0005A7-1f;
	Thu, 12 Sep 2024 12:44:55 +0000
Date: Thu, 12 Sep 2024 20:44:32 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, Alistair Popple <apopple@nvidia.com>,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/12] mm: Allow compound zone device pages
Message-ID: <202409122024.PPIwP6vb-lkp@intel.com>
References: <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6f1833b8208c3b9e59eff10792667b6639365146]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Popple/mm-gup-c-Remove-redundant-check-for-PCI-P2PDMA-page/20240910-121806
base:   6f1833b8208c3b9e59eff10792667b6639365146
patch link:    https://lore.kernel.org/r/c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple%40nvidia.com
patch subject: [PATCH 04/12] mm: Allow compound zone device pages
config: csky-defconfig (https://download.01.org/0day-ci/archive/20240912/202409122024.PPIwP6vb-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122024.PPIwP6vb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409122024.PPIwP6vb-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mm.h:32,
                    from mm/gup.c:7:
   include/linux/memremap.h: In function 'is_device_private_page':
   include/linux/memremap.h:164:17: error: implicit declaration of function 'page_dev_pagemap' [-Wimplicit-function-declaration]
     164 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
         |                 ^~~~~~~~~~~~~~~~
   include/linux/memremap.h:164:39: error: invalid type argument of '->' (have 'int')
     164 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
         |                                       ^~
   include/linux/memremap.h: In function 'is_pci_p2pdma_page':
   include/linux/memremap.h:176:39: error: invalid type argument of '->' (have 'int')
     176 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
         |                                       ^~
   include/linux/memremap.h: In function 'is_device_coherent_page':
   include/linux/memremap.h:182:39: error: invalid type argument of '->' (have 'int')
     182 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_COHERENT;
         |                                       ^~
   include/linux/memremap.h: In function 'is_pci_p2pdma_page':
>> include/linux/memremap.h:177:1: warning: control reaches end of non-void function [-Wreturn-type]
     177 | }
         | ^
   include/linux/memremap.h: In function 'is_device_coherent_page':
   include/linux/memremap.h:183:1: warning: control reaches end of non-void function [-Wreturn-type]
     183 | }
         | ^
--
   In file included from include/linux/mm.h:32,
                    from mm/memory.c:44:
   include/linux/memremap.h: In function 'is_device_private_page':
   include/linux/memremap.h:164:17: error: implicit declaration of function 'page_dev_pagemap' [-Wimplicit-function-declaration]
     164 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
         |                 ^~~~~~~~~~~~~~~~
   include/linux/memremap.h:164:39: error: invalid type argument of '->' (have 'int')
     164 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
         |                                       ^~
   include/linux/memremap.h: In function 'is_pci_p2pdma_page':
   include/linux/memremap.h:176:39: error: invalid type argument of '->' (have 'int')
     176 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
         |                                       ^~
   include/linux/memremap.h: In function 'is_device_coherent_page':
   include/linux/memremap.h:182:39: error: invalid type argument of '->' (have 'int')
     182 |                 page_dev_pagemap(page)->type == MEMORY_DEVICE_COHERENT;
         |                                       ^~
   mm/memory.c: In function 'do_swap_page':
>> mm/memory.c:4052:31: error: assignment to 'struct dev_pagemap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4052 |                         pgmap = page_dev_pagemap(vmf->page);
         |                               ^
   include/linux/memremap.h: In function 'is_device_private_page':
   include/linux/memremap.h:165:1: warning: control reaches end of non-void function [-Wreturn-type]
     165 | }
         | ^


vim +4052 mm/memory.c

  3988	
  3989	/*
  3990	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3991	 * but allow concurrent faults), and pte mapped but not yet locked.
  3992	 * We return with pte unmapped and unlocked.
  3993	 *
  3994	 * We return with the mmap_lock locked or unlocked in the same cases
  3995	 * as does filemap_fault().
  3996	 */
  3997	vm_fault_t do_swap_page(struct vm_fault *vmf)
  3998	{
  3999		struct vm_area_struct *vma = vmf->vma;
  4000		struct folio *swapcache, *folio = NULL;
  4001		struct page *page;
  4002		struct swap_info_struct *si = NULL;
  4003		rmap_t rmap_flags = RMAP_NONE;
  4004		bool need_clear_cache = false;
  4005		bool exclusive = false;
  4006		swp_entry_t entry;
  4007		pte_t pte;
  4008		vm_fault_t ret = 0;
  4009		void *shadow = NULL;
  4010		int nr_pages;
  4011		unsigned long page_idx;
  4012		unsigned long address;
  4013		pte_t *ptep;
  4014	
  4015		if (!pte_unmap_same(vmf))
  4016			goto out;
  4017	
  4018		entry = pte_to_swp_entry(vmf->orig_pte);
  4019		if (unlikely(non_swap_entry(entry))) {
  4020			if (is_migration_entry(entry)) {
  4021				migration_entry_wait(vma->vm_mm, vmf->pmd,
  4022						     vmf->address);
  4023			} else if (is_device_exclusive_entry(entry)) {
  4024				vmf->page = pfn_swap_entry_to_page(entry);
  4025				ret = remove_device_exclusive_entry(vmf);
  4026			} else if (is_device_private_entry(entry)) {
  4027				struct dev_pagemap *pgmap;
  4028				if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
  4029					/*
  4030					 * migrate_to_ram is not yet ready to operate
  4031					 * under VMA lock.
  4032					 */
  4033					vma_end_read(vma);
  4034					ret = VM_FAULT_RETRY;
  4035					goto out;
  4036				}
  4037	
  4038				vmf->page = pfn_swap_entry_to_page(entry);
  4039				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  4040						vmf->address, &vmf->ptl);
  4041				if (unlikely(!vmf->pte ||
  4042					     !pte_same(ptep_get(vmf->pte),
  4043								vmf->orig_pte)))
  4044					goto unlock;
  4045	
  4046				/*
  4047				 * Get a page reference while we know the page can't be
  4048				 * freed.
  4049				 */
  4050				get_page(vmf->page);
  4051				pte_unmap_unlock(vmf->pte, vmf->ptl);
> 4052				pgmap = page_dev_pagemap(vmf->page);
  4053				ret = pgmap->ops->migrate_to_ram(vmf);
  4054				put_page(vmf->page);
  4055			} else if (is_hwpoison_entry(entry)) {
  4056				ret = VM_FAULT_HWPOISON;
  4057			} else if (is_pte_marker_entry(entry)) {
  4058				ret = handle_pte_marker(vmf);
  4059			} else {
  4060				print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
  4061				ret = VM_FAULT_SIGBUS;
  4062			}
  4063			goto out;
  4064		}
  4065	
  4066		/* Prevent swapoff from happening to us. */
  4067		si = get_swap_device(entry);
  4068		if (unlikely(!si))
  4069			goto out;
  4070	
  4071		folio = swap_cache_get_folio(entry, vma, vmf->address);
  4072		if (folio)
  4073			page = folio_file_page(folio, swp_offset(entry));
  4074		swapcache = folio;
  4075	
  4076		if (!folio) {
  4077			if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
  4078			    __swap_count(entry) == 1) {
  4079				/*
  4080				 * Prevent parallel swapin from proceeding with
  4081				 * the cache flag. Otherwise, another thread may
  4082				 * finish swapin first, free the entry, and swapout
  4083				 * reusing the same entry. It's undetectable as
  4084				 * pte_same() returns true due to entry reuse.
  4085				 */
  4086				if (swapcache_prepare(entry, 1)) {
  4087					/* Relax a bit to prevent rapid repeated page faults */
  4088					schedule_timeout_uninterruptible(1);
  4089					goto out;
  4090				}
  4091				need_clear_cache = true;
  4092	
  4093				/* skip swapcache */
  4094				folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
  4095							vma, vmf->address, false);
  4096				if (folio) {
  4097					__folio_set_locked(folio);
  4098					__folio_set_swapbacked(folio);
  4099	
  4100					if (mem_cgroup_swapin_charge_folio(folio,
  4101								vma->vm_mm, GFP_KERNEL,
  4102								entry)) {
  4103						ret = VM_FAULT_OOM;
  4104						goto out_page;
  4105					}
  4106					mem_cgroup_swapin_uncharge_swap(entry);
  4107	
  4108					shadow = get_shadow_from_swap_cache(entry);
  4109					if (shadow)
  4110						workingset_refault(folio, shadow);
  4111	
  4112					folio_add_lru(folio);
  4113	
  4114					/* To provide entry to swap_read_folio() */
  4115					folio->swap = entry;
  4116					swap_read_folio(folio, NULL);
  4117					folio->private = NULL;
  4118				}
  4119			} else {
  4120				folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
  4121							vmf);
  4122				swapcache = folio;
  4123			}
  4124	
  4125			if (!folio) {
  4126				/*
  4127				 * Back out if somebody else faulted in this pte
  4128				 * while we released the pte lock.
  4129				 */
  4130				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  4131						vmf->address, &vmf->ptl);
  4132				if (likely(vmf->pte &&
  4133					   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  4134					ret = VM_FAULT_OOM;
  4135				goto unlock;
  4136			}
  4137	
  4138			/* Had to read the page from swap area: Major fault */
  4139			ret = VM_FAULT_MAJOR;
  4140			count_vm_event(PGMAJFAULT);
  4141			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
  4142			page = folio_file_page(folio, swp_offset(entry));
  4143		} else if (PageHWPoison(page)) {
  4144			/*
  4145			 * hwpoisoned dirty swapcache pages are kept for killing
  4146			 * owner processes (which may be unknown at hwpoison time)
  4147			 */
  4148			ret = VM_FAULT_HWPOISON;
  4149			goto out_release;
  4150		}
  4151	
  4152		ret |= folio_lock_or_retry(folio, vmf);
  4153		if (ret & VM_FAULT_RETRY)
  4154			goto out_release;
  4155	
  4156		if (swapcache) {
  4157			/*
  4158			 * Make sure folio_free_swap() or swapoff did not release the
  4159			 * swapcache from under us.  The page pin, and pte_same test
  4160			 * below, are not enough to exclude that.  Even if it is still
  4161			 * swapcache, we need to check that the page's swap has not
  4162			 * changed.
  4163			 */
  4164			if (unlikely(!folio_test_swapcache(folio) ||
  4165				     page_swap_entry(page).val != entry.val))
  4166				goto out_page;
  4167	
  4168			/*
  4169			 * KSM sometimes has to copy on read faults, for example, if
  4170			 * page->index of !PageKSM() pages would be nonlinear inside the
  4171			 * anon VMA -- PageKSM() is lost on actual swapout.
  4172			 */
  4173			folio = ksm_might_need_to_copy(folio, vma, vmf->address);
  4174			if (unlikely(!folio)) {
  4175				ret = VM_FAULT_OOM;
  4176				folio = swapcache;
  4177				goto out_page;
  4178			} else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {
  4179				ret = VM_FAULT_HWPOISON;
  4180				folio = swapcache;
  4181				goto out_page;
  4182			}
  4183			if (folio != swapcache)
  4184				page = folio_page(folio, 0);
  4185	
  4186			/*
  4187			 * If we want to map a page that's in the swapcache writable, we
  4188			 * have to detect via the refcount if we're really the exclusive
  4189			 * owner. Try removing the extra reference from the local LRU
  4190			 * caches if required.
  4191			 */
  4192			if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
  4193			    !folio_test_ksm(folio) && !folio_test_lru(folio))
  4194				lru_add_drain();
  4195		}
  4196	
  4197		folio_throttle_swaprate(folio, GFP_KERNEL);
  4198	
  4199		/*
  4200		 * Back out if somebody else already faulted in this pte.
  4201		 */
  4202		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
  4203				&vmf->ptl);
  4204		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  4205			goto out_nomap;
  4206	
  4207		if (unlikely(!folio_test_uptodate(folio))) {
  4208			ret = VM_FAULT_SIGBUS;
  4209			goto out_nomap;
  4210		}
  4211	
  4212		nr_pages = 1;
  4213		page_idx = 0;
  4214		address = vmf->address;
  4215		ptep = vmf->pte;
  4216		if (folio_test_large(folio) && folio_test_swapcache(folio)) {
  4217			int nr = folio_nr_pages(folio);
  4218			unsigned long idx = folio_page_idx(folio, page);
  4219			unsigned long folio_start = address - idx * PAGE_SIZE;
  4220			unsigned long folio_end = folio_start + nr * PAGE_SIZE;
  4221			pte_t *folio_ptep;
  4222			pte_t folio_pte;
  4223	
  4224			if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
  4225				goto check_folio;
  4226			if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
  4227				goto check_folio;
  4228	
  4229			folio_ptep = vmf->pte - idx;
  4230			folio_pte = ptep_get(folio_ptep);
  4231			if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
  4232			    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
  4233				goto check_folio;
  4234	
  4235			page_idx = idx;
  4236			address = folio_start;
  4237			ptep = folio_ptep;
  4238			nr_pages = nr;
  4239			entry = folio->swap;
  4240			page = &folio->page;
  4241		}
  4242	
  4243	check_folio:
  4244		/*
  4245		 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
  4246		 * must never point at an anonymous page in the swapcache that is
  4247		 * PG_anon_exclusive. Sanity check that this holds and especially, that
  4248		 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
  4249		 * check after taking the PT lock and making sure that nobody
  4250		 * concurrently faulted in this page and set PG_anon_exclusive.
  4251		 */
  4252		BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
  4253		BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
  4254	
  4255		/*
  4256		 * Check under PT lock (to protect against concurrent fork() sharing
  4257		 * the swap entry concurrently) for certainly exclusive pages.
  4258		 */
  4259		if (!folio_test_ksm(folio)) {
  4260			exclusive = pte_swp_exclusive(vmf->orig_pte);
  4261			if (folio != swapcache) {
  4262				/*
  4263				 * We have a fresh page that is not exposed to the
  4264				 * swapcache -> certainly exclusive.
  4265				 */
  4266				exclusive = true;
  4267			} else if (exclusive && folio_test_writeback(folio) &&
  4268				  data_race(si->flags & SWP_STABLE_WRITES)) {
  4269				/*
  4270				 * This is tricky: not all swap backends support
  4271				 * concurrent page modifications while under writeback.
  4272				 *
  4273				 * So if we stumble over such a page in the swapcache
  4274				 * we must not set the page exclusive, otherwise we can
  4275				 * map it writable without further checks and modify it
  4276				 * while still under writeback.
  4277				 *
  4278				 * For these problematic swap backends, simply drop the
  4279				 * exclusive marker: this is perfectly fine as we start
  4280				 * writeback only if we fully unmapped the page and
  4281				 * there are no unexpected references on the page after
  4282				 * unmapping succeeded. After fully unmapped, no
  4283				 * further GUP references (FOLL_GET and FOLL_PIN) can
  4284				 * appear, so dropping the exclusive marker and mapping
  4285				 * it only R/O is fine.
  4286				 */
  4287				exclusive = false;
  4288			}
  4289		}
  4290	
  4291		/*
  4292		 * Some architectures may have to restore extra metadata to the page
  4293		 * when reading from swap. This metadata may be indexed by swap entry
  4294		 * so this must be called before swap_free().
  4295		 */
  4296		arch_swap_restore(folio_swap(entry, folio), folio);
  4297	
  4298		/*
  4299		 * Remove the swap entry and conditionally try to free up the swapcache.
  4300		 * We're already holding a reference on the page but haven't mapped it
  4301		 * yet.
  4302		 */
  4303		swap_free_nr(entry, nr_pages);
  4304		if (should_try_to_free_swap(folio, vma, vmf->flags))
  4305			folio_free_swap(folio);
  4306	
  4307		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
  4308		add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
  4309		pte = mk_pte(page, vma->vm_page_prot);
  4310		if (pte_swp_soft_dirty(vmf->orig_pte))
  4311			pte = pte_mksoft_dirty(pte);
  4312		if (pte_swp_uffd_wp(vmf->orig_pte))
  4313			pte = pte_mkuffd_wp(pte);
  4314	
  4315		/*
  4316		 * Same logic as in do_wp_page(); however, optimize for pages that are
  4317		 * certainly not shared either because we just allocated them without
  4318		 * exposing them to the swapcache or because the swap entry indicates
  4319		 * exclusivity.
  4320		 */
  4321		if (!folio_test_ksm(folio) &&
  4322		    (exclusive || folio_ref_count(folio) == 1)) {
  4323			if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
  4324			    !pte_needs_soft_dirty_wp(vma, pte)) {
  4325				pte = pte_mkwrite(pte, vma);
  4326				if (vmf->flags & FAULT_FLAG_WRITE) {
  4327					pte = pte_mkdirty(pte);
  4328					vmf->flags &= ~FAULT_FLAG_WRITE;
  4329				}
  4330			}
  4331			rmap_flags |= RMAP_EXCLUSIVE;
  4332		}
  4333		folio_ref_add(folio, nr_pages - 1);
  4334		flush_icache_pages(vma, page, nr_pages);
  4335		vmf->orig_pte = pte_advance_pfn(pte, page_idx);
  4336	
  4337		/* ksm created a completely new copy */
  4338		if (unlikely(folio != swapcache && swapcache)) {
  4339			folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
  4340			folio_add_lru_vma(folio, vma);
  4341		} else if (!folio_test_anon(folio)) {
  4342			/*
  4343			 * We currently only expect small !anon folios, which are either
  4344			 * fully exclusive or fully shared. If we ever get large folios
  4345			 * here, we have to be careful.
  4346			 */
  4347			VM_WARN_ON_ONCE(folio_test_large(folio));
  4348			VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
  4349			folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
  4350		} else {
  4351			folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
  4352						rmap_flags);
  4353		}
  4354	
  4355		VM_BUG_ON(!folio_test_anon(folio) ||
  4356				(pte_write(pte) && !PageAnonExclusive(page)));
  4357		set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
  4358		arch_do_swap_page_nr(vma->vm_mm, vma, address,
  4359				pte, pte, nr_pages);
  4360	
  4361		folio_unlock(folio);
  4362		if (folio != swapcache && swapcache) {
  4363			/*
  4364			 * Hold the lock to avoid the swap entry to be reused
  4365			 * until we take the PT lock for the pte_same() check
  4366			 * (to avoid false positives from pte_same). For
  4367			 * further safety release the lock after the swap_free
  4368			 * so that the swap count won't change under a
  4369			 * parallel locked swapcache.
  4370			 */
  4371			folio_unlock(swapcache);
  4372			folio_put(swapcache);
  4373		}
  4374	
  4375		if (vmf->flags & FAULT_FLAG_WRITE) {
  4376			ret |= do_wp_page(vmf);
  4377			if (ret & VM_FAULT_ERROR)
  4378				ret &= VM_FAULT_ERROR;
  4379			goto out;
  4380		}
  4381	
  4382		/* No need to invalidate - it was non-present before */
  4383		update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
  4384	unlock:
  4385		if (vmf->pte)
  4386			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4387	out:
  4388		/* Clear the swap cache pin for direct swapin after PTL unlock */
  4389		if (need_clear_cache)
  4390			swapcache_clear(si, entry, 1);
  4391		if (si)
  4392			put_swap_device(si);
  4393		return ret;
  4394	out_nomap:
  4395		if (vmf->pte)
  4396			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4397	out_page:
  4398		folio_unlock(folio);
  4399	out_release:
  4400		folio_put(folio);
  4401		if (folio != swapcache && swapcache) {
  4402			folio_unlock(swapcache);
  4403			folio_put(swapcache);
  4404		}
  4405		if (need_clear_cache)
  4406			swapcache_clear(si, entry, 1);
  4407		if (si)
  4408			put_swap_device(si);
  4409		return ret;
  4410	}
  4411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

