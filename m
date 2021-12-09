Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193EE46F614
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhLIVlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 16:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:41:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE84C061746;
        Thu,  9 Dec 2021 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P2aQ91d+0Nay119c7Hm3YaZibGVAqClk58OZHKt3Xl4=; b=cnU75D1qm7eep+zg67cBjnjU5u
        lEicByKXRIZocx5wZq6zz69Ru+PEst/T/YMAfJlX9bjLZTJ8RFLbUZKTb7yq0FGSeTxuxDF318g3Y
        8bDeqcD4guFJ52AXIO0Ol8Ursu1fyiEL9Fp/krOOOBTH3HOk2GMcRtjxSB5RzR8ZNL9nkRwlqzYVQ
        J45nCMz4FrZPTnutzDjny73jdO6DYA3AS5OPoFC1bjbRmniOLrddvCkhqnTDaOBBoaMPlby6StiVt
        aI9kKhleNDxAgoxqQbGxfIEGg2Hmgi85JF43BUH+QueHj7/+g31cgvjKM0v661QxPAY3HpdxM6Xws
        eNT/Cpag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvR75-009kVO-PD; Thu, 09 Dec 2021 21:38:04 +0000
Date:   Thu, 9 Dec 2021 21:38:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <YbJ3O1qf+9p/HWka@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-20-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:42AM +0000, Matthew Wilcox (Oracle) wrote:
> +++ b/fs/iomap/buffered-io.c
> @@ -881,17 +881,20 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
>  static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
> +	struct folio *folio;
>  	struct page *page;
>  	int status;
> -	unsigned offset = offset_in_page(pos);
> -	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> +	size_t offset, bytes;
>  
> -	status = iomap_write_begin(iter, pos, bytes, &page);
> +	status = iomap_write_begin(iter, pos, length, &page);

This turned out to be buggy.  Darrick and I figured out why his tests
were failing and mine weren't; this only shows up with a 4kB block
size filesystem and I was only testing with 1kB block size filesystems.
(at least on x86; I haven't figured out why it passes with 1kB block size
filesystems, so I'm not sure what would be true on other filesystems).
iomap_write_begin() is not prepared to deal with a length that spans a
page boundary.  So I'm replacing this patch with the following patches
(whitespace damaged; pick them up from
https://git.infradead.org/users/willy/linux.git/tag/refs/tags/iomap-folio-5.17c
if you want to compile them):

commit 412212960b72
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Dec 9 15:47:44 2021 -0500

    iomap: Allow iomap_write_begin() to be called with the full length

    In the future, we want write_begin to know the entire length of the
    write so that it can choose to allocate large folios.  Pass the full
    length in from __iomap_zero_iter() and limit it where necessary.

    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index d67108489148..9270db17c435 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -968,6 +968,9 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
        struct gfs2_sbd *sdp = GFS2_SB(inode);
        unsigned int blocks;

+       /* gfs2 does not support large folios yet */
+       if (len > PAGE_SIZE)
+               len = PAGE_SIZE;
        blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
        return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8d7a67655b60..67fcd3b9928d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -632,6 +632,8 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
                goto out_no_page;
        }
        folio = page_folio(page);
+       if (pos + len > folio_pos(folio) + folio_size(folio))
+               len = folio_pos(folio) + folio_size(folio) - pos;

        if (srcmap->type == IOMAP_INLINE)
                status = iomap_write_begin_inline(iter, page);
@@ -891,16 +893,19 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff
_t pos, u64 length)
        struct page *page;
        int status;
        unsigned offset = offset_in_page(pos);
-       unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);

-       status = iomap_write_begin(iter, pos, bytes, &page);
+       if (length > UINT_MAX)
+               length = UINT_MAX;
+       status = iomap_write_begin(iter, pos, length, &page);
        if (status)
                return status;
+       if (length > PAGE_SIZE - offset)
+               length = PAGE_SIZE - offset;

-       zero_user(page, offset, bytes);
+       zero_user(page, offset, length);
        mark_page_accessed(page);

-       return iomap_write_end(iter, pos, bytes, bytes, page);
+       return iomap_write_end(iter, pos, length, length, page);
 }

 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)


commit 78c747a1b3a1
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Fri Nov 5 14:24:09 2021 -0400

    iomap: Convert __iomap_zero_iter to use a folio
    
    The zero iterator can work in folio-sized chunks instead of page-sized
    chunks.  This will save a lot of page cache lookups if the file is cached
    in large folios.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Darrick J. Wong <djwong@kernel.org>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 67fcd3b9928d..bbde6d4f27cd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -890,20 +890,23 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
 static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 {
+       struct folio *folio;
        struct page *page;
        int status;
-       unsigned offset = offset_in_page(pos);
+       size_t offset;
 
        if (length > UINT_MAX)
                length = UINT_MAX;
        status = iomap_write_begin(iter, pos, length, &page);
        if (status)
                return status;
-       if (length > PAGE_SIZE - offset)
-               length = PAGE_SIZE - offset;
+       folio = page_folio(page);
 
-       zero_user(page, offset, length);
-       mark_page_accessed(page);
+       offset = offset_in_folio(folio, pos);
+       if (length > folio_size(folio) - offset)
+               length = folio_size(folio) - offset;
+       folio_zero_range(folio, offset, length);
+       folio_mark_accessed(folio);
 
        return iomap_write_end(iter, pos, length, length, page);
 }


The xfstests that Darrick identified as failing all passed.  Running a
full sweep now; then I'll re-run with a 1kB filesystem to be sure that
still passes.  Then I'll send another pull request.
