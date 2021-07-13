Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB963C6F43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhGMLSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235709AbhGMLSe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 920C16128B;
        Tue, 13 Jul 2021 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174944;
        bh=wIYK+zTwQ7yPDwj/nToSjirA2iz4TxAWTPQjoOOdykY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0xmy1AZt5dLXotHVZBlSnrrHV27znA7tThhN4QbeuZB2m4FFpKz3kSPOUgEju7Am
         iyW2O1i1wH1f8BhSfw5flL2lZQEoGVVEXuW71xCQ/vY6UZIhNKpfnL9BBbg8NGWM2n
         pL7bnnGcIHgOLB/38q7utTBFe8IUbwDHC06LdrxvE6yE2bXzYxPRB6oekPEXiwTEp8
         toBY1AZs8gY6AnQzKmLS6sr11aDjENEmfpb56ib8awRZZNe+IQjT02/BbLrnt0mMlS
         ckBhqzrDJIZFaVGm7Ptxh+zxAJn69zWc90jFFmFhYDu3kVkbFRI3zgV/HlS9WJ9Fsn
         LhGH+ese+APhA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 05/24] btrfs/inode: handle idmaps in btrfs_new_inode()
Date:   Tue, 13 Jul 2021 13:13:25 +0200
Message-Id: <20210713111344.1149376-6-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4609; h=from:subject; bh=lqrQ2ADi/0WAeQ5SMUfIJPUaNfSV/gjOtKDcd4xJdwQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY3wCHV0m9rQuWNX3Ex+hwWz7rBLL7F6ZN2+sfi67ao9 OeLNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpCWL4Z/HxWTunycqTUStuVHGuvf yOa12Ju8Xvz6XrDTZ563jM/cPwh3f7q7zjc66KPbx32fzg33sXWnxX33+1Ikl5r5uxpMDRXHYA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Extend btrfs_new_inode() to take the idmapped mount into account when
initializing a new inode. This is just a matter of passing down the mount's
userns. The rest is taken care of in inode_init_owner(). This is a preliminary
patch to make the individual btrfs inode operations idmapped mount aware.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6eb20987351..d8aef4cf0972 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6281,6 +6281,7 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 
 static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
+				     struct user_namespace *mnt_userns,
 				     struct inode *dir,
 				     const char *name, int name_len,
 				     u64 ref_objectid, u64 objectid,
@@ -6390,7 +6391,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	if (ret != 0)
 		goto fail_unlock;
 
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(mnt_userns, inode, dir, mode);
 	inode_set_bytes(inode, 0);
 
 	inode->i_mtime = current_time(inode);
@@ -6575,9 +6576,9 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-			dentry->d_name.len, btrfs_ino(BTRFS_I(dir)), objectid,
-			mode, &index);
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+			dentry->d_name.name, dentry->d_name.len,
+			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6639,9 +6640,9 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-			dentry->d_name.len, btrfs_ino(BTRFS_I(dir)), objectid,
-			mode, &index);
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+			dentry->d_name.name, dentry->d_name.len,
+			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6784,8 +6785,9 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-			dentry->d_name.len, btrfs_ino(BTRFS_I(dir)), objectid,
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+			dentry->d_name.name, dentry->d_name.len,
+			btrfs_ino(BTRFS_I(dir)), objectid,
 			S_IFDIR | mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -8860,7 +8862,8 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	if (err < 0)
 		return err;
 
-	inode = btrfs_new_inode(trans, new_root, NULL, "..", 2, ino, ino,
+	inode = btrfs_new_inode(trans, new_root, &init_user_ns, NULL, "..", 2,
+				ino, ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
 	if (IS_ERR(inode))
@@ -9353,7 +9356,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	inode = btrfs_new_inode(trans, root, dir,
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
 				dentry->d_name.name,
 				dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)),
@@ -9852,9 +9855,10 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-				dentry->d_name.len, btrfs_ino(BTRFS_I(dir)),
-				objectid, S_IFLNK|S_IRWXUGO, &index);
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+				dentry->d_name.name, dentry->d_name.len,
+				btrfs_ino(BTRFS_I(dir)), objectid,
+				S_IFLNK | S_IRWXUGO, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -10203,7 +10207,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ret)
 		goto out;
 
-	inode = btrfs_new_inode(trans, root, dir, NULL, 0,
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir, NULL, 0,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-- 
2.30.2

