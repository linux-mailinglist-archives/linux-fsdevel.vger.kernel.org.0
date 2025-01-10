Return-Path: <linux-fsdevel+bounces-38776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FBA0856A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E5C3A82FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105AC1E32C5;
	Fri, 10 Jan 2025 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l5vJoJ2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994E1E1A18;
	Fri, 10 Jan 2025 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476741; cv=none; b=kup10a35N4lp1D1z4mDc2wjLUgjeaS8vf0hEbPbSVIPg9d4xlOBiTI2pazBue+qIZmYUTvF7Ux6+yB81o9mz/C4ggei4CzDGkajyf7uDqYJaja4sw4yL51dPg3GrtoL2+5vMZKL2uWOaNaGzmBqPaArjhWC0n7oYu4GMuPVcT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476741; c=relaxed/simple;
	bh=ArsVe4uCp/mkm5cIi5o9H5W+vRhAT5bl4i3CGSNeJME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jaGUTIT73QZc9CbeBFc8CTH1oEIUwzbyy41hcXowGWDaXekPYnjljsVdYgaYQfsEvrgmTJjVmjWp2jej40GSm+Z5T4B9CTBJ+vjJI4Gh68uu93yTX9MfmKW1g/XN1RAJMS/l+NO0QXbJLfreErN9tBH0hXLjJfHJH9QDF4hHORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l5vJoJ2u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5kSDVbu8ir4RQFEVW4OLsyQRvGGzqq8qrfXa4TRN1g0=; b=l5vJoJ2uHoO8TvP5dyi6uCfRmk
	BYPMWphHJjmm5lhpFOuyhp0QmTvV9KhGAeZWk+tufm5qAvq3AiXpcCpzyuKaT77gmPKtnJs7h9pdw
	1MgTS1I9bExdJot084MtbENNCH9NSm2Md4WXhkTHsu7s0QCpnFLzXln64SYKwfIlupUGqEHYG76QV
	c/vywIkcahbtqAJ64Ubh9yxCVs8h1iPPAHIAtWRv0GxostgxCw7vZmcrS2ULaSwvfBifsQtMpQK+W
	mWM2WcGiZMNxZlufxcK5aLnP6GFiuGFUuZV49yh5khjDuy/trWhMM+eyfCLYQvPQ4JhuPLx+G8fF5
	yWw78XxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4vG-0000000HRTP-281f;
	Fri, 10 Jan 2025 02:38:54 +0000
Date: Fri, 10 Jan 2025 02:38:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel Krisman Bertazi <krisman@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCHES][RFC][CFT] ->d_revalidate() calling conventions changes
 (->d_parent/->d_name stability problems)
Message-ID: <20250110023854.GS1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[this had been more than a year in making; my apologies for getting sidetracked
several times]

	Locking rules for dentry->d_name and dentry->d_parent are seriously
unpleasant and historically we had quite a few races in that area.  Filesystem
methods mostly don't have to care about that since the locking in VFS callers
is enough to guarantee that dentries passed to the methods won't be renamed
or moved behind the method's back.

	Directory-modifying methods (->mknod(), ->mkdir(), ->unlink(), ->rename(),
->link(), etc.) are guaranteed that their dentry arguments will have names and
parents unchanging through the method exectuction.  For ->lookup() the warranties
are slightly weaker (they disappear once an inode has been attached to dentry),
but they still cover most of the execution.  As the result, all these methods
can safely access ->d_parent and ->d_name.

	->d_revalidate() is an exception - the caller might be holding no locks
whatsoever and both the name and parent may be changing right under us.
Locally you can hold dentry->d_lock - that'll stabilize both ->d_parent and
->d_name, but you obviously can't hold that over any IO and as soon as you drop
->d_lock, you are on your own.

	There is a rather convoluted dance needed to get a safe reference
to parent -
	if not in RCU mode
		parent = dget_parent(dentry)
		dir = d_inode(parent)
	else
		parent = READ_ONCE(dentry->d_parent)
		dir = d_inode_rcu(parent)
		if (!dir)
			return -ECHILD
	<do actual work>
	if not in RCU mode
		dput(parent)
and it's duplicated in a bunch of instances (not all of them - quite a few
->d_revalidate() instances do not care about the parent *or* name in the
first place).  For names... you can safely access that under ->d_lock
(including copying it someplace safe) or you can use take_dentry_name_snapshot(),
but blind dereferencing of ->d_name.name is really asking for trouble -
for a long name you might end up accessing freed memory.

	An obvious improvement would be to pass safe references to parent
and name as explicit arguments of ->d_revalidate().  Examining the in-tree
instances shows that we have 4 groups:
	1) really don't care about parent at all: hfs, jfs, all procfs ones,
tracefs.
	2) want only the inode of parent directory: afs, ceph, exfat and
vfat ones, fscrypt, fuse, gfs2, nfs, ocfs2, orangefs
	3) don't use the parent directly, no help from that calling conventions
change: smb, 9p, vboxsf, coda, kernfs.
	4) really special: ecryptfs, overlayfs.
In other words, passing the parent's inode is more useful than passing its
dentry, ending up with
	int (*d_revalidate)(struct inode *dir, const struct qstr *name,
                            struct dentry *dentry, unsigned int flags);

	That, however, presumes that we can get these stable references in
the callers without a serious overhead.  Thankfully, there are only 3 callers
of ->d_revalidate() in the entire tree.  The regular one is in
fs/namei.c:d_revalidate() and that's what the pathname resolution is using.
Additionally, ecryptfs and overlayfs instances of ->d_revalidate() may
want to call that method for dentries in underlying filesystems.

	fs/namei.c:d_revalidate() callers already have stable references
to parent and name - we are calling that right after we'd found our dentry
in dcache and we bloody well know which parent/name combination we'd been
looking for.  So in this case no convolutions are needed - we already have
the values of extra arguments for ->d_revalidate().

	In case of ecryptfs and overlayfs deciding to call ->d_revalidate()
for underlying dentries we can just use take_dentry_name_snapshot() on that
underlying dentry to get the stable name and either do the aforementioned
convoluted dance to get a stable reference to parent (in case of overlayfs)
or use the directory underlying the parent of our dentry (in case of ecryptfs).

	That allows to get rid of boilerplate in the instances and allows
to close some actual races wrt ->d_name uses.  The series below attempts to
do just that.  It lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.d_revalidate
itself on top of #work.dcache.

	Individual patches in followups; please, review.

Shortlog (including #work.dcache):
Al Viro (20):
      make sure that DNAME_INLINE_LEN is a multiple of word size
      dcache: back inline names with a struct-wrapped array of unsigned long
      make take_dentry_name_snapshot() lockless
      dissolve external_name.u into separate members
      ext4 fast_commit: make use of name_snapshot primitives
      generic_ci_d_compare(): use shortname_storage
      Pass parent directory inode and expected name to ->d_revalidate()
      afs_d_revalidate(): use stable name and parent inode passed by caller
      ceph_d_revalidate(): use stable parent inode passed by caller
      ceph_d_revalidate(): propagate stable name down into request enconding
      fscrypt_d_revalidate(): use stable parent inode passed by caller
      exfat_d_revalidate(): use stable parent inode passed by caller
      vfat_revalidate{,_ci}(): use stable parent inode passed by caller
      fuse_dentry_revalidate(): use stable parent inode and name passed by caller
      gfs2_drevalidate(): use stable parent inode and name passed by caller
      nfs{,4}_lookup_validate(): use stable parent inode passed by caller
      nfs: fix ->d_revalidate() UAF on ->d_name accesses
      ocfs2_dentry_revalidate(): use stable parent inode and name passed by caller
      orangefs_d_revalidate(): use stable parent inode and name passed by caller
      9p: fix ->rename_sem exclusion

Diffstat (again, including #work.dcache):
 Documentation/filesystems/locking.rst        |  5 +-
 Documentation/filesystems/porting.rst        | 13 ++++
 Documentation/filesystems/vfs.rst            | 22 ++++++-
 fs/9p/v9fs.h                                 |  2 +-
 fs/9p/vfs_dentry.c                           | 23 ++++++-
 fs/afs/dir.c                                 | 40 ++++--------
 fs/ceph/dir.c                                | 25 ++------
 fs/ceph/mds_client.c                         |  9 ++-
 fs/ceph/mds_client.h                         |  2 +
 fs/coda/dir.c                                |  3 +-
 fs/crypto/fname.c                            | 22 ++-----
 fs/dcache.c                                  | 96 ++++++++++++++++------------
 fs/ecryptfs/dentry.c                         | 18 ++++--
 fs/exfat/namei.c                             | 11 +---
 fs/ext4/fast_commit.c                        | 29 ++-------
 fs/ext4/fast_commit.h                        |  3 +-
 fs/fat/namei_vfat.c                          | 19 +++---
 fs/fuse/dir.c                                | 14 ++--
 fs/gfs2/dentry.c                             | 31 ++++-----
 fs/hfs/sysdep.c                              |  3 +-
 fs/jfs/namei.c                               |  3 +-
 fs/kernfs/dir.c                              |  3 +-
 fs/libfs.c                                   | 15 +++--
 fs/namei.c                                   | 18 +++---
 fs/nfs/dir.c                                 | 62 ++++++++----------
 fs/nfs/namespace.c                           |  2 +-
 fs/nfs/nfs3proc.c                            |  5 +-
 fs/nfs/nfs4proc.c                            | 20 +++---
 fs/nfs/proc.c                                |  6 +-
 fs/ocfs2/dcache.c                            | 14 ++--
 fs/orangefs/dcache.c                         | 20 +++---
 fs/overlayfs/super.c                         | 22 ++++++-
 fs/proc/base.c                               |  6 +-
 fs/proc/fd.c                                 |  3 +-
 fs/proc/generic.c                            |  6 +-
 fs/proc/proc_sysctl.c                        |  3 +-
 fs/smb/client/dir.c                          |  3 +-
 fs/tracefs/inode.c                           |  3 +-
 fs/vboxsf/dir.c                              |  3 +-
 include/linux/dcache.h                       | 22 +++++--
 include/linux/fscrypt.h                      |  7 +-
 include/linux/nfs_xdr.h                      |  2 +-
 tools/testing/selftests/bpf/progs/find_vma.c |  2 +-
 43 files changed, 336 insertions(+), 304 deletions(-)

	Overview (#work.dcache is the first 6 commits in there):

Part 1: hopefully cheaper take_dentry_name_snapshot() and handling of inline
(short) names.  One surprising thing was that gcc __builtin_memcpy() does
*not* make use of the alignment information; turns out that it's better to
wrap the entire short name into an object that can be copied by assignment.

01/20)   make sure that DNAME_INLINE_LEN is a multiple of word size
	Linus' suggestion to define the size of shortname in terms of
unsigned long words and derive its size in bytes from that.  Cleaner
that way.
02/20)   dcache: back inline names with a struct-wrapped array of unsigned long
	... so that they can be copied with struct assignment (which
generates better code) and accessed word-by-word.
	The type is union shortname_storage; it's a union of arrays of
unsigned char and unsigned long.
	struct name_snapshot.inline_name turned into union
shortname_storage; users (all in fs/dcache.c) adjusted.
	struct dentry.d_iname has some users outside of fs/dcache.c;
to reduce the amount of noise in commit, it is replaced with union
shortname_storage d_shortname and d_iname is turned into a macro that
expands to d_shortname.string (similar to d_lock handling)
03/20)   make take_dentry_name_snapshot() lockless
	Use ->d_seq instead of grabbing ->d_lock; in case of shortname
dentries that avoids any stores to shared data objects and in case of
long names we are down to (unavoidable) atomic_inc on the external_name
refcount.  Makes the thing safer as well - the areas where ->d_seq is held
odd are all nested inside the areas where ->d_lock is held, and the latter
are much more numerous.  NOTE: now that there is a lockless path where
we might try to grab a reference to an already doomed external_name
instance, it is no longer possible for external_name.u.count and
external_name.u.head to share space (kudos to Linus for spotting that).
To reduce the noice this commit just make external_name.u a struct
(instead of union); the next commit will dissolve it.
04/20)   dissolve external_name.u into separate members
	kept separate from the previous commit to keep the noise separate
from actual changes...
05/20)   ext4 fast_commit: make use of name_snapshot primitives
	... rather than open-coding them.  As a bonus, that avoids the
pointless work with extra allocations, etc. for long names.
06/20)   generic_ci_d_compare(): use shortname_storage
	... and check the "name might be unstable" predicate the right way.

Part 2: ->d_revalidate() calling conventions change.  The first commit
adds the method prototype and has the extra arguments supplied by the callers;
making use of those extra arguments is done in followup patches, so that
they can be reviewed separately.

07/20)   Pass parent directory inode and expected name to ->d_revalidate()
	->d_revalidate() often needs to access dentry parent and name;
that has to be done carefully, since the locking environment varies from
caller to caller.  We are not guaranteed that dentry in question will
not be moved right under us - not unless the filesystem is such that
nothing on it ever gets renamed.
	It can be dealt with, but that results in boilerplate code that
isn't even needed - the callers normally have just found the dentry
via dcache lookup and want to verify that it's in the right place; they
already have the values of ->d_parent and ->d_name stable.  There is a
couple of exceptions (overlayfs and, to less extent, ecryptfs), but for
the majority of calls that song and dance is not needed at all.
	It's easier to make ecryptfs and overlayfs find and pass those
values if there's a ->d_revalidate() instance to be called, rather than
doing that in the instances.
	This commit only changes the calling conventions; making use of
supplied values is left to followups.
	NOTE: some instances need more than just the parent - things like
CIFS may need to build an entire path from filesystem root, so they need
more precautions than the usual boilerplate.  This series doesn't
do anything to that need - these filesystems have to keep their locking
mechanisms (rename_lock loops, use of dentry_path_raw(), private rwsem
a-la v9fs).


Part 3: making use of the new arguments - getting rid of parent-obtaining
boilerplate in the instances and getting rid of racy uses of ->d_name in
some of those.  Split on per-filesystem basis.

08/20)   afs_d_revalidate(): use stable name and parent inode passed by caller
09/20)   ceph_d_revalidate(): use stable parent inode passed by caller
10/20)   ceph_d_revalidate(): propagate stable name down into request enconding
11/20)   fscrypt_d_revalidate(): use stable parent inode passed by caller
12/20)   exfat_d_revalidate(): use stable parent inode passed by caller
13/20)   vfat_revalidate{,_ci}(): use stable parent inode passed by caller
14/20)   fuse_dentry_revalidate(): use stable parent inode and name passed by caller
15/20)   gfs2_drevalidate(): use stable parent inode and name passed by caller
16/20)   nfs{,4}_lookup_validate(): use stable parent inode passed by caller
17/20)   nfs: fix ->d_revalidate() UAF on ->d_name accesses
18/20)   ocfs2_dentry_revalidate(): use stable parent inode and name passed by caller
19/20)   orangefs_d_revalidate(): use stable parent inode and name passed by caller


Part 4: dealing with races in access to ancestors' names/parents.  Changing the
calling conventions above helps with the name and parent of dentry being revalidated;
it doesn't do anything for its ancestors and some instances want to deal with the
entire path to filesystem root.  The way it's done varies from filesystem to
filesystem and often isn't limited to ->d_revalidate().  There is a safe helper
(dentry_path()) and e.g. smb avoids the races by using it.  9p and ceph do not,
for various reasons, and both have problems.  I've done a 9p fix (see below);
ceph one is trickier and I'd prefer to discuss it with ceph folks first.

20/20)   9p: fix ->rename_sem exclusion
	9p wants to be able to build a path from given dentry to fs root
and keep it valid over a blocking operation.
	->s_vfs_rename_mutex would be a natural candidate, but there
are places where we want that and where we have no way to tell if
->s_vfs_rename_mutex has already been taken deeper in callchain.
Moreover, it's only held for cross-directory renames; name changes within
the same directory happen without touching that lock.
Current mainline solution:
	* have d_move() done in ->rename() rather than in its caller
	* maintain a 9p-private rwsem (->rename_sem, per-filesystem)
	* hold it exclusive over the relevant part of ->rename()
	* hold it shared over the places where we want the path.
That almost works.  FS_RENAME_DOES_D_MOVE is enough to put all d_move()
and d_exchange() calls under filesystem's control.  However, there's
also __d_unalias(), which isn't covered by any of that.
	If ->lookup() hits a directory inode with preexisting dentry
elsewhere (due to e.g. rename done on server behind our back),
d_splice_alias() called by ->lookup() will move/rename that alias.
	One approach to fixing that would be to add a couple of optional
methods, so that __d_unalias() would do
	if alias->d_op->d_unalias_trylock != NULL
		if (!alias->d_op->d_unalias_trylock(alias))
			fail (resulting in -ESTALE from lookup)
	__d_move(...)
	if alias->d_op->d_unalias_unlock != NULL
		alias->d_unalias_unlock(alias)
where it currently does __d_move().  9p instances would be down_write_trylock()
and up_write() of ->rename_sem.
	However, to reduce dentry_operations bloat, let's add one method
instead - ->d_want_unalias(alias, true) instead of ->d_unalias_trylock(alias)
and ->d_want_unalias(alias, false) instead of ->d_unalias_unlock(alias).
	Another possible variant would be to hold ->rename_sem exclusive
around d_splice_alias() calls in 9p ->lookup(), but that would cause a lot
of contention on that rwsem (every lookup rather than only ones that end
up with __d_unalias()) and rwsem is filesystem-wide.  Let's not go there.

