Return-Path: <linux-fsdevel+bounces-53690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CBAF6067
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CA01C45F41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F8309DBF;
	Wed,  2 Jul 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax0VRZrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C82309A6F;
	Wed,  2 Jul 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478717; cv=none; b=b/HBQf2T9C3WnN0QzSmIjxBbl51IOoTcN+iCWG9JLrmdDecV5jl91EMFTjJjSdFgMRksJDyQHQARovf2KZfSSmQpmvcgFgEq0c6TPXiGchXx6IokU3RoMCL+ayvQhV0l0VImfshAyUBnhkD2MO3dXBRIXkHxDjhdQLvaTp5Jumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478717; c=relaxed/simple;
	bh=AroCB2V0g3NWGJzJs9h05rOXNy9tuygQRV0UcgOoX8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utQKlkH0KsD6hKBsWBvFq5LpHOWufKPi71fRSTORh1cAEzBxVNky//e8ZIThKP2EDpKswNYAVtrWUoV8vV4M+XHAWl1H7YjSihhB1H1MjDe0hc3n8rovaQCzmriituaIZhYVbPFIHGqKQOEGam59FgEskv5zYsxAzHBBLp3szRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax0VRZrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF18C4CEE7;
	Wed,  2 Jul 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478716;
	bh=AroCB2V0g3NWGJzJs9h05rOXNy9tuygQRV0UcgOoX8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ax0VRZrOc4RNV9bVOUKa86DiX5KOreLVa15lL3u/3SIQC8xstkLUbm2cAqb1RWq57
	 VVBZHjcp82VwQImnbyjnkTGnK5SKv5KhhFA+JBdbqcFQeIAnNlCw8tGSc/oEEYfR/A
	 ErSAmd3glwJzJWIrAwi8KbhfsB9wKCZVCvuo0NsJi7whY/QKTV+kX6c3PpNBW7SXi9
	 QcP1/pT7/ISq9fAe729Cb1ORVkFib1in1wcM6JSNWahLpeM6sXMu1UFA++rn79fV17
	 DH6PG5YGTw8h4OxaZk3BdNuWCj/Ug9nWaxewiIDJRy6mk1s4ooA5Lm2MbQvrJ4wnqn
	 INYFQYfsFVmjg==
Date: Wed, 2 Jul 2025 10:51:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 11/16] iomap: add read_folio_range() handler for
 buffered writes
Message-ID: <20250702175156.GE10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-12-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:30PM -0700, Joanne Koong wrote:
> Add a read_folio_range() handler for buffered writes that filesystems
> may pass in if they wish to provide a custom handler for synchronously
> reading in the contents of a folio.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> [hch: renamed to read_folio_range, pass less arguments]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  6 +++++
>  fs/iomap/buffered-io.c                        | 25 +++++++++++--------
>  include/linux/iomap.h                         | 10 ++++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 1f5732835567..813e26dbd21e 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -68,6 +68,8 @@ The following address space operations can be wrapped easily:
>       void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>                         struct folio *folio);
>       bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +     int (*read_folio_range)(const struct iomap_iter *iter,
> +     			struct folio *folio, loff_t pos, size_t len);
>   };
>  
>  iomap calls these functions:
> @@ -123,6 +125,10 @@ iomap calls these functions:
>      ``->iomap_valid``, then the iomap should considered stale and the
>      validation failed.
>  
> +  - ``read_folio_range``: Called to synchronously read in the range that will
> +    be written to. If this function is not provided, iomap will default to
> +    submitting a bio read request.

Excellent!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
>  These ``struct kiocb`` flags are significant for buffered I/O with iomap:
>  
>   * ``IOCB_NOWAIT``: Turns on ``IOMAP_NOWAIT``.
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f6e410c9ea7b..897a3ccea2df 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -667,22 +667,23 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
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
> -static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
> +static int __iomap_write_begin(const struct iomap_iter *iter,
> +		const struct iomap_write_ops *write_ops, size_t len,
>  		struct folio *folio)
>  {
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_folio_state *ifs;
>  	loff_t pos = iter->pos;
>  	loff_t block_size = i_blocksize(iter->inode);
> @@ -731,8 +732,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
>  			if (iter->flags & IOMAP_NOWAIT)
>  				return -EAGAIN;
>  
> -			status = iomap_read_folio_sync(block_start, folio,
> -					poff, plen, srcmap);
> +			if (write_ops && write_ops->read_folio_range)
> +				status = write_ops->read_folio_range(iter,
> +						folio, block_start, plen);
> +			else
> +				status = iomap_read_folio_range(iter,
> +						folio, block_start, plen);
>  			if (status)
>  				return status;
>  		}
> @@ -848,7 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
>  	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
>  	else
> -		status = __iomap_write_begin(iter, len, folio);
> +		status = __iomap_write_begin(iter, write_ops, len, folio);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8d20a926b645..5ec651606c51 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -166,6 +166,16 @@ struct iomap_write_ops {
>  	 * locked by the iomap code.
>  	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +
> +	/*
> +	 * Optional if the filesystem wishes to provide a custom handler for
> +	 * reading in the contents of a folio, otherwise iomap will default to
> +	 * submitting a bio read request.
> +	 *
> +	 * The read must be done synchronously.
> +	 */
> +	int (*read_folio_range)(const struct iomap_iter *iter,
> +			struct folio *folio, loff_t pos, size_t len);
>  };
>  
>  /*
> -- 
> 2.47.1
> 
> 

