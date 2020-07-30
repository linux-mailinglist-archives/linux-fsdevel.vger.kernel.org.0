Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D02232A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 04:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG3C17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 22:27:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726367AbgG3C14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596076074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVpH86nrp4dZZcn3Jtx63a1hxKRGCJ0Vr4RI3jcWe6I=;
        b=bvEOHaUMQqxyGcK6W32XSv0HSHdst24dAXeAmjM0sx/2n9xBpDSPRN7TwDjXS1nQs+LP9n
        E0YusHH6pt83bP2DFlOxV5kAo13EKEPP4pp8JrnRtBLMt0RMZMBljjq5DpzTZeavFJFQw5
        dB7nFLHdsH7XzRvJCOj/aNWSZuafjU8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-7afuLSK-NMSSXUOwuqQ0GQ-1; Wed, 29 Jul 2020 22:27:49 -0400
X-MC-Unique: 7afuLSK-NMSSXUOwuqQ0GQ-1
Received: by mail-pg1-f197.google.com with SMTP id e22so19878611pgl.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 19:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVpH86nrp4dZZcn3Jtx63a1hxKRGCJ0Vr4RI3jcWe6I=;
        b=PmpBE574vA3jfv8f993V5A2qysGO51ii6mnLXImSHaMA9qauygAZQu5b8SanePEF1d
         lRXxkVtvUh50/DcwXuqCl3PDSNd6nXLpnq8Ylf716VcjkJgqxdE5lZ74BzHPGMzEKzDi
         Nuw4e6poi2yGzn4AG0lGfGyUlAIKnIRpDF47Nqcwhv6BchwmS8DqshbQ1FDhQj+loL38
         yir3X5XF8RNu3/mBFH8bDI49OBozXeKgFVDDLU2c2O5BfgP3LN0q8aDD60bdeMg9WufD
         BoSKqel1iJa0hSOyOhJe1/iAvEu6uIMfp9wlBIzfxmCrtpiNFcReL5kS56SmLw4mpwKk
         oSYA==
X-Gm-Message-State: AOAM533QY9kPrsysv4w+enpMUGphwOF/OO/bhSLQX+2f7H4tk9IzQZzX
        /I8F5L/F9sRvGQhlNDmtQ8uEIarlm7xkbFaVkqNwH84Kf2FmedagI+qKROYSXYEQtxtRBPhpZiK
        Regd9WS36zarUOQLhBs0FyPkQWg==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr816819pjb.94.1596076068811;
        Wed, 29 Jul 2020 19:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXYnYX753dycaDyvSqN8KadG5qbAQ+i8wCUG8dvGmpGgJUHiu2RKAEtXiyQUAxyrq5XYYzgQ==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr816795pjb.94.1596076068370;
        Wed, 29 Jul 2020 19:27:48 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j13sm3943995pfa.149.2020.07.29.19.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 19:27:47 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:27:36 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH] iomap: add support to track dirty state of sub pages
Message-ID: <20200730022736.GA23366@xiangao.remote.csb>
References: <20200730011901.2840886-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730011901.2840886-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kuai,

On Thu, Jul 30, 2020 at 09:19:01AM +0800, Yu Kuai wrote:
> commit 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O
> without buffer heads") replace the per-block structure buffer_head with
> the per-page structure iomap_page. However, iomap_page can't track the
> dirty state of sub pages, which will cause performance issue since sub
> pages will be writeback even if they are not dirty.
> 
> For example, if block size is 4k and page size is 64k:
> 
> dd if=/dev/zero of=testfile bs=4k count=16 oflag=sync
> 
> With buffer_head implementation, the above dd cmd will writeback 4k in
> each round. However, with iomap_page implementation, the range of
> writeback in each round is from the start of the page to the end offset
> we just wrote.
> 
> Thus add support to track dirty state for sub pages in iomap_page.

AFAIK, the current focus is also on the numbers in the original
discussion thread, so it'd be better to show some numbers with
large PAGE_SIZE on this with some workloads as well.

https://lore.kernel.org/r/20200729230503.GA2005@dread.disaster.area

e.g. My guess is if the dirty blocks in the page are highly fragmented, maybe
it'd be better to writeback the whole page in an IO rather than individual blocks.

At a very quick glance, the approach looks good to me.

Thanks,
Gao Xiang

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..ac2676146b98 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -29,7 +29,9 @@ struct iomap_page {
>  	atomic_t		read_count;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
> +	spinlock_t		dirty_lock;
>  	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> +	DECLARE_BITMAP(dirty, PAGE_SIZE / 512);
>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
> @@ -53,7 +55,9 @@ iomap_page_create(struct inode *inode, struct page *page)
>  	atomic_set(&iop->read_count, 0);
>  	atomic_set(&iop->write_count, 0);
>  	spin_lock_init(&iop->uptodate_lock);
> +	spin_lock_init(&iop->dirty_lock);
>  	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> +	bitmap_zero(iop->dirty, PAGE_SIZE / SECTOR_SIZE);
>  
>  	/*
>  	 * migrate_page_move_mapping() assumes that pages with private data have
> @@ -135,6 +139,44 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>  	*lenp = plen;
>  }
>  
> +static void
> +iomap_iop_set_or_clear_range_dirty(
> +	struct page *page,
> +	unsigned int off,
> +	unsigned int len,
> +	bool is_set)
> +{
> +	struct iomap_page *iop = to_iomap_page(page);
> +	struct inode *inode = page->mapping->host;
> +	unsigned int first = off >> inode->i_blkbits;
> +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&iop->dirty_lock, flags);
> +	for (i = first; i <= last; i++)
> +		if (is_set)
> +			set_bit(i, iop->dirty);
> +		else
> +			clear_bit(i, iop->dirty);
> +	spin_unlock_irqrestore(&iop->dirty_lock, flags);
> +}
> +
> +static void
> +iomap_set_or_clear_range_dirty(
> +	struct page *page,
> +	unsigned int off,
> +	unsigned int len,
> +	bool is_set)
> +{
> +	if (PageError(page))
> +		return;
> +
> +	if (page_has_private(page))
> +		iomap_iop_set_or_clear_range_dirty(
> +			page, off, len, is_set);
3> +}
> +
>  static void
>  iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  {
> @@ -705,6 +747,8 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	if (unlikely(copied < len && !PageUptodate(page)))
>  		return 0;
>  	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> +	iomap_set_or_clear_range_dirty(
> +		page, offset_in_page(pos), len, true);
>  	iomap_set_page_dirty(page);
>  	return copied;
>  }
> @@ -1030,6 +1074,8 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  		WARN_ON_ONCE(!PageUptodate(page));
>  		iomap_page_create(inode, page);
>  		set_page_dirty(page);
> +		iomap_set_or_clear_range_dirty(
> +			page, offset_in_page(pos), length, true);
>  	}
>  
>  	return length;
> @@ -1386,7 +1432,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	for (i = 0, file_offset = page_offset(page);
>  	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
>  	     i++, file_offset += len) {
> -		if (iop && !test_bit(i, iop->uptodate))
> +		if (iop && (!test_bit(i, iop->uptodate) ||
> +		    !test_bit(i, iop->dirty)))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, file_offset);
> @@ -1435,6 +1482,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 */
>  		set_page_writeback_keepwrite(page);
>  	} else {
> +		iomap_set_or_clear_range_dirty(
> +			page, 0, end_offset - page_offset(page) + 1, false);
>  		clear_page_dirty_for_io(page);
>  		set_page_writeback(page);
>  	}
> -- 
> 2.25.4
> 

