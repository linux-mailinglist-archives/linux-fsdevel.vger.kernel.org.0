Return-Path: <linux-fsdevel+bounces-72552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF9CFB491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DDF23051593
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82552FD673;
	Tue,  6 Jan 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRfArTW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244082E1C6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739633; cv=none; b=SDDoj1J5aiCBcbn1GFBaahMZI/o67Q4Avi+NQNyEXT60VvBHpq2NSFzxE2B50/jnAruDDrvoKk7+Vc2xWF69njH1GOf3gmgbTL6OR45HQGaxzWOFAd5utV3d6R2br+bb40VlM3zIodxydO4k+B8BXo3hVsaLeIYPnQTcXm5sC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739633; c=relaxed/simple;
	bh=OvQEL8mjnKjkaBgt51moqLWtfHL3dXMdCe0XoLNyQRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=padCM3oj0hFXnM8qaSxSQ9LvOzZryPX7v6xDdSB+0hHwwt3kTAAzU7x3xabg2cBF0XzCcBfSM0bDVLWKk92y/X4CkPaEQQLP2ijWRGy0XspdXk5rDQvhYie/zVkLtrP8v2B2XW/ZW3Lib3PcKHwZ59PwHP9uUbRCoCX8faDdIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRfArTW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EADC116C6;
	Tue,  6 Jan 2026 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739632;
	bh=OvQEL8mjnKjkaBgt51moqLWtfHL3dXMdCe0XoLNyQRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRfArTW430buD6FABZnuTksslU4Nf0ItaHHrwqIEm7ES2hJpxOQL9BCXEzUNEmY5A
	 pcWtJYODdM/nLev9nyyS7HxMdvj/6yLeEm6mvNyk2tJ+YAkh75Fsh/LBhRewnTebVP
	 3YNsCrVgG+rpMipLYgEOpZHvsRsUJzEUDCBWcgIAQkoYY8AHlJ5gLVTg0zNZ7BsyZ2
	 HDuYl10rTSbv3khfwgCZSXtUpOpyYAbiQ6WZNqIXWKONH/gLhFIV5tu/4Q5yTQRnnR
	 Ks0XCa33Z18mZV3rG4fWcqM51j8KHjcr5ZSu9QPzfbv+KXewpkb4Iv+YWHtE9fYLA8
	 tTbbbYNJYPccw==
Date: Tue, 6 Jan 2026 23:47:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <20260106-asphalt-lasziv-e830a46e8287@brauner>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <6efb8f5d904c3cc4273aef725ca0bd43b05902eb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6efb8f5d904c3cc4273aef725ca0bd43b05902eb.camel@kernel.org>

On Mon, Jan 05, 2026 at 03:29:35PM -0500, Jeff Layton wrote:
> On Mon, 2025-12-29 at 14:03 +0100, Christian Brauner wrote:
> > When creating containers the setup usually involves using CLONE_NEWNS
> > via clone3() or unshare(). This copies the caller's complete mount
> > namespace. The runtime will also assemble a new rootfs and then use
> > pivot_root() to switch the old mount tree with the new rootfs. Afterward
> > it will recursively umount the old mount tree thereby getting rid of all
> > mounts.
> > 
> > On a basic system here where the mount table isn't particularly large
> > this still copies about 30 mounts. Copying all of these mounts only to
> > get rid of them later is pretty wasteful.
> > 
> > This is exacerbated if intermediary mount namespaces are used that only
> > exist for a very short amount of time and are immediately destroyed
> > again causing a ton of mounts to be copied and destroyed needlessly.
> > 
> > With a large mount table and a system where thousands or ten-thousands
> > of namespaces are spawned in parallel this quickly becomes a bottleneck
> > increasing contention on the semaphore.
> > 
> > Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> > OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> > returning a file descriptor referring to that mount tree
> > OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> > to a new mount namespace. In that new mount namespace the copied mount
> > tree has been mounted on top of a copy of the real rootfs.
> > 
> > The caller can setns() into that mount namespace and perform any
> > additionally setup such as move_mount()ing detached mounts in there.
> > 
> > This allows OPEN_TREE_NAMESPACE to function as a combined
> > unshare(CLONE_NEWNS) and pivot_root().
> > 
> > A caller may for example choose to create an extremely minimal rootfs:
> > 
> > fd_mntns = open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_NAMESPACE);
> > 
> > This will create a mount namespace where "wootwoot" has become the
> > rootfs mounted on top of the real rootfs. The caller can now setns()
> > into this new mount namespace and assemble additional mounts.
> > 
> > This also works with user namespaces:
> > 
> > unshare(CLONE_NEWUSER);
> > fd_mntns = open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_NAMESPACE);
> > 
> > which creates a new mount namespace owned by the earlier created user
> > namespace with "wootwoot" as the rootfs mounted on top of the real
> > rootfs.
> > 
> > This will scale a lot better when creating tons of mount namespaces and
> > will allow to get rid of a lot of unnecessary mount and umount cycles.
> > It also allows to create mount namespaces without needing to spawn
> > throwaway helper processes.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Christian Brauner (2):
> >       mount: add OPEN_TREE_NAMESPACE
> >       selftests/open_tree: add OPEN_TREE_NAMESPACE tests
> > 
> >  fs/internal.h                                      |    1 +
> >  fs/namespace.c                                     |  155 ++-
> >  fs/nsfs.c                                          |   13 +
> >  include/uapi/linux/mount.h                         |    3 +-
> >  .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
> >  .../selftests/filesystems/open_tree_ns/Makefile    |   10 +
> >  .../filesystems/open_tree_ns/open_tree_ns_test.c   | 1030 ++++++++++++++++++++
> >  tools/testing/selftests/filesystems/utils.c        |   26 +
> >  tools/testing/selftests/filesystems/utils.h        |    1 +
> >  9 files changed, 1223 insertions(+), 17 deletions(-)
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251229-work-empty-namespace-352a9c2dfe0a
> 
> I sat down today and rolled the attached program. It's a nonsensical
> test that just tries to fork new tasks that then spawn new mount
> namespaces and switch into them as quickly as possible.
> 
> Assuming that I've done this correctly, this gives me rough numbers
> from a test host that I checked out inside Meta:
> 
> With the older pivot_root() based method, I can create about 73k
> "containers" in 60s. With the newer open_tree() method, I can create
> about 109k in the same time. So it seems like the new method is roughly
> 40% faster than the older scheme (and a lot less syscalls too).
> 
> Note that the run_pivot() routine in the reproducer is based on a
> strace of an earlier reproducer. That one used minijail0 to create the
> containers. It's possible that there are more efficient ways to do what
> it's doing with the existing APIs. It seems to do some weird stuff too
> (e.g. setting everything to MS_PRIVATE twice under the old root).
> Spawning a real container might have other bottlenecks too.
> 
> Still, this extension to open_tree() seems like a good idea overall,
> and gets rid of a lot of useless work that we currently do when
> spawning a container. The only real downside that I can see is that
> container orchestrators will need changes to use the new method.
> 
> You can add:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Jeff Layton <jlayton@kernel.org>

Thank you for testing this!
The basic test looks correct. The pivot_root(".", ".") part could be
simplified a tiny bit but that shouldn't matter.

Fwiw, I think swapping out the rootfs isn't something that can always
be avoided in the manner I illustrated. Some users want to spawn an
empty mount namespace (e.g., just a tmpfs on top of the real rootfs) and
then assemble a detached mount tree and swap the two mounts.

But I have a better way of doing this than what pivot_root() currently
does. The main problem with pivot_root() is not just that it moves the
old rootfs to any other location on the new rootfs it also takes the
tasklist read lock and walks all processes on the system trying to find
any process that uses the old rootfs as its fs root or its pwd and then
rechroots and repwds all of these processes into the new rootfs.

But for 90% of the use-cases (containers) that is not needed. When the
container's mount namespace and rootfs are setup the task creating that
container is the only task that is using the old rootfs and that task
could very well just rechroot itself after it unmounted the old rootfs.

So in essence pivot_root() holds tasklist lock and walks all tasks on
the systems for no reason. If the user has a beefy and busy machine with
lots of processes coming and going each pivot_root() penalizes the whole
system.

I have a patchset that allows MOVE_MOUNT_BENEATH to work with the
rootfs (and an extension that adds MOVE_MOUNT_PIVOT_ROOT which optionally
does the rechrooting in case someone really needs to rechrooting.).

With MOVE_MOUNT_BENEATH working with the real rootfs that effectively
means one can stuff a new rootfs under the current rootfs, unmount the
old rootfs and chroot into the new rootfs and then be done.

That completely avoids the tasklist locking and has other benefits.

* You get the pivot_root(".", ".") trick for free.

* MOVE_MOUNT_BENEATH works with detached mounts meaning you can assemble
  your whole rootfs in a detached mount tree (since detached mounts can
  now be mounted onto other detached mounts) and then swap the old
  rootfs with your new rootfs.

* MOVE_MOUNT_BENEATH works with mount propagation. (Which means you
  could live-update the rootfs for all services. It would be a bit more
  complicated to actually make this work nicely but it would work.)

I just had a few thoughts in this area I wanted to note.

