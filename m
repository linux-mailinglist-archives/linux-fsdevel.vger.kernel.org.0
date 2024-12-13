Return-Path: <linux-fsdevel+bounces-37290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B39F0D95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3068C2840D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDFC1E0B70;
	Fri, 13 Dec 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRFCMACw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A525383
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097434; cv=none; b=nzuq5Jo+3RuKns4FSN3Oq5viuPV+B/t8cm2XwAAKg2ukNR9kAaVdw+ZToHk0QP1BBmpwlLHgfhShEcELp9eX8s/F99vGv8M1sxosX+nXuhSCAPxhyekKcVgleGbwzFlR8Wm4JBw8im4iPC7+hNBnzn9jsUsaGSaC92cC5Uii6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097434; c=relaxed/simple;
	bh=Nva6PeXaOYwIZH2FSMaesKo6TR1DWYxNm0AQ5/6d3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfAPaGhRbWdzfsQgIlTY4qIQn9T09+z7H0PsdYZ+dTevFiBAj/Gu2pU20FuCaDTNp96XW5dJfq3adB7DXZE/8awxd7K82bA+FnmTZzEV1uqJOo/x5jSYTOYoyMhtirQdE1PPjW2dncfm7kLWzCZIokXb1Hsvo+g0MgmeB9CQxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRFCMACw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A9C4CEE0;
	Fri, 13 Dec 2024 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097434;
	bh=Nva6PeXaOYwIZH2FSMaesKo6TR1DWYxNm0AQ5/6d3XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRFCMACwC4YMVAmhB/CU5ariuk7S1CgLbAD0ZZ+Hi1TttOOaA1OMXDyOeVILnIlKH
	 JI1ivBWIwc84xZd4VIwFXXyDx6H0Bb8EkWXeJx8EWet73xr/6jfmnk8pZXQhc/ppDo
	 MtZAszB0q9ntf2qpP2kKoftAjnyl7nDXn01V9LhCOVtoJwa2VQ7oJ+U1yna3rLo2SE
	 yHm9O1MhmM/70cTnNKWnTcCRB6eHtvz+OMPuOfGMpLyeqBH2lKlOGWvxhuI4UKiGkm
	 mdtov5GPceCw7bfOSVKfXd8f2Lrc0H8Yzh6E2hKteLs9xthqLT9EoVVhuLPPvfm6C/
	 Epsg9nETRrqDw==
Date: Fri, 13 Dec 2024 14:43:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
Message-ID: <20241213-international-schmuckvoll-f1a5c6075ac2@brauner>
References: <20241211153709.149603-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211153709.149603-1-mszeredi@redhat.com>

On Wed, Dec 11, 2024 at 04:37:08PM +0100, Miklos Szeredi wrote:
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

I think this starts to look nice and simple for the vfs bits.
A lot less violent if we had to reinvent all of the infrastructure.
Just a few comments.

> 
> v3:
> 
>   - use a global list protected for temporarily storing (Christian)
>   - move fsnotify_* calls to namespace_unlock() (Christian)
>   - downgrade namespace_sem to read for fsnotify_* calls (Christian)
>   - add notification for reparenting in propagate_umount (Christian)
>   - require nsfs file (/proc/PID/ns/mnt) in fanotify_mark(2) (Christian)
>   - cleaner check for fsnotify being initialized (Amir)
>   - fix stub __fsnotify_mntns_delete (kernel test robot)
>   - don't add FANOTIFY_MOUNT_EVENTS to FANOTIFY_FD_EVENTS (Amir)
> 
> v2:
>   - notify for whole namespace as this seems to be what people prefer
>   - move fsnotify() calls outside of mount_lock
>   - only report mnt_id, not parent_id
> 
>  fs/mount.h                         | 21 ++++++++++
>  fs/namespace.c                     | 62 ++++++++++++++++++++++++++---
>  fs/notify/fanotify/fanotify.c      | 37 +++++++++++++++--
>  fs/notify/fanotify/fanotify.h      | 18 +++++++++
>  fs/notify/fanotify/fanotify_user.c | 64 ++++++++++++++++++++++++++++--
>  fs/notify/fdinfo.c                 |  2 +
>  fs/notify/fsnotify.c               | 47 ++++++++++++++++++----
>  fs/notify/fsnotify.h               | 11 +++++
>  fs/notify/mark.c                   | 14 +++++--
>  fs/pnode.c                         |  4 +-
>  include/linux/fanotify.h           | 12 ++++--
>  include/linux/fsnotify.h           | 20 ++++++++++
>  include/linux/fsnotify_backend.h   | 40 ++++++++++++++++++-
>  include/linux/mnt_namespace.h      |  1 +
>  include/uapi/linux/fanotify.h      | 10 +++++
>  security/selinux/hooks.c           |  4 ++
>  16 files changed, 340 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 185fc56afc13..0ad68c90e7e2 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -5,6 +5,8 @@
>  #include <linux/ns_common.h>
>  #include <linux/fs_pin.h>
>  
> +extern struct list_head notify_list;
> +
>  struct mnt_namespace {
>  	struct ns_common	ns;
>  	struct mount *	root;
> @@ -14,6 +16,10 @@ struct mnt_namespace {
>  	u64			seq;	/* Sequence number to prevent loops */
>  	wait_queue_head_t poll;
>  	u64 event;
> +#ifdef CONFIG_FSNOTIFY
> +	__u32			n_fsnotify_mask;
> +	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
> +#endif
>  	unsigned int		nr_mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
>  	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> @@ -77,6 +83,9 @@ struct mount {
>  	int mnt_expiry_mark;		/* true if marked for expiry */
>  	struct hlist_head mnt_pins;
>  	struct hlist_head mnt_stuck_children;
> +
> +	struct list_head to_notify;	/* need to queue notification */
> +	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
>  } __randomize_layout;
>  
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
> @@ -167,3 +176,15 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
>  {
>  	return container_of(ns, struct mnt_namespace, ns);
>  }
> +
> +static inline void add_notify(struct mount *m)

Can we please name this mnt_add_notify() or mnt_notify_add()?

> +{
> +	/* Optimize the case where there are no watches */
> +	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
> +	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
> +		list_add_tail(&m->to_notify, &notify_list);
> +	else
> +		m->prev_ns = m->mnt_ns;
> +}
> +
> +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6eec7794f707..186f660abd60 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -79,6 +79,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>  static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> +LIST_HEAD(notify_list); /* protected by namespace_sem */
>  static DEFINE_RWLOCK(mnt_ns_tree_lock);
>  static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
>  
> @@ -145,6 +146,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  
>  	/* keep alive for {list,stat}mount() */
>  	if (refcount_dec_and_test(&ns->passive)) {
> +		fsnotify_mntns_delete(ns);
>  		put_user_ns(ns->user_ns);
>  		kfree(ns);
>  	}
> @@ -1136,6 +1138,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
>  	rb_link_node(&mnt->mnt_node, parent, link);
>  	rb_insert_color(&mnt->mnt_node, &ns->mounts);
>  	mnt->mnt.mnt_flags |= MNT_ONRB;
> +
> +	add_notify(mnt);
>  }
>  
>  /*
> @@ -1683,17 +1687,53 @@ int may_umount(struct vfsmount *mnt)
>  
>  EXPORT_SYMBOL(may_umount);
>  
> +static void notify_mount(struct mount *p)

Similarly this should please become mnt_notify(). Then we have a nice
symmetry:

mnt_notify_add()
mnt_notify()

> +{
> +	if (!p->prev_ns && p->mnt_ns) {
> +		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +	} else if (p->prev_ns && !p->mnt_ns) {
> +		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +	} else if (p->prev_ns == p->mnt_ns) {
> +		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> +	} else {
> +		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +	}
> +	p->prev_ns = p->mnt_ns;
> +}
> +
>  static void namespace_unlock(void)
>  {
>  	struct hlist_head head;
>  	struct hlist_node *p;
> -	struct mount *m;
> +	struct mount *m, *tmp;
>  	LIST_HEAD(list);
> +	bool notify = !list_empty(&notify_list);
>  
>  	hlist_move_list(&unmounted, &head);
>  	list_splice_init(&ex_mountpoints, &list);
>  
> -	up_write(&namespace_sem);
> +	/*
> +	 * No point blocking out concurrent readers while notifications are
> +	 * sent. This will also allow statmount()/listmount() to run
> +	 * concurrently.
> +	 */
> +	if (unlikely(notify))
> +		downgrade_write(&namespace_sem);
> +
> +	/*
> +	 * Notify about mounts that were added/reparented/remain connected after
> +	 * unmount.

This doesn't mention unmounted mounts in the comment. :)

> +	 */
> +	list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
> +		notify_mount(m);
> +		list_del_init(&m->to_notify);
> +	}
> +
> +	if (unlikely(notify))
> +		up_read(&namespace_sem);
> +	else
> +		up_write(&namespace_sem);
>  
>  	shrink_dentry_list(&list);
>  
> @@ -1806,6 +1846,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  		change_mnt_propagation(p, MS_PRIVATE);
>  		if (disconnect)
>  			hlist_add_head(&p->mnt_umount, &unmounted);
> +		add_notify(p);

So afaict, calling umount_tree() unconditionally is ok because:

(1) copy_tree() will leave mnt->mnt_ns NULL and mnt->prev_ns will be
   NULL and thus m->prev_ns will be NULL.
(2) fanotify will ignore anonymous mount namespaces even though
    dissolve_on_fput() will call umount_tree() and will end up
    registering all mounts that are umount if OPEN_TREE_CLONE |
    AT_RECURSIVE was done.

Imho, that is all mighty subtle. So please either makes this explicit by
adding the UMOUNT_NOTIFY flag that I had in my diff I sent as a reply to
v2 or please add detailed explanatory comments what guarantees and
assumptions are made by that function.

Thanks!
Christian

