Return-Path: <linux-fsdevel+bounces-67061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9AC33B5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F64F127B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9C1DE885;
	Wed,  5 Nov 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmQeFDSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED71DF273
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307459; cv=none; b=JcEwu8Dav0VgGtsIe30ND3XB6yl3Zvo8gVtOHBjVZ4wlkDa171AqV3F5lAJGwFBiJqoiP+TahvX1oqKuVUd4wkBHwhNO3p04AUn4wm/0pGEdwOnOY9yiDhimw5lMqjCG9n1DgDb/dm9entBZjQq/b7xjTs201PidLh1V/+ryXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307459; c=relaxed/simple;
	bh=H4d1fnVYWHmxahQsk2ql+400Kb53/sTDb2IlnvMqeIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyvR9HeHjMZiiJyjbhJJ0azQs7Rbg9cutXcBYQGfI2eT8r5Z/Vizn28WFzKDEYocek4lVlruOqLM9dJ6cjVVycNxUhVYNz/KKhoF/44OXl+8IUgUuhSFptJRtzkLoUTg4xvjDjttOcZRKH1sJMc3vf0YrQ6weFdcSnDgiIYOgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmQeFDSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F165C116B1;
	Wed,  5 Nov 2025 01:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762307459;
	bh=H4d1fnVYWHmxahQsk2ql+400Kb53/sTDb2IlnvMqeIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmQeFDSNwB2qAFYdC3LDJiPRr8NYuzcqqyJF2ksbe45l2B7z54mNQRShUZWJgQT7b
	 TL/qSRfjnHnq8+8eD5VK1XNH4ZGQr0o0I8Ddzvdlt3z15dSeBLq7W3151q28TNOIAx
	 mgmE3v3Ymh1sveYCYRpgoEggVLmmOjvOuKmDNDOqcWKIkg/UMXpVHWPXIegxf2ZxKx
	 VEYNPihMZdkvY0JAE0SDaJaw3r9TI5oNeZTyHjtw2DPsBhQn11hwYh++oGv5Vgc4VL
	 XGkUqGzyT0zPh4qEkNRZ2tHCEjZ8BvM7dOAuXdqY7v5avsUFtVYkS/B2nFCU5vlsiX
	 Qcp7kTa8vsBxQ==
Date: Tue, 4 Nov 2025 17:50:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 4/8] iomap: simplify ->read_folio_range() error
 handling for reads
Message-ID: <20251105015058.GJ196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-5-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:15PM -0800, Joanne Koong wrote:
> Instead of requiring that the caller calls iomap_finish_folio_read()
> even if the ->read_folio_range() callback returns an error, account for
> this internally in iomap instead, which makes the interface simpler and
> makes it match writeback's ->read_folio_range() error handling
> expectations.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  7 +++--
>  fs/fuse/file.c                                | 10 ++-----
>  fs/iomap/buffered-io.c                        | 27 +++++++++----------
>  include/linux/iomap.h                         |  5 ++--
>  4 files changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 4d30723be7fa..64f4baf5750e 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -149,10 +149,9 @@ These ``struct kiocb`` flags are significant for buffered I/O with iomap:
>  iomap calls these functions:
>  
>    - ``read_folio_range``: Called to read in the range. This must be provided
> -    by the caller. The caller is responsible for calling
> -    iomap_finish_folio_read() after reading in the folio range. This should be
> -    done even if an error is encountered during the read. This returns 0 on
> -    success or a negative error on failure.
> +    by the caller. If this succeeds, iomap_finish_folio_read() must be called
> +    after the range is read in, regardless of whether the read succeeded or
> +    failed.
>  
>    - ``submit_read``: Submit any pending read requests. This function is
>      optional.
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b343a6f37563..7bcb650a9f26 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -922,13 +922,6 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>  
>  	if (ctx->rac) {
>  		ret = fuse_handle_readahead(folio, ctx->rac, data, pos, len);
> -		/*
> -		 * If fuse_handle_readahead was successful, fuse_readpages_end
> -		 * will do the iomap_finish_folio_read, else we need to call it
> -		 * here
> -		 */
> -		if (ret)
> -			iomap_finish_folio_read(folio, off, len, ret);
>  	} else {
>  		/*
>  		 *  for non-readahead read requests, do reads synchronously
> @@ -936,7 +929,8 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>  		 *  out-of-order reads
>  		 */
>  		ret = fuse_do_readfolio(file, folio, off, len);
> -		iomap_finish_folio_read(folio, off, len, ret);
> +		if (!ret)
> +			iomap_finish_folio_read(folio, off, len, ret);
>  	}
>  	return ret;
>  }
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e3171462ba08..0f14d2a91f49 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -398,7 +398,8 @@ static void iomap_read_init(struct folio *folio)
>  		 * finished reading in the entire folio.
>  		 */
>  		spin_lock_irq(&ifs->state_lock);
> -		ifs->read_bytes_pending += len + 1;
> +		WARN_ON_ONCE(ifs->read_bytes_pending != 0);
> +		ifs->read_bytes_pending = len + 1;
>  		spin_unlock_irq(&ifs->state_lock);
>  	}
>  }
> @@ -414,19 +415,8 @@ static void iomap_read_init(struct folio *folio)
>   */
>  static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>  {
> -	struct iomap_folio_state *ifs;
> -
> -	/*
> -	 * If there are no bytes submitted, this means we are responsible for
> -	 * unlocking the folio here, since no IO helper has taken ownership of
> -	 * it.
> -	 */
> -	if (!bytes_submitted) {
> -		folio_unlock(folio);
> -		return;
> -	}
> +	struct iomap_folio_state *ifs = folio->private;
>  
> -	ifs = folio->private;
>  	if (ifs) {
>  		bool end_read, uptodate;
>  		/*
> @@ -451,6 +441,15 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>  		spin_unlock_irq(&ifs->state_lock);
>  		if (end_read)
>  			folio_end_read(folio, uptodate);
> +	} else if (!bytes_submitted) {
> +		/*
> +		 * If there were no bytes submitted, this means we are
> +		 * responsible for unlocking the folio here, since no IO helper
> +		 * has taken ownership of it. If there were bytes submitted,
> +		 * then the IO helper will end the read via
> +		 * iomap_finish_folio_read().
> +		 */
> +		folio_unlock(folio);
>  	}
>  }
>  
> @@ -498,10 +497,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		} else {
>  			if (!*bytes_submitted)
>  				iomap_read_init(folio);
> -			*bytes_submitted += plen;
>  			ret = ctx->ops->read_folio_range(iter, ctx, plen);
>  			if (ret)
>  				return ret;
> +			*bytes_submitted += plen;

Hrmm.  Is this the main change of this patch?  We don't increment
bytes_submitted if ->read_folio_range returns an error, which then means
that fuse doesn't have to call iomap_finish_folio_read to decrement
*bytes_submitted?

(and apparently the bio read_folio_range can't fail so no changes are
needed there)

--D

>  		}
>  
>  		ret = iomap_iter_advance(iter, plen);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b49e47f069db..520e967cb501 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -495,9 +495,8 @@ struct iomap_read_ops {
>  	/*
>  	 * Read in a folio range.
>  	 *
> -	 * The caller is responsible for calling iomap_finish_folio_read() after
> -	 * reading in the folio range. This should be done even if an error is
> -	 * encountered during the read.
> +	 * If this succeeds, iomap_finish_folio_read() must be called after the
> +	 * range is read in, regardless of whether the read succeeded or failed.
>  	 *
>  	 * Returns 0 on success or a negative error on failure.
>  	 */
> -- 
> 2.47.3
> 
> 

