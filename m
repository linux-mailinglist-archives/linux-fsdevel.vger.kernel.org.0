Return-Path: <linux-fsdevel+bounces-59447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC55B38EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276637C56FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 22:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9DC30FC21;
	Wed, 27 Aug 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJM9/lWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DC1B6D08
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335423; cv=none; b=n7mcuaz1jvgZjEX9byMozkSQPTWhgRAlYNs2+BnxkmhIA8TM+DCIHoce/F0AApoMB9rZ8cvV+xt9dmtXccssQSCdw1gx8wtxG4bcA4T0c1kLWgj0q+6hNQ8HPHFAiuK3Hx8oibtIUsGUydgn4RQujGjVeIrTYSO53moA4ARDPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335423; c=relaxed/simple;
	bh=gJP7dEYRhueHysb1ghKMfpaxNkjWNC+71YuvHyDl7Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HABmTVSYvYnRgrthF4udklqSGhspghIuWQxQ1BWBK+lxBDxfqZcQK6nH3wmaxxTli2HtC3ZLgvfjagegDwhp7B9yypD0wM8anA/i0mVqghsxhQ0uKNAPbxNbTZKhRgQa4wpzYCrn1bmyRBTnW1QF+X6r6Mimt1E/+hP+l14Gdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJM9/lWx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c58e29so5287641cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756335420; x=1756940220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvbMFSv0rY0WE0NHNJ8jMam8jzUNY5PyLsTi66Gs+wY=;
        b=YJM9/lWxXpXq2y0dwwOz2s9plEZqF5KbpOrVR+PqxnQxgOLZJqTMIyJIg4ZnNG7RzY
         1S06AIyzsB6dqu1LXbqtJUw6MCzd1HZxPGTLFYz2p95ITJUF+yC6OYMmjTbUILCD0w0D
         CU5s+TfYELEPIVxoSjIy3QqaXbczP3QAj9HuixZxamDXj9ZQXSdiv+EVeKCCx+lpUobH
         RrVQOVOIm4OdPMh7E0K733L0+9ZBuekv8rAMauvUg/JmTa2sBxh91nbICN400yz2b5nm
         2h2GHbhPQFhSvP5UOokpvG4gV6v7opxpXeCQ/qnxRcqlnIbjQrXqO0cAdaeqXyhyyVFo
         d1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756335420; x=1756940220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvbMFSv0rY0WE0NHNJ8jMam8jzUNY5PyLsTi66Gs+wY=;
        b=b45SbdBrRQoDBDYVEt2w/4H5ZB/xvxKxq5UwneC1iU/WyJO3m3vWDjYjcuDc9tZOid
         Qjw4ePPsGKGhM1Jd+kcc7/zxKj/8CUrNjip3sxzXbRTsT+iwIGF7JgNcIdbE8gpuT9ao
         594tHjL30v9niS2zKEML+DM5DLpYmRhKPNUOk5zpA0pbPCVZ9Yw6uJS6s2/SXOHDNRGs
         8DOb+1bjS08GY6zxSIb2wdreIt68XHGWC+hz+bm9TbvkjvP/6HOoc5+ANgd6wb7hIFIX
         bEIrSon4KqSIdS72hvJ0No3zznJTzahtxBlFM+6N3D3CZkRHIZvt0cIUfOp1vnz641fv
         RvPg==
X-Gm-Message-State: AOJu0YwwHwtaEHGB25qn5J4kdC0enNIXZ4Thx8HAxT+d9SH35XOhKRIc
	EKUdDF0JImYaRnZcQFXCym66JvBCq82+nQbBTTTTHbk7hyTsv8QS99idCTghcNhpNcebcFYa2DZ
	thMrxLkx5iM1ZU70GYTmPPrQPP+yE9uUyjVIXbzM=
X-Gm-Gg: ASbGnctXhZmYyEotutV2Nx0hfRLP59APKzh0cxPHnLzF5c1Ngda6+BnyT6etuEoDlOj
	vV3P+AOnNuQlv2RL4XlvW8XxJsyTZusQ8i9Shi2roy3XgfiWAtj3r+prdIBCTOdCumgrSkTv+Jf
	4+0AN1CqLbBBwEnJ4NXO9ADV9w7tbdEQeUeAcrU/1JOsQc1b3lqAsHmlBf9/DyRWLbkxKsGS7Fo
	MPR6ckE3VmJDO1qoLo=
X-Google-Smtp-Source: AGHT+IFc7jPDkYVDA99L3FF4TcsSpdhdymRF1OC312gfJX/4kILEAxB/ajjQ7asEqlcrxc4jmOX8Of9PQHj/ZQ9F/qk=
X-Received: by 2002:a05:622a:4d4f:b0:4b2:db87:740b with SMTP id
 d75a77b69052e-4b2db877cc3mr144067631cf.76.1756335420181; Wed, 27 Aug 2025
 15:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827110004.584582-1-mszeredi@redhat.com>
In-Reply-To: <20250827110004.584582-1-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 Aug 2025 15:56:49 -0700
X-Gm-Features: Ac12FXyIPRh1zMdn7sikeXaHDv7wWsKf3WBiAqXhsHSAy23P8O_UY-GW42nz0V4
Message-ID: <CAJnrk1b8FZC82oeWuynWk5oqiRe+04frUv-4w9=jg319KvUz0A@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:00=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> FUSE_INIT has always been asynchronous with mount.  That means that the
> server processed this request after the mount syscall returned.
>
> This means that FUSE_INIT can't supply the root inode's ID, hence it
> currently has a hardcoded value.  There are other limitations such as not
> being able to perform getxattr during mount, which is needed by selinux.
>
> To remove these limitations allow server to process FUSE_INIT while
> initializing the in-core super block for the fuse filesystem.  This can
> only be done if the server is prepared to handle this, so add
> FUSE_DEV_IOC_SYNC_INIT ioctl, which
>
>  a) lets the server know whether this feature is supported, returning
>  ENOTTY othewrwise.
>
>  b) lets the kernel know to perform a synchronous initialization
>
> The implementation is slightly tricky, since fuse_dev/fuse_conn are set u=
p
> only during super block creation.  This is solved by setting the private
> data of the fuse device file to a special value ((struct fuse_dev *) 1) a=
nd
> waiting for this to be turned into a proper fuse_dev before commecing wit=
h
> operations on the device file.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> v2:
>
>  - make fuse_send_init() perform sync/async sequence based on fc->sync_in=
it
>    (Joanne)
>
> fs/fuse/cuse.c            |  3 +-
>  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
>  fs/fuse/dev_uring.c       |  4 +--
>  fs/fuse/fuse_dev_i.h      | 13 +++++--
>  fs/fuse/fuse_i.h          |  5 ++-
>  fs/fuse/inode.c           | 50 ++++++++++++++++++++------
>  include/uapi/linux/fuse.h |  1 +
>  7 files changed, 115 insertions(+), 35 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 8ac074414897..948f45c6e0ef 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1530,14 +1530,34 @@ static int fuse_dev_open(struct inode *inode, str=
uct file *file)
>         return 0;
>  }
>
> +struct fuse_dev *fuse_get_dev(struct file *file)
> +{
> +       struct fuse_dev *fud =3D __fuse_get_dev(file);
> +       int err;
> +
> +       if (likely(fud))
> +               return fud;
> +
> +       err =3D wait_event_interruptible(fuse_dev_waitq,
> +                                      READ_ONCE(file->private_data) !=3D=
 FUSE_DEV_SYNC_INIT);

I wonder if we should make the semantics the same for synchronous and
non-synchronous inits here, i.e. doing a wait for
"(READ_ONCE(file->private_data) !=3D FUSE_DEV_SYNC_INIT) &&
READ_ONCE(file->private_data) !=3D NULL", so that from the libfuse point
of view, the flow can be unified between the two, eg
i) send sync_init ioctl call if doing a synchronous init
ii) kick off thread to read requests
iii) do mount call
otherwise for async inits, the mount call needs to happen first.

> +       if (err)
> +               return ERR_PTR(err);
> +
> +       fud =3D __fuse_get_dev(file);
> +       if (!fud)
> +               return ERR_PTR(-EPERM);
> +
> +       return fud;
> +}
> +
>  static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>  {
>         struct fuse_copy_state cs;
>         struct file *file =3D iocb->ki_filp;
>         struct fuse_dev *fud =3D fuse_get_dev(file);
>
> -       if (!fud)
> -               return -EPERM;
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
>
>         if (!user_backed_iter(to))
>                 return -EINVAL;
> @@ -1557,8 +1577,8 @@ static ssize_t fuse_dev_splice_read(struct file *in=
, loff_t *ppos,
>         struct fuse_copy_state cs;
>         struct fuse_dev *fud =3D fuse_get_dev(in);
>
> -       if (!fud)
> -               return -EPERM;
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
>
>         bufs =3D kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffe=
r),
>                               GFP_KERNEL);
> @@ -2233,8 +2253,8 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, s=
truct iov_iter *from)
>         struct fuse_copy_state cs;
>         struct fuse_dev *fud =3D fuse_get_dev(iocb->ki_filp);

Does this (and below in fuse_dev_splice_write()) need to be
fuse_get_dev()? afaict, fuse_dev_write() only starts getting used
after fud has already been initialized. i see why it's needed for
fuse_dev_read() since otherwise the server doesn't know when it can
start calling fuse_dev_read(), but for fuse_dev_write(), it seems like
that only gets used after fud is already initialized.

>
> -       if (!fud)
> -               return -EPERM;
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
>
>         if (!user_backed_iter(from))
>                 return -EINVAL;
> @@ -2258,8 +2278,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_in=
ode_info *pipe,
>         ssize_t ret;
>
>         fud =3D fuse_get_dev(out);
> -       if (!fud)
> -               return -EPERM;
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
>
>         pipe_lock(pipe);
>
> @@ -2581,8 +2601,8 @@ static long fuse_dev_ioctl_backing_open(struct file=
 *file,
>         struct fuse_dev *fud =3D fuse_get_dev(file);

Should this be __fuse_get_dev()?

>         struct fuse_backing_map map;
>
> -       if (!fud)
> -               return -EPERM;
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
>
>         if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 return -EOPNOTSUPP;
> @@ -2598,8 +2618,8 @@ static long fuse_dev_ioctl_backing_close(struct fil=
e *file, __u32 __user *argp)
>         struct fuse_dev *fud =3D fuse_get_dev(file);

Same question here.

>         int backing_id;
>
> -       if (!fud)
> -               return -EPERM;
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
>
>         if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 return -EOPNOTSUPP;
> @@ -2610,6 +2630,19 @@ static long fuse_dev_ioctl_backing_close(struct fi=
le *file, __u32 __user *argp)
>         return fuse_backing_close(fud->fc, backing_id);
>  }
>
> +static long fuse_dev_ioctl_sync_init(struct file *file)
> +{
> +       int err =3D -EINVAL;
> +
> +       mutex_lock(&fuse_mutex);
> +       if (!__fuse_get_dev(file)) {
> +               WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);

Does this still need a WRITE_ONCE if it's accessed within the scope of
the mutex? My understanding (maybe wrong) is that a mutex implicitly
serves as also a memory barrier. If not, then we probably also need a
WRITE_ONCE() around the *ctx->fudptr assignment in
fuse_fill_super_common()?


Thanks,
Joanne

> +               err =3D 0;
> +       }
> +       mutex_unlock(&fuse_mutex);
> +       return err;
> +}
> +
> @@ -1876,8 +1901,10 @@ int fuse_fill_super_common(struct super_block *sb,=
 struct fuse_fs_context *ctx)
>
>         list_add_tail(&fc->entry, &fuse_conn_list);
>         sb->s_root =3D root_dentry;
> -       if (ctx->fudptr)
> +       if (ctx->fudptr) {
>                 *ctx->fudptr =3D fud;
> +               wake_up_all(&fuse_dev_waitq);
> +       }
>         mutex_unlock(&fuse_mutex);
>         return 0;
>

