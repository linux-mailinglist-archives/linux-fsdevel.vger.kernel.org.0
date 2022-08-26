Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E65A1EB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiHZCS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbiHZCSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:18:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB6CB5FD;
        Thu, 25 Aug 2022 19:18:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE6E720890;
        Fri, 26 Aug 2022 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ub7ZQmWhkMwCrPt6XLaYYoLXvYl81gYHBE+E0mqaQY8=;
        b=akHDCDoZIvpZtrkKD5N2+PdNkzbpNDBUFlhF0ssPNMkkY0g5N6tu9oXIiP/uhonLdETaNE
        8n1Up45lp7/dW1S/RUkIXdZd0PBKJ90k+5N6OScf/HTaTmeR+hAp9p0sAAsDjtsFvUVXV2
        Mq/hJJ4Hifx5GeVMPHnEuqoqTDpLzss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ub7ZQmWhkMwCrPt6XLaYYoLXvYl81gYHBE+E0mqaQY8=;
        b=hQowVta/FFtn3ne1nv7wifMpnj+WbEhlmoT1GTmPtYB+QEYNPoq+vF6k0/2hS2hmbwfsJV
        AXDBSUeZ61NgVEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59D3413A65;
        Fri, 26 Aug 2022 02:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fKxlBnstCGPLMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:18:35 +0000
Subject: [PATCH 09/10] VFS: add LOOKUP_SILLY_RENAME
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984377.25420.5747334898411663007.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When performing a "silly rename" to avoid removing a file that is still
open, we need to perform a lookup in a directory that is already locked.

In order to allow common functions to be used for this lookup, introduce
LOOKUP_SILLY_RENAME which affirms that the directory is already locked
and that the vfsmnt is already writable.

When LOOKUP_SILLY_RENAME is set, path->mnt can be NULL.  As
i_op->rename() doesn't make the vfsmnt available, this is unavoidable.
So we ensure that a NULL ->mnt isn't fatal.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c           |    3 +-
 fs/namei.c            |   88 +++++++++++++++++++++++++++++--------------------
 include/linux/namei.h |    9 +++--
 3 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d6bfa49b143b..9bf346a9de52 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3297,7 +3297,8 @@ EXPORT_SYMBOL(d_tmpfile);
  * If the parent directory is locked with I_MUTEX_NORMAL, use I_MUTEX_NORMAL.
  * If the parent is locked with I_MUTEX_PARENT, I_MUTEX_PARENT2 or
  * I_MUTEX_CHILD, use I_MUTEX_PARENT or, for the second in a rename,
- * I_MUTEX_PARENT2.
+ * I_MUTEX_PARENT2.  When a third name is needed, as with "silly-rename"
+ * I_MUTEX_CHILD is used.
  */
 bool d_lock_update_nested(struct dentry *dentry,
 			  struct dentry *base, const struct qstr *name,
diff --git a/fs/namei.c b/fs/namei.c
index ef994239fa7c..c9bbff120bf9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1650,12 +1650,14 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 }
 
 /*
- * Parent directory (base) is not locked.  We take either an exclusive
- * or shared lock depending on the fs preference, then do a lookup,
- * and then set the DCACHE_PAR_UPDATE bit on the child if a shared lock
- * was taken on the parent.
+ * Without LOOKUP_SILLY_RENAME parent directory (base) is not locked.
+ * We take either an exclusive or shared lock depending on the fs
+ * preference, then do a lookup, and then set the DCACHE_PAR_UPDATE bit
+ * on the child if a shared lock was taken on the parent.
  * If LOOKUP_EXCL, name should not already exist, else -EEXIST
  * If not LOOKUP_CREATE, name should already exist, else -ENOENT
+ * If LOOKUP_SILLY_RENAME, don't require write access.  In this case
+ * path->mnt may be NULL.
  */
 static struct dentry *lookup_hash_update(
 	const struct qstr *name,
@@ -1665,21 +1667,26 @@ static struct dentry *lookup_hash_update(
 	struct dentry *dentry;
 	struct dentry *base = path->dentry;
 	struct inode *dir = base->d_inode;
-	int err, err2;
-
-	/* For create, don't fail immediately if it's r/o,
-	 * at least try to report other errors.
-	 * For unlink/rmdir where LOOKUP_REVAl is the only
-	 * flag, fail immediately if r/o.
-	 */
-	err2 = mnt_want_write(path->mnt);
-	if (err2 && (flags & ~LOOKUP_REVAL) == 0)
-		return ERR_PTR(err2);
+	int err, err2 = 0;
+	int class;
+
+	if (!(flags & LOOKUP_SILLY_RENAME)) {
+		/* For create, don't fail immediately if it's r/o,
+		 * at least try to report other errors.
+		 * For unlink/rmdir where LOOKUP_REVAl is the only
+		 * flag, fail immediately if r/o.
+		 */
+		err2 = mnt_want_write(path->mnt);
+		if (err2 && (flags & ~LOOKUP_REVAL) == 0)
+			return ERR_PTR(err2);
 
-	if (wq && IS_PAR_UPDATE(dir))
-		inode_lock_shared_nested(dir, I_MUTEX_PARENT);
-	else
-		inode_lock_nested(dir, I_MUTEX_PARENT);
+		if (wq && IS_PAR_UPDATE(dir))
+			inode_lock_shared_nested(dir, I_MUTEX_PARENT);
+		else
+			inode_lock_nested(dir, I_MUTEX_PARENT);
+		class = I_MUTEX_PARENT;
+	} else
+		class = I_MUTEX_CHILD;
 
 retry:
 	dentry = __lookup_hash(name, base, flags, wq);
@@ -1687,7 +1694,7 @@ static struct dentry *lookup_hash_update(
 		err = PTR_ERR(dentry);
 		goto out_err;
 	}
-	if (!d_lock_update_nested(dentry, base, name, I_MUTEX_PARENT)) {
+	if (!d_lock_update_nested(dentry, base, name, class)) {
 		/*
 		 * Failed to get lock due to race with unlink or rename
 		 * - try again
@@ -1724,12 +1731,14 @@ static struct dentry *lookup_hash_update(
 	return dentry;
 
 out_err:
-	if (wq && IS_PAR_UPDATE(dir))
-		inode_unlock_shared(dir);
-	else
-		inode_unlock(dir);
-	if (!err2)
-		mnt_drop_write(path->mnt);
+	if (!(flags & LOOKUP_SILLY_RENAME)) {
+		if (wq && IS_PAR_UPDATE(dir))
+			inode_unlock_shared(dir);
+		else
+			inode_unlock(dir);
+		if (!err2)
+			mnt_drop_write(path->mnt);
+	}
 	return ERR_PTR(err);
 }
 
@@ -1751,18 +1760,22 @@ struct dentry *lookup_hash_update_len(const char *name, int nlen,
 EXPORT_SYMBOL(lookup_hash_update_len);
 
 void __done_path_update(struct path *path, struct dentry *dentry,
-			bool with_wq)
+			bool with_wq, unsigned int flags)
 {
 	struct inode *dir = path->dentry->d_inode;
 
 	d_lookup_done(dentry);
 	d_unlock_update(dentry);
-	if (IS_PAR_UPDATE(dir) && with_wq)
-		inode_unlock_shared(dir);
-	else
-		inode_unlock(dir);
-	dput(dentry);
-	mnt_drop_write(path->mnt);
+	if (flags & LOOKUP_SILLY_RENAME) {
+		dput(dentry);
+	} else {
+		if (IS_PAR_UPDATE(dir) && with_wq)
+			inode_unlock_shared(dir);
+		else
+			inode_unlock(dir);
+		dput(dentry);
+		mnt_drop_write(path->mnt);
+	}
 }
 EXPORT_SYMBOL(__done_path_update);
 
@@ -4122,7 +4135,8 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 					  wait_queue_head_t *wq)
 {
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
-	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
+	unsigned int flags = lookup_flags & (LOOKUP_REVAL |
+					     LOOKUP_SILLY_RENAME);
 	unsigned int create_flag = LOOKUP_CREATE;
 
 	/*
@@ -4136,7 +4150,7 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 		 */
 		create_flag = 0;
 	return lookup_hash_update(last, path,
-				  reval_flag | create_flag | LOOKUP_EXCL,
+				  flags | create_flag | LOOKUP_EXCL,
 				  wq);
 }
 
@@ -4146,10 +4160,12 @@ struct dentry *filename_create_one_len(const char *name, int nlen,
 				       wait_queue_head_t *wq)
 {
 	struct qstr this;
+	struct user_namespace *uns = &init_user_ns;
 	int err;
 
-	err = lookup_one_common(mnt_user_ns(path->mnt), name,
-				path->dentry, nlen, &this);
+	if (path->mnt)
+		uns = mnt_user_ns(path->mnt);
+	err = lookup_one_common(uns, name, path->dentry, nlen, &this);
 	if (err)
 		return ERR_PTR(err);
 	return filename_create_one(&this, path, lookup_flags, wq);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 29756921f69b..92a62b04a83d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -21,6 +21,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
 #define LOOKUP_DIRECTORY	0x0002	/* require a directory */
 #define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
+#define LOOKUP_SILLY_RENAME	0x0008	/* Directory already locked, don't lock again */
 #define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
 #define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
 #define LOOKUP_MOUNTPOINT	0x0080	/* follow mounts in the end */
@@ -64,20 +65,20 @@ extern struct dentry *user_path_create(int, const char __user *, struct path *,
 extern struct dentry *lookup_hash_update_len(const char *name, int nlen,
 					     struct path *path, unsigned int flags,
 					     wait_queue_head_t *wq);
-extern void __done_path_update(struct path *, struct dentry *, bool);
+extern void __done_path_update(struct path *, struct dentry *, bool, unsigned int);
 static inline void done_path_update(struct path *path, struct dentry *dentry)
 {
-	__done_path_update(path, dentry, true);
+	__done_path_update(path, dentry, true, 0);
 }
 static inline void done_path_create(struct path *path, struct dentry *dentry)
 {
-	__done_path_update(path, dentry, false);
+	__done_path_update(path, dentry, false, 0);
 	path_put(path);
 }
 static inline void done_path_create_wq(struct path *path, struct dentry *dentry,
 				       bool with_wq)
 {
-	__done_path_update(path, dentry, with_wq);
+	__done_path_update(path, dentry, with_wq, 0);
 	path_put(path);
 }
 


