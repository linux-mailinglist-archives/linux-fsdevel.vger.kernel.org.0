Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5837B347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 03:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELBJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 21:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhELBJU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 21:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10F9161287;
        Wed, 12 May 2021 01:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620781693;
        bh=WMjYsQKfPQb4prJVKhVKqaB/94CM4DtIT053bm9RioE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gh3G1EEz0tF8FeTeXzKzgaZwGpoTA02TzsIdyO7FrhcpGlQy7Rvp4OqEWgAEzfBCx
         Y/Vx+ZvMlsgiytvmxXJhPtdBuVUWsAOWOaWVpHNs/F5fPfCeSyYSsaqvZ/eRtZs2so
         z9OCTHl51nPlvNq9vnrZB3hjG3DH3r7VAe/xodDc7SHmdObfgJTAoTst+S4pwKpBHu
         L2LqZkzToTdm4gH+zfbaeXwdQkcp9uvPdzq/jjuxtCWeXdoOoQ++l4oAu1l/uFdKjv
         5Ot2wXN8UAosHOspfO0QLZniUeHOzv49OYQvkC//xFtcSCZHFSVyp04SVirXUezyXj
         YhOYdZ2eMonng==
Date:   Tue, 11 May 2021 18:08:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
Message-ID: <20210512010810.GR8582@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511030933.3080921-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 11:09:27AM +0800, Shiyang Ruan wrote:
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
>  fs/dax.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index bf3fc8242e6c..f0249bb1d46a 100644
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
> + * Also, note DAX fault will always result in aligned pos and pos + length.
> + */
> +static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t align_size,

Nit: Linus has asked us not to continue the use of loff_t for file
io length.  Could you change this to 'uint64_t length', please?
(Assuming we even need the extra length bits?)

With that fixed up...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		struct iomap *srcmap, void *daddr)
> +{
> +	loff_t head_off = pos & (align_size - 1);

Other nit: head_off = round_down(pos, align_size); ?

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
> @@ -1180,7 +1236,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			return iov_iter_zero(min(length, end - pos), iter);
>  	}
>  
> -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> +	/*
> +	 * In DAX mode, we allow either pure overwrites of written extents, or
> +	 * writes to unwritten extents as part of a copy-on-write operation.
> +	 */
> +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> +			!(iomap->flags & IOMAP_F_SHARED)))
>  		return -EIO;
>  
>  	/*
> @@ -1219,6 +1280,13 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> +		if (write && srcmap->addr != iomap->addr) {
> +			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> +						 kaddr);
> +			if (ret)
> +				break;
> +		}
> +
>  		map_len = PFN_PHYS(map_len);
>  		kaddr += offset;
>  		map_len -= offset;
> @@ -1230,7 +1298,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		 * validated via access_ok() in either vfs_read() or
>  		 * vfs_write(), depending on which operation we are doing.
>  		 */
> -		if (iov_iter_rw(iter) == WRITE)
> +		if (write)
>  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>  					map_len, iter);
>  		else
> @@ -1382,6 +1450,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
>  	int err = 0;
>  	pfn_t pfn;
> +	void *kaddr;
>  
>  	/* if we are reading UNWRITTEN and HOLE, return a hole. */
>  	if (!write &&
> @@ -1392,18 +1461,25 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
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
> 2.31.1
> 
> 
> 
