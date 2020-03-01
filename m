Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0DB175024
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCAVx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgCAVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVz-003fQ6-M2; Sun, 01 Mar 2020 21:52:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 45/55] handle_dots(): return ERR_PTR/NULL instead of -E.../0
Date:   Sun,  1 Mar 2020 21:52:30 +0000
Message-Id: <20200301215240.873899-45-viro@ZenIV.linux.org.uk>
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

all callers prefer such calling conventions

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f15b18af991..20a2fc27dd87 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1785,7 +1785,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
-static int handle_dots(struct nameidata *nd, int type, int flags)
+static const char *handle_dots(struct nameidata *nd, int type, int flags)
 {
 	if (type == LAST_DOTDOT) {
 		int error = 0;
@@ -1793,14 +1793,14 @@ static int handle_dots(struct nameidata *nd, int type, int flags)
 		if (!nd->root.mnt) {
 			error = set_root(nd);
 			if (error)
-				return error;
+				return ERR_PTR(error);
 		}
 		if (nd->flags & LOOKUP_RCU)
 			error = follow_dotdot_rcu(nd);
 		else
 			error = follow_dotdot(nd);
 		if (error)
-			return error;
+			return ERR_PTR(error);
 
 		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
 			/*
@@ -1811,14 +1811,14 @@ static int handle_dots(struct nameidata *nd, int type, int flags)
 			 */
 			smp_rmb();
 			if (unlikely(__read_seqcount_retry(&mount_lock.seqcount, nd->m_seq)))
-				return -EAGAIN;
+				return ERR_PTR(-EAGAIN);
 			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
-				return -EAGAIN;
+				return ERR_PTR(-EAGAIN);
 		}
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	return 0;
+	return NULL;
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
@@ -1826,16 +1826,13 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	struct dentry *dentry;
 	struct inode *inode;
 	unsigned seq;
-	int err;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
 	 * parent relationships.
 	 */
-	if (unlikely(nd->last_type != LAST_NORM)) {
-		err = handle_dots(nd, nd->last_type, flags);
-		return ERR_PTR(err);
-	}
+	if (unlikely(nd->last_type != LAST_NORM))
+		return handle_dots(nd, nd->last_type, flags);
 	dentry = lookup_fast(nd, &inode, &seq);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
@@ -3135,17 +3132,17 @@ static const char *open_last_lookups(struct nameidata *nd,
 	unsigned seq;
 	struct inode *inode;
 	struct dentry *dentry;
-	const char *link;
+	const char *res;
 	int error;
 
 	nd->flags &= ~LOOKUP_PARENT;
 	nd->flags |= op->intent;
 
 	if (nd->last_type != LAST_NORM) {
-		error = handle_dots(nd, nd->last_type, WALK_TRAILING);
-		if (likely(!error))
-			error = complete_walk(nd);
-		return ERR_PTR(error);
+		res = handle_dots(nd, nd->last_type, WALK_TRAILING);
+		if (likely(!res))
+			res = ERR_PTR(complete_walk(nd));
+		return res;
 	}
 
 	if (!(open_flag & O_CREAT)) {
@@ -3209,11 +3206,11 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 finish_lookup:
-	link = step_into(nd, WALK_TRAILING, dentry, inode, seq);
-	if (unlikely(link)) {
+	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
+	if (unlikely(res)) {
 		nd->flags |= LOOKUP_PARENT;
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-		return link;
+		return res;
 	}
 
 	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
-- 
2.11.0

