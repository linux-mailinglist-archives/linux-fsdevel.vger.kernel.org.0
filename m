Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DD748D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjGETHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjGETGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3F1BF9;
        Wed,  5 Jul 2023 12:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5193D61704;
        Wed,  5 Jul 2023 19:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EF2C433C9;
        Wed,  5 Jul 2023 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583869;
        bh=fywqEQ5cn0nBZC+81C4lX2F4icKWGKCzmTpyfqbEI3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exaQeWtd5Q2J4elDK1iAzvk5yuOP9uNBJe1CUBAAwLvJsAknEQroJ8chxO0EyZU8N
         PfgBukzVIs8ZZ6pw1HJDTq6kInMbC0gt2D8N3fWr33oORUEQaX3ZOia9zcDz6HJujF
         MynaMZl5/qsApY1vWM5cfQChw6bEsAPKDdaorCW/ww4svUgxIbhHALkQzBhstYCWth
         1HHwDwY6XH4h/IWMKhumEFgFsvWHgoAAv4WuCcJ8icf9/AinC8TBNx5X1o0ny+alcV
         icjaEPU09NmtS0/Km1dOvJjliokDn9plqnx12O0hytjC6Af2QEJkOIEwf2x7XGLbYX
         76CVrZF/b1zjQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 48/92] hfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:13 -0400
Message-ID: <20230705190309.579783-46-jlayton@kernel.org>
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
 fs/hfs/catalog.c |  8 ++++----
 fs/hfs/dir.c     |  2 +-
 fs/hfs/inode.c   | 13 ++++++-------
 fs/hfs/sysdep.c  |  4 +++-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index d365bf0b8c77..632c226a3972 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -133,7 +133,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
 		goto err1;
 
 	dir->i_size++;
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	mark_inode_dirty(dir);
 	hfs_find_exit(&fd);
 	return 0;
@@ -269,7 +269,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 	}
 
 	dir->i_size--;
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	mark_inode_dirty(dir);
 	res = 0;
 out:
@@ -337,7 +337,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	if (err)
 		goto out;
 	dst_dir->i_size++;
-	dst_dir->i_mtime = dst_dir->i_ctime = current_time(dst_dir);
+	dst_dir->i_mtime = inode_set_ctime_current(dst_dir);
 	mark_inode_dirty(dst_dir);
 
 	/* finally remove the old entry */
@@ -349,7 +349,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	if (err)
 		goto out;
 	src_dir->i_size--;
-	src_dir->i_mtime = src_dir->i_ctime = current_time(src_dir);
+	src_dir->i_mtime = inode_set_ctime_current(src_dir);
 	mark_inode_dirty(src_dir);
 
 	type = entry.type;
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 3e1e3dcf0b48..b75c26045df4 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -263,7 +263,7 @@ static int hfs_remove(struct inode *dir, struct dentry *dentry)
 	if (res)
 		return res;
 	clear_nlink(inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	hfs_delete_inode(inode);
 	mark_inode_dirty(inode);
 	return 0;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 441d7fc952e3..ee349b72cfb3 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -200,7 +200,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	set_nlink(inode, 1);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
@@ -355,8 +355,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 			inode->i_mode |= S_IWUGO;
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
-		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				hfs_m_to_utime(rec->file.MdDat);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode,
+									hfs_m_to_utime(rec->file.MdDat));
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -366,8 +366,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				hfs_m_to_utime(rec->dir.MdDat);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode,
+									hfs_m_to_utime(rec->dir.MdDat));
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
@@ -654,8 +654,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 		truncate_setsize(inode, attr->ia_size);
 		hfs_file_truncate(inode);
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-						  current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	}
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
diff --git a/fs/hfs/sysdep.c b/fs/hfs/sysdep.c
index 2875961fdc10..dc27d418fbcd 100644
--- a/fs/hfs/sysdep.c
+++ b/fs/hfs/sysdep.c
@@ -28,7 +28,9 @@ static int hfs_revalidate_dentry(struct dentry *dentry, unsigned int flags)
 	/* fix up inode on a timezone change */
 	diff = sys_tz.tz_minuteswest * 60 - HFS_I(inode)->tz_secondswest;
 	if (diff) {
-		inode->i_ctime.tv_sec += diff;
+		struct timespec64 ctime = inode_get_ctime(inode);
+
+		inode_set_ctime(inode, ctime.tv_sec + diff, ctime.tv_nsec);
 		inode->i_atime.tv_sec += diff;
 		inode->i_mtime.tv_sec += diff;
 		HFS_I(inode)->tz_secondswest += diff;
-- 
2.41.0

