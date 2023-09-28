Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75EE7B1A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjI1LU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjI1LUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:20:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C944136;
        Thu, 28 Sep 2023 04:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF3C43397;
        Thu, 28 Sep 2023 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899141;
        bh=qg86FZNr5F1kC0kQbL28OzdqO1g+rILtRqAFwmKFQeI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P1gxXFtddzzOFO+hlnFWfznI2+IOLQ1aJKstS4efgg7yKFyajso2PlB14cMQ4Rss6
         CeThrOPz3EPGMdB5KntuIX+2m0VoH8KFShBrlXrVapgKNLuUapcOIOPZT9ZWrG9YSZ
         j9MZHg9IpWsojexoHLGKcyXJuVHO3FLpJey/9xyNLxk92et1olZyTJeffCJo+mhCJp
         VF41C4kzESMOP9hiq111oxnOyRsk6HejQePXLDwKl4390sK07me/idBqo/DK06QSGX
         pNglRqE3lJdDKU87IFhIaY2F4WktHtnN2P0Ch06XoXYJUTDpcFGnB2eHvac3xulA40
         Wfokk8DC9Uv6w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 74/87] fs/ufs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:23 -0400
Message-ID: <20230928110413.33032-73-jlayton@kernel.org>
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
 fs/ufs/dir.c    |  6 +++---
 fs/ufs/ialloc.c |  2 +-
 fs/ufs/inode.c  | 36 +++++++++++++++++++++---------------
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index fd57f03b6c93..27c85d92d1dc 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -107,7 +107,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_commit_chunk(page, pos, len);
 	ufs_put_page(page);
 	if (update_times)
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	ufs_handle_dirsync(dir);
 }
@@ -397,7 +397,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	ufs_set_de_type(sb, de, inode->i_mode);
 
 	ufs_commit_chunk(page, pos, rec_len);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	mark_inode_dirty(dir);
 	err = ufs_handle_dirsync(dir);
@@ -539,7 +539,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
 	ufs_commit_chunk(page, pos, to - from);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
 out:
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index a1e7bd9d1f98..73531827ecee 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -292,7 +292,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_blocks = 0;
 	inode->i_generation = 0;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	ufsi->i_flags = UFS_I(dir)->i_flags;
 	ufsi->i_lastfrag = 0;
 	ufsi->i_shadow = 0;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 21a4779a2de5..b0877667940d 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -579,13 +579,15 @@ static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	i_gid_write(inode, ufs_get_inode_gid(sb, ufs_inode));
 
 	inode->i_size = fs64_to_cpu(sb, ufs_inode->ui_size);
-	inode->i_atime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_atime.tv_sec);
+	inode_set_atime(inode,
+			(signed)fs32_to_cpu(sb, ufs_inode->ui_atime.tv_sec),
+			0);
 	inode_set_ctime(inode,
 			(signed)fs32_to_cpu(sb, ufs_inode->ui_ctime.tv_sec),
 			0);
-	inode->i_mtime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_mtime.tv_sec);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_nsec = 0;
+	inode_set_mtime(inode,
+			(signed)fs32_to_cpu(sb, ufs_inode->ui_mtime.tv_sec),
+			0);
 	inode->i_blocks = fs32_to_cpu(sb, ufs_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs_inode->ui_gen);
 	ufsi->i_flags = fs32_to_cpu(sb, ufs_inode->ui_flags);
@@ -626,12 +628,12 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 	i_gid_write(inode, fs32_to_cpu(sb, ufs2_inode->ui_gid));
 
 	inode->i_size = fs64_to_cpu(sb, ufs2_inode->ui_size);
-	inode->i_atime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_atime);
+	inode_set_atime(inode, fs64_to_cpu(sb, ufs2_inode->ui_atime),
+			fs32_to_cpu(sb, ufs2_inode->ui_atimensec));
 	inode_set_ctime(inode, fs64_to_cpu(sb, ufs2_inode->ui_ctime),
 			fs32_to_cpu(sb, ufs2_inode->ui_ctimensec));
-	inode->i_mtime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_mtime);
-	inode->i_atime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_atimensec);
-	inode->i_mtime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_mtimensec);
+	inode_set_mtime(inode, fs64_to_cpu(sb, ufs2_inode->ui_mtime),
+			fs32_to_cpu(sb, ufs2_inode->ui_mtimensec));
 	inode->i_blocks = fs64_to_cpu(sb, ufs2_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs2_inode->ui_gen);
 	ufsi->i_flags = fs32_to_cpu(sb, ufs2_inode->ui_flags);
@@ -725,12 +727,14 @@ static void ufs1_update_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	ufs_set_inode_gid(sb, ufs_inode, i_gid_read(inode));
 
 	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
-	ufs_inode->ui_atime.tv_sec = cpu_to_fs32(sb, inode->i_atime.tv_sec);
+	ufs_inode->ui_atime.tv_sec = cpu_to_fs32(sb,
+						 inode_get_atime(inode).tv_sec);
 	ufs_inode->ui_atime.tv_usec = 0;
 	ufs_inode->ui_ctime.tv_sec = cpu_to_fs32(sb,
 						 inode_get_ctime(inode).tv_sec);
 	ufs_inode->ui_ctime.tv_usec = 0;
-	ufs_inode->ui_mtime.tv_sec = cpu_to_fs32(sb, inode->i_mtime.tv_sec);
+	ufs_inode->ui_mtime.tv_sec = cpu_to_fs32(sb,
+						 inode_get_mtime(inode).tv_sec);
 	ufs_inode->ui_mtime.tv_usec = 0;
 	ufs_inode->ui_blocks = cpu_to_fs32(sb, inode->i_blocks);
 	ufs_inode->ui_flags = cpu_to_fs32(sb, ufsi->i_flags);
@@ -770,13 +774,15 @@ static void ufs2_update_inode(struct inode *inode, struct ufs2_inode *ufs_inode)
 	ufs_inode->ui_gid = cpu_to_fs32(sb, i_gid_read(inode));
 
 	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
-	ufs_inode->ui_atime = cpu_to_fs64(sb, inode->i_atime.tv_sec);
-	ufs_inode->ui_atimensec = cpu_to_fs32(sb, inode->i_atime.tv_nsec);
+	ufs_inode->ui_atime = cpu_to_fs64(sb, inode_get_atime(inode).tv_sec);
+	ufs_inode->ui_atimensec = cpu_to_fs32(sb,
+					      inode_get_atime(inode).tv_nsec);
 	ufs_inode->ui_ctime = cpu_to_fs64(sb, inode_get_ctime(inode).tv_sec);
 	ufs_inode->ui_ctimensec = cpu_to_fs32(sb,
 					      inode_get_ctime(inode).tv_nsec);
-	ufs_inode->ui_mtime = cpu_to_fs64(sb, inode->i_mtime.tv_sec);
-	ufs_inode->ui_mtimensec = cpu_to_fs32(sb, inode->i_mtime.tv_nsec);
+	ufs_inode->ui_mtime = cpu_to_fs64(sb, inode_get_mtime(inode).tv_sec);
+	ufs_inode->ui_mtimensec = cpu_to_fs32(sb,
+					      inode_get_mtime(inode).tv_nsec);
 
 	ufs_inode->ui_blocks = cpu_to_fs64(sb, inode->i_blocks);
 	ufs_inode->ui_flags = cpu_to_fs32(sb, ufsi->i_flags);
@@ -1208,7 +1214,7 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 	truncate_setsize(inode, size);
 
 	ufs_truncate_blocks(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 out:
 	UFSD("EXIT: err %d\n", err);
-- 
2.41.0

