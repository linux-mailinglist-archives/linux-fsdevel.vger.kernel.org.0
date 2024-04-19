Return-Path: <linux-fsdevel+bounces-17276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD8D8AA804
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 07:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98C21F21B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366FBE4B;
	Fri, 19 Apr 2024 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E7S0jusa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4F8F62
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505444; cv=none; b=Tk/zFaegriWnM4lodNCO7JGiPa3i6Y6h6VapGsbNcZ9Iae8OSauCqLhZbBT2pq7w+uY9jT/Uj5TxlyojvYKA9ZsfnOkNEPPzMKMrEuR5RzwZiWS1Z7+VUoLjFOal5cDTsS+AZ1TO+MPq7PvBMHxPvFsVU4ey6l2m3veHB46lKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505444; c=relaxed/simple;
	bh=BZOAmz/ECy/d+hsqPCwwkPpmNSz+J/2Q1BgC88jaEV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBrafBBsg+D8rg4LseM9W+V94J8qqeiZcKYHMQlh/3CO1UOCwHptjLoR6prC1m4d/opz/D2jMH/C9BtNUMfQDsRlrLe3Pa09asPmUlAYdG1WgFpWNjQFXpQQHypsXKNeOdTD+8fMSKkpORFU7g1KUfefAL7oaHJObVN1GkQ7EHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E7S0jusa; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VLNqT3Tmsz26T;
	Fri, 19 Apr 2024 07:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1713505429;
	bh=BZOAmz/ECy/d+hsqPCwwkPpmNSz+J/2Q1BgC88jaEV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7S0jusa1Z9ctkaBLwLKgXHk5x0toEARmH4ptDX0i2UvCOymCPk8Bs7BvpaQTWF5a
	 O/SyrEGO8HRZyVpuPTRKkIi7apQg3qCiBv7kxHrh2kXjEKqp0ZuHpyaldrJgTvuYeh
	 JRa0SKc6M9G2EETJr2644hJZvpmu5q3XTaAovG2g=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VLNqS3sd9zn7t;
	Fri, 19 Apr 2024 07:43:48 +0200 (CEST)
Date: Thu, 18 Apr 2024 22:43:42 -0700
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v14 02/12] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <20240418.uPh8Chi1shah@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-3-gnoack@google.com>
 <20240412.autaiv1NiRiX@digikod.net>
 <ZiDnoBc4cLEMOrpl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiDnoBc4cLEMOrpl@google.com>
X-Infomaniak-Routing: alpha

On Thu, Apr 18, 2024 at 11:28:00AM +0200, Günther Noack wrote:
> On Fri, Apr 12, 2024 at 05:16:59PM +0200, Mickaël Salaün wrote:
> > I like this patch very much! This patch series is in linux-next and I
> > don't expect it to change much. Just a few comments below and for test
> > patches.
> 
> Thanks!
> 
> > The only remaining question is: should we allow non-device files to
> > receive the LANDLOCK_ACCESS_FS_IOCTL_DEV right?
> 
> I think that yes, non-device files should be able to receive the
> LANDLOCK_ACCESS_FS_IOCTL_DEV right.  I played through some examples to
> ponder this:
> 
> It should be possible to grant this access right on a file hierarchy,
> for example on /dev/bus/usb to permit IOCTLs on all USB devices.
> 
> But such directories can also be empty (e.g. no USB devices plugged
> in)!  Asking user space Landlock users to traverse /dev/bus/usb to
> look for device files before using Landlock would needlessly
> complicate the API, and it would be a race condition anyway, because
> devices files can disappear at any time later as well (by unplugging
> your mouse and keyboard).
> 
> So when applies to a directory, the LANDLOCK_ACCESS_FS_IOCTL_DEV right
> already inherently needs to deal with cases where there is not a
> single device file within the directory.  (But there can technically
> be other files.)
> 
> So if the access right can be granted on any directory (with or
> without device files), it seems inconsistent that the requirements for
> using it on a file within that hierarchy should be stricter than that.

Yes, directories should be able to receive all access rights because of
file hierarchies. I was thinking about char/block devices vs.
regular/fifo/socket/symlink files.

> 
> Another data point:
> 
> This would also be consistent with the LANDLOCK_ACCESS_FS_EXECUTE
> right: This access right only has an effect on files that are marked
> executable in the first place, yet the access right can be granted on
> non-executable files as well.

I would say that LANDLOCK_ACCESS_FS_EXECUTE can be granted on fifo, but
I get your point.

> 
> To sum up:
> 
> * It seems harmless to permit, and the name of the access rights
>   already spells out that it has no effect on non-device files.
> 
> * It frees the user space libraries from doing up-front file type
>   checks.
> 
> * It would be consistent with how the access right can be granted on a
>   directory (where it really needs to be more flexible, as discussed
>   above).
> 
> * The LANDLOCK_ACCESS_FS_EXECUTE right has not been a point of
>   confusion so far, even though is has similar semantics.
> 
> So yes, I think it should be possible to use this access right on
> non-device files as well.

OK

> 
> 
> > On Fri, Apr 05, 2024 at 09:40:30PM +0000, Günther Noack wrote:
> > > Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
> > > and increments the Landlock ABI version to 5.
> > > 
> > > This access right applies to device-custom IOCTL commands
> > > when they are invoked on block or character device files.
> > > 
> > > Like the truncate right, this right is associated with a file
> > > descriptor at the time of open(2), and gets respected even when the
> > > file descriptor is used outside of the thread which it was originally
> > > opened in.
> > > 
> > > Therefore, a newly enabled Landlock policy does not apply to file
> > > descriptors which are already open.
> > > 
> > > If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
> > > number of safe IOCTL commands will be permitted on newly opened device
> > > files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
> > > as other IOCTL commands for regular files which are implemented in
> > > fs/ioctl.c.
> > > 
> > > Noteworthy scenarios which require special attention:
> > > 
> > > TTY devices are often passed into a process from the parent process,
> > > and so a newly enabled Landlock policy does not retroactively apply to
> > > them automatically.  In the past, TTY devices have often supported
> > > IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> > > letting callers control the TTY input buffer (and simulate
> > > keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> > > modern kernels though.
> > > 
> > > Known limitations:
> > > 
> > > The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
> > > control over IOCTL commands.
> > > 
> > > Landlock users may use path-based restrictions in combination with
> > > their knowledge about the file system layout to control what IOCTLs
> > > can be done.
> > > 
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Günther Noack <gnoack@google.com>
> > > ---
> > >  include/uapi/linux/landlock.h                |  38 +++-
> > >  security/landlock/fs.c                       | 221 ++++++++++++++++++-
> > 
> > You contributed a lot and you may want to add a copyright in this file.
> 
> Thanks, good point.
> 
> I'll add the Google copyright and will also retroactively add the
> copyright for the truncate contributions going back to 2022.

Good

> 
> 
> > > +static __attribute_const__ bool is_masked_device_ioctl(const unsigned int cmd)
> > > +{
> > > +   [...]
> > > +	case FICLONE:
> > > +	case FICLONERANGE:
> > > +	case FIDEDUPERANGE:
> > 
> > > +	/*
> > > +	 * FIONREAD, FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
> > > +	 * FS_IOC_FSSETXATTR are forwarded to device implementations.
> > > +	 */
> > 
> > The above comment should be better near the file_ioctl() one.
> 
> Done.
> 
> 
> > > +static __attribute_const__ bool
> > > +is_masked_device_ioctl_compat(const unsigned int cmd)
> > > +{
> > > +	switch (cmd) {
> > > +	/* FICLONE is permitted, same as in the non-compat variant. */
> > > +	case FICLONE:
> > > +		return true;
> > 
> > A new line before and after if/endif would be good.
> 
> Done.
> 
> > 
> > > +#if defined(CONFIG_X86_64)
> > > +	/*
> 

