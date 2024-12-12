Return-Path: <linux-fsdevel+bounces-37164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD29EE718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A976F282608
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F62139A1;
	Thu, 12 Dec 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIHq83/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E961714D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007860; cv=none; b=kvBIfjHJ5VFAEaH/XAh9b1zOpzAOiwuU4QqtIQYU8Qo2GAXC8EuuBgQnVTzzfM4zBuWgbdLSwj7A7pBDLoh88syoa+Jdz+UQZi74y8c3J7xz6KkygdRgzpi5n8ya4p8Tez2LxGtvo6m7S2KxNHtOckK/l42UFujuUOtb0zzIl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007860; c=relaxed/simple;
	bh=5I9p9hsij5TSHxGAPuwgODn8w9pj0MkiCf3vI0TAS8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxavCu5DWKWa8fIWzPJFQoHr3jluJz3msbHO2QfZIygQUPbfz0VoV2LvS4i4znmloXyJqRSRPpcFTEmMrSEfPPIPA71UahBiIHtLzVOAiaOTnJhDoETNeKWJt15eYZ9bsuupL2A46+llUKKp6nSoUqO5SKtfDdPvmP/j+1YrlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIHq83/m; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so745970a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734007856; x=1734612656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIMcamZE779ADnJwyMS2p63TgSsjBXve8POjDZ9HwN8=;
        b=cIHq83/m81jiY/FGRNta77LDXXA6Q7Av6DiebEztcrJFblhKFUTwKuZCMdIqUdRq31
         bU91xzaHeLOga3VNV3ytWMgdcMi6VRdppnA87Re1Gtc9OmUOzCGudQIbhVkTB/B/eDUr
         WJE+C1atRF7fCu6SvqQwrcl4G8TMlp3hbRzMzfkQJNv/ew94n+KEkx0oc1l83qUNpawa
         CWsC3R5WrRdg1yRQiG+x8C4C1sxx9FvWLjW2medBc4RDxhcxVjiQEcDPc5HujfrVxH2b
         ZpO9z9WL6FFVcM3GCLUEXYseFpzfh9zWYoZsolHiZy4BiCKTTEjS6Wsojo1iz8ebZw8t
         I4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007856; x=1734612656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIMcamZE779ADnJwyMS2p63TgSsjBXve8POjDZ9HwN8=;
        b=j1mibZaC203+tlbazqB3wTLzaEWILWRWtFvMrjjG964pjBGjFpsWt8RJbV2mWYrMME
         jkenDH4yCz2l0EtbrOk90PtZ2m1z5Wqa/ndD/R4x5u5BM83NW9bYCJm0FvRPUAPRVfsX
         hz5QrUtvXo0TdVKzzn8EJ+Bi9Uy75LyDOF9RayHJSpuffwVNVW4yYcgr4BqhMANgbF/j
         hdfWycrxlMg+Fx0NEPDpgJALBY14ehZrkiezOWO/XBPCFwuYIijOlzPf3hUoBVopQL9O
         XapWYxvUU+ohhsB+UpnOQ7p9SBdIaWQ0BaYWmfaPCpa3pbozzGXYaDsU0+mP/rbT/2Co
         rvow==
X-Gm-Message-State: AOJu0YxMWZjKc3PUUDSswzc5LX/JzRZwpKKqHyESbNDPJe+iemH/Ue1H
	XDrj5OJq7qkCRfSBCi7ZTNZ0UOzUIdcCx764dPNo0LaMkpB1sA8YzeyxbkenfGgrJnSKb81MnwB
	ilj6qJ42GoDs2q6HbFoQjx2hVNU4=
X-Gm-Gg: ASbGncvbiyn9ouThMUOwkUkwsqq7v4MdPUBXWtoYQD/d6akbLxWHZoYkX42eitt2+AU
	j3YTNB3Lbte3Fr16wcWoAwgJsAvRLebk9f6K2SA==
X-Google-Smtp-Source: AGHT+IHx9kbQJh+GYQd8DZQmGtKwkCPSAmVdfmRQ0gnQNbrCQ+kAZMJIn4bGBer3ibcF2hJEL+jEYzg7skl32FLKMjo=
X-Received: by 2002:a05:6402:42c9:b0:5d3:cdb3:a60 with SMTP id
 4fb4d7f45d1cf-5d633eaa568mr121206a12.34.1734007855578; Thu, 12 Dec 2024
 04:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153709.149603-1-mszeredi@redhat.com> <CAOQ4uxhq__DS=OYZkEvW=CcAwVfeO6j5n=9cKcCPWF+4aARy+Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhq__DS=OYZkEvW=CcAwVfeO6j5n=9cKcCPWF+4aARy+Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Dec 2024 13:50:44 +0100
Message-ID: <CAOQ4uxi_qDDtGtDXYABYjrU+Mu4LXa3buDeq8Bj+d6vfNJwOBQ@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:50=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Dec 11, 2024 at 4:37=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:
> >
> > Add notifications for attaching and detaching mounts.  The following ne=
w
> > event masks are added:
> >
> >   FAN_MNT_ATTACH  - Mount was attached
> >   FAN_MNT_DETACH  - Mount was detached
> >
> > If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> > FAN_MNT_DETACH).
> >
> > These events add an info record of type FAN_EVENT_INFO_TYPE_MNT contain=
ing
> > these fields identifying the affected mounts:
> >
> >   __u64 mnt_id    - the ID of the mount (see statmount(2))
> >
> > FAN_REPORT_MNT must be supplied to fanotify_init() to receive these eve=
nts
> > and no other type of event can be received with this report type.
> >
> > Marks are added with FAN_MARK_MNTNS, which records the mount namespace
> > belonging to the supplied path.
> >
> > Prior to this patch mount namespace changes could be monitored by polli=
ng
> > /proc/self/mountinfo, which did not convey any information about what
> > changed.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
>
> For the fs/notify/* bits, and apart from the FIXME,
> This looks good to me.
>
> I will provide RVB after the FIXME are addressed.

Adding some nit picking style comments...

>
> Thanks,
> Amir.
>
> >
> > v3:
> >
> >   - use a global list protected for temporarily storing (Christian)
> >   - move fsnotify_* calls to namespace_unlock() (Christian)
> >   - downgrade namespace_sem to read for fsnotify_* calls (Christian)
> >   - add notification for reparenting in propagate_umount (Christian)
> >   - require nsfs file (/proc/PID/ns/mnt) in fanotify_mark(2) (Christian=
)
> >   - cleaner check for fsnotify being initialized (Amir)
> >   - fix stub __fsnotify_mntns_delete (kernel test robot)
> >   - don't add FANOTIFY_MOUNT_EVENTS to FANOTIFY_FD_EVENTS (Amir)
> >
> > v2:
> >   - notify for whole namespace as this seems to be what people prefer
> >   - move fsnotify() calls outside of mount_lock
> >   - only report mnt_id, not parent_id
> >
> >  fs/mount.h                         | 21 ++++++++++
> >  fs/namespace.c                     | 62 ++++++++++++++++++++++++++---
> >  fs/notify/fanotify/fanotify.c      | 37 +++++++++++++++--
> >  fs/notify/fanotify/fanotify.h      | 18 +++++++++
> >  fs/notify/fanotify/fanotify_user.c | 64 ++++++++++++++++++++++++++++--
> >  fs/notify/fdinfo.c                 |  2 +
> >  fs/notify/fsnotify.c               | 47 ++++++++++++++++++----
> >  fs/notify/fsnotify.h               | 11 +++++
> >  fs/notify/mark.c                   | 14 +++++--
> >  fs/pnode.c                         |  4 +-
> >  include/linux/fanotify.h           | 12 ++++--
> >  include/linux/fsnotify.h           | 20 ++++++++++
> >  include/linux/fsnotify_backend.h   | 40 ++++++++++++++++++-
> >  include/linux/mnt_namespace.h      |  1 +
> >  include/uapi/linux/fanotify.h      | 10 +++++
> >  security/selinux/hooks.c           |  4 ++
> >  16 files changed, 340 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/mount.h b/fs/mount.h
> > index 185fc56afc13..0ad68c90e7e2 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -5,6 +5,8 @@
> >  #include <linux/ns_common.h>
> >  #include <linux/fs_pin.h>
> >
> > +extern struct list_head notify_list;
> > +
> >  struct mnt_namespace {
> >         struct ns_common        ns;
> >         struct mount *  root;
> > @@ -14,6 +16,10 @@ struct mnt_namespace {
> >         u64                     seq;    /* Sequence number to prevent l=
oops */
> >         wait_queue_head_t poll;
> >         u64 event;
> > +#ifdef CONFIG_FSNOTIFY
> > +       __u32                   n_fsnotify_mask;
> > +       struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
> > +#endif
> >         unsigned int            nr_mounts; /* # of mounts in the namesp=
ace */
> >         unsigned int            pending_mounts;
> >         struct rb_node          mnt_ns_tree_node; /* node in the mnt_ns=
_tree */
> > @@ -77,6 +83,9 @@ struct mount {
> >         int mnt_expiry_mark;            /* true if marked for expiry */
> >         struct hlist_head mnt_pins;
> >         struct hlist_head mnt_stuck_children;
> > +
> > +       struct list_head to_notify;     /* need to queue notification *=
/
> > +       struct mnt_namespace *prev_ns;  /* previous namespace (NULL if =
none) */
> >  } __randomize_layout;
> >
> >  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_name=
space */
> > @@ -167,3 +176,15 @@ static inline struct mnt_namespace *to_mnt_ns(stru=
ct ns_common *ns)
> >  {
> >         return container_of(ns, struct mnt_namespace, ns);
> >  }
> > +
> > +static inline void add_notify(struct mount *m)
> > +{
> > +       /* Optimize the case where there are no watches */
> > +       if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
> > +           (m->prev_ns && m->prev_ns->n_fsnotify_marks))
> > +               list_add_tail(&m->to_notify, &notify_list);
> > +       else
> > +               m->prev_ns =3D m->mnt_ns;
> > +}
> > +
> > +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 6eec7794f707..186f660abd60 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -79,6 +79,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> >  static DECLARE_RWSEM(namespace_sem);
> >  static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> >  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > +LIST_HEAD(notify_list); /* protected by namespace_sem */
> >  static DEFINE_RWLOCK(mnt_ns_tree_lock);
> >  static struct rb_root mnt_ns_tree =3D RB_ROOT; /* protected by mnt_ns_=
tree_lock */
> >
> > @@ -145,6 +146,7 @@ static void mnt_ns_release(struct mnt_namespace *ns=
)
> >
> >         /* keep alive for {list,stat}mount() */
> >         if (refcount_dec_and_test(&ns->passive)) {
> > +               fsnotify_mntns_delete(ns);
> >                 put_user_ns(ns->user_ns);
> >                 kfree(ns);
> >         }
> > @@ -1136,6 +1138,8 @@ static void mnt_add_to_ns(struct mnt_namespace *n=
s, struct mount *mnt)
> >         rb_link_node(&mnt->mnt_node, parent, link);
> >         rb_insert_color(&mnt->mnt_node, &ns->mounts);
> >         mnt->mnt.mnt_flags |=3D MNT_ONRB;
> > +
> > +       add_notify(mnt);
> >  }
> >
> >  /*
> > @@ -1683,17 +1687,53 @@ int may_umount(struct vfsmount *mnt)
> >
> >  EXPORT_SYMBOL(may_umount);
> >
> > +static void notify_mount(struct mount *p)
> > +{
> > +       if (!p->prev_ns && p->mnt_ns) {
> > +               fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> > +       } else if (p->prev_ns && !p->mnt_ns) {
> > +               fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> > +       } else if (p->prev_ns =3D=3D p->mnt_ns) {
> > +               fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> > +       } else {
> > +               fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> > +               fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> > +       }
> > +       p->prev_ns =3D p->mnt_ns;
> > +}
> > +
> >  static void namespace_unlock(void)
> >  {
> >         struct hlist_head head;
> >         struct hlist_node *p;
> > -       struct mount *m;
> > +       struct mount *m, *tmp;
> >         LIST_HEAD(list);
> > +       bool notify =3D !list_empty(&notify_list);
> >
> >         hlist_move_list(&unmounted, &head);
> >         list_splice_init(&ex_mountpoints, &list);
> >
> > -       up_write(&namespace_sem);
> > +       /*
> > +        * No point blocking out concurrent readers while notifications=
 are
> > +        * sent. This will also allow statmount()/listmount() to run
> > +        * concurrently.
> > +        */
> > +       if (unlikely(notify))
> > +               downgrade_write(&namespace_sem);
> > +
> > +       /*
> > +        * Notify about mounts that were added/reparented/remain connec=
ted after
> > +        * unmount.
> > +        */
> > +       list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
> > +               notify_mount(m);
> > +               list_del_init(&m->to_notify);
> > +       }
> > +
> > +       if (unlikely(notify))
> > +               up_read(&namespace_sem);
> > +       else
> > +               up_write(&namespace_sem);
> >
> >         shrink_dentry_list(&list);
> >
> > @@ -1806,6 +1846,7 @@ static void umount_tree(struct mount *mnt, enum u=
mount_tree_flags how)
> >                 change_mnt_propagation(p, MS_PRIVATE);
> >                 if (disconnect)
> >                         hlist_add_head(&p->mnt_umount, &unmounted);
> > +               add_notify(p);
> >         }
> >  }
> >
> > @@ -2103,16 +2144,24 @@ struct mnt_namespace *__lookup_next_mnt_ns(stru=
ct mnt_namespace *mntns, bool pre
> >         }
> >  }
> >
> > +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry)
> > +{
> > +       if (!is_mnt_ns_file(dentry))
> > +               return NULL;
> > +
> > +       return to_mnt_ns(get_proc_ns(dentry->d_inode));
> > +}
> > +
> >  static bool mnt_ns_loop(struct dentry *dentry)
> >  {
> >         /* Could bind mounting the mount namespace inode cause a
> >          * mount namespace loop?
> >          */
> > -       struct mnt_namespace *mnt_ns;
> > -       if (!is_mnt_ns_file(dentry))
> > +       struct mnt_namespace *mnt_ns =3D mnt_ns_from_dentry(dentry);
> > +
> > +       if (!mnt_ns)
> >                 return false;
> >
> > -       mnt_ns =3D to_mnt_ns(get_proc_ns(dentry->d_inode));
> >         return current->nsproxy->mnt_ns->seq >=3D mnt_ns->seq;
> >  }
> >
> > @@ -2505,6 +2554,7 @@ static int attach_recursive_mnt(struct mount *sou=
rce_mnt,
> >                         dest_mp =3D smp;
> >                 unhash_mnt(source_mnt);
> >                 attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
> > +               add_notify(source_mnt);
> >                 touch_mnt_namespace(source_mnt->mnt_ns);
> >         } else {
> >                 if (source_mnt->mnt_ns) {
> > @@ -4420,6 +4470,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, =
new_root,
> >         list_del_init(&new_mnt->mnt_expire);
> >         put_mountpoint(root_mp);
> >         unlock_mount_hash();
> > +       add_notify(root_mnt);
> > +       add_notify(new_mnt);
> >         chroot_fs_refs(&root, &new);
> >         error =3D 0;
> >  out4:
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index 24c7c5df4998..a9dc004291bf 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_e=
vent *old,
> >         case FANOTIFY_EVENT_TYPE_FS_ERROR:
> >                 return fanotify_error_event_equal(FANOTIFY_EE(old),
> >                                                   FANOTIFY_EE(new));
> > +       case FANOTIFY_EVENT_TYPE_MNT:
> > +               return false;
> >         default:
> >                 WARN_ON_ONCE(1);
> >         }
> > @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsnoti=
fy_group *group,
> >         pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_type=3D=
%d\n",
> >                  __func__, iter_info->report_mask, event_mask, data, da=
ta_type);
> >
> > -       if (!fid_mode) {
> > +       if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > +       {
> > +               if (data_type !=3D FSNOTIFY_EVENT_MNT)
> > +                       return 0;
> > +       } else if (!fid_mode) {
> >                 /* Do we have path to open a file descriptor? */
> >                 if (!path)
> >                         return 0;
> > @@ -548,6 +554,20 @@ static struct fanotify_event *fanotify_alloc_path_=
event(const struct path *path,
> >         return &pevent->fae;
> >  }
> >
> > +static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp=
_t gfp)
> > +{
> > +       struct fanotify_mnt_event *pevent;
> > +
> > +       pevent =3D kmem_cache_alloc(fanotify_mnt_event_cachep, gfp);
> > +       if (!pevent)
> > +               return NULL;
> > +
> > +       pevent->fae.type =3D FANOTIFY_EVENT_TYPE_MNT;
> > +       pevent->mnt_id =3D mnt_id;
> > +
> > +       return &pevent->fae;
> > +}
> > +
> >  static struct fanotify_event *fanotify_alloc_perm_event(const struct p=
ath *path,
> >                                                         gfp_t gfp)
> >  {
> > @@ -715,6 +735,7 @@ static struct fanotify_event *fanotify_alloc_event(
> >                                               fid_mode);
> >         struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_ty=
pe, dir);
> >         const struct path *path =3D fsnotify_data_path(data, data_type)=
;
> > +       u64 mnt_id =3D fsnotify_data_mnt_id(data, data_type);
> >         struct mem_cgroup *old_memcg;
> >         struct dentry *moved =3D NULL;
> >         struct inode *child =3D NULL;
> > @@ -810,8 +831,10 @@ static struct fanotify_event *fanotify_alloc_event=
(
> >                                                   moved, &hash, gfp);
> >         } else if (fid_mode) {
> >                 event =3D fanotify_alloc_fid_event(id, fsid, &hash, gfp=
);
> > -       } else {
> > +       } else if (path) {
> >                 event =3D fanotify_alloc_path_event(path, &hash, gfp);
> > +       } else /* if (mnt_id) */ {

I don't love this style. I understand why you don't like
the existing "assuming else" style either.
Since we handle !event case anyway, I would rather that we use
} else if (mnt_id) {
...
} else {
        WARN_ON_ONCE(1);
}

> > +               event =3D fanotify_alloc_mnt_event(mnt_id, gfp);
> >         }
> >
> >         if (!event)
> > @@ -910,7 +933,7 @@ static int fanotify_handle_event(struct fsnotify_gr=
oup *group, u32 mask,
> >         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
> >         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
> >
> > -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> > +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 23);
> >
> >         mask =3D fanotify_group_event_mask(group, iter_info, &match_mas=
k,
> >                                          mask, data, data_type, dir);
> > @@ -1011,6 +1034,11 @@ static void fanotify_free_error_event(struct fsn=
otify_group *group,
> >         mempool_free(fee, &group->fanotify_data.error_events_pool);
> >  }
> >
> > +static void fanotify_free_mnt_event(struct fanotify_event *event)
> > +{
> > +       kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
> > +}
> > +
> >  static void fanotify_free_event(struct fsnotify_group *group,
> >                                 struct fsnotify_event *fsn_event)
> >  {
> > @@ -1037,6 +1065,9 @@ static void fanotify_free_event(struct fsnotify_g=
roup *group,
> >         case FANOTIFY_EVENT_TYPE_FS_ERROR:
> >                 fanotify_free_error_event(group, event);
> >                 break;
> > +       case FANOTIFY_EVENT_TYPE_MNT:
> > +               fanotify_free_mnt_event(event);
> > +               break;
> >         default:
> >                 WARN_ON_ONCE(1);
> >         }
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index e5ab33cae6a7..f1a7cbedc9e3 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -9,6 +9,7 @@ extern struct kmem_cache *fanotify_mark_cache;
> >  extern struct kmem_cache *fanotify_fid_event_cachep;
> >  extern struct kmem_cache *fanotify_path_event_cachep;
> >  extern struct kmem_cache *fanotify_perm_event_cachep;
> > +extern struct kmem_cache *fanotify_mnt_event_cachep;
> >
> >  /* Possible states of the permission event */
> >  enum {
> > @@ -244,6 +245,7 @@ enum fanotify_event_type {
> >         FANOTIFY_EVENT_TYPE_PATH_PERM,
> >         FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> >         FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
> > +       FANOTIFY_EVENT_TYPE_MNT,
> >         __FANOTIFY_EVENT_TYPE_NUM
> >  };
> >
> > @@ -409,12 +411,23 @@ struct fanotify_path_event {
> >         struct path path;
> >  };
> >
> > +struct fanotify_mnt_event {
> > +       struct fanotify_event fae;
> > +       u64 mnt_id;
> > +};
> > +
> >  static inline struct fanotify_path_event *
> >  FANOTIFY_PE(struct fanotify_event *event)
> >  {
> >         return container_of(event, struct fanotify_path_event, fae);
> >  }
> >
> > +static inline struct fanotify_mnt_event *
> > +FANOTIFY_ME(struct fanotify_event *event)
> > +{
> > +       return container_of(event, struct fanotify_mnt_event, fae);
> > +}
> > +
> >  /*
> >   * Structure for permission fanotify events. It gets allocated and fre=
ed in
> >   * fanotify_handle_event() since we wait there for user response. When=
 the
> > @@ -456,6 +469,11 @@ static inline bool fanotify_is_error_event(u32 mas=
k)
> >         return mask & FAN_FS_ERROR;
> >  }
> >
> > +static inline bool fanotify_is_mnt_event(u32 mask)
> > +{
> > +       return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
> > +}
> > +
> >  static inline const struct path *fanotify_event_path(struct fanotify_e=
vent *event)
> >  {
> >         if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH)
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 2d85c71717d6..1e111730b6bf 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/memcontrol.h>
> >  #include <linux/statfs.h>
> >  #include <linux/exportfs.h>
> > +#include <linux/mnt_namespace.h>
> >
> >  #include <asm/ioctls.h>
> >
> > @@ -114,6 +115,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_i=
nit;
> >  struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
> >  struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
> >  struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
> > +struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
> >
> >  #define FANOTIFY_EVENT_ALIGN 4
> >  #define FANOTIFY_FID_INFO_HDR_LEN \
> > @@ -122,6 +124,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_=
after_init;
> >         sizeof(struct fanotify_event_info_pidfd)
> >  #define FANOTIFY_ERROR_INFO_LEN \
> >         (sizeof(struct fanotify_event_info_error))
> > +#define FANOTIFY_MNT_INFO_LEN \
> > +       (sizeof(struct fanotify_event_info_mnt))
> >
> >  static int fanotify_fid_info_len(int fh_len, int name_len)
> >  {
> > @@ -183,6 +187,8 @@ static size_t fanotify_event_len(unsigned int info_=
mode,
> >                 fh_len =3D fanotify_event_object_fh_len(event);
> >                 event_len +=3D fanotify_fid_info_len(fh_len, dot_len);
> >         }
> > +       if (fanotify_is_mnt_event(event->mask))
> > +               event_len +=3D FANOTIFY_MNT_INFO_LEN;
> >
> >         return event_len;
> >  }
> > @@ -380,6 +386,25 @@ static int process_access_response(struct fsnotify=
_group *group,
> >         return -ENOENT;
> >  }
> >
> > +static size_t copy_mnt_info_to_user(struct fanotify_event *event,
> > +                                   char __user *buf, int count)
> > +{
> > +       struct fanotify_event_info_mnt info =3D { };
> > +
> > +       info.hdr.info_type =3D FAN_EVENT_INFO_TYPE_MNT;
> > +       info.hdr.len =3D FANOTIFY_MNT_INFO_LEN;
> > +
> > +       if (WARN_ON(count < info.hdr.len))
> > +               return -EFAULT;
> > +
> > +       info.mnt_id =3D FANOTIFY_ME(event)->mnt_id;
> > +
> > +       if (copy_to_user(buf, &info, sizeof(info)))
> > +               return -EFAULT;
> > +
> > +       return info.hdr.len;
> > +}
> > +
> >  static size_t copy_error_info_to_user(struct fanotify_event *event,
> >                                       char __user *buf, int count)
> >  {
> > @@ -642,6 +667,14 @@ static int copy_info_records_to_user(struct fanoti=
fy_event *event,
> >                 total_bytes +=3D ret;
> >         }
> >
> > +       if (fanotify_is_mnt_event(event->mask)) {
> > +               ret =3D copy_mnt_info_to_user(event, buf, count);
> > +               if (ret < 0)
> > +                       return ret;
> > +               buf +=3D ret;
> > +               count -=3D ret;
> > +               total_bytes +=3D ret;
> > +       }
> >         return total_bytes;
> >  }
> >
> > @@ -1449,6 +1482,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >         if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
> >                 return -EINVAL;
> >
> > +       /* FIXME: check FAN_REPORT_MNT compatibility with other flags *=
/
> > +
> >         switch (event_f_flags & O_ACCMODE) {
> >         case O_RDONLY:
> >         case O_RDWR:
> > @@ -1718,6 +1753,9 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >         case FAN_MARK_FILESYSTEM:
> >                 obj_type =3D FSNOTIFY_OBJ_TYPE_SB;
> >                 break;
> > +       case FAN_MARK_MNTNS:
> > +               obj_type =3D FSNOTIFY_OBJ_TYPE_MNTNS;
> > +               break;
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -1765,6 +1803,19 @@ static int do_fanotify_mark(int fanotify_fd, uns=
igned int flags, __u64 mask,
> >                 return -EINVAL;
> >         group =3D fd_file(f)->private_data;
> >
> > +       /* Only report mount events on mnt namespace */
> > +       if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> > +               if (mask & ~FANOTIFY_MOUNT_EVENTS)
> > +                       return -EINVAL;
> > +               if (mark_type !=3D FAN_MARK_MNTNS)
> > +                       return -EINVAL;
> > +       } else {
> > +               if (mask & FANOTIFY_MOUNT_EVENTS)
> > +                       return -EINVAL;
> > +               if (mark_type =3D=3D FAN_MARK_MNTNS)
> > +                       return -EINVAL;
> > +       }
> > +
> >         /*
> >          * An unprivileged user is not allowed to setup mount nor files=
ystem
> >          * marks.  This also includes setting up such marks by a group =
that
> > @@ -1802,7 +1853,7 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >          * point.
> >          */
> >         fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > -       if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> > +       if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_=
EVENT_FLAGS) &&
> >             (!fid_mode || mark_type =3D=3D FAN_MARK_MOUNT))
> >                 return -EINVAL;
> >
> > @@ -1855,8 +1906,14 @@ static int do_fanotify_mark(int fanotify_fd, uns=
igned int flags, __u64 mask,
> >                 mnt =3D path.mnt;
> >                 if (mark_type =3D=3D FAN_MARK_MOUNT)
> >                         obj =3D mnt;
> > -               else
> > +               else if (mark_type =3D=3D FAN_MARK_FILESYSTEM)
> >                         obj =3D mnt->mnt_sb;
> > +               else /* if (mark_type =3D=3D FAN_MARK_MNTNS) */ {
> > +                       obj =3D mnt_ns_from_dentry(path.dentry);
> > +                       ret =3D -EINVAL;
> > +                       if (!obj)
> > +                               goto path_put_and_out;
> > +               }
> >         }

What triggers me here is the mix of {} and no {}, but actually this
code is clumsy to begin with because it is not clear to the reader the
later on the condition (mnt) is actually used to test "not an inode mark".
I think the code would look better like this:

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1767,7 +1767,6 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
                            int dfd, const char  __user *pathname)
 {
        struct inode *inode =3D NULL;
-       struct vfsmount *mnt =3D NULL;
        struct fsnotify_group *group;
        struct path path;
        struct fan_fsid __fsid, *fsid =3D NULL;
@@ -1938,16 +1937,17 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
        }

        /* inode held in place by reference to path; group by fget on fd */
-       if (mark_type =3D=3D FAN_MARK_INODE) {
+       if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_INODE) {
                inode =3D path.dentry->d_inode;
                obj =3D inode;
-       } else {
-               mnt =3D path.mnt;
-               if (mark_type =3D=3D FAN_MARK_MOUNT)
-                       obj =3D mnt;
-               else
-                       obj =3D mnt->mnt_sb;
+       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
+               obj =3D path.mnt;
+       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
+               obj =3D path.mnt->mnt_sb;
        }
+       ret =3D -EINVAL;
+       if (!obj)
+               goto path_put_and_out;

        /*
         * If some other task has this inode open for write we should not a=
dd
@@ -1956,10 +1956,10 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
         */
        if (mark_cmd =3D=3D FAN_MARK_ADD && (flags & FANOTIFY_MARK_IGNORE_B=
ITS) &&
            !(flags & FAN_MARK_IGNORED_SURV_MODIFY)) {
-               ret =3D mnt ? -EINVAL : -EISDIR;
+               ret =3D !inode ? -EINVAL : -EISDIR;
                /* FAN_MARK_IGNORE requires SURV_MODIFY for
sb/mount/dir marks */
                if (ignore =3D=3D FAN_MARK_IGNORE &&
-                   (mnt || S_ISDIR(inode->i_mode)))
+                   (!inode || S_ISDIR(inode->i_mode)))
                        goto path_put_and_out;

                ret =3D 0;
@@ -1968,7 +1968,7 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
        }

        /* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
-       if (mnt || !S_ISDIR(inode->i_mode)) {
+       if (!inode || !S_ISDIR(inode->i_mode)) {
                mask &=3D ~FAN_EVENT_ON_CHILD;
                umask =3D FAN_EVENT_ON_CHILD;
                /*
---

Thanks,
Amir.

