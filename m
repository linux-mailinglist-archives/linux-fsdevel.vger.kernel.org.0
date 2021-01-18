Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8202FABF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 21:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436982AbhARU4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 15:56:41 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:36086 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388548AbhARU4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:56:11 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id C6BC9766A23;
        Tue, 19 Jan 2021 07:55:21 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l1bYX-001MOF-1O; Tue, 19 Jan 2021 07:55:21 +1100
Date:   Tue, 19 Jan 2021 07:55:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210118205521.GF78941@dread.disaster.area>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-12-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=ajihwpiV6h8_n8UpGEgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:16PM +0100, Christoph Hellwig wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Attempt shared locking for unaligned DIO, but only if the the
> underlying extent is already allocated and in written state. On
> failure, retry with the existing exclusive locking.
....
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

Do we ever get here without holding the iolock anymore?

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

A few typos in that comment :)

	/*
	 * For unaligned IO, we cannot convert unwritten extents without
	 * requiring sub-block zeroing. This can only be done under an exclusive
	 * IOLOCK, hence return -EAGAIN if this is not a written extent to tell
	 * the caller to try again.
	 */

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
