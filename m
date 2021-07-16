Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F243CB1C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 07:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhGPFKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 01:10:38 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54970 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhGPFKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:10:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UfwgDyq_1626412048;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UfwgDyq_1626412048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 13:07:42 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] iomap: support tail packing inline read
Date:   Fri, 16 Jul 2021 13:07:23 +0800
Message-Id: <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This tries to add tail packing inline read to iomap. Different from
the previous approach, it only marks the block range uptodate in the
page it covers. Also, leave the original pos == 0 case as a fast path
but rename it to iomap_read_inline_page().

The write path remains untouched since EROFS cannot be used for
testing. It'd be better to be implemented if upcoming real users care
rather than leave untested dead code around.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 41 +++++++++++++++++++++++++++++++++++------
 fs/iomap/direct-io.c   |  8 ++++++--
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9023717c5188..c6d6d7f9d5a6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -206,7 +206,7 @@ struct iomap_readpage_ctx {
 };
 
 static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+iomap_read_inline_page(struct inode *inode, struct page *page,
 		struct iomap *iomap)
 {
 	size_t size = i_size_read(inode);
@@ -225,10 +225,33 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	SetPageUptodate(page);
 }
 
+/*
+ * Different from iomap_read_inline_page, which makes the range of
+ * some tail blocks in the page uptodate and doesn't clean post-EOF.
+ */
+static void
+iomap_read_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos, unsigned int plen)
+{
+	unsigned int poff = offset_in_page(pos);
+	unsigned int delta = pos - iomap->offset;
+	unsigned int alignedsize = roundup(plen, i_blocksize(inode));
+	void *addr;
+
+	/* make sure that inline_data doesn't cross page boundary */
+	BUG_ON(plen > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	BUG_ON(plen != i_size_read(inode) - pos);
+	addr = kmap_atomic(page);
+	memcpy(addr + poff, iomap->inline_data + delta, plen);
+	memset(addr + poff + plen, 0, alignedsize - plen);
+	kunmap_atomic(addr);
+	iomap_set_range_uptodate(page, poff, alignedsize);
+}
+
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
 		struct iomap *iomap, loff_t pos)
 {
-	return iomap->type != IOMAP_MAPPED ||
+	return (iomap->type != IOMAP_MAPPED && iomap->type != IOMAP_INLINE) ||
 		(iomap->flags & IOMAP_F_NEW) ||
 		pos >= i_size_read(inode);
 }
@@ -245,9 +268,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
+	if (iomap->type == IOMAP_INLINE && !pos) {
+		iomap_read_inline_page(inode, page, iomap);
 		return PAGE_SIZE;
 	}
 
@@ -262,6 +284,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		goto done;
 	}
 
+	if (iomap->type == IOMAP_INLINE) {
+		iomap_read_inline_data(inode, page, iomap, pos, plen);
+		goto done;
+	}
 	ctx->cur_page_in_bio = true;
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
@@ -598,6 +624,9 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	BUG_ON(pos + len > iomap->offset + iomap->length);
 	if (srcmap != iomap)
 		BUG_ON(pos + len > srcmap->offset + srcmap->length);
+	/* no available tail-packing write user yet, never allow it for now */
+	if (WARN_ON_ONCE(srcmap->type == IOMAP_INLINE && iomap->offset))
+		return -EIO;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -616,7 +645,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		iomap_read_inline_page(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..a905939dea4e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,7 +380,10 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(pos && (dio->flags & IOMAP_DIO_WRITE)))
+		return -EIO;
+	/* inline data should be in the same page boundary */
+	BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
@@ -394,7 +397,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(iomap->inline_data + pos - iomap->offset,
+				length, iter);
 	}
 	dio->size += copied;
 	return copied;
-- 
2.24.4

