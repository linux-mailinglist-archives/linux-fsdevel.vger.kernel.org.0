Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184791692A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBWBUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:20:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50150 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBWBUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:20:00 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fvv-00HDes-Hx; Sun, 23 Feb 2020 01:19:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 13/34] lookup_fast(): take mount traversal into callers
Date:   Sun, 23 Feb 2020 01:16:05 +0000
Message-Id: <20200223011626.4103706-13-viro@ZenIV.linux.org.uk>
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

Current calling conventions: -E... on error, 0 on cache miss,
result of handle_mounts(nd, dentry, path, inode, seqp) on
success.  Turn that into returning ERR_PTR(-E...), NULL and dentry
resp.; deal with handle_mounts() in the callers.  The thing
is, they already do that in cache miss handling case, so we
just need to supply dentry to them and unify the mount traversal
in those cases.  Fewer arguments that way, and we get closer
to merging handle_mounts() and step_into().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3215b0da6e91..4c9b633e1981 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1628,9 +1628,9 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	return dentry;
 }
 
-static int lookup_fast(struct nameidata *nd,
-		       struct path *path, struct inode **inode,
-		       unsigned *seqp)
+static struct dentry *lookup_fast(struct nameidata *nd,
+				  struct inode **inode,
+			          unsigned *seqp)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
@@ -1645,8 +1645,8 @@ static int lookup_fast(struct nameidata *nd,
 		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
 		if (unlikely(!dentry)) {
 			if (unlazy_walk(nd))
-				return -ECHILD;
-			return 0;
+				return ERR_PTR(-ECHILD);
+			return NULL;
 		}
 
 		/*
@@ -1655,7 +1655,7 @@ static int lookup_fast(struct nameidata *nd,
 		 */
 		*inode = d_backing_inode(dentry);
 		if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 
 		/*
 		 * This sequence count validates that the parent had no
@@ -1665,30 +1665,30 @@ static int lookup_fast(struct nameidata *nd,
 		 *  enough, we can use __read_seqcount_retry here.
 		 */
 		if (unlikely(__read_seqcount_retry(&parent->d_seq, nd->seq)))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 
 		*seqp = seq;
 		status = d_revalidate(dentry, nd->flags);
 		if (likely(status > 0))
-			return handle_mounts(nd, dentry, path, inode, seqp);
+			return dentry;
 		if (unlazy_child(nd, dentry, seq))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 		if (unlikely(status == -ECHILD))
 			/* we'd been told to redo it in non-rcu mode */
 			status = d_revalidate(dentry, nd->flags);
 	} else {
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
-			return 0;
+			return NULL;
 		status = d_revalidate(dentry, nd->flags);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
 			d_invalidate(dentry);
 		dput(dentry);
-		return status;
+		return ERR_PTR(status);
 	}
-	return handle_mounts(nd, dentry, path, inode, seqp);
+	return dentry;
 }
 
 /* Fast lookup failed, do it the slow way */
@@ -1874,19 +1874,18 @@ static int walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return err;
 	}
-	err = lookup_fast(nd, &path, &inode, &seq);
-	if (unlikely(err <= 0)) {
-		if (err < 0)
-			return err;
+	dentry = lookup_fast(nd, &inode, &seq);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	if (unlikely(!dentry)) {
 		dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
-
-		err = handle_mounts(nd, dentry, &path, &inode, &seq);
-		if (unlikely(err < 0))
-			return err;
 	}
 
+	err = handle_mounts(nd, dentry, &path, &inode, &seq);
+	if (unlikely(err < 0))
+			return err;
 	return step_into(nd, &path, flags, inode, seq);
 }
 
@@ -3304,13 +3303,12 @@ static int do_last(struct nameidata *nd,
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 		/* we _can_ be in RCU mode here */
-		error = lookup_fast(nd, &path, &inode, &seq);
-		if (likely(error > 0))
+		dentry = lookup_fast(nd, &inode, &seq);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+		if (likely(dentry))
 			goto finish_lookup;
 
-		if (error < 0)
-			return error;
-
 		BUG_ON(nd->inode != dir->d_inode);
 		BUG_ON(nd->flags & LOOKUP_RCU);
 	} else {
@@ -3385,10 +3383,10 @@ static int do_last(struct nameidata *nd,
 		got_write = false;
 	}
 
+finish_lookup:
 	error = handle_mounts(nd, dentry, &path, &inode, &seq);
 	if (unlikely(error < 0))
 		return error;
-finish_lookup:
 	error = step_into(nd, &path, 0, inode, seq);
 	if (unlikely(error))
 		return error;
-- 
2.11.0

