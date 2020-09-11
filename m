Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC13265FB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgIKMku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:40:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgIKMio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827924; x=1631363924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/QS4t8efLjLqGnrAtWaM0ztrbO7bjdXvqzls+xOaDw=;
  b=RGsP37aGe+/uscIO2n94jWkfX9fRopddYG14BjUPBby0oBbw+jbDESau
   oXdl2Yehk8Jaoxi9CcoXC3Yf97nlEWjt5Stp+yqnccooUTHCB8VU4K0LV
   vxM5sAfZwjjPQ77nD4QJi4Dm0MHOTtyYb7LMML+P1JqTxa6Roat+46vAP
   SMUIztq6O60V3k/lIroDBZjn5GFmi0W0VHsqJDwd1DdDDXSxau4C4VoA2
   aBzE83PcqYng9CuiQp/ilaAhcpZFbtF/w9/faZ9FtWm12osrXM0aLkhZh
   2bRIGbFdr5Rdhz0snhPqUx2sqtMOhQJxdfLLeClJlt21gDFTRpr78f+7A
   A==;
IronPort-SDR: L71X0zifjZB43zZK9l6B0MsnArpfPyCDvzoXf+nyCp1tUgnUG1GOhlvmIjggU94PcQuC/wAW7R
 g4XSZjybJbpTExneqmnbML3N8ee5EGmZcVjnzBh9UXViY/QOsBrlEYgU9EE+yQCmGdoSCmVSDN
 b5zST8D2NpjomUEDxsa1Rosna8mZn1Ktax+63x6pGJhZi3nbWQ4imjGQRlE2Ds9LmpK+io7tXW
 7cbt8RmRKcXeKoneRdfAwEqVtFqNHRoy8ciIenpNo16JDfU8WofdGSxkjPezC7xgo6aK4oKpsL
 Pkk=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126016"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:45 +0800
IronPort-SDR: I4qblLv6PX7xCjkLUsOSn3YqugBWWBWW+vXvnxoi+NmwXE+LhdvjcGpLPLBo25yvdfnUtBQqOE
 WUoYzKJ6Q67g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:06 -0700
IronPort-SDR: HfTgHcq0r6g9Jh5SRWE6CsOtUmgbkdvo1gSoSk9sAkmnf7BdrAYzxWnIGDqDZW01MFNo1q52zn
 59l7zw538QCA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 26/39] btrfs: serialize meta IOs on ZONED mode
Date:   Fri, 11 Sep 2020 21:32:46 +0900
Message-Id: <20200911123259.3782926-27-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot use zone append writing for metadata, because the B-tree nodes
have references to each other using the logical address. Without knowing
the address in advance, we cannot construct the tree in the first place.
Thus, we need to serialize write IOs for metadata.

We cannot add mutex around allocation and submit because metadata blocks
are allocated in an earlier stage to build up B-trees.

Thus, this commit add zoned_meta_io_lock and hold it during metadata IO
submission in btree_write_cache_pages() to serialize IOs. Furthermore, this
commit add per-block group metadata IO submission pointer
"meta_write_pointer" to ensure sequential writing, which can be caused when
writing back blocks in a not finished transaction.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent_io.c   | 27 ++++++++++++++++++++++-
 fs/btrfs/zoned.c       | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 31 ++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 401e9bcefaec..b2a8a3beceac 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -190,6 +190,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 zone_unusable;
+	u64 meta_write_pointer;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 54c22ad0d633..e08fe341cd81 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -941,6 +941,8 @@ struct btrfs_fs_info {
 	 */
 	int send_in_progress;
 
+	struct mutex zoned_meta_io_lock;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d766cb0e1a52..a50436d89d30 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2732,6 +2732,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
+	mutex_init(&fs_info->zoned_meta_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 00a07cefffeb..b660921af935 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -3986,6 +3987,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb, *prev_eb = NULL;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.extent_locked = 0,
@@ -4020,6 +4022,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4062,12 +4065,30 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (!ret)
 				continue;
 
+			if (!btrfs_check_meta_write_pointer(fs_info, eb,
+							    &cache)) {
+				/*
+				 * If for_sync, this hole will be filled with
+				 * trasnsaction commit.
+				 */
+				if (wbc->sync_mode == WB_SYNC_ALL &&
+				    !wbc->for_sync)
+					ret = -EAGAIN;
+				else
+					ret = 0;
+				done = 1;
+				free_extent_buffer(eb);
+				break;
+			}
+
 			prev_eb = eb;
 			ret = lock_extent_buffer_for_io(eb, &epd);
 			if (!ret) {
+				btrfs_revert_meta_write_pointer(cache, eb);
 				free_extent_buffer(eb);
 				continue;
 			} else if (ret < 0) {
+				btrfs_revert_meta_write_pointer(cache, eb);
 				done = 1;
 				free_extent_buffer(eb);
 				break;
@@ -4100,10 +4121,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
+	if (cache)
+		btrfs_put_block_group(cache);
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
@@ -4138,6 +4161,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1744e2649087..0f790f3a54e5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1002,6 +1002,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1135,3 +1138,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	kfree(logical);
 	bdput(bdev);
 }
+
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret)
+{
+	struct btrfs_block_group *cache;
+
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return true;
+
+	cache = *cache_ret;
+
+	if (cache && (eb->start < cache->start ||
+		      cache->start + cache->length <= eb->start)) {
+		btrfs_put_block_group(cache);
+		cache = NULL;
+		*cache_ret = NULL;
+	}
+
+	if (!cache)
+		cache = btrfs_lookup_block_group(fs_info, eb->start);
+
+	if (cache) {
+		*cache_ret = cache;
+
+		if (cache->meta_write_pointer != eb->start) {
+			btrfs_put_block_group(cache);
+			cache = NULL;
+			*cache_ret = NULL;
+			return false;
+		}
+
+		cache->meta_write_pointer = eb->start + eb->len;
+	}
+
+	return true;
+}
+
+void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				     struct extent_buffer *eb)
+{
+	if (!btrfs_fs_incompat(eb->fs_info, ZONED) || !cache)
+		return;
+
+	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
+	cache->meta_write_pointer = eb->start;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5f4bc746e3e2..5d4b132a4d95 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -53,6 +53,11 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
 				 struct bio *bio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret);
+void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				     struct extent_buffer *eb);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -130,6 +135,18 @@ static inline void btrfs_record_physical_zoned(struct inode *inode,
 }
 static inline void
 btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered) { }
+static inline bool
+btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+			       struct extent_buffer *eb,
+			       struct btrfs_block_group **cache_ret)
+{
+	return true;
+}
+static inline void
+btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				struct extent_buffer *eb)
+{
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -232,4 +249,18 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 	return true;
 }
 
+static inline void btrfs_zoned_meta_io_lock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return;
+	mutex_lock(&fs_info->zoned_meta_io_lock);
+}
+
+static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return;
+	mutex_unlock(&fs_info->zoned_meta_io_lock);
+}
+
 #endif
-- 
2.27.0

