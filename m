Return-Path: <linux-fsdevel+bounces-5803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A98108F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA80B1C208E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31810CA75;
	Wed, 13 Dec 2023 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0KKoY2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99DBE6D;
	Wed, 13 Dec 2023 04:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D37EC433C7;
	Wed, 13 Dec 2023 04:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702440074;
	bh=x1ouiu2WnKIQtV47erUmnthL70kDRsFLvcEjWZFRFeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0KKoY2jT1ZANMkBJSLNQH5u8pVIMTsBy73HXBRpwKDV7Y9DEaZ3MOTaU6elnCdH5
	 FEifJwGLDyd6ZCqq1Uxg65Uwdai7TBwjjtQs8EfW6obfdASjJ/0m23vQ8KPHo6TMju
	 hQQ9jWtHdGElAkeKMaVUcltO3blbnswYq/yrMfCuij5ThcE+PRpE/suLTrQNhM5Lxy
	 qcQ0xAqr3VM87rfeMHQ34tQ6Zj+NkaAl6JVTKgFojpSuA4mXi6VGxMsVnWl+Hi55zF
	 UbfeVpEKmp9Oq4lTMdTCFosg906UJ++dakgjzl56DBXB2Nos2yVxhUpVEdNM0pcDiT
	 gsKVYq/cC6eAA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/3] btrfs: call btrfs_close_devices from ->kill_sb
Date: Tue, 12 Dec 2023 20:00:16 -0800
Message-ID: <20231213040018.73803-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213040018.73803-1-ebiggers@kernel.org>
References: <20231213040018.73803-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex once call backs from block devices to
the file system using the holder ops are supported.  Move the call
to btrfs_close_devices into btrfs_free_fs_info so that it is closed
from ->kill_sb (which is also called from the mount failure handling
path unlike ->put_super) as well as when an fs_info is freed because
an existing superblock already exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 fs/btrfs/super.c   | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bbcc3df776461..fe98e6b1d9c61 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1237,20 +1237,22 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 	while ((node = rb_first_postorder(&fs_info->global_root_tree)) != NULL) {
 		root = rb_entry(node, struct btrfs_root, rb_node);
 		rb_erase(&root->rb_node, &fs_info->global_root_tree);
 		btrfs_put_root(root);
 	}
 }
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
 	free_global_roots(fs_info);
@@ -3605,21 +3607,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 
 fail_sb_buffer:
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail_alloc:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
 static void btrfs_end_super_write(struct bio *bio)
 {
 	struct btrfs_device *device = bio->bi_private;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -4385,21 +4386,20 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 * have had an IO error and have left over tree log blocks that aren't
 	 * cleaned up until the fs roots are freed.  This makes the block group
 	 * accounting appear to be wrong because there's pending reserved bytes,
 	 * so make sure we do the block group cleanup afterwards.
 	 */
 	btrfs_free_block_groups(fs_info);
 
 	iput(fs_info->btree_inode);
 
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
 			     struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	u64 transid = btrfs_header_generation(buf);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	/*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ef256b944c72a..9616ce63c5630 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1450,55 +1450,52 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
 	error = btrfs_open_devices(fs_devices, mode, fs_type);
 	mutex_unlock(&uuid_mutex);
 	if (error)
 		goto error_fs_info;
 
 	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
 		error = -EACCES;
-		goto error_close_devices;
+		goto error_fs_info;
 	}
 
 	bdev = fs_devices->latest_dev->bdev;
 	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
 		 fs_info);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
-		goto error_close_devices;
+		goto error_fs_info;
 	}
 
 	if (s->s_root) {
-		btrfs_close_devices(fs_devices);
 		btrfs_free_fs_info(fs_info);
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
 		btrfs_sb(s)->bdev_holder = fs_type;
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
 		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
 	security_free_mnt_opts(&new_sec_opts);
 	if (error) {
 		deactivate_locked_super(s);
 		return ERR_PTR(error);
 	}
 
 	return dget(s->s_root);
 
-error_close_devices:
-	btrfs_close_devices(fs_devices);
 error_fs_info:
 	btrfs_free_fs_info(fs_info);
 error_sec_opts:
 	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
 }
 
 /*
  * Mount function which is called by VFS layer.
  *
-- 
2.43.0


