Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1161D185296
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgCMXyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50218 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgCMXyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6f9-Qe; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 69/69] lookup_open(): don't bother with fallbacks to lookup+create
Date:   Fri, 13 Mar 2020 23:53:57 +0000
Message-Id: <20200313235357.2646756-69-viro@ZenIV.linux.org.uk>
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

We fall back to lookup+create (instead of atomic_open) in several cases:
	1) we don't have write access to filesystem and O_TRUNC is
present in the flags.  It's not something we want ->atomic_open() to
see - it just might go ahead and truncate the file.  However, we can
pass it the flags sans O_TRUNC - eventually do_open() will call
handle_truncate() anyway.
	2) we have O_CREAT | O_EXCL and we can't write to parent.
That's going to be an error, of course, but we want to know _which_
error should that be - might be EEXIST (if file exists), might be
EACCES or EROFS.  Simply stripping O_CREAT (and checking if we see
ENOENT) would suffice, if not for O_EXCL.  However, we used to have
->atomic_open() fully responsible for rejecting O_CREAT | O_EXCL
on existing file and just stripping O_CREAT would've disarmed
those checks.  With nothing downstream to catch the problem -
FMODE_OPENED used to be "don't bother with EEXIST checks,
->atomic_open() has done those".  Now EEXIST checks downstream
are skipped only if FMODE_CREATED is set - FMODE_OPENED alone
is not enough.  That has eliminated the need to fall back onto
lookup+create path in this case.
	3) O_WRONLY or O_RDWR when we have no write access to
filesystem, with nothing else objectionable.  Fallback is
(and had always been) pointless.

IOW, we don't really need that fallback; all we need in such
cases is to trim O_TRUNC and O_CREAT properly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 36b15f5b09bd..f4ac81b60a95 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2938,9 +2938,6 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	struct inode *dir =  nd->path.dentry->d_inode;
 	int error;
 
-	if (!(~open_flag & (O_EXCL | O_CREAT)))	/* both O_EXCL and O_CREAT */
-		open_flag &= ~O_TRUNC;
-
 	if (nd->flags & LOOKUP_DIRECTORY)
 		open_flag |= O_DIRECTORY;
 
@@ -3037,32 +3034,20 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	 * Another problem is returing the "right" error value (e.g. for an
 	 * O_EXCL open we want to return EEXIST not EROFS).
 	 */
+	if (unlikely(!got_write))
+		open_flag &= ~O_TRUNC;
 	if (open_flag & O_CREAT) {
+		if (open_flag & O_EXCL)
+			open_flag &= ~O_TRUNC;
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current_umask();
-		if (unlikely(!got_write)) {
-			create_error = -EROFS;
-			open_flag &= ~O_CREAT;
-			if (open_flag & (O_EXCL | O_TRUNC))
-				goto no_open;
-			/* No side effects, safe to clear O_CREAT */
-		} else {
+		if (likely(got_write))
 			create_error = may_o_create(&nd->path, dentry, mode);
-			if (create_error) {
-				open_flag &= ~O_CREAT;
-				if (open_flag & O_EXCL)
-					goto no_open;
-			}
-		}
-	} else if ((open_flag & (O_TRUNC|O_WRONLY|O_RDWR)) &&
-		   unlikely(!got_write)) {
-		/*
-		 * No O_CREATE -> atomicity not a requirement -> fall
-		 * back to lookup + open
-		 */
-		goto no_open;
+		else
+			create_error = -EROFS;
 	}
-
+	if (create_error)
+		open_flag &= ~O_CREAT;
 	if (dir_inode->i_op->atomic_open) {
 		dentry = atomic_open(nd, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
@@ -3070,7 +3055,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		return dentry;
 	}
 
-no_open:
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
 							     nd->flags);
-- 
2.11.0

