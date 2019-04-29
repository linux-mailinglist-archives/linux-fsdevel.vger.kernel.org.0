Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8A5E8CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfD2R1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbfD2R1K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D9EEACFB;
        Mon, 29 Apr 2019 17:27:08 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 01/18] btrfs: create a mount option for dax
Date:   Mon, 29 Apr 2019 12:26:32 -0500
Message-Id: <20190429172649.8288-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This sets S_DAX in inode->i_flags, which can be used with
IS_DAX().

The dax option is restricted to non multi-device mounts.
dax interacts with the device directly instead of using bio, so
all bio-hooks which we use for multi-device cannot be performed
here. While regular read/writes could be manipulated with
RAID0/1, mmap() is still an issue.

Auto-setting free space tree, because dealing with free space
inode (specifically readpages) is a nightmare.
Auto-setting nodatasum because we don't get callback for writing
checksums after mmap()s.
Deny compression because it does not go with direct I/O.

Store the dax_device in fs_info which will be used in iomap code.

I am aware of the push to directory-based flags for dax. Until, that
code is in the kernel, we will work with mount flags.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/disk-io.c |  4 ++++
 fs/btrfs/ioctl.c   |  5 ++++-
 fs/btrfs/super.c   | 30 ++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b3642367a595..8ca1c0d120f4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1067,6 +1067,7 @@ struct btrfs_fs_info {
 	u32 metadata_ratio;
 
 	void *bdev_holder;
+	struct dax_device *dax_dev;
 
 	/* private scrub information */
 	struct mutex scrub_lock;
@@ -1442,6 +1443,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_DAX			(1 << 29)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6fe9197f6ee4..2bbb63b2fcff 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -16,6 +16,7 @@
 #include <linux/uuid.h>
 #include <linux/semaphore.h>
 #include <linux/error-injection.h>
+#include <linux/dax.h>
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
@@ -2805,6 +2806,8 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
+	fs_info->dax_dev = fs_dax_get_by_bdev(fs_devices->latest_bdev);
+
 	/*
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
@@ -4043,6 +4046,7 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 #endif
 
 	btrfs_close_devices(fs_info->fs_devices);
+	fs_put_dax(fs_info->dax_dev);
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cd4e693406a0..0138119cd9a3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -149,8 +149,11 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
 	if (binode->flags & BTRFS_INODE_DIRSYNC)
 		new_fl |= S_DIRSYNC;
 
+	if ((btrfs_test_opt(btrfs_sb(inode->i_sb), DAX)) && S_ISREG(inode->i_mode))
+		new_fl |= S_DAX;
+
 	set_mask_bits(&inode->i_flags,
-		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC,
+		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC | S_DAX,
 		      new_fl);
 }
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 120e4340792a..3b85e61e5182 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -326,6 +326,7 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
+	Opt_dax,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -393,6 +394,7 @@ static const match_table_t tokens = {
 	{Opt_notreelog, "notreelog"},
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_dax, "dax"},
 
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
@@ -745,6 +747,32 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_user_subvol_rm_allowed:
 			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
 			break;
+		case Opt_dax:
+#ifdef CONFIG_FS_DAX
+			if (btrfs_super_num_devices(info->super_copy) > 1) {
+				btrfs_info(info,
+					   "dax not supported for multi-device btrfs partition\n");
+				ret = -EOPNOTSUPP;
+				goto out;
+			}
+			btrfs_set_opt(info->mount_opt, DAX);
+			btrfs_warn(info, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk\n");
+			btrfs_set_and_info(info, NODATASUM,
+					   "auto-setting nodatasum (dax)");
+			btrfs_clear_opt(info->mount_opt, SPACE_CACHE);
+			btrfs_set_and_info(info, FREE_SPACE_TREE,
+					"auto-setting free space tree (dax)");
+			if (btrfs_test_opt(info, COMPRESS)) {
+				btrfs_info(info, "disabling compress (dax)");
+				btrfs_clear_opt(info->mount_opt, COMPRESS);
+			}
+			break;
+#else
+			btrfs_err(info,
+				  "DAX option not supported\n");
+			ret = -EINVAL;
+			goto out;
+#endif
 		case Opt_enospc_debug:
 			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
 			break;
@@ -1335,6 +1363,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",clear_cache");
 	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
 		seq_puts(seq, ",user_subvol_rm_allowed");
+	if (btrfs_test_opt(info, DAX))
+		seq_puts(seq, ",dax");
 	if (btrfs_test_opt(info, ENOSPC_DEBUG))
 		seq_puts(seq, ",enospc_debug");
 	if (btrfs_test_opt(info, AUTO_DEFRAG))
-- 
2.16.4

