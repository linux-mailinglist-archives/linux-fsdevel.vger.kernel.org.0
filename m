Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28892F85FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 02:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLBWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 20:22:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44044 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLBWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:22:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1KThx174264;
        Tue, 12 Nov 2019 01:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=jrGapPxkFZOm7NHEqYQyYFfOwGBCUEAJLi6ulXrYylQ=;
 b=aYBHiZm3Fn/92fCzu9sJ2g/rkZvcLW3COWyeSL16EGLc0qF7XG6rFXQG1p27n2A5tP+M
 0aEYmM7GsinKfkNtyZNMteoPXG8bL5jftfPapoc1EC4Gcg6qG2/9gM9x+lCErm73QLJ9
 d0p7HsuKmyruf52rPcEteW9nRQEPVepv3omr3qQgQvr4FRptzoRqgjSy7gjObSYElGbb
 G3bguz6temJQ5xyoFJRI9na6xa9QhAFDOa4ygyrfagp796b64nivtDch1e8I2DAoACq0
 eZY6cGXQ/8KW6pGj3Ljoo+7sZs77f6eoh/GTcHcvbCjEwgNGcKjLF9WQC1zYY4r8jMTj /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w5p3qhfs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:20:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JGdD172345;
        Tue, 12 Nov 2019 01:20:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w6r8kbu1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:20:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAC1KJFX030412;
        Tue, 12 Nov 2019 01:20:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Nov 2019 17:20:19 -0800
Date:   Mon, 11 Nov 2019 17:20:17 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Message-ID: <20191112012017.GT6219@magnolia>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112003452.4756-3-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:34:52PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> swap_activate() and swap_deactivate() have nothing to do with
> address spaces.  We want to eventually make the address space operations
> dynamic to switch inode flags on the fly.  So to simplify this code as
> well as properly track these operations we move these functions to the
> file_operations vector.
> 
> This has been tested with XFS but not NFS, f2fs, or btrfs.
> 
> Also note f2fs and xfs have simple moves of their functions to
> facilitate compilation.  No functional changes are contained within
> those functions.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/btrfs/inode.c   |   4 +-
>  fs/f2fs/data.c     | 122 ---------------------------------------------
>  fs/f2fs/file.c     | 122 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/file.c      |   4 +-
>  fs/xfs/xfs_aops.c  |  13 -----
>  fs/xfs/xfs_file.c  |  12 +++++
>  include/linux/fs.h |  10 ++--
>  mm/swapfile.c      |  12 ++---
>  8 files changed, 148 insertions(+), 151 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6d159df7b536..4521f7dc0e8c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -11002,6 +11002,8 @@ static const struct file_operations btrfs_dir_file_operations = {
>  #endif
>  	.release        = btrfs_release_file,
>  	.fsync		= btrfs_sync_file,
> +	.swap_activate	= btrfs_swap_activate,
> +	.swap_deactivate = btrfs_swap_deactivate,
>  };
>  
>  static const struct extent_io_ops btrfs_extent_io_ops = {
> @@ -11032,8 +11034,6 @@ static const struct address_space_operations btrfs_aops = {
>  	.releasepage	= btrfs_releasepage,
>  	.set_page_dirty	= btrfs_set_page_dirty,
>  	.error_remove_page = generic_error_remove_page,
> -	.swap_activate	= btrfs_swap_activate,
> -	.swap_deactivate = btrfs_swap_deactivate,
>  };
>  
>  static const struct inode_operations btrfs_file_inode_operations = {
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3c7777bfae17..04b2a8f44fa9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -14,7 +14,6 @@
>  #include <linux/pagevec.h>
>  #include <linux/blkdev.h>
>  #include <linux/bio.h>
> -#include <linux/swap.h>
>  #include <linux/prefetch.h>
>  #include <linux/uio.h>
>  #include <linux/cleancache.h>
> @@ -3142,125 +3141,6 @@ int f2fs_migrate_page(struct address_space *mapping,
>  }
>  #endif
>  
> -#ifdef CONFIG_SWAP
> -/* Copied from generic_swapfile_activate() to check any holes */
> -static int check_swap_activate(struct file *swap_file, unsigned int max)
> -{
> -	struct inode *inode = swap_file->f_mapping->host;
> -	unsigned blocks_per_page;
> -	unsigned long page_no;
> -	unsigned blkbits;
> -	sector_t probe_block;
> -	sector_t last_block;
> -	sector_t lowest_block = -1;
> -	sector_t highest_block = 0;
> -
> -	blkbits = inode->i_blkbits;
> -	blocks_per_page = PAGE_SIZE >> blkbits;
> -
> -	/*
> -	 * Map all the blocks into the extent list.  This code doesn't try
> -	 * to be very smart.
> -	 */
> -	probe_block = 0;
> -	page_no = 0;
> -	last_block = i_size_read(inode) >> blkbits;
> -	while ((probe_block + blocks_per_page) <= last_block && page_no < max) {
> -		unsigned block_in_page;
> -		sector_t first_block;
> -
> -		cond_resched();
> -
> -		first_block = bmap(inode, probe_block);
> -		if (first_block == 0)
> -			goto bad_bmap;
> -
> -		/*
> -		 * It must be PAGE_SIZE aligned on-disk
> -		 */
> -		if (first_block & (blocks_per_page - 1)) {
> -			probe_block++;
> -			goto reprobe;
> -		}
> -
> -		for (block_in_page = 1; block_in_page < blocks_per_page;
> -					block_in_page++) {
> -			sector_t block;
> -
> -			block = bmap(inode, probe_block + block_in_page);
> -			if (block == 0)
> -				goto bad_bmap;
> -			if (block != first_block + block_in_page) {
> -				/* Discontiguity */
> -				probe_block++;
> -				goto reprobe;
> -			}
> -		}
> -
> -		first_block >>= (PAGE_SHIFT - blkbits);
> -		if (page_no) {	/* exclude the header page */
> -			if (first_block < lowest_block)
> -				lowest_block = first_block;
> -			if (first_block > highest_block)
> -				highest_block = first_block;
> -		}
> -
> -		page_no++;
> -		probe_block += blocks_per_page;
> -reprobe:
> -		continue;
> -	}
> -	return 0;
> -
> -bad_bmap:
> -	pr_err("swapon: swapfile has holes\n");
> -	return -EINVAL;
> -}
> -
> -static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
> -				sector_t *span)
> -{
> -	struct inode *inode = file_inode(file);
> -	int ret;
> -
> -	if (!S_ISREG(inode->i_mode))
> -		return -EINVAL;
> -
> -	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
> -		return -EROFS;
> -
> -	ret = f2fs_convert_inline_inode(inode);
> -	if (ret)
> -		return ret;
> -
> -	ret = check_swap_activate(file, sis->max);
> -	if (ret)
> -		return ret;
> -
> -	set_inode_flag(inode, FI_PIN_FILE);
> -	f2fs_precache_extents(inode);
> -	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> -	return 0;
> -}
> -
> -static void f2fs_swap_deactivate(struct file *file)
> -{
> -	struct inode *inode = file_inode(file);
> -
> -	clear_inode_flag(inode, FI_PIN_FILE);
> -}
> -#else
> -static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
> -				sector_t *span)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static void f2fs_swap_deactivate(struct file *file)
> -{
> -}
> -#endif
> -
>  const struct address_space_operations f2fs_dblock_aops = {
>  	.readpage	= f2fs_read_data_page,
>  	.readpages	= f2fs_read_data_pages,
> @@ -3273,8 +3153,6 @@ const struct address_space_operations f2fs_dblock_aops = {
>  	.releasepage	= f2fs_release_page,
>  	.direct_IO	= f2fs_direct_IO,
>  	.bmap		= f2fs_bmap,
> -	.swap_activate  = f2fs_swap_activate,
> -	.swap_deactivate = f2fs_swap_deactivate,
>  #ifdef CONFIG_MIGRATION
>  	.migratepage    = f2fs_migrate_page,
>  #endif
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 483ad22a0946..de7f9cf36689 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/uuid.h>
>  #include <linux/file.h>
>  #include <linux/nls.h>
> +#include <linux/swap.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -3466,6 +3467,125 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  #endif
>  
> +#ifdef CONFIG_SWAP
> +/* Copied from generic_swapfile_activate() to check any holes */
> +static int check_swap_activate(struct file *swap_file, unsigned int max)
> +{
> +	struct inode *inode = swap_file->f_mapping->host;
> +	unsigned blocks_per_page;
> +	unsigned long page_no;
> +	unsigned blkbits;
> +	sector_t probe_block;
> +	sector_t last_block;
> +	sector_t lowest_block = -1;
> +	sector_t highest_block = 0;
> +
> +	blkbits = inode->i_blkbits;
> +	blocks_per_page = PAGE_SIZE >> blkbits;
> +
> +	/*
> +	 * Map all the blocks into the extent list.  This code doesn't try
> +	 * to be very smart.
> +	 */
> +	probe_block = 0;
> +	page_no = 0;
> +	last_block = i_size_read(inode) >> blkbits;
> +	while ((probe_block + blocks_per_page) <= last_block && page_no < max) {
> +		unsigned block_in_page;
> +		sector_t first_block;
> +
> +		cond_resched();
> +
> +		first_block = bmap(inode, probe_block);
> +		if (first_block == 0)
> +			goto bad_bmap;
> +
> +		/*
> +		 * It must be PAGE_SIZE aligned on-disk
> +		 */
> +		if (first_block & (blocks_per_page - 1)) {
> +			probe_block++;
> +			goto reprobe;
> +		}
> +
> +		for (block_in_page = 1; block_in_page < blocks_per_page;
> +					block_in_page++) {
> +			sector_t block;
> +
> +			block = bmap(inode, probe_block + block_in_page);
> +			if (block == 0)
> +				goto bad_bmap;
> +			if (block != first_block + block_in_page) {
> +				/* Discontiguity */
> +				probe_block++;
> +				goto reprobe;
> +			}
> +		}
> +
> +		first_block >>= (PAGE_SHIFT - blkbits);
> +		if (page_no) {	/* exclude the header page */
> +			if (first_block < lowest_block)
> +				lowest_block = first_block;
> +			if (first_block > highest_block)
> +				highest_block = first_block;
> +		}
> +
> +		page_no++;
> +		probe_block += blocks_per_page;
> +reprobe:
> +		continue;
> +	}
> +	return 0;
> +
> +bad_bmap:
> +	pr_err("swapon: swapfile has holes\n");
> +	return -EINVAL;
> +}
> +
> +static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
> +				sector_t *span)
> +{
> +	struct inode *inode = file_inode(file);
> +	int ret;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
> +		return -EROFS;
> +
> +	ret = f2fs_convert_inline_inode(inode);
> +	if (ret)
> +		return ret;
> +
> +	ret = check_swap_activate(file, sis->max);
> +	if (ret)
> +		return ret;
> +
> +	set_inode_flag(inode, FI_PIN_FILE);
> +	f2fs_precache_extents(inode);
> +	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> +	return 0;
> +}
> +
> +static void f2fs_swap_deactivate(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +
> +	clear_inode_flag(inode, FI_PIN_FILE);
> +}
> +#else
> +static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
> +				sector_t *span)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void f2fs_swap_deactivate(struct file *file)
> +{
> +}
> +#endif
> +
>  const struct file_operations f2fs_file_operations = {
>  	.llseek		= f2fs_llseek,
>  	.read_iter	= generic_file_read_iter,
> @@ -3482,4 +3602,6 @@ const struct file_operations f2fs_file_operations = {
>  #endif
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
> +	.swap_activate  = f2fs_swap_activate,
> +	.swap_deactivate = f2fs_swap_deactivate,
>  };
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 95dc90570786..1f82f92185d6 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -520,8 +520,6 @@ const struct address_space_operations nfs_file_aops = {
>  	.launder_page = nfs_launder_page,
>  	.is_dirty_writeback = nfs_check_dirty_writeback,
>  	.error_remove_page = generic_error_remove_page,
> -	.swap_activate = nfs_swap_activate,
> -	.swap_deactivate = nfs_swap_deactivate,
>  };
>  
>  /*
> @@ -847,5 +845,7 @@ const struct file_operations nfs_file_operations = {
>  	.splice_write	= iter_file_splice_write,
>  	.check_flags	= nfs_check_flags,
>  	.setlease	= simple_nosetlease,
> +	.swap_activate = nfs_swap_activate,
> +	.swap_deactivate = nfs_swap_deactivate,
>  };
>  EXPORT_SYMBOL_GPL(nfs_file_operations);
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 3a688eb5c5ae..99f578a9ed90 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -631,17 +631,6 @@ xfs_vm_readpages(
>  	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
>  }
>  
> -static int
> -xfs_iomap_swapfile_activate(
> -	struct swap_info_struct		*sis,
> -	struct file			*swap_file,
> -	sector_t			*span)
> -{
> -	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
> -	return iomap_swapfile_activate(sis, swap_file, span,
> -			&xfs_read_iomap_ops);
> -}
> -
>  const struct address_space_operations xfs_address_space_operations = {
>  	.readpage		= xfs_vm_readpage,
>  	.readpages		= xfs_vm_readpages,
> @@ -655,7 +644,6 @@ const struct address_space_operations xfs_address_space_operations = {
>  	.migratepage		= iomap_migrate_page,
>  	.is_partially_uptodate  = iomap_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> -	.swap_activate		= xfs_iomap_swapfile_activate,
>  };
>  
>  const struct address_space_operations xfs_dax_aops = {
> @@ -663,5 +651,4 @@ const struct address_space_operations xfs_dax_aops = {
>  	.direct_IO		= noop_direct_IO,
>  	.set_page_dirty		= noop_set_page_dirty,
>  	.invalidatepage		= noop_invalidatepage,
> -	.swap_activate		= xfs_iomap_swapfile_activate,
>  };
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 865543e41fb4..3d2e89ac72ed 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1294,6 +1294,17 @@ xfs_file_mmap(
>  	return 0;
>  }
>  
> +static int
> +xfs_iomap_swapfile_activate(

Might as well rename this xfs_file_swap_activate().

Looks reasonable enough to me otherwise.

--D

> +	struct swap_info_struct		*sis,
> +	struct file			*swap_file,
> +	sector_t			*span)
> +{
> +	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
> +	return iomap_swapfile_activate(sis, swap_file, span,
> +			&xfs_read_iomap_ops);
> +}
> +
>  const struct file_operations xfs_file_operations = {
>  	.llseek		= xfs_file_llseek,
>  	.read_iter	= xfs_file_read_iter,
> @@ -1314,6 +1325,7 @@ const struct file_operations xfs_file_operations = {
>  	.fallocate	= xfs_file_fallocate,
>  	.fadvise	= xfs_file_fadvise,
>  	.remap_file_range = xfs_file_remap_range,
> +	.swap_activate	= xfs_iomap_swapfile_activate,
>  };
>  
>  const struct file_operations xfs_dir_file_operations = {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 83e011e0df7f..1175815da3df 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -402,11 +402,6 @@ struct address_space_operations {
>  					unsigned long);
>  	void (*is_dirty_writeback) (struct page *, bool *, bool *);
>  	int (*error_remove_page)(struct address_space *, struct page *);
> -
> -	/* swapfile support */
> -	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
> -				sector_t *span);
> -	void (*swap_deactivate)(struct file *file);
>  };
>  
>  extern const struct address_space_operations empty_aops;
> @@ -1858,6 +1853,11 @@ struct file_operations {
>  				   struct file *file_out, loff_t pos_out,
>  				   loff_t len, unsigned int remap_flags);
>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +
> +	/* swapfile support */
> +	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
> +				sector_t *span);
> +	void (*swap_deactivate)(struct file *file);
>  } __randomize_layout;
>  
>  struct inode_operations {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bb3261d45b6a..d2de8d668708 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2293,11 +2293,10 @@ static void destroy_swap_extents(struct swap_info_struct *sis)
>  
>  	if (sis->flags & SWP_ACTIVATED) {
>  		struct file *swap_file = sis->swap_file;
> -		struct address_space *mapping = swap_file->f_mapping;
>  
>  		sis->flags &= ~SWP_ACTIVATED;
> -		if (mapping->a_ops->swap_deactivate)
> -			mapping->a_ops->swap_deactivate(swap_file);
> +		if (swap_file->f_op->swap_deactivate)
> +			swap_file->f_op->swap_deactivate(swap_file);
>  	}
>  }
>  
> @@ -2381,8 +2380,7 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
>  static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
>  {
>  	struct file *swap_file = sis->swap_file;
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
> +	struct inode *inode = swap_file->f_mapping->host;
>  	int ret;
>  
>  	if (S_ISBLK(inode->i_mode)) {
> @@ -2391,8 +2389,8 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
>  		return ret;
>  	}
>  
> -	if (mapping->a_ops->swap_activate) {
> -		ret = mapping->a_ops->swap_activate(sis, swap_file, span);
> +	if (swap_file->f_op->swap_activate) {
> +		ret = swap_file->f_op->swap_activate(sis, swap_file, span);
>  		if (ret >= 0)
>  			sis->flags |= SWP_ACTIVATED;
>  		if (!ret) {
> -- 
> 2.20.1
> 
