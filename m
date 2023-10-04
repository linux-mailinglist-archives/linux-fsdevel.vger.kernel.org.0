Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13C7B8C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbjJDTA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbjJDS6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:58:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1D1BDF;
        Wed,  4 Oct 2023 11:55:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B5C433CB;
        Wed,  4 Oct 2023 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445711;
        bh=Jf/tgaFw2JwJVZViZFVmICop3c/4tpLGm/RvPo6JJs4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ShrOxWUf67smiUEzEWwq78XVsbjlrkZyK9rITImRb+4vh17rPGATcfp/fa/z8qeNR
         rLmv/nxdQ+iSe8QkMnnS5citNeMVw4oPt02RMM/S6Iuma+vkln6FjH2m+JGRMr07z1
         jtrOQtVH55tSB4qd2mxgL7RGvpy4a5GRo9zbhIpJJQgQ6tI7xOfrqo3PfaA7qECpJm
         LSrRQTQVC5wR4iYjI/kXhP0uVFoJ99IlSzlQdmwQWKhOvgQQDvkqdEjbWFqzw1NjBw
         vigyBmb1Cu3qRhRYFDxj4vkDCZVFnw6fM7LTZjIWReypScJW+gI0F5ySiorK+rqA78
         8ohn6b9vj3tBA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 71/89] sysv: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:56 -0400
Message-ID: <20231004185347.80880-69-jlayton@kernel.org>
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
 fs/sysv/dir.c    |  6 +++---
 fs/sysv/ialloc.c |  2 +-
 fs/sysv/inode.c  | 12 +++++-------
 fs/sysv/itree.c  |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 2f5ead88d00b..2e126d72d619 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -224,7 +224,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	err = sysv_handle_dirsync(dir);
 out_page:
@@ -249,7 +249,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 	}
 	de->inode = 0;
 	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return sysv_handle_dirsync(inode);
 }
@@ -346,7 +346,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	}
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	return sysv_handle_dirsync(inode);
 }
diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
index 6719da5889d9..269df6d49815 100644
--- a/fs/sysv/ialloc.c
+++ b/fs/sysv/ialloc.c
@@ -165,7 +165,7 @@ struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
 	dirty_sb(sb);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = fs16_to_cpu(sbi, ino);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_blocks = 0;
 	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
 	SYSV_I(inode)->i_dir_start_lookup = 0;
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 0aa3827d8178..5a915b2e68f5 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -200,11 +200,9 @@ struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
 	i_gid_write(inode, (gid_t)fs16_to_cpu(sbi, raw_inode->i_gid));
 	set_nlink(inode, fs16_to_cpu(sbi, raw_inode->i_nlink));
 	inode->i_size = fs32_to_cpu(sbi, raw_inode->i_size);
-	inode->i_atime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_atime);
-	inode->i_mtime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_mtime);
+	inode_set_atime(inode, fs32_to_cpu(sbi, raw_inode->i_atime), 0);
+	inode_set_mtime(inode, fs32_to_cpu(sbi, raw_inode->i_mtime), 0);
 	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->i_ctime), 0);
-	inode->i_atime.tv_nsec = 0;
-	inode->i_mtime.tv_nsec = 0;
 	inode->i_blocks = 0;
 
 	si = SYSV_I(inode);
@@ -253,9 +251,9 @@ static int __sysv_write_inode(struct inode *inode, int wait)
 	raw_inode->i_gid = cpu_to_fs16(sbi, fs_high2lowgid(i_gid_read(inode)));
 	raw_inode->i_nlink = cpu_to_fs16(sbi, inode->i_nlink);
 	raw_inode->i_size = cpu_to_fs32(sbi, inode->i_size);
-	raw_inode->i_atime = cpu_to_fs32(sbi, inode->i_atime.tv_sec);
-	raw_inode->i_mtime = cpu_to_fs32(sbi, inode->i_mtime.tv_sec);
-	raw_inode->i_ctime = cpu_to_fs32(sbi, inode_get_ctime(inode).tv_sec);
+	raw_inode->i_atime = cpu_to_fs32(sbi, inode_get_atime_sec(inode));
+	raw_inode->i_mtime = cpu_to_fs32(sbi, inode_get_mtime_sec(inode));
+	raw_inode->i_ctime = cpu_to_fs32(sbi, inode_get_ctime_sec(inode));
 
 	si = SYSV_I(inode);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index edb94e55de8e..725981474e5f 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -423,7 +423,7 @@ void sysv_truncate (struct inode * inode)
 		}
 		n++;
 	}
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (IS_SYNC(inode))
 		sysv_sync_inode (inode);
 	else
-- 
2.41.0

