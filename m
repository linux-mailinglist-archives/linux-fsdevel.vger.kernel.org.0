Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129C7B19FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjI1LIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjI1LGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:06:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F11727;
        Thu, 28 Sep 2023 04:05:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694DAC433CD;
        Thu, 28 Sep 2023 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899103;
        bh=9p+Br4Qd8T4+Podol5H0ddnyh0NUsxCG78yEaBv/aCU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SKXMQugzM+D+mRVDXdaaH5awFcy+VARhB9zdL/d8ZdPSjYyiV6bYnMImj4D+4wuHE
         JqcF92jLtBRSEor7bH14s9InP+3qNIiMhRePPnQeN6wW63lSBwb2GakCUEDsAIMp0+
         JXe6iZHDAHCz7TVZYdVxCoB98udF1JypUBd2YYnEcqNOBNGj9EMAbR6fOVjcEkwa5R
         mNPCkKWfSHlR/GlC6vkMWviE/96Zojzv3jk3axz9eKBKZs5ruaRqHJZbgPWxGUGubL
         KDAOXcuMP12Ge4idbDVN3zHFal+vR8hdBjjO0g/D+Jjuhg0fgBHIjOlQJH2YG6iLaQ
         XEydXPV2QRP8g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 43/87] fs/hpfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:52 -0400
Message-ID: <20230928110413.33032-42-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hpfs/dir.c   | 10 ++++++----
 fs/hpfs/inode.c | 12 ++++++------
 fs/hpfs/namei.c | 20 ++++++++++----------
 fs/hpfs/super.c | 10 ++++++----
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index f36566d61215..bd6ca49742d2 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -281,10 +281,12 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 		time64_t csec = local_to_gmt(dir->i_sb, le32_to_cpu(de->creation_date));
 
 		inode_set_ctime(result, csec ? csec : 1, 0);
-		result->i_mtime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->write_date));
-		result->i_mtime.tv_nsec = 0;
-		result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->read_date));
-		result->i_atime.tv_nsec = 0;
+		inode_set_mtime(result,
+				local_to_gmt(dir->i_sb, le32_to_cpu(de->write_date)),
+				0);
+		inode_set_atime(result,
+				local_to_gmt(dir->i_sb, le32_to_cpu(de->read_date)),
+				0);
 		hpfs_result->i_ea_size = le32_to_cpu(de->ea_size);
 		if (!hpfs_result->i_ea_mode && de->read_only)
 			result->i_mode &= ~0222;
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 479166378bae..b04e2d3d15f7 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -37,8 +37,8 @@ void hpfs_init_inode(struct inode *i)
 	hpfs_inode->i_dirty = 0;
 
 	inode_set_ctime(i, 0, 0);
-	i->i_mtime.tv_sec = i->i_mtime.tv_nsec = 0;
-	i->i_atime.tv_sec = i->i_atime.tv_nsec = 0;
+	inode_set_mtime(i, 0, 0);
+	inode_set_atime(i, 0, 0);
 }
 
 void hpfs_read_inode(struct inode *i)
@@ -230,8 +230,8 @@ void hpfs_write_inode_nolock(struct inode *i)
 	}
 	hpfs_write_inode_ea(i, fnode);
 	if (de) {
-		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
-		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
+		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_mtime(i).tv_sec));
+		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_atime(i).tv_sec));
 		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime(i).tv_sec));
 		de->read_only = !(i->i_mode & 0222);
 		de->ea_size = cpu_to_le32(hpfs_inode->i_ea_size);
@@ -240,8 +240,8 @@ void hpfs_write_inode_nolock(struct inode *i)
 	}
 	if (S_ISDIR(i->i_mode)) {
 		if ((de = map_dirent(i, hpfs_inode->i_dno, "\001\001", 2, NULL, &qbh))) {
-			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
-			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
+			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_mtime(i).tv_sec));
+			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_atime(i).tv_sec));
 			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime(i).tv_sec));
 			de->read_only = !(i->i_mode & 0222);
 			de->ea_size = cpu_to_le32(/*hpfs_inode->i_ea_size*/0);
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index f4eb8d6f5989..20f67da1cb20 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -12,10 +12,10 @@
 static void hpfs_update_directory_times(struct inode *dir)
 {
 	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
-	if (t == dir->i_mtime.tv_sec &&
+	if (t == inode_get_mtime(dir).tv_sec &&
 	    t == inode_get_ctime(dir).tv_sec)
 		return;
-	dir->i_mtime = inode_set_ctime(dir, t, 0);
+	inode_set_mtime_to_ts(dir, inode_set_ctime(dir, t, 0));
 	hpfs_write_inode_nolock(dir);
 }
 
@@ -58,8 +58,8 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
 	hpfs_i(result)->i_dno = dno;
-	result->i_mtime = result->i_atime =
-		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0);
+	inode_set_mtime_to_ts(result,
+			      inode_set_atime_to_ts(result, inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0)));
 	hpfs_i(result)->i_ea_size = 0;
 	result->i_mode |= S_IFDIR;
 	result->i_op = &hpfs_dir_iops;
@@ -164,8 +164,8 @@ static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_fop = &hpfs_file_ops;
 	set_nlink(result, 1);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_mtime = result->i_atime =
-		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0);
+	inode_set_mtime_to_ts(result,
+			      inode_set_atime_to_ts(result, inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0)));
 	hpfs_i(result)->i_ea_size = 0;
 	if (dee.read_only)
 		result->i_mode &= ~0222;
@@ -245,8 +245,8 @@ static int hpfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	hpfs_init_inode(result);
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_mtime = result->i_atime =
-		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0);
+	inode_set_mtime_to_ts(result,
+			      inode_set_atime_to_ts(result, inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0)));
 	hpfs_i(result)->i_ea_size = 0;
 	result->i_uid = current_fsuid();
 	result->i_gid = current_fsgid();
@@ -319,8 +319,8 @@ static int hpfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_ino = fno;
 	hpfs_init_inode(result);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_mtime = result->i_atime =
-		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0);
+	inode_set_mtime_to_ts(result,
+			      inode_set_atime_to_ts(result, inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0)));
 	hpfs_i(result)->i_ea_size = 0;
 	result->i_mode = S_IFLNK | 0777;
 	result->i_uid = current_fsuid();
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 758a51564124..6b0ba3c1efba 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -725,10 +725,12 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	if (!de)
 		hpfs_error(s, "unable to find root dir");
 	else {
-		root->i_atime.tv_sec = local_to_gmt(s, le32_to_cpu(de->read_date));
-		root->i_atime.tv_nsec = 0;
-		root->i_mtime.tv_sec = local_to_gmt(s, le32_to_cpu(de->write_date));
-		root->i_mtime.tv_nsec = 0;
+		inode_set_atime(root,
+				local_to_gmt(s, le32_to_cpu(de->read_date)),
+				0);
+		inode_set_mtime(root,
+				local_to_gmt(s, le32_to_cpu(de->write_date)),
+				0);
 		inode_set_ctime(root,
 				local_to_gmt(s, le32_to_cpu(de->creation_date)),
 				0);
-- 
2.41.0

