Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B876AA6CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbfIEPHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:07:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390251AbfIEPHB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:07:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06792B114;
        Thu,  5 Sep 2019 15:06:59 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 02/15] iomap: Read page from srcmap if IOMAP_F_COW is set
Date:   Thu,  5 Sep 2019 10:06:37 -0500
Message-Id: <20190905150650.21089-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190905150650.21089-1-rgoldwyn@suse.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

In case of a IOMAP_F_COW, read a page from the srcmap before
performing a write on the page.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 30 +++++++++++++++++++++---------
 include/linux/iomap.h  |  3 +++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f27756c0b31c..560459df75e4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -581,7 +581,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, struct iomap *iomap)
+		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	pgoff_t index = pos >> PAGE_SHIFT;
@@ -605,12 +605,24 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		goto out_no_page;
 	}
 
-	if (iomap->type == IOMAP_INLINE)
+	if (iomap->type == IOMAP_INLINE) {
 		iomap_read_inline_data(inode, page, iomap);
-	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
+	} else if (iomap->flags & IOMAP_F_COW) {
+		if (WARN_ON_ONCE(iomap->flags & IOMAP_F_BUFFER_HEAD)) {
+			status = -EIO;
+			goto out_no_page;
+		}
+		if (WARN_ON_ONCE(srcmap->type == IOMAP_HOLE &&
+				 srcmap->addr != IOMAP_NULL_ADDR)) {
+			status = -EIO;
+			goto out_no_page;
+		}
+		status = __iomap_write_begin(inode, pos, len, page, srcmap);
+	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
 		status = __block_write_begin_int(page, pos, len, NULL, iomap);
-	else
+	} else {
 		status = __iomap_write_begin(inode, pos, len, page, iomap);
+	}
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -772,7 +784,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		}
 
 		status = iomap_write_begin(inode, pos, bytes, flags, &page,
-				iomap);
+				iomap, srcmap);
 		if (unlikely(status))
 			break;
 
@@ -871,7 +883,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			return PTR_ERR(rpage);
 
 		status = iomap_write_begin(inode, pos, bytes,
-					   AOP_FLAG_NOFS, &page, iomap);
+					   AOP_FLAG_NOFS, &page, iomap, srcmap);
 		put_page(rpage);
 		if (unlikely(status))
 			return status;
@@ -917,13 +929,13 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
 EXPORT_SYMBOL_GPL(iomap_file_dirty);
 
 static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
-		unsigned bytes, struct iomap *iomap)
+		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
 	int status;
 
 	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
-				   iomap);
+				   iomap, srcmap);
 	if (status)
 		return status;
 
@@ -961,7 +973,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		if (IS_DAX(inode))
 			status = iomap_dax_zero(pos, offset, bytes, iomap);
 		else
-			status = iomap_zero(inode, pos, offset, bytes, iomap);
+			status = iomap_zero(inode, pos, offset, bytes, iomap, srcmap);
 		if (status < 0)
 			return status;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9782a79dde59..7fdb09925740 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -44,6 +44,9 @@ struct vm_fault;
 #define IOMAP_F_MERGED		0x10	/* contains multiple blocks/extents */
 #define IOMAP_F_SHARED		0x20	/* block shared with another file */
 
+/* Flags for CoW */
+#define IOMAP_F_COW		0x100	/* copy from srcmap before write */
+
 /*
  * Flags from 0x1000 up are for file system specific usage:
  */
-- 
2.16.4

