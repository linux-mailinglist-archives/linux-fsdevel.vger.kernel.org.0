Return-Path: <linux-fsdevel+bounces-36452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03129E3B2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C48B2DDBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04501BCA1C;
	Wed,  4 Dec 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmY3tuxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DC1A724C;
	Wed,  4 Dec 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317893; cv=none; b=SWiE0DUrOzmwL/5aoRSJt6zYdMqI75Z5Gxlysrpxgu0z8vJQuXzkcfLqZmHLxd6aG7SE10eHre0opGgJEi9WWXCAn838XtkBhDPXiPGx0O/6rars1n15X47i1CGqVRKNZ4MwCHwfy/31YvXgt0kd5lqWGquy000OyfyR09F22d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317893; c=relaxed/simple;
	bh=Vu1spLItqbI54j3jY+8nhm980fsaFpZxxjIUEgPzQMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqucndGHHtl0/PdU6eEqtZZOOxQoOaDfHimjEa7QQFwoDwbftKVKAVFTGZU9wDV0YIRu4HSs7n4JXll6YDqXLbou1kRRbNCjWo/0lXOcXX4UK1XJe8lFz210M5U3BeHAX9vd4/h+To/1DIVOC89H7vEbFqN0glhLXoMDmb6IKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmY3tuxj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733317892; x=1764853892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vu1spLItqbI54j3jY+8nhm980fsaFpZxxjIUEgPzQMk=;
  b=WmY3tuxj8WHEUUZwFgbUfZgCfyk2cw0vUE0/6zJ6uqSNAxcAYGkDUJh/
   ZNygpPEITIFoMSJosq3D4vvhPG6o1StslUgxcAEK+zQWeWBFtG/uYkokg
   PiYE28/bUzmEPyOploQ9GiJa0TuvwZ1EeJnxOGYJhc39NdH6tcWbai3MO
   NS84jC+Iaz476FQYbsfirqlGEG6ug75zhweL55aehc1sNMPAMNU4Afaeq
   DRFnx9HOsDNwOLlv6wCX4o8n7oQBi5xLtnxtUYLgoN0dCguNuanKhYB7k
   xphUXcMLU+KhvZV2tNy1IqocELgL414n0S0hMFOtRqugDv17bZuDux9T1
   g==;
X-CSE-ConnectionGUID: 5W8BhMAhQuuGAwR5XgkR0g==
X-CSE-MsgGUID: 8Iloju6eTnOiX8n9b84tTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33500209"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33500209"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 05:11:31 -0800
X-CSE-ConnectionGUID: c6O5TtqUR1qGHA1NVLvCYQ==
X-CSE-MsgGUID: uDu8waGPSginu1eCy+T4ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93610486"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 04 Dec 2024 05:11:27 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIpA4-00032v-2e;
	Wed, 04 Dec 2024 13:11:24 +0000
Date: Wed, 4 Dec 2024 21:10:43 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
Message-ID: <202412042012.zymuBpfD-lkp@intel.com>
References: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-vma-move-brk-internals-to-mm-vma-c/20241204-115150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
config: mips-ath25_defconfig (https://download.01.org/0day-ci/archive/20241204/202412042012.zymuBpfD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412042012.zymuBpfD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412042012.zymuBpfD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/vma.c:7:
   In file included from mm/vma_internal.h:12:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/mips/include/asm/cacheflush.h:13:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/vma.c:7:
   In file included from mm/vma_internal.h:29:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/vma.c:2503:11: error: use of undeclared identifier 'READ_IMPLIES_EXEC'
    2503 |         flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
         |                  ^
   arch/mips/include/asm/page.h:215:31: note: expanded from macro 'VM_DATA_DEFAULT_FLAGS'
     215 | #define VM_DATA_DEFAULT_FLAGS   VM_DATA_FLAGS_TSK_EXEC
         |                                 ^
   include/linux/mm.h:453:54: note: expanded from macro 'VM_DATA_FLAGS_TSK_EXEC'
     453 | #define VM_DATA_FLAGS_TSK_EXEC  (VM_READ | VM_WRITE | TASK_EXEC | \
         |                                                       ^
   include/linux/mm.h:450:44: note: expanded from macro 'TASK_EXEC'
     450 | #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
         |                                            ^
   3 warnings and 1 error generated.


vim +/READ_IMPLIES_EXEC +2503 mm/vma.c

  2481	
  2482	/*
  2483	 * do_brk_flags() - Increase the brk vma if the flags match.
  2484	 * @vmi: The vma iterator
  2485	 * @addr: The start address
  2486	 * @len: The length of the increase
  2487	 * @vma: The vma,
  2488	 * @flags: The VMA Flags
  2489	 *
  2490	 * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
  2491	 * do not match then create a new anonymous VMA.  Eventually we may be able to
  2492	 * do some brk-specific accounting here.
  2493	 */
  2494	int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
  2495			 unsigned long addr, unsigned long len, unsigned long flags)
  2496	{
  2497		struct mm_struct *mm = current->mm;
  2498	
  2499		/*
  2500		 * Check against address space limits by the changed size
  2501		 * Note: This happens *after* clearing old mappings in some code paths.
  2502		 */
> 2503		flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

