Return-Path: <linux-fsdevel+bounces-62840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0C1BA23EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8109A7B1BBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCAB239594;
	Fri, 26 Sep 2025 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Svo4UXpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KU8TOlC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9E17996
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855042; cv=none; b=d4yZLa8xEH6vn37sq0ByhfVEB/zIBzNoVwT5nBWzmtfqo0xQ/kIw5OuczjyyDR2LKEuKDq5ANQvO5nVliOsI2BInJQMjgxubCNLneOeZq+d9vNMDeZjssQZ3HyVDMH3hCIM4AdgRuH9NQs2tDgyDzvVOCf8Ah4rlPYzxa6bUt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855042; c=relaxed/simple;
	bh=1khKY8TSf8LxsJeD1lIbtb88PVGM4igAkdaXOinYpvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Ix0eZYUQU5gUaZHbR8SDpmDL8TSMY5R4FuVq0QKBeJBhH9tMQnUTFzoG1V5sfyFvxHff5EiSmd91/Sy4c/nEhucqiSaZnAj1tyaHDhEA+3teHxQ6WiEP+jCmOUq8lvVVJaVh2ja6udSnziq99BTKYQ09kuE1S/ogh9belqSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Svo4UXpA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KU8TOlC0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2D4C140015A;
	Thu, 25 Sep 2025 22:50:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 22:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855039;
	 x=1758941439; bh=hofSTCU+AF6dU9NtgEsK7Josq2yH/gEmFsICWTKaOrU=; b=
	Svo4UXpAPnhRa6wEalBWi289IbQvibGTnlKaTKK5RB519FbATWM7EQIO1knOCAhq
	HrRjXCf6qUQi/cooOds3v+quHG7NWtesx7V1amiQR1ev8QJ6HazKBLwd9H4xBSNt
	ZAExUK0Si+4Z4R5rSTrprzsK28oMG4nLNU+oybR4vGm3pOva+HLe1epo3ZH4v5Sp
	zkS7FqFTuEChtlHPeSJ3iSKVZSuZhyk7lKW2HbW0ee5ds1kRchG92h/0I1eoecO1
	Ojspfwq6rFsFEIfX4SaLfMy8u9FGDty1ODthCIs/WM2g3KoOJ69D0WdGLg7tRgWi
	q3A+ClaRQEc6ViBzVv8QtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855039; x=1758941439; bh=h
	ofSTCU+AF6dU9NtgEsK7Josq2yH/gEmFsICWTKaOrU=; b=KU8TOlC0CS+75hgaG
	4yZhM60gaBiQVXS4KqskXTdSS6XOLUlDB8NTbvRMUJsXGn2nsIFVBJZ8SnBbZWa2
	W2bGDDiw40f5zwXD20ZJW0jEFZcV1arms6+ZfxHurgw4SU9yZi1FiOYUAcPTa9R9
	sH/RbAxu1puI6jnjmRaUzRmdLA40xVtdHVUulNqgJfjyoEnXSMJxzELt+YerIw3a
	BhN070UICPrFCcr69jVTcIyXExelNzIj0OAH+ZpiXM9b/ARWdFZNPW9lQEpx6TtQ
	dITLtc7RrmievpugeFxfMRUntiZ+NzsSm0mEQXpO78bt52agWHUdC8TOMgdDbhkN
	DhrJg==
X-ME-Sender: <xms:f__VaPOmL924_XvJVlAmeMe2PSJ-I_-VIqGLMbWuLj1JadrO_M_PPg>
    <xme:f__VaE6GfC6Af-LuBFdLo7feXVHkvZZVJ5CHTWZD0A2lphongkV0YC93S_KF1ycV5
    B_qWCesYeZJepCJse8VjgPHWIJkD8BR5VzXbosWuDAZZWnZQg>
X-ME-Received: <xmr:f__VaNS5ny1jYBvFiEkHPLZrvCPTUGSuxahEjfFUvHuUjZZ_gncy-W5MgMMbheWT5zWGwxK5x_TYNtzLwydueq_7tnGZCx60s6eAqbuTs9QZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:f__VaJCbNBTJC3CyDg3-J-3tQpckgR1fxzG2QOrLUKZN7irLple7kw>
    <xmx:f__VaFF4LRKD-EtFcfjL5zbQlIbewmltpc-x6wsvnN4f9QyfBoSZng>
    <xmx:f__VaLBu0E7CL2bSA9UFgXsI727ZmCEBWyACgyhx-8QpuKnILU_q-g>
    <xmx:f__VaFUVJsTcCFYk4fVkNbnl9ysYkxOJYF4-uIho8U-e7H1RNWaBbw>
    <xmx:f__VaAHMqxyCUPnYwVbEiToQrdkQBNqsW8gAuqUuUZcaofRotYJBXJ5X>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:37 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/11] VFS: introduce start_dirop() and end_dirop()
Date: Fri, 26 Sep 2025 12:49:06 +1000
Message-ID: <20250926025015.1747294-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
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
that won't unlock when the dentry IS_ERR().  For those cases we have
end_dirop_mkdir().

end_dirop() can always be called on the result of start_dirop(), but not
after vfs_mkdir().
end_dirop_mkdir() can only be called on the result of start_dirop() if
that was not an error, and can also be called on the result of
vfs_mkdir().

When we change vfs_mkdir() to drop the lock when it drops the dentry,
end_dirop_mkdir() can be discarded.

As well as adding start_dirop() and end_dirop()/end_dirop_mkdir()
this patch uses them in:
 - simple_start_creating (which requires sharing lookup_noperm_common()
        with libfs.c)
 - start_removing_path / start_removing_user_path_at
 - filename_create / end_creating_path()
 - do_rmdir(), do_unlinkat()

The change in do_unlinkat() opens the opportunity for some cleanup.
As we don't need to unlock on lookup failure, "inode" can be local
to the non-error patch.  Also the "slashes" handler is moved
in-line with an "unlikely" annotation on the branch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/internal.h      |   3 ++
 fs/libfs.c         |  36 ++++++-------
 fs/namei.c         | 126 +++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |   3 ++
 4 files changed, 110 insertions(+), 58 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index a33d18ee5b74..d11fe787bbc1 100644
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
index ce8c496a6940..fc979becd536 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2289,27 +2289,25 @@ void stashed_dentry_prune(struct dentry *dentry)
 	cmpxchg(stashed, dentry, NULL);
 }
 
-/* parent must be held exclusive */
+/**
+ * simple_start_creating - prepare to create a given name
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
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
index 507ca0d7878d..81cbaabbbe21 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2765,6 +2765,69 @@ static int filename_parentat(int dfd, struct filename *name,
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent - the dentry of the parent in which the operation will occur
+ * @name - a qstr holding the name within that parent
+ * @lookup_flags - intent and other lookup flags.
+ *
+ * The lookup is performed and necessarly locks are taken so that, on success,
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
+ * @de - the dentry which was returned by start_dirop or similar.
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
+/**
+ * end_dirop_mkdir - signal completion of a dirop which could have been vfs_mkdir
+ * @de - the dentry which was returned by start_dirop or similar.
+ * @parent - the parent in which the mkdir happened.
+ *
+ * Because vfs_mkdir() dput()s the dentry on failure, end_dirop() cannot
+ * be used with it.  Instead this function must be used, and it must not
+ * be called if the original lookup failed.
+ *
+ * If de is an error the parent is unlocked, else this behaves the same as
+ * end_dirop().
+ */
+void end_dirop_mkdir(struct dentry *de, struct dentry *parent)
+{
+	if (IS_ERR(de))
+		inode_unlock(parent->d_inode);
+	else
+		end_dirop(de);
+}
+EXPORT_SYMBOL(end_dirop_mkdir);
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__start_removing_path(int dfd, struct filename *name,
 					   struct path *path)
@@ -2781,10 +2844,9 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
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
@@ -2792,10 +2854,9 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
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
@@ -2910,7 +2971,7 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
+int lookup_noperm_common(struct qstr *qname, struct dentry *base)
 {
 	const char *name = qname->name;
 	u32 len = qname->len;
@@ -4223,21 +4284,18 @@ static struct dentry *filename_create(int dfd, struct filename *name,
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
@@ -4258,9 +4316,7 @@ EXPORT_SYMBOL(start_creating_path);
 
 void end_creating_path(struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
-		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	end_dirop_mkdir(dentry, path->dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4592,8 +4648,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4602,9 +4657,8 @@ int do_rmdir(int dfd, struct filename *name)
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
@@ -4705,7 +4759,6 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct path path;
 	struct qstr last;
 	int type;
-	struct inode *inode = NULL;
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
 retry:
@@ -4721,14 +4774,19 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		struct inode *inode = NULL;
 
 		/* Why not before? Because we want correct error value */
-		if (last.name[last.len])
-			goto slashes;
+		if (unlikely(last.name[last.len])) {
+			if (d_is_dir(dentry))
+				error = -EISDIR;
+			else
+				error = -ENOTDIR;
+			goto exit3;
+		}
 		inode = dentry->d_inode;
 		ihold(inode);
 		error = security_path_unlink(&path, dentry);
@@ -4737,12 +4795,10 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		end_dirop(dentry);
+		if (inode)
+			iput(inode);	/* truncate the inode here */
 	}
-	inode_unlock(path.dentry->d_inode);
-	if (inode)
-		iput(inode);	/* truncate the inode here */
-	inode = NULL;
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
@@ -4753,19 +4809,11 @@ int do_unlinkat(int dfd, struct filename *name)
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-		inode = NULL;
 		goto retry;
 	}
 exit1:
 	putname(name);
 	return error;
-
-slashes:
-	if (d_is_dir(dentry))
-		error = -EISDIR;
-	else
-		error = -ENOTDIR;
-	goto exit3;
 }
 
 SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9e9d7c757efe..738554664d54 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3599,6 +3599,9 @@ extern void iterate_supers_type(struct file_system_type *,
 void filesystems_freeze(void);
 void filesystems_thaw(void);
 
+void end_dirop(struct dentry *de);
+void end_dirop_mkdir(struct dentry *de, struct dentry *parent);
+
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
-- 
2.50.0.107.gf914562f5916.dirty


