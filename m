Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943A1E8E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfD2R1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728928AbfD2R1U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11C81ACFB;
        Mon, 29 Apr 2019 17:27:18 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 06/18] btrfs: Rename __endio_write_update_ordered() to btrfs_update_ordered_extent()
Date:   Mon, 29 Apr 2019 12:26:37 -0500
Message-Id: <20190429172649.8288-7-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
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
index 050f30165531..1e3e758b83c2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3280,8 +3280,11 @@ struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
 		struct inode *inode, u64 start, u64 len, bool *nocow);
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
index 8e33c38511bb..af4b56cba104 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -98,10 +98,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
-static void __endio_write_update_ordered(struct inode *inode,
-					 const u64 offset, const u64 bytes,
-					 const bool uptodate);
-
 /*
  * Cleanup all submitted ordered extents in specified range to handle errors
  * from the btrfs_run_delalloc_range() callback.
@@ -142,7 +138,7 @@ static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
 		bytes -= PAGE_SIZE;
 	}
 
-	return __endio_write_update_ordered(inode, offset, bytes, false);
+	return btrfs_update_ordered_extent(inode, offset, bytes, false);
 }
 
 static int btrfs_dirty_inode(struct inode *inode);
@@ -8085,7 +8081,7 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	bio_put(bio);
 }
 
-static void __endio_write_update_ordered(struct inode *inode,
+void btrfs_update_ordered_extent(struct inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
 {
@@ -8138,7 +8134,7 @@ static void btrfs_endio_direct_write(struct bio *bio)
 	struct btrfs_dio_private *dip = bio->bi_private;
 	struct bio *dio_bio = dip->dio_bio;
 
-	__endio_write_update_ordered(dip->inode, dip->logical_offset,
+	btrfs_update_ordered_extent(dip->inode, dip->logical_offset,
 				     dip->bytes, !bio->bi_status);
 
 	kfree(dip);
@@ -8457,7 +8453,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		bio = NULL;
 	} else {
 		if (write)
-			__endio_write_update_ordered(inode,
+			btrfs_update_ordered_extent(inode,
 						file_offset,
 						dio_bio->bi_iter.bi_size,
 						false);
@@ -8597,7 +8593,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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

