Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE92FD8B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbhATSps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388660AbhATSli (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:41:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A1FC23403;
        Wed, 20 Jan 2021 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168057;
        bh=OpTAjWEt0SW3XTOe0Ax+oySwBwckCVg2zQyHp5ImymA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8pDmsiw1cwlF61rQtnZzuAjx6HjuUChZojqn4cZ3jPMDIqYhNjr0A1nIE1MnoRaU
         tyEurnBZVL5sXxQExYOoIdxx4DswHCpPfwzzIu+4grHSelmT2O+C5OUhaGVu1df/mD
         Mnz6QrRPKW4qMc13dE4Gvz5kvEjkOObq0vQnViiLVAMufhjdft687FsYMANBHdqZYl
         85sFJSkQFqq31aJWEfDJkC+Xm4vD1r7Dw2rQxNgQZR6jMsGFYfWYhC0jrcBoBc//lh
         j3Z5NaJMbndwI5G7lK0xS6x5kLSq56DAP/qrt4xly1iAp8VgkUMC3k/zj5hzHIFC4C
         Ki2lbtVYjgKEw==
Date:   Wed, 20 Jan 2021 10:40:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210120184056.GC3133414@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:16PM +0100, Christoph Hellwig wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Attempt shared locking for unaligned DIO, but only if the the
> underlying extent is already allocated and in written state. On
> failure, retry with the existing exclusive locking.
> 
> Test case is fio randrw of 512 byte IOs using AIO and an iodepth of
> 32 IOs.
> 
> Vanilla:
> 
>   READ: bw=4560KiB/s (4670kB/s), 4560KiB/s-4560KiB/s (4670kB/s-4670kB/s), io=134MiB (140MB), run=30001-30001msec
>   WRITE: bw=4567KiB/s (4676kB/s), 4567KiB/s-4567KiB/s (4676kB/s-4676kB/s), io=134MiB (140MB), run=30001-30001msec
> 
> Patched:
>    READ: bw=37.6MiB/s (39.4MB/s), 37.6MiB/s-37.6MiB/s (39.4MB/s-39.4MB/s), io=1127MiB (1182MB), run=30002-30002msec
>   WRITE: bw=37.6MiB/s (39.4MB/s), 37.6MiB/s-37.6MiB/s (39.4MB/s-39.4MB/s), io=1128MiB (1183MB), run=30002-30002msec
> 
> That's an improvement from ~18k IOPS to a ~150k IOPS, which is
> about the IOPS limit of the VM block device setup I'm testing on.
> 
> 4kB block IO comparison:
> 
>    READ: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=8868MiB (9299MB), run=30002-30002msec
>   WRITE: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=8878MiB (9309MB), run=30002-30002msec
> 
> Which is ~150k IOPS, same as what the test gets for sub-block
> AIO+DIO writes with this patch.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> [hch: rebased, split unaligned from nowait]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c  | 87 ++++++++++++++++++++++++++++++++--------------
>  fs/xfs/xfs_iomap.c | 31 ++++++++++++-----
>  2 files changed, 84 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index b181db42f2f32f..4e475e750148db 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -544,22 +544,35 @@ xfs_file_dio_write_aligned(
>  /*
>   * Handle block unaligned direct IO writes
>   *
> - * In most cases direct IO writes will be done holding IOLOCK_SHARED, allowing
> - * them to be done in parallel with reads and other direct IO writes.  However,
> - * if the I/O is not aligned to filesystem blocks, the direct I/O layer may
> - * need to do sub-block zeroing and that requires serialisation against other
> - * direct I/Os to the same block. In this case we need to serialise the
> - * submission of the unaligned I/Os so that we don't get racing block zeroing in
> - * the dio layer.
> + * In most cases direct IO writes will be done holding IOLOCK_SHARED
> + * allowing them to be done in parallel with reads and other direct IO writes.
> + * However, if the IO is not aligned to filesystem blocks, the direct IO layer
> + * may need to do sub-block zeroing and that requires serialisation against other
> + * direct IOs to the same block. In the case where sub-block zeroing is not
> + * required, we can do concurrent sub-block dios to the same block successfully.
>   *
> - * To provide the same serialisation for AIO, we also need to wait for
> + * Hence we have two cases here - the shared, optimisitic fast path for written
> + * extents, and everything else that needs exclusive IO path access across the
> + * entire IO.
> + *
> + * For the first case, we do all the checks we need at the mapping layer in the
> + * DIO code as part of the existing NOWAIT infrastructure. Hence all we need to
> + * do to support concurrent subblock dio is first try a non-blocking submission.
> + * If that returns -EAGAIN, then we simply repeat the IO submission with full
> + * IO exclusivity guaranteed so that we avoid racing sub-block zeroing.
> + *
> + * The only wrinkle in this case is that the iomap DIO code always does
> + * partial tail sub-block zeroing for post-EOF writes. Hence for any IO that
> + * _ends_ past the current EOF we need to run with full exclusivity. Note that
> + * we also check for the start of IO being beyond EOF because then zeroing
> + * between the old EOF and the start of the IO is required and that also
> + * requires exclusivity. Hence we avoid lock cycles and blocking under
> + * IOCB_NOWAIT for this situation, too.
> + *
> + * To provide the exclusivity required when using AIO, we also need to wait for
>   * outstanding IOs to complete so that unwritten extent conversion is completed
>   * before we try to map the overlapping block. This is currently implemented by
>   * hitting it with a big hammer (i.e. inode_dio_wait()).
> - *
> - * This means that unaligned dio writes always block. There is no "nowait" fast
> - * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
> - * and we don't have to worry about that anymore.
>   */
>  static noinline ssize_t
>  xfs_file_dio_write_unaligned(
> @@ -567,13 +580,27 @@ xfs_file_dio_write_unaligned(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> -	int			iolock = XFS_IOLOCK_EXCL;
> +	size_t			isize = i_size_read(VFS_I(ip));
> +	size_t			count = iov_iter_count(from);
> +	int			iolock = XFS_IOLOCK_SHARED;
> +	unsigned int		flags = IOMAP_DIO_UNALIGNED;
>  	ssize_t			ret;
>  
> -	/* unaligned dio always waits, bail */
> -	if (iocb->ki_flags & IOCB_NOWAIT)
> -		return -EAGAIN;
> -	xfs_ilock(ip, iolock);
> +	/*
> +	 * Extending writes need exclusivity because of the sub-block zeroing
> +	 * that the DIO code always does for partial tail blocks beyond EOF.
> +	 */
> +	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
> +retry_exclusive:
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		iolock = XFS_IOLOCK_EXCL;
> +		flags = IOMAP_DIO_FORCE_WAIT;
> +	}
> +
> +	ret = xfs_ilock_iocb(iocb, iolock);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * We can't properly handle unaligned direct I/O to reflink files yet,
> @@ -590,19 +617,27 @@ xfs_file_dio_write_unaligned(
>  		goto out_unlock;
>  
>  	/*
> -	 * If we are doing unaligned I/O, we can't allow any other overlapping
> -	 * I/O in-flight at the same time or we risk data corruption. Wait for
> -	 * all other I/O to drain before we submit.
> +	 * If we are doing exclusive unaligned IO, we can't allow any other
> +	 * overlapping IO in-flight at the same time or we risk data corruption.
> +	 * Wait for all other IO to drain before we submit.
>  	 */
> -	inode_dio_wait(VFS_I(ip));
> +	if (!(flags & IOMAP_DIO_UNALIGNED))
> +		inode_dio_wait(VFS_I(ip));

Er... this really confused me when I read it -- my first thought was
"How can we be in the unaligned direct write function but DIO_UNALIGNED
isn't set?  Wouldn't we be in some other function if we're doing an
aligned direct write?"

Then I looked upthread to where Christph said he'd renamed it
IOMAP_DIO_SUBBLOCK, but I didn't think that was sufficiently better:

	if (!(flags & IOMAP_DIO_SUBBLOCK))
		iomap_dio_wait(...);

This flag doesn't have a 1:1 relationship with the iocb asking for an
(fsblock-)unaligned write or the iocb saying that the write involves
sub-block io -- this flag really means "I require a stable written
mapping, no post-processing (of the disk block) allowed".

Admittedly the comment above the definition of IOMAP_DIO_UNALIGNED
actually says this, but as we all know I sometimes like to review
patchsets backwards. :P

How about...

IOMAP_DIO_REQUIRE_OVERWRITE ?

IOMAP_DIO_REQUIRE_STABLE ?

--D

>  
> -	/*
> -	 * This must be the only I/O in-flight. Wait on it before we release the
> -	 * iolock to prevent subsequent overlapping I/O.
> -	 */
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops, IOMAP_DIO_FORCE_WAIT);
> +			   &xfs_dio_write_ops, flags);
> +	/*
> +	 * Retry unaligned IO with exclusive blocking semantics if the DIO
> +	 * layer rejected it for mapping or locking reasons. If we are doing
> +	 * nonblocking user IO, propagate the error.
> +	 */
> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT)) {
> +		ASSERT(flags & IOMAP_DIO_UNALIGNED);
> +		xfs_iunlock(ip, iolock);
> +		goto retry_exclusive;
> +	}
> +
>  out_unlock:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7b9ff824e82d48..dc8c86e98b99bf 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -784,15 +784,30 @@ xfs_direct_write_iomap_begin(
>  		goto allocate_blocks;
>  
>  	/*
> -	 * NOWAIT IO needs to span the entire requested IO with a single map so
> -	 * that we avoid partial IO failures due to the rest of the IO range not
> -	 * covered by this map triggering an EAGAIN condition when it is
> -	 * subsequently mapped and aborting the IO.
> +	 * NOWAIT and unaligned IO needs to span the entire requested IO with a
> +	 * single map so that we avoid partial IO failures due to the rest of
> +	 * the IO range not covered by this map triggering an EAGAIN condition
> +	 * when it is subsequently mapped and aborting the IO.
>  	 */
> -	if ((flags & IOMAP_NOWAIT) &&
> -	    !imap_spans_range(&imap, offset_fsb, end_fsb)) {
> +	if (flags & (IOMAP_NOWAIT | IOMAP_UNALIGNED)) {
>  		error = -EAGAIN;
> -		goto out_unlock;
> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
> +			goto out_unlock;
> +	}
> +
> +	/*
> +	 * For unsigned I/O we can't convert an unwritten extents if the I/O is
> +	 * not block size aligned, as such a conversion would have to do
> +	 * sub-block zeroing, and that can only be done under an exclusive
> +	 * IOLOCK. Hence if this is not a written extent, return EAGAIN to tell
> +	 * the caller to try again.
> +	 */
> +	if (flags & IOMAP_UNALIGNED) {
> +		error = -EAGAIN;
> +		if (imap.br_state != XFS_EXT_NORM &&
> +		    ((offset & mp->m_blockmask) ||
> +		     ((offset + length) & mp->m_blockmask)))
> +			goto out_unlock;
>  	}
>  
>  	xfs_iunlock(ip, lockmode);
> @@ -801,7 +816,7 @@ xfs_direct_write_iomap_begin(
>  
>  allocate_blocks:
>  	error = -EAGAIN;
> -	if (flags & IOMAP_NOWAIT)
> +	if (flags & (IOMAP_NOWAIT | IOMAP_UNALIGNED))
>  		goto out_unlock;
>  
>  	/*
> -- 
> 2.29.2
> 
