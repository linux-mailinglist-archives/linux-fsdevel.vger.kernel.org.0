Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F341B1852AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCMXzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50182 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgCMXyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6eG-JR; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 60/69] reserve_stack(): switch to __nd_alloc_stack()
Date:   Fri, 13 Mar 2020 23:53:48 +0000
Message-Id: <20200313235357.2646756-60-viro@ZenIV.linux.org.uk>
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

expand the call of nd_alloc_stack() into it (and don't
recheck the depth on the second call)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c27f657c6b71..01ffbc58e761 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -566,15 +566,6 @@ static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
 	return is_subdir(dentry, mnt->mnt_root);
 }
 
-static inline int nd_alloc_stack(struct nameidata *nd)
-{
-	if (likely(nd->depth != EMBEDDED_LEVELS))
-		return 0;
-	if (likely(nd->stack != nd->internal))
-		return 0;
-	return __nd_alloc_stack(nd);
-}
-
 static void drop_links(struct nameidata *nd)
 {
 	int i = nd->depth;
@@ -1586,7 +1577,13 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS))
 		return -ELOOP;
-	error = nd_alloc_stack(nd);
+
+	if (likely(nd->depth != EMBEDDED_LEVELS))
+		return 0;
+	if (likely(nd->stack != nd->internal))
+		return 0;
+
+	error = __nd_alloc_stack(nd);
 	if (likely(!error))
 		return 0;
 	if (error == -ECHILD) {
@@ -1597,7 +1594,7 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 		if (unlikely(!grabbed_link))
 			error = -ECHILD;
 		if (!error)
-			error = nd_alloc_stack(nd);
+			error = __nd_alloc_stack(nd);
 	}
 	return error;
 }
-- 
2.11.0

