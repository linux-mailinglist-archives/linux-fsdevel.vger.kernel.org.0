Return-Path: <linux-fsdevel+bounces-37077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2B9ED2AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81CF281522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A31DE2DF;
	Wed, 11 Dec 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNF2q23a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC31DDC19
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935853; cv=none; b=KGJQTveq6rnrBnAHD4zWcm0a8KBR8l9xaX0dJUP89J77aB2S1cfmqZ0+o7wS5MdDJnkt28a6ev6Qn21xBST0JBcZl8Az1bYz6jWyh3C9RXOXxoZFZavL+SmrbiYBxeVcAIv3Rezs3vVlm6GL/MNulDog2E0zhU9U7mTQ64hSaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935853; c=relaxed/simple;
	bh=tfFL6cEdV0De+UWLNWGyYLc7nw0HR/XiFzKDXnKZaIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB9Hk4qt1hJGqBeQ8l8Pzoz4Y3TDugpe793OCAvjq30bExvBsIEW7M5dxRfx/SePz9GS5kTWyJDkKrmzPvawx3S4HiCTm7Igs/R3U2Unrq0aRTReuEjKIS/vi37PJ1jdmAy+bNtTYgiXn0qT8LpL8SPfMkg/EJWy/UUGclMU3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNF2q23a; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so9582417a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733935848; x=1734540648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX9oMdiiLBQaAKzuYn+r/yxyLvlqmCgNSmPeEgmIMw8=;
        b=TNF2q23aVd0A5idxGcGo2NRHXR07OML1lutfDV5AhFIUbUhG4bC8sP+F4XH/jD1JL5
         3svEIRUVKSo8QsVMNKUYLsiHrL74miP1Cm5Gib9GokagIWaMjvKPS76kHiDCi5MvRDpd
         kSupAnm7C2iaVssz35JcCraQqJPtBuLVPHqRqaHHgvaivrhs07I0KMApzAlliEohtoc8
         /8kPYZHMjpl6KAqtTyaj2NVlz/zfubcM5ylpw76htuTY9/PqoLgi0vkDGxgTnf7T5u08
         Ktf0U5bhHQcLWuZdb5gKBDMrP1di2ogL2RSUJNQOELcuCEKH76igrkRlwXk6dNI4V4nJ
         jAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935848; x=1734540648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX9oMdiiLBQaAKzuYn+r/yxyLvlqmCgNSmPeEgmIMw8=;
        b=XEL400mdwPlFGH92cQ2XSRj5oR++M9gs+xO+ZqxQsb0y9B0dr3gGhLDRT5XvKeirVu
         vq1OpWJZZdi7QCJ/6jVWai2P/VB5vKVtcHukSjX4LeRyk7+WQb17gPjZJ3U9b5hO2QbR
         Gd0bBMUBqjcac+xPzDqksirv8YcaVkAuo4PemxRF19zmd8v9HHzQb7ieEcYNe3cQMAqH
         fn18Bcd/jbV8p290oLCi9HeIYUovESHL2TSituhQWqh3v28ym0pA0siIVKkrJrzS59RF
         cmIVTIKJn6luPs3w2C3fRXhfjnqIMNG7ZnnX55rs/vcLYsABgErKYUjlduNq8RcN6JI2
         A96A==
X-Gm-Message-State: AOJu0YzNtBw37KyTBVNrsPs4CUynsSNqYume7fisyTN7BiIzAUtk8SCe
	cSXxImFbPBA0h2b/4NsWAaRCvUbTFYIFxf49ky0SQJPbR9VIbX6/uCFoFhXL69NOF/wYAxYt5F4
	RaROrg5O2BYgqyjZmx+F1PpH1pcA=
X-Gm-Gg: ASbGncsQVuPF2GYhNql9TIyPiHfexJG93WVMm2dKlgz7v2hi2jwdgHtVrwOhT041ZIR
	+i323nSBCJg6wpV+bCmQknzi9VaSP2SruiKY=
X-Google-Smtp-Source: AGHT+IEmEXLIIoqjrYQ/NcXuTDIeQ9GSY/iyTDuebvBt7vqlUpGuSKVdRJv5ybUV6sOLiv/ZwGt0Kpr9PuioibVBHts=
X-Received: by 2002:a05:6402:1ec8:b0:5d0:b7c5:c409 with SMTP id
 4fb4d7f45d1cf-5d445b3ebfamr298331a12.14.1733935847497; Wed, 11 Dec 2024
 08:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153709.149603-1-mszeredi@redhat.com>
In-Reply-To: <20241211153709.149603-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Dec 2024 17:50:36 +0100
Message-ID: <CAOQ4uxhq__DS=OYZkEvW=CcAwVfeO6j5n=9cKcCPWF+4aARy+Q@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:37=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
>
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
>
> If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> FAN_MNT_DETACH).
>
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containin=
g
> these fields identifying the affected mounts:
>
>   __u64 mnt_id    - the ID of the mount (see statmount(2))
>
> FAN_REPORT_MNT must be supplied to fanotify_init() to receive these event=
s
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

For the fs/notify/* bits, and apart from the FIXME,
This looks good to me.

I will provide RVB after the FIXME are addressed.

Thanks,
Amir.

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
>         struct ns_common        ns;
>         struct mount *  root;
> @@ -14,6 +16,10 @@ struct mnt_namespace {
>         u64                     seq;    /* Sequence number to prevent loo=
ps */
>         wait_queue_head_t poll;
>         u64 event;
> +#ifdef CONFIG_FSNOTIFY
> +       __u32                   n_fsnotify_mask;
> +       struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
> +#endif
>         unsigned int            nr_mounts; /* # of mounts in the namespac=
e */
>         unsigned int            pending_mounts;
>         struct rb_node          mnt_ns_tree_node; /* node in the mnt_ns_t=
ree */
> @@ -77,6 +83,9 @@ struct mount {
>         int mnt_expiry_mark;            /* true if marked for expiry */
>         struct hlist_head mnt_pins;
>         struct hlist_head mnt_stuck_children;
> +
> +       struct list_head to_notify;     /* need to queue notification */
> +       struct mnt_namespace *prev_ns;  /* previous namespace (NULL if no=
ne) */
>  } __randomize_layout;
>
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namesp=
ace */
> @@ -167,3 +176,15 @@ static inline struct mnt_namespace *to_mnt_ns(struct=
 ns_common *ns)
>  {
>         return container_of(ns, struct mnt_namespace, ns);
>  }
> +
> +static inline void add_notify(struct mount *m)
> +{
> +       /* Optimize the case where there are no watches */
> +       if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
> +           (m->prev_ns && m->prev_ns->n_fsnotify_marks))
> +               list_add_tail(&m->to_notify, &notify_list);
> +       else
> +               m->prev_ns =3D m->mnt_ns;
> +}
> +
> +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6eec7794f707..186f660abd60 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -79,6 +79,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>  static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> +LIST_HEAD(notify_list); /* protected by namespace_sem */
>  static DEFINE_RWLOCK(mnt_ns_tree_lock);
>  static struct rb_root mnt_ns_tree =3D RB_ROOT; /* protected by mnt_ns_tr=
ee_lock */
>
> @@ -145,6 +146,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>
>         /* keep alive for {list,stat}mount() */
>         if (refcount_dec_and_test(&ns->passive)) {
> +               fsnotify_mntns_delete(ns);
>                 put_user_ns(ns->user_ns);
>                 kfree(ns);
>         }
> @@ -1136,6 +1138,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns,=
 struct mount *mnt)
>         rb_link_node(&mnt->mnt_node, parent, link);
>         rb_insert_color(&mnt->mnt_node, &ns->mounts);
>         mnt->mnt.mnt_flags |=3D MNT_ONRB;
> +
> +       add_notify(mnt);
>  }
>
>  /*
> @@ -1683,17 +1687,53 @@ int may_umount(struct vfsmount *mnt)
>
>  EXPORT_SYMBOL(may_umount);
>
> +static void notify_mount(struct mount *p)
> +{
> +       if (!p->prev_ns && p->mnt_ns) {
> +               fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +       } else if (p->prev_ns && !p->mnt_ns) {
> +               fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +       } else if (p->prev_ns =3D=3D p->mnt_ns) {
> +               fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> +       } else {
> +               fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +               fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +       }
> +       p->prev_ns =3D p->mnt_ns;
> +}
> +
>  static void namespace_unlock(void)
>  {
>         struct hlist_head head;
>         struct hlist_node *p;
> -       struct mount *m;
> +       struct mount *m, *tmp;
>         LIST_HEAD(list);
> +       bool notify =3D !list_empty(&notify_list);
>
>         hlist_move_list(&unmounted, &head);
>         list_splice_init(&ex_mountpoints, &list);
>
> -       up_write(&namespace_sem);
> +       /*
> +        * No point blocking out concurrent readers while notifications a=
re
> +        * sent. This will also allow statmount()/listmount() to run
> +        * concurrently.
> +        */
> +       if (unlikely(notify))
> +               downgrade_write(&namespace_sem);
> +
> +       /*
> +        * Notify about mounts that were added/reparented/remain connecte=
d after
> +        * unmount.
> +        */
> +       list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
> +               notify_mount(m);
> +               list_del_init(&m->to_notify);
> +       }
> +
> +       if (unlikely(notify))
> +               up_read(&namespace_sem);
> +       else
> +               up_write(&namespace_sem);
>
>         shrink_dentry_list(&list);
>
> @@ -1806,6 +1846,7 @@ static void umount_tree(struct mount *mnt, enum umo=
unt_tree_flags how)
>                 change_mnt_propagation(p, MS_PRIVATE);
>                 if (disconnect)
>                         hlist_add_head(&p->mnt_umount, &unmounted);
> +               add_notify(p);
>         }
>  }
>
> @@ -2103,16 +2144,24 @@ struct mnt_namespace *__lookup_next_mnt_ns(struct=
 mnt_namespace *mntns, bool pre
>         }
>  }
>
> +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry)
> +{
> +       if (!is_mnt_ns_file(dentry))
> +               return NULL;
> +
> +       return to_mnt_ns(get_proc_ns(dentry->d_inode));
> +}
> +
>  static bool mnt_ns_loop(struct dentry *dentry)
>  {
>         /* Could bind mounting the mount namespace inode cause a
>          * mount namespace loop?
>          */
> -       struct mnt_namespace *mnt_ns;
> -       if (!is_mnt_ns_file(dentry))
> +       struct mnt_namespace *mnt_ns =3D mnt_ns_from_dentry(dentry);
> +
> +       if (!mnt_ns)
>                 return false;
>
> -       mnt_ns =3D to_mnt_ns(get_proc_ns(dentry->d_inode));
>         return current->nsproxy->mnt_ns->seq >=3D mnt_ns->seq;
>  }
>
> @@ -2505,6 +2554,7 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>                         dest_mp =3D smp;
>                 unhash_mnt(source_mnt);
>                 attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
> +               add_notify(source_mnt);
>                 touch_mnt_namespace(source_mnt->mnt_ns);
>         } else {
>                 if (source_mnt->mnt_ns) {
> @@ -4420,6 +4470,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, ne=
w_root,
>         list_del_init(&new_mnt->mnt_expire);
>         put_mountpoint(root_mp);
>         unlock_mount_hash();
> +       add_notify(root_mnt);
> +       add_notify(new_mnt);
>         chroot_fs_refs(&root, &new);
>         error =3D 0;
>  out4:
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 24c7c5df4998..a9dc004291bf 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_eve=
nt *old,
>         case FANOTIFY_EVENT_TYPE_FS_ERROR:
>                 return fanotify_error_event_equal(FANOTIFY_EE(old),
>                                                   FANOTIFY_EE(new));
> +       case FANOTIFY_EVENT_TYPE_MNT:
> +               return false;
>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsnotify=
_group *group,
>         pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_type=3D%d=
\n",
>                  __func__, iter_info->report_mask, event_mask, data, data=
_type);
>
> -       if (!fid_mode) {
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> +       {
> +               if (data_type !=3D FSNOTIFY_EVENT_MNT)
> +                       return 0;
> +       } else if (!fid_mode) {
>                 /* Do we have path to open a file descriptor? */
>                 if (!path)
>                         return 0;
> @@ -548,6 +554,20 @@ static struct fanotify_event *fanotify_alloc_path_ev=
ent(const struct path *path,
>         return &pevent->fae;
>  }
>
> +static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t=
 gfp)
> +{
> +       struct fanotify_mnt_event *pevent;
> +
> +       pevent =3D kmem_cache_alloc(fanotify_mnt_event_cachep, gfp);
> +       if (!pevent)
> +               return NULL;
> +
> +       pevent->fae.type =3D FANOTIFY_EVENT_TYPE_MNT;
> +       pevent->mnt_id =3D mnt_id;
> +
> +       return &pevent->fae;
> +}
> +
>  static struct fanotify_event *fanotify_alloc_perm_event(const struct pat=
h *path,
>                                                         gfp_t gfp)
>  {
> @@ -715,6 +735,7 @@ static struct fanotify_event *fanotify_alloc_event(
>                                               fid_mode);
>         struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type=
, dir);
>         const struct path *path =3D fsnotify_data_path(data, data_type);
> +       u64 mnt_id =3D fsnotify_data_mnt_id(data, data_type);
>         struct mem_cgroup *old_memcg;
>         struct dentry *moved =3D NULL;
>         struct inode *child =3D NULL;
> @@ -810,8 +831,10 @@ static struct fanotify_event *fanotify_alloc_event(
>                                                   moved, &hash, gfp);
>         } else if (fid_mode) {
>                 event =3D fanotify_alloc_fid_event(id, fsid, &hash, gfp);
> -       } else {
> +       } else if (path) {
>                 event =3D fanotify_alloc_path_event(path, &hash, gfp);
> +       } else /* if (mnt_id) */ {
> +               event =3D fanotify_alloc_mnt_event(mnt_id, gfp);
>         }
>
>         if (!event)
> @@ -910,7 +933,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
>         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 23);
>
>         mask =3D fanotify_group_event_mask(group, iter_info, &match_mask,
>                                          mask, data, data_type, dir);
> @@ -1011,6 +1034,11 @@ static void fanotify_free_error_event(struct fsnot=
ify_group *group,
>         mempool_free(fee, &group->fanotify_data.error_events_pool);
>  }
>
> +static void fanotify_free_mnt_event(struct fanotify_event *event)
> +{
> +       kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
> +}
> +
>  static void fanotify_free_event(struct fsnotify_group *group,
>                                 struct fsnotify_event *fsn_event)
>  {
> @@ -1037,6 +1065,9 @@ static void fanotify_free_event(struct fsnotify_gro=
up *group,
>         case FANOTIFY_EVENT_TYPE_FS_ERROR:
>                 fanotify_free_error_event(group, event);
>                 break;
> +       case FANOTIFY_EVENT_TYPE_MNT:
> +               fanotify_free_mnt_event(event);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>         }
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
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
>         FANOTIFY_EVENT_TYPE_PATH_PERM,
>         FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
>         FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
> +       FANOTIFY_EVENT_TYPE_MNT,
>         __FANOTIFY_EVENT_TYPE_NUM
>  };
>
> @@ -409,12 +411,23 @@ struct fanotify_path_event {
>         struct path path;
>  };
>
> +struct fanotify_mnt_event {
> +       struct fanotify_event fae;
> +       u64 mnt_id;
> +};
> +
>  static inline struct fanotify_path_event *
>  FANOTIFY_PE(struct fanotify_event *event)
>  {
>         return container_of(event, struct fanotify_path_event, fae);
>  }
>
> +static inline struct fanotify_mnt_event *
> +FANOTIFY_ME(struct fanotify_event *event)
> +{
> +       return container_of(event, struct fanotify_mnt_event, fae);
> +}
> +
>  /*
>   * Structure for permission fanotify events. It gets allocated and freed=
 in
>   * fanotify_handle_event() since we wait there for user response. When t=
he
> @@ -456,6 +469,11 @@ static inline bool fanotify_is_error_event(u32 mask)
>         return mask & FAN_FS_ERROR;
>  }
>
> +static inline bool fanotify_is_mnt_event(u32 mask)
> +{
> +       return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +}
> +
>  static inline const struct path *fanotify_event_path(struct fanotify_eve=
nt *event)
>  {
>         if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
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
> @@ -114,6 +115,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_ini=
t;
>  struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
>  struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
>  struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
> +struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
>
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
> @@ -122,6 +124,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_af=
ter_init;
>         sizeof(struct fanotify_event_info_pidfd)
>  #define FANOTIFY_ERROR_INFO_LEN \
>         (sizeof(struct fanotify_event_info_error))
> +#define FANOTIFY_MNT_INFO_LEN \
> +       (sizeof(struct fanotify_event_info_mnt))
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -183,6 +187,8 @@ static size_t fanotify_event_len(unsigned int info_mo=
de,
>                 fh_len =3D fanotify_event_object_fh_len(event);
>                 event_len +=3D fanotify_fid_info_len(fh_len, dot_len);
>         }
> +       if (fanotify_is_mnt_event(event->mask))
> +               event_len +=3D FANOTIFY_MNT_INFO_LEN;
>
>         return event_len;
>  }
> @@ -380,6 +386,25 @@ static int process_access_response(struct fsnotify_g=
roup *group,
>         return -ENOENT;
>  }
>
> +static size_t copy_mnt_info_to_user(struct fanotify_event *event,
> +                                   char __user *buf, int count)
> +{
> +       struct fanotify_event_info_mnt info =3D { };
> +
> +       info.hdr.info_type =3D FAN_EVENT_INFO_TYPE_MNT;
> +       info.hdr.len =3D FANOTIFY_MNT_INFO_LEN;
> +
> +       if (WARN_ON(count < info.hdr.len))
> +               return -EFAULT;
> +
> +       info.mnt_id =3D FANOTIFY_ME(event)->mnt_id;
> +
> +       if (copy_to_user(buf, &info, sizeof(info)))
> +               return -EFAULT;
> +
> +       return info.hdr.len;
> +}
> +
>  static size_t copy_error_info_to_user(struct fanotify_event *event,
>                                       char __user *buf, int count)
>  {
> @@ -642,6 +667,14 @@ static int copy_info_records_to_user(struct fanotify=
_event *event,
>                 total_bytes +=3D ret;
>         }
>
> +       if (fanotify_is_mnt_event(event->mask)) {
> +               ret =3D copy_mnt_info_to_user(event, buf, count);
> +               if (ret < 0)
> +                       return ret;
> +               buf +=3D ret;
> +               count -=3D ret;
> +               total_bytes +=3D ret;
> +       }
>         return total_bytes;
>  }
>
> @@ -1449,6 +1482,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
>                 return -EINVAL;
>
> +       /* FIXME: check FAN_REPORT_MNT compatibility with other flags */
> +
>         switch (event_f_flags & O_ACCMODE) {
>         case O_RDONLY:
>         case O_RDWR:
> @@ -1718,6 +1753,9 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         case FAN_MARK_FILESYSTEM:
>                 obj_type =3D FSNOTIFY_OBJ_TYPE_SB;
>                 break;
> +       case FAN_MARK_MNTNS:
> +               obj_type =3D FSNOTIFY_OBJ_TYPE_MNTNS;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -1765,6 +1803,19 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                 return -EINVAL;
>         group =3D fd_file(f)->private_data;
>
> +       /* Only report mount events on mnt namespace */
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> +               if (mask & ~FANOTIFY_MOUNT_EVENTS)
> +                       return -EINVAL;
> +               if (mark_type !=3D FAN_MARK_MNTNS)
> +                       return -EINVAL;
> +       } else {
> +               if (mask & FANOTIFY_MOUNT_EVENTS)
> +                       return -EINVAL;
> +               if (mark_type =3D=3D FAN_MARK_MNTNS)
> +                       return -EINVAL;
> +       }
> +
>         /*
>          * An unprivileged user is not allowed to setup mount nor filesys=
tem
>          * marks.  This also includes setting up such marks by a group th=
at
> @@ -1802,7 +1853,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          * point.
>          */
>         fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -       if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> +       if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EV=
ENT_FLAGS) &&
>             (!fid_mode || mark_type =3D=3D FAN_MARK_MOUNT))
>                 return -EINVAL;
>
> @@ -1855,8 +1906,14 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                 mnt =3D path.mnt;
>                 if (mark_type =3D=3D FAN_MARK_MOUNT)
>                         obj =3D mnt;
> -               else
> +               else if (mark_type =3D=3D FAN_MARK_FILESYSTEM)
>                         obj =3D mnt->mnt_sb;
> +               else /* if (mark_type =3D=3D FAN_MARK_MNTNS) */ {
> +                       obj =3D mnt_ns_from_dentry(path.dentry);
> +                       ret =3D -EINVAL;
> +                       if (!obj)
> +                               goto path_put_and_out;
> +               }
>         }
>
>         /*
> @@ -1952,7 +2009,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 13);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> @@ -1965,6 +2022,7 @@ static int __init fanotify_user_setup(void)
>                 fanotify_perm_event_cachep =3D
>                         KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
>         }
> +       fanotify_mnt_event_cachep =3D KMEM_CACHE(fanotify_mnt_event, SLAB=
_PANIC);
>
>         fanotify_max_queued_events =3D FANOTIFY_DEFAULT_MAX_EVENTS;
>         init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =3D
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index dec553034027..505aabd62abb 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -123,6 +123,8 @@ static void fanotify_fdinfo(struct seq_file *m, struc=
t fsnotify_mark *mark)
>
>                 seq_printf(m, "fanotify sdev:%x mflags:%x mask:%x ignored=
_mask:%x\n",
>                            sb->s_dev, mflags, mark->mask, mark->ignore_ma=
sk);
> +       } else if (mark->connector->type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) =
{
> +               /* FIXME: print info for mntns */
>         }
>  }
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index f976949d2634..2b2c3fd907c7 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -28,6 +28,11 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>         fsnotify_clear_marks_by_mount(mnt);
>  }
>
> +void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{
> +       fsnotify_clear_marks_by_mntns(mntns);
> +}
> +
>  /**
>   * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched in=
odes.
>   * @sb: superblock being unmounted.
> @@ -402,7 +407,7 @@ static int send_to_group(__u32 mask, const void *data=
, int data_type,
>                                      file_name, cookie, iter_info);
>  }
>
> -static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_co=
nnector **connp)
> +static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_co=
nnector *const *connp)
>  {
>         struct fsnotify_mark_connector *conn;
>         struct hlist_node *node =3D NULL;
> @@ -520,14 +525,15 @@ int fsnotify(__u32 mask, const void *data, int data=
_type, struct inode *dir,
>  {
>         const struct path *path =3D fsnotify_data_path(data, data_type);
>         struct super_block *sb =3D fsnotify_data_sb(data, data_type);
> -       struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> +       const struct fsnotify_mnt *mnt_data =3D fsnotify_data_mnt(data, d=
ata_type);
> +       struct fsnotify_sb_info *sbinfo =3D sb ? fsnotify_sb_info(sb) : N=
ULL;
>         struct fsnotify_iter_info iter_info =3D {};
>         struct mount *mnt =3D NULL;
>         struct inode *inode2 =3D NULL;
>         struct dentry *moved;
>         int inode2_type;
>         int ret =3D 0;
> -       __u32 test_mask, marks_mask;
> +       __u32 test_mask, marks_mask =3D 0;
>
>         if (path)
>                 mnt =3D real_mount(path->mnt);
> @@ -560,17 +566,20 @@ int fsnotify(__u32 mask, const void *data, int data=
_type, struct inode *dir,
>         if ((!sbinfo || !sbinfo->sb_marks) &&
>             (!mnt || !mnt->mnt_fsnotify_marks) &&
>             (!inode || !inode->i_fsnotify_marks) &&
> -           (!inode2 || !inode2->i_fsnotify_marks))
> +           (!inode2 || !inode2->i_fsnotify_marks) &&
> +           (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
>                 return 0;
>
> -       marks_mask =3D READ_ONCE(sb->s_fsnotify_mask);
> +       if (sb)
> +               marks_mask |=3D READ_ONCE(sb->s_fsnotify_mask);
>         if (mnt)
>                 marks_mask |=3D READ_ONCE(mnt->mnt_fsnotify_mask);
>         if (inode)
>                 marks_mask |=3D READ_ONCE(inode->i_fsnotify_mask);
>         if (inode2)
>                 marks_mask |=3D READ_ONCE(inode2->i_fsnotify_mask);
> -
> +       if (mnt_data)
> +               marks_mask |=3D READ_ONCE(mnt_data->ns->n_fsnotify_mask);
>
>         /*
>          * If this is a modify event we may need to clear some ignore mas=
ks.
> @@ -600,6 +609,10 @@ int fsnotify(__u32 mask, const void *data, int data_=
type, struct inode *dir,
>                 iter_info.marks[inode2_type] =3D
>                         fsnotify_first_mark(&inode2->i_fsnotify_marks);
>         }
> +       if (mnt_data) {
> +               iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =3D
> +                       fsnotify_first_mark(&mnt_data->ns->n_fsnotify_mar=
ks);
> +       }
>
>         /*
>          * We need to merge inode/vfsmount/sb mark lists so that e.g. ino=
de mark
> @@ -623,11 +636,31 @@ int fsnotify(__u32 mask, const void *data, int data=
_type, struct inode *dir,
>  }
>  EXPORT_SYMBOL_GPL(fsnotify);
>
> +void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount =
*mnt)
> +{
> +       struct fsnotify_mnt data =3D {
> +               .ns =3D ns,
> +               .mnt_id =3D real_mount(mnt)->mnt_id_unique,
> +       };
> +
> +       if (WARN_ON_ONCE(!ns))
> +               return;
> +
> +       /*
> +        * This is an optimization as well as making sure fsnotify_init()=
 has
> +        * been called.
> +        */
> +       if (!ns->n_fsnotify_marks)
> +               return;
> +
> +       fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
> +}
> +
>  static __init int fsnotify_init(void)
>  {
>         int ret;
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) !=3D 23);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) !=3D 25);
>
>         ret =3D init_srcu_struct(&fsnotify_mark_srcu);
>         if (ret)
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 663759ed6fbc..5950c7a67f41 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -33,6 +33,12 @@ static inline struct super_block *fsnotify_conn_sb(
>         return conn->obj;
>  }
>
> +static inline struct mnt_namespace *fsnotify_conn_mntns(
> +                               struct fsnotify_mark_connector *conn)
> +{
> +       return conn->obj;
> +}
> +
>  static inline struct super_block *fsnotify_object_sb(void *obj,
>                         enum fsnotify_obj_type obj_type)
>  {
> @@ -89,6 +95,11 @@ static inline void fsnotify_clear_marks_by_sb(struct s=
uper_block *sb)
>         fsnotify_destroy_marks(fsnotify_sb_marks(sb));
>  }
>
> +static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *m=
ntns)
> +{
> +       fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
> +}
> +
>  /*
>   * update the dentry->d_flags of all of inode's children to indicate if =
inode cares
>   * about events that happen to its children.
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 4981439e6209..798340db69d7 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -107,6 +107,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *=
obj,
>                 return &real_mount(obj)->mnt_fsnotify_marks;
>         case FSNOTIFY_OBJ_TYPE_SB:
>                 return fsnotify_sb_marks(obj);
> +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> +               return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
>         default:
>                 return NULL;
>         }
> @@ -120,6 +122,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_ma=
rk_connector *conn)
>                 return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
>         else if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_SB)
>                 return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
> +       else if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS)
> +               return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
>         return NULL;
>  }
>
> @@ -346,12 +350,15 @@ static void *fsnotify_detach_connector_from_object(
>                 fsnotify_conn_mount(conn)->mnt_fsnotify_mask =3D 0;
>         } else if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
>                 fsnotify_conn_sb(conn)->s_fsnotify_mask =3D 0;
> +       } else if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
> +               fsnotify_conn_mntns(conn)->n_fsnotify_mask =3D 0;
>         }
>
>         rcu_assign_pointer(*connp, NULL);
>         conn->obj =3D NULL;
>         conn->type =3D FSNOTIFY_OBJ_TYPE_DETACHED;
> -       fsnotify_update_sb_watchers(sb, conn);
> +       if (sb)
> +               fsnotify_update_sb_watchers(sb, conn);
>
>         return inode;
>  }
> @@ -724,7 +731,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mar=
k *mark, void *obj,
>          * Attach the sb info before attaching a connector to any object =
on sb.
>          * The sb info will remain attached as long as sb lives.
>          */
> -       if (!fsnotify_sb_info(sb)) {
> +       if (sb && !fsnotify_sb_info(sb)) {
>                 err =3D fsnotify_attach_info_to_sb(sb);
>                 if (err)
>                         return err;
> @@ -770,7 +777,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mar=
k *mark, void *obj,
>         /* mark should be the last entry.  last is the current last entry=
 */
>         hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
>  added:
> -       fsnotify_update_sb_watchers(sb, conn);
> +       if (sb)
> +               fsnotify_update_sb_watchers(sb, conn);
>         /*
>          * Since connector is attached to object using cmpxchg() we are
>          * guaranteed that connector initialization is fully visible by a=
nyone
> diff --git a/fs/pnode.c b/fs/pnode.c
> index a799e0315cc9..0c99de65724e 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_rest=
ore)
>                         mp =3D parent->mnt_mp;
>                         parent =3D parent->mnt_parent;
>                 }
> -               if (parent !=3D mnt->mnt_parent)
> +               if (parent !=3D mnt->mnt_parent) {
>                         mnt_change_mountpoint(parent, mp, mnt);
> +                       add_notify(mnt);
> +               }
>         }
>  }
>
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..d8699c165d94 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -25,7 +25,7 @@
>
>  #define FANOTIFY_FID_BITS      (FAN_REPORT_DFID_NAME_TARGET)
>
> -#define FANOTIFY_INFO_MODES    (FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
> +#define FANOTIFY_INFO_MODES    (FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | F=
AN_REPORT_MNT)
>
>  /*
>   * fanotify_init() flags that require CAP_SYS_ADMIN.
> @@ -38,7 +38,8 @@
>                                          FAN_REPORT_PIDFD | \
>                                          FAN_REPORT_FD_ERROR | \
>                                          FAN_UNLIMITED_QUEUE | \
> -                                        FAN_UNLIMITED_MARKS)
> +                                        FAN_UNLIMITED_MARKS | \
> +                                        FAN_REPORT_MNT)
>
>  /*
>   * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN=
.
> @@ -58,7 +59,7 @@
>  #define FANOTIFY_INTERNAL_GROUP_FLAGS  (FANOTIFY_UNPRIV)
>
>  #define FANOTIFY_MARK_TYPE_BITS        (FAN_MARK_INODE | FAN_MARK_MOUNT =
| \
> -                                FAN_MARK_FILESYSTEM)
> +                                FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS)
>
>  #define FANOTIFY_MARK_CMD_BITS (FAN_MARK_ADD | FAN_MARK_REMOVE | \
>                                  FAN_MARK_FLUSH)
> @@ -99,10 +100,13 @@
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR =
*/
>  #define FANOTIFY_ERROR_EVENTS  (FAN_FS_ERROR)
>
> +#define FANOTIFY_MOUNT_EVENTS  (FAN_MNT_ATTACH | FAN_MNT_DETACH)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS                (FANOTIFY_PATH_EVENTS | \
>                                  FANOTIFY_INODE_EVENTS | \
> -                                FANOTIFY_ERROR_EVENTS)
> +                                FANOTIFY_ERROR_EVENTS | \
> +                                FANOTIFY_MOUNT_EVENTS )
>
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS   (FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 278620e063ab..ea998551dd0d 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -255,6 +255,11 @@ static inline void fsnotify_vfsmount_delete(struct v=
fsmount *mnt)
>         __fsnotify_vfsmount_delete(mnt);
>  }
>
> +static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{
> +       __fsnotify_mntns_delete(mntns);
> +}
> +
>  /*
>   * fsnotify_inoderemove - an inode is going away
>   */
> @@ -463,4 +468,19 @@ static inline int fsnotify_sb_error(struct super_blo=
ck *sb, struct inode *inode,
>                         NULL, NULL, NULL, 0);
>  }
>
> +static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct =
vfsmount *mnt)
> +{
> +       fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
> +}
> +
> +static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct =
vfsmount *mnt)
> +{
> +       fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
> +}
> +
> +static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vf=
smount *mnt)
> +{
> +       fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
> +}
> +
>  #endif /* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 3ecf7768e577..b84ac1ed9721 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -56,6 +56,10 @@
>  #define FS_ACCESS_PERM         0x00020000      /* access event in a perm=
issions hook */
>  #define FS_OPEN_EXEC_PERM      0x00040000      /* open/exec event in a p=
ermission hook */
>
> +#define FS_MNT_ATTACH          0x00100000      /* Mount was attached */
> +#define FS_MNT_DETACH          0x00200000      /* Mount was detached */
> +#define FS_MNT_MOVE            (FS_MNT_ATTACH | FS_MNT_DETACH)
> +
>  /*
>   * Set on inode mark that cares about things that happen to its children=
.
>   * Always set for dnotify and inotify.
> @@ -102,7 +106,7 @@
>                              FS_EVENTS_POSS_ON_CHILD | \
>                              FS_DELETE_SELF | FS_MOVE_SELF | \
>                              FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED |=
 \
> -                            FS_ERROR)
> +                            FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
>
>  /* Extra flags that may be reported with event or control handling of ev=
ents */
>  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTIS=
HOT)
> @@ -288,6 +292,7 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_PATH,
>         FSNOTIFY_EVENT_INODE,
>         FSNOTIFY_EVENT_DENTRY,
> +       FSNOTIFY_EVENT_MNT,
>         FSNOTIFY_EVENT_ERROR,
>  };
>
> @@ -297,6 +302,11 @@ struct fs_error_report {
>         struct super_block *sb;
>  };
>
> +struct fsnotify_mnt {
> +       const struct mnt_namespace *ns;
> +       u64 mnt_id;
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int da=
ta_type)
>  {
>         switch (data_type) {
> @@ -354,6 +364,24 @@ static inline struct super_block *fsnotify_data_sb(c=
onst void *data,
>         }
>  }
>
> +static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *d=
ata,
> +                                                          int data_type)
> +{
> +       switch (data_type) {
> +       case FSNOTIFY_EVENT_MNT:
> +               return data;
> +       default:
> +               return NULL;
> +       }
> +}
> +
> +static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
> +{
> +       const struct fsnotify_mnt *mnt_data =3D fsnotify_data_mnt(data, d=
ata_type);
> +
> +       return mnt_data ? mnt_data->mnt_id : 0;
> +}
> +
>  static inline struct fs_error_report *fsnotify_data_error_report(
>                                                         const void *data,
>                                                         int data_type)
> @@ -379,6 +407,7 @@ enum fsnotify_iter_type {
>         FSNOTIFY_ITER_TYPE_SB,
>         FSNOTIFY_ITER_TYPE_PARENT,
>         FSNOTIFY_ITER_TYPE_INODE2,
> +       FSNOTIFY_ITER_TYPE_MNTNS,
>         FSNOTIFY_ITER_TYPE_COUNT
>  };
>
> @@ -388,6 +417,7 @@ enum fsnotify_obj_type {
>         FSNOTIFY_OBJ_TYPE_INODE,
>         FSNOTIFY_OBJ_TYPE_VFSMOUNT,
>         FSNOTIFY_OBJ_TYPE_SB,
> +       FSNOTIFY_OBJ_TYPE_MNTNS,
>         FSNOTIFY_OBJ_TYPE_COUNT,
>         FSNOTIFY_OBJ_TYPE_DETACHED =3D FSNOTIFY_OBJ_TYPE_COUNT
>  };
> @@ -572,8 +602,10 @@ extern int __fsnotify_parent(struct dentry *dentry, =
__u32 mask, const void *data
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
> +extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
>  extern void fsnotify_sb_free(struct super_block *sb);
>  extern u32 fsnotify_get_cookie(void);
> +extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vf=
smount *mnt);
>
>  static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
>  {
> @@ -879,6 +911,9 @@ static inline void __fsnotify_vfsmount_delete(struct =
vfsmount *mnt)
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
> +static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, st=
ruct vfsmount *mnt)
> +{}
> +
>  #endif /* CONFIG_FSNOTIFY */
>
>  #endif /* __KERNEL __ */
> diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.=
h
> index 70b366b64816..05bc01c0f38a 100644
> --- a/include/linux/mnt_namespace.h
> +++ b/include/linux/mnt_namespace.h
> @@ -10,6 +10,7 @@ struct mnt_namespace;
>  struct fs_struct;
>  struct user_namespace;
>  struct ns_common;
> +struct vfsmount;
>
>  extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_names=
pace *,
>                 struct user_namespace *, struct fs_struct *);
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 34f221d3a1b9..332ef8532390 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -25,6 +25,8 @@
>  #define FAN_OPEN_PERM          0x00010000      /* File open in perm chec=
k */
>  #define FAN_ACCESS_PERM                0x00020000      /* File accessed =
in perm check */
>  #define FAN_OPEN_EXEC_PERM     0x00040000      /* File open/exec in perm=
 check */
> +#define FAN_MNT_ATTACH         0x00100000      /* Mount was attached */
> +#define FAN_MNT_DETACH         0x00200000      /* Mount was detached */
>
>  #define FAN_EVENT_ON_CHILD     0x08000000      /* Interested in child ev=
ents */
>
> @@ -61,6 +63,7 @@
>  #define FAN_REPORT_NAME                0x00000800      /* Report events =
with name */
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
> +#define FAN_REPORT_MNT         0x00004000      /* Report mount events */
>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -91,6 +94,7 @@
>  #define FAN_MARK_INODE         0x00000000
>  #define FAN_MARK_MOUNT         0x00000010
>  #define FAN_MARK_FILESYSTEM    0x00000100
> +#define FAN_MARK_MNTNS         0x00000110
>
>  /*
>   * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MO=
DIFY
> @@ -143,6 +147,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID       3
>  #define FAN_EVENT_INFO_TYPE_PIDFD      4
>  #define FAN_EVENT_INFO_TYPE_ERROR      5
> +#define FAN_EVENT_INFO_TYPE_MNT                6
>
>  /* Special info types for FAN_RENAME */
>  #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME      10
> @@ -189,6 +194,11 @@ struct fanotify_event_info_error {
>         __u32 error_count;
>  };
>
> +struct fanotify_event_info_mnt {
> +       struct fanotify_event_info_header hdr;
> +       __u64 mnt_id;
> +};
> +
>  /*
>   * User space may need to record additional information about its decisi=
on.
>   * The extra information type records what kind of information is includ=
ed.
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 366c87a40bd1..aab8972a3124 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *=
path, u64 mask,
>         case FSNOTIFY_OBJ_TYPE_INODE:
>                 perm =3D FILE__WATCH;
>                 break;
> +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> +               /* FIXME: Is this correct??? */
> +               perm =3D FILE__WATCH;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> --
> 2.47.0
>

