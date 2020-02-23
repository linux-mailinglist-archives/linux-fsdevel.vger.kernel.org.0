Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D11692CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgBWBYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:24:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50250 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBWBYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:24:52 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g0X-00HDmd-ES; Sun, 23 Feb 2020 01:24:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 29/34] do_last(): merge the may_open() calls
Date:   Sun, 23 Feb 2020 01:16:21 +0000
Message-Id: <20200223011626.4103706-29-viro@ZenIV.linux.org.uk>
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

have FMODE_OPENED case rejoin the main path at earlier point

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 16786be13050..f79e020f08fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3215,10 +3215,7 @@ static const char *do_last(struct nameidata *nd,
 		audit_inode(nd->name, file->f_path.dentry, 0);
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
-		error = may_open(&nd->path, acc_mode, open_flag);
-		if (error)
-			goto out;
-		goto opened;
+		goto finish_open_created;
 	}
 
 	if (file->f_mode & FMODE_CREATED) {
@@ -3285,11 +3282,10 @@ static const char *do_last(struct nameidata *nd,
 	error = may_open(&nd->path, acc_mode, open_flag);
 	if (error)
 		goto out;
-	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
-	error = vfs_open(&nd->path, file);
+	if (!(file->f_mode & FMODE_OPENED))
+		error = vfs_open(&nd->path, file);
 	if (error)
 		goto out;
-opened:
 	error = ima_file_check(file, op->acc_mode);
 	if (!error && will_truncate)
 		error = handle_truncate(file);
-- 
2.11.0

