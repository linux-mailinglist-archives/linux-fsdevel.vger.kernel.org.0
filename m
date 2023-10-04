Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34237B8C16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbjJDSzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbjJDSzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E551700;
        Wed,  4 Oct 2023 11:54:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CC9C433C9;
        Wed,  4 Oct 2023 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445675;
        bh=/kKgNf3hiywveCMaNEhTJVWgpunI2TCWSMxTobQT/no=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aFtKkyn6j6x9UKSY+HeZ3Qhfc5ZbHtPRsdCXLU2B2m0lEYN2dCcvZxh0pbGM97BTJ
         6VgTn5nD7IfDM+MOl6gwYRkD/+Yysf3z6pF2zIm4JWvnwrQVtb8Whp+0OSodZ6FUFF
         oxXaYNo4w0RMYHZuZcDkEGXBClzo4UWx7dAxbvnc0foMlrGrZMfgZci2+kYhYmDUiC
         eiYGg2Cb7lPEpxA1Nc6LcGA5WhWcRVozm1aBM6il+1rqPVpGJEeTNGaDWVXVvMBoFJ
         v/VtQLhnRV3hooJUie08JSyDu3ublJJaDzLjylivrAQtGWfgyuVQnLMFwZhII1B5gO
         P/ZmV/qtPAexA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 42/89] hfsplus: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:27 -0400
Message-ID: <20231004185347.80880-40-jlayton@kernel.org>
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
 fs/hfsplus/catalog.c |  8 ++++----
 fs/hfsplus/inode.c   | 22 ++++++++++++----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index e71ae2537eaa..1995bafee839 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -312,7 +312,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	dir->i_size++;
 	if (S_ISDIR(inode->i_mode))
 		hfsplus_subfolders_inc(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	hfs_find_exit(&fd);
@@ -417,7 +417,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	dir->i_size--;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
@@ -494,7 +494,7 @@ int hfsplus_rename_cat(u32 cnid,
 	dst_dir->i_size++;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_inc(dst_dir);
-	dst_dir->i_mtime = inode_set_ctime_current(dst_dir);
+	inode_set_mtime_to_ts(dst_dir, inode_set_ctime_current(dst_dir));
 
 	/* finally remove the old entry */
 	err = hfsplus_cat_build_key(sb, src_fd.search_key,
@@ -511,7 +511,7 @@ int hfsplus_rename_cat(u32 cnid,
 	src_dir->i_size--;
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(src_dir);
-	src_dir->i_mtime = inode_set_ctime_current(src_dir);
+	inode_set_mtime_to_ts(src_dir, inode_set_ctime_current(src_dir));
 
 	/* remove old thread entry */
 	hfsplus_cat_build_key_with_cnid(sb, src_fd.search_key, cnid);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c65c8c4b03dd..702a0663b1d8 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -267,7 +267,7 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 		}
 		truncate_setsize(inode, attr->ia_size);
 		hfsplus_file_truncate(inode);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
@@ -392,7 +392,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 	inode->i_ino = sbi->next_cnid++;
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	set_nlink(inode, 1);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	hip = HFSPLUS_I(inode);
 	INIT_LIST_HEAD(&hip->open_dir_list);
@@ -521,8 +521,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		hfsplus_get_perms(inode, &folder->permissions, 1);
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
-		inode->i_atime = hfsp_mt2ut(folder->access_date);
-		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
+		inode_set_atime_to_ts(inode, hfsp_mt2ut(folder->access_date));
+		inode_set_mtime_to_ts(inode,
+				      hfsp_mt2ut(folder->content_mod_date));
 		inode_set_ctime_to_ts(inode,
 				      hfsp_mt2ut(folder->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = folder->create_date;
@@ -563,8 +564,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
-		inode->i_atime = hfsp_mt2ut(file->access_date);
-		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
+		inode_set_atime_to_ts(inode, hfsp_mt2ut(file->access_date));
+		inode_set_mtime_to_ts(inode,
+				      hfsp_mt2ut(file->content_mod_date));
 		inode_set_ctime_to_ts(inode,
 				      hfsp_mt2ut(file->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = file->create_date;
@@ -609,8 +611,8 @@ int hfsplus_cat_write_inode(struct inode *inode)
 					sizeof(struct hfsplus_cat_folder));
 		/* simple node checks? */
 		hfsplus_cat_set_perms(inode, &folder->permissions);
-		folder->access_date = hfsp_ut2mt(inode->i_atime);
-		folder->content_mod_date = hfsp_ut2mt(inode->i_mtime);
+		folder->access_date = hfsp_ut2mt(inode_get_atime(inode));
+		folder->content_mod_date = hfsp_ut2mt(inode_get_mtime(inode));
 		folder->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
 		folder->valence = cpu_to_be32(inode->i_size - 2);
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
@@ -644,8 +646,8 @@ int hfsplus_cat_write_inode(struct inode *inode)
 			file->flags |= cpu_to_be16(HFSPLUS_FILE_LOCKED);
 		else
 			file->flags &= cpu_to_be16(~HFSPLUS_FILE_LOCKED);
-		file->access_date = hfsp_ut2mt(inode->i_atime);
-		file->content_mod_date = hfsp_ut2mt(inode->i_mtime);
+		file->access_date = hfsp_ut2mt(inode_get_atime(inode));
+		file->content_mod_date = hfsp_ut2mt(inode_get_mtime(inode));
 		file->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
 		hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
 					 sizeof(struct hfsplus_cat_file));
-- 
2.41.0

