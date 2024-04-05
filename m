Return-Path: <linux-fsdevel+bounces-16215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28889A3D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 20:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B9628627E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53B171E5C;
	Fri,  5 Apr 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XH5jwJte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD864171678
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340109; cv=none; b=RxtGon9IQn8DoSJUtDdz8Uj0jvf5+EQepgX34T5oCP1B++vLWQ7i2VkzHUrf2AQZJttnT+cBNxscB0hemFz1UDYzby8iNCIJ4Bl+NuS2ZVVSyRqLUw4fnnd1vZXsiU4p1dJqR9bd0HIh3guHL8CSTxHIz2gmQDbUoPHassh6yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340109; c=relaxed/simple;
	bh=JbkxHY+u4mT9jorisYd0bizAxJ7WsOnDkj0Y7qOs8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPllQuNwdQGN/PL86Gtvsk2X6VYVSMfA6c0WTbG+LZ9udvW6VjSlkTnzGFDRQUZB3ENCaCzFxuq6dH/5tsvvumONzrI0UcIYlWjkPByIIvySO8GnfPvn3O4kg57OraF7B4nef2kN5KGm1aa6eEogUqWU5/pPhWpWBb6pVm6SREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XH5jwJte; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VB5s93Nqdz37J;
	Fri,  5 Apr 2024 20:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712340093;
	bh=JbkxHY+u4mT9jorisYd0bizAxJ7WsOnDkj0Y7qOs8ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XH5jwJteuehl9qY/U8wnQRlP9jo6xWr5vSmgB8ljWuvyk+cQLtWZXHUysYW1TUg3X
	 fjFgb8pjnih6mnN+uNfb4W/7OixhTC8XTz2XfqvYF5ZqzLKU9aRr1zincycBozSNE0
	 DWqcGlJWqQPgGUXuyiJSiEM1axk7jx6phGd42EwY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VB5s81DbqzmYY;
	Fri,  5 Apr 2024 20:01:32 +0200 (CEST)
Date: Fri, 5 Apr 2024 20:01:31 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <20240405.oPhaosiel1ni@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net>
 <ZgxOYauBXowTIgx-@google.com>
 <20240403.In2aiweBeir2@digikod.net>
 <ZhAkDW2u3GItsody@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAkDW2u3GItsody@google.com>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 06:17:17PM +0200, Günther Noack wrote:
> On Wed, Apr 03, 2024 at 01:15:45PM +0200, Mickaël Salaün wrote:
> > On Tue, Apr 02, 2024 at 08:28:49PM +0200, Günther Noack wrote:
> > > On Wed, Mar 27, 2024 at 05:57:31PM +0100, Mickaël Salaün wrote:
> > > > On Wed, Mar 27, 2024 at 01:10:31PM +0000, Günther Noack wrote:
> > > > > +	case FIOQSIZE:
> > > > > +		/*
> > > > > +		 * FIOQSIZE queries the size of a regular file or directory.
> > > > > +		 *
> > > > > +		 * This IOCTL command only applies to regular files and
> > > > > +		 * directories.
> > > > > +		 */
> > > > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > > > 
> > > > This should always be allowed because do_vfs_ioctl() never returns
> > > > -ENOIOCTLCMD for this command.  That's why I wrote
> > > > vfs_masked_device_ioctl() this way [1].  I think it would be easier to
> > > > read and maintain this code with a is_masked_device_ioctl() logic.  Listing
> > > > commands that are not masked makes it difficult to review because
> > > > allowed and denied return codes are interleaved.
> > > 
> > > Oh, I misunderstood you on [2], I think -- I was under the impression that you
> > > wanted to keep the switch case in the same order (and with the same entries?) as
> > > the original in do_vfs_ioctl.  So you'd prefer to only list the always-allowed
> > > IOCTL commands here, as you have done in vfs_masked_device_ioctl() [3]?
> > > 
> > > [2] https://lore.kernel.org/all/20240326.ooCheem1biV2@digikod.net/
> > > [3] https://lore.kernel.org/all/20240219183539.2926165-1-mic@digikod.net/
> > 
> > That was indeed unclear.  About IOCTL commands, the same order ease
> > reviewing and maintenance but we don't need to list all commands,
> > which will limit updates of this list.  However, for the current
> > unused/unmasked one, we can still add them very briefly in comments as I
> > did with FIONREAD and file_ioctl()'s ones in vfs_masked_device_ioctl().
> > Only listing the "masked" ones (for device case) shorten the list, and
> > having a list with the same semantic ("mask device-specific IOCTLs")
> > ease review and maintenance as well.
> > 
> > > 
> > > Can you please clarify how you make up your mind about what should be permitted
> > > and what should not?  I have trouble understanding the rationale for the changes
> > > that you asked for below, apart from the points that they are harmless and that
> > > the return codes should be consistent.
> > 
> > The rationale is the same: all IOCTL commands that are not
> > passed/specific to character or block devices (i.e. IOCTLs defined in
> > fs/ioctl.c) are allowed.  vfs_masked_device_ioctl() returns true if the
> > IOCTL command is not passed to the related device driver but handled by
> > fs/ioctl.c instead (i.e. handled by the VFS layer).
> 
> Thanks for clarifying -- this makes more sense now.  I traced the cases with
> -ENOIOCTLCMD through the code more thoroughly and it is more aligned now with
> what you implemented before.  The places where I ended up implementing it
> differently to your vfs_masked_device_ioctl() patch are:
> 
>  * Do not blanket-permit FS_IOC_{GET,SET}{FLAGS,XATTR}.
>    They fall back to the device implementation.
> 
>  * FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH are now handled.
>    These return -ENOIOCTLCMD from do_vfs_ioctl(), so they do fall back to the
>    handlers in struct file_operations, so we can not permit these either.

Good catch!

> 
> These seem like pretty clear cases to me.
> 
> 
> > > The criteria that I have used in this patch set are that (a) it is implemented
> > > in do_vfs_ioctl() rather than further below, and (b) it makes sense to use that
> > > command on a device file.  (If we permit FIOQSIZE, FS_IOC_FIEMAP and others
> > > here, we will get slightly more correct error codes in these cases, but the
> > > IOCTLs will still not work, because they are not useful and not implemented for
> > > devices. -- On the other hand, we are also increasing the exposed code surface a
> > > bit.  For example, FS_IOC_FIEMAP is calling into inode->i_op->fiemap().  That is
> > > probably harmless for device files, but requires us to reason at a deeper level
> > > to convince ourselves of that.)
> > 
> > FIOQSIZE is fully handled by do_vfs_ioctl(), and FS_IOC_FIEMAP is
> > implemented as the inode level, so it should not be passed at the struct
> > file/device level unless ENOIOCTLCMD is returned (but it should not,
> > right?).  Because it depends on the inode implementation, it looks like
> > this IOCTL may work (in theory) on character or block devices too.  If
> > this is correct, we should not deny it because the semantic of
> > LANDLOCK_ACCESS_FS_IOCTL_DEV is to control IOCTLs passed to device
> > drivers.  Furthermore, as you pointed out, error codes would be
> > unaltered.
> > 
> > It would be good to test (as you suggested IIRC) the masked commands on
> > a simple device (e.g. /dev/null) to check that it returns ENOTTY,
> > EOPNOTSUPP, or EACCES according to our expectations.
> 
> Sounds good, I'll add a test.
> 
> 
> > I agree that this would increase a bit the exposed code surface but I'm
> > pretty sure that if a sandboxed process is allowed to access a device
> > file, it is also allowed to access directory or other file types as well
> > and then would still be able to reach the FS_IOC_FIEMAP implementation.
> 
> I assume you mean FIGETBSZ?  The FS_IOC_FIEMAP IOCTL is the one that returns
> file extent maps, so that user space can reason about whether a file is stored
> in a consecutive way on disk.

I meant FS_IOC_FIEMAP for regular files.

> 
> 
> > I'd like to avoid exceptions as in the current implementation of
> > get_required_ioctl_dev_access() with a switch/case either returning 0 or
> > LANDLOCK_ACCESS_FS_IOCTL_DEV (excluding the default case of course).  An
> > alternative approach would be to group IOCTL command cases according to
> > their returned value, but I find it a bit more complex for no meaningful
> > gain.  What do you think?
> 
> I don't have strong opinions about it, as long as we don't accidentally mess up
> the fallbacks if this changes.
> 
> 
> > > In your implementation at [3], you were permitting FICLONE* and FIDEDUPERANGE,
> > > but not FS_IOC_ZERO_RANGE, which is like fallocate().  How are these cases
> > > different to each other?  Is that on purpose?
> > 
> > FICLONE* and FIDEDUPERANGE match device files and the
> > vfs_clone_file_range()/generic_file_rw_checks() check returns EINVAL for
> > device files.  So there is no need to add exceptions for these commands.
> > 
> > FS_IOC_ZERO_RANGE is only implemented for regular files (see
> > file_ioctl() call), so it is passed to device files.
> 
> Makes sense :)
> 
> 
> —Günther
> 

