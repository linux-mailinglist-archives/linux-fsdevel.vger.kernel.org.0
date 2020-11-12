Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0952B1062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKLV0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgKLV0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED42DC0613D4;
        Thu, 12 Nov 2020 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bTrDsmol5aUu0hNNGO8gHhFZiHT6t38oxGw0to6H7hI=; b=f/+BuA+klSCvPBZ5nrqnr6aDig
        tnqHLooQ2xnBfUL/bh+29e9RMw2V47ZfmV3cvxL7Ldhv16pkZp/7LVF67l3JVezO/pCdL59fSwqWW
        pBoJwjhNCAedzkvGZc/kh6aQvud1JKehsfneZ+Ygdp3S/mJqk4uWREZOTNs6L+M0nf/W2Zl0XxZMy
        BVFpA+vPKQrgk9CRFrxOcHLKm4g5Y4Jy5n8fEiy2s1e0l6SoR0DRMdXfJvGOeAraOyGb4Vh3wXGRk
        6yx7wubk7J6+jplA8nhom201WsiHPTfJnw5OPB6PuO/sl3IKgrL0/jZ3FUYdOXjSLM5CSfz9O4XXd
        IDi9MOAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7C-0007Ge-Tl; Thu, 12 Nov 2020 21:26:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/16] iomap: Use mapping_seek_hole_data
Date:   Thu, 12 Nov 2020 21:26:33 +0000
Message-Id: <20201112212641.27837-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enhance mapping_seek_hole_data() to handle partially uptodate pages and
convert the iomap seek code to call it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/seek.c | 125 +++++-------------------------------------------
 mm/filemap.c    |  37 ++++++++++++--
 2 files changed, 43 insertions(+), 119 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 107ee80c3568..dab1b02eba5b 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -10,122 +10,17 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-/*
- * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
- * Returns true if found and updates @lastoff to the offset in file.
- */
-static bool
-page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
-		int whence)
-{
-	const struct address_space_operations *ops = inode->i_mapping->a_ops;
-	unsigned int bsize = i_blocksize(inode), off;
-	bool seek_data = whence == SEEK_DATA;
-	loff_t poff = page_offset(page);
-
-	if (WARN_ON_ONCE(*lastoff >= poff + PAGE_SIZE))
-		return false;
-
-	if (*lastoff < poff) {
-		/*
-		 * Last offset smaller than the start of the page means we found
-		 * a hole:
-		 */
-		if (whence == SEEK_HOLE)
-			return true;
-		*lastoff = poff;
-	}
-
-	/*
-	 * Just check the page unless we can and should check block ranges:
-	 */
-	if (bsize == PAGE_SIZE || !ops->is_partially_uptodate)
-		return PageUptodate(page) == seek_data;
-
-	lock_page(page);
-	if (unlikely(page->mapping != inode->i_mapping))
-		goto out_unlock_not_found;
-
-	for (off = 0; off < PAGE_SIZE; off += bsize) {
-		if (offset_in_page(*lastoff) >= off + bsize)
-			continue;
-		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
-			unlock_page(page);
-			return true;
-		}
-		*lastoff = poff + off + bsize;
-	}
-
-out_unlock_not_found:
-	unlock_page(page);
-	return false;
-}
-
-/*
- * Seek for SEEK_DATA / SEEK_HOLE in the page cache.
- *
- * Within unwritten extents, the page cache determines which parts are holes
- * and which are data: uptodate buffer heads count as data; everything else
- * counts as a hole.
- *
- * Returns the resulting offset on successs, and -ENOENT otherwise.
- */
 static loff_t
-page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
-		int whence)
-{
-	pgoff_t index = offset >> PAGE_SHIFT;
-	pgoff_t end = DIV_ROUND_UP(offset + length, PAGE_SIZE);
-	loff_t lastoff = offset;
-	struct pagevec pvec;
-
-	if (length <= 0)
-		return -ENOENT;
-
-	pagevec_init(&pvec);
-
-	do {
-		unsigned nr_pages, i;
-
-		nr_pages = pagevec_lookup_range(&pvec, inode->i_mapping, &index,
-						end - 1);
-		if (nr_pages == 0)
-			break;
-
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
-
-			if (page_seek_hole_data(inode, page, &lastoff, whence))
-				goto check_range;
-			lastoff = page_offset(page) + PAGE_SIZE;
-		}
-		pagevec_release(&pvec);
-	} while (index < end);
-
-	/* When no page at lastoff and we are not done, we found a hole. */
-	if (whence != SEEK_HOLE)
-		goto not_found;
-
-check_range:
-	if (lastoff < offset + length)
-		goto out;
-not_found:
-	lastoff = -ENOENT;
-out:
-	pagevec_release(&pvec);
-	return lastoff;
-}
-
-
-static loff_t
-iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
+iomap_seek_hole_actor(struct inode *inode, loff_t start, loff_t length,
 		      void *data, struct iomap *iomap, struct iomap *srcmap)
 {
+	loff_t offset = start;
+
 	switch (iomap->type) {
 	case IOMAP_UNWRITTEN:
-		offset = page_cache_seek_hole_data(inode, offset, length,
-						   SEEK_HOLE);
-		if (offset < 0)
+		offset = mapping_seek_hole_data(inode->i_mapping, start,
+				start + length, SEEK_HOLE);
+		if (offset == start + length)
 			return length;
 		fallthrough;
 	case IOMAP_HOLE:
@@ -164,15 +59,17 @@ iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
 static loff_t
-iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
+iomap_seek_data_actor(struct inode *inode, loff_t start, loff_t length,
 		      void *data, struct iomap *iomap, struct iomap *srcmap)
 {
+	loff_t offset = start;
+
 	switch (iomap->type) {
 	case IOMAP_HOLE:
 		return length;
 	case IOMAP_UNWRITTEN:
-		offset = page_cache_seek_hole_data(inode, offset, length,
-						   SEEK_DATA);
+		offset = mapping_seek_hole_data(inode->i_mapping, start,
+				start + length, SEEK_DATA);
 		if (offset < 0)
 			return length;
 		fallthrough;
diff --git a/mm/filemap.c b/mm/filemap.c
index ab7103eb7e11..ef7411ea3f91 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2586,11 +2586,36 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
-static inline bool page_seek_match(struct page *page, bool seek_data)
+static inline loff_t page_seek_hole_data(struct xa_state *xas,
+		struct address_space *mapping, struct page *page,
+		loff_t start, loff_t end, bool seek_data)
 {
+	const struct address_space_operations *ops = mapping->a_ops;
+	size_t offset, bsz = i_blocksize(mapping->host);
+
 	if (xa_is_value(page) || PageUptodate(page))
-		return seek_data;
-	return !seek_data;
+		return seek_data ? start : end;
+	if (!ops->is_partially_uptodate)
+		return seek_data ? end : start;
+
+	xas_pause(xas);
+	rcu_read_unlock();
+	lock_page(page);
+	if (unlikely(page->mapping != mapping))
+		goto unlock;
+
+	offset = offset_in_thp(page, start) & ~(bsz - 1);
+
+	do {
+		if (ops->is_partially_uptodate(page, offset, bsz) == seek_data)
+			break;
+		start = (start + bsz) & ~(bsz - 1);
+		offset += bsz;
+	} while (offset < thp_size(page));
+unlock:
+	unlock_page(page);
+	rcu_read_lock();
+	return start;
 }
 
 static inline
@@ -2640,9 +2665,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 			start = pos;
 		}
 
-		if (page_seek_match(page, seek_data))
+		pos += seek_page_size(&xas, page);
+		start = page_seek_hole_data(&xas, mapping, page, start, pos,
+				seek_data);
+		if (start < pos)
 			goto unlock;
-		start = pos + seek_page_size(&xas, page);
 		put_page(page);
 	}
 	rcu_read_unlock();
-- 
2.28.0

