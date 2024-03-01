Return-Path: <linux-fsdevel+bounces-13279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72ED86E25B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425A01F21500
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA36BB4B;
	Fri,  1 Mar 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Dfgs8i5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439E53815
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300305; cv=none; b=fAJ+VOhefwgpULMLZ8BX0M7jgaxNA0Mis5rGdSFl6KMgSbRtPJq4o+rF54adiC6w/x7ZroM0YzjGXnbdL8ImYd+idOYRndQ4U+XPIQAV3HiCxJLBJ5ZpniHAklQRZIEGKoDGMV/lExOkKWE6dEwSU00BQ8wGo7pG9r54Zo9rLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300305; c=relaxed/simple;
	bh=tAp+WUezvA8Fv6XlGanbE5olVA6NnXYV4quUMvi0R44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHhUQgZ/zH+4e4+g5XXUjdYJEB4mEXe3fs/csoDuvtYFtO72fXiB9a72WMUGQokrRzCdxkuPVGspjm5YABUD91THYmr2JYlib4S1exf3oTsMT93oZi+vNzQHcVAg11YFWXoqrz33f4l3saAZ8pFJsnS/MG2qP7drJOP+i6MI+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Dfgs8i5z; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TmTgS0wj2z4hW;
	Fri,  1 Mar 2024 14:38:12 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TmTgQ6NSpzs1d;
	Fri,  1 Mar 2024 14:38:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709300292;
	bh=tAp+WUezvA8Fv6XlGanbE5olVA6NnXYV4quUMvi0R44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dfgs8i5zR2T0IiwJZWDDnfytWoZ4oSAsTu1CVq7FD+/Cf7TYlb285FofUKb0iiAT0
	 G9y/u+7wQemg3qMmZamcLhgDSh9MQ/xZ0gdwZxHV++EHFOfkiLgWJy9FgAzphEVoFG
	 /CVNnKSDIHvUv7CbPAWK48uIuNH2vPW3jprIr8ms=
Date: Fri, 1 Mar 2024 14:38:01 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240301.ahchaeNa6oh5@digikod.net>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <20240219.chu4Yeegh3oo@digikod.net>
 <Zd8txvjeeXjRdeP-@google.com>
 <20240301.eiGhingai1gi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301.eiGhingai1gi@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Mar 01, 2024 at 01:59:13PM +0100, Mickaël Salaün wrote:
> On Wed, Feb 28, 2024 at 01:57:42PM +0100, Günther Noack wrote:
> > Hello Mickaël!
> > 
> > On Mon, Feb 19, 2024 at 07:34:42PM +0100, Mickaël Salaün wrote:
> > > Arn, Christian, please take a look at the following RFC patch and the
> > > rationale explained here.
> > > 
> > > On Fri, Feb 09, 2024 at 06:06:05PM +0100, Günther Noack wrote:
> > > > Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> > > > and increments the Landlock ABI version to 5.
> > > > 
> > > > Like the truncate right, these rights are associated with a file
> > > > descriptor at the time of open(2), and get respected even when the
> > > > file descriptor is used outside of the thread which it was originally
> > > > opened in.
> > > > 
> > > > A newly enabled Landlock policy therefore does not apply to file
> > > > descriptors which are already open.
> > > > 
> > > > If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> > > > of safe IOCTL commands will be permitted on newly opened files.  The
> > > > permitted IOCTLs can be configured through the ruleset in limited ways
> > > > now.  (See documentation for details.)
> > > > 
> > > > Specifically, when LANDLOCK_ACCESS_FS_IOCTL is handled, granting this
> > > > right on a file or directory will *not* permit to do all IOCTL
> > > > commands, but only influence the IOCTL commands which are not already
> > > > handled through other access rights.  The intent is to keep the groups
> > > > of IOCTL commands more fine-grained.
> > > > 
> > > > Noteworthy scenarios which require special attention:
> > > > 
> > > > TTY devices are often passed into a process from the parent process,
> > > > and so a newly enabled Landlock policy does not retroactively apply to
> > > > them automatically.  In the past, TTY devices have often supported
> > > > IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> > > > letting callers control the TTY input buffer (and simulate
> > > > keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> > > > modern kernels though.
> > > > 
> > > > Some legitimate file system features, like setting up fscrypt, are
> > > > exposed as IOCTL commands on regular files and directories -- users of
> > > > Landlock are advised to double check that the sandboxed process does
> > > > not need to invoke these IOCTLs.
> > > 
> > > I think we really need to allow fscrypt and fs-verity IOCTLs.
> > > 
> > > > 
> > > > Known limitations:
> > > > 
> > > > The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> > > > over IOCTL commands.  Future work will enable a more fine-grained
> > > > access control for IOCTLs.
> > > > 
> > > > In the meantime, Landlock users may use path-based restrictions in
> > > > combination with their knowledge about the file system layout to
> > > > control what IOCTLs can be done.  Mounting file systems with the nodev
> > > > option can help to distinguish regular files and devices, and give
> > > > guarantees about the affected files, which Landlock alone can not give
> > > > yet.
> > > 
> > > I had a second though about our current approach, and it looks like we
> > > can do simpler, more generic, and with less IOCTL commands specific
> > > handling.
> > > 
> > > What we didn't take into account is that an IOCTL needs an opened file,
> > > which means that the caller must already have been allowed to open this
> > > file in read or write mode.
> > > 
> > > I think most FS-specific IOCTL commands check access rights (i.e. access
> > > mode or required capability), other than implicit ones (at least read or
> > > write), when appropriate.  We don't get such guarantee with device
> > > drivers.
> > > 
> > > The main threat is IOCTLs on character or block devices because their
> > > impact may be unknown (if we only look at the IOCTL command, not the
> > > backing file), but we should allow IOCTLs on filesystems (e.g. fscrypt,
> > > fs-verity, clone extents).  I think we should only implement a
> > > LANDLOCK_ACCESS_FS_IOCTL_DEV right, which would be more explicit.  This
> > > change would impact the IOCTLs grouping (not required anymore), but
> > > we'll still need the list of VFS IOCTLs.
> > 
> > 
> > I am fine with dropping the IOCTL grouping and going for this simpler approach.
> > 
> > This must have been a misunderstanding - I thought you wanted to align the
> > access checks in Landlock with the ones done by the kernel already, so that we
> > can reason about it more locally.  But I'm fine with doing it just for device
> > files as well, if that is what it takes.  It's definitely simpler.
> 
> I still think we should align existing Landlock access rights with the VFS IOCTL
> semantic (i.e. mostly defined in do_vfs_ioctl(), but also in the compat
> ioctl syscall).  However, according to our investigations and
> discussions, it looks like the groups we defined should already be
> enforced by the VFS code, which means we should not need such groups
> after all.  My last proposal is to still delegate access for VFS IOCTLs
> to the current Landlock access rights, but it doesn't seem required to
> add specific access check if we are able to identify these VFS IOCTLs.

To say it another way, at least one of the read/write Landlock rights
are already required to open a file/directory, and according to the new
get_required_ioctl_access() grouping we can simplifying it further to
fully rely on the meta "open" access right, and then replace
get_required_ioctl_access() with the file type and
vfs_masked_device_ioctl() checks.

For now, the only "optional" access right is
LANDLOCK_ACCESS_FS_TRUNCATE, and I don't think it needs to be tied to
any VFS IOCTLs.

Because the IOCTL_DEV access right comes now, future access rights that
may need to also check IOCTL (e.g. change file attribute) should be much
simpler to implement.  Indeed, they will only impact VFS IOCTLs which
would always be allowed with LANDLOCK_ACCESS_FS_IOCTL_DEV.  It should
then be trivial to add a new control layer for a subset of the VFS
IOCTLs.

