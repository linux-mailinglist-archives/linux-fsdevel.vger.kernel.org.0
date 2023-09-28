Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58667B19F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjI1LH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjI1LGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:06:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C7172C;
        Thu, 28 Sep 2023 04:05:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E2DC433C7;
        Thu, 28 Sep 2023 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899104;
        bh=WdhKVeDvEbKnuqVE8JioBf7/XuFh9c0DQ7/RiYq45FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lk6lU76rtis34gPcawFKYvC3t92lkvckjaFjUIluPI3HFE3OLVD5JnhI3R/rVMN7r
         F8czyTGJsP3qg3qvVwQLSTHLuSyrC0haq2UAKJra1gJAoQFpr99CN3v3mhZ6xsognJ
         yozcfjf26Nea0TfCxH8Vc/BNVQHQBJKESwH+U2q01uSM0hBTcrS7QUbw9WTVPm8yuG
         ex+WxCbn/K5N0oH3t1IZtrwihqdPcZRS3iWr07rRton6NuqSfucu3Sy2htGrrOwNpi
         x6tTG961YMV7gvUwsQo6MW1Xu0Ba7256DKzhqrfuFgVIH9idX1Q+JtwAwtDVxbGYs3
         j5W14p/tJlYsg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: [PATCH 44/87] fs/hugetlbfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:53 -0400
Message-ID: <20230928110413.33032-43-jlayton@kernel.org>
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
 fs/hugetlbfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..da217eaba102 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -980,7 +980,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 		inode->i_mode = S_IFDIR | ctx->mode;
 		inode->i_uid = ctx->uid;
 		inode->i_gid = ctx->gid;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_op = &hugetlbfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -1024,7 +1024,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
 		switch (mode & S_IFMT) {
@@ -1067,7 +1067,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	d_instantiate(dentry, inode);
 	dget(dentry);/* Extra count - pin the dentry in core */
 	return 0;
@@ -1099,7 +1099,7 @@ static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	d_tmpfile(file, inode);
 	return finish_open_simple(file, 0);
 }
@@ -1121,7 +1121,7 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 		} else
 			iput(inode);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	return error;
 }
-- 
2.41.0

