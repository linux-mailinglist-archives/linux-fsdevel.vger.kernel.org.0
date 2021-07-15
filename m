Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E153CAEA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhGOVgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231643AbhGOVgA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F4CA613AF;
        Thu, 15 Jul 2021 21:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626384786;
        bh=quEBZUrmecmZNDGxq3cR0ji1Uk/EOSVxX8y1nl5101M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtrcNL6bbPestT2KMxvMTUv1UQ+MuuRq365qUgLuCn0TL8Op8q87HiF4GiSe/HT89
         +qNRMfeRBiDJdcZ47zt5Nx115LPozKu2IpBLPUjBjajNLdI39di7fiLu7Qmj8pGRpC
         oOyzWnE/NsN8ML482++fx7jeP/UPlFYLkCJ0njdlaq4389bA3T6d6VZWKiNp389ZTV
         57i2V8usOaeEZoy5QMSFZhF2sSKYBxFhnU7zQQdCYnWC42LJNrcv7tEyhi1u4N4w3Y
         R7RctRLCE+roMQckmw0mqvCnUoRlf96+aDbOTkfNBRqHEWDoLLI8mzuLDYeIPJu0U3
         15iKMJ6dYKLpQ==
Date:   Thu, 15 Jul 2021 14:33:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 100/138] iomap: Convert readahead and readpage to use
 a folio
Message-ID: <20210715213305.GK22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-101-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-101-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:26AM +0100, Matthew Wilcox (Oracle) wrote:
> Handle folios of arbitrary size instead of working in PAGE_SIZE units.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 61 +++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4732298f74e1..7c702d6c2f64 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -188,8 +188,8 @@ static void iomap_read_end_io(struct bio *bio)
>  }
>  
>  struct iomap_readpage_ctx {
> -	struct page		*cur_page;
> -	bool			cur_page_in_bio;
> +	struct folio		*cur_folio;
> +	bool			cur_folio_in_bio;
>  	struct bio		*bio;
>  	struct readahead_control *rac;
>  };
> @@ -227,8 +227,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
> -	struct page *page = ctx->cur_page;
> -	struct folio *folio = page_folio(page);
> +	struct folio *folio = ctx->cur_folio;
>  	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	bool same_page = false, is_contig = false;
>  	loff_t orig_pos = pos;
> @@ -237,7 +236,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  	if (iomap->type == IOMAP_INLINE) {
>  		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> +		iomap_read_inline_data(inode, &folio->page, iomap);
>  		return PAGE_SIZE;
>  	}
>  
> @@ -252,7 +251,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		goto done;
>  	}
>  
> -	ctx->cur_page_in_bio = true;
> +	ctx->cur_folio_in_bio = true;
>  	if (iop)
>  		atomic_add(plen, &iop->read_bytes_pending);
>  
> @@ -266,7 +265,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	}
>  
>  	if (!is_contig || bio_full(ctx->bio, plen)) {
> -		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
> +		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
>  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>  
> @@ -305,30 +304,31 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  int
>  iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  {
> -	struct iomap_readpage_ctx ctx = { .cur_page = page };
> -	struct inode *inode = page->mapping->host;
> -	unsigned poff;
> +	struct folio *folio = page_folio(page);
> +	struct iomap_readpage_ctx ctx = { .cur_folio = folio };
> +	struct inode *inode = folio->mapping->host;
> +	size_t poff;
>  	loff_t ret;
> +	size_t len = folio_size(folio);
>  
> -	trace_iomap_readpage(page->mapping->host, 1);
> +	trace_iomap_readpage(inode, 1);
>  
> -	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
> -		ret = iomap_apply(inode, page_offset(page) + poff,
> -				PAGE_SIZE - poff, 0, ops, &ctx,
> -				iomap_readpage_actor);
> +	for (poff = 0; poff < len; poff += ret) {
> +		ret = iomap_apply(inode, folio_pos(folio) + poff, len - poff,
> +				0, ops, &ctx, iomap_readpage_actor);
>  		if (ret <= 0) {
>  			WARN_ON_ONCE(ret == 0);
> -			SetPageError(page);
> +			folio_set_error(folio);
>  			break;
>  		}
>  	}
>  
>  	if (ctx.bio) {
>  		submit_bio(ctx.bio);
> -		WARN_ON_ONCE(!ctx.cur_page_in_bio);
> +		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
>  	} else {
> -		WARN_ON_ONCE(ctx.cur_page_in_bio);
> -		unlock_page(page);
> +		WARN_ON_ONCE(ctx.cur_folio_in_bio);
> +		folio_unlock(folio);
>  	}
>  
>  	/*
> @@ -348,15 +348,15 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
>  	loff_t done, ret;
>  
>  	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> -			if (!ctx->cur_page_in_bio)
> -				unlock_page(ctx->cur_page);
> -			put_page(ctx->cur_page);
> -			ctx->cur_page = NULL;
> +		if (ctx->cur_folio &&
> +		    offset_in_folio(ctx->cur_folio, pos + done) == 0) {
> +			if (!ctx->cur_folio_in_bio)
> +				folio_unlock(ctx->cur_folio);
> +			ctx->cur_folio = NULL;
>  		}
> -		if (!ctx->cur_page) {
> -			ctx->cur_page = readahead_page(ctx->rac);
> -			ctx->cur_page_in_bio = false;
> +		if (!ctx->cur_folio) {
> +			ctx->cur_folio = readahead_folio(ctx->rac);
> +			ctx->cur_folio_in_bio = false;
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
>  				ctx, iomap, srcmap);
> @@ -404,10 +404,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> -	if (ctx.cur_page) {
> -		if (!ctx.cur_page_in_bio)
> -			unlock_page(ctx.cur_page);
> -		put_page(ctx.cur_page);
> +	if (ctx.cur_folio) {
> +		if (!ctx.cur_folio_in_bio)
> +			folio_unlock(ctx.cur_folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
> -- 
> 2.30.2
> 
