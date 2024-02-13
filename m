Return-Path: <linux-fsdevel+bounces-11391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE685364F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61BB2B24362
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7A5FEF7;
	Tue, 13 Feb 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVd+B4Na"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE41D6A5;
	Tue, 13 Feb 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842311; cv=none; b=tGgkmglv3wfMGwIhmmSEMFoow73KsrEkC3FbfEgJuTZm2JggeEkLcQeHxjw+l3QC1oUjWl/QoC3bX9irh3dcRyEkfR+DBzERuUME+3eJMm98KzoDRUncOC4M0tDaGd3YbIYHBW/rjqGpXcwhXoqIogcKnEulv0inByjfR18W+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842311; c=relaxed/simple;
	bh=tj+7TbENZG51WqSKyLxJxlrP3jkogejbHEm7mQelHao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S23uhwVPevB0tLqQ5sxIoihGsjbx0J4cm9iQsGsKC6vIwhhcAjORbnv00a+hYoXwn5pmJvYD50vz/8TsiJcHdZFEyiISamJn/2aN02sJVMMMnkH2U6MUhl/WgRikJj+hD/zgueokoyf6iP5DbSywXtlV0D9PJxQudfmHDFW03sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVd+B4Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17282C433C7;
	Tue, 13 Feb 2024 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842310;
	bh=tj+7TbENZG51WqSKyLxJxlrP3jkogejbHEm7mQelHao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVd+B4NaowQbDyPchjA4D5BZ2fZXSB/eV8rxFnFB3SswALTWYWgzH5KEmwVCvK0D/
	 eA0cvi+/fgWFrqPJ5Zdy8MO4sQRU1TMSJcM3AJxeudTlYhJkN0CRW9WBLmQYWpg6K9
	 i9RpproerpQzgm296HmhVFNSY9AO3eSY6a4G6bg5o/BjhyaGTgnEmtToT9UQf+qt2a
	 muBEzsGZjUb7NDtQ4ZuGwhBI6oNusHtYxlzP+ojZ7OKyWuc8ie6+fuNjNq4Pu7yzX1
	 +oFvewXLVKtunQ/90YrkIVyZYJ6OPO2S9l4/EQTkCuXh4AVIf2eyIwZY2ZbsE7IOk8
	 MMi8XP+hnZJFQ==
Date: Tue, 13 Feb 2024 08:38:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 03/14] filemap: use mapping_min_order while allocating
 folios
Message-ID: <20240213163829.GT6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-4-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:02AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> filemap_create_folio() and do_read_cache_folio() were always allocating
> folio of order 0. __filemap_get_folio was trying to allocate higher
> order folios when fgp_flags had higher order hint set but it will default
> to order 0 folio if higher order memory allocation fails.
> 
> As we bring the notion of mapping_min_order, make sure these functions
> allocate at least folio of mapping_min_order as we need to guarantee it
> in the page cache.
> 
> Add some additional VM_BUG_ON() in page_cache_delete[batch] and
> __filemap_add_folio to catch errors where we delete or add folios that
> has order less than min_order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good to me,
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/filemap.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 323a8e169581..7a6e15c47150 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -127,6 +127,7 @@
>  static void page_cache_delete(struct address_space *mapping,
>  				   struct folio *folio, void *shadow)
>  {
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	XA_STATE(xas, &mapping->i_pages, folio->index);
>  	long nr = 1;
>  
> @@ -135,6 +136,7 @@ static void page_cache_delete(struct address_space *mapping,
>  	xas_set_order(&xas, folio->index, folio_order(folio));
>  	nr = folio_nr_pages(folio);
>  
> +	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
>  	xas_store(&xas, shadow);
> @@ -277,6 +279,7 @@ void filemap_remove_folio(struct folio *folio)
>  static void page_cache_delete_batch(struct address_space *mapping,
>  			     struct folio_batch *fbatch)
>  {
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	XA_STATE(xas, &mapping->i_pages, fbatch->folios[0]->index);
>  	long total_pages = 0;
>  	int i = 0;
> @@ -305,6 +308,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  
>  		WARN_ON_ONCE(!folio_test_locked(folio));
>  
> +		VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
>  		folio->mapping = NULL;
>  		/* Leave folio->index set: truncation lookup relies on it */
>  
> @@ -846,6 +850,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  	int huge = folio_test_hugetlb(folio);
>  	bool charged = false;
>  	long nr = 1;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
> @@ -896,6 +901,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  			}
>  		}
>  
> +		VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
>  		xas_store(&xas, folio);
>  		if (xas_error(&xas))
>  			goto unlock;
> @@ -1847,6 +1853,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp)
>  {
>  	struct folio *folio;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +
> +	index = round_down(index, min_nrpages);
>  
>  repeat:
>  	folio = filemap_get_entry(mapping, index);
> @@ -1886,7 +1896,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> -		unsigned order = FGF_GET_ORDER(fgp_flags);
> +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>  		int err;
>  
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
> @@ -1914,8 +1924,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			err = -ENOMEM;
>  			if (order == 1)
>  				order = 0;
> +			if (order < min_order)
> +				order = min_order;
>  			if (order > 0)
>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +
> +			VM_BUG_ON(index & ((1UL << order) - 1));
> +
>  			folio = filemap_alloc_folio(alloc_gfp, order);
>  			if (!folio)
>  				continue;
> @@ -1929,7 +1944,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  				break;
>  			folio_put(folio);
>  			folio = NULL;
> -		} while (order-- > 0);
> +		} while (order-- > min_order);
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> @@ -2424,7 +2439,8 @@ static int filemap_create_folio(struct file *file,
>  	struct folio *folio;
>  	int error;
>  
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    mapping_min_folio_order(mapping));
>  	if (!folio)
>  		return -ENOMEM;
>  
> @@ -3682,7 +3698,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  repeat:
>  	folio = filemap_get_folio(mapping, index);
>  	if (IS_ERR(folio)) {
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +					    mapping_min_folio_order(mapping));
>  		if (!folio)
>  			return ERR_PTR(-ENOMEM);
>  		err = filemap_add_folio(mapping, folio, index, gfp);
> -- 
> 2.43.0
> 
> 

