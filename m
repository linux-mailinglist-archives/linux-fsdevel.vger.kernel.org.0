Return-Path: <linux-fsdevel+bounces-52787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F85AE6A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CF65A5C49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E812D8768;
	Tue, 24 Jun 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBda6Buk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951D2E62D4;
	Tue, 24 Jun 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777694; cv=none; b=AwxrQes2EVyEw03gURaQT+3qpwBZX6oXcJZNzGVZ+bOGd0C5RAxMTwiL9o5rP8+MxzHEIJ0ALzPjLuAIADtzkMCT8PQt+iyIH2kf9qfVuNjxFnyqTHzvqkzxys5GGkKLckvP79ZZ3rHpyvrBlBQWFwZTLqkS1+gzAYP5Pm0Dzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777694; c=relaxed/simple;
	bh=OPHA1z/KC+kY1wqRsFZpHAfDaJjbIQOWIkUz7MQja94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7Llh+M0YAYHksuxX0BC44B39pNh4iQRS9LYb7Rc/CDuMGt8HdUYlbR6uJ9qGoo4gEcOOFoGkG6/GElUPWoZ1A7WtfK8HCwKSe6z9QBSEPSTcppnvlBlNh7q7CrRPy9fgSo1soWJJY3MhUrTdypC4x7FEzwzmf5EQsuDd5a/ELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBda6Buk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad88d77314bso116398466b.1;
        Tue, 24 Jun 2025 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750777691; x=1751382491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFrc2w4D6eFdaMmtdU4beC0WwePufk+c7djYjFgyAdw=;
        b=KBda6BukzlMlMJw2I2JSax8H/kHkSSxnbbzDDH4Fou/SZQIqRXhoQMiFs2a0mWC2Ke
         HxXFHgk6y5liFzF4ADXqiB+1dNI3U26p4G53jM49ams5EgLggYcfLGgslHbqrOrTiDG+
         gVGskUiWuNFfNGgmzgPZBNPUuIO1Ab8TtUusfNa98Hfo9Uj4p3AoFUHbRPx3ZgdEz83a
         w28B+N0HC7x2x9nPgkp0D8gLlCG/wNFNXTVq8tBIb/MvMFPgH5tdrIcudMhvSUGHSorl
         W0bf0WLTBCW5/aux/5fH4JF46NphUBP6yG/1oa+pOIKzPicUN5bXpPr7BsfC11ioxyuD
         r4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777691; x=1751382491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFrc2w4D6eFdaMmtdU4beC0WwePufk+c7djYjFgyAdw=;
        b=dE7AljSYBPnWtjBtP28WUX7K8ygx55TVETwffusgoZtOU6D1vsSMdT2cj6UtvDx6Ad
         A+dZvIfAJqDj+xgBjmLoxUdkDfcu5iVuZ/gak5y95cZ0yPqi80V/4bHkayKseBIirsWr
         +mOZhUqBs9ZflSM23Ym75Cp+YaRFD0qOO1xyRurmcieKch+n5fzoFcrKGOcJnMkHKmAq
         k/FyJ/whqlYiTZVxtMRMNZUIFVBg0h8VFXy1SQviK5mJXUH/551Lwjwsopl0+I9O3x4L
         Xe23o/AY9fCp8osrh0OcR8ypAdRic2DPvy8GnAXjTmx+LSygkluSDzoTJSjt2ST+Zh51
         sQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEkaHEIiqAkcx9Z+8Y/FhwR0MxAltXzGCF4RK1D893YIsNQlYDSaXRVfoZtG8hr7lcDXbktyZ5A6ay@vger.kernel.org, AJvYcCXy2ykgtn0B6ulPQJ69PT7xc4lWbUws49h0Ew6QcmmyA4xVmaifQRnc95qFBM8mzstWLoghHUDQsb/TCG9p@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWmuRdLk3qhP7Sb+uTHSjjH0cSIP/RC0BCYJAr67hJdQMkgaf
	rKabmaXZuJQLCCr1SonqsZebOI5nC+U0ZOo1sAKzOqJHnzp8ekFE1fXr9rc39JkByufDeupCoZS
	DX57d/X+8/xCF6Vs4G7JZi46CA41eTi0=
X-Gm-Gg: ASbGncuJtt20ryYdDmTAW2MFa7ivI6H+dMLZhQJ27dC+AegoiaCZuzPrXj7aor06oom
	vL4YJiMpFEmJ/tHvV0wUSh4jlZmRKeDQfWA6o7aQj4IqvdP3Gi30FoI/7BDaFhMOIfd4xYHwIkk
	K/fHqrWfRuYlHauJdAuNcEjObPmgfVNqngXjdpi3X4eGs=
X-Google-Smtp-Source: AGHT+IH9qwfbG+qiq235qxnBIliecWxtr4XdhBInph1SGxFEVT06vBJnmnk97TinLSWkQeyBqH8bQt8U6sBB2sYn7KA=
X-Received: by 2002:a17:907:1b11:b0:ace:d710:a8d1 with SMTP id
 a640c23a62f3a-ae0579f936emr1641524366b.24.1750777690375; Tue, 24 Jun 2025
 08:08:10 -0700 (PDT)
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
 <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com> <20250624-reinreden-museen-5b07804eaffe@brauner>
In-Reply-To: <20250624-reinreden-museen-5b07804eaffe@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 17:07:59 +0200
X-Gm-Features: AX0GCFuXXBXhAVc1ZSBfRxl_T5ucmCFBPj3qnJSAs1AuEA2Ozw1WhQtNXUnw5is
Message-ID: <CAOQ4uxg_0+Z9vV1ArX2MbpDu=aGDXQSzQmMXR3mPPu5mFB8rTQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 4:51=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jun 24, 2025 at 04:28:50PM +0200, Amir Goldstein wrote:
> > On Tue, Jun 24, 2025 at 12:53=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 11:30=E2=80=AFAM Jan Kara <jack@suse.cz> wrot=
e:
> > > >
> > > > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > > > Various filesystems such as pidfs (and likely drm in the future) =
have a
> > > > > use-case to support opening files purely based on the handle with=
out
> > > > > having to require a file descriptor to another object. That's esp=
ecially
> > > > > the case for filesystems that don't do any lookup whatsoever and =
there's
> > > > > zero relationship between the objects. Such filesystems are also
> > > > > singletons that stay around for the lifetime of the system meanin=
g that
> > > > > they can be uniquely identified and accessed purely based on the =
file
> > > > > handle type. Enable that so that userspace doesn't have to alloca=
te an
> > > > > object needlessly especially if they can't do that for whatever r=
eason.
> > > > >
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > > > >  fs/pidfs.c   |  5 ++++-
> > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > > index ab4891925b52..54081e19f594 100644
> > > > > --- a/fs/fhandle.c
> > > > > +++ b/fs/fhandle.c
> > > > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, =
const char __user *, name,
> > > > >       return err;
> > > > >  }
> > > > >
> > > > > -static int get_path_anchor(int fd, struct path *root)
> > > > > +static int get_path_anchor(int fd, struct path *root, int handle=
_type)
> > > > >  {
> > > > >       if (fd >=3D 0) {
> > > > >               CLASS(fd, f)(fd);
> > > > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct pa=
th *root)
> > > > >               return 0;
> > > > >       }
> > > > >
> > > > > +     /*
> > > > > +      * Only autonomous handles can be decoded without a file
> > > > > +      * descriptor.
> > > > > +      */
> > > > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > +             return -EOPNOTSUPP;
> > > >
> > > > This somewhat ties to my comment to patch 5 that if someone passed =
invalid
> > > > fd < 0 before, we'd be returning -EBADF and now we'd be returning -=
EINVAL
> > > > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care =
that
> > > > much about it so feel free to ignore me but I think the following m=
ight be
> > > > more sensible error codes:
> > > >
> > > >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> > > >                 if (fd =3D=3D FD_INVALID)
> > > >                         return -EOPNOTSUPP;
> > > >                 return -EBADF;
> > > >         }
> > > >
> > > >         if (fd !=3D FD_INVALID)
> > > >                 return -EBADF; (or -EINVAL no strong preference her=
e)
> > >
> > > FWIW, I like -EBADF better.
> > > it makes the error more descriptive and keeps the flow simple:
> > >
> > > +       /*
> > > +        * Only autonomous handles can be decoded without a file
> > > +        * descriptor and only when FD_INVALID is provided.
> > > +        */
> > > +       if (fd !=3D FD_INVALID)
> > > +               return -EBADF;
> > > +
> > > +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > +               return -EOPNOTSUPP;
> > >
> >
> > Thinking about it some more, as I am trying to address your concerns
> > about crafting autonomous file handles by systemd, as you already
> > decided to define a range for kernel reserved values for fd, why not,
> > instead of requiring FD_INVALID for autonomous file handle, that we
> > actually define a kernel fd value that translates to "the root of pidfs=
":
> >
> > +       /*
> > +        * Autonomous handles can be decoded with a special file
> > +        * descriptor value that describes the filesystem.
> > +        */
> > +       switch (fd) {
> > +       case FD_PIDFS_ROOT:
> > +               pidfs_get_root(root);
> > +               break;
> > +       default:
> > +               return -EBADF;
> > +       }
> > +
> >
> > Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
> > and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
> > to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
> > as before (you can also keep the existing systemd code) and when you wa=
nt
> > to open file by handle you just go
> > open_by_handle_at(FD_PIDFS, &handle, 0)
> > and that's it.
> >
> > In the end, my one and only concern with autonomous file handles is tha=
t
> > there should be a user opt-in to request them.
> >
> > Sorry for taking the long road to get to this simpler design.
> > WDYT?
>
> And simply place FD_PIDFS_ROOT into the -10000 range?
> Sounds good to me.

Yes.

I mean I don't expect there will be a flood of those singleton
filesystems, but generally speaking, a unique fd constant
to describe the root of a singleton filesystem makes sense IMO.

Thanks,
Amir.

