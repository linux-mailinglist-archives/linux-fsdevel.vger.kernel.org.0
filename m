Return-Path: <linux-fsdevel+bounces-36713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9C9E8817
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 22:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BC916438F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF71925AC;
	Sun,  8 Dec 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVgt8TxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAF381AF
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693176; cv=none; b=LEntp/zAMjGBzE5WNsl4YrQP/nDi7ESId7prytqdkoVeOJFaW1oWPdPNkslveFR5zffjNKa3yJDO2wUcbtMcN3p8+RsV1Hsr47m7Ab2nNKdK85s3yom9NUAma5THsTxqq+Aa0FNdfl3DfmYNSQimAIT8hHqDMZsgMNudremXIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693176; c=relaxed/simple;
	bh=U4ENVuIkqhCBrwMs//m7uVCpAgUN0SOzTfnLOFOd6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7yKThcHbgqs5FDLRTrzU/G6uA2roUlt0aC+nE8FvC+QbnAhJvXw8OPLCVv/FsXlWQE9oR0E2BKxahI2/DC736yD/zVpovpAuo6GnFHs5Ewv95DpKB7EBGXDMm6kCszVByzCjSE8Gv6QQOCcOqwRu6xq/61VEmSby482DLUR8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVgt8TxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE50C4CED2;
	Sun,  8 Dec 2024 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733693175;
	bh=U4ENVuIkqhCBrwMs//m7uVCpAgUN0SOzTfnLOFOd6KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVgt8TxPNiMcExfAIvbtBPOZ5x6ZmxsuuDTUJYuGPAQRc2MYB2ZGo4VIyQektQ9gj
	 SHGFgARhRMPGctE+/lSzpMIx1qR2SsXPr4stAFD1Hef9/Xrozd50x/8Nqj/djwOa6K
	 fLChHQWT5TE8vixQRSxH7W7jyhbOGnxiG06ojRq5dL0En3+dCJG9/hTiB7x0j8mpU7
	 JnVfVkw6KfCNdoWXMuBW7N0YNv5gDK50o2X4kDC+uYcqkZc8+tG7Jy8vu300G3atZo
	 cosSQy5U5B+pgtuX5tgBM7vOUqqSoN4jBlBLMJsN1zMcNU2Ut1Cv3rBHWpqkLYxTUF
	 xPVxSXUfTni7A==
Date: Sun, 8 Dec 2024 22:26:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241207-zucken-bogen-7a3d015af168@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6hxvbdaktho2xkgy"
Content-Disposition: inline
In-Reply-To: <20241206151154.60538-1-mszeredi@redhat.com>


--6hxvbdaktho2xkgy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Dec 06, 2024 at 04:11:52PM +0100, Miklos Szeredi wrote:
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
> 
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
> 
> If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> FAN_MNT_DETACH).
> 
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
> these fields identifying the affected mounts:
> 
>   __u64 mnt_id    - the ID of the mount (see statmount(2))
> 
> FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
> and no other type of event can be received with this report type.
> 
> Marks are added with FAN_MARK_MNTNS, which records the mount namespace
> belonging to the supplied path.
> 
> Prior to this patch mount namespace changes could be monitored by polling
> /proc/self/mountinfo, which did not convey any information about what
> changed.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

I think we should be able to move most of the notifications for umount
out of the namespace semaphore. I've mentioned that in my other mail.

The corner cases are connected and reparented mounts. Such mounts are
created during umount. Since such mounts are still subject to change by
other code notifications for them must be generated with the namespace
semaphore held.

In contrast mounts that end up on @unmounted can't change anymore and
thus notifying for them after giving up the namespace semaphore is fine.

So connected and reparented mounts go on one notification list and
properly unmounted mounts end up on another.

And even though connected and reparented mounts need to register
notifications under the namespace semaphore it should be possible to
downgrade the namespace semaphore from a write to a read lock when
generation the notifications.

And the same namespace semaphore downgrade from write to read lock can
be done for adding mounts as well if we make it so that we generate
notifications for adding mounts in the same location as umount
notifications in namespace_unlock().

I wanted to see how feasible this would be and so I've added my changes
on top of your patch. Please see the appended UNTESTED DIFF.

A few other comments below.

> +static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt, struct list_head *notif)
> +{
> +	__mnt_add_to_ns(ns, mnt);
> +	queue_notify(ns, mnt, notif);

All but one call to mnt_add_to_ns() passes NULL. I would just add a
mnt_add_to_ns_notify() helper and leave all the other callers as is.

>  void dissolve_on_fput(struct vfsmount *mnt)
>  {
>  	struct mnt_namespace *ns;
> +	LIST_HEAD(notif);
> +
>  	namespace_lock();
>  	lock_mount_hash();
>  	ns = real_mount(mnt)->mnt_ns;
>  	if (ns) {
>  		if (is_anon_ns(ns))
> -			umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +			umount_tree(real_mount(mnt), &notif, UMOUNT_CONNECTED);

This shouldn't notify as it's currently impossible to place mark on an
anonymous mount.

> @@ -1855,8 +1906,18 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		mnt = path.mnt;
>  		if (mark_type == FAN_MARK_MOUNT)
>  			obj = mnt;
> -		else
> +		else if (mark_type == FAN_MARK_FILESYSTEM)
>  			obj = mnt->mnt_sb;
> +		else /* if (mark_type == FAN_MARK_MNTNS) */ {
> +			mntns = get_ns_from_mnt(mnt);

I would prefer to be strict here and require that an actual mount
namespace file descriptor is passed instead of allowing the mount
namespace to be derived from any file descriptor.

(A possible future extension would be to allow passing a mount namespace id.)

> +			ret = -EINVAL;
> +			if (!mntns)
> +				goto path_put_and_out;
> +			/* don't allow anon ns yet */
> +			if (is_anon_ns(mntns))
> +				goto path_put_and_out;

Watching an anoymous mount namespace doesn't yet make sense because you
currently cannot add or remove mounts in them apart from closing the
file descriptor and destroying the whole mount namespace. I just
remember that I have a pending patch series related to this comment. I
haven't had the time to finish it with tests yet though maybe I can find
a few days in December to finish the tests...

> @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
>  			mp = parent->mnt_mp;
>  			parent = parent->mnt_parent;
>  		}
> -		if (parent != mnt->mnt_parent)
> +		if (parent != mnt->mnt_parent) {
> +			/* FIXME: does this need to trigger a MOVE fsnotify event */
>  			mnt_change_mountpoint(parent, mp, mnt);

This is what I mentally always referred to as "rug-pulling umount
propagation". So basically for the case where we have a locked mount
(stuff that was overmounted when the mntns was created) or a mount with
children that aren't going/can't be unmounted. In both cases it's
necessary to reparent the mount.

The watcher will see a umount event for the parent of that mount but
that's not enough information because the watcher could end up infering
that all child mounts of the mount have vanished as well which is
obviously not the case.

So I think that we need to generate a FS_MNT_MOVE event for mounts that
got reparented.

--6hxvbdaktho2xkgy
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="patch.diff"

diff --git a/fs/mount.h b/fs/mount.h
index a79232a8c908..5b8cc66c7325 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,8 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct list_head umount_connected_notify;
+
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -178,3 +180,13 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
+
+static inline void queue_notify(struct mnt_namespace *ns, struct mount *m,
+				struct list_head *notif)
+{
+	/* Optimize the case where there are no watches */
+	if (ns->n_fsnotify_marks)
+		list_add_tail(&m->to_notify, notif);
+	else
+		m->prev_ns = m->mnt_ns;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index b376570544a7..06820b103a0a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -79,6 +79,9 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+struct list_head umount_connected_notify = LIST_HEAD_INIT(umount_connected_notify);
+static LIST_HEAD(umount_notify); /* protected by namespace_sem */
+static LIST_HEAD(mount_notify);  /* protected by namespace_sem */
 static DEFINE_RWLOCK(mnt_ns_tree_lock);
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 
@@ -1120,16 +1123,7 @@ static inline struct mount *node_to_mount(struct rb_node *node)
 	return node ? rb_entry(node, struct mount, mnt_node) : NULL;
 }
 
-static void queue_notify(struct mnt_namespace *ns, struct mount *m, struct list_head *notif)
-{
-	/* Optimize the case where there are no watches */
-	if (ns->n_fsnotify_marks)
-		list_add_tail(&m->to_notify, notif);
-	else
-		m->prev_ns = m->mnt_ns;
-}
-
-static void __mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
+static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 {
 	struct rb_node **link = &ns->mounts.rb_node;
 	struct rb_node *parent = NULL;
@@ -1148,37 +1142,31 @@ static void __mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_ONRB;
 }
 
-static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt, struct list_head *notif)
+static void mnt_add_to_ns_notify(struct mnt_namespace *ns, struct mount *mnt)
 {
-	__mnt_add_to_ns(ns, mnt);
-	queue_notify(ns, mnt, notif);
+	mnt_add_to_ns(ns, mnt);
+	queue_notify(ns, mnt, &mount_notify);
 }
 
-static void notify_mounts(struct list_head *head)
+static void notify_mount(struct mount *p)
 {
-	struct mount *p;
-
-	while (!list_empty(head)) {
-		p = list_first_entry(head, struct mount, to_notify);
-		if (!p->prev_ns && p->mnt_ns) {
-			fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
-		} else if (p->prev_ns && !p->mnt_ns) {
-			fsnotify_mnt_detach(p->prev_ns, &p->mnt);
-		} else if (p->prev_ns == p->mnt_ns) {
-			fsnotify_mnt_move(p->mnt_ns, &p->mnt);
-		} else	{
-			fsnotify_mnt_detach(p->prev_ns, &p->mnt);
-			fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
-		}
-		p->prev_ns = p->mnt_ns;
-		list_del_init(&p->to_notify);
+	if (!p->prev_ns && p->mnt_ns) {
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	} else if (p->prev_ns && !p->mnt_ns) {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+	} else if (p->prev_ns == p->mnt_ns) {
+		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
+	} else {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
 	}
+	p->prev_ns = p->mnt_ns;
 }
 
 /*
  * vfsmount lock must be held for write
  */
-static void commit_tree(struct mount *mnt, struct list_head *notif)
+static void commit_tree(struct mount *mnt)
 {
 	struct mount *parent = mnt->mnt_parent;
 	struct mount *m;
@@ -1192,7 +1180,7 @@ static void commit_tree(struct mount *mnt, struct list_head *notif)
 		m = list_first_entry(&head, typeof(*m), mnt_list);
 		list_del(&m->mnt_list);
 
-		mnt_add_to_ns(n, m, notif);
+		mnt_add_to_ns_notify(n, m);
 	}
 	n->nr_mounts += n->pending_mounts;
 	n->pending_mounts = 0;
@@ -1724,21 +1712,61 @@ static void namespace_unlock(void)
 {
 	struct hlist_head head;
 	struct hlist_node *p;
-	struct mount *m;
+	struct mount *m, *tmp;
 	LIST_HEAD(list);
+	LIST_HEAD(notif_umounts);
+	bool notify = !list_empty(&umount_connected_notify) ||
+		      !list_empty(&mount_notify);
 
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
+	list_splice_init(&umount_notify, &notif_umounts);
+
+	/*
+	 * No point blocking out concurrent readers while notifications
+	 * are sent. This will also allow statmount()/listmount() to run
+	 * concurrently.
+	 */
+	if (unlikely(notify))
+		downgrade_write(&namespace_sem);
+
+	/* Notify about mounts that were added. */
+	list_for_each_entry_safe(m, tmp, &mount_notify, to_notify) {
+		notify_mount(m);
+		list_del_init(&m->to_notify);
+	}
 
-	up_write(&namespace_sem);
+	/*
+	 * Notify mounts that remain connected to a parent mount. These
+	 * need to be notified with @namespace_sem held.
+	 */
+	list_for_each_entry_safe(m, tmp, &umount_connected_notify, to_notify) {
+		notify_mount(m);
+		list_del_init(&m->to_notify);
+	}
+
+	if (unlikely(notify))
+		up_read(&namespace_sem);
+	else
+		up_write(&namespace_sem);
 
 	shrink_dentry_list(&list);
 
+	/*
+	 * After notifications have been sent for connected mounts the
+	 * only mounts to send notifications to are a subset of
+	 * @unmounted.
+	 */
 	if (likely(hlist_empty(&head)))
 		return;
 
 	synchronize_rcu_expedited();
 
+	list_for_each_entry_safe(m, tmp, &notif_umounts, to_notify) {
+		notify_mount(m);
+		list_del_init(&m->to_notify);
+	}
+
 	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
 		hlist_del(&m->mnt_umount);
 		mntput(&m->mnt);
@@ -1754,6 +1782,7 @@ enum umount_tree_flags {
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
 	UMOUNT_CONNECTED = 4,
+	UMOUNT_NOTIFY = 8,
 };
 
 static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
@@ -1789,7 +1818,7 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
  * mount_lock must be held
  * namespace_sem must be held for write
  */
-static void umount_tree(struct mount *mnt, struct list_head *notif, enum umount_tree_flags how)
+static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 {
 	LIST_HEAD(tmp_list);
 	struct mount *p;
@@ -1822,12 +1851,11 @@ static void umount_tree(struct mount *mnt, struct list_head *notif, enum umount_
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
 		ns = p->mnt_ns;
-		p->mnt_ns = NULL;
 		if (ns) {
 			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
-			queue_notify(ns, p, notif);
 		}
+		p->mnt_ns = NULL;
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 
@@ -1844,10 +1872,16 @@ static void umount_tree(struct mount *mnt, struct list_head *notif, enum umount_
 		change_mnt_propagation(p, MS_PRIVATE);
 		if (disconnect)
 			hlist_add_head(&p->mnt_umount, &unmounted);
+		if ((how & UMOUNT_NOTIFY) && ns) {
+			if (disconnect)
+				queue_notify(ns, p, &umount_notify);
+			else
+				queue_notify(ns, p, &umount_connected_notify);
+		}
 	}
 }
 
-static void shrink_submounts(struct mount *mnt, struct list_head *notif);
+static void shrink_submounts(struct mount *mnt);
 
 static int do_umount_root(struct super_block *sb)
 {
@@ -1875,7 +1909,6 @@ static int do_umount_root(struct super_block *sb)
 static int do_umount(struct mount *mnt, int flags)
 {
 	struct super_block *sb = mnt->mnt.mnt_sb;
-	LIST_HEAD(notif);
 	int retval;
 
 	retval = security_sb_umount(&mnt->mnt, flags);
@@ -1953,21 +1986,20 @@ static int do_umount(struct mount *mnt, int flags)
 	if (flags & MNT_DETACH) {
 		if (mnt->mnt.mnt_flags & MNT_ONRB ||
 		    !list_empty(&mnt->mnt_list))
-			umount_tree(mnt, &notif, UMOUNT_PROPAGATE);
+			umount_tree(mnt, UMOUNT_PROPAGATE | UMOUNT_NOTIFY);
 		retval = 0;
 	} else {
-		shrink_submounts(mnt, &notif);
+		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
 			if (mnt->mnt.mnt_flags & MNT_ONRB ||
 			    !list_empty(&mnt->mnt_list))
-				umount_tree(mnt, &notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+				umount_tree(mnt, UMOUNT_PROPAGATE | UMOUNT_SYNC | UMOUNT_NOTIFY);
 			retval = 0;
 		}
 	}
 out:
 	unlock_mount_hash();
-	notify_mounts(&notif);
 	namespace_unlock();
 	return retval;
 }
@@ -1986,7 +2018,6 @@ void __detach_mounts(struct dentry *dentry)
 {
 	struct mountpoint *mp;
 	struct mount *mnt;
-	LIST_HEAD(notif);
 
 	namespace_lock();
 	lock_mount_hash();
@@ -2001,12 +2032,11 @@ void __detach_mounts(struct dentry *dentry)
 			umount_mnt(mnt);
 			hlist_add_head(&mnt->mnt_umount, &unmounted);
 		}
-		else umount_tree(mnt, &notif, UMOUNT_CONNECTED);
+		else umount_tree(mnt, UMOUNT_CONNECTED | UMOUNT_NOTIFY);
 	}
 	put_mountpoint(mp);
 out_unlock:
 	unlock_mount_hash();
-	notify_mounts(&notif);
 	namespace_unlock();
 }
 
@@ -2214,7 +2244,7 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 out:
 	if (res) {
 		lock_mount_hash();
-		umount_tree(res, NULL, UMOUNT_SYNC);
+		umount_tree(res, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
 	return dst_mnt;
@@ -2243,19 +2273,16 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 void dissolve_on_fput(struct vfsmount *mnt)
 {
 	struct mnt_namespace *ns;
-	LIST_HEAD(notif);
-
 	namespace_lock();
 	lock_mount_hash();
 	ns = real_mount(mnt)->mnt_ns;
 	if (ns) {
 		if (is_anon_ns(ns))
-			umount_tree(real_mount(mnt), &notif, UMOUNT_CONNECTED);
+			umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
 		else
 			ns = NULL;
 	}
 	unlock_mount_hash();
-	notify_mounts(&notif);
 	namespace_unlock();
 	if (ns)
 		free_mnt_ns(ns);
@@ -2263,13 +2290,10 @@ void dissolve_on_fput(struct vfsmount *mnt)
 
 void drop_collected_mounts(struct vfsmount *mnt)
 {
-	LIST_HEAD(notif);
-
 	namespace_lock();
 	lock_mount_hash();
-	umount_tree(real_mount(mnt), &notif,  0);
+	umount_tree(real_mount(mnt), UMOUNT_NOTIFY);
 	unlock_mount_hash();
-	notify_mounts(&notif);
 	namespace_unlock();
 }
 
@@ -2500,7 +2524,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
-	LIST_HEAD(notif);
 	struct mnt_namespace *ns = top_mnt->mnt_ns;
 	struct mountpoint *smp;
 	struct mount *child, *dest_mnt, *p;
@@ -2548,7 +2571,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
-		queue_notify(source_mnt->mnt_ns, source_mnt, &notif);
+		queue_notify(source_mnt->mnt_ns, source_mnt, &mount_notify);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -2563,7 +2586,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
 		else
 			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		commit_tree(source_mnt, &notif);
+		commit_tree(source_mnt);
 	}
 
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
@@ -2577,11 +2600,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
-		commit_tree(child, &notif);
+		commit_tree(child);
 	}
 	put_mountpoint(smp);
 	unlock_mount_hash();
-	notify_mounts(&notif);
 
 	return 0;
 
@@ -2589,7 +2611,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	while (!hlist_empty(&tree_list)) {
 		child = hlist_entry(tree_list.first, struct mount, mnt_hash);
 		child->mnt_parent->mnt_ns->pending_mounts = 0;
-		umount_tree(child, NULL, UMOUNT_SYNC);
+		umount_tree(child, UMOUNT_SYNC);
 	}
 	unlock_mount_hash();
 	cleanup_group_ids(source_mnt, NULL);
@@ -2839,7 +2861,7 @@ static int do_loopback(struct path *path, const char *old_name,
 	err = graft_tree(mnt, parent, mp);
 	if (err) {
 		lock_mount_hash();
-		umount_tree(mnt, NULL, UMOUNT_SYNC);
+		umount_tree(mnt, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
 out2:
@@ -2869,7 +2891,7 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 
 	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		mnt_add_to_ns(ns, p, NULL);
+		mnt_add_to_ns(ns, p);
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
@@ -3654,7 +3676,6 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 {
 	struct mount *mnt, *next;
 	LIST_HEAD(graveyard);
-	LIST_HEAD(notif);
 
 	if (list_empty(mounts))
 		return;
@@ -3677,10 +3698,9 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	while (!list_empty(&graveyard)) {
 		mnt = list_first_entry(&graveyard, struct mount, mnt_expire);
 		touch_mnt_namespace(mnt->mnt_ns);
-		umount_tree(mnt, &notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+		umount_tree(mnt, UMOUNT_PROPAGATE | UMOUNT_SYNC | UMOUNT_NOTIFY);
 	}
 	unlock_mount_hash();
-	notify_mounts(&notif);
 	namespace_unlock();
 }
 
@@ -3738,7 +3758,7 @@ static int select_submounts(struct mount *parent, struct list_head *graveyard)
  *
  * mount_lock must be held for write
  */
-static void shrink_submounts(struct mount *mnt, struct list_head *notif)
+static void shrink_submounts(struct mount *mnt)
 {
 	LIST_HEAD(graveyard);
 	struct mount *m;
@@ -3749,7 +3769,7 @@ static void shrink_submounts(struct mount *mnt, struct list_head *notif)
 			m = list_first_entry(&graveyard, struct mount,
 						mnt_expire);
 			touch_mnt_namespace(m->mnt_ns);
-			umount_tree(m, notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+			umount_tree(m, UMOUNT_PROPAGATE | UMOUNT_SYNC | UMOUNT_NOTIFY);
 		}
 	}
 }
@@ -4017,7 +4037,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	p = old;
 	q = new;
 	while (p) {
-		mnt_add_to_ns(new_ns, q, NULL);
+		mnt_add_to_ns(new_ns, q);
 		new_ns->nr_mounts++;
 		if (new_fs) {
 			if (&p->mnt == new_fs->root.mnt) {
@@ -4063,7 +4083,7 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 	}
 	ns->root = mnt;
 	ns->nr_mounts++;
-	mnt_add_to_ns(ns, mnt, NULL);
+	mnt_add_to_ns(ns, mnt);
 
 	err = vfs_path_lookup(m->mnt_root, m,
 			name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
@@ -4241,7 +4261,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	mnt = real_mount(newmount.mnt);
 	ns->root = mnt;
 	ns->nr_mounts = 1;
-	mnt_add_to_ns(ns, mnt, NULL);
+	mnt_add_to_ns(ns, mnt);
 	mntget(newmount.mnt);
 
 	/* Attach to an apparent O_PATH fd with a note that we need to unmount
@@ -5678,7 +5698,7 @@ static void __init init_mount_tree(void)
 	m = real_mount(mnt);
 	ns->root = m;
 	ns->nr_mounts = 1;
-	mnt_add_to_ns(ns, m, NULL);
+	mnt_add_to_ns(ns, m);
 	init_task.nsproxy->mnt_ns = ns;
 	get_mnt_ns(ns);
 
diff --git a/fs/pnode.c b/fs/pnode.c
index 203276b1e23f..00d7351c0c31 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -9,6 +9,7 @@
 #include <linux/mount.h>
 #include <linux/fs.h>
 #include <linux/nsproxy.h>
+#include <linux/fsnotify.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 #include "pnode.h"
@@ -550,8 +551,8 @@ static void restore_mounts(struct list_head *to_restore)
 			parent = parent->mnt_parent;
 		}
 		if (parent != mnt->mnt_parent) {
-			/* FIXME: does this need to trigger a MOVE fsnotify event */
 			mnt_change_mountpoint(parent, mp, mnt);
+			queue_notify(mnt->mnt_ns, mnt, &umount_connected_notify);
 		}
 	}
 }

--6hxvbdaktho2xkgy--

