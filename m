Return-Path: <linux-fsdevel+bounces-17908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8A8B3AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D61F24E27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4D1159581;
	Fri, 26 Apr 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW5Mm8BC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09F148841;
	Fri, 26 Apr 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144364; cv=none; b=nT1TTdFwte24mvDlg3aeV5hru7VCYY0VWqIIUQIlSl7VBiDhKmqaoUkkDe+SCuINodejjX6+Ou7TPyIh+ADMVlqIKIaEgwaQb2qUChnnok83k72BK1+0N6IibC905h3JJy3vNVKVBQwMXKXs0akxhewfjl8rBJGE3u0HtAGLax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144364; c=relaxed/simple;
	bh=quc7LSiSVw2TT07uTSXycfAYUCFeYT8rW3NArklrOJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sse7hsad+wxHVXuvjjzDkFKpBTIpj5yXkKW5QQ9RqFfM5PjoH18OEPbA+RmWedkHFnU1z/enMVdp8T2HCQ7avprNEIy76NHlnqiNNdiK+pJZTPOCNO3M9huj18vSB3SxVzBQPFVw5o+hHBXyVerCzFDVatsLt1PyZt2/wyd8cLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW5Mm8BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E65AC113CD;
	Fri, 26 Apr 2024 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144363;
	bh=quc7LSiSVw2TT07uTSXycfAYUCFeYT8rW3NArklrOJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UW5Mm8BCg0Roek5VE0mS5z+hU4Rliru5i4lxsEb6rJbZNPG0GNrdQRtkDQxnb70A2
	 wmpqBhMuWvX5vGpb/2QoMAZMZy21JdccdODDRNV9qwEWubFJPpfan9sSS4Qyj24qlH
	 88zpKEYRbBIkLYo1GadptPit6L8NfZzsA4kDQ+N6O5EJtsfweFTlyvwJZvMmuQSMEV
	 pmwDFrf+V1zCLYFN6Mhifq6VU5a6avVs1dtBi5wwRIRZ7u3u0EAMkIeB+2j4h9DIvw
	 sgRikwxLLz/3cs9yEEkwnKP6YLlXjH1MHlncJkACn31uQsj5kLJVkBkjUJ2b44RNEi
	 xdA+KkNkUUcYw==
Date: Fri, 26 Apr 2024 08:12:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240426151243.GD360919@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-4-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:38PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
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

If we cannot find a folio of at least min_order size, what error is sent
back?

If the answer is "the same error that you get if we cannot allocate a
base page today (aka ENOMEM)", then I think I understand this enough to
say

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/filemap.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 30de18c4fd28..f0c0cfbbd134 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -858,6 +858,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> +			folio);
>  	mapping_set_update(&xas, mapping);
>  
>  	if (!huge) {
> @@ -1895,8 +1897,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
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
> @@ -1936,7 +1940,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  				break;
>  			folio_put(folio);
>  			folio = NULL;
> -		} while (order-- > 0);
> +		} while (order-- > min_order);
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> @@ -2425,13 +2429,16 @@ static int filemap_update_page(struct kiocb *iocb,
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
> @@ -2449,6 +2456,8 @@ static int filemap_create_folio(struct file *file,
>  	 * well to keep locking rules simple.
>  	 */
>  	filemap_invalidate_lock_shared(mapping);
> +	/* index in PAGE units but aligned to min_order number of pages. */
> +	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
>  	error = filemap_add_folio(mapping, folio, index,
>  			mapping_gfp_constraint(mapping, GFP_KERNEL));
>  	if (error == -EEXIST)
> @@ -2509,8 +2518,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
> -		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
>  		if (err == AOP_TRUNCATED_PAGE)
>  			goto retry;
>  		return err;
> @@ -3708,9 +3716,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
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
> 2.34.1
> 
> 

