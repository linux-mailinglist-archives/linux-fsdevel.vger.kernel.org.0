Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50C7B8BC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbjJDSy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244690AbjJDSyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B510C2;
        Wed,  4 Oct 2023 11:54:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4806CC433C8;
        Wed,  4 Oct 2023 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445650;
        bh=0i9CE7r71pJZdjXfXE2Jus9B4sidSAXbrDfTPPIl14s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GnE2TT9WztiIbYrPDDM3P8R317hzMEYg4euMcqPSj84n6G15y1PPLK49SWkpodR9i
         u0dL6aNYtHiaGmWi0a74cz5BW7FXbAg0yOt1qsksaPXqrkIDD64ZPs5oLJo8ktTEtb
         BLgQTvWSPC/WLw4XDzIp7NsutReIk3fU9VGVF1tIfQSfZCgqWLgg5vieCsqqmIoj3p
         /G8Sy2MRGvRNy4OrGNKBcOb1/yuDPdr14g0gbcYMhLza84f30cAkNEThpJffw5B+7x
         1UrGfHIVM8JK1Bwl8zZGOryrwRAK3iw+wqsUV7ixycJ1+kQScPScGWE01RhzkxgAzR
         OVnZjqD0kSRtQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/89] bfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:07 -0400
Message-ID: <20231004185347.80880-20-jlayton@kernel.org>
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
 fs/bfs/dir.c   |  9 +++++----
 fs/bfs/inode.c | 12 +++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index 12b8af04dcb3..fbc4ae80a4b2 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -97,7 +97,7 @@ static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	set_bit(ino, info->si_imap);
 	info->si_freei--;
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_blocks = 0;
 	inode->i_op = &bfs_file_inops;
 	inode->i_fop = &bfs_file_operations;
@@ -187,7 +187,7 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 	de->ino = 0;
 	mark_buffer_dirty_inode(bh, dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 	inode_dec_link_count(inode);
@@ -240,7 +240,7 @@ static int bfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto end_rename;
 	}
 	old_de->ino = 0;
-	old_dir->i_mtime = inode_set_ctime_current(old_dir);
+	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
 	mark_inode_dirty(old_dir);
 	if (new_inode) {
 		inode_set_ctime_current(new_inode);
@@ -294,7 +294,8 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
 					dir->i_size += BFS_DIRENT_SIZE;
 					inode_set_ctime_current(dir);
 				}
-				dir->i_mtime = inode_set_ctime_current(dir);
+				inode_set_mtime_to_ts(dir,
+						      inode_set_ctime_current(dir));
 				mark_inode_dirty(dir);
 				de->ino = cpu_to_le16((u16)ino);
 				for (i = 0; i < BFS_NAMELEN; i++)
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index e6a76ae9eb44..355957dbce39 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -80,11 +80,9 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	set_nlink(inode, le32_to_cpu(di->i_nlink));
 	inode->i_size = BFS_FILESIZE(di);
 	inode->i_blocks = BFS_FILEBLOCKS(di);
-	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
-	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
+	inode_set_atime(inode, le32_to_cpu(di->i_atime), 0);
+	inode_set_mtime(inode, le32_to_cpu(di->i_mtime), 0);
 	inode_set_ctime(inode, le32_to_cpu(di->i_ctime), 0);
-	inode->i_atime.tv_nsec = 0;
-	inode->i_mtime.tv_nsec = 0;
 
 	brelse(bh);
 	unlock_new_inode(inode);
@@ -140,9 +138,9 @@ static int bfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	di->i_uid = cpu_to_le32(i_uid_read(inode));
 	di->i_gid = cpu_to_le32(i_gid_read(inode));
 	di->i_nlink = cpu_to_le32(inode->i_nlink);
-	di->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
-	di->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
-	di->i_ctime = cpu_to_le32(inode_get_ctime(inode).tv_sec);
+	di->i_atime = cpu_to_le32(inode_get_atime_sec(inode));
+	di->i_mtime = cpu_to_le32(inode_get_mtime_sec(inode));
+	di->i_ctime = cpu_to_le32(inode_get_ctime_sec(inode));
 	i_sblock = BFS_I(inode)->i_sblock;
 	di->i_sblock = cpu_to_le32(i_sblock);
 	di->i_eblock = cpu_to_le32(BFS_I(inode)->i_eblock);
-- 
2.41.0

