Return-Path: <linux-fsdevel+bounces-62173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE2B87216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A295E1CC308F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F612FAC00;
	Thu, 18 Sep 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZlLGWxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3F2F9DBF;
	Thu, 18 Sep 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230836; cv=none; b=pkn+3jFBOgLUPXri8WUpMyzDm6Ps5QxTw9Anpyh3R+NJBOimVx2mNe06cXYY5Jul99pAP1KEeUe3xmlKUFmNz5Fc9rZ+sVd9zxC2KqzmPNIngmAm+nY9pqo4YyzK+NEasZ7D15klk7NsOqdyzXZzDg91iQ6PTplHqW3ZB8jadsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230836; c=relaxed/simple;
	bh=iJiFkITtRJ6PD7GiWI/XmX+oLaayZm9P5ksBLsxMX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyr2C6uzt4TXhYePqgmFf7XGEdmNxZYYILUSpoEQ6zH6XGOTipm22g4fQ9H3ySRPpCJFwoyQEcntgAGklyAlXAh9pOXXwxg7PDQEGfTaFEk2pKLjg5VRszDDSN7M8FTUQv2Q02Grmsc6ReB1dG/UWorcOnC6LGZPp5Caw/moHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZlLGWxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4627C4CEE7;
	Thu, 18 Sep 2025 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758230835;
	bh=iJiFkITtRJ6PD7GiWI/XmX+oLaayZm9P5ksBLsxMX1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZlLGWxjV+uk4nKg5CwH1/u/U61BZft1r0fTnEp9VfrP8SdIzCCn2gRwf3TFjcPUU
	 1KvAIOO4zvNr9odCw/kGbXASIYuSDEkaZ/BNI6CkIM7GWBVNUkX3IbjxVwJCrvScy4
	 6Zem2/MHQbDUcrUqeqtm0iKVO5VKP3HCrLg51YdpT1O6vorb5OIqzM+V71UOANRlX0
	 tgy2XzSpHvjNytXi2OoVzzbn4Ktt4vsBQx/61Y7ORJB2GgTlxGvlgMFlI0SmVLVxgk
	 8RxBUZvHBU1nS51Y7RkJ2jnhAUshSUbRuAl9bqo2DDaidKQImUwK0qsuijDu2YjKd0
	 qIKCjmuFWVeVA==
Date: Thu, 18 Sep 2025 14:27:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/15] iomap: move bio read logic into helper function
Message-ID: <20250918212715.GS1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-2-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:11PM -0700, Joanne Koong wrote:
> Move the iomap_readpage_iter() bio read logic into a separate helper
> function, iomap_bio_read_folio_range(). This is needed to make iomap
> read/readahead more generically usable, especially for filesystems that
> do not require CONFIG_BLOCK.
> 
> Additionally rename buffered write's iomap_read_folio_range() function
> to iomap_bio_read_folio_range_sync() to better describe its synchronous
> behavior.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..05399aaa1361 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -357,36 +357,15 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static int iomap_readpage_iter(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx)
> +static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)

/me wonders if you could shorten these function names to
iomap_bio_read_folio{,_sync} now, but ... eh.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  {
> +	struct folio *folio = ctx->cur_folio;
>  	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos;
> +	struct iomap_folio_state *ifs = folio->private;
> +	size_t poff = offset_in_folio(folio, pos);
>  	loff_t length = iomap_length(iter);
> -	struct folio *folio = ctx->cur_folio;
> -	struct iomap_folio_state *ifs;
> -	size_t poff, plen;
>  	sector_t sector;
> -	int ret;
> -
> -	if (iomap->type == IOMAP_INLINE) {
> -		ret = iomap_read_inline_data(iter, folio);
> -		if (ret)
> -			return ret;
> -		return iomap_iter_advance(iter, &length);
> -	}
> -
> -	/* zero post-eof blocks as the page may be mapped */
> -	ifs = ifs_alloc(iter->inode, folio, iter->flags);
> -	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
> -	if (plen == 0)
> -		goto done;
> -
> -	if (iomap_block_needs_zeroing(iter, pos)) {
> -		folio_zero_range(folio, poff, plen);
> -		iomap_set_range_uptodate(folio, poff, plen);
> -		goto done;
> -	}
>  
>  	ctx->cur_folio_in_bio = true;
>  	if (ifs) {
> @@ -425,6 +404,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  		ctx->bio->bi_end_io = iomap_read_end_io;
>  		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
>  	}
> +}
> +
> +static int iomap_readpage_iter(struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx)
> +{
> +	const struct iomap *iomap = &iter->iomap;
> +	loff_t pos = iter->pos;
> +	loff_t length = iomap_length(iter);
> +	struct folio *folio = ctx->cur_folio;
> +	size_t poff, plen;
> +	int ret;
> +
> +	if (iomap->type == IOMAP_INLINE) {
> +		ret = iomap_read_inline_data(iter, folio);
> +		if (ret)
> +			return ret;
> +		return iomap_iter_advance(iter, &length);
> +	}
> +
> +	/* zero post-eof blocks as the page may be mapped */
> +	ifs_alloc(iter->inode, folio, iter->flags);
> +	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
> +	if (plen == 0)
> +		goto done;
> +
> +	if (iomap_block_needs_zeroing(iter, pos)) {
> +		folio_zero_range(folio, poff, plen);
> +		iomap_set_range_uptodate(folio, poff, plen);
> +	} else {
> +		iomap_bio_read_folio_range(iter, ctx, pos, plen);
> +	}
>  
>  done:
>  	/*
> @@ -549,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -static int iomap_read_folio_range(const struct iomap_iter *iter,
> +static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
>  		struct folio *folio, loff_t pos, size_t len)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -562,7 +572,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
>  	return submit_bio_wait(&bio);
>  }
>  #else
> -static int iomap_read_folio_range(const struct iomap_iter *iter,
> +static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
>  		struct folio *folio, loff_t pos, size_t len)
>  {
>  	WARN_ON_ONCE(1);
> @@ -739,7 +749,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  				status = write_ops->read_folio_range(iter,
>  						folio, block_start, plen);
>  			else
> -				status = iomap_read_folio_range(iter,
> +				status = iomap_bio_read_folio_range_sync(iter,
>  						folio, block_start, plen);
>  			if (status)
>  				return status;
> -- 
> 2.47.3
> 
> 

