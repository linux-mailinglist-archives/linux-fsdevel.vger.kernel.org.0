Return-Path: <linux-fsdevel+bounces-54298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED05AFD740
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940C116C8CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A452225A37;
	Tue,  8 Jul 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPEPzXlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5B221265;
	Tue,  8 Jul 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003660; cv=none; b=QlCBRWlWC/pm16jZGFcj+//jt/0KC8WQKJEJBMD5ZA8TgNdfyYc3fQxIetMyrC1iuY66eoapx0MmeO9K39jr1v/O39huFT5KTjFkDAdEFrbiXTVfcm5vzQ9+5pejFyivKuN1KPq4fVp2d0oiLWHlB7bHG/vO2B2hfeUaSpVKk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003660; c=relaxed/simple;
	bh=b2koz8FETPcTd13fonjv9SujYB86acp1cwWcpb7Tcrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH+nU3CTOzX2Qb3s9A7+Kvk4R6Diy6vGblrwCIB5bSaync0uF3HIDtiPD9yPv5C974/0w9UujjCB8JN1zBtmwBFyikaVgIEC0YZtnrUB6p9k+DIvvrukCegRxvDtlr6LNjOlOp8JwqRO8hamhNS+Cj2sq/pzk/BJWc73jYjC66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPEPzXlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57893C4CEED;
	Tue,  8 Jul 2025 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003660;
	bh=b2koz8FETPcTd13fonjv9SujYB86acp1cwWcpb7Tcrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPEPzXlJtMnbOLUYAq/jgDnIi4/gCZp7h20nGbGk6kayupMuJJOVeudVy5lZ92QWe
	 8N5MPuzD1ZLMS2iPwa11v624W4FJ4d2RvSth6R8twpAhFi6tGOwZA1W+8RZ/2rwR4S
	 AOz9K8rmlKaXpNExc6coZwij5hCE7WoYtx7m2Podfb79TNVdXGX8Nc6wgCGPludK7B
	 KQ6PxF37FZAuJiBuhKPd7PO6xoyCJvkLsdTVfh8SNG/XYp0Wl+rFL4eUDyh3GikAe5
	 ErtMICIQCHPU446Z6fwh1HiW04/F8mm5RerS4Oq+q1j//ThosAZqv7R0cOIljvoke+
	 NIqlsNn3UQB6A==
Date: Tue, 8 Jul 2025 12:40:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 12/14] iomap: improve argument passing to
 iomap_read_folio_sync
Message-ID: <20250708194059.GB2672049@frogsfrogsfrogs>
References: <20250708135132.3347932-1-hch@lst.de>
 <20250708135132.3347932-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708135132.3347932-13-hch@lst.de>

On Tue, Jul 08, 2025 at 03:51:18PM +0200, Christoph Hellwig wrote:
> Pass the iomap_iter and derive the map inside iomap_read_folio_sync
> instead of in the caller, and use the more descriptive srcmap name for
> the source iomap.  Stop passing the offset into folio argument as it
> can be derived from the folio and the file offset.  Rename the
> variables for the offset into the file and the length to be more
> descriptive and match the rest of the code.
> 
> Rename the function itself to iomap_read_folio_range to make the use
> more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Much clearer, thank you!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b04c00dd6768..c73048062cb1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -657,22 +657,22 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  					 pos + len - 1);
>  }
>  
> -static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> -		size_t poff, size_t plen, const struct iomap *iomap)
> +static int iomap_read_folio_range(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len)
>  {
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct bio_vec bvec;
>  	struct bio bio;
>  
> -	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
> -	bio_add_folio_nofail(&bio, folio, plen, poff);
> +	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> +	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
>  	return submit_bio_wait(&bio);
>  }
>  
>  static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
>  		struct folio *folio)
>  {
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_folio_state *ifs;
>  	loff_t pos = iter->pos;
>  	loff_t block_size = i_blocksize(iter->inode);
> @@ -721,8 +721,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
>  			if (iter->flags & IOMAP_NOWAIT)
>  				return -EAGAIN;
>  
> -			status = iomap_read_folio_sync(block_start, folio,
> -					poff, plen, srcmap);
> +			status = iomap_read_folio_range(iter, folio,
> +					block_start, plen);
>  			if (status)
>  				return status;
>  		}
> -- 
> 2.47.2
> 
> 

