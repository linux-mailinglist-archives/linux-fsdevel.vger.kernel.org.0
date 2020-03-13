Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160041852C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCMX4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50114 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgCMXyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7u-00B6cP-Qc; Fri, 13 Mar 2020 23:54:02 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 43/69] expand path_parent_directory() in its callers
Date:   Fri, 13 Mar 2020 23:53:31 +0000
Message-Id: <20200313235357.2646756-43-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 49b2a08105c7..88e5d7920540 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1440,18 +1440,6 @@ static void follow_mount(struct path *path)
 	}
 }
 
-static struct dentry *path_parent_directory(struct path *path)
-{
-	/* rare case of legitimate dget_parent()... */
-	struct dentry *parent = dget_parent(path->dentry);
-
-	if (unlikely(!path_connected(path->mnt, parent))) {
-		dput(parent);
-		parent = NULL;
-	}
-	return parent;
-}
-
 static int follow_dotdot(struct nameidata *nd)
 {
 	struct dentry *parent;
@@ -1462,9 +1450,13 @@ static int follow_dotdot(struct nameidata *nd)
 			break;
 		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
-			parent = path_parent_directory(&nd->path);
-			if (!parent)
+			/* rare case of legitimate dget_parent()... */
+			parent = dget_parent(nd->path.dentry);
+
+			if (unlikely(!path_connected(nd->path.mnt, parent))) {
+				dput(parent);
 				return -ENOENT;
+			}
 			dput(nd->path.dentry);
 			nd->path.dentry = parent;
 			break;
@@ -2602,13 +2594,14 @@ int path_pts(struct path *path)
 	/* Find something mounted on "pts" in the same directory as
 	 * the input path.
 	 */
-	struct dentry *child, *parent;
+	struct dentry *parent = dget_parent(path->dentry);
+	struct dentry *child;
 	struct qstr this;
 
-	parent = path_parent_directory(path);
-	if (!parent)
+	if (unlikely(!path_connected(path->mnt, parent))) {
+		dput(parent);
 		return -ENOENT;
-
+	}
 	dput(path->dentry);
 	path->dentry = parent;
 	this.name = "pts";
-- 
2.11.0

