Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A951692A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBWBTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:19:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50144 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgBWBTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:19:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fvh-00HDeS-MZ; Sun, 23 Feb 2020 01:19:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 12/34] teach handle_mounts() to handle RCU mode
Date:   Sun, 23 Feb 2020 01:16:04 +0000
Message-Id: <20200223011626.4103706-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and make the callers of __follow_mount_rcu() use handle_mounts().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 53e859b80b4c..3215b0da6e91 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1393,6 +1393,18 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 
 	path->mnt = nd->path.mnt;
 	path->dentry = dentry;
+	if (nd->flags & LOOKUP_RCU) {
+		unsigned int seq = *seqp;
+		if (unlikely(!*inode))
+			return -ENOENT;
+		if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
+			return 1;
+		if (unlazy_child(nd, dentry, seq))
+			return -ECHILD;
+		// *path might've been clobbered by __follow_mount_rcu()
+		path->mnt = nd->path.mnt;
+		path->dentry = dentry;
+	}
 	ret = follow_managed(path, nd);
 	if (likely(ret >= 0)) {
 		*inode = d_backing_inode(path->dentry);
@@ -1620,7 +1632,6 @@ static int lookup_fast(struct nameidata *nd,
 		       struct path *path, struct inode **inode,
 		       unsigned *seqp)
 {
-	struct vfsmount *mnt = nd->path.mnt;
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
 
@@ -1658,21 +1669,8 @@ static int lookup_fast(struct nameidata *nd,
 
 		*seqp = seq;
 		status = d_revalidate(dentry, nd->flags);
-		if (likely(status > 0)) {
-			/*
-			 * Note: do negative dentry check after revalidation in
-			 * case that drops it.
-			 */
-			if (unlikely(!inode))
-				return -ENOENT;
-			path->mnt = mnt;
-			path->dentry = dentry;
-			if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
-				return 1;
-			if (unlazy_child(nd, dentry, seq))
-				return -ECHILD;
+		if (likely(status > 0))
 			return handle_mounts(nd, dentry, path, inode, seqp);
-		}
 		if (unlazy_child(nd, dentry, seq))
 			return -ECHILD;
 		if (unlikely(status == -ECHILD))
@@ -2361,21 +2359,11 @@ static int handle_lookup_down(struct nameidata *nd)
 	unsigned seq = nd->seq;
 	int err;
 
-	if (nd->flags & LOOKUP_RCU) {
-		/*
-		 * don't bother with unlazy_walk on failure - we are
-		 * at the very beginning of walk, so we lose nothing
-		 * if we simply redo everything in non-RCU mode
-		 */
-		path = nd->path;
-		if (unlikely(!__follow_mount_rcu(nd, &path, &inode, &seq)))
-			return -ECHILD;
-	} else {
+	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
-		err = handle_mounts(nd, nd->path.dentry, &path, &inode, &seq);
-		if (unlikely(err < 0))
-			return err;
-	}
+	err = handle_mounts(nd, nd->path.dentry, &path, &inode, &seq);
+	if (unlikely(err < 0))
+		return err;
 	path_to_nameidata(&path, nd);
 	nd->inode = inode;
 	nd->seq = seq;
-- 
2.11.0

