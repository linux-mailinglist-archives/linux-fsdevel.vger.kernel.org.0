Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2D6D96C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 05:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfGSDoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 23:44:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56554 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSDoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:44:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoJoh-0007PZ-CO; Fri, 19 Jul 2019 03:44:19 +0000
Date:   Fri, 19 Jul 2019 04:44:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git work.mount0
Message-ID: <20190719034419.GX17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The first part of mount updates.  It's messier than I'd like;
the branch itself merges with a couple of trivial conflicts, but there
are two filesystems that have grown the need of update while in
separate branches.  I can do backmerges for those two (dmabuf and
vmballon), but fixups required are rather trivial.  Not sure what
would be the best way to deal with that; it could be folded into
the merge commit, but...

	Anyway, I'd pushed the proposed conflict resolution into
#merge-candidate, with followups in separate commit on top of the
merge; folding that into the merge itself is trivial.  Up to you.
FWIW, the fixup itself (as had been done in -next) amounts to
 drivers/dma-buf/dma-buf.c  | 14 +++++++++-----
 drivers/misc/vmw_balloon.c | 14 ++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)
and it's basically conversions of two pseudo-filesystems to
init_pseudo().

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount0

for you to fetch changes up to 037f11b4752f717201143a1dc5d6acf3cb71ddfa:

  mnt_init(): call shmem_init() unconditionally (2019-07-04 22:01:59 -0400)

----------------------------------------------------------------
Al Viro (25):
      drm: don't bother with super_operations and dentry_operations
      cxl: don't bother with dentry_operations
      cxlflash: don't bother with dentry_operations
      balloon: don't bother with dentry_operations
      zsmalloc: don't bother with dentry_operations
      unexport simple_dname()
      mount_pseudo(): drop 'name' argument, switch to d_make_root()
      no need to protect against put_user_ns(NULL)
      start massaging the checks in sget_...(): move to sget_userns()
      consolidate the capability checks in sget_{fc,userns}()
      move the capability checks from sget_userns() to legacy_get_tree()
      legacy_get_tree(): pass fc->user_ns to mount_capable()
      switch mount_capable() to fs_context
      mqueue: set ->user_ns before ->get_tree()
      procfs: set ->user_ns before calling ->get_tree()
      cpuset: move mount -t cpuset logics into cgroup.c
      move mount_capable() calls to vfs_get_tree()
      move mount_capable() further out
      fold mount_pseudo_xattr() into pseudo_fs_get_tree()
      convenience helper get_tree_nodev()
      convenience helper: get_tree_single()
      init_rootfs(): don't bother with init_ramfs_fs()
      don't bother with registering rootfs
      constify ksys_mount() string arguments
      mnt_init(): call shmem_init() unconditionally

Dan Williams (1):
      device-dax: Drop register_filesystem()

David Howells (37):
      z3fold: don't bother with dentry_operations
      vfs: Convert rpc_pipefs to use the new mount API
      vfs: Convert nfsctl to use the new mount API
      vfs: Kill mount_ns()
      vfs: Fix refcounting of filenames in fs_parser
      vfs: Provide sb->s_iflags settings in fs_context struct
      vfs: Provide a mount_pseudo-replacement for the new mount API
      vfs: Convert aio to use the new mount API
      vfs: Convert anon_inodes to use the new mount API
      vfs: Convert bdev to use the new mount API
      vfs: Convert nsfs to use the new mount API
      vfs: Convert pipe to use the new mount API
      vfs: Convert zsmalloc to use the new mount API
      zsfold: Convert zsfold to use the new mount API
      vfs: Convert sockfs to use the new mount API
      vfs: Convert dax to use the new mount API
      vfs: Convert drm to use the new mount API
      vfs: Convert ia64 perfmon to use the new mount API
      vfs: Convert cxl to use the new mount API
      vfs: Convert ocxlflash to use the new mount API
      vfs: Convert virtio_balloon to use the new mount API
      vfs: Convert btrfs_test to use the new mount API
      vfs: Use sget_fc() for pseudo-filesystems
      vfs: Kill sget_userns()
      vfs: Convert binfmt_misc to use the new mount API
      vfs: Convert configfs to use the new mount API
      vfs: Convert efivarfs to use the new mount API
      vfs: Convert qib_fs/ipathfs to use the new mount API
      vfs: Convert ibmasmfs to use the new mount API
      vfs: Convert oprofilefs to use the new mount API
      vfs: Convert gadgetfs to use the new mount API
      vfs: Convert xenfs to use the new mount API
      vfs: Convert openpromfs to use the new mount API
      vfs: Convert apparmorfs to use the new mount API
      vfs: Convert securityfs to use the new mount API
      vfs: Convert selinuxfs to use the new mount API
      vfs: Convert smackfs to use the new mount API

 arch/ia64/kernel/perfmon.c             |  17 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   3 +-
 drivers/base/devtmpfs.c                |   3 +-
 drivers/dax/super.c                    |  23 +++--
 drivers/gpu/drm/drm_drv.c              |  20 +----
 drivers/infiniband/hw/qib/qib_fs.c     |  26 ++++--
 drivers/misc/cxl/api.c                 |  13 +--
 drivers/misc/ibmasm/ibmasmfs.c         |  21 +++--
 drivers/oprofile/oprofilefs.c          |  20 +++--
 drivers/scsi/cxlflash/ocxl_hw.c        |  23 +----
 drivers/usb/gadget/legacy/inode.c      |  21 +++--
 drivers/virtio/virtio_balloon.c        |  13 +--
 drivers/xen/xenfs/super.c              |  21 +++--
 fs/aio.c                               |  16 ++--
 fs/anon_inodes.c                       |  13 +--
 fs/binfmt_misc.c                       |  20 +++--
 fs/block_dev.c                         |  17 ++--
 fs/btrfs/tests/btrfs-tests.c           |  15 ++--
 fs/configfs/mount.c                    |  20 +++--
 fs/d_path.c                            |   1 -
 fs/efivarfs/super.c                    |  25 +++---
 fs/fs_parser.c                         |   1 +
 fs/fsopen.c                            |   2 +
 fs/fuse/control.c                      |   2 +-
 fs/hugetlbfs/inode.c                   |   2 +-
 fs/internal.h                          |   3 +
 fs/libfs.c                             |  82 ++++++++++--------
 fs/namespace.c                         |  15 ++--
 fs/nfsd/nfsctl.c                       |  33 ++++++--
 fs/nsfs.c                              |  16 ++--
 fs/openpromfs/inode.c                  |  20 +++--
 fs/pipe.c                              |  15 ++--
 fs/proc/root.c                         |   7 +-
 fs/ramfs/inode.c                       |   6 +-
 fs/super.c                             | 148 ++++++++++-----------------------
 fs/sysfs/mount.c                       |   3 +-
 include/linux/dcache.h                 |   1 -
 include/linux/fs.h                     |  21 -----
 include/linux/fs_context.h             |   7 ++
 include/linux/init.h                   |   5 +-
 include/linux/pseudo_fs.h              |  16 ++++
 include/linux/ramfs.h                  |   1 -
 include/linux/syscalls.h               |   4 +-
 include/uapi/linux/magic.h             |   1 +
 init/do_mounts.c                       |  24 +-----
 init/main.c                            |   1 -
 ipc/mqueue.c                           |   9 +-
 kernel/cgroup/cgroup.c                 |  50 ++++++++++-
 kernel/cgroup/cpuset.c                 |  61 +-------------
 mm/shmem.c                             |   4 -
 mm/z3fold.c                            |  14 ++--
 mm/zsmalloc.c                          |  12 +--
 net/socket.c                           |  16 ++--
 net/sunrpc/rpc_pipe.c                  |  34 ++++++--
 security/apparmor/apparmorfs.c         |  20 +++--
 security/inode.c                       |  21 +++--
 security/selinux/selinuxfs.c           |  20 +++--
 security/smack/smackfs.c               |  34 +++++---
 58 files changed, 566 insertions(+), 516 deletions(-)
 create mode 100644 include/linux/pseudo_fs.h
