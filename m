Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1530E1852D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgCMX4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50052 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgCMXyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6aq-Nh; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 27/69] namei: invert the meaning of WALK_FOLLOW
Date:   Fri, 13 Mar 2020 23:53:15 +0000
Message-Id: <20200313235357.2646756-27-viro@ZenIV.linux.org.uk>
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

old flags & WALK_FOLLOW <=> new !(flags & WALK_TRAILING)
That's what that flag had really been used for.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 438717b462fb..5d25a3874a5b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1819,7 +1819,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	return NULL;
 }
 
-enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
+enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 /*
  * Do we need to follow links? We _really_ want to be able
@@ -1836,8 +1836,8 @@ static const char *step_into(struct nameidata *nd, int flags,
 	if (err < 0)
 		return ERR_PTR(err);
 	if (likely(!d_is_symlink(path.dentry)) ||
-	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
-	   flags & WALK_NOFOLLOW) {
+	   ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
+	   (flags & WALK_NOFOLLOW)) {
 		/* not a symlink or should not follow */
 		path_to_nameidata(&path, nd);
 		nd->inode = inode;
@@ -2190,10 +2190,10 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			if (!name)
 				return 0;
 			/* last component of nested symlink */
-			link = walk_component(nd, WALK_FOLLOW);
+			link = walk_component(nd, 0);
 		} else {
 			/* not the last component */
-			link = walk_component(nd, WALK_FOLLOW | WALK_MORE);
+			link = walk_component(nd, WALK_MORE);
 		}
 		if (unlikely(link)) {
 			if (IS_ERR(link))
@@ -2321,7 +2321,7 @@ static inline const char *lookup_last(struct nameidata *nd)
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	nd->flags &= ~LOOKUP_PARENT;
-	link = walk_component(nd, 0);
+	link = walk_component(nd, WALK_TRAILING);
 	if (link) {
 		nd->flags |= LOOKUP_PARENT;
 		nd->stack[0].name = NULL;
@@ -3276,7 +3276,7 @@ static const char *do_last(struct nameidata *nd,
 finish_lookup:
 	if (nd->depth)
 		put_link(nd);
-	res = step_into(nd, 0, dentry, inode, seq);
+	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
 	if (unlikely(res)) {
 		nd->flags |= LOOKUP_PARENT;
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-- 
2.11.0

