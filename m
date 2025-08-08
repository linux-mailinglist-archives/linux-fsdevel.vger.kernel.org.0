Return-Path: <linux-fsdevel+bounces-57113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A02B1ED07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A02189C128
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEDB157E6B;
	Fri,  8 Aug 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz6AoM//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69354287275
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670628; cv=none; b=cSmNnnDwOtLZZDB4rA6y02wa4qJNweXasuFE+P2E3tHBkH9PCEUgqdvFqcPjv/CTxUx26/elgrr6jA0+bO7ZVmoH2LnuHhtlgbQ8TItB9iArgCDqIkQNMeRDMTE9977xYxTtW/o0M+EtijXwMbZ3PC2bB8gBxJd2E9JxMIyVu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670628; c=relaxed/simple;
	bh=h17W2epHr5RpS17+v/qZpIHdILrqqe7vsykKiwAqAkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxBH2t3XwQYD4u4Z3xjK57gP2R4TO/Ec7BBYtb7YbtfMwMbUFtGO+8mLJCGM2g+g3bWHKu0BiJ2uL+WFPRP7YiOzxqN7yRtfGUAxXWdiFz84qlcThAoBMRc46t0u+6fqBzsLrz5fBDUXhB+q0ITB3ZSlpsWFTd3TsN3ilUWqvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz6AoM//; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so3711107a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754670625; x=1755275425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4+7gkfuvejDkwX6eLFrE8LV0I8uxm1uuZz2yZsB/j4=;
        b=Cz6AoM//aAz7T3CG1CyZ0iy4YZfctwRKhmXorYHHHt3t0HetWeVAfOAxs5nC+e5j0y
         Madgico1NqC2nbp+0pR4rktcPQgPi8CfgoRKqOzN+Vfx7JhXcneXcsEPo6Nim/u/sE9s
         RDHnKiZ1bpTexkX9/5e24dPnqAv0x9CBADI9MzwXpWs1M50io1Bvh1LlVF7oy5DMRGa0
         6qxx+9+iYwbQHuJhb22m++oGneSzs7CjGKet4xv6i+Hh4GuhtdLMuvkBTnm9CSsTAmgY
         8TB5X/Kj1eWOdv4KYAgk4umOA/jIp9p7R3oZhplwEF+7GayFlzP0L8nqM4HLnFaGfzlH
         uAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670625; x=1755275425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4+7gkfuvejDkwX6eLFrE8LV0I8uxm1uuZz2yZsB/j4=;
        b=tq886MuUhUt74lyti5YXGWQgSJF0hsvmqC/KT3GChP94lMy8rEIqOo0gGGRuT/po2g
         0s4wLCA2hynh1MpgBU6FMgFQF5r+RowJDZpS+HT9m7lgV0soKsL+k6wfuB2LQxPS2cjJ
         MLVLIzkP3btWSYZTXf6P3VKL0tLnjDWle2Yaahd7o5mTbL3MZIizcoqUAxQdqwZ5m1LR
         edmizKASAmobvK+amqZ7HAE4p1O1SqX/VCYC596PdYegdqC06xKyLSZJA/nMFy3AZDmB
         Lm13I09pN70BGBOVVOpYn9sXXX773XP39nden0RJjv+E9Cyer5jezpA5M/q1FPpQBzsZ
         tRiw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRFhRa2JLVmhvqZE5h3AHT4AojYA+LefbNrmiU5m/kW8eg60/3O7xO+QgNZvHMXwv1lfNJhMVGf4tfR/W@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuZ2npCfxSfuRWFl+tUrVt5VYxBa5jjMGLhY/UPNuAfWRJ+5F
	aPzRNyjkf9+bYIT+vD4ZYeDKQNlowzxVz3XJCZRCdydYHnq92pXvYYn7uJMTe+ZNigCDM0qUckP
	NmPlOlPqbC5HQR1MzHMjsw6+7Bg97yX65SzX7dCU=
X-Gm-Gg: ASbGncsPkBxLKBmIwsa2r0y7RwBO/GAPLWahIbPq1dNf+wNj4NiyK8Mdaxy+SU+4Oly
	yo/OTj7H09/XS0nr3O0mEoLwR0Z3oZUmvqbyaxcegS2nudeF17bZ5bGW0Vi1DjTPo+q6PXIcIHQ
	c3mxLPh8WHQqVIhJUeRrwtfv0Qos7fQx3hglPw8Eodh3wj7wXue87flf/hrUPX7blOLsK1xoCbb
	AFHzqYGWJexG93nuw==
X-Google-Smtp-Source: AGHT+IEmtBnbLtt5E99xAzZcYeYxxFcAr6j0vUuZKA/ky9H9bavdiy9FWSw0nu92aAe5vYlBuhddb64U7dk8sL7JIdk=
X-Received: by 2002:a17:907:3f1b:b0:ae0:da2d:1a53 with SMTP id
 a640c23a62f3a-af9c6541576mr265128766b.42.1754670624254; Fri, 08 Aug 2025
 09:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220516.953114-1-ibrahimjirdeh@meta.com> <20250806220516.953114-3-ibrahimjirdeh@meta.com>
In-Reply-To: <20250806220516.953114-3-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Aug 2025 18:30:12 +0200
X-Gm-Features: Ac12FXym9xj6L0tLRCrfbOi7UBNRx9MV3r0c40Q4kWTjb0WoySE4zBHZapuUnUo
Message-ID: <CAOQ4uxh7Jbgm-ceV7koL_uOxfhZ2U9BURVn_B3X3pGeF3Ob_VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: introduce restartable permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 12:06=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> This add support for restarting permission events. The main goal of
> the change is to provide better handling for pending events for lazy
> file loading use cases which may back fanotify events by a long-lived
> daemon. For prior discussion of approaches see [1][2].
>
> In terms of implementation, we add a new control-fd/queue-fd api.
> Control fd returned by fanotify_init keeps fanotify group alive and
> supports operations like fanotify_mark as well as a new ioctl
> FAN_IOC_OPEN_QUEUE_FD to issue user a queue fd. Queue fd is used
> for reading events and writing back responses. Upon release of
> queue fd, pending permission events are reinserted back into
> notification queue for reprocessing.
>
> Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> events can added to the mark mask if a group initialize with
> FAN_RESTARTABLE_EVENTS.
>
> [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr
> [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahi=
mjirdeh@meta.com
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=
=3DqL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---

Looking good overall.
I have some implementation comments, but they are mostly minor technical
details.

>  fs/notify/fanotify/fanotify.h       |   4 +
>  fs/notify/fanotify/fanotify_user.c  | 111 ++++++++++++++++++++++++++--
>  fs/notify/group.c                   |   2 +
>  include/linux/fanotify.h            |   1 +
>  include/linux/fsnotify_backend.h    |   2 +
>  include/uapi/linux/fanotify.h       |   6 ++
>  tools/include/uapi/linux/fanotify.h |   6 ++
>  7 files changed, 125 insertions(+), 7 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index c0dffbc3370d..5cf25e7ad2d8 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -556,3 +556,7 @@ extern void fanotify_insert_event(struct fsnotify_gro=
up *group,
>
>  extern int fanotify_merge(struct fsnotify_group *group,
>         struct fsnotify_event *event);
> +
> +extern const struct file_operations fanotify_fops;
> +extern const struct file_operations fanotify_control_fops;
> +extern const struct file_operations fanotify_queue_fops;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 01d273d35936..8d5266be78a2 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1011,6 +1011,7 @@ static void clear_queue(struct file *file, bool res=
tart_events)
>          * restart is requested, move them back into the notification que=
ue
>          * for reprocessing, otherwise simulate a reply from userspace.
>          */
> +       mutex_lock(&group->queue_mutex);
>         spin_lock(&group->notification_lock);
>         while (!list_empty(&group->fanotify_data.access_list)) {
>                 struct fanotify_perm_event *event;
> @@ -1043,8 +1044,17 @@ static void clear_queue(struct file *file, bool re=
start_events)
>                 spin_lock(&group->notification_lock);
>         }
>         spin_unlock(&group->notification_lock);
> +       group->queue_opened =3D false;
> +       mutex_unlock(&group->queue_mutex);
>  }
>
> +static int fanotify_queue_release(struct inode *ignored, struct file *fi=
le)
> +{
> +       clear_queue(file, true);
> +       return 0;
> +}
> +
> +
>  static int fanotify_release(struct inode *ignored, struct file *file)
>  {
>         struct fsnotify_group *group =3D file->private_data;
> @@ -1092,6 +1102,47 @@ static int fanotify_release(struct inode *ignored,=
 struct file *file)
>         return 0;
>  }
>
> +static int fanotify_open_queue_fd(struct file *file)
> +{
> +       struct fsnotify_group *group =3D file->private_data;
> +       int f_flags, fd;
> +       struct file *queue_file;
> +
> +       if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
> +               return -EINVAL;
> +
> +       mutex_lock(&group->queue_mutex);
> +       if (group->queue_opened) {
> +               fd =3D -EEXIST;

This is more an exclusive open than an exclusive creation,
so EBUSY feels more appropriate.

> +               goto out_unlock;
> +       }
> +
> +       f_flags =3D O_RDWR;
> +       if (group->fanotify_data.flags & FAN_CLOEXEC)
> +               f_flags |=3D O_CLOEXEC;
> +       if (group->fanotify_data.flags & FAN_NONBLOCK)
> +               f_flags |=3D O_NONBLOCK;
> +
> +       fd =3D get_unused_fd_flags(f_flags);
> +       if (fd < 0)
> +               goto out_unlock;
> +
> +       queue_file =3D anon_inode_getfile_fmode("[fanotify]",

This is mostly for nice printing in /proc so how about [fanotify-queue]?

I believe that CRIU will actually try to restore [fanotify] fd from
the init flags and marks, so printing this as fd as [fanotify] could
mess up CRIU.
OTOH, CRIU that doesn't know about FAN_IOC_OPEN_QUEUE_FD,
has no chance of restoring this group.
I hope they look at init flags and bail out for unknown flags,
but not sure they do.

> +                                             &fanotify_queue_fops, group=
,
> +                                             f_flags, FMODE_NONOTIFY);
> +       if (IS_ERR(queue_file)) {
> +               put_unused_fd(fd);
> +               fd =3D PTR_ERR(queue_file);
> +               goto out_unlock;
> +       }
> +       fd_install(fd, queue_file);
> +       group->queue_opened =3D true;
> +
> +out_unlock:
> +       mutex_unlock(&group->queue_mutex);
> +       return fd;
> +}
> +
>  static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
>  {
>         struct fsnotify_group *group;
> @@ -1112,12 +1163,15 @@ static long fanotify_ioctl(struct file *file, uns=
igned int cmd, unsigned long ar
>                 spin_unlock(&group->notification_lock);
>                 ret =3D put_user(send_len, (int __user *) p);
>                 break;
> +       case FAN_IOC_OPEN_QUEUE_FD:
> +               ret =3D fanotify_open_queue_fd(file);
> +               break;
>         }
>
>         return ret;
>  }
>
> -static const struct file_operations fanotify_fops =3D {
> +const struct file_operations fanotify_fops =3D {
>         .show_fdinfo    =3D fanotify_show_fdinfo,
>         .poll           =3D fanotify_poll,
>         .read           =3D fanotify_read,
> @@ -1129,6 +1183,30 @@ static const struct file_operations fanotify_fops =
=3D {
>         .llseek         =3D noop_llseek,
>  };
>
> +const struct file_operations fanotify_control_fops =3D {
> +       .show_fdinfo    =3D fanotify_show_fdinfo,
> +       .poll           =3D NULL,
> +       .read           =3D NULL,
> +       .write          =3D NULL,
> +       .fasync         =3D NULL,

no need to add the NULL fields.
I have no idea why .fasync  =3D NULL exists in fanotify_fops
It must be an oversight(?)

> +       .release        =3D fanotify_release,
> +       .unlocked_ioctl =3D fanotify_ioctl,
> +       .compat_ioctl   =3D compat_ptr_ioctl,

I'm afraid that FIONREAD ioctl only applied to queue fd
(it's a query about expected bytes returned from read())
so you'd need fanotify_control_ioctl() or something like that.
There is no need for compat_ioctl since open fd ioctl takes no
ptr argument.

> +       .llseek         =3D noop_llseek,
> +};
> +
> +const struct file_operations fanotify_queue_fops =3D {
> +       .show_fdinfo    =3D fanotify_show_fdinfo,

This prints info about group and marks
I don't think it is appropriate for queue fd.
It would have been nice to print some info that would allow
userspace to associate this [fanotify-queue] fd with the [fanotify] fd,
but I can't think of a valid identifier that we can use, so just leave
unassigned.

> +       .poll           =3D fanotify_poll,
> +       .read           =3D fanotify_read,
> +       .write          =3D fanotify_write,
> +       .fasync         =3D NULL,
> +       .release        =3D fanotify_queue_release,
> +       .unlocked_ioctl =3D NULL,
> +       .compat_ioctl   =3D compat_ptr_ioctl,
> +       .llseek         =3D noop_llseek,
> +};
> +
>  static int fanotify_find_path(int dfd, const char __user *filename,
>                               struct path *path, unsigned int flags, __u6=
4 mask,
>                               unsigned int obj_type)
> @@ -1541,6 +1619,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         int f_flags, fd;
>         unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
>         unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
> +       unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVENT=
S;
>         unsigned int internal_flags =3D 0;
>         struct file *file;
>
> @@ -1620,10 +1699,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>             (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID=
)))
>                 return -EINVAL;
>
> -       f_flags =3D O_RDWR;
> +       /*
> +        * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
> +        * FAN_CLASS_PRE_CONTENT
> +        */
> +       if (restartable_events && class =3D=3D FAN_CLASS_NOTIF)
> +               return -EINVAL;
> +
> +       f_flags =3D restartable_events ? O_RDONLY : O_RDWR;
>         if (flags & FAN_CLOEXEC)
>                 f_flags |=3D O_CLOEXEC;
> -       if (flags & FAN_NONBLOCK)
> +       if (!restartable_events && (flags & FAN_NONBLOCK))
>                 f_flags |=3D O_NONBLOCK;
>
>         /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release=
 */
> @@ -1694,8 +1780,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>         if (fd < 0)
>                 goto out_destroy_group;
>
> -       file =3D anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, g=
roup,
> -                                       f_flags, FMODE_NONOTIFY);
> +       file =3D anon_inode_getfile_fmode("[fanotify]",
> +                                       (restartable_events ? &fanotify_c=
ontrol_fops :
> +                                       &fanotify_fops),
> +                                       group, f_flags, FMODE_NONOTIFY);
>         if (IS_ERR(file)) {
>                 put_unused_fd(fd);
>                 fd =3D PTR_ERR(file);
> @@ -1920,7 +2008,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>                 return -EBADF;
>
>         /* verify that this is indeed an fanotify instance */
> -       if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops))
> +       if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
> +               fd_file(f)->f_op !=3D &fanotify_control_fops))
>                 return -EINVAL;
>         group =3D fd_file(f)->private_data;
>
> @@ -1937,6 +2026,14 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                         return -EINVAL;
>         }
>
> +       /*
> +        * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
> +        * permission events
> +        */
> +       if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
> +               !fanotify_is_perm_event(mask))
> +               return -EINVAL;
> +
>         /*
>          * A user is allowed to setup sb/mount/mntns marks only if it is
>          * capable in the user ns where the group was created.
> @@ -2142,7 +2239,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index 18446b7b0d49..949a8023a7e4 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -25,6 +25,7 @@ static void fsnotify_final_destroy_group(struct fsnotif=
y_group *group)
>                 group->ops->free_group_priv(group);
>
>         mem_cgroup_put(group->memcg);
> +       mutex_destroy(&group->queue_mutex);
>         mutex_destroy(&group->mark_mutex);
>
>         kfree(group);
> @@ -130,6 +131,7 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>         init_waitqueue_head(&group->notification_waitq);
>         group->max_events =3D UINT_MAX;
>
> +       mutex_init(&group->queue_mutex);
>         mutex_init(&group->mark_mutex);
>         INIT_LIST_HEAD(&group->marks_list);
>
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 879cff5eccd4..38854a1d6485 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -37,6 +37,7 @@
>                                          FAN_REPORT_TID | \
>                                          FAN_REPORT_PIDFD | \
>                                          FAN_REPORT_FD_ERROR | \
> +                                        FAN_RESTARTABLE_EVENTS | \
>                                          FAN_UNLIMITED_QUEUE | \
>                                          FAN_UNLIMITED_MARKS)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index d4034ddaf392..1203124dc9e8 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -231,6 +231,8 @@ struct fsnotify_group {
>         unsigned int max_events;                /* maximum events allowed=
 on the list */
>         enum fsnotify_group_prio priority;      /* priority for sending e=
vents */
>         bool shutdown;          /* group is being shut down, don't queue =
more events */
> +       bool queue_opened; /* whether or not a queue fd has been issued *=
/
> +       struct mutex queue_mutex; /* protects event queue during open / r=
elease */

Semantically, these belong in fanotify_data as they are only referenced in
fanotify code (except for the init/destroy that could be moved).
But TBH, it doesn't matter so much to me, so please move them
only if it's not too painful.

Thanks,
Amir.

