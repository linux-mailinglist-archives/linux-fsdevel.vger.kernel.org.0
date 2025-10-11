Return-Path: <linux-fsdevel+bounces-63837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC50BCF2B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150713AC183
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0223ABAF;
	Sat, 11 Oct 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfxBEWPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26DC29A2;
	Sat, 11 Oct 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173246; cv=none; b=icmLCQ2W8Uo+tdywKWouDpjAIh13PG3O/DicF5zwpjnU3Qao3FCjyNwADUhcT3AQnW4eUdITEpMveWZy3jRhi/3/mCiGJVxDShS1mjABuy+UA70JkyjwWrZolhIntG/T/hA5OchB4Z0067zc4Czcd0smacMwdgs1MZW2ptqf8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173246; c=relaxed/simple;
	bh=NmICyN7z5pd3yUB5P/aHf1eTN2vJpiuLtAiyWdk719s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mprrcxH30YB2Lu9SB6CA0WV1LiohkirFmtP/v2rfd5+QD8Opm+5ljKXGpn8VGryiGd7FE0CLWt3y9fOSrISFAnyFTELxlzUUjabv0XUSbJPJNUtX4U0kpO79YhYIlWQeNhySPpYNM5bhrbVJ6whKFmUOxuZvo2GBLnVFC8bq6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfxBEWPv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760173241; x=1791709241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NmICyN7z5pd3yUB5P/aHf1eTN2vJpiuLtAiyWdk719s=;
  b=OfxBEWPvucB9HGTXoh9O9ARboa7XhHXkYDKAdBAcM2ghE/o5COWTeesK
   9VpElkak2p/kYuooLPu2IYHFe+fmiRi0HB5SNbUdTMyDSRl2XOxu3zFbC
   APavLQjNJx3sP0f0Y8ERYdEMPVA0WSkAojrY8DoHdAzkJ2dpYrsdCpKmT
   xFkzPjh9vCvMW5PF0xkTMYUoTCL2TWWAaDNzv54MUGW/Nw6cS3EJOVf7e
   YWxAXvE5kl6hr+nG/XWkLitTOD86emAK3SqkXcnr7jSkXx/OPwH8pPXuS
   JxYS2MGiiTrZldY/rq1pXyiY01p6agAe1GbJxCWM+x7XbOd1aDhq1eai1
   Q==;
X-CSE-ConnectionGUID: 2IBvG2czTjmRPk5fhA+Vgg==
X-CSE-MsgGUID: hpSG8A7zTPGLniwD6OGWUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62277601"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62277601"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 02:00:40 -0700
X-CSE-ConnectionGUID: 4mnZvWzqSiqoAc10AJdWXw==
X-CSE-MsgGUID: GTrHiaj5QCSB0FokPuEspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181590217"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Oct 2025 02:00:34 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7VSq-0003f5-06;
	Sat, 11 Oct 2025 09:00:32 +0000
Date: Sat, 11 Oct 2025 17:00:15 +0800
From: kernel test robot <lkp@intel.com>
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, david@redhat.com,
	jane.chu@oracle.com, kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev, ziy@nvidia.com,
	akpm@linux-foundation.org, mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <202510111633.onu4Yaey-lkp@intel.com>
References: <20251010173906.3128789-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010173906.3128789-2-ziy@nvidia.com>

Hi Zi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17 next-20251010]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-huge_memory-do-not-change-split_huge_page-target-order-silently/20251011-014145
base:   linus/master
patch link:    https://lore.kernel.org/r/20251010173906.3128789-2-ziy%40nvidia.com
patch subject: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*() target order silently.
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20251011/202510111633.onu4Yaey-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111633.onu4Yaey-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111633.onu4Yaey-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/truncate.c: In function 'truncate_inode_partial_folio':
>> mm/truncate.c:229:14: error: too many arguments to function 'try_folio_split'; expected 3, have 4
     229 |         if (!try_folio_split(folio, split_at, NULL, min_order)) {
         |              ^~~~~~~~~~~~~~~                        ~~~~~~~~~
   In file included from include/linux/mm.h:1081,
                    from arch/parisc/include/asm/cacheflush.h:5,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/backing-dev.h:16,
                    from mm/truncate.c:12:
   include/linux/huge_mm.h:588:19: note: declared here
     588 | static inline int try_folio_split(struct folio *folio, struct page *page,
         |                   ^~~~~~~~~~~~~~~
   mm/truncate.c:259:25: error: too many arguments to function 'try_folio_split'; expected 3, have 4
     259 |                         try_folio_split(folio2, split_at2, NULL, min_order);
         |                         ^~~~~~~~~~~~~~~                          ~~~~~~~~~
   include/linux/huge_mm.h:588:19: note: declared here
     588 | static inline int try_folio_split(struct folio *folio, struct page *page,
         |                   ^~~~~~~~~~~~~~~


vim +/try_folio_split +229 mm/truncate.c

   179	
   180	/*
   181	 * Handle partial folios.  The folio may be entirely within the
   182	 * range if a split has raced with us.  If not, we zero the part of the
   183	 * folio that's within the [start, end] range, and then split the folio if
   184	 * it's large.  split_page_range() will discard pages which now lie beyond
   185	 * i_size, and we rely on the caller to discard pages which lie within a
   186	 * newly created hole.
   187	 *
   188	 * Returns false if splitting failed so the caller can avoid
   189	 * discarding the entire folio which is stubbornly unsplit.
   190	 */
   191	bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
   192	{
   193		loff_t pos = folio_pos(folio);
   194		size_t size = folio_size(folio);
   195		unsigned int offset, length;
   196		struct page *split_at, *split_at2;
   197		unsigned int min_order;
   198	
   199		if (pos < start)
   200			offset = start - pos;
   201		else
   202			offset = 0;
   203		if (pos + size <= (u64)end)
   204			length = size - offset;
   205		else
   206			length = end + 1 - pos - offset;
   207	
   208		folio_wait_writeback(folio);
   209		if (length == size) {
   210			truncate_inode_folio(folio->mapping, folio);
   211			return true;
   212		}
   213	
   214		/*
   215		 * We may be zeroing pages we're about to discard, but it avoids
   216		 * doing a complex calculation here, and then doing the zeroing
   217		 * anyway if the page split fails.
   218		 */
   219		if (!mapping_inaccessible(folio->mapping))
   220			folio_zero_range(folio, offset, length);
   221	
   222		if (folio_needs_release(folio))
   223			folio_invalidate(folio, offset, length);
   224		if (!folio_test_large(folio))
   225			return true;
   226	
   227		min_order = mapping_min_folio_order(folio->mapping);
   228		split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
 > 229		if (!try_folio_split(folio, split_at, NULL, min_order)) {
   230			/*
   231			 * try to split at offset + length to make sure folios within
   232			 * the range can be dropped, especially to avoid memory waste
   233			 * for shmem truncate
   234			 */
   235			struct folio *folio2;
   236	
   237			if (offset + length == size)
   238				goto no_split;
   239	
   240			split_at2 = folio_page(folio,
   241					PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
   242			folio2 = page_folio(split_at2);
   243	
   244			if (!folio_try_get(folio2))
   245				goto no_split;
   246	
   247			if (!folio_test_large(folio2))
   248				goto out;
   249	
   250			if (!folio_trylock(folio2))
   251				goto out;
   252	
   253			/*
   254			 * make sure folio2 is large and does not change its mapping.
   255			 * Its split result does not matter here.
   256			 */
   257			if (folio_test_large(folio2) &&
   258			    folio2->mapping == folio->mapping)
   259				try_folio_split(folio2, split_at2, NULL, min_order);
   260	
   261			folio_unlock(folio2);
   262	out:
   263			folio_put(folio2);
   264	no_split:
   265			return true;
   266		}
   267		if (folio_test_dirty(folio))
   268			return false;
   269		truncate_inode_folio(folio->mapping, folio);
   270		return true;
   271	}
   272	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

