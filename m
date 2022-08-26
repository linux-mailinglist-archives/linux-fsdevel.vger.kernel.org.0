Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584615A1E9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbiHZCRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiHZCQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:16:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D1ACB5C6;
        Thu, 25 Aug 2022 19:16:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F4E7205B5;
        Fri, 26 Aug 2022 02:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flcbf5eCoYGsPYcUMbhPHTTjfstyi64QPT7HETfyuxs=;
        b=wy/gZVhkTlsEKEZUR1s+RoPDJW63GyDvAf7TyZ0tpXCQjBJ13etQk3h6A/Dqjozj9jdjIf
        EXzMKqYoAUAon5Q01cslO9qBwZGEuEfsr2q6jjseuKbNdITnTS5Kb159YPUm+MxmmdXEyg
        kheyR1KnOAPhwmoUL94vuuCIx9jOlGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480214;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flcbf5eCoYGsPYcUMbhPHTTjfstyi64QPT7HETfyuxs=;
        b=1RlWoEWVyZwFXEQ3/53hLDv0nM/rCErQcGeycJFC8vrfUeO4mcHShCEsAtCeuNOmvZk3g7
        aAz/r0pm72lv5sAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7139713A65;
        Fri, 26 Aug 2022 02:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qB24ChMtCGNSMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:16:51 +0000
Subject: [PATCH 01/10] VFS: support parallel updates in the one directory.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984370.25420.13019217727422217511.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

Some filesystems can support parallel modifications to a directory,
either because the modification happen on a remote server which does its
own locking (e.g.  NFS) or because they can internally lock just a part
of a directory (e.g.  many local filesystems, with a bit of work - the
lustre project has patches for ext4 to support concurrent updates).

To allow this, we introduce VFS support for parallel modification:
unlink (including rmdir) and create.  Parallel rename is added in a
later patch.

If a filesystem supports parallel modification in directories, it sets
FS_PAR_DIR_UPDATE on the file_system_type.  lookup_open() and the new
lookup_hash_update() notice the flag and take a shared lock on the
directory, and rely on a lock-bit in d_flags, much like parallel lookup
relies on DCACHE_PAR_LOOKUP.  The lock bit is always set even if an
exclusive lock was taken, though in that case it will always be
uncontended.

__lookup_hash() is enhanced to use d_alloc_parallel() if it was told
that a shared lock was taken - by being given a non-NULL *wq.  This is
needed as the shared lock does not prevent races with lookups.

The new DCACHE_PAR_UPDATE is the most significant bit in d_flags, so we
have nearly run out of flags.  0x08000000 is still unused ....  for now.

Once a dentry for the target name has been obtained, DCACHE_PAR_UPDATE
is set on it, waiting if necessary if it is already set.  Once this is
set, the thread has exclusive access to the name and can call into the
filesystem to perform the required action.

We use wait_var_event() to wait for DCACHE_PAR_UPDATE to be cleared rather
than trying to overload the wq used for DCACHE_PAR_LOOKUP.

Some filesystems do *not* complete the lookup that precedes a create,
but leave the dentry d_in_lookup() and unhashed, so often a dentry will
have both DCACHE_PAR_LOOKUP and DCACHE_PAR_UPDATE set at the same time.
To allow for this, we need the 'wq' that is passed to d_alloc_parallel()
(and used when DCACHE_PAR_LOOKUP is cleared), to continue to exist until
the creation is complete, which may be after filename_create()
completes.  So a wq now needs to be passed to filename_create() when
parallel modification is attempted.

Some callers, such as kern_path(), perform a lookup for create but don't
pass in a wq and changing all call sites to do so would be churn for
little gain.  So if no wq is provided an exclusive lock is taken and
d_alloc() is used to allocate the dentry.  A new done_path_create_wq()
can be told if a wq was provided for create, so the correct unlock can
be used.

Waiting for DCACHE_PAR_UPDATE can sometimes result in the dentry
changing - either through unlink or rename.  This requires that the
lookup be retried.  This in turn requires that the wq be reused.  The
use of DECLARE_WAITQUEUE() in d_wait_lookup() and the omission of
remove_wait_queue() means that after the wake_up_all() in
__d_lookup_down(), the wait_queue_head list will be undefined.  So we
change d_wait_lookup() to use DEFINE_WAIT(), so that
autoremove_wake_function() is used for wakeups, and the wait_queue_head
remains well defined.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/dcache.c            |   66 ++++++++++++
 fs/namei.c             |  268 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/dcache.h |   28 +++++
 include/linux/fs.h     |    5 +
 include/linux/namei.h  |   16 +++
 5 files changed, 321 insertions(+), 62 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index bb0c4d0038db..d6bfa49b143b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1765,6 +1765,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	struct dentry *dentry;
 	char *dname;
 	int err;
+	static struct lock_class_key __key;
 
 	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
 				      GFP_KERNEL);
@@ -1820,6 +1821,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_LIST_HEAD(&dentry->d_child);
 	d_set_d_op(dentry, dentry->d_sb->s_d_op);
 
+	lockdep_init_map(&dentry->d_update_map, "DENTRY_PAR_UPDATE", &__key, 0);
+
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
 		if (err) {
@@ -2626,7 +2629,7 @@ static inline void end_dir_add(struct inode *dir, unsigned int n,
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
+		DEFINE_WAIT(wait);
 		add_wait_queue(dentry->d_wait, &wait);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
@@ -3274,6 +3277,67 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+/**
+ * d_lock_update_nested - lock a dentry before updating
+ * @dentry: the dentry to be locked
+ * @base:   the parent, or %NULL
+ * @name:   the name in that parent, or %NULL
+ * @subclass: lockdep locking class.
+ *
+ * Lock a dentry in a directory on which a shared-lock may be held, and
+ * on which parallel updates are permitted.
+ * If the base and name are given, then on success the dentry will still
+ * have that base and name - it will not have raced with rename.
+ * On success, a positive dentry will still be hashed, ensuring there
+ * was no race with unlink.
+ * If they are not given, then on success the dentry will be negative,
+ * which again ensures no race with rename, or unlink.
+ *
+ * @subclass uses the I_MUTEX_ classes.
+ * If the parent directory is locked with I_MUTEX_NORMAL, use I_MUTEX_NORMAL.
+ * If the parent is locked with I_MUTEX_PARENT, I_MUTEX_PARENT2 or
+ * I_MUTEX_CHILD, use I_MUTEX_PARENT or, for the second in a rename,
+ * I_MUTEX_PARENT2.
+ */
+bool d_lock_update_nested(struct dentry *dentry,
+			  struct dentry *base, const struct qstr *name,
+			  int subclass)
+{
+	bool ret = true;
+
+	lock_acquire_exclusive(&dentry->d_update_map, subclass,
+			       0, NULL, _THIS_IP_);
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_flags & DCACHE_PAR_UPDATE)
+		___wait_var_event(&dentry->d_flags,
+				  !(dentry->d_flags & DCACHE_PAR_UPDATE),
+				  TASK_UNINTERRUPTIBLE, 0, 0,
+				  (spin_unlock(&dentry->d_lock),
+				   schedule(),
+				   spin_lock(&dentry->d_lock))
+			);
+	rcu_read_lock(); /* for d_same_name() */
+	if (d_unhashed(dentry) && d_is_positive(dentry)) {
+		/* name was unlinked while we waited */
+		ret = false;
+	} else if (base &&
+		 (dentry->d_parent != base ||
+		  dentry->d_name.hash != name->hash ||
+		  !d_same_name(dentry, base, name))) {
+		/* dentry was renamed - possibly silly-rename */
+		ret = false;
+	} else if (!base && d_is_positive(dentry)) {
+		ret = false;
+	} else {
+		dentry->d_flags |= DCACHE_PAR_UPDATE;
+	}
+	rcu_read_unlock();
+	spin_unlock(&dentry->d_lock);
+	if (!ret)
+		lock_map_release(&dentry->d_update_map);
+	return ret;
+}
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..c008dfd01e30 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1574,14 +1574,14 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
+ * Parent directory has inode locked exclusive, or possibly shared if wq
+ * is given.  In the later case the fs has explicitly allowed concurrent
+ * updates in this directory.  This is the one and only case
+ * when ->lookup() may be called on a non in-lookup dentry.
  */
 static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+				    struct dentry *base, unsigned int flags,
+				    wait_queue_head_t *wq)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1594,18 +1594,103 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
+	if (wq)
+		dentry = d_alloc_parallel(base, name, wq);
+	else
+		dentry = d_alloc(base, name);
 	if (unlikely(!dentry))
 		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	if (wq && !d_in_lookup(dentry))
+		/* Must have raced with another thread doing the lookup */
+		return dentry;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
 	return dentry;
 }
 
+/*
+ * Parent directory (base) is not locked.  We take either an exclusive
+ * or shared lock depending on the fs preference, then do a lookup,
+ * and then set the DCACHE_PAR_UPDATE bit on the child if a shared lock
+ * was taken on the parent.
+ */
+static struct dentry *lookup_hash_update(
+	const struct qstr *name,
+	struct dentry *base, unsigned int flags,
+	wait_queue_head_t *wq)
+{
+	struct dentry *dentry;
+	struct inode *dir = base->d_inode;
+	int err;
+
+	if (wq && IS_PAR_UPDATE(dir))
+		inode_lock_shared_nested(dir, I_MUTEX_PARENT);
+	else
+		inode_lock_nested(dir, I_MUTEX_PARENT);
+
+retry:
+	dentry = __lookup_hash(name, base, flags, wq);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto out_err;
+	}
+	if (!d_lock_update_nested(dentry, base, name, I_MUTEX_PARENT)) {
+		/*
+		 * Failed to get lock due to race with unlink or rename
+		 * - try again
+		 */
+		d_lookup_done(dentry);
+		dput(dentry);
+		goto retry;
+	}
+	return dentry;
+
+out_err:
+	if (wq && IS_PAR_UPDATE(dir))
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
+	return ERR_PTR(err);
+}
+
+static int lookup_one_common(struct user_namespace *mnt_userns,
+			     const char *name, struct dentry *base, int len,
+			     struct qstr *this);
+
+struct dentry *lookup_hash_update_len(const char *name, int nlen,
+				      struct path *path, unsigned int flags,
+				      wait_queue_head_t *wq)
+{
+	struct qstr this;
+	int err = lookup_one_common(mnt_user_ns(path->mnt), name,
+				    path->dentry, nlen, &this);
+	if (err)
+		return ERR_PTR(err);
+	return lookup_hash_update(&this, path->dentry, flags, wq);
+}
+EXPORT_SYMBOL(lookup_hash_update_len);
+
+static void done_path_update(struct path *path, struct dentry *dentry,
+			     bool with_wq)
+{
+	struct inode *dir = path->dentry->d_inode;
+
+	d_lookup_done(dentry);
+	d_unlock_update(dentry);
+	if (IS_PAR_UPDATE(dir) && with_wq)
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
+}
+
 static struct dentry *lookup_fast(struct nameidata *nd)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
@@ -2570,7 +2655,7 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = __lookup_hash(&last, path->dentry, 0);
+	d = __lookup_hash(&last, path->dentry, 0, NULL);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -3271,11 +3356,24 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	if (nd->flags & LOOKUP_DIRECTORY)
 		open_flag |= O_DIRECTORY;
 
+	/*
+	 * dentry is negative or d_in_lookup().  In case this is a
+	 * shared-lock create we need to set DCACHE_PAR_UPDATE to ensure
+	 * exclusion.
+	 */
+	if (open_flag & O_CREAT) {
+		if (!d_lock_update(dentry, NULL, NULL))
+			/* already exists, non-atomic open */
+			return dentry;
+	}
+
 	file->f_path.dentry = DENTRY_NOT_SET;
 	file->f_path.mnt = nd->path.mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
+	if ((open_flag & O_CREAT))
+		d_unlock_update(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
 			if (unlikely(dentry != file->f_path.dentry)) {
@@ -3327,6 +3425,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	int error, create_error = 0;
 	umode_t mode = op->mode;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	bool have_par_update = false;
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -3400,6 +3499,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			dentry = res;
 		}
 	}
+	/*
+	 * If dentry is negative and this is a create we need to get
+	 * DCACHE_PAR_UPDATE.
+	 */
+	if ((open_flag & O_CREAT) && !dentry->d_inode)
+		have_par_update = d_lock_update(dentry, NULL, NULL);
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
@@ -3419,9 +3524,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		error = create_error;
 		goto out_dput;
 	}
+	if (have_par_update)
+		d_unlock_update(dentry);
 	return dentry;
 
 out_dput:
+	if (have_par_update)
+		d_unlock_update(dentry);
 	dput(dentry);
 	return ERR_PTR(error);
 }
@@ -3434,6 +3543,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	bool got_write = false;
 	struct dentry *dentry;
 	const char *res;
+	bool shared;
 
 	nd->flags |= op->intent;
 
@@ -3474,14 +3584,15 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
+	shared = !(open_flag & O_CREAT) || IS_PAR_UPDATE(dir->d_inode);
+	if (!shared)
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
 		fsnotify_create(dir->d_inode, dentry);
-	if (open_flag & O_CREAT)
+	if (!shared)
 		inode_unlock(dir->d_inode);
 	else
 		inode_unlock_shared(dir->d_inode);
@@ -3750,41 +3861,29 @@ struct file *do_file_open_root(const struct path *root,
 	return file;
 }
 
-static struct dentry *filename_create(int dfd, struct filename *name,
-				      struct path *path, unsigned int lookup_flags)
+static struct dentry *filename_create_one(struct qstr *last, struct path *path,
+					  unsigned int lookup_flags,
+					  wait_queue_head_t *wq)
 {
-	struct dentry *dentry = ERR_PTR(-EEXIST);
-	struct qstr last;
+	struct dentry *dentry;
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
-	int type;
 	int err2;
 	int error;
 
-	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
-	if (error)
-		return ERR_PTR(error);
-
-	/*
-	 * Yucky last component or no last component at all?
-	 * (foo/., foo/.., /////)
-	 */
-	if (unlikely(type != LAST_NORM))
-		goto out;
-
 	/* don't fail immediately if it's r/o, at least try to report other errors */
 	err2 = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (last->name[last->len] && !want_dir)
 		create_flags = 0;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path->dentry, reval_flag | create_flags);
+	dentry = lookup_hash_update(last, path->dentry,
+				    reval_flag | create_flags,  wq);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto drop_write;
 
 	error = -EEXIST;
 	if (d_is_positive(dentry))
@@ -3806,14 +3905,56 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	}
 	return dentry;
 fail:
+	done_path_update(path, dentry, !!wq);
 	dput(dentry);
 	dentry = ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
+drop_write:
 	if (!err2)
 		mnt_drop_write(path->mnt);
+	return dentry;
+}
+
+struct dentry *filename_create_one_len(const char *name, int nlen,
+				       struct path *path,
+				       unsigned int lookup_flags,
+				       wait_queue_head_t *wq)
+{
+	struct qstr this;
+	int err;
+
+	err = lookup_one_common(mnt_user_ns(path->mnt), name,
+				path->dentry, nlen, &this);
+	if (err)
+		return ERR_PTR(err);
+	return filename_create_one(&this, path, lookup_flags, wq);
+}
+EXPORT_SYMBOL(filename_create_one_len);
+
+static struct dentry *filename_create(int dfd, struct filename *name,
+				      struct path *path, unsigned int lookup_flags,
+				      wait_queue_head_t *wq)
+{
+	struct dentry *dentry = ERR_PTR(-EEXIST);
+	struct qstr last;
+	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
+	int type;
+	int error;
+
+	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
+	if (error)
+		return ERR_PTR(error);
+
+	/*
+	 * Yucky last component or no last component at all?
+	 * (foo/., foo/.., /////)
+	 */
+	if (unlikely(type != LAST_NORM))
+		goto out;
+
+	dentry = filename_create_one(&last, path, lookup_flags, wq);
 out:
-	path_put(path);
+	if (IS_ERR(dentry))
+		path_put(path);
 	return dentry;
 }
 
@@ -3821,27 +3962,28 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname_kernel(pathname);
-	struct dentry *res = filename_create(dfd, filename, path, lookup_flags);
+	struct dentry *res = filename_create(dfd, filename, path, lookup_flags,
+					     NULL);
 
 	putname(filename);
 	return res;
 }
 EXPORT_SYMBOL(kern_path_create);
 
-void done_path_create(struct path *path, struct dentry *dentry)
+void done_path_create_wq(struct path *path, struct dentry *dentry, bool with_wq)
 {
+	done_path_update(path, dentry, with_wq);
 	dput(dentry);
-	inode_unlock(path->dentry->d_inode);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
-EXPORT_SYMBOL(done_path_create);
+EXPORT_SYMBOL(done_path_create_wq);
 
 inline struct dentry *user_path_create(int dfd, const char __user *pathname,
-				struct path *path, unsigned int lookup_flags)
+				       struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname(pathname);
-	struct dentry *res = filename_create(dfd, filename, path, lookup_flags);
+	struct dentry *res = filename_create(dfd, filename, path, lookup_flags, NULL);
 
 	putname(filename);
 	return res;
@@ -3921,12 +4063,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	error = may_mknod(mode);
 	if (error)
 		goto out1;
 retry:
-	dentry = filename_create(dfd, name, &path, lookup_flags);
+	dentry = filename_create(dfd, name, &path, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out1;
@@ -3954,7 +4097,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 	}
 out2:
-	done_path_create(&path, dentry);
+	done_path_create_wq(&path, dentry, true);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4023,9 +4166,10 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 retry:
-	dentry = filename_create(dfd, name, &path, lookup_flags);
+	dentry = filename_create(dfd, name, &path, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putname;
@@ -4038,7 +4182,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
 	}
-	done_path_create(&path, dentry);
+	done_path_create_wq(&path, dentry, true);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4122,6 +4266,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4143,8 +4288,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4158,9 +4302,9 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_userns = mnt_user_ns(path.mnt);
 	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
 exit4:
+	done_path_update(&path, dentry, true);
 	dput(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4185,13 +4329,14 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * @dentry:	victim
  * @delegated_inode: returns victim inode, if the inode is delegated.
  *
- * The caller must hold dir->i_mutex.
+ * The caller must either hold a write-lock on dir->i_rwsem, or
+ * a have atomically set DCACHE_PAR_UPDATE, or both.
  *
  * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
  * return a reference to the inode in delegated_inode.  The caller
  * should then break the delegation on that inode and retry.  Because
  * breaking a delegation may take a long time, the caller should drop
- * dir->i_mutex before doing so.
+ * dir->i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4250,9 +4395,11 @@ EXPORT_SYMBOL(vfs_unlink);
 
 /*
  * Make sure that the actual truncation of the file will occur outside its
- * directory's i_mutex.  Truncate can take a long time if there is a lot of
+ * directory's i_rwsem.  Truncate can take a long time if there is a lot of
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
+ * If the filesystem permits (IS_PAR_UPDATE()), we take a shared lock on the
+ * directory and set DCACHE_PAR_UPDATE to get exclusive access to the dentry.
  */
 int do_unlinkat(int dfd, struct filename *name)
 {
@@ -4264,6 +4411,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct inode *inode = NULL;
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4276,9 +4424,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	error = mnt_want_write(path.mnt);
 	if (error)
 		goto exit2;
+
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		struct user_namespace *mnt_userns;
@@ -4297,9 +4445,9 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_userns, path.dentry->d_inode, dentry,
 				   &delegated_inode);
 exit3:
+		done_path_update(&path, dentry, true);
 		dput(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
@@ -4388,13 +4536,14 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags = 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (IS_ERR(from)) {
 		error = PTR_ERR(from);
 		goto out_putnames;
 	}
 retry:
-	dentry = filename_create(newdfd, to, &path, lookup_flags);
+	dentry = filename_create(newdfd, to, &path, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putnames;
@@ -4407,7 +4556,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 		error = vfs_symlink(mnt_userns, path.dentry->d_inode, dentry,
 				    from->name);
 	}
-	done_path_create(&path, dentry);
+	done_path_create_wq(&path, dentry, true);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4536,6 +4685,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct inode *delegated_inode = NULL;
 	int how = 0;
 	int error;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0) {
 		error = -EINVAL;
@@ -4559,7 +4709,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		goto out_putnames;
 
 	new_dentry = filename_create(newdfd, new, &new_path,
-					(how & LOOKUP_REVAL));
+				     (how & LOOKUP_REVAL), &wq);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto out_putpath;
@@ -4577,7 +4727,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
 out_dput:
-	done_path_create(&new_path, new_dentry);
+	done_path_create_wq(&new_path, new_dentry, true);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error) {
@@ -4847,7 +4997,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
 
-	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
+	old_dentry = __lookup_hash(&old_last, old_path.dentry,
+				   lookup_flags, NULL);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -4855,7 +5006,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = __lookup_hash(&new_last, new_path.dentry, lookup_flags | target_flags);
+	new_dentry = __lookup_hash(&new_last, new_path.dentry,
+				   lookup_flags | target_flags, NULL);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 92c78ed02b54..d71c12907617 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -13,7 +13,9 @@
 #include <linux/rcupdate.h>
 #include <linux/lockref.h>
 #include <linux/stringhash.h>
+#include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/wait_bit.h>
 
 struct path;
 struct vfsmount;
@@ -96,6 +98,8 @@ struct dentry {
 	unsigned long d_time;		/* used by d_revalidate */
 	void *d_fsdata;			/* fs-specific data */
 
+	/* lockdep tracking of DCACHE_PAR_UPDATE locks */
+	struct lockdep_map		d_update_map;
 	union {
 		struct list_head d_lru;		/* LRU list */
 		wait_queue_head_t *d_wait;	/* in-lookup ones only */
@@ -211,6 +215,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_PAR_UPDATE		0x80000000 /* Being created or unlinked with shared lock */
 
 extern seqlock_t rename_lock;
 
@@ -598,4 +603,27 @@ struct name_snapshot {
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
 
+bool d_lock_update_nested(struct dentry *dentry,
+			  struct dentry *base, const struct qstr *name,
+			  int subclass);
+static inline bool d_lock_update(struct dentry *dentry,
+				 struct dentry *base, const struct qstr *name)
+{
+	/* 0 is I_MUTEX_NORMAL, but fs.h might not be included */
+	return d_lock_update_nested(dentry, base, name, 0);
+}
+
+static inline void d_unlock_update(struct dentry *dentry)
+{
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+	if (dentry->d_flags & DCACHE_PAR_UPDATE) {
+		lock_map_release(&dentry->d_update_map);
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_PAR_UPDATE;
+		spin_unlock(&dentry->d_lock);
+		wake_up_var(&dentry->d_flags);
+	}
+}
+
 #endif	/* __LINUX_DCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..a9a48306806a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2524,12 +2524,13 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_ALLOW_IDMAP		32	/* FS has been updated to handle vfs idmappings. */
+#define FS_PAR_DIR_UPDATE	BIT(6)	/* Allow parallel directory updates */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index caeb08a98536..b7a123b489b1 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -61,7 +61,14 @@ extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
-extern void done_path_create(struct path *, struct dentry *);
+extern struct dentry *lookup_hash_update_len(const char *name, int nlen,
+					     struct path *path, unsigned int flags,
+					     wait_queue_head_t *wq);
+extern void done_path_create_wq(struct path *, struct dentry *, bool);
+static inline void done_path_create(struct path *path, struct dentry *dentry)
+{
+	done_path_create_wq(path, dentry, false);
+}
 extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
@@ -75,6 +82,13 @@ struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
 struct dentry *lookup_one_positive_unlocked(struct user_namespace *mnt_userns,
 					    const char *name,
 					    struct dentry *base, int len);
+struct dentry *filename_create_one_len(const char *name, int nlen,
+				       struct path *path,
+				       unsigned int lookup_flags,
+				       wait_queue_head_t *wq);
+static inline bool IS_PAR_UPDATE(struct inode *dir) {
+	return !!(dir->i_sb->s_type->fs_flags & FS_PAR_DIR_UPDATE);
+}
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);


