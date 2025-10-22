Return-Path: <linux-fsdevel+bounces-65034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE1CBF9FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99572564A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FB2110E;
	Wed, 22 Oct 2025 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aVl3EDY+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uh/uK7LX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643E2DF6FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108444; cv=none; b=Hzrp6bUxB/ztEbzsA4oCq4srGrZK3t2gLrR/L/xEnBYkpFb2osPhff9UUi7eAN3DUvH6eJ0tUT1cWDlkX1kwlYkrC0gAkWeRXdW58cr9JKa8A7zJUa8BDZQVqaL/xdyn21DeFbvVZISFYTk1m1Q/ByI2Dm32XW9otScHnE9nvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108444; c=relaxed/simple;
	bh=7z1puoGc0Maw2mYrBj5q5gzBpwaxvsXaP30tLYcOr9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1QUm35SSxEbtajYMQgGRKywwvITpzi17sggYwBhyx9ioBLfdmvNXuQeTH1wKrw/AugpeqX1VCxvXatyDQinYxj7PDPjnbB5RdmwKL8EWaAK82ZSD3l4WBGjS/u5NmCI6oZOYtKoF3DzfwHPIDJG/Y6nfFlAYVXZrPBFIDpFvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aVl3EDY+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uh/uK7LX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECABD1400083;
	Wed, 22 Oct 2025 00:47:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 00:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108440;
	 x=1761194840; bh=XmECYJsbB/jZ2LHmTB/scwrXUR8F+2VoGp+BtgaR5S4=; b=
	aVl3EDY+nWPbQnMrYFz7Dg+/OoH9x1Wca4FjOSvTECKovrRtUaNF2zmYvadTYkft
	PSDo8nt6StsqQdf5gCRdT3M1HqD1/BJYX/6UUZaWmDYm1KmP1UlDh1xY44e2jgTf
	YAZE2gk29kGFByRrs3zOSIR1VUz6B4lknvTpSNf+zZgeDcdS9dgo2DwJY2XO1TAN
	draqHQayMKu7cd1rZCwVnHaqLvHBCsOvbfgzZ8GBe/JGar1fzI7CE44OQR+vf85b
	qE6Oul7d9OvIodRpGKuDVpRRzQyjkv6522XpXyRg1A0aYXTwjeVSRhRalUPOxJoL
	OWAH9x/MozZ7oajIFR1G1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108440; x=1761194840; bh=X
	mECYJsbB/jZ2LHmTB/scwrXUR8F+2VoGp+BtgaR5S4=; b=uh/uK7LXHCf4ADC3A
	N5ZOGNDjuSjv9z6GEso6GIZRf5lmCNJCNy+sir9d8vmDNbGEfeW8KBo+bjqavQ/k
	9JXkgPzRsV/FMb97K7Q3bfN+LFDYx6SqTZIH0/Dt+PCGVdJ59t+DMgr1TtSWgb9d
	J8xspOytyIeIif2swfMXtnv1pFNrScjJunReJVzAxojOP4gPrSqXuU8sy10er5lz
	OMugc3zpfOUSOIM3/shYn3m+3Saeh17V6r93VSrxM5FpkdVoV7KfiQLftGO2XSwe
	qS05wzg6CGepai/RNtDAfZDkZQcI233YkiUVes7wsqvVoiEhSLWh9zaqNAd6JLag
	m9OvA==
X-ME-Sender: <xms:2GH4aKDva_254svNhrahBf4y0XGEKZ9w_Y-Ll-8TF3JkNRaI8vK1-w>
    <xme:2GH4aPfl7hYegsd4-QD_8RvPlg0IE7ptBuyCgYkp5It3oN-sWPlOAEUAiRJ-UMD9D
    -6hudoL0dBboag0gYSFAweOZWTqW9Y1u3WdJ-dg5O0EBBbp1A>
X-ME-Received: <xmr:2GH4aMlKEKZzgh0X_obVvD3MroLMQ8pCIL1wbV0CVxdEXoA9L785fR4fkTJIbVMCqi6cqd8xoEg32aIOup9QMLRioyB562qs5-nrppIzR0V6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2GH4aOFxOpbCgJblKFyThNqF9t-SRkp5lxJgomAbk1S_S4_31YJUgQ>
    <xmx:2GH4aM5-4n1Q4yR0hWwBcbK2RBw5SUizpOBGep-lsa7oOFsz8fJMYA>
    <xmx:2GH4aOl_9C_tYHQrsRxHBhtjy9NvOsCBp0QOv4asVZnYuwh-Dtp9qg>
    <xmx:2GH4aJqghlbSJEKs7VamZeEHVpLrXdDIlrDz3NlJQ1BuynY5M9VOQg>
    <xmx:2GH4aGZeNe-1UI1g3H-AzEhmOj3AZ7aa4DFDQSDg2CV8ULY5171Uvyvr>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:47:18 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/14] VFS: introduce start_dirop() and end_dirop()
Date: Wed, 22 Oct 2025 15:41:36 +1100
Message-ID: <20251022044545.893630-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
References: <20251022044545.893630-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

The fact that directory operations (create,remove,rename) are protected
by a lock on the parent is known widely throughout the kernel.
In order to change this - to instead lock the target dentry  - it is
best to centralise this knowledge so it can be changed in one place.

This patch introduces start_dirop() which is local to VFS code.
It performs the required locking for create and remove.  Rename
will be handled separately.

Various functions with names like start_creating() or start_removing_path(),
some of which already exist, will export this functionality beyond the VFS.

end_dirop() is the partner of start_dirop().  It drops the lock and
releases the reference on the dentry.
It *is* exported so that various end_creating etc functions can be inline.

As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
that won't unlock when the dentry IS_ERR().  For now we need an explicit
unlock when dentry IS_ERR().  I hope to change vfs_mkdir() to unlock
when it drops a dentry so that explicit unlock can go away.

end_dirop() can always be called on the result of start_dirop(), but not
after vfs_mkdir().  After a vfs_mkdir() we still may need the explicit
unlock as seen in end_creating_path().

As well as adding start_dirop() and end_dirop()
this patch uses them in:
 - simple_start_creating (which requires sharing lookup_noperm_common()
        with libfs.c)
 - start_removing_path / start_removing_user_path_at
 - filename_create / end_creating_path()
 - do_rmdir(), do_unlinkat()

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/internal.h      |  3 ++
 fs/libfs.c         | 36 ++++++++---------
 fs/namei.c         | 98 ++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |  2 +
 4 files changed, 95 insertions(+), 44 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9b2b4d116880..d08d5e2235e9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -67,6 +67,9 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
 struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags);
+int lookup_noperm_common(struct qstr *qname, struct dentry *base);
 
 /*
  * namespace.c
diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..02371f45ef7d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2289,27 +2289,25 @@ void stashed_dentry_prune(struct dentry *dentry)
 	cmpxchg(stashed, dentry, NULL);
 }
 
-/* parent must be held exclusive */
+/**
+ * simple_start_creating - prepare to create a given name
+ * @parent: directory in which to prepare to create the name
+ * @name:   the name to be created
+ *
+ * Required lock is taken and a lookup in performed prior to creating an
+ * object in a directory.  No permission checking is performed.
+ *
+ * Returns: a negative dentry on which vfs_create() or similar may
+ *  be attempted, or an error.
+ */
 struct dentry *simple_start_creating(struct dentry *parent, const char *name)
 {
-	struct dentry *dentry;
-	struct inode *dir = d_inode(parent);
+	struct qstr qname = QSTR(name);
+	int err;
 
-	inode_lock(dir);
-	if (unlikely(IS_DEADDIR(dir))) {
-		inode_unlock(dir);
-		return ERR_PTR(-ENOENT);
-	}
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		inode_unlock(dir);
-		return dentry;
-	}
-	if (dentry->d_inode) {
-		dput(dentry);
-		inode_unlock(dir);
-		return ERR_PTR(-EEXIST);
-	}
-	return dentry;
+	err = lookup_noperm_common(&qname, parent);
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, &qname, LOOKUP_CREATE | LOOKUP_EXCL);
 }
 EXPORT_SYMBOL(simple_start_creating);
diff --git a/fs/namei.c b/fs/namei.c
index 7377020a2cba..3618efd4bcaa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2765,6 +2765,48 @@ static int filename_parentat(int dfd, struct filename *name,
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent:       the dentry of the parent in which the operation will occur
+ * @name:         a qstr holding the name within that parent
+ * @lookup_flags: intent and other lookup flags.
+ *
+ * The lookup is performed and necessary locks are taken so that, on success,
+ * the returned dentry can be operated on safely.
+ * The qstr must already have the hash value calculated.
+ *
+ * Returns: a locked dentry, or an error.
+ *
+ */
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	struct inode *dir = d_inode(parent);
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+	dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(dir);
+	return dentry;
+}
+
+/**
+ * end_dirop - signal completion of a dirop
+ * @de: the dentry which was returned by start_dirop or similar.
+ *
+ * If the de is an error, nothing happens. Otherwise any lock taken to
+ * protect the dentry is dropped and the dentry itself is release (dput()).
+ */
+void end_dirop(struct dentry *de)
+{
+	if (!IS_ERR(de)) {
+		inode_unlock(de->d_parent->d_inode);
+		dput(de);
+	}
+}
+EXPORT_SYMBOL(end_dirop);
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__start_removing_path(int dfd, struct filename *name,
 					   struct path *path)
@@ -2781,10 +2823,9 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
 		return ERR_PTR(-EINVAL);
 	/* don't fail immediately if it's r/o, at least try to report other errors */
 	error = mnt_want_write(parent_path.mnt);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	d = start_dirop(parent_path.dentry, &last, 0);
 	if (IS_ERR(d))
-		goto unlock;
+		goto drop;
 	if (error)
 		goto fail;
 	path->dentry = no_free_ptr(parent_path.dentry);
@@ -2792,10 +2833,9 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
 	return d;
 
 fail:
-	dput(d);
+	end_dirop(d);
 	d = ERR_PTR(error);
-unlock:
-	inode_unlock(parent_path.dentry->d_inode);
+drop:
 	if (!error)
 		mnt_drop_write(parent_path.mnt);
 	return d;
@@ -2910,7 +2950,7 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
+int lookup_noperm_common(struct qstr *qname, struct dentry *base)
 {
 	const char *name = qname->name;
 	u32 len = qname->len;
@@ -4223,21 +4263,18 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 */
 	if (last.name[last.len] && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto out_drop_write;
 
 	if (unlikely(error))
 		goto fail;
 
 	return dentry;
 fail:
-	dput(dentry);
+	end_dirop(dentry);
 	dentry = ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
+out_drop_write:
 	if (!error)
 		mnt_drop_write(path->mnt);
 out:
@@ -4256,11 +4293,26 @@ struct dentry *start_creating_path(int dfd, const char *pathname,
 }
 EXPORT_SYMBOL(start_creating_path);
 
+/**
+ * end_creating_path - finish a code section started by start_creating_path()
+ * @path: the path instantiated by start_creating_path()
+ * @dentry: the dentry returned by start_creating_path()
+ *
+ * end_creating_path() will unlock and locks taken by start_creating_path()
+ * and drop an references that were taken.  It should only be called
+ * if start_creating_path() returned a non-error.
+ * If vfs_mkdir() was called and it returned an error, that error *should*
+ * be passed to end_creating_path() together with the path.
+ */
 void end_creating_path(const struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
-		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	if (IS_ERR(dentry))
+		/* The parent is still locked despite the error from
+		 * vfs_mkdir() - must unlock it.
+		 */
+		inode_unlock(path->dentry->d_inode);
+	else
+		end_dirop(dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4592,8 +4644,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4602,9 +4653,8 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit4;
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
-	dput(dentry);
+	end_dirop(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4721,8 +4771,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 
@@ -4737,9 +4786,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		end_dirop(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..f4543612ef1e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3609,6 +3609,8 @@ extern void iterate_supers_type(struct file_system_type *,
 void filesystems_freeze(void);
 void filesystems_thaw(void);
 
+void end_dirop(struct dentry *de);
+
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
-- 
2.50.0.107.gf914562f5916.dirty


