Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D112D0753
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJIGkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbfJIGkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:40:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x996bMUl069170
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:39:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vh7t0vre9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:39:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:39:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:39:53 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x996dq9U52625408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:39:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FF674203F;
        Wed,  9 Oct 2019 06:39:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 604C042047;
        Wed,  9 Oct 2019 06:39:50 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:39:50 +0000 (GMT)
Subject: Re: [PATCH v4 4/8] ext4: introduce direct I/O read path using iomap
 infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <df2b8a10641ec8a0509f137dcc2db1d3cc6087f1.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 12:09:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <df2b8a10641ec8a0509f137dcc2db1d3cc6087f1.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-4275-0000-0000-0000037059F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-4276-0000-0000-000038835CE2
Message-Id: <20191009063950.604C042047@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090060
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/3/19 5:04 PM, Matthew Bobrowski wrote:
> This patch introduces a new direct I/O read path that makes use of the
> iomap infrastructure.
> 
> The new function ext4_dio_read_iter() is responsible for calling into
> the iomap infrastructure via iomap_dio_rw(). If the read operation
> being performed on the inode does not pass the preliminary checks
> performed within ext4_dio_supported(), then we simply fallback to
> buffered I/O in order to fulfil the request.
> 
> Existing direct I/O read buffer_head code has been removed as it's now
> redundant.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>   fs/ext4/file.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++----
>   fs/ext4/inode.c | 32 +--------------------------
>   2 files changed, 55 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index ab75aee3e687..69ac042fb74b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -34,6 +34,53 @@
>   #include "xattr.h"
>   #include "acl.h"
> 
> +static bool ext4_dio_supported(struct inode *inode)
> +{
> +	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
> +		return false;
> +	if (fsverity_active(inode))
> +		return false;
> +	if (ext4_should_journal_data(inode))
> +		return false;
> +	if (ext4_has_inline_data(inode))
> +		return false;
> +	return true;
> +}
> +
> +static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	/*
> +	 * Get exclusion from truncate and other inode operations.
> +	 */
> +	if (!inode_trylock_shared(inode)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		inode_lock_shared(inode);
> +	}
Same comments here.
Let's follow as per the discussion here
https://patchwork.kernel.org/patch/11141577/


> +
> +	if (!ext4_dio_supported(inode)) {
> +		inode_unlock_shared(inode);
> +		/*
> +		 * Fallback to buffered I/O if the operation being
> +		 * performed on the inode is not supported by direct
> +		 * I/O. The IOCB_DIRECT flag needs to be cleared here
> +		 * in order to ensure that the direct I/O path withiin
> +		 * generic_file_read_iter() is not taken.
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		return generic_file_read_iter(iocb, to);
> +	}
> +
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
> +	inode_unlock_shared(inode);
> +
> +	file_accessed(iocb->ki_filp);
> +	return ret;
> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
> @@ -64,16 +111,19 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
> 
>   static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>   		return -EIO;
> 
>   	if (!iov_iter_count(to))
>   		return 0; /* skip atime */
> 
> -#ifdef CONFIG_FS_DAX
> -	if (IS_DAX(file_inode(iocb->ki_filp)))
> +	if (IS_DAX(inode))
>   		return ext4_dax_read_iter(iocb, to);
> -#endif
> +
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return ext4_dio_read_iter(iocb, to);
>   	return generic_file_read_iter(iocb, to);
>   }
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1dace576b8bd..159ffb92f82d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -863,9 +863,6 @@ int ext4_dio_get_block(struct inode *inode, sector_t iblock,
>   {
>   	/* We don't expect handle for direct IO */
>   	WARN_ON_ONCE(ext4_journal_current_handle());
> -
> -	if (!create)
> -		return _ext4_get_block(inode, iblock, bh, 0);
>   	return ext4_get_block_trans(inode, iblock, bh, EXT4_GET_BLOCKS_CREATE);
>   }
> 
> @@ -3855,30 +3852,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
>   	return ret;
>   }
> 
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
>   static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   {
>   	struct file *file = iocb->ki_filp;
> @@ -3905,10 +3878,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   		return 0;
> 
>   	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> -	if (iov_iter_rw(iter) == READ)
> -		ret = ext4_direct_IO_read(iocb, iter);
> -	else
> -		ret = ext4_direct_IO_write(iocb, iter);
> +	ret = ext4_direct_IO_write(iocb, iter);
>   	trace_ext4_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), ret);
>   	return ret;
>   }
> 

