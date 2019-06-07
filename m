Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED2138B36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfFGNLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfFGNLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913097; x=1591449097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Md7N9CZ8khRJ1RLXgchsCXH8xFL4tXDt3hVbHgdxZsc=;
  b=B2zVem9dWUohx/XLmBWHyskoYTtKSWmaKxjA1+QUZS7gA7WSenf+5GlW
   df+i/9SlSNFDFUyf4F6e0+XqSVZVjG9Tk6kP/5SEPpNhDnwT/Gzz8F3hb
   dEEPCxzg2FuZJivA3aBcuE4eEjN1p7ljBbnE/tf3/m5qnzbZojbIr/Osd
   6cQ9H/D9TVBUw0r9HK6/jACMy+bqMtttlChCvHAWRZ9QjUTU4JdMe2LIf
   /T4xTolwIcp7ggoxwTqd0paINkZ0oByvJg6L2Hs7jo5wN/hLTqOn3I3SH
   E+5yPb6ozuk5T7ZHLNoFumbkgq/6fXlaw/t2ohP+VXiN9xXGxkvcu4mlJ
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027815"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:37 +0800
IronPort-SDR: 48V5oN7uqwjYFwpGZZTjvI3qzyWPbIPi2w4hKsMRHqE/Qsl5szBJbAOpTg22kFxyyP9tycrOdX
 2PHuHcxol14INu4PLMPEqUd2hUA66t4IR3ToU0UnntlVPPxRR6AD5ybdtPJjejMjiKtfzYVRQA
 A/qXkZPn6ZzUcZTGoiqPsT1H60yPZ/y2qH6Xv/zqsrkDkzLUmNazpx5I3fQm8pz0EALROB9v24
 8A+bcM9DPrItuzAUa2m18XixxIszcDIr2ZTl6uJEXjUjhloMfowqIqDdxh7cCA5q10JZSqDv2i
 MtWTHU1BHVedYtOp56TpUPru
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:53 -0700
IronPort-SDR: UrvpwSOk56ZiywO/Md4VupENO7qzjOp0MOmyuhgrTZkPx4lOzSzGwD5NZ8ltmjmRXD5hqOQ/S7
 /SVOaT+JkfSclqcVKuJI4j/llxlL1Lk6o8OE7KHnU9GYfcSTkWaVq8np8Kl6Q5NKp0q2T9Ve+5
 f8p5FvWQ8QsO4Pc1hwEPLLAjWz/ZwyWtp7I9pvOrV/4FijlE+w5r6vrqLz97coObvlBASySSQS
 ghtCem3vZWS1UMMj+uK5LYAaaqOuzXVdQPQbsUOZsIO836bchB9s7fVYLEGHXr1btsXNXWQbHG
 Z5c=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:35 -0700
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
Subject: [PATCH 11/19] btrfs: introduce submit buffer
Date:   Fri,  7 Jun 2019 22:10:17 +0900
Message-Id: <20190607131025.31996-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sequential allocation is not enough to maintain sequential delivery of
write IOs to the device. Various features (async compress, async checksum,
...) of btrfs affect ordering of the IOs. This patch introduces submit
buffer to sort WRITE bios belonging to a block group and sort them out
sequentially in increasing block address to achieve sequential write
sequences with __btrfs_map_bio().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h             |   3 +
 fs/btrfs/extent-tree.c       |   5 ++
 fs/btrfs/volumes.c           | 165 +++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h           |   3 +
 include/trace/events/btrfs.h |  41 +++++++++
 5 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f4bcd2a6ec12..ade6d8243962 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -718,6 +718,9 @@ struct btrfs_block_group_cache {
 	 */
 	enum btrfs_alloc_type alloc_type;
 	u64 alloc_offset;
+	struct mutex submit_lock;
+	u64 submit_offset;
+	struct bio_list submit_buffer;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ae2c895d08c4..ebdc7a6dbe01 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -124,6 +124,7 @@ void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
 	if (atomic_dec_and_test(&cache->count)) {
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
+		WARN_ON(!bio_list_empty(&cache->submit_buffer));
 
 		/*
 		 * If not empty, someone is still holding mutex of
@@ -10511,6 +10512,8 @@ btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cache)
 		goto out;
 	}
 
+	cache->submit_offset = logical + cache->alloc_offset;
+
 out:
 	cache->alloc_type = alloc_type;
 	kfree(alloc_offsets);
@@ -10547,6 +10550,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 
 	atomic_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
+	mutex_init(&cache->submit_lock);
 	init_rwsem(&cache->data_rwsem);
 	INIT_LIST_HEAD(&cache->list);
 	INIT_LIST_HEAD(&cache->cluster_list);
@@ -10554,6 +10558,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cache->ro_list);
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
+	bio_list_init(&cache->submit_buffer);
 	btrfs_init_free_space_ctl(cache);
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 52d0d458c0fd..26a64a53032f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -29,6 +29,11 @@
 #include "sysfs.h"
 #include "tree-checker.h"
 
+struct map_bio_data {
+	void *orig_bi_private;
+	int mirror_num;
+};
+
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.sub_stripes	= 2,
@@ -523,6 +528,7 @@ static void requeue_list(struct btrfs_pending_bios *pending_bios,
 		pending_bios->tail = tail;
 }
 
+
 /*
  * we try to collect pending bios for a device so we don't get a large
  * number of procs sending bios down to the same device.  This greatly
@@ -606,6 +612,8 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 	spin_unlock(&device->io_lock);
 
 	while (pending) {
+		struct btrfs_bio *bbio;
+		struct completion *sent = NULL;
 
 		rmb();
 		/* we want to work on both lists, but do more bios on the
@@ -643,7 +651,12 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 			sync_pending = 0;
 		}
 
+		bbio = cur->bi_private;
+		if (bbio)
+			sent = bbio->sent;
 		btrfsic_submit_bio(cur);
+		if (sent)
+			complete(sent);
 		num_run++;
 		batch_run++;
 
@@ -5916,6 +5929,7 @@ static struct btrfs_bio *alloc_btrfs_bio(int total_stripes, int real_stripes)
 
 	atomic_set(&bbio->error, 0);
 	refcount_set(&bbio->refs, 1);
+	INIT_LIST_HEAD(&bbio->list);
 
 	return bbio;
 }
@@ -6730,7 +6744,7 @@ static void btrfs_end_bio(struct bio *bio)
  * the work struct is scheduled.
  */
 static noinline void btrfs_schedule_bio(struct btrfs_device *device,
-					struct bio *bio)
+					struct bio *bio, int need_seqwrite)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	int should_queue = 1;
@@ -6738,7 +6752,12 @@ static noinline void btrfs_schedule_bio(struct btrfs_device *device,
 
 	/* don't bother with additional async steps for reads, right now */
 	if (bio_op(bio) == REQ_OP_READ) {
+		struct btrfs_bio *bbio = bio->bi_private;
+		struct completion *sent = bbio->sent;
+
 		btrfsic_submit_bio(bio);
+		if (sent)
+			complete(sent);
 		return;
 	}
 
@@ -6746,7 +6765,7 @@ static noinline void btrfs_schedule_bio(struct btrfs_device *device,
 	bio->bi_next = NULL;
 
 	spin_lock(&device->io_lock);
-	if (op_is_sync(bio->bi_opf))
+	if (op_is_sync(bio->bi_opf) && need_seqwrite == 0)
 		pending_bios = &device->pending_sync_bios;
 	else
 		pending_bios = &device->pending_bios;
@@ -6785,8 +6804,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
+	/* queue all bios into scheduler if sequential write is required */
+	if (bbio->need_seqwrite) {
+		if (!async) {
+			DECLARE_COMPLETION_ONSTACK(sent);
+
+			bbio->sent = &sent;
+			btrfs_schedule_bio(dev, bio, bbio->need_seqwrite);
+			wait_for_completion_io(&sent);
+		} else {
+			btrfs_schedule_bio(dev, bio, bbio->need_seqwrite);
+		}
+		return;
+	}
 	if (async)
-		btrfs_schedule_bio(dev, bio);
+		btrfs_schedule_bio(dev, bio, bbio->need_seqwrite);
 	else
 		btrfsic_submit_bio(bio);
 }
@@ -6808,9 +6840,10 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 	}
 }
 
+
 static blk_status_t __btrfs_map_bio(struct btrfs_fs_info *fs_info,
 				    struct bio *bio, int mirror_num,
-				    int async_submit)
+				    int async_submit, int need_seqwrite)
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
@@ -6838,6 +6871,7 @@ static blk_status_t __btrfs_map_bio(struct btrfs_fs_info *fs_info,
 	bbio->private = first_bio->bi_private;
 	bbio->end_io = first_bio->bi_end_io;
 	bbio->fs_info = fs_info;
+	bbio->need_seqwrite = need_seqwrite;
 	atomic_set(&bbio->stripes_pending, bbio->num_stripes);
 
 	if ((bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
@@ -6885,10 +6919,131 @@ static blk_status_t __btrfs_map_bio(struct btrfs_fs_info *fs_info,
 	return BLK_STS_OK;
 }
 
+static blk_status_t __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info,
+					  struct bio *cur_bio, int mirror_num,
+					  int async_submit)
+{
+	u64 logical = (u64)cur_bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 length = cur_bio->bi_iter.bi_size;
+	struct bio *bio;
+	struct bio *next;
+	struct bio_list submit_list;
+	struct btrfs_block_group_cache *cache = NULL;
+	struct map_bio_data *map_private;
+	int sent;
+	blk_status_t ret;
+
+	WARN_ON(bio_op(cur_bio) != REQ_OP_WRITE);
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+	if (!cache || cache->alloc_type != BTRFS_ALLOC_SEQ) {
+		if (cache)
+			btrfs_put_block_group(cache);
+		return __btrfs_map_bio(fs_info, cur_bio, mirror_num,
+				       async_submit, 0);
+	}
+
+	mutex_lock(&cache->submit_lock);
+	if (cache->submit_offset == logical)
+		goto send_bios;
+
+	if (cache->submit_offset > logical) {
+		trace_btrfs_bio_before_write_pointer(cache, cur_bio);
+		mutex_unlock(&cache->submit_lock);
+		btrfs_put_block_group(cache);
+		WARN_ON_ONCE(1);
+		return BLK_STS_IOERR;
+	}
+
+	/* buffer the unaligned bio */
+	map_private = kmalloc(sizeof(*map_private), GFP_NOFS);
+	if (!map_private) {
+		mutex_unlock(&cache->submit_lock);
+		return errno_to_blk_status(-ENOMEM);
+	}
+
+	map_private->orig_bi_private = cur_bio->bi_private;
+	map_private->mirror_num = mirror_num;
+	cur_bio->bi_private = map_private;
+
+	bio_list_add(&cache->submit_buffer, cur_bio);
+	mutex_unlock(&cache->submit_lock);
+	btrfs_put_block_group(cache);
+
+	/* mimic a good result ... */
+	return BLK_STS_OK;
+
+send_bios:
+	mutex_unlock(&cache->submit_lock);
+	/* send this bio */
+	ret = __btrfs_map_bio(fs_info, cur_bio, mirror_num, 1, 1);
+	if (ret != BLK_STS_OK) {
+		/* TODO kill buffered bios */
+		return ret;
+	}
+
+loop:
+	/* and send previously buffered following bios */
+	mutex_lock(&cache->submit_lock);
+	cache->submit_offset += length;
+	length = 0;
+	bio_list_init(&submit_list);
+
+	/* collect sequential bios into submit_list */
+	do {
+		sent = 0;
+		bio = bio_list_get(&cache->submit_buffer);
+		while (bio) {
+			u64 logical =
+				(u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+			struct bio_list *target;
+
+			next = bio->bi_next;
+			bio->bi_next = NULL;
+
+			if (logical == cache->submit_offset + length) {
+				sent = 1;
+				length += bio->bi_iter.bi_size;
+				target = &submit_list;
+			} else {
+				target = &cache->submit_buffer;
+			}
+			bio_list_add(target, bio);
+
+			bio = next;
+		}
+	} while (sent);
+	mutex_unlock(&cache->submit_lock);
+
+	/* send the collected bios */
+	while ((bio = bio_list_pop(&submit_list)) != NULL) {
+		map_private = (struct map_bio_data *)bio->bi_private;
+		mirror_num = map_private->mirror_num;
+		bio->bi_private = map_private->orig_bi_private;
+		kfree(map_private);
+
+		ret = __btrfs_map_bio(fs_info, bio, mirror_num, 1, 1);
+		if (ret) {
+			bio->bi_status = ret;
+			bio_endio(bio);
+		}
+	}
+
+	if (length)
+		goto loop;
+	btrfs_put_block_group(cache);
+
+	return BLK_STS_OK;
+}
+
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num, int async_submit)
 {
-	return __btrfs_map_bio(fs_info, bio, mirror_num, async_submit);
+	if (btrfs_fs_incompat(fs_info, HMZONED) && bio_op(bio) == REQ_OP_WRITE)
+		return __btrfs_map_bio_zoned(fs_info, bio, mirror_num,
+					     async_submit);
+
+	return __btrfs_map_bio(fs_info, bio, mirror_num, async_submit, 0);
 }
 
 /*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f66755e43669..e97d13cb1627 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -329,6 +329,9 @@ struct btrfs_bio {
 	int mirror_num;
 	int num_tgtdevs;
 	int *tgtdev_map;
+	int need_seqwrite;
+	struct list_head list;
+	struct completion *sent;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index fe4d268028ee..2b4cd791bf24 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2091,6 +2091,47 @@ DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_read_lock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_write_lock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_lock_atomic);
 
+DECLARE_EVENT_CLASS(btrfs_hmzoned_bio_buffer_events,
+	TP_PROTO(const struct btrfs_block_group_cache *cache,
+		 const struct bio *bio),
+
+	TP_ARGS(cache, bio),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	block_group	)
+		__field(	u64,	flags		)
+		__field(	u64,	submit_pos	)
+		__field(	u64,	logical	)
+		__field(	u64,	length		)
+	),
+
+	TP_fast_assign_btrfs(cache->fs_info,
+		__entry->block_group = cache->key.objectid;
+		__entry->flags = cache->flags;
+		__entry->submit_pos = cache->submit_offset;
+		__entry->logical = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+		__entry->length = bio->bi_iter.bi_size;
+	),
+
+	TP_printk_btrfs(
+		"block_group=%llu(%s) submit_pos=%llu logical=%llu length=%llu",
+		__entry->block_group,
+		__print_flags((unsigned long)__entry->flags, "|",
+			      BTRFS_GROUP_FLAGS),
+		__entry->submit_pos, __entry->logical,
+		__entry->length)
+);
+
+#define DEFINE_BTRFS_HMZONED_BIO_BUF_EVENT(name)			\
+DEFINE_EVENT(btrfs_hmzoned_bio_buffer_events, name,			\
+	     TP_PROTO(const struct btrfs_block_group_cache *cache,	\
+		      const struct bio *bio),				\
+									\
+	     TP_ARGS(cache, bio)					\
+)
+
+DEFINE_BTRFS_HMZONED_BIO_BUF_EVENT(btrfs_bio_before_write_pointer);
+
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.21.0

