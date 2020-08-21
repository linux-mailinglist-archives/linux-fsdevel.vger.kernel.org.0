Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A910224CDD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 08:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHUGSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgHUGR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:17:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C085C061385;
        Thu, 20 Aug 2020 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IBcexKFr3UjZZmXJsxriFU+NEblTsPCGVKw6LJaZq6g=; b=Y4jFZd58hCGWF6Xt6uTzcnBXxC
        UWtop2H3owB7z8izxB38rhYUBWzbMNcfGF/ZbKA0of3MSSGs4NQaKztvqV9BDUpRVEyZJptkpmFLB
        eHZ5eUt+m/6J/A4wdP7EESaEV5liZvZfwbZtkswrXPxv9gneKZZ7Q4CLnAnyEyTg7b3sB729YufK9
        IRx3e5Gu6yO2cex9ZECh9Ci2L0FU60l/zlPbPI/LJmRmkCkLWVoIQNSHeAZjBvAHmdauVr7YPXpJv
        jBqr6WseTRQf+buwuQLScNsP5fKKfFg9m5mjh5K6k2emz1kUBkSy6mo8I4xRd9ThC4JeRxnP7VO2b
        VYTysohw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k90N6-0001K8-RX; Fri, 21 Aug 2020 06:17:52 +0000
Date:   Fri, 21 Aug 2020 07:17:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, willy@infradead.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200821061752.GF31091@infradead.org>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819120542.3780727-1-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..b6a7457d8581 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -21,15 +21,20 @@
>  
>  #include "../internal.h"
>  
> +#define DIRTY_BITS(x)	((x) + PAGE_SIZE / SECTOR_SIZE)
>  /*

Nit: please keep an empty line between a definition and a comment.

> +	 * The first half bits are used to track sub-page uptodate status,
> +	 * the second half bits are for dirty status.
> +	 */
> +	DECLARE_BITMAP(state, PAGE_SIZE * 2 / SECTOR_SIZE);
>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
> @@ -52,8 +57,8 @@ iomap_page_create(struct inode *inode, struct page *page)
>  	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
>  	atomic_set(&iop->read_count, 0);
>  	atomic_set(&iop->write_count, 0);
> -	spin_lock_init(&iop->uptodate_lock);
> -	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> +	spin_lock_init(&iop->state_lock);
> +	bitmap_zero(iop->state, PAGE_SIZE * 2 / SECTOR_SIZE);

Maybe add a

#define IOMAP_STATE_ARRAY_SIZE	(PAGE_SIZE * 2 / SECTOR_SIZE)

and use?  That isn't much shorter, but a little easier to read at least.

> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	for (i = first; i <= last; i++)
> +		set_bit(i, iop->state);

I think Matthew had some patches to move the these days pointlessly
atomic bitops to use the bitmap_* routines.  It might make sense to
start out that way for new code as well.

> +
> +	if (last >= first)
> +		iomap_set_page_dirty(page);
> +
> +	spin_unlock_irqrestore(&iop->state_lock, flags);

As aready pointed out, this probably needs to move out of the lock.

> +static void
> +iomap_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	if (PageError(page))
> +		return;
> +
> +	if (page_has_private(page))
> +		iomap_iop_set_range_dirty(page, off, len);

I'd be tempted to merge this function and iomap_iop_set_range_dirty,
and just return early if there is an error or no iomap_page structure,
relying on the fact that to_iomap_page returns NULL for that case.

> +static void
> +iomap_iop_clear_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	struct iomap_page *iop = to_iomap_page(page);
> +	struct inode *inode = page->mapping->host;
> +	unsigned int first = DIRTY_BITS(off >> inode->i_blkbits);
> +	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	for (i = first; i <= last; i++)
> +		clear_bit(i, iop->state);

should probably use bitmap_clear().

> +static void
> +iomap_clear_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	if (PageError(page))
> +		return;
> +
> +	if (page_has_private(page))
> +		iomap_iop_clear_range_dirty(page, off, len);
> +}

Same comment about merging the two functions as above.
