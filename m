Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB51852A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgCMXzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50178 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCMXyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6eA-FP; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 59/69] pick_link(): take reserving space on stack into a new helper
Date:   Fri, 13 Mar 2020 23:53:47 +0000
Message-Id: <20200313235357.2646756-59-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d58e447db2f1..c27f657c6b71 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1580,6 +1580,28 @@ static inline int may_lookup(struct nameidata *nd)
 	return inode_permission(nd->inode, MAY_EXEC);
 }
 
+static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
+{
+	int error;
+
+	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS))
+		return -ELOOP;
+	error = nd_alloc_stack(nd);
+	if (likely(!error))
+		return 0;
+	if (error == -ECHILD) {
+		// we must grab link first
+		bool grabbed_link = legitimize_path(nd, link, seq);
+		// ... and we must unlazy to be able to clean up
+		error = unlazy_walk(nd);
+		if (unlikely(!grabbed_link))
+			error = -ECHILD;
+		if (!error)
+			error = nd_alloc_stack(nd);
+	}
+	return error;
+}
+
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 static const char *pick_link(struct nameidata *nd, struct path *link,
@@ -1587,31 +1609,13 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 {
 	struct saved *last;
 	const char *res;
-	int error;
+	int error = reserve_stack(nd, link, seq);
 
-	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
-		if (!(nd->flags & LOOKUP_RCU))
-			path_put(link);
-		return ERR_PTR(-ELOOP);
-	}
-	error = nd_alloc_stack(nd);
 	if (unlikely(error)) {
-		if (error == -ECHILD) {
-			// we must grab link first
-			bool grabbed_link = legitimize_path(nd, link, seq);
-			// ... and we must unlazy to be able to clean up
-			error = unlazy_walk(nd);
-			if (unlikely(!grabbed_link))
-				error = -ECHILD;
-			if (!error)
-				error = nd_alloc_stack(nd);
-		}
-		if (error) {
+		if (!(nd->flags & LOOKUP_RCU))
 			path_put(link);
-			return ERR_PTR(error);
-		}
+		return ERR_PTR(error);
 	}
-
 	last = nd->stack + nd->depth++;
 	last->link = *link;
 	clear_delayed_call(&last->done);
-- 
2.11.0

