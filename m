Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116617B1A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjI1LIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjI1LHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:07:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247819B7;
        Thu, 28 Sep 2023 04:05:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED99C433CC;
        Thu, 28 Sep 2023 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899115;
        bh=VoXxlVrUqhBQVgwjQRi6qU/ZUnPcdpAUrcKR8cbC/GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgEOBlGxUkrY1UdDotHV8qYcq/YOtzMq9YHMhD3agVMSTw/us/cpFfcBz/nth7rUj
         zRWZpyzdYypQQykYBbsWt8+MAYeYNDi8uVYbnPsPUjrriqGEhVmdhOIafyZryy43DU
         Nk4UKhCs47HVDHlwS3kpdskGF7+ZZ6yJOQsBrI0Qlho9FP8yzHDpEtlqgWexgrwJ+v
         r+YxsIRtSnYdXo+1gVKjsYOWS94tba9gmJpMU75DTtIPwLvyUtbSvZZRBPiG2A/C7v
         ieXtx01U0AQc+Bm7ZklrbMxlL9h25Vzq4rcWNHlYq3wyyTz9QNZXmhRJ69B08FtF1u
         cI9D2dv7qUwUw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-nilfs@vger.kernel.org
Subject: [PATCH 52/87] fs/nilfs2: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:01 -0400
Message-ID: <20230928110413.33032-51-jlayton@kernel.org>
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
 fs/nilfs2/dir.c   |  6 +++---
 fs/nilfs2/inode.c | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

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
index 1a8bd5993476..b59380a8bbc0 100644
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
@@ -769,9 +769,9 @@ void nilfs_write_inode_common(struct inode *inode,
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le64(inode->i_size);
 	raw_inode->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	raw_inode->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
+	raw_inode->i_mtime = cpu_to_le64(inode_get_mtime(inode).tv_sec);
 	raw_inode->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	raw_inode->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	raw_inode->i_mtime_nsec = cpu_to_le32(inode_get_mtime(inode).tv_nsec);
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

