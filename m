Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE34A3AB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 23:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356551AbiA3Wac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 17:30:32 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54639 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233616AbiA3Wab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:30:31 -0500
Received: from dread.disaster.area (pa49-180-69-7.pa.nsw.optusnet.com.au [49.180.69.7])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4803662C2CA;
        Mon, 31 Jan 2022 09:30:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nEIiK-006Aoi-25; Mon, 31 Jan 2022 09:30:28 +1100
Date:   Mon, 31 Jan 2022 09:30:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: use vfs helper to update file attributes after
 fallocate
Message-ID: <20220130223028.GV59729@dread.disaster.area>
References: <164351876356.4177728.10148216594418485828.stgit@magnolia>
 <164351876914.4177728.15972280389302582854.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164351876914.4177728.15972280389302582854.stgit@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61f71185
        a=NB+Ng1P8A7U24Uo7qoRq4Q==:117 a=NB+Ng1P8A7U24Uo7qoRq4Q==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=XgmmCzSYVHu_Ghu3Hc8A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 29, 2022 at 08:59:29PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In XFS, we always update the inode change and modification time when any
> preallocation operation succeeds.  Furthermore, as various fallocate
> modes can change the file contents (extending EOF, punching holes,
> zeroing things, shifting extents), we should drop file privileges like
> suid just like we do for a regular write().  There's already a VFS
> helper that figures all this out for us, so use that.
> 
> The net effect of this is that we no longer drop suid/sgid if the caller
> is root, but we also now drop file capabilities.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_file.c |   20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 22ad207bedf4..3b0d026396e5 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1057,12 +1057,26 @@ xfs_file_fallocate(
>  		}
>  	}
>  
> +	/* Update [cm]time and drop file privileges like a regular write. */
> +	error = file_modified(file);
> +	if (error)
> +		goto out_unlock;
> +
> +	/*
> +	 * If we need to change the PREALLOC flag or flush the log, do so.
> +	 * We already updated the timestamps and cleared the suid flags, so we
> +	 * don't need to do that again.  This must be committed before the size
> +	 * change so that we don't trim post-EOF preallocations.
> +	 */
>  	if (file->f_flags & O_DSYNC)
>  		flags |= XFS_PREALLOC_SYNC;
> +	if (flags) {
> +		flags |= XFS_PREALLOC_INVISIBLE;
> -	error = xfs_update_prealloc_flags(ip, flags);
> -	if (error)
> -		goto out_unlock;
> +		error = xfs_update_prealloc_flags(ip, flags);
> +		if (error)
> +			goto out_unlock;
> +	}

That's a change of behaviour in that if O_DSYNC is not used, we
won't call xfs_update_prealloc_flags() and so won't always log the
inode here, regardless of whether the timestamps are changed or not.

Regardless, the only other caller of xfs_update_prealloc_flags() is
xfs_fs_map_blocks(), and that clearly modifies the layout of the
file so it has the same issue w.r.t. stripping privileges via
xfs_update_prealloc_flags(). So it should really also
and not the open coded stripping done in
xfs_update_prealloc_flags().

As such, I think that the use of XFS_PREALLOC_INVISIBLE here is not
a very nice workaround to avoid repeating the work done by
file_modified(). All the code that does direct extent modification
should perform the same actions for the same reasons. And if you
xfs_fs_map_blocks() to use xfs_log_force_inode() like patch 3 in
this series does for fallocate(), then XFS_PREALLOC_SYNC and that
code in xfs_update_prealloc_flags() can go away as well....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
