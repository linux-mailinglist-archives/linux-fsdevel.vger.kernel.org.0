Return-Path: <linux-fsdevel+bounces-69128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 048DDC70756
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25EC4EED37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08E35B12B;
	Wed, 19 Nov 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDDAtNxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0E2FF660
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572822; cv=none; b=MgCoQ4hnE/H6b0FOfQBV4jh7vE/srbUKEYYbzU/ytqE/3LODvy2spd5LjsnqP9b4uNFcb8gBKLWVRhQmVUVAhYUoOMGrJWYcGIj88UzaATdbfQryVL/q6l3CPQSjX3sVD88ylp183VMBfuX1su/cWyzgffKXWZ6G/3qubGJkK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572822; c=relaxed/simple;
	bh=nwrUb8CRYXPmtiKaGbKckfkZqulSg07POIGJ6MQydeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iaz/n2oJ6qdw8H4ylgQC+1wWQqUEe/CKPfr90Z5k5eYucPOs0Pyo+BhnrDS0np3Zj3xBoiEgeE3aiAdN4Ki5VqK8Zc0YgyxXivw/6b64LerIrBLkSul0lNtKJ7LlvKDinmZyPxwl7HkcQ8sm4JN41S5tVt/RHUy+Lnyw2CZ8xOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDDAtNxT; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6574de1cda1so1792196eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763572818; x=1764177618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvg61x5/8oMI9qMKzJR3J4oGKwF9G/bV4i+z0z+k1f8=;
        b=ZDDAtNxTSPeuI3vcidPgC9DJAO7rgeGVzKcn0OVK0W4hapLACLQnLV7CsOhlpZiUVR
         d6ccpHup9JHPmEb6OJgh75gM6FvL5sob+FO5FZENGL7It09TBrOcO3MZz/Oo9Qqua/54
         uo66hJ1NXF+PPBmtbwzGOHHbbMM+sE/qZDI2zO40JizVGXQqI6gxl0UjzVDL6q8RqPaS
         Hl3EQkT+xqMJgQvy+KmwDYW6J8TQwk+3+b7pQkEczoXdq+YpA+Zz/kyLimJEReLqUBw+
         acD/Rx0BwPIz10zPzXAbWfqnuH03xuEpC5t9otStqr3do1hETlR2Uz0SLdqIsBSKLHM+
         4blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572818; x=1764177618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nvg61x5/8oMI9qMKzJR3J4oGKwF9G/bV4i+z0z+k1f8=;
        b=AxwZyE6A+rkqU2dxtge6BYEAIaFrDyDlAsf/URN4MPi8LbrPDUaKLjMNWNKUSuoT6Y
         xLuv+wT8K7eALguO8yld5Fza3JNikb9CR2HHvTcsytXRilr2I2VDyjW5p6s6393cQa7s
         Va28pOiws371bis6PE9zzbO3T2RB/B5okU1gbZJ89VwBZsWJHoDseZ1McqzEoXZ/UhaR
         z7tPNRpwuRkvByc0mw6tw8Qv+3mUIWPjnaTwaFLyAdCoRsPsed8P+QmujwtZDYQNvicU
         YMLRAmfVHPSfNDAqgwR91x/JWb3zt4QTScg1bSK9pdiarxZtJkvrawDknQ7LRduDeA/P
         03DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdKmO8CHePsJlQXHx07y8HqXoUR/4xRWLxb6tBLNxrchIQK456GKusNRI9IRcoC3AV3oaZwsXuG5TuaOw9@vger.kernel.org
X-Gm-Message-State: AOJu0Yygpp2Jhk7JpFOLSE+Ks1hFpXD8ePK99M5Q9ySBAqn6kIQFtXoc
	Rs4MaHsqkxVKZcOxpXDGK4Gp9sPxBiUn4c2zOAB+GQIEQ6MIXsl7P69yE8CiPpOrnK+alGITgx9
	eEP38izHipzBoNd/uRS/v0nSyHu/FkG0=
X-Gm-Gg: ASbGncshLpaPkt67Pow1tLTZhuOKEFDzajGDfndXlmUx9ITl8j95hJ5WRDrJo6m2Eit
	C06dti0+v+xONQsbD8GDUn3ijP9UyGY33NqSU89sYsL4onP1c6FnB+qFHV7wZGUTvaIxf84ZbC1
	Fzmj4HrqCvMxvDSQo0lpHAy0Q8EKJiAbhwCZHe1HPZi3Hljy45vHFsOMtNHlb7E3uOqjfdoA+1M
	Gb/AQC7EBLs3szLpgee23uJPF2wcau3Q0qN2ZdnzCq5UwhxF0lDXGn0LqAir1TuyfGY9E/Uttki
	OB9ZKR8=
X-Google-Smtp-Source: AGHT+IGKPgur4p0IUHzaDttJY7fPbrfjd802yiBdjKL2Lc3dpo6Z7xClxsOJdBjhR9vBzaXgicR/QwPfo5YrXCKKY/Q=
X-Received: by 2002:a05:6870:9619:b0:3d1:f53e:ba47 with SMTP id
 586e51a60fabf-3ec9a3d5d9bmr71394fac.24.1763572817469; Wed, 19 Nov 2025
 09:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118084836.2114503-1-b.sachdev1904@gmail.com> <20251118084836.2114503-3-b.sachdev1904@gmail.com>
In-Reply-To: <20251118084836.2114503-3-b.sachdev1904@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 19 Nov 2025 09:20:05 -0800
X-Gm-Features: AWmQ_bmLgoebhL5bptj_-CNY4siyrG2szLu07p34etPBYN5vjQ7wJbGZh4fmXFA
Message-ID: <CANaxB-zG3JQRzZSF+rwfGqLRP8eWvc+J1w+2yZoB5uk5jhGyPA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] statmount: accept fd as a parameter
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:49=E2=80=AFAM Bhavik Sachdev <b.sachdev1904@gmai=
l.com> wrote:
>
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
> flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
> will return mountinfo about the mount the fd is on.
>
> This even works for "unmounted" mounts (mounts that have been umounted
> using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
> on that mount. These "umounted" mounts will have no mountpoint and no
> valid mount namespace. Hence, we unset the STATMOUNT_MNT_POINT and
> STATMOUNT_MNT_NS_ID in statmount.mask for "unmounted" mounts.
>
> In case of STATMOUNT_BY_FD, given that we already have access to an fd
> on the mount, accessing mount information without a capability check
> seems fine because of the following reasons:
>
> - All fs related information is available via fstatfs() without any
>   capability check.
> - Mount information is also available via /proc/pid/mountinfo (without
>   any capability check).
> - Given that we have access to a fd on the mount which tells us that we
>   had access to the mount at some point (or someone that had access gave
>   us the fd). So, we should be able to access mount info.
>
> Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
> ---
>  fs/namespace.c             | 99 ++++++++++++++++++++++++++------------
>  include/uapi/linux/mount.h |  7 ++-
>  2 files changed, 74 insertions(+), 32 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ee36d67f1ac2..1c41c6e2304a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5563,29 +5563,41 @@ static int grab_requested_root(struct mnt_namespa=
ce *ns, struct path *root)
>
>  /* locks: namespace_shared */
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> -                       struct mnt_namespace *ns)
> +                       struct mnt_namespace *ns, unsigned int flags)
>  {
>         struct mount *m;
>         int err;
>
> -       /* Has the namespace already been emptied? */
> -       if (mnt_ns_id && mnt_ns_empty(ns))
> -               return -ENOENT;
> +       /* caller sets s->mnt in case of STATMOUNT_BY_FD */
> +       if (!(flags & STATMOUNT_BY_FD)) {
> +               /* Has the namespace already been emptied? */
> +               if (mnt_ns_id && mnt_ns_empty(ns))
> +                       return -ENOENT;
>
> -       s->mnt =3D lookup_mnt_in_ns(mnt_id, ns);
> -       if (!s->mnt)
> -               return -ENOENT;
> +               s->mnt =3D lookup_mnt_in_ns(mnt_id, ns);
> +               if (!s->mnt)
> +                       return -ENOENT;
> +       }
>
> -       err =3D grab_requested_root(ns, &s->root);
> -       if (err)
> -               return err;
> +       if (ns) {
> +               err =3D grab_requested_root(ns, &s->root);
> +               if (err)
> +                       return err;
> +       } else {
> +               /*
> +                * We can't set mount point and mnt_ns_id since we don't =
have a
> +                * ns for the mount. This can happen if the mount is unmo=
unted
> +                * with MNT_DETACH.
> +                */
> +               s->mask &=3D ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID)=
;
> +       }
>
>         /*
>          * Don't trigger audit denials. We just want to determine what
>          * mounts to show users.
>          */
>         m =3D real_mount(s->mnt);
> -       if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
> +       if (ns && !is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
>             !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
> @@ -5709,7 +5721,7 @@ static int prepare_kstatmount(struct kstatmount *ks=
, struct mnt_id_req *kreq,
>  }
>
>  static int copy_mnt_id_req(const struct mnt_id_req __user *req,
> -                          struct mnt_id_req *kreq)
> +                          struct mnt_id_req *kreq, unsigned int flags)
>  {
>         int ret;
>         size_t usize;
> @@ -5727,11 +5739,18 @@ static int copy_mnt_id_req(const struct mnt_id_re=
q __user *req,
>         ret =3D copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
>         if (ret)
>                 return ret;
> -       if (kreq->mnt_ns_fd !=3D 0 && kreq->mnt_ns_id)
> -               return -EINVAL;
> -       /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. *=
/
> -       if (kreq->mnt_id <=3D MNT_UNIQUE_ID_OFFSET)
> -               return -EINVAL;
> +
> +       if (flags & STATMOUNT_BY_FD) {
> +               if (kreq->mnt_id || kreq->mnt_ns_id)
> +                       return -EINVAL;
> +       } else {
> +               if (kreq->fd !=3D 0 && kreq->mnt_ns_id)
> +                       return -EINVAL;
> +
> +               /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSE=
T + 1. */
> +               if (kreq->mnt_id <=3D MNT_UNIQUE_ID_OFFSET)
> +                       return -EINVAL;
> +       }
>         return 0;
>  }
>
> @@ -5740,16 +5759,18 @@ static int copy_mnt_id_req(const struct mnt_id_re=
q __user *req,
>   * that, or if not simply grab a passive reference on our mount namespac=
e and
>   * return that.
>   */
> -static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_r=
eq *kreq)
> +static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_r=
eq *kreq,
> +                                                  unsigned int flags)

In patch, grab_requested_mnt_ns is always called with zero flags, do we
really need adding flags here?

>  {
>         struct mnt_namespace *mnt_ns;
>
>         if (kreq->mnt_ns_id) {
>                 mnt_ns =3D lookup_mnt_ns(kreq->mnt_ns_id);
> -       } else if (kreq->mnt_ns_fd) {
> +       /* caller sets mnt_ns in case of STATMOUNT_BY_FD */
> +       } else if (!(flags & STATMOUNT_BY_FD) && kreq->fd) {

I don't understand this part. If STATMOUNT_BY_FD is set, we take a
reference to the current mount namespace. What is the idea here?

It looks like we don't need to change this function at all.

>                 struct ns_common *ns;
>
> -               CLASS(fd, f)(kreq->mnt_ns_fd);
> +               CLASS(fd, f)(kreq->fd);
>                 if (fd_empty(f))
>                         return ERR_PTR(-EBADF);
>
> @@ -5777,25 +5798,38 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_re=
q __user *, req,
>  {
>         struct mnt_namespace *ns __free(mnt_ns_release) =3D NULL;
>         struct kstatmount *ks __free(kfree) =3D NULL;
> +       struct file *file_from_fd __free(fput) =3D NULL;
> +       struct vfsmount *fd_mnt;
>         struct mnt_id_req kreq;
>         /* We currently support retrieval of 3 strings. */
>         size_t seq_size =3D 3 * PATH_MAX;
>         int ret;
>
> -       if (flags)
> +       if (flags & ~STATMOUNT_BY_FD)
>                 return -EINVAL;
>
> -       ret =3D copy_mnt_id_req(req, &kreq);
> +       ret =3D copy_mnt_id_req(req, &kreq, flags);
>         if (ret)
>                 return ret;
>
> -       ns =3D grab_requested_mnt_ns(&kreq);
> -       if (IS_ERR(ns))
> -               return PTR_ERR(ns);
> +       if (flags & STATMOUNT_BY_FD) {
> +               file_from_fd =3D fget_raw(kreq.fd);
> +               if (!file_from_fd)
> +                       return -EBADF;
>
> -       if (kreq.mnt_ns_id && (ns !=3D current->nsproxy->mnt_ns) &&
> -           !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
> -               return -EPERM;
> +               fd_mnt =3D file_from_fd->f_path.mnt;
> +               ns =3D real_mount(fd_mnt)->mnt_ns;

I think accessing mnt_ns here should be guarded with a lock/rcu.

> +               if (ns)
> +                       refcount_inc(&ns->passive);
> +       } else {
> +               ns =3D grab_requested_mnt_ns(&kreq, 0);
> +               if (IS_ERR(ns))
> +                       return PTR_ERR(ns);
> +
> +               if (kreq.mnt_ns_id && (ns !=3D current->nsproxy->mnt_ns) =
&&
> +                   !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
> +                       return -EPERM;
> +       }
>
>         ks =3D kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
>         if (!ks)
> @@ -5806,8 +5840,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req=
 __user *, req,
>         if (ret)
>                 return ret;
>
> +       if (flags & STATMOUNT_BY_FD)
> +               ks->mnt =3D fd_mnt;
> +
>         scoped_guard(namespace_shared)
> -               ret =3D do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns)=
;
> +               ret =3D do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns,=
 flags);
>
>         if (!ret)
>                 ret =3D copy_statmount_to_user(ks);
> @@ -5916,7 +5953,7 @@ static inline int prepare_klistmount(struct klistmo=
unt *kls, struct mnt_id_req *
>         if (!kls->kmnt_ids)
>                 return -ENOMEM;
>
> -       ns =3D grab_requested_mnt_ns(kreq);
> +       ns =3D grab_requested_mnt_ns(kreq, 0);
>         if (IS_ERR(ns))
>                 return PTR_ERR(ns);
>         kls->ns =3D ns;
> @@ -5947,7 +5984,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req =
__user *, req,
>         if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
>                 return -EFAULT;
>
> -       ret =3D copy_mnt_id_req(req, &kreq);
> +       ret =3D copy_mnt_id_req(req, &kreq, 0);
>         if (ret)
>                 return ret;
>
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 5d3f8c9e3a62..a2156599ddc6 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -197,7 +197,7 @@ struct statmount {
>   */
>  struct mnt_id_req {
>         __u32 size;
> -       __u32 mnt_ns_fd;
> +       __u32 fd;

we can consider using union here:
      union {
            __u32 mnt_ns_fd;
            __u32 mnt_fd;
       };

>         __u64 mnt_id;
>         __u64 param;
>         __u64 mnt_ns_id;
> @@ -232,4 +232,9 @@ struct mnt_id_req {
>  #define LSMT_ROOT              0xffffffffffffffff      /* root mount */
>  #define LISTMOUNT_REVERSE      (1 << 0) /* List later mounts first */
>
> +/*
> + * @flag bits for statmount(2)
> + */
> +#define STATMOUNT_BY_FD                0x00000001U     /* want mountinfo=
 for given fd */
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> --
> 2.51.1
>

