Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374031F5CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgFJUQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbgFJUNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81565C08C5C2;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C9KNZLFkt8Tle4VaX/QjFZQwjCdLqmDjaJSbY4g1BBc=; b=OiAighL9mBrPMhnrkS/gqGty1F
        u+yNVja/T7n3ktY+YB0D0qaJCPfbXCZl+5ippi9ekL75UScg7fDbqZKZZfN8RISA5FApVLRtZbdg5
        p0jd/PBsujMOChVBoe5Yno51GObGHDl00288vESYdf5iSJKEiH7iyWk5zCgBFto9+w9teXyQzL6hs
        eRHuA3fYJSvvczre/GDjn6fTWi0+rF5f1F0zwZFOTJtDR1b3TqOi3Glh1clzvypR6h2AZWUBEmf6J
        VqYU60h2wqrw0yz/hoFGCNB2yzIv9RcVmZBNol0fiYqT6bP6Vi7e0weWLFJWRUPFOBzhXVQ0OCLel
        hdP4QG6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Vv-BK; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 28/51] iomap: Change iomap_write_begin calling convention
Date:   Wed, 10 Jun 2020 13:13:22 -0700
Message-Id: <20200610201345.13273-29-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Pass (up to) the remaining length of the extent to iomap_write_begin()
and have it return the number of bytes that will fit in the page.
That lets us copy more bytes per call to iomap_write_begin() if the page
cache has already allocated a THP (and will in future allow us to pass
a hint to the page cache that it should try to allocate a larger page
if there are none in the cache).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 63 +++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8d690ad68657..e445ee5f0521 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -571,14 +571,14 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
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
 	int status;
 
@@ -614,12 +614,13 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
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
@@ -630,6 +631,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		return -EINTR;
 
 	if (page_ops && page_ops->page_prepare) {
+		if (len > UINT_MAX)
+			len = UINT_MAX;
 		status = page_ops->page_prepare(inode, pos, len, iomap);
 		if (status)
 			return status;
@@ -641,6 +644,10 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		status = -ENOMEM;
 		goto out_no_page;
 	}
+	page = thp_head(page);
+	offset = offset_in_thp(page, pos);
+	if (len > thp_size(page) - offset)
+		len = thp_size(page) - offset;
 
 	if (srcmap->type == IOMAP_INLINE)
 		iomap_read_inline_data(inode, page, srcmap);
@@ -650,11 +657,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
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
@@ -809,8 +816,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
 				srcmap);
-		if (unlikely(status))
+		if (status < 0)
 			break;
+		/* We may be partway through a THP */
+		offset = offset_in_thp(page, pos);
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -872,8 +881,7 @@ static loff_t
 iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
 {
-	long status = 0;
-	ssize_t written = 0;
+	loff_t written = 0;
 
 	/* don't bother with blocks that are not shared to start with */
 	if (!(iomap->flags & IOMAP_F_SHARED))
@@ -883,25 +891,24 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
@@ -932,15 +939,13 @@ static ssize_t iomap_zero(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
-	int status;
-	unsigned offset = offset_in_page(pos);
-	unsigned bytes = min_t(loff_t, PAGE_SIZE - offset, length);
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
2.26.2

