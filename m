Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14D3D5C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhGZORQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:17:16 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55082 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234762AbhGZORP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:17:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uh49OZI_1627311456;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uh49OZI_1627311456)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Jul 2021 22:57:40 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v8] iomap: make inline data support more flexible
Date:   Mon, 26 Jul 2021 22:57:34 +0800
Message-Id: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The existing inline data support only works for cases where the entire
file is stored as inline data.  For larger files, EROFS stores the
initial blocks separately and then can pack a small tail adjacent to the
inode.  Generalise inline data to allow for tail packing.  Tails may not
cross a page boundary in memory.

We currently have no filesystems that support tail packing and writing,
so that case is currently disabled (see iomap_write_begin_inline).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v7: https://lore.kernel.org/r/20210723174131.180813-1-hsiangkao@linux.alibaba.com
changes since v7:
 - This version is based on Andreas's patch, the main difference
   is to avoid using "iomap->length" in iomap_read_inline_data().
   more details see:
    https://lore.kernel.org/r/CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com
   The rest are similar (some renaming and return type changes.)

 - with update according to Christoph's comments:
   https://lore.kernel.org/r/20210726121702.GA528@lst.de/
   except that "
    I think we should fix that now that we have the srcmap concept.
    That is or IOMAP_WRITE|IOMAP_ZERO return the inline map as the
    soure map, and return the actual block map we plan to write into
    as the main iomap. "
   Hopefully it could be addressed with a new gfs2-related patch.

 - it passes gfs2 fstests and no strange on my side.

Hopefully I don't miss anything (already many inputs), and everyone
is happy with this version.

 fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++------------
 fs/iomap/direct-io.c   | 10 ++++++----
 include/linux/iomap.h  | 18 ++++++++++++++++++
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..0d9f161ecb7e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,25 +205,30 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+static int iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
 {
-	size_t size = i_size_read(inode);
+	size_t size = i_size_read(inode) - iomap->offset;
 	void *addr;
 
 	if (PageUptodate(page))
-		return;
+		return 0;
 
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must start page aligned in the file */
+	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
+		return -EIO;
+	if (WARN_ON_ONCE(size > PAGE_SIZE -
+			 offset_in_page(iomap->inline_data)))
+		return -EIO;
+	if (WARN_ON_ONCE(page_has_private(page)))
+		return -EIO;
 
 	addr = kmap_atomic(page);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
 	SetPageUptodate(page);
+	return 0;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -247,8 +252,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
+		int ret = iomap_read_inline_data(inode, page, iomap);
+
+		if (ret)
+			return ret;
 		return PAGE_SIZE;
 	}
 
@@ -589,6 +596,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(srcmap->offset != 0))
+		return -EIO;
+	return iomap_read_inline_data(inode, page, srcmap);
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +634,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
@@ -671,11 +687,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
-	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	BUG_ON(!iomap_inline_data_valid(iomap));
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
 	kunmap_atomic(addr);
 
 	mark_inode_dirty(inode);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..41ccbfc9dc82 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
 {
 	struct iov_iter *iter = dio->submit.iter;
+	void *inline_data = iomap_inline_data(iomap, pos);
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
+		return -EIO;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
 
 		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+			memset(iomap_inline_data(iomap, size), 0, pos - size);
+		copied = copy_from_iter(inline_data, length, iter);
 		if (copied) {
 			if (pos + copied > size)
 				i_size_write(inode, pos + copied);
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(inline_data, length, iter);
 	}
 	dio->size += copied;
 	return copied;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..b8ec145b2975 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,24 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+/*
+ * Returns the inline data pointer for logical offset @pos.
+ */
+static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data + pos - iomap->offset;
+}
+
+/*
+ * Check if the mapping's length is within the valid range for inline data.
+ * This is used to guard against accessing data beyond the page inline_data
+ * points at.
+ */
+static inline bool iomap_inline_data_valid(struct iomap *iomap)
+{
+	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.24.4

