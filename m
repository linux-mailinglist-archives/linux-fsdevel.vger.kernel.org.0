Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0D3CD742
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbhGSOPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 10:15:15 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:54894 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232727AbhGSOPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:15:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UgIJ0CV_1626706070;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgIJ0CV_1626706070)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 22:48:00 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: [PATCH v3] iomap: support tail packing inline read
Date:   Mon, 19 Jul 2021 22:47:47 +0800
Message-Id: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This tries to add tail packing inline read to iomap, which can support
several inline tail blocks. Similar to the previous approach, it cleans
post-EOF in one iteration.

The write path remains untouched since EROFS cannot be used for testing.
It'd be better to be implemented if upcoming real users care rather than
leave untested dead code around.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: https://lore.kernel.org/r/YPLdSja%2F4FBsjss%2F@B-P7TQMD6M-0146.local/
changes since v2:
 - update suggestion from Christoph:
    https://lore.kernel.org/r/YPVe41YqpfGLNsBS@infradead.org/

Hi Andreas,
would you mind test on the gfs2 side? Thanks in advance!

Thanks,
Gao Xiang

 fs/iomap/buffered-io.c | 50 ++++++++++++++++++++++++++----------------
 fs/iomap/direct-io.c   | 11 ++++++----
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..cac8a88660d8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -207,23 +207,22 @@ struct iomap_readpage_ctx {
 
 static void
 iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+		struct iomap *iomap, loff_t pos)
 {
-	size_t size = i_size_read(inode);
+	unsigned int size, poff = offset_in_page(pos);
 	void *addr;
 
-	if (PageUptodate(page))
-		return;
-
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline source data must be inside a single page */
+	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* handle tail-packing blocks cross the current page into the next */
+	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
+		     PAGE_SIZE - poff);
 
 	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - size);
+	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
+	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
 	kunmap_atomic(addr);
-	SetPageUptodate(page);
+	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(inode, page);
+	/* needs to skip some leading uptodated blocks */
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
+	if (iomap->type == IOMAP_INLINE) {
+		iomap_read_inline_data(inode, page, iomap, pos);
+		plen = PAGE_SIZE - poff;
+		goto done;
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
 	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
@@ -589,6 +589,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(pos != 0))
+		return -EIO;
+	if (PageUptodate(page))
+		return 0;
+	iomap_read_inline_data(inode, page, srcmap, pos);
+	return 0;
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, pos, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..ee6309967b77 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -379,22 +379,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 {
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
+	void *dst = iomap->inline_data + pos - iomap->offset;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must be inside a single page */
+	BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
 
 		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+			memset(iomap->inline_data + size - iomap->offset,
+			       0, pos - size);
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
-- 
2.24.4

