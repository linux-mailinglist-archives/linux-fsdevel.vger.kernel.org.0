Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9284C159FFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgBLETl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3yymKC5HofjIktaqISxer59WHRLOSzpRhrvUFUGt25s=; b=gyhDgfflQ7Z5TXmu97SKt/yc1b
        KDPf0SRcDenzPcvfPOEkDtLj9omcH8T1hdZS8YivupCAPmJ9G78E7iHIGNdaluqG+aVhdHDEKZlOg
        NHdnQMZ7BOOG9hY64LAmrmFJz+zPSZpMota5fUPkyWk4kQWxaEonw+5HiO+xMJZok/SuMjs4qP60j
        iabs20AExdfeQWu/OEQ9gZeSj8OpKkybOVKrLTQ2Zrm9/Lsxb8OptwZXi67dOUrSi8NK96uP/c2yZ
        YSU6DSRhTI12htrS5PlsrdVPpVJHNJ8huIugXWso03h5k5FTX+4hz9qYeo2vj0j+s/WwelTTvQpQb
        0f593Iig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006o1-3E; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/25] iomap: Support large pages in iomap_adjust_read_range
Date:   Tue, 11 Feb 2020 20:18:35 -0800
Message-Id: <20200212041845.25879-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Pass the struct page instead of the iomap_page so we can determine the
size of the page.  Introduce offset_in_this_page() and use thp_size()
instead of PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 16 +++++++++-------
 include/linux/mm.h     |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5e5a6b038fc3..e522039f627f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -83,15 +83,16 @@ iomap_page_release(struct page *page)
  * Calculate the range inside the page that we actually need to read.
  */
 static void
-iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
+iomap_adjust_read_range(struct inode *inode, struct page *page,
 		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
 {
+	struct iomap_page *iop = to_iomap_page(page);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
 	unsigned block_size = (1 << block_bits);
-	unsigned poff = offset_in_page(*pos);
-	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
+	unsigned poff = offset_in_this_page(page, *pos);
+	unsigned plen = min_t(loff_t, thp_size(page) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -129,7 +130,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
 	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
+		unsigned end = offset_in_this_page(page, isize - 1) >>
+				block_bits;
 
 		if (first <= end && last > end)
 			plen -= (last - end) * block_size;
@@ -256,7 +258,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
@@ -547,7 +549,6 @@ static int
 __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		struct page *page, struct iomap *srcmap)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
@@ -556,9 +557,10 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 
 	if (PageUptodate(page))
 		return 0;
+	iomap_page_create(inode, page);
 
 	do {
-		iomap_adjust_read_range(inode, iop, &block_start,
+		iomap_adjust_read_range(inode, page, &block_start,
 				block_end - block_start, &poff, &plen);
 		if (plen == 0)
 			break;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..b4bf86590096 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1387,6 +1387,8 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_this_page(page, p)	\
+	((unsigned long)(p) & (thp_size(page) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
-- 
2.25.0

