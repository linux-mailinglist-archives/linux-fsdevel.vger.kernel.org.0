Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF247B8B99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbjJDSzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbjJDSzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8C1705;
        Wed,  4 Oct 2023 11:54:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A257CC433C7;
        Wed,  4 Oct 2023 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445678;
        bh=bLOrGme+RocfazPEaVBFlntuWpbBmOjToSJmxl7XT9g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IJswiSnHIepUEQ2yQhrZdxCpsZgeDuSPwEzgVpqjE7kxYeWuWBxq3xV43pnyJ0Qwk
         HqAt1+isGv5RlPitoJptpGyeIagVq/C/2rM+TQRpGOqGPwrxbVRz7/TB1zwtGD5fof
         xSSUBqcrWwqOudPk21zRel/WG4a5wr699rtJW4qRFVgePNhhQ0hqSnoB81kK17p2Zb
         so821YrSS3LLudTKJTJSVDfRAPsL+9y3hvTcxqF/UVtS+Ak9EiIJR2MQQehSQS4smW
         6HgFTPLmhg5o+FMIpoUO2LXHdBOo80kXGPqLPU0aP5lrdlv/RlOzxKDptOCUPvBPoi
         5Us7cwpiKLu4w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/89] hpfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:29 -0400
Message-ID: <20231004185347.80880-42-jlayton@kernel.org>
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
 fs/hpfs/dir.c   | 12 +++++++-----
 fs/hpfs/inode.c | 16 ++++++++--------
 fs/hpfs/namei.c | 22 +++++++++++-----------
 fs/hpfs/super.c | 10 ++++++----
 4 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index f36566d61215..49dd585c2b17 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -277,14 +277,16 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	 * inode.
 	 */
 
-	if (!inode_get_ctime(result).tv_sec) {
+	if (!inode_get_ctime_sec(result)) {
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
index 479166378bae..a59e8fa630db 100644
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
@@ -230,9 +230,9 @@ void hpfs_write_inode_nolock(struct inode *i)
 	}
 	hpfs_write_inode_ea(i, fnode);
 	if (de) {
-		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
-		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime(i).tv_sec));
+		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_mtime_sec(i)));
+		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_atime_sec(i)));
+		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime_sec(i)));
 		de->read_only = !(i->i_mode & 0222);
 		de->ea_size = cpu_to_le32(hpfs_inode->i_ea_size);
 		hpfs_mark_4buffers_dirty(&qbh);
@@ -240,9 +240,9 @@ void hpfs_write_inode_nolock(struct inode *i)
 	}
 	if (S_ISDIR(i->i_mode)) {
 		if ((de = map_dirent(i, hpfs_inode->i_dno, "\001\001", 2, NULL, &qbh))) {
-			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
-			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime(i).tv_sec));
+			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_mtime_sec(i)));
+			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_atime_sec(i)));
+			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime_sec(i)));
 			de->read_only = !(i->i_mode & 0222);
 			de->ea_size = cpu_to_le32(/*hpfs_inode->i_ea_size*/0);
 			de->file_size = cpu_to_le32(0);
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index f4eb8d6f5989..9184b4584b01 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -12,10 +12,10 @@
 static void hpfs_update_directory_times(struct inode *dir)
 {
 	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
-	if (t == dir->i_mtime.tv_sec &&
-	    t == inode_get_ctime(dir).tv_sec)
+	if (t == inode_get_mtime_sec(dir) &&
+	    t == inode_get_ctime_sec(dir))
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

