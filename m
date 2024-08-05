Return-Path: <linux-fsdevel+bounces-25043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940DA948384
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76C21C2218F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754D14A4C9;
	Mon,  5 Aug 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjrhPUEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D4145FE2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889985; cv=none; b=CsrzUAQAJ4FqYZY3/7Xq+BMI0X6Y62K1Svd48A3bdLP8beCbK9antabjWqH8bAYhlxjjwYABuPjw0YHSqvF/l8Fe7Gld1WwdROaHMlpNEe8mPUM45/BzDn9LjbvcL0RppA16kARX4GD+GKBWSmtP5m9oTcmLg8Xh7yTeBQY3lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889985; c=relaxed/simple;
	bh=TddtKYRtJlUns6W0u+yroWh3gc6dLnxHHDf06VHqjh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKvaHBRQJogQJ7PEw6Kctf0ZgzrfmCMBfHOhbncCBb3frwKfaIYnUZ7EKqCnOCARokuWEhVsCAIipsJFgAhQW9q1lbRNv5xAolaNuapfQ6TsP1bitZGqSX9z/dvySR6/DAZk8u6F92J5ShWI8IpIMbGu5d0wEhy5FZjH9up4t0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjrhPUEW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447d6edc6b1so566401cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722889983; x=1723494783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd8sAamIRWp+uElgyVzkBn8L8GI4LxJfgJYtl3rbFcA=;
        b=SjrhPUEWWMqPe9raGBTMgoMtJ9zldAQkRIhvhqUT9HkVOCBKh8544nFhMESoxCIQLA
         /Cw0EEUO0bNdB9jMqIDnu9xWiUfAvVI6cJN9ytDe1s9hq9Ap7D07HGyuoDPb9ehOQ1rF
         7tqfhuuOlY5OF8rOZOYanCs1ZHq/S7ngWQL+8YwM5akMSzuOCy5dhqjb2sE6ucoG5zJ6
         nKSZQT7F7sZ3D8q7DP4RIOs3Wq+ISl9HZ9UZKCe0ujZJDBgUOdLxS0rrKoeLGClY54ZU
         z06VhSp8brqMSZsdYLML3hgUCRhMMhwS1UxYKzmTHJ3us0FYaez580n6+T8IoC8zmcu/
         lh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889983; x=1723494783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd8sAamIRWp+uElgyVzkBn8L8GI4LxJfgJYtl3rbFcA=;
        b=ipByTFwcakRY+/+yYTOkcn6sRyta+QB8IHmVmN5F1W01cQCYKRePRooH8Yd90O1riN
         GACCxxkshZ9nmj0VJmZYruvbk1NUJghISjUqBhkDXqBtxMSYzpysgdv1MpoXGp+Rs/X1
         Nxihgn1HrXV3D6Y/ExnTEAbca7LMB11YQoMuRa5vDMG+oXgJvUaL6Uet4UTldqJFcyA3
         UuNEk4wvJ/07ICOk56/X2AjtBstbkfGB5BNXkaRbqnpZ4iZt1Py3qTIHzhOC1FKpCccw
         luwMAKp0IEcWUczbcw7aotze89oCKz2M2DdW86mPljn4V6tf/JLBuHTScOkmrmPuJ/iG
         wEgA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ltXNX7yGcW19Zzp8SVEy9ZzHygqT3eOF+PWfT37JvJ/admizXvmeEA+EbSFDRuAxhx9tPI6DBsDPu2DSN3SUlXRghfcL0Qjp9qFhQA==
X-Gm-Message-State: AOJu0YxKvxm+kzNBsGT6Tvu75J8CpPwzedOR9axN518GneCOu7qTV5/h
	3L/9oqPARTrwiZVh1WzgTkWcpsVRB5x744WZ4wOTppd/P3nK66r4KIketMw7n4MFAAln24EQT1g
	QVrKbjej+i5RMArB0XkhOqnp9QCc=
X-Google-Smtp-Source: AGHT+IFzMHIF5ydXkleMxLXvWJKRaFNRJoUI8F/HdKIHrkLXKTARP6HbKHWpihqrcfQE49ugJrtGPOa8VMqx58Tt4IA=
X-Received: by 2002:a05:622a:14ce:b0:447:dfa0:2831 with SMTP id
 d75a77b69052e-4518920703cmr138670991cf.4.1722889982650; Mon, 05 Aug 2024
 13:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802215200.2842855-1-bschubert@ddn.com>
In-Reply-To: <20240802215200.2842855-1-bschubert@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Aug 2024 13:32:51 -0700
Message-ID: <CAJnrk1bzOSR_jOjZN8C+HTcWxU0Erh_=0rZD63zLskUne9d7Jw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Allow page aligned writes
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:52=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> Read/writes IOs should be page aligned as fuse server

I think you meant just "write IOs"  here and not reads?

> might need to copy data to another buffer otherwise in
> order to fulfill network or device storage requirements.
>
> Simple reproducer is with libfuse, example/passthrough*
> and opening a file with O_DIRECT - without this change
> writing to that file failed with -EINVAL if the underlying
> file system was requiring alignment.
>
> Required server side changes:
> Server needs to seek to the next page, without splice that is
> just page size buffer alignment, with splice another splice
> syscall is needed to seek over the unaligned area.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>
> ---
>
> Changes since v1:
> - Fuse client does not send the alignment offset anymore in the write
>   header.
> - Use FOPEN_ALIGNED_WRITES to be filled in by FUSE_OPEN and FUSE_CREATE
>   instead of a FUSE_INIT flag to allow control per file and to safe
>   init flags.
> - Instead of seeking a fixed offset, fuse_copy_align() just seeks to the
>   next page.
> - Added sanity checks in fuse_copy_align().
>
> libfuse patch:
> https://github.com/libfuse/libfuse/pull/983
>
> From implmentation point of view it is debatable if request type
> parsing should be done in fuse_copy_args() or if alignment
> should be stored in struct fuse_arg / fuse_in_arg.
> ---
>  fs/fuse/dev.c             | 25 +++++++++++++++++++++++--
>  fs/fuse/file.c            |  6 ++++++
>  fs/fuse/fuse_i.h          |  6 ++++--
>  include/uapi/linux/fuse.h |  9 ++++++++-
>  4 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..e0db408db90f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1009,6 +1009,24 @@ static int fuse_copy_one(struct fuse_copy_state *c=
s, void *val, unsigned size)
>         return 0;
>  }
>
> +/* Align to the next page */
> +static int fuse_copy_align(struct fuse_copy_state *cs)
> +{
> +       if (WARN_ON(!cs->write))
> +               return -EIO;

I understand why you have the check here but in my opinion,
fuse_copy_align should just be a generic api since the rest of the arg
copying APIs are generic and with having "align" as a bit in the args
field, align capability seems generic as well.

> +
> +       if (WARN_ON(cs->move_pages))
> +               return -EIO;
> +
> +       if (WARN_ON(cs->len =3D=3D PAGE_SIZE || cs->offset =3D=3D 0))
> +               return -EIO;
> +
> +       /* Seek to the next page */
> +       cs->offset +=3D cs->len;
> +       cs->len =3D 0;
> +       return 0;
> +}
> +
>  /* Copy request arguments to/from userspace buffer */
>  static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>                           unsigned argpages, struct fuse_arg *args,
> @@ -1019,10 +1037,13 @@ static int fuse_copy_args(struct fuse_copy_state =
*cs, unsigned numargs,
>
>         for (i =3D 0; !err && i < numargs; i++)  {
>                 struct fuse_arg *arg =3D &args[i];
> -               if (i =3D=3D numargs - 1 && argpages)
> +               if (i =3D=3D numargs - 1 && argpages) {
>                         err =3D fuse_copy_pages(cs, arg->size, zeroing);
> -               else
> +               } else {
>                         err =3D fuse_copy_one(cs, arg->value, arg->size);
> +                       if (!err && arg->align)
> +                               err =3D fuse_copy_align(cs);
> +               }
>         }
>         return err;
>  }
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..931e7324137f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1062,6 +1062,12 @@ static void fuse_write_args_fill(struct fuse_io_ar=
gs *ia, struct fuse_file *ff,
>                 args->in_args[0].size =3D FUSE_COMPAT_WRITE_IN_SIZE;
>         else
>                 args->in_args[0].size =3D sizeof(ia->write.in);
> +
> +       if (ff->open_flags & FOPEN_ALIGNED_WRITES) {
> +               args->in_args[0].align =3D 1;

This is more of a nit so feel free to disregard, but I think the code
is easier to understand if the align bit gets set on the arg that
needs alignment instead of on the preceding arg. I think this would
also make fuse_copy_args() easier to grok, since the alignment would
be done before doing fuse_copy_pages(), which makes it more obvious
that the alignment is for the copied out pages

> +               ia->write.in.write_flags |=3D FUSE_WRITE_ALIGNED;
> +       }
> +
>         args->in_args[0].value =3D &ia->write.in;
>         args->in_args[1].size =3D count;
>         args->out_numargs =3D 1;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f23919610313..1600bd7b1d0d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -275,13 +275,15 @@ struct fuse_file {
>
>  /** One input argument of a request */
>  struct fuse_in_arg {
> -       unsigned size;
> +       unsigned int size;
> +       unsigned int align:1;
>         const void *value;
>  };
>
>  /** One output argument of a request */
>  struct fuse_arg {
> -       unsigned size;
> +       unsigned int size;
> +       unsigned int align:1;
>         void *value;
>  };
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d08b99d60f6f..742262c7c1eb 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -217,6 +217,9 @@
>   *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
>   *  - add FUSE_NO_EXPORT_SUPPORT init flag
>   *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
> + *
> + * 7.41
> + *  - add FOPEN_ALIGNED_WRITES open flag and FUSE_WRITE_ALIGNED write fl=
ag
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -252,7 +255,7 @@
>  #define FUSE_KERNEL_VERSION 7
>
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 40
> +#define FUSE_KERNEL_MINOR_VERSION 41
>
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -360,6 +363,7 @@ struct fuse_file_lock {
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK=
_CACHE)
>   * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the s=
ame inode
>   * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
> + * FOPEN_ALIGNED_WRITES: Page align write io data
>   */
>  #define FOPEN_DIRECT_IO                (1 << 0)
>  #define FOPEN_KEEP_CACHE       (1 << 1)
> @@ -369,6 +373,7 @@ struct fuse_file_lock {
>  #define FOPEN_NOFLUSH          (1 << 5)
>  #define FOPEN_PARALLEL_DIRECT_WRITES   (1 << 6)
>  #define FOPEN_PASSTHROUGH      (1 << 7)
> +#define FOPEN_ALIGNED_WRITES   (1 << 8)

Nice, I like how you made the flag on open instead of init to allow
this option to be file-specific.

>
>  /**
>   * INIT request/reply flags
> @@ -496,10 +501,12 @@ struct fuse_file_lock {
>   * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guess=
ed
>   * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
>   * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
> + * FUSE_WRITE_ALIGNED: Write io data are page aligned
>   */
>  #define FUSE_WRITE_CACHE       (1 << 0)
>  #define FUSE_WRITE_LOCKOWNER   (1 << 1)
>  #define FUSE_WRITE_KILL_SUIDGID (1 << 2)
> +#define FUSE_WRITE_ALIGNED      (1 << 3)
>
>  /* Obsolete alias; this flag implies killing suid/sgid only. */
>  #define FUSE_WRITE_KILL_PRIV   FUSE_WRITE_KILL_SUIDGID
> --
> 2.43.0
>
Regarding where/how alignment should be stored, eg request type
parsing vs in fuse_arg/fuse_in_arg structs -

I don't feel strongly about this but it feels cleaner to me to do
request type parsing given that alignment is only needed for fuse
write requests. In my mind, it would look something like this:

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1012,17 +1012,21 @@ static int fuse_copy_one(struct
fuse_copy_state *cs, void *val, unsigned size)
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
                          unsigned argpages, struct fuse_arg *args,
-                         int zeroing)
+                         int zeroing, bool align)
 {
        int err =3D 0;
        unsigned i;

        for (i =3D 0; !err && i < numargs; i++)  {
                struct fuse_arg *arg =3D &args[i];
-               if (i =3D=3D numargs - 1 && argpages)
-                       err =3D fuse_copy_pages(cs, arg->size, zeroing);
-               else
+               if (i =3D=3D numargs - 1 && argpages) {
+                       if (align)
+                               err =3D fuse_copy_align(cs);
+                       if (!err)
+                               err =3D fuse_copy_pages(cs, arg->size, zero=
ing);
+               } else {
                        err =3D fuse_copy_one(cs, arg->value, arg->size);
+               }
        }
        return err;
 }

+static bool should_align_copy_pages(struct file *file, struct fuse_args *a=
rgs)
+{
+       struct fuse_file *ff =3D file->private_data;
+
+       return (ff->open_flags & FOPEN_ALIGNED_WRITES) && args->opcode
=3D=3D FUSE_WRITE;
+}
+
@@ -1212,6 +1223,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev
*fud, struct file *file,
        struct fuse_args *args;
        unsigned reqsize;
        unsigned int hash;
+       bool align;

        /*
         * Require sane minimum read buffer - that has capacity for fixed p=
art
@@ -1296,9 +1308,10 @@ static ssize_t fuse_dev_do_read(struct fuse_dev
*fud, struct file *file,
        spin_unlock(&fpq->lock);
        cs->req =3D req;
        err =3D fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
+       align =3D should_align_copy_pages(file, args);
        if (!err)
                err =3D fuse_copy_args(cs, args->in_numargs, args->in_pages=
,
-                                    (struct fuse_arg *) args->in_args, 0);
+                                    (struct fuse_arg *)
args->in_args, 0, align);
        fuse_copy_finish(cs);
        spin_lock(&fpq->lock);
        clear_bit(FR_LOCKED, &req->flags);
@@ -1896,7 +1909,7 @@ static int copy_out_args(struct fuse_copy_state
*cs, struct fuse_args *args,
                lastarg->size -=3D diffsize;
        }
        return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-                             args->out_args, args->page_zeroing);
+                             args->out_args, args->page_zeroing, false);
 }

which also seems to me easier to follow in logic than having the align
bit in the args. But if align will be something that other operations
will also need/request, then I think it makes sense to have it in the
args.


Thanks,
Joanne

