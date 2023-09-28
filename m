Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2A7B1A07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjI1LIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjI1LGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:06:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9BE1995;
        Thu, 28 Sep 2023 04:05:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A471FC433C8;
        Thu, 28 Sep 2023 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899111;
        bh=TozuuxZkQdCbjxpAkjZd4rQidqLN1czCk9GhEFGLV4E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fOlQpwFXWLM20fUeblLAHCVModVY78fPIpS3GiTgQooZCvbkU/WR4ZDjLPSFIBr3T
         tEfXgP67ERI3WUL1tS98Wil5FzqYU/HDXrDVbNTrn1QW1rBfsC+neuQ9Wgg7kmMgse
         vrzuY+ETJJm7aIY4KNYK1ffZ5M6VvtLL8C4qM1lvoH98z96n1TElmO1d8RR5rzOY4K
         Px9dx2A2Wl0sfDXIiT/vr7e5LqPye2OApeRytfn97PTYNALj3TI3QO/P/QFiZOJ1yn
         oPsgfCpoe4duVSSr9hYxWRX9R9g2ihJkKkHW+mPDUMlksHnuzwZDIvsCaNETBhVh/A
         nSQiMZQPClK2w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 49/87] fs/minix: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:58 -0400
Message-ID: <20230928110413.33032-48-jlayton@kernel.org>
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
 fs/minix/bitmap.c       |  2 +-
 fs/minix/dir.c          |  6 +++---
 fs/minix/inode.c        | 15 +++++++--------
 fs/minix/itree_common.c |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index 25c08fbfcb9d..7da66ca184f4 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -251,7 +251,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
 	}
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = j;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_blocks = 0;
 	memset(&minix_i(inode)->u, 0, sizeof(minix_i(inode)->u));
 	insert_inode_hash(inode);
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 20f23e6e58ad..62c313fc9a49 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -281,7 +281,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 		de->inode = inode->i_ino;
 	}
 	dir_commit_chunk(page, pos, sbi->s_dirsize);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	err = minix_handle_dirsync(dir);
 out_put:
@@ -313,7 +313,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 	else
 		de->inode = 0;
 	dir_commit_chunk(page, pos, len);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return minix_handle_dirsync(inode);
 }
@@ -436,7 +436,7 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 	else
 		de->inode = inode->i_ino;
 	dir_commit_chunk(page, pos, sbi->s_dirsize);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	return minix_handle_dirsync(dir);
 }
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df575473c1cc..8f10abf5fc6a 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -501,7 +501,8 @@ static struct inode *V1_minix_iget(struct inode *inode)
 	i_gid_write(inode, raw_inode->i_gid);
 	set_nlink(inode, raw_inode->i_nlinks);
 	inode->i_size = raw_inode->i_size;
-	inode->i_mtime = inode->i_atime = inode_set_ctime(inode, raw_inode->i_time, 0);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime(inode, raw_inode->i_time, 0)));
 	inode->i_blocks = 0;
 	for (i = 0; i < 9; i++)
 		minix_inode->u.i1_data[i] = raw_inode->i_zone[i];
@@ -538,11 +539,9 @@ static struct inode *V2_minix_iget(struct inode *inode)
 	i_gid_write(inode, raw_inode->i_gid);
 	set_nlink(inode, raw_inode->i_nlinks);
 	inode->i_size = raw_inode->i_size;
-	inode->i_mtime.tv_sec = raw_inode->i_mtime;
-	inode->i_atime.tv_sec = raw_inode->i_atime;
+	inode_set_mtime(inode, raw_inode->i_mtime, 0);
+	inode_set_atime(inode, raw_inode->i_atime, 0);
 	inode_set_ctime(inode, raw_inode->i_ctime, 0);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_nsec = 0;
 	inode->i_blocks = 0;
 	for (i = 0; i < 10; i++)
 		minix_inode->u.i2_data[i] = raw_inode->i_zone[i];
@@ -589,7 +588,7 @@ static struct buffer_head * V1_minix_update_inode(struct inode * inode)
 	raw_inode->i_gid = fs_high2lowgid(i_gid_read(inode));
 	raw_inode->i_nlinks = inode->i_nlink;
 	raw_inode->i_size = inode->i_size;
-	raw_inode->i_time = inode->i_mtime.tv_sec;
+	raw_inode->i_time = inode_get_mtime(inode).tv_sec;
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = old_encode_dev(inode->i_rdev);
 	else for (i = 0; i < 9; i++)
@@ -616,8 +615,8 @@ static struct buffer_head * V2_minix_update_inode(struct inode * inode)
 	raw_inode->i_gid = fs_high2lowgid(i_gid_read(inode));
 	raw_inode->i_nlinks = inode->i_nlink;
 	raw_inode->i_size = inode->i_size;
-	raw_inode->i_mtime = inode->i_mtime.tv_sec;
-	raw_inode->i_atime = inode->i_atime.tv_sec;
+	raw_inode->i_mtime = inode_get_mtime(inode).tv_sec;
+	raw_inode->i_atime = inode_get_atime(inode).tv_sec;
 	raw_inode->i_ctime = inode_get_ctime(inode).tv_sec;
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = old_encode_dev(inode->i_rdev);
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index ce18ae37c29d..dad131e30c05 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -350,7 +350,7 @@ static inline void truncate (struct inode * inode)
 		}
 		first_whole++;
 	}
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 }
 
-- 
2.41.0

