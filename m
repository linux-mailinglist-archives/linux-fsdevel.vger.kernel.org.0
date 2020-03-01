Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73724175041
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCAVyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:54:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41674 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCAVwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVx-003fP1-Ny; Sun, 01 Mar 2020 21:52:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 34/55] do_last(): don't bother with keeping got_write in FMODE_OPENED case
Date:   Sun,  1 Mar 2020 21:52:19 +0000
Message-Id: <20200301215240.873899-34-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's easier to drop it right after lookup_open() and regain if
needed (i.e. if we will need to truncate).  On the non-FMODE_OPENED
path we do that anyway.  In case of FMODE_CREATED we won't be
needing it.  And it's easier to prove correctness that way,
especially since the initial failure to get write access is not
always fatal; proving that we'll never end up truncating in that
case is rather convoluted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 91346e5d8bd8..b4de0994ccee 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3195,11 +3195,14 @@ static const char *do_last(struct nameidata *nd,
 	else
 		inode_unlock_shared(dir->d_inode);
 
-	if (IS_ERR(dentry)) {
-		error = PTR_ERR(dentry);
-		goto out;
+	if (got_write) {
+		mnt_drop_write(nd->path.mnt);
+		got_write = false;
 	}
 
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
 	if (file->f_mode & FMODE_OPENED) {
 		if (file->f_mode & FMODE_CREATED) {
 			open_flag &= ~O_TRUNC;
@@ -3224,16 +3227,6 @@ static const char *do_last(struct nameidata *nd,
 		goto finish_open_created;
 	}
 
-	/*
-	 * If atomic_open() acquired write access it is dropped now due to
-	 * possible mount and symlink following (this might be optimized away if
-	 * necessary...)
-	 */
-	if (got_write) {
-		mnt_drop_write(nd->path.mnt);
-		got_write = false;
-	}
-
 finish_lookup:
 	link = step_into(nd, WALK_TRAILING, dentry, inode, seq);
 	if (unlikely(link)) {
@@ -3253,27 +3246,25 @@ static const char *do_last(struct nameidata *nd,
 		return ERR_PTR(error);
 	audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
-		error = -EISDIR;
 		if (d_is_dir(nd->path.dentry))
-			goto out;
+			return ERR_PTR(-EISDIR);
 		error = may_create_in_sticky(dir_mode, dir_uid,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
-			goto out;
+			return ERR_PTR(error);
 	}
-	error = -ENOTDIR;
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
-		goto out;
+		return ERR_PTR(-ENOTDIR);
 	if (!d_is_reg(nd->path.dentry))
 		will_truncate = false;
 
+finish_open_created:
 	if (will_truncate) {
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
-			goto out;
+			return ERR_PTR(error);
 		got_write = true;
 	}
-finish_open_created:
 	error = may_open(&nd->path, acc_mode, open_flag);
 	if (error)
 		goto out;
-- 
2.11.0

