Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193F0E8D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfD2R1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728748AbfD2R1L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9A26AD5D;
        Mon, 29 Apr 2019 17:27:09 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 02/18] btrfs: Carve out btrfs_get_extent_map_write() out of btrfs_get_blocks_write()
Date:   Mon, 29 Apr 2019 12:26:33 -0500
Message-Id: <20190429172649.8288-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This makes btrfs_get_extent_map_write() independent of Direct
I/O code.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/inode.c | 40 +++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8ca1c0d120f4..9512f49262dd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3277,6 +3277,8 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 			      struct btrfs_path *path);
 struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 			 struct btrfs_root *root, int *was_new);
+int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
+		struct inode *inode, u64 start, u64 len);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end, int create);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 82fdda8ff5ab..68b8a4935ba6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7496,11 +7496,10 @@ static int btrfs_get_blocks_direct_read(struct extent_map *em,
 	return 0;
 }
 
-static int btrfs_get_blocks_direct_write(struct extent_map **map,
-					 struct buffer_head *bh_result,
-					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
-					 u64 start, u64 len)
+int btrfs_get_extent_map_write(struct extent_map **map,
+		struct buffer_head *bh,
+		struct inode *inode,
+		u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = *map;
@@ -7554,22 +7553,38 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			 */
 			btrfs_free_reserved_data_space_noquota(inode, start,
 							       len);
-			goto skip_cow;
+			/* skip COW */
+			goto out;
 		}
 	}
 
 	/* this will cow the extent */
-	len = bh_result->b_size;
+	if (bh)
+		len = bh->b_size;
 	free_extent_map(em);
 	*map = em = btrfs_new_extent_direct(inode, start, len);
-	if (IS_ERR(em)) {
-		ret = PTR_ERR(em);
-		goto out;
-	}
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+out:
+	return ret;
+}
 
+static int btrfs_get_blocks_direct_write(struct extent_map **map,
+					 struct buffer_head *bh_result,
+					 struct inode *inode,
+					 struct btrfs_dio_data *dio_data,
+					 u64 start, u64 len)
+{
+	int ret;
+	struct extent_map *em;
+
+	ret = btrfs_get_extent_map_write(map, bh_result, inode,
+			start, len);
+	if (ret < 0)
+		return ret;
+	em = *map;
 	len = min(len, em->len - (start - em->start));
 
-skip_cow:
 	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
 		inode->i_blkbits;
 	bh_result->b_size = len;
@@ -7590,7 +7605,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	dio_data->reserve -= len;
 	dio_data->unsubmitted_oe_range_end = start + len;
 	current->journal_info = dio_data;
-out:
 	return ret;
 }
 
-- 
2.16.4

