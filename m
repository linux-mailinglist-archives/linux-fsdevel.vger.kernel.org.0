Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B381141B9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgASDWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:22:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56860 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASDWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:22:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1A4-00BFcX-SW; Sun, 19 Jan 2020 03:22:11 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 15/17] fold handle_mounts() into step_into()
Date:   Sun, 19 Jan 2020 03:17:27 +0000
Message-Id: <20200119031738.2681033-15-viro@ZenIV.linux.org.uk>
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

The following is true:
	* calls of handle_mounts() and step_into() are always
paired in sequences like
	err = handle_mounts(nd, dentry, &path, &inode, &seq);
	if (unlikely(err < 0))
		return err;
	err = step_into(nd, &path, flags, inode, seq);
	* in all such sequences path is uninitialized before and
unused after this pair of calls
	* in all such sequences inode and seq are unused afterwards.

So the call of handle_mounts() can be shifted inside step_into(),
turning 'path' into a local variable in the combined function.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 44634643475d..6c28b969f4d1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1721,31 +1721,35 @@ enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
  */
-static inline int step_into(struct nameidata *nd, struct path *path,
-			    int flags, struct inode *inode, unsigned seq)
+static int step_into(struct nameidata *nd, int flags,
+		     struct dentry *dentry, struct inode *inode, unsigned seq)
 {
+	struct path path;
+	int err = handle_mounts(nd, dentry, &path, &inode, &seq);
+
+	if (err < 0)
+		return err;
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	if (likely(!d_is_symlink(path->dentry)) ||
+	if (likely(!d_is_symlink(path.dentry)) ||
 	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
 	   flags & WALK_NOFOLLOW) {
 		/* not a symlink or should not follow */
-		path_to_nameidata(path, nd);
+		path_to_nameidata(&path, nd);
 		nd->inode = inode;
 		nd->seq = seq;
 		return 0;
 	}
 	/* make sure that d_is_symlink above matches inode */
 	if (nd->flags & LOOKUP_RCU) {
-		if (read_seqcount_retry(&path->dentry->d_seq, seq))
+		if (read_seqcount_retry(&path.dentry->d_seq, seq))
 			return -ECHILD;
 	}
-	return pick_link(nd, path, inode, seq);
+	return pick_link(nd, &path, inode, seq);
 }
 
 static int walk_component(struct nameidata *nd, int flags)
 {
-	struct path path;
 	struct dentry *dentry;
 	struct inode *inode;
 	unsigned seq;
@@ -1769,11 +1773,7 @@ static int walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
-
-	err = handle_mounts(nd, dentry, &path, &inode, &seq);
-	if (unlikely(err < 0))
-			return err;
-	return step_into(nd, &path, flags, inode, seq);
+	return step_into(nd, flags, dentry, inode, seq);
 }
 
 /*
@@ -2222,17 +2222,10 @@ static inline int lookup_last(struct nameidata *nd)
 
 static int handle_lookup_down(struct nameidata *nd)
 {
-	struct path path;
-	struct inode *inode = nd->inode;
-	unsigned seq = nd->seq;
-	int err;
-
 	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
-	err = handle_mounts(nd, nd->path.dentry, &path, &inode, &seq);
-	if (unlikely(err < 0))
-		return err;
-	return step_into(nd, &path, WALK_NOFOLLOW, inode, seq);
+	return step_into(nd, WALK_NOFOLLOW,
+			nd->path.dentry, nd->inode, nd->seq);
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
@@ -3149,7 +3142,6 @@ static int do_last(struct nameidata *nd,
 	int acc_mode = op->acc_mode;
 	unsigned seq;
 	struct inode *inode;
-	struct path path;
 	struct dentry *dentry;
 	int error;
 
@@ -3247,10 +3239,7 @@ static int do_last(struct nameidata *nd,
 	}
 
 finish_lookup:
-	error = handle_mounts(nd, dentry, &path, &inode, &seq);
-	if (unlikely(error < 0))
-		return error;
-	error = step_into(nd, &path, 0, inode, seq);
+	error = step_into(nd, 0, dentry, inode, seq);
 	if (unlikely(error))
 		return error;
 
-- 
2.20.1

