Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D03C6F6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhGMLTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235932AbhGMLTx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB24D6023F;
        Tue, 13 Jul 2021 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175023;
        bh=/cn7CXHyFFjdCM6hf0uMa3DF0r9KkC6Av6VBa32UgCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tF/vv8F9/o6IPtwWG9LmPP8ce7wZobFgP8Pf/fpMbN0oDQXmD13p8RCTcNCKC6wrB
         Wx2ltCEBxJg1bwWPfLpjB8OIdbNqcUPUurKXmv6O1w2AO18T90ae1hqQX7B46xGDg4
         3rFWmcBnihSl2eRB337vOYQsYscvjt5Fehcvooj774+y9zvYJK4+rl814GgYp5ZjPs
         mL+9n6tmlmuEmmwig/rlWmP2KGUNNGz7iXKjlY/0teFVKdB1QabGBADf9vWOgHUgOc
         LVEFLq2fGajwp4LJJJmDq4cm9wNzMVDQ4r3qgdtJwzzc/iCb8/z/pc74ftoHi4PIMp
         4vjz+zBq2HGaw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 21/24] btrfs/ioctl: allow idmapped BTRFS_IOC_INO_LOOKUP_USER ioctl
Date:   Tue, 13 Jul 2021 13:13:41 +0200
Message-Id: <20210713111344.1149376-22-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3737; h=from:subject; bh=NuuA7EtYgP3uwobv3xcJsDqZuSmPZC6F7vuwUE3D+Zc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY2NialIn3b/7tI3zXcmrFmRMZm30YPX747uzberdH5t r8h/2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRG7sYGc4HVmoIHHy2TnplT+e7pb etn/eE7T5RIP/2R/UEQw25yJ+MDOsyLQy/nTjSq5/2NcU3wqUtXGdzV//BMm+rwLs6Um08jAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The BTRFS_IOC_INO_LOOKUP_USER is an unprivileged version of the
BTRFS_IOC_INO_LOOKUP ioctl and has the following restrictions. The main
difference between the two is that BTRFS_IOC_INO_LOOKUP is filesystem wide
operation wheres BTRFS_IOC_INO_LOOKUP_USER is scoped beneath the file
descriptor passed with the ioctl. Specifically, BTRFS_IOC_INO_LOOKUP_USER must
adhere to the following restrictions:
- The caller must be privileged over each inode of each path component for the
  path they are trying to lookup.
- The path for the subvolume the caller is trying to lookup must be reachable
  from the inode associated with the file descriptor passed with the ioctl.
The second condition makes it possible to scope the lookup of the path to the
mount identified by the file descriptor passed with the ioctl. This allows us
to enable this ioctl on idmapped mounts.

Specifically, this is possible because all child subvolumes of a parent
subvolume are reachable when the parent subvolume is mounted. So if the user
had access to open the parent subvolume or has been given the fd then they can
lookup the path if they had access to it provided they were privileged over
each path component.

Note, the BTRFS_IOC_INO_LOOKUP_USER ioctl allows a user to learn the path and
name of a subvolume even though they would otherwise be restricted from doing
so via regular vfs-based lookup.
So think about a parent subvolume with multiple child subvolumes. Someone could
mount he parent subvolume and restrict access to the child subvolumes by
overmounting them with empty directories. At this point the user can't traverse
the child subvolumes and they can't open files in the child subvolumes.
However, they can still learn the path of child subvolumes as long as they have
access to the parent subvolume by using the BTRFS_IOC_INO_LOOKUP_USER ioctl.

The underlying assumption here is that it's ok that the lookup ioctls can't
really take mounts into account other than the original mount the fd belongs to
during lookup. Since this assumption is baked into the original
BTRFS_IOC_INO_LOOKUP_USER ioctl we can extend it to idmapped mounts.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8c1ca9f05f4f..f56b4e159099 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2439,7 +2439,8 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	return ret;
 }
 
-static int btrfs_search_path_in_tree_user(struct inode *inode,
+static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
+				struct inode *inode,
 				struct btrfs_ioctl_ino_lookup_user_args *args)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -2537,7 +2538,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
-			ret = inode_permission(&init_user_ns, temp_inode,
+			ret = inode_permission(mnt_userns, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
 			if (ret) {
@@ -2679,7 +2680,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 		return -EACCES;
 	}
 
-	ret = btrfs_search_path_in_tree_user(inode, args);
+	ret = btrfs_search_path_in_tree_user(file_mnt_user_ns(file), inode, args);
 
 	if (ret == 0 && copy_to_user(argp, args, sizeof(*args)))
 		ret = -EFAULT;
-- 
2.30.2

