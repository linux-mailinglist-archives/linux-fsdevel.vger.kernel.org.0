Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1C141B93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgASDWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:22:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56846 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgASDWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:22:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it19p-00BFcA-0A; Sun, 19 Jan 2020 03:21:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 14/17] new step_into() flag: WALK_NOFOLLOW
Date:   Sun, 19 Jan 2020 03:17:26 +0000
Message-Id: <20200119031738.2681033-14-viro@ZenIV.linux.org.uk>
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

Tells step_into() not to follow symlinks, regardless of LOOKUP_FOLLOW.
Allows to switch handle_lookup_down() to of step_into(), getting
all follow_managed() and step_into() calls paired.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d529c1e138ff..44634643475d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1713,7 +1713,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 	return 1;
 }
 
-enum {WALK_FOLLOW = 1, WALK_MORE = 2};
+enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 /*
  * Do we need to follow links? We _really_ want to be able
@@ -1727,7 +1727,8 @@ static inline int step_into(struct nameidata *nd, struct path *path,
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
 	if (likely(!d_is_symlink(path->dentry)) ||
-	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
+	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
+	   flags & WALK_NOFOLLOW) {
 		/* not a symlink or should not follow */
 		path_to_nameidata(path, nd);
 		nd->inode = inode;
@@ -2231,10 +2232,7 @@ static int handle_lookup_down(struct nameidata *nd)
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
2.20.1

