Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A260F63CE38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 05:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiK3EJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 23:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiK3EIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:08:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12E729803;
        Tue, 29 Nov 2022 20:08:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F14A9B819FC;
        Wed, 30 Nov 2022 04:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998CAC433C1;
        Wed, 30 Nov 2022 04:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669781327;
        bh=YqgkfAkC7fkxgy0kQrNLPnoW4g3hvntZHdESVA87dbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxus8bK+AeMi3jmPxJ9YYnQ9eNRWMKBAk2NIrm28RPOyPrHAoQhobrQQoaxb2HEDG
         /zZAwrvErNsq4nYExnOVodJ4RtwBC3NZ1rRPYzmp9RrolDntYkFCQN+CjvyKBPa4g/
         nTLsaqJK5B64jbADSGx3FW0qQITA3KEtD69rXwc3u6oDCG+peIQHeY7XJGUyzNPlBJ
         p/u6ip95fQ45MosyDEKrktDzJJXIFNXUEaPijMYnBTjQDEEAQesxkNvkqSBiZ53e49
         qinB1a9tdT8GaZYJG5BbKQghDiJjJ57aBgV+JZeAzqxXoaVaHtOm2fN2AYe5WLRH7S
         3V5VeXop36R2A==
Date:   Tue, 29 Nov 2022 20:08:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] fsdax,xfs: fix warning messages at
 dax_[dis]associate_entry()
Message-ID: <Y4bXTywl3PQTY3Er@magnolia>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669301694-16-2-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669301694-16-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 24, 2022 at 02:54:53PM +0000, Shiyang Ruan wrote:
> This patch fixes the warning message reported in dax_associate_entry()
> and dax_disassociate_entry().

Hmm, that's quite a bit to put in a single patch, but I'll try to get
through this...

> 1. reset page->mapping and ->index when refcount counting down to 0.
> 2. set IOMAP_F_SHARED flag when iomap read to allow one dax page to be
> associated more than once for not only write but also read.

That makes sense, I think.

> 3. should zero the edge (when not aligned) if srcmap is HOLE or

When is IOMAP_F_SHARED set on the /source/ mapping?

> UNWRITTEN.
> 4. iterator of two files in dedupe should be executed side by side, not
> nested.

Why?  Also, this seems like a separate change?

> 5. use xfs_dax_write_iomap_ops for xfs zero and truncate. 

Makes sense.

> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c           | 114 ++++++++++++++++++++++++++-------------------
>  fs/xfs/xfs_iomap.c |   6 +--
>  2 files changed, 69 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1c6867810cbd..5ea7c0926b7f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -398,7 +398,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>  		if (dax_mapping_is_cow(page->mapping)) {
>  			/* keep the CoW flag if this page is still shared */
> -			if (page->index-- > 0)
> +			if (page->index-- > 1)

Hmm.  So if the fsdax "page" sharing factor drops from 2 to 1, we'll now
null out the mapping and index?  Before, we only did that when it
dropped from 1 to 0.

Does this leave the page with no mapping?  And I guess a subsequent
access will now take a fault to map it back in?

>  				continue;
>  		} else
>  			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> @@ -840,12 +840,6 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
>  		(iter->iomap.flags & IOMAP_F_DIRTY);
>  }
>  
> -static bool dax_fault_is_cow(const struct iomap_iter *iter)
> -{
> -	return (iter->flags & IOMAP_WRITE) &&
> -		(iter->iomap.flags & IOMAP_F_SHARED);
> -}
> -
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -859,13 +853,14 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	void *new_entry = dax_make_entry(pfn, flags);
> -	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
> -	bool cow = dax_fault_is_cow(iter);
> +	bool write = iter->flags & IOMAP_WRITE;
> +	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
> +	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> -	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
> +	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {

Ah, ok, so now we're yanking the mapping if the extent is shared,
presumably so that...

>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -877,12 +872,12 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>  
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		void *old;
>  
>  		dax_disassociate_entry(entry, mapping, false);
>  		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
> -				cow);
> +				shared);

...down here we can rebuild the association, but this time we'll set the
page->mapping to PAGE_MAPPING_DAX_COW?  I see a lot of similar changes,
so I'm guessing this is how you fixed the failures that were a result of
read file A -> reflink A to B -> read file B sequences?

>  		/*
>  		 * Only swap our new entry into the page cache if the current
>  		 * entry is a zero page or an empty entry.  If a normal PTE or
> @@ -902,7 +897,7 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>  
> -	if (cow)
> +	if (write && shared)
>  		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
>  
>  	xas_unlock_irq(xas);
> @@ -1107,23 +1102,35 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,

I think this function isn't well named.  It's copying into the parts of
the @daddr page that are *not* covered by @pos/@length.  In other words,
it's really copying *around* the range that's supplied, isn't it?

>  	loff_t end = pos + length;
>  	loff_t pg_end = round_up(end, align_size);
>  	bool copy_all = head_off == 0 && end == pg_end;
> +	/* write zero at edge if srcmap is a HOLE or IOMAP_UNWRITTEN */
> +	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||

When is IOMAP_F_SHARED set on the /source/ mapping?  I don't understand
that circumstance, so I don't understand why we want to zero around in
that case.

> +			 srcmap->type == IOMAP_UNWRITTEN;

Though it's self evident why we'd do that if the source map is
unwritten.

>  	void *saddr = 0;
>  	int ret = 0;
>  
> -	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> -	if (ret)
> -		return ret;
> +	if (!zero_edge) {
> +		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (copy_all) {
> -		ret = copy_mc_to_kernel(daddr, saddr, length);
> -		return ret ? -EIO : 0;
> +		if (zero_edge)
> +			memset(daddr, 0, size);
> +		else
> +			ret = copy_mc_to_kernel(daddr, saddr, length);
> +		goto out;
>  	}
>  
>  	/* Copy the head part of the range */
>  	if (head_off) {
> -		ret = copy_mc_to_kernel(daddr, saddr, head_off);
> -		if (ret)
> -			return -EIO;
> +		if (zero_edge)
> +			memset(daddr, 0, head_off);
> +		else {
> +			ret = copy_mc_to_kernel(daddr, saddr, head_off);
> +			if (ret)
> +				return -EIO;
> +		}
>  	}
>  
>  	/* Copy the tail part of the range */
> @@ -1131,12 +1138,19 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
>  		loff_t tail_off = head_off + length;
>  		loff_t tail_len = pg_end - end;
>  
> -		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
> -					tail_len);
> -		if (ret)
> -			return -EIO;
> +		if (zero_edge)
> +			memset(daddr + tail_off, 0, tail_len);
> +		else {
> +			ret = copy_mc_to_kernel(daddr + tail_off,
> +						saddr + tail_off, tail_len);
> +			if (ret)
> +				return -EIO;
> +		}
>  	}
> -	return 0;
> +out:
> +	if (zero_edge)
> +		dax_flush(srcmap->dax_dev, daddr, size);
> +	return ret ? -EIO : 0;
>  }
>  
>  /*
> @@ -1235,13 +1249,9 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
>  	if (ret < 0)
>  		return ret;
>  	memset(kaddr + offset, 0, size);
> -	if (srcmap->addr != iomap->addr) {
> -		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
> -					 kaddr);
> -		if (ret < 0)
> -			return ret;
> -		dax_flush(iomap->dax_dev, kaddr, PAGE_SIZE);
> -	} else
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap, kaddr);
> +	else
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	return ret;
>  }
> @@ -1258,6 +1268,15 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>  		return length;
>  
> +	/*
> +	 * invalidate the pages whose sharing state is to be changed
> +	 * because of CoW.
> +	 */
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		invalidate_inode_pages2_range(iter->inode->i_mapping,
> +					      pos >> PAGE_SHIFT,
> +					      (pos + length - 1) >> PAGE_SHIFT);
> +
>  	do {
>  		unsigned offset = offset_in_page(pos);
>  		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> @@ -1318,12 +1337,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		struct iov_iter *iter)
>  {
>  	const struct iomap *iomap = &iomi->iomap;
> -	const struct iomap *srcmap = &iomi->srcmap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iomi);
>  	loff_t length = iomap_length(iomi);
>  	loff_t pos = iomi->pos;
>  	struct dax_device *dax_dev = iomap->dax_dev;
>  	loff_t end = pos + length, done = 0;
>  	bool write = iov_iter_rw(iter) == WRITE;
> +	bool cow = write && iomap->flags & IOMAP_F_SHARED;
>  	ssize_t ret = 0;
>  	size_t xfer;
>  	int id;
> @@ -1350,7 +1370,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  	 * into page tables. We have to tear down these mappings so that data
>  	 * written by write(2) is visible in mmap.
>  	 */
> -	if (iomap->flags & IOMAP_F_NEW) {
> +	if (iomap->flags & IOMAP_F_NEW || cow) {
>  		invalidate_inode_pages2_range(iomi->inode->i_mapping,
>  					      pos >> PAGE_SHIFT,
>  					      (end - 1) >> PAGE_SHIFT);
> @@ -1384,8 +1404,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  			break;
>  		}
>  
> -		if (write &&
> -		    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> +		if (cow) {
>  			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
>  						 kaddr);
>  			if (ret)
> @@ -1532,7 +1551,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  		struct xa_state *xas, void **entry, bool pmd)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> -	const struct iomap *srcmap = &iter->srcmap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
>  	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>  	bool write = iter->flags & IOMAP_WRITE;
> @@ -1563,8 +1582,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  
>  	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
>  
> -	if (write &&
> -	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> +	if (write && iomap->flags & IOMAP_F_SHARED) {
>  		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
>  		if (err)
>  			return dax_fault_return(err);
> @@ -1936,15 +1954,15 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,

Does the dedupe change need to be in this patch?  It looks ok both
before and after, so I don't know why it's necessary.

Welp, thank you for fixing the problems, at least.  After a couple of
days it looks like the serious problems have cleared up.

--D

>  		.len		= len,
>  		.flags		= IOMAP_DAX,
>  	};
> -	int ret;
> +	int ret, compared = 0;
>  
> -	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
> -		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
> -			dst_iter.processed = dax_range_compare_iter(&src_iter,
> -						&dst_iter, len, same);
> -		}
> -		if (ret <= 0)
> -			src_iter.processed = ret;
> +	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
> +	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
> +		compared = dax_range_compare_iter(&src_iter, &dst_iter, len,
> +						  same);
> +		if (compared < 0)
> +			return ret;
> +		src_iter.processed = dst_iter.processed = compared;
>  	}
>  	return ret;
>  }
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 07da03976ec1..d9401d0300ad 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1215,7 +1215,7 @@ xfs_read_iomap_begin(
>  		return error;
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>  			       &nimaps, 0);
> -	if (!error && (flags & IOMAP_REPORT))
> +	if (!error && ((flags & IOMAP_REPORT) || IS_DAX(inode)))
>  		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
>  	xfs_iunlock(ip, lockmode);
>  
> @@ -1370,7 +1370,7 @@ xfs_zero_range(
>  
>  	if (IS_DAX(inode))
>  		return dax_zero_range(inode, pos, len, did_zero,
> -				      &xfs_direct_write_iomap_ops);
> +				      &xfs_dax_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
>  				&xfs_buffered_write_iomap_ops);
>  }
> @@ -1385,7 +1385,7 @@ xfs_truncate_page(
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
> -					&xfs_direct_write_iomap_ops);
> +					&xfs_dax_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> -- 
> 2.38.1
> 
