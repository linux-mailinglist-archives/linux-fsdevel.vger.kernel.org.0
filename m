Return-Path: <linux-fsdevel+bounces-9903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F1845D57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9B71C22484
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232E3FDB;
	Thu,  1 Feb 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0K+KOrz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58C4C67
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805234; cv=none; b=ndk8yFK0xGtTNMkpMfeLjuB/tJnBqir9x5RIcQkbMOiyFx3ZlKZ2IML8vVm40lTDcAN93ZrirvDP9GxO8SQBmi7lp8rxzG5y2Q9zTIgVj/Qe2kvnD99dF8c6MSqJg5IQf+3jE2OgWxlUo45ndMjNXhbUFyxa5caa+pBQqch2IiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805234; c=relaxed/simple;
	bh=q4oKGHaEd+DqEHnEW4gA6ouO0g/YOy9xwdFY7F1kAXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnP5g08iRsqNrjqwbTjBiVXe1J5lAPzbPKpoFY4V9h/AWOoCeTmPRAXtz5t6tPsgkOk0ID27k23WJfzK8GYTg2lo5eTIjTAH1jaV5fouyLElvui1uh1FHezmX+bvgvETAOwN1UU9W7Pd6r/g4xdDAy76AYfd6qLucapn7b9Aaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0K+KOrz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c444f9272so5336756d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706805231; x=1707410031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQYSZSxr7lfYsIoR5j17n7Mzcwq2R5CccFFTdCPO3fA=;
        b=d0K+KOrz5hfsJPQydrfWD6mmsLkpUQEDuISsR7Ypea2sorruSDMOGoDAUG2+FhD7PE
         wAkEXqJV3Ex7t1GBg1Si/ohm8HvY5r8rdeGUbw0+j6i/rfrASvRqDGiDttQUF5kYAjhF
         ho06EiY2SIEcVaODMm04wC+vuXrPkVQ51CkA/5V/tnZxEXo20RODAqAat5kZBwUyGalt
         6yM2OMCyyFZ2d3I7SxvReNI4wBWVlENnhwg0OOseGFkbe1HjHuHuEACXsx5B77rGf3mk
         MqXarGlHS5C73B14GL9xDYQR7WqLd4Z1zuB+kDuO0woHxW5Zapkrx8ZnrwxeruLThHSd
         18dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706805231; x=1707410031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQYSZSxr7lfYsIoR5j17n7Mzcwq2R5CccFFTdCPO3fA=;
        b=P/SaNmOlTW6h9k2Cjdqxz2hd/GxpYpI9+htOifnUlLNgZLCMbeWZsQ+wJyZQR35Z5K
         9SSPOFoFRdi+d0f92sGVVjMdIq3yc4kq94w+PgMAtTSy0ZxOeJNdyhFKjHYBoY975om4
         NborF6aq4ymlmp+WrPdjUAFkVTvVd1F9a+VL/RNl4jbs68Kr8+3TT67tYtNR7wS0lAiJ
         KRTrEQhA4xk6WVBss+TD+yzA2vcRaWBi+sUgtJX2QE7SZcqpTP3oM7V0xJYOVALXCHI3
         hp3IR9QAleglt/78wwPFU6M5rRRlb4NnruItKHJHVojUNJk/fgmSJssiqOAa75dpTETj
         JVAA==
X-Gm-Message-State: AOJu0YzQWJpeUyYAcniRaZkjw/v5aWTfaBxLmgbOD1eZ4Xm+C58DL4ie
	3Vb4fFi5hfIUwvnjbOKtCVs2yrvdl0yxu0ma8zwrwnY0Bd3WOm223HISVy1X1Cd5We/XxWjlQIJ
	aZUCZVr8cO8PbyZbkgsKKa5ER9LslHf1g
X-Google-Smtp-Source: AGHT+IFDHEpAMwGwYkizmCYFbd3YY/bl1NDNEIMsTP+DiI8Ll9bB7ga4r1Sbamh87qRg1cc2XdiA/Y5F2VdND0XtkBA=
X-Received: by 2002:a0c:e389:0:b0:68c:5337:b717 with SMTP id
 a9-20020a0ce389000000b0068c5337b717mr3015701qvl.18.1706805231374; Thu, 01 Feb
 2024 08:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-6-bschubert@ddn.com>
 <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com>
In-Reply-To: <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 18:33:39 +0200
Message-ID: <CAOQ4uxjVqCAYhn07Bnk6HsXB21t4FFQk91ywS3S8A8u=+B9A=w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fuse: introduce inode io modes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:47=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > The fuse inode io mode is determined by the mode of its open files/mmap=
s
> > and parallel dio.
> >
> > - caching io mode - files open in caching mode or mmap on direct_io fil=
e
> > - direct io mode - no files open in caching mode and no files mmaped
> > - parallel dio mode - direct io mode with parallel dio in progress
>
> Specifically if iocachectr is:
>
> > 0 -> caching io
> =3D=3D 0 -> direct io
> < 0 -> parallel io
>
> >
> > We use a new FOPEN_CACHE_IO flag to explicitly mark a file that was ope=
n
> > in caching mode.
>
> This is really confusing.  FOPEN_CACHE_IO is apparently an internally
> used flag, but it's defined on the userspace API.
>
> a) what is the meaning of this flag on the external API?
> b) what is the purpose of this flag internally?

The purpose is to annotate the state of direct io file that was mmaped
as FOPEN_DIRECT_IO | FOPEN_CACHE_IO.
An fd like this puts inode in caching mode and its release may get inode
out of caching mode.

I did not manage to do refcoutning with fuse_vma_close(), because those
calls are not balances with fuse_file_mmap() calls.

The first mmap() of an FOPEN_DIRECT_IO file may incur wait for completion
of parallel dio.

The only use of exporting FOPEN_CACHE_IO to the server is that it could
force incurring this wait at open() time instead of mmap() time.

I also considered for servers that advertise FUSE_PASSTHROUGH
capability to not allow open without specifying an explicit io mode,
that is one of  FOPEN_DIRECT_IO | FOPEN_CACHE_IO |
FOPEN_PASSTHROUGH, but I did not actually implement those
semantics ATM.

>
> >
> > direct_io mmap uses page cache, so first mmap will mark the file as
> > FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
> > the caching io mode.
> >
> > If the server opens the file with flags FOPEN_DIRECT_IO|FOPEN_CACHE_IO,
> > the inode enters caching io mode already on open.
> >
> > This allows executing parallel dio when inode is not in caching mode
> > even if shared mmap is allowed, but no mmaps have been performed on
> > the inode in question.
> >
> > An open in caching mode and mmap on direct_io file now waits for all
> > in-progress parallel dio writes to complete, so paralle dio writes
> > together with FUSE_DIRECT_IO_ALLOW_MMAP is enabled by this commit.
>
> I think the per file state is wrong, the above can be done with just
> the per-inode state.
>

The per-file state is to taint the file is "has been mmaped".
I did not find another way of doing this.
Please suggest another way.

>
> >
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/fuse/file.c            | 215 ++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h          |  79 +++++++++++++-
> >  include/uapi/linux/fuse.h |   2 +
> >  3 files changed, 286 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 7d2f4b0eb36a..eb9929ff9f60 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -105,10 +105,177 @@ static void fuse_release_end(struct fuse_mount *=
fm, struct fuse_args *args,
> >         kfree(ra);
> >  }
> >
> > +static bool fuse_file_is_direct_io(struct file *file)
> > +{
> > +       struct fuse_file *ff =3D file->private_data;
> > +
> > +       return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_DI=
RECT;
> > +}
>
> This is one of the issues with the per-file state. O_DIRECT can be
> changed with fcntl(fd, F_SETFL, ...), so state calculated at open can
> go stale.
>

Ouch!
Actually, it may not matter much if we just ignore O_DIRECT
completely for the purpose of io modes.

The io mode could be determined solely from FMODE_* flags.

Worst case is that if the server opens an O_DIRECT file without
FOPEN_DIRECT_IO, then this inode cannot do parallel dio
and this inode cannot be opened in passthrough mode.
I don't think that is such a big problem.

Bernd, what do you think?

BTW, server can and probably should open O_DIRECT files
with FOPEN_PASSTHROUGH and that means something
completely different than O_DIRECT && FOPEN_DIRECT_IO -
it means that io is passed through to the backing file without
doing buffered io on the backing file.

> > +
> > +/*
> > + * Wait for cached io to be allowed -
> > + * Blocks new parallel dio writes and waits for the in-progress parall=
el dio
> > + * writes to complete.
> > + */
> > +static int fuse_inode_wait_for_cached_io(struct fuse_inode *fi)
> > +{
> > +       int err =3D 0;
> > +
> > +       assert_spin_locked(&fi->lock);
> > +
> > +       while (!err && !fuse_inode_get_io_cache(fi)) {
> > +               /*
> > +                * Setting the bit advises new direct-io writes
> > +                * to use an exclusive lock - without it the wait below
> > +                * might be forever.
> > +                */
> > +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> > +               spin_unlock(&fi->lock);
> > +               err =3D wait_event_killable(fi->direct_io_waitq,
> > +                                         fuse_is_io_cache_allowed(fi))=
;
> > +               spin_lock(&fi->lock);
> > +       }
> > +       /* Clear FUSE_I_CACHE_IO_MODE flag if failed to enter caching m=
ode */
> > +       if (err && fi->iocachectr <=3D 0)
> > +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> > +
> > +       return err;
> > +}
>
> I suggest moving all infrastructure, including the inline helpers in
> fuse_i.h into a separate source file.
>

OK. I can make those changes.

> > +
> > +/* Start cached io mode where parallel dio writes are not allowed */
> > +static int fuse_file_cached_io_start(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > +       int err;
> > +
> > +       spin_lock(&fi->lock);
> > +       err =3D fuse_inode_wait_for_cached_io(fi);
> > +       spin_unlock(&fi->lock);
> > +       return err;
> > +}
> > +
> > +static void fuse_file_cached_io_end(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > +
> > +       spin_lock(&fi->lock);
> > +       fuse_inode_put_io_cache(get_fuse_inode(inode));
> > +       spin_unlock(&fi->lock);
> > +}
> > +
> > +/* Start strictly uncached io mode where cache access is not allowed *=
/
> > +static int fuse_file_uncached_io_start(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > +       bool ok;
> > +
> > +       spin_lock(&fi->lock);
> > +       ok =3D fuse_inode_deny_io_cache(fi);
> > +       spin_unlock(&fi->lock);
> > +       return ok ? 0 : -ETXTBSY;
> > +}
> > +
> > +static void fuse_file_uncached_io_end(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > +       bool allow_cached_io;
> > +
> > +       spin_lock(&fi->lock);
> > +       allow_cached_io =3D fuse_inode_allow_io_cache(fi);
> > +       spin_unlock(&fi->lock);
> > +       if (allow_cached_io)
> > +               wake_up(&fi->direct_io_waitq);
> > +}
> > +
> > +/* Open flags to determine regular file io mode */
> > +#define FOPEN_IO_MODE_MASK \
> > +       (FOPEN_DIRECT_IO | FOPEN_CACHE_IO)
> > +
> > +/* Request access to submit new io to inode via open file */
> > +static int fuse_file_io_open(struct file *file, struct inode *inode)
> > +{
> > +       struct fuse_file *ff =3D file->private_data;
> > +       int iomode_flags =3D ff->open_flags & FOPEN_IO_MODE_MASK;
> > +       int err;
> > +
> > +       err =3D -EBUSY;
> > +       if (WARN_ON(ff->io_opened))
> > +               goto fail;
> > +
> > +       if (!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode)) {
>
> This S_ISREG check can also go away with separating the directory opens.

OK. I will see if I can make that cleanup as well.

Thanks,
Amir.

