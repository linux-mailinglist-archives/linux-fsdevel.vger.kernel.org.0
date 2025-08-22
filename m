Return-Path: <linux-fsdevel+bounces-58862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067EFB32531
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 00:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB94624052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0434293B73;
	Fri, 22 Aug 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqMG5r+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7942820A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903172; cv=none; b=gHKhxfhPs2HUzsKpPpRRSkgD/PbEpBwrT+MLKhHkUFLecle67sg8d3LzsP3l+fhNTKV4LS5BfhXC3cULTBWK3hgvMh0PwHDQPgNaNxfpZMyNL3FRWq2mg966MqD/GMoDwWmZtFxcujIRqDkEdZ18xaBAwQZU0NZMUlavJRSxUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903172; c=relaxed/simple;
	bh=dT7OOshCBYsZRyOuImImaYBeNoXwh5tIuasxAWFDx1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flNf7suCJWB5p4mjkCcbwDQPSGKOn3WsLQYhQFliSQF4kSygB0GbV43b66cxIOhOsH1cqUcJ1rju+sgCZP181mgK2ZsVi3iwAxxODOMxSOfttWSDAHdO80x7lU1jTAuAlu9BDHwkRj8gfdOzbDqHXhWRTeB+9TEGk4hD7YzN55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqMG5r+x; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e87036b8aeso311879385a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 15:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755903169; x=1756507969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/gyJx4SQFGrCV+/npa/vStwD5S7QwaMHK5ZUrB50UA=;
        b=fqMG5r+x0YWYkDjcTmJ8oWKanUWMndX0N1nsEdL6JRxejflT/EodVrMhXs+hSBZtbf
         WOi+PsUgsqfxhYQxxPcI0rsUYIpd0Enj8dNxx786Mb6QbRAXxgRd+1egLndDPn82HiXq
         bZBb3QqhfKZWeV+4LxleEpkGHjcopAtAUHSdxxWaflEyCEzOCBax/bu0OC6yOSQoxaxX
         5ETmnacl929tYbWw172vU4SPQ7pF9DzdXySdtBLFmcfVxbzaJDMF9c7w7uKNZjJk69iQ
         ED2Xzhul/btZiYEsDhEXUeBfrazwUzNl4q5c58mDDZplbUtnVnlNL25wfLGD3mJ5krjd
         N/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755903169; x=1756507969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/gyJx4SQFGrCV+/npa/vStwD5S7QwaMHK5ZUrB50UA=;
        b=Orq89aiVoUgTXiZxjKitFgIYLHkn2RQQepI5L4ghxYi/S4EiV98O4/G8nYS41v+HkJ
         z1Y5mPwYyVfQ9vZcrg4cvhR8mObyPVKDxKdXDEcSzkDoGscihwGGecFhWVGjh98oGMxp
         +3YvEVAAw7D2Sly/lODeXs+acvK1Xk8ougE76vld9m40q9LIfZN23fkg9iqvm9Y34cRm
         61s6BtRMNPDUFF6+jCVhr0bEBWW4O318tUvaVaqp5UWzRMZan8FxStNo9UBdJON7gdvk
         q3rUVZRmeznUEvlqbkAY4SZW9LDyR0wmgNRJBZpaLZw8/Zo61ulVkS3TxClLwilvMYyK
         t3Xw==
X-Gm-Message-State: AOJu0YzUxPTd3FIrInerZ/dUHtZ26LseY4iDNIZI5T8LNL+8qi8vxcRt
	KRIYNQu5xY/DRxGuOn2jpDmECk2ohG8ZHhYZOQWcDefSL8o/cHa/mHdHJ6F0i7HApDhFTuHu7xN
	MGl8w1GuqPoQB9PIGnYoB+5/c9GJ3hro=
X-Gm-Gg: ASbGncv1bNMr0UrMFSK+25+AHX1fTue0lO6GBuaPiWga6J0VkQEBCYYyeztUvRaHYuI
	NWTfSUdCCQUNcyTz4I689DO1+0USEQcQrjFH5ULpWKtRqVsYdQiIWVJ7qZlVBaqNuR7gopQp1A5
	TeiSYa+luuwjiOgEgsrtDM1ja1Dnfup2oAA5MhqzkIOBxDDx8LX/yS9J3M9p3A+5rKqT04kb7l2
	WTUeM1O
X-Google-Smtp-Source: AGHT+IFv57PGHlkn44V7Gofh5/ySYfbr5e2x6TGrR0SHp6zz7WxXS8PGoc2ook/qpNhs/TpIYUyqEGP3qBCguzJ7tlY=
X-Received: by 2002:a05:620a:1915:b0:7e6:65f9:e3d1 with SMTP id
 af79cd13be357-7ea1107ccefmr503778585a.57.1755903169162; Fri, 22 Aug 2025
 15:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822114436.438844-1-mszeredi@redhat.com> <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 Aug 2025 15:52:38 -0700
X-Gm-Features: Ac12FXxmS9lwswbdcDhYGdlHC-X_YP1zaQJObCWUuwRPoO4iya07NF5Qpqiu7HQ
Message-ID: <CAJnrk1avdErcTcOAMuVTof4J_csc-k1vtq2=9z5Jpqws=VCY+g@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 3:46=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Aug 22, 2025 at 4:44=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:
> >
> > FUSE_INIT has always been asynchronous with mount.  That means that the
> > server processed this request after the mount syscall returned.
> >
> > This means that FUSE_INIT can't supply the root inode's ID, hence it
> > currently has a hardcoded value.  There are other limitations such as n=
ot
> > being able to perform getxattr during mount, which is needed by selinux=
.
> >
> > To remove these limitations allow server to process FUSE_INIT while
> > initializing the in-core super block for the fuse filesystem.  This can
> > only be done if the server is prepared to handle this, so add
> > FUSE_DEV_IOC_SYNC_INIT ioctl, which
> >
> >  a) lets the server know whether this feature is supported, returning
> >  ENOTTY othewrwise.
> >
> >  b) lets the kernel know to perform a synchronous initialization
> >
> > The implementation is slightly tricky, since fuse_dev/fuse_conn are set=
 up
> > only during super block creation.  This is solved by setting the privat=
e
> > data of the fuse device file to a special value ((struct fuse_dev *) 1)=
 and
> > waiting for this to be turned into a proper fuse_dev before commecing w=
ith
> > operations on the device file.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> > I tested this with my raw-interface tester, so no libfuse update yet.  =
Will
> > work on that next.
> >
> >  fs/fuse/cuse.c            |  3 +-
> >  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
> >  fs/fuse/dev_uring.c       |  4 +--
> >  fs/fuse/fuse_dev_i.h      | 13 +++++--
> >  fs/fuse/fuse_i.h          |  3 ++
> >  fs/fuse/inode.c           | 46 +++++++++++++++++++-----
> >  include/uapi/linux/fuse.h |  1 +
> >  7 files changed, 112 insertions(+), 32 deletions(-)
> >
>
> Will read this more thoroughly next week but left some comments below for=
 now.
>
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 8ac074414897..948f45c6e0ef 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1530,14 +1530,34 @@ static int fuse_dev_open(struct inode *inode, s=
truct file *file)
> >         return 0;
> >  }
> >
> > +struct fuse_dev *fuse_get_dev(struct file *file)
> > +{
> > +       struct fuse_dev *fud =3D __fuse_get_dev(file);
> > +       int err;
> > +
> > +       if (likely(fud))
> > +               return fud;
> > +
> > +       err =3D wait_event_interruptible(fuse_dev_waitq,
> > +                                      READ_ONCE(file->private_data) !=
=3D FUSE_DEV_SYNC_INIT);
> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       fud =3D __fuse_get_dev(file);
> > +       if (!fud)
> > +               return ERR_PTR(-EPERM);
> > +
> > +       return fud;
> > +}
> > +
> >
> > +static long fuse_dev_ioctl_sync_init(struct file *file)
> > +{
> > +       int err =3D -EINVAL;
> > +
> > +       mutex_lock(&fuse_mutex);
> > +       if (!__fuse_get_dev(file)) {
> > +               WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
> > +               err =3D 0;
> > +       }
> > +       mutex_unlock(&fuse_mutex);
> > +       return err;
>
> Does this let an untrusted server deadlock fuse if they call
> FUSE_DEV_IOC_SYNC_INIT twice? afaict, fuse_mutex is a global lock and
> the 2nd FUSE_DEV_IOC_SYNC_INIT call can forever hold fuse_mutex
> because of the __fuse_get_dev() -> wait_event_interruptible().

Never mind this comment, I got __fuse_get_dev() and fuse_get_dev()
mixed up. fuse_get_dev() is the one that calls
wait_event_interruptible(), not __fuse_get_dev().

>
> > +}
> > +
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 9d26a5bc394d..d5f9f2abc569 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1898,6 +1913,7 @@ EXPORT_SYMBOL_GPL(fuse_fill_super_common);
> >  static int fuse_fill_super(struct super_block *sb, struct fs_context *=
fsc)
> >  {
> >         struct fuse_fs_context *ctx =3D fsc->fs_private;
> > +       struct fuse_mount *fm;
> >         int err;
> >
> >         if (!ctx->file || !ctx->rootmode_present ||
> > @@ -1918,8 +1934,22 @@ static int fuse_fill_super(struct super_block *s=
b, struct fs_context *fsc)
> >                 return err;
> >         /* file->private_data shall be visible on all CPUs after this *=
/
> >         smp_mb();
> > -       fuse_send_init(get_fuse_mount_super(sb));
> > -       return 0;
> > +
> > +       fm =3D get_fuse_mount_super(sb);
> > +
> > +       if (fm->fc->sync_init) {
> > +               struct fuse_init_args *ia =3D fuse_new_init(fm);
> > +
> > +               err =3D fuse_simple_request(fm, &ia->args);
> > +               if (err > 0)
> > +                       err =3D 0;
> > +               process_init_reply(fm, &ia->args, err);
>
> Do we need a fuse_dev_free() here if err < 0? If err < 0 then the
> mount fails, but fuse_fill_super_common() -> fuse_dev_alloc_install()
> will have already been called which if i'm understanding it correctly
> means otherwise the fc will get leaked in this case. Or I guess
> another option is to retain original behavior with having the mount
> succeed even if the init server reply returns back an error code?
>
> > +       } else {
> > +               fuse_send_init(fm);
> > +               err =3D 0;
> > +       }
>
> imo this logic looks cleaner if fuse_send_init() takes in a 'bool
> async' arg and the bulk of this logic is handled there. Especially if
> virtio is also meant to support synchronous init requests (which I'm
> not seeing why it wouldn't?)
>
> Thanks,
> Joanne
>
> > +
> > +       return err;
> >  }
> >
> >  /*
> > @@ -1980,7 +2010,7 @@ static int fuse_get_tree(struct fs_context *fsc)
> >          * Allow creating a fuse mount with an already initialized fuse
> >          * connection
> >          */
> > -       fud =3D READ_ONCE(ctx->file->private_data);
> > +       fud =3D __fuse_get_dev(ctx->file);
> >         if (ctx->file->f_op =3D=3D &fuse_dev_operations && fud) {
> >                 fsc->sget_key =3D fud->fc;
> >                 sb =3D sget_fc(fsc, fuse_test_super, fuse_set_no_super)=
;

