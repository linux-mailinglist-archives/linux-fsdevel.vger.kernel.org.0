Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4EAA6E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbfIEPHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:56592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390297AbfIEPHP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCD29B647;
        Thu,  5 Sep 2019 15:07:13 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 09/15] btrfs: Carve out btrfs_get_extent_map_write() out of btrfs_get_blocks_write()
Date:   Thu,  5 Sep 2019 10:06:44 -0500
Message-Id: <20190905150650.21089-10-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190905150650.21089-1-rgoldwyn@suse.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
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
index 5ca3a365e639..c25dfd8e619b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3168,6 +3168,8 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 			      struct btrfs_path *path);
 struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 			 struct btrfs_root *root, int *was_new);
+int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
+		struct inode *inode, u64 start, u64 len);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end, int create);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 258bacefdf5f..24895793fd91 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7592,11 +7592,10 @@ static int btrfs_get_blocks_direct_read(struct extent_map *em,
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
@@ -7650,22 +7649,38 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
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
@@ -7686,7 +7701,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	dio_data->reserve -= len;
 	dio_data->unsubmitted_oe_range_end = start + len;
 	current->journal_info = dio_data;
-out:
 	return ret;
 }
 
-- 
2.16.4

