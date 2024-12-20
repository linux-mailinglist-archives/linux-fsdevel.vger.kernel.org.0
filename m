Return-Path: <linux-fsdevel+bounces-37906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA89F8A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4241662F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4E19995B;
	Fri, 20 Dec 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZPgGX3f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K3E6P5Fk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZPgGX3f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K3E6P5Fk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC6198A38;
	Fri, 20 Dec 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664165; cv=none; b=b9GIjk0+pF1+XquMHTBTsGBZN+ug5XgLpAzjzi7oMataYLS1ZLt2EwU2uSZQlDiFhFo3l4PitOrzJZqQ7OVVbTlN1EWhOzER8oYwZesBpU6AYL7iIoR5TlHDImU56k1shq3Hlu45GR4BtEAvw9wPk20jpLmUH9nQY21uPN78s8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664165; c=relaxed/simple;
	bh=P88JwG11tRsTydZ18sfuVVbZNGEKEJgROeBGZiDCPYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDO4tvDd84m1JZHvxebj2ba/YRpsRx48QKbtls51DeswhJ74OVSbCtHJiTsv46tVP9Ij5qMRD79f8/5GKKSEsUvjstXcW60xATs561t3shjELf+4tbGKol690QCTpPJ3tzrTT8Y6zVkfyF3z0N1jEJLiNKfwdh7SUz/4vEiFZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HZPgGX3f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K3E6P5Fk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HZPgGX3f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K3E6P5Fk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2B31210F2;
	Fri, 20 Dec 2024 03:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+9yKahrxXskV0v17ELTnYvjtxAsxpKKJ0xbMRqepw=;
	b=HZPgGX3fz2eGAvucxoFsAwYKpU8GF9pZXDNbfRzBZftX+vMEYYBRCb0iRs4K3UTa5nqODz
	2tYGe9s/PauyFn6wvfrm6UasdIZ1RVKwu7TrFquyfuqXnD4xKZwJy5s+XWpe7NP3AdSzON
	SFvOP063omaNYDRYtFT8yauQTNnArsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+9yKahrxXskV0v17ELTnYvjtxAsxpKKJ0xbMRqepw=;
	b=K3E6P5Fka2HwCNU6Kn5kERAfl8F6jeLMB3FAM2wO6H5q7Xwq7pWlyNAPswmLjWKGVs8k55
	HXtybquIRdEFZDDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HZPgGX3f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K3E6P5Fk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+9yKahrxXskV0v17ELTnYvjtxAsxpKKJ0xbMRqepw=;
	b=HZPgGX3fz2eGAvucxoFsAwYKpU8GF9pZXDNbfRzBZftX+vMEYYBRCb0iRs4K3UTa5nqODz
	2tYGe9s/PauyFn6wvfrm6UasdIZ1RVKwu7TrFquyfuqXnD4xKZwJy5s+XWpe7NP3AdSzON
	SFvOP063omaNYDRYtFT8yauQTNnArsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+9yKahrxXskV0v17ELTnYvjtxAsxpKKJ0xbMRqepw=;
	b=K3E6P5Fka2HwCNU6Kn5kERAfl8F6jeLMB3FAM2wO6H5q7Xwq7pWlyNAPswmLjWKGVs8k55
	HXtybquIRdEFZDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF6213A32;
	Fri, 20 Dec 2024 03:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6eadIN/fZGdmGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:19 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] VFS: introduce lookup_and_lock()
Date: Fri, 20 Dec 2024 13:54:25 +1100
Message-ID: <20241220030830.272429-8-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2B31210F2
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

lookup_and_lock() combines locking the directory and performing a lookup
prior to a change to the directory.
Abstracting this prepares for changing the locking requirements.

done_lookup_and_lock() will be called by all callers of
lookup_and_lock() to unlock and dput()

lookup_and_lock() returns -ENOENT if LOOKUP_CREATE was NOT given and the
name cannot be found,, and returns -EEXIST if LOOKUP_EXCL WAS given and
the name CAN be found.  This is what callers want.

These functions replace all uses of lookup_one_qstr_excl() in namei.c
except for those used for rename.

The name might seem backwards as the lock happens before the lookup.
A future patch will change this so that only a shared lock is taken
before the lookup, and an exclusive lock on the dentry is taken after a
successful lookup.  So the order "lookup" then "lock" will make sense.

This functionality is exported as lookup_and_lock_one() which takes a
name and len rather than a qstr.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            | 118 ++++++++++++++++++++++--------------------
 include/linux/namei.h |   3 ++
 2 files changed, 65 insertions(+), 56 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 29f86df4b9dc..371c80902c59 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1703,6 +1703,33 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+static struct dentry *lookup_and_lock(const struct qstr *last,
+				      struct dentry *base,
+				      unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	int err;
+
+	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	if (IS_ERR(dentry))
+		goto out;
+	err = -EEXIST;
+	if ((lookup_flags & LOOKUP_EXCL) && d_is_positive(dentry))
+		goto err;
+	err = -ENOENT;
+	if (!(lookup_flags & LOOKUP_CREATE) && d_is_negative(dentry))
+		goto err;
+	return dentry;
+
+err:
+	dput(dentry);
+	dentry = ERR_PTR(err);
+out:
+	inode_unlock(base->d_inode);
+	return dentry;
+}
+
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
  * @nd: current nameidata
@@ -2741,16 +2768,9 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		path_put(path);
 		return ERR_PTR(-EINVAL);
 	}
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, path->dentry, 0);
-	if (!IS_ERR(d) && d_is_negative(d)) {
-		dput(d);
-		d = ERR_PTR(-ENOENT);
-	}
-	if (IS_ERR(d)) {
-		inode_unlock(path->dentry->d_inode);
+	d = lookup_and_lock(&last, path->dentry, 0);
+	if (IS_ERR(d))
 		path_put(path);
-	}
 	return d;
 }
 
@@ -3051,6 +3071,22 @@ struct dentry *lookup_positive_unlocked(const char *name,
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
@@ -4080,7 +4116,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4092,50 +4127,31 @@ static struct dentry *filename_create(int dfd, struct filename *name,
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
-		create_flags = 0;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+		create_flags &= ~LOOKUP_CREATE;
+	dentry = lookup_and_lock(&last, path->dentry, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto drop;
 
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
-	if (unlikely(err2)) {
-		error = err2;
+	if (unlikely(error))
 		goto fail;
-	}
 	return dentry;
 fail:
 	d_lookup_done(dentry);
-	dput(dentry);
+	done_lookup_and_lock(path->dentry, dentry);
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
@@ -4555,23 +4571,18 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = lookup_and_lock(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
-	if (!dentry->d_inode) {
-		error = -ENOENT;
-		goto exit4;
-	}
+
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
-	dput(dentry);
+	done_lookup_and_lock(path.dentry, dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4691,13 +4702,11 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = lookup_and_lock(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-
 		/* Why not before? Because we want correct error value */
-		if (last.name[last.len] || d_is_negative(dentry))
+		if (last.name[last.len])
 			goto slashes;
 		inode = dentry->d_inode;
 		ihold(inode);
@@ -4707,9 +4716,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		done_lookup_and_lock(path.dentry, dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
@@ -4731,9 +4739,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	return error;
 
 slashes:
-	if (d_is_negative(dentry))
-		error = -ENOENT;
-	else if (d_is_dir(dentry))
+	if (d_is_dir(dentry))
 		error = -EISDIR;
 	else
 		error = -ENOTDIR;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 898fc8ba37e1..f882874a7b00 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,9 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    const char *name,
 					    struct dentry *base, int len);
+struct dentry *lookup_and_lock_one(struct mnt_idmap *idmap,
+				   const char *name, int len, struct dentry *base,
+				   unsigned int lookup_flags);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
-- 
2.47.0


