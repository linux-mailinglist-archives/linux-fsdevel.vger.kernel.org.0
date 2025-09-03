Return-Path: <linux-fsdevel+bounces-60206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C5B42AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1665D5834A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57344F5E0;
	Wed,  3 Sep 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxyiA04/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7D2D9EF4;
	Wed,  3 Sep 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931432; cv=none; b=qR4kb/aN+PLvTcQIZHlrVx1CgCU/Q9R63l9hzbSfuayi49pQ3E4kBoQhHT3yxjTlVhjnzrZUMyqaeA7TagcbscWosihbQattpSQa/CyysjANRjUF3twExhIaS6ZUHlisEO8AFMKBUJ83CxdhJDif0kqlZi9o2XzzldVuCLLoZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931432; c=relaxed/simple;
	bh=o7l9h73r/T0fAc83RFxZEqj/D9KOWBqOEEa1Lr9h1g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxavFnGRWCGsPFtDuIKL2J4yIQC4n9BGlpfUUWyRmjycTQkbQE3S5QGvqiKzWOF0giJZ3Y9ZqobI9gItmpXTB9JnYRFci4yN9m/bYbpRIL1H55c7F0IlPRLLdhrELRQ9eeF8nuaboHRloMeN0QyzAiu+LRYz5YTf0WTXD37Pl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxyiA04/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5029C4CEE7;
	Wed,  3 Sep 2025 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931432;
	bh=o7l9h73r/T0fAc83RFxZEqj/D9KOWBqOEEa1Lr9h1g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxyiA04/IbnzO5nu335qSMGoKoHDYsMXK7u+I2Gl6czAbIKmFFyKpGZxTFe2hPku9
	 soR1V4UvGIo/sXKVkSI+mPQjWS8M6q/lNB8xP4vIDan6zQkHKUoW3SI+l/k0m/7lfE
	 mzNJ1fjdru3sGL6kq4XCWqEOVzIRqQ76s45hBHuMAhfDk2zRgkLOxVYUiMsq2QHe2K
	 /gbWorA2uplwN9VeMrkDmxH2S604q+8PXTs/+BMIG+YzPm9IY3yE6NH/7Jz3DEVjfQ
	 F7+8pm/AXu80lKTW6yAd7XJHmypjBUwY6YYTDPJZC2EW1P8d+/V0DORE0qeqa7umBW
	 rkLzo0Bx6f3sA==
Date: Wed, 3 Sep 2025 13:30:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 04/16] iomap: use iomap_iter->private for stashing
 read/readahead bio
Message-ID: <20250903203031.GM1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-5-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:15PM -0700, Joanne Koong wrote:
> Use the iomap_iter->private field for stashing any read/readahead bios
> instead of defining the bio as part of the iomap_readpage_ctx struct.
> This makes the read/readahead interface more generic. Some filesystems
> that will be using iomap for read/readahead may not have CONFIG_BLOCK
> set.

Sorry, but I don't like abusing iomap_iter::private because (a) it's a
void pointer which means shenanigans; and (b) private exists to store
some private data for an iomap caller, not iomap itself.

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 49 +++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f2bfb3e17bb0..9db233a4a82c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -353,11 +353,10 @@ static void iomap_read_end_io(struct bio *bio)
>  struct iomap_readpage_ctx {
>  	struct folio		*cur_folio;
>  	bool			folio_unlocked;
> -	struct bio		*bio;

Does this work if you do:

#ifdef CONFIG_BLOCK
	struct bio		*bio;
#endif

Hm?  Possibly with a forward declaration of struct bio to shut the
compiler up?

--D

>  	struct readahead_control *rac;
>  };
>  
> -static void iomap_read_folio_range_async(const struct iomap_iter *iter,
> +static void iomap_read_folio_range_async(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
>  {
>  	struct folio *folio = ctx->cur_folio;
> @@ -365,6 +364,7 @@ static void iomap_read_folio_range_async(const struct iomap_iter *iter,
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	loff_t length = iomap_length(iter);
> +	struct bio *bio = iter->private;
>  	sector_t sector;
>  
>  	ctx->folio_unlocked = true;
> @@ -375,34 +375,32 @@ static void iomap_read_folio_range_async(const struct iomap_iter *iter,
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
>  
> -		if (ctx->bio)
> -			submit_bio(ctx->bio);
> +		if (bio)
> +			submit_bio(bio);
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> +		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> +				REQ_OP_READ, gfp);
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
> +		iter->private = bio;
>  		if (ctx->rac)
> -			ctx->bio->bi_opf |= REQ_RAHEAD;
> -		ctx->bio->bi_iter.bi_sector = sector;
> -		ctx->bio->bi_end_io = iomap_read_end_io;
> -		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
> +			bio->bi_opf |= REQ_RAHEAD;
> +		bio->bi_iter.bi_sector = sector;
> +		bio->bi_end_io = iomap_read_end_io;
> +		bio_add_folio_nofail(bio, folio, plen, poff);
>  	}
>  }
>  
> @@ -447,15 +445,18 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	return iomap_iter_advance(iter, &length);
>  }
>  
> -static void iomap_readfolio_submit(const struct iomap_readpage_ctx *ctx)
> +static void iomap_readfolio_submit(const struct iomap_iter *iter)
>  {
> -	if (ctx->bio)
> -		submit_bio(ctx->bio);
> +	struct bio *bio = iter->private;
> +
> +	if (bio)
> +		submit_bio(bio);
>  }
>  
> -static void iomap_readfolio_complete(const struct iomap_readpage_ctx *ctx)
> +static void iomap_readfolio_complete(const struct iomap_iter *iter,
> +		const struct iomap_readpage_ctx *ctx)
>  {
> -	iomap_readfolio_submit(ctx);
> +	iomap_readfolio_submit(iter);
>  
>  	if (ctx->cur_folio && !ctx->folio_unlocked)
>  		folio_unlock(ctx->cur_folio);
> @@ -492,7 +493,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.status = iomap_read_folio_iter(&iter, &ctx);
>  
> -	iomap_readfolio_complete(&ctx);
> +	iomap_readfolio_complete(&iter, &ctx);
>  
>  	/*
>  	 * Just like mpage_readahead and block_read_full_folio, we always
> @@ -558,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	while (iomap_iter(&iter, ops) > 0)
>  		iter.status = iomap_readahead_iter(&iter, &ctx);
>  
> -	iomap_readfolio_complete(&ctx);
> +	iomap_readfolio_complete(&iter, &ctx);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 
> 

