Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82880232A52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgG3DTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 23:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG3DTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:19:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412DEC061794;
        Wed, 29 Jul 2020 20:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ObYVAbjLZNL5RELvwh/jnTQxhHj3rC/rJB12CZz+dfg=; b=S0N287qi5qL/keCKSHTZaClYp3
        Y4hm3Gp6xWnHaWT94aHYI6hxryrySrz9J2286JdpWGNN/20uPAt5RoySBeYJLHh2bAboi9n+wuvXb
        4j5QyrwsAr3yx9eCs8ASlYoINipNJ0qUDj+0TdCQxnoSBHy82cEFZ/hRxUVCMdmQJfuNvLbPIvkom
        Y6nbyacYGyhGOEbMrJ44LsQJaHPPrYkbThYFIdXhCKnQ78yC0rTFjJhoiHLutaZFPSRCC7aMiZzX0
        e0DaMNZuIFeg/hQ487UbISSQzcWpFgVqpLr5CTGaXSvGjOFl6Ra/W7JbhR1V4Cdwu9Bruts3oDFvs
        HbY1W3Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0z6U-0007Lc-Nz; Thu, 30 Jul 2020 03:19:34 +0000
Date:   Thu, 30 Jul 2020 04:19:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH] iomap: add support to track dirty state of sub pages
Message-ID: <20200730031934.GA23808@casper.infradead.org>
References: <20200730011901.2840886-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730011901.2840886-1-yukuai3@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:19:01AM +0800, Yu Kuai wrote:
> +++ b/fs/iomap/buffered-io.c
> @@ -29,7 +29,9 @@ struct iomap_page {
>  	atomic_t		read_count;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
> +	spinlock_t		dirty_lock;

No need for a separate spinlock.  Just rename uptodate_lock.  Maybe
'bitmap_lock'.

>  	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> +	DECLARE_BITMAP(dirty, PAGE_SIZE / 512);

This is inefficient and poses difficulties for the THP patchset.
Maybe let the discussion on removing the ->uptodate array finish
before posting another patch for review?

> +static void
> +iomap_iop_set_or_clear_range_dirty(
> +	struct page *page,
> +	unsigned int off,
> +	unsigned int len,
> +	bool is_set)

Please follow normal kernel programming style.  This isn't XFS.
Also 'set or clear' with a bool to indicate which to do is horrible
style.  Separate functions!

> @@ -1386,7 +1432,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	for (i = 0, file_offset = page_offset(page);
>  	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
>  	     i++, file_offset += len) {
> -		if (iop && !test_bit(i, iop->uptodate))
> +		if (iop && (!test_bit(i, iop->uptodate) ||
> +		    !test_bit(i, iop->dirty)))
>  			continue;

Surely we don't need to test ->uptodate here at all.  Why would we write
back a block which isn't dirty?

