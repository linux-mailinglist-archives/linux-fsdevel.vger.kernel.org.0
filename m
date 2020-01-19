Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561EF141B8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgASDVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:21:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56812 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:21:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it197-00BFaq-Jz; Sun, 19 Jan 2020 03:21:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 12/17] teach handle_mounts() to handle RCU mode
Date:   Sun, 19 Jan 2020 03:17:24 +0000
Message-Id: <20200119031738.2681033-12-viro@ZenIV.linux.org.uk>
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

... and make the callers of __follow_mount_rcu() use handle_mounts().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2e416bd8ee26..a3bed1307a4b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1312,6 +1312,18 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 
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
@@ -1527,7 +1539,6 @@ static int lookup_fast(struct nameidata *nd,
 		       struct path *path, struct inode **inode,
 		       unsigned *seqp)
 {
-	struct vfsmount *mnt = nd->path.mnt;
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
 
@@ -1565,21 +1576,8 @@ static int lookup_fast(struct nameidata *nd,
 
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
@@ -2229,21 +2227,11 @@ static int handle_lookup_down(struct nameidata *nd)
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
2.20.1

