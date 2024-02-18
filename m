Return-Path: <linux-fsdevel+bounces-11957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CF85985C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 18:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EF71F219DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8CF6EB77;
	Sun, 18 Feb 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdnCeXgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2A6D1AB
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278884; cv=none; b=tg4kl2KmKUYCa/LqC+6IFoXt1BLpxXyyEhb/LQGHAyhnQs5afn/CZV/IUs8IQ3SS/7zIg7tfEQ5q1tty992q90nUWyW5pIfNfvNwltBekQ+m5Qscor+fUIPRVLYkwX49ZFiF2XyUaeBdfq3TRW4daVGXHraWGgvJuzkfgjXRczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278884; c=relaxed/simple;
	bh=M5jww2/61W7r1ypyZ7QvU93Sm/UzHmZQhMGtg8OSj74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKuSsjXzAH63vsuVfWz20j99QHshCb5IXUhzVs+VEGfyfPzdcOEBqd5y48OOYxb/MvJrDxmxIr8yF7ZiWJnPYvT8i/t4KzBpOijxDbenkEJCgQr/hLw41EuoRpd4Nq9XNlSxkU6nfh8hWVRsUcNGZVk2rRRl8zrYqnakIoDpQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdnCeXgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ABAC433C7;
	Sun, 18 Feb 2024 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708278884;
	bh=M5jww2/61W7r1ypyZ7QvU93Sm/UzHmZQhMGtg8OSj74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdnCeXgpcClDJ9VMvLWdiGt798kWNFA0LbG59wL/vGK6/L1iPD8NdHImzV2dEBEYi
	 DPfTQ/EaNfbATOzu2C4q2TZHZ3wQaaQpfSz+F6SBbVcqo/IPomfO76gLtGIGMR0IRf
	 2Rf/l5+nF2l+ZIBs7oi1Q5HfmrZevTfMyTKPykrOQwVdfecVUf3Rxvy1y0ulHDCjwt
	 mJ1cSQdb8/FokLIo2QMMupes1H4FLAWDJuqnm5lKtZIxWf6/c3Iu1N+3c5Hi+FyEjZ
	 w5336rIxiZj2D+TEQBoSiDRpcUMrJQrmVU5WHJCVN/qdeRZKs+nAEOkx7M7S1xzsq4
	 Jyk0ObMZO927w==
Date: Sun, 18 Feb 2024 18:54:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner>
References: <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
 <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
 <20240218-anomalie-hissen-295c5228d16b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hsyok4z45phifsuu"
Content-Disposition: inline
In-Reply-To: <20240218-anomalie-hissen-295c5228d16b@brauner>


--hsyok4z45phifsuu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sun, Feb 18, 2024 at 12:33:41PM +0100, Christian Brauner wrote:
> On Sun, Feb 18, 2024 at 12:15:02PM +0100, Christian Brauner wrote:
> > On Sat, Feb 17, 2024 at 09:30:19AM -0800, Linus Torvalds wrote:
> > > On Sat, 17 Feb 2024 at 06:00, Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > But I have a really stupid (I know nothing about vfs) question, why do we
> > > > need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
> > > > can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?
> > > >
> > > > IIUC, if this pid is freed and then another "struct pid" has the same address
> > > > we can rely on __wait_on_freeing_inode() ?
> > > 
> > > Heh. Maybe it would work, but we really don't want to expose core
> > > kernel pointers to user space as the inode number.
> > 
> > And then also the property that the inode number is unique for the
> > system lifetime is extremely useful for userspace and I would like to
> > retain that property.
> > 
> > > 
> > > So then we'd have to add extra hackery to that (ie we'd have to
> > > intercept stat calls, and we'd have to have something else for
> > > ->d_dname() etc..).
> > > 
> > > Those are all things that the VFS does support, but ...
> > > 
> > > So I do prefer Christian's new approach, although some of it ends up
> > > being a bit unclear.
> > > 
> > > Christian, can you explain why this:
> > > 
> > >         spin_lock(&alias->d_lock);
> > >         dget_dlock(alias);
> > >         spin_unlock(&alias->d_lock);
> > > 
> > > instead of just 'dget()'?
> > 
> > No reason other than I forgot to switch to dget().
> > 
> > > 
> > > Also, while I found the old __ns_get_path() to be fairly disgusting, I
> > > actually think it's simpler and clearer than playing around with the
> > > dentry alias list. So my expectation on code sharing was that you'd
> > 
> > It's overall probably also cheaper, I think.
> > 
> > > basically lift the old __ns_get_path(), make *that* the helper, and
> > > just pass it an argument that is the pointer to the filesystem
> > > "stashed" entry...
> > > 
> > > And yes, using "atomic_long_t" for stashed is a crime against
> > > humanity. It's also entirely pointless. There are no actual atomic
> > > operations that the code wants except for reading and writing (aka
> > > READ_ONCE() and WRITE_ONCE()) and cmpxchg (aka just cmpxchg()). Using
> > > "atomic_long_t" buys the code nothing, and only makes things more
> > > complicated and requires crazy casts.
> > 
> > Yup, I had that as a draft and that introduced struct ino_stash which
> > contained a dentry pointer and the inode number using cmpxchg(). But I
> > decided against this because ns_common.h would require to have access to
> > ino_stash definition so we wouldn't just able to hide it in internal.h
> > where it should belong.
> 
> Right, I remember. The annoying thing will be how to cleanly handle this
> without having to pass too many parameters because we need d_fsdata, the
> vfsmount, and the inode->i_fop. So let me see if I can get this to
> something that doesn't look too ugly.

So, I'm running out of time today so I'm appending the draft I jotted
down now (untested).
Roughly, here's what I think would work for both nsfs and pidfs (I got
the hint and will rename from pidfdfs ;)). The thing that makes it a bit
tricky is that we need to indicate to the caller whether we've reused a
stashed or added a new inode/dentry so the caller can put the reference
to the object it took for i_private in case we reused a dentry/inode. On
EAGAIN i_private is property of the fs and will be cleaned up in
->evict(). Alternative is a callback for getting a reference which I
think is also ugly. Better suggestions welcome of course.

--hsyok4z45phifsuu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-RFC-UNTESTED-LIKELY-STILL-BROKEN-internal-add-path_f.patch"

From 281553f0059a889476dba5f4460570ea08ceefe5 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 18 Feb 2024 14:50:13 +0100
Subject: [PATCH 1/3] [RFC UNTESTED LIKELY STILL BROKEN] internal: add
 path_from_stashed()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h |  3 ++
 fs/libfs.c    | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index b67406435fc0..cfddaec6fbf6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -310,3 +310,6 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
+int path_from_stashed(struct dentry **stashed, unsigned long ino,
+		      struct vfsmount *mnt, const struct file_operations *fops,
+		      void *data, struct path *path);
diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..af46a83cd476 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1973,3 +1973,81 @@ struct timespec64 simple_inode_init_ts(struct inode *inode)
 	return ts;
 }
 EXPORT_SYMBOL(simple_inode_init_ts);
+
+static inline struct dentry *get_stashed_dentry(struct dentry *stashed)
+{
+	struct dentry *dentry;
+
+	rcu_read_lock();
+	dentry = READ_ONCE(stashed);
+	if (!dentry || !lockref_get_not_dead(&dentry->d_lockref))
+		dentry = NULL;
+	rcu_read_unlock();
+	return dentry;
+}
+
+static struct dentry *stash_dentry(struct dentry **stashed, unsigned long ino,
+				   struct super_block *sb,
+				   const struct file_operations *fops,
+				   void *data)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = d_alloc_anon(sb);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+
+	inode = new_inode_pseudo(sb);
+	if (!inode) {
+		dput(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	inode->i_ino = ino;
+	inode->i_flags |= S_IMMUTABLE;
+	inode->i_mode = S_IFREG | S_IRUGO;
+	inode->i_fop = fops;
+	inode->i_private = data;
+	simple_inode_init_ts(inode);
+
+	/* @data is now owned by the fs */
+	d_instantiate(dentry, inode);
+
+	if (cmpxchg(stashed, NULL, dentry)) {
+		d_delete(dentry); /* make sure ->d_prune() does nothing */
+		dput(dentry);
+		cpu_relax();
+		return ERR_PTR(-EAGAIN);
+	}
+
+	return dentry;
+}
+
+/*
+ * Try to retrieve stashed dentry or allocate a new one. Indicate to the caller
+ * whether we reused an existing one by returning 0 or when we added a new one
+ * by returning 1. This allows the caller to put any references. Alternative is
+ * a callback which is ugly.
+ */
+int path_from_stashed(struct dentry **stashed, unsigned long ino,
+		      struct vfsmount *mnt, const struct file_operations *fops,
+		      void *data, struct path *path)
+{
+	struct dentry *dentry;
+	int ret = 0;
+
+	dentry = get_stashed_dentry(*stashed);
+	if (dentry)
+		goto out_path;
+
+	dentry = stash_dentry(stashed, ino, mnt->mnt_sb, fops, data);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	ret = 1;
+
+out_path:
+	path->dentry = dentry;
+	path->mnt = mntget(mnt);
+	return ret;
+}
-- 
2.43.0


--hsyok4z45phifsuu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-RFC-UNTESTED-LIKELY-STILL-BROKEN-nsfs-convert-to-pat.patch"

From ecf6c69f62a3b96926d1a4bb5f43dc18d6a60b0a Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 18 Feb 2024 14:51:23 +0100
Subject: [PATCH 2/3] [RFC UNTESTED LIKELY STILL BROKEN] nsfs: convert to
 path_from_stashed() helper

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 | 70 +++++++++------------------------------
 include/linux/ns_common.h |  2 +-
 include/linux/proc_ns.h   |  2 +-
 3 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 34e1e3e36733..31d02fb6cb2e 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -38,7 +38,7 @@ static void ns_prune_dentry(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	if (inode) {
 		struct ns_common *ns = inode->i_private;
-		atomic_long_set(&ns->stashed, 0);
+		WRITE_ONCE(ns->stashed, NULL);
 	}
 }
 
@@ -56,54 +56,6 @@ static void nsfs_evict(struct inode *inode)
 	ns->ops->put(ns);
 }
 
-static int __ns_get_path(struct path *path, struct ns_common *ns)
-{
-	struct vfsmount *mnt = nsfs_mnt;
-	struct dentry *dentry;
-	struct inode *inode;
-	unsigned long d;
-
-	rcu_read_lock();
-	d = atomic_long_read(&ns->stashed);
-	if (!d)
-		goto slow;
-	dentry = (struct dentry *)d;
-	if (!lockref_get_not_dead(&dentry->d_lockref))
-		goto slow;
-	rcu_read_unlock();
-	ns->ops->put(ns);
-got_it:
-	path->mnt = mntget(mnt);
-	path->dentry = dentry;
-	return 0;
-slow:
-	rcu_read_unlock();
-	inode = new_inode_pseudo(mnt->mnt_sb);
-	if (!inode) {
-		ns->ops->put(ns);
-		return -ENOMEM;
-	}
-	inode->i_ino = ns->inum;
-	simple_inode_init_ts(inode);
-	inode->i_flags |= S_IMMUTABLE;
-	inode->i_mode = S_IFREG | S_IRUGO;
-	inode->i_fop = &ns_file_operations;
-	inode->i_private = ns;
-
-	dentry = d_make_root(inode);	/* not the normal use, but... */
-	if (!dentry)
-		return -ENOMEM;
-	dentry->d_fsdata = (void *)ns->ops;
-	d = atomic_long_cmpxchg(&ns->stashed, 0, (unsigned long)dentry);
-	if (d) {
-		d_delete(dentry);	/* make sure ->d_prune() does nothing */
-		dput(dentry);
-		cpu_relax();
-		return -EAGAIN;
-	}
-	goto got_it;
-}
-
 int ns_get_path_cb(struct path *path, ns_get_path_helper_t *ns_get_cb,
 		     void *private_data)
 {
@@ -113,10 +65,16 @@ int ns_get_path_cb(struct path *path, ns_get_path_helper_t *ns_get_cb,
 		struct ns_common *ns = ns_get_cb(private_data);
 		if (!ns)
 			return -ENOENT;
-		ret = __ns_get_path(path, ns);
+		ret = path_from_stashed(&ns->stashed, ns->inum, nsfs_mnt,
+					&ns_file_operations, ns, path);
+		if (!ret || ret != -EAGAIN)
+			ns->ops->put(ns);
 	} while (ret == -EAGAIN);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 struct ns_get_path_task_args {
@@ -163,10 +121,13 @@ int open_related_ns(struct ns_common *ns,
 			return PTR_ERR(relative);
 		}
 
-		err = __ns_get_path(&path, relative);
+		err = path_from_stashed(&ns->stashed, ns->inum, nsfs_mnt,
+					&ns_file_operations, ns, &path);
+		if (!err || err != -EAGAIN)
+			ns->ops->put(ns);
 	} while (err == -EAGAIN);
 
-	if (err) {
+	if (err < 0) {
 		put_unused_fd(fd);
 		return err;
 	}
@@ -249,7 +210,8 @@ bool ns_match(const struct ns_common *ns, dev_t dev, ino_t ino)
 static int nsfs_show_path(struct seq_file *seq, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	const struct proc_ns_operations *ns_ops = dentry->d_fsdata;
+	const struct ns_common *ns = inode->i_private;
+	const struct proc_ns_operations *ns_ops = ns->ops;
 
 	seq_printf(seq, "%s:[%lu]", ns_ops->name, inode->i_ino);
 	return 0;
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..7d22ea50b098 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -7,7 +7,7 @@
 struct proc_ns_operations;
 
 struct ns_common {
-	atomic_long_t stashed;
+	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
 	refcount_t count;
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 49539bc416ce..5ea470eb4d76 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -66,7 +66,7 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 static inline int ns_alloc_inum(struct ns_common *ns)
 {
-	atomic_long_set(&ns->stashed, 0);
+	WRITE_ONCE(ns->stashed, NULL);
 	return proc_alloc_inum(&ns->inum);
 }
 
-- 
2.43.0


--hsyok4z45phifsuu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-RFC-UNTESTED-LIKELY-STILL-BROKEN-pidfds-convert-to-p.patch"

From 9bd2f66776f06621ae4a71d511615272971ef293 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 18 Feb 2024 14:52:24 +0100
Subject: [PATCH 3/3] [RFC UNTESTED LIKELY STILL BROKEN] pidfds: convert to
 path_from_stashed() helper

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfdfs.c        | 43 ++++++++++++++++++++++++++-----------------
 include/linux/pid.h |  1 +
 kernel/pid.c        |  1 +
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/fs/pidfdfs.c b/fs/pidfdfs.c
index be4e74cec8b9..3e1204553ef2 100644
--- a/fs/pidfdfs.c
+++ b/fs/pidfdfs.c
@@ -14,6 +14,8 @@
 #include <linux/seq_file.h>
 #include <uapi/linux/pidfd.h>
 
+#include "internal.h"
+
 struct pid *pidfd_pid(const struct file *file)
 {
 	if (file->f_op != &pidfd_fops)
@@ -161,9 +163,21 @@ static char *pidfdfs_dname(struct dentry *dentry, char *buffer, int buflen)
 			     d_inode(dentry)->i_ino);
 }
 
+static void pidfdfs_prune_dentry(struct dentry *dentry)
+{
+	struct inode *inode;
+
+	inode = d_inode(dentry);
+	if (inode) {
+		struct pid *pid = inode->i_private;
+		WRITE_ONCE(pid->stashed, NULL);
+	}
+}
+
 const struct dentry_operations pidfdfs_dentry_operations = {
 	.d_delete	= always_delete_dentry,
 	.d_dname	= pidfdfs_dname,
+	.d_prune	= pidfdfs_prune_dentry,
 };
 
 static int pidfdfs_init_fs_context(struct fs_context *fc)
@@ -188,27 +202,22 @@ static struct file_system_type pidfdfs_type = {
 struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
 {
 
-	struct inode *inode;
 	struct file *pidfd_file;
+	struct path path;
+	int ret;
 
-	inode = iget_locked(pidfdfs_sb, pid->ino);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
-
-	if (inode->i_state & I_NEW) {
-		inode->i_ino = pid->ino;
-		inode->i_mode = S_IFREG | S_IRUGO;
-		inode->i_fop = &pidfd_fops;
-		inode->i_flags |= S_IMMUTABLE;
-		inode->i_private = get_pid(pid);
-		simple_inode_init_ts(inode);
-		unlock_new_inode(inode);
-	}
+	do {
+		ret = path_from_stashed(&pid->stashed, pid->ino, pidfdfs_mnt,
+					&pidfd_fops, pid, &path);
+	} while (ret == -EAGAIN);
 
-	pidfd_file = alloc_file_pseudo(inode, pidfdfs_mnt, "", flags, &pidfd_fops);
-	if (IS_ERR(pidfd_file))
-		iput(inode);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
+	if (ret)
+		get_pid(pid);
+	pidfd_file = dentry_open(&path, flags, current_cred());
+	path_put(&path);
 	return pidfd_file;
 }
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 7b6f5deab36a..3d1e817a809f 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -56,6 +56,7 @@ struct pid
 	unsigned int level;
 	spinlock_t lock;
 #ifdef CONFIG_FS_PIDFD
+	struct dentry *stashed;
 	unsigned long ino;
 #endif
 	/* lists of tasks that use this pid */
diff --git a/kernel/pid.c b/kernel/pid.c
index 2c0a9e8f58e2..f2f418ecf232 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -277,6 +277,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
 #ifdef CONFIG_FS_PIDFD
+	pid->stashed = NULL;
 	pid->ino = ++pidfdfs_ino;
 #endif
 	for ( ; upid >= pid->numbers; --upid) {
-- 
2.43.0


--hsyok4z45phifsuu--

