Return-Path: <linux-fsdevel+bounces-15598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA28906E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC5929FB88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E421130A6A;
	Thu, 28 Mar 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hn8bkZFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66C137C2D
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645631; cv=none; b=cv1dSwCN2Zc3+KXYCR+bjeh+jz9ohaxyA49eBOY3sOdMzgzT8D2HNVrHlOsFtH7MFtmXLDTXIHU2WIiPtfLFV303C9XfMnNbc3s0VbfqtYjAvwGJLI4D9Yh8YzfJqtcjeOVUQCRcnkwewphYsqN8ucYfA8FHreYGBMf/lTKbuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645631; c=relaxed/simple;
	bh=RT2a3Bdv5hWixMPHbx2jUxcYJSPoofEnOgS/q+iAklo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJUbFsAXmU+kvgh80jv3kv275cyFjmJcqetHYwSsmCsqBNnpgfx5UVvgA30ugElOUcRU20UljeFLWS2ZSALTiATkhwKfn94DKk2v9eTjqI7hEMyS1OidErVi2kDPLnTrK8s6Lu0klOdE4E/QtWwb0mG6wutMqV/jW6BfCOWQALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hn8bkZFr; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1148303276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711645628; x=1712250428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/9NUgj0N+dhsgqOBL6TaIVx6GIGwNMflW6DF43oEXw=;
        b=Hn8bkZFroaxIYyYv5TEijJDxTt4XPqqvs7pGC4GDk+Oij0QoWAT4KGZDwgj0YpV1CF
         fsmcxpW7mKgw6NAC2MT199wifGEfD2UYG4UYshziWVktoMUyJr6wvejvDMA5yfXfXpkw
         KY+MCVpoDev7nM/jBeWUGrGyHPQyq8j3kDVFCDprJCSZg2JnhddmCf5e1XtZpdsDWyH/
         dqi0Gt3bPQUD1+M/VgfkcOVT/+RUnnp7MQKnTNlkjNlZdjVCfHglLcZluXEKjtSkWPfA
         LPTw7M80+AobHQDD44rUdoFisc21kQqnvwbBw8goIX/wrdVm2lo3z6MRppuifBRYNn+0
         bnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645628; x=1712250428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/9NUgj0N+dhsgqOBL6TaIVx6GIGwNMflW6DF43oEXw=;
        b=to3falvV+nzmL2vDMtbSnmQTVMkwUwH75K0V3MvBl5sSIW/2Xk15AaZlkevBj4LtTR
         WfJaQI+l+605mSe7F5fYzBLARrtjvcwfnjZpKE6L/b0GhSSeUDxbzFx+yYySSeStAr/I
         gpgULg389FTSI4yEzyEXLHPdfXivtlO4OSu6gqAM1xpgkbHvnvUpwcMyxn05gTeUIVSU
         xU8+bp6NutaHE2DkNhqKlIXlbvqNEqVyyuurhGOTzbIlb7Qo2gRO9SrhtMzPU9CLXMAK
         RA7IW+jviRfqnqncp0IXGQrsSQziSFJc+XyFFueWVkmMLdAkxmZdvSTyV51ptr3Getfp
         CJRg==
X-Forwarded-Encrypted: i=1; AJvYcCXIc3fh+gmbRlbtxZ0RKr7F3ZxEeNxx8N+NBGP09kPgRElQ1gGI5ZMTu53KnU3yTZXzOyOmF2ra0WWvrGXaxR94PbGxmvhme/zck/+KQA==
X-Gm-Message-State: AOJu0YxLO7hJ7RzNqecC9+NmqB9YAYPiA8ljw24nsogGvt6ELGQJHFwB
	c58T/GxmaQyEebUYItCxVVFbxuXgsCxujVI3bxTgzoDSv8r30ZDkEh4nPlFPM7drifw6MX0ZXCI
	cUgO8gWADb4hsvxkiIu4s60EP5ymsDJerMVkB
X-Google-Smtp-Source: AGHT+IHo+aMKDPWz42mJx5B+i5mcV3g7qEF3Qg44xH2L+OwF7fF86jCgM01cVT0r+ZdiP6L8VMqVdjc3rKEXYeCNlfQ=
X-Received: by 2002:a25:1608:0:b0:dcd:1436:a4ce with SMTP id
 8-20020a251608000000b00dcd1436a4cemr3336294ybw.23.1711645627690; Thu, 28 Mar
 2024 10:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-11-gnoack@google.com>
 <20240328.ahgh8EiLahpa@digikod.net> <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
 <20240328.mahn4seChaej@digikod.net>
In-Reply-To: <20240328.mahn4seChaej@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 13:06:57 -0400
Message-ID: <CAHC9VhS=ESSCK6TiTXbqDmvDUwPa3UFBN7ZaJogmj=Qguc_m2w@mail.gmail.com>
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:43=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Thu, Mar 28, 2024 at 09:08:13AM -0400, Paul Moore wrote:
> > On Thu, Mar 28, 2024 at 8:11=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Wed, Mar 27, 2024 at 01:10:40PM +0000, G=C3=BCnther Noack wrote:
> > > > Landlock's IOCTL support needs to partially replicate the list of
> > > > IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> > > > do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policie=
s.
> > > >
> > > > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > > > ---
> > > >  fs/ioctl.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > > index 1d5abfdf0f22..661b46125669 100644
> > > > --- a/fs/ioctl.c
> > > > +++ b/fs/ioctl.c
> > > > @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file =
*file, void __user *argp)
> > > >   *
> > > >   * When you add any new common ioctls to the switches above and be=
low,
> > > >   * please ensure they have compatible arguments in compat mode.
> > > > + *
> > > > + * The commands which are implemented here should be kept in sync =
with the IOCTL
> > > > + * security policies in the Landlock LSM.
> > >
> > > Suggestion:
> > > "with the Landlock IOCTL security policy defined in security/landlock=
/fs.c"
> >
> > We really shouldn't have any comments or code outside of the security/
> > directory that reference a specific LSM implementation.  I'm sure
> > there are probably a few old comments referring to SELinux, but those
> > are bugs as far as I'm concerned (if anyone spots one, please let me
> > know or send me a patch!).
> >
> > How about the following?
> >
> > "The LSM list should also be notified of any command additions or
>
> "The LSM mailing list..."

 ;)

> > changes as specific LSMs may be affected."
>
> Looks good.

--=20
paul-moore.com

