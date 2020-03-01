Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389E4175045
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCAVwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:52:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCAVwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVv-003fNj-To; Sun, 01 Mar 2020 21:52:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 21/55] merging pick_link() with get_link(), part 4
Date:   Sun,  1 Mar 2020 21:52:06 +0000
Message-Id: <20200301215240.873899-21-viro@ZenIV.linux.org.uk>
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

Move the call of get_link() into walk_component().  Change the
calling conventions for walk_component() to returning the link
body to follow (if any).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 59 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 46cd3e5cb052..21bd4cebd71b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1868,7 +1868,7 @@ static int step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq);
 }
 
-static int walk_component(struct nameidata *nd, int flags)
+static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -1883,17 +1883,22 @@ static int walk_component(struct nameidata *nd, int flags)
 		err = handle_dots(nd, nd->last_type);
 		if (!(flags & WALK_MORE) && nd->depth)
 			put_link(nd);
-		return err;
+		return ERR_PTR(err);
 	}
 	dentry = lookup_fast(nd, &inode, &seq);
 	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
+		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
 		dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
 		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+			return ERR_CAST(dentry);
 	}
-	return step_into(nd, flags, dentry, inode, seq);
+	err = step_into(nd, flags, dentry, inode, seq);
+	if (!err)
+		return NULL;
+	if (err > 0)
+		return get_link(nd);
+	return ERR_PTR(err);
 }
 
 /*
@@ -2145,6 +2150,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
+		const char *link;
 		u64 hash_len;
 		int type;
 
@@ -2202,24 +2208,18 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			if (!name)
 				return 0;
 			/* last component of nested symlink */
-			err = walk_component(nd, WALK_FOLLOW);
+			link = walk_component(nd, WALK_FOLLOW);
 		} else {
 			/* not the last component */
-			err = walk_component(nd, WALK_FOLLOW | WALK_MORE);
+			link = walk_component(nd, WALK_FOLLOW | WALK_MORE);
 		}
-		if (err < 0)
-			return err;
-
-		if (err) {
-			const char *s = get_link(nd);
-
-			if (IS_ERR(s))
-				return PTR_ERR(s);
-			if (likely(s)) {
-				nd->stack[nd->depth - 1].name = name;
-				name = s;
-				continue;
-			}
+		if (unlikely(link)) {
+			if (IS_ERR(link))
+				return PTR_ERR(link);
+			/* a symlink to follow */
+			nd->stack[nd->depth - 1].name = name;
+			name = link;
+			continue;
 		}
 		if (unlikely(!d_can_lookup(nd->path.dentry))) {
 			if (nd->flags & LOOKUP_RCU) {
@@ -2335,24 +2335,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	int err;
+	const char *link;
 	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	nd->flags &= ~LOOKUP_PARENT;
-	err = walk_component(nd, 0);
-	if (unlikely(err)) {
-		const char *s;
-		if (err < 0)
-			return PTR_ERR(err);
-		s = get_link(nd);
-		if (s) {
-			nd->flags |= LOOKUP_PARENT;
-			nd->stack[0].name = NULL;
-			return s;
-		}
+	link = walk_component(nd, 0);
+	if (link) {
+		nd->flags |= LOOKUP_PARENT;
+		nd->stack[0].name = NULL;
 	}
-	return NULL;
+	return link;
 }
 
 static int handle_lookup_down(struct nameidata *nd)
-- 
2.11.0

