Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202FAA0B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfH1U0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 16:26:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfH1U0X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:26:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4A58B67E;
        Wed, 28 Aug 2019 20:26:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 86EE31E4362; Wed, 28 Aug 2019 22:26:19 +0200 (CEST)
Date:   Wed, 28 Aug 2019 22:26:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190828202619.GG22343@quack2.suse.cz>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-08-19 22:53:26, Matthew Bobrowski wrote:
> This patch introduces a new direct IO write code path implementation
> that makes use of the iomap infrastructure.
> 
> All direct IO write operations are now passed from the ->write_iter() callback
> to the new function ext4_dio_write_iter(). This function is responsible for
> calling into iomap infrastructure via iomap_dio_rw(). Snippets of the direct
> IO code from within ext4_file_write_iter(), such as checking whether the IO
> request is unaligned asynchronous IO, or whether it will ber overwriting
> allocated and initialized blocks has been moved out and into
> ext4_dio_write_iter().
> 
> The block mapping flags that are passed to ext4_map_blocks() from within
> ext4_dio_get_block() and friends have effectively been taken out and
> introduced within the ext4_iomap_begin(). If ext4_map_blocks() happens to have
> instantiated blocks beyond the i_size, then we attempt to place the inode onto
> the orphan list. Despite being able to perform i_size extension checking
> earlier on in the direct IO code path, it makes most sense to perform this bit
> post successful block allocation.
> 
> The ->end_io() callback ext4_dio_write_end_io() is responsible for removing
> the inode from the orphan list and determining if we should truncate a failed
> write in the case of an error. We also convert a range of unwritten extents to
> written if IOMAP_DIO_UNWRITTEN is set and perform the necessary
> i_size/i_disksize extension if the iocb->ki_pos + dio->size > i_size_read(inode).
> 
> In the instance of a short write, we fallback to buffered IO and complete
> whatever is left the 'iter'. Any blocks that may have been allocated in
> preparation for direct IO will be reused by buffered IO, so there's no issue
> with leaving allocated blocks beyond EOF.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  fs/ext4/file.c  | 227 ++++++++++++++++++++++++++++++++++++++++----------------
>  fs/ext4/inode.c |  42 +++++++++--
>  2 files changed, 199 insertions(+), 70 deletions(-)

Overall this is very nice. Some smaller comments below.

> @@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	return iov_iter_count(from);
>  }
>  
> +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> +					struct iov_iter *from)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (!inode_trylock(inode)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EOPNOTSUPP;
> +		inode_lock(inode);
> +	}

Currently there's no support for IOCB_NOWAIT for buffered IO so you can
replace this with "inode_lock(inode)".

> @@ -284,6 +321,128 @@ static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
>  	return ret;
>  }
>  

I'd mention here that for cases where inode size is extended,
ext4_dio_write_iter() waits for DIO to complete and thus we are protected
by inode_lock in that case.

> +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> +				 ssize_t error, unsigned int flags)
> +{
> +	int ret = 0;
> +	handle_t *handle;
> +	loff_t offset = iocb->ki_pos;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error) {
> +		if (offset + size > i_size_read(inode))
> +			ext4_truncate_failed_write(inode);
> +
> +		/*
> +		 * The inode may have been placed onto the orphan list
> +		 * as a result of an extension. However, an error may
> +		 * have been encountered prior to being able to
> +		 * complete the write operation. Perform any necessary
> +		 * clean up in this case.
> +		 */
> +		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +			if (IS_ERR(handle)) {
> +				if (inode->i_nlink)
> +					ext4_orphan_del(NULL, inode);
> +				return PTR_ERR(handle);
> +			}
> +
> +			if (inode->i_nlink)
> +				ext4_orphan_del(handle, inode);
> +			ext4_journal_stop(handle);
> +		}
> +		return error;
> +	}
> +
> +	if (flags & IOMAP_DIO_UNWRITTEN) {
> +		ret = ext4_convert_unwritten_extents(NULL, inode, offset, size);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (offset + size > i_size_read(inode)) {
> +		ret = ext4_handle_inode_extension(inode, offset + size, 0);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
> +static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	ssize_t ret;
> +	loff_t offset = iocb->ki_pos;
> +	size_t count = iov_iter_count(from);
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
> +	if (ret <= 0)
> +		goto out;
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
> +
> +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
> +
> +	/*
> +	 * Unaligned direct AIO must be the only IO in flight or else
> +	 * any overlapping aligned IO after unaligned IO might result
> +	 * in data corruption.
> +	 */

Here I'd expand the comment to explain that we wait in case inode is
extended so that inode extension in ext4_dio_write_end_io() is properly
covered by inode_lock.

> +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> +		inode_dio_wait(inode);
> +
> +	if (ret >= 0 && iov_iter_count(from)) {
> +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> +		return ext4_buffered_write_iter(iocb, from);
> +	}
> +out:
> +	overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_FS_DAX
>  static ssize_t
>  ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)

...

> @@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>  			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
>  		} else {
>  			WARN_ON_ONCE(1);
>  			return -EIO;

Possibly this hunk should go into a separate patch (since this is not
directly related with iomap conversion) with a changelog / comment
explaining why we need to check EXT4_MAP_UNWRITTEN first.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
