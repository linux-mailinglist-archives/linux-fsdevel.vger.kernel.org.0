Return-Path: <linux-fsdevel+bounces-68847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A1C678B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080F34F2608
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C202FB095;
	Tue, 18 Nov 2025 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L2YBNssu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E72522B6;
	Tue, 18 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442978; cv=none; b=KPjKjnzkL7AgQvRCMeYv4PcTriLrSlP3gWak+KR84T4ESQAkjtecnKZSHv/wDbZwUkFGdLnFZ3r9OIsM02WEQtX1lJumuFR66+oj9J85HStBwbdKi6u5a9OWPdA7DqmUj+7hWFIjXbv50vX0ogAquNPnEKmDHxvZeKIYRHZyLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442978; c=relaxed/simple;
	bh=Fna6KaG3eiiCvByV9iOlrjxJWveUcPYAe/yIgBGRTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grsJ1pq3W2e64epAz9AvFu32Sp+1AYUP8AEub2puUy2kICOLu2uD4qR2BhiI+JnEmyRjAu45HLe5Al5YlIJ2pc/+WncgnTIlDZlns+EGbGdTmQQos0uFYE+m94sqoovQ7y7d1HM68I15GkiUqowgsmt/CXlSORPbJVp9lClGy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L2YBNssu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Wk0cJUyWrg1Q2BlOVZqE6LE8f2oIgwbaaPLwX7j5Zz0=; b=L2YBNssuhAbD/coTE+zppD6pgG
	4SHEnV/kIGVlfWZ/qJcm+mD7nBTcUj5u3PTUqaT11eNiFSt/eQjg53/kO2xAH3TAX1K+ir2dHsN/W
	+V2PSQeCGsk5NCmFRrEceu48UcS3G7dNw05gFfDQD/LGLbv3GTZ8U6VquIrxRziO0egZlUY5wvf+7
	rSHx7tdBjJILDSiZ9Nq7Zbb8qz3qlP5vEyyl8YxzfhzblHJlTb9Xjll2P9yAVRvIGhrorVG7e2mAe
	gwzXte4nPeA0zgOAP42jxne/BSzms8NV7fAnYjOgsWD9EXBqwRr1k3J2CvzlJ3gfHFtZK2D4YIPpB
	GKZnts7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4S-0000000GEPJ-3281;
	Tue, 18 Nov 2025 05:16:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 00/54] tree-in-dcache stuff
Date: Tue, 18 Nov 2025 05:15:09 +0000
Message-ID: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Some filesystems use a kinda-sorta controlled dentry refcount leak to pin
dentries of created objects in dcache (and undo it when removing those).
Reference is grabbed and not released, but it's not actually _stored_
anywhere.  That works, but it's hard to follow and verify; among other
things, we have no way to tell _which_ of the increments is intended
to be an unpaired one.  Worse, on removal we need to decide whether
the reference had already been dropped, which can be non-trivial if
that removal is on umount and we need to figure out if this dentry is
pinned due to e.g. unlink() not done.  Usually that is handled by using
kill_litter_super() as ->kill_sb(), but there are open-coded special
cases of the same (consider e.g. /proc/self).

Things get simpler if we introduce a new dentry flag (DCACHE_PERSISTENT)
marking those "leaked" dentries.  Having it set claims responsibility
for +1 in refcount.

The end result this series is aiming for:

* get these unbalanced dget() and dput() replaced with new primitives that
  would, in addition to adjusting refcount, set and clear persistency flag.
* instead of having kill_litter_super() mess with removing the remaining
  "leaked" references (e.g. for all tmpfs files that hadn't been removed
  prior to umount), have the regular shrink_dcache_for_umount() strip
  DCACHE_PERSISTENT of all dentries, dropping the corresponding
  reference if it had been set.  After that kill_litter_super() becomes
  an equivalent of kill_anon_super().

Doing that in a single step is not feasible - it would affect too many places
in too many filesystems.  It has to be split into a series.

This work has really started early in 2024; quite a few preliminary pieces
have already gone into mainline.  This chunk is finally getting to the
meat of that stuff - infrastructure and most of the conversions to it.

Some pieces are still sitting in the local branches, but the bulk of
that stuff is here.

Compared to v3:
	* fixed a functionfs braino around ffs_epfiles_destroy() (in #40/54,
used to be #36/50).
	* added fixes for a couple of UAF in functionfs (##36--39); that
does *NOT* include any fixes for dmabuf bugs Chris posted last week, though.

The branch is -rc5-based; it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.persistency
individual patches in followups.

Please, help with review and testing.  If nobody objects, in a few days it
goes into #for-next.

Shortlog:
      fuse_ctl_add_conn(): fix nlink breakage in case of early failure
      tracefs: fix a leak in eventfs_create_events_dir()
      new helper: simple_remove_by_name()
      new helper: simple_done_creating()
      introduce a flag for explicitly marking persistently pinned dentries
      primitives for maintaining persisitency
      convert simple_{link,unlink,rmdir,rename,fill_super}() to new primitives
      convert ramfs and tmpfs
      procfs: make /self and /thread_self dentries persistent
      configfs, securityfs: kill_litter_super() not needed
      convert xenfs
      convert smackfs
      convert hugetlbfs
      convert mqueue
      convert bpf
      convert dlmfs
      convert fuse_ctl
      convert pstore
      convert tracefs
      convert debugfs
      debugfs: remove duplicate checks in callers of start_creating()
      convert efivarfs
      convert spufs
      convert ibmasmfs
      ibmasmfs: get rid of ibmasmfs_dir_ops
      convert devpts
      binderfs: use simple_start_creating()
      binderfs_binder_ctl_create(): kill a bogus check
      convert binderfs
      autofs_{rmdir,unlink}: dentry->d_fsdata->dentry == dentry there
      convert autofs
      convert binfmt_misc
      selinuxfs: don't stash the dentry of /policy_capabilities
      selinuxfs: new helper for attaching files to tree
      convert selinuxfs
      functionfs: don't abuse ffs_data_closed() on fs shutdown
      functionfs: don't bother with ffs->ref in ffs_data_{opened,closed}()
      functionfs: need to cancel ->reset_work in ->kill_sb()
      functionfs: fix the open/removal races
      functionfs: switch to simple_remove_by_name()
      convert functionfs
      gadgetfs: switch to simple_remove_by_name()
      convert gadgetfs
      hypfs: don't pin dentries twice
      hypfs: switch hypfs_create_str() to returning int
      hypfs: swich hypfs_create_u64() to returning int
      convert hypfs
      convert rpc_pipefs
      convert nfsctl
      convert rust_binderfs
      get rid of kill_litter_super()
      convert securityfs
      kill securityfs_recursive_remove()
      d_make_discardable(): warn if given a non-persistent dentry

Diffstat:
 Documentation/filesystems/porting.rst     |   7 ++
 arch/powerpc/platforms/cell/spufs/inode.c |  17 ++-
 arch/s390/hypfs/hypfs.h                   |   6 +-
 arch/s390/hypfs/hypfs_diag_fs.c           |  60 ++++------
 arch/s390/hypfs/hypfs_vm_fs.c             |  21 ++--
 arch/s390/hypfs/inode.c                   |  82 +++++--------
 drivers/android/binder/rust_binderfs.c    | 121 ++++++-------------
 drivers/android/binderfs.c                |  82 +++----------
 drivers/base/devtmpfs.c                   |   2 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  24 ++--
 drivers/usb/gadget/function/f_fs.c        | 144 +++++++++++++----------
 drivers/usb/gadget/legacy/inode.c         |  49 ++++----
 drivers/xen/xenfs/super.c                 |   2 +-
 fs/autofs/inode.c                         |   2 +-
 fs/autofs/root.c                          |  11 +-
 fs/binfmt_misc.c                          |  69 ++++++-----
 fs/configfs/dir.c                         |  10 +-
 fs/configfs/inode.c                       |   3 +-
 fs/configfs/mount.c                       |   2 +-
 fs/dcache.c                               | 111 +++++++++++-------
 fs/debugfs/inode.c                        |  32 ++----
 fs/devpts/inode.c                         |  57 ++++-----
 fs/efivarfs/inode.c                       |   7 +-
 fs/efivarfs/super.c                       |   5 +-
 fs/fuse/control.c                         |  38 +++---
 fs/hugetlbfs/inode.c                      |  12 +-
 fs/internal.h                             |   1 -
 fs/libfs.c                                |  52 +++++++--
 fs/nfsd/nfsctl.c                          |  18 +--
 fs/ocfs2/dlmfs/dlmfs.c                    |   8 +-
 fs/proc/base.c                            |   6 +-
 fs/proc/internal.h                        |   1 +
 fs/proc/root.c                            |  14 +--
 fs/proc/self.c                            |  10 +-
 fs/proc/thread_self.c                     |  11 +-
 fs/pstore/inode.c                         |   7 +-
 fs/ramfs/inode.c                          |   8 +-
 fs/super.c                                |   8 --
 fs/tracefs/event_inode.c                  |   7 +-
 fs/tracefs/inode.c                        |  13 +--
 include/linux/dcache.h                    |   4 +-
 include/linux/fs.h                        |   6 +-
 include/linux/proc_fs.h                   |   2 -
 include/linux/security.h                  |   2 -
 init/do_mounts.c                          |   2 +-
 ipc/mqueue.c                              |  12 +-
 kernel/bpf/inode.c                        |  15 +--
 mm/shmem.c                                |  38 ++----
 net/sunrpc/rpc_pipe.c                     |  27 ++---
 security/apparmor/apparmorfs.c            |  13 ++-
 security/inode.c                          |  35 +++---
 security/selinux/selinuxfs.c              | 185 +++++++++++++-----------------
 security/smack/smackfs.c                  |   2 +-
 53 files changed, 649 insertions(+), 834 deletions(-)

	Overview:

First two commits are bugfixes (fusectl and tracefs resp.)

[1/54] fuse_ctl_add_conn(): fix nlink breakage in case of early failure
[2/54] tracefs: fix a leak in eventfs_create_events_dir()

Next, two commits adding a couple of useful helpers, the next three adding
the infrastructure and the rest consists of per-filesystem conversions.

[3/54] new helper: simple_remove_by_name()
[4/54] new helper: simple_done_creating()
	end_creating_path() analogue for internal object creation; unlike
end_creating_path() no mount is passed to it (or guaranteed to exist, for
that matter - it might be used during the filesystem setup, before the
superblock gets attached to any mounts).

Infrastructure:
[5/54] introduce a flag for explicitly marking persistently pinned dentries
	* introduce the new flag
	* teach shrink_dcache_for_umount() to handle it (i.e. remove
and drop refcount on anything that survives to umount with that flag
still set)
	* teach kill_litter_super() that anything with that flag does
*not* need to be unpinned.
[6/54] primitives for maintaining persisitency
	* d_make_persistent(dentry, inode) - bump refcount, mark persistent
and make hashed positive.  Return value is a borrowed reference to dentry;
it can be used until something removes persistency (at the very least,
until the parent gets unlocked, but some filesystems may have stronger
exclusion).
	* d_make_discardable() - remove persistency mark and drop reference.

NOTE: at that stage d_make_discardable() does not reject dentries not
marked persistent - it acts as if the mark been set.

Rationale: less noise in series splitup that way.  We want (and on the
next commit will get) simple_unlink() to do the right thing - remove
persistency, if it's there.  However, it's used by many filesystems.
We would have either to convert them all at once or split simple_unlink()
into "want persistent" and "don't want persistent" versions, the latter
being the old one.  In the course of the series almost all callers
would migrate to the replacement, leaving only two pathological cases
with the old one.  The same goes for simple_rmdir() (two callers left in
the end), simple_recursive_removal() (all callers gone in the end), etc.
That's a lot of noise and it's easier to start with d_make_discardable()
quietly accepting non-persistent dentries, then, in the end, add private
copies of simple_unlink() and simple_rmdir() for two weird users (configfs
and apparmorfs) and have those use dput() instead of d_make_discardable().
At that point we'd be left with all callers of d_make_discardable()
always passing persistent dentries, allowing to add a warning in it.

[7/54] convert simple_{link,unlink,rmdir,rename,fill_super}() to new primitives
	See above re quietly accepting non-peristent dentries in
simple_unlink(), simple_rmdir(), etc.

	Converting filesystems:
[8/54] convert ramfs and tmpfs
[9/54] procfs: make /self and /thread_self dentries persistent
[10/54] configfs, securityfs: kill_litter_super() not needed
[11/54] convert xenfs
[12/54] convert smackfs
[13/54] convert hugetlbfs
[14/54] convert mqueue
[15/54] convert bpf
[16/54] convert dlmfs
[17/54] convert fuse_ctl
[18/54] convert pstore
[19/54] convert tracefs
[20/54] convert debugfs
[21/54] debugfs: remove duplicate checks in callers of start_creating()
[22/54] convert efivarfs
[23/54] convert spufs
[24/54] convert ibmasmfs
[25/54] ibmasmfs: get rid of ibmasmfs_dir_ops
[26/54] convert devpts
[27/54] binderfs: use simple_start_creating()
[28/54] binderfs_binder_ctl_create(): kill a bogus check
[29/54] convert binderfs
[30/54] autofs_{rmdir,unlink}: dentry->d_fsdata->dentry == dentry there
[31/54] convert autofs
[32/54] convert binfmt_misc
[33/54] selinuxfs: don't stash the dentry of /policy_capabilities
[34/54] selinuxfs: new helper for attaching files to tree
[35/54] convert selinuxfs

	Several functionfs fixes, before converting it, to make life
simpler for backporting:
[36/54] functionfs: don't abuse ffs_data_closed() on fs shutdown
[37/54] functionfs: don't bother with ffs->ref in ffs_data_{opened,closed}()
[38/54] functionfs: need to cancel ->reset_work in ->kill_sb()
[39/54] functionfs: fix the open/removal races

	... and back to filesystems conversions:

[40/54] functionfs: switch to simple_remove_by_name()
[41/54] convert functionfs
[42/54] gadgetfs: switch to simple_remove_by_name()
[43/54] convert gadgetfs
[44/54] hypfs: don't pin dentries twice
[45/54] hypfs: switch hypfs_create_str() to returning int
[46/54] hypfs: swich hypfs_create_u64() to returning int
[47/54] convert hypfs
[48/54] convert rpc_pipefs
[49/54] convert nfsctl
[50/54] convert rust_binderfs

	... and no kill_litter_super() callers remain, so we
can take it out:
[51/54] get rid of kill_litter_super()
	
	Followups:
[52/54] convert securityfs
	That was the last remaining user of simple_recursive_removal()
that did *not* mark things persistent.  Now the only places where
d_make_discardable() is still called for dentries that are not marked
persistent are the calls of simple_{unlink,rmdir}() in configfs and
apparmorfs.

[53/54] kill securityfs_recursive_remove()
	Unused macro...

[54/54] d_make_discardable(): warn if given a non-persistent dentry

At this point there are very few call chains that might lead to
d_make_discardable() on a dentry that hadn't been made persistent:
calls of simple_unlink() and simple_rmdir() in configfs and
apparmorfs.

Both filesystems do pin (part of) their contents in dcache, but
they are currently playing very unusual games with that.  Converting
them to more usual patterns might be possible, but it's definitely
going to be a long series of changes in both cases.

For now the easiest solution is to have both stop using simple_unlink()
and simple_rmdir() - that allows to make d_make_discardable() warn
when given a non-persistent dentry.

Rather than giving them full-blown private copies (with calls of
d_make_discardable() replaced with dput()), let's pull the parts of
simple_unlink() and simple_rmdir() that deal with timestamps and link
counts into separate helpers (__simple_unlink() and __simple_rmdir()
resp.) and have those used by configfs and apparmorfs.


