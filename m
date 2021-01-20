Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD92FDA2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbhATTzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387544AbhATSoK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:44:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CFEF206CA;
        Wed, 20 Jan 2021 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168206;
        bh=bWqEu3H9M+Ga8TJW8rxQ//BM1cVoP5izthchvvZ0KMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X487uiYToio209BMhzQyMG1CO+qGtqY6tRjPmldr6RUgXX3brnJj0rRrFoyVaI7s/
         59AEGJ6BCcRWD/WUKPktVZwoWpK9Zv+eEHLVXVSFwEOeCFyQntFwYxR+60imA2sss3
         ptbnma3bFP2PpCSHdgpZf/z+mHR5WVsLW4oHQVW3avm5EII4tdSs0ebhwMHEvAFhYn
         8C5Y9GFFOjK65A5TiXQ42PlI64jzAX5ndMuHDSxPll5x9JEMAdDlnE78M8+vBdpbgv
         WKrk4+MEnD4unqkXx56qWs4ecHmWMkoFvUQHESum/sNXAe7oAZONrHgiEkB3o52Rss
         WWv0pkRRLFQMw==
Date:   Wed, 20 Jan 2021 10:43:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 03/11] xfs: cleanup the read/write helper naming
Message-ID: <20210120184325.GE3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:08PM +0100, Christoph Hellwig wrote:
> Drop a few pointless aio_ prefixes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Mmmm shortening!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index fb4e6f2852bb8b..ae7313ccaa11ed 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -215,7 +215,7 @@ xfs_ilock_iocb(
>  }
>  
>  STATIC ssize_t
> -xfs_file_dio_aio_read(
> +xfs_file_dio_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> @@ -265,7 +265,7 @@ xfs_file_dax_read(
>  }
>  
>  STATIC ssize_t
> -xfs_file_buffered_aio_read(
> +xfs_file_buffered_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> @@ -300,9 +300,9 @@ xfs_file_read_iter(
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
>  	else if (iocb->ki_flags & IOCB_DIRECT)
> -		ret = xfs_file_dio_aio_read(iocb, to);
> +		ret = xfs_file_dio_read(iocb, to);
>  	else
> -		ret = xfs_file_buffered_aio_read(iocb, to);
> +		ret = xfs_file_buffered_read(iocb, to);
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> @@ -317,7 +317,7 @@ xfs_file_read_iter(
>   * if called for a direct write beyond i_size.
>   */
>  STATIC ssize_t
> -xfs_file_aio_write_checks(
> +xfs_file_write_checks(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from,
>  	int			*iolock)
> @@ -502,7 +502,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
>  };
>  
>  /*
> - * xfs_file_dio_aio_write - handle direct IO writes
> + * xfs_file_dio_write - handle direct IO writes
>   *
>   * Lock the inode appropriately to prepare for and issue a direct IO write.
>   * By separating it from the buffered write path we remove all the tricky to
> @@ -527,7 +527,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
>   * negative return values.
>   */
>  STATIC ssize_t
> -xfs_file_dio_aio_write(
> +xfs_file_dio_write(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> @@ -549,7 +549,7 @@ xfs_file_dio_aio_write(
>  	/*
>  	 * Don't take the exclusive iolock here unless the I/O is unaligned to
>  	 * the file system block size.  We don't need to consider the EOF
> -	 * extension case here because xfs_file_aio_write_checks() will relock
> +	 * extension case here because xfs_file_write_checks() will relock
>  	 * the inode as necessary for EOF zeroing cases and fill out the new
>  	 * inode size as appropriate.
>  	 */
> @@ -580,7 +580,7 @@ xfs_file_dio_aio_write(
>  		xfs_ilock(ip, iolock);
>  	}
>  
> -	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
>  	count = iov_iter_count(from);
> @@ -590,7 +590,7 @@ xfs_file_dio_aio_write(
>  	 * in-flight at the same time or we risk data corruption. Wait for all
>  	 * other IO to drain before we submit. If the IO is aligned, demote the
>  	 * iolock if we had to take the exclusive lock in
> -	 * xfs_file_aio_write_checks() for other reasons.
> +	 * xfs_file_write_checks() for other reasons.
>  	 */
>  	if (unaligned_io) {
>  		inode_dio_wait(inode);
> @@ -634,7 +634,7 @@ xfs_file_dax_write(
>  	ret = xfs_ilock_iocb(iocb, iolock);
>  	if (ret)
>  		return ret;
> -	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
>  
> @@ -663,7 +663,7 @@ xfs_file_dax_write(
>  }
>  
>  STATIC ssize_t
> -xfs_file_buffered_aio_write(
> +xfs_file_buffered_write(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> @@ -682,7 +682,7 @@ xfs_file_buffered_aio_write(
>  	iolock = XFS_IOLOCK_EXCL;
>  	xfs_ilock(ip, iolock);
>  
> -	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>  	if (ret)
>  		goto out;
>  
> @@ -769,12 +769,12 @@ xfs_file_write_iter(
>  		 * CoW.  In all other directio scenarios we do not
>  		 * allow an operation to fall back to buffered mode.
>  		 */
> -		ret = xfs_file_dio_aio_write(iocb, from);
> +		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
>  	}
>  
> -	return xfs_file_buffered_aio_write(iocb, from);
> +	return xfs_file_buffered_write(iocb, from);
>  }
>  
>  static void
> -- 
> 2.29.2
> 
