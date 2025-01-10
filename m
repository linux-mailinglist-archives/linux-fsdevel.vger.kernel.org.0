Return-Path: <linux-fsdevel+bounces-38794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6BA085A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93695188CBF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26972080DD;
	Fri, 10 Jan 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XL/XkZo3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28B1F63C9;
	Fri, 10 Jan 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476989; cv=none; b=OLA8uQyXcjNObtKTNGSnu4JLHbw0539uCh2yovj/ZlTDtqZV3tD10UEfpLosJPFt51ex4ZXT6TQsaOI5RUNS+QV07ndroLP9fmHDAKorfoRIki/TAckttnGVtdnSbKfDTt10+OHu4g2lla3yRclowH4W6Eu6rB6qhztJENXd+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476989; c=relaxed/simple;
	bh=2nrxAKPQt+jainpMoWcyV9eaLyi/kGHg5WJk+J3gNkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMSq9KXXrQITWM21+d4uV+yfU+azPVjtd2BZKJb4HVHRH5KvEt2/TfOarfJeTghrbEfWA/Zu3eXmbMpUMo0LQVmKPd/aCPaVHRpAqG1UT3tN8kcbERLuebatLn1lFeJnaCA33/5WCrP2YmJUCVZAhhnuAK9LikFj68ELGPXYR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XL/XkZo3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+hJB8UCiBMMIE0LbCgBudJFZSfpKBcOyl49tfwqEHVo=; b=XL/XkZo3Q6wZuX6Px2TvAHnCGc
	+Na1ayE++EHFKHtYkt1o7mNmyfdxues/2YGrhs4VSiWLPp/lHFnFzHYNy70jA11EMvGx0LQQvmB6M
	OjmhO8NbdY+TgXJ2AOksbhscL0NzQsh9HuAD0ZSwGJSvLVeB0AP+xLnJbK6J+b07oO4rA2ztlfXUX
	ARKhB0eZVjGBCA4Q6kaGPqgnc7ZAJ2FSNcNsCiWr2e4+O7X13H4Loa9krrcD3vz8QeLWRmI7Jaaz6
	/7/ekyYO90YNdUCj4ChVqKQ0Xj52bqEIlmmyUM2VqY5VXaGKgvifv6E+otqVU9onuFGMYnajW8eKY
	aO7Ns4lA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRdL-3AHE;
	Fri, 10 Jan 2025 02:43:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH 20/20] 9p: fix ->rename_sem exclusion
Date: Fri, 10 Jan 2025 02:43:03 +0000
Message-ID: <20250110024303.4157645-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

9p wants to be able to build a path from given dentry to fs root and keep
it valid over a blocking operation.

->s_vfs_rename_mutex would be a natural candidate, but there are places
where we need that and where we have no way to tell if ->s_vfs_rename_mutex
is already held deeper in callchain.  Moreover, it's only held for
cross-directory renames; name changes within the same directory happen
without it.

Solution:
	* have d_move() done in ->rename() rather than in its caller
	* maintain a 9p-private rwsem (per-filesystem)
	* hold it exclusive over the relevant part of ->rename()
	* hold it shared over the places where we want the path.

That almost works.  FS_RENAME_DOES_D_MOVE is enough to put all d_move()
and d_exchange() calls under filesystem's control.  However, there's
also __d_unalias(), which isn't covered by any of that.

If ->lookup() hits a directory inode with preexisting dentry elsewhere
(due to e.g. rename done on server behind our back), d_splice_alias()
called by ->lookup() will move/rename that alias.

An approach to fixing that would be a couple of optional methods, so that
__d_unalias() would do
	if alias->d_op->d_unalias_trylock != NULL
		if (!alias->d_op->d_unalias_trylock(alias))
			fail (resulting in -ESTALE from lookup)
	__d_move(...)
	if alias->d_op->d_unalias_unlock != NULL
		alias->d_unalias_unlock(alias)
where it currently does __d_move().  9p instances would be down_write_trylock()
and up_write() of ->rename_mutex.

However, to reduce dentry_operations bloat, let's add one method instead -
->d_want_unalias(alias, true) instead of ->d_unalias_trylock(alias) and
->d_want_unalias(alias, false) instead of ->d_unalias_unlock(alias).

Another possible variant would be to hold ->rename_sem exclusive around
d_splice_alias() calls in 9p ->lookup(), but that would cause a lot of
contention on that rwsem and it's filesystem-wide, so let's not go there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/locking.rst |  2 ++
 Documentation/filesystems/vfs.rst     | 19 +++++++++++++++++++
 fs/9p/v9fs.h                          |  2 +-
 fs/9p/vfs_dentry.c                    | 13 +++++++++++++
 fs/dcache.c                           |  6 ++++++
 include/linux/dcache.h                |  1 +
 6 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 146e7d8aa736..6e20282447a0 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -31,6 +31,7 @@ prototypes::
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+	bool (*d_want_unalias)(const struct dentry *, bool);
 
 locking rules:
 
@@ -50,6 +51,7 @@ d_dname:	   no		no		no		no
 d_automount:	   no		no		yes		no
 d_manage:	   no		no		yes (ref-walk)	maybe
 d_real		   no		no		yes 		no
+d_want_unalias	   yes		no		no 		no
 ================== ===========	========	==============	========
 
 inode_operations
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c352ebaae98..07d4b4deb252 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1265,6 +1265,7 @@ defined:
 		struct vfsmount *(*d_automount)(struct path *);
 		int (*d_manage)(const struct path *, bool);
 		struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+		bool (*d_want_unalias)(const struct dentry *, bool);
 	};
 
 ``d_revalidate``
@@ -1428,6 +1429,24 @@ defined:
 
 	For non-regular files, the 'dentry' argument is returned.
 
+``d_want_unalias``
+	if present, will be called by d_splice_alias() before and after
+	moving a preexisting attached alias.  The second argument is
+	true for call before __d_move() and false for the call after.
+	Returning false on the first call prevents __d_move(), making
+	d_splice_alias() fail with -ESTALE; return value on the second
+	call is ignored.
+
+	Rationale: setting FS_RENAME_DOES_D_MOVE will prevent d_move()
+	and d_exchange() calls from the outside of filesystem methods;
+	however, it does not guarantee that attached dentries won't
+	be renamed or moved by d_splice_alias() finding a preexisting
+	alias for a directory inode.  Normally we would not care;
+	however, something that wants to stabilize the entire path to
+	root over a blocking operation might need that.  See 9p for one
+	(and hopefully only) example.
+
+
 Each dentry has a pointer to its parent dentry, as well as a hash list
 of child dentries.  Child dentries are basically like files in a
 directory.
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 698c43dd5dc8..f28bc763847a 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -202,7 +202,7 @@ static inline struct v9fs_session_info *v9fs_inode2v9ses(struct inode *inode)
 	return inode->i_sb->s_fs_info;
 }
 
-static inline struct v9fs_session_info *v9fs_dentry2v9ses(struct dentry *dentry)
+static inline struct v9fs_session_info *v9fs_dentry2v9ses(const struct dentry *dentry)
 {
 	return dentry->d_sb->s_fs_info;
 }
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 872c1abe3295..b2222df318d0 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -105,14 +105,27 @@ static int v9fs_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	return __v9fs_lookup_revalidate(dentry, flags);
 }
 
+static bool v9fs_dentry_want_unalias(const struct dentry *dentry, bool lock)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+
+	if (lock)
+		return down_write_trylock(&v9ses->rename_sem);
+
+	up_write(&v9ses->rename_sem);
+	return true;
+}
+
 const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
 	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
 	.d_release = v9fs_dentry_release,
+	.d_want_unalias = v9fs_dentry_want_unalias,
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
 	.d_delete = always_delete_dentry,
 	.d_release = v9fs_dentry_release,
+	.d_want_unalias = v9fs_dentry_want_unalias,
 };
diff --git a/fs/dcache.c b/fs/dcache.c
index 7d42ca367522..efbfbc1bc5d4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2947,6 +2947,7 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 {
 	struct mutex *m1 = NULL;
 	struct rw_semaphore *m2 = NULL;
+	bool (*extra_trylock)(const struct dentry *, bool);
 	int ret = -ESTALE;
 
 	/* If alias and dentry share a parent, then no extra locks required */
@@ -2961,7 +2962,12 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 		goto out_err;
 	m2 = &alias->d_parent->d_inode->i_rwsem;
 out_unalias:
+	extra_trylock = alias->d_op->d_want_unalias;
+	if (extra_trylock && !extra_trylock(alias, true))
+		goto out_err;
 	__d_move(alias, dentry, false);
+	if (extra_trylock)
+		extra_trylock(alias, false);
 	ret = 0;
 out_err:
 	if (m2)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4a6bdadf2f29..2b33b9d04a8f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -159,6 +159,7 @@ struct dentry_operations {
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+	bool (*d_want_unalias)(const struct dentry *, bool);
 } ____cacheline_aligned;
 
 /*
-- 
2.39.5


