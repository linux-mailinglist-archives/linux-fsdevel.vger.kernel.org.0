Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE65103AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 14:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfKTNLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 08:11:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfKTNLL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:11:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8DC0B26F;
        Wed, 20 Nov 2019 13:11:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 37EC81E484C; Wed, 20 Nov 2019 14:11:07 +0100 (CET)
Date:   Wed, 20 Nov 2019 14:11:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 2/4] ext4: Add ext4_ilock & ext4_iunlock API
Message-ID: <20191120131107.GC9509@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-3-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120050024.11161-3-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-11-19 10:30:22, Ritesh Harjani wrote:
> This adds ext4_ilock/iunlock types of APIs.
> This is the preparation APIs to make shared
> locking/unlocking & restarting with exclusive
> locking/unlocking easier in next patch.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

I know XFS does it this way but I don't think we need the obsurity of
additional locking helpers etc. just because of one place in
ext4_dio_write_iter() that will use this. So I'd just drop this patch...

								Honza

> ---
>  fs/ext4/ext4.h    | 33 ++++++++++++++++++++++++++++++
>  fs/ext4/extents.c | 16 +++++++--------
>  fs/ext4/file.c    | 52 +++++++++++++++++++++++------------------------
>  fs/ext4/inode.c   |  4 ++--
>  fs/ext4/ioctl.c   | 16 +++++++--------
>  fs/ext4/super.c   | 12 +++++------
>  fs/ext4/xattr.c   | 17 ++++++++--------
>  7 files changed, 92 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 61987c106511..b4169a92e8d0 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2960,6 +2960,39 @@ do {								\
>  #define EXT4_FREECLUSTERS_WATERMARK 0
>  #endif
>  
> +#define EXT4_IOLOCK_EXCL	(1 << 0)
> +#define EXT4_IOLOCK_SHARED	(1 << 1)
> +
> +static inline void ext4_ilock(struct inode *inode, unsigned int iolock)
> +{
> +	if (iolock == EXT4_IOLOCK_EXCL)
> +		inode_lock(inode);
> +	else
> +		inode_lock_shared(inode);
> +}
> +
> +static inline void ext4_iunlock(struct inode *inode, unsigned int iolock)
> +{
> +	if (iolock == EXT4_IOLOCK_EXCL)
> +		inode_unlock(inode);
> +	else
> +		inode_unlock_shared(inode);
> +}
> +
> +static inline int ext4_ilock_nowait(struct inode *inode, unsigned int iolock)
> +{
> +	if (iolock == EXT4_IOLOCK_EXCL)
> +		return inode_trylock(inode);
> +	else
> +		return inode_trylock_shared(inode);
> +}
> +
> +static inline void ext4_ilock_demote(struct inode *inode, unsigned int iolock)
> +{
> +	BUG_ON(iolock != EXT4_IOLOCK_EXCL);
> +	downgrade_write(&inode->i_rwsem);
> +}
> +
>  /* Update i_disksize. Requires i_mutex to avoid races with truncate */
>  static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
>  {
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0e8708b77da6..08dd57558533 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4754,7 +4754,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	else
>  		max_blocks -= lblk;
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  
>  	/*
>  	 * Indirect files do not support unwritten extnets
> @@ -4864,7 +4864,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  	ext4_journal_stop(handle);
>  out_mutex:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	return ret;
>  }
>  
> @@ -4930,7 +4930,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (mode & FALLOC_FL_KEEP_SIZE)
>  		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  
>  	/*
>  	 * We only support preallocation for extent-based files only
> @@ -4961,7 +4961,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  						EXT4_I(inode)->i_sync_tid);
>  	}
>  out:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
>  	return ret;
>  }
> @@ -5509,7 +5509,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  			return ret;
>  	}
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  	/*
>  	 * There is no need to overlap collapse range with EOF, in which case
>  	 * it is effectively a truncate operation
> @@ -5608,7 +5608,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  out_mmap:
>  	up_write(&EXT4_I(inode)->i_mmap_sem);
>  out_mutex:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	return ret;
>  }
>  
> @@ -5659,7 +5659,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  			return ret;
>  	}
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  	/* Currently just for extent based files */
>  	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
>  		ret = -EOPNOTSUPP;
> @@ -5786,7 +5786,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  out_mmap:
>  	up_write(&EXT4_I(inode)->i_mmap_sem);
>  out_mutex:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 977ac58dc718..ebe3f051598d 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -55,14 +55,14 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!inode_trylock_shared(inode))
> +		if (!ext4_ilock_nowait(inode, EXT4_IOLOCK_SHARED))
>  			return -EAGAIN;
>  	} else {
> -		inode_lock_shared(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
>  	}
>  
>  	if (!ext4_dio_supported(inode)) {
> -		inode_unlock_shared(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
>  		/*
>  		 * Fallback to buffered I/O if the operation being performed on
>  		 * the inode is not supported by direct I/O. The IOCB_DIRECT
> @@ -76,7 +76,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
>  			   is_sync_kiocb(iocb));
> -	inode_unlock_shared(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
>  
>  	file_accessed(iocb->ki_filp);
>  	return ret;
> @@ -89,22 +89,23 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	ssize_t ret;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!inode_trylock_shared(inode))
> +		if (!ext4_ilock_nowait(inode, EXT4_IOLOCK_SHARED))
>  			return -EAGAIN;
>  	} else {
> -		inode_lock_shared(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
>  	}
> +
>  	/*
>  	 * Recheck under inode lock - at this point we are sure it cannot
>  	 * change anymore
>  	 */
>  	if (!IS_DAX(inode)) {
> -		inode_unlock_shared(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
>  		/* Fallback to buffered IO in case we cannot support DAX */
>  		return generic_file_read_iter(iocb, to);
>  	}
>  	ret = dax_iomap_rw(iocb, to, &ext4_iomap_ops);
> -	inode_unlock_shared(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
>  
>  	file_accessed(iocb->ki_filp);
>  	return ret;
> @@ -244,7 +245,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		return -EOPNOTSUPP;
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  	ret = ext4_write_checks(iocb, from);
>  	if (ret <= 0)
>  		goto out;
> @@ -254,7 +255,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  	current->backing_dev_info = NULL;
>  
>  out:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	if (likely(ret > 0)) {
>  		iocb->ki_pos += ret;
>  		ret = generic_write_sync(iocb, ret);
> @@ -372,16 +373,17 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	handle_t *handle;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	bool extend = false, overwrite = false, unaligned_aio = false;
> +	unsigned int iolock = EXT4_IOLOCK_EXCL;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!inode_trylock(inode))
> +		if (!ext4_ilock_nowait(inode, iolock))
>  			return -EAGAIN;
>  	} else {
> -		inode_lock(inode);
> +		ext4_ilock(inode, iolock);
>  	}
>  
>  	if (!ext4_dio_supported(inode)) {
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, iolock);
>  		/*
>  		 * Fallback to buffered I/O if the inode does not support
>  		 * direct I/O.
> @@ -391,7 +393,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = ext4_write_checks(iocb, from);
>  	if (ret <= 0) {
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, iolock);
>  		return ret;
>  	}
>  
> @@ -416,7 +418,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
>  	    ext4_should_dioread_nolock(inode)) {
>  		overwrite = true;
> -		downgrade_write(&inode->i_rwsem);
> +		ext4_ilock_demote(inode, iolock);
> +		iolock = EXT4_IOLOCK_SHARED;
>  	}
>  
>  	if (offset + count > EXT4_I(inode)->i_disksize) {
> @@ -443,10 +446,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ret = ext4_handle_inode_extension(inode, offset, ret, count);
>  
>  out:
> -	if (overwrite)
> -		inode_unlock_shared(inode);
> -	else
> -		inode_unlock(inode);
> +	ext4_iunlock(inode, iolock);
>  
>  	if (ret >= 0 && iov_iter_count(from)) {
>  		ssize_t err;
> @@ -489,10 +489,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!inode_trylock(inode))
> +		if (!ext4_ilock_nowait(inode, EXT4_IOLOCK_EXCL))
>  			return -EAGAIN;
>  	} else {
> -		inode_lock(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  	}
>  
>  	ret = ext4_write_checks(iocb, from);
> @@ -524,7 +524,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (extend)
>  		ret = ext4_handle_inode_extension(inode, offset, ret, count);
>  out:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	if (ret > 0)
>  		ret = generic_write_sync(iocb, ret);
>  	return ret;
> @@ -757,16 +757,16 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
>  		return generic_file_llseek_size(file, offset, whence,
>  						maxbytes, i_size_read(inode));
>  	case SEEK_HOLE:
> -		inode_lock_shared(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
>  		offset = iomap_seek_hole(inode, offset,
>  					 &ext4_iomap_report_ops);
> -		inode_unlock_shared(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
>  		break;
>  	case SEEK_DATA:
> -		inode_lock_shared(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
>  		offset = iomap_seek_data(inode, offset,
>  					 &ext4_iomap_report_ops);
> -		inode_unlock_shared(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
>  		break;
>  	}
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 381813205f99..39dcc22667a1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3930,7 +3930,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>  			return ret;
>  	}
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size)
> @@ -4037,7 +4037,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>  out_dio:
>  	up_write(&EXT4_I(inode)->i_mmap_sem);
>  out_mutex:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 0b7f316fd30f..43b7a23dc57b 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -855,13 +855,13 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		if (err)
>  			return err;
>  
> -		inode_lock(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  		err = ext4_ioctl_check_immutable(inode,
>  				from_kprojid(&init_user_ns, ei->i_projid),
>  				flags);
>  		if (!err)
>  			err = ext4_ioctl_setflags(inode, flags);
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  		mnt_drop_write_file(filp);
>  		return err;
>  	}
> @@ -892,7 +892,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			goto setversion_out;
>  		}
>  
> -		inode_lock(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  		handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
>  		if (IS_ERR(handle)) {
>  			err = PTR_ERR(handle);
> @@ -907,7 +907,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		ext4_journal_stop(handle);
>  
>  unlock_out:
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  setversion_out:
>  		mnt_drop_write_file(filp);
>  		return err;
> @@ -1026,9 +1026,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		 * ext4_ext_swap_inode_data before we switch the
>  		 * inode format to prevent read.
>  		 */
> -		inode_lock((inode));
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  		err = ext4_ext_migrate(inode);
> -		inode_unlock((inode));
> +		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  		mnt_drop_write_file(filp);
>  		return err;
>  	}
> @@ -1272,7 +1272,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		if (err)
>  			return err;
>  
> -		inode_lock(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  		ext4_fill_fsxattr(inode, &old_fa);
>  		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
>  		if (err)
> @@ -1287,7 +1287,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			goto out;
>  		err = ext4_ioctl_setproject(filp, fa.fsx_projid);
>  out:
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  		mnt_drop_write_file(filp);
>  		return err;
>  	}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7796e2ffc294..48b83b2cf0ad 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2682,12 +2682,12 @@ static void ext4_orphan_cleanup(struct super_block *sb,
>  					__func__, inode->i_ino, inode->i_size);
>  			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
>  				  inode->i_ino, inode->i_size);
> -			inode_lock(inode);
> +			ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  			truncate_inode_pages(inode->i_mapping, inode->i_size);
>  			ret = ext4_truncate(inode);
>  			if (ret)
>  				ext4_std_error(inode->i_sb, ret);
> -			inode_unlock(inode);
> +			ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  			nr_truncates++;
>  		} else {
>  			if (test_opt(sb, DEBUG))
> @@ -5785,7 +5785,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
>  		 * files. If this fails, we return success anyway since quotas
>  		 * are already enabled and this is not a hard failure.
>  		 */
> -		inode_lock(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  		handle = ext4_journal_start(inode, EXT4_HT_QUOTA, 1);
>  		if (IS_ERR(handle))
>  			goto unlock_inode;
> @@ -5795,7 +5795,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
>  		ext4_mark_inode_dirty(handle, inode);
>  		ext4_journal_stop(handle);
>  	unlock_inode:
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	}
>  	return err;
>  }
> @@ -5887,7 +5887,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
>  	if (err || ext4_has_feature_quota(sb))
>  		goto out_put;
>  
> -	inode_lock(inode);
> +	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  	/*
>  	 * Update modification times of quota files when userspace can
>  	 * start looking at them. If we fail, we return success anyway since
> @@ -5902,7 +5902,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
>  	ext4_mark_inode_dirty(handle, inode);
>  	ext4_journal_stop(handle);
>  out_unlock:
> -	inode_unlock(inode);
> +	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  out_put:
>  	lockdep_set_quota_inode(inode, I_DATA_SEM_NORMAL);
>  	iput(inode);
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 8966a5439a22..5c2dcc4c836a 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -422,9 +422,9 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
>  		ext4_set_inode_state(inode, EXT4_STATE_LUSTRE_EA_INODE);
>  		ext4_xattr_inode_set_ref(inode, 1);
>  	} else {
> -		inode_lock(inode);
> +		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
>  		inode->i_flags |= S_NOQUOTA;
> -		inode_unlock(inode);
> +		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
>  	}
>  
>  	*ea_inode = inode;
> @@ -976,7 +976,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  	u32 hash;
>  	int ret;
>  
> -	inode_lock(ea_inode);
> +	ext4_ilock(ea_inode, EXT4_IOLOCK_EXCL);
>  
>  	ret = ext4_reserve_inode_write(handle, ea_inode, &iloc);
>  	if (ret)
> @@ -1030,7 +1030,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  		ext4_warning_inode(ea_inode,
>  				   "ext4_mark_iloc_dirty() failed ret=%d", ret);
>  out:
> -	inode_unlock(ea_inode);
> +	ext4_iunlock(ea_inode, EXT4_IOLOCK_EXCL);
>  	return ret;
>  }
>  
> @@ -1380,10 +1380,11 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
>  		block += 1;
>  	}
>  
> -	inode_lock(ea_inode);
> +	ext4_ilock(ea_inode, EXT4_IOLOCK_EXCL);
>  	i_size_write(ea_inode, wsize);
>  	ext4_update_i_disksize(ea_inode, wsize);
> -	inode_unlock(ea_inode);
> +	ext4_iunlock(ea_inode, EXT4_IOLOCK_EXCL);
> +
>  
>  	ext4_mark_inode_dirty(handle, ea_inode);
>  
> @@ -1432,9 +1433,9 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
>  		 */
>  		dquot_free_inode(ea_inode);
>  		dquot_drop(ea_inode);
> -		inode_lock(ea_inode);
> +		ext4_ilock(ea_inode, EXT4_IOLOCK_EXCL);
>  		ea_inode->i_flags |= S_NOQUOTA;
> -		inode_unlock(ea_inode);
> +		ext4_iunlock(ea_inode, EXT4_IOLOCK_EXCL);
>  	}
>  
>  	return ea_inode;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
