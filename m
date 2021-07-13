Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8793C6F48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhGMLSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235908AbhGMLSl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D27561178;
        Tue, 13 Jul 2021 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174951;
        bh=OFkDKvNxw31SKltT2MtCz+x/XsUFs5mFaA5DgkAaxMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4d2d7XcU0jspdVQWJpb+mQgFlXYYcbYFECGS+E/uRjgjKXG0F4Bf06ky8P6G5IlZ
         fMn5SIiIhOUP/+agitE8PtMYo6QacwDVV2dpGFdrxy2WKLVtVBm/EgX79B9ZM9O36k
         hk0wA82QMPoWSFmBkEzAtnWYOZGVbaY+4I4w1NNku1aB9dXLyMnLX9e/gWCTP6hADz
         iSbtJ8pEGBYHJwhXNw86iPO7bcuPWRu3aPTAuYVUNp0J0y5VCln2hKs9UXOarlrXg/
         otY3fG9pStrOO1irA9MtvEfVtiBbE7D3xRsOvHdRsrFvA3uX+w/xuIEVYecOt2IB7e
         UH8rcpd81d30g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 06/24] btrfs/inode: allow idmapped rename iop
Date:   Tue, 13 Jul 2021 13:13:26 +0200
Message-Id: <20210713111344.1149376-7-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; h=from:subject; bh=+u0X0J58uOOWZch/PHzeHjkn22DUeLJo2mBzZTdaecE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY04rNPof+nHLxudQkHXV5+//3p0Puyy/aJpzVPuMqw4 vJHrfUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEZtxi+J+YPE2vLDfAU3BWpVTn+j vnpx8Vr3j5R8Qh/imPXugR5lOMDIujZ/1fsV9xevYMO+bvbOYKHwWrlqYWrp9UO3mL1kLLeTwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_rename() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/inode.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d8aef4cf0972..c0c386cf8a2e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9344,6 +9344,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
+				     struct user_namespace *mnt_userns,
 				     struct inode *dir,
 				     struct dentry *dentry)
 {
@@ -9356,7 +9357,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name,
 				dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)),
@@ -9393,9 +9394,10 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-			   struct inode *new_dir, struct dentry *new_dentry,
-			   unsigned int flags)
+static int btrfs_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
 	struct btrfs_trans_handle *trans;
@@ -9568,8 +9570,8 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	if (flags & RENAME_WHITEOUT) {
-		ret = btrfs_whiteout_for_rename(trans, root, old_dir,
-						old_dentry);
+		ret = btrfs_whiteout_for_rename(trans, root, mnt_userns,
+						old_dir, old_dentry);
 
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -9619,7 +9621,8 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
 		return btrfs_rename_exchange(old_dir, old_dentry, new_dir,
 					  new_dentry);
 
-	return btrfs_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
+	return btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
+			    new_dentry, flags);
 }
 
 struct btrfs_delalloc_work {
-- 
2.30.2

