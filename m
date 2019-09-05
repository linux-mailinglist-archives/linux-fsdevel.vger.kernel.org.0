Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830EAAA6D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbfIEPHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390255AbfIEPHG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:07:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44F68B114;
        Thu,  5 Sep 2019 15:07:05 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 05/15] btrfs: Add CoW in iomap based writes
Date:   Thu,  5 Sep 2019 10:06:40 -0500
Message-Id: <20190905150650.21089-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190905150650.21089-1-rgoldwyn@suse.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set iomap->flags to IOMAP_F_COW and fill up the source map in case
the I/O is not page aligned.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/iomap.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/iomap.c b/fs/btrfs/iomap.c
index 025ccbf471bf..f8fa34105838 100644
--- a/fs/btrfs/iomap.c
+++ b/fs/btrfs/iomap.c
@@ -165,6 +165,35 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 	return 0;
 }
 
+/*
+ * get_iomap: Get the block map and fill the iomap structure
+ * @pos: file position
+ * @length: I/O length
+ * @iomap: The iomap structure to fill
+ */
+
+static int get_iomap(struct inode *inode, loff_t pos, loff_t length,
+		struct iomap *iomap)
+{
+	struct extent_map *em;
+	iomap->addr = IOMAP_NULL_ADDR;
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+	/* XXX Do we need to check for em->flags here? */
+	if (em->block_start == EXTENT_MAP_HOLE) {
+		iomap->type = IOMAP_HOLE;
+	} else {
+		iomap->addr = em->block_start;
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = em->start;
+	iomap->bdev = em->bdev;
+	iomap->length = em->len;
+	free_extent_map(em);
+	return 0;
+}
+
 static void btrfs_buffered_page_done(struct inode *inode, loff_t pos,
 		unsigned copied, struct page *page,
 		struct iomap *iomap)
@@ -190,6 +219,7 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 	int ret;
 	size_t write_bytes = length;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	size_t end;
 	size_t sector_offset = pos & (fs_info->sectorsize - 1);
 	struct btrfs_iomap *bi;
 
@@ -257,8 +287,18 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 	iomap->private = bi;
 	iomap->length = round_up(write_bytes, fs_info->sectorsize);
 	iomap->offset = round_down(pos, fs_info->sectorsize);
+	end = pos + write_bytes;
+	/* Set IOMAP_F_COW if start/end is not page aligned */
+	if (((pos & (PAGE_SIZE - 1)) || (end & (PAGE_SIZE - 1)))) {
+		iomap->flags = IOMAP_F_COW;
+		ret = get_iomap(inode, pos, length, srcmap);
+		if (ret < 0)
+			goto release;
+	} else {
+		iomap->type = IOMAP_DELALLOC;
+	}
+
 	iomap->addr = IOMAP_NULL_ADDR;
-	iomap->type = IOMAP_DELALLOC;
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->page_ops = &btrfs_buffered_page_ops;
 	return 0;
-- 
2.16.4

