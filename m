Return-Path: <linux-fsdevel+bounces-19304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D008C2FB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 07:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADE71F22F4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92447A7A;
	Sat, 11 May 2024 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNF6AtDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DA8C13;
	Sat, 11 May 2024 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715406108; cv=none; b=uyR6WmMwq7DY9QdNHGC6GqmbRCHIePFMZTsGZcFobz0ugmlqkKM3lHF+Y0WJZtgBP9wh8/42YxL8VqOqYQ39RCdVn4vZZjITTT8fNwk2cXYyqK6EeJCvttqG/x3ExrFM9mWU5+h0PynKv6QOAqdc93R5wo9pWBBdmd4jWdw+Vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715406108; c=relaxed/simple;
	bh=vKgo1rxMrX85fnLlODxarqhoWbgiR3+i3AwVqY8M3Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgO+8La6Nrj6/Axu35sP86tXxrvPaTfAeVqbcjax0jvxaCK/wG7utXmNfvRE8qzeFt/G2wKSUggMAer5qzYbs3uhL/S2KvQdjGw6Ij/aiq2dZnL7BXft3dNpkyh3jpAaD5xjqYvnSDmGOhwaBzqf0wcD2jyao5cX9UYAfQodPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNF6AtDt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715406106; x=1746942106;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vKgo1rxMrX85fnLlODxarqhoWbgiR3+i3AwVqY8M3Uc=;
  b=mNF6AtDtUTv7DFSiFLl/jFu6zGI3dmHBhFEKndl3UFrq9TUWaFU5q4tw
   RwQXUlaHsTLwbxtiyvOlRNpO8zeHhN1hwYh9dcz3dCttsqKGSrHfLODjq
   Es58Bs9ABuvmpRFsMbksPan5l+yNMIFJLlWPz4IbBhoAPBuyuhQpb02Co
   X4cIEMH3vvPM4GzQflBqbZdyWBd5G4oxcETibJEo8crPenIcTThoAbw61
   0CB+eq+T/K494vy5PT+z65Vx9tfGAA/cdDKrOCKCFGdhHSf+Kohhbc2f7
   xXsJFEdGZxlHsHx4supjPjzGCA1/8sRWM7ic4ibwnale+M0dTq0XVAA+8
   A==;
X-CSE-ConnectionGUID: xu5Es2VXT2CaGAT5ZctXFQ==
X-CSE-MsgGUID: G/eWI42GTNiu4qHkC4Sxsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="33918552"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="33918552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:41:46 -0700
X-CSE-ConnectionGUID: gzzJlJ0sRvGdkdKmgarTug==
X-CSE-MsgGUID: HSnXpZt5TO6cQtBRG/rGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34702998"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:41:42 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  David Hildenbrand <david@redhat.com>,  Hugh Dickins
 <hughd@google.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/12] mm: drop page_index and simplify folio_index
In-Reply-To: <20240510114747.21548-12-ryncsn@gmail.com> (Kairui Song's message
	of "Fri, 10 May 2024 19:47:46 +0800")
References: <20240510114747.21548-1-ryncsn@gmail.com>
	<20240510114747.21548-12-ryncsn@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 11 May 2024 13:39:50 +0800
Message-ID: <87o79chpp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> There are two helpers for retrieving the index within address space
> for mixed usage of swap cache and page cache:
>
> - page_index
> - folio_index
>
> This commit drops page_index, as we have eliminated all users, and
> converts folio_index's helper __page_file_index to use folio to avoid
> the page convertion.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  include/linux/mm.h      | 13 -------------
>  include/linux/pagemap.h |  8 ++++----
>  mm/swapfile.c           |  7 +++----
>  3 files changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..e2718cac0fda 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2290,19 +2290,6 @@ static inline void *folio_address(const struct folio *folio)
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
> index a324582ea702..0cfa5810cde3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -778,7 +778,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
>  			mapping_gfp_mask(mapping));
>  }
>  
> -#define swapcache_index(folio)	__page_file_index(&(folio)->page)
> +extern pgoff_t __folio_swap_cache_index(struct folio *folio);
>  
>  /**
>   * folio_index - File index of a folio.
> @@ -793,9 +793,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
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
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f6ca215fb92f..0b0ae6e8c764 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3474,12 +3474,11 @@ struct address_space *swapcache_mapping(struct folio *folio)
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
>  
>  /*
>   * add_swap_count_continuation - called when a swap count is duplicated

