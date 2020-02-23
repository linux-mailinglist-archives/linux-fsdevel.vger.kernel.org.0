Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38603169297
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBWBRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:17:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50098 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBWBRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:17:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5ftR-00HDad-Nq; Sun, 23 Feb 2020 01:17:22 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 05/34] make build_open_flags() treat O_CREAT | O_EXCL as implying O_NOFOLLOW
Date:   Sun, 23 Feb 2020 01:15:57 +0000
Message-Id: <20200223011626.4103706-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

O_CREAT | O_EXCL means "-EEXIST if we run into a trailing symlink".
As it is, we might or might not have LOOKUP_FOLLOW in op->intent
in that case - that depends upon having O_NOFOLLOW in open flags.
It doesn't matter, since we won't be checking it in that case -
do_last() bails out earlier.

However, making sure it's not set (i.e. acting as if we had an explicit
O_NOFOLLOW) makes the behaviour more explicit and allows to reorder the
check for O_CREAT | O_EXCL in do_last() with the call of step_into()
immediately following it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 15 +++++----------
 fs/open.c  |  4 +++-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6721c5f7e9d5..6938d20aa73a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3396,22 +3396,17 @@ static int do_last(struct nameidata *nd,
 	if (unlikely(error < 0))
 		return error;
 
-	/*
-	 * create/update audit record if it already exists.
-	 */
-	audit_inode(nd->name, path.dentry, 0);
-
-	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
-		path_to_nameidata(&path, nd);
-		return -EEXIST;
-	}
-
 	seq = 0;	/* out of RCU mode, so the value doesn't matter */
 	inode = d_backing_inode(path.dentry);
 finish_lookup:
 	error = step_into(nd, &path, 0, inode, seq);
 	if (unlikely(error))
 		return error;
+
+	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
+		audit_inode(nd->name, nd->path.dentry, 0);
+		return -EEXIST;
+	}
 finish_open:
 	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
 	error = complete_walk(nd);
diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..e5227cd533f4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1049,8 +1049,10 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
 	if (flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
-		if (flags & O_EXCL)
+		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
+			flags |= O_NOFOLLOW;
+		}
 	}
 
 	if (flags & O_DIRECTORY)
-- 
2.11.0

