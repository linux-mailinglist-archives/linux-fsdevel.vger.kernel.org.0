Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1CC3D4E51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGYOzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 10:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhGYOzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 10:55:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32A1C60F11;
        Sun, 25 Jul 2021 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627227333;
        bh=Jy2A3+vfngZcm6ZFqfgUgAb8RInjX1jbp4BBstOTwag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mobCCpzDHIf8ZE2RVgP1WE62nAIIUagMs5j5PkmxZsffDjLcsleL/9ykm8XkPmHsi
         aESjNqEEijpiL0KZINUWrpbOWSo+mAOa+qaamtiz5wILMrTkjY/9vWKevxQgKQRUOi
         WiAZrkjS1D/XRtoVTkNhu7QzhpirHKqxKMboTvu8Hw64oPbICGKJKPP5vIte7hb9hm
         kRCgnKsDEyaMT4tWezWz5+4cGbJHnOzq0hc0+Lcu/vTte+LkVUZnEmKh7LGzb8lRPA
         RTEix31iXpTTDftrFKrn0NIeo5BzD6rsI2JSYSM8Q/H6EXrQbRgANBEboZ/TH+juBq
         lPxr3mivrPP1Q==
Date:   Sun, 25 Jul 2021 08:35:31 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YP2Ew57ptGgYsD1Y@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716143919.44373-4-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note that, this patch is failing generic/250.

On 07/16, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs_write_begin() assumes that all blocks were preallocated by
> default unless FI_NO_PREALLOC is explicitly set.  This invites data
> corruption, as there are cases in which not all blocks are preallocated.
> Commit 47501f87c61a ("f2fs: preallocate DIO blocks when forcing
> buffered_io") fixed one case, but there are others remaining.
> 
> Fix up this logic by replacing this flag with FI_PREALLOCATED_ALL, which
> only gets set if all blocks for the current write were preallocated.
> 
> Also clean up f2fs_preallocate_blocks(), move it to file.c, and make it
> handle some of the logic that was previously in write_iter() directly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/f2fs/data.c |  55 ++--------------------
>  fs/f2fs/f2fs.h |   3 +-
>  fs/f2fs/file.c | 123 ++++++++++++++++++++++++++++++++-----------------
>  3 files changed, 84 insertions(+), 97 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 18cb28a514e6..cdadaa9daf55 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1370,53 +1370,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>  	return 0;
>  }
>  
> -int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
> -{
> -	struct inode *inode = file_inode(iocb->ki_filp);
> -	struct f2fs_map_blocks map;
> -	int flag;
> -	int err = 0;
> -	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
> -
> -	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
> -	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
> -	if (map.m_len > map.m_lblk)
> -		map.m_len -= map.m_lblk;
> -	else
> -		map.m_len = 0;
> -
> -	map.m_next_pgofs = NULL;
> -	map.m_next_extent = NULL;
> -	map.m_seg_type = NO_CHECK_TYPE;
> -	map.m_may_create = true;
> -
> -	if (direct_io) {
> -		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
> -		flag = f2fs_force_buffered_io(inode, iocb, from) ?
> -					F2FS_GET_BLOCK_PRE_AIO :
> -					F2FS_GET_BLOCK_PRE_DIO;
> -		goto map_blocks;
> -	}
> -	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA(inode)) {
> -		err = f2fs_convert_inline_inode(inode);
> -		if (err)
> -			return err;
> -	}
> -	if (f2fs_has_inline_data(inode))
> -		return err;
> -
> -	flag = F2FS_GET_BLOCK_PRE_AIO;
> -
> -map_blocks:
> -	err = f2fs_map_blocks(inode, &map, 1, flag);
> -	if (map.m_len > 0 && err == -ENOSPC) {
> -		if (!direct_io)
> -			set_inode_flag(inode, FI_NO_PREALLOC);
> -		err = 0;
> -	}
> -	return err;
> -}
> -
>  void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
>  {
>  	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
> @@ -3210,12 +3163,10 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>  	int flag;
>  
>  	/*
> -	 * we already allocated all the blocks, so we don't need to get
> -	 * the block addresses when there is no need to fill the page.
> +	 * If a whole page is being written and we already preallocated all the
> +	 * blocks, then there is no need to get a block address now.
>  	 */
> -	if (!f2fs_has_inline_data(inode) && len == PAGE_SIZE &&
> -	    !is_inode_flag_set(inode, FI_NO_PREALLOC) &&
> -	    !f2fs_verity_in_progress(inode))
> +	if (len == PAGE_SIZE && is_inode_flag_set(inode, FI_PREALLOCATED_ALL))
>  		return 0;
>  
>  	/* f2fs_lock_op avoids race between write CP and convert_inline_page */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ad7c1b94e23a..da1da3111f18 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -699,7 +699,7 @@ enum {
>  	FI_INLINE_DOTS,		/* indicate inline dot dentries */
>  	FI_DO_DEFRAG,		/* indicate defragment is running */
>  	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
> -	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
> +	FI_PREALLOCATED_ALL,	/* all blocks for write were preallocated */
>  	FI_HOT_DATA,		/* indicate file is hot */
>  	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
>  	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
> @@ -3604,7 +3604,6 @@ void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
>  int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
>  int f2fs_reserve_new_block(struct dnode_of_data *dn);
>  int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
> -int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from);
>  int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
>  struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>  			int op_flags, bool for_write);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b1cb5b50faac..9b12004e78c6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4218,10 +4218,72 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	return ret;
>  }
>  
> +/*
> + * Preallocate blocks for a write request, if it is possible and helpful to do
> + * so.  Returns a positive number if blocks may have been preallocated, 0 if no
> + * blocks were preallocated, or a negative errno value if something went
> + * seriously wrong.  Also sets FI_PREALLOCATED_ALL on the inode if *all* the
> + * requested blocks (not just some of them) have been allocated.
> + */
> +static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	const loff_t pos = iocb->ki_pos;
> +	const size_t count = iov_iter_count(iter);
> +	struct f2fs_map_blocks map = {};
> +	bool dio = (iocb->ki_flags & IOCB_DIRECT) &&
> +		   !f2fs_force_buffered_io(inode, iocb, iter);
> +	int flag;
> +	int ret;
> +
> +	/* If it will be an in-place direct write, don't bother. */
> +	if (dio && !f2fs_lfs_mode(sbi))
> +		return 0;
> +
> +	/* No-wait I/O can't allocate blocks. */
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		return 0;
> +
> +	/* If it will be a short write, don't bother. */
> +	if (iov_iter_fault_in_readable(iter, count) != 0)
> +		return 0;
> +
> +	if (f2fs_has_inline_data(inode)) {
> +		/* If the data will fit inline, don't bother. */
> +		if (pos + count <= MAX_INLINE_DATA(inode))
> +			return 0;
> +		ret = f2fs_convert_inline_inode(inode);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	map.m_lblk = (pos >> inode->i_blkbits);
> +	map.m_len = ((pos + count - 1) >> inode->i_blkbits) - map.m_lblk + 1;
> +	map.m_may_create = true;
> +	if (dio) {
> +		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
> +		flag = F2FS_GET_BLOCK_PRE_DIO;
> +	} else {
> +		map.m_seg_type = NO_CHECK_TYPE;
> +		flag = F2FS_GET_BLOCK_PRE_AIO;
> +	}
> +
> +	ret = f2fs_map_blocks(inode, &map, 1, flag);
> +	/* -ENOSPC is only a fatal error if no blocks could be allocated. */
> +	if (ret < 0 && !(ret == -ENOSPC && map.m_len > 0))
> +		return ret;
> +	if (ret == 0)
> +		set_inode_flag(inode, FI_PREALLOCATED_ALL);
> +	return map.m_len;
> +}
> +
>  static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> +	loff_t target_size;
> +	int preallocated;
>  	ssize_t ret;
>  
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
> @@ -4245,84 +4307,59 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	if (unlikely(IS_IMMUTABLE(inode))) {
>  		ret = -EPERM;
> -		goto unlock;
> +		goto out_unlock;
>  	}
>  
>  	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
>  		ret = -EPERM;
> -		goto unlock;
> +		goto out_unlock;
>  	}
>  
>  	ret = generic_write_checks(iocb, from);
>  	if (ret > 0) {
> -		bool preallocated = false;
> -		size_t target_size = 0;
> -		int err;
> -
> -		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
> -			set_inode_flag(inode, FI_NO_PREALLOC);
> -
> -		if ((iocb->ki_flags & IOCB_NOWAIT)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
>  						iov_iter_count(from)) ||
>  				f2fs_has_inline_data(inode) ||
>  				f2fs_force_buffered_io(inode, iocb, from)) {
> -				clear_inode_flag(inode, FI_NO_PREALLOC);
> -				inode_unlock(inode);
>  				ret = -EAGAIN;
> -				goto out;
> +				goto out_unlock;
>  			}
> -			goto write;
>  		}
> -
> -		if (is_inode_flag_set(inode, FI_NO_PREALLOC))
> -			goto write;
> -
>  		if (iocb->ki_flags & IOCB_DIRECT) {
>  			/*
>  			 * Convert inline data for Direct I/O before entering
>  			 * f2fs_direct_IO().
>  			 */
> -			err = f2fs_convert_inline_inode(inode);
> -			if (err)
> -				goto out_err;
> -			/*
> -			 * If force_buffere_io() is true, we have to allocate
> -			 * blocks all the time, since f2fs_direct_IO will fall
> -			 * back to buffered IO.
> -			 */
> -			if (!f2fs_force_buffered_io(inode, iocb, from) &&
> -					f2fs_lfs_mode(F2FS_I_SB(inode)))
> -				goto write;
> +			ret = f2fs_convert_inline_inode(inode);
> +			if (ret)
> +				goto out_unlock;
>  		}
> -		preallocated = true;
> -		target_size = iocb->ki_pos + iov_iter_count(from);
>  
> -		err = f2fs_preallocate_blocks(iocb, from);
> -		if (err) {
> -out_err:
> -			clear_inode_flag(inode, FI_NO_PREALLOC);
> -			inode_unlock(inode);
> -			ret = err;
> -			goto out;
> +		/* Possibly preallocate the blocks for the write. */
> +		target_size = iocb->ki_pos + iov_iter_count(from);
> +		preallocated = f2fs_preallocate_blocks(iocb, from);
> +		if (preallocated < 0) {
> +			ret = preallocated;
> +			goto out_unlock;
>  		}
> -write:
> +
>  		ret = __generic_file_write_iter(iocb, from);
> -		clear_inode_flag(inode, FI_NO_PREALLOC);
>  
> -		/* if we couldn't write data, we should deallocate blocks. */
> -		if (preallocated && i_size_read(inode) < target_size) {
> +		/* Don't leave any preallocated blocks around past i_size. */
> +		if (preallocated > 0 && inode->i_size < target_size) {
>  			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  			down_write(&F2FS_I(inode)->i_mmap_sem);
>  			f2fs_truncate(inode);
>  			up_write(&F2FS_I(inode)->i_mmap_sem);
>  			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		}
> +		clear_inode_flag(inode, FI_PREALLOCATED_ALL);
>  
>  		if (ret > 0)
>  			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
>  	}
> -unlock:
> +out_unlock:
>  	inode_unlock(inode);
>  out:
>  	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
> -- 
> 2.32.0
