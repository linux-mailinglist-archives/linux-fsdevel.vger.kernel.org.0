Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7C748D25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjGETH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGETG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE21BD8;
        Wed,  5 Jul 2023 12:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5302B616EC;
        Wed,  5 Jul 2023 19:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF0C433C8;
        Wed,  5 Jul 2023 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583860;
        bh=D922Cq2SEXEwUPorCNhui1jv3NnTtUlXFDIcqs6xt8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAAbnG555vPHng2XwacHERfeDI1a8Bgd29T3IqWiiqpvTLHOR/mRr2MSaYwH0ZBmb
         4XIyW4ejHpMr1kXrk/HMd9//yhhtQ/2m7zDcS8DD4gZvMCCZJMsu+++Shm2Xph94Wp
         xkHzp+lTDQyccTQstASQMXzT7jAvW6WEFX4z4XjN7x8RHEZkp5UN/xy67FnQIIublN
         o7V7TzDUHqlF+FgbnnhTyYpT34nOQQuEB4LtNqzIzrNhH+x6luN4ZjBJpxxU/DJ3IS
         LBq535e92TwCrp4hguQ6JS5IKU/zSKtCgz7j16Es67eQA4VNOhxHAdKTQS44Cxlm7M
         TYbwfJK+Jv+BA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v2 43/92] f2fs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:08 -0400
Message-ID: <20230705190309.579783-41-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/dir.c      |  8 ++++----
 fs/f2fs/f2fs.h     |  4 +++-
 fs/f2fs/file.c     | 20 ++++++++++----------
 fs/f2fs/inline.c   |  2 +-
 fs/f2fs/inode.c    | 10 +++++-----
 fs/f2fs/namei.c    | 12 ++++++------
 fs/f2fs/recovery.c |  4 ++--
 fs/f2fs/super.c    |  2 +-
 fs/f2fs/xattr.c    |  2 +-
 9 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d635c58cf5a3..8aa29fe2e87b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -455,7 +455,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
 	set_page_dirty(page);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 	f2fs_put_page(page, 1);
 }
@@ -609,7 +609,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 			f2fs_i_links_write(dir, true);
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
@@ -858,7 +858,7 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
 
 	if (S_ISDIR(inode->i_mode))
 		f2fs_i_links_write(dir, false);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 
 	f2fs_i_links_write(inode, false);
 	if (S_ISDIR(inode->i_mode)) {
@@ -919,7 +919,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	}
 	f2fs_put_page(page, 1);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c7cb2177b252..e18272ae3119 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3303,9 +3303,11 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_is_time_consistent(struct inode *inode)
 {
+	struct timespec64 ctime = inode_get_ctime(inode);
+
 	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
 		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &ctime))
 		return false;
 	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
 		return false;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 093039dee992..b018800223c4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -794,7 +794,7 @@ int f2fs_truncate(struct inode *inode)
 	if (err)
 		return err;
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return 0;
 }
@@ -905,7 +905,7 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 	if (ia_valid & ATTR_MTIME)
 		inode->i_mtime = attr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
@@ -1008,7 +1008,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			return err;
 
 		spin_lock(&F2FS_I(inode)->i_size_lock);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
@@ -1835,7 +1835,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (!ret) {
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, false);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
@@ -1937,7 +1937,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	else
 		clear_inode_flag(inode, FI_PROJ_INHERIT);
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	f2fs_set_inode_flags(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
@@ -2874,10 +2874,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (ret)
 		goto out_unlock;
 
-	src->i_mtime = src->i_ctime = current_time(src);
+	src->i_mtime = inode_set_ctime_current(src);
 	f2fs_mark_inode_dirty_sync(src, false);
 	if (src != dst) {
-		dst->i_mtime = dst->i_ctime = current_time(dst);
+		dst->i_mtime = inode_set_ctime_current(dst);
 		f2fs_mark_inode_dirty_sync(dst, false);
 	}
 	f2fs_update_time(sbi, REQ_TIME);
@@ -3073,7 +3073,7 @@ static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 		goto out_unlock;
 
 	fi->i_projid = kprojid;
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 out_unlock:
 	f2fs_unlock_op(sbi);
@@ -3511,7 +3511,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	set_inode_flag(inode, FI_COMPRESS_RELEASED);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -3710,7 +3710,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	if (ret >= 0) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 unlock_inode:
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4638fee16a91..88fc9208ffa7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -698,7 +698,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 09e986b050c6..c1c2ba9f28e5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -403,7 +403,7 @@ static void init_idisk_time(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	fi->i_disk_time[0] = inode->i_atime;
-	fi->i_disk_time[1] = inode->i_ctime;
+	fi->i_disk_time[1] = inode_get_ctime(inode);
 	fi->i_disk_time[2] = inode->i_mtime;
 }
 
@@ -434,10 +434,10 @@ static int do_read_inode(struct inode *inode)
 	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks) - 1);
 
 	inode->i_atime.tv_sec = le64_to_cpu(ri->i_atime);
-	inode->i_ctime.tv_sec = le64_to_cpu(ri->i_ctime);
+	inode_set_ctime(inode, le64_to_cpu(ri->i_ctime),
+			le32_to_cpu(ri->i_ctime_nsec));
 	inode->i_mtime.tv_sec = le64_to_cpu(ri->i_mtime);
 	inode->i_atime.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
 	inode->i_generation = le32_to_cpu(ri->i_generation);
 	if (S_ISDIR(inode->i_mode))
@@ -714,10 +714,10 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	set_raw_inline(inode, ri);
 
 	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	ri->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
+	ri->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
 	ri->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
 	ri->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
-	ri->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
+	ri->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
 	ri->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
 	if (S_ISDIR(inode->i_mode))
 		ri->i_current_depth =
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bee0568888da..193b22a2d6bf 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -243,7 +243,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	F2FS_I(inode)->i_crtime = inode->i_mtime;
 	inode->i_generation = get_random_u32();
 
@@ -420,7 +420,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	f2fs_balance_fs(sbi, true);
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	ihold(inode);
 
 	set_inode_flag(inode, FI_INC_LINK);
@@ -1052,7 +1052,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
 		new_page = NULL;
 
-		new_inode->i_ctime = current_time(new_inode);
+		inode_set_ctime_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
 		if (old_dir_entry)
 			f2fs_i_links_write(new_inode, false);
@@ -1086,7 +1086,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
-	old_inode->i_ctime = current_time(old_inode);
+	inode_set_ctime_current(old_inode);
 	f2fs_mark_inode_dirty_sync(old_inode, false);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
@@ -1251,7 +1251,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
-	old_dir->i_ctime = current_time(old_dir);
+	inode_set_ctime_current(old_dir);
 	if (old_nlink) {
 		f2fs_down_write(&F2FS_I(old_dir)->i_sem);
 		f2fs_i_links_write(old_dir, old_nlink > 0);
@@ -1270,7 +1270,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_pino_write(new_inode, old_dir->i_ino);
 	f2fs_up_write(&F2FS_I(new_inode)->i_sem);
 
-	new_dir->i_ctime = current_time(new_dir);
+	inode_set_ctime_current(new_dir);
 	if (new_nlink) {
 		f2fs_down_write(&F2FS_I(new_dir)->i_sem);
 		f2fs_i_links_write(new_dir, new_nlink > 0);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4e7d4ceeb084..b8637e88d94f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -321,10 +321,10 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
-	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
+	inode_set_ctime(inode, le64_to_cpu(raw->i_ctime),
+			le32_to_cpu(raw->i_ctime_nsec));
 	inode->i_mtime.tv_sec = le64_to_cpu(raw->i_mtime);
 	inode->i_atime.tv_nsec = le32_to_cpu(raw->i_atime_nsec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(raw->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca31163da00a..28aeffc0048c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2703,7 +2703,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 	if (len == towrite)
 		return err;
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return len - towrite;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 476b186b90a6..4ae93e1df421 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -764,7 +764,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		clear_inode_flag(inode, FI_ACL_MODE);
 	}
 
-- 
2.41.0

