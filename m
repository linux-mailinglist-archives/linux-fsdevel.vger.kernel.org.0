Return-Path: <linux-fsdevel+bounces-41007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BDEA2A049
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF97188810C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F31F60A;
	Thu,  6 Feb 2025 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+wtYod6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cAJbZx+Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+wtYod6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cAJbZx+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BA1B59A;
	Thu,  6 Feb 2025 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820777; cv=none; b=FLEZmTdaDKvze3JX3B2WEyYngveaN5LzD86Is5Jgli/Fr/k5jrptvQKpG37iYZtxFxk1rQ8EPiRu+I+ZwNZbo7V2DZy3LyKC128x7guOrFCr7w66KuAPoRYzS/U/ZJcdOiMfIzkmHNPnILmuFr0gORMfpOQA4FJXNtMoLzgHbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820777; c=relaxed/simple;
	bh=JkJvFV88L+Oz9pqbDobXWftglWw2WTtyc8jXH80FwFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj/xmecyCvPz2Y2ZmDjsAc3ByfdqfsB8oTR5imPol2tNkP+NYAkxTG/ov1o69PHvg8uwCtn7ZUXZl9GoVMpXgNUX+0X8c4kkhrwyRkYguU1LUCOBvHBCJV8MWCiLW3N88CJ2c4d5mbi7aDS++JKaX6dv50geAzm8g5PISedzHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+wtYod6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cAJbZx+Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+wtYod6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cAJbZx+Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C119821108;
	Thu,  6 Feb 2025 05:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l36d111ZVdx2z5cPfSMmMWyzXjCSVO4e/vMuSUOklnE=;
	b=e+wtYod6c57vEBKeMZCiuh0hzJDZWynzpVjEwefJgzEun3lXN1+QaOWw7FKbVnLa3W3qE7
	G2dSB6ioWv9bSar8jzG9yfi+oFrdAnLoUx1Xr0/905CTFI5lu6XBjdXq+CgwGwMmBk+/KF
	xWJcvG7Mx4IUTysO2wVqtZVQdOOmqKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l36d111ZVdx2z5cPfSMmMWyzXjCSVO4e/vMuSUOklnE=;
	b=cAJbZx+QAPyF7cbyr5DlbKc+hDFl4PU9P00icHSm5L2eBH4VbP1g4oaMyDTI/jTAWMpr69
	ScC1gVyFVbkWliDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l36d111ZVdx2z5cPfSMmMWyzXjCSVO4e/vMuSUOklnE=;
	b=e+wtYod6c57vEBKeMZCiuh0hzJDZWynzpVjEwefJgzEun3lXN1+QaOWw7FKbVnLa3W3qE7
	G2dSB6ioWv9bSar8jzG9yfi+oFrdAnLoUx1Xr0/905CTFI5lu6XBjdXq+CgwGwMmBk+/KF
	xWJcvG7Mx4IUTysO2wVqtZVQdOOmqKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l36d111ZVdx2z5cPfSMmMWyzXjCSVO4e/vMuSUOklnE=;
	b=cAJbZx+QAPyF7cbyr5DlbKc+hDFl4PU9P00icHSm5L2eBH4VbP1g4oaMyDTI/jTAWMpr69
	ScC1gVyFVbkWliDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5C3213795;
	Thu,  6 Feb 2025 05:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oD5sGqJMpGd5BwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:46:10 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] VFS: add common error checks to lookup_one_qstr()
Date: Thu,  6 Feb 2025 16:42:42 +1100
Message-ID: <20250206054504.2950516-6-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Callers of lookup_one_qstr() often check if the result is negative or
positive.
These changes can easily be moved into lookup_one_qstr() by checking the
lookup flags:
LOOKUP_CREATE means it is NOT an error if the name doesn't exist.
LOOKUP_EXCL means it IS an error if the name DOES exist.

This patch adds these checks, then removes error checks from callers,
and ensures that appropriate flags are passed.

This subtly changes the meaning of LOOKUP_EXCL.  Previously it could
only accompany LOOKUP_CREATE.  Now it can accompany LOOKUP_RENAME_TARGET
as well.  A couple of small changes are needed to accommodate this.  The
NFS is functionally a no-op but ensures nfs_is_exclusive_create() does
exactly what the name says.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            | 61 ++++++++++++++-----------------------------
 fs/nfs/dir.c          |  3 ++-
 fs/smb/server/vfs.c   | 26 +++++++-----------
 include/linux/namei.h |  2 +-
 4 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1901120bcbb8..69610047f6c6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1668,6 +1668,8 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * Parent directory has inode locked: exclusive or shared.
  * If @flags contains any LOOKUP_INTENT_FLAGS then d_lookup_done()
  * must be called after the intended operation is performed - or aborted.
+ * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
  */
 struct dentry *lookup_one_qstr(const struct qstr *name,
 			       struct dentry *base,
@@ -1678,7 +1680,7 @@ struct dentry *lookup_one_qstr(const struct qstr *name,
 	struct inode *dir = base->d_inode;
 
 	if (dentry)
-		return dentry;
+		goto found;
 
 	/* Don't create child dentry for a dead directory. */
 	if (unlikely(IS_DEADDIR(dir)))
@@ -1689,7 +1691,7 @@ struct dentry *lookup_one_qstr(const struct qstr *name,
 		return ERR_PTR(-ENOMEM);
 	if (!d_in_lookup(dentry))
 		/* Raced with another thread which did the lookup */
-		return dentry;
+		goto found;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
@@ -1700,6 +1702,15 @@ struct dentry *lookup_one_qstr(const struct qstr *name,
 	if ((flags & LOOKUP_INTENT_FLAGS) == 0)
 		/* ->lookup must have given final answer */
 		d_lookup_done(dentry);
+found:
+	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
+		dput(dentry);
+		return ERR_PTR(-ENOENT);
+	}
+	if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
+		dput(dentry);
+		return ERR_PTR(-EEXIST);
+	}
 	return dentry;
 }
 EXPORT_SYMBOL(lookup_one_qstr);
@@ -2745,10 +2756,6 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr(&last, path->dentry, 0);
-	if (!IS_ERR(d) && d_is_negative(d)) {
-		dput(d);
-		d = ERR_PTR(-ENOENT);
-	}
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -4085,27 +4092,13 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * '/', and a directory wasn't requested.
 	 */
 	if (last.name[last.len] && !want_dir)
-		create_flags = 0;
+		create_flags &= ~LOOKUP_CREATE;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	dentry = lookup_one_qstr(&last, path->dentry,
 				 reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
 
-	error = -EEXIST;
-	if (d_is_positive(dentry))
-		goto fail;
-
-	/*
-	 * Special case - lookup gave negative, but... we had foo/bar/
-	 * From the vfs_mknod() POV we just have a negative dentry -
-	 * all is fine. Let's be bastards - you had / on the end, you've
-	 * been asking for (non-existent) directory. -ENOENT for you.
-	 */
-	if (unlikely(!create_flags)) {
-		error = -ENOENT;
-		goto fail;
-	}
 	if (unlikely(err2)) {
 		error = err2;
 		goto fail;
@@ -4522,10 +4515,6 @@ int do_rmdir(int dfd, struct filename *name)
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
-	if (!dentry->d_inode) {
-		error = -ENOENT;
-		goto exit4;
-	}
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
@@ -4656,7 +4645,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (!IS_ERR(dentry)) {
 
 		/* Why not before? Because we want correct error value */
-		if (last.name[last.len] || d_is_negative(dentry))
+		if (last.name[last.len])
 			goto slashes;
 		inode = dentry->d_inode;
 		ihold(inode);
@@ -4690,9 +4679,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	return error;
 
 slashes:
-	if (d_is_negative(dentry))
-		error = -ENOENT;
-	else if (d_is_dir(dentry))
+	if (d_is_dir(dentry))
 		error = -EISDIR;
 	else
 		error = -ENOTDIR;
@@ -5192,7 +5179,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	struct qstr old_last, new_last;
 	int old_type, new_type;
 	struct inode *delegated_inode = NULL;
-	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
+	unsigned int lookup_flags = 0, target_flags =
+		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 	bool should_retry = false;
 	int error = -EINVAL;
 
@@ -5205,6 +5193,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
+	if (flags & RENAME_NOREPLACE)
+		target_flags |= LOOKUP_EXCL;
 
 retry:
 	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
@@ -5246,23 +5236,12 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
-	/* source must exist */
-	error = -ENOENT;
-	if (d_is_negative(old_dentry))
-		goto exit4;
 	new_dentry = lookup_one_qstr(&new_last, new_path.dentry,
 				     lookup_flags | target_flags);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
-	error = -EEXIST;
-	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry))
-		goto exit5;
 	if (flags & RENAME_EXCHANGE) {
-		error = -ENOENT;
-		if (d_is_negative(new_dentry))
-			goto exit5;
-
 		if (!d_is_dir(new_dentry)) {
 			error = -ENOTDIR;
 			if (new_last.name[new_last.len])
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 27c7a5c4e91b..8cbe63f4089a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1531,7 +1531,8 @@ static int nfs_is_exclusive_create(struct inode *dir, unsigned int flags)
 {
 	if (NFS_PROTO(dir)->version == 2)
 		return 0;
-	return flags & LOOKUP_EXCL;
+	return (flags & (LOOKUP_CREATE | LOOKUP_EXCL)) ==
+		(LOOKUP_CREATE | LOOKUP_EXCL);
 }
 
 /*
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 89b3823f6405..bf8ac43c39b0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -113,11 +113,6 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	if (IS_ERR(d))
 		goto err_out;
 
-	if (d_is_negative(d)) {
-		dput(d);
-		goto err_out;
-	}
-
 	path->dentry = d;
 	path->mnt = mntget(parent_path->mnt);
 
@@ -677,6 +672,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	struct ksmbd_file *parent_fp;
 	int new_type;
 	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
+	int target_lookup_flags = LOOKUP_RENAME_TARGET;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
@@ -687,6 +683,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto revert_fsids;
 	}
 
+	/*
+	 * explicitly handle file overwrite case, for compatibility with
+	 * filesystems that may not support rename flags (e.g: fuse)
+	 */
+	if (flags & RENAME_NOREPLACE)
+		target_lookup_flags |= LOOKUP_EXCL;
+	flags &= ~(RENAME_NOREPLACE);
+
 retry:
 	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
 				     &new_path, &new_last, &new_type,
@@ -727,7 +731,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	}
 
 	new_dentry = lookup_one_qstr(&new_last, new_path.dentry,
-				     lookup_flags | LOOKUP_RENAME_TARGET);
+				     lookup_flags | target_lookup_flags);
 	if (IS_ERR(new_dentry)) {
 		err = PTR_ERR(new_dentry);
 		goto out3;
@@ -738,16 +742,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out4;
 	}
 
-	/*
-	 * explicitly handle file overwrite case, for compatibility with
-	 * filesystems that may not support rename flags (e.g: fuse)
-	 */
-	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
-		err = -EEXIST;
-		goto out4;
-	}
-	flags &= ~(RENAME_NOREPLACE);
-
 	if (old_child == trap) {
 		err = -EINVAL;
 		goto out4;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 06bb3ea65beb..839a64d07f8c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -31,7 +31,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 /* These tell filesystem methods that we are dealing with the final component... */
 #define LOOKUP_OPEN		0x0100	/* ... in open */
 #define LOOKUP_CREATE		0x0200	/* ... in object creation */
-#define LOOKUP_EXCL		0x0400	/* ... in exclusive creation */
+#define LOOKUP_EXCL		0x0400	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
 
 #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
-- 
2.47.1


