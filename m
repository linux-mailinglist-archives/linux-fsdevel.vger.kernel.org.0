Return-Path: <linux-fsdevel+bounces-37289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C049F0D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E293283816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCDE1E009C;
	Fri, 13 Dec 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aStHeTHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFD4C8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095849; cv=none; b=EEPuk3onL5D/Kb6i9uSSmXP/9zX3+xf6HxbsQ9MBgJEZGSr5ygkW4o5p/Y1oKsX/eU9uveRpeS4FYK+GqLIIeF3NpywOAV1tyuJEh+dCCscEjuycUwb1dLm0SPkU8yP0gO/Z4MmedTGypCcAYt3EVpM0sbx0E+H0oiBI5uNq+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095849; c=relaxed/simple;
	bh=wsxEf/Q0Qz4WpjIE8AOQ6qKXEbVzM2UBv2WLbErdUbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQhUJf+QqUbYC14RjEhjuMPZ343LPsjaewBzFLIBv4IyodWSE1rZFKun1SgbdqJd16xs4aWzY0HPyFbPoiPzDN4Uz5WR3Dwy1NcPfTkbz4LJ+TKos4+d9CLoAczJOLEE5SzfW+5/xBacOD9D2Bu1Y6Iijqv46m19ZZ1+ndyeZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aStHeTHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB8AC4CED0;
	Fri, 13 Dec 2024 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095848;
	bh=wsxEf/Q0Qz4WpjIE8AOQ6qKXEbVzM2UBv2WLbErdUbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aStHeTHmP4eschhoB8V5xwBTWSUNWZ9/xc9sT11XdeE8F8vO2MoTPSvRs+S9wCuoj
	 i4+NWUkfopFh/Nfp0tonEx1Z1dmU9gRQAFiLbrO8bnydSU0ic6nCNCLUFen4SKvRQQ
	 fIKC2c+rKgYgJIQjYJf9eBG8C7/f6PCjv/hbwHsDcBzsSlZocOzWv1DGn9ERdKjiQp
	 BxU1VC1ikINeT1YDF1H39nC1M9AroXG3Im5zyWTMbIy25ViLr4Ys5uuTrv5Hl8Lpuk
	 zF9zYaWhbXb2iDYdmS3KWXJtcrkPaKyaaS7QdzY2F7NL96n0hK6Nbq+t17wl1weqHG
	 OvZ1ahx2FVuHw==
Date: Fri, 13 Dec 2024 14:17:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
Message-ID: <20241213-ergrauen-dreidimensional-f31d86d2c2d8@brauner>
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

This will have conflicts with changes I have queued for fs/namespace.c
and maybe this would also conflict with stuff you have in fanotify. So
we should probably split this up into a stable fanotify changes branch
that I can pull from you and the vfs changes I can then put on top.

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
>  	}
>  }
>  
> @@ -2103,16 +2144,24 @@ struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mntns, bool pre
>  	}
>  }
>  
> +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry)
> +{
> +	if (!is_mnt_ns_file(dentry))
> +		return NULL;
> +
> +	return to_mnt_ns(get_proc_ns(dentry->d_inode));
> +}
> +
>  static bool mnt_ns_loop(struct dentry *dentry)
>  {
>  	/* Could bind mounting the mount namespace inode cause a
>  	 * mount namespace loop?
>  	 */
> -	struct mnt_namespace *mnt_ns;
> -	if (!is_mnt_ns_file(dentry))
> +	struct mnt_namespace *mnt_ns = mnt_ns_from_dentry(dentry);
> +
> +	if (!mnt_ns)
>  		return false;
>  
> -	mnt_ns = to_mnt_ns(get_proc_ns(dentry->d_inode));
>  	return current->nsproxy->mnt_ns->seq >= mnt_ns->seq;
>  }
>  
> @@ -2505,6 +2554,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  			dest_mp = smp;
>  		unhash_mnt(source_mnt);
>  		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
> +		add_notify(source_mnt);
>  		touch_mnt_namespace(source_mnt->mnt_ns);
>  	} else {
>  		if (source_mnt->mnt_ns) {
> @@ -4420,6 +4470,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>  	list_del_init(&new_mnt->mnt_expire);
>  	put_mountpoint(root_mp);
>  	unlock_mount_hash();
> +	add_notify(root_mnt);
> +	add_notify(new_mnt);
>  	chroot_fs_refs(&root, &new);
>  	error = 0;
>  out4:
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 24c7c5df4998..a9dc004291bf 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>  	case FANOTIFY_EVENT_TYPE_FS_ERROR:
>  		return fanotify_error_event_equal(FANOTIFY_EE(old),
>  						  FANOTIFY_EE(new));
> +	case FANOTIFY_EVENT_TYPE_MNT:
> +		return false;
>  	default:
>  		WARN_ON_ONCE(1);
>  	}
> @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
>  		 __func__, iter_info->report_mask, event_mask, data, data_type);
>  
> -	if (!fid_mode) {
> +	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> +	{
> +		if (data_type != FSNOTIFY_EVENT_MNT)
> +			return 0;
> +	} else if (!fid_mode) {
>  		/* Do we have path to open a file descriptor? */
>  		if (!path)
>  			return 0;
> @@ -548,6 +554,20 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
>  	return &pevent->fae;
>  }
>  
> +static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t gfp)
> +{
> +	struct fanotify_mnt_event *pevent;
> +
> +	pevent = kmem_cache_alloc(fanotify_mnt_event_cachep, gfp);
> +	if (!pevent)
> +		return NULL;
> +
> +	pevent->fae.type = FANOTIFY_EVENT_TYPE_MNT;
> +	pevent->mnt_id = mnt_id;
> +
> +	return &pevent->fae;
> +}
> +
>  static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
>  							gfp_t gfp)
>  {
> @@ -715,6 +735,7 @@ static struct fanotify_event *fanotify_alloc_event(
>  					      fid_mode);
>  	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
>  	const struct path *path = fsnotify_data_path(data, data_type);
> +	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
>  	struct mem_cgroup *old_memcg;
>  	struct dentry *moved = NULL;
>  	struct inode *child = NULL;
> @@ -810,8 +831,10 @@ static struct fanotify_event *fanotify_alloc_event(
>  						  moved, &hash, gfp);
>  	} else if (fid_mode) {
>  		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
> -	} else {
> +	} else if (path) {
>  		event = fanotify_alloc_path_event(path, &hash, gfp);
> +	} else /* if (mnt_id) */ {
> +		event = fanotify_alloc_mnt_event(mnt_id, gfp);
>  	}
>  
>  	if (!event)
> @@ -910,7 +933,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);
> @@ -1011,6 +1034,11 @@ static void fanotify_free_error_event(struct fsnotify_group *group,
>  	mempool_free(fee, &group->fanotify_data.error_events_pool);
>  }
>  
> +static void fanotify_free_mnt_event(struct fanotify_event *event)
> +{
> +	kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
> +}
> +
>  static void fanotify_free_event(struct fsnotify_group *group,
>  				struct fsnotify_event *fsn_event)
>  {
> @@ -1037,6 +1065,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
>  	case FANOTIFY_EVENT_TYPE_FS_ERROR:
>  		fanotify_free_error_event(group, event);
>  		break;
> +	case FANOTIFY_EVENT_TYPE_MNT:
> +		fanotify_free_mnt_event(event);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  	}
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index e5ab33cae6a7..f1a7cbedc9e3 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -9,6 +9,7 @@ extern struct kmem_cache *fanotify_mark_cache;
>  extern struct kmem_cache *fanotify_fid_event_cachep;
>  extern struct kmem_cache *fanotify_path_event_cachep;
>  extern struct kmem_cache *fanotify_perm_event_cachep;
> +extern struct kmem_cache *fanotify_mnt_event_cachep;
>  
>  /* Possible states of the permission event */
>  enum {
> @@ -244,6 +245,7 @@ enum fanotify_event_type {
>  	FANOTIFY_EVENT_TYPE_PATH_PERM,
>  	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
>  	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
> +	FANOTIFY_EVENT_TYPE_MNT,
>  	__FANOTIFY_EVENT_TYPE_NUM
>  };
>  
> @@ -409,12 +411,23 @@ struct fanotify_path_event {
>  	struct path path;
>  };
>  
> +struct fanotify_mnt_event {
> +	struct fanotify_event fae;
> +	u64 mnt_id;
> +};
> +
>  static inline struct fanotify_path_event *
>  FANOTIFY_PE(struct fanotify_event *event)
>  {
>  	return container_of(event, struct fanotify_path_event, fae);
>  }
>  
> +static inline struct fanotify_mnt_event *
> +FANOTIFY_ME(struct fanotify_event *event)
> +{
> +	return container_of(event, struct fanotify_mnt_event, fae);
> +}
> +
>  /*
>   * Structure for permission fanotify events. It gets allocated and freed in
>   * fanotify_handle_event() since we wait there for user response. When the
> @@ -456,6 +469,11 @@ static inline bool fanotify_is_error_event(u32 mask)
>  	return mask & FAN_FS_ERROR;
>  }
>  
> +static inline bool fanotify_is_mnt_event(u32 mask)
> +{
> +	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +}
> +
>  static inline const struct path *fanotify_event_path(struct fanotify_event *event)
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2d85c71717d6..1e111730b6bf 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -19,6 +19,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/statfs.h>
>  #include <linux/exportfs.h>
> +#include <linux/mnt_namespace.h>
>  
>  #include <asm/ioctls.h>
>  
> @@ -114,6 +115,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_init;
>  struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
>  struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
>  struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
> +struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
>  
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
> @@ -122,6 +124,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
>  	sizeof(struct fanotify_event_info_pidfd)
>  #define FANOTIFY_ERROR_INFO_LEN \
>  	(sizeof(struct fanotify_event_info_error))
> +#define FANOTIFY_MNT_INFO_LEN \
> +	(sizeof(struct fanotify_event_info_mnt))
>  
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -183,6 +187,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  		fh_len = fanotify_event_object_fh_len(event);
>  		event_len += fanotify_fid_info_len(fh_len, dot_len);
>  	}
> +	if (fanotify_is_mnt_event(event->mask))
> +		event_len += FANOTIFY_MNT_INFO_LEN;
>  
>  	return event_len;
>  }
> @@ -380,6 +386,25 @@ static int process_access_response(struct fsnotify_group *group,
>  	return -ENOENT;
>  }
>  
> +static size_t copy_mnt_info_to_user(struct fanotify_event *event,
> +				    char __user *buf, int count)
> +{
> +	struct fanotify_event_info_mnt info = { };
> +
> +	info.hdr.info_type = FAN_EVENT_INFO_TYPE_MNT;
> +	info.hdr.len = FANOTIFY_MNT_INFO_LEN;
> +
> +	if (WARN_ON(count < info.hdr.len))
> +		return -EFAULT;
> +
> +	info.mnt_id = FANOTIFY_ME(event)->mnt_id;
> +
> +	if (copy_to_user(buf, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return info.hdr.len;
> +}
> +
>  static size_t copy_error_info_to_user(struct fanotify_event *event,
>  				      char __user *buf, int count)
>  {
> @@ -642,6 +667,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>  		total_bytes += ret;
>  	}
>  
> +	if (fanotify_is_mnt_event(event->mask)) {
> +		ret = copy_mnt_info_to_user(event, buf, count);
> +		if (ret < 0)
> +			return ret;
> +		buf += ret;
> +		count -= ret;
> +		total_bytes += ret;
> +	}
>  	return total_bytes;
>  }
>  
> @@ -1449,6 +1482,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
>  		return -EINVAL;
>  
> +	/* FIXME: check FAN_REPORT_MNT compatibility with other flags */
> +
>  	switch (event_f_flags & O_ACCMODE) {
>  	case O_RDONLY:
>  	case O_RDWR:
> @@ -1718,6 +1753,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	case FAN_MARK_FILESYSTEM:
>  		obj_type = FSNOTIFY_OBJ_TYPE_SB;
>  		break;
> +	case FAN_MARK_MNTNS:
> +		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1765,6 +1803,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EINVAL;
>  	group = fd_file(f)->private_data;
>  
> +	/* Only report mount events on mnt namespace */
> +	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> +		if (mask & ~FANOTIFY_MOUNT_EVENTS)
> +			return -EINVAL;
> +		if (mark_type != FAN_MARK_MNTNS)
> +			return -EINVAL;
> +	} else {
> +		if (mask & FANOTIFY_MOUNT_EVENTS)
> +			return -EINVAL;
> +		if (mark_type == FAN_MARK_MNTNS)
> +			return -EINVAL;
> +	}
> +
>  	/*
>  	 * An unprivileged user is not allowed to setup mount nor filesystem
>  	 * marks.  This also includes setting up such marks by a group that
> @@ -1802,7 +1853,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	 * point.
>  	 */
>  	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> +	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>  	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
>  		return -EINVAL;
>  
> @@ -1855,8 +1906,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		mnt = path.mnt;
>  		if (mark_type == FAN_MARK_MOUNT)
>  			obj = mnt;
> -		else
> +		else if (mark_type == FAN_MARK_FILESYSTEM)
>  			obj = mnt->mnt_sb;
> +		else /* if (mark_type == FAN_MARK_MNTNS) */ {
> +			obj = mnt_ns_from_dentry(path.dentry);
> +			ret = -EINVAL;
> +			if (!obj)
> +				goto path_put_and_out;
> +		}
>  	}
>  
>  	/*
> @@ -1952,7 +2009,7 @@ static int __init fanotify_user_setup(void)
>  				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
>  
>  	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
> -	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
> +	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
>  	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
>  
>  	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
> @@ -1965,6 +2022,7 @@ static int __init fanotify_user_setup(void)
>  		fanotify_perm_event_cachep =
>  			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
>  	}
> +	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
>  
>  	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
>  	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index dec553034027..505aabd62abb 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -123,6 +123,8 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
>  
>  		seq_printf(m, "fanotify sdev:%x mflags:%x mask:%x ignored_mask:%x\n",
>  			   sb->s_dev, mflags, mark->mask, mark->ignore_mask);
> +	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
> +		/* FIXME: print info for mntns */
>  	}
>  }
>  
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index f976949d2634..2b2c3fd907c7 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -28,6 +28,11 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  	fsnotify_clear_marks_by_mount(mnt);
>  }
>  
> +void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{
> +	fsnotify_clear_marks_by_mntns(mntns);
> +}
> +
>  /**
>   * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
>   * @sb: superblock being unmounted.
> @@ -402,7 +407,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  				     file_name, cookie, iter_info);
>  }
>  
> -static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
> +static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector *const *connp)
>  {
>  	struct fsnotify_mark_connector *conn;
>  	struct hlist_node *node = NULL;
> @@ -520,14 +525,15 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  {
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	struct super_block *sb = fsnotify_data_sb(data, data_type);
> -	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> +	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
> +	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
>  	struct fsnotify_iter_info iter_info = {};
>  	struct mount *mnt = NULL;
>  	struct inode *inode2 = NULL;
>  	struct dentry *moved;
>  	int inode2_type;
>  	int ret = 0;
> -	__u32 test_mask, marks_mask;
> +	__u32 test_mask, marks_mask = 0;
>  
>  	if (path)
>  		mnt = real_mount(path->mnt);
> @@ -560,17 +566,20 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	if ((!sbinfo || !sbinfo->sb_marks) &&
>  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
>  	    (!inode || !inode->i_fsnotify_marks) &&
> -	    (!inode2 || !inode2->i_fsnotify_marks))
> +	    (!inode2 || !inode2->i_fsnotify_marks) &&
> +	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
>  		return 0;
>  
> -	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
> +	if (sb)
> +		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
>  	if (mnt)
>  		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
>  	if (inode)
>  		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
>  	if (inode2)
>  		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
> -
> +	if (mnt_data)
> +		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
>  
>  	/*
>  	 * If this is a modify event we may need to clear some ignore masks.
> @@ -600,6 +609,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  		iter_info.marks[inode2_type] =
>  			fsnotify_first_mark(&inode2->i_fsnotify_marks);
>  	}
> +	if (mnt_data) {
> +		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
> +			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
> +	}
>  
>  	/*
>  	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
> @@ -623,11 +636,31 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  }
>  EXPORT_SYMBOL_GPL(fsnotify);
>  
> +void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	struct fsnotify_mnt data = {
> +		.ns = ns,
> +		.mnt_id = real_mount(mnt)->mnt_id_unique,
> +	};
> +
> +	if (WARN_ON_ONCE(!ns))
> +		return;
> +
> +	/*
> +	 * This is an optimization as well as making sure fsnotify_init() has
> +	 * been called.
> +	 */
> +	if (!ns->n_fsnotify_marks)
> +		return;
> +
> +	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
> +}
> +
>  static __init int fsnotify_init(void)
>  {
>  	int ret;
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
>  
>  	ret = init_srcu_struct(&fsnotify_mark_srcu);
>  	if (ret)
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 663759ed6fbc..5950c7a67f41 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -33,6 +33,12 @@ static inline struct super_block *fsnotify_conn_sb(
>  	return conn->obj;
>  }
>  
> +static inline struct mnt_namespace *fsnotify_conn_mntns(
> +				struct fsnotify_mark_connector *conn)
> +{
> +	return conn->obj;
> +}
> +
>  static inline struct super_block *fsnotify_object_sb(void *obj,
>  			enum fsnotify_obj_type obj_type)
>  {
> @@ -89,6 +95,11 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>  	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
>  }
>  
> +static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
> +{
> +	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
> +}
> +
>  /*
>   * update the dentry->d_flags of all of inode's children to indicate if inode cares
>   * about events that happen to its children.
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 4981439e6209..798340db69d7 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -107,6 +107,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
>  		return &real_mount(obj)->mnt_fsnotify_marks;
>  	case FSNOTIFY_OBJ_TYPE_SB:
>  		return fsnotify_sb_marks(obj);
> +	case FSNOTIFY_OBJ_TYPE_MNTNS:
> +		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
>  	default:
>  		return NULL;
>  	}
> @@ -120,6 +122,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
>  		return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
>  	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
>  		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
> +		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
>  	return NULL;
>  }
>  
> @@ -346,12 +350,15 @@ static void *fsnotify_detach_connector_from_object(
>  		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
>  	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
>  		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
> +	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
> +		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
>  	}
>  
>  	rcu_assign_pointer(*connp, NULL);
>  	conn->obj = NULL;
>  	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
> -	fsnotify_update_sb_watchers(sb, conn);
> +	if (sb)
> +		fsnotify_update_sb_watchers(sb, conn);
>  
>  	return inode;
>  }
> @@ -724,7 +731,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
>  	 * Attach the sb info before attaching a connector to any object on sb.
>  	 * The sb info will remain attached as long as sb lives.
>  	 */
> -	if (!fsnotify_sb_info(sb)) {
> +	if (sb && !fsnotify_sb_info(sb)) {
>  		err = fsnotify_attach_info_to_sb(sb);
>  		if (err)
>  			return err;
> @@ -770,7 +777,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
>  	/* mark should be the last entry.  last is the current last entry */
>  	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
>  added:
> -	fsnotify_update_sb_watchers(sb, conn);
> +	if (sb)
> +		fsnotify_update_sb_watchers(sb, conn);
>  	/*
>  	 * Since connector is attached to object using cmpxchg() we are
>  	 * guaranteed that connector initialization is fully visible by anyone
> diff --git a/fs/pnode.c b/fs/pnode.c
> index a799e0315cc9..0c99de65724e 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
>  			mp = parent->mnt_mp;
>  			parent = parent->mnt_parent;
>  		}
> -		if (parent != mnt->mnt_parent)
> +		if (parent != mnt->mnt_parent) {
>  			mnt_change_mountpoint(parent, mp, mnt);
> +			add_notify(mnt);
> +		}
>  	}
>  }
>  
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..d8699c165d94 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -25,7 +25,7 @@
>  
>  #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
>  
> -#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
> +#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
>  
>  /*
>   * fanotify_init() flags that require CAP_SYS_ADMIN.
> @@ -38,7 +38,8 @@
>  					 FAN_REPORT_PIDFD | \
>  					 FAN_REPORT_FD_ERROR | \
>  					 FAN_UNLIMITED_QUEUE | \
> -					 FAN_UNLIMITED_MARKS)
> +					 FAN_UNLIMITED_MARKS | \
> +					 FAN_REPORT_MNT)
>  
>  /*
>   * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
> @@ -58,7 +59,7 @@
>  #define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
>  
>  #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
> -				 FAN_MARK_FILESYSTEM)
> +				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS)
>  
>  #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
>  				 FAN_MARK_FLUSH)
> @@ -99,10 +100,13 @@
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
>  #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
>  
> +#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
>  				 FANOTIFY_INODE_EVENTS | \
> -				 FANOTIFY_ERROR_EVENTS)
> +				 FANOTIFY_ERROR_EVENTS | \
> +				 FANOTIFY_MOUNT_EVENTS )
>  
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 278620e063ab..ea998551dd0d 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -255,6 +255,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  	__fsnotify_vfsmount_delete(mnt);
>  }
>  
> +static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{
> +	__fsnotify_mntns_delete(mntns);
> +}
> +
>  /*
>   * fsnotify_inoderemove - an inode is going away
>   */
> @@ -463,4 +468,19 @@ static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
>  			NULL, NULL, NULL, 0);
>  }
>  
> +static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
> +}
> +
> +static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
> +}
> +
> +static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
> +}
> +
>  #endif	/* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 3ecf7768e577..b84ac1ed9721 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -56,6 +56,10 @@
>  #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
>  #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
>  
> +#define FS_MNT_ATTACH		0x00100000	/* Mount was attached */
> +#define FS_MNT_DETACH		0x00200000	/* Mount was detached */
> +#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
> +
>  /*
>   * Set on inode mark that cares about things that happen to its children.
>   * Always set for dnotify and inotify.
> @@ -102,7 +106,7 @@
>  			     FS_EVENTS_POSS_ON_CHILD | \
>  			     FS_DELETE_SELF | FS_MOVE_SELF | \
>  			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
> -			     FS_ERROR)
> +			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
>  
>  /* Extra flags that may be reported with event or control handling of events */
>  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
> @@ -288,6 +292,7 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
>  	FSNOTIFY_EVENT_DENTRY,
> +	FSNOTIFY_EVENT_MNT,
>  	FSNOTIFY_EVENT_ERROR,
>  };
>  
> @@ -297,6 +302,11 @@ struct fs_error_report {
>  	struct super_block *sb;
>  };
>  
> +struct fsnotify_mnt {
> +	const struct mnt_namespace *ns;
> +	u64 mnt_id;
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  {
>  	switch (data_type) {
> @@ -354,6 +364,24 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
>  	}
>  }
>  
> +static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
> +							   int data_type)
> +{
> +	switch (data_type) {
> +	case FSNOTIFY_EVENT_MNT:
> +		return data;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
> +{
> +	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
> +
> +	return mnt_data ? mnt_data->mnt_id : 0;
> +}
> +
>  static inline struct fs_error_report *fsnotify_data_error_report(
>  							const void *data,
>  							int data_type)
> @@ -379,6 +407,7 @@ enum fsnotify_iter_type {
>  	FSNOTIFY_ITER_TYPE_SB,
>  	FSNOTIFY_ITER_TYPE_PARENT,
>  	FSNOTIFY_ITER_TYPE_INODE2,
> +	FSNOTIFY_ITER_TYPE_MNTNS,
>  	FSNOTIFY_ITER_TYPE_COUNT
>  };
>  
> @@ -388,6 +417,7 @@ enum fsnotify_obj_type {
>  	FSNOTIFY_OBJ_TYPE_INODE,
>  	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
>  	FSNOTIFY_OBJ_TYPE_SB,
> +	FSNOTIFY_OBJ_TYPE_MNTNS,
>  	FSNOTIFY_OBJ_TYPE_COUNT,
>  	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
>  };
> @@ -572,8 +602,10 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
> +extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
>  extern void fsnotify_sb_free(struct super_block *sb);
>  extern u32 fsnotify_get_cookie(void);
> +extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
>  
>  static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
>  {
> @@ -879,6 +911,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  static inline void fsnotify_sb_delete(struct super_block *sb)
>  {}
>  
> +static inline void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{}
> +
>  static inline void fsnotify_sb_free(struct super_block *sb)
>  {}
>  
> @@ -893,6 +928,9 @@ static inline u32 fsnotify_get_cookie(void)
>  static inline void fsnotify_unmount_inodes(struct super_block *sb)
>  {}
>  
> +static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
> +{}
> +
>  #endif	/* CONFIG_FSNOTIFY */
>  
>  #endif	/* __KERNEL __ */
> diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
> index 70b366b64816..05bc01c0f38a 100644
> --- a/include/linux/mnt_namespace.h
> +++ b/include/linux/mnt_namespace.h
> @@ -10,6 +10,7 @@ struct mnt_namespace;
>  struct fs_struct;
>  struct user_namespace;
>  struct ns_common;
> +struct vfsmount;
>  
>  extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
>  		struct user_namespace *, struct fs_struct *);
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 34f221d3a1b9..332ef8532390 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -25,6 +25,8 @@
>  #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
>  #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
>  #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
> +#define FAN_MNT_ATTACH		0x00100000	/* Mount was attached */
> +#define FAN_MNT_DETACH		0x00200000	/* Mount was detached */
>  
>  #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
>  
> @@ -61,6 +63,7 @@
>  #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
>  #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
>  #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
> +#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
>  
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -91,6 +94,7 @@
>  #define FAN_MARK_INODE		0x00000000
>  #define FAN_MARK_MOUNT		0x00000010
>  #define FAN_MARK_FILESYSTEM	0x00000100
> +#define FAN_MARK_MNTNS		0x00000110
>  
>  /*
>   * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
> @@ -143,6 +147,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID	3
>  #define FAN_EVENT_INFO_TYPE_PIDFD	4
>  #define FAN_EVENT_INFO_TYPE_ERROR	5
> +#define FAN_EVENT_INFO_TYPE_MNT		6
>  
>  /* Special info types for FAN_RENAME */
>  #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
> @@ -189,6 +194,11 @@ struct fanotify_event_info_error {
>  	__u32 error_count;
>  };
>  
> +struct fanotify_event_info_mnt {
> +	struct fanotify_event_info_header hdr;
> +	__u64 mnt_id;
> +};
> +
>  /*
>   * User space may need to record additional information about its decision.
>   * The extra information type records what kind of information is included.
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 366c87a40bd1..aab8972a3124 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
>  	case FSNOTIFY_OBJ_TYPE_INODE:
>  		perm = FILE__WATCH;
>  		break;
> +	case FSNOTIFY_OBJ_TYPE_MNTNS:
> +		/* FIXME: Is this correct??? */
> +		perm = FILE__WATCH;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.47.0
> 

