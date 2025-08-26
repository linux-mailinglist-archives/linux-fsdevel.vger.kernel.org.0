Return-Path: <linux-fsdevel+bounces-59324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB5B3747D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 23:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274B41B261C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1628643A;
	Tue, 26 Aug 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/7u/gVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031926A09F
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244665; cv=none; b=kcu8fb+tRQa+qrfFxSG3Jug2i6ty+6nfXUTQbxI78GRQWwYThb1xWj2Tc9qbO7t1cOiReVeTzFpWx4NeQ5vPvaGj0jmTt4QqPYJe962nwgPETV5mMahvQxOWRu/zqKQy98/AZpNkATy76iBW3Zv3JuEylnHrrJFMIsWVP7YOlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244665; c=relaxed/simple;
	bh=tM4vVAIWDdqoMsw+oAd0bdagRvfadjhhM+miOjbqBvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZui6QTUUuCgNA0vVoqA9dxRkrDfgBQdue6YeySYPhX81pbfteyWQzm2JGBm2d+VAH7fPzU+AY6/2EAEmcBHT6hOpUgg+svE1ZkfbFPozn4dbgMJ/VQkzKbGJShtYsYN+JbWHryTFpTbzcmEmc0En8M/nEA+rGKu0ngd/fAHwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/7u/gVu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b2d501db08so30858851cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756244663; x=1756849463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgU8fJSVnHmMknXxUnDCxpLHNnBi6YOWxM34XEd7GWM=;
        b=S/7u/gVuubNB6r6zhYf2i30uGYURh8jFk3cxFBfT966kLzd/4Pe1XbEW3UoSiwWY3z
         2qqibObhg2C1TXTyVUbq3wjdrvBRxeZvVLnIBIHODoyZlAj/vyMubq9IVk8dgEMyfp47
         zg5nG/0RUQSKi0Ys5Zryz2nLjep7l0n0A7tNp0sys+GjfRuSyiLnT2hTxNpAYp4W6VDR
         MKmbrJvS76gWMeX+uoAHhL9EAFamSjbqDi9tyRjYY3Qr1mDk2Pg/IpUDhgQ7E3alSFzk
         x91CTtv4ahpsIemI55MtioAcA463BmjJgayZTPoiCZjO7yHqj/3uxWvrJU8qXxXpKirz
         R7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244663; x=1756849463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgU8fJSVnHmMknXxUnDCxpLHNnBi6YOWxM34XEd7GWM=;
        b=sLk2OdNToMAsQyn/gW8n6fl1rJKQueg0tgYDB+PRJNPOvso8ecmHJCE4ZxYtNVQTB5
         7nbG0vcRxFWwHR78SGPwMXLm/hfKZbHttyEaWcUmDN58/5vM7QC4SC3ko/Dnoc5sGU2N
         epzu2FXSFvNMxZZi4aQ/dIurn+GHh/9TFIaVt9ltMF1FTphpCUt/1ihlnKk+KXHTB3kR
         dd2wQIjmtUaGkZnu9HrHUtyegFlJT96S2tZnOdvXgZqsC6w0abkwpnPbi88Oy6LdOCSc
         VfNPN8nE27X83qjVsWHeHhgZYKSrXVHls+fSWROGm9t0yGXMyanLx8N1XTuLwo2gNa/K
         fGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5iXhqXIDzJi9YdeAr43MkTM6zZto0MfHPKejfbvf/fzVflttNT8UADfgACaLKscPiVTlTEA2Yfv+QXFZe@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXKhvPAsmVhRe/HSTPHGwBH5uOiqmdNu7+kzBhsZKiv8UDFFT
	ChN/LLxvHQrJasYckV7KZHZrrCJZCDseI9J47tK3qTPczqQVDR9mhGm2zTGRZNY4dfbnvsYCvKM
	0TUGa1zjgXAGncRQ3wmuM8Oeme1EDFo40kQ==
X-Gm-Gg: ASbGncttMDoImmMbB54U+qHxWVGsELovE9ZiESyNfXEb6RgJVi3ZxPoDMNttfiH9gJ8
	xleol7GLfXsDE/phwSnuVeBdvMoAlbDpI5vP8DKqXYjjUwJAzX684YfQiMtipXi/vIAiL0EkPqI
	kCoApJQOD8dXlXUfGbRU/LC0dZhUFUcivodUY544IB7WOCqJ00e1SNXjdl3l8vdJsgdgohu4Ibi
	ZSrmVE2zTlmh9ZJGL0=
X-Google-Smtp-Source: AGHT+IFj5eoqb+g852I2tRpr9vUXfv/0swZmyWWTtxZLT1XcA8FECHbn2yXMd6AJx8Z/qEfqcKJHvc5ZimYOulDEr/M=
X-Received: by 2002:a05:622a:3c8:b0:4b1:2783:ab99 with SMTP id
 d75a77b69052e-4b2aaacf013mr213823361cf.39.1756244662907; Tue, 26 Aug 2025
 14:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822114436.438844-1-mszeredi@redhat.com> <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
 <CAJnrk1avdErcTcOAMuVTof4J_csc-k1vtq2=9z5Jpqws=VCY+g@mail.gmail.com>
 <20250826192618.GD19809@frogsfrogsfrogs> <CAJnrk1ah4rUNz6FbR0fWjJ95i_pNKmK+vWXFwhvwNak6z5bupQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ah4rUNz6FbR0fWjJ95i_pNKmK+vWXFwhvwNak6z5bupQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 26 Aug 2025 14:44:12 -0700
X-Gm-Features: Ac12FXyGC8dMlKi7x3ISDea6TeF61cksqVYH84bOzbPCupuu0Kc98YjjD40O-Ss
Message-ID: <CAJnrk1bAT-oDctFWmLK+uFwgGnTQqkqTYBG8FsS2cYWhW4=mYQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Aug 26, 2025 at 12:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> >
> > On Fri, Aug 22, 2025 at 03:52:38PM -0700, Joanne Koong wrote:
> > > On Fri, Aug 22, 2025 at 3:46=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Aug 22, 2025 at 4:44=E2=80=AFAM Miklos Szeredi <mszeredi@re=
dhat.com> wrote:
> > > > >
> > > > > FUSE_INIT has always been asynchronous with mount.  That means th=
at the
> > > > > server processed this request after the mount syscall returned.
> > > > >
> > > > > This means that FUSE_INIT can't supply the root inode's ID, hence=
 it
> > > > > currently has a hardcoded value.  There are other limitations suc=
h as not
> > > > > being able to perform getxattr during mount, which is needed by s=
elinux.
> > > > >
> > > > > To remove these limitations allow server to process FUSE_INIT whi=
le
> > > > > initializing the in-core super block for the fuse filesystem.  Th=
is can
> > > > > only be done if the server is prepared to handle this, so add
> > > > > FUSE_DEV_IOC_SYNC_INIT ioctl, which
> > > > >
> > > > >  a) lets the server know whether this feature is supported, retur=
ning
> > > > >  ENOTTY othewrwise.
> > > > >
> > > > >  b) lets the kernel know to perform a synchronous initialization
> > > > >
> > > > > The implementation is slightly tricky, since fuse_dev/fuse_conn a=
re set up
> > > > > only during super block creation.  This is solved by setting the =
private
> > > > > data of the fuse device file to a special value ((struct fuse_dev=
 *) 1) and
> > > > > waiting for this to be turned into a proper fuse_dev before comme=
cing with
> > > > > operations on the device file.
> > > > >
> > > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > > ---
> > > > > I tested this with my raw-interface tester, so no libfuse update =
yet.  Will
> > > > > work on that next.
> > > > >
> > > > >  fs/fuse/cuse.c            |  3 +-
> > > > >  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----=
------
> > > > >  fs/fuse/dev_uring.c       |  4 +--
> > > > >  fs/fuse/fuse_dev_i.h      | 13 +++++--
> > > > >  fs/fuse/fuse_i.h          |  3 ++
> > > > >  fs/fuse/inode.c           | 46 +++++++++++++++++++-----
> > > > >  include/uapi/linux/fuse.h |  1 +
> > > > >  7 files changed, 112 insertions(+), 32 deletions(-)
> > > > >
> > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > index 9d26a5bc394d..d5f9f2abc569 100644
> > > > > --- a/fs/fuse/inode.c
> > > > > +++ b/fs/fuse/inode.c
> > > > > @@ -1918,8 +1934,22 @@ static int fuse_fill_super(struct super_bl=
ock *sb, struct fs_context *fsc)
> > > > >                 return err;
> > > > >         /* file->private_data shall be visible on all CPUs after =
this */
> > > > >         smp_mb();
> > > > > -       fuse_send_init(get_fuse_mount_super(sb));
> > > > > -       return 0;
> > > > > +
> > > > > +       fm =3D get_fuse_mount_super(sb);
> > > > > +
> > > > > +       if (fm->fc->sync_init) {
> > > > > +               struct fuse_init_args *ia =3D fuse_new_init(fm);
> > > > > +
> > > > > +               err =3D fuse_simple_request(fm, &ia->args);
> > > > > +               if (err > 0)
> > > > > +                       err =3D 0;
> > > > > +               process_init_reply(fm, &ia->args, err);
> > > >
> > > > Do we need a fuse_dev_free() here if err < 0? If err < 0 then the
> >
> > Er... are you asking if we should drop the newly created fud via
> > fuse_dev_release if err !=3D 0?  (AFAICT there is no fuse_dev_free?)
> >
>
> That's weird, I see fuse_dev_free() in fs/fuse/inode.c (eg
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/fuse/inode.c#n1624)
>
> > > > mount fails, but fuse_fill_super_common() -> fuse_dev_alloc_install=
()
> > > > will have already been called which if i'm understanding it correct=
ly
> > > > means otherwise the fc will get leaked in this case. Or I guess
> > > > another option is to retain original behavior with having the mount
> > > > succeed even if the init server reply returns back an error code?
> >
> > <shrug> I was figuring that it was fine to leave the fud attached to th=
e
> > device fd until the caller close()s it, but OTOH maybe the fuse server
> > would like to try to mount again?  Do fuse servers do that?
>
> Won't this still leak the reference? From what I see, the mount will
> create the fc (refcount 1) then when the mount does the dev
> installation (fuse_dev_install()) that'll acquire another reference on
> fc. With the caller close()ing it, that releases 1 refcount but
> there's still 1 refcount that needs to be released by
> fuse_mount_destroy(). As I understand it, if the mount fails, the
> .kill_sb -> fuse_mount_destroy() never gets triggered (since it was
> never mounted) which will leave 1 refcount remaining.

Ahh okay, I just tested this experimentally and I see now where I'm
wrong. If the mount fails, the .kill_sb -> fuse_mount_destroy()
callback does actually still get triggered.

>
> >
> > --D
> >

