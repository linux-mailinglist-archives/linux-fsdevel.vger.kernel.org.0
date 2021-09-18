Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC194107BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhIRRJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 13:09:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233210AbhIRRJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 13:09:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18IH0KdG003766;
        Sat, 18 Sep 2021 13:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=r44pCIkboU67vrUt7SMofnZIYe0NQ0/P+QTi3wuQ7ps=;
 b=OgtchIiYQczWvPlrdQlgwQ5a+Ytkm07fLzDLu1KGY0x0+kwQpsr8rlI40s72AB5kkfDK
 eLvNKA76ioIIVuECSydijIYmDSQRm1aK6B9LxkIv92Tg2fhtaFOf2mTsr5Ec1Ca71+AX
 i7yoOvEGF2shJeG4rXjIJnHWXTvkzhy2TrpvxhopIzYlhVe8CZChmKx0xYUwCJfezTnQ
 CZBWIHTWOJPy1eUpfVBnpbFVxbdm+tQ+UTiJ3hTlUfOd17xMLbohx6HowK6W/O6USbDd
 CAQe0ro1qVps+mLu66yzmBJA3q8/Our8sHsCMuOuPGlkrztum6LYx60mE+7E6wvRb+17 bA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b5m4r82w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 13:08:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18IH7EMg028237;
        Sat, 18 Sep 2021 17:08:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3b57r8ude2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 17:08:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18IH7w2i43319584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 17:07:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD1642049;
        Sat, 18 Sep 2021 17:07:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EEFB42045;
        Sat, 18 Sep 2021 17:07:58 +0000 (GMT)
Received: from localhost (unknown [9.43.63.221])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Sep 2021 17:07:58 +0000 (GMT)
Date:   Sat, 18 Sep 2021 22:37:57 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 5/5] ext4: implement FALLOC_FL_ZEROINIT_RANGE
Message-ID: <20210918170757.j5yjxo34thzks5iv@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192867220.417973.4913917281472586603.stgit@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192867220.417973.4913917281472586603.stgit@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k_kOm3xhYRvgrAVSQOGBLH57KNIeJXIQ
X-Proofpoint-ORIG-GUID: k_kOm3xhYRvgrAVSQOGBLH57KNIeJXIQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_05,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+cc linux-ext4

[Thread]: https://lore.kernel.org/linux-xfs/163192864476.417973.143014658064006895.stgit@magnolia/T/#t

On 21/09/17 06:31PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement this new fallocate mode so that persistent memory users can,
> upon receipt of a pmem poison notification, cause the pmem to be
> reinitialized to a known value (zero) and clear any hardware poison
> state that might be lurking.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/ext4/extents.c           |   93 +++++++++++++++++++++++++++++++++++++++++++
>  include/trace/events/ext4.h |    7 +++
>  2 files changed, 99 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c0de30f25185..c345002e2da6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -29,6 +29,7 @@
>  #include <linux/fiemap.h>
>  #include <linux/backing-dev.h>
>  #include <linux/iomap.h>
> +#include <linux/dax.h>
>  #include "ext4_jbd2.h"
>  #include "ext4_extents.h"
>  #include "xattr.h"
> @@ -4475,6 +4476,90 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
>
>  static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
>
> +static long ext4_zeroinit_range(struct file *file, loff_t offset, loff_t len)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = inode->i_mapping;
> +	handle_t *handle = NULL;
> +	loff_t end = offset + len;
> +	long ret;
> +
> +	trace_ext4_zeroinit_range(inode, offset, len,
> +			FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE);
> +
> +	/* We don't support data=journal mode */
> +	if (ext4_should_journal_data(inode))
> +		return -EOPNOTSUPP;
> +
> +	inode_lock(inode);
> +
> +	/*
> +	 * Indirect files do not support unwritten extents
> +	 */
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> +		ret = -EOPNOTSUPP;
> +		goto out_mutex;
> +	}
> +
> +	/* Wait all existing dio workers, newcomers will block on i_mutex */
> +	inode_dio_wait(inode);
> +
> +	/*
> +	 * Prevent page faults from reinstantiating pages we have released from
> +	 * page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
> +
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_mmap;
> +
> +	/* Now release the pages and zero block aligned part of pages */
> +	truncate_pagecache_range(inode, offset, end - 1);
> +	inode->i_mtime = inode->i_ctime = current_time(inode);
> +
> +	if (IS_DAX(inode))
> +		ret = dax_zeroinit_range(inode, offset, len,
> +				&ext4_iomap_report_ops);
> +	else
> +		ret = iomap_zeroout_range(inode, offset, len,
> +				&ext4_iomap_report_ops);
> +	if (ret == -ECANCELED)
> +		ret = -EOPNOTSUPP;
> +	if (ret)
> +		goto out_mmap;
> +
> +	/*
> +	 * In worst case we have to writeout two nonadjacent unwritten
> +	 * blocks and update the inode
> +	 */

Is this comment true? We are actually not touching IOMAP_UNWRITTEN blocks no?
So is there any need for journal transaction for this?
We are essentially only writing to blocks which are already allocated on disk
and zeroing it out in both dax_zeroinit_range() and iomap_zeroinit_range().


> +	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);

I guess credits is 1 here since only inode is getting modified.


> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		ext4_std_error(inode->i_sb, ret);
> +		goto out_mmap;
> +	}
> +
> +	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	ret = ext4_mark_inode_dirty(handle, inode);
> +	if (unlikely(ret))
> +		goto out_handle;
> +	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
> +			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);

I am not sure whether we need ext4_fc_track_range() here?
We are not doing any metadata operation except maybe updating inode timestamp
right?

-ritesh

> +	ext4_update_inode_fsync_trans(handle, inode, 1);
> +
> +	if (file->f_flags & O_SYNC)
> +		ext4_handle_sync(handle);
> +
> +out_handle:
> +	ext4_journal_stop(handle);
> +out_mmap:
> +	filemap_invalidate_unlock(mapping);
> +out_mutex:
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
>  static long ext4_zero_range(struct file *file, loff_t offset,
>  			    loff_t len, int mode)
>  {
> @@ -4659,7 +4744,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	/* Return error if mode is not supported */
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>  		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
> -		     FALLOC_FL_INSERT_RANGE))
> +		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_ZEROINIT_RANGE))
>  		return -EOPNOTSUPP;
>
>  	ext4_fc_start_update(inode);
> @@ -4687,6 +4772,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		ret = ext4_zero_range(file, offset, len, mode);
>  		goto exit;
>  	}
> +
> +	if (mode & FALLOC_FL_ZEROINIT_RANGE) {
> +		ret = ext4_zeroinit_range(file, offset, len);
> +		goto exit;
> +	}
> +
>  	trace_ext4_fallocate_enter(inode, offset, len, mode);
>  	lblk = offset >> blkbits;
>
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 0ea36b2b0662..282f1208067f 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1407,6 +1407,13 @@ DEFINE_EVENT(ext4__fallocate_mode, ext4_zero_range,
>  	TP_ARGS(inode, offset, len, mode)
>  );
>
> +DEFINE_EVENT(ext4__fallocate_mode, ext4_zeroinit_range,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int mode),
> +
> +	TP_ARGS(inode, offset, len, mode)
> +);
> +
>  TRACE_EVENT(ext4_fallocate_exit,
>  	TP_PROTO(struct inode *inode, loff_t offset,
>  		 unsigned int max_blocks, int ret),
>
