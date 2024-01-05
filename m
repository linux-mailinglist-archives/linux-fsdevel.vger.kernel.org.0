Return-Path: <linux-fsdevel+bounces-7461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62E825362
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64A6B23242
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959B2D602;
	Fri,  5 Jan 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANvuD82K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7B2D039;
	Fri,  5 Jan 2024 12:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EEBC433C7;
	Fri,  5 Jan 2024 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704458123;
	bh=5J1KJXZRdraMu6G/CHVh6lUfcT7m4APQO55yTGNmOwc=;
	h=From:To:Cc:Subject:Date:From;
	b=ANvuD82KGuXpo5gASm7IarTvHyUW+bIuTX/iB7qp//LJRjqc2Si+9r2bZNMZEWKmL
	 d+QvEvRKsrosm7gViKH1kr2antmzFKUnX0dWLwVCmp9yUDu9JLUzeDK5nuy1/+m3ZD
	 OOY1RF8kUGCQAenVJUMw0cVq/o8o8lN1FdpYDCqhV6iCsRWkdBPMf1HdPK6t8wIo0h
	 pyVHQ9czwUzG+EeZvTJCeKwhDk/DlTOl2zbppB8BkmYlNYOHix+O8Ztx9dYRIrcoug
	 fQYfeLudyeb9YHDUcn7lYuPS6a6SYsKmW397tX+HZkmd9xjnc2Lm8DSHFoYnNQrZPk
	 W55gbSB+ToBmQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc updates
Date: Fri,  5 Jan 2024 13:35:05 +0100
Message-ID: <20240105-vfs-misc-62acb84c5066@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11449; i=brauner@kernel.org; h=from:subject:message-id; bh=5J1KJXZRdraMu6G/CHVh6lUfcT7m4APQO55yTGNmOwc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRO/14xoXj1pWlbcpymVqq91ClrtVi7O0how+M+9wcxD /hes79h6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI9bmMDBNjizZf31r9N/rt 3oe3aua1q/FtYT23L4hPj6mFu6ep0pGRYY2PZaqZ6OscA4sNekJpk+a0zLpVc13Kt//xzbdGjDU HuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual miscellaneous features, cleanups, and fixes for vfs and
individual fses. The vfs.file branch merged into here has also been merged into
io_uring which depends on it.

Features
========

* Add Jan Kara as VFS reviewer.
* Show correct device and inode numbers in proc/<pid>/maps for vma files on
  stacked filesystems. This is now easily doable thanks to the backing file
  work from the last cycles. This comes with selftests.

Cleanups
========

* Remove a redundant might_sleep() from wait_on_inode().
* Initialize pointer with NULL, not 0.
* Clarify comment on access_override_creds().
* Rework and simplify eventfd_signal() and eventfd_signal_mask() helpers.
* Process aio completions in batches to avoid needless wakeups.
* Completely decouple struct mnt_idmap from namespaces. We now only keep the
  actual idmapping around and don't stash references to namespaces.
* Reformat maintainer entries to indicate that a given subsystem belongs to fs/.
* Simplify fput() for files that were never opened.
* Get rid of various pointless file helpers.
* Rename various file helpers.
* Rename struct file members after SLAB_TYPESAFE_BY_RCU switch from last cycle.
* Make relatime_need_update() return bool.
* Use GFP_KERNEL instead of GFP_USER when allocating superblocks.
* Replace deprecated ida_simple_*() calls with their current ida_*() counterparts.

Fixes
=====

* Fix comments on user namespace id mapping helpers. They aren't kernel doc
  comments so they shouldn't be using /**.
* s/Retuns/Returns/g in various places.
* Add missing parameter documentation on can_move_mount_beneath().
* Rename i_mapping->private_data to i_mapping->i_private_data.
* Fix a false-positive lockdep warning in pipe_write() for watch queues.
* Improve __fget_files_rcu() code generation to improve performance.
* Only notify writer that pipe resizing has finished after setting
  pipe->max_usage otherwise writers are never notified that the pipe has been
  resized and hang.
* Fix some kernel docs in hfsplus.
* s/passs/pass/g in various places.
* Fix kernel docs in ntfs.
* Fix kcalloc() arguments order reported by gcc 14.
* Fix uninitialized value in reiserfs.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the vfs-brauner tree with the mm tree
    https://lore.kernel.org/linux-next/20231122103119.34d23955@canb.auug.org.au

[2] linux-next: manual merge of the vfs-brauner tree with the btrfs tree
    https://lore.kernel.org/linux-next/20231127091437.4062f96c@canb.auug.org.au

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.misc

for you to fetch changes up to dd8f87f21dc3da2eaf46e7401173f935b90b13a8:

  reiserfs: fix uninit-value in comp_keys (2023-12-28 11:56:52 +0100)

Please consider pulling these changes from the signed vfs-6.8.misc tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.misc

----------------------------------------------------------------
Abhinav Singh (1):
      fs : Fix warning using plain integer as NULL

Al Viro (1):
      file: massage cleanup of files that failed to open

Alexander Mikhalitsyn (2):
      fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
      fs: fix doc comment typo fs tree wide

Andrei Vagin (2):
      fs/proc: show correct device and inode numbers in /proc/pid/maps
      selftests/overlayfs: verify device and inode numbers in /proc/pid/maps

Bagas Sanjaya (1):
      fs: Clarify "non-RCY" in access_override_creds() comment

Christian Brauner (16):
      fs: add missing @mp parameter documentation
      i915: make inject_virtual_interrupt() void
      eventfd: simplify eventfd_signal()
      eventfd: simplify eventfd_signal_mask()
      eventfd: make eventfd_signal{_mask}() void
      mnt_idmapping: remove check_fsmapping()
      mnt_idmapping: remove nop check
      mnt_idmapping: decouple from namespaces
      fs: reformat idmapped mounts entry
      file: s/close_fd_get_file()/file_close_fd()/g
      file: remove pointless wrapper
      fs: replace f_rcuhead with f_task_work
      file: stop exposing receive_fd_user()
      file: remove __receive_fd()
      fs: add Jan Kara as reviewer
      Merge branch 'vfs.file'

Christophe JAILLET (1):
      eventfd: Remove usage of the deprecated ida_simple_xx() API

Dmitry Antipov (1):
      watch_queue: fix kcalloc() arguments order

Edward Adam Davis (1):
      reiserfs: fix uninit-value in comp_keys

Hao Ge (1):
      fs/inode: Make relatime_need_update return bool

Jann Horn (1):
      fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Kent Overstreet (1):
      fs/aio: obey min_nr when doing wakeups

Linus Torvalds (1):
      Improve __fget_files_rcu() code generation (and thus __fget_light())

Lukas Schauer (1):
      pipe: wakeup wr_wait after setting max_usage

Mateusz Guzik (1):
      vfs: remove a redundant might_sleep in wait_on_inode

Matthew Wilcox (Oracle) (1):
      fs: Rename mapping private members

Randy Dunlap (3):
      userns: eliminate many kernel-doc warnings
      fs/hfsplus: wrapper.c: fix kernel-doc warnings
      ntfs: dir.c: fix kernel-doc function parameter warnings

YangXin (1):
      fs: namei: Fix spelling mistake "Retuns" to "Returns"

 MAINTAINERS                                        |  21 +--
 arch/x86/kvm/hyperv.c                              |   2 +-
 arch/x86/kvm/xen.c                                 |   2 +-
 drivers/accel/habanalabs/common/device.c           |   2 +-
 drivers/android/binder.c                           |   2 +-
 drivers/fpga/dfl.c                                 |   2 +-
 drivers/gpu/drm/drm_syncobj.c                      |   6 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |  13 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   2 +-
 drivers/misc/ocxl/file.c                           |   2 +-
 drivers/s390/cio/vfio_ccw_chp.c                    |   2 +-
 drivers/s390/cio/vfio_ccw_drv.c                    |   4 +-
 drivers/s390/cio/vfio_ccw_ops.c                    |   6 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   4 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   8 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |   2 +-
 drivers/vfio/pci/vfio_pci_core.c                   |   6 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  |  12 +-
 drivers/vfio/platform/vfio_platform_irq.c          |   4 +-
 drivers/vhost/vdpa.c                               |   4 +-
 drivers/vhost/vhost.c                              |  10 +-
 drivers/vhost/vhost.h                              |   2 +-
 drivers/virt/acrn/ioeventfd.c                      |   2 +-
 drivers/xen/privcmd.c                              |   2 +-
 fs/aio.c                                           |  85 +++++++---
 fs/attr.c                                          |   2 +-
 fs/btrfs/extent_io.c                               |  52 +++---
 fs/btrfs/subpage.c                                 |   4 +-
 fs/buffer.c                                        | 108 ++++++------
 fs/dax.c                                           |   2 +-
 fs/direct-io.c                                     |   2 +-
 fs/eventfd.c                                       |  46 ++----
 fs/ext4/inode.c                                    |   4 +-
 fs/file.c                                          |  97 ++++++-----
 fs/file_table.c                                    |  22 +--
 fs/gfs2/glock.c                                    |   2 +-
 fs/gfs2/ops_fstype.c                               |   2 +-
 fs/hfsplus/wrapper.c                               |   5 +-
 fs/hugetlbfs/inode.c                               |   4 +-
 fs/inode.c                                         |  22 +--
 fs/internal.h                                      |   3 +-
 fs/mnt_idmapping.c                                 | 159 +++++++++++-------
 fs/namei.c                                         |  31 ++--
 fs/namespace.c                                     |   3 +-
 fs/nfs/write.c                                     |  12 +-
 fs/nilfs2/inode.c                                  |   4 +-
 fs/ntfs/aops.c                                     |  10 +-
 fs/ntfs/dir.c                                      |   3 +-
 fs/open.c                                          |   5 +-
 fs/pipe.c                                          |  24 ++-
 fs/posix_acl.c                                     |   4 +-
 fs/proc/task_mmu.c                                 |   3 +-
 fs/reiserfs/stree.c                                |   2 +-
 fs/stat.c                                          |   2 +-
 fs/super.c                                         |   2 +-
 include/linux/eventfd.h                            |  17 +-
 include/linux/fdtable.h                            |  19 ++-
 include/linux/file.h                               |  12 +-
 include/linux/fs.h                                 |  34 ++--
 include/linux/mnt_idmapping.h                      |   3 -
 include/linux/uidgid.h                             |  13 ++
 include/linux/writeback.h                          |   1 -
 include/net/scm.h                                  |   9 +
 io_uring/io_uring.c                                |   4 +-
 io_uring/openclose.c                               |   2 +-
 kernel/pid.c                                       |   2 +-
 kernel/seccomp.c                                   |   2 +-
 kernel/user_namespace.c                            |  20 +--
 kernel/watch_queue.c                               |   2 +-
 mm/hugetlb.c                                       |   2 +-
 mm/memcontrol.c                                    |  10 +-
 mm/migrate.c                                       |   6 +-
 mm/vmpressure.c                                    |   2 +-
 net/compat.c                                       |   2 +-
 net/core/scm.c                                     |   2 +-
 samples/vfio-mdev/mtty.c                           |   4 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/overlayfs/.gitignore     |   2 +
 .../selftests/filesystems/overlayfs/Makefile       |   7 +
 .../selftests/filesystems/overlayfs/dev_in_maps.c  | 182 +++++++++++++++++++++
 .../testing/selftests/filesystems/overlayfs/log.h  |  26 +++
 virt/kvm/eventfd.c                                 |   4 +-
 83 files changed, 784 insertions(+), 456 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/log.h

