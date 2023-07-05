Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC3748D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjGETK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjGETIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9019BE;
        Wed,  5 Jul 2023 12:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F3061707;
        Wed,  5 Jul 2023 19:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93859C433C8;
        Wed,  5 Jul 2023 19:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583876;
        bh=VTN22iDlc64pJ0V7tpQfQ3Y7pWhLYJcjLyC9KHu7DZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT6gBYHCRs/6tnJ8EKp/GPZRquTdOojJPymszidSu2ZcARD5LhhDsRCtQ6+No8KUO
         rWhc+OTLxB7j9N3UYTZJn0n6tMjSqrC4/u/HuImKHsYD0G1SJxZvMx5NI2xIzOOwic
         rErhRbOUiS0DqVGDECpI1QGtTByyDJE6Mwf/oKnBXAozpV1CEFcb5FMAKc11ogfUFx
         /b/Cc3Xz+DkxbPOaudF4TIdmqE/pndqJs6e6BnoK9UDx/gEO0k1ygvDuk5VBLAY68d
         Blo/yJZIJajDp0TtVHTaS1MCU5xXSTP+iO8MID38E8as5ZqTXr5/Jti4q6QUzNNl6E
         i4xIcbxGtrIVw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 52/92] hugetlbfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:17 -0400
Message-ID: <20230705190309.579783-50-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hugetlbfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..93d3bcfd4fc8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -887,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 out:
 	inode_unlock(inode);
 	return error;
@@ -935,7 +935,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 		inode->i_mode = S_IFDIR | ctx->mode;
 		inode->i_uid = ctx->uid;
 		inode->i_gid = ctx->gid;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		inode->i_op = &hugetlbfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -979,7 +979,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
 		switch (mode & S_IFMT) {
@@ -1022,7 +1022,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);/* Extra count - pin the dentry in core */
 	return 0;
@@ -1054,7 +1054,7 @@ static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	d_tmpfile(file, inode);
 	return finish_open_simple(file, 0);
 }
@@ -1076,7 +1076,7 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 		} else
 			iput(inode);
 	}
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 
 	return error;
 }
-- 
2.41.0

