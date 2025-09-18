Return-Path: <linux-fsdevel+bounces-62176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2A9B872A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAFB2A88FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41A2FAC05;
	Thu, 18 Sep 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7grNq3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB271F4181;
	Thu, 18 Sep 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231462; cv=none; b=UsVP+V/wsnbXSo98LID3xwBtIyJdtS92wrsjKvdmJFZv1J+RAzZJs6XayM7ptYJzXolHwvirCPLt8uUhbWdbEZ02d6zBtVKjydMKybT34Ub91Qj3XHtSDKCZRyV4VTJFYptancac+4cyuoK58un4as6MnMpj8vZqcXOIhpPCw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231462; c=relaxed/simple;
	bh=nenRloHhZZ/kclJh+U9hD8GUkdddf+gbcseCB9vGaTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMx1kbHOoR4TeGz0XGyA7KILgUUA2hQ95sJk8BzJ0DQasAY4XGdPCdP7OjLFNz8lyS/FVrGOfJkHEQF7aLJDLBE8+Bk4/GjV3CbSTtWAUK2Hhpl2AkNYVk1LzVQWErC0+hoH1wp527T1dxb2WPiWHDgONmxN8ia1D0k/ODBM/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7grNq3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F0C4CEE7;
	Thu, 18 Sep 2025 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758231461;
	bh=nenRloHhZZ/kclJh+U9hD8GUkdddf+gbcseCB9vGaTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7grNq3d0Kdjc0jbyt0wdda6yxWRm/Oer5VgGBWej6sjwWfWxTFlFwbPSTbKf+6l4
	 /PaJkQ4fIDoZnz47KXyaczu+zBvqKT/jSRiA/N7iqLTWdclY/k104BdXcY3ZTnUoYg
	 bBZOM5aB/rPpOWpo1NdgfJSIHxvUX8IQXiPzS1d4arlHUH4i95Gw5P5IH5tT6UZVr9
	 cyUXtu20Ilhtaz0kQmJQnh2Zef+b9nIynjv062tEyZTO6UfMYlMfvMgvmmgwZX5bpg
	 HQ+7H4TEadKHZAwFtpwk4uzVTX+8QapEFTJwaRNWhWYQLYt+B7Kso3rqstY2UQkOiE
	 9fJuhh/u8FMzg==
Date: Thu, 18 Sep 2025 14:37:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 04/15] iomap: iterate over entire folio in
 iomap_readpage_iter()
Message-ID: <20250918213740.GV1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-5-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:14PM -0700, Joanne Koong wrote:
> Iterate over all non-uptodate ranges in a single call to
> iomap_readpage_iter() instead of leaving the partial folio iteration to
> the caller.
> 
> This will be useful for supporting caller-provided async folio read
> callbacks (added in later commit) because that will require tracking
> when the first and last async read request for a folio is sent, in order
> to prevent premature read completion of the folio.
> 
> This additionally makes the iomap_readahead_iter() logic a bit simpler.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This looks pretty straightforward, so 
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 69 ++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2a1709e0757b..0c4ba2a63490 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	loff_t length = iomap_length(iter);
>  	struct folio *folio = ctx->cur_folio;
>  	size_t poff, plen;
> +	loff_t count;
>  	int ret;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> @@ -431,39 +432,33 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  
>  	/* zero post-eof blocks as the page may be mapped */
>  	ifs_alloc(iter->inode, folio, iter->flags);
> -	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
> -	if (plen == 0)
> -		goto done;
>  
> -	if (iomap_block_needs_zeroing(iter, pos)) {
> -		folio_zero_range(folio, poff, plen);
> -		iomap_set_range_uptodate(folio, poff, plen);
> -	} else {
> -		iomap_bio_read_folio_range(iter, ctx, pos, plen);
> -	}
> +	length = min_t(loff_t, length,
> +			folio_size(folio) - offset_in_folio(folio, pos));
> +	while (length) {
> +		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
> +				&plen);
>  
> -done:
> -	/*
> -	 * Move the caller beyond our range so that it keeps making progress.
> -	 * For that, we have to include any leading non-uptodate ranges, but
> -	 * we can skip trailing ones as they will be handled in the next
> -	 * iteration.
> -	 */
> -	length = pos - iter->pos + plen;
> -	return iomap_iter_advance(iter, &length);
> -}
> +		count = pos - iter->pos + plen;
> +		if (WARN_ON_ONCE(count > length))
> +			return -EIO;
>  
> -static int iomap_read_folio_iter(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx)
> -{
> -	int ret;
> +		if (plen == 0)
> +			return iomap_iter_advance(iter, &count);
>  
> -	while (iomap_length(iter)) {
> -		ret = iomap_readpage_iter(iter, ctx);
> +		if (iomap_block_needs_zeroing(iter, pos)) {
> +			folio_zero_range(folio, poff, plen);
> +			iomap_set_range_uptodate(folio, poff, plen);
> +		} else {
> +			iomap_bio_read_folio_range(iter, ctx, pos, plen);
> +		}
> +
> +		length -= count;
> +		ret = iomap_iter_advance(iter, &count);
>  		if (ret)
>  			return ret;
> +		pos = iter->pos;
>  	}
> -
>  	return 0;
>  }
>  
> @@ -482,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_read_folio_iter(&iter, &ctx);
> +		iter.status = iomap_readpage_iter(&iter, &ctx);
>  
>  	iomap_bio_submit_read(&ctx);
>  
> @@ -504,16 +499,16 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  	int ret;
>  
>  	while (iomap_length(iter)) {
> -		if (ctx->cur_folio &&
> -		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> -			if (!ctx->cur_folio_in_bio)
> -				folio_unlock(ctx->cur_folio);
> -			ctx->cur_folio = NULL;
> -		}
> -		if (!ctx->cur_folio) {
> -			ctx->cur_folio = readahead_folio(ctx->rac);
> -			ctx->cur_folio_in_bio = false;
> -		}
> +		if (ctx->cur_folio && !ctx->cur_folio_in_bio)
> +			folio_unlock(ctx->cur_folio);
> +		ctx->cur_folio = readahead_folio(ctx->rac);
> +		/*
> +		 * We should never in practice hit this case since the iter
> +		 * length matches the readahead length.
> +		 */
> +		if (WARN_ON_ONCE(!ctx->cur_folio))
> +			return -EINVAL;
> +		ctx->cur_folio_in_bio = false;
>  		ret = iomap_readpage_iter(iter, ctx);
>  		if (ret)
>  			return ret;
> -- 
> 2.47.3
> 
> 

