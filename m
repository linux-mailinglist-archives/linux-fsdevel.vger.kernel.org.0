Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71E535A334
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDIQ0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIQ0O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 523516105A;
        Fri,  9 Apr 2021 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985561;
        bh=J8t17g23+btk3F9jOLqdBzPhP1M+ElUmU2FMOvdU35s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYeb/mFm+mEB0QdiF1/xJqPdxDngRuMpjybOG2/06Q7K+yLL0Vor6hwciE5X+lYRk
         LX+o7BxirbIPeGapNhfyLS/golrvzFZCwmM1N9K/se5LcQvLrqozE3jDFHwmTEIL2r
         xS/hs2V46dkAmdW9PuosHGxBHjlDoGCZnByL4SYck+C7Egfd59B5thaMRb1X16xzVl
         +PrgehGxXRaCgeiUHeCS62CQfgr9xPQ9ynxdQuSrvv6kWA8jDZAq7AjE93kGqU1toW
         3FEYmoBPom3zPp5SYThpqT158q6K30o6UVGtejhK7jtH7BqlA54/O9alxY49xe8dcZ
         IawG+eMlpIyxw==
From:   Christian Brauner <brauner@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/3] ecryptfs: use private mount in path
Date:   Fri,  9 Apr 2021 18:24:21 +0200
Message-Id: <20210409162422.1326565-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409162422.1326565-1-brauner@kernel.org>
References: <20210409162422.1326565-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=cTiuNNElCYkKGQaeMRo+ULrYG/J4jrYXaS1E1zaTBsk=; m=BfKPJZd/WyI8d3+yV455yfmFFC3JWxIMysPbkeJUUeI=; p=SB/NGq7zX1GFwVbjpRQ5dn1d2ILPE3+QigJ5r9vh9zc=; g=ec6964566ef553203b82917ad7a9c494550e550c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHB/qwAKCRCRxhvAZXjcotgvAPwIhxR vKIQtVgJUZt45ahP/CuM18PjakMhf7IsURPf1eAD/e09EvDHpouyxDuJAdBr4/V103r6dG2cMCltR GCXC7gs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Since [1] we support creating private mounts from a given path's
vfsmount. This makes them very suitable for any filesystem or
filesystem functionality that piggybacks on paths of another filesystem.
Overlayfs, cachefiles, and ecryptfs are three prime examples.

Since private mounts aren't attached in the filesystem they aren't
affected by mount property changes after ecryptfs makes use of them.
This seems a rather desirable property as the underlying path can't e.g.
suddenly go from read-write to read-only and in general it means that
ecryptfs is always in full control of the underlying mount after the
user has allowed it to be used (apart from operations that affect the
superblock of course).

Besides that it also makes things simpler for a variety of other vfs
features. One concrete example is fanotify. When the path->mnt of the
path that is used as a cache has been marked with FAN_MARK_MOUNT the
semantics get tricky as it isn't clear whether the watchers of path->mnt
should get notified about fsnotify events when files are created by
cachefilesd via path->mnt. Using a private mount let's us elegantly
handle this case too and aligns the behavior of stacks created by
overlayfs and cachefiles.

Reading through the codebase of ecryptfs it currently takes path->mnt
and then retrieves that path whenever it needs to perform operations in
the underlying filesystem. Simply drop the old path->mnt once we've
created a private mount and place the new private mnt into path->mnt.
This should be all that is needed to make this work since ecryptfs uses
the same lower path's vfsmount to construct the paths it uses to operate
on the underlying filesystem.

[1]: c771d683a62e ("vfs: introduce clone_private_mount()")
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ecryptfs/main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index cdf40a54a35d..9dcf9a0dd37b 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -476,6 +476,7 @@ static struct file_system_type ecryptfs_fs_type;
 static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags,
 			const char *dev_name, void *raw_data)
 {
+	struct vfsmount *mnt = NULL;
 	struct super_block *s;
 	struct ecryptfs_sb_info *sbi;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
@@ -537,6 +538,14 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 		goto out_free;
 	}
 
+	mnt = clone_private_mount(&path);
+	if (IS_ERR(mnt)) {
+		rc = PTR_ERR(mnt);
+		mnt = NULL;
+		pr_warn("Failed to create private mount for ecryptfs\n");
+		goto out_free;
+	}
+
 	if (check_ruid && !uid_eq(d_inode(path.dentry)->i_uid, current_uid())) {
 		rc = -EPERM;
 		printk(KERN_ERR "Mount of device (uid: %d) not owned by "
@@ -592,6 +601,13 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 
 	/* ->kill_sb() will take care of root_info */
 	ecryptfs_set_dentry_private(s->s_root, root_info);
+
+	/* We've created a private clone of this mount above so drop it now. */
+	mntput(path.mnt);
+
+	/* Use our private mount from now on. */
+	path.mnt = mnt;
+
 	root_info->lower_path = path;
 
 	s->s_flags |= SB_ACTIVE;
@@ -599,6 +615,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 
 out_free:
 	path_put(&path);
+	mntput(mnt);
 out1:
 	deactivate_locked_super(s);
 out:
-- 
2.27.0

