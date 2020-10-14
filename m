Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BFE28DDAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgJNJan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgJNJTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCDC0F26F0;
        Tue, 13 Oct 2020 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=78jQva7SN0URAIlYak97f7/G/y+lO4R9hQAD5LqWZfM=; b=abukv0v1g/Y5sNHv1T8SRp7RLT
        2S5W1gZUZIfNydJ4TCWEIlrzKkaM/3O3UM23uKmiN2gir7ANyxX1ey2ra2cmfmfZgzkoiK/aNfLp+
        icIlf5blq+ln6nx68CNgDpx/WHFyJ4HYIjaWn/H+V3SKzU/uO3cX0y6PqSi9S7wdlahpPmDfufqSl
        brOCMrF/BB2pNmj3zPHnqgxi4W+UX55+Pux6nJ1dDDV1RtWeS9vbxQG96lB9iim18PVZYVN09Om+d
        VFGJqwolfbxukF80XjIg8zUZRHnxz+/tzMFGTffHBFsW5HQAJCodJYccYZymlCQ3//N6FuIZntpV+
        p8bkrL9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX57-0005j3-G0; Wed, 14 Oct 2020 03:04:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 09/14] iomap: Change iomap_write_begin calling convention
Date:   Wed, 14 Oct 2020 04:03:52 +0100
Message-Id: <20201014030357.21898-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass (up to) the remaining length of the extent to iomap_write_begin()
and have it return the number of bytes that will fit in the page.
That lets us copy more bytes per call to iomap_write_begin() if the page
cache has already allocated a THP (and will in future allow us to pass
a hint to the page cache that it should try to allocate a larger page
if there are none in the cache).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 61 +++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4ef02afaedc5..397795db3ce5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -616,14 +616,14 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 	return submit_bio_wait(&bio);
 }
 
-static int
-__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
-		struct page *page, struct iomap *srcmap)
+static ssize_t __iomap_write_begin(struct inode *inode, loff_t pos,
+		size_t len, int flags, struct page *page, struct iomap *srcmap)
 {
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len;
+	size_t from = offset_in_thp(page, pos);
+	size_t to = from + len;
 	size_t poff, plen;
 
 	if (PageUptodate(page))
@@ -658,12 +658,13 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
-static int
-iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
+static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, loff_t len,
+		unsigned flags, struct page **pagep, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	struct page *page;
+	size_t offset;
 	int status = 0;
 
 	BUG_ON(pos + len > iomap->offset + iomap->length);
@@ -674,6 +675,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		return -EINTR;
 
 	if (page_ops && page_ops->page_prepare) {
+		if (len > UINT_MAX)
+			len = UINT_MAX;
 		status = page_ops->page_prepare(inode, pos, len, iomap);
 		if (status)
 			return status;
@@ -685,6 +688,10 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		status = -ENOMEM;
 		goto out_no_page;
 	}
+	page = thp_head(page);
+	offset = offset_in_thp(page, pos);
+	if (len > thp_size(page) - offset)
+		len = thp_size(page) - offset;
 
 	if (srcmap->type == IOMAP_INLINE)
 		iomap_read_inline_data(inode, page, srcmap);
@@ -694,11 +701,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		status = __iomap_write_begin(inode, pos, len, flags, page,
 				srcmap);
 
-	if (unlikely(status))
+	if (status < 0)
 		goto out_unlock;
 
 	*pagep = page;
-	return 0;
+	return len;
 
 out_unlock:
 	unlock_page(page);
@@ -854,8 +861,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
 				srcmap);
-		if (unlikely(status))
+		if (status < 0)
 			break;
+		/* We may be partway through a THP */
+		offset = offset_in_thp(page, pos);
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -915,7 +924,6 @@ static loff_t
 iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
 {
-	long status = 0;
 	loff_t written = 0;
 
 	/* don't bother with blocks that are not shared to start with */
@@ -926,25 +934,24 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		return length;
 
 	do {
-		unsigned long offset = offset_in_page(pos);
-		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct page *page;
+		ssize_t bytes;
 
-		status = iomap_write_begin(inode, pos, bytes,
+		bytes = iomap_write_begin(inode, pos, length,
 				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
-		if (unlikely(status))
-			return status;
+		if (bytes < 0)
+			return bytes;
 
-		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
+		bytes = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
 				srcmap);
-		if (WARN_ON_ONCE(status == 0))
+		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
 		cond_resched();
 
-		pos += status;
-		written += status;
-		length -= status;
+		pos += bytes;
+		written += bytes;
+		length -= bytes;
 
 		balance_dirty_pages_ratelimited(inode->i_mapping);
 	} while (length);
@@ -975,15 +982,13 @@ static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
 		struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
-	int status;
-	unsigned offset = offset_in_page(pos);
-	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
+	ssize_t bytes;
 
-	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
-	if (status)
-		return status;
+	bytes = iomap_write_begin(inode, pos, length, 0, &page, iomap, srcmap);
+	if (bytes < 0)
+		return bytes;
 
-	zero_user(page, offset, bytes);
+	zero_user(page, offset_in_thp(page, pos), bytes);
 	mark_page_accessed(page);
 
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
-- 
2.28.0

