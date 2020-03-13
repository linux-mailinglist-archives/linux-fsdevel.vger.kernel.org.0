Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F431852A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCMXyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50062 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgCMXyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7t-00B6b8-1P; Fri, 13 Mar 2020 23:54:01 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 30/69] namei: have link_path_walk() maintain LOOKUP_PARENT
Date:   Fri, 13 Mar 2020 23:53:18 +0000
Message-Id: <20200313235357.2646756-30-viro@ZenIV.linux.org.uk>
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

set on entry, clear when we get to the last component.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 04c1d798013f..b45ec86dc7b3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2124,6 +2124,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	int err;
 
 	nd->last_type = LAST_ROOT;
+	nd->flags |= LOOKUP_PARENT;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 	while (*name=='/')
@@ -2184,8 +2185,10 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		if (unlikely(!*name)) {
 OK:
 			/* pathname or trailing symlink, done */
-			if (!depth)
+			if (!depth) {
+				nd->flags &= ~LOOKUP_PARENT;
 				return 0;
+			}
 			/* last component of nested symlink */
 			name = nd->stack[--depth].name;
 			link = walk_component(nd, 0);
@@ -2222,7 +2225,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
 
-	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
+	nd->flags = flags | LOOKUP_JUMPED;
 	nd->depth = 0;
 
 	nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
@@ -2314,16 +2317,10 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	const char *link;
 	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
-	nd->flags &= ~LOOKUP_PARENT;
-	link = walk_component(nd, WALK_TRAILING);
-	if (link) {
-		nd->flags |= LOOKUP_PARENT;
-	}
-	return link;
+	return walk_component(nd, WALK_TRAILING);
 }
 
 static int handle_lookup_down(struct nameidata *nd)
@@ -3174,7 +3171,6 @@ static const char *do_last(struct nameidata *nd,
 	const char *res;
 	int error;
 
-	nd->flags &= ~LOOKUP_PARENT;
 	nd->flags |= op->intent;
 
 	if (nd->last_type != LAST_NORM) {
@@ -3275,7 +3271,6 @@ static const char *do_last(struct nameidata *nd,
 		put_link(nd);
 	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
 	if (unlikely(res)) {
-		nd->flags |= LOOKUP_PARENT;
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 		return res;
 	}
-- 
2.11.0

