Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C521317503D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCAVyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:54:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41678 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgCAVwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVy-003fP7-1K; Sun, 01 Mar 2020 21:52:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 35/55] do_last(): rejoing the common path earlier in FMODE_{OPENED,CREATED} case
Date:   Sun,  1 Mar 2020 21:52:20 +0000
Message-Id: <20200301215240.873899-35-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b4de0994ccee..66c3e2df46b2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3204,13 +3204,6 @@ static const char *do_last(struct nameidata *nd,
 		return ERR_CAST(dentry);
 
 	if (file->f_mode & FMODE_OPENED) {
-		if (file->f_mode & FMODE_CREATED) {
-			open_flag &= ~O_TRUNC;
-			will_truncate = false;
-			acc_mode = 0;
-		} else if (!S_ISREG(file_inode(file)->i_mode))
-			will_truncate = false;
-
 		audit_inode(nd->name, file->f_path.dentry, 0);
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
@@ -3218,10 +3211,6 @@ static const char *do_last(struct nameidata *nd,
 	}
 
 	if (file->f_mode & FMODE_CREATED) {
-		/* Don't check for write permission, don't truncate */
-		open_flag &= ~O_TRUNC;
-		will_truncate = false;
-		acc_mode = 0;
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
 		goto finish_open_created;
@@ -3255,10 +3244,16 @@ static const char *do_last(struct nameidata *nd,
 	}
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return ERR_PTR(-ENOTDIR);
-	if (!d_is_reg(nd->path.dentry))
-		will_truncate = false;
 
 finish_open_created:
+	if (file->f_mode & FMODE_CREATED) {
+		/* Don't check for write permission, don't truncate */
+		open_flag &= ~O_TRUNC;
+		will_truncate = false;
+		acc_mode = 0;
+	} else if (!d_is_reg(nd->path.dentry)) {
+		will_truncate = false;
+	}
 	if (will_truncate) {
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
-- 
2.11.0

