Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9CD0724
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJIG1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:27:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727029AbfJIG1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:27:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x996MJk8126841
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:27:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vha7c049e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:27:28 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:27:26 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:27:08 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x996R7l458917000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:27:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 471F04204B;
        Wed,  9 Oct 2019 06:27:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 694BF42049;
        Wed,  9 Oct 2019 06:27:05 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:27:05 +0000 (GMT)
Subject: Re: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 11:57:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-0028-0000-0000-000003A85700
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-0029-0000-0000-0000246A5A07
Message-Id: <20191009062705.694BF42049@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=629 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090058
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/3/19 5:04 PM, Matthew Bobrowski wrote:
> In preparation for implementing the iomap direct I/O write path
> modifications, the inode extension/truncate code needs to be moved out
> from ext4_iomap_end(). For direct I/O, if the current code remained
> within ext4_iomap_end() it would behave incorrectly. Updating the
> inode size prior to converting unwritten extents to written extents
> will potentially allow a racing direct I/O read operation to find
> unwritten extents before they've been correctly converted.
> 
> The inode extension/truncate code has been moved out into a new helper
> ext4_handle_inode_extension(). This function has been designed so that
> it can be used by both DAX and direct I/O paths.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

checkpatch shows some whitespaces error in your comments
in this patch.
But apart from that, patch looks good to me.
You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/file.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   fs/ext4/inode.c | 48 +-----------------------------
>   2 files changed, 79 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 69ac042fb74b..2883711e8a33 100644
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
> @@ -233,12 +234,82 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	return iov_iter_count(from);
>   }
> 
> +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> +				       ssize_t written, size_t count)
> +{
> +	int ret = 0;
> +	handle_t *handle;
> +	bool truncate = false;
> +	u8 blkbits = inode->i_blkbits;
> +	ext4_lblk_t written_blk, end_blk;
> +
> +	/*
> +         * Note that EXT4_I(inode)->i_disksize can get extended up to
> +         * inode->i_size while the IO was running due to writeback of
> +         * delalloc blocks. But the code in ext4_iomap_alloc() is careful
> +         * to use zeroed / unwritten extents if this is possible and thus
> +         * we won't leave uninitialized blocks in a file even if we didn't
> +         * succeed in writing as much as we planned.
> +         */
> +	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> +	if (offset + count <= EXT4_I(inode)->i_disksize)
> +		return written < 0 ? written : 0;
> +
> +	if (written < 0) {
> +		ret = written;
> +		goto truncate;
> +	}
> +
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		goto truncate;
> +	}
> +
> +	if (ext4_update_inode_size(inode, offset + written))
> +		ext4_mark_inode_dirty(handle, inode);
> +
> +	/*
> +	 * We may need to truncate allocated but not written blocks
> +	 * beyond EOF.
> +	 */
> +	written_blk = ALIGN(offset + written, 1 << blkbits);
> +	end_blk = ALIGN(offset + count, 1 << blkbits);
> +	if (written_blk < end_blk && ext4_can_truncate(inode))
> +		truncate = true;
> +
> +	/*
> +	 * Remove the inode from the orphan list if it has been
> +	 * extended and everything went OK.
> +	 */
> +	if (!truncate && inode->i_nlink)
> +		ext4_orphan_del(handle, inode);
> +	ext4_journal_stop(handle);
> +
> +	if (truncate) {
> +truncate:
> +		ext4_truncate_failed_write(inode);
> +		/*
> +		 * If the truncate operation failed early, then the
> +		 * inode may still be on the orphan list. In that
> +		 * case, we need to try remove the inode from the
> +		 * in-memory linked list.
> +		 */
> +		if (inode->i_nlink)
> +			ext4_orphan_del(NULL, inode);
> +	}
> +	return ret;
> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t
>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
> -	struct inode *inode = file_inode(iocb->ki_filp);
> +	int error;
>   	ssize_t ret;
> +	size_t count;
> +	loff_t offset;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> 
>   	if (!inode_trylock(inode)) {
>   		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -255,7 +326,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret)
>   		goto out;
> 
> +	offset = iocb->ki_pos;
> +	count = iov_iter_count(from);
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> +
> +	error = ext4_handle_inode_extension(inode, offset, ret, count);
> +	if (error)
> +		ret = error;
>   out:
>   	inode_unlock(inode);
>   	if (ret > 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 159ffb92f82d..d616062b603e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3592,53 +3592,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

