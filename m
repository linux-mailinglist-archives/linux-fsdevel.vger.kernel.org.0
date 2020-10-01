Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515A82806F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbgJASjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgJASjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577547; x=1633113547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shVFtZnTpmLC/FMiePjkuEnS2T84Svac1gaMW/ga3nw=;
  b=cT+KNSt6nETolEv3i9rNfwMZShwekdjBaQB2upJhVwv0IKCDRXvegVYT
   6WuXA49Pdj0tP0Zn9KITN6Zzx9mcooACYXZC5FnjgF+FgKLtK0ODCEsWu
   T5mC45dwfyF8f9n1uVrKWru7L5tQ+uAH7duSZbV9SfPoBgXazs7kYK9hJ
   G/IG9IkF2/++Z9LI4vyNh8wA26JYvZF45JtV2CR7LgWEkpnr5j3Gtlqx+
   k/EtmCnjPlxWhSXgd92W9v0JaVOf0rSS+UqjtIyiigWvtyPe+psKabmt4
   JmoUVzxNdLLq+C49b9JIkLop5nM/R1QEHAp8u2pgDMcpmLB5s5wZ7IHBc
   A==;
IronPort-SDR: 4bXM91bz94JBkS50mUue6hEEVC24+F+IenwchuSuRTQLZwVC8ayyRJrFA/Rp7UE5tz64Q7MMmq
 IpeJwvnwDXo6CrzBBsEZN/Na3fFevarfWVOinUclijCCXfODmoUAmQKsCbVvVr/6nwircRWIAg
 q7QB5jGuhV5eOmImn/WPx+ytBPUOCo4rqjks4qQkEoiDitODrEGcvfcvmAShuWSIY2ikPu/s1E
 C++0Z7zrxdyLRrA6t5F9ZhqRW1RW71S164gjE6mzCag+KdDAoCm+OKDVict0G+1LMOClZrSXB7
 tC4=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036841"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:44 +0800
IronPort-SDR: eJT85jVFDAhWTO4lwNmpnaSMtrdCiz/fj5LoeYxewIm3EfL3OxtD6pad3RrDTtJ13WNLib4e6N
 VRT96mKcfwxg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:40 -0700
IronPort-SDR: Acg0lP1uR9Pn9ccqUWB593gGmUa0AnugzrsbUUef/vdJOD0ZwUad7Lr/c8EWBY2IDEyv1/2pmW
 m2ZsT0Ic11AA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 36/41] btrfs: relocate block group to repair IO failure in ZONED
Date:   Fri,  2 Oct 2020 03:36:43 +0900
Message-Id: <2e1473edbe7144719eaa72444fa24cc3ac5074d7.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When btrfs find a checksum error and if the file system has a mirror of the
damaged data, btrfs read the correct data from the mirror and write the
data to damaged blocks. This repairing, however, is against the sequential
write required rule.

We can consider three methods to repair an IO failure in ZONED mode:
(1) Reset and rewrite the damaged zone
(2) Allocate new device extent and replace the damaged device extent to the
    new extent
(3) Relocate the corresponding block group

Method (1) is most similar to a behavior done with regular devices.
However, it also wipes non-damaged data in the same device extent, and so
it unnecessary degrades non-damaged data.

Method (2) is much like device replacing but done in the same device. It is
safe because it keeps the device extent until the replacing finish.
However, extending device replacing is non-trivial. It assumes
"src_dev->physical == dst_dev->physical". Also, the extent mapping
replacing function should be extended to support replacing device extent
position in one device.

Method (3) invokes relocation of the damaged block group, so it is
straightforward to implement. It relocates all the mirrored device extents,
so it is, potentially, a more costly operation than method (1) or (2). But
it relocates only using extents which reduce the total IO size.

Let's apply method (3) for now. In the future, we can extend device-replace
and apply method (2).

For protecting a block group gets relocated multiple time with multiple IO
errors, this commit introduces "relocating_repair" bit to show it's now
relocating to repair IO failures. Also it uses a new kthread
"btrfs-relocating-repair", not to block IO path with relocating process.

This commit also supports repairing in the scrub process.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent_io.c   |  3 ++
 fs/btrfs/scrub.c       |  3 ++
 fs/btrfs/volumes.c     | 71 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     |  1 +
 5 files changed, 79 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index e91123495d68..50e5ddb0a19b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -96,6 +96,7 @@ struct btrfs_block_group {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int to_copy:1;
+	unsigned int relocating_repair:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ed6a9fce016d..b93c67e8ba1d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2268,6 +2268,9 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
+	if (btrfs_fs_incompat(fs_info, ZONED))
+		return btrfs_repair_one_zone(fs_info, logical);
+
 	bio = btrfs_io_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2e607caa5ab9..4c247a1618d0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -861,6 +861,9 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	have_csum = sblock_to_check->pagev[0]->have_csum;
 	dev = sblock_to_check->pagev[0]->dev;
 
+	if (btrfs_fs_incompat(fs_info, ZONED) && !sctx->is_dev_replace)
+		return btrfs_repair_one_zone(fs_info, logical);
+
 	/*
 	 * We must use GFP_NOFS because the scrub task might be waiting for a
 	 * worker task executing this function and in turn a transaction commit
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index af2ed4d3389f..33380f20a206 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7975,3 +7975,74 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 	spin_unlock(&fs_info->swapfile_pins_lock);
 	return node != NULL;
 }
+
+static int relocating_repair_kthread(void *data)
+{
+	struct btrfs_block_group *cache = (struct btrfs_block_group *) data;
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	u64 target;
+	int ret = 0;
+
+	target = cache->start;
+	btrfs_put_block_group(cache);
+
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
+		btrfs_info(fs_info,
+			   "skip relocating block group %llu to repair: EBUSY",
+			   target);
+		return -EBUSY;
+	}
+
+	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+
+	/* ensure Block Group still exists */
+	cache = btrfs_lookup_block_group(fs_info, target);
+	if (!cache)
+		goto out;
+
+	if (!cache->relocating_repair)
+		goto out;
+
+	ret = btrfs_may_alloc_data_chunk(fs_info, target);
+	if (ret < 0)
+		goto out;
+
+	btrfs_info(fs_info, "relocating block group %llu to repair IO failure",
+		   target);
+	ret = btrfs_relocate_chunk(fs_info, target);
+
+out:
+	if (cache)
+		btrfs_put_block_group(cache);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	btrfs_exclop_finish(fs_info);
+
+	return ret;
+}
+
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
+
+	/* do not attempt to repair in degraded state */
+	if (btrfs_test_opt(fs_info, DEGRADED))
+		return 0;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+	if (!cache)
+		return 0;
+
+	spin_lock(&cache->lock);
+	if (cache->relocating_repair) {
+		spin_unlock(&cache->lock);
+		btrfs_put_block_group(cache);
+		return 0;
+	}
+	cache->relocating_repair = 1;
+	spin_unlock(&cache->lock);
+
+	kthread_run(relocating_repair_kthread, cache,
+		    "btrfs-relocating-repair");
+
+	return 0;
+}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f8fc3debd5e0..7f1a38c820e3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -584,5 +584,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.27.0

