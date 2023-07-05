Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B995748D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjGETHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjGETGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FB91BFB;
        Wed,  5 Jul 2023 12:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE32616EE;
        Wed,  5 Jul 2023 19:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D642CC433C8;
        Wed,  5 Jul 2023 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583871;
        bh=pAYK4jRtSf2dl/XbNth++d6zVtmL9UNXNT5q53wy680=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjgNmrT6kfJhbF1rqw26ri9S7MpH8jneiGey1PHyURAePU7V1/RIH0FVvx0K2fwks
         v54dds3zQzTObuXYFSmfibLNT1hBKD+3/ntCjJyKw5z1h0Aq1VVH7coExp+egUzM/o
         GhXJVDNWz/aBnsTIj9ljdQYh6XNOLKyYgkQpYGQtebTcCu9TkkvNCbKyU4WON4KFJ6
         MugXI0YMogsWOPJCDJfuoO7dygvzl6/t7AKCN5Krb+GCxhKPaNDNF/+EK+SB2kRDeb
         UR7gl73Ai3qn3R2sLDDNs9pB5lqt4UA/vDQ6TZwIQN3l1MhC54EsuXWmrfE8ecZ86o
         ply0teg9xRvNQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 49/92] hfsplus: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:14 -0400
Message-ID: <20230705190309.579783-47-jlayton@kernel.org>
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
 fs/hfsplus/catalog.c |  8 ++++----
 fs/hfsplus/dir.c     |  6 +++---
 fs/hfsplus/inode.c   | 16 +++++++++-------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 35472cba750e..e71ae2537eaa 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -312,7 +312,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	dir->i_size++;
 	if (S_ISDIR(inode->i_mode))
 		hfsplus_subfolders_inc(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	hfs_find_exit(&fd);
@@ -417,7 +417,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	dir->i_size--;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
@@ -494,7 +494,7 @@ int hfsplus_rename_cat(u32 cnid,
 	dst_dir->i_size++;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_inc(dst_dir);
-	dst_dir->i_mtime = dst_dir->i_ctime = current_time(dst_dir);
+	dst_dir->i_mtime = inode_set_ctime_current(dst_dir);
 
 	/* finally remove the old entry */
 	err = hfsplus_cat_build_key(sb, src_fd.search_key,
@@ -511,7 +511,7 @@ int hfsplus_rename_cat(u32 cnid,
 	src_dir->i_size--;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(src_dir);
-	src_dir->i_mtime = src_dir->i_ctime = current_time(src_dir);
+	src_dir->i_mtime = inode_set_ctime_current(src_dir);
 
 	/* remove old thread entry */
 	hfsplus_cat_build_key_with_cnid(sb, src_fd.search_key, cnid);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 56fb5f1312e7..f5c4b3e31a1c 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -346,7 +346,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	inc_nlink(inode);
 	hfsplus_instantiate(dst_dentry, inode, cnid);
 	ihold(inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 	sbi->file_count++;
 	hfsplus_mark_mdb_dirty(dst_dir->i_sb);
@@ -405,7 +405,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 			hfsplus_delete_inode(inode);
 	} else
 		sbi->file_count--;
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 out:
 	mutex_unlock(&sbi->vh_mutex);
@@ -426,7 +426,7 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 	if (res)
 		goto out;
 	clear_nlink(inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	hfsplus_delete_inode(inode);
 	mark_inode_dirty(inode);
 out:
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7d1a675e037d..40c61ab4a918 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -267,7 +267,7 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 		}
 		truncate_setsize(inode, attr->ia_size);
 		hfsplus_file_truncate(inode);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 	}
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
@@ -392,7 +392,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 	inode->i_ino = sbi->next_cnid++;
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	set_nlink(inode, 1);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 
 	hip = HFSPLUS_I(inode);
 	INIT_LIST_HEAD(&hip->open_dir_list);
@@ -523,7 +523,8 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
 		inode->i_atime = hfsp_mt2ut(folder->access_date);
 		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
-		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
+		inode_set_ctime_to_ts(inode,
+				      hfsp_mt2ut(folder->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = folder->create_date;
 		HFSPLUS_I(inode)->fs_blocks = 0;
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
@@ -564,7 +565,8 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		}
 		inode->i_atime = hfsp_mt2ut(file->access_date);
 		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
-		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
+		inode_set_ctime_to_ts(inode,
+				      hfsp_mt2ut(file->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = file->create_date;
 	} else {
 		pr_err("bad catalog entry used to create inode\n");
@@ -609,7 +611,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 		hfsplus_cat_set_perms(inode, &folder->permissions);
 		folder->access_date = hfsp_ut2mt(inode->i_atime);
 		folder->content_mod_date = hfsp_ut2mt(inode->i_mtime);
-		folder->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
+		folder->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
 		folder->valence = cpu_to_be32(inode->i_size - 2);
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
 			folder->subfolders =
@@ -644,7 +646,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 			file->flags &= cpu_to_be16(~HFSPLUS_FILE_LOCKED);
 		file->access_date = hfsp_ut2mt(inode->i_atime);
 		file->content_mod_date = hfsp_ut2mt(inode->i_mtime);
-		file->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
+		file->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
 		hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
 					 sizeof(struct hfsplus_cat_file));
 	}
@@ -700,7 +702,7 @@ int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 	else
 		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 
 	return 0;
-- 
2.41.0

