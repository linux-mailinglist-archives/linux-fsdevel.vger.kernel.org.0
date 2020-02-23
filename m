Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95431692D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBWB0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:26:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50298 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBWB0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:26:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g1j-00HDq5-Jw; Sun, 23 Feb 2020 01:25:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 33/34] do_last(): rejoin the common path even earlier in FMODE_{OPENED,CREATED} case
Date:   Sun, 23 Feb 2020 01:16:25 +0000
Message-Id: <20200223011626.4103706-33-viro@ZenIV.linux.org.uk>
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

... getting may_create_in_sticky() checks in FMODE_OPENED case as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ce6f2864a335..37cbe7806677 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3207,14 +3207,7 @@ static const char *do_last(struct nameidata *nd,
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
@@ -3238,7 +3231,9 @@ static const char *do_last(struct nameidata *nd,
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
@@ -3250,7 +3245,6 @@ static const char *do_last(struct nameidata *nd,
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return ERR_PTR(-ENOTDIR);
 
-finish_open_created:
 	do_truncate = false;
 	acc_mode = op->acc_mode;
 	if (file->f_mode & FMODE_CREATED) {
-- 
2.11.0

