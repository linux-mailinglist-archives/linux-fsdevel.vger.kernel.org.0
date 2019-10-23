Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D56E124F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 08:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfJWGkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 02:40:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728697AbfJWGkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:40:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N6b9F8001584
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:40:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtcvafn62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:40:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 23 Oct 2019 07:40:29 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 07:40:26 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9N6ePaZ44696032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 06:40:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 082B24C040;
        Wed, 23 Oct 2019 06:40:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFBD44C050;
        Wed, 23 Oct 2019 06:40:22 +0000 (GMT)
Received: from [9.199.158.207] (unknown [9.199.158.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 06:40:22 +0000 (GMT)
Subject: Re: [PATCH v5 07/12] ext4: introduce direct I/O read using iomap
 infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <280de880787dc7c064c309efb685f95d4ff732a9.1571647179.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 23 Oct 2019 12:10:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <280de880787dc7c064c309efb685f95d4ff732a9.1571647179.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102306-0008-0000-0000-00000325E0E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102306-0009-0000-0000-00004A450F12
Message-Id: <20191023064022.CFBD44C050@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230064
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/21/19 2:48 PM, Matthew Bobrowski wrote:
> This patch introduces a new direct I/O read path which makes use of
> the iomap infrastructure.
> 
> The new function ext4_do_read_iter() is responsible for calling into
> the iomap infrastructure via iomap_dio_rw(). If the read operation
> performed on the inode is not supported, which is checked via
> ext4_dio_supported(), then we simply fallback and complete the I/O
> using buffered I/O.
> 
> Existing direct I/O read code path has been removed, as it is no
> longer required.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>


Patch looks good to me. You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/file.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>   fs/ext4/inode.c | 32 +-------------------------------
>   2 files changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index ab75aee3e687..6ea7e00e0204 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -34,6 +34,46 @@
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
> +static int ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	inode_lock_shared(inode);
> +	if (!ext4_dio_supported(inode)) {
> +		inode_unlock_shared(inode);
> +		/*
> +		 * Fallback to buffered I/O if the operation being performed on
> +		 * the inode is not supported by direct I/O. The IOCB_DIRECT
> +		 * flag needs to be cleared here in order to ensure that the
> +		 * direct I/O path within generic_file_read_iter() is not
> +		 * taken.
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		return generic_file_read_iter(iocb, to);
> +	}
> +
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
> +			   is_sync_kiocb(iocb));
> +	inode_unlock_shared(inode);
> +
> +	file_accessed(iocb->ki_filp);
> +	return ret;
> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
> @@ -64,7 +104,9 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
> @@ -74,6 +116,8 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	if (IS_DAX(file_inode(iocb->ki_filp)))
>   		return ext4_dax_read_iter(iocb, to);
>   #endif
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return ext4_dio_read_iter(iocb, to);
>   	return generic_file_read_iter(iocb, to);
>   }
>   
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ebeedbf3900f..03a9e2b85e46 100644
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
> @@ -3865,30 +3862,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
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
> @@ -3915,10 +3888,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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

