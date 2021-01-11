Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE362F18D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbhAKOzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:38544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbhAKOzf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 598DDAB7A;
        Mon, 11 Jan 2021 14:54:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2460A1E0807; Mon, 11 Jan 2021 15:54:54 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:54:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/12] fs: don't call ->dirty_inode for lazytime
 timestamp updates
Message-ID: <20210111145454.GD18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:58:56, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> There is no need to call ->dirty_inode for lazytime timestamp updates
> (i.e. for __mark_inode_dirty(I_DIRTY_TIME)), since by the definition of
> lazytime, filesystems must ignore these updates.  Filesystems only need
> to care about the updated timestamps when they expire.
> 
> Therefore, only call ->dirty_inode when I_DIRTY_INODE is set.
> 
> Based on a patch from Christoph Hellwig:
> https://lore.kernel.org/r/20200325122825.1086872-4-hch@lst.de
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c   | 12 +-----------
>  fs/f2fs/super.c   |  3 ---
>  fs/fs-writeback.c |  6 +++---
>  fs/gfs2/super.c   |  2 --
>  4 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 27946882d4ce4..4cc6c7834312f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5933,26 +5933,16 @@ int __ext4_mark_inode_dirty(handle_t *handle, struct inode *inode,
>   * If the inode is marked synchronous, we don't honour that here - doing
>   * so would cause a commit on atime updates, which we don't bother doing.
>   * We handle synchronous inodes at the highest possible level.
> - *
> - * If only the I_DIRTY_TIME flag is set, we can skip everything.  If
> - * I_DIRTY_TIME and I_DIRTY_SYNC is set, the only inode fields we need
> - * to copy into the on-disk inode structure are the timestamp files.
>   */
>  void ext4_dirty_inode(struct inode *inode, int flags)
>  {
>  	handle_t *handle;
>  
> -	if (flags == I_DIRTY_TIME)
> -		return;
>  	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>  	if (IS_ERR(handle))
> -		goto out;
> -
> +		return;
>  	ext4_mark_inode_dirty(handle, inode);
> -
>  	ext4_journal_stop(handle);
> -out:
> -	return;
>  }
>  
>  int ext4_change_inode_journal_flag(struct inode *inode, int val)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b4a07fe62d1a5..cc98dc49f4a26 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1196,9 +1196,6 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
>  			inode->i_ino == F2FS_META_INO(sbi))
>  		return;
>  
> -	if (flags == I_DIRTY_TIME)
> -		return;
> -
>  	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
>  		clear_inode_flag(inode, FI_AUTO_RECOVER);
>  
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index c41cb887eb7d3..b7616bbd55336 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2255,16 +2255,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
>  	 * dirty the inode itself
>  	 */
> -	if (flags & (I_DIRTY_INODE | I_DIRTY_TIME)) {
> +	if (flags & I_DIRTY_INODE) {
>  		trace_writeback_dirty_inode_start(inode, flags);
>  
>  		if (sb->s_op->dirty_inode)
>  			sb->s_op->dirty_inode(inode, flags);
>  
>  		trace_writeback_dirty_inode(inode, flags);
> -	}
> -	if (flags & I_DIRTY_INODE)
> +
>  		flags &= ~I_DIRTY_TIME;
> +	}
>  	dirtytime = flags & I_DIRTY_TIME;
>  
>  	/*
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 2f56acc41c049..042b94288ff11 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -562,8 +562,6 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
>  	int need_endtrans = 0;
>  	int ret;
>  
> -	if (!(flags & I_DIRTY_INODE))
> -		return;
>  	if (unlikely(gfs2_withdrawn(sdp)))
>  		return;
>  	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
