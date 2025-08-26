Return-Path: <linux-fsdevel+bounces-59323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F696B37479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 23:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD2B3B779B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD027F00A;
	Tue, 26 Aug 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPLxDn2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5E13D521
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244229; cv=none; b=Ulyx2QeGre5Dh+Fpo0AA4XlDvUbqLRH4wdbrSiltxZPQaFv1ybHWT+JXFP66ZHpoltz5V4GfwaP+oL+ZVZ+4Mco7GU+rS4pFvWPYBVFLqoTB3EL1t9TFOinq9LsmZIRh31pfWQsrkG11VZD9a83KkYg7lxna0Cab8TNkWcQn6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244229; c=relaxed/simple;
	bh=PF1Eg5aYt2fCaOdO1zQEWKVueNvgRe+anizsWiWUd5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPMCfq0q6qcOBqopmLoSfQyFt2arNxRAI2Xx12idzh2v39nT+RyoX/aYVAhXbRUDCBicb+PqzpIqM/RHQ6SvKRDsj7A4KYD/uGVRJJsOrUz+rrJ+WOGL8MlNKVXuiOv1CY8FXQD4Ejk4xPAXJYj2ijXmZ79sc4wHDeC3t9OgXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPLxDn2/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b2cf656e4fso3550241cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756244226; x=1756849026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XajqH6Xs/ioY79V5pXnWKz7XBojvWrKUFEMTaNH4vQo=;
        b=YPLxDn2/3SLgvQYsOTiNCO0T7QBTjY4w8KfRTYBj+ns0TNUKia/hxOBRCaIiww+N1F
         iQ/1yLwWh1QxFh+mvqdAWsqdcxO3zXTaCfd6VoJVfNBB9RD6LGs0SgPZS3OjqQSHVRsp
         PlZt23dnyKmWvBeVt47VoIs1+J75yM0dQinxTndxpyHm65lNCI5Q73EwL4+svA0uDdaP
         amvd7Gj67DajcyDZHBJJwiwMeVRIf2TnqI/KcZmvH4xRa6SmxFSDBlwxAOCdHlTKjtvA
         oEsT3KSjoZpkGr4xj9mmwnjhXgW49xv3klxxf4778G9NKeyZ0mCccXlaOd3XB970uP0I
         Qkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244226; x=1756849026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XajqH6Xs/ioY79V5pXnWKz7XBojvWrKUFEMTaNH4vQo=;
        b=sZgwt0GJ+oF97rTwbMkx4SXEOMpYZA2Vqk67HP3akZI71wvHU+gHBobFd0ijY9bWoa
         qdPGwq6OEBRix6JO4GB4qejED8Ws4KsNgag3gptuVdt9hNqNe6FWZhoeBIIG25GmzUe1
         poP4siMtyAs2cF9bJr3Gfctt9mwAz1ymxH9da5fp79Zz6e4M/NGWdQJQm5MnvFGPif58
         IIl8SBPfWO5do/QrO1pBwjQKWWPhhLBFnRxc+KSjKK/wDm7G1z5RjBJPIUG0A30yAZa7
         KB85239I3UbtJbQcb1LGdG1Zi5vM9WH/dQIvHaxWgszSWdeYuXr41tFd2tC/sxu2LQWb
         2Piw==
X-Forwarded-Encrypted: i=1; AJvYcCWu7B1QypayRxMm9G9nt99l5z6MIsfoCAF6uGa4frmR5yBt3GLzqcOz9tgH3/ZfYbFapAUwNPA64EEd1gr9@vger.kernel.org
X-Gm-Message-State: AOJu0YzszOSURL94AzeCkCqdKysdJKHZVAn8D09awoHgjvC7o89orb+Q
	kugKN4Roi3s/eEu5AzXz4/vbL+1pjn0mZgelqS6WLiJ9fLLRs2L8V7ZgQmZn6ubL80P/TiMnGLj
	4B2dm//KPXYktV9phcnR7mO4/3CTvcKk=
X-Gm-Gg: ASbGnct/yaoSnf7og1ndu27G45KSoCNo83wAd7sDJMRoinJCa235NsND/sDY+zTCmS3
	x8tboeVtNHAXNSnMf71QE8FcNQWobacg0W2yhCwhw7PMVIS+/LybtxV64BorMkv8Lx9wUFH7Bj5
	mujT78Gfim8uiX28D3358Wuv7SLB4bM7tv/kjPyWUfAb7uEC1qOSgY0WFbX4MoAui/VSXo7rnGx
	4Xuv2B3qlmYb8PoH1c=
X-Google-Smtp-Source: AGHT+IFE/V65rkSwAzjc0/d1iVQrEZvQVzti44iWXdtvFg1wz6k6zD47kzW6bewBtkabZ6bxg/L3AGhSLVgRC6UsRU4=
X-Received: by 2002:ac8:6907:0:b0:4ab:95a7:5f4 with SMTP id
 d75a77b69052e-4b2e76f8291mr37895991cf.27.1756244226005; Tue, 26 Aug 2025
 14:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822114436.438844-1-mszeredi@redhat.com> <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
 <CAJnrk1avdErcTcOAMuVTof4J_csc-k1vtq2=9z5Jpqws=VCY+g@mail.gmail.com> <20250826192618.GD19809@frogsfrogsfrogs>
In-Reply-To: <20250826192618.GD19809@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 26 Aug 2025 14:36:55 -0700
X-Gm-Features: Ac12FXxQtXGYUR95T7bhC4aY1OZkjJ2fZlNelYiRqxqhP7GjRAIiI7aT8fk7SBw
Message-ID: <CAJnrk1ah4rUNz6FbR0fWjJ95i_pNKmK+vWXFwhvwNak6z5bupQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Aug 22, 2025 at 03:52:38PM -0700, Joanne Koong wrote:
> > On Fri, Aug 22, 2025 at 3:46=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 4:44=E2=80=AFAM Miklos Szeredi <mszeredi@redh=
at.com> wrote:
> > > >
> > > > FUSE_INIT has always been asynchronous with mount.  That means that=
 the
> > > > server processed this request after the mount syscall returned.
> > > >
> > > > This means that FUSE_INIT can't supply the root inode's ID, hence i=
t
> > > > currently has a hardcoded value.  There are other limitations such =
as not
> > > > being able to perform getxattr during mount, which is needed by sel=
inux.
> > > >
> > > > To remove these limitations allow server to process FUSE_INIT while
> > > > initializing the in-core super block for the fuse filesystem.  This=
 can
> > > > only be done if the server is prepared to handle this, so add
> > > > FUSE_DEV_IOC_SYNC_INIT ioctl, which
> > > >
> > > >  a) lets the server know whether this feature is supported, returni=
ng
> > > >  ENOTTY othewrwise.
> > > >
> > > >  b) lets the kernel know to perform a synchronous initialization
> > > >
> > > > The implementation is slightly tricky, since fuse_dev/fuse_conn are=
 set up
> > > > only during super block creation.  This is solved by setting the pr=
ivate
> > > > data of the fuse device file to a special value ((struct fuse_dev *=
) 1) and
> > > > waiting for this to be turned into a proper fuse_dev before commeci=
ng with
> > > > operations on the device file.
> > > >
> > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > ---
> > > > I tested this with my raw-interface tester, so no libfuse update ye=
t.  Will
> > > > work on that next.
> > > >
> > > >  fs/fuse/cuse.c            |  3 +-
> > > >  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++------=
----
> > > >  fs/fuse/dev_uring.c       |  4 +--
> > > >  fs/fuse/fuse_dev_i.h      | 13 +++++--
> > > >  fs/fuse/fuse_i.h          |  3 ++
> > > >  fs/fuse/inode.c           | 46 +++++++++++++++++++-----
> > > >  include/uapi/linux/fuse.h |  1 +
> > > >  7 files changed, 112 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 9d26a5bc394d..d5f9f2abc569 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -1918,8 +1934,22 @@ static int fuse_fill_super(struct super_bloc=
k *sb, struct fs_context *fsc)
> > > >                 return err;
> > > >         /* file->private_data shall be visible on all CPUs after th=
is */
> > > >         smp_mb();
> > > > -       fuse_send_init(get_fuse_mount_super(sb));
> > > > -       return 0;
> > > > +
> > > > +       fm =3D get_fuse_mount_super(sb);
> > > > +
> > > > +       if (fm->fc->sync_init) {
> > > > +               struct fuse_init_args *ia =3D fuse_new_init(fm);
> > > > +
> > > > +               err =3D fuse_simple_request(fm, &ia->args);
> > > > +               if (err > 0)
> > > > +                       err =3D 0;
> > > > +               process_init_reply(fm, &ia->args, err);
> > >
> > > Do we need a fuse_dev_free() here if err < 0? If err < 0 then the
>
> Er... are you asking if we should drop the newly created fud via
> fuse_dev_release if err !=3D 0?  (AFAICT there is no fuse_dev_free?)
>

That's weird, I see fuse_dev_free() in fs/fuse/inode.c (eg
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
fuse/inode.c#n1624)

> > > mount fails, but fuse_fill_super_common() -> fuse_dev_alloc_install()
> > > will have already been called which if i'm understanding it correctly
> > > means otherwise the fc will get leaked in this case. Or I guess
> > > another option is to retain original behavior with having the mount
> > > succeed even if the init server reply returns back an error code?
>
> <shrug> I was figuring that it was fine to leave the fud attached to the
> device fd until the caller close()s it, but OTOH maybe the fuse server
> would like to try to mount again?  Do fuse servers do that?

Won't this still leak the reference? From what I see, the mount will
create the fc (refcount 1) then when the mount does the dev
installation (fuse_dev_install()) that'll acquire another reference on
fc. With the caller close()ing it, that releases 1 refcount but
there's still 1 refcount that needs to be released by
fuse_mount_destroy(). As I understand it, if the mount fails, the
.kill_sb -> fuse_mount_destroy() never gets triggered (since it was
never mounted) which will leave 1 refcount remaining.

>
> --D
>

