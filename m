Return-Path: <linux-fsdevel+bounces-60204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08925B42A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8831BC4CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE92DCF69;
	Wed,  3 Sep 2025 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr8a6J9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486D4C9D;
	Wed,  3 Sep 2025 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930621; cv=none; b=n+lBTW76zDTpX9vRR0vez3hk9XF+sdJJBE/nywwmoKkTGkG+dhDoKap0querfjrP8s7hEHz0vd+1lb6FDtnOQ3SiAmJ7Q/Q2odse+8uWrhv9ntQngBnD18xwMqSmJ10W6gXBlXS8A9qh/CR6E0lCkmJxcRupsvvNOJblFkVr+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930621; c=relaxed/simple;
	bh=BS6KtRNSdZI86az9SVn2Al6KzQIC+ATxI/Qmgbf4TvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeE0PrH5+oLN0z/AivuAqp9adHBdRxnVHfu5Hho/EABMFZC8v4ucGwDamaHWVWqUuGN7p2OPZFvjg3/TBLNbcGRH69Zzx6e0mrBvu+X00u7yN0PhM35oydYzPUNQ8NxDoTwCV71zQZ2wBsSMoQ2gfIUvQidVMAkVVKiA7FraX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr8a6J9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56122C4CEE7;
	Wed,  3 Sep 2025 20:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756930620;
	bh=BS6KtRNSdZI86az9SVn2Al6KzQIC+ATxI/Qmgbf4TvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr8a6J9V/YINn//h6DMz0L7zGCgXoKxIQAETJMuXCj+6Run//ehwAHgmSbePS/5eG
	 f5lVB35YaZKAAjD3fWhKhM20Y+0W6ULSCi8+uG8G+32rtm4JoXIxBvCb4C9wfTppuQ
	 EGuxlGiswVdox1hyTpV0T4jGCCLeE5Iwn4N3wXF7AVv8rQLtOR7yw2Emro+vYouC8W
	 yhhDAUKI5kXT6VKceypHNRcW+5Y2rnGV+sgbQAyuXiY5p2xz0vK4yz79Ujj26tg4Nv
	 0edEuQa7/E8rI3yeWXr9UQEMEo0YtPURzpCRQZ4Cun0sxaRzW3gNLXhJPX/yW42kX0
	 iyFbsgbRRewrQ==
Date: Wed, 3 Sep 2025 13:16:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 01/16] iomap: move async bio read logic into helper
 function
Message-ID: <20250903201659.GK1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-2-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:12PM -0700, Joanne Koong wrote:
> Move the iomap_readpage_iter() async bio read logic into a separate
> helper function. This is needed to make iomap read/readahead more
> generically usable, especially for filesystems that do not require
> CONFIG_BLOCK.
> 
> Rename iomap_read_folio_range() to iomap_read_folio_range_sync() to
> diferentiate between the synchronous and asynchronous bio folio read
> calls.

Hrmm.  Readahead is asynchronous, whereas reading in data as part of an
unaligned write to a file must be synchronous.  How about naming it
iomap_readahead_folio_range() ?

Oh wait, iomap_read_folio also calls iomap_readpage_iter, which uses the
readahead paths to fill out a folio, but then waits for the folio lock
to drop, which effectively makes it ... a synchronous user of
asynchronous code.

Bleh, naming is hard.  Though the code splitting seems fine...

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..f8bdb2428819 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -357,36 +357,15 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static int iomap_readpage_iter(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx)
> +static void iomap_read_folio_range_async(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
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
> +		iomap_read_folio_range_async(iter, ctx, pos, plen);
> +	}
>  
>  done:
>  	/*
> @@ -549,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -static int iomap_read_folio_range(const struct iomap_iter *iter,
> +static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
>  		struct folio *folio, loff_t pos, size_t len)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -562,7 +572,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
>  	return submit_bio_wait(&bio);
>  }
>  #else
> -static int iomap_read_folio_range(const struct iomap_iter *iter,
> +static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
>  		struct folio *folio, loff_t pos, size_t len)
>  {
>  	WARN_ON_ONCE(1);
> @@ -739,7 +749,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  				status = write_ops->read_folio_range(iter,
>  						folio, block_start, plen);
>  			else
> -				status = iomap_read_folio_range(iter,
> +				status = iomap_read_folio_range_sync(iter,
>  						folio, block_start, plen);
>  			if (status)
>  				return status;
> -- 
> 2.47.3
> 
> 

