Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D63D449B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 05:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhGXDFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhGXDFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:05:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F191C061575;
        Fri, 23 Jul 2021 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+N9SykQ2lbTxb2AejJAk1U9VpUSl7HtWA73hcep5cqs=; b=FWR4ZW/GP+Y/LB9DmDzRFFL2rQ
        HltVxc2YO3d4m15reevVU61gjCWzppiiDHE/KfnoWITuUsLcR4EtBANeqZE9OTPkFMQZksCitiJfC
        uXIJwgKxdmvZ+JrdWkHkUP0MTqSZke34LNwxXVkYahSF9SHaYq9H5O2LfutNIXqrKOOW/d4DOq0L9
        O9XOpyngqBOlOVfBopGzPHneJPOMQnOdg9mLLQtWR1qCATt3WEeIyAE0ltMCwnobY5MtUgSrp4OH/
        l1VcxAnSFGWy/elbMD+7FutA8F4Dz0jplqVupoBK4FJzYAvuVTVDMf8+SdN+BIw8yoWXW8a5/7FIw
        /BPYZ1eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m78b9-00Byaw-R4; Sat, 24 Jul 2021 03:45:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/2] iomap: Support file tail packing
Date:   Sat, 24 Jul 2021 04:44:34 +0100
Message-Id: <20210724034435.2854295-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210724034435.2854295-1-willy@infradead.org>
References: <20210724034435.2854295-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Add support for reading inline data content into the page cache from
nonzero page-aligned file offsets.  This enables the EROFS tailpacking
mode where the last few bytes of the file are stored right after the
inode.

The buffered write path remains untouched since EROFS cannot be used
for testing. It'd be better to be implemented if upcoming real users
care and provide a real pattern rather than leave untested dead code
around.

Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++----------------
 fs/iomap/direct-io.c   | 10 ++++++----
 include/linux/iomap.h  | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a463b41c0a16..7bd8e5de996d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+static int iomap_read_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos)
 {
-	size_t size = i_size_read(inode);
+	size_t size = iomap->length + iomap->offset - pos;
 	void *addr;
 
 	if (PageUptodate(page))
-		return;
+		return PAGE_SIZE;
 
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must start page aligned in the file */
+	if (WARN_ON_ONCE(offset_in_page(pos)))
+		return -EIO;
+	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
+		return -EIO;
+	if (WARN_ON_ONCE(page_has_private(page)))
+		return -EIO;
 
 	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
+	memcpy(addr, iomap_inline_buf(iomap, pos), size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
 	SetPageUptodate(page);
+	return PAGE_SIZE;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -245,11 +249,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
-	}
+	if (iomap->type == IOMAP_INLINE)
+		return iomap_read_inline_data(inode, page, iomap, pos);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(inode, page);
@@ -581,6 +582,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(srcmap->offset != 0))
+		return -EIO;
+	return iomap_read_inline_data(inode, page, srcmap, 0);
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -610,14 +620,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
 		status = __iomap_write_begin(inode, pos, len, flags, page,
 				srcmap);
 
-	if (unlikely(status))
+	if (unlikely(status < 0))
 		goto out_unlock;
 
 	*pagep = page;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..a6aaea2764a5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
 {
 	struct iov_iter *iter = dio->submit.iter;
+	void *dst = iomap_inline_buf(iomap, pos);
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
+		return -EIO;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
 
 		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+			memset(iomap_inline_buf(iomap, size), 0, pos - size);
+		copied = copy_from_iter(dst, length, iter);
 		if (copied) {
 			if (pos + copied > size)
 				i_size_write(inode, pos + copied);
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(dst, length, iter);
 	}
 	dio->size += copied;
 	return copied;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..3cfe787fbf50 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,20 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+static inline void *iomap_inline_buf(const struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data - iomap->offset + pos;
+}
+
+/*
+ * iomap->inline_data is a potentially kmapped page, ensure it never crosses a
+ * page boundary.
+ */
+static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
+{
+	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.30.2

