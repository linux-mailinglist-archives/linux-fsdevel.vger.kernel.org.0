Return-Path: <linux-fsdevel+bounces-6219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA18150C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EADF2870EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116406928A;
	Fri, 15 Dec 2023 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWXxx/CL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685D56778;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yOUu3Oa9oop0gFCwHzPJjrXW9AuzoUvkVlbRlf+EeEk=; b=KWXxx/CL90Q2i3AE4nF0/mc+Ao
	yCvtsrMjiAytmy+AXKn93CDYgqxfFKBdhap8lWBk+1BZ/PAX+jE6QGRo7HLonPxjSSKnqLeDR1M8R
	tmxLyCmpYj7r/Y4DqQAFj2eekjVysrtUiydLRxXpNh5jv/FS1M0Xfi+jgvBRLcU5NUUvqmP48AP+O
	LunUCVkXMfq9oHMZ7oCXnribKfi5dluuUKM/LSqY8E75FU5ODSWTwGVluoj4Lz0BXBAHTVrn+Sr8A
	kkmLXpZJcaO8FiS4j82bUdzrpcYdJftLdmG8fz2Lfq9BaJUMnYuPcpx8KA3BAdVxm9b4qLhVhxUjN
	yfHnqccQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOW-0038jt-Jx; Fri, 15 Dec 2023 20:02:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 14/14] fs: Remove the bh_end_io argument from __block_write_full_folio
Date: Fri, 15 Dec 2023 20:02:45 +0000
Message-Id: <20231215200245.748418-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers are passing end_buffer_async_write as this argument, so we
can hardcode references to it within __block_write_full_folio().
That lets us make end_buffer_async_write() static.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 22 ++++++++++------------
 fs/gfs2/aops.c              |  2 +-
 include/linux/buffer_head.h |  4 +---
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2e69f0ddca37..d5ce6b29c893 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -372,10 +372,10 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 }
 
 /*
- * Completion handler for block_write_full_folio() - pages which are unlocked
- * during I/O, and which have PageWriteback cleared upon I/O completion.
+ * Completion handler for block_write_full_folio() - folios which are unlocked
+ * during I/O, and which have the writeback flag cleared upon I/O completion.
  */
-void end_buffer_async_write(struct buffer_head *bh, int uptodate)
+static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
 	unsigned long flags;
 	struct buffer_head *first;
@@ -415,7 +415,6 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	return;
 }
-EXPORT_SYMBOL(end_buffer_async_write);
 
 /*
  * If a page's buffers are under async readin (end_buffer_async_read
@@ -1787,8 +1786,7 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
  * causes the writes to be flagged as synchronous writes.
  */
 int __block_write_full_folio(struct inode *inode, struct folio *folio,
-			get_block_t *get_block, struct writeback_control *wbc,
-			bh_end_io_t *handler)
+			get_block_t *get_block, struct writeback_control *wbc)
 {
 	int err;
 	sector_t block;
@@ -1867,7 +1865,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			mark_buffer_async_write_endio(bh, handler);
+			mark_buffer_async_write_endio(bh,
+				end_buffer_async_write);
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1920,7 +1919,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		if (buffer_mapped(bh) && buffer_dirty(bh) &&
 		    !buffer_delay(bh)) {
 			lock_buffer(bh);
-			mark_buffer_async_write_endio(bh, handler);
+			mark_buffer_async_write_endio(bh,
+				end_buffer_async_write);
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -2704,8 +2704,7 @@ int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 
 	/* Is the folio fully inside i_size? */
 	if (folio_pos(folio) + folio_size(folio) <= i_size)
-		return __block_write_full_folio(inode, folio, get_block, wbc,
-					       end_buffer_async_write);
+		return __block_write_full_folio(inode, folio, get_block, wbc);
 
 	/* Is the folio fully outside i_size? (truncate in progress) */
 	if (folio_pos(folio) >= i_size) {
@@ -2722,8 +2721,7 @@ int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 	 */
 	folio_zero_segment(folio, offset_in_folio(folio, i_size),
 			folio_size(folio));
-	return __block_write_full_folio(inode, folio, get_block, wbc,
-			end_buffer_async_write);
+	return __block_write_full_folio(inode, folio, get_block, wbc);
 }
 
 sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index f986cd032b76..9914d7f54f7d 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -108,7 +108,7 @@ static int gfs2_write_jdata_folio(struct folio *folio,
 				folio_size(folio));
 
 	return __block_write_full_folio(inode, folio, gfs2_get_block_noalloc,
-			wbc, end_buffer_async_write);
+			wbc);
 }
 
 /**
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 396b2adf24bf..d78454a4dd1f 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -205,7 +205,6 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
-void end_buffer_async_write(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
@@ -255,8 +254,7 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 		void *get_block);
 int __block_write_full_folio(struct inode *inode, struct folio *folio,
-			get_block_t *get_block, struct writeback_control *wbc,
-			bh_end_io_t *handler);
+		get_block_t *get_block, struct writeback_control *wbc);
 int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-- 
2.42.0


