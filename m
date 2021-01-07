Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823592ED14D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 15:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbhAGODL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 09:03:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:60344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbhAGODK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:03:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D800BACAF;
        Thu,  7 Jan 2021 14:02:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 974151E0872; Thu,  7 Jan 2021 15:02:28 +0100 (CET)
Date:   Thu, 7 Jan 2021 15:02:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/13] fs: add a lazytime_expired method
Message-ID: <20210107140228.GF12990@quack2.suse.cz>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-12-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-12-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 04-01-21 16:54:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a lazytime_expired method to 'struct super_operations'.  Filesystems
> can implement this to be notified when an inode's lazytime timestamps
> have expired and need to be written to disk.
> 
> This avoids any potential ambiguity with
> ->dirty_inode(inode, I_DIRTY_SYNC), which can also mean a generic
> dirtying of the inode, not just a lazytime timestamp expiration.
> In particular, this will be useful for XFS.
> 
> If not implemented, then ->dirty_inode(inode, I_DIRTY_SYNC) continues to
> be called.
> 
> Note that there are three cases where we have to make sure to call
> lazytime_expired():
> 
> - __writeback_single_inode(): inode is being written now
> - vfs_fsync_range(): inode is going to be synced
> - iput(): inode is going to be evicted
> 
> In the latter two cases, the inode still needs to be put on the
> writeback list.  So, we can't just replace the calls to
> mark_inode_dirty_sync() with lazytime_expired().  Instead, add a new
> flag I_DIRTY_TIME_EXPIRED which can be passed to __mark_inode_dirty().
> It's like I_DIRTY_SYNC, except it causes the filesystem to be notified
> of a lazytime expiration rather than a generic I_DIRTY_SYNC.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Hum, seeing this patch I kind of wonder: Why don't we dirty the inode after
expiring the lazytime timestamps with I_DIRTY_SYNC | I_DIRTY_TIME_EXPIRED
and propagate I_DIRTY_TIME_EXPIRED even to ->dirty_inode() where XFS can
catch it and act? Functionally it would be the same but we'd save a bunch
of generic code and ->lazytime_expired helper used just by a single
filesystem...

								Honza

> ---
>  Documentation/filesystems/locking.rst |  2 ++
>  Documentation/filesystems/vfs.rst     | 10 ++++++++++
>  fs/fs-writeback.c                     | 27 ++++++++++++++++++++++-----
>  fs/inode.c                            |  2 +-
>  fs/sync.c                             |  2 +-
>  include/linux/fs.h                    |  7 ++++++-
>  6 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index c0f2c7586531b..53088e2a93b69 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -150,6 +150,7 @@ prototypes::
>  	void (*free_inode)(struct inode *);
>  	void (*destroy_inode)(struct inode *);
>  	void (*dirty_inode) (struct inode *, int flags);
> +	void (*lazytime_expired) (struct inode *);
>  	int (*write_inode) (struct inode *, struct writeback_control *wbc);
>  	int (*drop_inode) (struct inode *);
>  	void (*evict_inode) (struct inode *);
> @@ -175,6 +176,7 @@ alloc_inode:
>  free_inode:				called from RCU callback
>  destroy_inode:
>  dirty_inode:
> +lazytime_expired:
>  write_inode:
>  drop_inode:				!!!inode->i_lock!!!
>  evict_inode:
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 287b80948a40b..02531b1421d01 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -231,6 +231,7 @@ filesystem.  As of kernel 2.6.22, the following members are defined:
>  		void (*destroy_inode)(struct inode *);
>  
>  		void (*dirty_inode) (struct inode *, int flags);
> +		void (*lazytime_expired) (struct inode *);
>  		int (*write_inode) (struct inode *, int);
>  		void (*drop_inode) (struct inode *);
>  		void (*delete_inode) (struct inode *);
> @@ -275,6 +276,15 @@ or bottom half).
>  	not its data.  If the update needs to be persisted by fdatasync(),
>  	then I_DIRTY_DATASYNC will be set in the flags argument.
>  
> +``lazytime_expired``
> +	when the lazytime mount option is enabled, this method is
> +	called when an inode's in-memory updated timestamps have
> +	expired and thus need to be written to disk.  This happens
> +	when the timestamps have been in memory for too long, when the
> +	inode is going to be evicted, or when userspace triggers a
> +	sync.  If this method is not implemented, then
> +	->dirty_inode(inode, I_DIRTY_SYNC) is called instead.
> +
>  ``write_inode``
>  	this method is called when the VFS needs to write an inode to
>  	disc.  The second parameter indicates whether the write should
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index ed76112bd067b..f187fc3f854e4 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1441,6 +1441,14 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  	}
>  }
>  
> +static void lazytime_expired(struct inode *inode)
> +{
> +	if (inode->i_sb->s_op->lazytime_expired)
> +		inode->i_sb->s_op->lazytime_expired(inode);
> +	else if (inode->i_sb->s_op->dirty_inode)
> +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
> +}
> +
>  /*
>   * Write out an inode and its dirty pages. Do not update the writeback list
>   * linkage. That is left to the caller. The caller is also responsible for
> @@ -1520,8 +1528,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  		 * isn't enough.  Don't call mark_inode_dirty_sync(), as that
>  		 * would put the inode back on the dirty list.
>  		 */
> -		if ((dirty & I_DIRTY_TIME) && inode->i_sb->s_op->dirty_inode)
> -			inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
> +		if (dirty & I_DIRTY_TIME)
> +			lazytime_expired(inode);
>  
>  		err = write_inode(inode, wbc);
>  		if (ret == 0)
> @@ -2231,8 +2239,9 @@ static noinline void block_dump___mark_inode_dirty(struct inode *inode)
>   *
>   * @inode: inode to mark
>   * @flags: what kind of dirty, e.g. I_DIRTY_SYNC.  This can be a combination of
> - *	   multiple I_DIRTY_* flags, except that I_DIRTY_TIME can't be combined
> - *	   with I_DIRTY_PAGES.
> + *	   multiple I_DIRTY_* flags, except that:
> + *	   - I_DIRTY_TIME can't be combined with I_DIRTY_PAGES
> + *	   - I_DIRTY_TIME_EXPIRED must be used by itself
>   *
>   * Mark an inode as dirty.  We notify the filesystem, then update the inode's
>   * dirty flags.  Then, if needed we add the inode to the appropriate dirty list.
> @@ -2260,7 +2269,15 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  	trace_writeback_mark_inode_dirty(inode, flags);
>  
> -	if (flags & I_DIRTY_INODE) {
> +	if (flags & I_DIRTY_TIME_EXPIRED) {
> +		/*
> +		 * Notify the filesystem about a lazytime timestamp expiration.
> +		 * Afterwards, this case just turns into I_DIRTY_SYNC.
> +		 */
> +		WARN_ON_ONCE(flags & ~I_DIRTY_TIME_EXPIRED);
> +		lazytime_expired(inode);
> +		flags = I_DIRTY_SYNC;
> +	} else if (flags & I_DIRTY_INODE) {
>  		/*
>  		 * Notify the filesystem about the inode being dirtied, so that
>  		 * (if needed) it can update on-disk fields and journal the
> diff --git a/fs/inode.c b/fs/inode.c
> index d0fa43d8e9d5c..039b201a4743a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1673,7 +1673,7 @@ void iput(struct inode *inode)
>  			atomic_inc(&inode->i_count);
>  			spin_unlock(&inode->i_lock);
>  			trace_writeback_lazytime_iput(inode);
> -			mark_inode_dirty_sync(inode);
> +			__mark_inode_dirty(inode, I_DIRTY_TIME_EXPIRED);
>  			goto retry;
>  		}
>  		iput_final(inode);
> diff --git a/fs/sync.c b/fs/sync.c
> index 1373a610dc784..363071a3528e3 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -196,7 +196,7 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
>  	if (!file->f_op->fsync)
>  		return -EINVAL;
>  	if (!datasync && (inode->i_state & I_DIRTY_TIME))
> -		mark_inode_dirty_sync(inode);
> +		__mark_inode_dirty(inode, I_DIRTY_TIME_EXPIRED);
>  	return file->f_op->fsync(file, start, end, datasync);
>  }
>  EXPORT_SYMBOL(vfs_fsync_range);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45a0303b2aeb6..8c5f5c5e62be4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1935,7 +1935,8 @@ struct super_operations {
>  	void (*destroy_inode)(struct inode *);
>  	void (*free_inode)(struct inode *);
>  
> -   	void (*dirty_inode) (struct inode *, int flags);
> +	void (*dirty_inode) (struct inode *, int flags);
> +	void (*lazytime_expired)(struct inode *);
>  	int (*write_inode) (struct inode *, struct writeback_control *wbc);
>  	int (*drop_inode) (struct inode *);
>  	void (*evict_inode) (struct inode *);
> @@ -2108,6 +2109,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
>   *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
>   *			i_state, but not both.  I_DIRTY_PAGES may still be set.
> + * I_DIRTY_TIME_EXPIRED Passed to __mark_inode_dirty() to indicate the intent to
> + *			expire the inode's timestamps.  Not stored in i_state.
> + *
>   * I_NEW		Serves as both a mutex and completion notification.
>   *			New inodes set I_NEW.  If two processes both create
>   *			the same inode, one of them will release its inode and
> @@ -2173,6 +2177,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
>  #define I_LINKABLE		(1 << 10)
>  #define I_DIRTY_TIME		(1 << 11)
> +#define I_DIRTY_TIME_EXPIRED	(1 << 12)
>  #define I_WB_SWITCH		(1 << 13)
>  #define I_OVL_INUSE		(1 << 14)
>  #define I_CREATING		(1 << 15)
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
