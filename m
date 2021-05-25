Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AF390CF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 01:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEYXbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 19:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYXbS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 19:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DF9D613C5;
        Tue, 25 May 2021 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621985388;
        bh=AJ+FqQjD2tfizRfYl3YcUjYoTFd7vYQranc9ATQtPko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3sxlTwGEaNgLugGNfFB4yLMkaP0igoa+rQCQhR/cwj6nhyR2AsfPVGHNafOibgPZ
         +/fa93Px8rOvbB4GxCa4vr9Bq48aLfie9SVnYOofWyWlMr5hCooIA2GNPKWmBzmNkM
         LQh34wNxbSKbLKpXhNBa4L9lc2ocCUljoODxRUX816i48FVYpf4tCnj4991lAvUWWN
         IZ8BYTBNBBbGKu+ic0Gxr7IV3HEUkHWZvEeDPURyGc9gTPI/XAxWH/zoRcgApXNdgK
         J+U55mGvivTg3EhS+U7ojz1X5esgMB6AsFkYWOCuPr5NE+FqwaqprV2hpsRHrIlQ6c
         svvYgo/or1FNw==
Date:   Tue, 25 May 2021 16:29:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v6 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210525232947.GE202144@locust>
References: <20210519060045.1051226-1-ruansy.fnst@fujitsu.com>
 <20210519060045.1051226-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519060045.1051226-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 02:00:43PM +0800, Shiyang Ruan wrote:
> With dax we cannot deal with readpage() etc. So, we create a dax
> comparison funciton which is similar with

s/funciton/function/

> vfs_dedupe_file_range_compare().
> And introduce dax_remap_file_range_prep() for filesystem use.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c             | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/remap_range.c     | 36 ++++++++++++++++++------
>  fs/xfs/xfs_reflink.c |  8 ++++--
>  include/linux/dax.h  |  8 ++++++
>  include/linux/fs.h   | 12 +++++---
>  5 files changed, 116 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index baee584cb8ae..93f16210847b 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1864,3 +1864,69 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
>  }
>  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> +
> +static loff_t dax_range_compare_actor(struct inode *ino1, loff_t pos1,
> +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> +		struct iomap *smap, struct iomap *dmap)
> +{
> +	void *saddr, *daddr;
> +	bool *same = data;
> +	int ret;
> +
> +	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
> +		*same = true;
> +		return len;
> +	}
> +
> +	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
> +		*same = false;
> +		return 0;
> +	}
> +
> +	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
> +				      &saddr, NULL);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
> +				      &daddr, NULL);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	*same = !memcmp(saddr, daddr, len);
> +	return len;
> +}
> +
> +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +		struct inode *dest, loff_t destoff, loff_t len, bool *is_same,
> +		const struct iomap_ops *ops)
> +{
> +	int id, ret = 0;
> +
> +	id = dax_read_lock();
> +	while (len) {
> +		ret = iomap_apply2(src, srcoff, dest, destoff, len, 0, ops,
> +				   is_same, dax_range_compare_actor);
> +		if (ret < 0 || !*is_same)
> +			goto out;
> +
> +		len -= ret;
> +		srcoff += ret;
> +		destoff += ret;
> +	}
> +	ret = 0;
> +out:
> +	dax_read_unlock(id);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_dedupe_file_range_compare);
> +
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops)
> +{
> +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> +					       pos_out, len, remap_flags, ops);
> +}
> +EXPORT_SYMBOL(dax_remap_file_range_prep);
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e4a5fdd7ad7b..4cfc1553f3bf 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -14,6 +14,7 @@
>  #include <linux/compat.h>
>  #include <linux/mount.h>
>  #include <linux/fs.h>
> +#include <linux/dax.h>
>  #include "internal.h"
>  
>  #include <linux/uaccess.h>
> @@ -199,9 +200,9 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
>   */
> -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> -					 struct inode *dest, loff_t destoff,
> -					 loff_t len, bool *is_same)
> +int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +				  struct inode *dest, loff_t destoff,
> +				  loff_t len, bool *is_same)
>  {
>  	loff_t src_poff;
>  	loff_t dest_poff;
> @@ -280,6 +281,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  out_error:
>  	return error;
>  }
> +EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
>  
>  /*
>   * Check that the two inodes are eligible for cloning, the ranges make
> @@ -289,9 +291,11 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>   * If there's an error, then the usual negative error code is returned.
>   * Otherwise returns 0 with *len set to the request length.
>   */
> -int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -				  struct file *file_out, loff_t pos_out,
> -				  loff_t *len, unsigned int remap_flags)
> +int
> +__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				loff_t *len, unsigned int remap_flags,
> +				const struct iomap_ops *dax_read_ops)
>  {
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
> @@ -351,8 +355,15 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	if (remap_flags & REMAP_FILE_DEDUP) {
>  		bool		is_same = false;
>  
> -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> -				inode_out, pos_out, *len, &is_same);
> +		if (!IS_DAX(inode_in))
> +			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> +					inode_out, pos_out, *len, &is_same);
> +		else if (dax_read_ops)
> +			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
> +					inode_out, pos_out, *len, &is_same,
> +					dax_read_ops);
> +		else
> +			return -EINVAL;
>  		if (ret)
>  			return ret;
>  		if (!is_same)
> @@ -370,6 +381,15 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(__generic_remap_file_range_prep);
> +
> +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  loff_t *len, unsigned int remap_flags)
> +{
> +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> +					       pos_out, len, remap_flags, NULL);
> +}
>  EXPORT_SYMBOL(generic_remap_file_range_prep);
>  
>  loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 060695d6d56a..d25434f93235 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1329,8 +1329,12 @@ xfs_reflink_remap_prep(
>  	if (IS_DAX(inode_in) || IS_DAX(inode_out))
>  		goto out_unlock;
>  
> -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> -			len, remap_flags);
> +	if (!IS_DAX(inode_in))
> +		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> +				pos_out, len, remap_flags);
> +	else
> +		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> +				pos_out, len, remap_flags, &xfs_read_iomap_ops);
>  	if (ret || *len == 0)
>  		goto out_unlock;
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 3275e01ed33d..106d1f033a78 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -239,6 +239,14 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
>  		struct iomap *srcmap);
> +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +				  struct inode *dest, loff_t destoff,
> +				  loff_t len, bool *is_same,
> +				  const struct iomap_ops *ops);
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops);

I totally thought that not having explicit static inline stubs of these
functions would break the build when CONFIG_FS_DAX=n, but then I
realized that when fsdax is disabled, S_DAX is zero, so this works
because dead code elimination in the compiler means that the object
files never receive deferred references to the dax functions, which
means that linking actually succeeds.

So:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..deed4371f34f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -71,6 +71,7 @@ struct fsverity_operations;
>  struct fs_context;
>  struct fs_parameter_spec;
>  struct fileattr;
> +struct iomap_ops;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -2126,10 +2127,13 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				       struct file *file_out, loff_t pos_out,
>  				       size_t len, unsigned int flags);
> -extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -					 struct file *file_out, loff_t pos_out,
> -					 loff_t *count,
> -					 unsigned int remap_flags);
> +int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				    struct file *file_out, loff_t pos_out,
> +				    loff_t *len, unsigned int remap_flags,
> +				    const struct iomap_ops *dax_read_ops);
> +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  loff_t *count, unsigned int remap_flags);
>  extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
>  				  loff_t len, unsigned int remap_flags);
> -- 
> 2.31.1
> 
> 
> 
