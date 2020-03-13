Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1D61852EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCMX5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:57:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50006 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgCMXyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7r-00B6Zh-7S; Fri, 13 Mar 2020 23:53:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 16/69] fold handle_mounts() into step_into()
Date:   Fri, 13 Mar 2020 23:53:04 +0000
Message-Id: <20200313235357.2646756-16-viro@ZenIV.linux.org.uk>
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
index e47b376cf442..8f0dea52e9dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1835,29 +1835,33 @@ enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
  */
-static inline int step_into(struct nameidata *nd, struct path *path,
-			    int flags, struct inode *inode, unsigned seq)
+static int step_into(struct nameidata *nd, int flags,
+		     struct dentry *dentry, struct inode *inode, unsigned seq)
 {
-	if (likely(!d_is_symlink(path->dentry)) ||
+	struct path path;
+	int err = handle_mounts(nd, dentry, &path, &inode, &seq);
+
+	if (err < 0)
+		return err;
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
@@ -1883,11 +1887,7 @@ static int walk_component(struct nameidata *nd, int flags)
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-
-	err = handle_mounts(nd, dentry, &path, &inode, &seq);
-	if (unlikely(err < 0))
-			return err;
-	return step_into(nd, &path, flags, inode, seq);
+	return step_into(nd, flags, dentry, inode, seq);
 }
 
 /*
@@ -2354,17 +2354,10 @@ static inline int lookup_last(struct nameidata *nd)
 
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
@@ -3281,7 +3274,6 @@ static int do_last(struct nameidata *nd,
 	int acc_mode = op->acc_mode;
 	unsigned seq;
 	struct inode *inode;
-	struct path path;
 	struct dentry *dentry;
 	int error;
 
@@ -3384,10 +3376,7 @@ static int do_last(struct nameidata *nd,
 finish_lookup:
 	if (nd->depth)
 		put_link(nd);
-	error = handle_mounts(nd, dentry, &path, &inode, &seq);
-	if (unlikely(error < 0))
-		return error;
-	error = step_into(nd, &path, 0, inode, seq);
+	error = step_into(nd, 0, dentry, inode, seq);
 	if (unlikely(error))
 		return error;
 
-- 
2.11.0

