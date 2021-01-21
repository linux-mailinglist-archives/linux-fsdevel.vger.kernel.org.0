Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D752FED10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbhAUOiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 09:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732450AbhAUNfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611236023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=osaOkMQC5TBliM3TcAepWHeIDX6eGu5zaKc4yWEOYyM=;
        b=MK1buBoSEoQ/Ge2wEn2ap98c5FoH7LalYYebmMebk/Y2zY85qiJwdkHaisqT8ewvaZg/JQ
        uz4oueKGwH2h/juH6TiR6BrR/ghr957gpcMl6FhGhEKYa4KJ35BcbtGDjJeLPwk5OJG3JV
        dZZlI/u3pBzXYgLTvyG+EUB/gGa+o98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-3oMWyCF2N2SJgyQN1fMVDw-1; Thu, 21 Jan 2021 08:33:38 -0500
X-MC-Unique: 3oMWyCF2N2SJgyQN1fMVDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE0EE879500;
        Thu, 21 Jan 2021 13:33:36 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D73935D9C6;
        Thu, 21 Jan 2021 13:33:35 +0000 (UTC)
Date:   Thu, 21 Jan 2021 08:33:34 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210121133334.GB1793795@bfoster>
References: <20210121085906.322712-1-hch@lst.de>
 <20210121085906.322712-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121085906.322712-12-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:59:06AM +0100, Christoph Hellwig wrote:
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
>  fs/xfs/xfs_iomap.c | 30 +++++++++++-----
>  2 files changed, 83 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index b181db42f2f32f..33899a5cca53f9 100644
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

The above paragraph still implicitly refers to the original NOWAIT based
implementation. I'd suggest to tweak it to something like:

"The mapping layer of the dio code performs all the checks required to
distinguish between the shared (overwrite) and exclusive cases. Hence to
support concurrent unaligned dio, first submit the request in overwrite
only mode. If that returns -EAGAIN, sub-block zeroing is required.
Repeat the submission with full IO exclusivity to avoid races."

That aside, I still find the single mapping requirement a bit
unfortunate, but otherwise the code LGTM:

Reviewed-by: Brian Foster <bfoster@redhat.com>

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
> +	unsigned int		flags = IOMAP_DIO_OVERWRITE_ONLY;
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
> +	if (flags & IOMAP_DIO_FORCE_WAIT)
> +		inode_dio_wait(VFS_I(ip));
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
> +		ASSERT(flags & IOMAP_DIO_OVERWRITE_ONLY);
> +		xfs_iunlock(ip, iolock);
> +		goto retry_exclusive;
> +	}
> +
>  out_unlock:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7b9ff824e82d48..596af78f910596 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -784,15 +784,29 @@ xfs_direct_write_iomap_begin(
>  		goto allocate_blocks;
>  
>  	/*
> -	 * NOWAIT IO needs to span the entire requested IO with a single map so
> -	 * that we avoid partial IO failures due to the rest of the IO range not
> -	 * covered by this map triggering an EAGAIN condition when it is
> -	 * subsequently mapped and aborting the IO.
> +	 * NOWAIT and OVERWRITE needs to span the entire requested IO with a
> +	 * single map so that we avoid partial IO failures due to the rest of
> +	 * the IO range not covered by this map triggering an EAGAIN condition
> +	 * when it is subsequently mapped and aborting the IO.
>  	 */
> -	if ((flags & IOMAP_NOWAIT) &&
> -	    !imap_spans_range(&imap, offset_fsb, end_fsb)) {
> +	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY)) {
>  		error = -EAGAIN;
> -		goto out_unlock;
> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
> +			goto out_unlock;
> +	}
> +
> +	/*
> +	 * For overwrite only I/O, we cannot convert unwritten extents without
> +	 * requiring sub-block zeroing.  This can only be done under an
> +	 * exclusive IOLOCK, hence return -EAGAIN if this is not a written
> +	 * extent to tell the caller to try again.
> +	 */
> +	if (flags & IOMAP_OVERWRITE_ONLY) {
> +		error = -EAGAIN;
> +		if (imap.br_state != XFS_EXT_NORM &&
> +		    ((offset & mp->m_blockmask) ||
> +		     ((offset + length) & mp->m_blockmask)))
> +			goto out_unlock;
>  	}
>  
>  	xfs_iunlock(ip, lockmode);
> @@ -801,7 +815,7 @@ xfs_direct_write_iomap_begin(
>  
>  allocate_blocks:
>  	error = -EAGAIN;
> -	if (flags & IOMAP_NOWAIT)
> +	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY))
>  		goto out_unlock;
>  
>  	/*
> -- 
> 2.29.2
> 

