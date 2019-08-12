Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5417F8A3F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfHLREi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 13:04:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbfHLREi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:04:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CH2MWo035859
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 13:04:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ub9m0qaja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 13:04:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 12 Aug 2019 18:04:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 18:04:32 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CH4Vlh58392624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 17:04:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CCAC5204F;
        Mon, 12 Aug 2019 17:04:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 982E552051;
        Mon, 12 Aug 2019 17:04:30 +0000 (GMT)
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using iomap
 infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
From:   RITESH HARJANI <riteshh@linux.ibm.com>
Date:   Mon, 12 Aug 2019 22:34:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081217-4275-0000-0000-00000358490A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081217-4276-0000-0000-0000386A5600
Message-Id: <20190812170430.982E552051@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120190
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/12/19 6:23 PM, Matthew Bobrowski wrote:
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
>   fs/ext4/file.c  | 227 ++++++++++++++++++++++++++++++++++++++++----------------
>   fs/ext4/inode.c |  42 +++++++++--
>   2 files changed, 199 insertions(+), 70 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7470800c63b7..d74576821676 100644
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
> @@ -218,6 +219,14 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret <= 0)
>   		return ret;
>   
> +	ret = file_remove_privs(iocb->ki_filp);
> +	if (ret)
> +		return 0;
> +
> +	ret = file_update_time(iocb->ki_filp);
> +	if (ret)
> +		return 0;
> +
>   	if (unlikely(IS_IMMUTABLE(inode)))
>   		return -EPERM;
>   
> @@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	return iov_iter_count(from);
>   }
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
> +
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
>   static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
>   				       size_t count)
>   {
> @@ -284,6 +321,128 @@ static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
>   	return ret;
>   }
>   
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
> +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> +		inode_dio_wait(inode);

Could you please add explain & add a comment about why we wait in AIO 
DIO case
when extend is true? As I see without iomap code this case was not 
present earlier.


> +
> +	if (ret >= 0 && iov_iter_count(from)) {
> +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> +		return ext4_buffered_write_iter(iocb, from);
> +	}
should not we copy code from "__generic_file_write_iter" which does below?

3436                 /*
3437                  * We need to ensure that the page cache pages are 
written to
3438                  * disk and invalidated to preserve the expected 
O_DIRECT
3439                  * semantics.
3440                  */


> +out:
> +	overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> +	return ret;
> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t
>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> @@ -300,12 +459,6 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>   
> @@ -327,10 +480,6 @@ static ssize_t
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
> @@ -339,61 +488,9 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (IS_DAX(inode))
>   		return ext4_dax_write_iter(iocb, from);
>   #endif
> -	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
> -		return -EOPNOTSUPP;
> -
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
> index 761ce6286b05..9155a8a6eb0b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3533,8 +3533,38 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		if (IS_ERR(handle))
>   			return PTR_ERR(handle);
>   
> -		ret = ext4_map_blocks(handle, inode, &map,
> -				      EXT4_GET_BLOCKS_CREATE_ZERO);
> +		if (IS_DAX(inode)) {
> +			ret = ext4_map_blocks(handle, inode, &map,
> +					      EXT4_GET_BLOCKS_CREATE_ZERO);
> +		} else {
> +			/*
> +			 * DAX and direct IO are the only two
> +			 * operations currently supported with
> +			 * IOMAP_WRITE.
> +			 */
> +			WARN_ON(!(flags & IOMAP_DIRECT));
> +			if (round_down(offset, i_blocksize(inode)) >=
> +			    i_size_read(inode)) {
> +				ret = ext4_map_blocks(handle, inode, &map,
> +						      EXT4_GET_BLOCKS_CREATE);
> +			} else if (!ext4_test_inode_flag(inode,
> +							 EXT4_INODE_EXTENTS)) {
> +				/*
> +				 * We cannot fill holes in indirect
> +				 * tree based inodes as that could
> +				 * expose stale data in the case of a
> +				 * crash. Use magic error code to
> +				 * fallback to buffered IO.
> +				 */
> +				ret = ext4_map_blocks(handle, inode, &map, 0);
> +				if (ret == 0)
> +					ret = -ENOTBLK;
> +			} else {
> +				ret = ext4_map_blocks(handle, inode, &map,
> +						      EXT4_GET_BLOCKS_IO_CREATE_EXT);
> +			}
> +		}

Could you please check & confirm on below points -
1. Do you see a problem @above in case of *overwrite* with extents mapping?
It will fall into EXT4_GET_BLOCKS_IO_CREATE_EXT case.
So are we piggy backing on the fact that ext4_map_blocks first call 
ext4_ext_map_blocks
with flags & EXT4_GET_BLOCKS_KEEP_SIZE. And so for overwrite case since 
it will return
val > 0 then we will anyway not create any blocks and so we don't need 
to check overwrite
case specifically here?


2. For cases with flags passed is 0 to ext4_map_blocks (overwrite & 
fallocate without extent case),
we need not start the journaling transaction. But in above we are doing 
ext4_journal_start/stop unconditionally
& unnecessarily reserving dio_credits blocks.
We need to take care of that right?


> +
>   		if (ret < 0) {
>   			ext4_journal_stop(handle);
>   			if (ret == -ENOSPC &&
> @@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>   		iomap->addr = IOMAP_NULL_ADDR;
>   	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>   			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
Maybe a comment as to explaining why checking UNWRITTEN before is 
necessary for others.
So in case of fallocate & DIO write case we may get extent which is both 
unwritten & mapped (right?).
so we need to check if we have an unwritten extent first so that it will 
need the conversion in ->end_io
callback.

>   		} else {
>   			WARN_ON_ONCE(1);
>   			return -EIO;
> @@ -3601,6 +3631,8 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>   			  ssize_t written, unsigned flags, struct iomap *iomap)
>   {
> +	if (flags & IOMAP_DIRECT && written == 0)
> +		return -ENOTBLK;
>   	return 0;
>   }
>   

