Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66ADE195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 02:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfJUApm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 20:45:42 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35038 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbfJUApm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 20:45:42 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EA6A936401C;
        Mon, 21 Oct 2019 11:45:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMLpI-0002rU-GA; Mon, 21 Oct 2019 11:45:36 +1100
Date:   Mon, 21 Oct 2019 11:45:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/xfs: Allow toggle of physical DAX flag
Message-ID: <20191021004536.GD8015@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020155935.12297-6-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=hWqqfTRvkZgBDQNmCT4A:9
        a=cV2GjQ2AOK1rOS_g:21 a=QTE3axTs5XAi6-A_:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 20, 2019 at 08:59:35AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Switching between DAX and non-DAX on a file is racy with respect to data
> operations.  However, if no data is involved the flag is safe to switch.
> 
> Allow toggling the physical flag if a file is empty.  The file length
> check is not racy with respect to other operations as it is performed
> under XFS_MMAPLOCK_EXCL and XFS_IOLOCK_EXCL locks.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/xfs/xfs_ioctl.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index d3a7340d3209..3839684c249b 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -33,6 +33,7 @@
>  #include "xfs_sb.h"
>  #include "xfs_ag.h"
>  #include "xfs_health.h"
> +#include "libxfs/xfs_dir2.h"
>  
>  #include <linux/mount.h>
>  #include <linux/namei.h>
> @@ -1232,12 +1233,10 @@ xfs_diflags_to_linux(
>  		inode->i_flags |= S_NOATIME;
>  	else
>  		inode->i_flags &= ~S_NOATIME;
> -#if 0	/* disabled until the flag switching races are sorted out */
>  	if (xflags & FS_XFLAG_DAX)
>  		inode->i_flags |= S_DAX;
>  	else
>  		inode->i_flags &= ~S_DAX;
> -#endif

This code has bit-rotted. See xfs_setup_iops(), where we now have a
different inode->i_mapping->a_ops for DAX inodes.

That, fundamentally, is the issue here - it's not setting/clearing
the DAX flag that is the issue, it's doing a swap of the
mapping->a_ops while there may be other code using that ops
structure.

IOWs, if there is any code anywhere in the kernel that
calls an address space op without holding one of the three locks we
hold here (i_rwsem, MMAPLOCK, ILOCK) then it can race with the swap
of the address space operations.

By limiting the address space swap to file sizes of zero, we rule
out the page fault path (mmap of a zero length file segv's with an
access beyond EOF on the first read/write page fault, right?).
However, other aops callers that might run unlocked and do the wrong
thing if the aops pointer is swapped between check of the aop method
existing and actually calling it even if the file size is zero?

A quick look shows that FIBMAP (ioctl_fibmap())) looks susceptible
to such a race condition with the current definitions of the XFS DAX
aops. I'm guessing there will be others, but I haven't looked
further than this...

>  	/* lock, flush and invalidate mapping in preparation for flag change */
>  	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> +
> +	if (i_size_read(inode) != 0) {
> +		error = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}

Wrong error. Should be the same as whatever is returned when we try
to change the extent size hint and can't because the file is
non-zero in length (-EINVAL, I think). Also needs a comment
explainging why this check exists, and probably better written as
i_size_read() > 0 ....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
