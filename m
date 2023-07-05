Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B88748D5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjGETJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjGETIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F383A90;
        Wed,  5 Jul 2023 12:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC986170C;
        Wed,  5 Jul 2023 19:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEE8C433C7;
        Wed,  5 Jul 2023 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583929;
        bh=N41sRvjWUM+giT4o3DhV73SdjvTXgpcGef0e4/i5ocI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/ks/Box9NsEnOZQZvnpvhRQ/USiaZ3FgZrclMtifuYNtg+IL69Jmh62tTnfUXje/
         gK4OhCeeZZ8HcdybEe7MXgXYqjLC16dt6olv95JTzqp3KHaiIKkafvONho9tubIKWz
         BvK/MSBJDZ0uKdwZDDY0DQb0v0Wdofjivy8L3881bPLMBHCRSVp9MBWsPHnQJ4v9Yy
         PeHAjw1cgrzb/fRk0wO/cRRQe1lZFmBXmDVCeLxc3rYg6E6G7pNvJ4TszMOKV0p5N7
         EeRwW6vQiWuS2nolqi5GFFM1G6pHF5r53c35BvSULk5xuP09D/tGQOvZJUmKn2cCFh
         FV4nTh24U1YoA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 80/92] ufs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:45 -0400
Message-ID: <20230705190309.579783-78-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 fs/ufs/dir.c    |  6 +++---
 fs/ufs/ialloc.c |  2 +-
 fs/ufs/inode.c  | 23 +++++++++++++----------
 fs/ufs/namei.c  |  8 ++++----
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 379d75796a5c..fd57f03b6c93 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -107,7 +107,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_commit_chunk(page, pos, len);
 	ufs_put_page(page);
 	if (update_times)
-		dir->i_mtime = dir->i_ctime = current_time(dir);
+		dir->i_mtime = inode_set_ctime_current(dir);
 	mark_inode_dirty(dir);
 	ufs_handle_dirsync(dir);
 }
@@ -397,7 +397,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	ufs_set_de_type(sb, de, inode->i_mode);
 
 	ufs_commit_chunk(page, pos, rec_len);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 
 	mark_inode_dirty(dir);
 	err = ufs_handle_dirsync(dir);
@@ -539,7 +539,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
 	ufs_commit_chunk(page, pos, to - from);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
 out:
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 06bd84d555bd..a1e7bd9d1f98 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -292,7 +292,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_blocks = 0;
 	inode->i_generation = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	ufsi->i_flags = UFS_I(dir)->i_flags;
 	ufsi->i_lastfrag = 0;
 	ufsi->i_shadow = 0;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a4246c83a8cd..21a4779a2de5 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -296,7 +296,7 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 
 	if (new)
 		*new = 1;
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	if (IS_SYNC(inode))
 		ufs_sync_inode (inode);
 	mark_inode_dirty(inode);
@@ -378,7 +378,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 	mark_buffer_dirty(bh);
 	if (IS_SYNC(inode))
 		sync_dirty_buffer(bh);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 out:
 	brelse (bh);
@@ -580,11 +580,12 @@ static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 
 	inode->i_size = fs64_to_cpu(sb, ufs_inode->ui_size);
 	inode->i_atime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_atime.tv_sec);
-	inode->i_ctime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_ctime.tv_sec);
+	inode_set_ctime(inode,
+			(signed)fs32_to_cpu(sb, ufs_inode->ui_ctime.tv_sec),
+			0);
 	inode->i_mtime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_mtime.tv_sec);
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
 	inode->i_blocks = fs32_to_cpu(sb, ufs_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs_inode->ui_gen);
 	ufsi->i_flags = fs32_to_cpu(sb, ufs_inode->ui_flags);
@@ -626,10 +627,10 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 
 	inode->i_size = fs64_to_cpu(sb, ufs2_inode->ui_size);
 	inode->i_atime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_atime);
-	inode->i_ctime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_ctime);
+	inode_set_ctime(inode, fs64_to_cpu(sb, ufs2_inode->ui_ctime),
+			fs32_to_cpu(sb, ufs2_inode->ui_ctimensec));
 	inode->i_mtime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_mtime);
 	inode->i_atime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_atimensec);
-	inode->i_ctime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_ctimensec);
 	inode->i_mtime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_mtimensec);
 	inode->i_blocks = fs64_to_cpu(sb, ufs2_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs2_inode->ui_gen);
@@ -726,7 +727,8 @@ static void ufs1_update_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
 	ufs_inode->ui_atime.tv_sec = cpu_to_fs32(sb, inode->i_atime.tv_sec);
 	ufs_inode->ui_atime.tv_usec = 0;
-	ufs_inode->ui_ctime.tv_sec = cpu_to_fs32(sb, inode->i_ctime.tv_sec);
+	ufs_inode->ui_ctime.tv_sec = cpu_to_fs32(sb,
+						 inode_get_ctime(inode).tv_sec);
 	ufs_inode->ui_ctime.tv_usec = 0;
 	ufs_inode->ui_mtime.tv_sec = cpu_to_fs32(sb, inode->i_mtime.tv_sec);
 	ufs_inode->ui_mtime.tv_usec = 0;
@@ -770,8 +772,9 @@ static void ufs2_update_inode(struct inode *inode, struct ufs2_inode *ufs_inode)
 	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
 	ufs_inode->ui_atime = cpu_to_fs64(sb, inode->i_atime.tv_sec);
 	ufs_inode->ui_atimensec = cpu_to_fs32(sb, inode->i_atime.tv_nsec);
-	ufs_inode->ui_ctime = cpu_to_fs64(sb, inode->i_ctime.tv_sec);
-	ufs_inode->ui_ctimensec = cpu_to_fs32(sb, inode->i_ctime.tv_nsec);
+	ufs_inode->ui_ctime = cpu_to_fs64(sb, inode_get_ctime(inode).tv_sec);
+	ufs_inode->ui_ctimensec = cpu_to_fs32(sb,
+					      inode_get_ctime(inode).tv_nsec);
 	ufs_inode->ui_mtime = cpu_to_fs64(sb, inode->i_mtime.tv_sec);
 	ufs_inode->ui_mtimensec = cpu_to_fs32(sb, inode->i_mtime.tv_nsec);
 
@@ -1205,7 +1208,7 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 	truncate_setsize(inode, size);
 
 	ufs_truncate_blocks(inode);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 out:
 	UFSD("EXIT: err %d\n", err);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 36154b5aca6d..9cad29463791 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -153,7 +153,7 @@ static int ufs_link (struct dentry * old_dentry, struct inode * dir,
 	struct inode *inode = d_inode(old_dentry);
 	int error;
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 
@@ -220,7 +220,7 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	inode->i_ctime = dir->i_ctime;
+	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 	inode_dec_link_count(inode);
 	err = 0;
 out:
@@ -282,7 +282,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (!new_de)
 			goto out_dir;
 		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
-		new_inode->i_ctime = current_time(new_inode);
+		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
@@ -298,7 +298,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * Like most other Unix systems, set the ctime for inodes on a
  	 * rename.
 	 */
-	old_inode->i_ctime = current_time(old_inode);
+	inode_set_ctime_current(old_inode);
 
 	ufs_delete_entry(old_dir, old_de, old_page);
 	mark_inode_dirty(old_inode);
-- 
2.41.0

