Return-Path: <linux-fsdevel+bounces-40073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3412A1BCE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13884188CCE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED12248B2;
	Fri, 24 Jan 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PFJhowTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE021D8DFB
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747540; cv=none; b=mWWYvUcvlqn1bDW5yKt+xBtgXQTz3/HxE0TF+/GMTpsdKRni7jkHP+YIcgOEJB56UyIxEZ2tTj6OU6Jygy2eZ8rFmD8IQH79bYwPz93D+xW7GWWY5Sg9rxPETYRW4sI55PcAGsAEviq9da+dQiMN9i0f0W533ERxhoQp3So0dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747540; c=relaxed/simple;
	bh=8UMR/gQQF3RMFssteNVSoeA1kuoejtce9j8ARsQuuHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtYNDcnBGfw1pPwhuciJB4JT2HZ8Grw2WKvHfeGS8KeLsSzzaTWcA1KW8+jz5LII09Y9d8YXY39gAHcghD+DtDmJZWC82AJjJ699F5k88BjyWPJjz4OZr0HVOhDbF0LWOnHDG5pOBfUNBbs6wVbMfffHJOpNy2FhQ4njKTgrlbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PFJhowTX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so3464240276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737747536; x=1738352336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MnwjjVLsJJ71yflbceZSLRp2hbWGVT+m0L0+NVZyek=;
        b=PFJhowTXhPdBXrotG0XjaEzKyP8dxnXRfzdjO44sSAmkQ8OFm/ijcO6LhaYutOGjiB
         17HjHUvj5fc6aVdpOBO7TnSKmKuwvROFsbNy49gIVmn8hZdG/J1qeHL6dEJcgYDeNPTJ
         13ENyzyw3+d0uPZYaaYQGQ4imbkwEhEyCzu+raDWMDKG2JZtwhyNC27v0q0qwwqAHFy4
         wyYjKrtr4HuC5bHxkiGzKxix5qutnIdszb/CLoZ4RGOe4HheXWMPVIwwuAs2QySpZuK9
         u89a4fHxnltOmNc7hbKxL/uwiiXKWkcXP3nGfgZbY9fezS3WRkkXEmow8T0QZpkArPYS
         nciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737747536; x=1738352336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MnwjjVLsJJ71yflbceZSLRp2hbWGVT+m0L0+NVZyek=;
        b=l8fZ3yQPMpg635YA4FOV9AMR6GC8uDCOHDvhb3YBnSxRhHn9t75HDdCVC93L/eto5I
         qD485rM28IDwNRtE3a4CWUeHj/Lnv9f0EhK+17IyRBIX6nZLnIunv2UvxGQeWZJpkc2O
         gBNixbSWWU5IkahTL3R7dFpHLoPDXGOlunqrmZqo19z/UC+hqFjGN36HOiJ012iflE1N
         F0FJttdXlcO5DhvC22Igi+01cqCILaM26Ce6JI8J1A/Ll41R/4o6WY5SO4pAiZ9/vkp3
         Uw+ZMCBRLTDgGRu+h6nfi8t3Z0CIeG6kIzgSa9N3Alg3pbx4J72XnCEsC44EUEh8ZI8V
         4pFw==
X-Gm-Message-State: AOJu0YwDpwUIx+P3W11WWuhWkXWBM5u0f/kxcFdcBmPQeYGErBEarvfq
	4jQO+pYKdQPPyCznihL+TWp4zpmVQWZ/X+Yni0YugGOCdJkOcf/5xwTqzbStPQXXyNF6BFYJit8
	6MJhcDHW4AfzkqJ0qBlAq3eMOcmATroK07T2j
X-Gm-Gg: ASbGncvYTfm+d74vVZJaAZrBHVDFsMIlYhefUQnO8THFoSuGzPj4BYczlLhyVnrQk6X
	nPTHbDHdFvE7ijNT6SIobn1CEDZTx6IUIaMwnsGRzwD24j7YQYmYDpXocphrc
X-Google-Smtp-Source: AGHT+IHOCS66Uhbsw8Qwv5XfosQhMf8xEtFXBNBvA5lhAKuC21uFqV3YGhMWunrSZ0D39V2s9OYDimXWlP88CG/XiVU=
X-Received: by 2002:a05:690c:4d02:b0:6ef:4a1f:36aa with SMTP id
 00721157ae682-6f6eb684195mr278781017b3.20.1737747536016; Fri, 24 Jan 2025
 11:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-3-mszeredi@redhat.com>
In-Reply-To: <20250123194108.1025273-3-mszeredi@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Jan 2025 14:38:45 -0500
X-Gm-Features: AWEUYZkALCpcQM22xsBMODdNr33jbIcfGuS2w3uTvbEb10KPXNVglUEApFRl1RA
Message-ID: <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:41=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add notifications for attaching and detaching mounts.

Adding the SELinux list to my reply as things like this really should
go to the full list.  For those of you seeing this for the first time,
the full patchset from Miklos can be found at the lore link below.
Policy folks, please read my comments at the bottom, there is a
question for you there.

https://lore.kernel.org/linux-security-module/20250123194108.1025273-1-msze=
redi@redhat.com

> The following new event masks are added:
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
> Marks are added with FAN_MARK_MNTNS, which records the mount namespace fr=
om
> an nsfs file (e.g. /proc/self/ns/mnt).

The policy folks can correct me, but to put some context on this
(pardon the pun), I believe most public SELinux policies label the
nsfs files based on the associated process, e.g. if sshd is running in
the sshd_t domain, the /proc/<sshd>/ns files will be labeled as
sshd_t.

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/mount.h                         |  2 +
>  fs/namespace.c                     | 14 +++--
>  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
>  fs/notify/fanotify/fanotify.h      | 18 +++++++
>  fs/notify/fanotify/fanotify_user.c | 86 +++++++++++++++++++++++++-----
>  fs/notify/fdinfo.c                 |  5 ++
>  include/linux/fanotify.h           | 12 +++--
>  include/uapi/linux/fanotify.h      | 10 ++++
>  security/selinux/hooks.c           |  4 ++
>  9 files changed, 166 insertions(+), 23 deletions(-)

I'll refrain from trimming the original patch for easier viewing by
the SELinux folks.

> diff --git a/fs/mount.h b/fs/mount.h
> index 33311ad81042..9689e7bf4501 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -174,3 +174,5 @@ static inline struct mnt_namespace *to_mnt_ns(struct =
ns_common *ns)
>  {
>         return container_of(ns, struct mnt_namespace, ns);
>  }
> +
> +struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index eac057e56948..4d9072fd1263 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2101,16 +2101,24 @@ struct mnt_namespace *__lookup_next_mnt_ns(struct=
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
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 24c7c5df4998..b1937f92f105 100644
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
> @@ -303,7 +305,10 @@ static u32 fanotify_group_event_mask(struct fsnotify=
_group *group,
>         pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_type=3D%d=
\n",
>                  __func__, iter_info->report_mask, event_mask, data, data=
_type);
>
> -       if (!fid_mode) {
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> +               if (data_type !=3D FSNOTIFY_EVENT_MNT)
> +                       return 0;
> +       } else if (!fid_mode) {
>                 /* Do we have path to open a file descriptor? */
>                 if (!path)
>                         return 0;
> @@ -548,6 +553,20 @@ static struct fanotify_event *fanotify_alloc_path_ev=
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
> @@ -715,6 +734,7 @@ static struct fanotify_event *fanotify_alloc_event(
>                                               fid_mode);
>         struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type=
, dir);
>         const struct path *path =3D fsnotify_data_path(data, data_type);
> +       u64 mnt_id =3D fsnotify_data_mnt_id(data, data_type);
>         struct mem_cgroup *old_memcg;
>         struct dentry *moved =3D NULL;
>         struct inode *child =3D NULL;
> @@ -810,8 +830,12 @@ static struct fanotify_event *fanotify_alloc_event(
>                                                   moved, &hash, gfp);
>         } else if (fid_mode) {
>                 event =3D fanotify_alloc_fid_event(id, fsid, &hash, gfp);
> -       } else {
> +       } else if (path) {
>                 event =3D fanotify_alloc_path_event(path, &hash, gfp);
> +       } else if (mnt_id) {
> +               event =3D fanotify_alloc_mnt_event(mnt_id, gfp);
> +       } else {
> +               WARN_ON_ONCE(1);
>         }
>
>         if (!event)
> @@ -910,7 +934,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
>         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 23);
>
>         mask =3D fanotify_group_event_mask(group, iter_info, &match_mask,
>                                          mask, data, data_type, dir);
> @@ -1011,6 +1035,11 @@ static void fanotify_free_error_event(struct fsnot=
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
> @@ -1037,6 +1066,9 @@ static void fanotify_free_event(struct fsnotify_gro=
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
> index 2d85c71717d6..da97eb01e2fa 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -114,6 +114,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_ini=
t;
>  struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
>  struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
>  struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
> +struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
>
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
> @@ -122,6 +123,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_af=
ter_init;
>         sizeof(struct fanotify_event_info_pidfd)
>  #define FANOTIFY_ERROR_INFO_LEN \
>         (sizeof(struct fanotify_event_info_error))
> +#define FANOTIFY_MNT_INFO_LEN \
> +       (sizeof(struct fanotify_event_info_mnt))
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -183,6 +186,8 @@ static size_t fanotify_event_len(unsigned int info_mo=
de,
>                 fh_len =3D fanotify_event_object_fh_len(event);
>                 event_len +=3D fanotify_fid_info_len(fh_len, dot_len);
>         }
> +       if (fanotify_is_mnt_event(event->mask))
> +               event_len +=3D FANOTIFY_MNT_INFO_LEN;
>
>         return event_len;
>  }
> @@ -380,6 +385,25 @@ static int process_access_response(struct fsnotify_g=
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
> @@ -642,6 +666,14 @@ static int copy_info_records_to_user(struct fanotify=
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
> @@ -1446,6 +1478,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>         if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
>                 return -EINVAL;
>
> +       /* Don't allow mixing mnt events with inode events for now */
> +       if (flags & FAN_REPORT_MNT) {
> +               if (class !=3D FAN_CLASS_NOTIF)
> +                       return -EINVAL;
> +               if (flags & (FANOTIFY_FID_BITS | FAN_REPORT_FD_ERROR))
> +                       return -EINVAL;
> +       }
> +
>         if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
>                 return -EINVAL;
>
> @@ -1685,7 +1725,6 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>                             int dfd, const char  __user *pathname)
>  {
>         struct inode *inode =3D NULL;
> -       struct vfsmount *mnt =3D NULL;
>         struct fsnotify_group *group;
>         struct path path;
>         struct fan_fsid __fsid, *fsid =3D NULL;
> @@ -1718,6 +1757,9 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
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
> @@ -1765,6 +1807,19 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
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
> @@ -1802,7 +1857,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
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
> @@ -1848,17 +1903,21 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>         }
>
>         /* inode held in place by reference to path; group by fget on fd =
*/
> -       if (mark_type =3D=3D FAN_MARK_INODE) {
> +       if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_INODE) {
>                 inode =3D path.dentry->d_inode;
>                 obj =3D inode;
> -       } else {
> -               mnt =3D path.mnt;
> -               if (mark_type =3D=3D FAN_MARK_MOUNT)
> -                       obj =3D mnt;
> -               else
> -                       obj =3D mnt->mnt_sb;
> +       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> +               obj =3D path.mnt;
> +       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
> +               obj =3D path.mnt->mnt_sb;
> +       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
> +               obj =3D mnt_ns_from_dentry(path.dentry);
>         }
>
> +       ret =3D -EINVAL;
> +       if (!obj)
> +               goto path_put_and_out;
> +
>         /*
>          * If some other task has this inode open for write we should not=
 add
>          * an ignore mask, unless that ignore mask is supposed to survive
> @@ -1866,10 +1925,10 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>          */
>         if (mark_cmd =3D=3D FAN_MARK_ADD && (flags & FANOTIFY_MARK_IGNORE=
_BITS) &&
>             !(flags & FAN_MARK_IGNORED_SURV_MODIFY)) {
> -               ret =3D mnt ? -EINVAL : -EISDIR;
> +               ret =3D !inode ? -EINVAL : -EISDIR;
>                 /* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir =
marks */
>                 if (ignore =3D=3D FAN_MARK_IGNORE &&
> -                   (mnt || S_ISDIR(inode->i_mode)))
> +                   (!inode || S_ISDIR(inode->i_mode)))
>                         goto path_put_and_out;
>
>                 ret =3D 0;
> @@ -1878,7 +1937,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         }
>
>         /* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
> -       if (mnt || !S_ISDIR(inode->i_mode)) {
> +       if (!inode || !S_ISDIR(inode->i_mode)) {
>                 mask &=3D ~FAN_EVENT_ON_CHILD;
>                 umask =3D FAN_EVENT_ON_CHILD;
>                 /*
> @@ -1952,7 +2011,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 13);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> @@ -1965,6 +2024,7 @@ static int __init fanotify_user_setup(void)
>                 fanotify_perm_event_cachep =3D
>                         KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
>         }
> +       fanotify_mnt_event_cachep =3D KMEM_CACHE(fanotify_mnt_event, SLAB=
_PANIC);
>
>         fanotify_max_queued_events =3D FANOTIFY_DEFAULT_MAX_EVENTS;
>         init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =3D
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index e933f9c65d90..1161eabf11ee 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -121,6 +121,11 @@ static void fanotify_fdinfo(struct seq_file *m, stru=
ct fsnotify_mark *mark)
>
>                 seq_printf(m, "fanotify sdev:%x mflags:%x mask:%x ignored=
_mask:%x\n",
>                            sb->s_dev, mflags, mark->mask, mark->ignore_ma=
sk);
> +       } else if (mark->connector->type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) =
{
> +               struct mnt_namespace *mnt_ns =3D fsnotify_conn_mntns(mark=
->connector);
> +
> +               seq_printf(m, "fanotify mnt_ns:%u mflags:%x mask:%x ignor=
ed_mask:%x\n",
> +                          mnt_ns->ns.inum, mflags, mark->mask, mark->ign=
ore_mask);
>         }
>  }
>
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..fc142be2542d 100644
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
> +                                FANOTIFY_MOUNT_EVENTS)
>
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS   (FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 34f221d3a1b9..69340e483ae7 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -25,6 +25,8 @@
>  #define FAN_OPEN_PERM          0x00010000      /* File open in perm chec=
k */
>  #define FAN_ACCESS_PERM                0x00020000      /* File accessed =
in perm check */
>  #define FAN_OPEN_EXEC_PERM     0x00040000      /* File open/exec in perm=
 check */
> +#define FAN_MNT_ATTACH         0x01000000      /* Mount was attached */
> +#define FAN_MNT_DETACH         0x02000000      /* Mount was detached */
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
> index 171dd7fceac5..d2b3e60e2be9 100644
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

If I understand the commit description correctly,
security_path_notify(path, mask, FSNOTIFY_OBJ_TYPE_MNTNS) indicates a
change in the mount namespace indicated by the @path parameter, with
the initial mntns changes being limited to attach/detach and possibly
some other attributes (see patch 4/4), although the latter looks like
it will probably happen at a later date.

My initial thinking is that if we limit ourselves to existing SELinux
policy permissions, this is much more of FILE__WATCH_MOUNT operation
rather than a FILE__WATCH operation as while the /proc/PID/ns/mnt file
specified in @path is simply a file, it represents much more than
that.  However, it we want to consider adding a new SELinux policy
permission (which is easy to do), we may want to consider adding a new
mount namespace specific permission, e.g. FILE__WATCH_MOUNTNS, this
would make it easier for policy developers to distinguish between
watching a traditional mount point and a mount namespace (although
given the common approaches to labeling this may not be very
significant).  I'd personally like to hear from the SELinux policy
folks on this (the SELinux reference policy has also been CC'd).

If we reuse the file/watch_mount permission the policy rule would look
something like below where <subject> is the SELinux domain of the
process making the change, and <mntns_label> is the label of the
/proc/PID/ns/mnt file:

  allow <subject> <mntns_label>:file { watch_mount };

If we add a new file/watch_mountns permission the policy rule would
look like this:

  allow <subject> <mntns_label>:file { watch_mountns };

>         default:
>                 return -EINVAL;
>         }
> --
> 2.47.1

--=20
paul-moore.com

