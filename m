Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF938B29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfFGNLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfFGNLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913100; x=1591449100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GoYf30WTHw0II9b6V5i/U/orUf2sypkPcyGouNXga/M=;
  b=J5w+muKCneSXYiNgbLo5K0mXvRO38wZslXJefdgK4Vyak+raEWv2/nKM
   yUpu+1uXjcPT9U7fx3n2YRZDwk7/9by1QFDSv9cEotNXLpkuB9HtPVw1u
   ut9c8MuDE/l/cHl1hbPkslUjIUVOgsPl882ROcZjCTbhjpMHWW6hao+8L
   iOmWaHkJFzokEIjtvVgmog7ZnwuEqfJp7RGZqwI49vg5hSE6NfLWTRVYN
   zwPw0PlbXVMuxTI+8GM/7i1Han1qkhm06pUd8KAUFIobGsStNFcCe7+OY
   BR+fZWkI5GgJ/QLWVJMsgEznNwbQkAKn1j1AdvvfYryz1+9WaV+g48W5k
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027817"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:40 +0800
IronPort-SDR: kwjn0jBdY6713oYsphFrj2W0PGXjEuFiqVihz86QsXjU+w57Ja8wv84IRL6jdvcShUucpi1BgO
 ILupTMGWqVqXxHKRqXyaKTLTMTLySkUcZ/NHtOARuf3FrtdaLafXcEgHA8WHfpIL4DSkDQmbES
 jcBiHcPi/0CzxPx/CYKKAZtBZUAKsFco7siO8jyWOM1mYpXJsKhqpZgwNYVxtvL3TMZIlKuWtv
 X8hsKvMFERKWUwZkexa6qc81niP/JL5LqpUuq87Ae6aFloQqEUkznPNLoPlRajOxn+10870ae6
 m/Ae8Ig+OOCrEy971r674LH2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:57 -0700
IronPort-SDR: a9N/SVvEpntRkOI1lh60+JeGY+0UjvJLraoXISMbOe7ZnKGftLjFqju7tPgPZcWWC8qBi9O90f
 RCvhebZ9KTXVYmfrcgkrw80BF7nCrjEbxwBL3Bq35qfh4siviPv8ADHfeOzE5GjW8ADpjp8pCD
 dy1iP4z+ix/8gW42wfFngRUdEqwvtNFv8anvh7oHKu2RFKamP3yPbd8crVnyUUgjbbErSermHc
 gU0usiOQdm8Ri/eBf3UmVjA+ZoRT8OC1W22KmbNyYRTYjl0rQSgCkscBczniIux3k+Xjnc4kPa
 FfI=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/19] btrfs: expire submit buffer on timeout
Date:   Fri,  7 Jun 2019 22:10:18 +0900
Message-Id: <20190607131025.31996-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible to have bios stalled in the submit buffer due to some bug or
device problem. In such situation, btrfs stops working waiting for buffered
bios completions. To avoid such hang, add a worker that will cancel the
stalled bios after a timeout.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h             |  13 ++++
 fs/btrfs/disk-io.c           |   2 +
 fs/btrfs/extent-tree.c       |  16 +++-
 fs/btrfs/super.c             |  18 +++++
 fs/btrfs/volumes.c           | 146 ++++++++++++++++++++++++++++++++++-
 include/trace/events/btrfs.h |   2 +
 6 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ade6d8243962..dad8ea5c3b99 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -596,6 +596,8 @@ enum btrfs_alloc_type {
 	BTRFS_ALLOC_SEQ		= 1,
 };
 
+struct expire_work;
+
 struct btrfs_block_group_cache {
 	struct btrfs_key key;
 	struct btrfs_block_group_item item;
@@ -721,6 +723,14 @@ struct btrfs_block_group_cache {
 	struct mutex submit_lock;
 	u64 submit_offset;
 	struct bio_list submit_buffer;
+	struct expire_work *expire_work;
+	int expired:1;
+};
+
+struct expire_work {
+	struct list_head list;
+	struct delayed_work work;
+	struct btrfs_block_group_cache *block_group;
 };
 
 /* delayed seq elem */
@@ -1194,6 +1204,9 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+	struct list_head expire_work_list;
+	struct mutex expire_work_lock;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ddbb02906042..56a416902ce7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2717,6 +2717,8 @@ int open_ctree(struct super_block *sb,
 	INIT_RADIX_TREE(&fs_info->reada_tree, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	spin_lock_init(&fs_info->reada_lock);
 	btrfs_init_ref_verify(fs_info);
+	INIT_LIST_HEAD(&fs_info->expire_work_list);
+	mutex_init(&fs_info->expire_work_lock);
 
 	fs_info->thread_pool_size = min_t(unsigned long,
 					  num_online_cpus() + 2, 8);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ebdc7a6dbe01..cb29a96c226b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -125,6 +125,7 @@ void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
 		WARN_ON(!bio_list_empty(&cache->submit_buffer));
+		WARN_ON(cache->expire_work);
 
 		/*
 		 * If not empty, someone is still holding mutex of
@@ -10180,6 +10181,13 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		    block_group->cached == BTRFS_CACHE_ERROR)
 			free_excluded_extents(block_group);
 
+		if (block_group->alloc_type == BTRFS_ALLOC_SEQ) {
+			mutex_lock(&block_group->submit_lock);
+			WARN_ON(!bio_list_empty(&block_group->submit_buffer));
+			WARN_ON(block_group->expire_work != NULL);
+			mutex_unlock(&block_group->submit_lock);
+		}
+
 		btrfs_remove_free_space_cache(block_group);
 		ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
 		ASSERT(list_empty(&block_group->dirty_list));
@@ -10513,6 +10521,7 @@ btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cache)
 	}
 
 	cache->submit_offset = logical + cache->alloc_offset;
+	cache->expired = 0;
 
 out:
 	cache->alloc_type = alloc_type;
@@ -10565,6 +10574,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
 	cache->alloc_type = BTRFS_ALLOC_FIT;
 	cache->alloc_offset = 0;
+	cache->expire_work = NULL;
 
 	if (btrfs_fs_incompat(fs_info, HMZONED)) {
 		ret = btrfs_get_block_group_alloc_offset(cache);
@@ -11329,11 +11339,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
+		mutex_lock(&block_group->submit_lock);
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->pinned ||
 		    btrfs_block_group_used(&block_group->item) ||
 		    block_group->ro ||
-		    list_is_singular(&block_group->list)) {
+		    list_is_singular(&block_group->list) ||
+		    !bio_list_empty(&block_group->submit_buffer)) {
 			/*
 			 * We want to bail if we made new allocations or have
 			 * outstanding allocations in this block group.  We do
@@ -11342,10 +11354,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			 */
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
+			mutex_unlock(&block_group->submit_lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
 		spin_unlock(&block_group->lock);
+		mutex_unlock(&block_group->submit_lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
 		ret = inc_block_group_ro(block_group, 0);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 740a701f16c5..343c26537999 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -154,6 +154,24 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * completes. The next time when the filesystem is mounted writable
 	 * again, the device replace operation continues.
 	 */
+
+	/* expire pending bios in submit buffer */
+	if (btrfs_fs_incompat(fs_info, HMZONED)) {
+		struct expire_work *work;
+		struct btrfs_block_group_cache *block_group;
+
+		mutex_lock(&fs_info->expire_work_lock);
+		list_for_each_entry(work, &fs_info->expire_work_list, list) {
+			block_group = work->block_group;
+			mutex_lock(&block_group->submit_lock);
+			if (block_group->expire_work)
+				mod_delayed_work(
+					system_unbound_wq,
+					&block_group->expire_work->work, 0);
+			mutex_unlock(&block_group->submit_lock);
+		};
+		mutex_unlock(&fs_info->expire_work_lock);
+	}
 }
 
 #ifdef CONFIG_PRINTK
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 26a64a53032f..a04379e440fb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6840,6 +6840,124 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 	}
 }
 
+static void expire_bios_fn(struct work_struct *work)
+{
+	struct expire_work *ework;
+	struct btrfs_block_group_cache *cache;
+	struct bio *bio, *next;
+
+	ework = container_of(work, struct expire_work, work.work);
+	cache = ework->block_group;
+
+	mutex_lock(&cache->fs_info->expire_work_lock);
+	mutex_lock(&cache->submit_lock);
+	list_del(&cache->expire_work->list);
+
+	if (btrfs_fs_closing(cache->fs_info)) {
+		WARN_ON(!bio_list_empty(&cache->submit_buffer));
+		goto end;
+	}
+
+	if (bio_list_empty(&cache->submit_buffer))
+		goto end;
+
+	bio = bio_list_get(&cache->submit_buffer);
+	cache->expired = 1;
+	mutex_unlock(&cache->submit_lock);
+
+	btrfs_handle_fs_error(cache->fs_info, -EIO,
+			      "bio submit buffer expired");
+	btrfs_err(cache->fs_info, "block group %llu submit pos %llu",
+		  cache->key.objectid, cache->submit_offset);
+
+	while (bio) {
+		struct map_bio_data *map_private =
+			(struct map_bio_data *)bio->bi_private;
+
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+		bio->bi_private = map_private->orig_bi_private;
+		kfree(map_private);
+
+		trace_btrfs_expire_bio(cache, bio);
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+
+		bio = next;
+	}
+
+end:
+	kfree(cache->expire_work);
+	cache->expire_work = NULL;
+	mutex_unlock(&cache->submit_lock);
+	mutex_unlock(&cache->fs_info->expire_work_lock);
+	btrfs_put_block_group(cache);
+}
+
+static int schedule_expire_work(struct btrfs_block_group_cache *cache)
+{
+	const unsigned long delay = 90 * HZ;
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct expire_work *work;
+	int ret = 0;
+
+	mutex_lock(&fs_info->expire_work_lock);
+	mutex_lock(&cache->submit_lock);
+	if (cache->expire_work) {
+		mod_delayed_work(system_unbound_wq, &cache->expire_work->work,
+				 delay);
+		goto end;
+	}
+
+	work = kmalloc(sizeof(*work), GFP_NOFS);
+	if (!work) {
+		ret = -ENOMEM;
+		goto end;
+	}
+	work->block_group = cache;
+	INIT_LIST_HEAD(&work->list);
+	INIT_DELAYED_WORK(&work->work, expire_bios_fn);
+	cache->expire_work = work;
+
+	list_add(&work->list, &fs_info->expire_work_list);
+	btrfs_get_block_group(cache);
+	mod_delayed_work(system_unbound_wq, &cache->expire_work->work, delay);
+
+end:
+	mutex_unlock(&cache->submit_lock);
+	mutex_unlock(&cache->fs_info->expire_work_lock);
+	return ret;
+}
+
+static bool cancel_expire_work(struct btrfs_block_group_cache *cache)
+{
+	struct expire_work *work;
+	bool ret = true;
+
+	mutex_lock(&cache->fs_info->expire_work_lock);
+	mutex_lock(&cache->submit_lock);
+	work = cache->expire_work;
+	if (!work)
+		goto end;
+	cache->expire_work = NULL;
+
+	ret = cancel_delayed_work(&work->work);
+	/*
+	 * if cancel failed, expire_work is freed by the
+	 * expire worker thread
+	 */
+	if (!ret)
+		goto end;
+
+	list_del(&work->list);
+	kfree(work);
+	btrfs_put_block_group(cache);
+
+end:
+	mutex_unlock(&cache->submit_lock);
+	mutex_unlock(&cache->fs_info->expire_work_lock);
+	return ret;
+}
 
 static blk_status_t __btrfs_map_bio(struct btrfs_fs_info *fs_info,
 				    struct bio *bio, int mirror_num,
@@ -6931,7 +7049,9 @@ static blk_status_t __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group_cache *cache = NULL;
 	struct map_bio_data *map_private;
 	int sent;
+	bool should_queue;
 	blk_status_t ret;
+	int ret2;
 
 	WARN_ON(bio_op(cur_bio) != REQ_OP_WRITE);
 
@@ -6944,8 +7064,20 @@ static blk_status_t __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info,
 	}
 
 	mutex_lock(&cache->submit_lock);
-	if (cache->submit_offset == logical)
+
+	if (cache->expired) {
+		trace_btrfs_bio_in_expired_block_group(cache, cur_bio);
+		mutex_unlock(&cache->submit_lock);
+		btrfs_put_block_group(cache);
+		WARN_ON_ONCE(1);
+		return BLK_STS_IOERR;
+	}
+
+	if (cache->submit_offset == logical) {
+		mutex_unlock(&cache->submit_lock);
+		cancel_expire_work(cache);
 		goto send_bios;
+	}
 
 	if (cache->submit_offset > logical) {
 		trace_btrfs_bio_before_write_pointer(cache, cur_bio);
@@ -6968,13 +7100,18 @@ static blk_status_t __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info,
 
 	bio_list_add(&cache->submit_buffer, cur_bio);
 	mutex_unlock(&cache->submit_lock);
+
+	ret2 = schedule_expire_work(cache);
+	if (ret2) {
+		btrfs_put_block_group(cache);
+		return errno_to_blk_status(ret2);
+	}
 	btrfs_put_block_group(cache);
 
 	/* mimic a good result ... */
 	return BLK_STS_OK;
 
 send_bios:
-	mutex_unlock(&cache->submit_lock);
 	/* send this bio */
 	ret = __btrfs_map_bio(fs_info, cur_bio, mirror_num, 1, 1);
 	if (ret != BLK_STS_OK) {
@@ -7013,6 +7150,7 @@ static blk_status_t __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info,
 			bio = next;
 		}
 	} while (sent);
+	should_queue = !bio_list_empty(&cache->submit_buffer);
 	mutex_unlock(&cache->submit_lock);
 
 	/* send the collected bios */
@@ -7031,8 +7169,10 @@ static blk_status_t __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info,
 
 	if (length)
 		goto loop;
-	btrfs_put_block_group(cache);
 
+	if (should_queue)
+		WARN_ON(schedule_expire_work(cache));
+	btrfs_put_block_group(cache);
 	return BLK_STS_OK;
 }
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 2b4cd791bf24..0ffb0b330b6c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2131,6 +2131,8 @@ DEFINE_EVENT(btrfs_hmzoned_bio_buffer_events, name,			\
 )
 
 DEFINE_BTRFS_HMZONED_BIO_BUF_EVENT(btrfs_bio_before_write_pointer);
+DEFINE_BTRFS_HMZONED_BIO_BUF_EVENT(btrfs_expire_bio);
+DEFINE_BTRFS_HMZONED_BIO_BUF_EVENT(btrfs_bio_in_expired_block_group);
 
 #endif /* _TRACE_BTRFS_H */
 
-- 
2.21.0

