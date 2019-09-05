Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45145AA6E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbfIEPHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:07:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:56670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390297AbfIEPHS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:07:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E57CDB653;
        Thu,  5 Sep 2019 15:07:15 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 10/15] btrfs: Rename __endio_write_update_ordered() to btrfs_update_ordered_extent()
Date:   Thu,  5 Sep 2019 10:06:45 -0500
Message-Id: <20190905150650.21089-11-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190905150650.21089-1-rgoldwyn@suse.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we will be using it in another part of the code, use a
better name to declare it non-static

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  7 +++++--
 fs/btrfs/inode.c | 14 +++++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c25dfd8e619b..04c119ca229b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3171,8 +3171,11 @@ struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
 		struct inode *inode, u64 start, u64 len);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 end, int create);
+		struct page *page, size_t pg_offset,
+		u64 start, u64 end, int create);
+void btrfs_update_ordered_extent(struct inode *inode,
+		const u64 offset, const u64 bytes,
+		const bool uptodate);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct inode *inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24895793fd91..d415534ce733 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -89,10 +89,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
-static void __endio_write_update_ordered(struct inode *inode,
-					 const u64 offset, const u64 bytes,
-					 const bool uptodate);
-
 /*
  * Cleanup all submitted ordered extents in specified range to handle errors
  * from the btrfs_run_delalloc_range() callback.
@@ -133,7 +129,7 @@ static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
 		bytes -= PAGE_SIZE;
 	}
 
-	return __endio_write_update_ordered(inode, offset, bytes, false);
+	return btrfs_update_ordered_extent(inode, offset, bytes, false);
 }
 
 static int btrfs_dirty_inode(struct inode *inode);
@@ -8176,7 +8172,7 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	bio_put(bio);
 }
 
-static void __endio_write_update_ordered(struct inode *inode,
+void btrfs_update_ordered_extent(struct inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
 {
@@ -8229,7 +8225,7 @@ static void btrfs_endio_direct_write(struct bio *bio)
 	struct btrfs_dio_private *dip = bio->bi_private;
 	struct bio *dio_bio = dip->dio_bio;
 
-	__endio_write_update_ordered(dip->inode, dip->logical_offset,
+	btrfs_update_ordered_extent(dip->inode, dip->logical_offset,
 				     dip->bytes, !bio->bi_status);
 
 	kfree(dip);
@@ -8546,7 +8542,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		bio = NULL;
 	} else {
 		if (write)
-			__endio_write_update_ordered(inode,
+			btrfs_update_ordered_extent(inode,
 						file_offset,
 						dio_bio->bi_iter.bi_size,
 						false);
@@ -8686,7 +8682,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			 */
 			if (dio_data.unsubmitted_oe_range_start <
 			    dio_data.unsubmitted_oe_range_end)
-				__endio_write_update_ordered(inode,
+				btrfs_update_ordered_extent(inode,
 					dio_data.unsubmitted_oe_range_start,
 					dio_data.unsubmitted_oe_range_end -
 					dio_data.unsubmitted_oe_range_start,
-- 
2.16.4

