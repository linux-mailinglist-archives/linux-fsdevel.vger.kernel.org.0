Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627376F216D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 01:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbjD1X5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347070AbjD1X5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8720213C
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 16:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FCD963D5A
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 23:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B820FC4339E;
        Fri, 28 Apr 2023 23:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682726248;
        bh=Jnmh0IrBmttmTsJ0WCR/ajrT00x6rT/seV0gJKIYmJU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pD/kuiRwSeiaw+a3rlOVwEbf2SFB9gMnOMpNwlN9SnOFZ77YFLUDxVHE9pRILS35/
         10g9DbuOPOEROgvxAO4gFMijuuF9jW9O/rKTYPNooj7wfCsb2hc90IcLc4W/eAKwnm
         DsfqrSQxqb+Wr3bXV2Zq+vhpas4EXe07QLPfJDiakvvph0ulCA5x2OaoPz7xoDCXyJ
         A8sLSgnMbrJ5EKks3KG+UXGtP0cMaF4lcTRMiehWZG9CX8xbc6tT5x1GoReocsBvuO
         3e8DjuZMIK8Q6Oe26bZPeuwz4+9TTYnFcjztXSKdiWDB9N0AxBye5yms+fqoGh1HBA
         zltcCVRUpIh5Q==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 29 Apr 2023 01:57:18 +0200
Subject: [PATCH v3 1/4] fs: add path_mounted()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v3-1-377893f74bc8@kernel.org>
References: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Jnmh0IrBmttmTsJ0WCR/ajrT00x6rT/seV0gJKIYmJU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT4xKY2cJz8clrASOQsm2BZ2MF2n7C6KVp/Jydt7RS4fck9
 q8S3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKv+Rn+ShVveSvZYTqvlOfKP6b4ko
 27N5nv2R3JM2VR+v9Vj5wmRTAyTONk+WpVZ2bd8vrZVsc5Cz+YSE05zqP269Ope4b9x6dcYwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

