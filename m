Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7C1852AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgCMXzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50186 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgCMXyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6eM-M4; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 61/69] __nd_alloc_stack(): make it return bool
Date:   Fri, 13 Mar 2020 23:53:49 +0000
Message-Id: <20200313235357.2646756-61-viro@ZenIV.linux.org.uk>
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

... and adjust the caller (reserve_stack()).  Rename to nd_alloc_stack(),
while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 01ffbc58e761..c4b6e3c969b7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -529,24 +529,17 @@ static void restore_nameidata(void)
 		kfree(now->stack);
 }
 
-static int __nd_alloc_stack(struct nameidata *nd)
+static bool nd_alloc_stack(struct nameidata *nd)
 {
 	struct saved *p;
 
-	if (nd->flags & LOOKUP_RCU) {
-		p= kmalloc_array(MAXSYMLINKS, sizeof(struct saved),
-				  GFP_ATOMIC);
-		if (unlikely(!p))
-			return -ECHILD;
-	} else {
-		p= kmalloc_array(MAXSYMLINKS, sizeof(struct saved),
-				  GFP_KERNEL);
-		if (unlikely(!p))
-			return -ENOMEM;
-	}
+	p= kmalloc_array(MAXSYMLINKS, sizeof(struct saved),
+			 nd->flags & LOOKUP_RCU ? GFP_ATOMIC : GFP_KERNEL);
+	if (unlikely(!p))
+		return false;
 	memcpy(p, nd->internal, sizeof(nd->internal));
 	nd->stack = p;
-	return 0;
+	return true;
 }
 
 /**
@@ -1573,8 +1566,6 @@ static inline int may_lookup(struct nameidata *nd)
 
 static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 {
-	int error;
-
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS))
 		return -ELOOP;
 
@@ -1582,21 +1573,21 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 		return 0;
 	if (likely(nd->stack != nd->internal))
 		return 0;
-
-	error = __nd_alloc_stack(nd);
-	if (likely(!error))
+	if (likely(nd_alloc_stack(nd)))
 		return 0;
-	if (error == -ECHILD) {
-		// we must grab link first
+
+	if (nd->flags & LOOKUP_RCU) {
+		// we need to grab link before we do unlazy.  And we can't skip
+		// unlazy even if we fail to grab the link - cleanup needs it
 		bool grabbed_link = legitimize_path(nd, link, seq);
-		// ... and we must unlazy to be able to clean up
-		error = unlazy_walk(nd);
-		if (unlikely(!grabbed_link))
-			error = -ECHILD;
-		if (!error)
-			error = __nd_alloc_stack(nd);
+
+		if (unlazy_walk(nd) != 0 || !grabbed_link)
+			return -ECHILD;
+
+		if (nd_alloc_stack(nd))
+			return 0;
 	}
-	return error;
+	return -ENOMEM;
 }
 
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
-- 
2.11.0

