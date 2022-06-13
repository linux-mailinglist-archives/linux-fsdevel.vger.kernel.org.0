Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76B54A285
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiFMXUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFMXUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:20:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBBBC32;
        Mon, 13 Jun 2022 16:20:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8892821AA0;
        Mon, 13 Jun 2022 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAyx4lnT48FNRLjRvrBUnHtS5K5G19758aNWXIlREG4=;
        b=IiVqI0b+7Ysyf8nrZ9y1Fz+NGolcwI1S3XvOKvnN4syPmynHdxzlART7ErI5chTFYYSqm+
        B59GelGMpXsAEXabaPat3pqVoKtqB4gbSIOIGiyS/+D8BFvd1ftfC9I8erAkYhaY8lq92u
        iFFZktTzXMpOUcNl5AicjC9eZes5uBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAyx4lnT48FNRLjRvrBUnHtS5K5G19758aNWXIlREG4=;
        b=B97reOGAcYHj6qampMy/vPSVYE0MYJSMh/Vs3ZNVKGTjdaCn+On8FphJCeMxTUvU5dqf8s
        x/FRi8QvJp9Dx5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F470134CF;
        Mon, 13 Jun 2022 23:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MyjIMx7Gp2KbbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:19:58 +0000
Subject: [PATCH 01/12] VFS: support parallel updates in the one directory.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:21 +1000
Message-ID: <165516230195.21248.5682920287666811819.stgit@noble.brown>
In-Reply-To: <165516173293.21248.14587048046993234326.stgit@noble.brown>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

If a filesystem supports parallel modification in a given directory, it
sets S_PAR_UPDATE on the inode for that directory.  lookup_open() and
the new lookup_hash_update() notice the flag and take a shared lock on
the directory, and rely on a lock-bit in d_flags, much like parallel
lookup relies on DCACHE_PAR_LOOKUP.

__lookup_hash() is enhanced to use d_alloc_parallel() if it was told
that a shared lock was taken - by being given a non-NULL *wq.

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

Waiting for DCACHE_PAR_UPDATE can sometimes result in the dentry
changing - either through unlink or rename.  This requires that the
lookup be retried.  This in turn requires that the wq be reused.  The
use for DECLARE_WAITQUEUE() in d_wait_lookup() and the omission of
remove_wait_queue() means that after the wake_up_all() in
__d_lookup_down(), the wait_queue_head list will be undefined.  So we
change d_wait_lookup() to use DEFINE_WAIT(), so that
autoremove_wake_function() is used for wakeups, and the wait_queue_head
remains well defined.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/dcache.c            |   59 ++++++++++
 fs/namei.c             |  277 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/dcache.h |   27 +++++
 include/linux/fs.h     |    1 
 include/linux/namei.h  |   13 ++
 5 files changed, 317 insertions(+), 60 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..1b523b512575 100644
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
@@ -2580,7 +2583,7 @@ static inline void end_dir_add(struct inode *dir, unsigned n)
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
+		DEFINE_WAIT(wait);
 		add_wait_queue(dentry->d_wait, &wait);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
@@ -3209,6 +3212,60 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+/**
+ * d_lock_update_nested - lock a dentry before updating
+ * @dentry: the dentry to be locked
+ * @base:   the parent, or %NULL
+ * @name:   the name in that parent, or %NULL
+ * @subclass: lockdep locking class.
+ *
+ * Lock a dentry in a directory on which a shared-lock is held, and
+ * on which parallel updates are permitted.
+ * If the base and name are given, then on success the dentry will still
+ * have that base and name - it will not have raced with rename.
+ * On success, a positive dentry will still be hashed, ensuring there
+ * was no race with unlink.
+ * If they are not given, then on success the dentry will be negative,
+ * which again ensures no race with rename, or unlink.
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
+	spin_unlock(&dentry->d_lock);
+	if (!ret)
+		lock_map_release(&dentry->d_update_map);
+	return ret;
+}
+EXPORT_SYMBOL(d_lock_update_nested);
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..9a2ca515c219 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1575,14 +1575,13 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
+ * Parent directory has inode locked exclusive, or shared if wq is
+ * given.  In the later case the fs has explicitly allowed concurrent
+ * creates in this directory.
  */
 static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+				    struct dentry *base, unsigned int flags,
+				    wait_queue_head_t *wq)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1595,18 +1594,107 @@ static struct dentry *__lookup_hash(const struct qstr *name,
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
+	if (wq && d_in_lookup(dentry))
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
+static struct dentry *lookup_hash_update(const struct qstr *name,
+					 struct dentry *base, unsigned int flags,
+					 wait_queue_head_t *wq)
+{
+	struct dentry *dentry;
+	struct inode *dir = base->d_inode;
+	int err;
+
+	if (!(dir->i_flags & S_PAR_UPDATE))
+		wq = NULL;
+
+	if (wq)
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
+	if (wq && !d_lock_update(dentry, base, name)) {
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
+	if (wq)
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
+			     wait_queue_head_t *wq)
+{
+	struct inode *dir = path->dentry->d_inode;
+	bool shared = (dir->i_flags & S_PAR_UPDATE) && wq;
+
+	if (shared) {
+		d_lookup_done(dentry);
+		d_unlock_update(dentry);
+		inode_unlock_shared(dir);
+	} else {
+		inode_unlock(dir);
+	}
+}
+
 static struct dentry *lookup_fast(struct nameidata *nd,
 				  struct inode **inode,
 			          unsigned *seqp)
@@ -2589,7 +2677,7 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = __lookup_hash(&last, path->dentry, 0);
+	d = __lookup_hash(&last, path->dentry, 0, NULL);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -3226,16 +3314,32 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
 	struct inode *dir =  nd->path.dentry->d_inode;
+	bool have_par_update = false;
 	int error;
 
 	if (nd->flags & LOOKUP_DIRECTORY)
 		open_flag |= O_DIRECTORY;
 
+	/*
+	 * dentry is negative or d_in_lookup().  If this is a
+	 * shared-lock create we need to set DCACHE_PAR_UPDATE to ensure
+	 * exclusion.
+	 */
+	if ((open_flag & O_CREAT) &&
+	    (dir->i_flags & S_PAR_UPDATE)) {
+		if (!d_lock_update(dentry, NULL, NULL))
+			/* already exists, non-atomic open */
+			return dentry;
+		have_par_update = true;
+	}
+
 	file->f_path.dentry = DENTRY_NOT_SET;
 	file->f_path.mnt = nd->path.mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
+	if (have_par_update)
+		d_unlock_update(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
 			if (unlikely(dentry != file->f_path.dentry)) {
@@ -3287,6 +3391,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	int error, create_error = 0;
 	umode_t mode = op->mode;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	bool have_par_update = false;
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -3361,6 +3466,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			dentry = res;
 		}
 	}
+	/*
+	 * If dentry is negative and this is a shared-lock
+	 * create we need to get DCACHE_PAR_UPDATE to ensure exclusion
+	 */
+	if ((open_flag & O_CREAT) &&
+	    !dentry->d_inode &&
+	    (dir_inode->i_flags & S_PAR_UPDATE))
+		have_par_update = d_lock_update(dentry, NULL, NULL);
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
@@ -3380,9 +3493,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
@@ -3397,6 +3514,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
+	bool shared;
 
 	nd->flags |= op->intent;
 
@@ -3437,14 +3555,15 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
+	shared = !!(dir->d_inode->i_flags & S_PAR_UPDATE);
+	if ((open_flag & O_CREAT) && !shared)
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
 		fsnotify_create(dir->d_inode, dentry);
-	if (open_flag & O_CREAT)
+	if ((open_flag & O_CREAT) && !shared)
 		inode_unlock(dir->d_inode);
 	else
 		inode_unlock_shared(dir->d_inode);
@@ -3712,41 +3831,29 @@ struct file *do_file_open_root(const struct path *root,
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
@@ -3768,14 +3875,56 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	}
 	return dentry;
 fail:
+	done_path_update(path, dentry, wq);
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
 
@@ -3783,27 +3932,29 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
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
+void done_path_create_wq(struct path *path, struct dentry *dentry,
+			 wait_queue_head_t *wq)
 {
+	done_path_update(path, dentry, wq);
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
@@ -3882,12 +4033,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
@@ -3916,7 +4068,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 	}
 out2:
-	done_path_create(&path, dentry);
+	done_path_create_wq(&path, dentry, &wq);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -3985,9 +4137,10 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
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
@@ -4001,7 +4154,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
 	}
-	done_path_create(&path, dentry);
+	done_path_create_wq(&path, dentry, &wq);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4085,6 +4238,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4106,8 +4260,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4121,9 +4274,9 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_userns = mnt_user_ns(path.mnt);
 	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
 exit4:
+	done_path_update(&path, dentry, &wq);
 	dput(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4148,13 +4301,14 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * @dentry:	victim
  * @delegated_inode: returns victim inode, if the inode is delegated.
  *
- * The caller must hold dir->i_mutex.
+ * The caller must either hold a write-lock on dir->i_rwsem, or
+ * a read-lock having atomically set DCACHE_PAR_UPDATE.
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
@@ -4213,9 +4367,11 @@ EXPORT_SYMBOL(vfs_unlink);
 
 /*
  * Make sure that the actual truncation of the file will occur outside its
- * directory's i_mutex.  Truncate can take a long time if there is a lot of
+ * directory's i_rwsem.  Truncate can take a long time if there is a lot of
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
+ * If the directory permits (S_PAR_UPDATE), we take a shared lock on the
+ * directory DCACHE_PAR_UPDATE to get exclusive access to the dentry.
  */
 int do_unlinkat(int dfd, struct filename *name)
 {
@@ -4227,6 +4383,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct inode *inode = NULL;
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4239,9 +4396,9 @@ int do_unlinkat(int dfd, struct filename *name)
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
@@ -4260,9 +4417,9 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_userns, path.dentry->d_inode, dentry,
 				   &delegated_inode);
 exit3:
+		done_path_update(&path, dentry, &wq);
 		dput(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
@@ -4351,13 +4508,14 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
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
@@ -4370,7 +4528,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 		error = vfs_symlink(mnt_userns, path.dentry->d_inode, dentry,
 				    from->name);
 	}
-	done_path_create(&path, dentry);
+	done_path_create_wq(&path, dentry, &wq);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4499,6 +4657,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct inode *delegated_inode = NULL;
 	int how = 0;
 	int error;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0) {
 		error = -EINVAL;
@@ -4522,7 +4681,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		goto out_putnames;
 
 	new_dentry = filename_create(newdfd, new, &new_path,
-					(how & LOOKUP_REVAL));
+				     (how & LOOKUP_REVAL), &wq);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto out_putpath;
@@ -4540,7 +4699,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
 out_dput:
-	done_path_create(&new_path, new_dentry);
+	done_path_create_wq(&new_path, new_dentry, &wq);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error) {
@@ -4810,7 +4969,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
 
-	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
+	old_dentry = __lookup_hash(&old_last, old_path.dentry,
+				   lookup_flags, NULL);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -4818,7 +4978,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
index f5bba51480b2..6331cf4ac87a 100644
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
 
@@ -599,4 +604,26 @@ struct name_snapshot {
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
 
+bool d_lock_update_nested(struct dentry *dentry,
+			  struct dentry *base, const struct qstr *name,
+			  int subclass);
+static inline bool d_lock_update(struct dentry *dentry,
+				 struct dentry *base, const struct qstr *name)
+{
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
index 9ad5e3520fae..96a2a23927e1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2146,6 +2146,7 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_PAR_UPDATE	(1 << 18) /* Parallel directory operations supported */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
diff --git a/include/linux/namei.h b/include/linux/namei.h
index caeb08a98536..f75c6639dd1a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -61,7 +61,14 @@ extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
-extern void done_path_create(struct path *, struct dentry *);
+extern struct dentry *lookup_hash_update_len(const char *name, int nlen,
+					     struct path *path, unsigned int flags,
+					     wait_queue_head_t *wq);
+extern void done_path_create_wq(struct path *, struct dentry *, wait_queue_head_t *wq);
+static inline void done_path_create(struct path *path, struct dentry *dentry)
+{
+	done_path_create_wq(path, dentry, NULL);
+}
 extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
@@ -75,6 +82,10 @@ struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
 struct dentry *lookup_one_positive_unlocked(struct user_namespace *mnt_userns,
 					    const char *name,
 					    struct dentry *base, int len);
+struct dentry *filename_create_one_len(const char *name, int nlen,
+				       struct path *path,
+				       unsigned int lookup_flags,
+				       wait_queue_head_t *wq);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);


