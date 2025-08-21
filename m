Return-Path: <linux-fsdevel+bounces-58580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FCEB2F0B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BD5188D7A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812A2EA15B;
	Thu, 21 Aug 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcZRUBBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766824DCF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763784; cv=none; b=mMFOLVH4guca6dFFYMmiOXoygzVRG4/LjcEzGy/fuyurIjUtgMNlh6QAbKMrKSl4wir2YnVTAhw9UbxRYbKI0+1O6lmQYVzxLQ3a/bUdUCtjehQ9nbTKuaNPVCS8QuE037bSKCBQMhq5onR1giyLd7+0lH8+ywabyMoBK41a/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763784; c=relaxed/simple;
	bh=1Iw9MareJoEGOL1ew1LItaYWN81YYmFXo8Wip++UANU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdFdF415B7EzaurG4x1nqlS/hGW4fzW6wrRW4O3C43tG9nSCdGmBOt2qXuepQyranDGtHLHCV5rr73HHKbBEajGCv+Mzosm16h2IcVlQLRysp6ApMiTwMAqUNBOL0U2GVe2AbtUPxdsKUdJhGWHa8s/tqjDFQW1vfT74e4i7KiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcZRUBBV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afca3e71009so279685766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755763780; x=1756368580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teUIc8YXstGDgdP7y50RrODVC302xLMTEgmrYPICjqA=;
        b=AcZRUBBV9kjtXf/blMbJkYMQ1lNiq/OCUd1uc+pM2NGqrjzNJltO9Q08T80kXauLK6
         2eOBARieqRsNV4UTF/yxlIe0khwVdy6TEHV0VN/MI4THfMS7XxKc1i7wognMC86qVT2G
         vhZ8EB5DNfx9dnyVWSLiRMcoJS7XDn5OgLjVtyPNqSCdI2zH4mSY7oRZGs8mK9Fyttvj
         dXssF55ZxHfyBWYcWIPKnILAE0lVeuh9qPqHkGT6GCF/XHlyXrBdU8W4Q0k1h9iyd9SD
         39+uwpSed/bmnKZJMl3xQ67lPx2vZ2AGGKomHRx2fDvlQkEujAC2vZEk5zc06LZGfoSU
         MoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763780; x=1756368580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teUIc8YXstGDgdP7y50RrODVC302xLMTEgmrYPICjqA=;
        b=COaYDNk38m0M0DgPMU03OYH7ZSb5YrzD2Os1Dmfc4OOW0Qnn0nZ+mOV8Fwd/nbtYsk
         o1+5yWrKH/4PnVr6TFOSZEAPVFXaRXTbSAdhyaScgvySCGSdQJXHL1uh6ARMHjp2dVlq
         AC8wrO+pKKuyLZtNUQA8x8RoZgutNwwHLlLYqOwe2anH/6mrzAtKJAqbN1BsgIbopN/a
         Y5Aicb+1Uoswj+d/mMDa/0ND8EbN1r0gAou9ASF6fIkfnsMnJHiIT8uL6oP/YAvFO7BK
         vZWR/IcUcyn1sv4ehX2BG9ZFBK9rft2PuTYH0cFj2khTLaFNbAbGHOSG+V7rJLWdCc4n
         soMg==
X-Forwarded-Encrypted: i=1; AJvYcCWCNY6Kt4uWAyinqF+OoJYx4KAjG876K0U6lOZh5+4cpUl6BMs+sC53SgAWuCT/d57nSdMudGQYK2Gw4S4F@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLMThgZV6sTrouy3GUZmcI9Q18v5a0O4UCjG0u/zF1QC7p+aX
	CBC8tQIWwOnZ3VXUqGX2qEpGJHnq5VJ093r8csO5kHVs2HDOxZJsS/UBBCAitDRr9ylnCMcA5aG
	5JPYrwNzUIIK+3PEA+JZEc/A9m1z2QpM=
X-Gm-Gg: ASbGncsPfhjP6gk5q49PQg9YbTuTRpc4S0ztfl9GDxaF7mrTHoIoK8pbij1EKGZnb/k
	vunVp1praq6sYjgMBbw0THUNqNHpaYXMXdGX5pNdKaKzNe8F3IMjBwT9revoYBtfXyTDLbs3gyG
	CYLb2Rm3bE990FSx1832fhhSCKP9DWcLFM2nVM8mdtGaI9pwNkbrz0CXOJJKIqj5kqcBpKNTo5R
	IBrRXs=
X-Google-Smtp-Source: AGHT+IHk4TXqNu31vnWyDdkEFdY9k27F78Y9q9n3b2n3l89CDH5W8wJAQZzScBuLNKYAw+lnEaTKjCMA7z5AileEIhY=
X-Received: by 2002:a17:907:3d93:b0:af9:c53a:f997 with SMTP id
 a640c23a62f3a-afe0b45a486mr121522366b.26.1755763780265; Thu, 21 Aug 2025
 01:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs> <175573709244.17510.7992044692651721971.stgit@frogsfrogsfrogs>
In-Reply-To: <175573709244.17510.7992044692651721971.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Aug 2025 10:09:29 +0200
X-Gm-Features: Ac12FXy74b6Cwx_difYHeBc7utcQmVHyVDdQ_ugr0XK-rL9yuXrbE_Gv15F5gDQ
Message-ID: <CAOQ4uxgPOARcEq+p6p0NsBSC9GQp3egHViFeniR=Kc2GpQBCDg@mail.gmail.com>
Subject: Re: [PATCH 06/23] fuse: add an ioctl to add new iomap devices
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:54=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Add an ioctl that allows fuse servers to register block devices for use
> with iomap.  This is (for now) separate from the backing file open/close
> ioctl (despite using the same struct) to keep the codepaths separate.

Is it though? I'm pretty sure this commit does not add a new ioctl
and reuses the same one (which is fine by me).

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h      |    9 +++++
>  fs/fuse/fuse_trace.h  |   49 ++++++++++++++++++++++++++-
>  fs/fuse/Kconfig       |    1 +
>  fs/fuse/backing.c     |   19 ++++++++---
>  fs/fuse/file_iomap.c  |   88 +++++++++++++++++++++++++++++++++++++++++++=
+-----
>  fs/fuse/passthrough.c |   13 +++++++
>  fs/fuse/trace.c       |    1 +
>  7 files changed, 163 insertions(+), 17 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1762517a1b99c8..f4834a02d16c98 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -100,6 +100,10 @@ struct fuse_submount_lookup {
>  struct fuse_backing {
>         struct file *file;
>         struct cred *cred;
> +       struct block_device *bdev;
> +
> +       unsigned int passthrough:1;
> +       unsigned int iomap:1;
>
>         /** refcount */
>         refcount_t count;
> @@ -1639,9 +1643,14 @@ static inline bool fuse_has_iomap(const struct ino=
de *inode)
>  {
>         return get_fuse_conn_c(inode)->iomap;
>  }
> +
> +int fuse_iomap_backing_open(struct fuse_conn *fc, struct fuse_backing *f=
b);
> +int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *=
fb);
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
> +# define fuse_iomap_backing_open(...)          (-EOPNOTSUPP)
> +# define fuse_iomap_backing_close(...)         (-EOPNOTSUPP)
>  #endif
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index 660d9b5206a175..c3671a605a32f6 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -175,6 +175,13 @@ TRACE_EVENT(fuse_request_end,
>  );
>
>  #ifdef CONFIG_FUSE_BACKING
> +#define FUSE_BACKING_PASSTHROUGH       (1U << 0)
> +#define FUSE_BACKING_IOMAP             (1U << 1)
> +
> +#define FUSE_BACKING_FLAG_STRINGS \
> +       { FUSE_BACKING_PASSTHROUGH,             "pass" }, \
> +       { FUSE_BACKING_IOMAP,                   "iomap" }
> +
>  TRACE_EVENT(fuse_backing_class,
>         TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
>                  const struct fuse_backing *fb),
> @@ -184,7 +191,9 @@ TRACE_EVENT(fuse_backing_class,
>         TP_STRUCT__entry(
>                 __field(dev_t,                  connection)
>                 __field(unsigned int,           idx)
> +               __field(unsigned int,           flags)
>                 __field(unsigned long,          ino)
> +               __field(dev_t,                  rdev)
>         ),
>
>         TP_fast_assign(
> @@ -193,12 +202,23 @@ TRACE_EVENT(fuse_backing_class,
>                 __entry->connection     =3D       fc->dev;
>                 __entry->idx            =3D       idx;
>                 __entry->ino            =3D       inode->i_ino;
> +               __entry->flags          =3D       0;
> +               if (fb->passthrough)
> +                       __entry->flags  |=3D      FUSE_BACKING_PASSTHROUG=
H;
> +               if (fb->iomap) {
> +                       __entry->rdev   =3D       inode->i_rdev;
> +                       __entry->flags  |=3D      FUSE_BACKING_IOMAP;
> +               } else {
> +                       __entry->rdev   =3D       0;
> +               }
>         ),
>
> -       TP_printk("connection %u idx %u ino 0x%lx",
> +       TP_printk("connection %u idx %u flags (%s) ino 0x%lx rdev %u:%u",
>                   __entry->connection,
>                   __entry->idx,
> -                 __entry->ino)
> +                 __print_flags(__entry->flags, "|", FUSE_BACKING_FLAG_ST=
RINGS),
> +                 __entry->ino,
> +                 MAJOR(__entry->rdev), MINOR(__entry->rdev))
>  );
>  #define DEFINE_FUSE_BACKING_EVENT(name)                \
>  DEFINE_EVENT(fuse_backing_class, name,         \
> @@ -210,7 +230,6 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
>  #endif
>
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
> -
>  /* tracepoint boilerplate so we don't have to keep doing this */
>  #define FUSE_IOMAP_OPFLAGS_FIELD \
>                 __field(unsigned,               opflags)
> @@ -452,6 +471,30 @@ TRACE_EVENT(fuse_iomap_end_error,
>                   __entry->written,
>                   __entry->error)
>  );
> +
> +TRACE_EVENT(fuse_iomap_dev_add,
> +       TP_PROTO(const struct fuse_conn *fc,
> +                const struct fuse_backing_map *map),
> +
> +       TP_ARGS(fc, map),
> +
> +       TP_STRUCT__entry(
> +               __field(dev_t,                  connection)
> +               __field(int,                    fd)
> +               __field(unsigned int,           flags)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->connection     =3D       fc->dev;
> +               __entry->fd             =3D       map->fd;
> +               __entry->flags          =3D       map->flags;
> +       ),
> +
> +       TP_printk("connection %u fd %d flags 0x%x",
> +                 __entry->connection,
> +                 __entry->fd,
> +                 __entry->flags)
> +);
>  #endif /* CONFIG_FUSE_IOMAP */
>
>  #endif /* _TRACE_FUSE_H */
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index ebb9a2d76b532e..1ab3d3604c07d0 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -75,6 +75,7 @@ config FUSE_IOMAP
>         depends on FUSE_FS
>         depends on BLOCK
>         select FS_IOMAP
> +       select FUSE_BACKING
>         help
>           For supported fuseblk servers, this allows the file IO path to =
run
>           through the kernel.
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index c128bed95a76b8..c63990254649ca 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -67,16 +67,19 @@ static struct fuse_backing *fuse_backing_id_remove(st=
ruct fuse_conn *fc,
>
>  static int fuse_backing_id_free(int id, void *p, void *data)
>  {
> +       struct fuse_conn *fc =3D data;
>         struct fuse_backing *fb =3D p;
>
>         WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> +
> +       trace_fuse_backing_close(fc, id, fb);
>         fuse_backing_free(fb);
>         return 0;
>  }
>
>  void fuse_backing_files_free(struct fuse_conn *fc)
>  {
> -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> +       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
>         idr_destroy(&fc->backing_files_map);
>  }
>
> @@ -84,12 +87,12 @@ int fuse_backing_open(struct fuse_conn *fc, struct fu=
se_backing_map *map)
>  {
>         struct file *file =3D NULL;
>         struct fuse_backing *fb =3D NULL;
> -       int res, passthrough_res;
> +       int res, passthrough_res, iomap_res;
>
>         pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
>
>         res =3D -EPERM;
> -       if (!fc->passthrough)
> +       if (!fc->passthrough && !fc->iomap)
>                 goto out;
>
>         res =3D -EINVAL;
> @@ -125,10 +128,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>          * default.
>          */
>         passthrough_res =3D fuse_passthrough_backing_open(fc, fb);
> +       iomap_res =3D fuse_iomap_backing_open(fc, fb);
>
>         if (refcount_read(&fb->count) < 2) {
>                 if (passthrough_res)
>                         res =3D passthrough_res;
> +               if (!res && iomap_res)
> +                       res =3D iomap_res;
>                 if (!res)
>                         res =3D -EPERM;
>                 goto out_fb;
> @@ -157,12 +163,12 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>  {
>         struct fuse_backing *fb =3D NULL, *test_fb;
> -       int err, passthrough_err;
> +       int err, passthrough_err, iomap_err;
>
>         pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
>
>         err =3D -EPERM;
> -       if (!fc->passthrough)
> +       if (!fc->passthrough && !fc->iomap)
>                 goto out;
>
>         err =3D -EINVAL;
> @@ -187,10 +193,13 @@ int fuse_backing_close(struct fuse_conn *fc, int ba=
cking_id)
>          * error code will be passed up.  EBUSY is the default.
>          */
>         passthrough_err =3D fuse_passthrough_backing_close(fc, fb);
> +       iomap_err =3D fuse_iomap_backing_close(fc, fb);
>
>         if (refcount_read(&fb->count) > 1) {
>                 if (passthrough_err)
>                         err =3D passthrough_err;
> +               if (!err && iomap_err)
> +                       err =3D iomap_err;
>                 if (!err)
>                         err =3D -EBUSY;
>                 goto out_fb;

Do you really think that we need to support both file passthrough and file =
iomap
on the same fuse filesystem?

Unless you have a specific use case in mind, it looks like over design to m=
e
We could enforce either fc->passthrough or fc->iomap on init.

Put it in other words: unless you intend to test a combination of file
passthrough
and file iomap, I think you should leave this configuration out of the conf=
ig
possibilities.

Thanks,
Amir.

