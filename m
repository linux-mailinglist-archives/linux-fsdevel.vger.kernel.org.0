Return-Path: <linux-fsdevel+bounces-21539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF090571F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075DB28682B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E9180A69;
	Wed, 12 Jun 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b77FuOqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F117E459;
	Wed, 12 Jun 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206699; cv=none; b=rIQF6LXVy2xu4eBtIzjeKkdAF/6X9qEzakDVg06aVdOrhljyVSXVZJk56rfjfJxEErrmrR2dg+JMMvNfUi3AVYlDoWUmBzBN9glJ7xNtiNoAtKLxgm1Xel4JyjEECdhrvd64nUgs9WjDU5/SEWmtTCYvG4oKLUbaeuiG6FuOeLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206699; c=relaxed/simple;
	bh=GhEQV951Rgveo5IXjSKGMBu8FQMmaP1O2TS2Zw66Oeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn3qx3chxvsy++ltmnJCOXkjWrVotpQXxjlq4K8RLstINTq6Y/bSsUT/2ppPSWtgfuzV7jA/NAFO2rLxig7meCpK0E70IiNrlVExXUaaH/dn5/k9P2AF7/ohOkd52+OTrAjevuBpeX7sg0mab5xA0tq+nQwkpZu36a+0x1Njfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b77FuOqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2DCC116B1;
	Wed, 12 Jun 2024 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206698;
	bh=GhEQV951Rgveo5IXjSKGMBu8FQMmaP1O2TS2Zw66Oeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b77FuOqPWmCfZ508+vsvox/n9776x053NS+9Yzkb3HFU5pbf7qCXW4cZUDLKCToLP
	 z8F6ur2LW3AWU0UxlgvYxP+00HlCzFC4QY2w2onMVGhaZ4/Ux9gBnPzCODEv0pS/mo
	 9BAv/Egstz3QYspZHkFsmyBc5ZNTptS5AEWFhrSA//ddymUZRkZVrZbp1jUmR0ukZA
	 bebf5RFROjAbTDW7egr+/m8bXxJNzbIMUU0OVJ6EPDcA4cE/8RbqMtoFIr36iMDvlH
	 gN3Nw4sFnftEEsEKMEQpkxOuaykPN90noxOyO0+nRVe9dlaBATySeOycUZjdMAKacV
	 g5Qe3sdJBJSlQ==
Date: Wed, 12 Jun 2024 08:38:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 02/11] fs: Allow fine-grained control of folio sizes
Message-ID: <20240612153818.GA2764752@frogsfrogsfrogs>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-3-kernel@pankajraghav.com>

On Fri, Jun 07, 2024 at 02:58:53PM +0000, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We need filesystems to be able to communicate acceptable folio sizes
> to the pagecache for a variety of uses (e.g. large block sizes).
> Support a range of folio sizes between order-0 and order-31.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/pagemap.h | 86 ++++++++++++++++++++++++++++++++++-------
>  mm/filemap.c            |  6 +--
>  mm/readahead.c          |  4 +-
>  3 files changed, 77 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 8f09ed4a4451..228275e7049f 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,14 +204,21 @@ enum mapping_flags {
>  	AS_EXITING	= 4, 	/* final truncate in progress */
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,
> -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>  				   folio contents */
> -	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
> -	AS_INACCESSIBLE,	/* Do not attempt direct R/W access to the mapping */
> +	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
> +	AS_INACCESSIBLE = 9,	/* Do not attempt direct R/W access to the mapping */
> +	/* Bits 16-25 are used for FOLIO_ORDER */
> +	AS_FOLIO_ORDER_BITS = 5,
> +	AS_FOLIO_ORDER_MIN = 16,
> +	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
>  };
>  
> +#define AS_FOLIO_ORDER_MASK     ((1u << AS_FOLIO_ORDER_BITS) - 1)
> +#define AS_FOLIO_ORDER_MIN_MASK (AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MIN)
> +#define AS_FOLIO_ORDER_MAX_MASK (AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MAX)
> +
>  /**
>   * mapping_set_error - record a writeback error in the address_space
>   * @mapping: the mapping in which an error should be set
> @@ -360,9 +367,49 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  #define MAX_PAGECACHE_ORDER	8
>  #endif
>  
> +/*
> + * mapping_set_folio_order_range() - Set the orders supported by a file.
> + * @mapping: The address space of the file.
> + * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> + * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate which base size (min) and maximum size (max) of folio the VFS
> + * can use to cache the contents of the file.  This should only be used
> + * if the filesystem needs special handling of folio sizes (ie there is
> + * something the core cannot know).
> + * Do not tune it based on, eg, i_size.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> +						 unsigned int min,
> +						 unsigned int max)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return;
> +
> +	if (min > MAX_PAGECACHE_ORDER)
> +		min = MAX_PAGECACHE_ORDER;
> +	if (max > MAX_PAGECACHE_ORDER)
> +		max = MAX_PAGECACHE_ORDER;
> +	if (max < min)
> +		max = min;
> +
> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +		(min << AS_FOLIO_ORDER_MIN) | (max << AS_FOLIO_ORDER_MAX);
> +}
> +
> +static inline void mapping_set_folio_min_order(struct address_space *mapping,
> +					       unsigned int min)
> +{
> +	mapping_set_folio_order_range(mapping, min, MAX_PAGECACHE_ORDER);
> +}
> +
>  /**
>   * mapping_set_large_folios() - Indicate the file supports large folios.
> - * @mapping: The file.
> + * @mapping: The address space of the file.
>   *
>   * The filesystem should call this function in its inode constructor to
>   * indicate that the VFS can use large folios to cache the contents of
> @@ -373,7 +420,23 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>   */
>  static inline void mapping_set_large_folios(struct address_space *mapping)
>  {
> -	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
> +}
> +
> +static inline
> +unsigned int mapping_max_folio_order(const struct address_space *mapping)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;
> +	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
> +}
> +
> +static inline
> +unsigned int mapping_min_folio_order(const struct address_space *mapping)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;
> +	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
>  }
>  
>  /*
> @@ -382,16 +445,13 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
>   */
>  static inline bool mapping_large_folio_support(struct address_space *mapping)
>  {
> -	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	return mapping_max_folio_order(mapping) > 0;
>  }
>  
>  /* Return the maximum folio size for this pagecache mapping, in bytes. */
> -static inline size_t mapping_max_folio_size(struct address_space *mapping)
> +static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>  {
> -	if (mapping_large_folio_support(mapping))
> -		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
> -	return PAGE_SIZE;
> +	return PAGE_SIZE << mapping_max_folio_order(mapping);
>  }
>  
>  static inline int filemap_nr_thps(struct address_space *mapping)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 37061aafd191..46c7a6f59788 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1933,10 +1933,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
>  			fgp_flags |= FGP_LOCK;
>  
> -		if (!mapping_large_folio_support(mapping))
> -			order = 0;
> -		if (order > MAX_PAGECACHE_ORDER)
> -			order = MAX_PAGECACHE_ORDER;
> +		if (order > mapping_max_folio_order(mapping))
> +			order = mapping_max_folio_order(mapping);
>  		/* If we're not aligned, allocate a smaller folio */
>  		if (index & ((1UL << order) - 1))
>  			order = __ffs(index);
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 75e934a1fd78..da34b28da02c 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -504,9 +504,9 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	limit = min(limit, index + ra->size - 1);
>  
> -	if (new_order < MAX_PAGECACHE_ORDER) {
> +	if (new_order < mapping_max_folio_order(mapping)) {
>  		new_order += 2;
> -		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
> +		new_order = min(mapping_max_folio_order(mapping), new_order);
>  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	}
>  
> -- 
> 2.44.1
> 
> 

