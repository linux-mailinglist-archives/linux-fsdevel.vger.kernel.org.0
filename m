Return-Path: <linux-fsdevel+bounces-1372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604747D9B73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835641C210B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F95374D7;
	Fri, 27 Oct 2023 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qePow6h6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F233374D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3C5C433C7;
	Fri, 27 Oct 2023 14:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698417063;
	bh=JYQ1485ecBidH5KSEpi5oHr1PrJU9Tal5XPzYUOFl2g=;
	h=From:To:Cc:Subject:Date:From;
	b=qePow6h6E0Mg0JTmplXfP1n5tl41zPyBvs2B+a1eQKi5UJHDO/rngUDh8+NVWOg6d
	 qT+tYx9RwmggP9XYTNqqqed69hpT8qz5IawjivyiJHHesNf8P5DUnb67Bc07exz3ee
	 tuDlCRmjosEWk+YyuUGwQmW9MzuljWgr20IthywAxTIu/tYdb3ECZ/KVglRnafXKFW
	 gtGXOGpKnIVzptPScSQuP7RpBlZ6CoHOP5BS9nvFvBmCUVORouHSTOcl58TfVjVUPo
	 INHdlZusUNPQVh6p88fdiqFP7jlSw8YsptFSXptNY4QN9zKSzkoWpFxWGOiXr+trO3
	 X99y2q//AHEqA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] vfs misc updates
Date: Fri, 27 Oct 2023 16:30:46 +0200
Message-Id: <20231027-vfs-misc-7ebef2b5a462@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11286; i=brauner@kernel.org; h=from:subject:message-id; bh=JYQ1485ecBidH5KSEpi5oHr1PrJU9Tal5XPzYUOFl2g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRan4xX/2h1Irbu2sbmDrYy5mr1pORvnNVuxo9btjceViv7 sbqxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLvCxj+cIXWquhxezpumt/J+OvyP5 mE2I1VqrPPLO76srHqsGbCXYbfrKYfF8X2WHNWLb6uvJDHgOnu5Fn5xwSrvp40PTT5eNhCRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual miscellaneous features, cleanups, and fixes for
vfs and individual fses.

Features
========

* Rename and export helpers that get write access to a mount. They are
  used in overlayfs to get write access to the upper mount.
* Print the pretty name of the root device on boot failure. This helps
  in scenarios where we would usually only print "unknown-block(1,2)".
* Add an internal SB_I_NOUMASK flag. This is another part in the endless
  POSIX ACL saga in a way.

  When POSIX ACLs are enabled via SB_POSIXACL the vfs cannot strip the
  umask because if the relevant inode has POSIX ACLs set it might take
  the umask from there. But if the inode doesn't have any POSIX ACLs
  set then we apply the umask in the filesytem itself. So we end up with:

  (1) no SB_POSIXACL -> strip umask in vfs
  (2) SB_POSIXACL    -> strip umask in filesystem

  The umask semantics associated with SB_POSIXACL allowed filesystems
  that don't even support POSIX ACLs at all to raise SB_POSIXACL purely
  to avoid umask stripping. That specifically means NFS v4 and
  Overlayfs. NFS v4 does it because it delegates this to the server and
  Overlayfs because it needs to delegate umask stripping to the upper
  filesystem, i.e., the filesystem used as the writable layer.

  This went so far that SB_POSIXACL is raised eve on kernels that don't
  even have POSIX ACL support at all.

  Stop this blatant abuse and add SB_I_NOUMASK which is an internal
  superblock flag that filesystems can raise to opt out of umask
  handling. That should really only be the two mentioned above. It's not
  that we want any filesystems to do this. Ideally we have all umask
  handling always in the vfs.
* Make overlayfs use SB_I_NOUMASK too.
* Now that we have SB_I_NOUMASK, stop checking for SB_POSIXACL in
  IS_POSIXACL() if the kernel doesn't have support for it. This is a
  very old patch but it's only possible to do this now with the wider
  cleanup that was done.
* Follow-up work on fake path handling from last cycle. Citing mostly
  from Amir:

  When overlayfs was first merged, overlayfs files of regular files and
  directories, the ones that are installed in file table, had a "fake"
  path, namely, f_path is the overlayfs path and f_inode is the "real"
  inode on the underlying filesystem.

  In v6.5, we took another small step by introducing of the backing_file
  container and the file_real_path() helper.  This change allowed vfs
  and filesystem code to get the "real" path of an overlayfs backing
  file. With this change, we were able to make fsnotify work correctly
  and report events on the "real" filesystem objects that were accessed
  via overlayfs.

  This method works fine, but it still leaves the vfs vulnerable to new
  code that is not aware of files with fake path.  A recent example is
  commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
  i_version"). This commit uses direct referencing to f_path in IMA code
  that otherwise uses file_inode() and file_dentry() to reference the
  filesystem objects that it is measuring.

  This pull request contains work to switch things around: instead of
  having filesystem code opt-in to get the "real" path, have generic
  code opt-in for the "fake" path in the few places that it is needed.

  Is it far more likely that new filesystems code that does not use the
  file_dentry() and file_real_path() helpers will end up causing crashes
  or averting LSM/audit rules if we keep the "fake" path exposed by
  default.

  This change already makes file_dentry() moot, but for now we did not
  change this helper just added a WARN_ON() in ovl_d_real() to catch if
  we have made any wrong assumptions.

  After the dust settles on this change, we can make file_dentry() a
  plain accessor and we can drop the inode argument to ->d_real().
* Switch struct file to SLAB_TYPESAFE_BY_RCU. This looks
  like a small change but it really isn't and I would like to see
  everyone on their tippie toes for any possible bugs from this work.

  Essentially we've been doing most of what SLAB_TYPESAFE_BY_RCU for
  files since a very long time because of the nasty interactions between
  the SCM_RIGHTS file descriptor garbage collection. So extending it
  makes a lot of sense but it is a subtle change. There are almost no
  places that fiddle with file rcu semantics directly and the ones that
  did mess around with struct file internal under rcu have been made to
  stop doing that because it really was always dodgy.

  I forgot to put in the link tag for this change and the
  discussion in the commit so adding it into the merge message:
  https://lore.kernel.org/r/20230926162228.68666-1-mjguzik@gmail.com

Cleanups
========

* Various smaller pipe cleanups including the removal of a spin lock
  that was only used to protect against writes without pipe_lock() from
  O_NOTIFICATION_PIPE aka watch queues. As that was never implemented
  remove the additional locking from pipe_write().
* Annotate struct watch_filter with the new __counted_by attribute.
* Clarify do_unlinkat() cleanup so that it doesn't look like an extra
  iput() is done that would cause issues.
* Simplify file cleanup when the file has never been opened.
* Use module helper instead of open-coding it.
* Predict error unlikely for stale retry.
* Use WRITE_ONCE() for mount expiry field instead of just commenting
  that one hopes the compiler doesn't get smart.

Fixes
=====

* Fix readahead on block devices.
* Fix writeback when layztime is enabled and inodes whose timestamp is
  the only thing that changed reside on wb->b_dirty_time. This caused
  excessively large zombie memory cgroup when lazytime was enabled as
  such inodes weren't handled fast enough.
* Convert BUG_ON() to WARN_ON_ONCE() in open_last_lookups().

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

## Merge Conflicts with other trees

[1] linux-next: manual merge of the integrity tree with the vfs-brauner tree
    https://lore.kernel.org/r/20231027131137.3051da98@canb.auug.org.au

At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.misc

for you to fetch changes up to 61d4fb0b349ec1b33119913c3b0bd109de30142c:

  file, i915: fix file reference for mmap_singleton() (2023-10-25 22:17:04 +0200)

Please consider pulling these changes from the signed vfs-6.7.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.misc

----------------------------------------------------------------
Amir Goldstein (5):
      fs: rename __mnt_{want,drop}_write*() helpers
      fs: export mnt_{get,put}_write_access() to modules
      fs: get mnt_writers count for an open backing file's real path
      fs: create helper file_user_path() for user displayed mapped file path
      fs: store real path instead of fake path in backing file f_path

Bernd Schubert (1):
      vfs: Convert BUG_ON to WARN_ON_ONCE in open_last_lookups

Christian Brauner (5):
      file: convert to SLAB_TYPESAFE_BY_RCU
      io_uring: use files_lookup_fd_locked()
      backing file: free directly
      ovl: rely on SB_I_NOUMASK
      file, i915: fix file reference for mmap_singleton()

Jeff Layton (1):
      fs: add a new SB_I_NOUMASK flag

Jianyong Wu (1):
      init/mount: print pretty name of root device when panics

Jingbo Xu (1):
      writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs

Kees Cook (1):
      watch_queue: Annotate struct watch_filter with __counted_by

Luís Henriques (1):
      fs: simplify misleading code to remove ambiguity regarding ihold()/iput()

Mateusz Guzik (3):
      vfs: shave work on failed file open
      vfs: predict the error in retry_estale as unlikely
      vfs: stop counting on gcc not messing with mnt_expiry_mark if not asked

Max Kellermann (5):
      pipe: reduce padding in struct pipe_inode_info
      fs/pipe: move check to pipe_has_watch_queue()
      fs/pipe: remove unnecessary spinlock from pipe_write()
      fs/pipe: use spinlock in pipe_read() only if there is a watch_queue
      fs: fix umask on NFS with CONFIG_FS_POSIX_ACL=n

Reuben Hawkins (1):
      vfs: fix readahead(2) on block devices

Uwe Kleine-König (1):
      chardev: Simplify usage of try_module_get()

 Documentation/filesystems/files.rst          |  53 +++++-----
 arch/arc/kernel/troubleshoot.c               |   6 +-
 arch/powerpc/platforms/cell/spufs/coredump.c |  11 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c     |   6 +-
 fs/char_dev.c                                |   2 +-
 fs/file.c                                    | 153 +++++++++++++++++++++++----
 fs/file_table.c                              |  49 +++++----
 fs/fs-writeback.c                            |  41 ++++---
 fs/gfs2/glock.c                              |  11 +-
 fs/init.c                                    |   6 +-
 fs/inode.c                                   |   8 +-
 fs/internal.h                                |  22 ++--
 fs/namei.c                                   |  31 ++----
 fs/namespace.c                               |  40 +++----
 fs/nfs/super.c                               |   2 +-
 fs/notify/dnotify/dnotify.c                  |   6 +-
 fs/open.c                                    |  52 ++++++---
 fs/overlayfs/super.c                         |  24 ++++-
 fs/pipe.c                                    |  64 ++++++-----
 fs/proc/base.c                               |   2 +-
 fs/proc/fd.c                                 |  11 +-
 fs/proc/nommu.c                              |   2 +-
 fs/proc/task_mmu.c                           |   4 +-
 fs/proc/task_nommu.c                         |   2 +-
 include/linux/fdtable.h                      |  17 +--
 include/linux/fs.h                           |  35 +++---
 include/linux/fsnotify.h                     |   3 +-
 include/linux/mount.h                        |   4 +-
 include/linux/namei.h                        |  26 ++++-
 include/linux/pipe_fs_i.h                    |  22 +++-
 include/linux/watch_queue.h                  |   2 +-
 init/do_mounts.c                             |   2 +-
 io_uring/openclose.c                         |   9 +-
 kernel/acct.c                                |   4 +-
 kernel/bpf/task_iter.c                       |   4 +-
 kernel/fork.c                                |   4 +-
 kernel/kcmp.c                                |   4 +-
 kernel/trace/trace_output.c                  |   2 +-
 mm/readahead.c                               |   3 +-
 39 files changed, 479 insertions(+), 270 deletions(-)

