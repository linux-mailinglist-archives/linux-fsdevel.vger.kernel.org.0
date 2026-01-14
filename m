Return-Path: <linux-fsdevel+bounces-73644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E0D1D640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FEC630935F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3B37F744;
	Wed, 14 Jan 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRQuPXhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACE37F8AE;
	Wed, 14 Jan 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381141; cv=none; b=sZGM3KQOmt+rhtEtroyaJvFxSxZqGgglNvJzGAOwvJUnwA8yl9esNHUUV6RNGe2L6o120a3E542BYbBkTpIx6oO7pECENkDPEpfcUiYALpJWn9IBA5RLhBQknMvZjivNL9ZRML9JLjsniritcU3R0sxwPMtWbRRT4taVOWaSAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381141; c=relaxed/simple;
	bh=R29hzgrrDYrnsVQRMzK2tEszjuUszFSknF9FRSHs+BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzD91/koLNtkP/QbH+NjnvSpiCx79GwQvl6IZ0wjjwfXaPb5z5xjxdmVghsjXYOannQF8/lac/H7+zZq7zDyQXUPehh+YBo2klInTXJQWjQOI6YaqfzKq+YBbtQWVPJWs8/GLgwzNjHcgXR9yt/sfkp5MrENeGZVGHvtN6iyhZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRQuPXhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F14C4CEF7;
	Wed, 14 Jan 2026 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381141;
	bh=R29hzgrrDYrnsVQRMzK2tEszjuUszFSknF9FRSHs+BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRQuPXhppRQDiFeU3JtrcADQnfVtqI8MCO3YnjuEk7yUFsO/qXn0cuPjnBPnNvyfb
	 sRVeydG/+xR1zgKOX0lpXiPIoAF3Szkf6A+vPNhrtms/YMaBA0Z4yQu/hXFfEFh+yn
	 jWRt26eizPYiABSDxsbAYNChkkvfLpCb6rNfbf0ThuqCZcrc6aa3Z2yECxGMDe3F0N
	 FWLblLuScgwANBo2z8F+GLXIuqPuF+FAVr5OOTmMLaRMD1jl9GI3yiqI/O442Qg4N8
	 spIvvYbAHRhn9BGIJIUXQQWwC4v5pEEMvXK4EXTXj+1+7ateRiLBGpbgQTlJiBYQm7
	 ndDLaZmaPPZ8Q==
Date: Wed, 14 Jan 2026 09:58:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Message-ID: <20260114-zarte-zerrbild-0e20b46eb1a6@brauner>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
 <3e81b65a391a9704aeace7719337fbf9444303ac.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e81b65a391a9704aeace7719337fbf9444303ac.camel@kernel.org>

On Tue, Jan 13, 2026 at 09:17:05AM -0500, Jeff Layton wrote:
> On Mon, 2026-01-12 at 16:47 +0100, Christian Brauner wrote:
> > Currently pivot_root() doesn't work on the real rootfs because it
> > cannot be unmounted. Userspace has to do a recursive removal of the
> > initramfs contents manually before continuing the boot.
> > 
> > Really all we want from the real rootfs is to serve as the parent mount
> > for anything that is actually useful such as the tmpfs or ramfs for
> > initramfs unpacking or the rootfs itself. There's no need for the real
> > rootfs to actually be anything meaningful or useful. Add a immutable
> > rootfs called "nullfs" that can be selected via the "nullfs_rootfs"
> > kernel command line option.
> > 
> > The kernel will mount a tmpfs/ramfs on top of it, unpack the initramfs
> > and fire up userspace which mounts the rootfs and can then just do:
> > 
> >   chdir(rootfs);
> >   pivot_root(".", ".");
> >   umount2(".", MNT_DETACH);
> > 
> > and be done with it. (Ofc, userspace can also choose to retain the
> > initramfs contents by using something like pivot_root(".", "/initramfs")
> > without unmounting it.)
> > 
> > Technically this also means that the rootfs mount in unprivileged
> > namespaces doesn't need to become MNT_LOCKED anymore as it's guaranteed
> > that the immutable rootfs remains permanently empty so there cannot be
> > anything revealed by unmounting the covering mount.
> > 
> > In the future this will also allow us to create completely empty mount
> > namespaces without risking to leak anything.
> > 
> > systemd already handles this all correctly as it tries to pivot_root()
> > first and falls back to MS_MOVE only when that fails.
> > 
> > This goes back to various discussion in previous years and a LPC 2024
> > presentation about this very topic.
> > 
> > Now in vfs-7.0.nullfs.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Changes in v2:
> > - Rename to "nullfs".
> > - Update documentation.
> > - Link to v1: https://patch.msgid.link/20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org
> > 
> > ---
> > Christian Brauner (4):
> >       fs: ensure that internal tmpfs mount gets mount id zero
> >       fs: add init_pivot_root()
> >       fs: add immutable rootfs
> >       docs: mention nullfs
> > 
> >  .../filesystems/ramfs-rootfs-initramfs.rst         |  32 +++-
> >  fs/Makefile                                        |   2 +-
> >  fs/init.c                                          |  17 ++
> >  fs/internal.h                                      |   1 +
> >  fs/mount.h                                         |   1 +
> >  fs/namespace.c                                     | 181 ++++++++++++++-------
> >  fs/nullfs.c                                        |  70 ++++++++
> >  include/linux/init_syscalls.h                      |   1 +
> >  include/uapi/linux/magic.h                         |   1 +
> >  init/do_mounts.c                                   |  14 ++
> >  init/do_mounts.h                                   |   1 +
> >  11 files changed, 254 insertions(+), 67 deletions(-)
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20260102-work-immutable-rootfs-b5f23e0f5a27
> 
> I like the set overall. My only real gripe is the new command-line
> option. Won't that make distro adoption hard?
> 
> IIUC, with this new method, you're just adding a new nullfs at the
> bottom of the stack and then mounting the traditional ramfs as the
> mutable rootfs on top of it.
> 
> Would there be any harm in just always doing this (and dropping the
> command-line option)?
> 
> You would end up "leaking" both the nullfs and ramfs in the case of
> traditional userspace that was unaware of the extra mount, but that
> seems like it should be something we could live with.

I would be open to trying to make it unconditional. IOW, a patch on top
of the current set that removes the "nullfs_rootfs" command line so that
we can simply revert if it turns out that is an issue.

