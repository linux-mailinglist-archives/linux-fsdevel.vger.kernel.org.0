Return-Path: <linux-fsdevel+bounces-51052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B6CAD2437
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6428188600C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B221ABB9;
	Mon,  9 Jun 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYX2M7vW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B12192F5;
	Mon,  9 Jun 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487121; cv=none; b=UFfw5oXIPoW8SPrAE2OiFYStpaAqZsvx+Z6vz9V4JS9mvN19W168KZRtjAg1QGwzFIQ1EjpwFwF9jB2e/qa1d7wZGhZwzP0R1M07nUDWSv4/aYIFsFXYn4SiCRiF/Iwm01EMieRH2uwyM70S+g/XawpEAsvMz5f/mZgZQf03/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487121; c=relaxed/simple;
	bh=n0oYnBYMgefR187kpSqOFBtyAmWgXDMh4P+5LW6w7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dha+tPPRB3Gp72z5r+cywDX3MQxLrZK4W0vK5gTewN0b0jFzeWfOHTi1+mYtlfv2fmzQIJ6sZjAjmQgPN7K9ovBjmN6Z2uIWHIaS9sMYMs6vrPFLG6CLz/Y0EiTct6nar+atF6IKS0G991UH46cT6Hsop17OTYCN/BWnR2ocZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYX2M7vW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506ECC4CEEB;
	Mon,  9 Jun 2025 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749487121;
	bh=n0oYnBYMgefR187kpSqOFBtyAmWgXDMh4P+5LW6w7dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYX2M7vWFpI8yxnrIvJ+T9Hal/aC1VO15GswnBqHmsyUU7cPFaHlJEydON5l9A521
	 Al0M5MFyu/spoDs7vGPgD90zXIY2al9p3JAO5LJAT6yYzI++YwfXKi4wESJv/fpq93
	 MSKVYKuivT3HzlJVQuBIh42JcYixgl5U/qyZKVhLCsZH3Pqkq8lT9uh1+59lPvLz2V
	 drt8JFwUUmGORR/RHe6W8AlGpTyM/jo6cZ7S8u6XRxk52ptXCHbeeGpOgcrP87573Z
	 CHO6yPbiHtWUMGryF4Qm8W++850DPhwKujKgcR1Cf8BB+/M5jrBw1ccAbrYawXzDcg
	 XCYE2KL3r4ihw==
Date: Mon, 9 Jun 2025 09:38:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 3/8] iomap: add buffered write support for
 IOMAP_IN_MEM iomaps
Message-ID: <20250609163840.GJ6156@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-4-joannelkoong@gmail.com>

On Fri, Jun 06, 2025 at 04:37:58PM -0700, Joanne Koong wrote:
> Add buffered write support for IOMAP_IN_MEM iomaps. This lets
> IOMAP_IN_MEM iomaps use some of the internal features in iomaps
> such as granular dirty tracking for large folios.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 24 +++++++++++++++++-------
>  include/linux/iomap.h  | 10 ++++++++++
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1caeb4921035..fd2ea1306d88 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -300,7 +300,7 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  
> -	return srcmap->type != IOMAP_MAPPED ||
> +	return (srcmap->type != IOMAP_MAPPED && srcmap->type != IOMAP_IN_MEM) ||
>  		(srcmap->flags & IOMAP_F_NEW) ||
>  		pos >= i_size_read(iter->inode);
>  }
> @@ -583,16 +583,26 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  					 pos + len - 1);
>  }
>  
> -static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> -		size_t poff, size_t plen, const struct iomap *iomap)
> +static int iomap_read_folio_sync(const struct iomap_iter *iter, loff_t block_start,
> +				 struct folio *folio, size_t poff, size_t plen)
>  {
> -	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, iomap);
> +	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +
> +	if (folio_ops && folio_ops->read_folio_sync)
> +		return folio_ops->read_folio_sync(block_start, folio,
> +						  poff, plen, srcmap,
> +						  iter->private);

Hmm, patch 6 hooks this up to fuse_do_readfolio, which means that iomap
provides the folios and manages their uptodate/dirty state.  You still
want fuse to handle the folio contents (aka poke the fuse server via
FUSE_READ/FUSE_WRITE), but this avoids the memcpy that IOMAP_INLINE
performs.

So I think you're effectively addding another IO path to buffered-io.c,
which explains why you moved the bio code to a separate file.  I wonder
if you could hook up this new IO path by checking for a non-NULL
->read_folio_sync function and calling it regardless of iomap::type?

--D

> +
> +	/* IOMAP_IN_MEM iomaps must always handle ->read_folio_sync() */
> +	WARN_ON_ONCE(iter->iomap.type == IOMAP_IN_MEM);
> +
> +	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, srcmap);
>  }
>  
>  static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  		size_t len, struct folio *folio)
>  {
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_folio_state *ifs;
>  	loff_t block_size = i_blocksize(iter->inode);
>  	loff_t block_start = round_down(pos, block_size);
> @@ -640,8 +650,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  			if (iter->flags & IOMAP_NOWAIT)
>  				return -EAGAIN;
>  
> -			status = iomap_read_folio_sync(block_start, folio,
> -					poff, plen, srcmap);
> +			status = iomap_read_folio_sync(iter, block_start, folio,
> +						       poff, plen);
>  			if (status)
>  				return status;
>  		}
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index dbbf217eb03f..e748aeebe1a5 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -175,6 +175,16 @@ struct iomap_folio_ops {
>  	 * locked by the iomap code.
>  	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +
> +	/*
> +	 * Required for IOMAP_IN_MEM iomaps. Otherwise optional if the caller
> +	 * wishes to handle reading in a folio.
> +	 *
> +	 * The read must be done synchronously.
> +	 */
> +	int (*read_folio_sync)(loff_t block_start, struct folio *folio,
> +			       size_t off, size_t len, const struct iomap *iomap,
> +			       void *private);
>  };
>  
>  /*
> -- 
> 2.47.1
> 
> 

