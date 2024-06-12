Return-Path: <linux-fsdevel+bounces-21540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8E905731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9863B272AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39706180A78;
	Wed, 12 Jun 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HktmaJO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914021802D7;
	Wed, 12 Jun 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206836; cv=none; b=WCKngCDTE2dLbYM51MuwbFmFqhFNmu4xsz8gX9m1WUJHaVii9oBLk9sErqbtmiiTdGw9qINk62+s7RXNM9DkN/oCZnONrHFfmoSjEfN03gz0pVf0XK/6H6pP70Cdp9UO5Dmzl+K44vzNIrA3ayh4cppNEr0sGkLY0KUVSiY5CTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206836; c=relaxed/simple;
	bh=ure0E9PZwCCE0IY9IoqbKopYZ1g301DYRj00CAi1dLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T01wG2wIBgFLbEThR2vTP5sd/gsNIErxsE6PkUstJPT/uKSLjEfqtvKFe3QU6qDU3rjUaqiPOP09m9MpGDVAXiYvJT5am+kTB/7GQlIvWy/7FCiMvqVDJiYnxEgSEua2hWuFeUgBBB48Ox/G+gXjamPZX78g+s202y8gW1DaBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HktmaJO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ECAC116B1;
	Wed, 12 Jun 2024 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206836;
	bh=ure0E9PZwCCE0IY9IoqbKopYZ1g301DYRj00CAi1dLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HktmaJO2RTpRTrqfSR8FlHZ+rsRypeu+fENZHR48jiez8Y2UbDMAcpNYpiD4vQx6S
	 pEnMbNtoaD0mpi9vtHcGOBYwnFSILO/WdcUWkJNbAb3eKh9NqZ4gF6YWetox81MYuG
	 Ue0Bi9wLpBjv8ORF4K+YUM+90DEHh9uJvbdM0hUOs/mQoRAF6H2t8d9caCfCHC2lCq
	 GwzYHi/OmufmuheIhYrF1nnZ558EAly0Db63nSBFO5Vs0GEQC4cancE4ySQ8TXHYNV
	 TxxaJzEZfbxzovsteb40Wbh6rLI5k1aJGoydnLgPWTgfPHvxgfQ52Bh7wIvk95IUj9
	 ekLXkiHonZ/vw==
Date: Wed, 12 Jun 2024 08:40:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240612154035.GB2764752@frogsfrogsfrogs>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-4-kernel@pankajraghav.com>

On Fri, Jun 07, 2024 at 02:58:54PM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> filemap_create_folio() and do_read_cache_folio() were always allocating
> folio of order 0. __filemap_get_folio was trying to allocate higher
> order folios when fgp_flags had higher order hint set but it will default
> to order 0 folio if higher order memory allocation fails.
> 
> Supporting mapping_min_order implies that we guarantee each folio in the
> page cache has at least an order of mapping_min_order. When adding new
> folios to the page cache we must also ensure the index used is aligned to
> the mapping_min_order as the page cache requires the index to be aligned
> to the order of the folio.
> 
> Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Seems pretty straightforward, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/pagemap.h | 20 ++++++++++++++++++++
>  mm/filemap.c            | 26 ++++++++++++++++++--------
>  2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 228275e7049f..899b8d751768 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -439,6 +439,26 @@ unsigned int mapping_min_folio_order(const struct address_space *mapping)
>  	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
>  }
>  
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
> +}
> +
>  /*
>   * Large folio support currently depends on THP.  These dependencies are
>   * being worked on but are not yet fixed.
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 46c7a6f59788..8bb0d2bc93c5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -859,6 +859,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> +			folio);
>  	mapping_set_update(&xas, mapping);
>  
>  	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
> @@ -1919,8 +1921,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> -		unsigned order = FGF_GET_ORDER(fgp_flags);
> +		unsigned int min_order = mapping_min_folio_order(mapping);
> +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>  		int err;
> +		index = mapping_align_start_index(mapping, index);
>  
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp |= __GFP_WRITE;
> @@ -1943,7 +1947,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			gfp_t alloc_gfp = gfp;
>  
>  			err = -ENOMEM;
> -			if (order > 0)
> +			if (order > min_order)
>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>  			folio = filemap_alloc_folio(alloc_gfp, order);
>  			if (!folio)
> @@ -1958,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  				break;
>  			folio_put(folio);
>  			folio = NULL;
> -		} while (order-- > 0);
> +		} while (order-- > min_order);
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> @@ -2447,13 +2451,16 @@ static int filemap_update_page(struct kiocb *iocb,
>  }
>  
>  static int filemap_create_folio(struct file *file,
> -		struct address_space *mapping, pgoff_t index,
> +		struct address_space *mapping, loff_t pos,
>  		struct folio_batch *fbatch)
>  {
>  	struct folio *folio;
>  	int error;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	pgoff_t index;
>  
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    min_order);
>  	if (!folio)
>  		return -ENOMEM;
>  
> @@ -2471,6 +2478,8 @@ static int filemap_create_folio(struct file *file,
>  	 * well to keep locking rules simple.
>  	 */
>  	filemap_invalidate_lock_shared(mapping);
> +	/* index in PAGE units but aligned to min_order number of pages. */
> +	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
>  	error = filemap_add_folio(mapping, folio, index,
>  			mapping_gfp_constraint(mapping, GFP_KERNEL));
>  	if (error == -EEXIST)
> @@ -2531,8 +2540,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
> -		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
>  		if (err == AOP_TRUNCATED_PAGE)
>  			goto retry;
>  		return err;
> @@ -3748,9 +3756,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  repeat:
>  	folio = filemap_get_folio(mapping, index);
>  	if (IS_ERR(folio)) {
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +					    mapping_min_folio_order(mapping));
>  		if (!folio)
>  			return ERR_PTR(-ENOMEM);
> +		index = mapping_align_start_index(mapping, index);
>  		err = filemap_add_folio(mapping, folio, index, gfp);
>  		if (unlikely(err)) {
>  			folio_put(folio);
> -- 
> 2.44.1
> 
> 

