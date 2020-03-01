Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA332175046
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCAVyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:54:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41666 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgCAVwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVx-003fOo-Gs; Sun, 01 Mar 2020 21:52:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 32/55] atomic_open(): lift the call of may_open() into do_last()
Date:   Sun,  1 Mar 2020 21:52:17 +0000
Message-Id: <20200301215240.873899-32-viro@ZenIV.linux.org.uk>
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

there we'll be able to merge it with its counterparts in other
cases, and there's no reason to do it before the parent has
been unlocked

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bfd62fa3856c..9fcb8f635e66 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2952,23 +2952,12 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
-			int acc_mode = op->acc_mode;
 			if (unlikely(dentry != file->f_path.dentry)) {
 				dput(dentry);
 				dentry = dget(file->f_path.dentry);
 			}
-			/*
-			 * We didn't have the inode before the open, so check open
-			 * permission here.
-			 */
-			if (file->f_mode & FMODE_CREATED) {
-				WARN_ON(!(open_flag & O_CREAT));
+			if (file->f_mode & FMODE_CREATED)
 				fsnotify_create(dir, dentry);
-				acc_mode = 0;
-			}
-			error = may_open(&file->f_path, acc_mode, open_flag);
-			if (WARN_ON(error > 0))
-				error = -EINVAL;
 		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
 			error = -EIO;
 		} else {
@@ -3212,12 +3201,19 @@ static const char *do_last(struct nameidata *nd,
 	}
 
 	if (file->f_mode & FMODE_OPENED) {
-		if ((file->f_mode & FMODE_CREATED) ||
-		    !S_ISREG(file_inode(file)->i_mode))
+		if (file->f_mode & FMODE_CREATED) {
+			open_flag &= ~O_TRUNC;
+			will_truncate = false;
+			acc_mode = 0;
+		} else if (!S_ISREG(file_inode(file)->i_mode))
 			will_truncate = false;
 
 		audit_inode(nd->name, file->f_path.dentry, 0);
-		dput(dentry);
+		dput(nd->path.dentry);
+		nd->path.dentry = dentry;
+		error = may_open(&nd->path, acc_mode, open_flag);
+		if (error)
+			goto out;
 		goto opened;
 	}
 
-- 
2.11.0

