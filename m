Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44A6BFB53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCRPxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCRPxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02D327D7B
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 08:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5903860EB2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 15:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9730FC433D2;
        Sat, 18 Mar 2023 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154774;
        bh=JdFBUcuGMjNZRHXOy73KO7upXoZZjG6eh1la+hWw78w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kjpPDhupRnI9HJvtndggMAHTT1EDyMfE+S+ARN7XThT+sBdWovmEJ0v5DQbh9qqkZ
         752hNvIZegsa7a259TrDi1ESB6hW/D8awx5NWEsOZHcTcAbFHZZmASqwe0GLMvVFgS
         L6757E9qjsPhCfC6/Sohh/PSsEugiALh+npxvWVCp/tYP3K1maVdga8glF6eIz0hjy
         z/pVQvl9lOmHZligYCsvc2/+/P14VhxkZbkk4emZyyjzwd/QkProxlWBwXI6uIonZJ
         MW493TBorHKRCXNvw38tRfb3IHpvwj4Lm2Lfe18iUp+bfELX4i/3gSHOj8m5HN+ICT
         73H2ClOHaxBXQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 18 Mar 2023 16:51:57 +0100
Subject: [PATCH RFC 1/5] fs: add path_mounted()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v1-1-9b73026d5f10@kernel.org>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=4063; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JdFBUcuGMjNZRHXOy73KO7upXoZZjG6eh1la+hWw78w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSI3gte9+H0T5e3XWdayq1OlLLZfNj/bL3AJ9FPk+r7mYJ8
 Lx8S7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIGy/DP8s0efsz573OO3/+mCs2OW
 X3w+UJ108pZyk4sjKW5Mfc6mJkWBn3uWH26/yKjP3V8ZKtH5dPXrOKX5L3A1dR5AWHj7/t2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a small helper to check whether a path refers to the root of the
mount instead of open-coding this everywhere.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/namespace.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bc0f15257b49..154569fd7343 100644
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

