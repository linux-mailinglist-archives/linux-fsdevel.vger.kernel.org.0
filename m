Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD8306A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 02:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhA1BNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 20:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhA1BLX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:11:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DC8960C40;
        Thu, 28 Jan 2021 01:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611796242;
        bh=v3T7ujwKzSnkDtCCImiUZpKv0YgdS5KXdKZ00euqCw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RV991imw0fVh9WuRc7VZ1451DK+8xNudMlmBSu97HfL/HcAG9EyJ1e7YNloQE4ILz
         elCgFA61wcaut5wzKbnnk0ifs0RqDiLl723PFM9yyMWgnrRpNhKQxPfoG+XgvL1kUy
         6XlI59+no6iuAZSuD5reFegb6Qb9+WUT9LWC57KFskhN80VGRPn/QMZer4GyYh9gNk
         d7yXXDc+QS4mYUHJnrhMH0ElxbMnh4dqMZ7u/itMFe7DChNCgDNEo0tngRwOrRk/0i
         uj0s1HyPFsKM1vELAsrjK1+RWRRBPjBj4kV82JwQ4ZQbhmIZ/FASrnPH+4oWOAT5AF
         E/nbh2iHNYlMg==
Date:   Wed, 27 Jan 2021 17:10:39 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 4/6] fs-verity: support reading Merkle tree with ioctl
Message-ID: <YBIPD53iVg1US++r@google.com>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115181819.34732-5-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/15, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for FS_VERITY_METADATA_TYPE_MERKLE_TREE to
> FS_IOC_READ_VERITY_METADATA.  This allows a userspace server program to
> retrieve the Merkle tree of a verity file for serving to a client which
> implements fs-verity compatible verification.  See the patch which
> introduced FS_IOC_READ_VERITY_METADATA for more details.
> 
> This has been tested using a new xfstest which calls this ioctl via a
> new subcommand for the 'fsverity' program from fsverity-utils.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fsverity.rst | 10 +++-
>  fs/verity/read_metadata.c              | 70 ++++++++++++++++++++++++++
>  include/uapi/linux/fsverity.h          |  2 +
>  3 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> index 9ef7a7de60085..50b47a6d9ea11 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst
> @@ -234,6 +234,8 @@ need this ioctl.
>  
>  This ioctl takes in a pointer to the following structure::
>  
> +   #define FS_VERITY_METADATA_TYPE_MERKLE_TREE     1
> +
>     struct fsverity_read_metadata_arg {
>             __u64 metadata_type;
>             __u64 offset;
> @@ -242,7 +244,13 @@ This ioctl takes in a pointer to the following structure::
>             __u64 __reserved;
>     };
>  
> -``metadata_type`` specifies the type of metadata to read.
> +``metadata_type`` specifies the type of metadata to read:
> +
> +- ``FS_VERITY_METADATA_TYPE_MERKLE_TREE`` reads the blocks of the
> +  Merkle tree.  The blocks are returned in order from the root level
> +  to the leaf level.  Within each level, the blocks are returned in
> +  the same order that their hashes are themselves hashed.
> +  See `Merkle tree`_ for more information.
>  
>  The semantics are similar to those of ``pread()``.  ``offset``
>  specifies the offset in bytes into the metadata item to read from, and
> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index 43be990fd53e4..0f8ad2991cf90 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -7,8 +7,75 @@
>  
>  #include "fsverity_private.h"
>  
> +#include <linux/backing-dev.h>
> +#include <linux/highmem.h>
> +#include <linux/sched/signal.h>
>  #include <linux/uaccess.h>
>  
> +static int fsverity_read_merkle_tree(struct inode *inode,
> +				     const struct fsverity_info *vi,
> +				     void __user *buf, u64 offset, int length)
> +{
> +	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> +	u64 end_offset;
> +	unsigned int offs_in_page;
> +	pgoff_t index, last_index;
> +	int retval = 0;
> +	int err = 0;
> +
> +	end_offset = min(offset + length, vi->tree_params.tree_size);
> +	if (offset >= end_offset)
> +		return 0;
> +	offs_in_page = offset_in_page(offset);
> +	last_index = (end_offset - 1) >> PAGE_SHIFT;
> +
> +	/*
> +	 * Iterate through each Merkle tree page in the requested range and copy
> +	 * the requested portion to userspace.  Note that the Merkle tree block
> +	 * size isn't important here, as we are returning a byte stream; i.e.,
> +	 * we can just work with pages even if the tree block size != PAGE_SIZE.
> +	 */
> +	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
> +		unsigned long num_ra_pages =
> +			min_t(unsigned long, last_index - index + 1,
> +			      inode->i_sb->s_bdi->io_pages);
> +		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
> +						   PAGE_SIZE - offs_in_page);
> +		struct page *page;
> +		const void *virt;
> +
> +		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
> +		if (IS_ERR(page)) {
> +			err = PTR_ERR(page);
> +			fsverity_err(inode,
> +				     "Error %d reading Merkle tree page %lu",
> +				     err, index);
> +			break;
> +		}
> +
> +		virt = kmap(page);
> +		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
> +			kunmap(page);
> +			put_page(page);
> +			err = -EFAULT;
> +			break;
> +		}
> +		kunmap(page);
> +		put_page(page);
> +
> +		retval += bytes_to_copy;
> +		buf += bytes_to_copy;
> +		offset += bytes_to_copy;
> +
> +		if (fatal_signal_pending(current))  {
> +			err = -EINTR;
> +			break;
> +		}
> +		cond_resched();
> +		offs_in_page = 0;
> +	}

Minor thought:
How about invalidating or truncating merkel tree pages?

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> +	return retval ? retval : err;
> +}
>  /**
>   * fsverity_ioctl_read_metadata() - read verity metadata from a file
>   * @filp: file to read the metadata from
> @@ -48,6 +115,9 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
>  	buf = u64_to_user_ptr(arg.buf_ptr);
>  
>  	switch (arg.metadata_type) {
> +	case FS_VERITY_METADATA_TYPE_MERKLE_TREE:
> +		return fsverity_read_merkle_tree(inode, vi, buf, arg.offset,
> +						 length);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
> index e062751294d01..94003b153cb3d 100644
> --- a/include/uapi/linux/fsverity.h
> +++ b/include/uapi/linux/fsverity.h
> @@ -83,6 +83,8 @@ struct fsverity_formatted_digest {
>  	__u8 digest[];
>  };
>  
> +#define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
> +
>  struct fsverity_read_metadata_arg {
>  	__u64 metadata_type;
>  	__u64 offset;
> -- 
> 2.30.0
