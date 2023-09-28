Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C00B7B19D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjI1LGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjI1LE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C83CE4;
        Thu, 28 Sep 2023 04:04:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275A2C433C7;
        Thu, 28 Sep 2023 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899090;
        bh=buEnV+Wgc4pn0pkfok4z43YPFhAqoFE2sQ0OTWjvEdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seXE8k23ubQh+fcr3ejnY/+V/XKY5rKosQptvSFDxf2yJJEZtEnmwwGp7OXXgM1rx
         0Dg56KVr9Nm6oQP93rHHlfB8EGAySs6A2fQZlXBTvq2kvMCxRC57rgoI6Wv2v31RtD
         QydqSZk23W34l5e2dH14bwmLkMFhavQrlEAwgwAifc6Zj78sbntBIGq1xg4SHXKugR
         ggr7/o7r0RikMpzwvYmZl+shWH2363RzWaJuESszmA73lW4GpU0DqH1Zy6yQ+9JmI9
         6e041QlZw7BYb1GVNOZ2DH6soQINvGBhYr7g0e878yttwp809CGoVNf4ulYrrypwrC
         eW7Z0KykhIFDw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 33/87] fs/ext2: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:42 -0400
Message-ID: <20230928110413.33032-32-jlayton@kernel.org>
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
 fs/ext2/dir.c    |  6 +++---
 fs/ext2/ialloc.c |  2 +-
 fs/ext2/inode.c  | 11 +++++------
 fs/ext2/super.c  |  2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index b335f17f682f..c7900868171b 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -468,7 +468,7 @@ int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 	ext2_set_de_type(de, inode);
 	ext2_commit_chunk(page, pos, len);
 	if (update_times)
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 	return ext2_handle_dirsync(dir);
@@ -555,7 +555,7 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
 	ext2_commit_chunk(page, pos, rec_len);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 	err = ext2_handle_dirsync(dir);
@@ -606,7 +606,7 @@ int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
 		pde->rec_len = ext2_rec_len_to_disk(to - from);
 	dir->inode = 0;
 	ext2_commit_chunk(page, pos, to - from);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
 	return ext2_handle_dirsync(inode);
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index c24d0de95a83..fdf63e9c6e7c 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -546,7 +546,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_flags =
 		ext2_mask_flags(mode, EXT2_I(dir)->i_flags & EXT2_FL_INHERITED);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 314b415ee518..d8c9eaae383f 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1291,7 +1291,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	__ext2_truncate_blocks(inode, newsize);
 	filemap_invalidate_unlock(inode->i_mapping);
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (inode_needs_sync(inode)) {
 		sync_mapping_buffers(inode->i_mapping);
 		sync_inode_metadata(inode, 1);
@@ -1412,10 +1412,9 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	i_gid_write(inode, i_gid);
 	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
 	inode->i_size = le32_to_cpu(raw_inode->i_size);
-	inode->i_atime.tv_sec = (signed)le32_to_cpu(raw_inode->i_atime);
+	inode_set_atime(inode, (signed)le32_to_cpu(raw_inode->i_atime), 0);
 	inode_set_ctime(inode, (signed)le32_to_cpu(raw_inode->i_ctime), 0);
-	inode->i_mtime.tv_sec = (signed)le32_to_cpu(raw_inode->i_mtime);
-	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = 0;
+	inode_set_mtime(inode, (signed)le32_to_cpu(raw_inode->i_mtime), 0);
 	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
 	/* We now have enough fields to check if the inode was active or not.
 	 * This is needed because nfsd might try to access dead inodes
@@ -1544,9 +1543,9 @@ static int __ext2_write_inode(struct inode *inode, int do_sync)
 	}
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le32(inode->i_size);
-	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
+	raw_inode->i_atime = cpu_to_le32(inode_get_atime(inode).tv_sec);
 	raw_inode->i_ctime = cpu_to_le32(inode_get_ctime(inode).tv_sec);
-	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
+	raw_inode->i_mtime = cpu_to_le32(inode_get_mtime(inode).tv_sec);
 
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index aaf3e3e88cb2..645ee6142f69 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1572,7 +1572,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return len - towrite;
 }
-- 
2.41.0

