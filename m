Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E65266769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgIKRmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38375 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIKMgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827798; x=1631363798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZVFdRqawtuE2G8GiC+tGGO9id34TaO6eSKQ2BgJ2fw=;
  b=PVwptQx7pwexGTQPyZVTGUdzeQsqxg9U8bZe+MmGJHc3AbYIFw15c/Al
   2xXzjAzY1WAir/bKcIhVVXIuTVV5sc+fCFM1Q6Fvs0ke2UNpDp9MzhWEJ
   wCSUjBdvf7ZBzVV2GeyHZtsCuyZ1+8KDIn1ci45pEceOLU2SrakUhN0Ce
   8st+bP5g/xMiLsNVbHB8ziqVp2t699KsqjbFnX89AFHw47CfLxSK6M4rh
   xdR70YXP5nW8rOdtq+EkzUilrF6KcK56vsxEvArWl+d8tQcpyg+yFct9p
   LRQDHczflTR0j7UOmuZ4twBHVewavsYxC/Jpb/JTAvnVbnoyI4NdOlR2v
   Q==;
IronPort-SDR: QvuAZ2D8huPpkQ3fi6FtoSenbI2VXE8Y/trfukIFnAN6CRkRFw/6QGDqkSc4LI1ywRvsZ2zKTT
 cOBAUIB0op724sfOZYTjpRqfhdNElwHjWN0FDdGi/W+Q9OXLYbEMJCn1iDqeaoTM9WrLYquhJr
 Ecmp+kn3Ffx9V58EwGz/ibjOGANSP7et3oW/g/wUGTQmzt/SwZL7oF9U0YZQy319Y67KEmFFPN
 eSB6EjLHXXr3uY1n39kcjdz135QHlLjTEm78cpx47uR+2Yni3xX7Mxincax+k6SzFMeVwbjmVT
 Cds=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125995"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:34 +0800
IronPort-SDR: TZGftri9jj/dXQfdc7zJZVTK8V4y7EOyRMnwB4eQIFOkROj3XseEJsm0SJbaXyf8p/INd8ycV2
 htJFgUwIXjLg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:55 -0700
IronPort-SDR: hKt/lV44sZPVg5qDKGQ1azEa1FIc6jz/LiYf7iysr3py6yStfBqarqRCW9eZhZzqX09rz2V34J
 Bos1RSrTXlCw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 18/39] btrfs: redirty released extent buffers in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:38 +0900
Message-Id: <20200911123259.3782926-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On ZONED volumes, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch introduces a list of clean and unwritten extent buffers that
have been released in a transaction. Btrfs redirty the buffer so that
btree_write_cache_pages() can send proper bios to the devices.

Besides it clears the entire content of the extent buffer not to confuse
raw block scanners e.g. btrfsck. By clearing the content,
csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     |  8 ++++++++
 fs/btrfs/extent-tree.c | 12 +++++++++++-
 fs/btrfs/extent_io.c   |  3 +++
 fs/btrfs/extent_io.h   |  2 ++
 fs/btrfs/transaction.c | 10 ++++++++++
 fs/btrfs/transaction.h |  3 +++
 fs/btrfs/tree-log.c    |  6 ++++++
 fs/btrfs/zoned.c       | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 9 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 362799403285..d766cb0e1a52 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -510,6 +510,12 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 		return 0;
 
 	found_start = btrfs_header_bytenr(eb);
+
+	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
+		WARN_ON(found_start != 0);
+		return 0;
+	}
+
 	/*
 	 * Please do not consolidate these warnings into a single if.
 	 * It is useful to know what went wrong.
@@ -4689,6 +4695,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
+	btrfs_free_redirty_list(cur_trans);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7fe5b6e3b207..81b9b58d7a9d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3271,8 +3271,10 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret)
+			if (!ret) {
+				btrfs_redirty_list_add(trans->transaction, buf);
 				goto out;
+			}
 		}
 
 		pin = 0;
@@ -3284,6 +3286,13 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
+		if (btrfs_fs_incompat(fs_info, ZONED)) {
+			btrfs_redirty_list_add(trans->transaction, buf);
+			pin_down_extent(trans, cache, buf->start, buf->len, 1);
+			btrfs_put_block_group(cache);
+			goto out;
+		}
+
 		WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
 
 		btrfs_add_free_space(cache, buf->start, buf->len);
@@ -4615,6 +4624,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_tree_lock(buf);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
+	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
 	btrfs_set_lock_blocking_write(buf);
 	set_extent_buffer_uptodate(buf);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c15ab6c1897f..53bac37bc4ac 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -24,6 +24,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "zoned.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4994,6 +4995,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 
 	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
 			     &fs_info->allocated_ebs);
+	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
@@ -5756,6 +5758,7 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
 
 	offset = offset_in_page(start);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 30794ae58498..29dbb21a5c9a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -30,6 +30,7 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
+	EXTENT_BUFFER_NO_CHECK,
 };
 
 /* these are flags for __process_pages_contig */
@@ -119,6 +120,7 @@ struct extent_buffer {
 	 */
 	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	int spinning_writers;
 	atomic_t spinning_readers;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 951b10364fd0..1414b3ade2db 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -22,6 +22,7 @@
 #include "qgroup.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -334,6 +335,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
+	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
+	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
@@ -2334,6 +2337,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto scrub_continue;
 	}
 
+	/*
+	 * At this point, we should have written the all tree blocks
+	 * allocated in this transaction. So it's now safe to free the
+	 * redirtyied extent buffers.
+	 */
+	btrfs_free_redirty_list(cur_trans);
+
 	ret = write_all_supers(fs_info, 0);
 	/*
 	 * the super is written, we can safely allow the tree-loggers
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index d60b055b8695..d274b6d9798c 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -85,6 +85,9 @@ struct btrfs_transaction {
 	spinlock_t dropped_roots_lock;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct btrfs_fs_info *fs_info;
+
+	spinlock_t releasing_ebs_lock;
+	struct list_head releasing_ebs;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 39da9db35278..4b6a68a81eac 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -20,6 +20,7 @@
 #include "inode-map.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -2746,6 +2747,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 						free_extent_buffer(next);
 						return ret;
 					}
+					btrfs_redirty_list_add(
+						trans->transaction, next);
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
@@ -3281,6 +3284,9 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	extent_io_tree_release(&log->log_csum_range);
+
+	if (trans && log->node)
+		btrfs_redirty_list_add(trans->transaction, log->node);
 	btrfs_put_root(log);
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 68f8224d74c3..855acbc61d47 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -18,6 +18,7 @@
 #include "rcu-string.h"
 #include "disk-io.h"
 #include "block-group.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1028,3 +1029,39 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 	 */
 	btrfs_free_excluded_extents(cache);
 }
+
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+
+	if (!btrfs_fs_incompat(fs_info, ZONED) ||
+	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN) ||
+	    !list_empty(&eb->release_list))
+		return;
+
+	set_extent_buffer_dirty(eb);
+	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
+			       eb->start + eb->len - 1, EXTENT_DIRTY);
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
+
+	spin_lock(&trans->releasing_ebs_lock);
+	list_add_tail(&eb->release_list, &trans->releasing_ebs);
+	spin_unlock(&trans->releasing_ebs_lock);
+	atomic_inc(&eb->refs);
+}
+
+void btrfs_free_redirty_list(struct btrfs_transaction *trans)
+{
+	spin_lock(&trans->releasing_ebs_lock);
+	while (!list_empty(&trans->releasing_ebs)) {
+		struct extent_buffer *eb;
+
+		eb = list_first_entry(&trans->releasing_ebs,
+				      struct extent_buffer, release_list);
+		list_del_init(&eb->release_list);
+		free_extent_buffer(eb);
+	}
+	spin_unlock(&trans->releasing_ebs_lock);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index ccfb63a455dc..cdb84c758a61 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -47,6 +47,9 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb);
+void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -115,6 +118,9 @@ static inline int btrfs_load_block_group_zone_info(
 	return 0;
 }
 static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
+static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+					  struct extent_buffer *eb) { }
+static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

