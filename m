Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4110EE8FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfD2R1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728954AbfD2R1g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96DB1AE5A;
        Mon, 29 Apr 2019 17:27:34 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 14/18] dax: memcpy before zeroing range
Date:   Mon, 29 Apr 2019 12:26:45 -0500
Message-Id: <20190429172649.8288-15-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

However, this needed more iomap fields, so it was easier
to pass iomap and compute inside the function rather
than passing a log of arguments.

Note, there is subtle difference between iomap_sector and
dax_iomap_sector(). Can we replace dax_iomap_sector with
iomap_sector()? It would need pos & PAGE_MASK though or else
bdev_dax_pgoff() return -EINVAL.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/dax.c              | 17 ++++++++++++-----
 fs/iomap.c            |  9 +--------
 include/linux/dax.h   | 11 +++++------
 include/linux/iomap.h |  6 ++++++
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index fa9ccbad7c03..82a08b0eec23 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1063,11 +1063,16 @@ static bool dax_range_is_aligned(struct block_device *bdev,
 	return true;
 }
 
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int size)
+int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
+			  unsigned int offset, unsigned int size)
 {
-	if (dax_range_is_aligned(bdev, offset, size)) {
+	sector_t sector = dax_iomap_sector(iomap, pos & PAGE_MASK);
+	struct block_device *bdev = iomap->bdev;
+	struct dax_device *dax_dev = iomap->dax_dev;
+	int ret = 0;
+
+	if (!(iomap->type == IOMAP_DAX_COW) &&
+	    dax_range_is_aligned(bdev, offset, size)) {
 		sector_t start_sector = sector + (offset >> 9);
 
 		return blkdev_issue_zeroout(bdev, start_sector,
@@ -1087,11 +1092,13 @@ int __dax_zero_page_range(struct block_device *bdev,
 			dax_read_unlock(id);
 			return rc;
 		}
+		if (iomap->type == IOMAP_DAX_COW)
+			ret = memcpy_mcsafe(kaddr, iomap->inline_data, offset);
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
 		dax_read_unlock(id);
 	}
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
diff --git a/fs/iomap.c b/fs/iomap.c
index abdd18e404f8..90698c854883 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -98,12 +98,6 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	return written ? written : ret;
 }
 
-static sector_t
-iomap_sector(struct iomap *iomap, loff_t pos)
-{
-	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
-}
-
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
@@ -990,8 +984,7 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
 		struct iomap *iomap)
 {
-	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
-			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
+	return __dax_zero_page_range(iomap, pos, offset, bytes);
 }
 
 static loff_t
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 1370d39c91b6..c469d9ff54b4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -9,6 +9,7 @@
 
 typedef unsigned long dax_entry_t;
 
+struct iomap;
 struct iomap_ops;
 struct dax_device;
 struct dax_operations {
@@ -163,13 +164,11 @@ int dax_file_range_compare(struct inode *src, loff_t srcoff,
 			   const struct iomap_ops *ops);
 
 #ifdef CONFIG_FS_DAX
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length);
+int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
+		unsigned int offset, unsigned int size);
 #else
-static inline int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length)
+static inline int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
+		unsigned int offset, unsigned int size)
 {
 	return -ENXIO;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6e885c5a38a3..fcfce269db3e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/mm_types.h>
+#include <linux/blkdev.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -120,6 +121,11 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
 	return NULL;
 }
 
+static inline sector_t iomap_sector(struct iomap *iomap, loff_t pos)
+{
+	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-- 
2.16.4

