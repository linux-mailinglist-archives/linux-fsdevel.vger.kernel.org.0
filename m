Return-Path: <linux-fsdevel+bounces-22694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31C091B236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9495282344
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52E1A2C32;
	Thu, 27 Jun 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdGaOk7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A811A0B1A;
	Thu, 27 Jun 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527239; cv=none; b=YT1XbLcO8bDK7TFDG3l8QSsfye2kGfsfJs5dAmZ1Zqwz8/IhVJEudq/5J679fJNQ0VJ+mKgsMt1qhe0qDQl9l2f0M5W11HiXbbqOusOIL65BWiBBIxUcMaNkcf569gtoiN+YLIBFj9MXTWAbSkhIKH2I/LdFxu8PqMpO6KYjRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527239; c=relaxed/simple;
	bh=6ZRjC23wobObDdFfd8zFQZZ9Z3PFbjqgjYHg7T/vNQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3tRlmK9locKzllgeKTYnqqAGZBEgMOyR85QBastr6v6CW3uCynoyPDvmItjonLNCKCFTjlN+j/StE7GC/wj89LjMAAcnOlLdlSeT5zf1wtqO7d9qr+eH6Sa3rnoZtx6iUhDZSDoyUCUHQbwAHyOg35pIg2Vic/w17gRILsblfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdGaOk7T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719527238; x=1751063238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZRjC23wobObDdFfd8zFQZZ9Z3PFbjqgjYHg7T/vNQU=;
  b=fdGaOk7TauulQ2l/YNo97fXu0aFQxvtFw3EOuRxdQa9FwvjCk054Z0xL
   8Ti4IaU56K7y/Jk8/hKmbgRSHfNHALle0L1F7Gew5EOzceKqMEw5Jt918
   +XJu2A8asLzmCxmSTHAW3j7KQ8RpgeR8e93LQPyEXLRRvl1eenjABYLxg
   dUCvT6yhpjflRTQTB4kjKiozDkvNDX4gqQ/oN76MEC8bWGGz+zIGd7WY7
   jjcwvSCgKWW6kJAVRXKdBgppMyqMIjjWIcZQwBeDynEeGwvQ5KmK/s454
   m26I30sUUoOAsD36Adymlj3LvKsnsVpLEawraNmCm4b6ueCYyc0p1Cpde
   Q==;
X-CSE-ConnectionGUID: JGpX81p4QiyXlcNTi6+wOw==
X-CSE-MsgGUID: i5cLKlcRQn2IIYmfAyVBCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16369833"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16369833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 15:27:17 -0700
X-CSE-ConnectionGUID: zkBVUXQWQjyqQHVWEEfu0Q==
X-CSE-MsgGUID: fngSrsCqRteimFpQDSTiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44625380"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Jun 2024 15:27:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMxa7-000Gb0-24;
	Thu, 27 Jun 2024 22:27:07 +0000
Date: Fri, 28 Jun 2024 06:26:36 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
Message-ID: <202406280637.147dyRrV-lkp@intel.com>
References: <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on f2661062f16b2de5d7b6a5c42a9a5c96326b8454]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Popple/mm-gup-c-Remove-redundant-check-for-PCI-P2PDMA-page/20240627-191709
base:   f2661062f16b2de5d7b6a5c42a9a5c96326b8454
patch link:    https://lore.kernel.org/r/bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple%40nvidia.com
patch subject: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240628/202406280637.147dyRrV-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280637.147dyRrV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280637.147dyRrV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/rmap.c:1513:37: error: call to '__compiletime_assert_279' declared with 'error' attribute: BUILD_BUG failed
    1513 |         __folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
         |                                            ^
   include/linux/huge_mm.h:111:26: note: expanded from macro 'HPAGE_PUD_NR'
     111 | #define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
         |                          ^
   include/linux/huge_mm.h:110:26: note: expanded from macro 'HPAGE_PUD_ORDER'
     110 | #define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
         |                          ^
   include/linux/huge_mm.h:97:28: note: expanded from macro 'HPAGE_PUD_SHIFT'
      97 | #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
         |                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:72:1: note: expanded from here
      72 | __compiletime_assert_279
         | ^
   mm/rmap.c:1660:35: error: call to '__compiletime_assert_280' declared with 'error' attribute: BUILD_BUG failed
    1660 |         __folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
         |                                          ^
   include/linux/huge_mm.h:111:26: note: expanded from macro 'HPAGE_PUD_NR'
     111 | #define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
         |                          ^
   include/linux/huge_mm.h:110:26: note: expanded from macro 'HPAGE_PUD_ORDER'
     110 | #define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
         |                          ^
   include/linux/huge_mm.h:97:28: note: expanded from macro 'HPAGE_PUD_SHIFT'
      97 | #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
         |                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:79:1: note: expanded from here
      79 | __compiletime_assert_280
         | ^
   2 errors generated.


vim +1513 mm/rmap.c

  1498	
  1499	/**
  1500	 * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
  1501	 * @folio:	The folio to add the mapping to
  1502	 * @page:	The first page to add
  1503	 * @vma:	The vm area in which the mapping is added
  1504	 *
  1505	 * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
  1506	 *
  1507	 * The caller needs to hold the page table lock.
  1508	 */
  1509	void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
  1510			struct vm_area_struct *vma)
  1511	{
  1512	#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> 1513		__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
  1514	#else
  1515		WARN_ON_ONCE(true);
  1516	#endif
  1517	}
  1518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

