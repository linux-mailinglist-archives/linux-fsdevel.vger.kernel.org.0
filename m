Return-Path: <linux-fsdevel+bounces-17907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9B8B3AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2269BB25D90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795D149001;
	Fri, 26 Apr 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAhOXheB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D801482F5;
	Fri, 26 Apr 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144146; cv=none; b=YKbf15Q7k+h6HDa+qUsKSe/IAs7xmRWgYiCOy2KlD/nK71jxUrLYPNuakdU9l69WXU25Mqt9SgrGENn+ETFd8WtumPSa8ZaRiO6y/zXeFVbcHo8UDJ6EZ8PzVmbUvXfWUxdgYtbsHzsrm8cZHyqKsbEiZUcuTAHmek48OwG5Lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144146; c=relaxed/simple;
	bh=1EfFaT2e5RgbE+xX1x4IG+RRoAmpjsYgLXgHqkDgINc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WATKM7pGM0k9FlVD23qyjLGQm0TOSpFsKBxu0Qa0ZzyfkyFxXdcINiEhr28RuEPUawsRnnyYD+pzM0Q3tdVEByAsQY9uYf+1ftTwRBWswvpLO2uIpm5RBDzvepcuSj64H7GJWOR9hksybsppX3x2XFtJCoxXYUIBL+9R1wF6G4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAhOXheB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DF4C113CD;
	Fri, 26 Apr 2024 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144146;
	bh=1EfFaT2e5RgbE+xX1x4IG+RRoAmpjsYgLXgHqkDgINc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAhOXheBGM++yaYo+e3kZwiwfI79o2O+mL2LPAt4MbZdYEC3+usp6A5WvqG8q6VgY
	 sNWFG1/roU/lp+Y6JgZH6fQko5jVQZJ7/JUnmuboqcjOJA1is3shxB3J0Gqoq+IgDI
	 Sz7OkjoSVqHebxZFlPhf7t638z13ZHyD5cZRRe6V/64VITnqh97YHZ097BYzkISUC4
	 dENjq3lZI0pbolHnBNDOOG7HMnhtmkNxRTDetfuLBe1OqBwvEqnsOJKXMn5TDoj8d6
	 yLXfDi6vKi08DuoYTLDdZ+6N+oWftN/JrWdhoBNONbz+QXJNcJJApZu1CKKg+No2Sz
	 WDFekvnZ35GFg==
Date: Fri, 26 Apr 2024 08:09:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 02/11] fs: Allow fine-grained control of folio sizes
Message-ID: <20240426150905.GC360919@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-3-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:37PM +0200, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Some filesystems want to be able to ensure that folios that are added to
> the page cache are at least a certain size.
> Add mapping_set_folio_min_order() to allow this level of control.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/pagemap.h | 116 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 96 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d..2e5612de1749 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -202,13 +202,18 @@ enum mapping_flags {
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
> +	AS_FOLIO_ORDER_MIN = 8,
> +	AS_FOLIO_ORDER_MAX = 13, /* Bit 8-17 are used for FOLIO_ORDER */
> +	AS_UNMOVABLE = 18,		/* The mapping cannot be moved, ever */
>  };
>  
> +#define AS_FOLIO_ORDER_MIN_MASK 0x00001f00
> +#define AS_FOLIO_ORDER_MAX_MASK 0x0003e000
> +#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
> +
>  /**
>   * mapping_set_error - record a writeback error in the address_space
>   * @mapping: the mapping in which an error should be set
> @@ -344,9 +349,63 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  	m->gfp_mask = mask;
>  }
>  
> +/*
> + * There are some parts of the kernel which assume that PMD entries
> + * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> + * limit the maximum allocation order to PMD size.  I'm not aware of any
> + * assumptions about maximum order if THP are disabled, but 8 seems like
> + * a good order (that's 1MB if you're using 4kB pages)
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define MAX_PAGECACHE_ORDER	8
> +#endif
> +
> +/*
> + * mapping_set_folio_order_range() - Set the folio order range
> + * @mapping: The address_space.
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
> +						 unsigned int min_order,
> +						 unsigned int max_order)
> +{
> +	if (min_order > MAX_PAGECACHE_ORDER)
> +		min_order = MAX_PAGECACHE_ORDER;
> +
> +	if (max_order > MAX_PAGECACHE_ORDER)
> +		max_order = MAX_PAGECACHE_ORDER;
> +
> +	max_order = max(max_order, min_order);
> +	/*
> +	 * TODO: max_order is not yet supported in filemap.
> +	 */
> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +			 (min_order << AS_FOLIO_ORDER_MIN) |
> +			 (max_order << AS_FOLIO_ORDER_MAX);
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
> + * @mapping: The address_space.
>   *
>   * The filesystem should call this function in its inode constructor to
>   * indicate that the VFS can use large folios to cache the contents of
> @@ -357,7 +416,37 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>   */
>  static inline void mapping_set_large_folios(struct address_space *mapping)
>  {
> -	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
> +}
> +
> +static inline unsigned int mapping_max_folio_order(struct address_space *mapping)
> +{
> +	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
> +}
> +
> +static inline unsigned int mapping_min_folio_order(struct address_space *mapping)
> +{
> +	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
> +}
> +
> +static inline unsigned long mapping_min_folio_nrpages(struct address_space *mapping)
> +{
> +	return 1UL << mapping_min_folio_order(mapping);
> +}
> +
> +/**
> + * mapping_align_start_index() - Align starting index based on the min
> + * folio order of the page cache.
> + * @mapping: The address_space.
> + *
> + * Ensure the index used is aligned to the minimum folio order when adding
> + * new folios to the page cache by rounding down to the nearest minimum
> + * folio number of pages.
> + */
> +static inline pgoff_t mapping_align_start_index(struct address_space *mapping,
> +						pgoff_t index)
> +{
> +	return round_down(index, mapping_min_folio_nrpages(mapping));
>  }
>  
>  /*
> @@ -367,7 +456,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
>  static inline bool mapping_large_folio_support(struct address_space *mapping)
>  {
>  	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	       (mapping_max_folio_order(mapping) > 0);
>  }
>  
>  static inline int filemap_nr_thps(struct address_space *mapping)
> @@ -528,19 +617,6 @@ static inline void *detach_page_private(struct page *page)
>  	return folio_detach_private(page_folio(page));
>  }
>  
> -/*
> - * There are some parts of the kernel which assume that PMD entries
> - * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> - * limit the maximum allocation order to PMD size.  I'm not aware of any
> - * assumptions about maximum order if THP are disabled, but 8 seems like
> - * a good order (that's 1MB if you're using 4kB pages)
> - */
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> -#else
> -#define MAX_PAGECACHE_ORDER	8
> -#endif
> -
>  #ifdef CONFIG_NUMA
>  struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
>  #else
> -- 
> 2.34.1
> 
> 

