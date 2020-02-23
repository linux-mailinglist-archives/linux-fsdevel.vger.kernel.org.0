Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E11692D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBWBZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:25:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50276 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgBWBZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:25:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g15-00HDp3-SI; Sun, 23 Feb 2020 01:25:16 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 31/34] do_last(): rejoing the common path earlier in FMODE_{OPENED,CREATED} case
Date:   Sun, 23 Feb 2020 01:16:23 +0000
Message-Id: <20200223011626.4103706-31-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 56285466aa55..51283caaf7c4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3208,13 +3208,6 @@ static const char *do_last(struct nameidata *nd,
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
@@ -3222,10 +3215,6 @@ static const char *do_last(struct nameidata *nd,
 	}
 
 	if (file->f_mode & FMODE_CREATED) {
-		/* Don't check for write permission, don't truncate */
-		open_flag &= ~O_TRUNC;
-		will_truncate = false;
-		acc_mode = 0;
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
 		goto finish_open_created;
@@ -3260,10 +3249,16 @@ static const char *do_last(struct nameidata *nd,
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

