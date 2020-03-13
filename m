Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4BF1852DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCMX4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50034 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgCMXyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6aO-6f; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 23/69] merging pick_link() with get_link(), part 5
Date:   Fri, 13 Mar 2020 23:53:11 +0000
Message-Id: <20200313235357.2646756-23-viro@ZenIV.linux.org.uk>
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

move get_link() call into step_into().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a05de97e6893..04a76f6dd3fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1841,14 +1841,14 @@ enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
  */
-static int step_into(struct nameidata *nd, int flags,
+static const char *step_into(struct nameidata *nd, int flags,
 		     struct dentry *dentry, struct inode *inode, unsigned seq)
 {
 	struct path path;
 	int err = handle_mounts(nd, dentry, &path, &inode, &seq);
 
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
 	if (likely(!d_is_symlink(path.dentry)) ||
 	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
 	   flags & WALK_NOFOLLOW) {
@@ -1856,14 +1856,17 @@ static int step_into(struct nameidata *nd, int flags,
 		path_to_nameidata(&path, nd);
 		nd->inode = inode;
 		nd->seq = seq;
-		return 0;
+		return NULL;
 	}
 	/* make sure that d_is_symlink above matches inode */
 	if (nd->flags & LOOKUP_RCU) {
 		if (read_seqcount_retry(&path.dentry->d_seq, seq))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 	}
-	return pick_link(nd, &path, inode, seq);
+	err = pick_link(nd, &path, inode, seq);
+	if (err > 0)
+		return get_link(nd);
+	return ERR_PTR(err);
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
@@ -1893,12 +1896,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	err = step_into(nd, flags, dentry, inode, seq);
-	if (!err)
-		return NULL;
-	if (err > 0)
-		return get_link(nd);
-	return ERR_PTR(err);
+	return step_into(nd, flags, dentry, inode, seq);
 }
 
 /*
@@ -2352,8 +2350,8 @@ static int handle_lookup_down(struct nameidata *nd)
 {
 	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
-	return step_into(nd, WALK_NOFOLLOW,
-			nd->path.dentry, nd->inode, nd->seq);
+	return PTR_ERR(step_into(nd, WALK_NOFOLLOW,
+			nd->path.dentry, nd->inode, nd->seq));
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
@@ -3193,6 +3191,7 @@ static const char *do_last(struct nameidata *nd,
 	unsigned seq;
 	struct inode *inode;
 	struct dentry *dentry;
+	const char *res;
 	int error;
 
 	nd->flags &= ~LOOKUP_PARENT;
@@ -3294,18 +3293,12 @@ static const char *do_last(struct nameidata *nd,
 finish_lookup:
 	if (nd->depth)
 		put_link(nd);
-	error = step_into(nd, 0, dentry, inode, seq);
-	if (unlikely(error)) {
-		const char *s;
-		if (error < 0)
-			return ERR_PTR(error);
-		s = get_link(nd);
-		if (s) {
-			nd->flags |= LOOKUP_PARENT;
-			nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-			nd->stack[0].name = NULL;
-			return s;
-		}
+	res = step_into(nd, 0, dentry, inode, seq);
+	if (unlikely(res)) {
+		nd->flags |= LOOKUP_PARENT;
+		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
+		nd->stack[0].name = NULL;
+		return res;
 	}
 
 	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
-- 
2.11.0

