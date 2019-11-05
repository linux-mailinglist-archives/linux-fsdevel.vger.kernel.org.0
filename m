Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A529F01E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfKEPuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 10:50:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEPuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:50:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5FnD0I066481;
        Tue, 5 Nov 2019 15:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=APEU/aNlvQSPU/njjGIQlYIBj3oP7fIICKZEJuIOtfg=;
 b=XlYJZUutXUJidwahwhCYzC+5YDQ7A/KMQYwqfs42xB2ai8oAO7HqznqCcnCQwfpLJJkq
 1QuV9go5V+9lhuWx2vfb2Ybqug/VSoTSoQSirsun2+b94+6oxbWS10GSQByodlCstryJ
 wv6/YrF+10aXmL2a/5LbdbtpZeSS10hgagEigv6BoEEIV8PMtsh4xbo7mk0QQeeQavlH
 MeHeL4wY+9ChOBgNV+dFlpueFroIAJL2p+R5SssNWEERlre6ErOmvWbE8odyOsZEE6Td
 K4BZKL/NhehFJgGY32PaNxJ8u2a+lN3Y1FybYiqLM7ftlY90gbyZGGCMytnm8HxxjMlq +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w117tyfym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 15:49:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5Fmupc127804;
        Tue, 5 Nov 2019 15:49:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w2wck3pjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 15:49:53 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA5FnpP0004031;
        Tue, 5 Nov 2019 15:49:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 07:49:51 -0800
Date:   Tue, 5 Nov 2019 07:49:50 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 08/11] ext4: move inode extension/truncate code out
 from ->iomap_end() callback
Message-ID: <20191105154950.GC15203@magnolia>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <d41ffa26e20b15b12895812c3cad7c91a6a59bc6.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d41ffa26e20b15b12895812c3cad7c91a6a59bc6.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:01:51PM +1100, Matthew Bobrowski wrote:
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
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/file.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/ext4/inode.c | 48 +-------------------------
>  2 files changed, 89 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 440f4c6ba4ee..ec54fec96a81 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -33,6 +33,7 @@
>  #include "ext4_jbd2.h"
>  #include "xattr.h"
>  #include "acl.h"
> +#include "truncate.h"
>  
>  static bool ext4_dio_supported(struct inode *inode)
>  {
> @@ -234,12 +235,95 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	return iov_iter_count(from);
>  }
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

I keep seeing this chunk (and the ext4_orphan_add chunk) bouncing around
through this patchset, which causes me to wonder -- would it be useful
to refactor these into small helpers?  Or is it really just the same two
orphan_add/del chunks bouncing around multiple places?

--D

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
>  #ifdef CONFIG_FS_DAX
>  static ssize_t
>  ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
> -	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
> +	size_t count;
> +	loff_t offset;
> +	struct inode *inode = file_inode(iocb->ki_filp);
>  
>  	if (!inode_trylock(inode)) {
>  		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -256,7 +340,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (ret)
>  		goto out;
>  
> +	offset = iocb->ki_pos;
> +	count = iov_iter_count(from);
>  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> +	ret = ext4_handle_inode_extension(inode, offset, ret, count);
>  out:
>  	inode_unlock(inode);
>  	if (ret > 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9bd80df6b856..071a1f976aab 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3583,53 +3583,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  			  ssize_t written, unsigned flags, struct iomap *iomap)
>  {
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
>  }
>  
>  const struct iomap_ops ext4_iomap_ops = {
> -- 
> 2.20.1
> 
