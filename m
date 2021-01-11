Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB42F190A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbhAKPAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 10:00:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:42178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbhAKPAL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:00:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85BC0AD1E;
        Mon, 11 Jan 2021 14:59:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4933C1E0807; Mon, 11 Jan 2021 15:59:29 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:59:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 07/12] fs: clean up __mark_inode_dirty() a bit
Message-ID: <20210111145929.GF18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-8-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-8-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:58:58, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Improve some comments, and don't bother checking for the I_DIRTY_TIME
> flag in the case where we just cleared it.
> 
> Also, warn if I_DIRTY_TIME and I_DIRTY_PAGES are passed to
> __mark_inode_dirty() at the same time, as this case isn't handled.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 49 +++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2e6064012f7d3..80ee9816d9df5 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2219,23 +2219,24 @@ static noinline void block_dump___mark_inode_dirty(struct inode *inode)
>  }
>  
>  /**
> - * __mark_inode_dirty -	internal function
> + * __mark_inode_dirty -	internal function to mark an inode dirty
>   *
>   * @inode: inode to mark
> - * @flags: what kind of dirty (i.e. I_DIRTY_SYNC)
> + * @flags: what kind of dirty, e.g. I_DIRTY_SYNC.  This can be a combination of
> + *	   multiple I_DIRTY_* flags, except that I_DIRTY_TIME can't be combined
> + *	   with I_DIRTY_PAGES.
>   *
> - * Mark an inode as dirty. Callers should use mark_inode_dirty or
> - * mark_inode_dirty_sync.
> + * Mark an inode as dirty.  We notify the filesystem, then update the inode's
> + * dirty flags.  Then, if needed we add the inode to the appropriate dirty list.
>   *
> - * Put the inode on the super block's dirty list.
> + * Most callers should use mark_inode_dirty() or mark_inode_dirty_sync()
> + * instead of calling this directly.
>   *
> - * CAREFUL! We mark it dirty unconditionally, but move it onto the
> - * dirty list only if it is hashed or if it refers to a blockdev.
> - * If it was not hashed, it will never be added to the dirty list
> - * even if it is later hashed, as it will have been marked dirty already.
> + * CAREFUL!  We only add the inode to the dirty list if it is hashed or if it
> + * refers to a blockdev.  Unhashed inodes will never be added to the dirty list
> + * even if they are later hashed, as they will have been marked dirty already.
>   *
> - * In short, make sure you hash any inodes _before_ you start marking
> - * them dirty.
> + * In short, ensure you hash any inodes _before_ you start marking them dirty.
>   *
>   * Note that for blockdevs, inode->dirtied_when represents the dirtying time of
>   * the block-special inode (/dev/hda1) itself.  And the ->dirtied_when field of
> @@ -2247,25 +2248,34 @@ static noinline void block_dump___mark_inode_dirty(struct inode *inode)
>  void __mark_inode_dirty(struct inode *inode, int flags)
>  {
>  	struct super_block *sb = inode->i_sb;
> -	int dirtytime;
> +	int dirtytime = 0;
>  
>  	trace_writeback_mark_inode_dirty(inode, flags);
>  
> -	/*
> -	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
> -	 * dirty the inode itself
> -	 */
>  	if (flags & I_DIRTY_INODE) {
> +		/*
> +		 * Notify the filesystem about the inode being dirtied, so that
> +		 * (if needed) it can update on-disk fields and journal the
> +		 * inode.  This is only needed when the inode itself is being
> +		 * dirtied now.  I.e. it's only needed for I_DIRTY_INODE, not
> +		 * for just I_DIRTY_PAGES or I_DIRTY_TIME.
> +		 */
>  		trace_writeback_dirty_inode_start(inode, flags);
> -
>  		if (sb->s_op->dirty_inode)
>  			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
> -
>  		trace_writeback_dirty_inode(inode, flags);
>  
> +		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
>  		flags &= ~I_DIRTY_TIME;
> +	} else {
> +		/*
> +		 * Else it's either I_DIRTY_PAGES, I_DIRTY_TIME, or nothing.
> +		 * (We don't support setting both I_DIRTY_PAGES and I_DIRTY_TIME
> +		 * in one call to __mark_inode_dirty().)
> +		 */
> +		dirtytime = flags & I_DIRTY_TIME;
> +		WARN_ON_ONCE(dirtytime && flags != I_DIRTY_TIME);
>  	}
> -	dirtytime = flags & I_DIRTY_TIME;
>  
>  	/*
>  	 * Paired with smp_mb() in __writeback_single_inode() for the
> @@ -2288,6 +2298,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  		inode_attach_wb(inode, NULL);
>  
> +		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
>  		if (flags & I_DIRTY_INODE)
>  			inode->i_state &= ~I_DIRTY_TIME;
>  		inode->i_state |= flags;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
