Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F4086141B76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgASDSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:18:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56646 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:18:39 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it16E-00BFTh-AH; Sun, 19 Jan 2020 03:18:09 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 02/17] fix automount/automount race properly
Date:   Sun, 19 Jan 2020 03:17:14 +0000
Message-Id: <20200119031738.2681033-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Protection against automount/automount races (two threads hitting the same
referral point at the same time) is based upon do_add_mount() prevention of
identical overmounts - trying to overmount the root of mounted tree with
the same tree fails with -EBUSY.  It's unreliable (the other thread might've
mounted something on top of the automount it has triggered) *and* causes
no end of headache for follow_automount() and its caller, since
finish_automount() behaves like do_new_mount() - if the mountpoint to be is
overmounted, it mounts on top what's overmounting it.  It's not only wrong
(we want to go into what's overmounting the automount point and quietly
discard what we planned to mount there), it introduces the possibility of
original parent mount getting dropped.  That's what 8aef18845266 (VFS: Fix
vfsmount overput on simultaneous automount) deals with, but it can't do
anything about the reliability of conflict detection - if something had
been overmounted the other thread's automount (e.g. that other thread
having stepped into automount in mount(2)), we don't get that -EBUSY and
the result is
	 referral point under automounted NFS under explicit overmount
under another copy of automounted NFS

What we need is finish_automount() *NOT* digging into overmounts - if it
finds one, it should just quietly discard the thing it was asked to mount.
And don't bother with actually crossing into the results of finish_automount() -
the same loop that calls follow_automount() will do that just fine on the
next iteration.

IOW, instead of calling lock_mount() have finish_automount() do it manually,
_without_ the "move into overmount and retry" part.  And leave crossing into
the results to the caller of follow_automount(), which simplifies it a lot.

Moral: if you end up with a lot of glue working around the calling conventions
of something, perhaps these calling conventions are simply wrong...

Fixes: 8aef18845266 (VFS: Fix vfsmount overput on simultaneous automount)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c     | 29 ++++-------------------------
 fs/namespace.c | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d2720dc71d0e..bd036dfdb0d9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1133,11 +1133,9 @@ EXPORT_SYMBOL(follow_up);
  * - return -EISDIR to tell follow_managed() to stop and return the path we
  *   were called with.
  */
-static int follow_automount(struct path *path, struct nameidata *nd,
-			    bool *need_mntput)
+static int follow_automount(struct path *path, struct nameidata *nd)
 {
 	struct vfsmount *mnt;
-	int err;
 
 	if (!path->dentry->d_op || !path->dentry->d_op->d_automount)
 		return -EREMOTE;
@@ -1178,29 +1176,10 @@ static int follow_automount(struct path *path, struct nameidata *nd,
 		return PTR_ERR(mnt);
 	}
 
-	if (!mnt) /* mount collision */
-		return 0;
-
-	if (!*need_mntput) {
-		/* lock_mount() may release path->mnt on error */
-		mntget(path->mnt);
-		*need_mntput = true;
-	}
-	err = finish_automount(mnt, path);
-
-	switch (err) {
-	case -EBUSY:
-		/* Someone else made a mount here whilst we were busy */
+	if (!mnt)
 		return 0;
-	case 0:
-		path_put(path);
-		path->mnt = mnt;
-		path->dentry = dget(mnt->mnt_root);
-		return 0;
-	default:
-		return err;
-	}
 
+	return finish_automount(mnt, path);
 }
 
 /*
@@ -1258,7 +1237,7 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 
 		/* Handle an automount point */
 		if (flags & DCACHE_NEED_AUTOMOUNT) {
-			ret = follow_automount(path, nd, &need_mntput);
+			ret = follow_automount(path, nd);
 			if (ret < 0)
 				break;
 			continue;
diff --git a/fs/namespace.c b/fs/namespace.c
index 5f0a80f17651..f1817eb5f87d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2823,6 +2823,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 
 int finish_automount(struct vfsmount *m, struct path *path)
 {
+	struct dentry *dentry = path->dentry;
 	struct mount *mnt = real_mount(m);
 	struct mountpoint *mp;
 	int err;
@@ -2832,21 +2833,47 @@ int finish_automount(struct vfsmount *m, struct path *path)
 	BUG_ON(mnt_get_count(mnt) < 2);
 
 	if (m->mnt_sb == path->mnt->mnt_sb &&
-	    m->mnt_root == path->dentry) {
+	    m->mnt_root == dentry) {
 		err = -ELOOP;
-		goto fail;
+		goto discard;
 	}
 
-	mp = lock_mount(path);
+	/*
+	 * we don't want to use lock_mount() - in this case finding something
+	 * that overmounts our mountpoint to be means "quitely drop what we've
+	 * got", not "try to mount it on top".
+	 */
+	inode_lock(dentry->d_inode);
+	if (unlikely(cant_mount(dentry))) {
+		err = -ENOENT;
+		goto discard1;
+	}
+	namespace_lock();
+	rcu_read_lock();
+	if (unlikely(__lookup_mnt(path->mnt, dentry))) {
+		rcu_read_unlock();
+		err = 0;
+		goto discard2;
+	}
+	rcu_read_unlock();
+	mp = get_mountpoint(dentry);
 	if (IS_ERR(mp)) {
 		err = PTR_ERR(mp);
-		goto fail;
+		goto discard2;
 	}
+
 	err = do_add_mount(mnt, mp, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
 	unlock_mount(mp);
-	if (!err)
-		return 0;
-fail:
+	if (unlikely(err))
+		goto discard;
+	mntput(m);
+	return 0;
+
+discard2:
+	namespace_unlock();
+discard1:
+	inode_unlock(dentry->d_inode);
+discard:
 	/* remove m from any expiration list it may be on */
 	if (!list_empty(&mnt->mnt_expire)) {
 		namespace_lock();
-- 
2.20.1

