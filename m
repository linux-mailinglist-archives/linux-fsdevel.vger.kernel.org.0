Return-Path: <linux-fsdevel+bounces-23132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A6792783D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176ADB20C91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51611B0103;
	Thu,  4 Jul 2024 14:24:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A81D2F5;
	Thu,  4 Jul 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103058; cv=none; b=ltz4T/5lWxajo9h9NF3sNUcGZ5BE9bLmrsii5lPz0M5/5gQf1evfe85E9ZtzFDJm4eqwuhY4gAZ7+zgtQAO4lNO+VXjIuUaXIZYz4Rk+YGiBE5gh41lkz2L7uvqQD27b2lTvZ+wfDhL2N7tCK4VbH5oQNEkvT5OAhUo3GDSkGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103058; c=relaxed/simple;
	bh=OEHQ7C893Gjev4bvMfn1iM0WMS4Q5I2bihnm8aIUGr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5JlOAuBfI1KRKcDe8eGjRhilymQ8xGdbUKAuOYblKh9GtzgnkiIkv3rOYUoEjxcD+GCK8lTNBpYrYaeTVpm+7ZOuMCPI5AuWxqfjGVVJXToX+Hs3XHsdvcDjXM0YTV+jd4ORRcAvud7XqlOZwyCO+IeFTtC0gmT6puDyW5P/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35EA8367;
	Thu,  4 Jul 2024 07:24:40 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29AE33F766;
	Thu,  4 Jul 2024 07:24:12 -0700 (PDT)
Message-ID: <98790338-0f86-4658-8dec-95e94b6d5c18@arm.com>
Date: Thu, 4 Jul 2024 15:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] readahead: allocate folios with
 mapping_min_order in readahead
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
 <20240625114420.719014-4-kernel@pankajraghav.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240625114420.719014-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2024 12:44, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> page_cache_ra_unbounded() was allocating single pages (0 order folios)
> if there was no folio found in an index. Allocate mapping_min_order folios
> as we need to guarantee the minimum order if it is set.
> While we are at it, rework the loop in page_cache_ra_unbounded() to
> advance with the number of pages in a folio instead of just one page at
> a time.
> 
> page_cache_ra_order() tries to allocate folio to the page cache with a
> higher order if the index aligns with that order. Modify it so that the
> order does not go below the mapping_min_order requirement of the page
> cache. This function will do the right thing even if the new_order passed
> is less than the mapping_min_order.
> When adding new folios to the page cache we must also ensure the index
> used is aligned to the mapping_min_order as the page cache requires the
> index to be aligned to the order of the folio.
> 
> readahead_expand() is called from readahead aops to extend the range of
> the readahead so this function can assume ractl->_index to be aligned with
> min_order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Co-developed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  mm/readahead.c | 81 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 66058ae02f2e..2acfd6447d7b 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -206,9 +206,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  		unsigned long nr_to_read, unsigned long lookahead_size)
>  {
>  	struct address_space *mapping = ractl->mapping;
> -	unsigned long index = readahead_index(ractl);
> +	unsigned long ra_folio_index, index = readahead_index(ractl);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> -	unsigned long i;
> +	unsigned long mark, i = 0;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
>  
>  	/*
>  	 * Partway through the readahead operation, we will have added
> @@ -223,10 +224,26 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	unsigned int nofs = memalloc_nofs_save();
>  
>  	filemap_invalidate_lock_shared(mapping);
> +	index = mapping_align_index(mapping, index);
> +
> +	/*
> +	 * As iterator `i` is aligned to min_nrpages, round_up the
> +	 * difference between nr_to_read and lookahead_size to mark the
> +	 * index that only has lookahead or "async_region" to set the
> +	 * readahead flag.
> +	 */
> +	ra_folio_index = round_up(readahead_index(ractl) + nr_to_read - lookahead_size,
> +				  min_nrpages);
> +	mark = ra_folio_index - index;
> +	if (index != readahead_index(ractl)) {
> +		nr_to_read += readahead_index(ractl) - index;
> +		ractl->_index = index;
> +	}
> +
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */
> -	for (i = 0; i < nr_to_read; i++) {
> +	while (i < nr_to_read) {
>  		struct folio *folio = xa_load(&mapping->i_pages, index + i);
>  		int ret;
>  
> @@ -240,12 +257,13 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */

For the case that the folio is already in the xarray, perhaps its worth
asserting that the folio is at least min_nrpages?


>  			read_pages(ractl);
> -			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			ractl->_index += min_nrpages;
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask,
> +					    mapping_min_folio_order(mapping));
>  		if (!folio)
>  			break;
>  
> @@ -255,14 +273,15 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			if (ret == -ENOMEM)
>  				break;
>  			read_pages(ractl);
> -			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			ractl->_index += min_nrpages;
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
> -		if (i == nr_to_read - lookahead_size)
> +		if (i == mark)
>  			folio_set_readahead(folio);
>  		ractl->_workingset |= folio_test_workingset(folio);
> -		ractl->_nr_pages++;
> +		ractl->_nr_pages += min_nrpages;
> +		i += min_nrpages;
>  	}
>  
>  	/*
> @@ -492,13 +511,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  {
>  	struct address_space *mapping = ractl->mapping;
>  	pgoff_t index = readahead_index(ractl);
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
>  	pgoff_t mark = index + ra->size - ra->async_size;
>  	unsigned int nofs;
>  	int err = 0;
>  	gfp_t gfp = readahead_gfp_mask(mapping);
> +	unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
>  
> -	if (!mapping_large_folio_support(mapping) || ra->size < 4)
> +	/*
> +	 * Fallback when size < min_nrpages as each folio should be
> +	 * at least min_nrpages anyway.
> +	 */
> +	if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
>  		goto fallback;
>  
>  	limit = min(limit, index + ra->size - 1);
> @@ -507,11 +532,20 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		new_order += 2;
>  		new_order = min(mapping_max_folio_order(mapping), new_order);
>  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
> +		new_order = max(new_order, min_order);
>  	}
>  
>  	/* See comment in page_cache_ra_unbounded() */
>  	nofs = memalloc_nofs_save();
>  	filemap_invalidate_lock_shared(mapping);
> +	/*
> +	 * If the new_order is greater than min_order and index is
> +	 * already aligned to new_order, then this will be noop as index
> +	 * aligned to new_order should also be aligned to min_order.
> +	 */
> +	ractl->_index = mapping_align_index(mapping, index);
> +	index = readahead_index(ractl);
> +
>  	while (index <= limit) {
>  		unsigned int order = new_order;
>  
> @@ -519,7 +553,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		if (index & ((1UL << order) - 1))
>  			order = __ffs(index);
>  		/* Don't allocate pages past EOF */
> -		while (index + (1UL << order) - 1 > limit)
> +		while (order > min_order && index + (1UL << order) - 1 > limit)
>  			order--;
>  		err = ra_alloc_folio(ractl, index, mark, order, gfp);
>  		if (err)
> @@ -783,8 +817,15 @@ void readahead_expand(struct readahead_control *ractl,
>  	struct file_ra_state *ra = ractl->ra;
>  	pgoff_t new_index, new_nr_pages;
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	unsigned long min_nrpages = mapping_min_folio_nrpages(mapping);
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  
>  	new_index = new_start / PAGE_SIZE;
> +	/*
> +	 * Readahead code should have aligned the ractl->_index to
> +	 * min_nrpages before calling readahead aops.
> +	 */
> +	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
>  
>  	/* Expand the leading edge downwards */
>  	while (ractl->_index > new_index) {
> @@ -794,9 +835,11 @@ void readahead_expand(struct readahead_control *ractl,
>  		if (folio && !xa_is_value(folio))
>  			return; /* Folio apparently present */
>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask, min_order);
>  		if (!folio)
>  			return;
> +
> +		index = mapping_align_index(mapping, index);
>  		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
>  			folio_put(folio);
>  			return;
> @@ -806,7 +849,7 @@ void readahead_expand(struct readahead_control *ractl,
>  			ractl->_workingset = true;
>  			psi_memstall_enter(&ractl->_pflags);
>  		}
> -		ractl->_nr_pages++;
> +		ractl->_nr_pages += min_nrpages;
>  		ractl->_index = folio->index;
>  	}
>  
> @@ -821,9 +864,11 @@ void readahead_expand(struct readahead_control *ractl,
>  		if (folio && !xa_is_value(folio))
>  			return; /* Folio apparently present */
>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask, min_order);
>  		if (!folio)
>  			return;
> +
> +		index = mapping_align_index(mapping, index);
>  		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
>  			folio_put(folio);
>  			return;
> @@ -833,10 +878,10 @@ void readahead_expand(struct readahead_control *ractl,
>  			ractl->_workingset = true;
>  			psi_memstall_enter(&ractl->_pflags);
>  		}
> -		ractl->_nr_pages++;
> +		ractl->_nr_pages += min_nrpages;
>  		if (ra) {
> -			ra->size++;
> -			ra->async_size++;
> +			ra->size += min_nrpages;
> +			ra->async_size += min_nrpages;
>  		}
>  	}
>  }


