Return-Path: <linux-fsdevel+bounces-17234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3E88A962F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB9A1F22C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CBF15B11D;
	Thu, 18 Apr 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ek42yXrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739615AAD9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432487; cv=none; b=kiEYtGB7CKyNs8oqUPpsRNc13WLXbeNfR93m173tgjLZgroVhEPM7UPqSWQNO6gT/oRvGWaWXR9q/QlnjkTUuSKZhrLJazT1hWtEFEehKQsp479WbQCQz0ePnNX1V12WpbHZLn/L8D+y5USBM1KnuUKDdIfJ2dSa84GJteQyz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432487; c=relaxed/simple;
	bh=mmpRuVnLzaZkiChhcQIUHiwxIhPxTu0XXrUH7x+fUUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nKj0BLa+FP1PbFg9Q30oVDE6TeTJYgk2+WkMv+5vjWERFKEuSvnX6oP+Gm1C3KhRe0X5UQyNn0jcPj8NQF9OSkALUfMAQh+MIS3L5DS+ShUaQjp4qhplYFowkc7EfU31LVVqN/mdRDvPvLwIYdI1A2vV0Qe6oaosnQbehTKH7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ek42yXrc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1370057276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713432483; x=1714037283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyg642GYvTPod/yGbxT3ikZpcn2e2tqv8aBf+gFjhXI=;
        b=Ek42yXrcSJe5AXOXgolTkZirIFDvwgF9URcKWGxIgZx8qno0tavUFd1R0OQoGD9y8t
         AsSLAhJjU7GlTpdG6rJ6AJ4cMlxld1TAMLOJIBdC3FhYquYad4BL0vGZHDnNiyeosHG/
         Mkdvs66iYhRUNPoEOZEqtA1gnl0SvzbhKqPWG741F6BFPIszUaYEzqq7jTShWD171BOv
         OxMoqJS6cj+7okNW+iPvNz6HtietwJbJvVT+44g2QB67iKSYXl1vdZkv1I4QB90vccNA
         /RpHlKw6JrLQhcYGNHXURGVLcjhak2I9UaRgwYhtYEcWUXINqSHsQwat+GTykcrhu7Zb
         b1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432483; x=1714037283;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fyg642GYvTPod/yGbxT3ikZpcn2e2tqv8aBf+gFjhXI=;
        b=vZWk9Mp4pMseqm6yJ0cgqtxafaQq8edSPAkT5DHePIzmj6Yj/6S6jn1WxdKpCX4Bib
         cPKwRLPeNL1Lekv5yV2pvrC1ZgXBcse9Igvyqw8+TfgoValeC81YsnERF2MlIvBnY8rL
         R4Dl1gToM3qAfTIwu0Pa5mJXUD+1IM3ivvyVNVx8rlqLlVANy6B9dLFozm4GycNdkBFA
         NhBzBrTDZQ/CvFGhQg80/7xLVRp+jKRfpAs/Am5Qevw9I7TnrAS2i299F80fPnlhHgeG
         kixk3nqJavZGIDu5gBmU1K+aMUqRUVhKjCCBJnoKdhieYnsyuQ1tYkpFzqjqdZ/RtQjw
         071g==
X-Forwarded-Encrypted: i=1; AJvYcCXPAg+lKrpYKabwiclxeeDTcczt+1gTRAPzVpCwBOsFg+390RcWxxRs5MtMedanmDF1D58nM7q+jiYXnQSw6rsohy7KANF2x44VYvIoVw==
X-Gm-Message-State: AOJu0YxG6qQQaF05/Ou7KcytTl/wZ8SFujbCfBzTlb0OF4PHDS/9J/Gv
	eEhkqafixOZwJKDfXULhBDikuZdBHpGdMEjU3r6W2tP4oWRAG/EMNoiUSF+M37k0U4SITLGJ8fB
	jfA==
X-Google-Smtp-Source: AGHT+IEFTH/fRyFJhexa8umGOF+edTTRQxDuqX/RilnnArTQrU8wHSJcqtT0gJfhgIEmdQl61azfcpOSs9Y=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:20c6:b0:dce:5218:c89b with SMTP id
 dj6-20020a05690220c600b00dce5218c89bmr221420ybb.5.1713432483212; Thu, 18 Apr
 2024 02:28:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:28:00 +0200
In-Reply-To: <20240412.autaiv1NiRiX@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-3-gnoack@google.com>
 <20240412.autaiv1NiRiX@digikod.net>
Message-ID: <ZiDnoBc4cLEMOrpl@google.com>
Subject: Re: [PATCH v14 02/12] landlock: Add IOCTL access right for character
 and block devices
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 05:16:59PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> I like this patch very much! This patch series is in linux-next and I
> don't expect it to change much. Just a few comments below and for test
> patches.

Thanks!

> The only remaining question is: should we allow non-device files to
> receive the LANDLOCK_ACCESS_FS_IOCTL_DEV right?

I think that yes, non-device files should be able to receive the
LANDLOCK_ACCESS_FS_IOCTL_DEV right.  I played through some examples to
ponder this:

It should be possible to grant this access right on a file hierarchy,
for example on /dev/bus/usb to permit IOCTLs on all USB devices.

But such directories can also be empty (e.g. no USB devices plugged
in)!  Asking user space Landlock users to traverse /dev/bus/usb to
look for device files before using Landlock would needlessly
complicate the API, and it would be a race condition anyway, because
devices files can disappear at any time later as well (by unplugging
your mouse and keyboard).

So when applies to a directory, the LANDLOCK_ACCESS_FS_IOCTL_DEV right
already inherently needs to deal with cases where there is not a
single device file within the directory.  (But there can technically
be other files.)

So if the access right can be granted on any directory (with or
without device files), it seems inconsistent that the requirements for
using it on a file within that hierarchy should be stricter than that.

Another data point:

This would also be consistent with the LANDLOCK_ACCESS_FS_EXECUTE
right: This access right only has an effect on files that are marked
executable in the first place, yet the access right can be granted on
non-executable files as well.

To sum up:

* It seems harmless to permit, and the name of the access rights
  already spells out that it has no effect on non-device files.

* It frees the user space libraries from doing up-front file type
  checks.

* It would be consistent with how the access right can be granted on a
  directory (where it really needs to be more flexible, as discussed
  above).

* The LANDLOCK_ACCESS_FS_EXECUTE right has not been a point of
  confusion so far, even though is has similar semantics.

So yes, I think it should be possible to use this access right on
non-device files as well.


> On Fri, Apr 05, 2024 at 09:40:30PM +0000, G=C3=BCnther Noack wrote:
> > Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
> > and increments the Landlock ABI version to 5.
> >=20
> > This access right applies to device-custom IOCTL commands
> > when they are invoked on block or character device files.
> >=20
> > Like the truncate right, this right is associated with a file
> > descriptor at the time of open(2), and gets respected even when the
> > file descriptor is used outside of the thread which it was originally
> > opened in.
> >=20
> > Therefore, a newly enabled Landlock policy does not apply to file
> > descriptors which are already open.
> >=20
> > If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
> > number of safe IOCTL commands will be permitted on newly opened device
> > files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
> > as other IOCTL commands for regular files which are implemented in
> > fs/ioctl.c.
> >=20
> > Noteworthy scenarios which require special attention:
> >=20
> > TTY devices are often passed into a process from the parent process,
> > and so a newly enabled Landlock policy does not retroactively apply to
> > them automatically.  In the past, TTY devices have often supported
> > IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> > letting callers control the TTY input buffer (and simulate
> > keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> > modern kernels though.
> >=20
> > Known limitations:
> >=20
> > The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
> > control over IOCTL commands.
> >=20
> > Landlock users may use path-based restrictions in combination with
> > their knowledge about the file system layout to control what IOCTLs
> > can be done.
> >=20
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  include/uapi/linux/landlock.h                |  38 +++-
> >  security/landlock/fs.c                       | 221 ++++++++++++++++++-
>=20
> You contributed a lot and you may want to add a copyright in this file.

Thanks, good point.

I'll add the Google copyright and will also retroactively add the
copyright for the truncate contributions going back to 2022.


> > +static __attribute_const__ bool is_masked_device_ioctl(const unsigned =
int cmd)
> > +{
> > +   [...]
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +	case FIDEDUPERANGE:
>=20
> > +	/*
> > +	 * FIONREAD, FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
> > +	 * FS_IOC_FSSETXATTR are forwarded to device implementations.
> > +	 */
>=20
> The above comment should be better near the file_ioctl() one.

Done.


> > +static __attribute_const__ bool
> > +is_masked_device_ioctl_compat(const unsigned int cmd)
> > +{
> > +	switch (cmd) {
> > +	/* FICLONE is permitted, same as in the non-compat variant. */
> > +	case FICLONE:
> > +		return true;
>=20
> A new line before and after if/endif would be good.

Done.

>=20
> > +#if defined(CONFIG_X86_64)
> > +	/*

