Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CA56AFF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiGHBnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 21:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiGHBnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:43:15 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804FD73585;
        Thu,  7 Jul 2022 18:43:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 2715C10057D;
        Fri,  8 Jul 2022 11:43:13 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B2SFyUUwx-So; Fri,  8 Jul 2022 11:43:13 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 1BF77100530; Fri,  8 Jul 2022 11:43:13 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 9B72C10005B;
        Fri,  8 Jul 2022 11:43:12 +1000 (AEST)
Subject: [PATCH 3/5] autofs: use dentry info count instead of simple_empty()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Jul 2022 09:43:12 +0800
Message-ID: <165724459238.30914.1504611159945950108.stgit@donald.themaw.net>
In-Reply-To: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
References: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dentry info. field count is used to check if a dentry is in use
during expire. But, to be used for this the count field must account
for the presence of child dentries in a directory dentry.

Therefore it can also be used to check for an empty directory dentry
which can be done without having to to take an additional lock or
account for the presence of a readdir cursor dentry as is done by
simple_empty().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    5 +++++
 fs/autofs/expire.c   |    2 +-
 fs/autofs/root.c     |   18 ++++++++----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 918826eaceea..0117d6e06300 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -148,6 +148,11 @@ static inline int autofs_oz_mode(struct autofs_sb_info *sbi)
 		 task_pgrp(current) == sbi->oz_pgrp);
 }
 
+static inline bool autofs_empty(struct autofs_info *ino)
+{
+	return ino->count < 2;
+}
+
 struct inode *autofs_get_inode(struct super_block *, umode_t);
 void autofs_free_ino(struct autofs_info *);
 
diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index b3fefd6237c3..038b3d2d9f57 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -371,7 +371,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 		return NULL;
 	}
 
-	if (simple_empty(dentry))
+	if (autofs_empty(ino))
 		return NULL;
 
 	/* Case 2: tree mount, expire iff entire tree is not busy */
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 442d27d9cb1b..e0fa71eb5c05 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -79,6 +79,7 @@ static int autofs_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 
 	pr_debug("file=%p dentry=%p %pd\n", file, dentry, dentry);
 
@@ -95,7 +96,7 @@ static int autofs_dir_open(struct inode *inode, struct file *file)
 	 * it.
 	 */
 	spin_lock(&sbi->lookup_lock);
-	if (!path_is_mountpoint(&file->f_path) && simple_empty(dentry)) {
+	if (!path_is_mountpoint(&file->f_path) && autofs_empty(ino)) {
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOENT;
 	}
@@ -364,7 +365,7 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 		 * the mount never trigger mounts themselves (they have an
 		 * autofs trigger mount mounted on them). But v4 pseudo direct
 		 * mounts do need the leaves to trigger mounts. In this case
-		 * we have no choice but to use the list_empty() check and
+		 * we have no choice but to use the autofs_empty() check and
 		 * require user space behave.
 		 */
 		if (sbi->version > 4) {
@@ -373,7 +374,7 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 				goto done;
 			}
 		} else {
-			if (!simple_empty(dentry)) {
+			if (!autofs_empty(ino)) {
 				spin_unlock(&sbi->fs_lock);
 				goto done;
 			}
@@ -428,9 +429,8 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 
 	if (rcu_walk) {
 		/* We don't need fs_lock in rcu_walk mode,
-		 * just testing 'AUTOFS_INFO_NO_RCU' is enough.
-		 * simple_empty() takes a spinlock, so leave it
-		 * to last.
+		 * just testing 'AUTOFS_INF_WANT_EXPIRE' is enough.
+		 *
 		 * We only return -EISDIR when certain this isn't
 		 * a mount-trap.
 		 */
@@ -443,9 +443,7 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 		inode = d_inode_rcu(dentry);
 		if (inode && S_ISLNK(inode->i_mode))
 			return -EISDIR;
-		if (list_empty(&dentry->d_subdirs))
-			return 0;
-		if (!simple_empty(dentry))
+		if (!autofs_empty(ino))
 			return -EISDIR;
 		return 0;
 	}
@@ -465,7 +463,7 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 		 * we can avoid needless calls ->d_automount() and avoid
 		 * an incorrect ELOOP error return.
 		 */
-		if ((!path_is_mountpoint(path) && !simple_empty(dentry)) ||
+		if ((!path_is_mountpoint(path) && !autofs_empty(ino)) ||
 		    (d_really_is_positive(dentry) && d_is_symlink(dentry)))
 			status = -EISDIR;
 	}


