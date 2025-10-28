Return-Path: <linux-fsdevel+bounces-65850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D300C12759
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B728B587982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D82433CE89;
	Tue, 28 Oct 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qUrf3iVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A34219A8D;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612390; cv=none; b=oHYDdRcXYJcpkGeBdWMNujRMrnqZ6Spafjj5e+rQWj9UAlkSxgukiRuqn9lPABF/w6t9prk0M+rpNv/4GtT5DlG5mhi49uDbPl5YZBj9S3phEO9TUlVfmgbfXG5f035+jFlDrWFLbPuEDxYB1sd3COAlFq1WisZRVoFdSoBr/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612390; c=relaxed/simple;
	bh=VHOkmnB/9PvyDvO+O/Z+3Hjq56tQI29obEctBTT5G/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDvSHlH47CizLWXnbn4M+Mpr11bKYweD/mnZap9kIofDYl4Ejr3yyFAXE4FbWTS3So36hH5P1VbQqLrZJrNt9ui5DyDnrakwNReROgtYSMqLvS4Lh4vJE4k9jboqePA8gk4VE19eLr68LNcDc0oJr8J2kWISLYhZtlskqrre+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qUrf3iVC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5ME/pVGCOy0Jb+JLf9dI2yLeDW8cBFJkPzOSFDOyz5Y=; b=qUrf3iVC/Npnl6d73w47u6Oa4R
	zrqTPbfglbVdIPrJRfch5ExLovV2/DlgosTCty9ho+IPlLi36xdYFAMUD8O+hIokG1FBxTJBhOMxM
	MK0agSJv17yaf4uzQizZ1VLSLosYFLhXqOH1HnXRA3UlIUYbvuZWAfOC9IAcvHxLj2e9tkPi1EAQQ
	FLljTM38TFxZrY0t7yJcwPWrgjhW+stoRqLFC+AwOjP+jd4j+xPDV1soJFeHjKP9erbpKckHKmOw2
	/Y94OASfDqEiNUeT9ARs7217/wGzstPuPqW55J0f3HlnblUsip1rp1ieiOuvYuKQVdBkUNbdc36pG
	Y3DhNePQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqo-00000001eUb-1HIx;
	Tue, 28 Oct 2025 00:46:14 +0000
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
	bpf@vger.kernel.org
Subject: [PATCH v2 00/50] tree-in-dcache stuff
Date: Tue, 28 Oct 2025 00:45:19 +0000
Message-ID: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
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

Compared to v[1/50] 
	* fusectl nlink leak fix
	* selinuxfs stuff split
	* rpc_pipe conversion added
	* nfsctl conversion added
	* rust_binderfs conversion added
	* securityfs conversion added
	* now that the last users are converted, kill_litter_super() is gone.
	* tracefs leak fix in LOCKDOWN_TRACEFS case added.
	* shmem_{un,}link() makes use of simple_{un,}link() rather than
open-coding those.
	* killed securityfs_recursive_remove() - it's an unused alias for
securityfs_remove
	* configfs and apparmorfs switched away from calling simple_unlink()
and simple_rmdir(), allowing to make d_make_discardable() warn when given
a dentry that had not been marked persistent.

The branch is -rc3-based; it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.persistency
individual patches in followups.

Please, help with review and testing; it does appear to survive the local beating,
but extra eyes on it would be very welcome.

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
 arch/powerpc/platforms/cell/spufs/inode.c |  15 +--
 arch/s390/hypfs/hypfs.h                   |   6 +-
 arch/s390/hypfs/hypfs_diag_fs.c           |  60 ++++------
 arch/s390/hypfs/hypfs_vm_fs.c             |  21 ++--
 arch/s390/hypfs/inode.c                   |  82 +++++--------
 drivers/android/binder/rust_binderfs.c    | 121 ++++++-------------
 drivers/android/binderfs.c                |  82 +++----------
 drivers/base/devtmpfs.c                   |   2 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  24 ++--
 drivers/usb/gadget/function/f_fs.c        |  54 ++++-----
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
 53 files changed, 585 insertions(+), 806 deletions(-)

	Overview:

First two commits are bugfixes (fusectl and tracefs resp.)

[1/50] fuse_ctl_add_conn(): fix nlink breakage in case of early failure
[2/50] tracefs: fix a leak in eventfs_create_events_dir()

Next, two commits adding a couple of useful helpers, the next three adding
the infrastructure and the rest consists of per-filesystem conversions.

[3/50] new helper: simple_remove_by_name()
[4/50] new helper: simple_done_creating()
	end_creating_path() analogue for internal object creation; unlike
end_creating_path() no mount is passed to it (or guaranteed to exist, for
that matter - it might be used during the filesystem setup, before the
superblock gets attached to any mounts).

Infrastructure:
[5/50] introduce a flag for explicitly marking persistently pinned dentries
	* introduce the new flag
	* teach shrink_dcache_for_umount() to handle it (i.e. remove
and drop refcount on anything that survives to umount with that flag
still set)
	* teach kill_litter_super() that anything with that flag does
*not* need to be unpinned.
[6/50] primitives for maintaining persisitency
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

[7/50] convert simple_{link,unlink,rmdir,rename,fill_super}() to new primitives
	See above re quietly accepting non-peristent dentries in
simple_unlink(), simple_rmdir(), etc.

	Converting filesystems:
[8/50] convert ramfs and tmpfs
[9/50] procfs: make /self and /thread_self dentries persistent
[10/50] configfs, securityfs: kill_litter_super() not needed
[11/50] convert xenfs
[12/50] convert smackfs
[13/50] convert hugetlbfs
[14/50] convert mqueue
[15/50] convert bpf
[16/50] convert dlmfs
[17/50] convert fuse_ctl
[18/50] convert pstore
[19/50] convert tracefs
[20/50] convert debugfs
[21/50] debugfs: remove duplicate checks in callers of start_creating()
[22/50] convert efivarfs
[23/50] convert spufs
[24/50] convert ibmasmfs
[25/50] ibmasmfs: get rid of ibmasmfs_dir_ops
[26/50] convert devpts
[27/50] binderfs: use simple_start_creating()
[28/50] binderfs_binder_ctl_create(): kill a bogus check
[29/50] convert binderfs
[30/50] autofs_{rmdir,unlink}: dentry->d_fsdata->dentry == dentry there
[31/50] convert autofs
[32/50] convert binfmt_misc
[33/50] selinuxfs: don't stash the dentry of /policy_capabilities
[34/50] selinuxfs: new helper for attaching files to tree
[35/50] convert selinuxfs
[36/50] functionfs: switch to simple_remove_by_name()
[37/50] convert functionfs
[38/50] gadgetfs: switch to simple_remove_by_name()
[39/50] convert gadgetfs
[40/50] hypfs: don't pin dentries twice
[41/50] hypfs: switch hypfs_create_str() to returning int
[42/50] hypfs: swich hypfs_create_u64() to returning int
[43/50] convert hypfs
[44/50] convert rpc_pipefs
[45/50] convert nfsctl
[46/50] convert rust_binderfs

	... and no kill_litter_super() callers remain, so we
can take it out:
[47/50] get rid of kill_litter_super()
	
	Followups:
[48/50] convert securityfs
	That was the last remaining user of simple_recursive_removal()
that did *not* mark things persistent.  Now the only places where
d_make_discardable() is still called for dentries that are not marked
persistent are the calls of simple_{unlink,rmdir}() in configfs and
apparmorfs.

[49/50] kill securityfs_recursive_remove()
	Unused macro...

[50/50] d_make_discardable(): warn if given a non-persistent dentry

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

-- 
2.47.3


