Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFC1852B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgCMXzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50150 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgCMXyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7w-00B6dT-E6; Fri, 13 Mar 2020 23:54:04 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 52/69] follow_dotdot(): be lazy about changing nd->path
Date:   Fri, 13 Mar 2020 23:53:40 +0000
Message-Id: <20200313235357.2646756-52-viro@ZenIV.linux.org.uk>
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

Change nd->path only after the loop is done and only in case we hadn't
ended up finding ourselves in root.  Same for NO_XDEV check.

That separates the "check how far back do we need to go through the
mount stack" logics from the rest of .. traversal.

NOTE: path_get/path_put introduced here are temporary.  They will
go away later in the series.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e569ccdd3513..bda303090467 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1748,16 +1748,24 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 	if (path_equal(&nd->path, &nd->root))
 		goto in_root;
 	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
+		struct path path = nd->path;
+		path_get(&path);
 		while (1) {
-			if (!follow_up(&nd->path))
+			if (!follow_up(&path)) {
+				path_put(&path);
 				goto in_root;
-			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-				return ERR_PTR(-EXDEV);
-			if (path_equal(&nd->path, &nd->root))
+			}
+			if (path_equal(&path, &nd->root)) {
+				path_put(&path);
 				goto in_root;
-			if (nd->path.dentry != nd->path.mnt->mnt_root)
+			}
+			if (path.dentry != nd->path.mnt->mnt_root)
 				break;
 		}
+		path_put(&nd->path);
+		nd->path = path;
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return ERR_PTR(-EXDEV);
 	}
 	/* rare case of legitimate dget_parent()... */
 	parent = dget_parent(nd->path.dentry);
-- 
2.11.0

