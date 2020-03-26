Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105371936AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 04:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZDWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 23:22:22 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55603 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbgCZDWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:22:22 -0400
Received: from dread.disaster.area (pa49-179-23-206.pa.nsw.optusnet.com.au [49.179.23.206])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D3C267EB4DD;
        Thu, 26 Mar 2020 14:22:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jHJ5w-0006v8-Du; Thu, 26 Mar 2020 14:22:12 +1100
Date:   Thu, 26 Mar 2020 14:22:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: avoid double-writing the inode on a lazytime
 expiration
Message-ID: <20200326032212.GN10776@dread.disaster.area>
References: <20200325122825.1086872-1-hch@lst.de>
 <20200325122825.1086872-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325122825.1086872-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=n/Z79dAqQwRlp4tcgfhWYA==:117 a=n/Z79dAqQwRlp4tcgfhWYA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=7-415B0cAAAA:8 a=TQi0xSRmeD81B83iwF8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 01:28:23PM +0100, Christoph Hellwig wrote:
> In the case that an inode has dirty timestamp for longer than the
> lazytime expiration timeout (or if all such inodes are being flushed
> out due to a sync or syncfs system call), we need to inform the file
> system that the inode is dirty so that the inode's timestamps can be
> copied out to the on-disk data structures.  That's because if the file
> system supports lazytime, it will have ignored the dirty_inode(inode,
> I_DIRTY_TIME) notification when the timestamp was modified in memory.q
> Previously, this was accomplished by calling mark_inode_dirty_sync(),
> but that has the unfortunate side effect of also putting the inode the
> writeback list, and that's not necessary in this case, since we will
> immediately call write_inode() afterwards.  Replace the call to
> mark_inode_dirty_sync() with a new lazytime_expired method to clearly
> separate out this case.


hmmm. Doesn't this cause issues with both iput() and
vfs_fsync_range() because they call mark_inode_dirty_sync() on
I_DIRTY_TIME inodes to move them onto the writeback list so they are
appropriately expired when the inode is written back.

i.e.:


> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2094386af8ac..e5aafd40dd0f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -612,19 +612,13 @@ xfs_fs_destroy_inode(
>  }
>  
>  static void
> -xfs_fs_dirty_inode(
> -	struct inode			*inode,
> -	int				flag)
> +xfs_fs_lazytime_expired(
> +	struct inode			*inode)
>  {
>  	struct xfs_inode		*ip = XFS_I(inode);
>  	struct xfs_mount		*mp = ip->i_mount;
>  	struct xfs_trans		*tp;
>  
> -	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
> -		return;
> -	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
> -		return;
> -
>  	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
>  		return;
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> @@ -1053,7 +1047,7 @@ xfs_fs_free_cached_objects(
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> -	.dirty_inode		= xfs_fs_dirty_inode,
> +	.lazytime_expired	= xfs_fs_lazytime_expired,
>  	.drop_inode		= xfs_fs_drop_inode,
>  	.put_super		= xfs_fs_put_super,
>  	.sync_fs		= xfs_fs_sync_fs,

This means XFS no longer updates/logs the current timestamp because
->dirty_inode(I_DIRTY_SYNC) is no longer called for XFS) before
->fsync flushes the inode data and metadata changes to the journal.
Hence the current in-memory timestamps are not present in the log
before the fsync is run as so we violate the fsync guarantees
lazytime gives for timestamp updates....

I haven't quite got it straight in my head if the iput() case has
similar problems, but the fsync case definitely looks broken.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
