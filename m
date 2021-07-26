Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01F3D5AC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhGZNM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 09:12:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhGZNM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:12:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A316921FB0;
        Mon, 26 Jul 2021 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627307576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6u6JmLZ5nMSudx8EQgpWxou1jhI5cmw4yaIo4reKyU=;
        b=BjWCAZUlbMCT8nvnoZWyj9JwrtOUujAC+9qFgKnBaA3SSP7psqClvPkX9nGAd3gptfnbOx
        JVI06ufXzADuHTz5ATt5qhWrThhtN7g9K8PwUEbXL+TSekZtxSLw0yAo2grqCeaMcUeCr6
        8eYl9j/j8wypRwdAHlOehhJwMurkqTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627307576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6u6JmLZ5nMSudx8EQgpWxou1jhI5cmw4yaIo4reKyU=;
        b=jLBMuSWiHk7O2i9annC+aqY3slF/rqzUQ6+8OvUQUBirtU+rTVHycuowwFI5ktT7s9JaNt
        Y3PVUr7JyCmIjGDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 96067A3B84;
        Mon, 26 Jul 2021 13:52:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F8531E3B13; Mon, 26 Jul 2021 15:52:56 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:52:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fs: remove generic_block_fiemap
Message-ID: <20210726135256.GF20621@quack2.suse.cz>
References: <20210720133341.405438-1-hch@lst.de>
 <20210720133341.405438-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133341.405438-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-07-21 15:33:41, Christoph Hellwig wrote:
> Remove the now unused generic_block_fiemap helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ioctl.c             | 203 -----------------------------------------
>  include/linux/fiemap.h |   4 -
>  2 files changed, 207 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..eea8267ae1f2 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -263,209 +263,6 @@ static long ioctl_file_clone_range(struct file *file,
>  				args.src_length, args.dest_offset);
>  }
>  
> -#ifdef CONFIG_BLOCK
> -
> -static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
> -{
> -	return (offset >> inode->i_blkbits);
> -}
> -
> -static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
> -{
> -	return (blk << inode->i_blkbits);
> -}
> -
> -/**
> - * __generic_block_fiemap - FIEMAP for block based inodes (no locking)
> - * @inode: the inode to map
> - * @fieinfo: the fiemap info struct that will be passed back to userspace
> - * @start: where to start mapping in the inode
> - * @len: how much space to map
> - * @get_block: the fs's get_block function
> - *
> - * This does FIEMAP for block based inodes.  Basically it will just loop
> - * through get_block until we hit the number of extents we want to map, or we
> - * go past the end of the file and hit a hole.
> - *
> - * If it is possible to have data blocks beyond a hole past @inode->i_size, then
> - * please do not use this function, it will stop at the first unmapped block
> - * beyond i_size.
> - *
> - * If you use this function directly, you need to do your own locking. Use
> - * generic_block_fiemap if you want the locking done for you.
> - */
> -static int __generic_block_fiemap(struct inode *inode,
> -			   struct fiemap_extent_info *fieinfo, loff_t start,
> -			   loff_t len, get_block_t *get_block)
> -{
> -	struct buffer_head map_bh;
> -	sector_t start_blk, last_blk;
> -	loff_t isize = i_size_read(inode);
> -	u64 logical = 0, phys = 0, size = 0;
> -	u32 flags = FIEMAP_EXTENT_MERGED;
> -	bool past_eof = false, whole_file = false;
> -	int ret = 0;
> -
> -	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Either the i_mutex or other appropriate locking needs to be held
> -	 * since we expect isize to not change at all through the duration of
> -	 * this call.
> -	 */
> -	if (len >= isize) {
> -		whole_file = true;
> -		len = isize;
> -	}
> -
> -	/*
> -	 * Some filesystems can't deal with being asked to map less than
> -	 * blocksize, so make sure our len is at least block length.
> -	 */
> -	if (logical_to_blk(inode, len) == 0)
> -		len = blk_to_logical(inode, 1);
> -
> -	start_blk = logical_to_blk(inode, start);
> -	last_blk = logical_to_blk(inode, start + len - 1);
> -
> -	do {
> -		/*
> -		 * we set b_size to the total size we want so it will map as
> -		 * many contiguous blocks as possible at once
> -		 */
> -		memset(&map_bh, 0, sizeof(struct buffer_head));
> -		map_bh.b_size = len;
> -
> -		ret = get_block(inode, start_blk, &map_bh, 0);
> -		if (ret)
> -			break;
> -
> -		/* HOLE */
> -		if (!buffer_mapped(&map_bh)) {
> -			start_blk++;
> -
> -			/*
> -			 * We want to handle the case where there is an
> -			 * allocated block at the front of the file, and then
> -			 * nothing but holes up to the end of the file properly,
> -			 * to make sure that extent at the front gets properly
> -			 * marked with FIEMAP_EXTENT_LAST
> -			 */
> -			if (!past_eof &&
> -			    blk_to_logical(inode, start_blk) >= isize)
> -				past_eof = 1;
> -
> -			/*
> -			 * First hole after going past the EOF, this is our
> -			 * last extent
> -			 */
> -			if (past_eof && size) {
> -				flags = FIEMAP_EXTENT_MERGED|FIEMAP_EXTENT_LAST;
> -				ret = fiemap_fill_next_extent(fieinfo, logical,
> -							      phys, size,
> -							      flags);
> -			} else if (size) {
> -				ret = fiemap_fill_next_extent(fieinfo, logical,
> -							      phys, size, flags);
> -				size = 0;
> -			}
> -
> -			/* if we have holes up to/past EOF then we're done */
> -			if (start_blk > last_blk || past_eof || ret)
> -				break;
> -		} else {
> -			/*
> -			 * We have gone over the length of what we wanted to
> -			 * map, and it wasn't the entire file, so add the extent
> -			 * we got last time and exit.
> -			 *
> -			 * This is for the case where say we want to map all the
> -			 * way up to the second to the last block in a file, but
> -			 * the last block is a hole, making the second to last
> -			 * block FIEMAP_EXTENT_LAST.  In this case we want to
> -			 * see if there is a hole after the second to last block
> -			 * so we can mark it properly.  If we found data after
> -			 * we exceeded the length we were requesting, then we
> -			 * are good to go, just add the extent to the fieinfo
> -			 * and break
> -			 */
> -			if (start_blk > last_blk && !whole_file) {
> -				ret = fiemap_fill_next_extent(fieinfo, logical,
> -							      phys, size,
> -							      flags);
> -				break;
> -			}
> -
> -			/*
> -			 * if size != 0 then we know we already have an extent
> -			 * to add, so add it.
> -			 */
> -			if (size) {
> -				ret = fiemap_fill_next_extent(fieinfo, logical,
> -							      phys, size,
> -							      flags);
> -				if (ret)
> -					break;
> -			}
> -
> -			logical = blk_to_logical(inode, start_blk);
> -			phys = blk_to_logical(inode, map_bh.b_blocknr);
> -			size = map_bh.b_size;
> -			flags = FIEMAP_EXTENT_MERGED;
> -
> -			start_blk += logical_to_blk(inode, size);
> -
> -			/*
> -			 * If we are past the EOF, then we need to make sure as
> -			 * soon as we find a hole that the last extent we found
> -			 * is marked with FIEMAP_EXTENT_LAST
> -			 */
> -			if (!past_eof && logical + size >= isize)
> -				past_eof = true;
> -		}
> -		cond_resched();
> -		if (fatal_signal_pending(current)) {
> -			ret = -EINTR;
> -			break;
> -		}
> -
> -	} while (1);
> -
> -	/* If ret is 1 then we just hit the end of the extent array */
> -	if (ret == 1)
> -		ret = 0;
> -
> -	return ret;
> -}
> -
> -/**
> - * generic_block_fiemap - FIEMAP for block based inodes
> - * @inode: The inode to map
> - * @fieinfo: The mapping information
> - * @start: The initial block to map
> - * @len: The length of the extect to attempt to map
> - * @get_block: The block mapping function for the fs
> - *
> - * Calls __generic_block_fiemap to map the inode, after taking
> - * the inode's mutex lock.
> - */
> -
> -int generic_block_fiemap(struct inode *inode,
> -			 struct fiemap_extent_info *fieinfo, u64 start,
> -			 u64 len, get_block_t *get_block)
> -{
> -	int ret;
> -	inode_lock(inode);
> -	ret = __generic_block_fiemap(inode, fieinfo, start, len, get_block);
> -	inode_unlock(inode);
> -	return ret;
> -}
> -EXPORT_SYMBOL(generic_block_fiemap);
> -
> -#endif  /*  CONFIG_BLOCK  */
> -
>  /*
>   * This provides compatibility with legacy XFS pre-allocation ioctls
>   * which predate the fallocate syscall.
> diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
> index 4e624c466583..c50882f19235 100644
> --- a/include/linux/fiemap.h
> +++ b/include/linux/fiemap.h
> @@ -18,8 +18,4 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>  			    u64 phys, u64 len, u32 flags);
>  
> -int generic_block_fiemap(struct inode *inode,
> -		struct fiemap_extent_info *fieinfo, u64 start, u64 len,
> -		get_block_t *get_block);
> -
>  #endif /* _LINUX_FIEMAP_H 1 */
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
