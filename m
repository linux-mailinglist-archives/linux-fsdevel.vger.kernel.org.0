Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2D175063
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCAVzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:55:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41594 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAVwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:43 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVu-003fN2-9O; Sun, 01 Mar 2020 21:52:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 14/55] new step_into() flag: WALK_NOFOLLOW
Date:   Sun,  1 Mar 2020 21:51:59 +0000
Message-Id: <20200301215240.873899-14-viro@ZenIV.linux.org.uk>
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

Tells step_into() not to follow symlinks, regardless of LOOKUP_FOLLOW.
Allows to switch handle_lookup_down() to of step_into(), getting
all follow_managed() and step_into() calls paired.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4c9b633e1981..fe48a8d00ae5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1827,7 +1827,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 	return 1;
 }
 
-enum {WALK_FOLLOW = 1, WALK_MORE = 2};
+enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 /*
  * Do we need to follow links? We _really_ want to be able
@@ -1841,7 +1841,8 @@ static inline int step_into(struct nameidata *nd, struct path *path,
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
 	if (likely(!d_is_symlink(path->dentry)) ||
-	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
+	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
+	   flags & WALK_NOFOLLOW) {
 		/* not a symlink or should not follow */
 		path_to_nameidata(path, nd);
 		nd->inode = inode;
@@ -2363,10 +2364,7 @@ static int handle_lookup_down(struct nameidata *nd)
 	err = handle_mounts(nd, nd->path.dentry, &path, &inode, &seq);
 	if (unlikely(err < 0))
 		return err;
-	path_to_nameidata(&path, nd);
-	nd->inode = inode;
-	nd->seq = seq;
-	return 0;
+	return step_into(nd, &path, WALK_NOFOLLOW, inode, seq);
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
-- 
2.11.0

