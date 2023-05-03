Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82A86F570C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjECLTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjECLTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 07:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C71B0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 04:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7DF62CD5
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 11:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1898AC4339C;
        Wed,  3 May 2023 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683112740;
        bh=Jnmh0IrBmttmTsJ0WCR/ajrT00x6rT/seV0gJKIYmJU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lC3dIBv8du5WRUw3h/Pfj70tx9fUN6RUi9UOFx286HN16LhXsuYdeKw01oCXLkIrk
         dxCwm9dTkzIev/Ac9uEfz0sMQN7XBdrp80EjWl1uq/VkxqWxfj6Hz2KOnzWmj/kvb8
         0GXEPR4JlwtUMrpfTxXNAakIP5Zg/ip1z/LksGMaWWT3g5VT6Haro3lZTF4lpcXcQX
         JAnFy1pbgdgVNX723OUjsYpMHsFtsn0Ku7vcs3OxBMckfJ4gUhUzGL5uQeJgjhGBAg
         FwJfRYXtLlePbCLmKzWowE4FWh1Jhi5CwKp9tOvaogjhdSYFhJVLqJUsQo0RQq3r2J
         tK4EB+FDrxeqA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 03 May 2023 13:18:39 +0200
Subject: [PATCH v4 1/4] fs: add path_mounted()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v4-1-98f3d80d7eaa@kernel.org>
References: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Jnmh0IrBmttmTsJ0WCR/ajrT00x6rT/seV0gJKIYmJU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQEOStc2V44Wbb/4ssn73f4bpup+SXt2czZO2a/mrjRz0Tc
 ol+Vv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi4U8Y/vB6Kd1ieV2hWaLy48Km8u
 jlfBMLXulsv3NaR3u3z/7Tkycy/BWPyF7Do3X7banK/Z4GZY5rZW+1lRkVtJTlb8x4J6T+lgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a small helper to check whether a path refers to the root of the
mount instead of open-coding this everywhere.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6836e937ee61..ffa56ec633c6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1767,6 +1767,19 @@ bool may_mount(void)
 	return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
+/**
+ * path_mounted - check whether path is mounted
+ * @path: path to check
+ *
+ * Determine whether @path refers to the root of a mount.
+ *
+ * Return: true if @path is the root of a mount, false if not.
+ */
+static inline bool path_mounted(const struct path *path)
+{
+	return path->mnt->mnt_root == path->dentry;
+}
+
 static void warn_mandlock(void)
 {
 	pr_warn_once("=======================================================\n"
@@ -1782,7 +1795,7 @@ static int can_umount(const struct path *path, int flags)
 
 	if (!may_mount())
 		return -EPERM;
-	if (path->dentry != path->mnt->mnt_root)
+	if (!path_mounted(path))
 		return -EINVAL;
 	if (!check_mnt(mnt))
 		return -EINVAL;
@@ -2367,7 +2380,7 @@ static int do_change_type(struct path *path, int ms_flags)
 	int type;
 	int err = 0;
 
-	if (path->dentry != path->mnt->mnt_root)
+	if (!path_mounted(path))
 		return -EINVAL;
 
 	type = flags_to_propagation_type(ms_flags);
@@ -2646,7 +2659,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	if (!check_mnt(mnt))
 		return -EINVAL;
 
-	if (path->dentry != mnt->mnt.mnt_root)
+	if (!path_mounted(path))
 		return -EINVAL;
 
 	if (!can_change_locked_flags(mnt, mnt_flags))
@@ -2685,7 +2698,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (!check_mnt(mnt))
 		return -EINVAL;
 
-	if (path->dentry != path->mnt->mnt_root)
+	if (!path_mounted(path))
 		return -EINVAL;
 
 	if (!can_change_locked_flags(mnt, mnt_flags))
@@ -2775,9 +2788,9 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 
 	err = -EINVAL;
 	/* To and From paths should be mount roots */
-	if (from_path->dentry != from_path->mnt->mnt_root)
+	if (!path_mounted(from_path))
 		goto out;
-	if (to_path->dentry != to_path->mnt->mnt_root)
+	if (!path_mounted(to_path))
 		goto out;
 
 	/* Setting sharing groups is only allowed across same superblock */
@@ -2858,7 +2871,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (old->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
 
-	if (old_path->dentry != old_path->mnt->mnt_root)
+	if (!path_mounted(old_path))
 		goto out;
 
 	if (d_is_dir(new_path->dentry) !=
@@ -2940,8 +2953,7 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
 	}
 
 	/* Refuse the same filesystem on the same mount point */
-	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb &&
-	    path->mnt->mnt_root == path->dentry)
+	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb && path_mounted(path))
 		return -EBUSY;
 
 	if (d_is_symlink(newmnt->mnt.mnt_root))
@@ -3920,11 +3932,11 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	if (new_mnt == root_mnt || old_mnt == root_mnt)
 		goto out4; /* loop, on the same file system  */
 	error = -EINVAL;
-	if (root.mnt->mnt_root != root.dentry)
+	if (!path_mounted(&root))
 		goto out4; /* not a mountpoint */
 	if (!mnt_has_parent(root_mnt))
 		goto out4; /* not attached */
-	if (new.mnt->mnt_root != new.dentry)
+	if (!path_mounted(&new))
 		goto out4; /* not a mountpoint */
 	if (!mnt_has_parent(new_mnt))
 		goto out4; /* not attached */
@@ -4127,7 +4139,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	struct mount *mnt = real_mount(path->mnt);
 	int err = 0;
 
-	if (path->dentry != mnt->mnt.mnt_root)
+	if (!path_mounted(path))
 		return -EINVAL;
 
 	if (kattr->mnt_userns) {

-- 
2.34.1

