Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88022180E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 04:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgCKDUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 23:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgCKDUL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:20:11 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B946F21927;
        Wed, 11 Mar 2020 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583896810;
        bh=B7xgBQEUb/r+AEoKXzPSxZbf08c/Z+iCpPzEuSoE/F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6Mh5X93gscC3R5GBKJqrSbWul9Y2vkMh+xBH9F34D44D8YlNg+pXwc0LaVkf1rjn
         tywYLH1vl5MiQyJdfJXVSlWtd7GnAL/2lT4PPMK5zccVN8blmwdUm4mobS8hLJxqJy
         use+h+rMW+C8MRrzdDS/MdS017PzI8vhdfcHoDTg=
Date:   Tue, 10 Mar 2020 20:20:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] writeback: avoid double-writing the inode on a lazytime
 expiration
Message-ID: <20200311032009.GC46757@gmail.com>
References: <20200306004555.GB225345@gmail.com>
 <20200307020043.60118-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307020043.60118-1-tytso@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:00:43PM -0500, Theodore Ts'o wrote:
> In the case that an inode has dirty timestamp for longer than the
> lazytime expiration timeout (or if all such inodes are being flushed
> out due to a sync or syncfs system call), we need to inform the file
> system that the inode is dirty so that the inode's timestamps can be
> copied out to the on-disk data structures.  That's because if the file
> system supports lazytime, it will have ignored the dirty_inode(inode,
> I_DIRTY_TIME) notification when the timestamp was modified in memory.q
> 
> Previously, this was accomplished by calling mark_inode_dirty_sync(),
> but that has the unfortunate side effect of also putting the inode the
> writeback list, and that's not necessary in this case, since we will
> immediately call write_inode() afterwards.
> 
> Eric Biggers noticed that this was causing problems for fscrypt after
> the key was removed[1].
> 
> [1] https://lore.kernel.org/r/20200306004555.GB225345@gmail.com
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/fs-writeback.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 76ac9c7d32ec..32101349ba97 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1504,8 +1504,9 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  
>  	spin_unlock(&inode->i_lock);
>  
> -	if (dirty & I_DIRTY_TIME)
> -		mark_inode_dirty_sync(inode);
> +	/* This was a lazytime expiration; we need to tell the file system */
> +	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
> +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_TIME_EXPIRED);
>  	/* Don't write the inode if only I_DIRTY_PAGES was set */
>  	if (dirty & ~I_DIRTY_PAGES) {
>  		int err = write_inode(inode, wbc);
> -- 

Thanks Ted!  This fixes the fscrypt test failure.

However, are you sure this works correctly on all filesystems?  I'm not sure
about XFS.  XFS only implements ->dirty_inode(), not ->write_inode(), and in its
->dirty_inode() it does:

	static void
	xfs_fs_dirty_inode(
		struct inode                    *inode,
		int                             flag)
	{
		struct xfs_inode                *ip = XFS_I(inode);
		struct xfs_mount                *mp = ip->i_mount;
		struct xfs_trans                *tp;

		if (!(inode->i_sb->s_flags & SB_LAZYTIME))
			return;
		if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
			return;

		if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
			return;
		xfs_ilock(ip, XFS_ILOCK_EXCL);
		xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
		xfs_trans_log_inode(tp, ip, XFS_ILOG_TIMESTAMP);
		xfs_trans_commit(tp);
	}


So flag=I_DIRTY_TIME_EXPIRED will be a no-op.

Maybe you should be using I_DIRTY_SYNC instead?  Or perhaps XFS should be
checking for either I_DIRTY_TIME_EXPIRED or I_DIRTY_SYNC?

- Eric
