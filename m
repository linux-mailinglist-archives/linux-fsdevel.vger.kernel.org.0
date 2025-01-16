Return-Path: <linux-fsdevel+bounces-39371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A03A13280
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447097A3815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167581A83E0;
	Thu, 16 Jan 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wvZL/YdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7032157E88;
	Thu, 16 Jan 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005004; cv=none; b=PAirpko2MqnnbziI4PiWtYNeJbhlhtZAyFaZcwKgp0GyqWgOodyeol/TB9/nIGNRzIwP7p5axWvZ3s0BVHby7a6AtSySkXOTJ6TUnKRSQ3fq9Y+9eEwigQlJOEf7PHdXKvOTX4MSvMlEc3v35PbPDwQsJXuYkJ3ZS2V6mHbKUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005004; c=relaxed/simple;
	bh=pebguC7yBaT1CfCeU8IoKa1qp9w/nenKal0WBuZHXFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4BB6yvjgXiHc4tVoj7IB1r/uOjNsrXrI4HmOvBH/MUwbCwjtP1WyXlKtBsCVJKIUxi3KRQaE+4lh8B9i7Ai6qk+za8MO7gqnIIFpKn5bl3hNEpNctUSM1+EstyE+qFuWvWQScIBc6dnLwR6gMQUrTjpsVsmJSQxLPXGIWKikUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wvZL/YdY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1cyqCeqgV8SV7Bbn/l88t8DR8FQG+BtXpkABEHx6sIY=; b=wvZL/YdYkWVnTwHOXUHFTY6W3b
	yk9UoduAo7QTUfwIYCigCZdTqBSz9oOdVirOO3iCV7bew+mFvhaP38vkWe5o7d/Wtv5dAsN+aYvD7
	+PW89IAB2WFqIkf3JEKQEf32WVHiqfiMDnXCR1L7b8MvSAOds5908z69ET8ZdAAdiQIx9O2rEb3Vy
	lXO3iOVD35LSQBwGzcqXN2e3M+Zdk64wRjilH1nJuKTi7arvYAsYnGDL0cQc/Im4ihEYAI+aZepup
	YfD+IXfMR6P3mI40/2LYNS8/28n2ttiCmUEAz8CHOFpvfGJe/yBZhH3sDeJ2WzOk3XYTlK5gfBE1R
	rBb8csRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILg-000000022Ir-0n2j;
	Thu, 16 Jan 2025 05:23:20 +0000
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
Subject: [PATCH v2 20/20] 9p: fix ->rename_sem exclusion
Date: Thu, 16 Jan 2025 05:23:17 +0000
Message-ID: <20250116052317.485356-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
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

Add a couple of optional methods, so that __d_unalias() would do
	if alias->d_op->d_unalias_trylock != NULL
		if (!alias->d_op->d_unalias_trylock(alias))
			fail (resulting in -ESTALE from lookup)
	__d_move(...)
	if alias->d_op->d_unalias_unlock != NULL
		alias->d_unalias_unlock(alias)
where it currently does __d_move().  9p instances do down_write_trylock()
and up_write() of ->rename_mutex.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/locking.rst |  4 ++++
 Documentation/filesystems/vfs.rst     | 21 +++++++++++++++++++++
 fs/9p/v9fs.h                          |  2 +-
 fs/9p/vfs_dentry.c                    | 16 ++++++++++++++++
 fs/dcache.c                           |  5 +++++
 include/linux/dcache.h                |  2 ++
 6 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 146e7d8aa736..d20a32b77b60 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -31,6 +31,8 @@ prototypes::
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+	bool (*d_unalias_trylock)(const struct dentry *);
+	void (*d_unalias_unlock)(const struct dentry *);
 
 locking rules:
 
@@ -50,6 +52,8 @@ d_dname:	   no		no		no		no
 d_automount:	   no		no		yes		no
 d_manage:	   no		no		yes (ref-walk)	maybe
 d_real		   no		no		yes 		no
+d_unalias_trylock  yes		no		no 		no
+d_unalias_unlock   yes		no		no 		no
 ================== ===========	========	==============	========
 
 inode_operations
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c352ebaae98..31eea688609a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1265,6 +1265,8 @@ defined:
 		struct vfsmount *(*d_automount)(struct path *);
 		int (*d_manage)(const struct path *, bool);
 		struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+		bool (*d_unalias_trylock)(const struct dentry *);
+		void (*d_unalias_unlock)(const struct dentry *);
 	};
 
 ``d_revalidate``
@@ -1428,6 +1430,25 @@ defined:
 
 	For non-regular files, the 'dentry' argument is returned.
 
+``d_unalias_trylock``
+	if present, will be called by d_splice_alias() before moving a
+	preexisting attached alias.  Returning false prevents __d_move(),
+	making d_splice_alias() fail with -ESTALE.
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
+``d_unalias_unlock``
+	should be paired with ``d_unalias_trylock``; that one is called after
+	__d_move() call in __d_unalias().
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
index 872c1abe3295..5061f192eafd 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -105,14 +105,30 @@ static int v9fs_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	return __v9fs_lookup_revalidate(dentry, flags);
 }
 
+static bool v9fs_dentry_unalias_trylock(const struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	return down_write_trylock(&v9ses->rename_sem);
+}
+
+static void v9fs_dentry_unalias_unlock(const struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	up_write(&v9ses->rename_sem);
+}
+
 const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
 	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
 	.d_release = v9fs_dentry_release,
+	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
+	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
 	.d_delete = always_delete_dentry,
 	.d_release = v9fs_dentry_release,
+	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
+	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
diff --git a/fs/dcache.c b/fs/dcache.c
index 6f36d3e8c739..695406e48937 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2961,7 +2961,12 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 		goto out_err;
 	m2 = &alias->d_parent->d_inode->i_rwsem;
 out_unalias:
+	if (alias->d_op->d_unalias_trylock &&
+	    !alias->d_op->d_unalias_trylock(alias))
+		goto out_err;
 	__d_move(alias, dentry, false);
+	if (alias->d_op->d_unalias_unlock)
+		alias->d_op->d_unalias_unlock(alias);
 	ret = 0;
 out_err:
 	if (m2)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4a6bdadf2f29..9a1a30857763 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -159,6 +159,8 @@ struct dentry_operations {
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
+	bool (*d_unalias_trylock)(const struct dentry *);
+	void (*d_unalias_unlock)(const struct dentry *);
 } ____cacheline_aligned;
 
 /*
-- 
2.39.5


