Return-Path: <linux-fsdevel+bounces-62180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B7B873BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7185A3B7823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5630DD14;
	Thu, 18 Sep 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAHOXEOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FC306D47;
	Thu, 18 Sep 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234621; cv=none; b=XbCy79QMAKitQ8xmZoXnWw8k5Vdz23eH6KOCcaO233k1FaSiMx3g/7Yo4bF+kteD+7iKuVRf1IBI1n0ldaob0YD4UpZIMRQzaU1GYz/UErUcwPQaUOTkIpwPckwp1+dQiYAT4OxGx1E/g8x96lF/p7f4jNoymN8wWM9T8pYrf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234621; c=relaxed/simple;
	bh=7Bl1V2o/RMjdnd2WG+3hxDxqvKlTqca40A7h0y6talg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEw7PFOKX9DTYzESf1mRkd8L0ygnXHBC80uG4TX8jqIPeCERpm57ax4JRootIxe37GKsUX4q3/ufYUUNDl8yRP/dh4jv9pTHy3jHwt53ZiDtjKQYR2Enu5s7ICUm/jRylVw5e4XdwV/K8C374DkLMbxgQXHQhGfVW4q1nR1fyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAHOXEOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79216C4CEE7;
	Thu, 18 Sep 2025 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758234619;
	bh=7Bl1V2o/RMjdnd2WG+3hxDxqvKlTqca40A7h0y6talg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAHOXEOjeKvnm1VefaotNFOexkCo4x4lgpYCptWVG5OOAQ119fDJKR4pTqvhLr2S6
	 YhNllpwQ2k3ti8rsdxw0gpHGcx/vg2UKFFR+S9S8O2GRhdlw50Cyl/neS01GOJrfqh
	 HDHh65YuVt1hI7RxBxU/4SXtxAWQkGnH99G4Jb2K0s2krNZ4qtWVKX6ezOCOvWfKgq
	 M0RV09See1lljTjRzluFYvNpRi0SFYH9vwXPVqRFBQUQw803f/SFt1Vg6XN/ADtsMO
	 52FDv4Dmqbzayx3hbLRXmPsQTsO11xs28vdacnnGjS/urjFikw86f+UfsPfsYdtLmW
	 9PgUS7RjEYInQ==
Date: Thu, 18 Sep 2025 15:30:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
Message-ID: <20250918223018.GY1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-11-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:20PM -0700, Joanne Koong wrote:
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
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 55 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 561378f2b9bb..667a49cb5ae5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,38 @@ const struct iomap_read_ops iomap_bio_read_ops = {
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
> +static void iomap_read_add_bias(struct folio *folio)
> +{
> +	iomap_start_folio_read(folio, 1);

I wonder, could you achieve the same effect by elevating
read_bytes_pending by the number of bytes that we think we have to read,
and subtracting from it as the completions come in or we decide that no
read is necessary?

(That might just be overthinking the plumbing though)

--D

> +}
> +
> +static void iomap_read_remove_bias(struct folio *folio, bool *cur_folio_owned)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	bool finished, uptodate;
> +
> +	if (ifs) {
> +		spin_lock_irq(&ifs->state_lock);
> +		ifs->read_bytes_pending -= 1;
> +		finished = !ifs->read_bytes_pending;
> +		if (finished)
> +			uptodate = ifs_is_fully_uptodate(folio, ifs);
> +		spin_unlock_irq(&ifs->state_lock);
> +		if (finished)
> +			folio_end_read(folio, uptodate);
> +		*cur_folio_owned = true;
> +	}
> +}
> +
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
>  {
> @@ -429,7 +461,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  	struct folio *folio = ctx->cur_folio;
>  	size_t poff, plen;
>  	loff_t delta;
> -	int ret;
> +	int ret = 0;
>  
>  	if (iomap->type == IOMAP_INLINE) {
>  		ret = iomap_read_inline_data(iter, folio);
> @@ -441,6 +473,8 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  	/* zero post-eof blocks as the page may be mapped */
>  	ifs_alloc(iter->inode, folio, iter->flags);
>  
> +	iomap_read_add_bias(folio);
> +
>  	length = min_t(loff_t, length,
>  			folio_size(folio) - offset_in_folio(folio, pos));
>  	while (length) {
> @@ -448,16 +482,18 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  				&plen);
>  
>  		delta = pos - iter->pos;
> -		if (WARN_ON_ONCE(delta + plen > length))
> -			return -EIO;
> +		if (WARN_ON_ONCE(delta + plen > length)) {
> +			ret = -EIO;
> +			break;
> +		}
>  		length -= delta + plen;
>  
>  		ret = iomap_iter_advance(iter, &delta);
>  		if (ret)
> -			return ret;
> +			break;
>  
>  		if (plen == 0)
> -			return 0;
> +			break;
>  
>  		if (iomap_block_needs_zeroing(iter, pos)) {
>  			folio_zero_range(folio, poff, plen);
> @@ -466,16 +502,19 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			*cur_folio_owned = true;
>  			ret = ctx->ops->read_folio_range(iter, ctx, plen);
>  			if (ret)
> -				return ret;
> +				break;
>  		}
>  
>  		delta = plen;
>  		ret = iomap_iter_advance(iter, &delta);
>  		if (ret)
> -			return ret;
> +			break;
>  		pos = iter->pos;
>  	}
> -	return 0;
> +
> +	iomap_read_remove_bias(folio, cur_folio_owned);
> +
> +	return ret;
>  }
>  
>  int iomap_read_folio(const struct iomap_ops *ops,
> -- 
> 2.47.3
> 
> 

