Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898D2470576
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 17:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbhLJQXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbhLJQXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:23:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0BC061746;
        Fri, 10 Dec 2021 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bQKwfN6aNXQHwZHVhA6OGDeJq601xLR25UKpfXdatfo=; b=Ny6DjNqSEJVyWgTkBORi1+Qc5+
        mTW8Dvfx/YQzImCymApCZt5oni3kLQlybqFiCyhkEtUPVZddxMNq3u+pmG/lI2pTWKww+cbRvdt5t
        tt/eXhAT2/0tVIT6ZAgcw+IO7jmIhf0t/BeVI0U7m16EZRLz3ac8r7JsPTe+6LnztWXdfexApGpFP
        l9xNSLTLhILrGX2J6QmjgIXS172OmUzsbV7PMUpHMkPn9RUP4deCgpL8nBtH8yeH13MYRcA7gY9q2
        twhDOsj1mkRXvTCf4XAC5tp1XcNR5vbR0p9D95Kv9ZqnnS9A6a8iI2lxkFciOzpe670m9guZmC2Ej
        zrZnaEVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvick-00ATZt-5Y; Fri, 10 Dec 2021 16:19:54 +0000
Date:   Fri, 10 Dec 2021 16:19:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <YbN+KqqCG0032NMG@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
 <YbJ3O1qf+9p/HWka@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJ3O1qf+9p/HWka@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:38:03PM +0000, Matthew Wilcox wrote:
> @@ -891,16 +893,19 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff
> _t pos, u64 length)
>         struct page *page;
>         int status;
>         unsigned offset = offset_in_page(pos);
> -       unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> 
> -       status = iomap_write_begin(iter, pos, bytes, &page);
> +       if (length > UINT_MAX)
> +               length = UINT_MAX;
> +       status = iomap_write_begin(iter, pos, length, &page);
>         if (status)
>                 return status;
> +       if (length > PAGE_SIZE - offset)
> +               length = PAGE_SIZE - offset;
> 
> -       zero_user(page, offset, bytes);
> +       zero_user(page, offset, length);
>         mark_page_accessed(page);
> 
> -       return iomap_write_end(iter, pos, bytes, bytes, page);
> +       return iomap_write_end(iter, pos, length, length, page);
>  }

After attempting the merge with Christoph's ill-timed refactoring,
I decided that eliding the use of 'bytes' here was the wrong approach,
because it very much needs to be put back in for the merge.

Here's the merge as I have it:

diff --cc fs/iomap/buffered-io.c
index f3176cf90351,d1aa0f0e7fd5..40356db3e856
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@@ -888,19 -926,12 +904,23 @@@ static loff_t iomap_zero_iter(struct io
                return length;

        do {
-               unsigned offset = offset_in_page(pos);
-               size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
-               struct page *page;
 -              s64 bytes;
++              struct folio *folio;
 +              int status;
++              size_t offset;
++              size_t bytes = min_t(u64, SIZE_MAX, length);
 +
-               status = iomap_write_begin(iter, pos, bytes, &page);
++              status = iomap_write_begin(iter, pos, bytes, &folio);
 +              if (status)
 +                      return status;
 +
-               zero_user(page, offset, bytes);
-               mark_page_accessed(page);
++              offset = offset_in_folio(folio, pos);
++              if (bytes > folio_size(folio) - offset)
++                      bytes = folio_size(folio) - offset;
++
++              folio_zero_range(folio, offset, bytes);
++              folio_mark_accessed(folio);

-               bytes = iomap_write_end(iter, pos, bytes, bytes, page);
 -              if (IS_DAX(iter->inode))
 -                      bytes = dax_iomap_zero(pos, length, iomap);
 -              else
 -                      bytes = __iomap_zero_iter(iter, pos, length);
++              bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
                if (bytes < 0)
                        return bytes;

I've pushed out a new tag:

https://git.infradead.org/users/willy/linux.git/shortlog/refs/tags/iomap-folio-5.17d

