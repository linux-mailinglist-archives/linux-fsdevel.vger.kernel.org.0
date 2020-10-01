Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B02806F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbgJASjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24722 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733106AbgJASjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577548; x=1633113548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AoO3xZRWnSdnCylQAmdUKrRADOJvnmHa8U78NBbPy3Q=;
  b=jMOAjghyf8VQhX5rv9+l2GiOsRKB55pCcJ0iycOYRUkr/pqPdYG6STpK
   nJ0fkavvAWA3kfrheHtCErBwM5BtOs0TQXrTR2ug0uE4Bd0626xHlrdSk
   lC65A2pr26hsT75/3m9GEFjHKTa2ecOfJOVmXKYd5tZefWY+yM4EozH0G
   NL/VPml+TYu1WNE2ioW/MESo0ODicXyPgbPdLjpAni3mn3StnxuENyDi+
   EtNgojOV905XfjztcyPk873cGDk/j2cStbeuDxYxWpMrO+FqkfKggHlIU
   IvO8hO4/8Uih0bNLpnx2WOlkIcPlplIQHzB5jVHYWwwtElfbNLrM/dbXO
   A==;
IronPort-SDR: r2fhwohEKGv1uQzQpDQBjUBijgYOcgWvUqRAMZaGVsN0hWx4BdiTjSdSLMEgl8/dAq67dv2on6
 0b1dCxdi4IQdseToKYsNHfiSKJhyni77Zhz0fh5pbO1HpoFAr7CTrdpo/K3aVL4W/C21ICVsap
 +x4rtSIDjU72ZPR0jjBDHsB1KiTf42af9o99ualk4JbiWS3QfS7WV0cZSzVwTGPAvORMk/7rcN
 FfWcWbjRDOyMZpy1j1mUSw+VwKpV47PO34H4U/1L28efm+FJ+u2BDhqWfZ052VLkdKXxRu2tWN
 itg=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036844"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:45 +0800
IronPort-SDR: /KN4EDoHedYFZfsRoZl0A2N4LC45fWN0Xl9gs4KkMFUZq7t/ShfOoSgW/5q4sFUN563muRDqLe
 NmYkDvNG09ZQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:41 -0700
IronPort-SDR: W9G3l2HZ23hI46uJSE9pqyCqNqiFbhvQOlPd+QyyYuRJc9dWaOw+OcjWYUqRLsRmL7uFyHSHI0
 3NFOPLZK6EBg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:44 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 37/41] btrfs: split alloc_log_tree()
Date:   Fri,  2 Oct 2020 03:36:44 +0900
Message-Id: <82d118bccd4a795dc9c64a2fe74032d3ae43dba6.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation for the next patch. This commit split
alloc_log_tree() to allocating tree structure part (remains in
alloc_log_tree()) and allocating tree node part (moved in
btrfs_alloc_log_tree_node()). The latter part is also exported to be used
in the next patch.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 27 ++++++++++++++++++++++++---
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ce5b18f9dc4..02b1f9b20bed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1211,7 +1211,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct extent_buffer *leaf;
 
 	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
 	if (!root)
@@ -1221,6 +1220,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
 
+	return root;
+}
+
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root)
+{
+	struct extent_buffer *leaf;
+
 	/*
 	 * DON'T set SHAREABLE bit for log trees.
 	 *
@@ -1235,24 +1242,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		btrfs_put_root(root);
-		return ERR_CAST(leaf);
+		return PTR_ERR(leaf);
 	}
 
 	root->node = leaf;
 
 	btrfs_mark_buffer_dirty(root->node);
 	btrfs_tree_unlock(root->node);
-	return root;
+
+	return 0;
 }
 
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
@@ -1264,11 +1278,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *log_root;
 	struct btrfs_inode_item *inode_item;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
+
 	log_root->last_trans = trans->transid;
 	log_root->root_key.offset = root->root_key.objectid;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index fee69ced58b4..b82ae3711c42 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -115,6 +115,8 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info);
 int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
-- 
2.27.0

