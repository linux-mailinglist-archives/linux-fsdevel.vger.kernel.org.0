Return-Path: <linux-fsdevel+bounces-11399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2568685368D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773AFB275B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18896086E;
	Tue, 13 Feb 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUApaTHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC9605D7;
	Tue, 13 Feb 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842831; cv=none; b=JDjJqtNvK4Z66pDDtl/iu0leXX6TqLcL4/K7d/D096lJnIuAEAmmrNQwU0/be7u23z3gkWYaqXMS1mTxOiPzZWE44SZqcZZS8aK2FzoUUsPBPbwB/l84/32mjTJjUkrq6eRnO4On3LPhhWT6n3GYIPCTK/L1raCQGv8JjNLaZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842831; c=relaxed/simple;
	bh=NdN2Ja2ehPSCmCWIF4zS46W/wsgKmR+1NTmC15pVJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad7cSG0hDGCwlblie5ClLPcN0wHePdDTwORmJxiB0lwp9c+aeO7anAJcs6GUMPMXRzInE3bEANWod/5o8k7VJOcW8gGcrNYXX9P3k2rsLSYJ/4+5n853VcQQmwgweHBCdKEeUoRxX1L1xbpcKWz8KMKAJmWTEdiObQwsOG/ZJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUApaTHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77242C43390;
	Tue, 13 Feb 2024 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842830;
	bh=NdN2Ja2ehPSCmCWIF4zS46W/wsgKmR+1NTmC15pVJ8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUApaTHRZ0VkLxXsU9EbaadXGfH4cZRNqlvBKVrBHBONMQnNXHhqxJpRC7PXBAS/R
	 1M9er3q+mjyku1+kZeG/gf2P880C3CSsn3Yn9CQVOFsyzCL7sRaQjYjh/QHL6KHYIF
	 tBntToqk82c7PZIv6pRfB2WUkzqufyUjtO/0LvbE4rkSQ/hv0vlM7OHdAYkbcnAWTH
	 57FK0CURnw3ApKQpXcDCKBrGNZHtnnFsoWHXZhCY6JW4eFxkLGNcKxD5ji556ClaiK
	 c5sVK8TFANHXkysJkJ268QrC770HE+w7pe2EtWi3gJw/03PJLELkGHtxKtcv001d0X
	 97t1xaLOnIo1w==
Date: Tue, 13 Feb 2024 08:47:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 07/14] readahead: allocate folios with mapping_min_order
 in ra_(unbounded|order)
Message-ID: <20240213164710.GY6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-8-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-8-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:06AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Allocate folios with at least mapping_min_order in
> page_cache_ra_unbounded() and page_cache_ra_order() as we need to
> guarantee a minimum order in the page cache.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/readahead.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 13b62cbd3b79..a361fba18674 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -214,6 +214,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	unsigned long index = readahead_index(ractl);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
>  	unsigned long i = 0;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
>  
>  	/*
>  	 * Partway through the readahead operation, we will have added
> @@ -235,6 +236,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  		struct folio *folio = xa_load(&mapping->i_pages, index + i);
>  
>  		if (folio && !xa_is_value(folio)) {
> +			long nr_pages = folio_nr_pages(folio);
> +
>  			/*
>  			 * Page already present?  Kick off the current batch
>  			 * of contiguous pages before continuing with the
> @@ -244,19 +247,31 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
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
>  			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
> @@ -516,6 +531,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  {
>  	struct address_space *mapping = ractl->mapping;
>  	pgoff_t index = readahead_index(ractl);
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
>  	pgoff_t mark = index + ra->size - ra->async_size;
>  	int err = 0;
> @@ -542,11 +558,17 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		if (index & ((1UL << order) - 1))
>  			order = __ffs(index);
>  		/* Don't allocate pages past EOF */
> -		while (index + (1UL << order) - 1 > limit)
> +		while (order > min_order && index + (1UL << order) - 1 > limit)
>  			order--;
>  		/* THP machinery does not support order-1 */
>  		if (order == 1)
>  			order = 0;
> +
> +		if (order < min_order)
> +			order = min_order;
> +
> +		VM_BUG_ON(index & ((1UL << order) - 1));
> +
>  		err = ra_alloc_folio(ractl, index, mark, order, gfp);
>  		if (err)
>  			break;
> -- 
> 2.43.0
> 
> 

