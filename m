Return-Path: <linux-fsdevel+bounces-62533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A8B97DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 02:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DEF2E82CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68379EA;
	Wed, 24 Sep 2025 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARx5MTrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730E1FB1;
	Wed, 24 Sep 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672816; cv=none; b=GBT3qPRBtZsQ98UUaP07GKj/VOKF4BipzPuOpGeJyAW/PU7zqTsgKcqYyaweDUd+pLG1BLlNdUc+4IWTUsSWzVG23yAaS+nB1e0WQmwGLbiaRK+WeINZPs2ZHcaHq8Rod/CiQbbD7n07JYSaIud4MRqyYB/AQE4wSQqDDVvz9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672816; c=relaxed/simple;
	bh=XY0QCw5F75YlXeKBpjwCvQa2FkFZ1g/792l5DMfMKY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thIrW1ohEHeSLq+tmYGBklgdOdrljATfR4lS1XeMnsRUQEzSVf6hXL2g8emJoWprBO+D03330vzuORa1GBA2kytLjX2WuZ7qhk2njbjZQbmRGOawevdwCZGR+Hge0LsY/K0r9sAUqNeM/Dk0gY2sbSHwgnih0WGyKo74HQt3l3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARx5MTrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0ADC4CEF5;
	Wed, 24 Sep 2025 00:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672815;
	bh=XY0QCw5F75YlXeKBpjwCvQa2FkFZ1g/792l5DMfMKY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARx5MTrNCc4yiI+cLaco4c9yNoTNEwVRIBu1k+9EMun7L7nTQUU46Pq2agG25uOPR
	 QJO2RRk+lSafqwR5sEjG+Lv7Yvo3kJwk2gpLCuadyld3p3MAdtEku1qAZb1Rm+WB8c
	 xjksU0r2PkOenxjTmqhCFvIIaZ0y4EcT2gDdsCZnMLrPHxUGnBaV2+jz70zENNq9cC
	 t9AeibzKp2Potx6XtNzMILO64LNzp6oJZof1MMBBLNdTubMT6ILzu6ycEYcJ+bx2du
	 ht+HEFlkFa3/M6gS6v8rpEjvIJYb0zi1u9gMhwSaf747IMQ5jdGcWp2r4N/nMa40C7
	 AH447rUpeUV4Q==
Date: Tue, 23 Sep 2025 17:13:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 07/15] iomap: track read/readahead folio ownership
 internally
Message-ID: <20250924001335.GL1587915@frogsfrogsfrogs>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
 <20250923002353.2961514-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923002353.2961514-8-joannelkoong@gmail.com>

On Mon, Sep 22, 2025 at 05:23:45PM -0700, Joanne Koong wrote:
> The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
> track folio ownership to know who is responsible for unlocking it.
> Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
> purpose and so that this can be generically used later on by filesystems
> that are not block-based.
> 
> Since "struct iomap_read_folio_ctx" will be made a public interface
> later on when read/readahead takes in caller-provided callbacks, track
> the folio ownership state internally instead of exposing it in "struct
> iomap_read_folio_ctx" to make the interface simpler for end users.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 09e65771a947..34df1cddf65c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -362,7 +362,6 @@ static void iomap_read_end_io(struct bio *bio)
>  
>  struct iomap_read_folio_ctx {
>  	struct folio		*cur_folio;
> -	bool			cur_folio_in_bio;
>  	void			*read_ctx;
>  	struct readahead_control *rac;
>  };
> @@ -386,7 +385,6 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  	sector_t sector;
>  	struct bio *bio = ctx->read_ctx;
>  
> -	ctx->cur_folio_in_bio = true;
>  	if (ifs) {
>  		spin_lock_irq(&ifs->state_lock);
>  		ifs->read_bytes_pending += plen;
> @@ -423,7 +421,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  }
>  
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool *folio_owned)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	loff_t pos = iter->pos;
> @@ -460,6 +458,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> +			*folio_owned = true;
>  			iomap_bio_read_folio_range(iter, ctx, pos, plen);
>  		}
>  
> @@ -482,16 +481,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	struct iomap_read_folio_ctx ctx = {
>  		.cur_folio	= folio,
>  	};
> +	/*
> +	 * If an IO helper takes ownership of the folio, it is responsible for
> +	 * unlocking it when the read completes.
> +	 */
> +	bool folio_owned = false;
>  	int ret;
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_read_folio_iter(&iter, &ctx);
> +		iter.status = iomap_read_folio_iter(&iter, &ctx,
> +				&folio_owned);
>  
>  	iomap_bio_submit_read(&ctx);
>  
> -	if (!ctx.cur_folio_in_bio)
> +	if (!folio_owned)
>  		folio_unlock(folio);
>  
>  	/*
> @@ -504,14 +509,15 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
>  static int iomap_readahead_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx,
> +		bool *cur_folio_owned)
>  {
>  	int ret;
>  
>  	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
>  		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> -			if (!ctx->cur_folio_in_bio)
> +			if (!*cur_folio_owned)
>  				folio_unlock(ctx->cur_folio);
>  			ctx->cur_folio = NULL;
>  		}
> @@ -519,9 +525,9 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  			ctx->cur_folio = readahead_folio(ctx->rac);
>  			if (WARN_ON_ONCE(!ctx->cur_folio))
>  				return -EINVAL;
> -			ctx->cur_folio_in_bio = false;
> +			*cur_folio_owned = false;
>  		}
> -		ret = iomap_read_folio_iter(iter, ctx);
> +		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
>  		if (ret)
>  			return ret;
>  	}
> @@ -554,15 +560,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	struct iomap_read_folio_ctx ctx = {
>  		.rac	= rac,
>  	};
> +	/*
> +	 * If an IO helper takes ownership of the folio, it is responsible for
> +	 * unlocking it when the read completes.
> +	 */
> +	bool cur_folio_owned = false;
>  
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
>  	while (iomap_iter(&iter, ops) > 0)
> -		iter.status = iomap_readahead_iter(&iter, &ctx);
> +		iter.status = iomap_readahead_iter(&iter, &ctx,
> +					&cur_folio_owned);
>  
>  	iomap_bio_submit_read(&ctx);
>  
> -	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
> +	if (ctx.cur_folio && !cur_folio_owned)
>  		folio_unlock(ctx.cur_folio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
> -- 
> 2.47.3
> 
> 

