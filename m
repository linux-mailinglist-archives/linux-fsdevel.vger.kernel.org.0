Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27E443BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 04:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhKCDTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 23:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCDTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 23:19:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA3C061714;
        Tue,  2 Nov 2021 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBWPgBNoCYscxKU/Ytp7yevOCr+ydQgdoa0YQn6Vxlc=; b=lYjsDBPCQMP7Rs3nVKlsFzzc8z
        4zHaHb5gq+1VlXHTmv9cl7Qiu5BMrHavNSowxe5nTooYbGs9tfXhs9nY2PKxOH2dEnFcHllB/YtG0
        m/Uxxo1WNDHTkciPbaknfQuA3XRWXMzahfu7LhUtPmM/YzcWtYis4ZDsuhHzD1u/tgNXGh3+NSXiZ
        fs4vfFwotF1TD03miQCafolJrxNEnRxX2K7WKW0DCnI5EzhZH1DMWQfd34AbjVTajOZOA7MVCBcTq
        42xhbGIAzZzt9Yej+wC7Lequ36lJmhLrstOQgQjfGxnea2tNrcskY8DJhDFNrA8lpmm24zr0VGuJX
        yiJNJAaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mi6k5-004vkI-Go; Wed, 03 Nov 2021 03:15:31 +0000
Date:   Wed, 3 Nov 2021 03:15:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/21] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YYH+wfNdgubpqtyP@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-16-willy@infradead.org>
 <20211102232215.GG2237511@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102232215.GG2237511@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:22:15PM -0700, Darrick J. Wong wrote:
> > +	page = folio_file_page(folio, pos >> PAGE_SHIFT);
> 
> Isn't this only needed in the BUFFER_HEAD case?

Good catch.  Want me to fold this in?

+++ b/fs/iomap/buffered-io.c
@@ -608,7 +608,6 @@ static int iomap_write_begin(const struct iomap_iter *iter,
loff_t pos,
        const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
        const struct iomap *srcmap = iomap_iter_srcmap(iter);
        struct folio *folio;
-       struct page *page;
        unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
        int status = 0;

@@ -632,12 +631,12 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
                goto out_no_page;
        }
 
-       page = folio_file_page(folio, pos >> PAGE_SHIFT);
        if (srcmap->type == IOMAP_INLINE)
                status = iomap_write_begin_inline(iter, folio);
-       else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
+       else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+               struct page *page = folio_file_page(folio, pos >> PAGE_SHIFT);
                status = __block_write_begin_int(page, pos, len, NULL, srcmap);
-       else
+       } else
                status = __iomap_write_begin(iter, pos, len, folio);
 
        if (unlikely(status))

