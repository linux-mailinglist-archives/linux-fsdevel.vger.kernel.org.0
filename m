Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7222F118E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 17:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLJQzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 11:55:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfLJQzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5fcYU56SUZZVQF3+y6QNQ2Ux8rrw+6trvD32tU3jDkw=; b=WlL+KE+xCd/chNjVxM8aQrTdv
        Uv3Ylrhbg9l5AFyw3pgsyyBhcIXpX4/A+2YbYa6gdbqC8wyv5I/Shy3c4fy/wJG9jP561I9eHSdma
        RcdAhCrZe+MSwyVFo9bI9B5YSF54yAIp1tnvQag8LzaAYxXLP8DtL4iX2GQGDnUrk4pDj+WtVzulv
        TcbpIn9MBchiiXD9VGOsaL1UN5IVbzsXV2Xsk0Gj3KwMJZEBks0M0XRpDH7W+kUulfcY9lqJg0S/n
        71wO+uaqOkTO9iMPdrxVcVq0Yi0o1gmG6gYTv42Gl2FcrU8BIRJ+gXY2sS4fHZeFSRYXxDCdoAbqt
        e+qDT98Og==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieinM-0002gn-OT; Tue, 10 Dec 2019 16:55:32 +0000
Date:   Tue, 10 Dec 2019 08:55:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Message-ID: <20191210165532.GJ32169@bombadil.infradead.org>
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210162454.8608-4-axboe@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
> +/*
> + * Start writeback on the pages in pgs[], and then try and remove those pages
> + * from the page cached. Used with RWF_UNCACHED.
> + */
> +void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
> +			     unsigned *nr)

It would seem more natural to use a pagevec instead of pgs/nr.

> +{
> +	loff_t start, end;
> +	int i;
> +
> +	end = 0;
> +	start = LLONG_MAX;
> +	for (i = 0; i < *nr; i++) {
> +		struct page *page = pgs[i];
> +		loff_t off;
> +
> +		off = (loff_t) page_to_index(page) << PAGE_SHIFT;

Isn't that page_offset()?

> +	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
> +
> +	for (i = 0; i < *nr; i++) {
> +		struct page *page = pgs[i];
> +
> +		lock_page(page);
> +		if (page->mapping == mapping) {

So you're protecting against the page being freed and reallocated to a
different file, but not against the page being freed and reallocated to
a location in the same file which is outside (start, end)?

