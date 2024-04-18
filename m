Return-Path: <linux-fsdevel+bounces-17259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B518C8AA1F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 20:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B43F28346F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B417AD84;
	Thu, 18 Apr 2024 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RveOv0Qn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DF176FB1;
	Thu, 18 Apr 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464518; cv=none; b=u0u3BUSfhuvKB4ADutT+0yW5LowUyq4H/nqkxdPjvYI6tyIrNX8MC943/Qfhxf4jAbG8kVGMWU4OaMimRzEl5ToJbgr4qIa/wumTvWGzmRavS8Cbw02kBYkjNE5OsNjK8lLu5erUL27QRDoRt8XaSRNRSgfQfb9re6xRChs8TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464518; c=relaxed/simple;
	bh=76Q4Uz7TXZn7xtFGN4DRXE4m+cPLFVaCk5NMS6tTgQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwAU8/yLG8y8ozcC+mE/a3ZgG50WIB7xSuxmcLbTyY48syOUlqtLK8Z/Ea7mshGjpyWUsJxEgIHP35Y26aeBYFBUhqKDen8BEYxzx7PMTogZK06F5jnzbRHFzsq+3tYTxzyWXU2Ii1ptRguA7RqqmsVPqb7JBeY28/MKGegst/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RveOv0Qn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713464516; x=1745000516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=76Q4Uz7TXZn7xtFGN4DRXE4m+cPLFVaCk5NMS6tTgQ0=;
  b=RveOv0QnnDgieZFdHboaRqg3qBd7NDHpUQgUP+OUHbGPJFzUn1YkZRqv
   MSKgw0AvqAYSVKLwjgZ+RRis5qBrwt2oZXszN3CelKHP8cuIbaUmCuleW
   UiwLAnAd3S0KFa0WKWHuUSrX44O0rGCufS92MHkHXxg9+rX0/QscuZHMJ
   gyz7tPbWdiEGE4Seo7IrqhisLyeOoNujW44yhv+JvZKW5KwKXXuVnbDzb
   lJEzk3K7b1GCwKI8Siv4bm7Na1GCc/BtcE/NNgSbuYIBeCZ4aRPqrvuob
   /7RjbF/Q9s+95i7N42oz55Rif+mQSvWXRzBLn7RXE2z5xfSC0R5Aria+e
   A==;
X-CSE-ConnectionGUID: 5XSvgmeUQ6+WIVWtusvdmQ==
X-CSE-MsgGUID: FacHeN9LQJqlMGDHh4UCxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8898369"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8898369"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 11:21:53 -0700
X-CSE-ConnectionGUID: PaPWmaMoQDOLn9EQ4/K1xw==
X-CSE-MsgGUID: T4X8YjSiSSqQ9bZJ2iB4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27531779"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Apr 2024 11:21:49 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxWOJ-00095s-0c;
	Thu, 18 Apr 2024 18:21:47 +0000
Date: Fri, 19 Apr 2024 02:21:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 8/8] mm/swap: reduce swap cache search space
Message-ID: <202404190205.WSYYPQvi-lkp@intel.com>
References: <20240417160842.76665-9-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417160842.76665-9-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on ceph-client/testing]
[also build test ERROR on ceph-client/for-linus trondmy-nfs/linux-next konis-nilfs2/upstream jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev cifs/for-next linus/master v6.9-rc4]
[cannot apply to akpm-mm/mm-everything next-20240418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/NFS-remove-nfs_page_lengthg-and-usage-of-page_index/20240418-001343
base:   https://github.com/ceph/ceph-client.git testing
patch link:    https://lore.kernel.org/r/20240417160842.76665-9-ryncsn%40gmail.com
patch subject: [PATCH 8/8] mm/swap: reduce swap cache search space
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240419/202404190205.WSYYPQvi-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190205.WSYYPQvi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190205.WSYYPQvi-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/shmem.c: In function 'shmem_replace_folio':
>> mm/shmem.c:1765:22: error: implicit declaration of function 'swap_cache_index' [-Werror=implicit-function-declaration]
    1765 |         swap_index = swap_cache_index(entry);
         |                      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/swap_cache_index +1765 mm/shmem.c

  1753	
  1754	static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
  1755					struct shmem_inode_info *info, pgoff_t index)
  1756	{
  1757		struct folio *old, *new;
  1758		struct address_space *swap_mapping;
  1759		swp_entry_t entry;
  1760		pgoff_t swap_index;
  1761		int error;
  1762	
  1763		old = *foliop;
  1764		entry = old->swap;
> 1765		swap_index = swap_cache_index(entry);
  1766		swap_mapping = swap_address_space(entry);
  1767	
  1768		/*
  1769		 * We have arrived here because our zones are constrained, so don't
  1770		 * limit chance of success by further cpuset and node constraints.
  1771		 */
  1772		gfp &= ~GFP_CONSTRAINT_MASK;
  1773		VM_BUG_ON_FOLIO(folio_test_large(old), old);
  1774		new = shmem_alloc_folio(gfp, info, index);
  1775		if (!new)
  1776			return -ENOMEM;
  1777	
  1778		folio_get(new);
  1779		folio_copy(new, old);
  1780		flush_dcache_folio(new);
  1781	
  1782		__folio_set_locked(new);
  1783		__folio_set_swapbacked(new);
  1784		folio_mark_uptodate(new);
  1785		new->swap = entry;
  1786		folio_set_swapcache(new);
  1787	
  1788		/*
  1789		 * Our caller will very soon move newpage out of swapcache, but it's
  1790		 * a nice clean interface for us to replace oldpage by newpage there.
  1791		 */
  1792		xa_lock_irq(&swap_mapping->i_pages);
  1793		error = shmem_replace_entry(swap_mapping, swap_index, old, new);
  1794		if (!error) {
  1795			mem_cgroup_migrate(old, new);
  1796			__lruvec_stat_mod_folio(new, NR_FILE_PAGES, 1);
  1797			__lruvec_stat_mod_folio(new, NR_SHMEM, 1);
  1798			__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -1);
  1799			__lruvec_stat_mod_folio(old, NR_SHMEM, -1);
  1800		}
  1801		xa_unlock_irq(&swap_mapping->i_pages);
  1802	
  1803		if (unlikely(error)) {
  1804			/*
  1805			 * Is this possible?  I think not, now that our callers check
  1806			 * both PageSwapCache and page_private after getting page lock;
  1807			 * but be defensive.  Reverse old to newpage for clear and free.
  1808			 */
  1809			old = new;
  1810		} else {
  1811			folio_add_lru(new);
  1812			*foliop = new;
  1813		}
  1814	
  1815		folio_clear_swapcache(old);
  1816		old->private = NULL;
  1817	
  1818		folio_unlock(old);
  1819		folio_put_refs(old, 2);
  1820		return error;
  1821	}
  1822	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

