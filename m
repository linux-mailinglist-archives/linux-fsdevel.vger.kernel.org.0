Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76111E7FDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 06:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfJ2FrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 01:47:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728827AbfJ2FrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:47:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T4uGxd111983
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 01:47:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vxccsd80s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 01:47:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 29 Oct 2019 05:47:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 05:47:02 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9T5l1rj14024916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 05:47:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17314A4065;
        Tue, 29 Oct 2019 05:47:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6426A4060;
        Tue, 29 Oct 2019 05:46:58 +0000 (GMT)
Received: from [9.199.158.60] (unknown [9.199.158.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 05:46:58 +0000 (GMT)
Subject: Re: [PATCH v6 08/11] ext4: move inode extension/truncate code out
 from ->iomap_end() callback
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <c0068ac9822568e1af6383a2f16667d2265a1d14.1572255426.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 29 Oct 2019 11:16:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c0068ac9822568e1af6383a2f16667d2265a1d14.1572255426.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102905-0008-0000-0000-00000328A20D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102905-0009-0000-0000-00004A47E281
Message-Id: <20191029054658.C6426A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=985 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290044
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/28/19 4:22 PM, Matthew Bobrowski wrote:
> In preparation for implementing the iomap direct I/O modifications,
> the inode extension/truncate code needs to be moved out from the
> ext4_iomap_end() callback. For direct I/O, if the current code
> remained, it would behave incorrrectly. Updating the inode size prior
> to converting unwritten extents would potentially allow a racing
> direct I/O read to find unwritten extents before being converted
> correctly.
> 
> The inode extension/truncate code now resides within a new helper
> ext4_handle_inode_extension(). This function has been designed so that
> it can accommodate for both DAX and direct I/O extension/truncate
> operations.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for the patch. Looks good to me.
You may add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/file.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   fs/ext4/inode.c | 48 +-------------------------
>   2 files changed, 89 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 440f4c6ba4ee..ec54fec96a81 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -33,6 +33,7 @@
>   #include "ext4_jbd2.h"
>   #include "xattr.h"
>   #include "acl.h"
> +#include "truncate.h"
> 
>   static bool ext4_dio_supported(struct inode *inode)
>   {
> @@ -234,12 +235,95 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	return iov_iter_count(from);
>   }
> 
> +static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> +					   ssize_t written, size_t count)
> +{
> +	handle_t *handle;
> +	bool truncate = false;
> +	u8 blkbits = inode->i_blkbits;
> +	ext4_lblk_t written_blk, end_blk;
> +
> +	/*
> +	 * Note that EXT4_I(inode)->i_disksize can get extended up to
> +	 * inode->i_size while the I/O was running due to writeback of delalloc
> +	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
> +	 * zeroed/unwritten extents if this is possible; thus we won't leave
> +	 * uninitialized blocks in a file even if we didn't succeed in writing
> +	 * as much as we intended.
> +	 */
> +	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> +	if (offset + count <= EXT4_I(inode)->i_disksize) {
> +		/*
> +		 * We need to ensure that the inode is removed from the orphan
> +		 * list if it has been added prematurely, due to writeback of
> +		 * delalloc blocks.
> +		 */
> +		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +
> +			if (IS_ERR(handle)) {
> +				ext4_orphan_del(NULL, inode);
> +				return PTR_ERR(handle);
> +			}
> +
> +			ext4_orphan_del(handle, inode);
> +			ext4_journal_stop(handle);
> +		}
> +
> +		return written;
> +	}
> +
> +	if (written < 0)
> +		goto truncate;
> +
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +	if (IS_ERR(handle)) {
> +		written = PTR_ERR(handle);
> +		goto truncate;
> +	}
> +
> +	if (ext4_update_inode_size(inode, offset + written))
> +		ext4_mark_inode_dirty(handle, inode);
> +
> +	/*
> +	 * We may need to truncate allocated but not written blocks beyond EOF.
> +	 */
> +	written_blk = ALIGN(offset + written, 1 << blkbits);
> +	end_blk = ALIGN(offset + count, 1 << blkbits);
> +	if (written_blk < end_blk && ext4_can_truncate(inode))
> +		truncate = true;
> +
> +	/*
> +	 * Remove the inode from the orphan list if it has been extended and
> +	 * everything went OK.
> +	 */
> +	if (!truncate && inode->i_nlink)
> +		ext4_orphan_del(handle, inode);
> +	ext4_journal_stop(handle);
> +
> +	if (truncate) {
> +truncate:
> +		ext4_truncate_failed_write(inode);
> +		/*
> +		 * If the truncate operation failed early, then the inode may
> +		 * still be on the orphan list. In that case, we need to try
> +		 * remove the inode from the in-memory linked list.
> +		 */
> +		if (inode->i_nlink)
> +			ext4_orphan_del(NULL, inode);
> +	}
> +
> +	return written;
> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t
>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
> -	struct inode *inode = file_inode(iocb->ki_filp);
>   	ssize_t ret;
> +	size_t count;
> +	loff_t offset;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> 
>   	if (!inode_trylock(inode)) {
>   		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -256,7 +340,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret)
>   		goto out;
> 
> +	offset = iocb->ki_pos;
> +	count = iov_iter_count(from);
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> +	ret = ext4_handle_inode_extension(inode, offset, ret, count);
>   out:
>   	inode_unlock(inode);
>   	if (ret > 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e44b3b1dbbc4..7c21028760ee 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3543,53 +3543,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>   			  ssize_t written, unsigned flags, struct iomap *iomap)
>   {
> -	int ret = 0;
> -	handle_t *handle;
> -	int blkbits = inode->i_blkbits;
> -	bool truncate = false;
> -
> -	if (!(flags & IOMAP_WRITE) || (flags & IOMAP_FAULT))
> -		return 0;
> -
> -	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		goto orphan_del;
> -	}
> -	if (ext4_update_inode_size(inode, offset + written))
> -		ext4_mark_inode_dirty(handle, inode);
> -	/*
> -	 * We may need to truncate allocated but not written blocks beyond EOF.
> -	 */
> -	if (iomap->offset + iomap->length >
> -	    ALIGN(inode->i_size, 1 << blkbits)) {
> -		ext4_lblk_t written_blk, end_blk;
> -
> -		written_blk = (offset + written) >> blkbits;
> -		end_blk = (offset + length) >> blkbits;
> -		if (written_blk < end_blk && ext4_can_truncate(inode))
> -			truncate = true;
> -	}
> -	/*
> -	 * Remove inode from orphan list if we were extending a inode and
> -	 * everything went fine.
> -	 */
> -	if (!truncate && inode->i_nlink &&
> -	    !list_empty(&EXT4_I(inode)->i_orphan))
> -		ext4_orphan_del(handle, inode);
> -	ext4_journal_stop(handle);
> -	if (truncate) {
> -		ext4_truncate_failed_write(inode);
> -orphan_del:
> -		/*
> -		 * If truncate failed early the inode might still be on the
> -		 * orphan list; we need to make sure the inode is removed from
> -		 * the orphan list in that case.
> -		 */
> -		if (inode->i_nlink)
> -			ext4_orphan_del(NULL, inode);
> -	}
> -	return ret;
> +	return 0;
>   }
> 
>   const struct iomap_ops ext4_iomap_ops = {
> 

