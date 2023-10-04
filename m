Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A37B8BE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbjJDSz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244830AbjJDSyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6194B10D7;
        Wed,  4 Oct 2023 11:54:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D4AC433C8;
        Wed,  4 Oct 2023 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445667;
        bh=kFTNQpEU+Pu8tNfESD938BnBRfFvEHWpO/AqQh7tvYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/bnXjIAGc5J+vGl6YIHLBdDLBGZ+K8FEuAOXJbv0299dxULTaQhJCI/D5bPKsO8R
         4VN/f4ifF6L1l2xN5WjvvbcdMnyFvqvP+eTzMe5s0uZRAuTC7VR8pkMAqbYQRhd+AJ
         2vUtTn+nvaulkjfqczhSbg7iME2sl99itUilBr3zltNdJjEIuWYu3bld6NZvOdy+p9
         OCZwmvKHxPE7lulRghIYCdVgMBufMd1NqIqtoTslyN67wd0KkEUafWqLkTBg21Of4g
         xNZ7zYcljP/kN3imcElBURln+fXpGaVr4D9oIvjuUh6GQhw0uKfPywsAvxeThQr6Ud
         AVty2UjF6nIpQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 35/89] ext4: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:20 -0400
Message-ID: <20231004185347.80880-33-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/ext4.h    | 20 +++++++++++++++-----
 fs/ext4/extents.c | 11 ++++++-----
 fs/ext4/ialloc.c  |  4 ++--
 fs/ext4/inline.c  |  4 ++--
 fs/ext4/inode.c   | 19 ++++++++++---------
 fs/ext4/ioctl.c   | 13 +++++++++++--
 fs/ext4/namei.c   | 10 +++++-----
 fs/ext4/super.c   |  2 +-
 fs/ext4/xattr.c   |  8 ++++----
 9 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 380c5a267d27..180b8c5fe021 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -891,10 +891,13 @@ do {										\
 		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX));	\
 } while (0)
 
-#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
-	EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, (inode)->xtime)
+#define EXT4_INODE_SET_ATIME(inode, raw_inode)						\
+	EXT4_INODE_SET_XTIME_VAL(i_atime, inode, raw_inode, inode_get_atime(inode))
 
-#define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
+#define EXT4_INODE_SET_MTIME(inode, raw_inode)						\
+	EXT4_INODE_SET_XTIME_VAL(i_mtime, inode, raw_inode, inode_get_mtime(inode))
+
+#define EXT4_INODE_SET_CTIME(inode, raw_inode)						\
 	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode))
 
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)				\
@@ -910,9 +913,16 @@ do {										\
 			.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime)	\
 		})
 
-#define EXT4_INODE_GET_XTIME(xtime, inode, raw_inode)				\
+#define EXT4_INODE_GET_ATIME(inode, raw_inode)					\
+do {										\
+	inode_set_atime_to_ts(inode,						\
+		EXT4_INODE_GET_XTIME_VAL(i_atime, inode, raw_inode));		\
+} while (0)
+
+#define EXT4_INODE_GET_MTIME(inode, raw_inode)					\
 do {										\
-	(inode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode);	\
+	inode_set_mtime_to_ts(inode,						\
+		EXT4_INODE_GET_XTIME_VAL(i_mtime, inode, raw_inode));		\
 } while (0)
 
 #define EXT4_INODE_GET_CTIME(inode, raw_inode)					\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..4c4176ee1749 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4481,7 +4481,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			if (epos > new_size)
 				epos = new_size;
 			if (ext4_update_inode_size(inode, epos) & 0x1)
-				inode->i_mtime = inode_get_ctime(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_get_ctime(inode));
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -4617,7 +4618,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
@@ -4642,7 +4643,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5378,7 +5379,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5488,7 +5489,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b65058d972f9..e9bbb1da2d0a 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1250,8 +1250,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	inode->i_ino = ino + group * EXT4_INODES_PER_GROUP(sb);
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	ei->i_crtime = inode->i_mtime;
+	simple_inode_init_ts(inode);
+	ei->i_crtime = inode_get_mtime(inode);
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_dir_start_lookup = 0;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 012d9259ff53..9a84a5f9fef4 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1037,7 +1037,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	return 1;
@@ -1991,7 +1991,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		ext4_orphan_del(handle, inode);
 
 	if (err == 0) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ce35f1c8b0a..08cb5c0e0d51 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4020,7 +4020,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
@@ -4180,7 +4180,7 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	err2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(err2 && !err))
 		err = err2;
@@ -4284,8 +4284,8 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 
 	EXT4_INODE_SET_CTIME(inode, raw_inode);
-	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
-	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
+	EXT4_INODE_SET_MTIME(inode, raw_inode);
+	EXT4_INODE_SET_ATIME(inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
 
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
@@ -4893,8 +4893,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	EXT4_INODE_GET_CTIME(inode, raw_inode);
-	EXT4_INODE_GET_XTIME(i_mtime, inode, raw_inode);
-	EXT4_INODE_GET_XTIME(i_atime, inode, raw_inode);
+	EXT4_INODE_GET_ATIME(inode, raw_inode);
+	EXT4_INODE_GET_MTIME(inode, raw_inode);
 	EXT4_EINODE_GET_XTIME(i_crtime, ei, raw_inode);
 
 	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT))) {
@@ -5019,8 +5019,8 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 
 		spin_lock(&ei->i_raw_lock);
 		EXT4_INODE_SET_CTIME(inode, raw_inode);
-		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
-		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
+		EXT4_INODE_SET_MTIME(inode, raw_inode);
+		EXT4_INODE_SET_ATIME(inode, raw_inode);
 		ext4_inode_csum_set(inode, raw_inode, ei);
 		spin_unlock(&ei->i_raw_lock);
 		trace_ext4_other_inode_update_time(inode, orig_ino);
@@ -5413,7 +5413,8 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 * update c/mtime in shrink case below
 			 */
 			if (!shrink)
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 
 			if (shrink)
 				ext4_fc_track_range(handle, inode,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0bfe2ce589e2..4f931f80cb34 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -312,13 +312,22 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
 	struct ext4_inode_info *ei1;
 	struct ext4_inode_info *ei2;
 	unsigned long tmp;
+	struct timespec64 ts1, ts2;
 
 	ei1 = EXT4_I(inode1);
 	ei2 = EXT4_I(inode2);
 
 	swap(inode1->i_version, inode2->i_version);
-	swap(inode1->i_atime, inode2->i_atime);
-	swap(inode1->i_mtime, inode2->i_mtime);
+
+	ts1 = inode_get_atime(inode1);
+	ts2 = inode_get_atime(inode2);
+	inode_set_atime_to_ts(inode1, ts2);
+	inode_set_atime_to_ts(inode2, ts1);
+
+	ts1 = inode_get_mtime(inode1);
+	ts2 = inode_get_mtime(inode2);
+	inode_set_mtime_to_ts(inode1, ts2);
+	inode_set_mtime_to_ts(inode2, ts1);
 
 	memswap(ei1->i_data, ei2->i_data, sizeof(ei1->i_data));
 	tmp = ei1->i_flags & EXT4_FL_SHOULD_SWAP;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index bbda587f76b8..057d74467293 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2207,7 +2207,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	err2 = ext4_mark_inode_dirty(handle, dir);
@@ -3202,7 +3202,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	 * recovery. */
 	inode->i_size = 0;
 	ext4_orphan_add(handle, inode);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_set_ctime_current(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (retval)
@@ -3277,7 +3277,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		retval = ext4_delete_entry(handle, dir, de, bh);
 		if (retval)
 			goto out_handle;
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 		ext4_update_dx_flag(dir);
 		retval = ext4_mark_inode_dirty(handle, dir);
 		if (retval)
@@ -3648,7 +3648,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	if (ext4_has_feature_filetype(ent->dir->i_sb))
 		ent->de->file_type = file_type;
 	inode_inc_iversion(ent->dir);
-	ent->dir->i_mtime = inode_set_ctime_current(ent->dir);
+	inode_set_mtime_to_ts(ent->dir, inode_set_ctime_current(ent->dir));
 	retval = ext4_mark_inode_dirty(handle, ent->dir);
 	BUFFER_TRACE(ent->bh, "call ext4_handle_dirty_metadata");
 	if (!ent->inlined) {
@@ -3963,7 +3963,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		ext4_dec_count(new.inode);
 		inode_set_ctime_current(new.inode);
 	}
-	old.dir->i_mtime = inode_set_ctime_current(old.dir);
+	inode_set_mtime_to_ts(old.dir, inode_set_ctime_current(old.dir));
 	ext4_update_dx_flag(old.dir);
 	if (old.dir_bh) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f37fb009bd99..3165426784a9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7136,7 +7136,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	}
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 92ba28cebac6..b9467ff8d4e9 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -356,7 +356,7 @@ ext4_xattr_inode_hash(struct ext4_sb_info *sbi, const void *buffer, size_t size)
 
 static u64 ext4_xattr_inode_get_ref(struct inode *ea_inode)
 {
-	return ((u64) inode_get_ctime(ea_inode).tv_sec << 32) |
+	return ((u64) inode_get_ctime_sec(ea_inode) << 32) |
 		(u32) inode_peek_iversion_raw(ea_inode);
 }
 
@@ -368,12 +368,12 @@ static void ext4_xattr_inode_set_ref(struct inode *ea_inode, u64 ref_count)
 
 static u32 ext4_xattr_inode_get_hash(struct inode *ea_inode)
 {
-	return (u32)ea_inode->i_atime.tv_sec;
+	return (u32) inode_get_atime_sec(ea_inode);
 }
 
 static void ext4_xattr_inode_set_hash(struct inode *ea_inode, u32 hash)
 {
-	ea_inode->i_atime.tv_sec = hash;
+	inode_set_atime(ea_inode, hash, 0);
 }
 
 /*
@@ -418,7 +418,7 @@ static int ext4_xattr_inode_read(struct inode *ea_inode, void *buf, size_t size)
 	return ret;
 }
 
-#define EXT4_XATTR_INODE_GET_PARENT(inode) ((__u32)(inode)->i_mtime.tv_sec)
+#define EXT4_XATTR_INODE_GET_PARENT(inode) ((__u32)(inode_get_mtime_sec(inode)))
 
 static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 				 u32 ea_inode_hash, struct inode **ea_inode)
-- 
2.41.0

