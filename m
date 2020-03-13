Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA9185283
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgCMXyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50210 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgCMXyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6ex-IU; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 67/69] open_last_lookups(): move complete_walk() into do_open()
Date:   Fri, 13 Mar 2020 23:53:55 +0000
Message-Id: <20200313235357.2646756-67-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3e1573373773..88ff59dcfd47 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3127,10 +3127,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (nd->last_type != LAST_NORM) {
 		if (nd->depth)
 			put_link(nd);
-		res = handle_dots(nd, nd->last_type);
-		if (likely(!res))
-			res = ERR_PTR(complete_walk(nd));
-		return res;
+		return handle_dots(nd, nd->last_type);
 	}
 
 	if (!(open_flag & O_CREAT)) {
@@ -3195,13 +3192,9 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (nd->depth)
 		put_link(nd);
 	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
-	if (unlikely(res)) {
+	if (unlikely(res))
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-		return res;
-	}
-
-	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
-	return ERR_PTR(complete_walk(nd));
+	return res;
 }
 
 /*
@@ -3215,6 +3208,11 @@ static int do_open(struct nameidata *nd,
 	int acc_mode;
 	int error;
 
+	if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
+		error = complete_walk(nd);
+		if (error)
+			return error;
+	}
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
-- 
2.11.0

