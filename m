Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9272C3C6F67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhGMLTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235920AbhGMLTn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26BD61164;
        Tue, 13 Jul 2021 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175013;
        bh=RvWedfsmMrpM+9NCCB794l2U7Q955yR624q1FcsFZE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+SKauGSqndxS6gPsPnGmiURh8/p9J5mp77sc1Gw3bEEuKC3jPYi85CXpjewQOCQZ
         rZTg24VvauNvHAoWmpmI0pISJCHjTCmEQvXd6v7a3khlrddGlX62Ix7hx/gzuaNGTR
         5isXtWsfrS19tRLqb+XOEQWyg84vlReCjEnjot07vWm0aALYKGFd3eApBuu/THSVXR
         Dd4FrIl9folvr5DrO1JvTUbOXvYKwFGXfwp7xOblH5MZ0k7HfP0AO9M8nPeIOYOnDT
         kFF+iPvnYjjQ3RDJHgkYSqgfl9vp/mczzGEzWOpwthi5VKoyOEJN7HfpqpAYTdVMMJ
         UHAIJivZ51xKA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 18/24] btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with subvolids
Date:   Tue, 13 Jul 2021 13:13:38 +0200
Message-Id: <20210713111344.1149376-19-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; h=from:subject; bh=Xm+yqr5sDrgKlUCWrejT8RAVn07B35vb1JCtXAGZZ7k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY1ROLRp1pkPAVPuTWUOyhUv4ptgL/aZv8z/o/IkvvBX d/8d7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI/2pGhuv77DR23TVdlXZ8ckdO6c 5533+acd54H/7fjmunrnTxhrsM/11ceTUceblXFj6tvbF7685TerkSLC9WbFq/QTLz5RzNJn4A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

So far we prevented the deletion of subvolumes and snapshots using subvolume
ids possible with the BTRFS_SUBVOL_SPEC_BY_ID flag.
This restriction is necessary on idmapped mounts as this allows filesystem wide
subvolume and snapshot deletions and thus can escape the scope of what's
exposed under the mount identified by the fd passed with the ioctl.

Deletion by subvolume id works by looking for an alias of the parent of the
subvolume or snapshot to be deleted. The parent alias can be anywhere in the
filesystem. However, as long as the alias of the parent that is found is the
same as the one identified by the file descriptor passed through the ioctl we
can allow the deletion.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/ioctl.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dd0fabdbeeeb..586ec4af9777 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2943,17 +2943,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			if (err)
 				goto out;
 		} else {
-			/*
-			 * Deleting by subvolume id can be used to delete
-			 * subvolumes/snapshots anywhere in the filesystem.
-			 * Ensure that users can't abuse idmapped mounts of
-			 * btrfs subvolumes/snapshots to perform operations in
-			 * the whole filesystem.
-			 */
-			if (mnt_userns != &init_user_ns) {
-				err = -EINVAL;
-				goto out;
-			}
+			struct inode *old_dir;
 
 			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
 				err = -EINVAL;
@@ -2991,6 +2981,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 				err = PTR_ERR(parent);
 				goto out_drop_write;
 			}
+			old_dir = dir;
 			dir = d_inode(parent);
 
 			/*
@@ -3001,6 +2992,20 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			 */
 			destroy_parent = true;
 
+			/*
+			 * On idmapped mounts, deletion via subvolid is
+			 * restricted to subvolumes that are immediate
+			 * ancestors of the inode referenced by the file
+			 * descriptor in the ioctl. Otherwise the idmapping
+			 * could potentially be abused to delete subvolumes
+			 * anywhere in the filesystem the user wouldn't be able
+			 * to delete without an idmapped mount.
+			 */
+			if (old_dir != dir && mnt_userns != &init_user_ns) {
+				err = -EINVAL;
+				goto free_parent;
+			}
+
 			subvol_name_ptr = btrfs_get_subvol_name_from_objectid(
 						fs_info, vol_args2->subvolid);
 			if (IS_ERR(subvol_name_ptr)) {
-- 
2.30.2

