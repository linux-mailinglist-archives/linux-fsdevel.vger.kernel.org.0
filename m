Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6576A1852E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgCMXx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:53:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49954 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgCMXx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:53:58 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7p-00B6YQ-HO; Fri, 13 Mar 2020 23:53:57 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 03/69] follow_automount(): get rid of dead^Wstillborn code
Date:   Fri, 13 Mar 2020 23:52:51 +0000
Message-Id: <20200313235357.2646756-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

1) no instances of ->d_automount() have ever made use of the "return
ERR_PTR(-EISDIR) if you don't feel like mounting anything" - that's
a rudiment of plans that got superseded before the thing went into
the tree.  Despite the comment in follow_automount(), autofs has
never done that.

2) if there's no ->d_automount() in dentry_operations, filesystems
should not set DCACHE_NEED_AUTOMOUNT in the first place.  None have
ever done so...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c     | 28 +++-------------------------
 fs/namespace.c |  9 ++++++++-
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 626eddb33508..39dd56f5171f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1210,10 +1210,7 @@ EXPORT_SYMBOL(follow_up);
  */
 static int follow_automount(struct path *path, struct nameidata *nd)
 {
-	struct vfsmount *mnt;
-
-	if (!path->dentry->d_op || !path->dentry->d_op->d_automount)
-		return -EREMOTE;
+	struct dentry *dentry = path->dentry;
 
 	/* We don't want to mount if someone's just doing a stat -
 	 * unless they're stat'ing a directory and appended a '/' to
@@ -1228,33 +1225,14 @@ static int follow_automount(struct path *path, struct nameidata *nd)
 	 */
 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
-	    path->dentry->d_inode)
+	    dentry->d_inode)
 		return -EISDIR;
 
 	nd->total_link_count++;
 	if (nd->total_link_count >= 40)
 		return -ELOOP;
 
-	mnt = path->dentry->d_op->d_automount(path);
-	if (IS_ERR(mnt)) {
-		/*
-		 * The filesystem is allowed to return -EISDIR here to indicate
-		 * it doesn't want to automount.  For instance, autofs would do
-		 * this so that its userspace daemon can mount on this dentry.
-		 *
-		 * However, we can only permit this if it's a terminal point in
-		 * the path being looked up; if it wasn't then the remainder of
-		 * the path is inaccessible and we should say so.
-		 */
-		if (PTR_ERR(mnt) == -EISDIR && (nd->flags & LOOKUP_PARENT))
-			return -EREMOTE;
-		return PTR_ERR(mnt);
-	}
-
-	if (!mnt)
-		return 0;
-
-	return finish_automount(mnt, path);
+	return finish_automount(dentry->d_op->d_automount(path), path);
 }
 
 /*
diff --git a/fs/namespace.c b/fs/namespace.c
index 777c3116e62e..743980380a8f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2824,9 +2824,16 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 int finish_automount(struct vfsmount *m, struct path *path)
 {
 	struct dentry *dentry = path->dentry;
-	struct mount *mnt = real_mount(m);
 	struct mountpoint *mp;
+	struct mount *mnt;
 	int err;
+
+	if (!m)
+		return 0;
+	if (IS_ERR(m))
+		return PTR_ERR(m);
+
+	mnt = real_mount(m);
 	/* The new mount record should have at least 2 refs to prevent it being
 	 * expired before we get a chance to add it
 	 */
-- 
2.11.0

