Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC40400558
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350933AbhICSyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351269AbhICSyw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:54:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1408461051;
        Fri,  3 Sep 2021 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630695232;
        bh=nmWhUNMQR3hZroaQr4jgy+GDIFc+zeOl4mdCOJr1lbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX4IrgsY3Rjnb/gjA+Erw9nXWJ1hFrekn3inpWCxSdIpKDlGOC32dDW9h0HKOMFVX
         yUm7vMNz2JIE7YqOemA12d4ds8SPFWhrU+zXk+JcHQXUN98B5V9Hb25hk7Y6CpuBje
         XXj+xWD89+/JEbqBdt14/DXiww578nstfY2t4cn7GiQLpdgB/de0QWE1xU8roGx7mV
         8FwUZNqZNJQ5U4N6HmCtdgeqMpyjsAQh0usMunyVAU2LNbCUJk5I3anqGoQZpCag4e
         uE3aslQN31+867om4vwVPA5+/TBiMFpGXLb+KtvoBkP7tkG6M72ZeDV+OE7MAm6CFh
         O5Uw5/znR6ZUw==
Date:   Fri, 3 Sep 2021 11:53:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
Message-ID: <20210903185351.GD9892@magnolia>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-17-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-17-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:23PM +0200, Andreas Gruenbacher wrote:
> Add a done_before argument to iomap_dio_rw that indicates how much of
> the request has already been transferred.  When the request succeeds, we
> report that done_before additional bytes were tranferred.  This is
> useful for finishing a request asynchronously when part of the request
> has already been completed synchronously.
> 
> We'll use that to allow iomap_dio_rw to be used with page faults
> disabled: when a page fault occurs while submitting a request, we
> synchronously complete the part of the request that has already been
> submitted.  The caller can then take care of the page fault and call
> iomap_dio_rw again for the rest of the request, passing in the number of
> bytes already tranferred.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/btrfs/file.c       |  5 +++--
>  fs/ext4/file.c        |  5 +++--
>  fs/gfs2/file.c        |  4 ++--
>  fs/iomap/direct-io.c  | 11 ++++++++---
>  fs/xfs/xfs_file.c     |  6 +++---
>  fs/zonefs/super.c     |  4 ++--
>  include/linux/iomap.h |  4 ++--
>  7 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 281c77cfe91a..8817fe6b5fc0 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1945,7 +1945,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	}
>  
>  	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			     0);
> +			     0, 0);
>  
>  	btrfs_inode_unlock(inode, ilock_flags);
>  
> @@ -3637,7 +3637,8 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  		return 0;
>  
>  	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
> -	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops, 0);
> +	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> +			   0, 0);
>  	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>  	return ret;
>  }
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 816dedcbd541..4a5e7fd31fb5 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -74,7 +74,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		return generic_file_read_iter(iocb, to);
>  	}
>  
> -	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0);
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, 0);
>  	inode_unlock_shared(inode);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -566,7 +566,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (ilock_shared)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> -			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0);
> +			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
> +			   0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>  
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index fce3a5249e19..64bf2f68e6d6 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -822,7 +822,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
>  	if (ret)
>  		goto out_uninit;
>  
> -	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
> +	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0, 0);
>  	gfs2_glock_dq(gh);
>  out_uninit:
>  	gfs2_holder_uninit(gh);
> @@ -856,7 +856,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
>  	if (offset + len > i_size_read(&ip->i_inode))
>  		goto out;
>  
> -	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
> +	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>  out:
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ba88fe51b77a..dcf9a2b4381f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -31,6 +31,7 @@ struct iomap_dio {
>  	atomic_t		ref;
>  	unsigned		flags;
>  	int			error;
> +	size_t			done_before;

So, now that I actually understand the reason why the count of
previously transferred bytes has to be passed into the iomap_dio, I
would like this field to have a comment so that stupid maintainers like
me don't forget the subtleties again:

	/*
	 * For asynchronous IO, we have one chance to call the iocb
	 * completion method with the results of the directio operation.
	 * If this operation is a resubmission after a previous partial
	 * completion (e.g. page fault), we need to know about that
	 * progress so that we can report that and the result of the
	 * resubmission to the iocb completion.
	 */
	size_t			done_before;

With that added, I think I can live with this enough to:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	bool			wait_for_completion;
>  
>  	union {
> @@ -126,6 +127,9 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
>  		ret = generic_write_sync(iocb, ret);
>  
> +	if (ret > 0)
> +		ret += dio->done_before;
> +
>  	kfree(dio);
>  
>  	return ret;
> @@ -450,7 +454,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  struct iomap_dio *
>  __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags)
> +		unsigned int dio_flags, size_t done_before)
>  {
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -477,6 +481,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	dio->dops = dops;
>  	dio->error = 0;
>  	dio->flags = 0;
> +	dio->done_before = done_before;
>  
>  	dio->submit.iter = iter;
>  	dio->submit.waiter = current;
> @@ -648,11 +653,11 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags)
> +		unsigned int dio_flags, size_t done_before)
>  {
>  	struct iomap_dio *dio;
>  
> -	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags);
> +	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, done_before);
>  	if (IS_ERR_OR_NULL(dio))
>  		return PTR_ERR_OR_ZERO(dio);
>  	return iomap_dio_complete(dio);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index cc3cfb12df53..3103d9bda466 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -259,7 +259,7 @@ xfs_file_dio_read(
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
>  		return ret;
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0);
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, 0);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -569,7 +569,7 @@ xfs_file_dio_write_aligned(
>  	}
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, 0);
> +			   &xfs_dio_write_ops, 0, 0);
>  out_unlock:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> @@ -647,7 +647,7 @@ xfs_file_dio_write_unaligned(
>  
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, flags);
> +			   &xfs_dio_write_ops, flags, 0);
>  
>  	/*
>  	 * Retry unaligned I/O with exclusive blocking semantics if the DIO
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 70055d486bf7..85ca2f5fe06e 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -864,7 +864,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  		ret = zonefs_file_dio_append(iocb, from);
>  	else
>  		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
> -				   &zonefs_write_dio_ops, 0);
> +				   &zonefs_write_dio_ops, 0, 0);
>  	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
>  	    (ret > 0 || ret == -EIOCBQUEUED)) {
>  		if (ret > 0)
> @@ -999,7 +999,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		}
>  		file_accessed(iocb->ki_filp);
>  		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
> -				   &zonefs_read_dio_ops, 0);
> +				   &zonefs_read_dio_ops, 0, 0);
>  	} else {
>  		ret = generic_file_read_iter(iocb, to);
>  		if (ret == -EIO)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index bcae4814b8e3..908bda10024c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -276,10 +276,10 @@ struct iomap_dio_ops {
>  
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags);
> +		unsigned int dio_flags, size_t done_before);
>  struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		unsigned int dio_flags);
> +		unsigned int dio_flags, size_t done_before);
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
> -- 
> 2.26.3
> 
