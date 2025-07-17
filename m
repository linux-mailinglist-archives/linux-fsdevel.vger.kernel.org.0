Return-Path: <linux-fsdevel+bounces-55302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F341B09716
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA277B9F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8957C23C515;
	Thu, 17 Jul 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaccgL1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02951C6FFD;
	Thu, 17 Jul 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752793840; cv=none; b=q9c2y7hEWQn5sDzmkwCFVsaPjSaKCqqw8U2QgPwQiLaJeAXUWOaFj7q10R04Q8wluvLDJIHim1yNduTAfwupAoa+D0zSUxZjO8KOsbOKZG+iTUjQs+K5sjdcUOwOC25MX+piScZKxMUuIUGsLwuBeo8lp0SScyH2L08re7CqzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752793840; c=relaxed/simple;
	bh=G1Xp1dKPUfJzybBu+Y+YBQjiqjDgnvclFXhL071t/dU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qlzIZa1edyMY6zcQboKrC3Jz1rtK87iDYM2cv4AOEKA10cPAlGShTd/lkkkBD2xC/E9EshyTjFiKSgXv2yKBtJdRg9Aio2s/4S3n1AypMppgu7mN42UOfr6B15Fv+ubbcLVMT/dIVgs96QFbqlbiS0CJ9/FQISSoamHaL+vh4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaccgL1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653DCC4CEE3;
	Thu, 17 Jul 2025 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752793839;
	bh=G1Xp1dKPUfJzybBu+Y+YBQjiqjDgnvclFXhL071t/dU=;
	h=Date:From:To:Cc:Subject:From;
	b=UaccgL1rJ1AvmqzPUkVT53ng2onXHj+M+f3mAkOQzzZ7TROmbS16VoCeeniiz3Tvh
	 bjEIrBrZy3n9vrSWJBDv39rFPqHhQQg4T92rexQ9zZxJnKuzpwJGjoGHULIKkv7DrS
	 rhNfjnY8piCPmFwRHwwiuPBYX2YfbGDSozX1D3xzCw30j1YxjTOerPHKMjzdAUF74b
	 Uc9g2/JcGga9tQTi0allEL1l6mzKqz7/CiHW97u2U+pdi16hNClJPUFhq3W6XZhdHL
	 4e2ptFCYSBQl92sOP/cI/M3xUVZR6EWwObortVsD9UH9r/kBNREdyWLYBtQz+dNaVK
	 GSlhTwhsEEaTQ==
Date: Thu, 17 Jul 2025 16:10:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: John@groves.net, bernd@bsbernd.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Subject: [RFC v3] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250717231038.GQ2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

DO NOT MERGE THIS, STILL!

This is the third request for comments of a prototype to connect the
Linux fuse driver to fs-iomap for regular file IO operations to and from
files whose contents persist to locally attached storage devices.

Why would you want to do that?  Most filesystem drivers are seriously
vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
over almost a decade of its existence.  Faulty code can lead to total
kernel compromise, and I think there's a very strong incentive to move
all that parsing out to userspace where we can containerize the fuse
server process.

willy's folios conversion project (and to a certain degree RH's new
mount API) have also demonstrated that treewide changes to the core
mm/pagecache/fs code are very very difficult to pull off and take years
because you have to understand every filesystem's bespoke use of that
core code.  Eeeugh.

The fuse command plumbing is very simple -- the ->iomap_begin,
->iomap_end, and iomap ->ioend calls within iomap are turned into
upcalls to the fuse server via a trio of new fuse commands.  Pagecache
writeback is now a directio write.  The fuse server is now able to
upsert mappings into the kernel for cached access (== zero upcalls for
rereads and pure overwrites!) and the iomap cache revalidation code
works.

With this RFC, I am able to show that it's possible to build a fuse
server for a real filesystem (ext4) that runs entirely in userspace yet
maintains most of its performance.  At this stage I still get about 95%
of the kernel ext4 driver's streaming directio performance on streaming
IO, and 110% of its streaming buffered IO performance.  Random buffered
IO is about 85% as fast as the kernel.  Random direct IO is about 80% as
fast as the kernel; see the cover letter for the fuse2fs iomap changes
for more details.  Unwritten extent conversions on random direct writes
are especially painful for fuse+iomap (~90% more overhead) due to upcall
overhead.  And that's with debugging turned on!

These items have been addressed since the first RFC:

1. The iomap cookie validation is now present, which avoids subtle races
between pagecache zeroing and writeback on filesystems that support
unwritten and delalloc mappings.

2. Mappings can be cached in the kernel for more speed.

3. iomap supports inline data.

4. I can now turn on fuse+iomap on a per-inode basis, which turned out
to be as easy as creating a new ->getattr_iflags callback so that the
fuse server can set fuse_attr::flags.

5. statx and syncfs work on iomap filesystems.

6. Timestamps and ACLs work the same way they do in ext4/xfs when iomap
is enabled.

7. The ext4 shutdown ioctl is now supported.

There are some major warts remaining:

a. ext4 doesn't support out of place writes so I don't know if that
actually works correctly.

b. iomap is an inode-based service, not a file-based service.  This
means that we /must/ push ext2's inode numbers into the kernel via
FUSE_GETATTR so that it can report those same numbers back out through
the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
to index its incore inode, so we have to pass those too so that
notifications work properly.  This is related to #3 below:

c. Hardlinks and iomap are not possible for upper-level libfuse clients
because the upper level libfuse likes to abstract kernel nodeids with
its own homebrew dirent/inode cache, which doesn't understand hardlinks.
As a result, a hardlinked file results in two distinct struct inodes in
the kernel, which completely breaks iomap's locking model.  I will have
to rewrite fuse2fs for the lowlevel libfuse library to make this work,
but on the plus side there will be far less path lookup overhead.

d. There are too many changes to the IO manager in libext2fs because I
built things needed to stage the direct/buffered IO paths separately.
These are now unnecessary but I haven't pulled them out yet because
they're sort of useful to verify that iomap file IO never goes through
libext2fs except for inline data.

e. If we're going to use fuse servers as "safe" replacements for kernel
filesystem drivers, we need to be able to set PF_MEMALLOC_NOFS so that
fuse2fs memory allocations (in the kernel) don't push pagecache reclaim.
We also need to disable the OOM killer(s) for fuse servers because you
don't want filesystems to unmount abruptly.

f. How do we maximally contain the fuse server to have safe filesystem
mounts?  It's very convenient to use systemd services to configure
isolation declaratively, but fuse2fs still needs to be able to open
/dev/fuse, the ext4 block device, and call mount() in the shared
namespace.  This prevents us from using most of the stronger systemd
protections because they tend to run in a private mount namespace with
various parts of the filesystem either hidden or readonly.

In theory one could design a socket protocol to pass mount options,
block device paths, fds, and responsibility for the mount() call between
a mount helper and a service:

e2fsprogs would define as a systemd socket service for fuse2fs that sets
up a dynamic unprivileged user, no network access, and no access to the
host's filesystem aside from readonly access to the root filesystem.

The mount helper (e.g. mount.safe) would then connect to the magic
socket and pass the CLI arguments to the fuse2fs service.  The service
would parse the arguments, find the block device paths, and feed them
back through the socket to mount.safe.  mount.safe would open them and
pass fds back to the fuse2fs service.  The service would then open the
devices, parse the superblock, and if everything was ok, request a mount
through the socket.  The mount helper would then open /dev/fuse and
mount the filesystem, and if successful, pass the /dev/fuse fd through
the socket to the fuse2fs server.  At that point the fuse2fs server
would attach to the /dev/fuse device and handle the usual events.

Finally we'd have to train people/daemons to run "mount -t safe.ext4
/dev/sda1 /mnt" to get the contained version of ext4.

(Yeah, #f is all Neal. ;))

g. fuse2fs doesn't support the ext4 journal.  Urk.

I'll work on these in July/August, but for now here's an unmergeable RFC
to start some discussion.

--Darrick


