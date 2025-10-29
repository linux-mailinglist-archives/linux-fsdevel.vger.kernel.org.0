Return-Path: <linux-fsdevel+bounces-66179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE218C185D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48B9D35110B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE112F7466;
	Wed, 29 Oct 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWhga3VV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3A1DC9B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717374; cv=none; b=EHP1PWPlrFigHxYMrhl56QQqKkU9MMNcrZVnzl7axEMHpNzbyJ5Fwo8YKwapYa6UrmyjdBY8EjBcDyAqSHG+n0uFM8o7KwZ+33B0qIQbUOs7uUsDGsMIHdZw6X1AdAnMYAG8uoMuGQUhxegNyP5mmafGrKMWEOuoQ4C/nR9cujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717374; c=relaxed/simple;
	bh=ulhF2ABZf2nzezUVPBRL+Mb3aNuLGrCdxIbaTHpMlKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMNqBsN57WNGBDtgjyUUDVild55SJEeHCqX2HDITCPonLT+pwb87noq987ilQkLv6g8kz397hdDVSXd2XIWABri3ARSHgnwj8SSOsyQnZO3kwnJADMQXZDKhMUfkyXTbwi9Zf4bqT50+SOCf5/8Q92DfzWS8DystHuri9PvU4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWhga3VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6103C4CEF7;
	Wed, 29 Oct 2025 05:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761717373;
	bh=ulhF2ABZf2nzezUVPBRL+Mb3aNuLGrCdxIbaTHpMlKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWhga3VV2PqUDyMQWjrCKAj6tmPGFkaQ30AT/Y9S2Xo3Mrol6X2PsnG0o9TXg4CzP
	 j4Lki3cVXMAz4CjubFCcKFXRj3XHVsZk6UIZYG7MFohu6xaV1KX84Pz76ssS0qys7i
	 uLjGx8YgIYsNEyPpHIOeZXaVr0gmgYuoqj0lpmG5l/14Hr5oWeJTA/D/MK66eGYDr4
	 spql79X6YapXB004HYn8r5mXTbUjvA5xMbA4V4mNka9w5mypOtqTLtYhGFivPp3D+G
	 W6AAZ7Wf2UQnVYsXbgoNgMNWEyWQq/aY/OONc5+qZ+xVeKvCJtOgdkgXd0N0nmHO5+
	 ZP7ewCPHFAshQ==
Date: Tue, 28 Oct 2025 22:56:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, bfoster@redhat.com, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iomap: rename bytes_pending/bytes_accounted to
 bytes_submitted/bytes_not_submitted
Message-ID: <20251029055613.GQ4015566@frogsfrogsfrogs>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
 <20251028181133.1285219-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028181133.1285219-2-joannelkoong@gmail.com>

On Tue, Oct 28, 2025 at 11:11:32AM -0700, Joanne Koong wrote:
> As mentioned by Brian in [1], the naming "bytes_pending" and
> "bytes_accounting" may be confusing and could be better named. Rename
> this to "bytes_submitted" and "bytes_not_submitted" to make it more
> clear that these are bytes we passed to the IO helper to read in.
> 
> [1] https://lore.kernel.org/linux-fsdevel/aPuz4Uop66-jRpN-@bfoster/
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks fine to me, though it's gonna be hard for me to figure out what's
going on in patch 2 because first I have to go find this 6.19 iomap
branch that everyone's talking about...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 72196e5021b1..4c0d66612a67 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -364,16 +364,16 @@ static void iomap_read_init(struct folio *folio)
>  	}
>  }
>  
> -static void iomap_read_end(struct folio *folio, size_t bytes_pending)
> +static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>  {
>  	struct iomap_folio_state *ifs;
>  
>  	/*
> -	 * If there are no bytes pending, this means we are responsible for
> +	 * If there are no bytes submitted, this means we are responsible for
>  	 * unlocking the folio here, since no IO helper has taken ownership of
>  	 * it.
>  	 */
> -	if (!bytes_pending) {
> +	if (!bytes_submitted) {
>  		folio_unlock(folio);
>  		return;
>  	}
> @@ -381,10 +381,11 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
>  	ifs = folio->private;
>  	if (ifs) {
>  		bool end_read, uptodate;
> -		size_t bytes_accounted = folio_size(folio) - bytes_pending;
> +		size_t bytes_not_submitted = folio_size(folio) -
> +				bytes_submitted;
>  
>  		spin_lock_irq(&ifs->state_lock);
> -		ifs->read_bytes_pending -= bytes_accounted;
> +		ifs->read_bytes_pending -= bytes_not_submitted;
>  		/*
>  		 * If !ifs->read_bytes_pending, this means all pending reads
>  		 * by the IO helper have already completed, which means we need
> @@ -401,7 +402,7 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
>  }
>  
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx, size_t *bytes_pending)
> +		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	loff_t pos = iter->pos;
> @@ -442,9 +443,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> -			if (!*bytes_pending)
> +			if (!*bytes_submitted)
>  				iomap_read_init(folio);
> -			*bytes_pending += plen;
> +			*bytes_submitted += plen;
>  			ret = ctx->ops->read_folio_range(iter, ctx, plen);
>  			if (ret)
>  				return ret;
> @@ -468,39 +469,40 @@ void iomap_read_folio(const struct iomap_ops *ops,
>  		.pos		= folio_pos(folio),
>  		.len		= folio_size(folio),
>  	};
> -	size_t bytes_pending = 0;
> +	size_t bytes_submitted = 0;
>  	int ret;
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_read_folio_iter(&iter, ctx, &bytes_pending);
> +		iter.status = iomap_read_folio_iter(&iter, ctx,
> +				&bytes_submitted);
>  
>  	if (ctx->ops->submit_read)
>  		ctx->ops->submit_read(ctx);
>  
> -	iomap_read_end(folio, bytes_pending);
> +	iomap_read_end(folio, bytes_submitted);
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
>  static int iomap_readahead_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_pending)
> +		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_submitted)
>  {
>  	int ret;
>  
>  	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
>  		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> -			iomap_read_end(ctx->cur_folio, *cur_bytes_pending);
> +			iomap_read_end(ctx->cur_folio, *cur_bytes_submitted);
>  			ctx->cur_folio = NULL;
>  		}
>  		if (!ctx->cur_folio) {
>  			ctx->cur_folio = readahead_folio(ctx->rac);
>  			if (WARN_ON_ONCE(!ctx->cur_folio))
>  				return -EINVAL;
> -			*cur_bytes_pending = 0;
> +			*cur_bytes_submitted = 0;
>  		}
> -		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_pending);
> +		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_submitted);
>  		if (ret)
>  			return ret;
>  	}
> @@ -532,19 +534,19 @@ void iomap_readahead(const struct iomap_ops *ops,
>  		.pos	= readahead_pos(rac),
>  		.len	= readahead_length(rac),
>  	};
> -	size_t cur_bytes_pending;
> +	size_t cur_bytes_submitted;
>  
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
>  	while (iomap_iter(&iter, ops) > 0)
>  		iter.status = iomap_readahead_iter(&iter, ctx,
> -					&cur_bytes_pending);
> +					&cur_bytes_submitted);
>  
>  	if (ctx->ops->submit_read)
>  		ctx->ops->submit_read(ctx);
>  
>  	if (ctx->cur_folio)
> -		iomap_read_end(ctx->cur_folio, cur_bytes_pending);
> +		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 

