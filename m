Return-Path: <linux-fsdevel+bounces-58861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01710B32527
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 00:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFFCB64006
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF72820A3;
	Fri, 22 Aug 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um7ZYC9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526227602E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902818; cv=none; b=GFuLYE/9vrGs//So5hI+FpAxZeP1OuC9Lz4v85rf9lDHqE7evYGIzI0kCs0/kwItZHZPKNA4w0BtgUkTOnkdzrbfrtae59oeyMMeskmNR1tveA/N+tIHF+7jSow9VXpHxdLD6CR5by7E31Vy2enFoeT3tiQpMXI8xmeLy7yGcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902818; c=relaxed/simple;
	bh=ph3BP5Q5Ef3dep9ugAz/wykQIzWHSdvdYxLUVhHxuT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAIuT0cztaIlODmnQ/51MoaDf5Duziv8vXm2p3YHp0050Vy9GsNYzB72u0pNOwCR2g3AUwrOvNbVLCP4d2SNt2xeEBacylwClVea8WzDVToN9RRUVfLKYPVTTYhj9zO4HpIdcI7Wj7jpzH+jCJNUtuBogF5hrEZGTWQS9lrcQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um7ZYC9Q; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e87036b8aeso311537685a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755902816; x=1756507616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz5oJmwIHeTa+Od4I9erb8ZTsA1phEBAuUJ8TEYHXt8=;
        b=Um7ZYC9QskBazPqvnaukyjBlpC284LGxYWfIWvdABfZWPpK4UIL73COfPVCAnCfMxd
         LrPQrexTpKUmt2zb3JMBWA8mglgAXwGQETPVbts0VmVPNeJRiIyFEhmrdeWqjm9JWjeV
         fe2Z/yejdR5NOFQWZFoOgYsAwJyAKDNTt4FuXxQOJCQD0C2BUEJot05m90Vz0hs3yK/D
         Q2EpY8W3jsJjMztcK1FRWVC+O6+3H/vUvEoDi6GEuBSeZc+ZIW0OuR+9uCiPbY9ja3mt
         wo8hoCaxGtTeHnj1mZP4tj80IERM16jFI1N3O9eg9CQ7d0q+pSoFlR58u3ZSzGZeOsAB
         6Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755902816; x=1756507616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz5oJmwIHeTa+Od4I9erb8ZTsA1phEBAuUJ8TEYHXt8=;
        b=ECgHvPdzYLtKRfby9tszeFYKkJJOcpS+E9yFYfjEdkIxRzKAQ0d3vyLu5rVWi95uu2
         dcAgouWhoqfK9RE46OEBtv1Qb1ZSMFU44uoTo2QdRPurrYGlZDzmNTfq0P/E+JfwZXA3
         XvQQFcZloMqSUpOwj3jRZOIa50AEkmUDFg8u2eOd4c7/rt4ucubPNfk10pwYf+2dgqSR
         xlpPVWy/9km0r8krAhBUNNUEDceGzEx5ZkLA19hB1by1ca6SWZl6b9vzmbmGpEvWybvr
         swskYV3nTFOeeZa3NNbrjeoBTnUy4n9Lw8O5b54IvPtYT1l2sSuCRUJ5eP4/rjCl5Ni7
         HGfg==
X-Gm-Message-State: AOJu0YzHisLeRFFS0XQUwfRrQ3LUEObD/V9vK82fDNLS4+p5mBFwYVrS
	s+yL7S2m5ggEqD24UmCnt8xO+J9QSAzPwRp6Kfm89wxWgtbqVy+dq2FoIsqpPLFzUUwf+Huh3f6
	wI2hw9xK8ONQl2k1ZtHFfR1tyHpDGMc8=
X-Gm-Gg: ASbGncsEB58Hg6zAuo/CcF9k5zUu1LEIB34twx/C0mz5R8jRp3O9Ogg3FnaxLMRt2Ep
	GFAqWANE2bMUzNdgIZ/m1DGBd0kdTizZDvnwsszRY4sch7ggj76Nnw/tcGS4lQsSc4vmdJ6IA4d
	GTCAZj0aK/3F06s3bTyA+gnGyhNsJUF7RJVSpYVqSHP+pvuWeCsXTkJBvy8q04kGx8A6fJEoTe8
	CHVsKDo
X-Google-Smtp-Source: AGHT+IGbuzhSAKMXmYFw1fqT2Jj5yJ4Rnhsn2wnTbHvcgp4ag4TfYpA5dyUQ4nXsg5elGrgs79zSF88odf8EXWt/3hs=
X-Received: by 2002:a05:622a:13d2:b0:4b0:6a5e:8ad1 with SMTP id
 d75a77b69052e-4b2aaa55f58mr51048901cf.34.1755902815858; Fri, 22 Aug 2025
 15:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822114436.438844-1-mszeredi@redhat.com>
In-Reply-To: <20250822114436.438844-1-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 Aug 2025 15:46:44 -0700
X-Gm-Features: Ac12FXzK4_Tl0wOKUeTYte7JhFDTk6FttojxvWu6vipaQYuJZEhkhHD1t6fSB98
Message-ID: <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:44=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
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
> I tested this with my raw-interface tester, so no libfuse update yet.  Wi=
ll
> work on that next.
>
>  fs/fuse/cuse.c            |  3 +-
>  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
>  fs/fuse/dev_uring.c       |  4 +--
>  fs/fuse/fuse_dev_i.h      | 13 +++++--
>  fs/fuse/fuse_i.h          |  3 ++
>  fs/fuse/inode.c           | 46 +++++++++++++++++++-----
>  include/uapi/linux/fuse.h |  1 +
>  7 files changed, 112 insertions(+), 32 deletions(-)
>

Will read this more thoroughly next week but left some comments below for n=
ow.

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
>
> +static long fuse_dev_ioctl_sync_init(struct file *file)
> +{
> +       int err =3D -EINVAL;
> +
> +       mutex_lock(&fuse_mutex);
> +       if (!__fuse_get_dev(file)) {
> +               WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
> +               err =3D 0;
> +       }
> +       mutex_unlock(&fuse_mutex);
> +       return err;

Does this let an untrusted server deadlock fuse if they call
FUSE_DEV_IOC_SYNC_INIT twice? afaict, fuse_mutex is a global lock and
the 2nd FUSE_DEV_IOC_SYNC_INIT call can forever hold fuse_mutex
because of the __fuse_get_dev() -> wait_event_interruptible().

> +}
> +
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9d26a5bc394d..d5f9f2abc569 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1898,6 +1913,7 @@ EXPORT_SYMBOL_GPL(fuse_fill_super_common);
>  static int fuse_fill_super(struct super_block *sb, struct fs_context *fs=
c)
>  {
>         struct fuse_fs_context *ctx =3D fsc->fs_private;
> +       struct fuse_mount *fm;
>         int err;
>
>         if (!ctx->file || !ctx->rootmode_present ||
> @@ -1918,8 +1934,22 @@ static int fuse_fill_super(struct super_block *sb,=
 struct fs_context *fsc)
>                 return err;
>         /* file->private_data shall be visible on all CPUs after this */
>         smp_mb();
> -       fuse_send_init(get_fuse_mount_super(sb));
> -       return 0;
> +
> +       fm =3D get_fuse_mount_super(sb);
> +
> +       if (fm->fc->sync_init) {
> +               struct fuse_init_args *ia =3D fuse_new_init(fm);
> +
> +               err =3D fuse_simple_request(fm, &ia->args);
> +               if (err > 0)
> +                       err =3D 0;
> +               process_init_reply(fm, &ia->args, err);

Do we need a fuse_dev_free() here if err < 0? If err < 0 then the
mount fails, but fuse_fill_super_common() -> fuse_dev_alloc_install()
will have already been called which if i'm understanding it correctly
means otherwise the fc will get leaked in this case. Or I guess
another option is to retain original behavior with having the mount
succeed even if the init server reply returns back an error code?

> +       } else {
> +               fuse_send_init(fm);
> +               err =3D 0;
> +       }

imo this logic looks cleaner if fuse_send_init() takes in a 'bool
async' arg and the bulk of this logic is handled there. Especially if
virtio is also meant to support synchronous init requests (which I'm
not seeing why it wouldn't?)

Thanks,
Joanne

> +
> +       return err;
>  }
>
>  /*
> @@ -1980,7 +2010,7 @@ static int fuse_get_tree(struct fs_context *fsc)
>          * Allow creating a fuse mount with an already initialized fuse
>          * connection
>          */
> -       fud =3D READ_ONCE(ctx->file->private_data);
> +       fud =3D __fuse_get_dev(ctx->file);
>         if (ctx->file->f_op =3D=3D &fuse_dev_operations && fud) {
>                 fsc->sget_key =3D fud->fc;
>                 sb =3D sget_fc(fsc, fuse_test_super, fuse_set_no_super);

