Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2F173B36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgB1PVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:21:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgB1PVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:21:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFIjZp160857;
        Fri, 28 Feb 2020 15:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pGiMW2LyVLMiB/edMgYp2mkWHO7Yw7JkXI0UMJGAsto=;
 b=zq9RPWPE+IAxhphsGFmTvqfnUZqEGOlYqgxh/pZ8kX/QlFHwcVNPlyUjxUcMq+Sltcwq
 3KTAaOvho+ZqybF3GcPwaFCHbZg/C3I8YRjNJUGW3XDmhilKgO12jtcSFTq0lC5ycQQE
 DfBZ1PfQJmc9AvZLxlHaBQgYzVE9/uWac67Gg9kXT9r1n0JQQoMWyai9zDfnO+XEkobZ
 1ry3STCKT0JS1wFoQ4x04EuM0lEOnoEdnij/a2JO5QoUBph8/PKH0pb5cSGZIwDztIip
 hcxpxBebEjVnUkEyx5Yb3Pus1TxHwdPbHW0077UBKHbrxQGIN5yQVfNK0Bbn9MGS+jRM Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ydct3kexw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:21:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFGnNU009823;
        Fri, 28 Feb 2020 15:21:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ydcsfgma9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:21:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SFLC6m011186;
        Fri, 28 Feb 2020 15:21:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 07:21:07 -0800
Date:   Fri, 28 Feb 2020 07:21:02 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCHv5 5/6] ext4: Move ext4_fiemap to use iomap framework.
Message-ID: <20200228152102.GD8036@magnolia>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <b9f45c885814fcdd0631747ff0fe08886270828c.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f45c885814fcdd0631747ff0fe08886270828c.1582880246.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:58PM +0530, Ritesh Harjani wrote:
> This patch moves ext4_fiemap to use iomap framework.
> For xattr a new 'ext4_iomap_xattr_ops' is added.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

The interactions with iomap look ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/extents.c | 290 ++++++++--------------------------------------
>  fs/ext4/inline.c  |  41 -------
>  2 files changed, 48 insertions(+), 283 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0de548bb3c90..0e3dfea0c065 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -28,6 +28,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/fiemap.h>
>  #include <linux/backing-dev.h>
> +#include <linux/iomap.h>
>  #include "ext4_jbd2.h"
>  #include "ext4_extents.h"
>  #include "xattr.h"
> @@ -97,9 +98,6 @@ static int ext4_split_extent_at(handle_t *handle,
>  			     int split_flag,
>  			     int flags);
>  
> -static int ext4_find_delayed_extent(struct inode *inode,
> -				    struct extent_status *newes);
> -
>  static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  {
>  	/*
> @@ -2176,155 +2174,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	return err;
>  }
>  
> -static int ext4_fill_fiemap_extents(struct inode *inode,
> -				    ext4_lblk_t block, ext4_lblk_t num,
> -				    struct fiemap_extent_info *fieinfo)
> -{
> -	struct ext4_ext_path *path = NULL;
> -	struct ext4_extent *ex;
> -	struct extent_status es;
> -	ext4_lblk_t next, next_del, start = 0, end = 0;
> -	ext4_lblk_t last = block + num;
> -	int exists, depth = 0, err = 0;
> -	unsigned int flags = 0;
> -	unsigned char blksize_bits = inode->i_sb->s_blocksize_bits;
> -
> -	while (block < last && block != EXT_MAX_BLOCKS) {
> -		num = last - block;
> -		/* find extent for this block */
> -		down_read(&EXT4_I(inode)->i_data_sem);
> -
> -		path = ext4_find_extent(inode, block, &path, 0);
> -		if (IS_ERR(path)) {
> -			up_read(&EXT4_I(inode)->i_data_sem);
> -			err = PTR_ERR(path);
> -			path = NULL;
> -			break;
> -		}
> -
> -		depth = ext_depth(inode);
> -		if (unlikely(path[depth].p_hdr == NULL)) {
> -			up_read(&EXT4_I(inode)->i_data_sem);
> -			EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
> -			err = -EFSCORRUPTED;
> -			break;
> -		}
> -		ex = path[depth].p_ext;
> -		next = ext4_ext_next_allocated_block(path);
> -
> -		flags = 0;
> -		exists = 0;
> -		if (!ex) {
> -			/* there is no extent yet, so try to allocate
> -			 * all requested space */
> -			start = block;
> -			end = block + num;
> -		} else if (le32_to_cpu(ex->ee_block) > block) {
> -			/* need to allocate space before found extent */
> -			start = block;
> -			end = le32_to_cpu(ex->ee_block);
> -			if (block + num < end)
> -				end = block + num;
> -		} else if (block >= le32_to_cpu(ex->ee_block)
> -					+ ext4_ext_get_actual_len(ex)) {
> -			/* need to allocate space after found extent */
> -			start = block;
> -			end = block + num;
> -			if (end >= next)
> -				end = next;
> -		} else if (block >= le32_to_cpu(ex->ee_block)) {
> -			/*
> -			 * some part of requested space is covered
> -			 * by found extent
> -			 */
> -			start = block;
> -			end = le32_to_cpu(ex->ee_block)
> -				+ ext4_ext_get_actual_len(ex);
> -			if (block + num < end)
> -				end = block + num;
> -			exists = 1;
> -		} else {
> -			BUG();
> -		}
> -		BUG_ON(end <= start);
> -
> -		if (!exists) {
> -			es.es_lblk = start;
> -			es.es_len = end - start;
> -			es.es_pblk = 0;
> -		} else {
> -			es.es_lblk = le32_to_cpu(ex->ee_block);
> -			es.es_len = ext4_ext_get_actual_len(ex);
> -			es.es_pblk = ext4_ext_pblock(ex);
> -			if (ext4_ext_is_unwritten(ex))
> -				flags |= FIEMAP_EXTENT_UNWRITTEN;
> -		}
> -
> -		/*
> -		 * Find delayed extent and update es accordingly. We call
> -		 * it even in !exists case to find out whether es is the
> -		 * last existing extent or not.
> -		 */
> -		next_del = ext4_find_delayed_extent(inode, &es);
> -		if (!exists && next_del) {
> -			exists = 1;
> -			flags |= (FIEMAP_EXTENT_DELALLOC |
> -				  FIEMAP_EXTENT_UNKNOWN);
> -		}
> -		up_read(&EXT4_I(inode)->i_data_sem);
> -
> -		if (unlikely(es.es_len == 0)) {
> -			EXT4_ERROR_INODE(inode, "es.es_len == 0");
> -			err = -EFSCORRUPTED;
> -			break;
> -		}
> -
> -		/*
> -		 * This is possible iff next == next_del == EXT_MAX_BLOCKS.
> -		 * we need to check next == EXT_MAX_BLOCKS because it is
> -		 * possible that an extent is with unwritten and delayed
> -		 * status due to when an extent is delayed allocated and
> -		 * is allocated by fallocate status tree will track both of
> -		 * them in a extent.
> -		 *
> -		 * So we could return a unwritten and delayed extent, and
> -		 * its block is equal to 'next'.
> -		 */
> -		if (next == next_del && next == EXT_MAX_BLOCKS) {
> -			flags |= FIEMAP_EXTENT_LAST;
> -			if (unlikely(next_del != EXT_MAX_BLOCKS ||
> -				     next != EXT_MAX_BLOCKS)) {
> -				EXT4_ERROR_INODE(inode,
> -						 "next extent == %u, next "
> -						 "delalloc extent = %u",
> -						 next, next_del);
> -				err = -EFSCORRUPTED;
> -				break;
> -			}
> -		}
> -
> -		if (exists) {
> -			err = fiemap_fill_next_extent(fieinfo,
> -				(__u64)es.es_lblk << blksize_bits,
> -				(__u64)es.es_pblk << blksize_bits,
> -				(__u64)es.es_len << blksize_bits,
> -				flags);
> -			if (err < 0)
> -				break;
> -			if (err == 1) {
> -				err = 0;
> -				break;
> -			}
> -		}
> -
> -		block = es.es_lblk + es.es_len;
> -	}
> -
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> -	return err;
> -}
> -
>  static int ext4_fill_es_cache_info(struct inode *inode,
>  				   ext4_lblk_t block, ext4_lblk_t num,
>  				   struct fiemap_extent_info *fieinfo)
> @@ -5058,64 +4907,13 @@ int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
>  	return ret < 0 ? ret : err;
>  }
>  
> -/*
> - * If newes is not existing extent (newes->ec_pblk equals zero) find
> - * delayed extent at start of newes and update newes accordingly and
> - * return start of the next delayed extent.
> - *
> - * If newes is existing extent (newes->ec_pblk is not equal zero)
> - * return start of next delayed extent or EXT_MAX_BLOCKS if no delayed
> - * extent found. Leave newes unmodified.
> - */
> -static int ext4_find_delayed_extent(struct inode *inode,
> -				    struct extent_status *newes)
> -{
> -	struct extent_status es;
> -	ext4_lblk_t block, next_del;
> -
> -	if (newes->es_pblk == 0) {
> -		ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> -					  newes->es_lblk,
> -					  newes->es_lblk + newes->es_len - 1,
> -					  &es);
> -
> -		/*
> -		 * No extent in extent-tree contains block @newes->es_pblk,
> -		 * then the block may stay in 1)a hole or 2)delayed-extent.
> -		 */
> -		if (es.es_len == 0)
> -			/* A hole found. */
> -			return 0;
> -
> -		if (es.es_lblk > newes->es_lblk) {
> -			/* A hole found. */
> -			newes->es_len = min(es.es_lblk - newes->es_lblk,
> -					    newes->es_len);
> -			return 0;
> -		}
> -
> -		newes->es_len = es.es_lblk + es.es_len - newes->es_lblk;
> -	}
> -
> -	block = newes->es_lblk + newes->es_len;
> -	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, block,
> -				  EXT_MAX_BLOCKS, &es);
> -	if (es.es_len == 0)
> -		next_del = EXT_MAX_BLOCKS;
> -	else
> -		next_del = es.es_lblk;
> -
> -	return next_del;
> -}
> -
> -static int ext4_xattr_fiemap(struct inode *inode,
> -				struct fiemap_extent_info *fieinfo)
> +static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
>  {
>  	__u64 physical = 0;
> -	__u64 length;
> -	__u32 flags = FIEMAP_EXTENT_LAST;
> +	__u64 length = 0;
>  	int blockbits = inode->i_sb->s_blocksize_bits;
>  	int error = 0;
> +	u16 iomap_type;
>  
>  	/* in-inode? */
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> @@ -5130,40 +4928,49 @@ static int ext4_xattr_fiemap(struct inode *inode,
>  				EXT4_I(inode)->i_extra_isize;
>  		physical += offset;
>  		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>  		brelse(iloc.bh);
> -	} else { /* external block */
> +		iomap_type = IOMAP_INLINE;
> +	} else if (EXT4_I(inode)->i_file_acl) { /* external block */
>  		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>  		length = inode->i_sb->s_blocksize;
> +		iomap_type = IOMAP_MAPPED;
> +	} else {
> +		/* no in-inode or external block for xattr, so return -ENOENT */
> +		error = -ENOENT;
> +		goto out;
>  	}
>  
> -	if (physical)
> -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
> -						length, flags);
> -	return (error < 0 ? error : 0);
> +	iomap->addr = physical;
> +	iomap->offset = 0;
> +	iomap->length = length;
> +	iomap->type = iomap_type;
> +	iomap->flags = 0;
> +out:
> +	return error;
>  }
>  
> -static int _ext4_fiemap(struct inode *inode,
> -			struct fiemap_extent_info *fieinfo,
> -			__u64 start, __u64 len,
> -			int (*fill)(struct inode *, ext4_lblk_t,
> -				    ext4_lblk_t,
> -				    struct fiemap_extent_info *))
> +static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
> +				  loff_t length, unsigned flags,
> +				  struct iomap *iomap, struct iomap *srcmap)
>  {
> -	ext4_lblk_t start_blk;
> -	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
> +	int error;
>  
> -	int error = 0;
> -
> -	if (ext4_has_inline_data(inode)) {
> -		int has_inline = 1;
> +	error = ext4_iomap_xattr_fiemap(inode, iomap);
> +	if (error == 0 && (offset >= iomap->length))
> +		error = -ENOENT;
> +	return error;
> +}
>  
> -		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
> -						start, len);
> +static const struct iomap_ops ext4_iomap_xattr_ops = {
> +	.iomap_begin		= ext4_iomap_xattr_begin,
> +};
>  
> -		if (has_inline)
> -			return error;
> -	}
> +static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +			__u64 start, __u64 len, bool from_es_cache)
> +{
> +	ext4_lblk_t start_blk;
> +	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR;
> +	int error = 0;
>  
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
>  		error = ext4_ext_precache(inode);
> @@ -5172,19 +4979,19 @@ static int _ext4_fiemap(struct inode *inode,
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>  	}
>  
> -	/* fallback to generic here if not in extents fmt */
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) &&
> -	    fill == ext4_fill_fiemap_extents)
> -		return generic_block_fiemap(inode, fieinfo, start, len,
> -			ext4_get_block);
> -
> -	if (fill == ext4_fill_es_cache_info)
> +	if (from_es_cache)
>  		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
> +
>  	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
>  		return -EBADR;
>  
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
> -		error = ext4_xattr_fiemap(inode, fieinfo);
> +		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
> +		error = iomap_fiemap(inode, fieinfo, start, len,
> +				     &ext4_iomap_xattr_ops);
> +	} else if (!from_es_cache) {
> +		error = iomap_fiemap(inode, fieinfo, start, len,
> +				     &ext4_iomap_report_ops);
>  	} else {
>  		ext4_lblk_t len_blks;
>  		__u64 last_blk;
> @@ -5199,7 +5006,8 @@ static int _ext4_fiemap(struct inode *inode,
>  		 * Walk the extent tree gathering extent information
>  		 * and pushing extents back to the user.
>  		 */
> -		error = fill(inode, start_blk, len_blks, fieinfo);
> +		error = ext4_fill_es_cache_info(inode, start_blk, len_blks,
> +						fieinfo);
>  	}
>  	return error;
>  }
> @@ -5207,8 +5015,7 @@ static int _ext4_fiemap(struct inode *inode,
>  int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		__u64 start, __u64 len)
>  {
> -	return _ext4_fiemap(inode, fieinfo, start, len,
> -			    ext4_fill_fiemap_extents);
> +	return _ext4_fiemap(inode, fieinfo, start, len, false);
>  }
>  
>  int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
> @@ -5224,8 +5031,7 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			return 0;
>  	}
>  
> -	return _ext4_fiemap(inode, fieinfo, start, len,
> -			    ext4_fill_es_cache_info);
> +	return _ext4_fiemap(inode, fieinfo, start, len, true);
>  }
>  
>  
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index e61603f47035..b8b99634c832 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1857,47 +1857,6 @@ int ext4_inline_data_iomap(struct inode *inode, struct iomap *iomap)
>  	return error;
>  }
>  
> -int ext4_inline_data_fiemap(struct inode *inode,
> -			    struct fiemap_extent_info *fieinfo,
> -			    int *has_inline, __u64 start, __u64 len)
> -{
> -	__u64 physical = 0;
> -	__u64 inline_len;
> -	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
> -		FIEMAP_EXTENT_LAST;
> -	int error = 0;
> -	struct ext4_iloc iloc;
> -
> -	down_read(&EXT4_I(inode)->xattr_sem);
> -	if (!ext4_has_inline_data(inode)) {
> -		*has_inline = 0;
> -		goto out;
> -	}
> -	inline_len = min_t(size_t, ext4_get_inline_size(inode),
> -			   i_size_read(inode));
> -	if (start >= inline_len)
> -		goto out;
> -	if (start + len < inline_len)
> -		inline_len = start + len;
> -	inline_len -= start;
> -
> -	error = ext4_get_inode_loc(inode, &iloc);
> -	if (error)
> -		goto out;
> -
> -	physical = (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
> -	physical += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
> -	physical += offsetof(struct ext4_inode, i_block);
> -
> -	brelse(iloc.bh);
> -out:
> -	up_read(&EXT4_I(inode)->xattr_sem);
> -	if (physical)
> -		error = fiemap_fill_next_extent(fieinfo, start, physical,
> -						inline_len, flags);
> -	return (error < 0 ? error : 0);
> -}
> -
>  int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
>  {
>  	handle_t *handle;
> -- 
> 2.21.0
> 
