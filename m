Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9ED175030
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCAVws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:52:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41686 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgCAVwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVy-003fPJ-9m; Sun, 01 Mar 2020 21:52:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 37/55] do_last(): rejoin the common path even earlier in FMODE_{OPENED,CREATED} case
Date:   Sun,  1 Mar 2020 21:52:22 +0000
Message-Id: <20200301215240.873899-37-viro@ZenIV.linux.org.uk>
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

... getting may_create_in_sticky() checks in FMODE_OPENED case as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index af2eb52c4a8d..66f236d5aee7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3203,14 +3203,7 @@ static const char *do_last(struct nameidata *nd,
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	if (file->f_mode & FMODE_OPENED) {
-		audit_inode(nd->name, file->f_path.dentry, 0);
-		dput(nd->path.dentry);
-		nd->path.dentry = dentry;
-		goto finish_open_created;
-	}
-
-	if (file->f_mode & FMODE_CREATED) {
+	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
 		goto finish_open_created;
@@ -3233,7 +3226,9 @@ static const char *do_last(struct nameidata *nd,
 	error = complete_walk(nd);
 	if (error)
 		return ERR_PTR(error);
-	audit_inode(nd->name, nd->path.dentry, 0);
+finish_open_created:
+	if (!(file->f_mode & FMODE_CREATED))
+		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
 		if (d_is_dir(nd->path.dentry))
 			return ERR_PTR(-EISDIR);
@@ -3245,7 +3240,6 @@ static const char *do_last(struct nameidata *nd,
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return ERR_PTR(-ENOTDIR);
 
-finish_open_created:
 	do_truncate = false;
 	acc_mode = op->acc_mode;
 	if (file->f_mode & FMODE_CREATED) {
-- 
2.11.0

