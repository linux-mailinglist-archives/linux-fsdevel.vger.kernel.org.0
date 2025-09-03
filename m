Return-Path: <linux-fsdevel+bounces-60208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84320B42B38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDE816C3CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566531AF1C;
	Wed,  3 Sep 2025 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOMvet+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2202DE6FB;
	Wed,  3 Sep 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932229; cv=none; b=jIFPHrghQCaGLIfC8Gp4uSthAS5JBrbNU11l+vCU2/BVXT6QHhjJ+xjrDMlTRECyHxA2xDPUzLrHcYfDZ6/yDJpbgiEfV+DWBCfVz7+eNDMA7JfSi+U2v1pJ7arGBfwxB5R/TuM0zn42JYDYZ+1TpvY01KBccrqsx0IsHgXtB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932229; c=relaxed/simple;
	bh=2HvflQBDjFss4z/3YIhlC2S1Il45Fr0+/joDtsa4EDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuNcTtBb5ipCIUUzR5Q0RzVFsbVAIptxKImKmC+II4DDrZOhcc10WhV78IaLbz526K3QZqUEom5pNmfpiiLBQD8H7A5VG4KiKzKGaqvzkCbqDgDgTgsdqqlfcppz3i6giRPjuT4oMSP09LklIS2VIpt+XWt05oje9UsfNd7Gtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOMvet+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A8CC4CEE7;
	Wed,  3 Sep 2025 20:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932229;
	bh=2HvflQBDjFss4z/3YIhlC2S1Il45Fr0+/joDtsa4EDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOMvet+k1vgS0/PUJGJUawiF62vs2C4DiEormBVKGJSCY/zS9023yshhwtp5PBfUQ
	 4s24DvT+z6ytd+Xlmb/byXucMSxT48U5rBo8DN51P9xkEnSpEnEEoMJmOrZKAiSGN0
	 iabGQTAlTsma1yMvQaRS9wRdDoPNX9FQRX1fT6qxl5hCniqG0ZRx9W/BVV6ErMCBwi
	 QmQLzJ38WhbTOeebT7AxflQoqGpel4bGlXMQ61G4POF9OE9W+ZWqK5oozt6wBt9MLs
	 tHNisyz2/FWW/xR6UJ8PRTR+RpWIl7GTUEc3Li1Tx9+vFH1hpxRuIW/PIY8AkTfZ8t
	 glShtCOaKa9Pw==
Date: Wed, 3 Sep 2025 13:43:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 07/16] iomap: iterate through entire folio in
 iomap_readpage_iter()
Message-ID: <20250903204348.GO1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-8-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:18PM -0700, Joanne Koong wrote:
> Iterate through the entire folio in iomap_readpage_iter() in one go
> instead of in pieces. This will be needed for supporting user-provided
> async read folio callbacks (not yet added). This additionally makes the
> iomap_readahead_iter() logic simpler to follow.

This might be a good time to change the name since you're not otherwise
changing the function declaration, and there ought to be /some/
indication that the behavior isn't the same anymore.

Otherwise, this looks correct to me.

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 76 ++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f26544fbcb36..75bbef386b62 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -452,6 +452,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	loff_t length = iomap_length(iter);
>  	struct folio *folio = ctx->cur_folio;
>  	size_t poff, plen;
> +	loff_t count;
>  	int ret;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> @@ -463,26 +464,30 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
> -		iomap_read_folio_range_async(iter, ctx, pos, plen);
> -	}
> +	length = min_t(loff_t, length,
> +			folio_size(folio) - offset_in_folio(folio, pos));
> +	while (length) {
> +		iomap_adjust_read_range(iter->inode, folio, &pos,
> +				length, &poff, &plen);
> +		count = pos - iter->pos + plen;
> +		if (plen == 0)
> +			return iomap_iter_advance(iter, &count);
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
> +		if (iomap_block_needs_zeroing(iter, pos)) {
> +			folio_zero_range(folio, poff, plen);
> +			iomap_set_range_uptodate(folio, poff, plen);
> +		} else {
> +			iomap_read_folio_range_async(iter, ctx, pos, plen);
> +		}
> +
> +		length -= count;
> +		ret = iomap_iter_advance(iter, &count);
> +		if (ret)
> +			return ret;
> +		pos = iter->pos;
> +	}
> +	return 0;
>  }
>  
>  static void iomap_readfolio_complete(const struct iomap_iter *iter,
> @@ -494,20 +499,6 @@ static void iomap_readfolio_complete(const struct iomap_iter *iter,
>  		folio_unlock(ctx->cur_folio);
>  }
>  
> -static int iomap_read_folio_iter(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx)
> -{
> -	int ret;
> -
> -	while (iomap_length(iter)) {
> -		ret = iomap_readpage_iter(iter, ctx);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  {
>  	struct iomap_iter iter = {
> @@ -523,7 +514,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_read_folio_iter(&iter, &ctx);
> +		iter.status = iomap_readpage_iter(&iter, &ctx);
>  
>  	iomap_readfolio_complete(&iter, &ctx);
>  
> @@ -537,16 +528,15 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  	int ret;
>  
>  	while (iomap_length(iter)) {
> -		if (ctx->cur_folio &&
> -		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> -			if (!ctx->folio_unlocked)
> -				folio_unlock(ctx->cur_folio);
> -			ctx->cur_folio = NULL;
> -		}
> -		if (!ctx->cur_folio) {
> -			ctx->cur_folio = readahead_folio(ctx->rac);
> -			ctx->folio_unlocked = false;
> -		}
> +		if (ctx->cur_folio && !ctx->folio_unlocked)
> +			folio_unlock(ctx->cur_folio);
> +		ctx->cur_folio = readahead_folio(ctx->rac);
> +		/*
> +		 * We should never in practice hit this case since
> +		 * the iter length matches the readahead length.
> +		 */
> +		WARN_ON(!ctx->cur_folio);
> +		ctx->folio_unlocked = false;
>  		ret = iomap_readpage_iter(iter, ctx);
>  		if (ret)
>  			return ret;
> -- 
> 2.47.3
> 
> 

