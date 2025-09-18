Return-Path: <linux-fsdevel+bounces-62175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B3B8723D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7698A5830FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A92FA0F3;
	Thu, 18 Sep 2025 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvkBlxyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEA2853F7;
	Thu, 18 Sep 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230953; cv=none; b=qAFZa/descTd21VH+PiBYUONkUVC1MJQYfbm/YuQzYnOU1h7EAE6qMDRwhCLq8ewJK6nOBIpmurqt6+ll7NPTo3O3x0qmY/+XofMRKsYj6sdEFG4c8lYnAEU7UavVGhsd1xL2/KzN/NFZl9Q7MWQMry1G7k7ij7IERRVfUa9qyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230953; c=relaxed/simple;
	bh=7rSIyrqIY6PBVT2Jg4E7x2E9XeGwiwSOPhvIgucWkus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZENSK8N8DSM/kXEhCEnSXuJLFnsqc2s2hlpkS3A215jJALS+yjZIAaKjXPktcS7Liqx8sSX/7gQ6fYgC+lsnsv6bIfFzcECeSTMNB8A6EdmTriD6/egLywi6M4JnNmuI2MP6buhHeq2Hmrtk5vmin66Mld8HmeK71kzO7zveCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvkBlxyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601EAC4CEE7;
	Thu, 18 Sep 2025 21:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758230951;
	bh=7rSIyrqIY6PBVT2Jg4E7x2E9XeGwiwSOPhvIgucWkus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvkBlxyKRHF/CAKmvEH73k+DP0wVHp5xgJhLCehu0BE0it5Dfd9/zSWK2dW6MCr96
	 WRi71Am9ASFnijaalbaJeWMBNTubPxkUNn6zJjrVwU1xBYuvCiy3qsuEURS8IFJIQK
	 qPtmco8blb9cN00f+AF+bPCODoF3djixQGww5MDTLKwND+n2mgWH8lIlTtRwrpmo0u
	 rerNhCMmYZm1/D7IkSM1RiBuTLfd8JDPW64wBBUJhpu8CT305stpzwTndwHpxN9E55
	 qZ2IppFB/KAQc8cL41kz/VcGWtV1Z4XyLNMqHxOBFczULgROuI9/yDWE6vaoa5Vn5I
	 x1VKqrlK3mKfQ==
Date: Thu, 18 Sep 2025 14:29:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 03/15] iomap: store read/readahead bio generically
Message-ID: <20250918212910.GU1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-4-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:13PM -0700, Joanne Koong wrote:
> Store the iomap_readpage_ctx bio generically as a "void *read_ctx".
> This makes the read/readahead interface more generic, which allows it to
> be used by filesystems that may not be block-based and may not have
> CONFIG_BLOCK set.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Wheee type changes :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ee96558b6d99..2a1709e0757b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -353,13 +353,13 @@ static void iomap_read_end_io(struct bio *bio)
>  struct iomap_readpage_ctx {
>  	struct folio		*cur_folio;
>  	bool			cur_folio_in_bio;
> -	struct bio		*bio;
> +	void			*read_ctx;
>  	struct readahead_control *rac;
>  };
>  
>  static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
>  {
> -	struct bio *bio = ctx->bio;
> +	struct bio *bio = ctx->read_ctx;
>  
>  	if (bio)
>  		submit_bio(bio);
> @@ -374,6 +374,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  	size_t poff = offset_in_folio(folio, pos);
>  	loff_t length = iomap_length(iter);
>  	sector_t sector;
> +	struct bio *bio = ctx->read_ctx;
>  
>  	ctx->cur_folio_in_bio = true;
>  	if (ifs) {
> @@ -383,9 +384,8 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  	}
>  
>  	sector = iomap_sector(iomap, pos);
> -	if (!ctx->bio ||
> -	    bio_end_sector(ctx->bio) != sector ||
> -	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
> +	if (!bio || bio_end_sector(bio) != sector ||
> +	    !bio_add_folio(bio, folio, plen, poff)) {
>  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
>  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> @@ -394,22 +394,21 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> +		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> +				     gfp);
>  		/*
>  		 * If the bio_alloc fails, try it again for a single page to
>  		 * avoid having to deal with partial page reads.  This emulates
>  		 * what do_mpage_read_folio does.
>  		 */
> -		if (!ctx->bio) {
> -			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
> -					     orig_gfp);
> -		}
> +		if (!bio)
> +			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
>  		if (ctx->rac)
> -			ctx->bio->bi_opf |= REQ_RAHEAD;
> -		ctx->bio->bi_iter.bi_sector = sector;
> -		ctx->bio->bi_end_io = iomap_read_end_io;
> -		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
> +			bio->bi_opf |= REQ_RAHEAD;
> +		bio->bi_iter.bi_sector = sector;
> +		bio->bi_end_io = iomap_read_end_io;
> +		bio_add_folio_nofail(bio, folio, plen, poff);
> +		ctx->read_ctx = bio;
>  	}
>  }
>  
> -- 
> 2.47.3
> 
> 

