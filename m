Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688434BEFA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiBVCZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 21:25:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVCZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:25:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC725C50;
        Mon, 21 Feb 2022 18:24:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 779521F393;
        Tue, 22 Feb 2022 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645496696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f9qZDGPI6LJt9sQX6R9aNI+D5jkG6a8S2anNBl9PVxk=;
        b=hq4GQjldvzNbxBkPOPuO+P3phSldpnItWC1q0eqCIAjmt4zIsn3ksxOE2fJT7EmRYdu6fb
        cvlgvorh6ceXQVO2YgVFENuzjAOoYBa1+dj4xyZre6g80UOJ1IMmFF8zP0sDRhsvxU8VQT
        wUV5M181N+mtBxHxjPwvfGyQF/u09oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645496696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f9qZDGPI6LJt9sQX6R9aNI+D5jkG6a8S2anNBl9PVxk=;
        b=xnCiZCxH976yH4Gblu98C4dcIU/hOBgEkcevCA3kB6n/z8aAkm5gUrnQ15edjBfg1kRa0m
        d64TidCmlzGQRsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E242B13510;
        Tue, 22 Feb 2022 02:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tEpfJXVJFGKQSwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 22 Feb 2022 02:24:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH/RFC] VFS: support parallel updates in the one directory.
Date:   Tue, 22 Feb 2022 13:24:50 +1100
Message-id: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al,
 I wonder if you might find time to have a look at this patch.  It
 allows concurrent updates to a single directory.  This can result in
 substantial throughput improvements when the application uses multiple
 threads to create lots of files in the one directory, and there is
 noticeable per-create latency, as there can be with NFS to a remote
 server.
Thanks,
NeilBrown

Some filesystems can support parallel modifications to a directory,
either because the modification happen on a remote server which does its
own locking (e.g.  NFS) or because they can internally lock just a part
of a directory (e.g.  many local filesystems, with a bit of work - the
lustre project has patches for ext4 to support concurrent updates).

To allow this, we introduce VFS support for parallel modification:
unlink (including rmdir) and create.  Parallel rename is not (yet)
supported.

If a filesystem supports parallel modification in a given directory, it
sets S_PAR_UNLINK on the inode for that directory.  lookup_open() and
the new lookup_hash_modify() (similar to __lookup_hash()) notice the
flag and take a shared lock on the directory, and rely on a lock-bit in
d_flags, much like parallel lookup relies on DCACHE_PAR_LOOKUP.

The new DCACHE_PAR_UPDATE is most significant bit in d_flags, so we have
nearly run out of flags.  0x08000000 is still unused .... for now.

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
lookup be retried.  This in turn requires that the wq be reused.
The use for DECLARE_WAITQUEUE() in d_wait_lookup() and the omission of
remove_wait_queue() means that the after the wake_up_all() in
__d_lookup_down(), the wait_queue_head list will be undefined.  So we change
d_wait_lookup() to use DEFINE_WAIT(), so that autoremove_wake_function()
is used for wakeups, and the wait_queue_head remains well defined.

NFS can easily support parallel updates as the locking is done on the
server, so this patch enable parallel updates for NFS.  This would be a
separate patch in the final submission.

NFS unlink needs to block concurrent opens() once it decides to actually
unlink the file, rather the rename it to .nfsXXXX (aka sillyrename).
It currently does this by temporarily unhashing the dentry and relying
on the exclusive lock on the directory to block a ->lookup().  That
doesn't work now that unlink uses a shared lock, so an alternate
approach is needed.

__nfs_lookup_revalidate (->d_revalidate) now blocks if DCACHE_PAR_UPDATE
is set, and if nfs_unlink() happens to be called with an exclusive lock
and DCACHE_PAR_UPDATE is not it, it sets during the potential race window.

I'd rather use some other indicator in the dentry to tell
_nfs_lookup_revalidate() to wait, but we are nearly out of d_flags bits,
and NFS does have a general-purpose d_fsdata.

NFS "silly-rename" may now be called with only a shared lock on the
directory, so it needs a bit of extra care to get exclusive access to
the new name. d_lock_update_nested() and d_unlock_update() help here.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/dcache.c            |  59 ++++++++++++-
 fs/namei.c             | 193 ++++++++++++++++++++++++++++++++++-------
 fs/nfs/dir.c           |  31 +++++--
 fs/nfs/inode.c         |   2 +
 fs/nfs/unlink.c        |   5 +-
 include/linux/dcache.h |  27 ++++++
 include/linux/fs.h     |   1 +
 7 files changed, 278 insertions(+), 40 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..1ca63abbe4b2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1765,6 +1765,7 @@ static struct dentry *__d_alloc(struct super_block *sb,=
 const struct qstr *name)
 	struct dentry *dentry;
 	char *dname;
 	int err;
+	static struct lock_class_key __key;
=20
 	dentry =3D kmem_cache_alloc(dentry_cache, GFP_KERNEL);
 	if (!dentry)
@@ -1819,6 +1820,8 @@ static struct dentry *__d_alloc(struct super_block *sb,=
 const struct qstr *name)
 	INIT_LIST_HEAD(&dentry->d_child);
 	d_set_d_op(dentry, dentry->d_sb->s_d_op);
=20
+	lockdep_init_map(&dentry->d_update_map, "DENTRY_PAR_UPDATE", &__key, 0);
+
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err =3D dentry->d_op->d_init(dentry);
 		if (err) {
@@ -2579,7 +2582,7 @@ static inline void end_dir_add(struct inode *dir, unsig=
ned n)
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
+		DEFINE_WAIT(wait);
 		add_wait_queue(dentry->d_wait, &wait);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
@@ -3208,6 +3211,60 @@ void d_tmpfile(struct dentry *dentry, struct inode *in=
ode)
 }
 EXPORT_SYMBOL(d_tmpfile);
=20
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
+	bool ret =3D true;
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
+		ret =3D false;
+	} else if (base &&
+		 (dentry->d_parent !=3D base ||
+		  dentry->d_name.hash !=3D name->hash ||
+		  !d_same_name(dentry, base, name))) {
+		/* dentry was renamed - possibly silly-rename */
+		ret =3D false;
+	} else if (!base && d_is_positive(dentry)) {
+		ret =3D false;
+	} else {
+		dentry->d_flags |=3D DCACHE_PAR_UPDATE;
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
index 3f1829b3ab5b..f8cdbabc23c9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1613,6 +1613,94 @@ static struct dentry *__lookup_hash(const struct qstr =
*name,
 	return dentry;
 }
=20
+/*
+ * Parent directory (base) is not locked.  We take either an exclusive
+ * or shared lock depending on the fs preference, then dor a lookup,
+ * and then set the DCACHE_PAR_UPDATE bit on the child if a shared lock
+ * was taken on the parent.
+ */
+static struct dentry *lookup_hash_update(const struct qstr *name,
+					 struct dentry *base, unsigned int flags,
+					 wait_queue_head_t *wq)
+{
+	struct dentry *dentry;
+	struct inode *dir =3D base->d_inode;
+	bool shared =3D (dir->i_flags & S_PAR_UPDATE) && wq;
+	int err;
+
+	if (shared)
+		inode_lock_shared_nested(dir, I_MUTEX_PARENT);
+	else
+		inode_lock_nested(dir, I_MUTEX_PARENT);
+
+retry:
+	dentry =3D lookup_dcache(name, base, flags);
+	if (!dentry) {
+		/* Don't create child dentry for a dead directory. */
+		err =3D -ENOENT;
+		if (unlikely(IS_DEADDIR(dir)))
+			goto out_err;
+
+		if (shared)
+			dentry =3D d_alloc_parallel(base, name, wq);
+		else
+			dentry =3D d_alloc(base, name);
+
+		if (!IS_ERR(dentry) &&
+		    (!shared || d_in_lookup(dentry))) {
+			struct dentry *old;
+
+			old =3D dir->i_op->lookup(dir, dentry, flags);
+			/*
+			 * Note: dentry might still be d_unhashed() and
+			 * d_in_lookup() if the fs will do the lookup
+			 * at 'create' time.
+			 */
+			if (unlikely(old)) {
+				d_lookup_done(dentry);
+				dput(dentry);
+				dentry =3D old;
+			}
+		}
+	}
+	if (IS_ERR(dentry)) {
+		err =3D PTR_ERR(dentry);
+		goto out_err;
+	}
+	if (shared && !d_lock_update(dentry, base, name)) {
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
+	if (shared)
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
+	return ERR_PTR(err);
+}
+
+static void lookup_done_update(struct path *path, struct dentry *dentry,
+			       wait_queue_head_t *wq)
+{
+	struct inode *dir =3D path->dentry->d_inode;
+	bool shared =3D (dir->i_flags & S_PAR_UPDATE) && wq;
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
@@ -3182,16 +3270,32 @@ static struct dentry *atomic_open(struct nameidata *n=
d, struct dentry *dentry,
 {
 	struct dentry *const DENTRY_NOT_SET =3D (void *) -1UL;
 	struct inode *dir =3D  nd->path.dentry->d_inode;
+	bool have_par_update =3D false;
 	int error;
=20
 	if (nd->flags & LOOKUP_DIRECTORY)
 		open_flag |=3D O_DIRECTORY;
=20
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
+		have_par_update =3D true;
+	}
+
 	file->f_path.dentry =3D DENTRY_NOT_SET;
 	file->f_path.mnt =3D nd->path.mnt;
 	error =3D dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
+	if (have_par_update)
+		d_unlock_update(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
 			if (unlikely(dentry !=3D file->f_path.dentry)) {
@@ -3243,6 +3347,7 @@ static struct dentry *lookup_open(struct nameidata *nd,=
 struct file *file,
 	int error, create_error =3D 0;
 	umode_t mode =3D op->mode;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	bool have_par_update =3D false;
=20
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -3317,6 +3422,14 @@ static struct dentry *lookup_open(struct nameidata *nd=
, struct file *file,
 			dentry =3D res;
 		}
 	}
+	/*
+	 * If dentry is negative and this is a shared-lock
+	 * create we need to get DCACHE_PAR_UPDATE to ensure exclusion
+	 */
+	if ((open_flag & O_CREAT) &&
+	    !dentry->d_inode &&
+	    (dir_inode->i_flags & S_PAR_UPDATE))
+		have_par_update =3D d_lock_update(dentry, NULL, NULL);
=20
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
@@ -3336,9 +3449,13 @@ static struct dentry *lookup_open(struct nameidata *nd=
, struct file *file,
 		error =3D create_error;
 		goto out_dput;
 	}
+	if (have_par_update)
+		d_unlock_update(dentry);
 	return dentry;
=20
 out_dput:
+	if (have_par_update)
+		d_unlock_update(dentry);
 	dput(dentry);
 	return ERR_PTR(error);
 }
@@ -3353,6 +3470,7 @@ static const char *open_last_lookups(struct nameidata *=
nd,
 	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
+	bool shared;
=20
 	nd->flags |=3D op->intent;
=20
@@ -3393,14 +3511,15 @@ static const char *open_last_lookups(struct nameidata=
 *nd,
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
+	shared =3D !!(dir->d_inode->i_flags & S_PAR_UPDATE);
+	if ((open_flag & O_CREAT) && !shared)
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
 	dentry =3D lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
 		fsnotify_create(dir->d_inode, dentry);
-	if (open_flag & O_CREAT)
+	if ((open_flag & O_CREAT) && !shared)
 		inode_unlock(dir->d_inode);
 	else
 		inode_unlock_shared(dir->d_inode);
@@ -3669,7 +3788,8 @@ struct file *do_file_open_root(const struct path *root,
 }
=20
 static struct dentry *filename_create(int dfd, struct filename *name,
-				      struct path *path, unsigned int lookup_flags)
+				      struct path *path, unsigned int lookup_flags,
+				      wait_queue_head_t *wq)
 {
 	struct dentry *dentry =3D ERR_PTR(-EEXIST);
 	struct qstr last;
@@ -3701,10 +3821,9 @@ static struct dentry *filename_create(int dfd, struct =
filename *name,
 	 * Do the final lookup.
 	 */
 	lookup_flags |=3D LOOKUP_CREATE | LOOKUP_EXCL;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry =3D __lookup_hash(&last, path->dentry, lookup_flags);
+	dentry =3D lookup_hash_update(&last, path->dentry, lookup_flags, wq);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto drop_write;
=20
 	error =3D -EEXIST;
 	if (d_is_positive(dentry))
@@ -3726,10 +3845,10 @@ static struct dentry *filename_create(int dfd, struct=
 filename *name,
 	}
 	return dentry;
 fail:
+	lookup_done_update(path, dentry, wq);
 	dput(dentry);
 	dentry =3D ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
+drop_write:
 	if (!err2)
 		mnt_drop_write(path->mnt);
 out:
@@ -3741,27 +3860,33 @@ struct dentry *kern_path_create(int dfd, const char *=
pathname,
 				struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename =3D getname_kernel(pathname);
-	struct dentry *res =3D filename_create(dfd, filename, path, lookup_flags);
+	struct dentry *res =3D filename_create(dfd, filename, path, lookup_flags,
+					     NULL);
=20
 	putname(filename);
 	return res;
 }
 EXPORT_SYMBOL(kern_path_create);
=20
-void done_path_create(struct path *path, struct dentry *dentry)
+static void __done_path_create(struct path *path, struct dentry *dentry,
+			       wait_queue_head_t *wq)
 {
+	lookup_done_update(path, dentry, wq);
 	dput(dentry);
-	inode_unlock(path->dentry->d_inode);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
+void done_path_create(struct path *path, struct dentry *dentry)
+{
+	__done_path_create(path, dentry, NULL);
+}
 EXPORT_SYMBOL(done_path_create);
=20
 inline struct dentry *user_path_create(int dfd, const char __user *pathname,
-				struct path *path, unsigned int lookup_flags)
+				       struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename =3D getname(pathname);
-	struct dentry *res =3D filename_create(dfd, filename, path, lookup_flags);
+	struct dentry *res =3D filename_create(dfd, filename, path, lookup_flags, N=
ULL);
=20
 	putname(filename);
 	return res;
@@ -3840,12 +3965,13 @@ static int do_mknodat(int dfd, struct filename *name,=
 umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags =3D 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
=20
 	error =3D may_mknod(mode);
 	if (error)
 		goto out1;
 retry:
-	dentry =3D filename_create(dfd, name, &path, lookup_flags);
+	dentry =3D filename_create(dfd, name, &path, lookup_flags, &wq);
 	error =3D PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out1;
@@ -3874,7 +4000,7 @@ static int do_mknodat(int dfd, struct filename *name, u=
mode_t mode,
 			break;
 	}
 out2:
-	done_path_create(&path, dentry);
+	__done_path_create(&path, dentry, &wq);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |=3D LOOKUP_REVAL;
 		goto retry;
@@ -3943,9 +4069,10 @@ int do_mkdirat(int dfd, struct filename *name, umode_t=
 mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags =3D LOOKUP_DIRECTORY;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
=20
 retry:
-	dentry =3D filename_create(dfd, name, &path, lookup_flags);
+	dentry =3D filename_create(dfd, name, &path, lookup_flags, &wq);
 	error =3D PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putname;
@@ -3959,7 +4086,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t =
mode)
 		error =3D vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
 	}
-	done_path_create(&path, dentry);
+	__done_path_create(&path, dentry, &wq);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |=3D LOOKUP_REVAL;
 		goto retry;
@@ -4043,6 +4170,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags =3D 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 retry:
 	error =3D filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4064,8 +4192,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
=20
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry =3D __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry =3D lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
 	error =3D PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4079,9 +4206,9 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_userns =3D mnt_user_ns(path.mnt);
 	error =3D vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
 exit4:
+	lookup_done_update(&path, dentry, &wq);
 	dput(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4106,13 +4233,14 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
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
@@ -4171,9 +4299,11 @@ EXPORT_SYMBOL(vfs_unlink);
=20
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
@@ -4185,6 +4315,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct inode *inode =3D NULL;
 	struct inode *delegated_inode =3D NULL;
 	unsigned int lookup_flags =3D 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 retry:
 	error =3D filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4197,9 +4328,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	error =3D mnt_want_write(path.mnt);
 	if (error)
 		goto exit2;
+
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry =3D __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry =3D lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
 	error =3D PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		struct user_namespace *mnt_userns;
@@ -4218,9 +4349,9 @@ int do_unlinkat(int dfd, struct filename *name)
 		error =3D vfs_unlink(mnt_userns, path.dentry->d_inode, dentry,
 				   &delegated_inode);
 exit3:
+		lookup_done_update(&path, dentry, &wq);
 		dput(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode =3D NULL;
@@ -4309,13 +4440,14 @@ int do_symlinkat(struct filename *from, int newdfd, s=
truct filename *to)
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags =3D 0;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
=20
 	if (IS_ERR(from)) {
 		error =3D PTR_ERR(from);
 		goto out_putnames;
 	}
 retry:
-	dentry =3D filename_create(newdfd, to, &path, lookup_flags);
+	dentry =3D filename_create(newdfd, to, &path, lookup_flags, &wq);
 	error =3D PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putnames;
@@ -4328,7 +4460,7 @@ int do_symlinkat(struct filename *from, int newdfd, str=
uct filename *to)
 		error =3D vfs_symlink(mnt_userns, path.dentry->d_inode, dentry,
 				    from->name);
 	}
-	done_path_create(&path, dentry);
+	__done_path_create(&path, dentry, &wq);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |=3D LOOKUP_REVAL;
 		goto retry;
@@ -4457,6 +4589,7 @@ int do_linkat(int olddfd, struct filename *old, int new=
dfd,
 	struct inode *delegated_inode =3D NULL;
 	int how =3D 0;
 	int error;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
=20
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) !=3D 0) {
 		error =3D -EINVAL;
@@ -4480,7 +4613,7 @@ int do_linkat(int olddfd, struct filename *old, int new=
dfd,
 		goto out_putnames;
=20
 	new_dentry =3D filename_create(newdfd, new, &new_path,
-					(how & LOOKUP_REVAL));
+				     (how & LOOKUP_REVAL), &wq);
 	error =3D PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto out_putpath;
@@ -4498,7 +4631,7 @@ int do_linkat(int olddfd, struct filename *old, int new=
dfd,
 	error =3D vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
 out_dput:
-	done_path_create(&new_path, new_dentry);
+	__done_path_create(&new_path, new_dentry, &wq);
 	if (delegated_inode) {
 		error =3D break_deleg_wait(&delegated_inode);
 		if (!error) {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7bc7cf6b26f0..4a6c24aadb79 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1638,6 +1638,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned=
 int flags,
 	int ret;
=20
 	if (flags & LOOKUP_RCU) {
+		if (dentry->d_flags & DCACHE_PAR_UPDATE)
+			/* Pending unlink */
+			return -ECHILD;
 		parent =3D READ_ONCE(dentry->d_parent);
 		dir =3D d_inode_rcu(parent);
 		if (!dir)
@@ -1646,6 +1649,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned=
 int flags,
 		if (parent !=3D READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else {
+		/* Wait for unlink to complete */
+		wait_var_event(&dentry->d_flags,
+			       !(dentry->d_flags & DCACHE_PAR_UPDATE));
 		parent =3D dget_parent(dentry);
 		ret =3D reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -2308,8 +2314,6 @@ static int nfs_safe_remove(struct dentry *dentry)
 			nfs_drop_nlink(inode);
 	} else
 		error =3D NFS_PROTO(dir)->remove(dir, dentry);
-	if (error =3D=3D -ENOENT)
-		nfs_dentry_handle_enoent(dentry);
 	trace_nfs_remove_exit(dir, dentry, error);
 out:
 	return error;
@@ -2323,7 +2327,7 @@ static int nfs_safe_remove(struct dentry *dentry)
 int nfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
-	int need_rehash =3D 0;
+	bool did_set_par_update =3D false;
=20
 	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry);
@@ -2337,15 +2341,26 @@ int nfs_unlink(struct inode *dir, struct dentry *dent=
ry)
 		error =3D nfs_sillyrename(dir, dentry);
 		goto out;
 	}
-	if (!d_unhashed(dentry)) {
-		__d_drop(dentry);
-		need_rehash =3D 1;
+	/* We must prevent any concurrent open until the unlink
+	 * completes.  ->d_revalidate will wait for DCACHE_PAR_UPDATE
+	 * to clear, but if this happens to a non-parallel update, we
+	 * still want to block opens.  So set DCACHE_PAR_UPDATE
+	 * temporarily.
+	 */
+	if (!(dentry->d_flags & DCACHE_PAR_UPDATE)) {
+		/* Must have exclusive lock on parent */
+		did_set_par_update =3D true;
+		dentry->d_flags |=3D DCACHE_PAR_UPDATE;
 	}
+
 	spin_unlock(&dentry->d_lock);
 	error =3D nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	if (need_rehash)
-		d_rehash(dentry);
+	if (did_set_par_update) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &=3D ~DCACHE_PAR_UPDATE;
+		spin_unlock(&dentry->d_lock);
+	}
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a918c3a834b6..f7b58f216274 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -484,6 +484,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, stru=
ct nfs_fattr *fattr)
=20
 		/* We can't support update_atime(), since the server will reset it */
 		inode->i_flags |=3D S_NOATIME|S_NOCMTIME;
+		/* Parallel updates to directories are trivial */
+		inode->i_flags |=3D S_PAR_UPDATE;
 		inode->i_mode =3D fattr->mode;
 		nfsi->cache_validity =3D 0;
 		if ((fattr->valid & NFS_ATTR_FATTR_MODE) =3D=3D 0
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 5fa11e1aca4c..d4db67e82a01 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -453,6 +453,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	sdentry =3D NULL;
 	do {
 		int slen;
+		d_unlock_update(sdentry);
 		dput(sdentry);
 		sillycounter++;
 		slen =3D scnprintf(silly, sizeof(silly),
@@ -470,7 +471,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 		 */
 		if (IS_ERR(sdentry))
 			goto out;
-	} while (d_inode(sdentry) !=3D NULL); /* need negative lookup */
+	} while (!d_lock_update_nested(sdentry, NULL, NULL,
+				       SINGLE_DEPTH_NESTING));
=20
 	ihold(inode);
=20
@@ -515,6 +517,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	rpc_put_task(task);
 out_dput:
 	iput(inode);
+	d_unlock_update(sdentry);
 	dput(sdentry);
 out:
 	return error;
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
=20
 struct path;
 struct vfsmount;
@@ -96,6 +98,8 @@ struct dentry {
 	unsigned long d_time;		/* used by d_revalidate */
 	void *d_fsdata;			/* fs-specific data */
=20
+	/* lockdep tracking of DCACHE_PAR_UPDATE locks */
+	struct lockdep_map		d_update_map;
 	union {
 		struct list_head d_lru;		/* LRU list */
 		wait_queue_head_t *d_wait;	/* in-lookup ones only */
@@ -211,6 +215,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked=
 shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_PAR_UPDATE		0x80000000 /* Being created or unlinked with shar=
ed lock */
=20
 extern seqlock_t rename_lock;
=20
@@ -599,4 +604,26 @@ struct name_snapshot {
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
=20
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
+		dentry->d_flags &=3D ~DCACHE_PAR_UPDATE;
+		spin_unlock(&dentry->d_lock);
+		wake_up_var(&dentry->d_flags);
+	}
+}
+
 #endif	/* __LINUX_DCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..19f902d8d4dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2162,6 +2162,7 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cach=
efiles) */
+#define S_PAR_UPDATE	(1 << 18) /* Parallel directory operations supported */
=20
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
--=20
2.35.1

