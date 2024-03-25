Return-Path: <linux-fsdevel+bounces-15244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAE88AF26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3181F63363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E45C96;
	Mon, 25 Mar 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wo9sobzT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E54A21;
	Mon, 25 Mar 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393231; cv=none; b=CO8IlveLXxVbU0MOpIthA2IS8/u/M+WOyeUN9nsgl1kr9PPx2Kmt7V8xvxvUOsp59OzQTBjFc/drNW2NvPEZxC/flY7xdqj7slu/VH0pitCEODEEb7voBYxGVCBQGE/8nWNGbfDvYpoD7XdKZwY8zGE6FJ8bf8IU/EjA/Yn4Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393231; c=relaxed/simple;
	bh=f6KVRMBffRNR3GxpvS3ie2AoEl9D+n2F+AduBnRxZNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8U38QI8NrgYBZLBiKxLucZoE7jHgkT7nhd5uwX75PTiQd6i0+NWLUsQgIy24OgOjsgSbiF6BjRy/lYTF1ZHCEgZSDvSkgVwkqez6xC6JoCMQsxQjZjdswlZc4a6KeSHwvdKmQ6ADhppbZSUY+6jaXmPegasZFvwqx2sI59L36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wo9sobzT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vJKeYjHEVe0gfRNnzKMs8M7l+ce1BSEpQNULOYVmG6E=; b=Wo9sobzTx9yoIPBHdce3Jf8Q4w
	2ruJ5KSp24f10buTZ2gTyna4Qps8r45y3SNriLQkPwN/xC8aKCzf0J0DHzH8RXz4lTQBVbt2/NjK/
	7F78mDZYmv1HUsOZrSSu+JaifG7wBI7oEJ+xz/lUhbaQEPLemWnRxUyYoUS5gAxGCdjUv9cMGKltV
	juuvNVMbM982bct7QUPIAw6nUDogsAidz2B57REtlrMzJXKTgUzbYR2sbS1YB723Yp6UCmUZYFDFu
	VEtPaNYIkPLvvdkfciegfBcdmumUffVExTTu8xT8XV284FkDg/e5NLKj5wfl4lOIueBUmwq+mLEXy
	48nf7hlA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ropYU-0000000H7OE-3KgK;
	Mon, 25 Mar 2024 19:00:22 +0000
Date: Mon, 25 Mar 2024 19:00:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de,
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 05/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <ZgHJxiYHvN9DfD15@casper.infradead.org>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-6-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-6-kernel@pankajraghav.com>

On Wed, Mar 13, 2024 at 06:02:47PM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> page_cache_ra_unbounded() was allocating single pages (0 order folios)
> if there was no folio found in an index. Allocate mapping_min_order folios
> as we need to guarantee the minimum order if it is set.
> When read_pages() is triggered and if a page is already present, check
> for truncation and move the ractl->_index by mapping_min_nrpages if that
> folio was truncated. This is done to ensure we keep the alignment
> requirement while adding a folio to the page cache.
> 
> page_cache_ra_order() tries to allocate folio to the page cache with a
> higher order if the index aligns with that order. Modify it so that the
> order does not go below the min_order requirement of the page cache.

This paragraph doesn't make sense.  We have an assertion that there's no
folio in the page cache with a lower order than the minimum, so this
seems to be describing a situation that can't happen.  Does it need to
be rephrased (because you're actually describing something else) or is
it just stale?

> @@ -239,23 +258,35 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */
>  			read_pages(ractl);
> -			ractl->_index += folio_nr_pages(folio);
> +
> +			/*
> +			 * Move the ractl->_index by at least min_pages
> +			 * if the folio got truncated to respect the
> +			 * alignment constraint in the page cache.
> +			 *
> +			 */
> +			if (mapping != folio->mapping)
> +				nr_pages = min_nrpages;
> +
> +			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
> +			ractl->_index += nr_pages;
>  			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask,
> +					    mapping_min_folio_order(mapping));
>  		if (!folio)
>  			break;
>  		if (filemap_add_folio(mapping, folio, index + i,
>  					gfp_mask) < 0) {
>  			folio_put(folio);
>  			read_pages(ractl);
> -			ractl->_index++;
> +			ractl->_index += min_nrpages;

Hah, you changed this here.  Please move into previous patch.

>  			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
> -		if (i == nr_to_read - lookahead_size)
> +		if (i == mark)
>  			folio_set_readahead(folio);
>  		ractl->_workingset |= folio_test_workingset(folio);
>  		ractl->_nr_pages += folio_nr_pages(folio);
> @@ -489,12 +520,18 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  {
>  	struct address_space *mapping = ractl->mapping;
>  	pgoff_t index = readahead_index(ractl);
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
>  	pgoff_t mark = index + ra->size - ra->async_size;
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
> @@ -505,9 +542,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  			new_order = MAX_PAGECACHE_ORDER;
>  		while ((1 << new_order) > ra->size)
>  			new_order--;
> +		if (new_order < min_order)
> +			new_order = min_order;

I think these are the two lines you're describing in the paragraph that
doesn't make sense to me?  And if so, I think they're useless?

> @@ -515,7 +562,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		if (index & ((1UL << order) - 1))
>  			order = __ffs(index);
>  		/* Don't allocate pages past EOF */
> -		while (index + (1UL << order) - 1 > limit)
> +		while (order > min_order && index + (1UL << order) - 1 > limit)
>  			order--;

This raises an interesting question that I don't know if we have a test
for.  POSIX says that if we mmap, let's say, the first 16kB of a 10kB
file, then we can store into offset 0-12287, but stores to offsets
12288-16383 get a signal (I forget if it's SEGV or BUS).  Thus far,
we've declined to even create folios in the page cache that would let us
create PTEs for offset 12288-16383, so I haven't paid too much attention
to this.  Now we're going to have folios that extend into that range, so
we need to be sure that when we mmap(), we only create PTEs that go as
far as 12287.

Can you check that we have such an fstest, and that we still pass it
with your patches applied and a suitably large block size?


