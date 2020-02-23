Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A751692B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBWBVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:21:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50184 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgBWBVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:21:36 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fxN-00HDhB-US; Sun, 23 Feb 2020 01:21:24 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 19/34] merging pick_link() with get_link(), part 2
Date:   Sun, 23 Feb 2020 01:16:11 +0000
Message-Id: <20200223011626.4103706-19-viro@ZenIV.linux.org.uk>
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

Fold trailing_symlink() into lookup_last() and do_last(), change
the calling conventions of those two.  Rules change:
	success, we are done => NULL instead of 0
	error	=> ERR_PTR(-E...) instead of -E...
	got a symlink to follow => return the path to be followed instead of 1

The loops calling those (in path_lookupat() and path_openat()) adjusted.

A subtle change of control flow here: originally a pure-jump trailing
symlink ("/" or procfs one) would've passed through the upper level
loop once more, with "" for path to traverse.  That would've brought
us back to the lookup_last/do_last entry and we would've hit LAST_BIND
case (LAST_BIND left from get_link() called by trailing_symlink())
and pretty much skip to the point right after where we'd left the
sucker back when we picked that trailing symlink.

Now we don't bother with that extra pass through the upper level
loop - if get_link() says "I've just done a pure jump, nothing
else to do", we just treat that as non-symlink case.

Boilerplate added on that step will go away shortly - it'll migrate
into walk_component() and then to step_into(), collapsing into the
change of calling conventions for those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 68 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3594f6a4998b..888b1e5b994e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2333,21 +2333,26 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	return s;
 }
 
-static const char *trailing_symlink(struct nameidata *nd)
-{
-	const char *s = get_link(nd);
-	nd->flags |= LOOKUP_PARENT;
-	nd->stack[0].name = NULL;
-	return s ? s : "";
-}
-
-static inline int lookup_last(struct nameidata *nd)
+static inline const char *lookup_last(struct nameidata *nd)
 {
+	int err;
 	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	nd->flags &= ~LOOKUP_PARENT;
-	return walk_component(nd, 0);
+	err = walk_component(nd, 0);
+	if (unlikely(err)) {
+		const char *s;
+		if (err < 0)
+			return PTR_ERR(err);
+		s = get_link(nd);
+		if (s) {
+			nd->flags |= LOOKUP_PARENT;
+			nd->stack[0].name = NULL;
+			return s;
+		}
+	}
+	return NULL;
 }
 
 static int handle_lookup_down(struct nameidata *nd)
@@ -2370,10 +2375,9 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 			s = ERR_PTR(err);
 	}
 
-	while (!(err = link_path_walk(s, nd))
-		&& ((err = lookup_last(nd)) > 0)) {
-		s = trailing_symlink(nd);
-	}
+	while (!(err = link_path_walk(s, nd)) &&
+	       (s = lookup_last(nd)) != NULL)
+		;
 	if (!err)
 		err = complete_walk(nd);
 
@@ -3185,7 +3189,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 /*
  * Handle the last step of open()
  */
-static int do_last(struct nameidata *nd,
+static const char *do_last(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
@@ -3206,7 +3210,7 @@ static int do_last(struct nameidata *nd,
 	if (nd->last_type != LAST_NORM) {
 		error = handle_dots(nd, nd->last_type);
 		if (unlikely(error))
-			return error;
+			return ERR_PTR(error);
 		goto finish_open;
 	}
 
@@ -3216,7 +3220,7 @@ static int do_last(struct nameidata *nd,
 		/* we _can_ be in RCU mode here */
 		dentry = lookup_fast(nd, &inode, &seq);
 		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+			return ERR_CAST(dentry);
 		if (likely(dentry))
 			goto finish_lookup;
 
@@ -3231,12 +3235,12 @@ static int do_last(struct nameidata *nd,
 		 */
 		error = complete_walk(nd);
 		if (error)
-			return error;
+			return ERR_PTR(error);
 
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */
 		if (unlikely(nd->last.name[nd->last.len]))
-			return -EISDIR;
+			return ERR_PTR(-EISDIR);
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
@@ -3296,18 +3300,28 @@ static int do_last(struct nameidata *nd,
 
 finish_lookup:
 	error = step_into(nd, 0, dentry, inode, seq);
-	if (unlikely(error))
-		return error;
+	if (unlikely(error)) {
+		const char *s;
+		if (error < 0)
+			return ERR_PTR(error);
+		s = get_link(nd);
+		if (s) {
+			nd->flags |= LOOKUP_PARENT;
+			nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
+			nd->stack[0].name = NULL;
+			return s;
+		}
+	}
 
 	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
 		audit_inode(nd->name, nd->path.dentry, 0);
-		return -EEXIST;
+		return ERR_PTR(-EEXIST);
 	}
 finish_open:
 	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
 	error = complete_walk(nd);
 	if (error)
-		return error;
+		return ERR_PTR(error);
 	audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
 		error = -EISDIR;
@@ -3349,7 +3363,7 @@ static int do_last(struct nameidata *nd,
 	}
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
-	return error;
+	return ERR_PTR(error);
 }
 
 struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
@@ -3452,10 +3466,8 @@ static struct file *path_openat(struct nameidata *nd,
 	} else {
 		const char *s = path_init(nd, flags);
 		while (!(error = link_path_walk(s, nd)) &&
-			(error = do_last(nd, file, op)) > 0) {
-			nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-			s = trailing_symlink(nd);
-		}
+		       (s = do_last(nd, file, op)) != NULL)
+			;
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
-- 
2.11.0

