Return-Path: <linux-fsdevel+bounces-57604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECAB23CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CC21B65EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46F2EAB68;
	Tue, 12 Aug 2025 23:53:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAA2D4B5C;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042785; cv=none; b=B7mK3ajcd4qWz7fGcKi/NmHjnNI5gvYN/6mswx+X/9UJmtkTz02nz95U3AucYH09V/MrQsDnLQcpPSIFYQu9Xb51Ws+uD+tfeWo6NkXi2OAFrbob7yGOcTlOsegJoNeJCJrbHrdhU9kyz0vqwnZOukJrjL86YiJIMaK0C6bnUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042785; c=relaxed/simple;
	bh=9qcyWdG+FPc6f3BpLvDkzYF4KvXRp3c65nSRlmO6sGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGwXVlzMaUCbPagmjpVsZe0cLUg3G+KEVhUdWNGAW3B4LBEfdhXYc+eXWIu2oIwY+G5UfRFXFujSqac/vxLK8ETdRWuJ7meBNkYg1R9VwIoh3OoA2/fNqQw2sC5jbWHHK9CcKQVjKECCaSpudlK9NdYUnzkcMgCkW8hRQ0LDVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynR-005Y2F-21;
	Tue, 12 Aug 2025 23:52:50 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] VFS: introduce d_alloc_noblock() and d_alloc_locked()
Date: Tue, 12 Aug 2025 12:25:14 +1000
Message-ID: <20250812235228.3072318-12-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several filesystems use the results of readdir to prime the dcache.
These filesystems use d_alloc_parallel() which can block if there is a
concurrent lookup.  Blocking in that case is pointless as the lookup
will add info to the dcache and there is no value in the readdir waiting
to see if it should add the info too.

Also these calls to d_alloc_parallel() are made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So this patch introduces d_alloc_noblock() which doesn't block
but instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache now use that and ignore -EWOULDBLOCK errors as harmless.

A few filesystems need more than -EWOULDBLOCK - they need to be able to
create the missing dentry within the readdir.  procfs is a good example
as the inode number is not known until the lookup completes, so readdir
must perform a full lookup.

For these filesystems d_alloc_locked() is provided.  It will return a
dentry which is already d_in_lookup() but will also lock it against
concurrent lookup.  The filesystem's ->lookup function must co-operate
by calling lock_lookup() before proceeding with the lookup.  This way we
can ensure exclusion between a lookup performed in ->iterate_shared and
a lookup performed in ->lookup.  Currently this exclusion is provided by
waiting in d_wait_lookup().  The proposed changed to dir locking will
mean that calling d_wait_lookup() (in readdir) while already holding
i_rwsem could deadlock.

Any filesystem (i.e.  xfs) that uses d_add_ci() faces a similar problem
as d_add_ci() calls d_alloc_parallel() while holding i_rwsem and so
will risk deadlock.  d_add_ci() is changed to use d_alloc_locked() and
any filesystem using it must call lock_lookup() in the ->lookup
function, at least when configured for ci.

After the changes to directory locking are complete, filesystems which
opt out of using i_rwsem (which will be for all member-related
activities except ->iterate_shared) lookups will no longer wait for
i_rwsem so d_alloc_locked() will no longer be needed: d_alloc_parallel()
won't deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c             | 147 ++++++++++++++++++++++++++++++++++++++--
 fs/fuse/readdir.c       |  14 ++--
 fs/namei.c              |  57 ++++++++++++++--
 fs/nfs/dir.c            |  13 ++--
 fs/smb/client/readdir.c |   2 +-
 fs/xfs/xfs_iops.c       |   5 ++
 include/linux/dcache.h  |   7 +-
 include/linux/namei.h   |   2 +
 8 files changed, 225 insertions(+), 22 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7e3eb5576fa4..ca96518f21f1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2121,6 +2121,10 @@ EXPORT_SYMBOL(d_obtain_root);
  *
  * If no entry exists with the exact case name, allocate new dentry with
  * the exact case, and return the spliced entry.
+ *
+ * Any filesystem which calls this in its ->lookup function must
+ * call lock_lookup() at the start of that function and return the
+ * result if IS_ERR_OR_NULL()
  */
 struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 			struct qstr *name)
@@ -2136,7 +2140,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
-	found = d_alloc_parallel(dentry->d_parent, name);
+	found = d_alloc_locked(dentry->d_parent, name);
 	if (IS_ERR(found) || !d_in_lookup(found)) {
 		iput(inode);
 		return found;
@@ -2581,8 +2585,16 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name)
+/* What to do when __d_alloc_parallel finds a d_in_lookup dentry */
+enum alloc_para {
+	ALLOC_PARA_WAIT,
+	ALLOC_PARA_FAIL,
+	ALLOC_PARA_RETURN,
+};
+
+static inline struct dentry *__d_alloc_parallel(struct dentry *parent,
+						const struct qstr *name,
+						enum alloc_para how)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2596,6 +2608,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = NULL;
+	new->d_lookup_locked = false;
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
@@ -2663,7 +2676,22 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * wait for them to finish
 		 */
 		spin_lock(&dentry->d_lock);
-		d_wait_lookup(dentry);
+		if (d_in_lookup(dentry))
+			switch (how) {
+			case ALLOC_PARA_FAIL:
+				spin_unlock(&dentry->d_lock);
+				dput(new);
+				dput(dentry);
+				return ERR_PTR(-EWOULDBLOCK);
+			case ALLOC_PARA_RETURN:
+				spin_unlock(&dentry->d_lock);
+				dput(new);
+				return dentry;
+			case ALLOC_PARA_WAIT:
+				d_wait_lookup(dentry);
+				/* ... and continue */
+			}
+
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2692,8 +2720,116 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup(), then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_parallel() waits for
+ * that lookup to complete before returning the dentry and then ensures the
+ * match is still valid.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.  (but see
+ * d_alloc_locked() below) If the returned dentry is not
+ * d_in_lookup() then a lookup has already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error %-ENOMEM.
+ */
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
+/**
+ * d_alloc_noblock() - find or allocate a new dentry
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_noblock()
+ * returns with error %-EWOULDBLOCK.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.  (but see
+ * d_alloc_locked() below) If the returned dentry is not
+ * d_in_lookup() then a lookup has already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    %-ENOMEM or %-EWOULDBLOCK.
+ */
+struct dentry *d_alloc_noblock(struct dentry *parent,
+					struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+}
+EXPORT_SYMBOL(d_alloc_noblock);
+
+/**
+ * d_alloc_locked() - allocate a new dentry and ensure uniqueness
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is not
+ * d_in_lookup() then that is returned instead.  If the existing dentry
+ * is d_in_lookup(), d_alloc_locked() will return it and the caller
+ * should instantiate it.  This requires particular care on the part of
+ * the caller.
+ *
+ * This may only be used by a filesystem on its own dentrys.  Any filesystem
+ * using it must have a lookup inode_operation which first calls
+ * lock_lookup() on the dentry and returns the result if it IS_ERR_OR_NULL().
+ * This will ensure only one of the callers of d_alloc_locked() or ->lookup()
+ * will instantiate the dentry, but not both.
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    -ENOMEM.
+ */
+struct dentry *d_alloc_locked(struct dentry *parent,
+			      struct qstr *name)
+{
+	struct dentry *dentry;
+again:
+	dentry = __d_alloc_parallel(parent, name, ALLOC_PARA_RETURN);
+	if (IS_ERR(dentry))
+		return dentry;
+	if (d_in_lookup(dentry)) {
+		spin_lock(&dentry->d_lock);
+		wait_var_event_spinlock(&dentry->d_lookup_locked,
+					!d_in_lookup(dentry) ||
+					!dentry->d_lookup_locked,
+					&dentry->d_lock);
+		if (d_in_lookup(dentry)) {
+			dentry->d_lookup_locked = true;
+			spin_unlock(&dentry->d_lock);
+			return dentry;
+		}
+		spin_unlock(&dentry->d_lock);
+	}
+	if (d_unhashed(dentry)) {
+		dput(dentry);
+		goto again;
+	}
+	return dentry;
+}
+EXPORT_SYMBOL(d_alloc_locked);
+
 /*
  * - Unhash the dentry
  * - Retrieve and clear the waitqueue head in dentry
@@ -2706,6 +2842,9 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 
 	lockdep_assert_held(&dentry->d_lock);
 
+	if (dentry->d_lookup_locked)
+		wake_up_var_locked(&dentry->d_lookup_locked, &dentry->d_lock);
+
 	b = in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index f588252891af..d566db29c51a 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -6,12 +6,12 @@
   See the file COPYING.
 */
 
-
 #include "fuse_i.h"
 #include <linux/iversion.h>
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/namei.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -192,14 +192,18 @@ static int fuse_direntplus_link(struct file *file,
 	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
 
-	name.hash = full_name_hash(parent, name.name, name.len);
-	dentry = d_lookup(parent, &name);
+	dentry = try_lookup_noperm(&name, parent);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name);
-		if (IS_ERR(dentry))
+		dentry = d_alloc_noblock(parent, &name);
+		if (IS_ERR(dentry)) {
+			if (PTR_ERR(dentry) == -EWOULDBLOCK)
+				/* harmless */
+				return 0;
 			return PTR_ERR(dentry);
+		}
 	}
+
 	if (!d_in_lookup(dentry)) {
 		struct fuse_inode *fi;
 		inode = d_inode(dentry);
diff --git a/fs/namei.c b/fs/namei.c
index 6a645f3a2b20..5e03458f503c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1665,6 +1665,49 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 	return dentry;
 }
 
+/*
+ * lock_lookup: prepare to lookup exclusively with d_alloc_locked()
+ * @dentry: the dentry that needs to be locked for lookup
+ *
+ * Any filesystem which uses d_alloc_locked() internally must
+ * commense the lookup() inode_operation with a called to lock_lookup(),
+ * and must immediately return the result if it is %NULL or an error.
+ * This protects against races so that only one thread will proceed
+ * to create the relevant inode and instantiate it to the dentry.
+ *
+ * The lock is achieved by setting ->d_lookup_locked while
+ * %DCACHE_PAR_LOOKUP is set.  d_lookup_done() and other functions
+ * which clear %DCACHE_PAR_LOOKUP will wake up any waiters if
+ * ->d_lookup_locked was set.
+ *
+ * Returns: @dentry if the lock was gained, else a suitable return value
+ * for ->lookup, either %NULL if lookup is already compete or  %-EAGAIN
+ * indicating that the dcache lookup needs to be repeated.
+ */
+struct dentry *lock_lookup(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	wait_var_event_spinlock(&dentry->d_lookup_locked,
+				!d_in_lookup(dentry) ||
+				!dentry->d_lookup_locked,
+				&dentry->d_lock);
+	if (d_in_lookup(dentry)) {
+		dentry->d_lookup_locked = true;
+		spin_unlock(&dentry->d_lock);
+		/* Continue with normal lookup */
+		return dentry;
+	}
+	spin_unlock(&dentry->d_lock);
+	if (!d_unhashed(dentry))
+		/* Just return dentry */
+		return NULL;
+	/* lookup didn't hash dentry, maybe it substituted a dentry.
+	 * Need to retry
+	 */
+	return ERR_PTR(-EAGAIN);
+}
+EXPORT_SYMBOL(lock_lookup);
+
 /*
  * Parent directory has inode locked.
  * d_lookup_done() must be called before the dentry is dput()
@@ -1682,6 +1725,7 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	struct dentry *old;
 	struct inode *dir;
 
+again:
 	dentry = lookup_dcache(name, base, flags);
 	if (dentry)
 		goto found;
@@ -1702,6 +1746,8 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(old)) {
 		d_lookup_done(dentry);
 		dput(dentry);
+		if (old == ERR_PTR(-EAGAIN))
+			goto again;
 		dentry = old;
 	}
 found:
@@ -2057,6 +2103,8 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 		d_lookup_done(dentry);
 		if (unlikely(old)) {
 			dput(dentry);
+			if (old == ERR_PTR(-EAGAIN))
+			    goto again;
 			dentry = old;
 		}
 	}
@@ -4057,6 +4105,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		return ERR_PTR(-ENOENT);
 
 	file->f_mode &= ~FMODE_CREATED;
+again:
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
@@ -4120,11 +4169,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 							     nd->flags);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
-			if (IS_ERR(res)) {
-				error = PTR_ERR(res);
-				goto out_dput;
-			}
 			dput(dentry);
+			if (res == ERR_PTR(-EAGAIN))
+				goto again;
+			if (IS_ERR(res))
+				return res;
 			dentry = res;
 		}
 	}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bbeb24805a0e..4293754cdec6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -750,15 +750,14 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		if (filename.len == 2 && filename.name[1] == '.')
 			return;
 	}
-	filename.hash = full_name_hash(parent, filename.name, filename.len);
 
-	dentry = d_lookup(parent, &filename);
+	dentry = try_lookup_noperm(&filename, parent);
 again:
-	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename);
-		if (IS_ERR(dentry))
-			return;
-	}
+	if (!dentry)
+		dentry = d_alloc_noblock(parent, &filename);
+	if (IS_ERR(dentry))
+		return;
+
 	if (!d_in_lookup(dentry)) {
 		/* Is there a mountpoint here? If so, just exit */
 		if (!nfs_fsid_equal(&NFS_SB(dentry->d_sb)->fsid,
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 5a92a1ad317d..d47fc8ab7879 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -105,7 +105,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
 
-		dentry = d_alloc_parallel(parent, name);
+		dentry = d_alloc_noblock(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 149b5460fbfd..07a4a8116f08 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -35,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
+#include <linux/namei.h>
 
 /*
  * Directories have different lock order w.r.t. mmap_lock compared to regular
@@ -349,6 +350,10 @@ xfs_vn_ci_lookup(
 	if (dentry->d_name.len >= MAXNAMELEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	dentry = lock_lookup(dentry);
+	if (IS_ERR_OR_NULL(dentry))
+		return dentry;
+
 	xfs_dentry_to_name(&xname, dentry);
 	error = xfs_lookup(XFS_I(dir), &xname, &ip, &ci_name);
 	if (unlikely(error)) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 996259d1bc88..cfccd5c2fa5b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -114,7 +114,10 @@ struct dentry {
 
 	union {
 		struct list_head d_lru;		/* LRU list */
-		wait_queue_head_t *d_wait;	/* in-lookup ones only */
+		struct {			/* in-lookup ones only */
+			wait_queue_head_t *d_wait;
+			bool		   d_lookup_locked;
+		};
 	};
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
@@ -242,6 +245,8 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
+extern struct dentry * d_alloc_locked(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 26e5778c665f..a39dca19375b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -101,6 +101,8 @@ struct dentry *simple_start_creating(struct dentry *parent, const char *name)
 				    LOOKUP_CREATE | LOOKUP_EXCL);
 }
 
+struct dentry *lock_lookup(struct dentry *dentry);
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.50.0.107.gf914562f5916.dirty


