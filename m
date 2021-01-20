Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2382FD977
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbhATTWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388705AbhATSpq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:45:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFBCE2065D;
        Wed, 20 Jan 2021 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168302;
        bh=H3SeZMBnKkU3+84kk5QxIo1jfTpWv+vd+FsMDUhvJ1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTvPnZDOU+hV8kX41/1xUoMQ1FGpL4H0mvkifTEKzngUeMT7HJ0R6rMirOiatna5m
         O8Jj2BgFB+ejU4NORWo78INdUvMQqfnuVJH2EC2MhfX0tlfPKRw3WbwBzAxXEaNB8s
         Z8MZnhU7wBO6i/EJhA0qvQTR9Av5GIfuAToFflMfqzBMoaer2mglhXJXMW44CIY00l
         lHsAyu/HugBYYG+yvHAJ2uIaXAe7auAUSHhsUamMuYUbnTCA9kLEtyxloksJH+ZV2D
         xY7cH8bRy24mJdrCo9G7MnaXRm2kmYFExt61iU8jjqOl59nl6crSY0jQzFnZvx/76A
         IfaO7MuubFpTQ==
Date:   Wed, 20 Jan 2021 10:45:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 05/11] xfs: simplify the read/write tracepoints
Message-ID: <20210120184501.GG3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:10PM +0100, Christoph Hellwig wrote:
> Pass the iocb and iov_iter to the tracepoints and leave decoding of
> actual arguments to the code only run when tracing is enabled.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

I've been thinking for a while that we really should be pushing
structure decoding and whatnot to the tracepoint code to keep it out of
the callers, so I like this:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c  | 20 ++++++++------------
>  fs/xfs/xfs_trace.h | 18 +++++++++---------
>  2 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 97836ec53397d4..aa64e78fc3c467 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -220,12 +220,11 @@ xfs_file_dio_read(
>  	struct iov_iter		*to)
>  {
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> -	size_t			count = iov_iter_count(to);
>  	ssize_t			ret;
>  
> -	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
> +	trace_xfs_file_direct_read(iocb, to);
>  
> -	if (!count)
> +	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
>  	file_accessed(iocb->ki_filp);
> @@ -246,12 +245,11 @@ xfs_file_dax_read(
>  	struct iov_iter		*to)
>  {
>  	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> -	size_t			count = iov_iter_count(to);
>  	ssize_t			ret = 0;
>  
> -	trace_xfs_file_dax_read(ip, count, iocb->ki_pos);
> +	trace_xfs_file_dax_read(iocb, to);
>  
> -	if (!count)
> +	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
> @@ -272,7 +270,7 @@ xfs_file_buffered_read(
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>  	ssize_t			ret;
>  
> -	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
> +	trace_xfs_file_buffered_read(iocb, to);
>  
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
> @@ -599,7 +597,7 @@ xfs_file_dio_write(
>  		iolock = XFS_IOLOCK_SHARED;
>  	}
>  
> -	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> +	trace_xfs_file_direct_write(iocb, from);
>  	/*
>  	 * If unaligned, this is the only IO in-flight. Wait on it before we
>  	 * release the iolock to prevent subsequent overlapping IO.
> @@ -622,7 +620,6 @@ xfs_file_dax_write(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	int			iolock = XFS_IOLOCK_EXCL;
>  	ssize_t			ret, error = 0;
> -	size_t			count;
>  	loff_t			pos;
>  
>  	ret = xfs_ilock_iocb(iocb, iolock);
> @@ -633,9 +630,8 @@ xfs_file_dax_write(
>  		goto out;
>  
>  	pos = iocb->ki_pos;
> -	count = iov_iter_count(from);
>  
> -	trace_xfs_file_dax_write(ip, count, pos);
> +	trace_xfs_file_dax_write(iocb, from);
>  	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
>  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
>  		i_size_write(inode, iocb->ki_pos);
> @@ -683,7 +679,7 @@ xfs_file_buffered_write(
>  	/* We can write back this queue in page reclaim */
>  	current->backing_dev_info = inode_to_bdi(inode);
>  
> -	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
> +	trace_xfs_file_buffered_write(iocb, from);
>  	ret = iomap_file_buffered_write(iocb, from,
>  			&xfs_buffered_write_iomap_ops);
>  	if (likely(ret >= 0))
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 5a263ae3d4f008..a6d04d860a565e 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1287,8 +1287,8 @@ TRACE_EVENT(xfs_log_assign_tail_lsn,
>  )
>  
>  DECLARE_EVENT_CLASS(xfs_file_class,
> -	TP_PROTO(struct xfs_inode *ip, size_t count, loff_t offset),
> -	TP_ARGS(ip, count, offset),
> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
> +	TP_ARGS(iocb, iter),
>  	TP_STRUCT__entry(
>  		__field(dev_t, dev)
>  		__field(xfs_ino_t, ino)
> @@ -1297,11 +1297,11 @@ DECLARE_EVENT_CLASS(xfs_file_class,
>  		__field(size_t, count)
>  	),
>  	TP_fast_assign(
> -		__entry->dev = VFS_I(ip)->i_sb->s_dev;
> -		__entry->ino = ip->i_ino;
> -		__entry->size = ip->i_d.di_size;
> -		__entry->offset = offset;
> -		__entry->count = count;
> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
> +		__entry->ino = XFS_I(file_inode(iocb->ki_filp))->i_ino;
> +		__entry->size = XFS_I(file_inode(iocb->ki_filp))->i_d.di_size;
> +		__entry->offset = iocb->ki_pos;
> +		__entry->count = iov_iter_count(iter);
>  	),
>  	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx count 0x%zx",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> @@ -1313,8 +1313,8 @@ DECLARE_EVENT_CLASS(xfs_file_class,
>  
>  #define DEFINE_RW_EVENT(name)		\
>  DEFINE_EVENT(xfs_file_class, name,	\
> -	TP_PROTO(struct xfs_inode *ip, size_t count, loff_t offset),	\
> -	TP_ARGS(ip, count, offset))
> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),		\
> +	TP_ARGS(iocb, iter))
>  DEFINE_RW_EVENT(xfs_file_buffered_read);
>  DEFINE_RW_EVENT(xfs_file_direct_read);
>  DEFINE_RW_EVENT(xfs_file_dax_read);
> -- 
> 2.29.2
> 
