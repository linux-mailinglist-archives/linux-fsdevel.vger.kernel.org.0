Return-Path: <linux-fsdevel+bounces-13325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718886E892
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19801B2A879
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39C37153;
	Fri,  1 Mar 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ArHMa97E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B939ACE
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318133; cv=none; b=MZw2wNW4UU8ExzBk5v2toOONNqLnhjBgJ4bW3bW2qg4tcNrYuFxzKq/q+PJdqA6YJDVXv0ObnFsATlB5UOurDEJeC66YKMvA9SKGJcvlVG/brnv6sc5Kw/7LjKp2saSbOhtlfpSEqK+V3cwpXmUrAmIP0uPWa8RaJAJVRq6fVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318133; c=relaxed/simple;
	bh=wKERaFJOJQ9cxuvSdSbANjYWDVAz56PvYj3xS16BRsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaghhmfJTB853q59SWyaYoG7TzAZYvXOF9GA5mgoNtJXXQog68OFqllk0DwZ5VuhVJ+l0s0StkT78t01fG8V4W51oojWgjbJmtmaWYLHVNPAmKsCHd/fg8cGJAQATbLFhfDuEdki7x8pomEUZpRWnAcjWXlWBaonDiYBalxl+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ArHMa97E; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TmcGK0D1kz3x7;
	Fri,  1 Mar 2024 19:35:21 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TmcGH3bSzzMpnPt;
	Fri,  1 Mar 2024 19:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709318120;
	bh=wKERaFJOJQ9cxuvSdSbANjYWDVAz56PvYj3xS16BRsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArHMa97E3bmeC8RRJHQQqEABcAgbsFck3zopceBxwTCS/tRuYTMKxLHgbtiLTKN70
	 U64UhvcOAy2iZZlEqxwEXl6WnWJ1aDs8S8fudc9sXKVOwd0Zqkk1N+N4mEJqcPCi4p
	 elBLzTWStAkXiSKRqMgD5L3fSEZMt/Co8jF5RnB4=
Date: Fri, 1 Mar 2024 19:35:09 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240301.hoohie5EPheH@digikod.net>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net>
 <0d532558-0c47-4d1c-8b33-b1ff8f4846a5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d532558-0c47-4d1c-8b33-b1ff8f4846a5@app.fastmail.com>
X-Infomaniak-Routing: alpha

On Fri, Mar 01, 2024 at 05:24:52PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 19, 2024, at 19:35, Mickaël Salaün wrote:
> > vfs_masks_device_ioctl() and vfs_masks_device_ioctl_compat() are useful
> > to differenciate between device driver IOCTL implementations and
> > filesystem ones.  The goal is to be able to filter well-defined IOCTLs
> > from per-device (i.e. namespaced) IOCTLs and control such access.
> >
> > Add a new ioctl_compat() helper, similar to vfs_ioctl(), to wrap
> > compat_ioctl() calls and handle error conversions.
> 
> I'm still a bit confused by what your goal is here. I see
> the code getting more complex but don't see the payoff in this
> patch.

The main idea is to be able to identify if an IOCTL is handled by a
device driver (i.e. block or character devices) or not.  This would be
used at least by Landlock to control such IOCTL (according to the
char/block device file, which can already be identified) while allowing
other VFS/FS IOCTLs.

> 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> 
> I assume the missing Signed-off-by is intentional while you are
> still gathering feedback?

No, I sent it too quickly and forgot to add it.

Signed-off-by: Mickaël Salaün <mic@digikod.net>

> 
> > +/*
> > + * Safeguard to maintain a list of valid IOCTLs handled by 
> > do_vfs_ioctl()
> > + * instead of def_blk_fops or def_chr_fops (see init_special_inode).
> > + */
> > +__attribute_const__ bool vfs_masked_device_ioctl(const unsigned int 
> > cmd)
> > +{
> > +	switch (cmd) {
> > +	case FIOCLEX:
> > +	case FIONCLEX:
> > +	case FIONBIO:
> > +	case FIOASYNC:
> > +	case FIOQSIZE:
> > +	case FIFREEZE:
> > +	case FITHAW:
> > +	case FS_IOC_FIEMAP:
> > +	case FIGETBSZ:
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +	case FIDEDUPERANGE:
> > +	/* FIONREAD is forwarded to device implementations. */
> > +	case FS_IOC_GETFLAGS:
> > +	case FS_IOC_SETFLAGS:
> > +	case FS_IOC_FSGETXATTR:
> > +	case FS_IOC_FSSETXATTR:
> > +	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +EXPORT_SYMBOL(vfs_masked_device_ioctl);
> 
> It looks like this gets added into the hot path of every
> ioctl command, which is not ideal, especially when this
> no longer gets inlined into the caller.

I'm looking for a way to guarantee that the list of IOCTLs in this
helper will be kept up-to-date. This kind of run time check might be
too much though. Do you have other suggestions? Do you think a simple
comment to remind contributors to update this helper would be enough?
I guess VFS IOCTLs should not be added often, but I'm worried that this
list could get out of sync...

> 
> > +	inode = file_inode(f.file);
> > +	is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> > +	if (is_device && !vfs_masked_device_ioctl(cmd)) {
> > +		error = vfs_ioctl(f.file, cmd, arg);
> > +		goto out;
> > +	}
> 
> The S_ISBLK() || S_ISCHR() check here looks like it changes
> behavior, at least for sockets. If that is intentional,
> it should probably be a separate patch with a detailed
> explanation.

I don't think this changes the behavior for sockets, and at least that's
not intentionnal.  This patch should not change the current behavior at
all.

The path to reach socket IOCTLs goes through a vfs_ioctl() call, which
is...

> 
> >  	error = do_vfs_ioctl(f.file, fd, cmd, arg);
> > -	if (error == -ENOIOCTLCMD)
> > +	if (error == -ENOIOCTLCMD) {
> > +		WARN_ON_ONCE(is_device);
> >  		error = vfs_ioctl(f.file, cmd, arg);

...here!

> > +	}
> 
> The WARN_ON_ONCE() looks like it can be triggered from
> userspace, which is generally a bad idea.

This WARN_ON_ONCE() should never be triggered because if the it is a
device IOCTL it goes through the previous vfs_ioctl() (for
device-specific command) call or through this do_vfs_ioctl() call (for
VFS-specific command).

>  
> > +extern __attribute_const__ bool vfs_masked_device_ioctl(const unsigned 
> > int cmd);
> > +#ifdef CONFIG_COMPAT
> > +extern __attribute_const__ bool
> > +vfs_masked_device_ioctl_compat(const unsigned int cmd);
> > +#else /* CONFIG_COMPAT */
> > +static inline __attribute_const__ bool
> > +vfs_masked_device_ioctl_compat(const unsigned int cmd)
> > +{
> > +	return vfs_masked_device_ioctl(cmd);
> > +}
> > +#endif /* CONFIG_COMPAT */
> 
> I don't understand the purpose of the #else path here,
> this should not be needed.

Correct, this else branch is useless.

> 
>       Arnd
> 

