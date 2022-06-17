Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE354F099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380029AbiFQFgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380109AbiFQFgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:36:04 -0400
Received: from smtp03.aussiebb.com.au (smtp03.aussiebb.com.au [121.200.0.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42066C8C;
        Thu, 16 Jun 2022 22:36:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 6B1831A00A2;
        Fri, 17 Jun 2022 15:35:58 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cgjuU-QEkJUA; Fri, 17 Jun 2022 15:35:58 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id 63C9C1A00A4; Fri, 17 Jun 2022 15:35:58 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id AF5BA1A0085;
        Fri, 17 Jun 2022 15:35:57 +1000 (AEST)
Subject: [PATCH 6/6] autofs: manage dentry info mount trigger flags better
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:35:57 +0800
Message-ID: <165544415748.250070.14681426149656207251.stgit@donald.themaw.net>
In-Reply-To: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
References: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The autofs managed dentry flags are left set for dentries in an
autofs mount directory regardless of whether the dentry should
trigger a mount (a non-empty directory or a symlink doesn't).

But properly managing these flags can sometimes provide the loop
termination condition needed when following mounts which now uses
an -EISDIR return.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   97 +++++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index ca03c1cae2be..d140d06c5bc6 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -529,9 +529,8 @@ static struct dentry *autofs_lookup(struct inode *dir,
 
 		spin_lock(&sbi->lookup_lock);
 		spin_lock(&dentry->d_lock);
-		/* Mark entries in the root as mount triggers */
-		if (IS_ROOT(dentry->d_parent) &&
-		    autofs_type_indirect(sbi->type))
+		/* Mark indirect mount entries as mount triggers */
+		if (autofs_type_indirect(sbi->type))
 			__managed_dentry_set_managed(dentry);
 		dentry->d_fsdata = ino;
 		ino->dentry = dentry;
@@ -567,7 +566,9 @@ static int autofs_dir_symlink(struct user_namespace *mnt_userns,
 			      struct inode *dir, struct dentry *dentry,
 			      const char *symname)
 {
+	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
+	struct dentry *parent = dentry->d_parent;
 	struct autofs_info *p_ino;
 	struct inode *inode;
 	size_t size = strlen(symname);
@@ -602,6 +603,16 @@ static int autofs_dir_symlink(struct user_namespace *mnt_userns,
 
 	dir->i_mtime = current_time(dir);
 
+	/* Symlinks don't trigger mounts */
+	managed_dentry_clear_managed(dentry);
+	/* Clear containing directory flags if it's no longer empty */
+	if (autofs_dentry_ino(parent)->count == 2) {
+		/* Don't set or clear type indirect root */
+		if (!IS_ROOT(parent) ||
+		    !autofs_type_indirect(sbi->type))
+			managed_dentry_clear_managed(parent);
+	}
+
 	return 0;
 }
 
@@ -624,12 +635,21 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
+	struct dentry *parent = dentry->d_parent;
 	struct autofs_info *p_ino;
 
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
 	dput(ino->dentry);
 
+	/* Set containing directory flags if it's now empty */
+	if (autofs_dentry_ino(parent)->count == 1) {
+		/* Don't set or clear type indirect root */
+		if (!IS_ROOT(parent) ||
+		    !autofs_type_indirect(sbi->type))
+			managed_dentry_set_managed(parent);
+	}
+
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
@@ -643,56 +663,11 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	return 0;
 }
 
-/*
- * Version 4 of autofs provides a pseudo direct mount implementation
- * that relies on directories at the leaves of a directory tree under
- * an indirect mount to trigger mounts. To allow for this we need to
- * set the DMANAGED_AUTOMOUNT and DMANAGED_TRANSIT flags on the leaves
- * of the directory tree. There is no need to clear the automount flag
- * following a mount or restore it after an expire because these mounts
- * are always covered. However, it is necessary to ensure that these
- * flags are clear on non-empty directories to avoid unnecessary calls
- * during path walks.
- */
-static void autofs_set_leaf_automount_flags(struct dentry *dentry)
-{
-	struct dentry *parent;
-
-	/* root and dentrys in the root are already handled */
-	if (IS_ROOT(dentry->d_parent))
-		return;
-
-	managed_dentry_set_managed(dentry);
-
-	parent = dentry->d_parent;
-	/* only consider parents below dentrys in the root */
-	if (IS_ROOT(parent->d_parent))
-		return;
-	managed_dentry_clear_managed(parent);
-}
-
-static void autofs_clear_leaf_automount_flags(struct dentry *dentry)
-{
-	struct dentry *parent;
-
-	/* flags for dentrys in the root are handled elsewhere */
-	if (IS_ROOT(dentry->d_parent))
-		return;
-
-	managed_dentry_clear_managed(dentry);
-
-	parent = dentry->d_parent;
-	/* only consider parents below dentrys in the root */
-	if (IS_ROOT(parent->d_parent))
-		return;
-	if (autofs_dentry_ino(parent)->count == 2)
-		managed_dentry_set_managed(parent);
-}
-
 static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
+	struct dentry *parent = dentry->d_parent;
 	struct autofs_info *p_ino;
 
 	pr_debug("dentry %p, removing %pd\n", dentry, dentry);
@@ -705,15 +680,20 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	d_drop(dentry);
 	spin_unlock(&sbi->lookup_lock);
 
-	if (sbi->version < 5)
-		autofs_clear_leaf_automount_flags(dentry);
-
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
 	dput(ino->dentry);
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
+	/* Set containing directory flags if it's now empty */
+	if (autofs_dentry_ino(parent)->count == 1) {
+		/* Don't set or clear type indirect root */
+		if (!IS_ROOT(parent) ||
+		    !autofs_type_indirect(sbi->type))
+			managed_dentry_set_managed(parent);
+	}
+
 	if (dir->i_nlink)
 		drop_nlink(dir);
 
@@ -726,6 +706,7 @@ static int autofs_dir_mkdir(struct user_namespace *mnt_userns,
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
+	struct dentry *parent = dentry->d_parent;
 	struct autofs_info *p_ino;
 	struct inode *inode;
 
@@ -742,15 +723,21 @@ static int autofs_dir_mkdir(struct user_namespace *mnt_userns,
 		return -ENOMEM;
 	d_add(dentry, inode);
 
-	if (sbi->version < 5)
-		autofs_set_leaf_automount_flags(dentry);
-
 	dget(dentry);
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
 	dir->i_mtime = current_time(dir);
 
+	managed_dentry_set_managed(dentry);
+	/* Clear containing directory flags if it's no longer empty */
+	if (autofs_dentry_ino(parent)->count == 2) {
+		/* Don't set or clear type indirect root */
+		if (!IS_ROOT(parent) ||
+		    !autofs_type_indirect(sbi->type))
+			managed_dentry_clear_managed(parent);
+	}
+
 	return 0;
 }
 


