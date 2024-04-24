Return-Path: <linux-fsdevel+bounces-17574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB38AFE44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 04:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8821F234B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 02:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65221401F;
	Wed, 24 Apr 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrLmDOu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C8613D;
	Wed, 24 Apr 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925144; cv=none; b=hCKnKEz7kDqeFuAYPBdlyVelfg16TjehexNNwA1XsoKf2dbSTOy1o2pCSwO4/GbVDssRJ4XliQcc0Pgplt3g6vu+6D6OsOVvelkMW61JK1t7aVnrVcjTVt1Ryt53QNSH1N4W+ytn2UcmQ7z5hANMOGYOjc3aI4H9rbeb8gPPJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925144; c=relaxed/simple;
	bh=622WZlwVCJJhM5NFaUq2YGnX21+RyuFNnIvaTcGnoUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jI74zVIsAA+WnnsCPiEr7+aUfx8232dGTAA4X6RuiglTV5CMgMDHqEL5wpA+SHbHeyNk3tVzHZJEFwKAGagJlMofjEDGGPP45N9ULJ6WdPuniD+lmbYY7YpYEmscEufDxMhaFPPou111DhTXhl3smxkWpDcVbb7lgyWA6Pxz0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrLmDOu+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713925143; x=1745461143;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=622WZlwVCJJhM5NFaUq2YGnX21+RyuFNnIvaTcGnoUU=;
  b=IrLmDOu+HtTDnO5vGJzCdcKuhVIH7MHv9HEIuZ3SsOd055pQtSuzu5NC
   YDSWSncHkiWxeQ+lrpqFbRgNYZ2m0TUDZBDE26xQ2I/zz5OhvjwpyDzl6
   iR2bNIklNMIJbPUDE0G2YBmoAr6nXvyWcwPd5udfIbWb6tS6K3RfoEhj+
   4dFU5WowDv7Wn7hchP9yuXckGohWCMZHtA94tuFKiqdQLvtm6T5r1PFMU
   y4XSAMluTjqyD084DXnnKaMpQD77Jgm6urP2rNeZhi976ZDbe6r7iPKsw
   0CWYxlffK+GFnBZG4oYqiP1yVWSj3hSrOHHx60PN6Stacv4OohJhTRTHI
   A==;
X-CSE-ConnectionGUID: OKiHOjnfSDqcxyi94oANwQ==
X-CSE-MsgGUID: v+5CY05ZRYq8DhqbsA8rLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9365434"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9365434"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:19:02 -0700
X-CSE-ConnectionGUID: SZ7/5vfdTAKglyVcecXQOg==
X-CSE-MsgGUID: niJKYeGpT92AO/eeePjt1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24601983"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:18:57 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>,
 linux-afs@lists.infradead.org, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH v2 7/8] mm: drop page_index/page_file_offset and convert
 swap helpers to use folio
In-Reply-To: <20240423170339.54131-8-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 24 Apr 2024 01:03:38 +0800")
References: <20240423170339.54131-1-ryncsn@gmail.com>
	<20240423170339.54131-8-ryncsn@gmail.com>
Date: Wed, 24 Apr 2024 10:17:04 +0800
Message-ID: <87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> There are four helpers for retrieving the page index within address
> space, or offset within mapped file:
>
> - page_index
> - page_file_offset
> - folio_index (equivalence of page_index)
> - folio_file_pos (equivalence of page_file_offset)
>
> And they are only needed for mixed usage of swap cache & page cache (eg.
> migration, huge memory split). Else users can just use folio->index or
> folio_pos.
>
> This commit drops page_index and page_file_offset as we have eliminated
> all users, and converts folio_index and folio_file_pos (they were simply
> wrappers of page_index and page_file_offset, and implemented in a not
> very clean way) to use folio internally.
>
> After this commit, there will be only two helpers for users that may
> encounter mixed usage of swap cache and page cache:
>
> - folio_index (calls __folio_swap_cache_index for swap cache folio)
> - folio_file_pos (calls __folio_swap_dev_pos for swap cache folio)
>
> The index in swap cache and offset in swap device are still basically
> the same thing, but will be different in following commits.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm.h      | 13 -------------
>  include/linux/pagemap.h | 19 +++++++++----------
>  mm/swapfile.c           | 13 +++++++++----
>  3 files changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0436b919f1c7..797480e76c9c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2245,19 +2245,6 @@ static inline void *folio_address(const struct folio *folio)
>  	return page_address(&folio->page);
>  }
>  
> -extern pgoff_t __page_file_index(struct page *page);
> -
> -/*
> - * Return the pagecache index of the passed page.  Regular pagecache pages
> - * use ->index whereas swapcache pages use swp_offset(->private)
> - */
> -static inline pgoff_t page_index(struct page *page)
> -{
> -	if (unlikely(PageSwapCache(page)))
> -		return __page_file_index(page);
> -	return page->index;
> -}
> -
>  /*
>   * Return true only if the page has been allocated with
>   * ALLOC_NO_WATERMARKS and the low watermark was not
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d..a7d025571ee6 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -780,7 +780,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
>  			mapping_gfp_mask(mapping));
>  }
>  
> -#define swapcache_index(folio)	__page_file_index(&(folio)->page)
> +extern pgoff_t __folio_swap_cache_index(struct folio *folio);
>  
>  /**
>   * folio_index - File index of a folio.
> @@ -795,9 +795,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
>   */
>  static inline pgoff_t folio_index(struct folio *folio)
>  {
> -        if (unlikely(folio_test_swapcache(folio)))
> -                return swapcache_index(folio);
> -        return folio->index;
> +	if (unlikely(folio_test_swapcache(folio)))
> +		return __folio_swap_cache_index(folio);
> +	return folio->index;
>  }
>  
>  /**
> @@ -920,11 +920,6 @@ static inline loff_t page_offset(struct page *page)
>  	return ((loff_t)page->index) << PAGE_SHIFT;
>  }
>  
> -static inline loff_t page_file_offset(struct page *page)
> -{
> -	return ((loff_t)page_index(page)) << PAGE_SHIFT;
> -}
> -
>  /**
>   * folio_pos - Returns the byte position of this folio in its file.
>   * @folio: The folio.
> @@ -934,6 +929,8 @@ static inline loff_t folio_pos(struct folio *folio)
>  	return page_offset(&folio->page);
>  }
>  
> +extern loff_t __folio_swap_dev_pos(struct folio *folio);
> +
>  /**
>   * folio_file_pos - Returns the byte position of this folio in its file.
>   * @folio: The folio.
> @@ -943,7 +940,9 @@ static inline loff_t folio_pos(struct folio *folio)
>   */
>  static inline loff_t folio_file_pos(struct folio *folio)
>  {
> -	return page_file_offset(&folio->page);
> +	if (unlikely(folio_test_swapcache(folio)))
> +		return __folio_swap_dev_pos(folio);
> +	return ((loff_t)folio->index << PAGE_SHIFT);

This still looks confusing for me.  The function returns the byte
position of the folio in its file.  But we returns the swap device
position of the folio.

Tried to search folio_file_pos() usage.  The 2 usage in page_io.c is
swap specific, we can use swap_dev_pos() directly.

There are also other file system users (NFS and AFS) of
folio_file_pos(), I don't know why they need to work with swap
cache. Cced file system maintainers for help.

>  }
>  
>  /*
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4919423cce76..2387f5e131d7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3419,12 +3419,17 @@ struct address_space *swapcache_mapping(struct folio *folio)
>  }
>  EXPORT_SYMBOL_GPL(swapcache_mapping);
>  
> -pgoff_t __page_file_index(struct page *page)
> +pgoff_t __folio_swap_cache_index(struct folio *folio)
>  {
> -	swp_entry_t swap = page_swap_entry(page);
> -	return swp_offset(swap);
> +	return swp_offset(folio->swap);
>  }
> -EXPORT_SYMBOL_GPL(__page_file_index);
> +EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
> +
> +loff_t __folio_swap_dev_pos(struct folio *folio)
> +{
> +	return swap_dev_pos(folio->swap);
> +}
> +EXPORT_SYMBOL_GPL(__folio_swap_dev_pos);
>  
>  /*
>   * add_swap_count_continuation - called when a swap count is duplicated

--
Best Regards,
Huang, Ying

