Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A994E2FDA48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbhATT4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbhATSn5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:43:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82A0220575;
        Wed, 20 Jan 2021 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168119;
        bh=e4bbHWEnKxiFttJ49RuoAstviJoZaF5D6DRfcaP2NwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5LCWhLp+65kkIhMR8LRsWAXvr2jQAzUsP7rLZTIi0Kv7MFhCt0WoMYEQYlcf68FY
         am2igzb1iT0yDpEvfp93InsrWS5YxTaIDfoF+6WBr813d5I7ZNDDQCsahd8CGeULCH
         X7PJaZeshVT2GBgaWj307mcZbOYxnMSXvhuzbIzSGCippiheWUw0BvXSTDc1enDYVj
         WaQGzb7le5fQwrCkVjjoYe3TWJcNLrfABxbtq3oGmNNvHVKkPaO0QdgHGFxIuXBAPT
         05VdAb7soQG8QW0juEXOJvuVFMCYg65SwMzPYN/e9+1I7OnCw1T7xsk8HDTZDUe9WW
         Etb82qJ+OZSHA==
Date:   Wed, 20 Jan 2021 10:41:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 01/11] xfs: factor out a xfs_ilock_iocb helper
Message-ID: <20210120184159.GC3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:06PM +0100, Christoph Hellwig wrote:
> Add a helper to factor out the nowait locking logical for the read/write
> helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Looks pretty straightforward,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 55 +++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5b0f93f738372d..c441cddfa4acbc 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -197,6 +197,23 @@ xfs_file_fsync(
>  	return error;
>  }
>  
> +static int
> +xfs_ilock_iocb(
> +	struct kiocb		*iocb,
> +	unsigned int		lock_mode)
> +{
> +	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!xfs_ilock_nowait(ip, lock_mode))
> +			return -EAGAIN;
> +	} else {
> +		xfs_ilock(ip, lock_mode);
> +	}
> +
> +	return 0;
> +}
> +
>  STATIC ssize_t
>  xfs_file_dio_aio_read(
>  	struct kiocb		*iocb,
> @@ -213,12 +230,9 @@ xfs_file_dio_aio_read(
>  
>  	file_accessed(iocb->ki_filp);
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
> -			return -EAGAIN;
> -	} else {
> -		xfs_ilock(ip, XFS_IOLOCK_SHARED);
> -	}
> +	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
> +	if (ret)
> +		return ret;
>  	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
>  			is_sync_kiocb(iocb));
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
> @@ -240,13 +254,9 @@ xfs_file_dax_read(
>  	if (!count)
>  		return 0; /* skip atime */
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
> -			return -EAGAIN;
> -	} else {
> -		xfs_ilock(ip, XFS_IOLOCK_SHARED);
> -	}
> -
> +	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
> +	if (ret)
> +		return ret;
>  	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
> @@ -264,12 +274,9 @@ xfs_file_buffered_aio_read(
>  
>  	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
> -			return -EAGAIN;
> -	} else {
> -		xfs_ilock(ip, XFS_IOLOCK_SHARED);
> -	}
> +	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
> +	if (ret)
> +		return ret;
>  	ret = generic_file_read_iter(iocb, to);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
> @@ -608,13 +615,9 @@ xfs_file_dax_write(
>  	size_t			count;
>  	loff_t			pos;
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!xfs_ilock_nowait(ip, iolock))
> -			return -EAGAIN;
> -	} else {
> -		xfs_ilock(ip, iolock);
> -	}
> -
> +	ret = xfs_ilock_iocb(iocb, iolock);
> +	if (ret)
> +		return ret;
>  	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
> -- 
> 2.29.2
> 
