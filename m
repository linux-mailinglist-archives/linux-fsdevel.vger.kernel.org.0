Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B22FBB23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391504AbhASP1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 10:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390832AbhASPZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611069842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG4O0ujJn/mAWAXt6JtUbPmD4HQVxe9/zEf8ebvAMU0=;
        b=Pk5EJ5texvXgwhbI4mcHYep1BaTyO8FnOWNgzZxlgYr2wzN19njOSPV60M563d+wfSMF9j
        I/0T4+pvuMKIRxOh6k1lTzH5twUVmMJIv4cEf0SuL4Op+5SoLLWTJRJILOHWQ00kX/PxUz
        Yhtwa9VeSmTvphtkx2kUoVWLAYRy+9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-bLE8l5WvOxu03FRy1cUT1A-1; Tue, 19 Jan 2021 10:24:00 -0500
X-MC-Unique: bLE8l5WvOxu03FRy1cUT1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31FE384E242;
        Tue, 19 Jan 2021 15:23:59 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AAE169320;
        Tue, 19 Jan 2021 15:23:58 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:23:56 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 09/11] iomap: pass a flags argument to iomap_dio_rw
Message-ID: <20210119152356.GI1646807@bfoster>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-10-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:14PM +0100, Christoph Hellwig wrote:
> Pass a set of flags to iomap_dio_rw instead of the boolean
> wait_for_completion argument.  The IOMAP_DIO_FORCE_WAIT flag
> replaces the wait_for_completion, but only needs to be passed
> when the iocb isn't synchronous to start with to simplify the
> callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/btrfs/file.c       |  7 +++----
>  fs/ext4/file.c        |  5 ++---
>  fs/gfs2/file.c        |  7 ++-----
>  fs/iomap/direct-io.c  | 11 +++++------
>  fs/xfs/xfs_file.c     |  7 +++----
>  fs/zonefs/super.c     |  4 ++--
>  include/linux/iomap.h | 10 ++++++++--
>  7 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0e41459b8de667..ddfd2e2adedf58 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1949,8 +1949,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  		goto buffered;
>  	}
>  
> -	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
> -			     &btrfs_dio_ops, is_sync_kiocb(iocb));
> +	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> +			     0);
>  
>  	btrfs_inode_unlock(inode, ilock_flags);
>  
> @@ -3622,8 +3622,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  		return 0;
>  
>  	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
> -	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			   is_sync_kiocb(iocb));
> +	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops, 0);
>  	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>  	return ret;
>  }
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 349b27f0dda0cb..194f5d00fa3267 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -74,8 +74,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		return generic_file_read_iter(iocb, to);
>  	}
>  
> -	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
> -			   is_sync_kiocb(iocb));
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0);
>  	inode_unlock_shared(inode);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -550,7 +549,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (ilock_shared)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> -			   is_sync_kiocb(iocb) || unaligned_io || extend);
> +			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>  
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index b39b339feddc93..89609c2997177a 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -797,9 +797,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
>  	if (ret)
>  		goto out_uninit;
>  
> -	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
> -			   is_sync_kiocb(iocb));
> -
> +	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
>  	gfs2_glock_dq(gh);
>  out_uninit:
>  	gfs2_holder_uninit(gh);
> @@ -833,8 +831,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
>  	if (offset + len > i_size_read(&ip->i_inode))
>  		goto out;
>  
> -	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
> -			   is_sync_kiocb(iocb));
> +	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>  out:
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 604103ab76f9c5..32dbbf7dd4aadb 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -420,13 +420,15 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  struct iomap_dio *
>  __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		bool wait_for_completion)
> +		unsigned int dio_flags)
>  {
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	size_t count = iov_iter_count(iter);
>  	loff_t pos = iocb->ki_pos;
>  	loff_t end = iocb->ki_pos + count - 1, ret = 0;
> +	bool wait_for_completion =
> +		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
>  	unsigned int iomap_flags = IOMAP_DIRECT;
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
> @@ -434,9 +436,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (!count)
>  		return NULL;
>  
> -	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
> -		return ERR_PTR(-EIO);
> -
>  	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
>  	if (!dio)
>  		return ERR_PTR(-ENOMEM);
> @@ -598,11 +597,11 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		bool wait_for_completion)
> +		unsigned int flags)
>  {
>  	struct iomap_dio *dio;
>  
> -	dio = __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);
> +	dio = __iomap_dio_rw(iocb, iter, ops, dops, flags);
>  	if (IS_ERR_OR_NULL(dio))
>  		return PTR_ERR_OR_ZERO(dio);
>  	return iomap_dio_complete(dio);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index bffd7240cefb7f..b181db42f2f32f 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -232,8 +232,7 @@ xfs_file_dio_read(
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
>  		return ret;
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
> -			is_sync_kiocb(iocb));
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -535,7 +534,7 @@ xfs_file_dio_write_aligned(
>  	}
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, is_sync_kiocb(iocb));
> +			   &xfs_dio_write_ops, 0);
>  out_unlock:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> @@ -603,7 +602,7 @@ xfs_file_dio_write_unaligned(
>  	 */
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, true);
> +			   &xfs_dio_write_ops, IOMAP_DIO_FORCE_WAIT);
>  out_unlock:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index bec47f2d074beb..0e7ab0bc00ae8e 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -780,7 +780,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  		ret = zonefs_file_dio_append(iocb, from);
>  	else
>  		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
> -				   &zonefs_write_dio_ops, sync);
> +				   &zonefs_write_dio_ops, 0);
>  	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
>  	    (ret > 0 || ret == -EIOCBQUEUED)) {
>  		if (ret > 0)
> @@ -917,7 +917,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		}
>  		file_accessed(iocb->ki_filp);
>  		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
> -				   &zonefs_read_dio_ops, is_sync_kiocb(iocb));
> +				   &zonefs_read_dio_ops, 0);
>  	} else {
>  		ret = generic_file_read_iter(iocb, to);
>  		if (ret == -EIO)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5bd3cac4df9cb4..b322598dc10ec0 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -256,12 +256,18 @@ struct iomap_dio_ops {
>  			struct bio *bio, loff_t file_offset);
>  };
>  
> +/*
> + * Wait for the I/O to complete in iomap_dio_rw even if the kiocb is not
> + * synchronous.
> + */
> +#define IOMAP_DIO_FORCE_WAIT	(1 << 0)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		bool wait_for_completion);
> +		unsigned int flags);
>  struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		bool wait_for_completion);
> +		unsigned int flags);
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
> -- 
> 2.29.2
> 

