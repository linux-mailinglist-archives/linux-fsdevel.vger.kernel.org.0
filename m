Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC8141BAD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgASDZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:25:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56986 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASDZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:25:23 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1Cm-00BFk3-3M; Sun, 19 Jan 2020 03:25:01 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/9] merging pick_link() with get_link(), part 5
Date:   Sun, 19 Jan 2020 03:17:34 +0000
Message-Id: <20200119031738.2681033-22-viro@ZenIV.linux.org.uk>
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

move get_link() call into step_into().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2c7778d95d32..ad6de8b4167e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1840,14 +1840,14 @@ enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
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
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
 	if (likely(!d_is_symlink(path.dentry)) ||
@@ -1857,14 +1857,18 @@ static int step_into(struct nameidata *nd, int flags,
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
+	else
+		return ERR_PTR(err);
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
@@ -1892,13 +1896,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
-	err = step_into(nd, flags, dentry, inode, seq);
-	if (!err)
-		return NULL;
-	else if (err > 0)
-		return get_link(nd);
-	else
-		return ERR_PTR(err);
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
+	const char *link;
 	int error;
 
 	nd->flags &= ~LOOKUP_PARENT;
@@ -3289,18 +3288,12 @@ static const char *do_last(struct nameidata *nd,
 	}
 
 finish_lookup:
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
+	link = step_into(nd, 0, dentry, inode, seq);
+	if (unlikely(link)) {
+		nd->flags |= LOOKUP_PARENT;
+		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
+		nd->stack[0].name = NULL;
+		return link;
 	}
 
 	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
-- 
2.20.1

