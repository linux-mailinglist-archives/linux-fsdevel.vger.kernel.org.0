Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61477B8BFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244860AbjJDSzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbjJDSzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB0BF;
        Wed,  4 Oct 2023 11:54:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2CDC433C8;
        Wed,  4 Oct 2023 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445679;
        bh=p1Dmt9XjnzAIX2jMetI3FBJUlMhdUAq23wbUyqvehig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjCLMHa9gGt1lQ2XglXkWIOzENaZqGQds9dyNJRseHF7EiGAA4OQYoi85LQLmjerE
         W8FBwPDioyvpOxPK4SsvWmfmOJFhaQ/auThs4fF5EMh6fvA/N06QRW/BZHoaTCb8qR
         JfGxyvUL5iiEeiP/BQzzmnpOfMwLqK9PQRk1kwhs3++i33ChgTGZAL4lmby1YURqqO
         5MMygpwKgaGff/zh75Jj7sUd5GeLsGG0j6xslMdzq+jnE/+DMDf+QxMvEe23VwhezG
         w+VDO5JZfF6S7M421QsoVPWflcKapd4cnqFBWvHd/PcCA/EJiIq+aMcOY0aLgROZjM
         myDH5ZPPCUwxg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: [PATCH v2 45/89] hugetlbfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:30 -0400
Message-ID: <20231004185347.80880-43-jlayton@kernel.org>
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
 fs/hugetlbfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 926d01c493fb..ebb3506eeeee 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -981,7 +981,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 		inode->i_mode = S_IFDIR | ctx->mode;
 		inode->i_uid = ctx->uid;
 		inode->i_gid = ctx->gid;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_op = &hugetlbfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -1025,7 +1025,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
 		switch (mode & S_IFMT) {
@@ -1068,7 +1068,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	d_instantiate(dentry, inode);
 	dget(dentry);/* Extra count - pin the dentry in core */
 	return 0;
@@ -1100,7 +1100,7 @@ static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	d_tmpfile(file, inode);
 	return finish_open_simple(file, 0);
 }
@@ -1122,7 +1122,7 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 		} else
 			iput(inode);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	return error;
 }
-- 
2.41.0

