Return-Path: <linux-fsdevel+bounces-42123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32906A3CC33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FCE3A7F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795325333B;
	Wed, 19 Feb 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjaRJYTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0800286280;
	Wed, 19 Feb 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003756; cv=none; b=AYAXPiRxaRLrBz4BBkTfuURbeBOAqWhYEIOnXhMntgVXgqLtKu8yoG04qsLsmy1X3A8nx4U8OcK/v9a8b/uHNSBzGBqhWfU8YR+3sAiYb334fazbazoJLkiIAHKz9OYpKiDzAtMfyukkOpMHj83X9AlEVTceFELiMmktLzScYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003756; c=relaxed/simple;
	bh=SutIu3Ft66646WwIdiUf9XX7kwLKS5b0/THMrNij154=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWB2I1W6f55gkf9gjt5ex9AsqBGUJ12PDJbVnLwYok2ToKTu0h/XZ4WeLUQjHV9zNMXG+dEqdq/I7xxivOT6vKljgiu2VaJqweuatiqB8MuE86I6fdn3yQPn/t1x1HxflMF2ml/TljbWwNHePKYn2vAB3On4tJwHxSdYnyTJap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjaRJYTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3701FC4CED1;
	Wed, 19 Feb 2025 22:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740003756;
	bh=SutIu3Ft66646WwIdiUf9XX7kwLKS5b0/THMrNij154=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjaRJYTzL4nrxje5CL7mkYTi8EhO80WJ/4SUIDrfkN+snUjwMl61SjSTPSG6XW3Qm
	 zR/aui7wFk/dTZYyx3h4/l+ZL8cPrx5bXhagZ1hEmeBRa2zkRVZoUkXxOt7cSvAZTW
	 PTvwEugHQDgkVVm7Ez9Duuqt/64aA0ExTCxzZE73WdOhe0gQ0kr6BAS7jj+Yg1vO0W
	 3ul6UMTtsbjUrW20AYYgY/ZP+rFx3lX+GxqKUuxqVam3wwfoKKze6E73MBS2yxqERc
	 0nBGOvSoyM7cle9YsngvwwBMrgyjatXfIKw7WS5Dj6ANmqQiS0qyTzQksXcCbVPYnf
	 tWhNGRvmSW0Fw==
Date: Wed, 19 Feb 2025 14:22:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/12] iomap: advance the iter directly on buffered
 read
Message-ID: <20250219222235.GB21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-2-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:39PM -0500, Brian Foster wrote:
> iomap buffered read advances the iter via iter.processed. To
> continue separating iter advance from return status, update
> iomap_readpage_iter() to advance the iter instead of returning the
> number of bytes processed. In turn, drop the offset parameter and
> sample the updated iter->pos at the start of the function. Update
> the callers to loop based on remaining length in the current
> iteration instead of number of bytes processed.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 45 +++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ec227b45f3aa..215866ba264d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -366,15 +366,14 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  		pos >= i_size_read(iter->inode);
>  }
>  
> -static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx, loff_t offset)
> +static loff_t iomap_readpage_iter(struct iomap_iter *iter,

I wonder, do we really need to return loff_t from some of these
functions now?  I thought the only return codes were the -EIO/0 from
iomap_iter_advance?

--D

> +		struct iomap_readpage_ctx *ctx)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos + offset;
> -	loff_t length = iomap_length(iter) - offset;
> +	loff_t pos = iter->pos;
> +	loff_t length = iomap_length(iter);
>  	struct folio *folio = ctx->cur_folio;
>  	struct iomap_folio_state *ifs;
> -	loff_t orig_pos = pos;
>  	size_t poff, plen;
>  	sector_t sector;
>  
> @@ -438,25 +437,22 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	 * we can skip trailing ones as they will be handled in the next
>  	 * iteration.
>  	 */
> -	return pos - orig_pos + plen;
> +	length = pos - iter->pos + plen;
> +	return iomap_iter_advance(iter, &length);
>  }
>  
> -static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
> +static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> -	struct folio *folio = ctx->cur_folio;
> -	size_t offset = offset_in_folio(folio, iter->pos);
> -	loff_t length = min_t(loff_t, folio_size(folio) - offset,
> -			      iomap_length(iter));
> -	loff_t done, ret;
> -
> -	for (done = 0; done < length; done += ret) {
> -		ret = iomap_readpage_iter(iter, ctx, done);
> -		if (ret <= 0)
> +	loff_t ret;
> +
> +	while (iomap_length(iter)) {
> +		ret = iomap_readpage_iter(iter, ctx);
> +		if (ret)
>  			return ret;
>  	}
>  
> -	return done;
> +	return 0;
>  }
>  
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
> @@ -493,15 +489,14 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
> -static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> +static loff_t iomap_readahead_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> -	loff_t length = iomap_length(iter);
> -	loff_t done, ret;
> +	loff_t ret;
>  
> -	for (done = 0; done < length; done += ret) {
> +	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
> -		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
> +		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
>  			if (!ctx->cur_folio_in_bio)
>  				folio_unlock(ctx->cur_folio);
>  			ctx->cur_folio = NULL;
> @@ -510,12 +505,12 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
>  			ctx->cur_folio = readahead_folio(ctx->rac);
>  			ctx->cur_folio_in_bio = false;
>  		}
> -		ret = iomap_readpage_iter(iter, ctx, done);
> -		if (ret <= 0)
> +		ret = iomap_readpage_iter(iter, ctx);
> +		if (ret)
>  			return ret;
>  	}
>  
> -	return done;
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.48.1
> 
> 

