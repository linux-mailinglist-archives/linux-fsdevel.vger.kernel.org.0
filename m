Return-Path: <linux-fsdevel+bounces-41010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93518A2A051
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63C67A3DB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA729224AFD;
	Thu,  6 Feb 2025 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UF43y6Eb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a4pKuja8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UF43y6Eb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a4pKuja8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254392248AC;
	Thu,  6 Feb 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820812; cv=none; b=bgyp55/+jxGH2de0NgngzFM2/Sb+vK9fKVduvZyzDNWYDxH8eO+JMOyZ8Yo0wcI3RfrrC+WEifeyZZLQM6VyVugg+V8SJ2PXXsYNmSxtrFUPe8o8MESGkhreFvkoLUbJ4J3l3+fO2af/vtWU81Zs+01fXcLawnrehyd3xUQxb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820812; c=relaxed/simple;
	bh=iL/nhqws/lXvFKaqQy7FzZc+bidN+UBJRyrqXGrYlDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJT0OmJrSvTjhnlQnoFmOkPkSLthbwPkUJDIRNNyFyX+pmcfpyt7v/RDk3VDE6Ddx6VlLnbktcZ3ZdFcyiQ/nYXT59EmBc8UV+CQaQRnk7FjmQsJ3MSspg0wOjer7zF4qoeCPTQE4TLeNw+oBKhFVfRa3N0eGJjd5T0ehbqEgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UF43y6Eb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a4pKuja8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UF43y6Eb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a4pKuja8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 841401F381;
	Thu,  6 Feb 2025 05:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8L/HH4OAeWFVdkvYr7ks2OhMu7jHsU5kLHRPnlUFHo=;
	b=UF43y6EbY62n9ITb24RVzoJ4h4g7dwHffT9jcyquJDBzHcKUgeqrTSbUXcswbDWcA8iSkU
	Rss+IEy2dViPdQzYRlMiiOiZ+Rdb23PKUfZ8dXuHhaa1qF1DIAYjpFXYmc/KV0Uqpabpae
	mWEyAlmMKWzTU7yIhV7dnjK4/8HKuto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8L/HH4OAeWFVdkvYr7ks2OhMu7jHsU5kLHRPnlUFHo=;
	b=a4pKuja8eTeUZ/qLDVJHZyceidRG4S1uOx0yYoh14Jn2JtaagPn+ZS8x4R9qT7JCX3PaW9
	vxomYNQeR7MoNGDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8L/HH4OAeWFVdkvYr7ks2OhMu7jHsU5kLHRPnlUFHo=;
	b=UF43y6EbY62n9ITb24RVzoJ4h4g7dwHffT9jcyquJDBzHcKUgeqrTSbUXcswbDWcA8iSkU
	Rss+IEy2dViPdQzYRlMiiOiZ+Rdb23PKUfZ8dXuHhaa1qF1DIAYjpFXYmc/KV0Uqpabpae
	mWEyAlmMKWzTU7yIhV7dnjK4/8HKuto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8L/HH4OAeWFVdkvYr7ks2OhMu7jHsU5kLHRPnlUFHo=;
	b=a4pKuja8eTeUZ/qLDVJHZyceidRG4S1uOx0yYoh14Jn2JtaagPn+ZS8x4R9qT7JCX3PaW9
	vxomYNQeR7MoNGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C202413795;
	Thu,  6 Feb 2025 05:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NCEEHcVMpGehBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:46:45 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
Date: Thu,  6 Feb 2025 16:42:45 +1100
Message-ID: <20250206054504.2950516-9-neilb@suse.de>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

lookup_and_lock() combines locking the directory and performing a lookup
prior to a change to the directory.
Abstracting this prepares for changing the locking requirements.

done_lookup_and_lock() provides the inverse of putting the dentry and
unlocking.

For "silly_rename" we will need to lookup_and_lock() in a directory that
is already locked.  For this purpose we add LOOKUP_PARENT_LOCKED.

Like lookup_len_qstr(), lookup_and_lock() returns -ENOENT if
LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
-EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.

These functions replace all uses of lookup_one_qstr() in namei.c
except for those used for rename.

The name might seem backwards as the lock happens before the lookup.
A future patch will change this so that only a shared lock is taken
before the lookup, and an exclusive lock on the dentry is taken after a
successful lookup.  So the order "lookup" then "lock" will make sense.

This functionality is exported as lookup_and_lock_one() which takes a
name and len rather than a qstr.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            | 102 ++++++++++++++++++++++++++++--------------
 include/linux/namei.h |  15 ++++++-
 2 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 69610047f6c6..3c0feca081a2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1715,6 +1715,41 @@ struct dentry *lookup_one_qstr(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr);
 
+static struct dentry *lookup_and_lock_nested(const struct qstr *last,
+					     struct dentry *base,
+					     unsigned int lookup_flags,
+					     unsigned int subclass)
+{
+	struct dentry *dentry;
+
+	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
+		inode_lock_nested(base->d_inode, subclass);
+
+	dentry = lookup_one_qstr(last, base, lookup_flags);
+	if (IS_ERR(dentry) && !(lookup_flags & LOOKUP_PARENT_LOCKED)) {
+			inode_unlock(base->d_inode);
+	}
+	return dentry;
+}
+
+static struct dentry *lookup_and_lock(const struct qstr *last,
+				      struct dentry *base,
+				      unsigned int lookup_flags)
+{
+	return lookup_and_lock_nested(last, base, lookup_flags,
+				      I_MUTEX_PARENT);
+}
+
+void done_lookup_and_lock(struct dentry *base, struct dentry *dentry,
+			  unsigned int lookup_flags)
+{
+	d_lookup_done(dentry);
+	dput(dentry);
+	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
+		inode_unlock(base->d_inode);
+}
+EXPORT_SYMBOL(done_lookup_and_lock);
+
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
  * @nd: current nameidata
@@ -2754,12 +2789,9 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		path_put(path);
 		return ERR_PTR(-EINVAL);
 	}
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr(&last, path->dentry, 0);
-	if (IS_ERR(d)) {
-		inode_unlock(path->dentry->d_inode);
+	d = lookup_and_lock(&last, path->dentry, 0);
+	if (IS_ERR(d))
 		path_put(path);
-	}
 	return d;
 }
 
@@ -3053,6 +3085,22 @@ struct dentry *lookup_positive_unlocked(const char *name,
 }
 EXPORT_SYMBOL(lookup_positive_unlocked);
 
+struct dentry *lookup_and_lock_one(struct mnt_idmap *idmap,
+				   const char *name, int len, struct dentry *base,
+				   unsigned int lookup_flags)
+{
+	struct qstr this;
+	int err;
+
+	if (!idmap)
+		idmap = &nop_mnt_idmap;
+	err = lookup_one_common(idmap, name, base, len, &this);
+	if (err)
+		return ERR_PTR(err);
+	return lookup_and_lock(&this, base, lookup_flags);
+}
+EXPORT_SYMBOL(lookup_and_lock_one);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
@@ -4071,7 +4119,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4083,36 +4130,30 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * (foo/., foo/.., /////)
 	 */
 	if (unlikely(type != LAST_NORM))
-		goto out;
+		goto put;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
-	err2 = mnt_want_write(path->mnt);
+	error = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
 	if (last.name[last.len] && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr(&last, path->dentry,
-				 reval_flag | create_flags);
+	dentry = lookup_and_lock(&last, path->dentry, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto drop;
 
-	if (unlikely(err2)) {
-		error = err2;
+	if (unlikely(error))
 		goto fail;
-	}
 	return dentry;
 fail:
-	d_lookup_done(dentry);
-	dput(dentry);
+	done_lookup_and_lock(path->dentry, dentry, reval_flag | create_flags);
 	dentry = ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
-	if (!err2)
+drop:
+	if (!error)
 		mnt_drop_write(path->mnt);
-out:
+put:
 	path_put(path);
 	return dentry;
 }
@@ -4130,14 +4171,13 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	done_lookup_and_lock(path->dentry, dentry, LOOKUP_CREATE);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
 EXPORT_SYMBOL(done_path_create);
 
-inline struct dentry *user_path_create(int dfd, const char __user *pathname,
+struct dentry *user_path_create(int dfd, const char __user *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname(pathname);
@@ -4510,19 +4550,18 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr(&last, path.dentry, lookup_flags);
+	dentry = lookup_and_lock(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
+
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
-	dput(dentry);
+	done_lookup_and_lock(path.dentry, dentry, lookup_flags);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4639,11 +4678,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr(&last, path.dentry, lookup_flags);
+	dentry = lookup_and_lock(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
 			goto slashes;
@@ -4655,9 +4692,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		done_lookup_and_lock(path.dentry, dentry, lookup_flags);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 0d81e571a159..76c587a5ec3a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -29,7 +29,11 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_RCU		BIT(8)	/* RCU pathwalk mode; semi-internal */
 #define LOOKUP_CACHED		BIT(9) /* Only do cached lookup */
 #define LOOKUP_PARENT		BIT(10)	/* Looking up final parent in path */
-/* 5 spare bits for pathwalk */
+#define LOOKUP_PARENT_LOCKED	BIT(11)	/* filesystem sets this for nested
+					 * "lookup_and_lock_one" when it knows
+					 * parent is sufficiently locked.
+					 */
+/* 4 spare bits for pathwalk */
 
 /* These tell filesystem methods that we are dealing with the final component... */
 #define LOOKUP_OPEN		BIT(16)	/* ... in open */
@@ -82,6 +86,15 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    const char *name,
 					    struct dentry *base, int len);
+struct dentry *lookup_and_lock_one(struct mnt_idmap *idmap,
+				   const char *name, int len, struct dentry *base,
+				   unsigned int lookup_flags);
+struct dentry *__lookup_and_lock_one(struct mnt_idmap *idmap,
+				     const char *name, int len, struct dentry *base,
+				     unsigned int lookup_flags);
+void done_lookup_and_lock(struct dentry *base, struct dentry *dentry,
+			  unsigned int lookup_flags);
+void __done_lookup_and_lock(struct dentry *dentry);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
-- 
2.47.1


