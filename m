Return-Path: <linux-fsdevel+bounces-41812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A593A37935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 01:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026271887F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0F101EE;
	Mon, 17 Feb 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OIqU7N3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cyMs895y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OIqU7N3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cyMs895y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FED7483
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739752258; cv=none; b=PdDdI8vJ2clw3UFl+Y/z4H/DbTuhvg6taODQipf4hqjlH6aBJU31TVZIq3Sv/CR2gU+qqdUjpmHAuyHPTxr6gEPgtIGk6i1vB3kL1c5mmnEpwxs92K3UWNG+rTk/9I2goZ2soNYPVfefpNNdIiTv4y1IgZ15oNhdR4tCtui8/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739752258; c=relaxed/simple;
	bh=zldPhPfWi24bHWNiNznSpIaITcjoLGS52Sun5Ysd2KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRB52VrAwoQYJNN957dj7lejOGG2PMKBL48p962pC766oX45UC1KrP4i+Tvbx47CDjoo5kud3BD+PLJpk87PgkyxdSLpPkzWWkmBg+9qxmLw/qIkpEQHrOhptvmeCIicoNcyavQsz9nrExfFeaY+htyr6fxZphapzzQtWTegvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OIqU7N3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cyMs895y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OIqU7N3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cyMs895y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AA6A1F38E;
	Mon, 17 Feb 2025 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739752251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzntZag4Jyd7I2J65VWUhUDAU6A8G27ubNJ4dWYpTrM=;
	b=OIqU7N3AnyWXjPqWRNAyxuWMwjD2aP8aEtxDwkPLWNowLTB3ZGz3p0bb7toZcsdJh2jwkM
	tY1cUhX9P3NgiU/X4XyUwUXlfWHAY4vx050+PTiUTxRJPjzloJCH6H7aHXYWN2fvea5szE
	+wEeKGbxis8ZUMZfoZ468fm4Wxdqqrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739752251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzntZag4Jyd7I2J65VWUhUDAU6A8G27ubNJ4dWYpTrM=;
	b=cyMs895yVljvJZ/Zj4TiLFIXwGK3kb+8wdSZLZqrBUE7VKW3p3NAJQiCjlp8xcTcj/T8KA
	RV/TecOS1DR8zQCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OIqU7N3A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cyMs895y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739752251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzntZag4Jyd7I2J65VWUhUDAU6A8G27ubNJ4dWYpTrM=;
	b=OIqU7N3AnyWXjPqWRNAyxuWMwjD2aP8aEtxDwkPLWNowLTB3ZGz3p0bb7toZcsdJh2jwkM
	tY1cUhX9P3NgiU/X4XyUwUXlfWHAY4vx050+PTiUTxRJPjzloJCH6H7aHXYWN2fvea5szE
	+wEeKGbxis8ZUMZfoZ468fm4Wxdqqrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739752251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzntZag4Jyd7I2J65VWUhUDAU6A8G27ubNJ4dWYpTrM=;
	b=cyMs895yVljvJZ/Zj4TiLFIXwGK3kb+8wdSZLZqrBUE7VKW3p3NAJQiCjlp8xcTcj/T8KA
	RV/TecOS1DR8zQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF63136AD;
	Mon, 17 Feb 2025 00:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TFK8IDmDsmfWJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 17 Feb 2025 00:30:49 +0000
From: NeilBrown <neilb@suse.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()
Date: Mon, 17 Feb 2025 11:27:21 +1100
Message-ID: <20250217003020.3170652-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217003020.3170652-1-neilb@suse.de>
References: <20250217003020.3170652-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9AA6A1F38E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Callers of lookup_one_qstr_excl() often check if the result is negative or
positive.
These changes can easily be moved into lookup_one_qstr_excl() by checking the
lookup flags:
LOOKUP_CREATE means it is NOT an error if the name doesn't exist.
LOOKUP_EXCL means it IS an error if the name DOES exist.

This patch adds these checks, then removes error checks from callers,
and ensures that appropriate flags are passed.

This subtly changes the meaning of LOOKUP_EXCL.  Previously it could
only accompany LOOKUP_CREATE.  Now it can accompany LOOKUP_RENAME_TARGET
as well.  A couple of small changes are needed to accommodate this.  The
NFS change is functionally a no-op but ensures nfs_is_exclusive_create() does
exactly what the name says.

Signed-off-by: NeilBrown <neilb@suse.de>
Link: https://lore.kernel.org/r/20250207034040.3402438-3-neilb@suse.de
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst | 12 ++++++
 fs/namei.c                            | 61 +++++++++------------------
 fs/nfs/dir.c                          |  3 +-
 fs/smb/server/vfs.c                   | 26 +++++-------
 4 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 2ead47e20677..3b6622fbd66b 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1165,3 +1165,15 @@ magic.
 kern_path_locked() and user_path_locked() no longer return a negative
 dentry so this doesn't need to be checked.  If the name cannot be found,
 ERR_PTR(-ENOENT) is returned.
+
+** recommend**
+
+lookup_one_qstr_excl() is changed to return errors in more cases, so
+these conditions don't require explicit checks.
+ - if LOOKUP_CREATE is NOT given, then the dentry won't be negative,
+   ERR_PTR(-ENOENT) is returned instead
+ - if LOOKUP_EXCL IS given, then the dentry won't be positive,
+   ERR_PTR(-EEXIST) is rreturned instread
+
+LOOKUP_EXCL now means "target must not exist".  It can be combined with 
+LOOK_CREATE or LOOKUP_RENAME_TARGET.
diff --git a/fs/namei.c b/fs/namei.c
index fb6da3ca0ca5..b7cdca902803 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1670,6 +1670,8 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * dentries - as the matter of fact, this only gets called
  * when directory is guaranteed to have no in-lookup children
  * at all.
+ * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
  */
 struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
@@ -1680,7 +1682,7 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	struct inode *dir = base->d_inode;
 
 	if (dentry)
-		return dentry;
+		goto found;
 
 	/* Don't create child dentry for a dead directory. */
 	if (unlikely(IS_DEADDIR(dir)))
@@ -1695,6 +1697,17 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 		dput(dentry);
 		dentry = old;
 	}
+found:
+	if (IS_ERR(dentry))
+		return dentry;
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
 EXPORT_SYMBOL(lookup_one_qstr_excl);
@@ -2741,10 +2754,6 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr_excl(&last, path->dentry, 0);
-	if (!IS_ERR(d) && d_is_negative(d)) {
-		dput(d);
-		d = ERR_PTR(-ENOENT);
-	}
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -4082,27 +4091,13 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * '/', and a directory wasn't requested.
 	 */
 	if (last.name[last.len] && !want_dir)
-		create_flags = 0;
+		create_flags &= ~LOOKUP_CREATE;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	dentry = lookup_one_qstr_excl(&last, path->dentry,
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
@@ -4449,10 +4444,6 @@ int do_rmdir(int dfd, struct filename *name)
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
@@ -4583,7 +4574,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (!IS_ERR(dentry)) {
 
 		/* Why not before? Because we want correct error value */
-		if (last.name[last.len] || d_is_negative(dentry))
+		if (last.name[last.len])
 			goto slashes;
 		inode = dentry->d_inode;
 		ihold(inode);
@@ -4617,9 +4608,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	return error;
 
 slashes:
-	if (d_is_negative(dentry))
-		error = -ENOENT;
-	else if (d_is_dir(dentry))
+	if (d_is_dir(dentry))
 		error = -EISDIR;
 	else
 		error = -ENOTDIR;
@@ -5119,7 +5108,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	struct qstr old_last, new_last;
 	int old_type, new_type;
 	struct inode *delegated_inode = NULL;
-	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
+	unsigned int lookup_flags = 0, target_flags =
+		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 	bool should_retry = false;
 	int error = -EINVAL;
 
@@ -5132,6 +5122,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
+	if (flags & RENAME_NOREPLACE)
+		target_flags |= LOOKUP_EXCL;
 
 retry:
 	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
@@ -5173,23 +5165,12 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
-	/* source must exist */
-	error = -ENOENT;
-	if (d_is_negative(old_dentry))
-		goto exit4;
 	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
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
index 2b04038b0e40..56cf16a72334 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1532,7 +1532,8 @@ static int nfs_is_exclusive_create(struct inode *dir, unsigned int flags)
 {
 	if (NFS_PROTO(dir)->version == 2)
 		return 0;
-	return flags & LOOKUP_EXCL;
+	return (flags & (LOOKUP_CREATE | LOOKUP_EXCL)) ==
+		(LOOKUP_CREATE | LOOKUP_EXCL);
 }
 
 /*
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 6890016e1923..fe29acef5872 100644
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
 
@@ -693,6 +688,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	struct ksmbd_file *parent_fp;
 	int new_type;
 	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
+	int target_lookup_flags = LOOKUP_RENAME_TARGET;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
@@ -703,6 +699,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
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
@@ -743,7 +747,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	}
 
 	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | LOOKUP_RENAME_TARGET);
+					  lookup_flags | target_lookup_flags);
 	if (IS_ERR(new_dentry)) {
 		err = PTR_ERR(new_dentry);
 		goto out3;
@@ -754,16 +758,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
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
-- 
2.47.1


