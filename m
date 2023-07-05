Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13297748D4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjGETI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjGETIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA81FED;
        Wed,  5 Jul 2023 12:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4805D616EE;
        Wed,  5 Jul 2023 19:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F91C433C7;
        Wed,  5 Jul 2023 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583890;
        bh=E7KAJORRcCNXt1YrJFvd8B4M9LhppUh4YeCIy/iI+nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3orGEaOx2fRwNShOb7ALICoaGh+vRYkd3YyYRt7eoP1/phRgn7gPW8lq0bK34IWQ
         LjCnMulH1Vk78laTtJmer3+eZr2neFxAJtIB2Og7ospx32MKqzlJNlkwuazXG5i6kQ
         6qXMZa6uqAyiNpWvEek3HXKP9RkfWFYDrr53RjNXIWS/VAV1LqOze0oACktBn5KHRV
         oU7vXqOU6GZL0MstaI8IHe4sLMzVro62nn6NSj56YABIcO+w1rapsUMwgUSKq3HqiD
         dGUnZ6uKT3bnOsvsN4iVwB+nzMCH2iIuW9w3tr2hgO3fCc6yl4IyGxjlF9VrqxVa3s
         4sCoaQKe5vZig==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH v2 59/92] nilfs2: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:24 -0400
Message-ID: <20230705190309.579783-57-jlayton@kernel.org>
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

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/dir.c   |  6 +++---
 fs/nilfs2/inode.c | 12 ++++++------
 fs/nilfs2/ioctl.c |  2 +-
 fs/nilfs2/namei.c |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index decd6471300b..bce734b68f08 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -429,7 +429,7 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
 	nilfs_put_page(page);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 }
 
 /*
@@ -519,7 +519,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, page->mapping, from, to);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
@@ -567,7 +567,7 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
 	nilfs_commit_chunk(page, mapping, from, to);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 out:
 	nilfs_put_page(page);
 	return err;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index a8ce522ac747..5259b94ca1dc 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -366,7 +366,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	atomic64_inc(&root->inodes_count);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = ino;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 
 	if (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) {
 		err = nilfs_bmap_read(ii->i_bmap, NULL);
@@ -450,10 +450,10 @@ int nilfs_read_inode_common(struct inode *inode,
 	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
 	inode->i_size = le64_to_cpu(raw_inode->i_size);
 	inode->i_atime.tv_sec = le64_to_cpu(raw_inode->i_mtime);
-	inode->i_ctime.tv_sec = le64_to_cpu(raw_inode->i_ctime);
+	inode_set_ctime(inode, le64_to_cpu(raw_inode->i_ctime),
+			le32_to_cpu(raw_inode->i_ctime_nsec));
 	inode->i_mtime.tv_sec = le64_to_cpu(raw_inode->i_mtime);
 	inode->i_atime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(raw_inode->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
 	if (nilfs_is_metadata_file_inode(inode) && !S_ISREG(inode->i_mode))
 		return -EIO; /* this inode is for metadata and corrupted */
@@ -768,9 +768,9 @@ void nilfs_write_inode_common(struct inode *inode,
 	raw_inode->i_gid = cpu_to_le32(i_gid_read(inode));
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le64(inode->i_size);
-	raw_inode->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
+	raw_inode->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
 	raw_inode->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
-	raw_inode->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
+	raw_inode->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
 	raw_inode->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
 	raw_inode->i_blocks = cpu_to_le64(inode->i_blocks);
 
@@ -875,7 +875,7 @@ void nilfs_truncate(struct inode *inode)
 
 	nilfs_truncate_bmap(ii, blkoff);
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	if (IS_SYNC(inode))
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 1dfbc0c34513..40ffade49f38 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -149,7 +149,7 @@ int nilfs_fileattr_set(struct mnt_idmap *idmap,
 	NILFS_I(inode)->i_flags = oldflags | (flags & FS_FL_USER_MODIFIABLE);
 
 	nilfs_set_inode_flags(inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	if (IS_SYNC(inode))
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index c7024da8f1e2..2a4e7f4a8102 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -185,7 +185,7 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 
@@ -283,7 +283,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	inode->i_ctime = dir->i_ctime;
+	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 	drop_nlink(inode);
 	err = 0;
 out:
@@ -387,7 +387,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			goto out_dir;
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
 		nilfs_mark_inode_dirty(new_dir);
-		new_inode->i_ctime = current_time(new_inode);
+		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		drop_nlink(new_inode);
@@ -406,7 +406,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old_inode->i_ctime = current_time(old_inode);
+	inode_set_ctime_current(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
 
-- 
2.41.0

