Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B854F092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiFQFfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFQFfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:35:32 -0400
Received: from smtp03.aussiebb.com.au (2403-5800-3-25--1003.ip6.aussiebb.net [IPv6:2403:5800:3:25::1003])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF1B2CE09;
        Thu, 16 Jun 2022 22:35:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 817721A007E;
        Fri, 17 Jun 2022 15:35:30 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DQIddVwqXtHQ; Fri, 17 Jun 2022 15:35:30 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id 76A1B1A009C; Fri, 17 Jun 2022 15:35:30 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id CAAAC1A007E;
        Fri, 17 Jun 2022 15:35:29 +1000 (AEST)
Subject: [PATCH 1/6] autofs: use inode permission method for write access
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:35:29 +0800
Message-ID: <165544412955.250070.4233102297106814123.stgit@donald.themaw.net>
In-Reply-To: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
References: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
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


