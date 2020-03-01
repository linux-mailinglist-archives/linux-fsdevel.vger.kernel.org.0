Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5330E175037
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCAVyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:54:02 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCAVws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVy-003fPb-PL; Sun, 01 Mar 2020 21:52:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 40/55] path_parent_directory(): leave changing path->dentry to callers
Date:   Sun,  1 Mar 2020 21:52:25 +0000
Message-Id: <20200301215240.873899-40-viro@ZenIV.linux.org.uk>
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

Instead of returning 0, return new dentry; instead of returning
-ENOENT, return NULL.  Adjust the callers accordingly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 971d0ee11286..8e588632e03a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1440,19 +1440,21 @@ static void follow_mount(struct path *path)
 	}
 }
 
-static int path_parent_directory(struct path *path)
+static struct dentry *path_parent_directory(struct path *path)
 {
-	struct dentry *old = path->dentry;
 	/* rare case of legitimate dget_parent()... */
-	path->dentry = dget_parent(path->dentry);
-	dput(old);
-	if (unlikely(!path_connected(path->mnt, path->dentry)))
-		return -ENOENT;
-	return 0;
+	struct dentry *parent = dget_parent(path->dentry);
+
+	if (unlikely(!path_connected(path->mnt, parent))) {
+		dput(parent);
+		parent = NULL;
+	}
+	return parent;
 }
 
 static int follow_dotdot(struct nameidata *nd)
 {
+	struct dentry *parent;
 	while (1) {
 		if (path_equal(&nd->path, &nd->root)) {
 			if (unlikely(nd->flags & LOOKUP_BENEATH))
@@ -1460,9 +1462,11 @@ static int follow_dotdot(struct nameidata *nd)
 			break;
 		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
-			int ret = path_parent_directory(&nd->path);
-			if (ret)
-				return ret;
+			parent = path_parent_directory(&nd->path);
+			if (!parent)
+				return -ENOENT;
+			dput(nd->path.dentry);
+			nd->path.dentry = parent;
 			break;
 		}
 		if (!follow_up(&nd->path))
@@ -2603,13 +2607,13 @@ int path_pts(struct path *path)
 	 */
 	struct dentry *child, *parent;
 	struct qstr this;
-	int ret;
 
-	ret = path_parent_directory(path);
-	if (ret)
-		return ret;
+	parent = path_parent_directory(path);
+	if (!parent)
+		return -ENOENT;
 
-	parent = path->dentry;
+	dput(path->dentry);
+	path->dentry = parent;
 	this.name = "pts";
 	this.len = 3;
 	child = d_hash_and_lookup(parent, &this);
-- 
2.11.0

