Return-Path: <linux-fsdevel+bounces-35159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C09D1BCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CECB1F2204B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AF8197558;
	Mon, 18 Nov 2024 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhuqOd5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F22147C71;
	Mon, 18 Nov 2024 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731972433; cv=none; b=j643NbKAgm/442IYsdxQq7gzM4eF5vHbR7bqFbt/JyVBKSkJjKdn4C6UWiElv+fZ48oU+g++AZ+5ZsVV1IuSBgkDYWhMltc4Cq5zl+HxeCwcp3Biy48T29PlqbgvAZEmGRe6DQghVMSp0gMI11eaPKcW8GYdxcDc1t/o4YcDVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731972433; c=relaxed/simple;
	bh=7QPZIDne9o93BGUUovfbC0lKxWtZu//qeS4e3zdFdV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSsnmlnJeC3iibnfxU+5A2SBuezNA5OwRbzyjHcsYfS7CfezZAAa9ztUPBFDTmUAhL4M5qtOUYtv3CX1htfExWPB0INp8OVv+GZdGAk9+CJ1MC/EK1DzrJRKbp9yLkSzeBLrY1FSf4pvxLrn6xOR/8Fgs7pdxhH0UbjqOkYDkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhuqOd5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2192DC4CECC;
	Mon, 18 Nov 2024 23:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731972433;
	bh=7QPZIDne9o93BGUUovfbC0lKxWtZu//qeS4e3zdFdV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhuqOd5SqDW7NW8lx0a5T9PhrKS5dcGtnEm1E4tZHVKtoYkKIPUpdpKo9xB1IdQCV
	 u7n7mMV++inl2ih+xTT3Wm9F3Eqdn1h5PIHCRChYjybx/w+DAExa23FZ0/yrGk+cAo
	 +0ACvcy+bv3sO+e0CPwqReA/bB2kgvT4tLWbEHau5WlAKW9hyMJ+dPAsZkCx6b5Hh7
	 EDt6c9TXNAouWV5np8t5x5/doemFCP/yTiX7+/HbONED1sK8/N0h+2E4wjCeOlkLp0
	 qCFqVQXSTjUvMfBmnFCNtcWgRJ8vkPEOr92QoD6qI+eAvgoPDhDbMNLUZOkKTMq3SB
	 zjFVYPCGb3g7g==
Date: Mon, 18 Nov 2024 15:27:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, david@fromorbit.com, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH 04/27] ext4: refactor ext4_punch_hole()
Message-ID: <20241118232712.GB9417@frogsfrogsfrogs>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-5-yi.zhang@huaweicloud.com>

On Tue, Oct 22, 2024 at 07:10:35PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The current implementation of ext4_punch_hole() contains complex
> position calculations and stale error tags. To improve the code's
> clarity and maintainability, it is essential to clean up the code and
> improve its readability, this can be achieved by: a) simplifying and
> renaming variables; b) eliminating unnecessary position calculations;
> c) writing back all data in data=journal mode, and drop page cache from
> the original offset to the end, rather than using aligned blocks,
> d) renaming the stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 140 +++++++++++++++++++++---------------------------
>  1 file changed, 62 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94b923afcd9c..1d128333bd06 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3955,13 +3955,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
> -	ext4_lblk_t first_block, stop_block;
> +	ext4_lblk_t start_lblk, end_lblk;
>  	struct address_space *mapping = inode->i_mapping;
> -	loff_t first_block_offset, last_block_offset, max_length;
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +	loff_t end = offset + length;
> +	unsigned long blocksize = i_blocksize(inode);
>  	handle_t *handle;
>  	unsigned int credits;
> -	int ret = 0, ret2 = 0;
> +	int ret = 0;
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> @@ -3969,36 +3970,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
> -	 * If the hole extends beyond i_size, set the hole
> -	 * to end after the page that contains i_size
> +	 * If the hole extends beyond i_size, set the hole to end after
> +	 * the page that contains i_size, and also make sure that the hole
> +	 * within one block before last range.
>  	 */
> -	if (offset + length > inode->i_size) {
> -		length = inode->i_size +
> -		   PAGE_SIZE - (inode->i_size & (PAGE_SIZE - 1)) -
> -		   offset;
> -	}
> +	if (end > inode->i_size)
> +		end = round_up(inode->i_size, PAGE_SIZE);
> +	if (end > max_end)
> +		end = max_end;
> +	length = end - offset;
>  
>  	/*
> -	 * For punch hole the length + offset needs to be within one block
> -	 * before last range. Adjust the length if it goes beyond that limit.
> +	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
> +	 * block.
>  	 */
> -	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
> -	if (offset + length > max_length)
> -		length = max_length - offset;
> -
> -	if (offset & (sb->s_blocksize - 1) ||
> -	    (offset + length) & (sb->s_blocksize - 1)) {
> -		/*
> -		 * Attach jinode to inode for jbd2 if we do any zeroing of
> -		 * partial block
> -		 */
> +	if (offset & (blocksize - 1) || end & (blocksize - 1)) {

IS_ALIGNED(offset | end, blocksize) ?

>  		ret = ext4_inode_attach_jinode(inode);
>  		if (ret < 0)
> -			goto out_mutex;
> -
> +			goto out;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -4006,7 +3998,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -4016,34 +4008,24 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_dio;
> -
> -	first_block_offset = round_up(offset, sb->s_blocksize);
> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
> +		goto out_invalidate_lock;
>  
> -	/* Now release the pages and zero block aligned part of pages*/
> -	if (last_block_offset > first_block_offset) {
> +	/*
> +	 * For journalled data we need to write (and checkpoint) pages
> +	 * before discarding page cache to avoid inconsitent data on

inconsistent

> +	 * disk in case of crash before punching trans is committed.
> +	 */
> +	if (ext4_should_journal_data(inode)) {
> +		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
> +	} else {
>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
> -		if (ret)
> -			goto out_dio;
> -
> -		/*
> -		 * For journalled data we need to write (and checkpoint) pages
> -		 * before discarding page cache to avoid inconsitent data on
> -		 * disk in case of crash before punching trans is committed.
> -		 */
> -		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping,
> -					first_block_offset, last_block_offset);
> -			if (ret)
> -				goto out_dio;
> -		}
> -
> -		ext4_truncate_folios_range(inode, first_block_offset,
> -					   last_block_offset + 1);
> -		truncate_pagecache_range(inode, first_block_offset,
> -					 last_block_offset);
> +		ext4_truncate_folios_range(inode, offset, end);
>  	}
> +	if (ret)
> +		goto out_invalidate_lock;
> +
> +	/* Now release the pages and zero block aligned part of pages*/
> +	truncate_pagecache_range(inode, offset, end - 1);
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> @@ -4053,52 +4035,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(sb, ret);
> -		goto out_dio;
> +		goto out_invalidate_lock;
>  	}
>  
> -	ret = ext4_zero_partial_blocks(handle, inode, offset,
> -				       length);
> +	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
>  	if (ret)
> -		goto out_stop;
> -
> -	first_block = (offset + sb->s_blocksize - 1) >>
> -		EXT4_BLOCK_SIZE_BITS(sb);
> -	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
> +		goto out_handle;
>  
>  	/* If there are blocks to remove, do it */
> -	if (stop_block > first_block) {
> -		ext4_lblk_t hole_len = stop_block - first_block;
> +	start_lblk = round_up(offset, blocksize) >> inode->i_blkbits;

egad I wish ext4 had nicer unit conversion helpers.

static inline ext4_lblk_t
EXT4_B_TO_LBLK(struct ext4_sb_info *sbi, ..., loff_t offset)
{
	return round_up(offset, blocksize) >> inode->i_blkbits;
}

	start_lblk = EXT4_B_TO_LBLK(sbi, offset);

ah well.

> +	end_lblk = end >> inode->i_blkbits;
> +
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t hole_len = end_lblk - start_lblk;
>  
>  		down_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_discard_preallocations(inode);
>  
> -		ext4_es_remove_extent(inode, first_block, hole_len);
> +		ext4_es_remove_extent(inode, start_lblk, hole_len);
>  
>  		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -			ret = ext4_ext_remove_space(inode, first_block,
> -						    stop_block - 1);
> +			ret = ext4_ext_remove_space(inode, start_lblk,
> +						    end_lblk - 1);
>  		else
> -			ret = ext4_ind_remove_space(handle, inode, first_block,
> -						    stop_block);
> +			ret = ext4_ind_remove_space(handle, inode, start_lblk,
> +						    end_lblk);
> +		if (ret) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			goto out_handle;
> +		}
>  
> -		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
> +		ext4_es_insert_extent(inode, start_lblk, hole_len, ~0,
>  				      EXTENT_STATUS_HOLE, 0);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  	}
> -	ext4_fc_track_range(handle, inode, first_block, stop_block);
> +	ext4_fc_track_range(handle, inode, start_lblk, end_lblk);
> +
> +	ret = ext4_mark_inode_dirty(handle, inode);
> +	if (unlikely(ret))
> +		goto out_handle;
> +
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -
> -	ret2 = ext4_mark_inode_dirty(handle, inode);
> -	if (unlikely(ret2))
> -		ret = ret2;
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_dio:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:

Why drop "_mutex"?  You're unlocking *something* on the way out.

--D

>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.46.1
> 
> 

