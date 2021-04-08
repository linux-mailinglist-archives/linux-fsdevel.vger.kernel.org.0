Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE8358F81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 23:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhDHVxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 17:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhDHVxb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B46E610E6;
        Thu,  8 Apr 2021 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617918798;
        bh=A6hMiax8/Or4LgNgXkUOelrTPiu/9BumK44HXSqfYOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3UgSbfLjLyszGJJ0okGlDnxF/Jo+EQZsoDN7YjCW+ScTgoJQ21QcQllqj0WMW8AY
         phwC2BxfW75myZd+/4n3cVt0fJ2iIfKznXI3phH88YZ4Hkqvn57FyZNz+3swTTgklS
         H2uVClhQNfLPP2gG5KWl+cUx2iG7jMTKAn2WSpT9P3BZ3EDg/H6FSC3u4Lh+RvwWkA
         COgFaum7EWRQu2ozHAXcJFbdygyMgMquWLpoJx7u6p43Q+SzkxPDbI6xZoYlmvZ1fv
         L/+yxwO8eahF10cCzjemscD74D3C+veBLTteFgZV7A65PA7V1LXJ6SGDoxNt8RDbD2
         9T0b/O6QpzD3Q==
Date:   Thu, 8 Apr 2021 14:53:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH v4 1/7] fsdax: Introduce dax_iomap_cow_copy()
Message-ID: <20210408215317.GY3957620@magnolia>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408120432.1063608-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:04:26PM +0800, Shiyang Ruan wrote:
> In the case where the iomap is a write operation and iomap is not equal
> to srcmap after iomap_begin, we consider it is a CoW operation.
> 
> The destance extent which iomap indicated is new allocated extent.
> So, it is needed to copy the data from srcmap to new allocated extent.
> In theory, it is better to copy the head and tail ranges which is
> outside of the non-aligned area instead of copying the whole aligned
> range. But in dax page fault, it will always be an aligned range.  So,
> we have to copy the whole range in this case.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 8d7e4e2cc0fb..b4fd3813457a 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1038,6 +1038,61 @@ static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
>  	return rc;
>  }
>  
> +/**
> + * dax_iomap_cow_copy(): Copy the data from source to destination before write.
> + * @pos:	address to do copy from.
> + * @length:	size of copy operation.
> + * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
> + * @srcmap:	iomap srcmap
> + * @daddr:	destination address to copy to.
> + *
> + * This can be called from two places. Either during DAX write fault, to copy
> + * the length size data to daddr. Or, while doing normal DAX write operation,
> + * dax_iomap_actor() might call this to do the copy of either start or end
> + * unaligned address. In this case the rest of the copy of aligned ranges is
> + * taken care by dax_iomap_actor() itself.

Er... what?  This description is very confusing to me.  /me reads the
code, and ...

OH.

Given a range (pos, length) and a mapping for a source file, this
function copies all the bytes between pos and (pos + length) to daddr if
the range is aligned to @align_size.  But if pos and length are not both
aligned to align_src then it'll copy *around* the range, leaving the
area in the middle uncopied waiting for write_iter to fill it in with
whatever's in the iovec.

Yikes, this function is doing double duty and ought to be split into
two functions.

The first function does the COW work for a write fault to an mmap
region and does a straight copy.  Page faults are always aligned, so
this functionality is needed by dax_fault_actor.  Maybe this could be
named dax_fault_cow?

The second function does the prep COW work *around* a write so that we
always copy entire page/blocks.  This cow-around code is needed by
dax_iomap_actor.  This should perhaps be named dax_iomap_cow_around()?

> + * Also, note DAX fault will always result in aligned pos and pos + length.
> + */
> +static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t align_size,
> +		struct iomap *srcmap, void *daddr)
> +{
> +	loff_t head_off = pos & (align_size - 1);
> +	size_t size = ALIGN(head_off + length, align_size);
> +	loff_t end = pos + length;
> +	loff_t pg_end = round_up(end, align_size);
> +	bool copy_all = head_off == 0 && end == pg_end;
> +	void *saddr = 0;
> +	int ret = 0;
> +
> +	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_all) {
> +		ret = copy_mc_to_kernel(daddr, saddr, length);
> +		return ret ? -EIO : 0;

I find it /very/ interesting that copy_mc_to_kernel takes an unsigned
int argument but returns an unsigned long (counting the bytes that
didn't get copied, oddly...but that's an existing API so I guess I'll
let it go.)

> +	}
> +
> +	/* Copy the head part of the range.  Note: we pass offset as length. */
> +	if (head_off) {
> +		ret = copy_mc_to_kernel(daddr, saddr, head_off);
> +		if (ret)
> +			return -EIO;
> +	}
> +
> +	/* Copy the tail part of the range */
> +	if (end < pg_end) {
> +		loff_t tail_off = head_off + length;
> +		loff_t tail_len = pg_end - end;
> +
> +		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
> +					tail_len);
> +		if (ret)
> +			return -EIO;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * The user has performed a load from a hole in the file.  Allocating a new
>   * page in the file would cause excessive storage usage for workloads with
> @@ -1167,11 +1222,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	struct dax_device *dax_dev = iomap->dax_dev;
>  	struct iov_iter *iter = data;
>  	loff_t end = pos + length, done = 0;
> +	bool write = iov_iter_rw(iter) == WRITE;
>  	ssize_t ret = 0;
>  	size_t xfer;
>  	int id;
>  
> -	if (iov_iter_rw(iter) == READ) {
> +	if (!write) {
>  		end = min(end, i_size_read(inode));
>  		if (pos >= end)
>  			return 0;
> @@ -1180,7 +1236,8 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			return iov_iter_zero(min(length, end - pos), iter);
>  	}
>  
> -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> +			!(iomap->flags & IOMAP_F_SHARED)))

This is a bit subtle.  Could we add a comment:

	/*
	 * In DAX mode, we allow either pure overwrites of written extents,
	 * or writes to unwritten extents as part of a copy-on-write
	 * operation.
	 */
	if (WARN_ON_ONCE(...))

>  		return -EIO;
>  
>  	/*
> @@ -1219,6 +1276,13 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> +		if (write && srcmap->addr != iomap->addr) {

Do you have to check if srcmap is not a hole?

--D

> +			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> +						 kaddr);
> +			if (ret)
> +				break;
> +		}
> +
>  		map_len = PFN_PHYS(map_len);
>  		kaddr += offset;
>  		map_len -= offset;
> @@ -1230,7 +1294,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		 * validated via access_ok() in either vfs_read() or
>  		 * vfs_write(), depending on which operation we are doing.
>  		 */
> -		if (iov_iter_rw(iter) == WRITE)
> +		if (write)
>  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>  					map_len, iter);
>  		else
> @@ -1382,6 +1446,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
>  	int err = 0;
>  	pfn_t pfn;
> +	void *kaddr;
>  
>  	/* if we are reading UNWRITTEN and HOLE, return a hole. */
>  	if (!write &&
> @@ -1392,18 +1457,25 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  			return dax_pmd_load_hole(xas, vmf, iomap, entry);
>  	}
>  
> -	if (iomap->type != IOMAP_MAPPED) {
> +	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
>  		WARN_ON_ONCE(1);
>  		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
>  	}
>  
> -	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
> +	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
>  	if (err)
>  		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>  
>  	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
>  				  write && !sync);
>  
> +	if (write &&
> +	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> +		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
> +		if (err)
> +			return dax_fault_return(err);
> +	}
> +
>  	if (sync)
>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
>  
> -- 
> 2.31.0
> 
> 
> 
