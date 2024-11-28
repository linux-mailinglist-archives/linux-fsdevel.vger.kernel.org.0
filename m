Return-Path: <linux-fsdevel+bounces-36101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504469DBB77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11106281AB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4621C07DA;
	Thu, 28 Nov 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqzGZFkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C31C07C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812248; cv=none; b=JxXoNDf+JXed+pW47uNyXe4Ip4lBYXIIZE7Me/wUzEWRAj9yEkUAfyG1a68yYBm59yZPuYPkVkces1eMWWiuhHu0bvg6JjFHvVh4+cjA+q4Uhuyj7QAT1q8IZqUocEhYzPmD4dW0jqLw2TsFCX5AOmYX5DRxx6siE6HkV6O9xPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812248; c=relaxed/simple;
	bh=WBBXyZKPTyp+JaWVOvZzqHpcEnaBDw2qpx5BOZLYCvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TS2OR1VXXoCMxBbapX697b32ra1Q0irpoylCaociKS3xvdm3Zgj5ImXJVSjJ43HdxBHP4AtKet3M4vybEWOGqd1FTbcME4K7aO2MvKJbw/afOZohPSYvX8vlL+ewVLWLGYZTIA03y8wS4iqCbNlacZWEzchTkmqhpjIK4Z7PfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqzGZFkD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ec267b879so132829366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732812244; x=1733417044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8skRHScvF7gO4/kSAwu5VJdlukvXLOjyNAnLvbxXpa8=;
        b=UqzGZFkDbn+5MlH/J9UwMCwdbn2sCezI4uVgPDc04JKTeeIiAmIE7ijak/6d7wFw9e
         4zTin9teSnVcz9qs6d6QpaCOF/FAeeL1R3FdbDXLDQi6bUE4IUbqMPIAMqV970wZRaZA
         TiMbB9yzGlfBXMirsPpB9QaQVFfYJd0xj9erVQSzURh0oi8tVO8tebRlyjOWGN//4qiB
         Voc+DSt/7FE2EOVMRp/7hRPIJU0+L395A6MeruWaShoX0LHM/xMgbi8uoSX2yJdmY7/7
         PwkpaK+RyxT2qcOhZxjjvB9C85yJXlhb/0lxX6I8swG6IJzfiVZYM+VSGhPMPlMYvOsH
         LxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732812244; x=1733417044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8skRHScvF7gO4/kSAwu5VJdlukvXLOjyNAnLvbxXpa8=;
        b=H9EMLy1pw+H4FwY1BYhB3rLU5w2+keD0U0ulomgwHpc0DdZiwHKj+rWjkKpr8epAOU
         ftIghbptz5iAtDloj2codowH0TwSm9FMoG+e2jsb2QSmSTDLiEc2PsYlYVOHamAxHsz2
         a9Nxdy4Wnm+awvPUr3R0EDYtseo1mz00g8otZH5SLgDn2CrEhUzSMMaRoHQq5yYvBbKm
         1TB2g46uVyteX8Ml8a4ZLik9HH5P305DA5LZoFVGqMwWdbMAS6SWW+359ByTzXVHQstd
         BoqwVF7N75W2bbKg2kV8x/ee62XcIh0Y2+eo0Vb3q9xOpOqPsvDIvzDv5Sb5mMFlImAG
         urSw==
X-Gm-Message-State: AOJu0Yx8VXJ6yHf77BKhIb6a9B+GSCFczAVsWpN+0YOfF+clhuVNARhB
	uv1RqwBYFD9HYBwstD4uITdyId/BGkSIaqLbmyjVontfQCFzK1innAQMMFrJqVkPku+dmgNuiQu
	jFgDKQ8oYPs2p7Zl19+CqMGoe3Cs=
X-Gm-Gg: ASbGncv6cg3Dga8Fw2VnX+wINgj5RgqQScNXBdtR1K/uXrRzqmygMjuSUwsNxw4kimo
	XyAVVTZpt0q+45j5UfDi4i1aMqYvf9cI=
X-Google-Smtp-Source: AGHT+IHMdfUhNKpRA0M60Z7M0Z3rwuPplqB1Gy2iBKwD/59EmxkXqOJi5+pzehzib0sc7m4FT5sfei+w1Yzd+lOZCNg=
X-Received: by 2002:a17:907:7744:b0:aa5:297a:ac65 with SMTP id
 a640c23a62f3a-aa580f1ae33mr621455866b.19.1732812243583; Thu, 28 Nov 2024
 08:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com>
In-Reply-To: <20241128144002.42121-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Nov 2024 17:43:52 +0100
Message-ID: <CAOQ4uxjAvpOnGp32OnsOKujivECgY1iV+UiBF_woDsxNSyJN_A@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 3:40=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
>
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
>
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containin=
g
> these fields identifying the affected mounts:
>
>   __u64 mnt_id    - the attached or detached mount
>   __u64 parent_id - where the mount was attached to or detached from
>

Nice! some comments below.
FYI, this conflicts with almost every part of Jan's fsnotify_hsm branch
including event macro assignments etc.

> The mountpoint object (file or directory) is also contained in the event
> either as an FD or a FID.
>

This sounds good, but do the watchers actually need this information
or is it redundant to parent_id?

How is the mount monitoring application expected to be using this informati=
on?
If it is not going to be useful or is redundant maybe we do not send it??

> Adding marks with FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM both work.
>
> FAN_MARK_INODE doesn't, not sure why.  I think it might make sense to mak=
e
> it work, i.e. allow watching a single mountpoint.

The inode that is queried for fsnotify marks is the inode argument to
fsnotify(), so you need to pass non NULL in that argument.

Watching a single mountpoint makes sense, as long as it is clear that
FAN_EVENT_ON_CHILD for watching the parent of several mountpoints
is not supported (I don't think we want that).

This makes the interface somewhat confusing when mixing non-mount
events that are supported in parent watches.

Another confusing thing is whether the FAN_ONDIR filter is applicable
to FAN_MNT_ events. The way you implemented them it does not
because the event is never reported with FS_ISDIR.
I think this is correct, just needs to be documented.
If we are NOT reporting fd/fid, then this point is less confusing IMO.

To reduce API complexity and test matrix, my suggestion is that:
FAN_MNT_* event cannot be mixed with other events in the same group
i.e. the role of mount namespace monitoring application is not related to
filesystem namespace monitoring and the two should not be using the same
group/event-queue.

The simplest way to implement this (if there is an agreement) is to require
opt-in on fanotify_init with FAN_REPORT_MNTID and require that only
FAN_MARK_* events can be set in such a group and not in other groups.

If we are not sure that reporting fd/fid is needed, then we can limit
FAN_REPORT_MNTID | FAN_REPORT_*FID now and consider adding it later.

WDYT?

>
> Prior to this patch mount namespace changes could be monitored by polling
> /proc/self/mountinfo, which did not convey any information about what
> changed.
>
> To monitor an entire mount namespace with this new interface, watches nee=
d
> to be added to all existing mounts.  This can be done by performing
> listmount()/statmount() recursively at startup and when a new mount is
> added.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/namespace.c                     | 23 +++++++++++++++++
>  fs/notify/fanotify/fanotify.c      | 10 +++++++-
>  fs/notify/fanotify/fanotify.h      |  7 +++++
>  fs/notify/fanotify/fanotify_user.c | 41 ++++++++++++++++++++++++++++++
>  fs/notify/fsnotify.c               |  2 +-
>  include/linux/fanotify.h           |  7 +++--
>  include/linux/fsnotify.h           | 18 +++++++++++++
>  include/linux/fsnotify_backend.h   | 30 +++++++++++++++++++++-
>  include/uapi/linux/fanotify.h      |  9 +++++++
>  9 files changed, 142 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6b0a17487d0f..7724c78df945 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -988,12 +988,24 @@ static void __touch_mnt_namespace(struct mnt_namesp=
ace *ns)
>         }
>  }
>
> +static inline void __fsnotify_mnt_detach(struct mount *mnt)
> +{
> +       struct path mountpoint =3D {
> +               .mnt =3D &mnt->mnt_parent->mnt,
> +               .dentry =3D mnt->mnt_mountpoint,
> +       };
> +       fsnotify_mnt_detach(&mountpoint, &mnt->mnt);
> +}
> +
>  /*
>   * vfsmount lock must be held for write
>   */
>  static struct mountpoint *unhash_mnt(struct mount *mnt)
>  {
>         struct mountpoint *mp;
> +
> +       __fsnotify_mnt_detach(mnt);
> +
>         mnt->mnt_parent =3D mnt;
>         mnt->mnt_mountpoint =3D mnt->mnt.mnt_root;
>         list_del_init(&mnt->mnt_child);
> @@ -1027,6 +1039,15 @@ void mnt_set_mountpoint(struct mount *mnt,
>         hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
>  }
>
> +static inline void __fsnotify_mnt_attach(struct mount *mnt)
> +{
> +       struct path mountpoint =3D {
> +               .mnt =3D &mnt->mnt_parent->mnt,
> +               .dentry =3D mnt->mnt_mountpoint,
> +       };
> +       fsnotify_mnt_attach(&mountpoint, &mnt->mnt);
> +}
> +
>  /**
>   * mnt_set_mountpoint_beneath - mount a mount beneath another one
>   *
> @@ -1059,6 +1080,8 @@ static void __attach_mnt(struct mount *mnt, struct =
mount *parent)
>         hlist_add_head_rcu(&mnt->mnt_hash,
>                            m_hash(&parent->mnt, mnt->mnt_mountpoint));
>         list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
> +
> +       __fsnotify_mnt_attach(mnt);
>  }
>
>  /**
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 24c7c5df4998..9a93c9b58bd4 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -16,6 +16,7 @@
>  #include <linux/stringhash.h>
>
>  #include "fanotify.h"
> +#include "../../mount.h"
>
>  static bool fanotify_path_equal(const struct path *p1, const struct path=
 *p2)
>  {
> @@ -715,6 +716,9 @@ static struct fanotify_event *fanotify_alloc_event(
>                                               fid_mode);
>         struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type=
, dir);
>         const struct path *path =3D fsnotify_data_path(data, data_type);
> +       struct vfsmount *mnt =3D fsnotify_data_mnt(data, data_type);
> +       u64 mnt_id =3D mnt ? real_mount(mnt)->mnt_id_unique : 0;
> +       u64 parent_id =3D path ? real_mount(path->mnt)->mnt_id_unique : 0=
;
>         struct mem_cgroup *old_memcg;
>         struct dentry *moved =3D NULL;
>         struct inode *child =3D NULL;
> @@ -824,8 +828,12 @@ static struct fanotify_event *fanotify_alloc_event(
>
>         /* Mix event info, FAN_ONDIR flag and pid into event merge key */
>         hash ^=3D hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HA=
SH_BITS);
> +       hash ^=3D hash_64(mnt_id, FANOTIFY_EVENT_HASH_BITS);
> +       hash ^=3D hash_64(parent_id, FANOTIFY_EVENT_HASH_BITS);

You missed fanotify_should_merge(). IMO FAN_MNT_ events should never be mer=
ged
so not sure that mixing this data in the hash is needed.

>         fanotify_init_event(event, hash, mask);
>         event->pid =3D pid;
> +       event->mnt_id =3D mnt_id;
> +       event->parent_id =3D parent_id;
>
>  out:
>         set_active_memcg(old_memcg);
> @@ -910,7 +918,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
>         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 23);
>
>         mask =3D fanotify_group_event_mask(group, iter_info, &match_mask,
>                                          mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index e5ab33cae6a7..71cc9cb2335a 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -261,6 +261,8 @@ struct fanotify_event {
>                 unsigned int hash : FANOTIFY_EVENT_HASH_BITS;
>         };
>         struct pid *pid;
> +       u64 mnt_id;
> +       u64 parent_id;

There can be many fanotify_fid_event and fanotify_name_event in a queue
of filesystem monitor. It is not nice to burden this memory on them.

I think if we do not HAVE TO mix mntid info and fid info, then we better
stick with event->fd + mntid and add those fields to fanotify_path_event.
We can also inherit specialized fanotify_mnt_event, but I don't think this
is critical.??


>  };
>
>  static inline void fanotify_init_event(struct fanotify_event *event,
> @@ -456,6 +458,11 @@ static inline bool fanotify_is_error_event(u32 mask)
>         return mask & FAN_FS_ERROR;
>  }
>
> +static inline bool fanotify_is_mnt_event(u32 mask)
> +{
> +       return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);

mask & FANOTIFY_MOUNT_EVENTS;

> +}
> +
>  static inline const struct path *fanotify_event_path(struct fanotify_eve=
nt *event)
>  {
>         if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 2d85c71717d6..adf19e1a10bd 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -122,6 +122,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_af=
ter_init;
>         sizeof(struct fanotify_event_info_pidfd)
>  #define FANOTIFY_ERROR_INFO_LEN \
>         (sizeof(struct fanotify_event_info_error))
> +#define FANOTIFY_MNT_INFO_LEN \
> +       (sizeof(struct fanotify_event_info_mnt))
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -159,6 +161,9 @@ static size_t fanotify_event_len(unsigned int info_mo=
de,
>         int fh_len;
>         int dot_len =3D 0;
>
> +       if (fanotify_is_mnt_event(event->mask))
> +               event_len +=3D FANOTIFY_MNT_INFO_LEN;
> +
>         if (!info_mode)
>                 return event_len;
>
> @@ -380,6 +385,26 @@ static int process_access_response(struct fsnotify_g=
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
> +       info.mnt_id =3D event->mnt_id;
> +       info.parent_id =3D event->parent_id;
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
> @@ -656,6 +681,7 @@ static ssize_t copy_event_to_user(struct fsnotify_gro=
up *group,
>         unsigned int pidfd_mode =3D info_mode & FAN_REPORT_PIDFD;
>         struct file *f =3D NULL, *pidfd_file =3D NULL;
>         int ret, pidfd =3D -ESRCH, fd =3D -EBADF;
> +       int total_bytes =3D 0;
>
>         pr_debug("%s: group=3D%p event=3D%p\n", __func__, group, event);
>
> @@ -755,14 +781,29 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>
>         buf +=3D FAN_EVENT_METADATA_LEN;
>         count -=3D FAN_EVENT_METADATA_LEN;
> +       total_bytes +=3D FAN_EVENT_METADATA_LEN;
>
>         if (info_mode) {
>                 ret =3D copy_info_records_to_user(event, info, info_mode,=
 pidfd,
>                                                 buf, count);
>                 if (ret < 0)
>                         goto out_close_fd;
> +
> +               buf +=3D ret;
> +               count -=3D ret;
> +               total_bytes +=3D ret;
> +       }
> +
> +       if (fanotify_is_mnt_event(event->mask)) {
> +               ret =3D copy_mnt_info_to_user(event, buf, count);
> +               if (ret < 0)
> +                       goto out_close_fd;
> +
> +               total_bytes +=3D ret;
>         }

See patch "fanotify: don't skip extra event info if no info_mode is set"
in Jan's fsnotify_hsm branch.
This should be inside copy_info_records_to_user().

>
> +       WARN_ON(metadata.event_len !=3D total_bytes);
> +
>         if (f)
>                 fd_install(fd, f);
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index f976949d2634..1d5831b127e6 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -627,7 +627,7 @@ static __init int fsnotify_init(void)
>  {
>         int ret;
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) !=3D 23);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) !=3D 25);
>
>         ret =3D init_srcu_struct(&fsnotify_mark_srcu);
>         if (ret)
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..84e6f81bdb1b 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -90,7 +90,7 @@
>                                  FAN_RENAME)
>
>  /* Events that can be reported with event->fd */
> -#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
> +#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS =
| FANOTIFY_MOUNT_EVENTS)
>
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE =
*/
>  #define FANOTIFY_INODE_EVENTS  (FANOTIFY_DIRENT_EVENTS | \
> @@ -99,10 +99,13 @@
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
> index 278620e063ab..4129347e4f16 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -463,4 +463,22 @@ static inline int fsnotify_sb_error(struct super_blo=
ck *sb, struct inode *inode,
>                         NULL, NULL, NULL, 0);
>  }
>
> +static inline void fsnotify_mnt_attach(struct path *mountpoint, struct v=
fsmount *mnt)
> +{
> +       struct fsnotify_mnt data =3D {
> +               .path =3D mountpoint,
> +               .mnt =3D mnt,
> +       };
> +       fsnotify(FS_MNT_ATTACH, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NU=
LL, 0);
> +}
> +
> +static inline void fsnotify_mnt_detach(struct path *mountpoint, struct v=
fsmount *mnt)
> +{
> +       struct fsnotify_mnt data =3D {
> +               .path =3D mountpoint,
> +               .mnt =3D mnt,
> +       };
> +       fsnotify(FS_MNT_DETACH, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NU=
LL, 0);
> +}
> +
>  #endif /* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 3ecf7768e577..1e9c15ad64b6 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -56,6 +56,9 @@
>  #define FS_ACCESS_PERM         0x00020000      /* access event in a perm=
issions hook */
>  #define FS_OPEN_EXEC_PERM      0x00040000      /* open/exec event in a p=
ermission hook */
>
> +#define FS_MNT_ATTACH          0x00100000      /* Mount was attached */
> +#define FS_MNT_DETACH          0x00200000      /* Mount was detached */
> +
>  /*
>   * Set on inode mark that cares about things that happen to its children=
.
>   * Always set for dnotify and inotify.
> @@ -102,7 +105,7 @@
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
> @@ -288,6 +291,7 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_PATH,
>         FSNOTIFY_EVENT_INODE,
>         FSNOTIFY_EVENT_DENTRY,
> +       FSNOTIFY_EVENT_MNT,
>         FSNOTIFY_EVENT_ERROR,
>  };
>
> @@ -297,6 +301,11 @@ struct fs_error_report {
>         struct super_block *sb;
>  };
>
> +struct fsnotify_mnt {
> +       const struct path *path;
> +       struct vfsmount *mnt;
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int da=
ta_type)
>  {
>         switch (data_type) {
> @@ -306,6 +315,8 @@ static inline struct inode *fsnotify_data_inode(const=
 void *data, int data_type)
>                 return d_inode(data);
>         case FSNOTIFY_EVENT_PATH:
>                 return d_inode(((const struct path *)data)->dentry);
> +       case FSNOTIFY_EVENT_MNT:
> +               return d_inode(((struct fsnotify_mnt *)data)->path->dentr=
y);
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *)data)->inode;
>         default:
> @@ -321,6 +332,8 @@ static inline struct dentry *fsnotify_data_dentry(con=
st void *data, int data_typ
>                 return (struct dentry *)data;
>         case FSNOTIFY_EVENT_PATH:
>                 return ((const struct path *)data)->dentry;
> +       case FSNOTIFY_EVENT_MNT:
> +               return ((const struct fsnotify_mnt *)data)->path->dentry;
>         default:
>                 return NULL;
>         }
> @@ -332,6 +345,8 @@ static inline const struct path *fsnotify_data_path(c=
onst void *data,
>         switch (data_type) {
>         case FSNOTIFY_EVENT_PATH:
>                 return data;
> +       case FSNOTIFY_EVENT_MNT:
> +               return ((const struct fsnotify_mnt *)data)->path;
>         default:
>                 return NULL;
>         }
> @@ -347,6 +362,8 @@ static inline struct super_block *fsnotify_data_sb(co=
nst void *data,
>                 return ((struct dentry *)data)->d_sb;
>         case FSNOTIFY_EVENT_PATH:
>                 return ((const struct path *)data)->dentry->d_sb;
> +       case FSNOTIFY_EVENT_MNT:
> +               return ((const struct fsnotify_mnt *)data)->mnt->mnt_sb;
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *) data)->sb;
>         default:
> @@ -354,6 +371,17 @@ static inline struct super_block *fsnotify_data_sb(c=
onst void *data,
>         }
>  }
>
> +static inline struct vfsmount *fsnotify_data_mnt(const void *data,
> +                                                int data_type)
> +{
> +       switch (data_type) {
> +       case FSNOTIFY_EVENT_MNT:
> +               return ((const struct fsnotify_mnt *)data)->mnt;
> +       default:
> +               return NULL;
> +       }
> +}
> +
>  static inline struct fs_error_report *fsnotify_data_error_report(
>                                                         const void *data,
>                                                         int data_type)
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 34f221d3a1b9..8b2d47947bc2 100644
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
> @@ -143,6 +145,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID       3
>  #define FAN_EVENT_INFO_TYPE_PIDFD      4
>  #define FAN_EVENT_INFO_TYPE_ERROR      5
> +#define FAN_EVENT_INFO_TYPE_MNT                6
>
>  /* Special info types for FAN_RENAME */
>  #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME      10
> @@ -189,6 +192,12 @@ struct fanotify_event_info_error {
>         __u32 error_count;
>  };
>
> +struct fanotify_event_info_mnt {
> +       struct fanotify_event_info_header hdr;
> +       __u64 mnt_id;
> +       __u64 parent_id;
> +};
> +
>  /*
>   * User space may need to record additional information about its decisi=
on.
>   * The extra information type records what kind of information is includ=
ed.
> --
> 2.47.0
>

