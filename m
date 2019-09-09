Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4686DAD4A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfIIIRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 04:17:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbfIIIRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:17:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x898Gl92025171
        for <linux-fsdevel@vger.kernel.org>; Mon, 9 Sep 2019 04:17:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uwj3xjukb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 04:17:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 9 Sep 2019 09:17:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 09:17:31 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x898HUkb45875376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 08:17:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C56AD42047;
        Mon,  9 Sep 2019 08:17:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3555C42041;
        Mon,  9 Sep 2019 08:17:29 +0000 (GMT)
Received: from [9.199.158.183] (unknown [9.199.158.183])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 08:17:29 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <c1e9b23ced988587dfec399021a5b62983745842.1567978633.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 9 Sep 2019 13:47:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c1e9b23ced988587dfec399021a5b62983745842.1567978633.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090908-0012-0000-0000-00000348AA0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090908-0013-0000-0000-000021830932
Message-Id: <20190909081729.3555C42041@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=667 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/9/19 4:49 AM, Matthew Bobrowski wrote:
> In preparation for implementing the iomap direct IO write path
> modifications, the inode extension/truncate code needs to be moved out
> from ext4_iomap_end(). For direct IO, if the current code remained
> within ext4_iomap_end() it would behave incorrectly. If we update the
> inode size prior to converting unwritten extents we run the risk of
> allowing a racing direct IO read operation to find unwritten extents
> before they are converted.
> 
> The inode extension/truncate code has been moved out into a new helper
> ext4_handle_inode_extension(). This helper has been designed so that
> it can be used by both DAX and direct IO paths in the instance that
> the result of the write is extending the inode.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>   fs/ext4/file.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   fs/ext4/inode.c | 48 +------------------------
>   2 files changed, 93 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index e52e3928dc25..8e586198f6e6 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -33,6 +33,7 @@
>   #include "ext4_jbd2.h"
>   #include "xattr.h"
>   #include "acl.h"
> +#include "truncate.h"
> 
>   static bool ext4_dio_checks(struct inode *inode)
>   {
> @@ -233,12 +234,91 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	return iov_iter_count(from);
>   }
> 
> +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> +				       ssize_t len, size_t count)
> +{
> +	handle_t *handle;
> +	bool truncate = false;
> +	ext4_lblk_t written_blk, end_blk;
> +	int ret = 0, blkbits = inode->i_blkbits;
> +
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		goto orphan_del;
> +	}
> +
> +	if (ext4_update_inode_size(inode, offset + len))
> +		ext4_mark_inode_dirty(handle, inode);
> +
> +	/*
> +	 * We may need truncate allocated but not written blocks
> +	 * beyond EOF.
> +	 */
> +	written_blk = ALIGN(offset + len, 1 << blkbits);
> +	end_blk = ALIGN(offset + len + count, 1 << blkbits);

why add len in end_blk calculation?
shouldn't this be like below?
	end_blk = ALIGN(offset + count, 1 << blkbits);

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
> +		ext4_truncate_failed_write(inode);
> +orphan_del:
> +		/*
> +		 * If the truncate operation failed early the inode
> +		 * may still be on the orphan list. In that case, we
> +		 * need try remove the inode from the linked list in
> +		 * memory.
> +		 */
> +		if (inode->i_nlink)
> +			ext4_orphan_del(NULL, inode);
> +	}
> +	return ret;
> +}
> +
> +/*
> + * The inode may have been placed onto the orphan list or has had
> + * blocks allocated beyond EOF as a result of an extension. We need to
> + * ensure that any necessary cleanup routines are performed if the
> + * error path has been taken for a write.
> + */
> +static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
> +{
> +	int ret = 0;

No need of ret anyways.


> +	handle_t *handle;
> +
> +	if (size > i_size_read(inode))
> +		ext4_truncate_failed_write(inode);
> +
> +	if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +		if (IS_ERR(handle)) {
> +			if (inode->i_nlink)
> +				ext4_orphan_del(NULL, inode);
> +			return PTR_ERR(handle);
> +		}
> +		if (inode->i_nlink)
> +			ext4_orphan_del(handle, inode);
> +		ext4_journal_stop(handle);
> +	}
> +	return ret;

can directly call for `return 0;`

> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t
>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
> -	struct inode *inode = file_inode(iocb->ki_filp);
>   	ssize_t ret;
> +	int error = 0;
> +	loff_t offset;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> 
>   	if (!inode_trylock(inode)) {
>   		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -255,7 +335,18 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret)
>   		goto out;
> 
> +	offset = iocb->ki_pos;
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> +	if (ret > 0 && iocb->ki_pos > i_size_read(inode))
> +		error = ext4_handle_inode_extension(inode, offset, ret,
> +						    iov_iter_count(from));
> +
> +	if (ret < 0)
> +		error = ext4_handle_failed_inode_extension(inode,
> +							   iocb->ki_pos);
> +
> +	if (error)
> +		ret = error;
>   out:
>   	inode_unlock(inode);
>   	if (ret > 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 420fe3deed39..761ce6286b05 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3601,53 +3601,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

