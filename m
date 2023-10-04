Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A087B8C25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbjJDS4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbjJDSzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0BE4;
        Wed,  4 Oct 2023 11:54:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA89C43391;
        Wed,  4 Oct 2023 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445685;
        bh=H9Lg9euMGZuxmMKeqAIzK2Cek3hrbdgrjDGHylOx0vA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hDpc2bRReKUCHbe39dGQf3XZktLcVOaGC9VjQhy1EbJAphkT6ujmAva0TjOI2sjve
         CY8tFlErQqv8n7h+5HElp3jPjbymz7h28rnvMFrjeRyba6NFt9K7aZiZU31C0pTBKF
         05Py0YNrYH0TtXJCJFzirogMPjSw3G3yogTqe1FHTHOZpXDSGQ1sEmYZdgw43f1Yen
         Ebzqcd45YiBuoXwAu/lNJV/aGmSThKfgpLiKpPzN9CNR7t5HHQB+GxNi4tqEabYjHF
         dpqAFZuSK4jxJ7vt8fvATBh/ugzRUrxGIsv4Bw2SATVmNBKmEKILxsqB88sbkSq0NW
         UyBpl0evE+yWg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 50/89] minix: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:35 -0400
Message-ID: <20231004185347.80880-48-jlayton@kernel.org>
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
 fs/minix/bitmap.c       |  2 +-
 fs/minix/dir.c          |  6 +++---
 fs/minix/inode.c        | 17 ++++++++---------
 fs/minix/itree_common.c |  2 +-
 4 files changed, 13 insertions(+), 14 deletions(-)

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
index df575473c1cc..f8af6c3ae336 100644
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
+	raw_inode->i_time = inode_get_mtime_sec(inode);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = old_encode_dev(inode->i_rdev);
 	else for (i = 0; i < 9; i++)
@@ -616,9 +615,9 @@ static struct buffer_head * V2_minix_update_inode(struct inode * inode)
 	raw_inode->i_gid = fs_high2lowgid(i_gid_read(inode));
 	raw_inode->i_nlinks = inode->i_nlink;
 	raw_inode->i_size = inode->i_size;
-	raw_inode->i_mtime = inode->i_mtime.tv_sec;
-	raw_inode->i_atime = inode->i_atime.tv_sec;
-	raw_inode->i_ctime = inode_get_ctime(inode).tv_sec;
+	raw_inode->i_mtime = inode_get_mtime_sec(inode);
+	raw_inode->i_atime = inode_get_atime_sec(inode);
+	raw_inode->i_ctime = inode_get_ctime_sec(inode);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = old_encode_dev(inode->i_rdev);
 	else for (i = 0; i < 10; i++)
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

