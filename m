Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B6BBD94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfIWVJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 17:09:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388750AbfIWVJ7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:09:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B26AAC69;
        Mon, 23 Sep 2019 21:09:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 281871E4669; Mon, 23 Sep 2019 23:10:11 +0200 (CEST)
Date:   Mon, 23 Sep 2019 23:10:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190923211011.GH20367@quack2.suse.cz>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'll try to comment just on top of refactoring Christoph has suggested...

On Thu 12-09-19 21:04:46, Matthew Bobrowski wrote:
> @@ -310,6 +341,120 @@ static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
>  	return 0;
>  }
>  
> +/*
> + * For a write that extends the inode size, ext4_dio_write_iter() will
> + * wait for the write to complete. Consequently, operations performed
> + * within this function are still covered by the inode_lock(). On
> + * success, this function returns 0.
> + */
> +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> +				 unsigned int flags)
> +{
> +	int ret;
> +	loff_t offset = iocb->ki_pos;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error) {
> +		ret = ext4_handle_failed_inode_extension(inode, offset + size);
> +		return ret ? ret : error;
> +	}
> +
> +	if (flags & IOMAP_DIO_UNWRITTEN) {
> +		ret = ext4_convert_unwritten_extents(NULL, inode,
> +						     offset, size);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (offset + size > i_size_read(inode)) {
> +		ret = ext4_handle_inode_extension(inode, offset, size, 0);
> +		if (ret)
> +			return ret;
> +	}

With the suggestions I made to your patch 3/6 this could be simplified to:

	if (!error && flags & IOMAP_DIO_UNWRITTEN) {
		error = ext4_convert_unwritten_extents(NULL, inode, offset,
						       size);
	}
	return ext4_handle_inode_extension(inode, offset, error ? : size, size);


Note the change that when ext4_convert_unwritten_extents() fails (although
this should not really happen unless there's some corruption going on), we
do properly truncate possible extents beyond i_size.

> +static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	ssize_t ret;
> +	size_t count;
> +	loff_t offset = iocb->ki_pos;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	bool extend = false, overwrite = false, unaligned_aio = false;
> +
> +	if (!inode_trylock(inode)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		inode_lock(inode);
> +	}
> +
> +	if (!ext4_dio_checks(inode)) {
> +		inode_unlock(inode);
> +		/*
> +		 * Fallback to buffered IO if the operation on the
> +		 * inode is not supported by direct IO.
> +		 */
> +		return ext4_buffered_write_iter(iocb, from);
> +	}
> +
> +	ret = ext4_write_checks(iocb, from);
> +	if (ret <= 0) {
> +		inode_unlock(inode);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Unaligned direct AIO must be serialized among each other as
> +	 * the zeroing of partial blocks of two competing unaligned
> +	 * AIOs can result in data corruption.
> +	 */
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
> +	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
> +		unaligned_aio = true;
> +		inode_dio_wait(inode);
> +	}
> +
> +	/*
> +	 * Determine whether the IO operation will overwrite allocated
> +	 * and initialized blocks. If so, check to see whether it is
> +	 * possible to take the dioread_nolock path.
> +	 */
> +	count = iov_iter_count(from);
> +	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
> +	    ext4_should_dioread_nolock(inode)) {
> +		overwrite = true;
> +		downgrade_write(&inode->i_rwsem);
> +	}
> +
> +	if (offset + count > i_size_read(inode) ||
> +	    offset + count > EXT4_I(inode)->i_disksize) {
> +		ext4_update_i_disksize(inode, inode->i_size);
> +		extend = true;
> +	}

This call to ext4_update_i_disksize() is definitely wrong. If nothing else,
you need to also have transaction started and call ext4_mark_inode_dirty()
to actually journal the change of i_disksize (ext4_update_i_disksize()
updates only the in-memory copy of the entry). Also the direct IO code
needs to add the inode to the orphan list so that in case of crash, blocks
allocated beyond EOF get truncated on next mount. That is the whole point
of this excercise with i_disksize after all.

But I'm wondering if i_disksize update is needed. Truncate cannot be in
progress (we hold i_rwsem) and dirty pages will be flushed by
iomap_dio_rw() before we start to allocate any blocks. So it should be
enough to have here:

	if (offset + count > i_size_read(inode)) {
		/*
		 * Add inode to orphan list so that blocks allocated beyond
		 * EOF get properly truncated in case of crash.
		 */
		start transaction handle
		add inode to orphan list
		stop transaction handle
	}

And just leave i_disksize at whatever it currently is.

> +
> +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
> +
> +	/*
> +	 * Unaligned direct AIO must be the only IO in flight or else
> +	 * any overlapping aligned IO after unaligned IO might result
> +	 * in data corruption. We also need to wait here in the case
> +	 * where the inode is being extended so that inode extension
> +	 * routines in ext4_dio_write_end_io() are covered by the
> +	 * inode_lock().
> +	 */
> +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> +		inode_dio_wait(inode);
> +
> +	if (overwrite)
> +		inode_unlock_shared(inode);
> +	else
> +		inode_unlock(inode);
> +
> +	if (ret >= 0 && iov_iter_count(from))
> +		return ext4_buffered_write_iter(iocb, from);
> +	return ret;
> +}
> +
...
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index efb184928e51..f52ad3065236 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3513,11 +3513,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			}
>  		}
>  	} else if (flags & IOMAP_WRITE) {
> -		int dio_credits;
>  		handle_t *handle;
> -		int retries = 0;
> +		int dio_credits, retries = 0, m_flags = 0;
>  
> -		/* Trim mapping request to maximum we can map at once for DIO */
> +		/*
> +		 * Trim mapping request to maximum we can map at once
> +		 * for DIO.
> +		 */
>  		if (map.m_len > DIO_MAX_BLOCKS)
>  			map.m_len = DIO_MAX_BLOCKS;
>  		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
> @@ -3533,8 +3535,30 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		if (IS_ERR(handle))
>  			return PTR_ERR(handle);
>  
> -		ret = ext4_map_blocks(handle, inode, &map,
> -				      EXT4_GET_BLOCKS_CREATE_ZERO);
> +		/*
> +		 * DAX and direct IO are the only two operations that
> +		 * are currently supported with IOMAP_WRITE.
> +		 */
> +		WARN_ON(!IS_DAX(inode) && !(flags & IOMAP_DIRECT));
> +		if (IS_DAX(inode))
> +			m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
> +		else if (round_down(offset, i_blocksize(inode)) >=
> +			 i_size_read(inode))
> +			m_flags = EXT4_GET_BLOCKS_CREATE;
> +		else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +			m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +
> +		ret = ext4_map_blocks(handle, inode, &map, m_flags);
> +
> +		/*
> +		 * We cannot fill holes in indirect tree based inodes
> +		 * as that could expose stale data in the case of a
> +		 * crash. Use the magic error code to fallback to
> +		 * buffered IO.
> +		 */
> +		if (!m_flags && !ret)
> +			ret = -ENOTBLK;
> +
>  		if (ret < 0) {
>  			ext4_journal_stop(handle);
>  			if (ret == -ENOSPC &&
> @@ -3544,13 +3568,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		}
>  
>  		/*
> -		 * If we added blocks beyond i_size, we need to make sure they
> -		 * will get truncated if we crash before updating i_size in
> -		 * ext4_iomap_end(). For faults we don't need to do that (and
> -		 * even cannot because for orphan list operations inode_lock is
> -		 * required) - if we happen to instantiate block beyond i_size,
> -		 * it is because we race with truncate which has already added
> -		 * the inode to the orphan list.
> +		 * If we added blocks beyond i_size, we need to make
> +		 * sure they will get truncated if we crash before
> +		 * updating the i_size. For faults we don't need to do
> +		 * that (and even cannot because for orphan list
> +		 * operations inode_lock is required) - if we happen
> +		 * to instantiate block beyond i_size, it is because
> +		 * we race with truncate which has already added the
> +		 * inode to the orphan list.
>  		 */

Just a nit but it would be nice to use full width of 80 columns when
formatting comments so that they don't get unnecessarily long.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
