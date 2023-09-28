Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9483F7B1A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjI1LKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjI1LJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3CB26A8;
        Thu, 28 Sep 2023 04:05:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF0BC433CD;
        Thu, 28 Sep 2023 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899137;
        bh=hlr3TuYXADCwXim6mrb06nRfR5jkoWz/gdSaebmF2Wk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DHN1zSTMmlijWdkQdsxILM1rMD6qm/KfhRdJ42/vzxS3V+NcgFL+2g1ejKwXc5v3z
         XUVf2sB4aQNaity8J9vOZG8yRp0VjM2q52tSmDoMbBiJdDweFp94TdKbsHyt2CGSDS
         +V/DTt2NVv0dnll9nK591330UW6kkOGnbkLUAsDDK+oh3C89kN2xkq+rh9KLQXYN0W
         z2Z9etLeDNjf6qlLlbiT25InrBlsE/c8GPQCo+R4oVzG4FcU2zX2XH8evG0BChzpFN
         ncL1f9sPkRW0B+g/hCoQ33qImFPztdvTERVHkhMEIuol5Gg02Y4hwAdNfQaGe7TGJJ
         j/uAV0kIlFQ7g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 70/87] fs/sysv: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:19 -0400
Message-ID: <20230928110413.33032-69-jlayton@kernel.org>
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
 fs/sysv/dir.c    |  6 +++---
 fs/sysv/ialloc.c |  2 +-
 fs/sysv/inode.c  | 10 ++++------
 fs/sysv/itree.c  |  2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

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
index 0aa3827d8178..8b7977f39722 100644
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
@@ -253,8 +251,8 @@ static int __sysv_write_inode(struct inode *inode, int wait)
 	raw_inode->i_gid = cpu_to_fs16(sbi, fs_high2lowgid(i_gid_read(inode)));
 	raw_inode->i_nlink = cpu_to_fs16(sbi, inode->i_nlink);
 	raw_inode->i_size = cpu_to_fs32(sbi, inode->i_size);
-	raw_inode->i_atime = cpu_to_fs32(sbi, inode->i_atime.tv_sec);
-	raw_inode->i_mtime = cpu_to_fs32(sbi, inode->i_mtime.tv_sec);
+	raw_inode->i_atime = cpu_to_fs32(sbi, inode_get_atime(inode).tv_sec);
+	raw_inode->i_mtime = cpu_to_fs32(sbi, inode_get_mtime(inode).tv_sec);
 	raw_inode->i_ctime = cpu_to_fs32(sbi, inode_get_ctime(inode).tv_sec);
 
 	si = SYSV_I(inode);
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

