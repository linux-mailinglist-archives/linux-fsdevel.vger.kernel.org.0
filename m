Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254EA141B74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgASDSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:18:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56634 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:18:23 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it162-00BFTJ-CW; Sun, 19 Jan 2020 03:17:57 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/17] do_add_mount(): lift lock_mount/unlock_mount into callers
Date:   Sun, 19 Jan 2020 03:17:13 +0000
Message-Id: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031423.GV8904@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

preparation to finish_automount() fix (next commit)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2fd0c8bcb8c1..5f0a80f17651 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2697,45 +2697,32 @@ static int do_move_mount_old(struct path *path, const char *old_name)
 /*
  * add a mount into a namespace's mount tree
  */
-static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
+static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
+			struct path *path, int mnt_flags)
 {
-	struct mountpoint *mp;
-	struct mount *parent;
-	int err;
+	struct mount *parent = real_mount(path->mnt);
 
 	mnt_flags &= ~MNT_INTERNAL_FLAGS;
 
-	mp = lock_mount(path);
-	if (IS_ERR(mp))
-		return PTR_ERR(mp);
-
-	parent = real_mount(path->mnt);
-	err = -EINVAL;
 	if (unlikely(!check_mnt(parent))) {
 		/* that's acceptable only for automounts done in private ns */
 		if (!(mnt_flags & MNT_SHRINKABLE))
-			goto unlock;
+			return -EINVAL;
 		/* ... and for those we'd better have mountpoint still alive */
 		if (!parent->mnt_ns)
-			goto unlock;
+			return -EINVAL;
 	}
 
 	/* Refuse the same filesystem on the same mount point */
-	err = -EBUSY;
 	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb &&
 	    path->mnt->mnt_root == path->dentry)
-		goto unlock;
+		return -EBUSY;
 
-	err = -EINVAL;
 	if (d_is_symlink(newmnt->mnt.mnt_root))
-		goto unlock;
+		return -EINVAL;
 
 	newmnt->mnt.mnt_flags = mnt_flags;
-	err = graft_tree(newmnt, parent, mp);
-
-unlock:
-	unlock_mount(mp);
-	return err;
+	return graft_tree(newmnt, parent, mp);
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags);
@@ -2748,6 +2735,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
 	struct vfsmount *mnt;
+	struct mountpoint *mp;
 	struct super_block *sb = fc->root->d_sb;
 	int error;
 
@@ -2768,7 +2756,13 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
-	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
+	mp = lock_mount(mountpoint);
+	if (IS_ERR(mp)) {
+		mntput(mnt);
+		return PTR_ERR(mp);
+	}
+	error = do_add_mount(real_mount(mnt), mp, mountpoint, mnt_flags);
+	unlock_mount(mp);
 	if (error < 0)
 		mntput(mnt);
 	return error;
@@ -2830,6 +2824,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 int finish_automount(struct vfsmount *m, struct path *path)
 {
 	struct mount *mnt = real_mount(m);
+	struct mountpoint *mp;
 	int err;
 	/* The new mount record should have at least 2 refs to prevent it being
 	 * expired before we get a chance to add it
@@ -2842,7 +2837,13 @@ int finish_automount(struct vfsmount *m, struct path *path)
 		goto fail;
 	}
 
-	err = do_add_mount(mnt, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
+	mp = lock_mount(path);
+	if (IS_ERR(mp)) {
+		err = PTR_ERR(mp);
+		goto fail;
+	}
+	err = do_add_mount(mnt, mp, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
+	unlock_mount(mp);
 	if (!err)
 		return 0;
 fail:
-- 
2.20.1

