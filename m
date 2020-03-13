Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805701852C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgCMX4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50110 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgCMXyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7u-00B6cJ-MG; Fri, 13 Mar 2020 23:54:02 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 42/69] path_parent_directory(): leave changing path->dentry to callers
Date:   Fri, 13 Mar 2020 23:53:30 +0000
Message-Id: <20200313235357.2646756-42-viro@ZenIV.linux.org.uk>
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

Instead of returning 0, return new dentry; instead of returning
-ENOENT, return NULL.  Adjust the callers accordingly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2bf9f605c46f..49b2a08105c7 100644
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
@@ -2600,13 +2604,13 @@ int path_pts(struct path *path)
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

