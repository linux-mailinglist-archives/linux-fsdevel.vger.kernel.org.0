Return-Path: <linux-fsdevel+bounces-25727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19D94FA3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BA71C22133
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F3C198822;
	Mon, 12 Aug 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnOecPwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25D16B39A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505209; cv=none; b=upceeVvWrwXGp1P8y0SE+q1Nq8Bhw7IyEgmCoS4Qcy8uKvwI3dXBWRT2BNQzESmFwZU2sd/CXy10ji/pTctzBSsmqflN/wGNTShf5Ae2XFZ4o3iDy6YHpLtI+u3PRw5h865MZSSY2+PGeA1Tt8hBJHUxHo6YGvjV9Gk6n7ktL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505209; c=relaxed/simple;
	bh=MRRkOPRtk7IGRNypURaunAuGddnpk0Z/h3OSkblS/xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO+CkdjchSsPBhLTPBi3ngMV1elk2/6c0xpfnKA/FpGL7oWwBV6sgRuEQOuUXdqrFwxCoLeq8eJ3E2uV9SGItx1xFBHoB/yhGbp1KyEy6VyfHbRIhi+QSXEVtVx/Qvm/1Ps7uXJB60dYJujnOoBEcXkvdHUERYorcixcLKHOUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnOecPwB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fea44f725so5595701cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723505207; x=1724110007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd1wGupfZioTOOUjiQj8YP1ubyH83kBVZf61eVW9mT8=;
        b=dnOecPwBSUCnOO0te46+Ewq5hiB7HfDmeVp4YXDUn4aQ/klyZnUFt4k6m0chSSkNyt
         MtNJ0QEiADmnv4mREAPXK6DQblheOBTQe0RODGgj3DnFBeZmQYYehpCx4mRmxf+YFOZB
         /gEuy/+u9KSoCgGzr/gqsQGRsv8JrPkGNblYn4GGf1y5jUSMFk2fqUfE7tZ2XZhFfvQP
         26iAvo74s1oN2zfpXhyXNaqGK/G+9MgEB49854KMsN3njVfdrl3WFvBfKQYpen+ADtHb
         fBXXqDS21krrS+PFhgwQvX08KaVrmvL/qiIjaoTny4qOK5rSUGhooiusgqDZGWYVwrMt
         b1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505207; x=1724110007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd1wGupfZioTOOUjiQj8YP1ubyH83kBVZf61eVW9mT8=;
        b=PvUo545HFKKsrmxJP4q20oZk1Tu2LVJn2/nvknMceUz61LF5EgKxiI1qYUqFoiL0FW
         lfJC9eChPraPQOqYQPhN6jPUu8wSzRx1lXF18Rxb0pSAjLDN4a5ct9m4rW8paqgvSTwD
         HQAqnUsEveoeDdpRFoYEnx7bLT1e1LmMDYdxyl1V14hy3YD/0Mjp9VIwY75kl/e7ZZw2
         X+Ii4V1iLYWZaButZ9i2rhbCb3AK6yfGtNfSN94xCtqgeNSaVZGZ3L2UVB4rOpzpdB5G
         iE60aQbLWxEiYlM81p+mu0FM+bg4+3E8+V5LK2Wf1UgHcHdfal693C1W6EU06gC1mWl+
         EbbA==
X-Forwarded-Encrypted: i=1; AJvYcCUMzaq8dbD5u5IXDYjE0S4OsmC6YcjzblzjKtADaEymnFq506Z/Tl0Z+3dJ5mUyk1zOCSIkZtN9WOT6y9zt6HmXrPsOmj1sJAsxe6suPA==
X-Gm-Message-State: AOJu0YzjrZVPSPSw9Chg62yej1tq5ap2max+cd3+sXcrnhKlEso4THhk
	XfC2qyOl/C23AOa/FW+kjm+64roLywSE+OguXrn8XdUKXMaDA0zy6UPDN/x3YmyjibAI+AiakWk
	aEdnaAOMPuyzcagQwMyZSWlNW7hI=
X-Google-Smtp-Source: AGHT+IHYyzCSpO6LFW5/GdAbFs9XFm/i/SoP7pN3zByjaMUzCGdurKtVu2kLlMM5xCxHiNfuTXZ7gCHnF2bWtVOllDo=
X-Received: by 2002:ac8:7f42:0:b0:442:1bdc:2a6 with SMTP id
 d75a77b69052e-4534cc78bbdmr17760031cf.30.1723505206789; Mon, 12 Aug 2024
 16:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812161839.1961311-1-bschubert@ddn.com> <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
In-Reply-To: <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 12 Aug 2024 16:26:36 -0700
Message-ID: <CAJnrk1Yr2=n_yofD-FxCa621u3m67K8rYT1Ouz0OTKM9QMqB-A@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:37=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Sorry, I had sent out the wrong/old patch file - it doesn't have one chan=
ge
> (handling of already aligned buffers).
> Shall I sent v4? The correct version is below
>
> ---
>
> From: Bernd Schubert <bschubert@ddn.com>
> Date: Fri, 21 Jun 2024 11:51:23 +0200
> Subject: [PATCH v3] fuse: Allow page aligned writes
>
> Write IOs should be page aligned as fuse server
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

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>
> Changes since v2:
> - Added a no-op return in fuse_copy_align for buffers that are
>   already aligned (cs->len =3D=3D PAGE_SIZE && cs->offset =3D=3D 0). Some
>   server implementations actually do that to compensate for fuse client
>   misalignment. And it could also happen by accident for non aligned
>   server allocation.
> Added suggestions from Joannes review:
> - Removed two sanity checks in fuse_copy_align() to have it
>   generic.
> - Moved from args->in_args[0].align to args->in_args[1].align
>   to have it in the arg that actually needs the alignment
>   (for FUSE_WRITE) and updated fuse_copy_args() to align that arg.
> - Slight update in the commit body (removed "Reads").
>
> libfuse patch:
> https://github.com/libfuse/libfuse/pull/983
>
> From implmentation point of view it is debatable if request type
> parsing should be done in fuse_copy_args() (or fuse_dev_do_read()
> or if alignment should be stored in struct fuse_arg / fuse_in_arg.
> There are pros and cons for both, I kept it in args as it is
> more generic and also allows to later on align other request
> types, for example FUSE_SETXATTR.
> ---
>  fs/fuse/dev.c             | 29 +++++++++++++++++++++++++++--
>  fs/fuse/file.c            |  6 ++++++
>  fs/fuse/fuse_i.h          |  6 ++++--
>  include/uapi/linux/fuse.h |  9 ++++++++-
>  4 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..072c7bacc4a7 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1009,6 +1009,25 @@ static int fuse_copy_one(struct fuse_copy_state *c=
s, void *val, unsigned size)
>         return 0;
>  }
>
> +/* Align to the next page */
> +static int fuse_copy_align(struct fuse_copy_state *cs)
> +{
> +       /*
> +        * This could happen if the userspace buffer is aligned in a way =
that
> +        * it compensates fuse headers.
> +        */
> +       if (cs->len =3D=3D PAGE_SIZE && cs->offset =3D=3D 0)
> +               return 0;
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
> @@ -1019,10 +1038,16 @@ static int fuse_copy_args(struct fuse_copy_state =
*cs, unsigned numargs,
>
>         for (i =3D 0; !err && i < numargs; i++)  {
>                 struct fuse_arg *arg =3D &args[i];
> -               if (i =3D=3D numargs - 1 && argpages)
> +               if (i =3D=3D numargs - 1 && argpages) {
> +                       if (arg->align) {
> +                               err =3D fuse_copy_align(cs);
> +                               if (err)
> +                                       break;
> +                       }
>                         err =3D fuse_copy_pages(cs, arg->size, zeroing);
> -               else
> +               } else {
>                         err =3D fuse_copy_one(cs, arg->value, arg->size);
> +               }
>         }
>         return err;
>  }
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..9783d5809ec3 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1062,6 +1062,12 @@ static void fuse_write_args_fill(struct fuse_io_ar=
gs *ia, struct fuse_file *ff,
>                 args->in_args[0].size =3D FUSE_COMPAT_WRITE_IN_SIZE;
>         else
>                 args->in_args[0].size =3D sizeof(ia->write.in);
> +
> +       if (ff->open_flags & FOPEN_ALIGNED_WRITES) {
> +               args->in_args[1].align =3D 1;
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
>

