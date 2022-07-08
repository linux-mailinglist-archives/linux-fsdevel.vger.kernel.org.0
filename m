Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE98D56AFFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 03:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiGHBnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 21:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiGHBnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:43:09 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEE73586;
        Thu,  7 Jul 2022 18:43:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 96D5E1007B3;
        Fri,  8 Jul 2022 11:43:07 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qPPTC2uInoch; Fri,  8 Jul 2022 11:43:07 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 8B492100530; Fri,  8 Jul 2022 11:43:07 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id ED561100530;
        Fri,  8 Jul 2022 11:43:06 +1000 (AEST)
Subject: [PATCH 2/5] autofs: make dentry info count consistent
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Jul 2022 09:43:06 +0800
Message-ID: <165724458671.30914.2902424437132835325.stgit@donald.themaw.net>
In-Reply-To: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
References: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an autofs dentry is a mount root directory there's no ->mkdir()
call to set its count to one.

To make the dentry info count consistent for all autofs dentries
set count to one when the dentry info struct is allocated.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |    1 +
 fs/autofs/root.c  |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 9edf243713eb..affa70360b1f 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -20,6 +20,7 @@ struct autofs_info *autofs_new_ino(struct autofs_sb_info *sbi)
 		INIT_LIST_HEAD(&ino->expiring);
 		ino->last_used = jiffies;
 		ino->sbi = sbi;
+		ino->count = 1;
 	}
 	return ino;
 }
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index fef6ed991022..442d27d9cb1b 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -582,7 +582,6 @@ static int autofs_dir_symlink(struct user_namespace *mnt_userns,
 	d_add(dentry, inode);
 
 	dget(dentry);
-	ino->count++;
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
@@ -612,7 +611,6 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
-	ino->count--;
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
 	dput(ino->dentry);
@@ -695,7 +693,6 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	if (sbi->version < 5)
 		autofs_clear_leaf_automount_flags(dentry);
 
-	ino->count--;
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
 	dput(ino->dentry);
@@ -734,7 +731,6 @@ static int autofs_dir_mkdir(struct user_namespace *mnt_userns,
 		autofs_set_leaf_automount_flags(dentry);
 
 	dget(dentry);
-	ino->count++;
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);


