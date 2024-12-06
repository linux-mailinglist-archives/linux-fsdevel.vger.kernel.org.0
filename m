Return-Path: <linux-fsdevel+bounces-36669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0A9E7816
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048F728271E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49F203D4C;
	Fri,  6 Dec 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOmXCkCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DC204569
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509772; cv=none; b=c+/qh1MnWyQNwcMfdv46nvOHJZIo4oysi/IBLA4qwcWrEYFj060SqbUpKZBzwG7ogmi/Kxnimk8DpMfUddhId/7vo2EEhBYfqPmptQReVYiMCouaoxPCNWcsz6475Sm6ib7jALtI/Y40alxtH/YuuwSRK6pcMcqzlY5TzSL+62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509772; c=relaxed/simple;
	bh=9d4z1jO9kz1jnNcyQApx9StSxkKRegL30Wj9VRTmQx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMZnyAZV82rP1iAplvsSg0N2XjY1m2vTXi3A81PVa2fif/LA+2OwkXKz0O1eb1tvAez1L5iAZpNkXXKvtOYWZTzQRrFUzRiK5FmM3fQI84m06TTRzyVgE9Edk+DjPzxxcf0YoobuEDriI5eqQ0kMS2IzoBq/jy2gxUC5Ky4NrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOmXCkCe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa63dbda904so201545066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509768; x=1734114568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYzpFQvZ5izEGs/MzMexYVzWtfLohR5IsKWhw0NXYXk=;
        b=YOmXCkCexVV0Wal2NS/FAYRm/BRok3Nmv4Xof865tR48u7DR9+0IA2nviFT/gwHdDa
         g+7Wnx74+KKrpZElGSqWazCEEsPNPBjhq2XdD5VEDuNJu/9zz2nVAWN5mQrW4aD1qlIO
         Ofg2Qbn7Qe1vKQcoPiIVL0TISvsvOJaslWQvKx9AFA/J3gACynPODhTOVCWUnwMA/H5X
         1fTpkkYgoSHgksnTZ2qvBvIPHf+1eJBxd4oQUGpf9fNCi4JE9Q9r6X8sA57nCGjs6jFV
         V2SCK7BmWpLSziu/Wua7GW2sDzSIRJDv0h/bvTxJOypmH1U5JZkGimjdeRuv9AJAmul2
         l25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509768; x=1734114568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYzpFQvZ5izEGs/MzMexYVzWtfLohR5IsKWhw0NXYXk=;
        b=OxcyvRm4e8N12t/sxrUua8pu96fCccuMnlpSTiSbs8yEIlFnvLZg43zYprXGd9DSjD
         digQI6XWamewgk2v5lzYcldnTcbzPtDe8lyif7f8GNvnk3GzGYBHq050vfKgjlcxSh7p
         YGFldfKlQjITthK6fy5k97MA/i5bqbs4y9OMjbujaXLXUNfT3hg2gEVB8PijSbqyfAjz
         i8VbPIgjZZdJF3Yo0R4ZjUDtWNIeLn12vlVN/34S0dGVtMu2UxTck9PEZouycIw0rFLH
         biCd7n21kKnTQjLoQKmh/u4hJ30q+TX4ach+/gyQqUeXYm2ZqpeRAAvhZV/AlsRfa7bp
         RruQ==
X-Gm-Message-State: AOJu0Yw50kplNuQp1tSbOfvx+6Rs19LXvxeKD6hmPged+bHSYWSIEIrV
	JcKtSfeCk4lRZJNdQMPEGXInr65RGFYaBt9T7CVIlMbguHrQ2oSQwpolEfjQmcJIKKYTt1fVnA8
	wgZEzP1MZ5gLKAk0z5V+HMzHMDjU=
X-Gm-Gg: ASbGncsbuIBbvIgzYCwHubbTp5NFHdkqruJffOeJ9qEZskzEaCWxS4HVfc4fvNPPNGP
	1xeoaPfaLZtWV4MmgQhqsstCUd8Akt7A=
X-Google-Smtp-Source: AGHT+IHwyP54wRLqyoe0d6RR/9HcOlf15K+Yn+bhjdyseBRE3n1ObkGlt3UgNt13poJR7fgtH0IEQJ6FLmnwQ90rRkY=
X-Received: by 2002:a17:906:1da1:b0:aa6:256a:40a7 with SMTP id
 a640c23a62f3a-aa63a00ab34mr309320866b.22.1733509767452; Fri, 06 Dec 2024
 10:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206151154.60538-1-mszeredi@redhat.com>
In-Reply-To: <20241206151154.60538-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 6 Dec 2024 19:29:16 +0100
Message-ID: <CAOQ4uxhG9h6vBEyw9tZ0bMygZO=3VH5FmvxffRaLNUAyH9UYaw@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:12=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
>
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
>
> If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> FAN_MNT_DETACH).

This makes sense under the conditions that:
1. Mount events are not merged (true)
2. User requested to watch the mask (FAN_MNT_ATTACH | FAN_MNT_DETACH)

Because with fanotify the event mask is used both as a filter for subscribe
and as a filter to the reported event->mask, so with your current patch
a user watching only FAN_MNT_DETACH, will get a FAN_MNT_DETACH
event on mount move. Is that the intention?

Is there even a use case for watching only attach or only detach?
Are we ever likely to add more mount events besides attach/detach?
If the answers are no and no, then I think we should consider forcing
to set and clear the mount events together.

There are more simplifications that follow if we make that decision...

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
>         - notify for whole namespace as this seems to be what people pref=
er
>         - move fsnotify() calls outside of mount_lock
>         - only report mnt_id, not parent_id
>
> diff --git a/fs/mount.h b/fs/mount.h
> index 185fc56afc13..a79232a8c908 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -14,6 +14,10 @@ struct mnt_namespace {
>         u64                     seq;    /* Sequence number to prevent loo=
ps */
>         wait_queue_head_t poll;
>         u64 event;
> +#ifdef CONFIG_FSNOTIFY
> +       __u32                   n_fsnotify_mask;

There is no point in this "optimization" mask if all the mntns
marks are interested in all the two possible mount events.
The "optimization" would not have been needed even if we would allow watchi=
ng
only attach or detach, but I guess this helps keeping the code generic...

> +       struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
> +#endif
>         unsigned int            nr_mounts; /* # of mounts in the namespac=
e */
>         unsigned int            pending_mounts;
>         struct rb_node          mnt_ns_tree_node; /* node in the mnt_ns_t=
ree */
> @@ -77,6 +81,13 @@ struct mount {
>         int mnt_expiry_mark;            /* true if marked for expiry */
>         struct hlist_head mnt_pins;
>         struct hlist_head mnt_stuck_children;
> +
> +       /*
> +        * for mount notification
> +        * FIXME: maybe move to a union with some other fields?
> +        */
> +       struct list_head to_notify; /* singly linked list? */
> +       struct mnt_namespace *prev_ns;
>  } __randomize_layout;
>

I am not going to comment about the vfs part only on the
fanotify/fsnotify parts....

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 24c7c5df4998..39ebc4da1f00 100644
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
> @@ -303,17 +305,19 @@ static u32 fanotify_group_event_mask(struct fsnotif=
y_group *group,
>         pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_type=3D%d=
\n",
>                  __func__, iter_info->report_mask, event_mask, data, data=
_type);
>
> -       if (!fid_mode) {
> -               /* Do we have path to open a file descriptor? */
> -               if (!path)
> -                       return 0;
> -               /* Path type events are only relevant for files and dirs =
*/
> -               if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry=
))
> -                       return 0;
> -       } else if (!(fid_mode & FAN_REPORT_FID)) {
> -               /* Do we have a directory inode to report? */
> -               if (!dir && !ondir)
> -                       return 0;
> +       if (data_type !=3D FSNOTIFY_EVENT_MNT) {

Until we allow mixing other mark type (e.g. ignore mount mark for
specific mount)
and if we mandate watching both mount events, then all the logic below
is irrelevant
and if (data_type =3D=3D FSNOTIFY_EVENT_MNT) can always
     return FANOTIFY_MOUNT_EVENTS;

> +               if (!fid_mode) {
> +                       /* Do we have path to open a file descriptor? */
> +                       if (!path)
> +                               return 0;
> +                       /* Path type events are only relevant for files a=
nd dirs */
> +                       if (!d_is_reg(path->dentry) && !d_can_lookup(path=
->dentry))
> +                               return 0;
> +               } else if (!(fid_mode & FAN_REPORT_FID)) {
> +                       /* Do we have a directory inode to report? */
> +                       if (!dir && !ondir)
> +                               return 0;
> +               }
>         }
>
>         fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> @@ -548,6 +552,20 @@ static struct fanotify_event *fanotify_alloc_path_ev=
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
> @@ -715,6 +733,7 @@ static struct fanotify_event *fanotify_alloc_event(
>                                               fid_mode);
>         struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type=
, dir);
>         const struct path *path =3D fsnotify_data_path(data, data_type);
> +       u64 mnt_id =3D fsnotify_data_mnt_id(data, data_type);
>         struct mem_cgroup *old_memcg;
>         struct dentry *moved =3D NULL;
>         struct inode *child =3D NULL;
> @@ -810,10 +829,13 @@ static struct fanotify_event *fanotify_alloc_event(
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
> +
>         if (!event)
>                 goto out;
>
> @@ -910,7 +932,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
>         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 23);
>
>         mask =3D fanotify_group_event_mask(group, iter_info, &match_mask,
>                                          mask, data, data_type, dir);
> @@ -1011,6 +1033,11 @@ static void fanotify_free_error_event(struct fsnot=
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
> @@ -1037,6 +1064,9 @@ static void fanotify_free_event(struct fsnotify_gro=
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
> index 2d85c71717d6..83ca8766b791 100644
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
> @@ -1688,6 +1723,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         struct vfsmount *mnt =3D NULL;
>         struct fsnotify_group *group;
>         struct path path;
> +       struct mnt_namespace *mntns =3D NULL;
>         struct fan_fsid __fsid, *fsid =3D NULL;
>         u32 valid_mask =3D FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
>         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> @@ -1718,6 +1754,9 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
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
> @@ -1742,7 +1781,6 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         if (mask & ~valid_mask)
>                 return -EINVAL;
>
> -
>         /* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK togethe=
r */
>         if (ignore =3D=3D (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
>                 return -EINVAL;
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
> @@ -1855,8 +1906,18 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                 mnt =3D path.mnt;
>                 if (mark_type =3D=3D FAN_MARK_MOUNT)
>                         obj =3D mnt;
> -               else
> +               else if (mark_type =3D=3D FAN_MARK_FILESYSTEM)
>                         obj =3D mnt->mnt_sb;
> +               else /* if (mark_type =3D=3D FAN_MARK_MNTNS) */ {
> +                       mntns =3D get_ns_from_mnt(mnt);
> +                       ret =3D -EINVAL;
> +                       if (!mntns)
> +                               goto path_put_and_out;
> +                       /* don't allow anon ns yet */
> +                       if (is_anon_ns(mntns))
> +                               goto path_put_and_out;
> +                       obj =3D mntns;
> +               }
>         }
>
>         /*
> @@ -1905,6 +1966,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         }
>
>  path_put_and_out:
> +       if (mntns)
> +               mnt_ns_release(mntns);
>         path_put(&path);
>         return ret;
>  }
> @@ -1952,7 +2015,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 13);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> @@ -1965,6 +2028,7 @@ static int __init fanotify_user_setup(void)
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
> index f976949d2634..61159c623df5 100644
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
> @@ -623,11 +636,28 @@ int fsnotify(__u32 mask, const void *data, int data=
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
> +       /* FIXME: is this the proper way to check if fsnotify_init() ran?=
 */
> +       if (!fsnotify_mark_connector_cachep)
> +               return;

checking if (ns->n_fsnotify_marks) is easier.
marks cannot be added before boot completed and user requested to add marks=
.

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
> index a799e0315cc9..203276b1e23f 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_rest=
ore)
>                         mp =3D parent->mnt_mp;
>                         parent =3D parent->mnt_parent;
>                 }
> -               if (parent !=3D mnt->mnt_parent)
> +               if (parent !=3D mnt->mnt_parent) {
> +                       /* FIXME: does this need to trigger a MOVE fsnoti=
fy event */
>                         mnt_change_mountpoint(parent, mp, mnt);
> +               }
>         }
>  }
>
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..801af8012730 100644
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
> @@ -90,7 +91,7 @@
>                                  FAN_RENAME)
>
>  /* Events that can be reported with event->fd */
> -#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
> +#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS =
| FANOTIFY_MOUNT_EVENTS)

mount events are not reported with event->fd.
The condition that uses FANOTIFY_FD_EVENTS needs to be fixed
to accommodate the case of mount events.


        if (mask &
~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&

or some less ugly version of this

Thanks,
Amir.

