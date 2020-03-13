Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB61D1852DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCMX4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgCMXyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6aw-Qi; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 28/69] pick_link(): check for WALK_TRAILING, not LOOKUP_PARENT
Date:   Fri, 13 Mar 2020 23:53:16 +0000
Message-Id: <20200313235357.2646756-28-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5d25a3874a5b..ff028f12cb95 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1723,8 +1723,10 @@ static inline int handle_dots(struct nameidata *nd, int type)
 	return 0;
 }
 
+enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
+
 static const char *pick_link(struct nameidata *nd, struct path *link,
-		     struct inode *inode, unsigned seq)
+		     struct inode *inode, unsigned seq, int flags)
 {
 	struct saved *last;
 	const char *res;
@@ -1762,7 +1764,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	clear_delayed_call(&last->done);
 	last->seq = seq;
 
-	if (!(nd->flags & LOOKUP_PARENT)) {
+	if (flags & WALK_TRAILING) {
 		error = may_follow_link(nd, inode);
 		if (unlikely(error))
 			return ERR_PTR(error);
@@ -1819,8 +1821,6 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	return NULL;
 }
 
-enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
-
 /*
  * Do we need to follow links? We _really_ want to be able
  * to do this check without having to look at inode->i_op,
@@ -1849,7 +1849,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 		if (read_seqcount_retry(&path.dentry->d_seq, seq))
 			return ERR_PTR(-ECHILD);
 	}
-	return pick_link(nd, &path, inode, seq);
+	return pick_link(nd, &path, inode, seq, flags);
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
-- 
2.11.0

