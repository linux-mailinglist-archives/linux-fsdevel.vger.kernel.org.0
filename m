Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AC7B8C75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbjJDS7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbjJDS5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DDC19BE;
        Wed,  4 Oct 2023 11:55:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4825C433CD;
        Wed,  4 Oct 2023 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445705;
        bh=yAeLI7C8FS/jnlSR3OJ6c14X/tE7zEDbA+SFSmoaVbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ShDFwKFrVrXVS+LxoFsHhwRpQx8Tw1iTmkncpeqoXnUU9c7aDmKet/YOTimS4BWLn
         4Jo+BqokYM+2say+UPeM9bRKV/f5Uf2VfHVX7SgDnZ2FHXVgBgg0FCVDuTAwHVhPAj
         JGA0T5G/2Zjvrd1NeZlEzJRUt8kiVVqO/3/RLb9nMBwNze3NyWVqxUVX09zsmVNl+g
         VyLTWQ5uw6lNmUX5opUQNHely2hX+27HZfmZKkXuvFehdXFmTmAi9FXLE3d0Y/FdAz
         v/onLQ9z0j73UA3bna7MkC2Xo8fqGw37upFMNSptQi7M7c7krzHPBQINufhFcBIWjW
         +4nenb+58VyHA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     reiserfs-devel@vger.kernel.org
Subject: [PATCH v2 66/89] reiserfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:51 -0400
Message-ID: <20231004185347.80880-64-jlayton@kernel.org>
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
 fs/reiserfs/inode.c | 26 +++++++++++---------------
 fs/reiserfs/namei.c |  8 ++++----
 fs/reiserfs/stree.c |  5 +++--
 fs/reiserfs/super.c |  2 +-
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 86e55d4bb10d..c8572346556f 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -1257,11 +1257,9 @@ static void init_inode(struct inode *inode, struct treepath *path)
 		i_uid_write(inode, sd_v1_uid(sd));
 		i_gid_write(inode, sd_v1_gid(sd));
 		inode->i_size = sd_v1_size(sd);
-		inode->i_atime.tv_sec = sd_v1_atime(sd);
-		inode->i_mtime.tv_sec = sd_v1_mtime(sd);
+		inode_set_atime(inode, sd_v1_atime(sd), 0);
+		inode_set_mtime(inode, sd_v1_mtime(sd), 0);
 		inode_set_ctime(inode, sd_v1_ctime(sd), 0);
-		inode->i_atime.tv_nsec = 0;
-		inode->i_mtime.tv_nsec = 0;
 
 		inode->i_blocks = sd_v1_blocks(sd);
 		inode->i_generation = le32_to_cpu(INODE_PKEY(inode)->k_dir_id);
@@ -1311,11 +1309,9 @@ static void init_inode(struct inode *inode, struct treepath *path)
 		i_uid_write(inode, sd_v2_uid(sd));
 		inode->i_size = sd_v2_size(sd);
 		i_gid_write(inode, sd_v2_gid(sd));
-		inode->i_mtime.tv_sec = sd_v2_mtime(sd);
-		inode->i_atime.tv_sec = sd_v2_atime(sd);
+		inode_set_mtime(inode, sd_v2_mtime(sd), 0);
+		inode_set_atime(inode, sd_v2_atime(sd), 0);
 		inode_set_ctime(inode, sd_v2_ctime(sd), 0);
-		inode->i_mtime.tv_nsec = 0;
-		inode->i_atime.tv_nsec = 0;
 		inode->i_blocks = sd_v2_blocks(sd);
 		rdev = sd_v2_rdev(sd);
 		if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
@@ -1370,9 +1366,9 @@ static void inode2sd(void *sd, struct inode *inode, loff_t size)
 	set_sd_v2_uid(sd_v2, i_uid_read(inode));
 	set_sd_v2_size(sd_v2, size);
 	set_sd_v2_gid(sd_v2, i_gid_read(inode));
-	set_sd_v2_mtime(sd_v2, inode->i_mtime.tv_sec);
-	set_sd_v2_atime(sd_v2, inode->i_atime.tv_sec);
-	set_sd_v2_ctime(sd_v2, inode_get_ctime(inode).tv_sec);
+	set_sd_v2_mtime(sd_v2, inode_get_mtime_sec(inode));
+	set_sd_v2_atime(sd_v2, inode_get_atime_sec(inode));
+	set_sd_v2_ctime(sd_v2, inode_get_ctime_sec(inode));
 	set_sd_v2_blocks(sd_v2, to_fake_used_blocks(inode, SD_V2_SIZE));
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		set_sd_v2_rdev(sd_v2, new_encode_dev(inode->i_rdev));
@@ -1391,9 +1387,9 @@ static void inode2sd_v1(void *sd, struct inode *inode, loff_t size)
 	set_sd_v1_gid(sd_v1, i_gid_read(inode));
 	set_sd_v1_nlink(sd_v1, inode->i_nlink);
 	set_sd_v1_size(sd_v1, size);
-	set_sd_v1_atime(sd_v1, inode->i_atime.tv_sec);
-	set_sd_v1_ctime(sd_v1, inode_get_ctime(inode).tv_sec);
-	set_sd_v1_mtime(sd_v1, inode->i_mtime.tv_sec);
+	set_sd_v1_atime(sd_v1, inode_get_atime_sec(inode));
+	set_sd_v1_ctime(sd_v1, inode_get_ctime_sec(inode));
+	set_sd_v1_mtime(sd_v1, inode_get_mtime_sec(inode));
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		set_sd_v1_rdev(sd_v1, new_encode_dev(inode->i_rdev));
@@ -1984,7 +1980,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 
 	/* uid and gid must already be set by the caller for quota init */
 
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_size = i_size;
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 9c5704be2435..994d6e6995ab 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -572,7 +572,7 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 	}
 
 	dir->i_size += paste_size;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (!S_ISDIR(inode->i_mode) && visible)
 		/* reiserfs_mkdir or reiserfs_rename will do that by itself */
 		reiserfs_update_sd(th, dir);
@@ -966,8 +966,8 @@ static int reiserfs_rmdir(struct inode *dir, struct dentry *dentry)
 			       inode->i_nlink);
 
 	clear_nlink(inode);
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	reiserfs_update_sd(&th, inode);
 
 	DEC_DIR_INODE_NLINK(dir)
@@ -1075,7 +1075,7 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 	reiserfs_update_sd(&th, inode);
 
 	dir->i_size -= (de.de_entrylen + DEH_SIZE);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	reiserfs_update_sd(&th, dir);
 
 	if (!savelink)
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 3676e02a0232..2138ee7d271d 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -2003,7 +2003,8 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 			pathrelse(&s_search_path);
 
 			if (update_timestamps) {
-				inode->i_mtime = current_time(inode);
+				inode_set_mtime_to_ts(inode,
+						      current_time(inode));
 				inode_set_ctime_current(inode);
 			}
 			reiserfs_update_sd(th, inode);
@@ -2028,7 +2029,7 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 update_and_out:
 	if (update_timestamps) {
 		/* this is truncate, not file closing */
-		inode->i_mtime = current_time(inode);
+		inode_set_mtime_to_ts(inode, current_time(inode));
 		inode_set_ctime_current(inode);
 	}
 	reiserfs_update_sd(th, inode);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 7eaf36b3de12..67b5510beded 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2587,7 +2587,7 @@ static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
 		return err;
 	if (inode->i_size < off + len - towrite)
 		i_size_write(inode, off + len - towrite);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return len - towrite;
 }
-- 
2.41.0

