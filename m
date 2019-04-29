Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8981CE8D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfD2R1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728873AbfD2R1Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA113ADAF;
        Mon, 29 Apr 2019 17:27:13 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during writes
Date:   Mon, 29 Apr 2019 12:26:35 -0500
Message-Id: <20190429172649.8288-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The IOMAP_DAX_COW is a iomap type which performs copy of
edges of data while performing a write if start/end are
not page aligned. The source address is expected in
iomap->inline_data.

dax_copy_edges() is a helper functions performs a copy from
one part of the device to another for data not page aligned.
If iomap->inline_data is NULL, it memset's the area to zero.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/dax.c              | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iomap.h |  1 +
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index e5e54da1715f..610bfa861a28 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1084,6 +1084,42 @@ int __dax_zero_page_range(struct block_device *bdev,
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
+/*
+ * dax_copy_edges - Copies the part of the pages not included in
+ * 		    the write, but required for CoW because
+ * 		    offset/offset+length are not page aligned.
+ */
+static int dax_copy_edges(struct inode *inode, loff_t pos, loff_t length,
+			   struct iomap *iomap, void *daddr)
+{
+	unsigned offset = pos & (PAGE_SIZE - 1);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, PAGE_SIZE);
+	void *saddr = iomap->inline_data;
+	int ret = 0;
+	/*
+	 * Copy the first part of the page
+	 * Note: we pass offset as length
+	 */
+	if (offset) {
+		if (saddr)
+			ret = memcpy_mcsafe(daddr, saddr, offset);
+		else
+			memset(daddr, 0, offset);
+	}
+
+	/* Copy the last part of the range */
+	if (end < pg_end) {
+		if (saddr)
+			ret = memcpy_mcsafe(daddr + offset + length,
+			       saddr + offset + length,	pg_end - end);
+		else
+			memset(daddr + offset + length, 0,
+					pg_end - end);
+	}
+	return ret;
+}
+
 static loff_t
 dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
@@ -1105,9 +1141,11 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			return iov_iter_zero(min(length, end - pos), iter);
 	}
 
-	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
+	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED
+			 && iomap->type != IOMAP_DAX_COW))
 		return -EIO;
 
+
 	/*
 	 * Write can allocate block for an area which has a hole page mapped
 	 * into page tables. We have to tear down these mappings so that data
@@ -1144,6 +1182,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
+		if (iomap->type == IOMAP_DAX_COW) {
+			ret = dax_copy_edges(inode, pos, length, iomap, kaddr);
+			if (ret)
+				break;
+		}
+
 		map_len = PFN_PHYS(map_len);
 		kaddr += offset;
 		map_len -= offset;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0fefb5455bda..6e885c5a38a3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -25,6 +25,7 @@ struct vm_fault;
 #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
 #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
 #define IOMAP_INLINE	0x05	/* data inline in the inode */
+#define IOMAP_DAX_COW	0x06	/* Copy data pointed by inline_data before write*/
 
 /*
  * Flags for all iomap mappings:
-- 
2.16.4

