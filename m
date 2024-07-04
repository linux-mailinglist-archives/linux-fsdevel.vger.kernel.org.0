Return-Path: <linux-fsdevel+bounces-23121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4A9275DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0B91C22D5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E61AE849;
	Thu,  4 Jul 2024 12:23:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586C1DFF8;
	Thu,  4 Jul 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095809; cv=none; b=FQryqjM+1d6sNXP9J8fImcWSHigomRGKFCUt5c2hAEWg3OPELTxdR+xWvMLXySM+xJ86lm09HqnjL4anLZoT0wfHxsInEcsZtW5xgRcN6NERqDpO1lcPYEm1deGsHmYUMYNaqbR8x9iEssvJlAwxhgzJFp6nh3Yyb0VnvA7OMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095809; c=relaxed/simple;
	bh=Y5QjDjXX0VA+8pkrBV75lbIfi099/i/j1WUgt1fHJGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL0KFQfz5/iWJnBapDi/0gQAi3hfWLvcUFZCnWph/UEUEzfwgDPamV2sCzZZca2O/q9QocB6IZ/mp7FOzmwAksVMTkNwyoME5WbYpuEA2khabLfyaP1orTgD+jKW53g2icQ40XeNV797Rfb9tiONzanY/qyPnDVJ1Ryx240W9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A14367;
	Thu,  4 Jul 2024 05:23:50 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D8933F762;
	Thu,  4 Jul 2024 05:23:22 -0700 (PDT)
Message-ID: <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
Date: Thu, 4 Jul 2024 13:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
 brauner@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
 linux-mm@kvack.org, john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
 hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org, gost.dev@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 Zi Yan <zi.yan@sent.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240625114420.719014-2-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Here are some drive-by review comments as I'm evaluating whether these patches
can help me with what I'm trying to do at
https://lore.kernel.org/linux-mm/20240215154059.2863126-1-ryan.roberts@arm.com/...


On 25/06/2024 12:44, Pankaj Raghav (Samsung) wrote:
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
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  include/linux/pagemap.h | 86 ++++++++++++++++++++++++++++++++++-------
>  mm/filemap.c            |  6 +--
>  mm/readahead.c          |  4 +-
>  3 files changed, 77 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 4b71d581091f..0c51154cdb57 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,14 +204,21 @@ enum mapping_flags {
>  	AS_EXITING	= 4, 	/* final truncate in progress */
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,

nit: this removed enum is still referenced in a comment further down the file.

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

nit: These 3 new enums seem a bit odd. It might be clearer if you just reserve
the bits for the fields here? AS_FOLIO_ORDER_BITS isn't actually a flags bit and
the MAX value is currently the start of the max field, not the end.

#define AS_FOLIO_ORDER_BITS 5

enum mapping_flags {
	...
	AS_FOLIO_ORDERS_FIRST = 16,
	AS_FOLIO_ORDERS_LAST = AS_FOLIO_ORDERS_FIRST+(2*AS_FOLIO_ORDER_BITS)-1,
	...
};

#define AS_FOLIO_ORDER_MIN_MASK \
	GENMASK(AS_FOLIO_ORDERS_FIRST + AS_FOLIO_ORDER_BITS - 1, \
		AS_FOLIO_ORDERS_FIRST)
#define AS_FOLIO_ORDER_MAX_MASK \
	GENMASK(AS_FOLIO_ORDERS_LAST, \
		AS_FOLIO_ORDERS_LAST - AS_FOLIO_ORDER_BITS + 1)

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

It seems strange to silently clamp these? Presumably for the bs>ps usecase,
whatever values are passed in are a hard requirement? So wouldn't want them to
be silently reduced. (Especially given the recent change to reduce the size of
MAX_PAGECACHE_ORDER to less then PMD size in some cases).

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
> @@ -386,16 +449,13 @@ static inline bool mapping_large_folio_support(struct address_space *mapping)
>  	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
>  			"Anonymous mapping always supports large folio");
>  
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
> index 0b8c732bb643..d617c9afca51 100644
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
> index c1b23989d9ca..66058ae02f2e 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -503,9 +503,9 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	limit = min(limit, index + ra->size - 1);
>  
> -	if (new_order < MAX_PAGECACHE_ORDER) {
> +	if (new_order < mapping_max_folio_order(mapping)) {
>  		new_order += 2;
> -		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
> +		new_order = min(mapping_max_folio_order(mapping), new_order);
>  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));

I wonder if its possible that ra->size could ever be less than
mapping_min_folio_order()? Do you need to handle that?

Thanks,
Ryan

>  	}
>  


