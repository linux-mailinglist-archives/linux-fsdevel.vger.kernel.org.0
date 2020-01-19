Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786DF141BB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgASDZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:25:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57016 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASDZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:25:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1DO-00BFlc-6j; Sun, 19 Jan 2020 03:25:36 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 7/9] finally fold get_link() into pick_link()
Date:   Sun, 19 Jan 2020 03:17:36 +0000
Message-Id: <20200119031738.2681033-24-viro@ZenIV.linux.org.uk>
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

kill nd->link_inode, while we are at it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 135 ++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 74 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index adb573e0f424..40263f89a54f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -503,7 +503,6 @@ struct nameidata {
 	} *stack, internal[EMBEDDED_LEVELS];
 	struct filename	*name;
 	struct nameidata *saved;
-	struct inode	*link_inode;
 	unsigned	root_seq;
 	int		dfd;
 } __randomize_layout;
@@ -962,9 +961,8 @@ int sysctl_protected_regular __read_mostly;
  *
  * Returns 0 if following the symlink is allowed, -ve on error.
  */
-static inline int may_follow_link(struct nameidata *nd)
+static inline int may_follow_link(struct nameidata *nd, const struct inode *inode)
 {
-	const struct inode *inode;
 	const struct inode *parent;
 	kuid_t puid;
 
@@ -972,7 +970,6 @@ static inline int may_follow_link(struct nameidata *nd)
 		return 0;
 
 	/* Allowed if owner and follower match. */
-	inode = nd->link_inode;
 	if (uid_eq(current_cred()->fsuid, inode->i_uid))
 		return 0;
 
@@ -1105,73 +1102,6 @@ static int may_create_in_sticky(struct dentry * const dir,
 	return 0;
 }
 
-static __always_inline
-const char *get_link(struct nameidata *nd)
-{
-	struct saved *last = nd->stack + nd->depth - 1;
-	struct dentry *dentry = last->link.dentry;
-	struct inode *inode = nd->link_inode;
-	int error;
-	const char *res;
-
-	if (!(nd->flags & LOOKUP_PARENT)) {
-		error = may_follow_link(nd);
-		if (unlikely(error))
-			return ERR_PTR(error);
-	}
-
-	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
-		return ERR_PTR(-ELOOP);
-
-	if (!(nd->flags & LOOKUP_RCU)) {
-		touch_atime(&last->link);
-		cond_resched();
-	} else if (atime_needs_update(&last->link, inode)) {
-		if (unlikely(unlazy_walk(nd)))
-			return ERR_PTR(-ECHILD);
-		touch_atime(&last->link);
-	}
-
-	error = security_inode_follow_link(dentry, inode,
-					   nd->flags & LOOKUP_RCU);
-	if (unlikely(error))
-		return ERR_PTR(error);
-
-	nd->last_type = LAST_BIND;
-	res = READ_ONCE(inode->i_link);
-	if (!res) {
-		const char * (*get)(struct dentry *, struct inode *,
-				struct delayed_call *);
-		get = inode->i_op->get_link;
-		if (nd->flags & LOOKUP_RCU) {
-			res = get(NULL, inode, &last->done);
-			if (res == ERR_PTR(-ECHILD)) {
-				if (unlikely(unlazy_walk(nd)))
-					return ERR_PTR(-ECHILD);
-				res = get(dentry, inode, &last->done);
-			}
-		} else {
-			res = get(dentry, inode, &last->done);
-		}
-		if (!res)
-			goto all_done;
-		if (IS_ERR(res))
-			return res;
-	}
-	if (*res == '/') {
-		error = nd_jump_root(nd);
-		if (unlikely(error))
-			return ERR_PTR(error);
-		while (unlikely(*++res == '/'))
-			;
-	}
-	if (*res)
-		return res;
-all_done: // pure jump
-	put_link(nd);
-	return NULL;
-}
-
 /*
  * follow_up - Find the mountpoint of path's vfsmount
  *
@@ -1795,8 +1725,10 @@ static inline int handle_dots(struct nameidata *nd, int type)
 static const char *pick_link(struct nameidata *nd, struct path *link,
 		     struct inode *inode, unsigned seq)
 {
-	int error;
 	struct saved *last;
+	const char *res;
+	int error;
+
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
 		path_to_nameidata(link, nd);
 		return ERR_PTR(-ELOOP);
@@ -1827,9 +1759,64 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	last = nd->stack + nd->depth++;
 	last->link = *link;
 	clear_delayed_call(&last->done);
-	nd->link_inode = inode;
 	last->seq = seq;
-	return get_link(nd);
+
+	if (!(nd->flags & LOOKUP_PARENT)) {
+		error = may_follow_link(nd, inode);
+		if (unlikely(error))
+			return ERR_PTR(error);
+	}
+
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+		return ERR_PTR(-ELOOP);
+
+	if (!(nd->flags & LOOKUP_RCU)) {
+		touch_atime(&last->link);
+		cond_resched();
+	} else if (atime_needs_update(&last->link, inode)) {
+		if (unlikely(unlazy_walk(nd)))
+			return ERR_PTR(-ECHILD);
+		touch_atime(&last->link);
+	}
+
+	error = security_inode_follow_link(link->dentry, inode,
+					   nd->flags & LOOKUP_RCU);
+	if (unlikely(error))
+		return ERR_PTR(error);
+
+	nd->last_type = LAST_BIND;
+	res = READ_ONCE(inode->i_link);
+	if (!res) {
+		const char * (*get)(struct dentry *, struct inode *,
+				struct delayed_call *);
+		get = inode->i_op->get_link;
+		if (nd->flags & LOOKUP_RCU) {
+			res = get(NULL, inode, &last->done);
+			if (res == ERR_PTR(-ECHILD)) {
+				if (unlikely(unlazy_walk(nd)))
+					return ERR_PTR(-ECHILD);
+				res = get(link->dentry, inode, &last->done);
+			}
+		} else {
+			res = get(link->dentry, inode, &last->done);
+		}
+		if (!res)
+			goto all_done;
+		if (IS_ERR(res))
+			return res;
+	}
+	if (*res == '/') {
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+		while (unlikely(*++res == '/'))
+			;
+	}
+	if (*res)
+		return res;
+all_done: // pure jump
+	put_link(nd);
+	return NULL;
 }
 
 enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
-- 
2.20.1

