Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C478B3427
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfIPEhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 00:37:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfIPEhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 00:37:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8G4bX8r137313
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 00:37:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v1x61x4mw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 00:37:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 16 Sep 2019 05:37:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Sep 2019 05:37:44 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8G4bhsh54460562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 04:37:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66F99A4060;
        Mon, 16 Sep 2019 04:37:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCBDEA4054;
        Mon, 16 Sep 2019 04:37:41 +0000 (GMT)
Received: from [9.124.31.57] (unknown [9.124.31.57])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Sep 2019 04:37:41 +0000 (GMT)
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 16 Sep 2019 10:07:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091604-0012-0000-0000-0000034C5FC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091604-0013-0000-0000-00002186D421
Message-Id: <20190916043741.BCBDEA4054@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160049
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 9/12/19 4:34 PM, Matthew Bobrowski wrote:
> This patch introduces a new direct IO write code path implementation
> that makes use of the iomap infrastructure.
> 
> All direct IO write operations are now passed from the ->write_iter()
> callback to the new function ext4_dio_write_iter(). This function is
> responsible for calling into iomap infrastructure via
> iomap_dio_rw(). Snippets of the direct IO code from within
> ext4_file_write_iter(), such as checking whether the IO request is
> unaligned asynchronous IO, or whether it will ber overwriting
> allocated and initialized blocks has been moved out and into
> ext4_dio_write_iter().
> 
> The block mapping flags that are passed to ext4_map_blocks() from
> within ext4_dio_get_block() and friends have effectively been taken
> out and introduced within the ext4_iomap_begin(). If ext4_map_blocks()
> happens to have instantiated blocks beyond the i_size, then we attempt
> to place the inode onto the orphan list. Despite being able to perform
> i_size extension checking earlier on in the direct IO code path, it
> makes most sense to perform this bit post successful block allocation.
> 
> The ->end_io() callback ext4_dio_write_end_io() is responsible for
> removing the inode from the orphan list and determining if we should
> truncate a failed write in the case of an error. We also convert a
> range of unwritten extents to written if IOMAP_DIO_UNWRITTEN is set
> and perform the necessary i_size/i_disksize extension if the
> iocb->ki_pos + dio->size > i_size_read(inode).
> 
> In the instance of a short write, we fallback to buffered IO and
> complete whatever is left the 'iter'. Any blocks that may have been
> allocated in preparation for direct IO will be reused by buffered IO,
> so there's no issue with leaving allocated blocks beyond EOF.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>   fs/ext4/file.c  | 219 +++++++++++++++++++++++++++++++++---------------
>   fs/ext4/inode.c |  57 ++++++++++---
>   2 files changed, 196 insertions(+), 80 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6457c629b8cf..413c7895aa9e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -29,6 +29,7 @@
>   #include <linux/pagevec.h>
>   #include <linux/uio.h>
>   #include <linux/mman.h>
> +#include <linux/backing-dev.h>
>   #include "ext4.h"
>   #include "ext4_jbd2.h"
>   #include "xattr.h"
> @@ -213,12 +214,16 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   	ssize_t ret;
> 
> +	if (unlikely(IS_IMMUTABLE(inode)))
> +		return -EPERM;
> +
>   	ret = generic_write_checks(iocb, from);
>   	if (ret <= 0)
>   		return ret;
> 
> -	if (unlikely(IS_IMMUTABLE(inode)))
> -		return -EPERM;
> +	ret = file_modified(iocb->ki_filp);
> +	if (ret)
> +		return 0;

Why not return ret directly, otherwise we will be returning the wrong
error code to user space. Thoughts?

Do you think simplification/restructuring of this API
"ext4_write_checks" can be a separate patch, so that this patch
only focuses on conversion of DIO write path to iomap?


Also, I think we can make the function (ext4_write_checks())
like below.
This way we call for file_modified() only after we have checked for
write limits, at one place.

   static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter 
*from)
   {
           struct inode *inode = file_inode(iocb->ki_filp);
           ssize_t ret;

           if (unlikely(IS_IMMUTABLE(inode)))
                   return -EPERM;

           ret = generic_write_checks(iocb, from);
           if (ret <= 0)
_                 return ret;
           /*
            * If we have encountered a bitmap-format file, the size limit
            * is smaller than s_maxbytes, which is for extent-mapped files.
            */
           if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
                   struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);

                   if (iocb->ki_pos >= sbi->s_bitmap_maxbytes)
                           return -EFBIG;
                   iov_iter_truncate(from, sbi->s_bitmap_maxbytes - 
iocb->ki_pos);
           }
+
+         ret = file_modified(iocb->ki_filp);
+         if (ret)
+                 return ret;
+
           return iov_iter_count(from);
   }


-ritesh


> 
>   	/*
>   	 * If we have encountered a bitmap-format file, the size limit
> @@ -234,6 +239,32 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	return iov_iter_count(from);
>   }
> 
> +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> +					struct iov_iter *from)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		return -EOPNOTSUPP;
> +
> +	inode_lock(inode);
> +	ret = ext4_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out;
> +
> +	current->backing_dev_info = inode_to_bdi(inode);
> +	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
> +	current->backing_dev_info = NULL;
> +out:
> +	inode_unlock(inode);
> +	if (likely(ret > 0)) {
> +		iocb->ki_pos += ret;
> +		ret = generic_write_sync(iocb, ret);
> +	}
> +	return ret;
> +}
> +
>   static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>   				       ssize_t len, size_t count)
>   {
> @@ -310,6 +341,120 @@ static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
>   	return 0;
>   }
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
> +	return 0;
> +}
> +
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
>   #ifdef CONFIG_FS_DAX
>   static ssize_t
>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> @@ -324,15 +469,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   			return -EAGAIN;
>   		inode_lock(inode);
>   	}
> +
>   	ret = ext4_write_checks(iocb, from);
>   	if (ret <= 0)
>   		goto out;
> -	ret = file_remove_privs(iocb->ki_filp);
> -	if (ret)
> -		goto out;
> -	ret = file_update_time(iocb->ki_filp);
> -	if (ret)
> -		goto out;
> 
>   	offset = iocb->ki_pos;
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> @@ -358,73 +498,16 @@ static ssize_t
>   ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
>   	struct inode *inode = file_inode(iocb->ki_filp);
> -	int o_direct = iocb->ki_flags & IOCB_DIRECT;
> -	int unaligned_aio = 0;
> -	int overwrite = 0;
> -	ssize_t ret;
> 
>   	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>   		return -EIO;
> 
> -#ifdef CONFIG_FS_DAX
>   	if (IS_DAX(inode))
>   		return ext4_dax_write_iter(iocb, from);
> -#endif
> -	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
> -		return -EOPNOTSUPP;
> 
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> -			return -EAGAIN;
> -		inode_lock(inode);
> -	}
> -
> -	ret = ext4_write_checks(iocb, from);
> -	if (ret <= 0)
> -		goto out;
> -
> -	/*
> -	 * Unaligned direct AIO must be serialized among each other as zeroing
> -	 * of partial blocks of two competing unaligned AIOs can result in data
> -	 * corruption.
> -	 */
> -	if (o_direct && ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
> -	    !is_sync_kiocb(iocb) &&
> -	    ext4_unaligned_aio(inode, from, iocb->ki_pos)) {
> -		unaligned_aio = 1;
> -		ext4_unwritten_wait(inode);
> -	}
> -
> -	iocb->private = &overwrite;
> -	/* Check whether we do a DIO overwrite or not */
> -	if (o_direct && !unaligned_aio) {
> -		if (ext4_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from))) {
> -			if (ext4_should_dioread_nolock(inode))
> -				overwrite = 1;
> -		} else if (iocb->ki_flags & IOCB_NOWAIT) {
> -			ret = -EAGAIN;
> -			goto out;
> -		}
> -	}
> -
> -	ret = __generic_file_write_iter(iocb, from);
> -	/*
> -	 * Unaligned direct AIO must be the only IO in flight. Otherwise
> -	 * overlapping aligned IO after unaligned might result in data
> -	 * corruption.
> -	 */
> -	if (ret == -EIOCBQUEUED && unaligned_aio)
> -		ext4_unwritten_wait(inode);
> -	inode_unlock(inode);
> -
> -	if (ret > 0)
> -		ret = generic_write_sync(iocb, ret);
> -
> -	return ret;
> -
> -out:
> -	inode_unlock(inode);
> -	return ret;
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return ext4_dio_write_iter(iocb, from);
> +	return ext4_buffered_write_iter(iocb, from);
>   }
> 
>   #ifdef CONFIG_FS_DAX
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index efb184928e51..f52ad3065236 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3513,11 +3513,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			}
>   		}
>   	} else if (flags & IOMAP_WRITE) {
> -		int dio_credits;
>   		handle_t *handle;
> -		int retries = 0;
> +		int dio_credits, retries = 0, m_flags = 0;
> 
> -		/* Trim mapping request to maximum we can map at once for DIO */
> +		/*
> +		 * Trim mapping request to maximum we can map at once
> +		 * for DIO.
> +		 */
>   		if (map.m_len > DIO_MAX_BLOCKS)
>   			map.m_len = DIO_MAX_BLOCKS;
>   		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
> @@ -3533,8 +3535,30 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		if (IS_ERR(handle))
>   			return PTR_ERR(handle);
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
>   		if (ret < 0) {
>   			ext4_journal_stop(handle);
>   			if (ret == -ENOSPC &&
> @@ -3544,13 +3568,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		}
> 
>   		/*
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
>   		 */
>   		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
>   		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> @@ -3612,6 +3637,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>   			  ssize_t written, unsigned flags, struct iomap *iomap)
>   {
> +	/*
> +	 * Check to see whether an error occurred while writing data
> +	 * out to allocated blocks. If so, return the magic error code
> +	 * so that we fallback to buffered IO and reuse the blocks
> +	 * that were allocated in preparation for the direct IO write.
> +	 */
> +	if (flags & IOMAP_DIRECT && written == 0)
> +		return -ENOTBLK;
>   	return 0;
>   }
> 

