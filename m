Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72AE6CC7A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjC1QNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjC1QNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:13:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178BFE3B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 948FBB81DA5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 16:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5EFC4339E;
        Tue, 28 Mar 2023 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680020003;
        bh=IMnzmusWqH/wdAAywJGvV4jW/PNRucB2FHw5lIG7LRk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Zkuf1TjwjolI/E2x2I1c63SG3BGVT9VxWoOC1C4XX+dc0E15/f37tvYqGNHXaZJpE
         30hWG6ut5M59VLGJKcJtIpK4GqN1hU+vYxLtLdKTCgDVL3gMLK9XNMh/M8f6ht4XN5
         3A51lMDSDj8yMssa4Wh5AYzmZVozIy9rUomP0VPwq4wQx+1iFBTTIZ8jkwPxC678Hl
         kn6pElFyChl1QiBVKmd4GLYaXxWFuCPUDIDiOAGiCiJ5ldrf1lnKOKmB4OaJIr/fyc
         vJM6PJo3f+SGZzSlhiskvGUtn0IL7+Ohm6MJJrlLnqw40km4XlolQdE+4lH9d+X0SC
         inx1XRgWuYU3A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Mar 2023 18:13:06 +0200
Subject: [PATCH v2 1/5] fs: add path_mounted()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v2-1-f53cd31d6392@kernel.org>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IMnzmusWqH/wdAAywJGvV4jW/PNRucB2FHw5lIG7LRk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQoC8l/e1+5jis7vVf3d2H/1KKMGbefxNUHRiZNDGxK+C+p
 +PRWRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETKlzH8ZFTaVPb7jK/DgrQpz1R41j
 fZZTX2yFyrl7uevCW/Tbf2PMNfEbZpnTox6fN3/FXmOvzVfG/xd3lDTz6+tfuOXfQ6NjWGHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

