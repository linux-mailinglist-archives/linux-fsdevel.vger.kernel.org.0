Return-Path: <linux-fsdevel+bounces-56913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A29B1CE16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C8A1688A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51811F7586;
	Wed,  6 Aug 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6aV9vB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8354654;
	Wed,  6 Aug 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513550; cv=none; b=dAc0iYAqTHzbhg3N8a1WOpqMzh9Mf7gb60cWjT1otmZ2KicRHTIXRKG5dzokScZebovzZnnwm7MtxqqsZKnn2csgOHKTHsFLTDggnf4YHSglpEThDOFnMAjqNeWSSGOSZJ3P7iPqwPQfa8sgpJE1r6dF603XE74U0LecvDOyTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513550; c=relaxed/simple;
	bh=QmvpDt2PS2p7demErPhAY+ZhnKGpcjx2LhJW1JzrWGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km4rx4yDuggmFgtcRt23Oajuw9KD2zrsUj/s5l4jWJCjnBBuHTIqd6BeBZ/gfiO2027+BP2fl2FvfxiXy9SBVc67LpXprgycy/mW+bQfQ1yrTN/TNFb4AzZ+ngRJCQFTJkIdILVLh27UumMu/RGRfrD52q9dH5ovPlwCTBKG8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6aV9vB3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754513549; x=1786049549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QmvpDt2PS2p7demErPhAY+ZhnKGpcjx2LhJW1JzrWGc=;
  b=f6aV9vB3qcBP/5VGhEMQ7De83VFkvOQUSAujO8UMatcpEjSmDGeF6tOp
   /Ip3mwgbtWtImShzt501HqZclrzOUQ+oP9yGAiAzrqUFmBJDhwwMeGPHl
   48KZaLRhqDdeLorpoN9fe5eIDYfJJ3VvbY69+k9Zq74BfXoLxRvsdeNpg
   vj3zdC+TitOE89hq6ydfhI8wAo9G3Ohvl1K+5DLOY+fX4Rg9GHZuuBDv+
   zyz5gGdi49XHC4BLazdKROuqvKEsD+jnT76KQ7ogigDnHsL+A3aiGAaG0
   vWREW3mk8IT10gYQ7RQpjH2MDeVqGP9/JghwIP+fprwZWE/nZEYeqDCmk
   A==;
X-CSE-ConnectionGUID: xuoIqQi6SQyWq4aAcp6O0g==
X-CSE-MsgGUID: CvGZkmnUSnaxQ7MjTY4FrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67108554"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67108554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:52:28 -0700
X-CSE-ConnectionGUID: +2xhNmFsRnGZfDnhagyifw==
X-CSE-MsgGUID: ITvLCpOyQFqptZuo1Oorhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169045376"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2025 13:52:26 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujl7T-00025u-22;
	Wed, 06 Aug 2025 20:52:20 +0000
Date: Thu, 7 Aug 2025 04:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shakeel.butt@linux.dev, hch@infradead.org, wqu@suse.com
Subject: Re: [PATCH 3/3] mm: add vmstat for cgroup uncharged pages
Message-ID: <202508070450.bjCshoYI-lkp@intel.com>
References: <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>

Hi Boris,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on v6.16]
[cannot apply to akpm-mm/mm-everything linus/master next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Burkov/mm-filemap-add-filemap_add_folio_nocharge/20250806-130147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris%40bur.io
patch subject: [PATCH 3/3] mm: add vmstat for cgroup uncharged pages
config: i386-buildonly-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070450.bjCshoYI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070450.bjCshoYI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070450.bjCshoYI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/filemap.c:209:2: error: call to undeclared function 'filemap_mod_uncharged_vmstat'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     209 |         filemap_mod_uncharged_vmstat(folio, -1);
         |         ^
   mm/filemap.c:209:2: note: did you mean 'filemap_mod_uncharged_cgroup_vmstat'?
   mm/filemap.c:158:13: note: 'filemap_mod_uncharged_cgroup_vmstat' declared here
     158 | static void filemap_mod_uncharged_cgroup_vmstat(struct folio *folio, int sign)
         |             ^
   mm/filemap.c:998:3: error: call to undeclared function 'filemap_mod_uncharged_vmstat'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     998 |                 filemap_mod_uncharged_vmstat(folio, 1);
         |                 ^
   2 errors generated.


vim +/filemap_mod_uncharged_vmstat +209 mm/filemap.c

   163	
   164	
   165	static void filemap_unaccount_folio(struct address_space *mapping,
   166			struct folio *folio)
   167	{
   168		long nr;
   169	
   170		VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
   171		if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
   172			pr_alert("BUG: Bad page cache in process %s  pfn:%05lx\n",
   173				 current->comm, folio_pfn(folio));
   174			dump_page(&folio->page, "still mapped when deleted");
   175			dump_stack();
   176			add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
   177	
   178			if (mapping_exiting(mapping) && !folio_test_large(folio)) {
   179				int mapcount = folio_mapcount(folio);
   180	
   181				if (folio_ref_count(folio) >= mapcount + 2) {
   182					/*
   183					 * All vmas have already been torn down, so it's
   184					 * a good bet that actually the page is unmapped
   185					 * and we'd rather not leak it: if we're wrong,
   186					 * another bad page check should catch it later.
   187					 */
   188					atomic_set(&folio->_mapcount, -1);
   189					folio_ref_sub(folio, mapcount);
   190				}
   191			}
   192		}
   193	
   194		/* hugetlb folios do not participate in page cache accounting. */
   195		if (folio_test_hugetlb(folio))
   196			return;
   197	
   198		nr = folio_nr_pages(folio);
   199	
   200		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
   201		if (folio_test_swapbacked(folio)) {
   202			__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
   203			if (folio_test_pmd_mappable(folio))
   204				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
   205		} else if (folio_test_pmd_mappable(folio)) {
   206			__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
   207			filemap_nr_thps_dec(mapping);
   208		}
 > 209		filemap_mod_uncharged_vmstat(folio, -1);
   210	
   211		/*
   212		 * At this point folio must be either written or cleaned by
   213		 * truncate.  Dirty folio here signals a bug and loss of
   214		 * unwritten data - on ordinary filesystems.
   215		 *
   216		 * But it's harmless on in-memory filesystems like tmpfs; and can
   217		 * occur when a driver which did get_user_pages() sets page dirty
   218		 * before putting it, while the inode is being finally evicted.
   219		 *
   220		 * Below fixes dirty accounting after removing the folio entirely
   221		 * but leaves the dirty flag set: it has no effect for truncated
   222		 * folio and anyway will be cleared before returning folio to
   223		 * buddy allocator.
   224		 */
   225		if (WARN_ON_ONCE(folio_test_dirty(folio) &&
   226				 mapping_can_writeback(mapping)))
   227			folio_account_cleaned(folio, inode_to_wb(mapping->host));
   228	}
   229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

