Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86D1852A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCMXzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50174 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgCMXyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6e4-CD; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 58/69] fold path_to_nameidata() into its only remaining caller
Date:   Fri, 13 Mar 2020 23:53:46 +0000
Message-Id: <20200313235357.2646756-58-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a94ff3d58b51..d58e447db2f1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -860,18 +860,6 @@ static int set_root(struct nameidata *nd)
 	return 0;
 }
 
-static inline void path_to_nameidata(const struct path *path,
-					struct nameidata *nd)
-{
-	if (!(nd->flags & LOOKUP_RCU)) {
-		dput(nd->path.dentry);
-		if (nd->path.mnt != path->mnt)
-			mntput(nd->path.mnt);
-	}
-	nd->path.mnt = path->mnt;
-	nd->path.dentry = path->dentry;
-}
-
 static int nd_jump_root(struct nameidata *nd)
 {
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
@@ -1704,7 +1692,12 @@ static const char *step_into(struct nameidata *nd, int flags,
 	   ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
 	   (flags & WALK_NOFOLLOW)) {
 		/* not a symlink or should not follow */
-		path_to_nameidata(&path, nd);
+		if (!(nd->flags & LOOKUP_RCU)) {
+			dput(nd->path.dentry);
+			if (nd->path.mnt != path.mnt)
+				mntput(nd->path.mnt);
+		}
+		nd->path = path;
 		nd->inode = inode;
 		nd->seq = seq;
 		return NULL;
-- 
2.11.0

