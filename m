Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F67B8BD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245014AbjJDSzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbjJDSyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260410E6;
        Wed,  4 Oct 2023 11:54:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E217C433C9;
        Wed,  4 Oct 2023 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445668;
        bh=tCBISPWGGNokIp2mrKL+31cK3tG8P238OYYBHV60Bhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICpZaDp8WPBHBzLqiwbH/Lg9p8LqbmsgAz7ulyJIv6dJOBISnqcve+wUh6Zcf2btx
         St/t/TMAZZ1NzxOSbq/KBJEHzjj+IrrJgbK5EoJpSCBYz20pcqPFS/mpAhSXCekEn9
         cLmP/yWN514DmpRWQfmTtMv5JXd+KUMhb/0cyRUh6THVMjWhFO7Efk//qpPDMCd2hO
         VX9VWcObdPAQGh0AdWoogJCMRtZxsHlluAJC2quCjHtZZ63/wE2YrmKkO4taQM3hG3
         ce6ddArmxDDgs2kzjMUNNAIUH6foN75SSkT14ADF2XtwEsR/2r8+YO8dm3SmjAZVX5
         AAQ4C+I0Qm5Tw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v2 36/89] f2fs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:21 -0400
Message-ID: <20231004185347.80880-34-jlayton@kernel.org>
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
 fs/f2fs/dir.c      |  6 +++---
 fs/f2fs/f2fs.h     | 10 ++++++----
 fs/f2fs/file.c     | 14 +++++++-------
 fs/f2fs/inline.c   |  2 +-
 fs/f2fs/inode.c    | 24 ++++++++++++------------
 fs/f2fs/namei.c    |  4 ++--
 fs/f2fs/recovery.c |  8 ++++----
 fs/f2fs/super.c    |  2 +-
 8 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8aa29fe2e87b..042593aed1ec 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -455,7 +455,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
 	set_page_dirty(page);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 	f2fs_put_page(page, 1);
 }
@@ -609,7 +609,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 			f2fs_i_links_write(dir, true);
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
@@ -919,7 +919,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	}
 	f2fs_put_page(page, 1);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3878288122ee..9043cedfa12b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3318,13 +3318,15 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_is_time_consistent(struct inode *inode)
 {
-	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 ts = inode_get_atime(inode);
 
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &ts))
 		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &ctime))
+	ts = inode_get_ctime(inode);
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &ts))
 		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
+	ts = inode_get_mtime(inode);
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &ts))
 		return false;
 	return true;
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 161826c6e200..5769c9879e79 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -798,7 +798,7 @@ int f2fs_truncate(struct inode *inode)
 	if (err)
 		return err;
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return 0;
 }
@@ -905,9 +905,9 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
+		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
 	if (ia_valid & ATTR_CTIME)
 		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
@@ -1012,7 +1012,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			return err;
 
 		spin_lock(&F2FS_I(inode)->i_size_lock);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
@@ -1840,7 +1840,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (!ret) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		f2fs_mark_inode_dirty_sync(inode, false);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
@@ -2888,10 +2888,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (ret)
 		goto out_unlock;
 
-	src->i_mtime = inode_set_ctime_current(src);
+	inode_set_mtime_to_ts(src, inode_set_ctime_current(src));
 	f2fs_mark_inode_dirty_sync(src, false);
 	if (src != dst) {
-		dst->i_mtime = inode_set_ctime_current(dst);
+		inode_set_mtime_to_ts(dst, inode_set_ctime_current(dst));
 		f2fs_mark_inode_dirty_sync(dst, false);
 	}
 	f2fs_update_time(sbi, REQ_TIME);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 2fe25619ccb5..ac00423f117b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -699,7 +699,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cde243840abd..5779c7edd49b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -386,9 +386,9 @@ static void init_idisk_time(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	fi->i_disk_time[0] = inode->i_atime;
+	fi->i_disk_time[0] = inode_get_atime(inode);
 	fi->i_disk_time[1] = inode_get_ctime(inode);
-	fi->i_disk_time[2] = inode->i_mtime;
+	fi->i_disk_time[2] = inode_get_mtime(inode);
 }
 
 static int do_read_inode(struct inode *inode)
@@ -417,12 +417,12 @@ static int do_read_inode(struct inode *inode)
 	inode->i_size = le64_to_cpu(ri->i_size);
 	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks) - 1);
 
-	inode->i_atime.tv_sec = le64_to_cpu(ri->i_atime);
+	inode_set_atime(inode, le64_to_cpu(ri->i_atime),
+			le32_to_cpu(ri->i_atime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(ri->i_ctime),
 			le32_to_cpu(ri->i_ctime_nsec));
-	inode->i_mtime.tv_sec = le64_to_cpu(ri->i_mtime);
-	inode->i_atime.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
-	inode->i_mtime.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
+	inode_set_mtime(inode, le64_to_cpu(ri->i_mtime),
+			le32_to_cpu(ri->i_mtime_nsec));
 	inode->i_generation = le32_to_cpu(ri->i_generation);
 	if (S_ISDIR(inode->i_mode))
 		fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
@@ -698,12 +698,12 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	}
 	set_raw_inline(inode, ri);
 
-	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	ri->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	ri->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
-	ri->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
-	ri->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	ri->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	ri->i_atime = cpu_to_le64(inode_get_atime_sec(inode));
+	ri->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	ri->i_mtime = cpu_to_le64(inode_get_mtime_sec(inode));
+	ri->i_atime_nsec = cpu_to_le32(inode_get_atime_nsec(inode));
+	ri->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
+	ri->i_mtime_nsec = cpu_to_le32(inode_get_mtime_nsec(inode));
 	if (S_ISDIR(inode->i_mode))
 		ri->i_current_depth =
 			cpu_to_le32(F2FS_I(inode)->i_current_depth);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 193b22a2d6bf..d0053b0284d8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -243,8 +243,8 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	F2FS_I(inode)->i_crtime = inode->i_mtime;
+	simple_inode_init_ts(inode);
+	F2FS_I(inode)->i_crtime = inode_get_mtime(inode);
 	inode->i_generation = get_random_u32();
 
 	if (S_ISDIR(inode->i_mode))
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7be60df277a5..b56d0f1078a7 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -320,12 +320,12 @@ static int recover_inode(struct inode *inode, struct page *page)
 	}
 
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
-	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
+	inode_set_atime(inode, le64_to_cpu(raw->i_atime),
+			le32_to_cpu(raw->i_atime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(raw->i_ctime),
 			le32_to_cpu(raw->i_ctime_nsec));
-	inode->i_mtime.tv_sec = le64_to_cpu(raw->i_mtime);
-	inode->i_atime.tv_nsec = le32_to_cpu(raw->i_atime_nsec);
-	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
+	inode_set_mtime(inode, le64_to_cpu(raw->i_mtime),
+			le32_to_cpu(raw->i_mtime_nsec));
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a61be3204c54..0118405467ce 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2758,7 +2758,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 	if (len == towrite)
 		return err;
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return len - towrite;
 }
-- 
2.41.0

