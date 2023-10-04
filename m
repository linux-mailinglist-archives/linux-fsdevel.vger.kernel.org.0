Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61BA7B8C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbjJDS5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244953AbjJDSzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F0171F;
        Wed,  4 Oct 2023 11:54:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D99C433CA;
        Wed,  4 Oct 2023 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445689;
        bh=BzmHHAJz6lYHHZHZoa6zewaRspqSDICvIyQA0NDXkSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bL7wuzDQWPALt/93IkyyQc+LFc/NemtrEXf/xfciiaEjZ3f6RElycysodrnL8RyrI
         m6jPMzcT+lZ2Aj/nEfVAMOZR7o0GqN+Q4jjW9/K/1JGhxqQVlrpHSeKr6jPPEDndvw
         ci/icWTpE8PwBpkb88gfDoa8kASYMwsP11NUavrmZDZJUFuLTtLSIBVY8xmKbJDgDj
         R9DhK/i5qP5rBJBQwkaeXPe17CPwu2GkEq8FkOsnuwdD5/1zpAvnLt1w/SChqbLR8k
         UUmuAYbZuC1O4XoFvjHjBcC2ZLboqCHepAJCWNLthmuFOYC8PuFfjclO27zDUyPVZV
         JN7VV2G01Vwug==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-nilfs@vger.kernel.org
Subject: [PATCH v2 53/89] nilfs2: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:38 -0400
Message-ID: <20231004185347.80880-51-jlayton@kernel.org>
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
 fs/nilfs2/dir.c   |  6 +++---
 fs/nilfs2/inode.c | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index bce734b68f08..de2073c47651 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -429,7 +429,7 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
 	nilfs_put_page(page);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
 /*
@@ -519,7 +519,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, page->mapping, from, to);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
@@ -567,7 +567,7 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
 	nilfs_commit_chunk(page, mapping, from, to);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 out:
 	nilfs_put_page(page);
 	return err;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 1a8bd5993476..f861f3a0bf5c 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -366,7 +366,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	atomic64_inc(&root->inodes_count);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = ino;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	if (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) {
 		err = nilfs_bmap_read(ii->i_bmap, NULL);
@@ -449,12 +449,12 @@ int nilfs_read_inode_common(struct inode *inode,
 	i_gid_write(inode, le32_to_cpu(raw_inode->i_gid));
 	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
 	inode->i_size = le64_to_cpu(raw_inode->i_size);
-	inode->i_atime.tv_sec = le64_to_cpu(raw_inode->i_mtime);
+	inode_set_atime(inode, le64_to_cpu(raw_inode->i_mtime),
+			le32_to_cpu(raw_inode->i_mtime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(raw_inode->i_ctime),
 			le32_to_cpu(raw_inode->i_ctime_nsec));
-	inode->i_mtime.tv_sec = le64_to_cpu(raw_inode->i_mtime);
-	inode->i_atime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
-	inode->i_mtime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
+	inode_set_mtime(inode, le64_to_cpu(raw_inode->i_mtime),
+			le32_to_cpu(raw_inode->i_mtime_nsec));
 	if (nilfs_is_metadata_file_inode(inode) && !S_ISREG(inode->i_mode))
 		return -EIO; /* this inode is for metadata and corrupted */
 	if (inode->i_nlink == 0)
@@ -768,10 +768,10 @@ void nilfs_write_inode_common(struct inode *inode,
 	raw_inode->i_gid = cpu_to_le32(i_gid_read(inode));
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le64(inode->i_size);
-	raw_inode->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	raw_inode->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
-	raw_inode->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	raw_inode->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	raw_inode->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	raw_inode->i_mtime = cpu_to_le64(inode_get_mtime_sec(inode));
+	raw_inode->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
+	raw_inode->i_mtime_nsec = cpu_to_le32(inode_get_mtime_nsec(inode));
 	raw_inode->i_blocks = cpu_to_le64(inode->i_blocks);
 
 	raw_inode->i_flags = cpu_to_le32(ii->i_flags);
@@ -875,7 +875,7 @@ void nilfs_truncate(struct inode *inode)
 
 	nilfs_truncate_bmap(ii, blkoff);
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (IS_SYNC(inode))
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
-- 
2.41.0

