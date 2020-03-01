Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37427175029
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCAVxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41714 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgCAVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVz-003fPz-Ew; Sun, 01 Mar 2020 21:52:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 44/55] move put_link() into handle_dots()
Date:   Sun,  1 Mar 2020 21:52:29 +0000
Message-Id: <20200301215240.873899-44-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

That closes a harmless irregularity in do_last() - if trailing
symlink ends with . or .. we forget to drop it.  Not a problem,
since nameidata is about to be done with anyway, but let's keep
it more regular.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 76 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index be756aa32240..3f15b18af991 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1654,40 +1654,6 @@ static inline int may_lookup(struct nameidata *nd)
 	return inode_permission(nd->inode, MAY_EXEC);
 }
 
-static inline int handle_dots(struct nameidata *nd, int type)
-{
-	if (type == LAST_DOTDOT) {
-		int error = 0;
-
-		if (!nd->root.mnt) {
-			error = set_root(nd);
-			if (error)
-				return error;
-		}
-		if (nd->flags & LOOKUP_RCU)
-			error = follow_dotdot_rcu(nd);
-		else
-			error = follow_dotdot(nd);
-		if (error)
-			return error;
-
-		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
-			/*
-			 * If there was a racing rename or mount along our
-			 * path, then we can't be sure that ".." hasn't jumped
-			 * above nd->root (and so userspace should retry or use
-			 * some fallback).
-			 */
-			smp_rmb();
-			if (unlikely(__read_seqcount_retry(&mount_lock.seqcount, nd->m_seq)))
-				return -EAGAIN;
-			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
-				return -EAGAIN;
-		}
-	}
-	return 0;
-}
-
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 static const char *pick_link(struct nameidata *nd, struct path *link,
@@ -1819,6 +1785,42 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
+static int handle_dots(struct nameidata *nd, int type, int flags)
+{
+	if (type == LAST_DOTDOT) {
+		int error = 0;
+
+		if (!nd->root.mnt) {
+			error = set_root(nd);
+			if (error)
+				return error;
+		}
+		if (nd->flags & LOOKUP_RCU)
+			error = follow_dotdot_rcu(nd);
+		else
+			error = follow_dotdot(nd);
+		if (error)
+			return error;
+
+		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
+			/*
+			 * If there was a racing rename or mount along our
+			 * path, then we can't be sure that ".." hasn't jumped
+			 * above nd->root (and so userspace should retry or use
+			 * some fallback).
+			 */
+			smp_rmb();
+			if (unlikely(__read_seqcount_retry(&mount_lock.seqcount, nd->m_seq)))
+				return -EAGAIN;
+			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
+				return -EAGAIN;
+		}
+	}
+	if (!(flags & WALK_MORE) && nd->depth)
+		put_link(nd);
+	return 0;
+}
+
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
@@ -1831,9 +1833,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	 * parent relationships.
 	 */
 	if (unlikely(nd->last_type != LAST_NORM)) {
-		err = handle_dots(nd, nd->last_type);
-		if (!(flags & WALK_MORE) && nd->depth)
-			put_link(nd);
+		err = handle_dots(nd, nd->last_type, flags);
 		return ERR_PTR(err);
 	}
 	dentry = lookup_fast(nd, &inode, &seq);
@@ -3142,7 +3142,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	nd->flags |= op->intent;
 
 	if (nd->last_type != LAST_NORM) {
-		error = handle_dots(nd, nd->last_type);
+		error = handle_dots(nd, nd->last_type, WALK_TRAILING);
 		if (likely(!error))
 			error = complete_walk(nd);
 		return ERR_PTR(error);
-- 
2.11.0

