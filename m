Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473F356AFF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 03:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiGHBnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 21:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiGHBnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:43:05 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EAD73580;
        Thu,  7 Jul 2022 18:43:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 4BD441005DD;
        Fri,  8 Jul 2022 11:43:03 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kNudNxroYQWK; Fri,  8 Jul 2022 11:43:03 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 426241007D8; Fri,  8 Jul 2022 11:43:03 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 4922010052B;
        Fri,  8 Jul 2022 11:43:01 +1000 (AEST)
Subject: [PATCH 1/5] autofs: use inode permission method for write access
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Jul 2022 09:43:01 +0800
Message-ID: <165724458096.30914.13499431569758625806.stgit@donald.themaw.net>
In-Reply-To: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
References: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eliminate some code duplication from mkdir/rmdir/symlink/unlink
methods by using the inode operation .permission().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   63 +++++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 91fe4548c256..fef6ed991022 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -10,6 +10,7 @@
 
 #include "autofs_i.h"
 
+static int autofs_dir_permission(struct user_namespace *, struct inode *, int);
 static int autofs_dir_symlink(struct user_namespace *, struct inode *,
 			      struct dentry *, const char *);
 static int autofs_dir_unlink(struct inode *, struct dentry *);
@@ -50,6 +51,7 @@ const struct file_operations autofs_dir_operations = {
 
 const struct inode_operations autofs_dir_inode_operations = {
 	.lookup		= autofs_lookup,
+	.permission	= autofs_dir_permission,
 	.unlink		= autofs_dir_unlink,
 	.symlink	= autofs_dir_symlink,
 	.mkdir		= autofs_dir_mkdir,
@@ -526,11 +528,30 @@ static struct dentry *autofs_lookup(struct inode *dir,
 	return NULL;
 }
 
+static int autofs_dir_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask)
+{
+	if (mask & MAY_WRITE) {
+		struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
+
+		if (!autofs_oz_mode(sbi))
+			return -EACCES;
+
+		/* autofs_oz_mode() needs to allow path walks when the
+		 * autofs mount is catatonic but the state of an autofs
+		 * file system needs to be preserved over restarts.
+		 */
+		if (sbi->flags & AUTOFS_SBI_CATATONIC)
+			return -EACCES;
+	}
+
+	return generic_permission(mnt_userns, inode, mask);
+}
+
 static int autofs_dir_symlink(struct user_namespace *mnt_userns,
 			      struct inode *dir, struct dentry *dentry,
 			      const char *symname)
 {
-	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	struct inode *inode;
@@ -539,16 +560,6 @@ static int autofs_dir_symlink(struct user_namespace *mnt_userns,
 
 	pr_debug("%s <- %pd\n", symname, dentry);
 
-	if (!autofs_oz_mode(sbi))
-		return -EACCES;
-
-	/* autofs_oz_mode() needs to allow path walks when the
-	 * autofs mount is catatonic but the state of an autofs
-	 * file system needs to be preserved over restarts.
-	 */
-	if (sbi->flags & AUTOFS_SBI_CATATONIC)
-		return -EACCES;
-
 	BUG_ON(!ino);
 
 	autofs_clean_ino(ino);
@@ -601,16 +612,6 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
-	if (!autofs_oz_mode(sbi))
-		return -EACCES;
-
-	/* autofs_oz_mode() needs to allow path walks when the
-	 * autofs mount is catatonic but the state of an autofs
-	 * file system needs to be preserved over restarts.
-	 */
-	if (sbi->flags & AUTOFS_SBI_CATATONIC)
-		return -EACCES;
-
 	ino->count--;
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
@@ -683,16 +684,6 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 
 	pr_debug("dentry %p, removing %pd\n", dentry, dentry);
 
-	if (!autofs_oz_mode(sbi))
-		return -EACCES;
-
-	/* autofs_oz_mode() needs to allow path walks when the
-	 * autofs mount is catatonic but the state of an autofs
-	 * file system needs to be preserved over restarts.
-	 */
-	if (sbi->flags & AUTOFS_SBI_CATATONIC)
-		return -EACCES;
-
 	if (ino->count != 1)
 		return -ENOTEMPTY;
 
@@ -726,16 +717,6 @@ static int autofs_dir_mkdir(struct user_namespace *mnt_userns,
 	struct autofs_info *p_ino;
 	struct inode *inode;
 
-	if (!autofs_oz_mode(sbi))
-		return -EACCES;
-
-	/* autofs_oz_mode() needs to allow path walks when the
-	 * autofs mount is catatonic but the state of an autofs
-	 * file system needs to be preserved over restarts.
-	 */
-	if (sbi->flags & AUTOFS_SBI_CATATONIC)
-		return -EACCES;
-
 	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
 
 	BUG_ON(!ino);


