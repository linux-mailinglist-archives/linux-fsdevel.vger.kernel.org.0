Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7577387DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjFUOv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjFUOu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB992959;
        Wed, 21 Jun 2023 07:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F50615A1;
        Wed, 21 Jun 2023 14:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653C9C433C0;
        Wed, 21 Jun 2023 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358917;
        bh=04irOXozoqZySwXawSaTumKvdGyvq3lEBxeRjcB3L88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTQv9pQzZfnt0PUYvc0GBuyOYN8vKTZeQzPXgonRxjPD1o3DHEpGx5oC671009eLc
         ktq8RD5GIE9vUFul0+eHzeO8vFxQwbFQ8r/ea+jIa3YBECR3Jh/3AYWmVa1NWPEOlP
         wrm+JSQK6mWlZTQdX9f1VBvVK2LG2RLG0eYWkpDOoSZx9SbyPqQwOdJ/uQbetZYujo
         6v6Di6UPxLabwfZGXYfX+i4/cNdRJysQGOX+v4Zfa9no7IZvU4YYGjoLiq26Rk9V26
         BE+JAQFKXVrKScHKekIfQJoYZlWDMi/JRmm1fcQnoHdboNAMjRih2h6tTdmGvJneBT
         iCfmaEJxBQHGg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 36/79] hfsplus: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:49 -0400
Message-ID: <20230621144735.55953-35-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hfsplus/catalog.c |  8 ++++----
 fs/hfsplus/dir.c     |  6 +++---
 fs/hfsplus/inode.c   | 14 +++++++-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 35472cba750e..0e1938729669 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -312,7 +312,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	dir->i_size++;
 	if (S_ISDIR(inode->i_mode))
 		hfsplus_subfolders_inc(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	hfs_find_exit(&fd);
@@ -417,7 +417,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	dir->i_size--;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
@@ -494,7 +494,7 @@ int hfsplus_rename_cat(u32 cnid,
 	dst_dir->i_size++;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_inc(dst_dir);
-	dst_dir->i_mtime = dst_dir->i_ctime = current_time(dst_dir);
+	dst_dir->i_mtime = inode_ctime_set_current(dst_dir);
 
 	/* finally remove the old entry */
 	err = hfsplus_cat_build_key(sb, src_fd.search_key,
@@ -511,7 +511,7 @@ int hfsplus_rename_cat(u32 cnid,
 	src_dir->i_size--;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(src_dir);
-	src_dir->i_mtime = src_dir->i_ctime = current_time(src_dir);
+	src_dir->i_mtime = inode_ctime_set_current(src_dir);
 
 	/* remove old thread entry */
 	hfsplus_cat_build_key_with_cnid(sb, src_fd.search_key, cnid);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 56fb5f1312e7..e7b6de12ecef 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -346,7 +346,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	inc_nlink(inode);
 	hfsplus_instantiate(dst_dentry, inode, cnid);
 	ihold(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	sbi->file_count++;
 	hfsplus_mark_mdb_dirty(dst_dir->i_sb);
@@ -405,7 +405,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 			hfsplus_delete_inode(inode);
 	} else
 		sbi->file_count--;
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 out:
 	mutex_unlock(&sbi->vh_mutex);
@@ -426,7 +426,7 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 	if (res)
 		goto out;
 	clear_nlink(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	hfsplus_delete_inode(inode);
 	mark_inode_dirty(inode);
 out:
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7d1a675e037d..b9c02df839c8 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -267,7 +267,7 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 		}
 		truncate_setsize(inode, attr->ia_size);
 		hfsplus_file_truncate(inode);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 	}
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
@@ -392,7 +392,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 	inode->i_ino = sbi->next_cnid++;
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	set_nlink(inode, 1);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 
 	hip = HFSPLUS_I(inode);
 	INIT_LIST_HEAD(&hip->open_dir_list);
@@ -523,7 +523,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
 		inode->i_atime = hfsp_mt2ut(folder->access_date);
 		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
-		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
+		inode_ctime_set(inode, hfsp_mt2ut(folder->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = folder->create_date;
 		HFSPLUS_I(inode)->fs_blocks = 0;
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
@@ -564,7 +564,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		}
 		inode->i_atime = hfsp_mt2ut(file->access_date);
 		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
-		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
+		inode_ctime_set(inode, hfsp_mt2ut(file->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = file->create_date;
 	} else {
 		pr_err("bad catalog entry used to create inode\n");
@@ -609,7 +609,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 		hfsplus_cat_set_perms(inode, &folder->permissions);
 		folder->access_date = hfsp_ut2mt(inode->i_atime);
 		folder->content_mod_date = hfsp_ut2mt(inode->i_mtime);
-		folder->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
+		folder->attribute_mod_date = hfsp_ut2mt(inode_ctime_peek(inode));
 		folder->valence = cpu_to_be32(inode->i_size - 2);
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
 			folder->subfolders =
@@ -644,7 +644,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 			file->flags &= cpu_to_be16(~HFSPLUS_FILE_LOCKED);
 		file->access_date = hfsp_ut2mt(inode->i_atime);
 		file->content_mod_date = hfsp_ut2mt(inode->i_mtime);
-		file->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
+		file->attribute_mod_date = hfsp_ut2mt(inode_ctime_peek(inode));
 		hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
 					 sizeof(struct hfsplus_cat_file));
 	}
@@ -700,7 +700,7 @@ int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 	else
 		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 
 	return 0;
-- 
2.41.0

