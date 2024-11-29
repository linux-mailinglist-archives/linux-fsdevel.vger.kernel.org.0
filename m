Return-Path: <linux-fsdevel+bounces-36156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8539DE8F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE916459D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE613BC39;
	Fri, 29 Nov 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I30V3Z1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7701FAA;
	Fri, 29 Nov 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891980; cv=none; b=MkT25Zs2yJQf1njUbzIArW+Ynjfq9yeJbV0KWwJa+ass6PwTI9lerLOpVdQSkwpeUbYTygKMQ44VgMDszMhFuaBAG7dk5I96IxorK0ifHo8N24bglpsAEDnFosGPhzk4E1mFK4uxyFdgCf7rDY4QAmRwChdCO1xJnpOnefYZ+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891980; c=relaxed/simple;
	bh=zJlPBig+lgV2Lp56R39ZHMvRHVVA8KYu1+j69eQKfaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAGRxGXU8EUssPYjxguqGUPvUWI0QUYDAts8x1C0SKVVT0NmCWJ5rUAQDqV84kAUVm5UL5PxeHa1GVpbi9WJB8UpBaV8bTueMoEFORbgoYgiced1HC97ukU48+76tODw+6tUkIWNvbzLQsScSKmj/dTdSv1Kj1diEQbKz8wiC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I30V3Z1y; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so32242211fa.2;
        Fri, 29 Nov 2024 06:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732891976; x=1733496776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGGucu5b3fh5BHXyh4zKrcuqpz7yBgyX/yP/psycVVo=;
        b=I30V3Z1yp6SzCfZvrbvxpQLkWsEcah8O03HGt35H7mEznnFXr/tSy/xFlFa4tBqVO6
         S0n9az/BiS4xfbiaoixqR1JMtRzomUn7qTaEk4uejzbuji0pr8rGxlzFcqDoyP8WPDE7
         lhfSpDoSB0225pm1JU/psR96IiNNhq5scvGuo5o7UrVDUf1FLyrw6BOwA6PQAUfgHxvi
         iwdlcYkqczwKvUo/YOhidzoDoMvFz8n9PBOrp8uMxSdNV24L1GTlMW7FFCSBTaH2tde0
         mL79nsQnyY0V24boeBTFNl7EpTpgIEZqqWpGYtxwewStWvzmsLFQ+KoG872FiVeLmhQk
         R0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891976; x=1733496776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGGucu5b3fh5BHXyh4zKrcuqpz7yBgyX/yP/psycVVo=;
        b=Ab0J8Mi8CUWKdM9+0d+qYSPAlMvNkzbNdlOKppHTMRauGLXm6NEUvaLBrpox+lDV7c
         lGDNtI96/A/CWvIDvHOixSQwJittuS5aFxt2UutxdVi6V30QFOJaLAiAbj1w5c1+C3rk
         cg/qDxgEBcyLOGUX3eIsclgz6/kMZF7ciJkm3OW15o54avPYSuHAKpas/6v7DDVx87Lq
         ygml3hGlo2FPHm+lSBXi5LMhwRvoSj6bKJpVphO2MN5zmKCBlzOnTrcL5HAKJHsqt5kr
         Pl46FC8gsOxISeccSV4a0dl20jhxoCdsCgWsPZIlkj0f1EaBeXWlsHDaAzku3Ufqw2gL
         bdwg==
X-Forwarded-Encrypted: i=1; AJvYcCU9jfkkS5wxh3yF3v5jQ4GwGYvgUHaVFGB7jioV0JRF4Ry7/XdcHBMR6VjTZJi/wvfCj3Wvk7hnEifpwWTe@vger.kernel.org, AJvYcCW+rFKtw/w7K9YLoasBsb11d6KsFfkYDg4Mw+1ivKxy9WKF6V0Su5abPAGQrjg+OO39Zb8cIwNewlHk@vger.kernel.org, AJvYcCXoKSJN3JUfevstd+BXwp9fXDWJXKlQgKLBvv7C38iDjdN9XpXxzWpuWvpM18tsQmFXYkaV5AUlUqUt9k6M@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6XV3cItTneJQqWkF7xLIGm9Jiyv4Pj8DYMfKxZqsAhBJG8c/
	TIYfWPnVctfs2+MNwFZ/6MNTz8t1abbUolzTi49dnh93Pq4JcdNPHYXFqOadUqA35VSe+QHRWyV
	mWhUzKa9ihOwvgEvpILMFKjAcVwE=
X-Gm-Gg: ASbGncuQHzdzanwUJvFHtF0QXBefiWptVM9g8SDdP7B0EXoYpLj48ywCTJ/U8X/om1j
	ojNzH+APCojx6SsoUkG4waQ4HOi+H/Ww=
X-Google-Smtp-Source: AGHT+IFImVeOoC9UzykX48cXxK2khjkH2/3mQ5F7MYFCwCwn/BOFYi6f9JJ1iXcmoSps34aI/Qh1LtVCYXccq+U7oFA=
X-Received: by 2002:a05:651c:1994:b0:2ff:c8a1:c4c9 with SMTP id
 38308e7fff4ca-2ffd5fcc344mr106189731fa.1.1732891975906; Fri, 29 Nov 2024
 06:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org> <20241129-work-pidfs-file_handle-v1-6-87d803a42495@kernel.org>
In-Reply-To: <20241129-work-pidfs-file_handle-v1-6-87d803a42495@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Nov 2024 15:52:44 +0100
Message-ID: <CAOQ4uxjUMWPRUP=Shjrs=m9Fd9GV_XycGP4BecMcLUY5GST6rg@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] pidfs: implement file handle support
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 2:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 64-bit platforms, userspace can read the pidfd's inode in order to
> get a never-repeated PID identifier. On 32-bit platforms this identifier
> is not exposed, as inodes are limited to 32 bits. Instead expose the
> identifier via export_fh, which makes it available to userspace via
> name_to_handle_at.
>
> In addition we implement fh_to_dentry, which allows userspace to
> recover a pidfd from a pidfs file handle.
>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> [brauner: patch heavily rewritten]
> Co-Developed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fhandle.c | 34 +++++++++++----------
>  fs/pidfs.c   | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 115 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 23491094032ec037066a271873ea8ff794616bee..4c847ca16fabe31d51ff5698b=
0c9c355c3e2fb67 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -268,20 +268,6 @@ static int do_handle_to_path(struct file_handle *han=
dle, struct path *path,
>         return 0;
>  }
>
> -/*
> - * Allow relaxed permissions of file handles if the caller has the
> - * ability to mount the filesystem or create a bind-mount of the
> - * provided @mountdirfd.
> - *
> - * In both cases the caller may be able to get an unobstructed way to
> - * the encoded file handle. If the caller is only able to create a
> - * bind-mount we need to verify that there are no locked mounts on top
> - * of it that could prevent us from getting to the encoded file.
> - *
> - * In principle, locked mounts can prevent the caller from mounting the
> - * filesystem but that only applies to procfs and sysfs neither of which
> - * support decoding file handles.
> - */
>  static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
>                                  unsigned int o_flags)
>  {
> @@ -291,6 +277,19 @@ static inline bool may_decode_fh(struct handle_to_pa=
th_ctx *ctx,
>                 return true;
>
>         /*
> +        * Allow relaxed permissions of file handles if the caller has th=
e
> +        * ability to mount the filesystem or create a bind-mount of the
> +        * provided @mountdirfd.
> +        *
> +        * In both cases the caller may be able to get an unobstructed wa=
y to
> +        * the encoded file handle. If the caller is only able to create =
a
> +        * bind-mount we need to verify that there are no locked mounts o=
n top
> +        * of it that could prevent us from getting to the encoded file.
> +        *
> +        * In principle, locked mounts can prevent the caller from mounti=
ng the
> +        * filesystem but that only applies to procfs and sysfs neither o=
f which
> +        * support decoding file handles.
> +        *

Belongs in patch 4

>          * Restrict to O_DIRECTORY to provide a deterministic API that av=
oids a
>          * confusing api in the face of disconnected non-dir dentries.
>          *
> @@ -397,6 +396,7 @@ static long do_handle_open(int mountdirfd, struct fil=
e_handle __user *ufh,
>         long retval =3D 0;
>         struct path path __free(path_put) =3D {};
>         struct file *file;
> +       const struct export_operations *eops;
>
>         retval =3D handle_to_path(mountdirfd, ufh, &path, open_flag);
>         if (retval)
> @@ -406,7 +406,11 @@ static long do_handle_open(int mountdirfd, struct fi=
le_handle __user *ufh,
>         if (fd < 0)
>                 return fd;
>
> -       file =3D file_open_root(&path, "", open_flag, 0);
> +       eops =3D path.mnt->mnt_sb->s_export_op;
> +       if (eops->open)
> +               file =3D eops->open(&path, open_flag);
> +       else
> +               file =3D file_open_root(&path, "", open_flag, 0);

Belongs in patch 3

>         if (IS_ERR(file))
>                 return PTR_ERR(file);
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index f73a47e1d8379df886a90a044fb887f8d06f7c0b..f09af08a4abe4a9100ed972be=
e8f5c5d7ab33d84 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/anon_inodes.h>
> +#include <linux/exportfs.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/cgroup.h>
> @@ -454,6 +455,100 @@ static const struct dentry_operations pidfs_dentry_=
operations =3D {
>         .d_prune        =3D stashed_dentry_prune,
>  };
>
> +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +                          struct inode *parent)
> +{
> +       struct pid *pid =3D inode->i_private;
> +
> +       if (*max_len < 2) {
> +               *max_len =3D 2;
> +               return FILEID_INVALID;
> +       }
> +
> +       *max_len =3D 2;
> +       *(u64 *)fh =3D pid->ino;
> +       return FILEID_KERNFS;
> +}
> +
> +/* Find a struct pid based on the inode number. */
> +static struct pid *pidfs_ino_get_pid(u64 ino)
> +{
> +       ino_t pid_ino =3D pidfs_ino(ino);
> +       u32 gen =3D pidfs_gen(ino);
> +       struct pid *pid;
> +
> +       guard(rcu)();
> +
> +       /* Handle @pid lookup carefully so there's no risk of UAF. */
> +       pid =3D idr_find(&pidfs_ino_idr, (u32)pid_ino);
> +       if (!pid)
> +               return NULL;
> +
> +       if (sizeof(ino_t) < sizeof(u64)) {

Not sure why the two cases are needed. Isn't this enough?

  if (pidfs_ino(pid->ino) !=3D pid_ino || pidfs_gen(pid->ino) !=3D gen)
         pid =3D NULL;


> +               if (gen && pidfs_gen(pid->ino) !=3D gen)
> +                       pid =3D NULL;
> +       } else {
> +               if (pidfs_ino(pid->ino) !=3D pid_ino)
> +                       pid =3D NULL;
> +       }
> +
> +       /* Within our pid namespace hierarchy? */
> +       if (pid_vnr(pid) =3D=3D 0)
> +               pid =3D NULL;
> +
> +       return get_pid(pid);
> +}
> +
> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> +                                        struct fid *fid, int fh_len,
> +                                        int fh_type)
> +{
> +       int ret;
> +       u64 pid_ino;
> +       struct path path;
> +       struct pid *pid;
> +
> +       if (fh_len < 2)
> +               return NULL;
> +
> +       switch (fh_type) {
> +       case FILEID_KERNFS:
> +               pid_ino =3D *(u64 *)fid;
> +               break;
> +       default:
> +               return NULL;
> +       }
> +
> +       pid =3D pidfs_ino_get_pid(pid_ino);
> +       if (!pid)
> +               return NULL;
> +
> +       ret =3D path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
> +       mntput(path.mnt);
> +       return path.dentry;
> +}
> +
> +static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
> +                                  unsigned int oflags)
> +{

This deserves a comment to explain why no permissions are required.

> +       return 0;
> +}
> +
> +static struct file *pidfs_export_open(struct path *path, unsigned int of=
lags)
> +{
> +       return dentry_open(path, oflags | O_RDWR, current_cred());

Why is O_RDWR needed here? perhaps a comment to explain.

Thanks,
Amir.

