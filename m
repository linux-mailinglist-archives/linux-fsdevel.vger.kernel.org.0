Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993062806FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgJASjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24779 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbgJASjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577543; x=1633113543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g83IDaetFeG2qxHEJsxkSMJbqm1nC0dkIReub0/vubg=;
  b=Fs2mGwVS0FzrXhpX/BejfYxnnthSTjAZkT6Q94UAAJo+HwBDlPuVxS15
   chxQ/1NT0k15wUVi7R3gIsZvCc8NgfuGzm3BxN2BCXisZ7mW9vRgQtIVG
   AvZVNKK+QToQ6BArWgLNbiRzh9xFIPWrzac1gRBDyKnXlDt6XtgTZZi1u
   RXiBCuJi07p+4nnQpW0Rh/CkOvtbc5BkwGbrU85Vh1OLJOhpaRhHZBzsj
   26KZaUMcSkkqIKQ8RRn4ezLixRaJXfCE1d/uo1yllk5sPsYkjRh3HWeRv
   qQNXy0JsBtGsiBCGc5XqwJ+Nr6y1eB4+I+t9FuXk4Djwl05cpMMzrRl8X
   g==;
IronPort-SDR: fOUVVYRH/5C4mQ91W2t4p9mgStFe+UUwNfROQMtdrWT2Y2ndz0fM/cMMWkxuv6KYa1CiJxtTEC
 FRBE2UjRGkIF15DQ7VzVvGamQrDh7cfE8mLwjYXLPsFPjCDAZBltrqg40s4NGW7sn+oKngmNwy
 R9ITdGzbR6YfoAXxDzVYbNdk3/EMSkWXP7p6TM6Ir3oajYqTTfjq3K1jHuJSM+4XTDXUtgwyr/
 FiM/brPc40ijcerU2/CjN5qPrvWzZxTDWljqib1KHB+9pGOUAdAlK6MQfcvD1nNRs3SBLaQ8NT
 AfA=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036827"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:38 +0800
IronPort-SDR: sTFXU9TuFoBFs5zylhquPJU+7Z/HJRnGdS4POUHjtfZ6RmZt74KF0zRHGDclxNu4gB1nubkv44
 t1MA0XGnZpqg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:34 -0700
IronPort-SDR: +RKVdMvDuJougfTXYcbz6Q8IodeFuIxy65WQijLy+k0YBsTbZRaxhysdJp9GUqCnbMX4viXJrl
 IuVHReHSWt4w==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 31/41] btrfs: mark block groups to copy for device-replace
Date:   Fri,  2 Oct 2020 03:36:38 +0900
Message-Id: <83652d36a020f8c11e601d969cc8940a829020e9.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 1/4 patch to support device-replace in ZONED mode.

We have two types of I/Os during the device-replace process. One is an I/O
to "copy" (by the scrub functions) all the device extents on the source
device to the destination device.  The other one is an I/O to "clone" (by
handle_ops_on_dev_replace()) new incoming write I/Os from users to the
source device into the target device.

Cloning incoming I/Os can break the sequential write rule in the target
device. When writing is mapped in the middle of a block group, the I/O is
directed in the middle of a target device zone, which breaks the sequential
write rule.

However, the cloning function cannot be merely disabled since incoming I/Os
targeting already copied device extents must be cloned so that the I/O is
executed on the target device.

We cannot use dev_replace->cursor_{left,right} to determine whether bio is
going to not yet copied region.  Since we have a time gap between finishing
btrfs_scrub_dev() and rewriting the mapping tree in
btrfs_dev_replace_finishing(), we can have a newly allocated device extent
which is never cloned nor copied.

So the point is to copy only already existing device extents. This patch
introduces mark_block_group_to_copy() to mark existing block groups as a
target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
check the flag to do their job.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/dev-replace.c | 175 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.h |   3 +
 fs/btrfs/scrub.c       |  17 ++++
 4 files changed, 196 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b2a8a3beceac..e91123495d68 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -95,6 +95,7 @@ struct btrfs_block_group {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5e3554482af1..e86aff38aea4 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -22,6 +22,7 @@
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "zoned.h"
+#include "block-group.h"
 
 /*
  * Device replace overview
@@ -437,6 +438,176 @@ static char* btrfs_dev_name(struct btrfs_device *device)
 		return rcu_str_deref(device->name);
 }
 
+static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
+				    struct btrfs_device *src_dev)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_dev_extent *dev_extent = NULL;
+	struct btrfs_block_group *cache;
+	struct extent_buffer *l;
+	struct btrfs_trans_handle *trans;
+	int slot;
+	int ret = 0;
+	u64 chunk_offset, length;
+
+	/* Do not use "to_copy" on non-ZONED for now */
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
+	mutex_lock(&fs_info->chunk_mutex);
+
+	/* ensulre we don't have pending new block group */
+	while (fs_info->running_transaction &&
+	       !list_empty(&fs_info->running_transaction->dev_update_list)) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		trans = btrfs_attach_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			mutex_lock(&fs_info->chunk_mutex);
+			if (ret == -ENOENT)
+				continue;
+			else
+				goto out;
+		}
+
+		ret = btrfs_commit_transaction(trans);
+		mutex_lock(&fs_info->chunk_mutex);
+		if (ret)
+			goto out;
+	}
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	path->reada = READA_FORWARD;
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	key.objectid = src_dev->devid;
+	key.offset = 0ull;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+
+	while (1) {
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			if (path->slots[0] >=
+			    btrfs_header_nritems(path->nodes[0])) {
+				ret = btrfs_next_leaf(root, path);
+				if (ret < 0)
+					break;
+				if (ret > 0) {
+					ret = 0;
+					break;
+				}
+			} else {
+				ret = 0;
+			}
+		}
+
+		l = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(l, &found_key, slot);
+
+		if (found_key.objectid != src_dev->devid)
+			break;
+
+		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
+			break;
+
+		if (found_key.offset < key.offset)
+			break;
+
+		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
+		length = btrfs_dev_extent_length(l, dev_extent);
+
+		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
+
+		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
+		if (!cache)
+			goto skip;
+
+		spin_lock(&cache->lock);
+		cache->to_copy = 1;
+		spin_unlock(&cache->lock);
+
+		btrfs_put_block_group(cache);
+
+skip:
+		key.offset = found_key.offset + length;
+		btrfs_release_path(path);
+	}
+
+	btrfs_free_path(path);
+out:
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	return ret;
+}
+
+bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group *cache,
+				      u64 physical)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 chunk_offset = cache->start;
+	int num_extents, cur_extent;
+	int i;
+
+	/* Do not use "to_copy" on non-ZONED for now */
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return true;
+
+	spin_lock(&cache->lock);
+	if (cache->removed) {
+		spin_unlock(&cache->lock);
+		return true;
+	}
+	spin_unlock(&cache->lock);
+
+	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	BUG_ON(IS_ERR(em));
+	map = em->map_lookup;
+
+	num_extents = cur_extent = 0;
+	for (i = 0; i < map->num_stripes; i++) {
+		/* we have more device extent to copy */
+		if (srcdev != map->stripes[i].dev)
+			continue;
+
+		num_extents++;
+		if (physical == map->stripes[i].physical)
+			cur_extent = i;
+	}
+
+	free_extent_map(em);
+
+	if (num_extents > 1 && cur_extent < num_extents - 1) {
+		/*
+		 * Has more stripes on this device. Keep this BG
+		 * readonly until we finish all the stripes.
+		 */
+		return false;
+	}
+
+	/* last stripe on this device */
+	spin_lock(&cache->lock);
+	cache->to_copy = 0;
+	spin_unlock(&cache->lock);
+
+	return true;
+}
+
 static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
 		int read_src)
@@ -478,6 +649,10 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	if (ret)
 		return ret;
 
+	ret = mark_block_group_to_copy(fs_info, src_device);
+	if (ret)
+		return ret;
+
 	down_write(&dev_replace->rwsem);
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 60b70dacc299..3911049a5f23 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -18,5 +18,8 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
 void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
 int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
 int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
+bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group *cache,
+				      u64 physical);
 
 #endif
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aa1b36cf5c88..d0d7db3c8b0b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3500,6 +3500,17 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+
+		if (sctx->is_dev_replace && btrfs_fs_incompat(fs_info, ZONED)) {
+			spin_lock(&cache->lock);
+			if (!cache->to_copy) {
+				spin_unlock(&cache->lock);
+				ro_set = 0;
+				goto done;
+			}
+			spin_unlock(&cache->lock);
+		}
+
 		/*
 		 * Make sure that while we are scrubbing the corresponding block
 		 * group doesn't get its logical address and its device extents
@@ -3631,6 +3642,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		scrub_pause_off(fs_info);
 
+		if (sctx->is_dev_replace &&
+		    !btrfs_finish_block_group_to_copy(dev_replace->srcdev,
+						      cache, found_key.offset))
+			ro_set = 0;
+
+done:
 		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_left = dev_replace->cursor_right;
 		dev_replace->item_needs_writeback = 1;
-- 
2.27.0

