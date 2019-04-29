Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EDBE8D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfD2R1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728748AbfD2R1R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0828EAD0A;
        Mon, 29 Apr 2019 17:27:16 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 05/18] btrfs: return whether extent is nocow or not
Date:   Mon, 29 Apr 2019 12:26:36 -0500
Message-Id: <20190429172649.8288-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

We require this to make sure we return type IOMAP_DAX_COW in
iomap structure, in the later patches.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h | 2 +-
 fs/btrfs/inode.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7bbe5130a3b..050f30165531 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3278,7 +3278,7 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 			 struct btrfs_root *root, int *was_new);
 int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
-		struct inode *inode, u64 start, u64 len);
+		struct inode *inode, u64 start, u64 len, bool *nocow);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end, int create);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 68b8a4935ba6..8e33c38511bb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7499,12 +7499,15 @@ static int btrfs_get_blocks_direct_read(struct extent_map *em,
 int btrfs_get_extent_map_write(struct extent_map **map,
 		struct buffer_head *bh,
 		struct inode *inode,
-		u64 start, u64 len)
+		u64 start, u64 len, bool *nocow)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = *map;
 	int ret = 0;
 
+	if (nocow)
+		*nocow = false;
+
 	/*
 	 * We don't allocate a new extent in the following cases
 	 *
@@ -7553,6 +7556,8 @@ int btrfs_get_extent_map_write(struct extent_map **map,
 			 */
 			btrfs_free_reserved_data_space_noquota(inode, start,
 							       len);
+			if (nocow)
+				*nocow = true;
 			/* skip COW */
 			goto out;
 		}
@@ -7579,7 +7584,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct extent_map *em;
 
 	ret = btrfs_get_extent_map_write(map, bh_result, inode,
-			start, len);
+			start, len, NULL);
 	if (ret < 0)
 		return ret;
 	em = *map;
-- 
2.16.4

