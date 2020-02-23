Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8591692D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBWBZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:25:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50292 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBWBZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:25:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g1Q-00HDpc-1m; Sun, 23 Feb 2020 01:25:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 32/34] do_last(): simplify the liveness analysis past finish_open_created
Date:   Sun, 23 Feb 2020 01:16:24 +0000
Message-Id: <20200223011626.4103706-32-viro@ZenIV.linux.org.uk>
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

Don't mess with got_write there - it is guaranteed to be false on
entry and it will be set true if and only if we decide to go for
truncation and manage to get write access for that.

Don't carry acc_mode through the entire thing - it's only used
in that part.  And don't bother with gotos in there - compiler is
quite capable of optimizing that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 51283caaf7c4..ce6f2864a335 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3131,9 +3131,9 @@ static const char *do_last(struct nameidata *nd,
 	kuid_t dir_uid = nd->inode->i_uid;
 	umode_t dir_mode = nd->inode->i_mode;
 	int open_flag = op->open_flag;
-	bool will_truncate = (open_flag & O_TRUNC) != 0;
+	bool do_truncate;
 	bool got_write = false;
-	int acc_mode = op->acc_mode;
+	int acc_mode;
 	unsigned seq;
 	struct inode *inode;
 	struct dentry *dentry;
@@ -3251,36 +3251,30 @@ static const char *do_last(struct nameidata *nd,
 		return ERR_PTR(-ENOTDIR);
 
 finish_open_created:
+	do_truncate = false;
+	acc_mode = op->acc_mode;
 	if (file->f_mode & FMODE_CREATED) {
 		/* Don't check for write permission, don't truncate */
 		open_flag &= ~O_TRUNC;
-		will_truncate = false;
 		acc_mode = 0;
-	} else if (!d_is_reg(nd->path.dentry)) {
-		will_truncate = false;
-	}
-	if (will_truncate) {
+	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
 			return ERR_PTR(error);
-		got_write = true;
+		do_truncate = true;
 	}
 	error = may_open(&nd->path, acc_mode, open_flag);
-	if (error)
-		goto out;
-	if (!(file->f_mode & FMODE_OPENED))
+	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
-	if (error)
-		goto out;
-	error = ima_file_check(file, op->acc_mode);
-	if (!error && will_truncate)
+	if (!error)
+		error = ima_file_check(file, op->acc_mode);
+	if (!error && do_truncate)
 		error = handle_truncate(file);
-out:
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	if (got_write)
+	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
 	return ERR_PTR(error);
 }
-- 
2.11.0

