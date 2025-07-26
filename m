Return-Path: <linux-fsdevel+bounces-56063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FBCB129B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A087E7A7B80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5197B202F67;
	Sat, 26 Jul 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rNVus5Ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023214A82
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516885; cv=none; b=kYkFTiJh23lxA76xqgNV8wJo6/TWmIkKK1JeKOsIihvRP3rOVXr8QnJQVFjxGHU9vwksCSaSBmm+XxQiwohl2RS+m8/6S+zlAmE5+Px+VECval708BwtRLcr5fX+T5H3UUSY5Oj04b4whervp76UcUh3DMvOYSg8iAqwdZd0Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516885; c=relaxed/simple;
	bh=2yBaxwjkO86grqtAVHgtKtD5A8twR+2SDhdupEPgyDU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W/JbLBhA7L/h0VZ0Xn2kB8SF8h3Lc5k7b9t8yAZAwFKjYgeJJnUWITf1BGffmsIObPV15hywhahfd1gbN2ZKGKKwYmAONRgCrKzAzPR0sJXf6pFUkiEQhcNTF57GzLHYwBIa0KOsd9chP0p9Tvk3ygbgPxl/R74v2R2FxfiqEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rNVus5Ck; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=11tU2xGmqClvqh+N0MHn15qExOKGO0nlO1yUaYujq6E=; b=rNVus5Ck3bfFiQfakP/PkYr17j
	mxNnqjffDKkdP+gSYmZIeLy4cBMjXUNRhEKIoJLEF6cD9il27RJMH3aR8AJ0p0lKC5s9kvd8T5ivY
	IU6KhHPayzJ/WiNlI9Gf0hZKnrM/1nUKRBUxN8214N8skig/dT8deHKY36rFgdm7DvAd5FImXT2nt
	6Fqmk4gHL6nWtRQsFIuhO2M2dJde4LJxB9Qe3wC1LJFfUCVWD+D7L/Ig4WZ2DyUbBuFh08l2qcJET
	RtE1Ji35/L5DYiSk+uVsifl+olY8GhK5Y+MTvZELQfmigUdQcapASjz3nzRi92IT8fy50hZKc3Ttd
	vjpq7ZPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZqK-000000066sM-08E5;
	Sat, 26 Jul 2025 08:01:20 +0000
Date: Sat, 26 Jul 2025 09:01:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 1/9: d_flags pile
Message-ID: <20250726080119.GA222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[trivial conflict in Documentation/filesystems/porting.rst]

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache

for you to fetch changes up to a509e7cf622bc7ce3f45b1c7047fc2a5e9bea869:

  configfs: use DCACHE_DONTCACHE (2025-06-11 13:41:05 -0400)

----------------------------------------------------------------
	Current exclusion rules for ->d_flags stores are rather unpleasant.
The basic rules are simple:
	* stores to dentry->d_flags are OK under dentry->d_lock.
	* stores to dentry->d_flags are OK in the dentry constructor, before
becomes potentially visible to other threads.
Unfortunately, there's a couple of exceptions to that, and that's where the
headache comes from.

	Main PITA comes from d_set_d_op(); that primitive sets ->d_op
of dentry and adjusts the flags that correspond to presence of individual
methods.  It's very easy to misuse; existing uses _are_ safe, but proof
of correctness is brittle.

	Use in __d_alloc() is safe (we are within a constructor), but we
might as well precalculate the initial value of ->d_flags when we set
the default ->d_op for given superblock and set ->d_flags directly
instead of messing with that helper.

	The reasons why other uses are safe are bloody convoluted; I'm not going
to reproduce it here.  See https://lore.kernel.org/all/20250224010624.GT1977892@ZenIV/
for gory details, if you care.  The critical part is using d_set_d_op() only
just prior to d_splice_alias(), which makes a combination of d_splice_alias()
with setting ->d_op, etc. a natural replacement primitive.  Better yet, if
we go that way, it's easy to take setting ->d_op and modifying ->d_flags
under ->d_lock, which eliminates the headache as far as ->d_flags exclusion
rules are concerned.  Other exceptions are minor and easy to deal with.

	What this series does:
* d_set_d_op() is no longer available; new primitive (d_splice_alias_ops())
is provided, equivalent to combination of d_set_d_op() and d_splice_alias().
* new field of struct super_block - ->s_d_flags.  Default value of ->d_flags
to be used when allocating dentries on this filesystem.
* new primitive for setting ->s_d_op: set_default_d_op().  Replaces stores
to ->s_d_op at mount time.  All in-tree filesystems converted; out-of-tree
ones will get caught by compiler (->s_d_op is renamed, so stores to it will
be caught).  ->s_d_flags is set by the same primitive to match the ->s_d_op.
* a lot of filesystems had ->s_d_op->d_delete equal to always_delete_dentry;
that is equivalent to setting DCACHE_DONTCACHE in ->d_flags, so such filesystems
can bloody well set that bit in ->s_d_flags and drop ->d_delete() from
dentry_operations.  In quite a few cases that results in empty dentry_operations,
which means that we can get rid of those.
* kill simple_dentry_operations - not needed anymore.
* massage d_alloc_parallel() to get rid of the other exception wrt ->d_flags
stores - we can set DCACHE_PAR_LOOKUP as soon as we allocate the new dentry;
no need to delay that until we commit to using the sucker.

As the result, ->d_flags stores are all either under ->d_lock or done before
the dentry becomes visible in any shared data structures.

----------------------------------------------------------------
Al Viro (20):
      d_set_mounted(): we don't need to bump seqcount component of rename_lock
      procfs: kill ->proc_dops
      new helper: d_splice_alias_ops()
      switch procfs from d_set_d_op() to d_splice_alias_ops()
      fuse: no need for special dentry_operations for root dentry
      new helper: set_default_d_op()
      split d_flags calculation out of d_set_d_op()
      correct the set of flags forbidden at d_set_d_op() time
      set_default_d_op(): calculate the matching value for ->d_flags
      simple_lookup(): just set DCACHE_DONTCACHE
      make d_set_d_op() static
      d_alloc_parallel(): set DCACHE_PAR_LOOKUP earlier
      shmem: no dentry retention past the refcount reaching zero
      devpts, sunrpc, hostfs: don't bother with ->d_op
      kill simple_dentry_operations
      ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
      9p: don't bother with always_delete_dentry
      efivarfs: use DCACHE_DONTCACHE instead of always_delete_dentry()
      debugfs: use DCACHE_DONTCACHE
      configfs: use DCACHE_DONTCACHE

Steven Rostedt (1):
      tracefs: Add d_delete to remove negative dentries

 Documentation/filesystems/porting.rst |  18 ++++
 fs/9p/vfs_dentry.c                    |   1 -
 fs/9p/vfs_super.c                     |  10 ++-
 fs/adfs/super.c                       |   2 +-
 fs/affs/super.c                       |   4 +-
 fs/afs/super.c                        |   4 +-
 fs/autofs/inode.c                     |   2 +-
 fs/btrfs/super.c                      |   2 +-
 fs/ceph/super.c                       |   2 +-
 fs/coda/inode.c                       |   2 +-
 fs/configfs/dir.c                     |   1 -
 fs/configfs/mount.c                   |   3 +-
 fs/dcache.c                           | 153 ++++++++++++++++++++--------------
 fs/debugfs/inode.c                    |   4 +-
 fs/devpts/inode.c                     |   2 +-
 fs/ecryptfs/main.c                    |   2 +-
 fs/efivarfs/super.c                   |   4 +-
 fs/exfat/super.c                      |   4 +-
 fs/fat/namei_msdos.c                  |   2 +-
 fs/fat/namei_vfat.c                   |   4 +-
 fs/fuse/dir.c                         |   7 --
 fs/fuse/fuse_i.h                      |   1 -
 fs/fuse/inode.c                       |   6 +-
 fs/gfs2/ops_fstype.c                  |   2 +-
 fs/hfs/super.c                        |   2 +-
 fs/hfsplus/super.c                    |   2 +-
 fs/hostfs/hostfs_kern.c               |   2 +-
 fs/hpfs/super.c                       |   2 +-
 fs/hugetlbfs/inode.c                  |   1 +
 fs/isofs/inode.c                      |   2 +-
 fs/jfs/super.c                        |   2 +-
 fs/kernfs/mount.c                     |   2 +-
 fs/libfs.c                            |  27 +++---
 fs/nfs/super.c                        |   2 +-
 fs/ntfs3/super.c                      |   3 +-
 fs/ocfs2/super.c                      |   2 +-
 fs/orangefs/super.c                   |   2 +-
 fs/overlayfs/super.c                  |   2 +-
 fs/proc/base.c                        |   9 +-
 fs/proc/generic.c                     |  10 ++-
 fs/proc/internal.h                    |   6 +-
 fs/proc/namespaces.c                  |   3 +-
 fs/proc/proc_sysctl.c                 |   7 +-
 fs/ramfs/inode.c                      |   1 +
 fs/smb/client/cifsfs.c                |   4 +-
 fs/tracefs/inode.c                    |  13 ++-
 fs/vboxsf/super.c                     |   2 +-
 include/linux/dcache.h                |   6 +-
 include/linux/fs.h                    |   4 +-
 include/linux/proc_fs.h               |   2 +
 ipc/mqueue.c                          |   1 +
 mm/shmem.c                            |   4 +-
 net/sunrpc/rpc_pipe.c                 |   2 +-
 53 files changed, 210 insertions(+), 159 deletions(-)

