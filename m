Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141A74EF72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfFUT2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 15:28:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfFUT2o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E619AF3B;
        Fri, 21 Jun 2019 19:28:43 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/6] btrfs: Add CoW in iomap based writes
Date:   Fri, 21 Jun 2019 14:28:27 -0500
Message-Id: <20190621192828.28900-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190621192828.28900-1-rgoldwyn@suse.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set iomap->type to IOMAP_COW and fill up the source map in case
the I/O is not page aligned.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/iomap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/btrfs/iomap.c b/fs/btrfs/iomap.c
index 0435b179d461..f4133cf953b4 100644
--- a/fs/btrfs/iomap.c
+++ b/fs/btrfs/iomap.c
@@ -172,6 +172,35 @@ static int btrfs_buffered_page_prepare(struct inode *inode, loff_t pos,
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
+		iomap->addr = em->block_start + (pos - em->start);
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
@@ -196,6 +225,7 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 	int ret;
 	size_t write_bytes = length;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	size_t end;
 	size_t sector_offset = pos & (fs_info->sectorsize - 1);
 	struct btrfs_iomap *bi;
 
@@ -263,6 +293,17 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 	iomap->private = bi;
 	iomap->length = round_up(write_bytes, fs_info->sectorsize);
 	iomap->offset = round_down(pos, fs_info->sectorsize);
+	end = pos + write_bytes;
+	/* Set IOMAP_COW if start/end is not page aligned */
+	if (((pos & (PAGE_SIZE - 1)) || (end & (PAGE_SIZE - 1)))) {
+		iomap->type = IOMAP_COW;
+		ret = get_iomap(inode, pos, length, srcmap);
+		if (ret < 0)
+			goto release;
+	} else {
+		iomap->type = IOMAP_DELALLOC;
+	}
+
 	iomap->addr = IOMAP_NULL_ADDR;
 	iomap->type = IOMAP_DELALLOC;
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
-- 
2.16.4

