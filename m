Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535D92FDA45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbhATT4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbhATSn5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:43:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D51CE23406;
        Wed, 20 Jan 2021 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168179;
        bh=f9XPtkNLkl6mprDCw0aNyTt9doPwDAylSvz4TPKHFDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIkWZHlbXvc3zfX+crcjhBX9A+7p5Z0ZnHWKe+PTXryMn5s4KSUlAjlvTReUXG4Hl
         VrWFtz/jexbMt6Bi4Rjo+M+WFPqkYfQl1VN2QwFzXE1cnHG62PN0cHqJ5G6Ui64jjc
         cOZD3Tm7WcT1GDM6JxjpF7SJ9L3Uq4b8EuaI/y8s6iP8LQO+vvXE3cY3LJPbvEgM7g
         +We/xz9BWvNnR/9D7M1avd0uwSp6IZ4saXuKBKYC6uxZZMGEB/XPZjoj0CX5TQf2FH
         /iSGnm0t+Vw97hqEs0n1c7vqh2Vd2vljSmLo300cs8w5WlO/I/l3wNWX/3o04R78Um
         Gu78R9fUQoorA==
Date:   Wed, 20 Jan 2021 10:42:58 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 02/11] xfs: make xfs_file_aio_write_checks
 IOCB_NOWAIT-aware
Message-ID: <20210120184258.GD3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:07PM +0100, Christoph Hellwig wrote:
> Ensure we don't block on the iolock, or waiting for I/O in
> xfs_file_aio_write_checks if the caller asked to avoid that.
> 
> Fixes: 29a5d29ec181 ("xfs: nowait aio support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index c441cddfa4acbc..fb4e6f2852bb8b 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -335,7 +335,14 @@ xfs_file_aio_write_checks(
>  	if (error <= 0)
>  		return error;
>  
> -	error = xfs_break_layouts(inode, iolock, BREAK_WRITE);
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		error = break_layout(inode, false);
> +		if (error == -EWOULDBLOCK)
> +			error = -EAGAIN;
> +	} else {
> +		error = xfs_break_layouts(inode, iolock, BREAK_WRITE);
> +	}
> +
>  	if (error)
>  		return error;
>  
> @@ -346,7 +353,11 @@ xfs_file_aio_write_checks(
>  	if (*iolock == XFS_IOLOCK_SHARED && !IS_NOSEC(inode)) {
>  		xfs_iunlock(ip, *iolock);
>  		*iolock = XFS_IOLOCK_EXCL;
> -		xfs_ilock(ip, *iolock);
> +		error = xfs_ilock_iocb(iocb, *iolock);
> +		if (error) {
> +			*iolock = 0;
> +			return error;
> +		}
>  		goto restart;
>  	}
>  	/*
> @@ -368,6 +379,10 @@ xfs_file_aio_write_checks(
>  	isize = i_size_read(inode);
>  	if (iocb->ki_pos > isize) {
>  		spin_unlock(&ip->i_flags_lock);
> +
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +
>  		if (!drained_dio) {
>  			if (*iolock == XFS_IOLOCK_SHARED) {
>  				xfs_iunlock(ip, *iolock);
> @@ -593,7 +608,8 @@ xfs_file_dio_aio_write(
>  			   &xfs_dio_write_ops,
>  			   is_sync_kiocb(iocb) || unaligned_io);
>  out:
> -	xfs_iunlock(ip, iolock);
> +	if (iolock)
> +		xfs_iunlock(ip, iolock);
>  
>  	/*
>  	 * No fallback to buffered IO after short writes for XFS, direct I/O
> @@ -632,7 +648,8 @@ xfs_file_dax_write(
>  		error = xfs_setfilesize(ip, pos, ret);
>  	}
>  out:
> -	xfs_iunlock(ip, iolock);
> +	if (iolock)
> +		xfs_iunlock(ip, iolock);
>  	if (error)
>  		return error;
>  
> -- 
> 2.29.2
> 
