Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B825AD5DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbfIIJgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 05:36:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57536 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389977AbfIIJgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:36:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x899Vtum117034
        for <linux-fsdevel@vger.kernel.org>; Mon, 9 Sep 2019 05:36:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uv7c2q1r7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 05:36:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 9 Sep 2019 10:36:45 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 10:36:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x899adWe28049788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 09:36:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A63342057;
        Mon,  9 Sep 2019 09:36:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174F642049;
        Mon,  9 Sep 2019 09:36:36 +0000 (GMT)
Received: from [9.199.158.183] (unknown [9.199.158.183])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 09:36:35 +0000 (GMT)
Subject: Re: [PATCH v2 6/6] ext4: cleanup legacy buffer_head direct IO code
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <8c22105d832117969690af05d13782e69fb7619a.1567978633.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 9 Sep 2019 15:06:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8c22105d832117969690af05d13782e69fb7619a.1567978633.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090909-0016-0000-0000-000002A8B328
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090909-0017-0000-0000-0000330933AE
Message-Id: <20190909093636.174F642049@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/9/19 4:50 AM, Matthew Bobrowski wrote:
> Remove buffer_head direct IO code that is now redundant as a result of
> porting across the read/write paths to use iomap infrastructure.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/ext4.h    |   3 -
>   fs/ext4/extents.c |  11 +-
>   fs/ext4/file.c    |   7 -
>   fs/ext4/inode.c   | 398 +---------------------------------------------
>   4 files changed, 5 insertions(+), 414 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bf660aa7a9e0..2ab91815f52d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1555,7 +1555,6 @@ enum {
>   	EXT4_STATE_NO_EXPAND,		/* No space for expansion */
>   	EXT4_STATE_DA_ALLOC_CLOSE,	/* Alloc DA blks on close */
>   	EXT4_STATE_EXT_MIGRATE,		/* Inode is migrating */
> -	EXT4_STATE_DIO_UNWRITTEN,	/* need convert on dio done*/
>   	EXT4_STATE_NEWENTRY,		/* File just added to dir */
>   	EXT4_STATE_MAY_INLINE_DATA,	/* may have in-inode data */
>   	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
> @@ -2522,8 +2521,6 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
>   			     struct buffer_head *bh_result, int create);
>   int ext4_get_block(struct inode *inode, sector_t iblock,
>   		   struct buffer_head *bh_result, int create);
> -int ext4_dio_get_block(struct inode *inode, sector_t iblock,
> -		       struct buffer_head *bh_result, int create);
>   int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
>   			   struct buffer_head *bh, int create);
>   int ext4_walk_page_buffers(handle_t *handle,
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 92266a2da7d6..a869e206bd81 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1753,16 +1753,9 @@ ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent *ex1,
>   	 */
>   	if (ext1_ee_len + ext2_ee_len > EXT_INIT_MAX_LEN)
>   		return 0;
> -	/*
> -	 * The check for IO to unwritten extent is somewhat racy as we
> -	 * increment i_unwritten / set EXT4_STATE_DIO_UNWRITTEN only after
> -	 * dropping i_data_sem. But reserved blocks should save us in that
> -	 * case.
> -	 */
> +
>   	if (ext4_ext_is_unwritten(ex1) &&
> -	    (ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) ||
> -	     atomic_read(&EXT4_I(inode)->i_unwritten) ||
> -	     (ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN)))
> +	    (ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN))
>   		return 0;
>   #ifdef AGGRESSIVE_TEST
>   	if (ext1_ee_len >= 4)
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index bf22425a6a6f..d4b9a82aed6c 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -155,13 +155,6 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>   	return 0;
>   }
> 
> -static void ext4_unwritten_wait(struct inode *inode)
> -{
> -	wait_queue_head_t *wq = ext4_ioend_wq(inode);
> -
> -	wait_event(*wq, (atomic_read(&EXT4_I(inode)->i_unwritten) == 0));
> -}
> -
>   /*
>    * This tests whether the IO in question is block-aligned or not.
>    * Ext4 utilizes unwritten extents when hole-filling during direct IO, and they
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f52ad3065236..a4f0749527c7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -826,136 +826,6 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
>   /* Maximum number of blocks we map for direct IO at once. */
>   #define DIO_MAX_BLOCKS 4096
> 
> -/*
> - * Get blocks function for the cases that need to start a transaction -
> - * generally difference cases of direct IO and DAX IO. It also handles retries
> - * in case of ENOSPC.
> - */
> -static int ext4_get_block_trans(struct inode *inode, sector_t iblock,
> -				struct buffer_head *bh_result, int flags)
> -{
> -	int dio_credits;
> -	handle_t *handle;
> -	int retries = 0;
> -	int ret;
> -
> -	/* Trim mapping request to maximum we can map at once for DIO */
> -	if (bh_result->b_size >> inode->i_blkbits > DIO_MAX_BLOCKS)
> -		bh_result->b_size = DIO_MAX_BLOCKS << inode->i_blkbits;
> -	dio_credits = ext4_chunk_trans_blocks(inode,
> -				      bh_result->b_size >> inode->i_blkbits);
> -retry:
> -	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
> -	if (IS_ERR(handle))
> -		return PTR_ERR(handle);
> -
> -	ret = _ext4_get_block(inode, iblock, bh_result, flags);
> -	ext4_journal_stop(handle);
> -
> -	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> -		goto retry;
> -	return ret;
> -}
> -
> -/* Get block function for DIO reads and writes to inodes without extents */
> -int ext4_dio_get_block(struct inode *inode, sector_t iblock,
> -		       struct buffer_head *bh, int create)
> -{
> -	/* We don't expect handle for direct IO */
> -	WARN_ON_ONCE(ext4_journal_current_handle());
> -
> -	if (!create)
> -		return _ext4_get_block(inode, iblock, bh, 0);
> -	return ext4_get_block_trans(inode, iblock, bh, EXT4_GET_BLOCKS_CREATE);
> -}
> -
> -/*
> - * Get block function for AIO DIO writes when we create unwritten extent if
> - * blocks are not allocated yet. The extent will be converted to written
> - * after IO is complete.
> - */
> -static int ext4_dio_get_block_unwritten_async(struct inode *inode,
> -		sector_t iblock, struct buffer_head *bh_result,	int create)
> -{
> -	int ret;
> -
> -	/* We don't expect handle for direct IO */
> -	WARN_ON_ONCE(ext4_journal_current_handle());
> -
> -	ret = ext4_get_block_trans(inode, iblock, bh_result,
> -				   EXT4_GET_BLOCKS_IO_CREATE_EXT);
> -
> -	/*
> -	 * When doing DIO using unwritten extents, we need io_end to convert
> -	 * unwritten extents to written on IO completion. We allocate io_end
> -	 * once we spot unwritten extent and store it in b_private. Generic
> -	 * DIO code keeps b_private set and furthermore passes the value to
> -	 * our completion callback in 'private' argument.
> -	 */
> -	if (!ret && buffer_unwritten(bh_result)) {
> -		if (!bh_result->b_private) {
> -			ext4_io_end_t *io_end;
> -
> -			io_end = ext4_init_io_end(inode, GFP_KERNEL);
> -			if (!io_end)
> -				return -ENOMEM;
> -			bh_result->b_private = io_end;
> -			ext4_set_io_unwritten_flag(inode, io_end);
> -		}
> -		set_buffer_defer_completion(bh_result);
> -	}
> -
> -	return ret;
> -}
> -
> -/*
> - * Get block function for non-AIO DIO writes when we create unwritten extent if
> - * blocks are not allocated yet. The extent will be converted to written
> - * after IO is complete by ext4_direct_IO_write().
> - */
> -static int ext4_dio_get_block_unwritten_sync(struct inode *inode,
> -		sector_t iblock, struct buffer_head *bh_result,	int create)
> -{
> -	int ret;
> -
> -	/* We don't expect handle for direct IO */
> -	WARN_ON_ONCE(ext4_journal_current_handle());
> -
> -	ret = ext4_get_block_trans(inode, iblock, bh_result,
> -				   EXT4_GET_BLOCKS_IO_CREATE_EXT);
> -
> -	/*
> -	 * Mark inode as having pending DIO writes to unwritten extents.
> -	 * ext4_direct_IO_write() checks this flag and converts extents to
> -	 * written.
> -	 */
> -	if (!ret && buffer_unwritten(bh_result))
> -		ext4_set_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN);
> -
> -	return ret;
> -}
> -
> -static int ext4_dio_get_block_overwrite(struct inode *inode, sector_t iblock,
> -		   struct buffer_head *bh_result, int create)
> -{
> -	int ret;
> -
> -	ext4_debug("ext4_dio_get_block_overwrite: inode %lu, create flag %d\n",
> -		   inode->i_ino, create);
> -	/* We don't expect handle for direct IO */
> -	WARN_ON_ONCE(ext4_journal_current_handle());
> -
> -	ret = _ext4_get_block(inode, iblock, bh_result, 0);
> -	/*
> -	 * Blocks should have been preallocated! ext4_file_write_iter() checks
> -	 * that.
> -	 */
> -	WARN_ON_ONCE(!buffer_mapped(bh_result) || buffer_unwritten(bh_result));
> -
> -	return ret;
> -}
> -
> -
>   /*
>    * `handle' can be NULL if create is zero
>    */
> @@ -3653,268 +3523,6 @@ const struct iomap_ops ext4_iomap_ops = {
>   	.iomap_end		= ext4_iomap_end,
>   };
> 
> -static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
> -			    ssize_t size, void *private)
> -{
> -        ext4_io_end_t *io_end = private;
> -
> -	/* if not async direct IO just return */
> -	if (!io_end)
> -		return 0;
> -
> -	ext_debug("ext4_end_io_dio(): io_end 0x%p "
> -		  "for inode %lu, iocb 0x%p, offset %llu, size %zd\n",
> -		  io_end, io_end->inode->i_ino, iocb, offset, size);
> -
> -	/*
> -	 * Error during AIO DIO. We cannot convert unwritten extents as the
> -	 * data was not written. Just clear the unwritten flag and drop io_end.
> -	 */
> -	if (size <= 0) {
> -		ext4_clear_io_unwritten_flag(io_end);
> -		size = 0;
> -	}
> -	io_end->offset = offset;
> -	io_end->size = size;
> -	ext4_put_io_end(io_end);
> -
> -	return 0;
> -}
> -
> -/*
> - * Handling of direct IO writes.
> - *
> - * For ext4 extent files, ext4 will do direct-io write even to holes,
> - * preallocated extents, and those write extend the file, no need to
> - * fall back to buffered IO.
> - *
> - * For holes, we fallocate those blocks, mark them as unwritten
> - * If those blocks were preallocated, we mark sure they are split, but
> - * still keep the range to write as unwritten.
> - *
> - * The unwritten extents will be converted to written when DIO is completed.
> - * For async direct IO, since the IO may still pending when return, we
> - * set up an end_io call back function, which will do the conversion
> - * when async direct IO completed.
> - *
> - * If the O_DIRECT write will extend the file then add this inode to the
> - * orphan list.  So recovery will truncate it back to the original size
> - * if the machine crashes during the write.
> - *
> - */
> -static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
> -{
> -	struct file *file = iocb->ki_filp;
> -	struct inode *inode = file->f_mapping->host;
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -	ssize_t ret;
> -	loff_t offset = iocb->ki_pos;
> -	size_t count = iov_iter_count(iter);
> -	int overwrite = 0;
> -	get_block_t *get_block_func = NULL;
> -	int dio_flags = 0;
> -	loff_t final_size = offset + count;
> -	int orphan = 0;
> -	handle_t *handle;
> -
> -	if (final_size > inode->i_size || final_size > ei->i_disksize) {
> -		/* Credits for sb + inode write */
> -		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> -		if (IS_ERR(handle)) {
> -			ret = PTR_ERR(handle);
> -			goto out;
> -		}
> -		ret = ext4_orphan_add(handle, inode);
> -		if (ret) {
> -			ext4_journal_stop(handle);
> -			goto out;
> -		}
> -		orphan = 1;
> -		ext4_update_i_disksize(inode, inode->i_size);
> -		ext4_journal_stop(handle);
> -	}
> -
> -	BUG_ON(iocb->private == NULL);
> -
> -	/*
> -	 * Make all waiters for direct IO properly wait also for extent
> -	 * conversion. This also disallows race between truncate() and
> -	 * overwrite DIO as i_dio_count needs to be incremented under i_mutex.
> -	 */
> -	inode_dio_begin(inode);
> -
> -	/* If we do a overwrite dio, i_mutex locking can be released */
> -	overwrite = *((int *)iocb->private);
> -
> -	if (overwrite)
> -		inode_unlock(inode);
> -
> -	/*
> -	 * For extent mapped files we could direct write to holes and fallocate.
> -	 *
> -	 * Allocated blocks to fill the hole are marked as unwritten to prevent
> -	 * parallel buffered read to expose the stale data before DIO complete
> -	 * the data IO.
> -	 *
> -	 * As to previously fallocated extents, ext4 get_block will just simply
> -	 * mark the buffer mapped but still keep the extents unwritten.
> -	 *
> -	 * For non AIO case, we will convert those unwritten extents to written
> -	 * after return back from blockdev_direct_IO. That way we save us from
> -	 * allocating io_end structure and also the overhead of offloading
> -	 * the extent convertion to a workqueue.
> -	 *
> -	 * For async DIO, the conversion needs to be deferred when the
> -	 * IO is completed. The ext4 end_io callback function will be
> -	 * called to take care of the conversion work.  Here for async
> -	 * case, we allocate an io_end structure to hook to the iocb.
> -	 */
> -	iocb->private = NULL;
> -	if (overwrite)
> -		get_block_func = ext4_dio_get_block_overwrite;
> -	else if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) ||
> -		   round_down(offset, i_blocksize(inode)) >= inode->i_size) {
> -		get_block_func = ext4_dio_get_block;
> -		dio_flags = DIO_LOCKING | DIO_SKIP_HOLES;
> -	} else if (is_sync_kiocb(iocb)) {
> -		get_block_func = ext4_dio_get_block_unwritten_sync;
> -		dio_flags = DIO_LOCKING;
> -	} else {
> -		get_block_func = ext4_dio_get_block_unwritten_async;
> -		dio_flags = DIO_LOCKING;
> -	}
> -	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
> -				   get_block_func, ext4_end_io_dio, NULL,
> -				   dio_flags);
> -
> -	if (ret > 0 && !overwrite && ext4_test_inode_state(inode,
> -						EXT4_STATE_DIO_UNWRITTEN)) {
> -		int err;
> -		/*
> -		 * for non AIO case, since the IO is already
> -		 * completed, we could do the conversion right here
> -		 */
> -		err = ext4_convert_unwritten_extents(NULL, inode,
> -						     offset, ret);
> -		if (err < 0)
> -			ret = err;
> -		ext4_clear_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN);
> -	}
> -
> -	inode_dio_end(inode);
> -	/* take i_mutex locking again if we do a ovewrite dio */
> -	if (overwrite)
> -		inode_lock(inode);
> -
> -	if (ret < 0 && final_size > inode->i_size)
> -		ext4_truncate_failed_write(inode);
> -
> -	/* Handle extending of i_size after direct IO write */
> -	if (orphan) {
> -		int err;
> -
> -		/* Credits for sb + inode write */
> -		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> -		if (IS_ERR(handle)) {
> -			/*
> -			 * We wrote the data but cannot extend
> -			 * i_size. Bail out. In async io case, we do
> -			 * not return error here because we have
> -			 * already submmitted the corresponding
> -			 * bio. Returning error here makes the caller
> -			 * think that this IO is done and failed
> -			 * resulting in race with bio's completion
> -			 * handler.
> -			 */
> -			if (!ret)
> -				ret = PTR_ERR(handle);
> -			if (inode->i_nlink)
> -				ext4_orphan_del(NULL, inode);
> -
> -			goto out;
> -		}
> -		if (inode->i_nlink)
> -			ext4_orphan_del(handle, inode);
> -		if (ret > 0) {
> -			loff_t end = offset + ret;
> -			if (end > inode->i_size || end > ei->i_disksize) {
> -				ext4_update_i_disksize(inode, end);
> -				if (end > inode->i_size)
> -					i_size_write(inode, end);
> -				/*
> -				 * We're going to return a positive `ret'
> -				 * here due to non-zero-length I/O, so there's
> -				 * no way of reporting error returns from
> -				 * ext4_mark_inode_dirty() to userspace.  So
> -				 * ignore it.
> -				 */
> -				ext4_mark_inode_dirty(handle, inode);
> -			}
> -		}
> -		err = ext4_journal_stop(handle);
> -		if (ret == 0)
> -			ret = err;
> -	}
> -out:
> -	return ret;
> -}
> -
> -static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
> -{
> -	struct address_space *mapping = iocb->ki_filp->f_mapping;
> -	struct inode *inode = mapping->host;
> -	size_t count = iov_iter_count(iter);
> -	ssize_t ret;
> -
> -	/*
> -	 * Shared inode_lock is enough for us - it protects against concurrent
> -	 * writes & truncates and since we take care of writing back page cache,
> -	 * we are protected against page writeback as well.
> -	 */
> -	inode_lock_shared(inode);
> -	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
> -					   iocb->ki_pos + count - 1);
> -	if (ret)
> -		goto out_unlock;
> -	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
> -				   iter, ext4_dio_get_block, NULL, NULL, 0);
> -out_unlock:
> -	inode_unlock_shared(inode);
> -	return ret;
> -}
> -
> -static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> -{
> -	struct file *file = iocb->ki_filp;
> -	struct inode *inode = file->f_mapping->host;
> -	size_t count = iov_iter_count(iter);
> -	loff_t offset = iocb->ki_pos;
> -	ssize_t ret;
> -
> -#ifdef CONFIG_FS_ENCRYPTION
> -	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> -		return 0;
> -#endif
> -
> -	/*
> -	 * If we are doing data journalling we don't support O_DIRECT
> -	 */
> -	if (ext4_should_journal_data(inode))
> -		return 0;
> -
> -	/* Let buffer I/O handle the inline data case. */
> -	if (ext4_has_inline_data(inode))
> -		return 0;
> -
> -	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> -	if (iov_iter_rw(iter) == READ)
> -		ret = ext4_direct_IO_read(iocb, iter);
> -	else
> -		ret = ext4_direct_IO_write(iocb, iter);
> -	trace_ext4_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), ret);
> -	return ret;
> -}
> -
>   /*
>    * Pages can be marked dirty completely asynchronously from ext4's journalling
>    * activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.  We cannot do
> @@ -3952,7 +3560,7 @@ static const struct address_space_operations ext4_aops = {
>   	.bmap			= ext4_bmap,
>   	.invalidatepage		= ext4_invalidatepage,
>   	.releasepage		= ext4_releasepage,
> -	.direct_IO		= ext4_direct_IO,
> +	.direct_IO		= noop_direct_IO,
>   	.migratepage		= buffer_migrate_page,
>   	.is_partially_uptodate  = block_is_partially_uptodate,
>   	.error_remove_page	= generic_error_remove_page,
> @@ -3969,7 +3577,7 @@ static const struct address_space_operations ext4_journalled_aops = {
>   	.bmap			= ext4_bmap,
>   	.invalidatepage		= ext4_journalled_invalidatepage,
>   	.releasepage		= ext4_releasepage,
> -	.direct_IO		= ext4_direct_IO,
> +	.direct_IO		= noop_direct_IO,
>   	.is_partially_uptodate  = block_is_partially_uptodate,
>   	.error_remove_page	= generic_error_remove_page,
>   };
> @@ -3985,7 +3593,7 @@ static const struct address_space_operations ext4_da_aops = {
>   	.bmap			= ext4_bmap,
>   	.invalidatepage		= ext4_da_invalidatepage,
>   	.releasepage		= ext4_releasepage,
> -	.direct_IO		= ext4_direct_IO,
> +	.direct_IO		= noop_direct_IO,
>   	.migratepage		= buffer_migrate_page,
>   	.is_partially_uptodate  = block_is_partially_uptodate,
>   	.error_remove_page	= generic_error_remove_page,
> 

