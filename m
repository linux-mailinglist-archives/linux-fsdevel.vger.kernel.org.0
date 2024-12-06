Return-Path: <linux-fsdevel+bounces-36649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562F9E7503
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB78285CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71C2066EE;
	Fri,  6 Dec 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z75vERBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792FBA20
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500861; cv=none; b=j86LLz4ID5QiGHxu8kR8JE49VvGUiwmL5CbZNrGdTwPU+iwL9MmiedUjQBFm1KWhJdFCdwWZd5VPYNt9hoo4nuOWSt0ykskn5Bi/6Vj7BK5htNjYI/1425LGIp5Gat1yUmztD5xszV3hgR+Zjn8hqbqT77UYhs1AQ/zi2BARWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500861; c=relaxed/simple;
	bh=HSCGDWcaxbK6HOFBVo52qZ91vHfVIpAQLmjT+vBw4Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lek35Fu5iC6aA+NwN2F7EzqHw1g1f1qacvIDDBDAoVxcTcUxdjqyoGQitAC8bpi/83PE1y+23auPIhp+fw/V2c6NHHj6Kq9joAkn5OY05a/Q6usWli9mA+J+02rNmU1tEHME4AByQDrMA2QSCT5crtu44pve4HyVEJZ7wtJAw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z75vERBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B2EC4CED1;
	Fri,  6 Dec 2024 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733500860;
	bh=HSCGDWcaxbK6HOFBVo52qZ91vHfVIpAQLmjT+vBw4Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z75vERBbR2GG1Q79Pxa0ev06tRXisCFf8+eo+jxdYlraqUFxcz/J/C2NMzYvffevH
	 uoUEEHjIRbYtyWARsNe6eL2rK4qxLIz/tgkhhSyrxceIdis5sjdxL1LC6aVcryBIeS
	 KnVzUIBeS+N0MlMRcq5zejkHH6imkTLBASziAcfhIiV/lRJpdQUfXAV8jxQMzZNhrf
	 Cwzln3KQHPRs6XTW5/GlrTStk1cprewBKFX6tGAthbR8MUhPq0cLgtw8EJhyNKii3Z
	 zRfnoKC+vJbg6+2T6jVORY1J/2nrlfZnfKBRniH2O4aOc7uK1CvtR2dftDrAqf6kdY
	 8r3Cmo9rp/xNw==
Date: Fri, 6 Dec 2024 17:00:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206151154.60538-1-mszeredi@redhat.com>

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
>  fs/mount.h                         |  11 +++
>  fs/namespace.c                     | 120 ++++++++++++++++++++++-------
>  fs/notify/fanotify/fanotify.c      |  56 ++++++++++----
>  fs/notify/fanotify/fanotify.h      |  18 +++++
>  fs/notify/fanotify/fanotify_user.c |  70 ++++++++++++++++-
>  fs/notify/fdinfo.c                 |   2 +
>  fs/notify/fsnotify.c               |  44 +++++++++--
>  fs/notify/fsnotify.h               |  11 +++
>  fs/notify/mark.c                   |  14 +++-
>  fs/pnode.c                         |   4 +-
>  include/linux/fanotify.h           |  14 ++--
>  include/linux/fsnotify.h           |  20 +++++
>  include/linux/fsnotify_backend.h   |  40 +++++++++-
>  include/linux/mnt_namespace.h      |   5 ++
>  include/uapi/linux/fanotify.h      |  10 +++
>  security/selinux/hooks.c           |   4 +
>  16 files changed, 384 insertions(+), 59 deletions(-)
> 
> v2:
> 	- notify for whole namespace as this seems to be what people prefer
> 	- move fsnotify() calls outside of mount_lock
> 	- only report mnt_id, not parent_id
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 185fc56afc13..a79232a8c908 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -14,6 +14,10 @@ struct mnt_namespace {
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
> @@ -77,6 +81,13 @@ struct mount {
>  	int mnt_expiry_mark;		/* true if marked for expiry */
>  	struct hlist_head mnt_pins;
>  	struct hlist_head mnt_stuck_children;
> +
> +	/*
> +	 * for mount notification
> +	 * FIXME: maybe move to a union with some other fields?
> +	 */
> +	struct list_head to_notify; /* singly linked list? */
> +	struct mnt_namespace *prev_ns;
>  } __randomize_layout;
>  
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..b376570544a7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -139,12 +139,13 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
>  	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
>  }
>  
> -static void mnt_ns_release(struct mnt_namespace *ns)
> +void mnt_ns_release(struct mnt_namespace *ns)
>  {
>  	lockdep_assert_not_held(&mnt_ns_tree_lock);
>  
>  	/* keep alive for {list,stat}mount() */
>  	if (refcount_dec_and_test(&ns->passive)) {
> +		fsnotify_mntns_delete(ns);
>  		put_user_ns(ns->user_ns);
>  		kfree(ns);
>  	}
> @@ -1119,7 +1120,16 @@ static inline struct mount *node_to_mount(struct rb_node *node)
>  	return node ? rb_entry(node, struct mount, mnt_node) : NULL;
>  }
>  
> -static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
> +static void queue_notify(struct mnt_namespace *ns, struct mount *m, struct list_head *notif)
> +{
> +	/* Optimize the case where there are no watches */
> +	if (ns->n_fsnotify_marks)
> +		list_add_tail(&m->to_notify, notif);
> +	else
> +		m->prev_ns = m->mnt_ns;
> +}
> +
> +static void __mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
>  {
>  	struct rb_node **link = &ns->mounts.rb_node;
>  	struct rb_node *parent = NULL;
> @@ -1138,10 +1148,37 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
>  	mnt->mnt.mnt_flags |= MNT_ONRB;
>  }
>  
> +static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt, struct list_head *notif)
> +{
> +	__mnt_add_to_ns(ns, mnt);
> +	queue_notify(ns, mnt, notif);
> +}
> +
> +static void notify_mounts(struct list_head *head)
> +{
> +	struct mount *p;
> +
> +	while (!list_empty(head)) {
> +		p = list_first_entry(head, struct mount, to_notify);
> +		if (!p->prev_ns && p->mnt_ns) {
> +			fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +		} else if (p->prev_ns && !p->mnt_ns) {
> +			fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +		} else if (p->prev_ns == p->mnt_ns) {
> +			fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> +		} else	{
> +			fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +			fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +		}
> +		p->prev_ns = p->mnt_ns;
> +		list_del_init(&p->to_notify);
> +	}
> +}
> +
>  /*
>   * vfsmount lock must be held for write
>   */
> -static void commit_tree(struct mount *mnt)
> +static void commit_tree(struct mount *mnt, struct list_head *notif)
>  {
>  	struct mount *parent = mnt->mnt_parent;
>  	struct mount *m;
> @@ -1155,7 +1192,7 @@ static void commit_tree(struct mount *mnt)
>  		m = list_first_entry(&head, typeof(*m), mnt_list);
>  		list_del(&m->mnt_list);
>  
> -		mnt_add_to_ns(n, m);
> +		mnt_add_to_ns(n, m, notif);
>  	}
>  	n->nr_mounts += n->pending_mounts;
>  	n->pending_mounts = 0;
> @@ -1752,7 +1789,7 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
>   * mount_lock must be held
>   * namespace_sem must be held for write
>   */
> -static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
> +static void umount_tree(struct mount *mnt, struct list_head *notif, enum umount_tree_flags how)
>  {
>  	LIST_HEAD(tmp_list);
>  	struct mount *p;
> @@ -1785,11 +1822,12 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  		list_del_init(&p->mnt_expire);
>  		list_del_init(&p->mnt_list);
>  		ns = p->mnt_ns;
> +		p->mnt_ns = NULL;
>  		if (ns) {
>  			ns->nr_mounts--;
>  			__touch_mnt_namespace(ns);
> +			queue_notify(ns, p, notif);
>  		}
> -		p->mnt_ns = NULL;
>  		if (how & UMOUNT_SYNC)
>  			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
>  
> @@ -1809,7 +1847,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  	}
>  }
>  
> -static void shrink_submounts(struct mount *mnt);
> +static void shrink_submounts(struct mount *mnt, struct list_head *notif);
>  
>  static int do_umount_root(struct super_block *sb)
>  {
> @@ -1837,6 +1875,7 @@ static int do_umount_root(struct super_block *sb)
>  static int do_umount(struct mount *mnt, int flags)
>  {
>  	struct super_block *sb = mnt->mnt.mnt_sb;
> +	LIST_HEAD(notif);
>  	int retval;
>  
>  	retval = security_sb_umount(&mnt->mnt, flags);
> @@ -1914,20 +1953,21 @@ static int do_umount(struct mount *mnt, int flags)
>  	if (flags & MNT_DETACH) {
>  		if (mnt->mnt.mnt_flags & MNT_ONRB ||
>  		    !list_empty(&mnt->mnt_list))
> -			umount_tree(mnt, UMOUNT_PROPAGATE);
> +			umount_tree(mnt, &notif, UMOUNT_PROPAGATE);
>  		retval = 0;
>  	} else {
> -		shrink_submounts(mnt);
> +		shrink_submounts(mnt, &notif);
>  		retval = -EBUSY;
>  		if (!propagate_mount_busy(mnt, 2)) {
>  			if (mnt->mnt.mnt_flags & MNT_ONRB ||
>  			    !list_empty(&mnt->mnt_list))
> -				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> +				umount_tree(mnt, &notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
>  			retval = 0;
>  		}
>  	}
>  out:
>  	unlock_mount_hash();
> +	notify_mounts(&notif);
>  	namespace_unlock();
>  	return retval;
>  }
> @@ -1946,6 +1986,7 @@ void __detach_mounts(struct dentry *dentry)
>  {
>  	struct mountpoint *mp;
>  	struct mount *mnt;
> +	LIST_HEAD(notif);
>  
>  	namespace_lock();
>  	lock_mount_hash();
> @@ -1960,11 +2001,12 @@ void __detach_mounts(struct dentry *dentry)
>  			umount_mnt(mnt);
>  			hlist_add_head(&mnt->mnt_umount, &unmounted);
>  		}
> -		else umount_tree(mnt, UMOUNT_CONNECTED);
> +		else umount_tree(mnt, &notif, UMOUNT_CONNECTED);
>  	}
>  	put_mountpoint(mp);
>  out_unlock:
>  	unlock_mount_hash();
> +	notify_mounts(&notif);

For unmount we shouldn't need to do this under the namespace semaphore.
Instead we should be able to do this in namespace_unlock() after we've
given up the namespace semaphore and making the umount fsnotify
notification list global. So in the end you can then do sm like:

diff --git a/fs/namespace.c b/fs/namespace.c
index b376570544a7..70e67f1490eb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1733,6 +1733,7 @@ static void namespace_unlock(void)
        up_write(&namespace_sem);

        shrink_dentry_list(&list);
+       notify_mounts(&notif);

        if (likely(hlist_empty(&head)))
                return;

Maybe you can even use the @unmounted list for this directly.

I wonder if we can avoid doing the notifications for mount events
without calling copy_to_user() under the namespace semaphore as well.
Something we've so far managed to avoid and it would let us sleep
easier.

