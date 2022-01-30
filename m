Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDA4A3AA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiA3V7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 16:59:43 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55217 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbiA3V7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:59:43 -0500
Received: from dread.disaster.area (pa49-180-69-7.pa.nsw.optusnet.com.au [49.180.69.7])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2D96062C865;
        Mon, 31 Jan 2022 08:59:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nEIEU-006AIC-Bx; Mon, 31 Jan 2022 08:59:38 +1100
Date:   Mon, 31 Jan 2022 08:59:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: ensure log flush at the end of a synchronous
 fallocate call
Message-ID: <20220130215938.GU59729@dread.disaster.area>
References: <164351876356.4177728.10148216594418485828.stgit@magnolia>
 <164351878016.4177728.4148624283377010229.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164351878016.4177728.4148624283377010229.stgit@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61f70a4c
        a=NB+Ng1P8A7U24Uo7qoRq4Q==:117 a=NB+Ng1P8A7U24Uo7qoRq4Q==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Vjp4jTvnlQluJxajWSgA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 29, 2022 at 08:59:40PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If the caller wanted us to persist the preallocation to disk before
> returning to userspace, make sure we force the log to disk after making
> all metadata updates.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_file.c |   32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a54a38e66744..8f2372b96fc4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -929,6 +929,7 @@ xfs_file_fallocate(
>  	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
>  	loff_t			new_size = 0;
>  	bool			do_file_insert = false;
> +	bool			flush_log;
>  
>  	if (!S_ISREG(inode->i_mode))
>  		return -EINVAL;
> @@ -1078,16 +1079,19 @@ xfs_file_fallocate(
>  		goto out_unlock;
>  
>  	/*
> -	 * If we need to change the PREALLOC flag or flush the log, do so.
> -	 * We already updated the timestamps and cleared the suid flags, so we
> -	 * don't need to do that again.  This must be committed before the size
> -	 * change so that we don't trim post-EOF preallocations.
> +	 * If we need to change the PREALLOC flag, do so.  We already updated
> +	 * the timestamps and cleared the suid flags, so we don't need to do
> +	 * that again.  This must be committed before the size change so that
> +	 * we don't trim post-EOF preallocations.  If this is the last
> +	 * transaction we're going to make, make the update synchronous too.
>  	 */
> -	if (xfs_file_sync_writes(file))
> -		flags |= XFS_PREALLOC_SYNC;
> +	flush_log = xfs_file_sync_writes(file);
>  	if (flags) {
>  		flags |= XFS_PREALLOC_INVISIBLE;
>  
> +		if (flush_log && !(do_file_insert || new_size))
> +			flags |= XFS_PREALLOC_SYNC;
> +
>  		error = xfs_update_prealloc_flags(ip, flags);
>  		if (error)
>  			goto out_unlock;
> @@ -1111,8 +1115,22 @@ xfs_file_fallocate(
>  	 * leave shifted extents past EOF and hence losing access to
>  	 * the data that is contained within them.
>  	 */
> -	if (do_file_insert)
> +	if (do_file_insert) {
>  		error = xfs_insert_file_space(ip, offset, len);
> +		if (error)
> +			goto out_unlock;
> +	}
> +
> +	/*
> +	 * If the caller wants us to flush the log and either we've made
> +	 * changes since updating the PREALLOC flag or we didn't need to
> +	 * update the PREALLOC flag, then flush the log now.
> +	 */
> +	if (flush_log && (do_file_insert || new_size || flags == 0)) {
> +		error = xfs_log_force_inode(ip);
> +		if (error)
> +			goto out_unlock;
> +	}

That's pretty crazy. We don't need to do synchronous transactions
for every operation in fallocate(), just guarantee that the
transactions have hit stable storage before we return to userspace.
Hence we don't need to pass SYNC flags anywhere or have stuff like
xfs_update_prealloc_flags() even have to support sync transactions.
All we need is this:

	if (xfs_file_sync_writes(file))
		error = xfs_log_force_inode(ip);

And that will force out all the changes to the journal at the end
of fallocate if required.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
