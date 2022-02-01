Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577324A5B57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiBALlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:41:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiBALlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:41:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 960AD218DF;
        Tue,  1 Feb 2022 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643715659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tHl1C+itQG6ufp4601MZgCGqjYvoSJJwvMt7UZ9Mcc=;
        b=LGbAmDVgS0xnAaR2ttWl0A7NxbQggwwajh543DAEvRWlGV7Ul/h3BtJVsHXqcOovWiAluM
        kCTmyNiuY8EvvvJP2y3q9tPg9hxYSd5aXvWm8ahq3SmUf3qYdre97j00QimbV+hq1wQLXe
        7TkgtVzg2/q2x6Xw9Sdgt+RSt/07MFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643715659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tHl1C+itQG6ufp4601MZgCGqjYvoSJJwvMt7UZ9Mcc=;
        b=Le8cHBBL+P7DumRe9+ddt9tFlMVofGzEeP7urmRsu1jbyvKhfJPvHK9n4xDxzlXzpeNqM+
        ZsflwVfLGgy4T4DQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F3D2A3B81;
        Tue,  1 Feb 2022 11:40:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21985A05B1; Tue,  1 Feb 2022 12:40:59 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:40:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 5/6] ext4: Refactor ext4_free_blocks() to pull out
 ext4_mb_clear_bb()
Message-ID: <20220201114059.chy3rauebk3ytszx@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <426fd12a24d7876e445aea3f14a6e09c2eba8fe3.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426fd12a24d7876e445aea3f14a6e09c2eba8fe3.1643642105.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 31-01-22 20:46:54, Ritesh Harjani wrote:
> ext4_free_blocks() function became too long and confusing, this patch
> just pulls out the ext4_mb_clear_bb() function logic from it
> which clears the block bitmap and frees it.
> 
> No functionality change in this patch
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Yeah, the function was rather long. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 180 ++++++++++++++++++++++++++--------------------
>  1 file changed, 102 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 2f931575e6c2..5f20e355d08c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5870,7 +5870,8 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  }
>  
>  /**
> - * ext4_free_blocks() -- Free given blocks and update quota
> + * ext4_mb_clear_bb() -- helper function for freeing blocks.
> + * 			Used by ext4_free_blocks()
>   * @handle:		handle for this transaction
>   * @inode:		inode
>   * @bh:			optional buffer of the block to be freed
> @@ -5878,9 +5879,9 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>   * @count:		number of blocks to be freed
>   * @flags:		flags used by ext4_free_blocks
>   */
> -void ext4_free_blocks(handle_t *handle, struct inode *inode,
> -		      struct buffer_head *bh, ext4_fsblk_t block,
> -		      unsigned long count, int flags)
> +static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> +			       ext4_fsblk_t block, unsigned long count,
> +			       int flags)
>  {
>  	struct buffer_head *bitmap_bh = NULL;
>  	struct super_block *sb = inode->i_sb;
> @@ -5897,80 +5898,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  
>  	sbi = EXT4_SB(sb);
>  
> -	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> -		ext4_free_blocks_simple(inode, block, count);
> -		return;
> -	}
> -
> -	might_sleep();
> -	if (bh) {
> -		if (block)
> -			BUG_ON(block != bh->b_blocknr);
> -		else
> -			block = bh->b_blocknr;
> -	}
> -
> -	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
> -	    !ext4_inode_block_valid(inode, block, count)) {
> -		ext4_error(sb, "Freeing blocks not in datazone - "
> -			   "block = %llu, count = %lu", block, count);
> -		goto error_return;
> -	}
> -
> -	ext4_debug("freeing block %llu\n", block);
> -	trace_ext4_free_blocks(inode, block, count, flags);
> -
> -	if (bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
> -		BUG_ON(count > 1);
> -
> -		ext4_forget(handle, flags & EXT4_FREE_BLOCKS_METADATA,
> -			    inode, bh, block);
> -	}
> -
> -	/*
> -	 * If the extent to be freed does not begin on a cluster
> -	 * boundary, we need to deal with partial clusters at the
> -	 * beginning and end of the extent.  Normally we will free
> -	 * blocks at the beginning or the end unless we are explicitly
> -	 * requested to avoid doing so.
> -	 */
> -	overflow = EXT4_PBLK_COFF(sbi, block);
> -	if (overflow) {
> -		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
> -			overflow = sbi->s_cluster_ratio - overflow;
> -			block += overflow;
> -			if (count > overflow)
> -				count -= overflow;
> -			else
> -				return;
> -		} else {
> -			block -= overflow;
> -			count += overflow;
> -		}
> -	}
> -	overflow = EXT4_LBLK_COFF(sbi, count);
> -	if (overflow) {
> -		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
> -			if (count > overflow)
> -				count -= overflow;
> -			else
> -				return;
> -		} else
> -			count += sbi->s_cluster_ratio - overflow;
> -	}
> -
> -	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
> -		int i;
> -		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
> -
> -		for (i = 0; i < count; i++) {
> -			cond_resched();
> -			if (is_metadata)
> -				bh = sb_find_get_block(inode->i_sb, block + i);
> -			ext4_forget(handle, is_metadata, inode, bh, block + i);
> -		}
> -	}
> -
>  do_more:
>  	overflow = 0;
>  	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
> @@ -6132,6 +6059,103 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  	return;
>  }
>  
> +/**
> + * ext4_free_blocks() -- Free given blocks and update quota
> + * @handle:		handle for this transaction
> + * @inode:		inode
> + * @bh:			optional buffer of the block to be freed
> + * @block:		starting physical block to be freed
> + * @count:		number of blocks to be freed
> + * @flags:		flags used by ext4_free_blocks
> + */
> +void ext4_free_blocks(handle_t *handle, struct inode *inode,
> +		      struct buffer_head *bh, ext4_fsblk_t block,
> +		      unsigned long count, int flags)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	unsigned int overflow;
> +	struct ext4_sb_info *sbi;
> +
> +	sbi = EXT4_SB(sb);
> +
> +	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> +		ext4_free_blocks_simple(inode, block, count);
> +		return;
> +	}
> +
> +	might_sleep();
> +	if (bh) {
> +		if (block)
> +			BUG_ON(block != bh->b_blocknr);
> +		else
> +			block = bh->b_blocknr;
> +	}
> +
> +	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
> +	    !ext4_inode_block_valid(inode, block, count)) {
> +		ext4_error(sb, "Freeing blocks not in datazone - "
> +			   "block = %llu, count = %lu", block, count);
> +		return;
> +	}
> +
> +	ext4_debug("freeing block %llu\n", block);
> +	trace_ext4_free_blocks(inode, block, count, flags);
> +
> +	if (bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
> +		BUG_ON(count > 1);
> +
> +		ext4_forget(handle, flags & EXT4_FREE_BLOCKS_METADATA,
> +			    inode, bh, block);
> +	}
> +
> +	/*
> +	 * If the extent to be freed does not begin on a cluster
> +	 * boundary, we need to deal with partial clusters at the
> +	 * beginning and end of the extent.  Normally we will free
> +	 * blocks at the beginning or the end unless we are explicitly
> +	 * requested to avoid doing so.
> +	 */
> +	overflow = EXT4_PBLK_COFF(sbi, block);
> +	if (overflow) {
> +		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
> +			overflow = sbi->s_cluster_ratio - overflow;
> +			block += overflow;
> +			if (count > overflow)
> +				count -= overflow;
> +			else
> +				return;
> +		} else {
> +			block -= overflow;
> +			count += overflow;
> +		}
> +	}
> +	overflow = EXT4_LBLK_COFF(sbi, count);
> +	if (overflow) {
> +		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
> +			if (count > overflow)
> +				count -= overflow;
> +			else
> +				return;
> +		} else
> +			count += sbi->s_cluster_ratio - overflow;
> +	}
> +
> +	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
> +		int i;
> +		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
> +
> +		for (i = 0; i < count; i++) {
> +			cond_resched();
> +			if (is_metadata)
> +				bh = sb_find_get_block(inode->i_sb, block + i);
> +			ext4_forget(handle, is_metadata, inode, bh, block + i);
> +		}
> +	}
> +
> +	ext4_mb_clear_bb(handle, inode, block, count, flags);
> +	return;
> +}
> +
>  /**
>   * ext4_group_add_blocks() -- Add given blocks to an existing group
>   * @handle:			handle to this transaction
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
