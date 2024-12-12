Return-Path: <linux-fsdevel+bounces-37212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD79EF9EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DB7188FD5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752E225409;
	Thu, 12 Dec 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjo/Ecdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098522370C;
	Thu, 12 Dec 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025728; cv=none; b=E50uWEOKR3+wo3RiCG4ref73qQLmXOAU4S8x7agOSZtfqXRva16pgUv+gyBo57+wucJvNUabciylxDuoszyvmJ5QgE9p8X3mVORXluFcOWz5tCBWvJalMDp1l249gbdn0UGsrd0Rle7zcJT22baBdlRdomV5niQbj3IvEJPjjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025728; c=relaxed/simple;
	bh=q2YICqpppTqdDJf64AAhY+bAjgqPYCSV1BdyiWmJNu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEXyGiNUmzvHWjxS6WaigbU9Sbn7r0VPAoVWbW8NT+yoWtU/4XMgvWRLAENfoOPWV0XxNfvQUlTBFskNxJNjAJbzbj+x/Z9TLv1BacOD4i2u23Chs+sB1f7b3yMPV+C+M6mEfmPFuxXX67g5I6gXNLIIB/LzMVm6ocWgj0TDOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjo/Ecdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21A2C4CED0;
	Thu, 12 Dec 2024 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734025727;
	bh=q2YICqpppTqdDJf64AAhY+bAjgqPYCSV1BdyiWmJNu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bjo/EcdfWRYD0es85vfW8YLTYJKSP5OqCSxWMNyaHuyiPKEIliQiK9p+kvzUYmLR2
	 EZ6ws9v+e/pGpYJ+Ju4rDdA45LtRAVQ7N6utilu/X6dcXpkYI25KBk2jlgpj7AkpaF
	 J+erQB2XjeupXJBwEPPRah2ay8tC2A111tStHx72/S6a/4t2UtV8+ldzvtSJ310oEd
	 YcFCA3Gn3+ToMsXuf8kYDIapYDRgh+1Qcv2H3wZtWaAWm5lbhQcEVrfExXdRFTRmEQ
	 8y/d1377pYzFtXx9sB4HuzbXT0Mg/vrgiNHsnOO3HZd+Oh+Zy+WYFqPxY3BWKfzXNq
	 dxi8VkZH1+rJA==
Date: Thu, 12 Dec 2024 09:48:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/8] iomap: allow the file system to submit the writeback
 bios
Message-ID: <20241212174847.GE6678@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-2-hch@lst.de>

On Wed, Dec 11, 2024 at 09:53:41AM +0100, Christoph Hellwig wrote:
> Change ->prepare_ioend to ->submit_ioend and require file systems that
> implement it to submit the bio.  This is needed for file systems that
> do their own work on the bios before submitting them to the block layer
> like btrfs or zoned xfs.  To make this easier also pass the writeback
> context to the method.

The code changes here are pretty straightforward, but please update
Documentation/filesystems/iomap/operations.rst to reflect the new name
and the new "submit the bio yourself" behavior expected of the
implementation.

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  fs/xfs/xfs_aops.c      | 13 +++++++++----
>  include/linux/iomap.h  | 12 +++++++-----
>  3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 955f19e27e47..cdccf11bb3be 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1675,7 +1675,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
>  }
>  
>  /*
> - * Submit the final bio for an ioend.
> + * Submit an ioend.
>   *
>   * If @error is non-zero, it means that we have a situation where some part of
>   * the submission process has failed after we've marked pages for writeback.
> @@ -1694,14 +1694,14 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
>  	 * failure happened so that the file system end I/O handler gets called
>  	 * to clean up.
>  	 */
> -	if (wpc->ops->prepare_ioend)
> -		error = wpc->ops->prepare_ioend(wpc->ioend, error);
> +	if (wpc->ops->submit_ioend)
> +		error = wpc->ops->submit_ioend(wpc, error);
> +	else if (!error)
> +		submit_bio(&wpc->ioend->io_bio);
>  
>  	if (error) {
>  		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
>  		bio_endio(&wpc->ioend->io_bio);
> -	} else {
> -		submit_bio(&wpc->ioend->io_bio);
>  	}
>  
>  	wpc->ioend = NULL;
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 559a3a577097..d175853da5ae 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -395,10 +395,11 @@ xfs_map_blocks(
>  }
>  
>  static int
> -xfs_prepare_ioend(
> -	struct iomap_ioend	*ioend,
> +xfs_submit_ioend(
> +	struct iomap_writepage_ctx *wpc,
>  	int			status)
>  {
> +	struct iomap_ioend	*ioend = wpc->ioend;
>  	unsigned int		nofs_flag;
>  
>  	/*
> @@ -420,7 +421,11 @@ xfs_prepare_ioend(
>  	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
>  	    (ioend->io_flags & IOMAP_F_SHARED))
>  		ioend->io_bio.bi_end_io = xfs_end_bio;
> -	return status;
> +
> +	if (status)
> +		return status;
> +	submit_bio(&ioend->io_bio);
> +	return 0;
>  }
>  
>  /*
> @@ -462,7 +467,7 @@ xfs_discard_folio(
>  
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
>  	.map_blocks		= xfs_map_blocks,
> -	.prepare_ioend		= xfs_prepare_ioend,
> +	.submit_ioend		= xfs_submit_ioend,
>  	.discard_folio		= xfs_discard_folio,
>  };
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5675af6b740c..c0339678d798 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -362,12 +362,14 @@ struct iomap_writeback_ops {
>  			  loff_t offset, unsigned len);
>  
>  	/*
> -	 * Optional, allows the file systems to perform actions just before
> -	 * submitting the bio and/or override the bio end_io handler for complex
> -	 * operations like copy on write extent manipulation or unwritten extent
> -	 * conversions.
> +	 * Optional, allows the file systems to hook into bio submission,
> +	 * including overriding the bi_end_io handler.
> +	 *
> +	 * Returns 0 if the bio was successfully submitted, or a negative
> +	 * error code if status was non-zero or another error happened and
> +	 * the bio could not be submitted.
>  	 */
> -	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
> +	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
>  
>  	/*
>  	 * Optional, allows the file system to discard state on a page where
> -- 
> 2.45.2
> 
> 

