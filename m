Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB147C47D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhLURBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbhLURBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3605AC061747;
        Tue, 21 Dec 2021 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=87hwk5i0bYjBDiuG7ta/mairPC/v5KjosO0WqlSlnlM=; b=vTd5Bt7BWbTvbpB0IZyYn6w+B8
        iF7NW5/0rPKjyTfUH1tnH6rK5zpdZYPaf5aTXpqFKW/6GBioOZXiDlo9rXK28tTu1+A3nU11vYCPO
        FRbDOMDn8LRvEWuyhMKOppJEcQFKabFusRq6K1SW2ihoqRh/PjGmferAjnpdu9ZONR6jofP3hH9Cd
        wSth8bC0nmDB743VocqTZcbPA/K/H+feLSFAWYDV+mzMBXPKQ2VowN2PcjY0XijBu2SMpJkfUOISz
        Lizym1SBF7jgiouTvEsS011YJA5O0euAiFwGP2YyE18Cu/I1jms+alEPuLJXiLWa3S+KDZk8oHk91
        b5jOlAbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mziW6-002eS7-8g; Tue, 21 Dec 2021 17:01:34 +0000
Date:   Tue, 21 Dec 2021 17:01:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: iomap-folio & nvdimm merge
Message-ID: <YcIIbtKhOulAL4s4@casper.infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216210715.3801857-17-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:07:06PM +0000, Matthew Wilcox (Oracle) wrote:
> The zero iterator can work in folio-sized chunks instead of page-sized
> chunks.  This will save a lot of page cache lookups if the file is cached
> in large folios.

This patch (and a few others) end up conflicting with what Christoph did
that's now in the nvdimm tree.  In an effort to make the merge cleaner,
I took the next-20211220 tag and did the following:

Revert de291b590286
Apply: https://lore.kernel.org/linux-xfs/20211221044450.517558-1-willy@infradead.org/
(these two things are likely to happen in the nvdimm tree imminently)

I then checked out iomap-folio-5.17e and added this patch:

    iomap: Inline __iomap_zero_iter into its caller

    To make the merge easier, replicate the inlining of __iomap_zero_iter()
    into iomap_zero_iter() that is currently in the nvdimm tree.

    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ba80bedd9590..c6b3a148e898 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -895,27 +895,6 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
-{
-       struct folio *folio;
-       int status;
-       size_t offset;
-       size_t bytes = min_t(u64, SIZE_MAX, length);
-
-       status = iomap_write_begin(iter, pos, bytes, &folio);
-       if (status)
-               return status;
-
-       offset = offset_in_folio(folio, pos);
-       if (bytes > folio_size(folio) - offset)
-               bytes = folio_size(folio) - offset;
-
-       folio_zero_range(folio, offset, bytes);
-       folio_mark_accessed(folio);
-
-       return iomap_write_end(iter, pos, bytes, bytes, folio);
-}
-
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
        struct iomap *iomap = &iter->iomap;
@@ -929,14 +908,34 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
                return length;
 
        do {
-               s64 bytes;
+               struct folio *folio;
+               int status;
+               size_t offset;
+               size_t bytes = min_t(u64, SIZE_MAX, length);
+
+               if (IS_DAX(iter->inode)) {
+                       s64 tmp = dax_iomap_zero(pos, bytes, iomap);
+                       if (tmp < 0)
+                               return tmp;
+                       bytes = tmp;
+                       goto good;
+               }
 
-               if (IS_DAX(iter->inode))
-                       bytes = dax_iomap_zero(pos, length, iomap);
-               else
-                       bytes = __iomap_zero_iter(iter, pos, length);
-               if (bytes < 0)
-                       return bytes;
+               status = iomap_write_begin(iter, pos, bytes, &folio);
+               if (status)
+                       return status;
+
+               offset = offset_in_folio(folio, pos);
+               if (bytes > folio_size(folio) - offset)
+                       bytes = folio_size(folio) - offset;
+
+               folio_zero_range(folio, offset, bytes);
+               folio_mark_accessed(folio);
+
+               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+good:
+               if (WARN_ON_ONCE(bytes == 0))
+                       return -EIO;
 
                pos += bytes;
                length -= bytes;



Then I did the merge, and the merge commit looks pretty sensible
afterwards:

    Merge branch 'iomap-folio-5.17f' into fixup

diff --cc fs/iomap/buffered-io.c
index 955f51f94b3f,c6b3a148e898..c938bbad075e
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@@ -888,19 -908,32 +907,23 @@@ static loff_t iomap_zero_iter(struct io
                return length;

        do {
-               unsigned offset = offset_in_page(pos);
-               size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
-               struct page *page;
+               struct folio *folio;
                int status;
+               size_t offset;
+               size_t bytes = min_t(u64, SIZE_MAX, length);

-               status = iomap_write_begin(iter, pos, bytes, &page);
 -              if (IS_DAX(iter->inode)) {
 -                      s64 tmp = dax_iomap_zero(pos, bytes, iomap);
 -                      if (tmp < 0)
 -                              return tmp;
 -                      bytes = tmp;
 -                      goto good;
 -              }
 -
+               status = iomap_write_begin(iter, pos, bytes, &folio);
                if (status)
                        return status;

-               zero_user(page, offset, bytes);
-               mark_page_accessed(page);
+               offset = offset_in_folio(folio, pos);
+               if (bytes > folio_size(folio) - offset)
+                       bytes = folio_size(folio) - offset;
+
+               folio_zero_range(folio, offset, bytes);
+               folio_mark_accessed(folio);

-               bytes = iomap_write_end(iter, pos, bytes, bytes, page);
+               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
 -good:
                if (WARN_ON_ONCE(bytes == 0))
                        return -EIO;



Shall I push out a version of this patch series which includes the
"iomap: Inline __iomap_zero_iter into its caller" patch I pasted above?
