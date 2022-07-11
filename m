Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4256D366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 05:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiGKDiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 23:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGKDh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:37:58 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2075518B09;
        Sun, 10 Jul 2022 20:37:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 9908910052F;
        Mon, 11 Jul 2022 13:37:53 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2jiGe7T7hu11; Mon, 11 Jul 2022 13:37:53 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 8EF2D100507; Mon, 11 Jul 2022 13:37:53 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id D0BDF100507;
        Mon, 11 Jul 2022 13:37:52 +1000 (AEST)
Subject: [PATCH 3/3] vfs: make may_umount_tree() mount namespace aware
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 11:37:52 +0800
Message-ID: <165751067234.210556.2619133379044425664.stgit@donald.themaw.net>
In-Reply-To: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change may_umount_tree() (and the associated autofs code) to use the
propagate_mount_tree_busy() helper so it also checks if propagated
mounts are busy.

This avoids unnecessary umount requests being sent to the automount
daemon when a mount in another mount namespace is in use when the
expire check is done.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c    |   14 ++++++++++++--
 fs/namespace.c        |   32 ++++++++++++++++++++------------
 fs/pnode.h            |    2 --
 include/linux/mount.h |    5 ++++-
 4 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 038b3d2d9f57..1352c454cf1d 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -31,10 +31,13 @@ static int autofs_mount_busy(struct vfsmount *mnt,
 {
 	struct dentry *top = dentry;
 	struct path path = {.mnt = mnt, .dentry = dentry};
+	unsigned int flags;
 	int status = 1;
 
 	pr_debug("dentry %p %pd\n", dentry, dentry);
 
+	/* A reference to the mount is held. */
+	flags = TREE_BUSY_REFERENCED;
 	path_get(&path);
 
 	if (!follow_down_one(&path))
@@ -55,7 +58,7 @@ static int autofs_mount_busy(struct vfsmount *mnt,
 	}
 
 	/* Update the expiry counter if fs is busy */
-	if (!may_umount_tree(path.mnt)) {
+	if (!may_umount_tree(path.mnt, flags)) {
 		struct autofs_info *ino;
 
 		ino = autofs_dentry_ino(top);
@@ -152,14 +155,21 @@ static int autofs_direct_busy(struct vfsmount *mnt,
 			      unsigned long timeout,
 			      unsigned int how)
 {
+	unsigned int flags;
+
 	pr_debug("top %p %pd\n", top, top);
 
 	/* Forced expire, user space handles busy mounts */
 	if (how & AUTOFS_EXP_FORCED)
 		return 0;
 
+	/* A mounted direct mount will have an open file handle
+	 * associated with it so we need TREE_BUSY_REFERENCED.
+	 */
+	flags = TREE_BUSY_REFERENCED;
+
 	/* If it's busy update the expiry counters */
-	if (!may_umount_tree(mnt)) {
+	if (!may_umount_tree(mnt, flags)) {
 		struct autofs_info *ino;
 
 		ino = autofs_dentry_ino(top);
diff --git a/fs/namespace.c b/fs/namespace.c
index 3c1ee5b5bb69..bdcb55e821f4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1431,28 +1431,36 @@ void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
  * open files, pwds, chroots or sub mounts that are
  * busy.
  */
-int may_umount_tree(struct vfsmount *m)
+int may_umount_tree(struct vfsmount *m, unsigned int flags)
 {
 	struct mount *mnt = real_mount(m);
-	int actual_refs = 0;
-	int minimum_refs = 0;
 	struct mount *p;
+	int ret = 1;
+
 	BUG_ON(!m);
 
-	/* write lock needed for mnt_get_count */
+	down_read(&namespace_sem);
 	lock_mount_hash();
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		actual_refs += mnt_get_count(p);
-		minimum_refs += 2;
+	if (propagate_mount_tree_busy(mnt, flags)) {
+		ret = 0;
+		goto out;
 	}
+	/* Only the passed in mount will have a reference held by
+	 * the caller.
+	 */
+	flags &= ~TREE_BUSY_REFERENCED;
+	for (p = next_mnt(mnt, mnt); p; p = next_mnt(p, mnt)) {
+		if (propagate_mount_tree_busy(p, flags)) {
+			ret = 0;
+			break;
+		}
+	}
+out:
 	unlock_mount_hash();
+	up_read(&namespace_sem);
 
-	if (actual_refs > minimum_refs)
-		return 0;
-
-	return 1;
+	return ret;
 }
-
 EXPORT_SYMBOL(may_umount_tree);
 
 /**
diff --git a/fs/pnode.h b/fs/pnode.h
index d7b9dddb257b..12c3ab5962a0 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -30,8 +30,6 @@
 
 #define CL_COPY_ALL		(CL_COPY_UNBINDABLE | CL_COPY_MNT_NS_FILE)
 
-#define TREE_BUSY_REFERENCED	0x01
-
 static inline void set_mnt_shared(struct mount *mnt)
 {
 	mnt->mnt.mnt_flags &= ~MNT_SHARED_MASK;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 55a4abaf6715..c21d74ea3d85 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -112,7 +112,10 @@ extern bool our_mnt(struct vfsmount *mnt);
 
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern void kern_unmount(struct vfsmount *mnt);
-extern int may_umount_tree(struct vfsmount *);
+
+#define TREE_BUSY_REFERENCED	0x01
+
+extern int may_umount_tree(struct vfsmount *m, unsigned int flags);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);


