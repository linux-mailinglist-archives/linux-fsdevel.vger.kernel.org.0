Return-Path: <linux-fsdevel+bounces-62276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F8B8C181
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491C55851FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8C26F2BE;
	Sat, 20 Sep 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VdNrb6s7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FCA55;
	Sat, 20 Sep 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354128; cv=none; b=Fiu/omP3tgv0i0UH7ExnzxA1xY+uofU5wY/TDk15IJZj0+4DNjSQCSnxPvaWUtkYi2IFnD6eR9qQW4M+ZD9wd2RRLM2A7aGG6nj86BSw+w+jMBtgdPJ+S6T/qRjlDByf0Li/UfQSXy+d7eDF1NCT7svFy5RPDO9Nj7vju4ZUf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354128; c=relaxed/simple;
	bh=A3huVRc6A2csEyMmMgXe98OEaz3Ab/XmeK1z1R3vyZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jQirpKwt2Y/upcD9p7OjE+xyt5l99w5o1AEra5KkF+2GCAgU7WYlEJhWOv/vnMl2IZkPbs8CUqtrbwBmSZWKBIlDU+xcEZS+5jrsR0nVziU4OC8LqCj3VCn0Pu2fYal3d9RprXodgf6QBpeSDNEf4NzD6LvcLAelWPWllps+gJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VdNrb6s7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Description:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:In-Reply-To:References;
	bh=oOCcbpCsT+zvuGsYMYIhlU7EGFEAzg77GcV6TXrg+wI=; b=VdNrb6s7Ppzquet+fhlCfW7h+O
	U02VJRZD01jqmmWq8luID9ZxhvGVspUTY4nW/p8P6sydj6Fh/zdOxwlaySXBB2o8ahurxu8m3/ZBq
	bg/bnm5KYL9Pe7gXJDeBPNWwS6t00mVZfB9upTq6q1l9AAEuvMS/3se6NUNTC2v1b96pRaz32ogAB
	IZjAmCZrj2r2JFuJznwECCDmp7ubClVul7WeFcbIJOo983wNLuGkwdTeAIPXqQWnQwLvqtlx4O/sb
	AVqVl+vJtVbzTxrgkAWWDpl7EQYGAK9TNIGABimVcXzMRVynmmmX5N9Gzbv0/5Y1DH2CzzML2Cfvk
	fzPQ7s5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsEG-0000000Euuv-3pwa;
	Sat, 20 Sep 2025 07:41:57 +0000
Date: Sat, 20 Sep 2025 08:41:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCHES][RFC] the meat of tree-in-dcache series
Message-ID: <20250920074156.GK39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: reas Hindborg <a.hindborg@kernel.org>, linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, Kees Cook <kees@
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[my apologies for the size of patchbomb and the size of Cc; this series
really affects a lot of places, if lightly]

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

The branch is -rc5-based; it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.persistency
individual patches in followups.

Please, help with review and testing; it does appear to survive the local beating,
but extra eyes on it would be very welcome.

First two commits add a couple of useful helpers, the next three add the
infrastructure and the rest consists of per-filesystem conversions.

Shortlog:
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
      convert selinuxfs
      functionfs: switch to simple_remove_by_name()
      convert functionfs
      gadgetfs: switch to simple_remove_by_name()
      convert gadgetfs
      hypfs: don't pin dentries twice
      hypfs: switch hypfs_create_str() to returning int
      hypfs: swich hypfs_create_u64() to returning int
      convert hypfs

Diffstat:
 arch/powerpc/platforms/cell/spufs/inode.c | 15 ++---
 arch/s390/hypfs/hypfs.h                   |  6 +-
 arch/s390/hypfs/hypfs_diag_fs.c           | 60 +++++++-------------
 arch/s390/hypfs/hypfs_vm_fs.c             | 21 +++----
 arch/s390/hypfs/inode.c                   | 82 +++++++++------------------
 drivers/android/binderfs.c                | 82 +++++++--------------------
 drivers/base/devtmpfs.c                   |  2 +-
 drivers/misc/ibmasm/ibmasmfs.c            | 24 ++++----
 drivers/usb/gadget/function/f_fs.c        | 54 ++++++++----------
 drivers/usb/gadget/legacy/inode.c         | 49 ++++++++--------
 drivers/xen/xenfs/super.c                 |  2 +-
 fs/autofs/inode.c                         |  2 +-
 fs/autofs/root.c                          | 11 ++--
 fs/binfmt_misc.c                          | 69 +++++++++++------------
 fs/configfs/mount.c                       |  2 +-
 fs/dcache.c                               | 93 ++++++++++++++++++++++++-------
 fs/debugfs/inode.c                        | 32 +++--------
 fs/devpts/inode.c                         | 57 +++++++------------
 fs/efivarfs/inode.c                       |  7 +--
 fs/efivarfs/super.c                       |  5 +-
 fs/fuse/control.c                         | 19 ++++---
 fs/hugetlbfs/inode.c                      | 12 ++--
 fs/libfs.c                                | 31 +++++++++--
 fs/ocfs2/dlmfs/dlmfs.c                    |  8 +--
 fs/proc/base.c                            |  6 +-
 fs/proc/internal.h                        |  1 +
 fs/proc/root.c                            | 14 ++---
 fs/proc/self.c                            | 10 +---
 fs/proc/thread_self.c                     | 11 +---
 fs/pstore/inode.c                         |  7 ++-
 fs/ramfs/inode.c                          |  8 +--
 fs/tracefs/event_inode.c                  |  4 +-
 fs/tracefs/inode.c                        | 13 ++---
 include/linux/dcache.h                    |  3 +
 include/linux/fs.h                        |  3 +
 include/linux/proc_fs.h                   |  2 -
 init/do_mounts.c                          |  2 +-
 ipc/mqueue.c                              | 12 +---
 kernel/bpf/inode.c                        | 15 ++---
 mm/shmem.c                                | 23 ++------
 security/inode.c                          |  2 +-
 security/selinux/selinuxfs.c              | 52 +++++++++--------
 security/smack/smackfs.c                  |  2 +-
 43 files changed, 412 insertions(+), 523 deletions(-)

