Return-Path: <linux-fsdevel+bounces-22974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26920924878
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 21:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9063BB22962
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B01CE091;
	Tue,  2 Jul 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsOOPoLN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AD1CCCDA;
	Tue,  2 Jul 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949112; cv=none; b=f9weZsLUxOq4iDhZ8q3G4p9eR5vjzaYpCKdLZlkUMLvUvve+iRoNma9XM2pDuMwV6ckmEKgDzhfDFjMxmlO/3HlTTCo/tpYuJQmyINiFUGSLi/EWKS8z47adJot1pQHI78ox2wUj1LAatpRpsi+6LSEgvJUw53+gpKHKw2nmDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949112; c=relaxed/simple;
	bh=iUNdoj/wPDxjLTPgtKmz7+YGlVRjPAtE2/pv9NEzpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6Un2ByUb5YgKDeWxyLo/LxXBWapN3hHYhnAjIdhl1BZ5icVBqHikH9r7zQN0cfTNvpfJuWcJJgmen7o2nznvVdbw2fU2G2w9cd6WOi5nSncgDUuP1qzascmZHj0Y9hklDpPtSQT5ftcYGZd8gnSpfKC0LYVxA2iHvEZIFDnsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsOOPoLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA38C116B1;
	Tue,  2 Jul 2024 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719949111;
	bh=iUNdoj/wPDxjLTPgtKmz7+YGlVRjPAtE2/pv9NEzpnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsOOPoLNpnnZw9+2pw3A/w/5kdZd9Fu9g6WYEFuV1/FVvogtwyeBtD7Oeq9kZDel+
	 e/HdU8RQh+2wQ71HxRT/HkOkCefqK3i6tZQbJNK5Qn/xV75FYaM2qbiG6ub38rM1E2
	 01afVdJMcmYkOJ4MNzCa7hx4Rf7LZwpF+stH2jTFGroYMc8zGtg19iQQjexLDDhsJx
	 0f25b3wNBShET7ZKhcchRw1n68qtkWDqB2FV6CCEVj9EtWsMYNBpkV9+r7g0o13qxB
	 ZmxY8B60qfdrI5K4f4JgdLoO906yBb3jh2TNDyiWMsMS53TCp789zFkm3Jnt0R8mWH
	 MX5Il/R6IXZCQ==
Date: Tue, 2 Jul 2024 12:38:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 03/10] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <20240702193830.GM612460@frogsfrogsfrogs>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-4-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:13AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> page_cache_ra_unbounded() was allocating single pages (0 order folios)
> if there was no folio found in an index. Allocate mapping_min_order folios
> as we need to guarantee the minimum order if it is set.
> While we are at it, rework the loop in page_cache_ra_unbounded() to
> advance with the number of pages in a folio instead of just one page at
> a time.

Ok, sounds pretty straightforward so far.

> page_cache_ra_order() tries to allocate folio to the page cache with a
> higher order if the index aligns with that order. Modify it so that the
> order does not go below the mapping_min_order requirement of the page
> cache. This function will do the right thing even if the new_order passed
> is less than the mapping_min_order.

Hmm.  So if I'm understanding this correctly: Currently,
page_cache_ra_order tries to allocate higher order folios if the
readahead index happens to be aligned to one of those higher orders.
With the minimum mapping order requirement, it now expands the readahead
range upwards and downwards to maintain the mapping_min_order
requirement.  Right?

> When adding new folios to the page cache we must also ensure the index
> used is aligned to the mapping_min_order as the page cache requires the
> index to be aligned to the order of the folio.
> 
> readahead_expand() is called from readahead aops to extend the range of
> the readahead so this function can assume ractl->_index to be aligned with
> min_order.

...and I guess this function also has to be modified to expand the ra
range even further if necessary to align with mapping_min_order.  Right?

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

I'm not as familiar with this function since xfs/iomap don't use it.

Does anyone actually pass nonzero lookahead size?

What does ext4_read_merkle_tree_page do??

	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);

		if (!IS_ERR(folio))
			folio_put(folio);
		else if (num_ra_pages > 1)
			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);

So we try to get the folio.  If the folio is an errptr then we try
unbounded readahead, which I guess works for ENOENT or EAGAIN; maybe
less well if __filemap_get_folio returns ENOMEM.

If @folio is a real but !uptodate folio then we put the folio and read
it again, but without doing readahead.  <shrug>

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

So at this point we've rounded index down and the readahead region up to
fit the min_nrpages requirement.  I'm not sure what the lookahead region
does, since nobody passes nonzero.  Judging from the other functions, I
guess that's the region that we're allowed to do asynchronously?

> +	mark = ra_folio_index - index;

Ah, ok, yes.  We mark the first folio in the "async" region so that we
(re)start readahead when someone accesses that folio.

> +	if (index != readahead_index(ractl)) {
> +		nr_to_read += readahead_index(ractl) - index;
> +		ractl->_index = index;
> +	}

So then if we rounded inded down, now we have to add that to the ra
region.

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

I guess this also rounds index down to mapping_min_order...

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

...and then we try to find an order that works and doesn't go below
min_order.  We already rounded index down to mapping_min_order, so that
will always succeed.  Right?

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

...and here we are expanding the ra window yet again, only now taking
min order into account.  Right?  Looks ok to me, though again, iomap/xfs
don't use this function so I'm not that familiar with it.

If the answer to /all/ the questions is 'yes' then

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

>  		}
>  	}
>  }
> -- 
> 2.44.1
> 
> 

