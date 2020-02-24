Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE12169B3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 01:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXAfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 19:35:03 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43679 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727151AbgBXAfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:35:03 -0500
Received: from dread.disaster.area (pa49-195-185-106.pa.nsw.optusnet.com.au [49.195.185.106])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B52CD3A211E;
        Mon, 24 Feb 2020 11:34:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j61i4-0004s8-0Y; Mon, 24 Feb 2020 11:34:56 +1100
Date:   Mon, 24 Feb 2020 11:34:55 +1100
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
Subject: Re: [PATCH V4 09/13] fs/xfs: Add write aops lock to xfs layer
Message-ID: <20200224003455.GY10776@dread.disaster.area>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004134.30599-10-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=bkRQb8bsQZKWSSj4M57YXw==:117 a=bkRQb8bsQZKWSSj4M57YXw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=jzfXMxHasCwLGlr9pT0A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:41:30PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> XFS requires the use of the aops of an inode to quiesced prior to
> changing it to/from the DAX aops vector.
> 
> Take the aops write lock while changing DAX state.
> 
> We define a new XFS_DAX_EXCL lock type to carry the lock through to
> transaction completion.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v3:
> 	Change locking function names to reflect changes in previous
> 	patches.
> 
> Changes from V2:
> 	Change name of patch (WAS: fs/xfs: Add lock/unlock state to xfs)
> 	Remove the xfs specific lock and move to the vfs layer.
> 		We still use XFS_LOCK_DAX_EXCL to be able to pass this
> 		flag through to the transaction code.  But we no longer
> 		have a lock specific to xfs.  This removes a lot of code
> 		from the XFS layer, preps us for using this in ext4, and
> 		is actually more straight forward now that all the
> 		locking requirements are better known.
> 
> 	Fix locking order comment
> 	Rework for new 'state' names
> 	(Other comments on the previous patch are not applicable with
> 	new patch as much of the code was removed in favor of the vfs
> 	level lock)
> ---
>  fs/xfs/xfs_inode.c | 22 ++++++++++++++++++++--
>  fs/xfs/xfs_inode.h |  7 +++++--
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 35df324875db..5b014c428f0f 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
>   *
>   * Basic locking order:
>   *
> - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> + * s_dax_sem -> i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
>   *
>   * mmap_sem locking order:
>   *
>   * i_rwsem -> page lock -> mmap_sem
> - * mmap_sem -> i_mmap_lock -> page_lock
> + * s_dax_sem -> mmap_sem -> i_mmap_lock -> page_lock
>   *
>   * The difference in mmap_sem locking order mean that we cannot hold the
>   * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
> @@ -182,6 +182,9 @@ xfs_ilock(
>  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
>  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
>  
> +	if (lock_flags & XFS_DAX_EXCL)
> +		inode_aops_down_write(VFS_I(ip));

I largely don't see the point of adding this to xfs_ilock/iunlock.

It's only got one caller, so I don't see much point in adding it to
an interface that has over a hundred other call sites that don't
need or use this lock. just open code it where it is needed in the
ioctl code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
