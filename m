Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5B6F59CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjECOVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjECOU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D565BE;
        Wed,  3 May 2023 07:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6D760B74;
        Wed,  3 May 2023 14:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05107C4339C;
        Wed,  3 May 2023 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123652;
        bh=r5kglyqnyJ7YcajVROoa4v4ejMgPkJhwiuOixesg33U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+LjYtJ5oYeNyriIgs8PjG8NY0mBWxXXjTjMov5iYUkXP9JCNLCIGD9UVAhSTbTNK
         mVL7JtM9+xaOsNxTx1iH7qUvVS/ZmcYrEKUo+LUwYvWrEid4BqSmAkmipoekcyG4L8
         QPsPXtjnB3KP3NRV/IK9b9aQvav7A6Dh1vOxsk96YDfzunuX8wmNQyFmo1UVBCuhGv
         EtG1hq5082tsDwhroQOmlexV/jpF03MqZp0TtY21BIJpF57+R/3PAVcs2jwzQQhcrK
         qehPc0i88lluWZ8FCfpQf+cXC2wWgsWh1rxIJkZlBL4MMKjclYInV8uneSonRnbUGg
         shQH/07/XUffg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 5/6] ext4: convert to multigrain timestamps
Date:   Wed,  3 May 2023 10:20:36 -0400
Message-Id: <20230503142037.153531-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503142037.153531-1-jlayton@kernel.org>
References: <20230503142037.153531-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/acl.c     |  2 +-
 fs/ext4/extents.c | 10 +++++-----
 fs/ext4/ialloc.c  |  2 +-
 fs/ext4/inline.c  |  4 ++--
 fs/ext4/inode.c   | 24 +++++++++++++++++++-----
 fs/ext4/ioctl.c   |  8 ++++----
 fs/ext4/namei.c   | 20 ++++++++++----------
 fs/ext4/super.c   |  4 ++--
 fs/ext4/xattr.c   |  2 +-
 9 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 27fcbddfb148..1f9cf0bdbd3f 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -259,7 +259,7 @@ ext4_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	error = __ext4_set_acl(handle, inode, type, acl, 0 /* xattr_flags */);
 	if (!error && update_mode) {
 		inode->i_mode = mode;
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		error = ext4_mark_inode_dirty(handle, inode);
 	}
 out_stop:
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..76ac6790869e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4484,7 +4484,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		map.m_lblk += ret;
 		map.m_len = len = len - ret;
 		epos = (loff_t)map.m_lblk << inode->i_blkbits;
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		if (new_size) {
 			if (epos > new_size)
 				epos = new_size;
@@ -4618,7 +4618,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		}
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode->i_ctime = current_ctime(inode);
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
@@ -4643,7 +4643,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_ctime(inode);
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5392,7 +5392,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_ctime(inode);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5509,7 +5509,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_ctime(inode);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 157663031f8c..cf6973286acc 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1248,7 +1248,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	inode->i_ino = ino + group * EXT4_INODES_PER_GROUP(sb);
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_ctime(inode);
 	ei->i_crtime = inode->i_mtime;
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1602d74b5eeb..6dbbd1a31fbe 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1054,7 +1054,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_ctime(dir);
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	return 1;
@@ -2015,7 +2015,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		ext4_orphan_del(handle, inode);
 
 	if (err == 0) {
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode->i_ctime = current_ctime(inode);
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf0b7dea4900..135fa0bf445c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4201,7 +4201,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_ctime(inode);
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
@@ -4361,7 +4361,7 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_ctime(inode);
 	err2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(err2 && !err))
 		err = err2;
@@ -4424,6 +4424,19 @@ static int ext4_inode_blocks_set(struct ext4_inode *raw_inode,
 	return 0;
 }
 
+static void ext4_inode_set_ctime(struct inode *inode, struct ext4_inode *raw_inode)
+{
+	struct timespec64 ctime = ctime_peek(inode);
+
+	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra)) {
+		raw_inode->i_ctime = cpu_to_le32(ctime.tv_sec);
+		raw_inode->i_ctime_extra = ext4_encode_extra_time(&ctime);
+	} else {
+		raw_inode->i_ctime = cpu_to_le32(clamp_t(int32_t,
+					ctime.tv_sec, S32_MIN, S32_MAX));
+	}
+}
+
 static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -4464,7 +4477,7 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 	}
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 
-	EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+	ext4_inode_set_ctime(inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
@@ -5172,7 +5185,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
-		EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+		ext4_inode_set_ctime(inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 		ext4_inode_csum_set(inode, raw_inode, ei);
@@ -5568,7 +5581,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 * update c/mtime in shrink case below
 			 */
 			if (!shrink) {
-				inode->i_mtime = current_time(inode);
+				inode->i_mtime = current_ctime(inode);
 				inode->i_ctime = inode->i_mtime;
 			}
 
@@ -5729,6 +5742,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_VERITY);
 
 	generic_fillattr(idmap, inode, stat);
+	generic_fill_multigrain_cmtime(request_mask, inode, stat);
 	return 0;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f9a430152063..4244ea049065 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -449,7 +449,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	diff = size - size_bl;
 	swap_inode_data(inode, inode_bl);
 
-	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
+	inode->i_ctime = inode_bl->i_ctime = current_ctime(inode);
 	inode_inc_iversion(inode);
 
 	inode->i_generation = get_random_u32();
@@ -663,7 +663,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 
 	ext4_set_inode_flags(inode, false);
 
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	inode_inc_iversion(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
@@ -774,7 +774,7 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 	}
 
 	EXT4_I(inode)->i_projid = kprojid;
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	inode_inc_iversion(inode);
 out_dirty:
 	rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
@@ -1257,7 +1257,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		err = ext4_reserve_inode_write(handle, inode, &iloc);
 		if (err == 0) {
-			inode->i_ctime = current_time(inode);
+			inode->i_ctime = current_ctime(inode);
 			inode_inc_iversion(inode);
 			inode->i_generation = generation;
 			err = ext4_mark_iloc_dirty(handle, inode, &iloc);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a5010b5b8a8c..1615ae8f8026 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2187,7 +2187,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_ctime(dir);
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	err2 = ext4_mark_inode_dirty(handle, dir);
@@ -3176,7 +3176,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	 * recovery. */
 	inode->i_size = 0;
 	ext4_orphan_add(handle, inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_ctime(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (retval)
 		goto end_rmdir;
@@ -3250,7 +3250,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		retval = ext4_delete_entry(handle, dir, de, bh);
 		if (retval)
 			goto out_handle;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
+		dir->i_ctime = dir->i_mtime = current_ctime(dir);
 		ext4_update_dx_flag(dir);
 		retval = ext4_mark_inode_dirty(handle, dir);
 		if (retval)
@@ -3265,7 +3265,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		drop_nlink(inode);
 	if (!inode->i_nlink)
 		ext4_orphan_add(handle, inode);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (dentry && !retval)
 		ext4_fc_track_unlink(handle, dentry);
@@ -3442,7 +3442,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	ext4_inc_count(inode);
 	ihold(inode);
 
@@ -3621,7 +3621,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 		ent->de->file_type = file_type;
 	inode_inc_iversion(ent->dir);
 	ent->dir->i_ctime = ent->dir->i_mtime =
-		current_time(ent->dir);
+		current_ctime(ent->dir);
 	retval = ext4_mark_inode_dirty(handle, ent->dir);
 	BUFFER_TRACE(ent->bh, "call ext4_handle_dirty_metadata");
 	if (!ent->inlined) {
@@ -3929,7 +3929,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old.inode->i_ctime = current_time(old.inode);
+	old.inode->i_ctime = current_ctime(old.inode);
 	retval = ext4_mark_inode_dirty(handle, old.inode);
 	if (unlikely(retval))
 		goto end_rename;
@@ -3943,9 +3943,9 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (new.inode) {
 		ext4_dec_count(new.inode);
-		new.inode->i_ctime = current_time(new.inode);
+		new.inode->i_ctime = current_ctime(new.inode);
 	}
-	old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
+	old.dir->i_ctime = old.dir->i_mtime = current_ctime(old.dir);
 	ext4_update_dx_flag(old.dir);
 	if (old.dir_bh) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
@@ -4139,7 +4139,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	ctime = current_time(old.inode);
+	ctime = current_ctime(old.inode);
 	old.inode->i_ctime = ctime;
 	new.inode->i_ctime = ctime;
 	retval = ext4_mark_inode_dirty(handle, old.inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f43e526112ae..cca7726eceff 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7051,7 +7051,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	}
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime = current_ctime(inode);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
@@ -7227,7 +7227,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MULTIGRAIN_TS,
 };
 MODULE_ALIAS_FS("ext4");
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 767454d74cd6..160f203d211e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2475,7 +2475,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 	}
 	if (!error) {
 		ext4_xattr_update_super_block(handle, inode->i_sb);
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		inode_inc_iversion(inode);
 		if (!value)
 			no_expand = 0;
-- 
2.40.1

