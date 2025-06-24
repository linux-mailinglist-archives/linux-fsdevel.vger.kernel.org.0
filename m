Return-Path: <linux-fsdevel+bounces-52799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A314AE6F7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49C116AC1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F922ECD33;
	Tue, 24 Jun 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St7VLBoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0A2E764E;
	Tue, 24 Jun 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793032; cv=none; b=riNtH7ZsChrVU6c0CtxWMQgbbe00EaxV0RL7i1DUQFbzVOg0i3jN3CCr9if+gpAkMkfo0gUMux+LVtNeLtBhWGbgm/4sb6YayOEURHnDEkOMSfr5/rUIYpcA7Fs+g2bo9riHBmkS8rUmEs0t+04E04K6am05MpqF9oz49sC7RJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793032; c=relaxed/simple;
	bh=VYDlKgHstydtk1jLgYkgzj6mfimmcmQa/nkPLi7h9Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9Da2b98AS1NWm96TjiAGNLFGFARB6yVKcWOlSNIcxO4ADVgblQZiYzhxOt/3vRF1D9XNojvLF3RMqy9ojvL5uKyDQpe5L7DQ0TWUEJIrmdnZ87OWCw9EC+5l0k18ELjo8SFo3RHCW6mt24JgFnXglMKqwUmEgpfvTGxlj6K1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St7VLBoH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so10029697a12.1;
        Tue, 24 Jun 2025 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750793028; x=1751397828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqFXQP7VVSbT0LVbNzCTmcmfY1yeHEXcsJdpZ2WfzqM=;
        b=St7VLBoH2Um2o5h0mGptN+NvD1mjvlytkKYEmNEyIilSThO9ySOerrNIFt+pyCFL4h
         YJC0Y0d6iqvUoqgNVtX8wladMWpv+flMZ9lvjGmDfpCOEEGPRbNn9HZpYHqTRkGtGVKo
         /k1FrTRd8wHykaQ1QFRLza/PIuKEsJTuXcLeO7+DNI/DS3d/RLnR4Zi2yBYxzE8JsD9o
         T+e/wYkOwxRMfYZGHVTsn3f6lOAf0f+PLEx90uN6aEy+JhEfNTUpVkX4iYy+mrbFcFzI
         HOHbLVsLhMFICGiGRWuWV8pyOTy9EhhEsfFajnbTxnTCgm+wqWJHgLPVnemzMCMhd4qR
         Epzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793028; x=1751397828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqFXQP7VVSbT0LVbNzCTmcmfY1yeHEXcsJdpZ2WfzqM=;
        b=ONLLbUbmvQSGAY6944hVma+b/S/+lQf2tStUa4SBHMS7ZKDlPVjuKgHnZbY2L+Kqq0
         PUpZ9XYvHbWQnB0ZVE4DhOlzRsGvWHFj1+xZpiqFk6k22gx1Uf0BhY7PuHM0z1WJpV8l
         Ld6Uvyw/CqIaa+wYwFvK2LOs5f7ngjsa9tTk6vnK0mOsxcOEyuCr5W7GtyciDXtPYBty
         JF3bppZl4rmWl7zDKTcVoWGhrFvmpXB54GpP6o+jpvkBvT5q4fD2NPsdv+0CMRpX7Mpz
         L6+EqukqyGUf7lwPBmcmi1G7930LmgBHN7UJAQMgh+rjAPhrjo+0GL/NXkETvBCePyB3
         9gOg==
X-Forwarded-Encrypted: i=1; AJvYcCVmjMsBH+UZRbxcpMMjlXd5Q/OlZjEBKZ8P4nfBXXrvg8wW+ba3lCDlA2bPr79UpJDEcSEfzZORfZKtvpGi@vger.kernel.org, AJvYcCWjFCBjKF7SeX0fw0W90HFLo9xDGpA8J9PvBUcdKtcmm45oAOtc8J+wqWONHd8A60hGbUfrRoKWazN2@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqDhvFl7+4BYJb8a0PU4v4d53kAG4ej1LOr9JxIywJLOHJSuv
	HMtNAOPDEYELaSH38pcgYn7bqeldK8KpPnXQyGxCtCGJc6MBA9TRltuIkP1Zhxl1X5b6NgvdiLH
	W4JW8SwgM2LMyDXg46jLqcpiECcwBxifbjPuEpws=
X-Gm-Gg: ASbGnct1wJuMUWPAud5JdlyBkS9fLW2O9xeE7jwHLOKCiiaS8MXEmSRcTQrMYIjdGVk
	YaPCbKn3e2gH2q95N8H9C5ouRWaTZccW1c/nwtN4tBL++Sf6F8T0apSS+fwvnhTnP61EkSAD0Md
	pdlaESbhTHFABEQK+UJYgDBvZMvE67vRroyoS12GaNOdI=
X-Google-Smtp-Source: AGHT+IGJvEN6mYEZK8hC6zvzefdyLtrMi6EyHJ5bq+dcks+IYhKn0BAQjnn8A5X7lXRSj4tUA2HU6Rn6Jb0DNfCH2v0=
X-Received: by 2002:a17:907:1c24:b0:ae0:a7f2:7be9 with SMTP id
 a640c23a62f3a-ae0be9fb7f3mr50303066b.41.1750793027647; Tue, 24 Jun 2025
 12:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
 <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
 <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>
 <20250624-reinreden-museen-5b07804eaffe@brauner> <CAOQ4uxg_0+Z9vV1ArX2MbpDu=aGDXQSzQmMXR3mPPu5mFB8rTQ@mail.gmail.com>
 <20250624-dankt-ruhekissen-896ff2e32821@brauner>
In-Reply-To: <20250624-dankt-ruhekissen-896ff2e32821@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 21:23:36 +0200
X-Gm-Features: AX0GCFv0qRkMajIIM09mCis1LbvS8YsZreGj9IDE5alLpQ8oAOOiEaQfl0RkId0
Message-ID: <CAOQ4uxjeAw3npz0pV4OgoZbY4weAOtK41HnYr2AWk8TRsGfohw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 5:23=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jun 24, 2025 at 05:07:59PM +0200, Amir Goldstein wrote:
> > On Tue, Jun 24, 2025 at 4:51=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 04:28:50PM +0200, Amir Goldstein wrote:
> > > > On Tue, Jun 24, 2025 at 12:53=E2=80=AFPM Amir Goldstein <amir73il@g=
mail.com> wrote:
> > > > >
> > > > > On Tue, Jun 24, 2025 at 11:30=E2=80=AFAM Jan Kara <jack@suse.cz> =
wrote:
> > > > > >
> > > > > > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > > > > > Various filesystems such as pidfs (and likely drm in the futu=
re) have a
> > > > > > > use-case to support opening files purely based on the handle =
without
> > > > > > > having to require a file descriptor to another object. That's=
 especially
> > > > > > > the case for filesystems that don't do any lookup whatsoever =
and there's
> > > > > > > zero relationship between the objects. Such filesystems are a=
lso
> > > > > > > singletons that stay around for the lifetime of the system me=
aning that
> > > > > > > they can be uniquely identified and accessed purely based on =
the file
> > > > > > > handle type. Enable that so that userspace doesn't have to al=
locate an
> > > > > > > object needlessly especially if they can't do that for whatev=
er reason.
> > > > > > >
> > > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > > ---
> > > > > > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > > > > > >  fs/pidfs.c   |  5 ++++-
> > > > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > > > > index ab4891925b52..54081e19f594 100644
> > > > > > > --- a/fs/fhandle.c
> > > > > > > +++ b/fs/fhandle.c
> > > > > > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, d=
fd, const char __user *, name,
> > > > > > >       return err;
> > > > > > >  }
> > > > > > >
> > > > > > > -static int get_path_anchor(int fd, struct path *root)
> > > > > > > +static int get_path_anchor(int fd, struct path *root, int ha=
ndle_type)
> > > > > > >  {
> > > > > > >       if (fd >=3D 0) {
> > > > > > >               CLASS(fd, f)(fd);
> > > > > > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struc=
t path *root)
> > > > > > >               return 0;
> > > > > > >       }
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * Only autonomous handles can be decoded without a fil=
e
> > > > > > > +      * descriptor.
> > > > > > > +      */
> > > > > > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > > > +             return -EOPNOTSUPP;
> > > > > >
> > > > > > This somewhat ties to my comment to patch 5 that if someone pas=
sed invalid
> > > > > > fd < 0 before, we'd be returning -EBADF and now we'd be returni=
ng -EINVAL
> > > > > > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't c=
are that
> > > > > > much about it so feel free to ignore me but I think the followi=
ng might be
> > > > > > more sensible error codes:
> > > > > >
> > > > > >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> > > > > >                 if (fd =3D=3D FD_INVALID)
> > > > > >                         return -EOPNOTSUPP;
> > > > > >                 return -EBADF;
> > > > > >         }
> > > > > >
> > > > > >         if (fd !=3D FD_INVALID)
> > > > > >                 return -EBADF; (or -EINVAL no strong preference=
 here)
> > > > >
> > > > > FWIW, I like -EBADF better.
> > > > > it makes the error more descriptive and keeps the flow simple:
> > > > >
> > > > > +       /*
> > > > > +        * Only autonomous handles can be decoded without a file
> > > > > +        * descriptor and only when FD_INVALID is provided.
> > > > > +        */
> > > > > +       if (fd !=3D FD_INVALID)
> > > > > +               return -EBADF;
> > > > > +
> > > > > +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > +               return -EOPNOTSUPP;
> > > > >
> > > >
> > > > Thinking about it some more, as I am trying to address your concern=
s
> > > > about crafting autonomous file handles by systemd, as you already
> > > > decided to define a range for kernel reserved values for fd, why no=
t,
> > > > instead of requiring FD_INVALID for autonomous file handle, that we
> > > > actually define a kernel fd value that translates to "the root of p=
idfs":
> > > >
> > > > +       /*
> > > > +        * Autonomous handles can be decoded with a special file
> > > > +        * descriptor value that describes the filesystem.
> > > > +        */
> > > > +       switch (fd) {
> > > > +       case FD_PIDFS_ROOT:
> > > > +               pidfs_get_root(root);
> > > > +               break;
> > > > +       default:
> > > > +               return -EBADF;
> > > > +       }
> > > > +
> > > >
> > > > Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
> > > > and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
> > > > to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
> > > > as before (you can also keep the existing systemd code) and when yo=
u want
> > > > to open file by handle you just go
> > > > open_by_handle_at(FD_PIDFS, &handle, 0)
> > > > and that's it.
> > > >
> > > > In the end, my one and only concern with autonomous file handles is=
 that
> > > > there should be a user opt-in to request them.
> > > >
> > > > Sorry for taking the long road to get to this simpler design.
> > > > WDYT?
> > >
> > > And simply place FD_PIDFS_ROOT into the -10000 range?
> > > Sounds good to me.
> >
> > Yes.
> >
> > I mean I don't expect there will be a flood of those singleton
> > filesystems, but generally speaking, a unique fd constant
> > to describe the root of a singleton filesystem makes sense IMO.
>
> Agreed. See the appended updated patches. I'm not resending completely.
> I just dropped other patches.

For those can also add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

But I see that FD_INVALID is still there.
Are you planning to keep the FD_INVALID patch without any
users for FD_INVALID?

Thanks,
Amir.

