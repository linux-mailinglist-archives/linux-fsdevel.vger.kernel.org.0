Return-Path: <linux-fsdevel+bounces-21163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A846F8FFB7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 07:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AF21C2435B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 05:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED014F110;
	Fri,  7 Jun 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luVw3tNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E529428
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739747; cv=none; b=q5IsOIaT4gZH1r6G7lJZ4ArJycxOiEEMpCdPsRml+yeS7HxbrKHuVPK/8GJL1QGJPjiu3+GYN4beIS6gQWppHj2tovD5NicK/gkqD6VXkCoRr5oXW/OaHhaXQkmJJVcjjEnDEqjHmA/ssHEFWsZ6WpyAUUV6rc2JhpF1oyg4CJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739747; c=relaxed/simple;
	bh=6ZFdsQ3nB+XZlkb7kypk5Rp0iPbMP1SQCuTZM7BBfbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmOC0KW5GTE+ctTNFYz2/hUGy+sWv8Pk+62FsXbV21sqOwAdFq4BAF0VicndJTMwAa7SIec1B0IOBt+uceL3WVh1YiaMWrlSxQ5llZsWrUroQBBJf7yQ+Ii+qPu7V7639S6NZ4hsvjRnY1nayhLP+6gPZ0kWi+ww0g/3acfPMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luVw3tNB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795413e26deso17856985a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717739744; x=1718344544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCUcpALN0bmLoA9zJu8ypT0NT5YUA0eYV4gDDrtl70A=;
        b=luVw3tNBdZxlVcHaqI3qGPswC+ZJrtXmgdBAMkn7c7aDTQXagFRmBALvZ29C400SQG
         VC28sXW53PjmNYp6ZHei8cohZNOaRQCR5LmyzA2Ry8J8aWiz7J+LC2Weuw//k6DXJIVd
         7n3IrZNrhR329Tkex39nNtO3TKBAcKjicFG+MzMADxdA/xnDE2sy4Xu/tnQsCjGKuZzd
         KWTID5AkUtJyAHheWc/isZ6aIruU1342at9pn6Ex2KyVgN/RoRyIqMIzh6zD+qt0XwYB
         Wzrv+43hUxrOMbWQ0bn9tDQEOPHsmBWbgB4kNpNN5NYzIcrZ9Qy08XaZd7ACcEfrKr4u
         ZSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717739744; x=1718344544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCUcpALN0bmLoA9zJu8ypT0NT5YUA0eYV4gDDrtl70A=;
        b=vZTB2W5MPNk4NbFXxyQCryw3/ZSvZcnFNdScOZCqlTv1I8ymNsUo+VxYvXnOJdppQF
         Nj0vZ0CVMBpRsHPqIZzm8A+YCSprb7W6tOL6aUflX9n2VBJWr9roPq/fTuWSMAOsB3lZ
         xsv57FUQ0gtFZHf6lwC/y7QZpaYLeq3N/UEie0RXRXRv3JomesTTl9mltNOpaKn8tyTt
         V61EykND51WhdJB6mkCyhoE2zRM4alYhOQv+4fdPt2lHGe5jwgPIUccslFAlScDa0NG0
         k6wJkHraU3TTvzinSrDjqRMZxHEk6RnuUnZNn7E13ZjvISzfqX0jyj1QNlduoW2PB3B5
         ewdQ==
X-Gm-Message-State: AOJu0YzEVOoAzujy3+X78uepwHvmQpUJtKwIT2DpekkdI7gtn9ZkNt4r
	S8gbUslXWO09qBZ28ZzM1Qh9Ua+9etN6bZekFOyBgzFsdW2b4bn0nPO2jLjQjnsUIZ5BO5W6x5C
	NqmY/XXsohO40p3u9sQgetSz8cRd+VQ==
X-Google-Smtp-Source: AGHT+IGSrWJxTKMcnZZ38ACHucitAdc7NFRj09VS1Zdj/DA3kIK9TZAAxRoXWrAm5ec9L284jx9HJQWo5QIK4S32Utk=
X-Received: by 2002:a05:620a:4496:b0:794:f1bb:2684 with SMTP id
 af79cd13be357-7953c4a5cb6mr179766685a.55.1717739744384; Thu, 06 Jun 2024
 22:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607015656.GX1629371@ZenIV> <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20240607015957.2372428-4-viro@zeniv.linux.org.uk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Jun 2024 08:55:33 +0300
Message-ID: <CAOQ4uxgtCz=JxfwVH+FHeg4K-cMFyt23MEz=URGCp+C0gwBkcg@mail.gmail.com>
Subject: Re: [PATCH 04/19] struct fd: representation change
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	torvalds@linux-foundation.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 5:00=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
>         The absolute majority of instances comes from fdget() and its
> relatives; the underlying primitives actually return a struct file
> reference and a couple of flags encoded into an unsigned long - the lower
> two bits of file address are always zero, so we can stash the flags
> into those.  On the way out we use __to_fd() to unpack that unsigned
> long into struct fd.
>
>         Let's use that representation for struct fd itself - make it
> a structure with a single unsigned long member (.word), with the value
> equal either to (unsigned long)p | flags, p being an address of some
> struct file instance, or to 0 for an empty fd.
>
>         Note that we never used a struct fd instance with NULL ->file
> and non-zero ->flags; the emptiness had been checked as (!f.file) and
> we expected e.g. fdput(empty) to be a no-op.  With new representation
> we can use (!f.word) for emptiness check; that is enough for compiler
> to figure out that (f.word & FDPUT_FPUT) will be false and that fdput(f)
> will be a no-op in such case.
>
>         For now the new predicate (fd_empty(f)) has no users; all the
> existing checks have form (!fd_file(f)).  We will convert to fd_empty()
> use later; here we only define it (and tell the compiler that it's
> unlikely to return true).
>
>         This commit only deals with representation change; there will
> be followups.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/infiniband/core/uverbs_cmd.c |  2 +-
>  fs/overlayfs/file.c                  | 28 +++++++++++++++-------------
>  fs/xfs/xfs_handle.c                  |  2 +-
>  include/linux/file.h                 | 22 ++++++++++++++++------
>  kernel/events/core.c                 |  2 +-
>  net/socket.c                         |  2 +-
>  6 files changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/co=
re/uverbs_cmd.c
> index 03ea3afcb31f..efe3cc3debba 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -572,7 +572,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bun=
dle *attrs)
>         struct inode                   *inode =3D NULL;
>         int                             new_xrcd =3D 0;
>         struct ib_device *ib_dev;
> -       struct fd f =3D {};
> +       struct fd f =3D EMPTY_FD;
>         int ret;
>
>         ret =3D uverbs_request(attrs, &cmd, sizeof(cmd));
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index c4963d0c5549..458299873780 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -93,11 +93,11 @@ static int ovl_real_fdget_meta(const struct file *fil=
e, struct fd *real,
>                                bool allow_meta)
>  {
>         struct dentry *dentry =3D file_dentry(file);
> +       struct file *private =3D file->private_data;

In future versions please rename s/private/realfile.

Thanks,
Amir.

>         struct path realpath;
>         int err;
>
> -       real->flags =3D 0;
> -       real->file =3D file->private_data;
> +       real->word =3D (unsigned long)private;
>
>         if (allow_meta) {
>                 ovl_path_real(dentry, &realpath);
> @@ -113,16 +113,17 @@ static int ovl_real_fdget_meta(const struct file *f=
ile, struct fd *real,
>                 return -EIO;
>
>         /* Has it been copied up since we'd opened it? */
> -       if (unlikely(file_inode(real->file) !=3D d_inode(realpath.dentry)=
)) {
> -               real->flags =3D FDPUT_FPUT;
> -               real->file =3D ovl_open_realfile(file, &realpath);
> -
> -               return PTR_ERR_OR_ZERO(real->file);
> +       if (unlikely(file_inode(private) !=3D d_inode(realpath.dentry))) =
{
> +               struct file *f =3D ovl_open_realfile(file, &realpath);
> +               if (IS_ERR(f))
> +                       return PTR_ERR(f);
> +               real->word =3D (unsigned long)ovl_open_realfile(file, &re=
alpath) | FDPUT_FPUT;
> +               return 0;
>         }
>
>         /* Did the flags change since open? */
> -       if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FL=
AGS))
> -               return ovl_change_flags(real->file, file->f_flags);
> +       if (unlikely((file->f_flags ^ private->f_flags) & ~OVL_OPEN_FLAGS=
))
> +               return ovl_change_flags(private, file->f_flags);
>
>         return 0;
>  }
> @@ -130,10 +131,11 @@ static int ovl_real_fdget_meta(const struct file *f=
ile, struct fd *real,
>  static int ovl_real_fdget(const struct file *file, struct fd *real)
>  {
>         if (d_is_dir(file_dentry(file))) {
> -               real->flags =3D 0;
> -               real->file =3D ovl_dir_real_file(file, false);
> -
> -               return PTR_ERR_OR_ZERO(real->file);
> +               struct file *f =3D ovl_dir_real_file(file, false);
> +               if (IS_ERR(f))
> +                       return PTR_ERR(f);
> +               real->word =3D (unsigned long)f;
> +               return 0;
>         }
>
>         return ovl_real_fdget_meta(file, real, false);
> diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
> index 445a2daff233..bb250f4246b3 100644
> --- a/fs/xfs/xfs_handle.c
> +++ b/fs/xfs/xfs_handle.c
> @@ -86,7 +86,7 @@ xfs_find_handle(
>         int                     hsize;
>         xfs_handle_t            handle;
>         struct inode            *inode;
> -       struct fd               f =3D {NULL};
> +       struct fd               f =3D EMPTY_FD;
>         struct path             path;
>         int                     error;
>         struct xfs_inode        *ip;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 0964408727a7..39eb10a1bbfc 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -35,18 +35,28 @@ static inline void fput_light(struct file *file, int =
fput_needed)
>                 fput(file);
>  }
>
> +/* either a reference to struct file + flags
> + * (cloned vs. borrowed, pos locked), with
> + * flags stored in lower bits of value,
> + * or empty (represented by 0).
> + */
>  struct fd {
> -       struct file *file;
> -       unsigned int flags;
> +       unsigned long word;
>  };
>  #define FDPUT_FPUT       1
>  #define FDPUT_POS_UNLOCK 2
>
> -#define fd_file(f) ((f).file)
> +#define fd_file(f) ((struct file *)((f).word & ~3))
> +static inline bool fd_empty(struct fd f)
> +{
> +       return unlikely(!f.word);
> +}
> +
> +#define EMPTY_FD (struct fd){0}
>
>  static inline void fdput(struct fd fd)
>  {
> -       if (fd.flags & FDPUT_FPUT)
> +       if (fd.word & FDPUT_FPUT)
>                 fput(fd_file(fd));
>  }
>
> @@ -60,7 +70,7 @@ extern void __f_unlock_pos(struct file *);
>
>  static inline struct fd __to_fd(unsigned long v)
>  {
> -       return (struct fd){(struct file *)(v & ~3),v & 3};
> +       return (struct fd){v};
>  }
>
>  static inline struct fd fdget(unsigned int fd)
> @@ -80,7 +90,7 @@ static inline struct fd fdget_pos(int fd)
>
>  static inline void fdput_pos(struct fd f)
>  {
> -       if (f.flags & FDPUT_POS_UNLOCK)
> +       if (f.word & FDPUT_POS_UNLOCK)
>                 __f_unlock_pos(fd_file(f));
>         fdput(f);
>  }
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7acf44111a6e..fd4621cd9c23 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12438,7 +12438,7 @@ SYSCALL_DEFINE5(perf_event_open,
>         struct perf_event_attr attr;
>         struct perf_event_context *ctx;
>         struct file *event_file =3D NULL;
> -       struct fd group =3D {NULL, 0};
> +       struct fd group =3D EMPTY_FD;
>         struct task_struct *task =3D NULL;
>         struct pmu *pmu;
>         int event_fd;
> diff --git a/net/socket.c b/net/socket.c
> index 50b074f52147..a2c509363d4d 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -559,7 +559,7 @@ static struct socket *sockfd_lookup_light(int fd, int=
 *err, int *fput_needed)
>         if (fd_file(f)) {
>                 sock =3D sock_from_file(fd_file(f));
>                 if (likely(sock)) {
> -                       *fput_needed =3D f.flags & FDPUT_FPUT;
> +                       *fput_needed =3D f.word & FDPUT_FPUT;
>                         return sock;
>                 }
>                 *err =3D -ENOTSOCK;
> --
> 2.39.2
>
>

