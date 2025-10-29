Return-Path: <linux-fsdevel+bounces-66388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD72C1DBA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E724252D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE02868A9;
	Wed, 29 Oct 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="asb4BGtb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsKJfaAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B237A3D2;
	Wed, 29 Oct 2025 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781503; cv=none; b=Rwn6crW90NHD0T/dtY+l0gRYeWJy2hny/w2Ha2ngi0QCl+4ym9xR1+zHvbR692PVzL1dEg1hBK1H7pL4Tw999CgtcM4pkOPNOpG22vrm3QQiNF98OSWzxp4FU2L6XfN/riM7A0RQFh8vA0sk5SHKq4jSV7VqJ7Ta0Ba1bJhk+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781503; c=relaxed/simple;
	bh=7z1puoGc0Maw2mYrBj5q5gzBpwaxvsXaP30tLYcOr9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv8fXIafL32lNRHZi/IoXh/pkNbZGZIEdmjOHMg4bMVj7KqPfMsYjEcADIhlJcWvyEH+fCz/0wSsVeiJqDZ3LBXa5BaEw1RJJJJe2eXnJfrUaDjNsLjwmZPiuPMunHULULHnorazythTLSJsX5bAwn84igt0khr33gXNO3krsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=asb4BGtb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsKJfaAW; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id ECC6313001A1;
	Wed, 29 Oct 2025 19:44:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Oct 2025 19:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781499;
	 x=1761788699; bh=XmECYJsbB/jZ2LHmTB/scwrXUR8F+2VoGp+BtgaR5S4=; b=
	asb4BGtbwh9wJXIiH4YOnEc1vqJzfKCJ1pF5tjVkjAoqlhNAdns7au+bOm/OSV+b
	3MAVjXQz3aUHdSOyC9a6EncbqQijTGrM0dtYITJ3Lg7T+vamS3idF/xjVN/cljz6
	qsTv82RqsSLbYCoWedCaYIKBiKXAXHIdURluz5oCAiJaldgyE4LL4qpDz/DrM+yD
	rboZYLoPUHVpWDdaL77ldIJQv4ZM0dyhIGICKKXAd9n1oLtPw0K4pwG0Fu1kq0CG
	l7hLorGpsLnoFmVb/r904woHGydLA4yDxqH9z7h9CwbtYAic6uZ88navVXT0+FQm
	850lXP2a7hOFi8n0dX0Gww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781499; x=1761788699; bh=X
	mECYJsbB/jZ2LHmTB/scwrXUR8F+2VoGp+BtgaR5S4=; b=WsKJfaAWyjGr/eolt
	u98gY3aY1buBgg6EINOgIAvYa7WFSKpIdlERn6v0ZxJHoNYA4nVoK6a+s1a3ZWH5
	231vH/qVp5K9WMHKxtGc1ETEnQD58LTT9yW7ND6JydI3OQV1SXOM9z6x3AXWmIGD
	261P6jX9PSiWcgbT+ZLalxhazH0ZmS2HNHJujH4F2HvZ5ZWMo1DDcoLTWtLMVqg5
	JsEkMx/6rZzzmBBOUtb/7fHKCxaikrVucof8ybDiq7dMqdemQYk5eloqc0+QCkty
	7PYvhYMT/i2X7O5cvEutJ0XOHsFWf15Vp3AATiMa2BELzKnjU6T4eAzMCB5tMGRr
	Xd0LQ==
X-ME-Sender: <xms:-6YCacUaRvYv_Mflw_xZ8RyXiZrnUxY6w2DI9aM7HiM21NuynjFsGg>
    <xme:-6YCaTfGDUqd6QLsFE9W2jNDWSsBMhRu3LXg5AhxztFlBCLZazO6bR2W9yJoTTJpD
    ChHl3Recz5jAYFi0nhscw5G1sIXqE50L1ckCODcnknTsonM>
X-ME-Received: <xmr:-6YCaRNvGjbWf5pBSHhLLOVaSLHF_oLnauPwnIJH1vTm8AgByAEKkbsgxi3-WiqeiA-S7O56ozbxn5ZES7R3v7JeuKCE3CP1z1_4DwKXBDPN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:-6YCadIyTdrxokJYCtTMpMzcz5tb3HF4FhcwX7MRHoKlRzwuAQbJag>
    <xmx:-6YCaUiCDOFEkcA5NKrk-QsCncLxVbYwl8WA0HwN5MhERWd7u-60_g>
    <xmx:-6YCaTcrKKlQcn9FVcqbPWFwGB8nQ0zEAaZnOTcaaQs04iks_k_guQ>
    <xmx:-6YCaU4H0XNp5cbSn0qsV1wNPyuEEMgyWWax0SbzOYOaATjFPJBbvg>
    <xmx:-6YCaR8v6Y2UJYVVEeieMm1A5cG-x5Hs8QS8aoQaX4LfG1N9icPZDPom>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:44:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 02/14] VFS: introduce start_dirop() and end_dirop()
Date: Thu, 30 Oct 2025 10:31:02 +1100
Message-ID: <20251029234353.1321957-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251029234353.1321957-1-neilb@ownmail.net>
References: <20251029234353.1321957-1-neilb@ownmail.net>
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


