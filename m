Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDFB248A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHRPx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHRPxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:53:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41470C061389;
        Tue, 18 Aug 2020 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yyUh9iK9jX/VmP7LW1FKsmxWNdg6vDrQTUz1XOSD6GE=; b=P1a0VDnX9q5mwOMQk56KD1bYkd
        e0VaIFb20psLt4A2GzwesTPRpbnt9rs4wnA/eCY48TWb2HV8dUbkjZVlDNyqQccTsdF1cdGP7JK8g
        mhl0CkyxXfs3mf/udZpA1jym2lJSlyif4H0Nixl7a8Tby/uQDYIdQE8EZxfT7pznxE8W+vk/7hY6p
        14CAFt27hJ4T3z7Jr0oFFLVkS5A+gGl8TQ8syfzf9dDFRK1XZy2hnlcoUO9ESTGGE2OiuAK+/w9I3
        OJmQtXO4bjYPCBC2b5wZJgyTbnskrtg+8qydH/1KmZg/+57U7UQBRXVb7e4W9aOTfcegW/VJlsySn
        Syu3fi2g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k83v7-0005Me-AC; Tue, 18 Aug 2020 15:53:05 +0000
Date:   Tue, 18 Aug 2020 16:53:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH V2] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200818155305.GR17456@casper.infradead.org>
References: <20200818134618.2345884-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818134618.2345884-1-yukuai3@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:46:18PM +0800, Yu Kuai wrote:
> changes from v1:
>  - separate set dirty and clear dirty functions
>  - don't test uptodate bit in iomap_writepage_map()
>  - use one bitmap array for uptodate and dirty.

This looks much better.

> +	spinlock_t		state_lock;
> +	/*
> +	 * The first half bits are used to track sub-page uptodate status,
> +	 * the second half bits are for dirty status.
> +	 */
> +	DECLARE_BITMAP(state, PAGE_SIZE / 256);

It would be better to use the same wording as below:

> +	bitmap_zero(iop->state, PAGE_SIZE * 2 / SECTOR_SIZE);

[...]

> +static void
> +iomap_iop_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	struct iomap_page *iop = to_iomap_page(page);
> +	struct inode *inode = page->mapping->host;
> +	unsigned int total = PAGE_SIZE / SECTOR_SIZE;
> +	unsigned int first = off >> inode->i_blkbits;
> +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	for (i = first; i <= last; i++)
> +		set_bit(i + total, iop->state);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}

How about:

-	unsigned int total = PAGE_SIZE / SECTOR_SIZE;
...
+	first += PAGE_SIZE / SECTOR_SIZE;
+	last += PAGE_SIZE / SECTOR_SIZE;
...
	for (i = first; i <= last; i++)
-		set_bit(i + total, iop->state);
+		set_bit(i, iop->state);

We might want

#define	DIRTY_BITS(x)	((x) + PAGE_SIZE / SECTOR_SIZE)

and then we could do:

+	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);

That might be overthinking things a bit though.

> @@ -705,6 +767,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	if (unlikely(copied < len && !PageUptodate(page)))
>  		return 0;
>  	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> +	iomap_set_range_dirty(page, offset_in_page(pos), len);
>  	iomap_set_page_dirty(page);

I would move the call to iomap_set_page_dirty() into
iomap_set_range_dirty() to parallel iomap_set_range_uptodate more closely.
We don't want a future change to add a call to iomap_set_range_dirty()
and miss the call to iomap_set_page_dirty().

>  	return copied;
>  }
> @@ -1030,6 +1093,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  		WARN_ON_ONCE(!PageUptodate(page));
>  		iomap_page_create(inode, page);
>  		set_page_dirty(page);
> +		iomap_set_range_dirty(page, offset_in_page(pos), length);

I would move all this from the mkwrite_actor() to iomap_page_mkwrite()
and call it once with (0, PAGE_SIZE) rather than calling it once for
each extent in the page.

> @@ -1435,6 +1500,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 */
>  		set_page_writeback_keepwrite(page);
>  	} else {
> +		iomap_clear_range_dirty(page, 0,
> +				end_offset - page_offset(page) + 1);
>  		clear_page_dirty_for_io(page);
>  		set_page_writeback(page);

I'm not sure it's worth doing this calculation.  Better to just clear
the dirty bits on the entire page?  Opinions?
