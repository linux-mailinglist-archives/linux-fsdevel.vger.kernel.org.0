Return-Path: <linux-fsdevel+bounces-62177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73379B872D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607B5188DCD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738CA2FD7CE;
	Thu, 18 Sep 2025 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKLuR1fO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E12222B4;
	Thu, 18 Sep 2025 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232194; cv=none; b=NGPYyWImdW84hrts3hXNW1oZcGwmNScxKUt8sldoWU8/sIhCAAvJrbWjRA9mHy0HEOagda3gEVpkhFukANP32khw6bkzOWvU/JEo9loZQzqygsChujcMwtK4NimIiP9XZUQtrON8NywY7niCPbj5hlqA2Tp7RUwkeD75JkCghKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232194; c=relaxed/simple;
	bh=glShEqxOWep0q0rclDTHuTdTRTdRHX98mDamAkIO2Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY4iv35V7ZQqggZ6pqUR06ik9/662vBFkh7MqiMLwTJvcNHD/2BgaV4kbNqAdSAiqwNmIBzzwxY/S55Dw0rJ0ytUZEnV+q8hTfi5JN6yGiv1pqc0ZMAi7kUuUQRNN4+cAhv9IGjvFhy5NRPdcUq7JATdlh3E+OKHP5eWwIb9eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKLuR1fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8DBC4CEF0;
	Thu, 18 Sep 2025 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758232194;
	bh=glShEqxOWep0q0rclDTHuTdTRTdRHX98mDamAkIO2Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKLuR1fO4moofkTJbuFylpeuBFvut+BZ+YejZKnNg9RJsirm6MdO9jvUXLuzGgHjh
	 QJNbKq2cH41bRgbXCux4TNryQ7rNbz5X8IxOFzmxzekrTtSernPBDbITTKDF4Twqnt
	 jQU5wFclzIM7jSErdv5tk/S0K/T2FDcipsvg7LIeG3X1F/mzosBGGH/ZBti7d5p1Jj
	 xkxr6Pn8tIuVn+Zr1TOOz3AxoUWRgemTkp6XppVSSQfSqN/ulO66fZy7pZ9Of0zvb6
	 D0cKtwxLLMmpbPT4OZhqDo4Xr0jsb4L6Ulb8U2uZPghFfuCP75v4kTT0ihKEdUFMg2
	 S2ePQfv9EHySg==
Date: Thu, 18 Sep 2025 14:49:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 07/15] iomap: track read/readahead folio ownership
 internally
Message-ID: <20250918214953.GW1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-8-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:17PM -0700, Joanne Koong wrote:
> The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
> track folio ownership to know who is responsible for unlocking it.
> Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
> purpose and so that this can be generically used later on by filesystems
> that are not block-based.

Hrmm, well if this is becoming a private variable, then I'd shorten it
to "folio_owned" since it's not really in the ctx/cur anymore, but I
might be bikeshedding now. :)

> Since "struct iomap_read_folio_ctx" will be made a public interface
> later on when read/readahead takes in caller-provided callbacks, track
> the folio ownership state internally instead of exposing it in "struct
> iomap_read_folio_ctx" to make the interface simpler for end users.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6c5a631848b7..587bbdbd24bc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -352,7 +352,6 @@ static void iomap_read_end_io(struct bio *bio)
>  
>  struct iomap_read_folio_ctx {
>  	struct folio		*cur_folio;
> -	bool			cur_folio_in_bio;
>  	void			*read_ctx;
>  	struct readahead_control *rac;
>  };
> @@ -376,7 +375,6 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  	sector_t sector;
>  	struct bio *bio = ctx->read_ctx;
>  
> -	ctx->cur_folio_in_bio = true;
>  	if (ifs) {
>  		spin_lock_irq(&ifs->state_lock);
>  		ifs->read_bytes_pending += plen;
> @@ -413,7 +411,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  }
>  
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	loff_t pos = iter->pos;
> @@ -450,6 +448,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> +			*cur_folio_owned = true;
>  			iomap_bio_read_folio_range(iter, ctx, pos, plen);
>  		}
>  
> @@ -472,16 +471,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	struct iomap_read_folio_ctx ctx = {
>  		.cur_folio	= folio,
>  	};
> +	/*
> +	 * If an external IO helper takes ownership of the folio, it is
> +	 * responsible for unlocking it when the read completes.

Not sure what "external" means here -- I think for your project it means
a custom folio read method supplied by a filesystem, but for the exist
code (xfs submitting unaltered bios), that part is still mostly internal
to iomap.

If we were *only* refactoring code I would suggest s/external/async/
because that's what the bio code does, but a filesystem supplying its
own folio read function could very well fill the folio synchronously and
it'd still have to unlock the folio.

Maybe just get rid of the word external?  The rest of the code changes
look fine to me.

--D

> +	 */
> +	bool cur_folio_owned = false;
>  	int ret;
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_read_folio_iter(&iter, &ctx);
> +		iter.status = iomap_read_folio_iter(&iter, &ctx,
> +				&cur_folio_owned);
>  
>  	iomap_bio_submit_read(&ctx);
>  
> -	if (!ctx.cur_folio_in_bio)
> +	if (!cur_folio_owned)
>  		folio_unlock(folio);
>  
>  	/*
> @@ -494,12 +499,13 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
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
> -		if (ctx->cur_folio && !ctx->cur_folio_in_bio)
> +		if (ctx->cur_folio && !*cur_folio_owned)
>  			folio_unlock(ctx->cur_folio);
>  		ctx->cur_folio = readahead_folio(ctx->rac);
>  		/*
> @@ -508,8 +514,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  		 */
>  		if (WARN_ON_ONCE(!ctx->cur_folio))
>  			return -EINVAL;
> -		ctx->cur_folio_in_bio = false;
> -		ret = iomap_read_folio_iter(iter, ctx);
> +		*cur_folio_owned = false;
> +		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
>  		if (ret)
>  			return ret;
>  	}
> @@ -542,15 +548,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	struct iomap_read_folio_ctx ctx = {
>  		.rac	= rac,
>  	};
> +	/*
> +	 * If an external IO helper takes ownership of the folio, it is
> +	 * responsible for unlocking it when the read completes.
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

