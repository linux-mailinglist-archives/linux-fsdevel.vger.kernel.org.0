Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB9265F35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgIKMF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgIKMFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:05:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F6C061573;
        Fri, 11 Sep 2020 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBGMeo7Z3bILVQBNCXRTkaqZ/cUvm3/3WjMP2Kmt4aI=; b=lvBhg035LfgK50qipLzWAXiaX0
        viGTEQnKY+3TIxHChDreQqCvYFz7cDDmFm085DouN0NX6FSHjr+NIss4N8Ny2KsIdApPgRptpDY75
        CLIaFRCeDZfa9ttMBsGM13eOrxYYjrJ7BXhgP0U7vPC5QB9+Vh2g+2a0+2DhLI2EbrDL9kRPmiqyZ
        mmp2d2Z8VjPke1++KM7nPqPAb20/+qT9X/uLvSemyMlpr82jRxLxC1CJVhn+9FCm/oUEjYWR/Jb9U
        wBvszZFxMl5cWaBETRk1CuaGUmLCeGm785Y9qpD6N9vRmtr0gvDGLf9RNwhpk70ZwsoGyovwwICwZ
        gPbB7X8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGho1-0004T6-OM; Fri, 11 Sep 2020 12:05:29 +0000
Date:   Fri, 11 Sep 2020 13:05:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH V4] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200911120529.GZ6583@casper.infradead.org>
References: <20200821123306.1658495-1-yukuai3@huawei.com>
 <20200821124424.GQ17456@casper.infradead.org>
 <7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 04:27:08PM +0800, yukuai (C) wrote:
> Since your THP iomap patches were reviewed, I made some modifications
> based on these patches.

Thanks!  This looks good to me!

> +static void
> +iomap_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	struct inode *inode = page->mapping->host;
> +	unsigned int blocks_per_page = i_blocks_per_page(inode, page);

I might call this nr_blocks.

> +	unsigned int first = (off >> inode->i_blkbits) + blocks_per_page;
> +	unsigned int last = ((off + len - 1) >> inode->i_blkbits) +
> blocks_per_page;
> +	unsigned long flags;
> +	struct iomap_page *iop;
> +
> +	if (PageError(page))
> +		return;

I think this is wrong.  If PageError is set then we've seen an I/O error
on this page (today either a read or a write, although I intend to make
that for writes only soon).  But I don't see a reason for declining to
make a page dirty if we've seen an eror -- indeed, that seems likely to
lead to further data loss as we then won't even try to write parts of
the page back to storage.

> +	if (len)
> +		iomap_set_page_dirty(page);
> +
> +	if (!page_has_private(page))
> +		return;
> +
> +	iop = to_iomap_page(page);

We usually do the last three lines as:

	iop = to_iomap_page(page);
	if (!iop)
		return;

(actually, we usually call to_iomap_page() at the start of the function
and then check it here)

> +static void
> +iomap_clear_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	struct inode *inode = page->mapping->host;
> +	unsigned int blocks_per_page = i_blocks_per_page(inode, page);
> +	unsigned int first = (off >> inode->i_blkbits) + blocks_per_page;
> +	unsigned int last = ((off + len - 1) >> inode->i_blkbits) +
> blocks_per_page;
> +	unsigned long flags;
> +	struct iomap_page *iop;
> +
> +	if (PageError(page))
> +		return;

It does make sense to avoid clearing the dirty state of the page here;
if the write failed, then the page is still dirty, and it'd be nice to
retry writes until they succeed.  So if you take out the PageError in
set_range_dirty, don't take it out here!

> +	if (!page_has_private(page))
> +		return;
> +
> +	iop = to_iomap_page(page);
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_clear(iop->state, first, last - first + 1);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
>  static void
>  iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  {
> @@ -148,11 +201,11 @@ iomap_iop_set_range_uptodate(struct page *page,
> unsigned off, unsigned len)
>  	unsigned last = (off + len - 1) >> inode->i_blkbits;
>  	unsigned long flags;
> 
> -	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	bitmap_set(iop->uptodate, first, last - first + 1);
> -	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_set(iop->state, first, last - first + 1);
> +	if (bitmap_full(iop->state, i_blocks_per_page(inode, page)))
>  		SetPageUptodate(page);
> -	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>  }
> 
>  static void
> @@ -445,7 +498,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned
> long from,
> 
>  	if (iop) {
>  		for (i = first; i <= last; i++)
> -			if (!test_bit(i, iop->uptodate))
> +			if (!test_bit(i, iop->state))
>  				return 0;
>  		return 1;
>  	}
> @@ -683,7 +736,7 @@ static size_t __iomap_write_end(struct inode *inode,
> loff_t pos, size_t len,
>  	if (unlikely(copied < len && !PageUptodate(page)))
>  		return 0;
>  	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> -	iomap_set_page_dirty(page);
> +	iomap_set_range_dirty(page, offset_in_page(pos), len);

I _think_ the call to set_range_uptodate here is now unnecessary.  The
blocks should already have been set uptodate in write_begin.  But please
check!

> @@ -1007,7 +1059,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
> const struct iomap_ops *ops)
>  {
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> -	unsigned long length;
> +	unsigned int length, dirty_bits;

This is dirty_bytes, surely?

