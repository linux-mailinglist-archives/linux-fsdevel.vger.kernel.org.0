Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746DF1852AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgCMXzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgCMXyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7w-00B6dm-VH; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 55/69] fs/namei.c: kill follow_mount()
Date:   Fri, 13 Mar 2020 23:53:43 +0000
Message-Id: <20200313235357.2646756-55-viro@ZenIV.linux.org.uk>
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

The only remaining caller (path_pts()) should be using follow_down()
anyway.  And clean path_pts() a bit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a9622e629e76..fc946d6f02d6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1414,22 +1414,6 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
 }
 
 /*
- * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
- */
-static void follow_mount(struct path *path)
-{
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path);
-		if (!mounted)
-			break;
-		dput(path->dentry);
-		mntput(path->mnt);
-		path->mnt = mounted;
-		path->dentry = dget(mounted->mnt_root);
-	}
-}
-
-/*
  * This looks up the name in dcache and possibly revalidates the found dentry.
  * NULL is returned if the dentry does not exist in the cache.
  */
@@ -2639,7 +2623,7 @@ int path_pts(struct path *path)
 	 */
 	struct dentry *parent = dget_parent(path->dentry);
 	struct dentry *child;
-	struct qstr this;
+	struct qstr this = QSTR_INIT("pts", 3);
 
 	if (unlikely(!path_connected(path->mnt, parent))) {
 		dput(parent);
@@ -2647,15 +2631,13 @@ int path_pts(struct path *path)
 	}
 	dput(path->dentry);
 	path->dentry = parent;
-	this.name = "pts";
-	this.len = 3;
 	child = d_hash_and_lookup(parent, &this);
 	if (!child)
 		return -ENOENT;
 
 	path->dentry = child;
 	dput(parent);
-	follow_mount(path);
+	follow_down(path);
 	return 0;
 }
 #endif
-- 
2.11.0

