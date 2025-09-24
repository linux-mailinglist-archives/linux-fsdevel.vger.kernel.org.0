Return-Path: <linux-fsdevel+bounces-62535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308FBB97E03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 02:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C4A7A17C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6D189BB6;
	Wed, 24 Sep 2025 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAoNdRWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4D23AD;
	Wed, 24 Sep 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673713; cv=none; b=iobPGVYJXSS0K8mnk1IYTqHlGsJVb3GjuBD+WOeodjpf5JG+3gHA3zRQNHZMYr51DTCiM4TpXJpssPdSGNxuOohmUISF+pqOwcjR3BKDa5hFv3L6eQijmel5BXZCtP7bM3KeHGogrTyGfnReRSucAOAMyyxP7dpdyxXBMixdCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673713; c=relaxed/simple;
	bh=NvXiOkoBMOhyoludx8D3RhL/BwY5aAuKdR/v5OmXcB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtQOcoDbc466ta+NcnONNgsHOZ9K405qjNr4zzOxuQOJ7nB/PCu3VYRHjmk86WF91aRRYA3iOteuX1e0Qih1G2nMmHdyXhoEBfEf50exE4YR92gdZBoWInke6EXZ/IHci9tAyWTaGUI3O/+GHtm/C+1d/nPKCa71zqD4pZ9wIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAoNdRWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA469C4CEF5;
	Wed, 24 Sep 2025 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673712;
	bh=NvXiOkoBMOhyoludx8D3RhL/BwY5aAuKdR/v5OmXcB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAoNdRWc2C5qRe8n0tG0oB227VzG9fVOTXlwuzlHtcAJNqO9OPmvn+sQAvMMIzvqU
	 F2uf5zH8UlyrZxBrDQiP2swPbAh5nlG9exTUf7xCm31qmwRk6nPnGF3Xm0RChk6Ul2
	 CjQ9DYHem52rayxxiox+BsDt9cwpGp68jdBDMQBZ3KYG/VCPUGm0dzGfWf5wfFTBl3
	 NFD2KBtfNydqlzNwfWF6yTzs/whO6QKvQiQrBiUheXAMpfJEG44xisroYKOY3UwcD7
	 tE+EcykXK0fg6n5WHwhP7t2ZSBBA1nakuq1VeVbp2Mj91z7mfy89aAgd9DfDuBycpN
	 ilmtIEAhFj8Lw==
Date: Tue, 23 Sep 2025 17:28:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 10/15] iomap: add bias for async read requests
Message-ID: <20250924002832.GN1587915@frogsfrogsfrogs>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
 <20250923002353.2961514-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923002353.2961514-11-joannelkoong@gmail.com>

On Mon, Sep 22, 2025 at 05:23:48PM -0700, Joanne Koong wrote:
> Non-block-based filesystems will be using iomap read/readahead. If they
> handle reading in ranges asynchronously and fulfill those read requests
> on an ongoing basis (instead of all together at the end), then there is
> the possibility that the read on the folio may be prematurely ended if
> earlier async requests complete before the later ones have been issued.
> 
> For example if there is a large folio and a readahead request for 16
> pages in that folio, if doing readahead on those 16 pages is split into
> 4 async requests and the first request is sent off and then completed
> before we have sent off the second request, then when the first request
> calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
> which would end the read and unlock the folio prematurely.
> 
> To mitigate this, a "bias" is added to ifs->read_bytes_pending before
> the first range is forwarded to the caller and removed after the last
> range has been forwarded.
> 
> iomap writeback does this with their async requests as well to prevent
> prematurely ending writeback.

I'm still waiting for responses to the old draft of this patch in the v3
thread.

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 48 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 81ba0cc7705a..354819facfac 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -430,6 +430,38 @@ const struct iomap_read_ops iomap_bio_read_ops = {
>  };
>  EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
>  
> +/*
> + * Add a bias to ifs->read_bytes_pending to prevent the read on the folio from
> + * being ended prematurely.
> + *
> + * Otherwise, if the ranges are read asynchronously and read requests are
> + * fulfilled on an ongoing basis, there is the possibility that the read on the
> + * folio may be prematurely ended if earlier async requests complete before the
> + * later ones have been issued.
> + */
> +static void iomap_read_add_bias(struct iomap_iter *iter, struct folio *folio)
> +{
> +	ifs_alloc(iter->inode, folio, iter->flags);
> +	iomap_start_folio_read(folio, 1);
> +}
> +
> +static void iomap_read_remove_bias(struct folio *folio, bool folio_owned)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	bool end_read, uptodate;
> +
> +	if (ifs) {
> +		spin_lock_irq(&ifs->state_lock);
> +		ifs->read_bytes_pending--;
> +		end_read = !ifs->read_bytes_pending && folio_owned;
> +		if (end_read)
> +			uptodate = ifs_is_fully_uptodate(folio, ifs);
> +		spin_unlock_irq(&ifs->state_lock);
> +		if (end_read)
> +			folio_end_read(folio, uptodate);
> +	}
> +}
> +
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx, bool *folio_owned)
>  {
> @@ -448,8 +480,6 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		return iomap_iter_advance(iter, length);
>  	}
>  
> -	ifs_alloc(iter->inode, folio, iter->flags);
> -
>  	length = min_t(loff_t, length,
>  			folio_size(folio) - offset_in_folio(folio, pos));
>  	while (length) {
> @@ -505,6 +535,8 @@ int iomap_read_folio(const struct iomap_ops *ops,
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
> +	iomap_read_add_bias(&iter, folio);
> +
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.status = iomap_read_folio_iter(&iter, ctx,
>  				&folio_owned);
> @@ -512,6 +544,8 @@ int iomap_read_folio(const struct iomap_ops *ops,
>  	if (ctx->ops->submit_read)
>  		ctx->ops->submit_read(ctx);
>  
> +	iomap_read_remove_bias(folio, folio_owned);
> +
>  	if (!folio_owned)
>  		folio_unlock(folio);
>  
> @@ -533,6 +567,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
>  		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> +			iomap_read_remove_bias(ctx->cur_folio,
> +					*cur_folio_owned);
>  			if (!*cur_folio_owned)
>  				folio_unlock(ctx->cur_folio);
>  			ctx->cur_folio = NULL;
> @@ -541,6 +577,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  			ctx->cur_folio = readahead_folio(ctx->rac);
>  			if (WARN_ON_ONCE(!ctx->cur_folio))
>  				return -EINVAL;
> +			iomap_read_add_bias(iter, ctx->cur_folio);
>  			*cur_folio_owned = false;
>  		}
>  		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
> @@ -590,8 +627,11 @@ void iomap_readahead(const struct iomap_ops *ops,
>  	if (ctx->ops->submit_read)
>  		ctx->ops->submit_read(ctx);
>  
> -	if (ctx->cur_folio && !cur_folio_owned)
> -		folio_unlock(ctx->cur_folio);
> +	if (ctx->cur_folio) {
> +		iomap_read_remove_bias(ctx->cur_folio, cur_folio_owned);
> +		if (!cur_folio_owned)
> +			folio_unlock(ctx->cur_folio);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 
> 

