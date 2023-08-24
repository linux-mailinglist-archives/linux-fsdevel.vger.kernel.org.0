Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2E787159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjHXOVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjHXOVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187311F;
        Thu, 24 Aug 2023 07:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895CE60281;
        Thu, 24 Aug 2023 14:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A8BC433C8;
        Thu, 24 Aug 2023 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692886861;
        bh=wcn7OeD/jrIUU62tjdUjIWPA+ZB02vNtj7nrACGImUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GqKv+dYVuuKgH4qSvdBMUUEfoFhvkXbv/1Drv3DM0qEOd1qt7Jr+JBxVTwxRU/Q09
         47ignSMUq9sTUGWeAhq+PnxANbNTj3nugmBF8bRn555KYsf0S1mZr2vrNkXZNbEr8S
         yskqEtMq8zjRqba+2xf9r821T02IjsHFIgKNkTZscKZwuZatK0WVrc5enGbqeEdKJ1
         e1Y4f7QBPv5Z1bTV9GQddoZ3UL0m38GAdPD3ltq+Uz3wP/pP97njyXiyzg0ioY9tZb
         cvMnCL85uQj7XkH6R8p1QAJSbwAnRmfJG+FoRYQ3OBNvoQTPOhjgGDetD2ywUXlVtG
         WHtpyJoU/6Sww==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] multi-grained timestamps
Date:   Thu, 24 Aug 2023 16:19:41 +0200
Message-Id: <20230824-sowie-april-a3f262c64848@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23471; i=brauner@kernel.org; h=from:subject:message-id; bh=wcn7OeD/jrIUU62tjdUjIWPA+ZB02vNtj7nrACGImUQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8T3v8++6qOw7MHqdvbl+rn+K2QOmh3MTin9cD9ro8bWrv 1Lm8r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi3KwM/2NDPdNDTVv6edesTDlk7N /DF3q1Ui+1YnmR7ZbMAAt+LUaGaYH3nC+5/liTw2g7Q4nhy09uyQrja7GrJ/N331x0U62AEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This adds VFS support for multi-grain timestamps and converts tmpfs,
xfs, ext4, and btrfs to use them. This carries acks from all relevant
filesystems.

The VFS always uses coarse-grained timestamps when updating the ctime
and mtime after a change. This has the benefit of allowing filesystems
to optimize away a lot of metadata updates, down to around 1 per jiffy,
even when a file is under heavy writes.

Unfortunately, this has always been an issue when we're exporting via
NFSv3, which relies on timestamps to validate caches. A lot of changes
can happen in a jiffy, so timestamps aren't sufficient to help the
client decide to invalidate the cache.

Even with NFSv4, a lot of exported filesystems don't properly support a
change attribute and are subject to the same problems with timestamp
granularity. Other applications have similar issues with timestamps
(e.g., backup applications).

If we were to always use fine-grained timestamps, that would improve the
situation, but that becomes rather expensive, as the underlying
filesystem would have to log a lot more metadata updates.

This introduces fine-grained timestamps that are used when they are
actively queried.

This uses the 31st bit of the ctime tv_nsec field to indicate that
something has queried the inode for the mtime or ctime. When this flag
is set, on the next mtime or ctime update, the kernel will fetch a
fine-grained timestamp instead of the usual coarse-grained one.

As POSIX generally mandates that when the mtime changes, the ctime must
also change the kernel always stores normalized ctime values, so only
the first 30 bits of the tv_nsec field are ever used.

Filesytems can opt into this behavior by setting the FS_MGTIME flag in
the fstype. Filesystems that don't set this flag will continue to use
coarse-grained timestamps.

Various preparatory changes, fixes and cleanups are included:

* Fixup all relevant places where POSIX requires updating ctime together
  with mtime. This is a wide-range of places and all maintainers
  provided necessary Acks.
* Add new accessors for inode->i_ctime directly and change all callers
  to rely on them. Plain accesses to inode->i_ctime are now gone and it
  is accordingly rename to inode->__i_ctime and commented as requiring
  accessors.
* Extend generic_fillattr() to pass in a request mask mirroring in a
  sense the statx() uapi. This allows callers to pass in a request mask
  to only get a subset of attributes filled in.
* Rework timestamp updates so it's possible to drop the @now parameter
  the update_time() inode operation and associated helpers.
* Add inode_update_timestamps() and convert all filesystems to it
  removing a bunch of open-coding.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
selftests, and LTP pass without regressions.

/* Conflicts */
This will have a merge conflict with the v6.6-vfs.tmpfs work. I'm
providing a conflict resolution in the v6.6-vfs.tmpfs pull request. So I
would suggest to merge this pull request here first.

It will also have conflicts with the following trees:

(1) linux-next: manual merge of the vfs-brauner tree with the btrfs tree
    https://lore.kernel.org/lkml/20230815112023.5903355c@canb.auug.org.au

(2) linux-next: manual merge of the vfs-brauner tree with the f2fs tree
    https://lore.kernel.org/lkml/20230815113013.40cbf98a@canb.auug.org.au

(3) linux-next: manual merge of the vfs-brauner tree with the f2fs tree
    https://lore.kernel.org/lkml/20230815113357.11919e63@canb.auug.org.au

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.ctime

for you to fetch changes up to 50e9ceef1d4f644ee0049e82e360058a64ec284c:

  btrfs: convert to multigrain timestamps (2023-08-11 09:04:58 +0200)

Please consider pulling these changes from the signed v6.6-vfs.ctime tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.ctime

----------------------------------------------------------------
Jeff Layton (107):
      ibmvmc: update ctime in conjunction with mtime on write
      bfs: update ctime in addition to mtime when adding entries
      efivarfs: update ctime when mtime changes on a write
      exfat: ensure that ctime is updated whenever the mtime is
      apparmor: update ctime whenever the mtime changes on an inode
      cifs: update the ctime on a partial page write
      fs: add ctime accessors infrastructure
      fs: new helper: simple_rename_timestamp
      btrfs: convert to simple_rename_timestamp
      ubifs: convert to simple_rename_timestamp
      shmem: convert to simple_rename_timestamp
      exfat: convert to simple_rename_timestamp
      ntfs3: convert to simple_rename_timestamp
      reiserfs: convert to simple_rename_timestamp
      spufs: convert to ctime accessor functions
      s390: convert to ctime accessor functions
      binderfs: convert to ctime accessor functions
      infiniband: convert to ctime accessor functions
      ibm: convert to ctime accessor functions
      usb: convert to ctime accessor functions
      9p: convert to ctime accessor functions
      adfs: convert to ctime accessor functions
      affs: convert to ctime accessor functions
      afs: convert to ctime accessor functions
      fs: convert to ctime accessor functions
      autofs: convert to ctime accessor functions
      befs: convert to ctime accessor functions
      bfs: convert to ctime accessor functions
      btrfs: convert to ctime accessor functions
      ceph: convert to ctime accessor functions
      coda: convert to ctime accessor functions
      configfs: convert to ctime accessor functions
      cramfs: convert to ctime accessor functions
      debugfs: convert to ctime accessor functions
      devpts: convert to ctime accessor functions
      ecryptfs: convert to ctime accessor functions
      efivarfs: convert to ctime accessor functions
      efs: convert to ctime accessor functions
      erofs: convert to ctime accessor functions
      exfat: convert to ctime accessor functions
      ext2: convert to ctime accessor functions
      ext4: convert to ctime accessor functions
      f2fs: convert to ctime accessor functions
      fat: convert to ctime accessor functions
      freevxfs: convert to ctime accessor functions
      fuse: convert to ctime accessor functions
      gfs2: convert to ctime accessor functions
      hfs: convert to ctime accessor functions
      hfsplus: convert to ctime accessor functions
      hostfs: convert to ctime accessor functions
      hpfs: convert to ctime accessor functions
      hugetlbfs: convert to ctime accessor functions
      isofs: convert to ctime accessor functions
      jffs2: convert to ctime accessor functions
      jfs: convert to ctime accessor functions
      kernfs: convert to ctime accessor functions
      nfs: convert to ctime accessor functions
      nfsd: convert to ctime accessor functions
      nilfs2: convert to ctime accessor functions
      ntfs: convert to ctime accessor functions
      ntfs3: convert to ctime accessor functions
      ocfs2: convert to ctime accessor functions
      omfs: convert to ctime accessor functions
      openpromfs: convert to ctime accessor functions
      orangefs: convert to ctime accessor functions
      overlayfs: convert to ctime accessor functions
      procfs: convert to ctime accessor functions
      pstore: convert to ctime accessor functions
      qnx4: convert to ctime accessor functions
      qnx6: convert to ctime accessor functions
      ramfs: convert to ctime accessor functions
      reiserfs: convert to ctime accessor functions
      romfs: convert to ctime accessor functions
      smb: convert to ctime accessor functions
      squashfs: convert to ctime accessor functions
      sysv: convert to ctime accessor functions
      tracefs: convert to ctime accessor functions
      ubifs: convert to ctime accessor functions
      udf: convert to ctime accessor functions
      ufs: convert to ctime accessor functions
      vboxsf: convert to ctime accessor functions
      xfs: convert to ctime accessor functions
      zonefs: convert to ctime accessor functions
      linux: convert to ctime accessor functions
      mqueue: convert to ctime accessor functions
      bpf: convert to ctime accessor functions
      shmem: convert to ctime accessor functions
      sunrpc: convert to ctime accessor functions
      apparmor: convert to ctime accessor functions
      security: convert to ctime accessor functions
      selinux: convert to ctime accessor functions
      fs: rename i_ctime field to __i_ctime
      gfs2: fix timestamp handling on quota inodes
      fs: remove silly warning from current_time
      fs: pass the request_mask to generic_fillattr
      fs: drop the timespec64 arg from generic_update_time
      btrfs: have it use inode_update_timestamps
      ubifs: have ubifs_update_time use inode_update_timestamps
      fat: remove i_version handling from fat_update_time
      fat: make fat_update_time get its own timestamp
      xfs: have xfs_vn_update_time gets its own timestamp
      fs: drop the timespec64 argument from update_time
      fs: add infrastructure for multigrain timestamps
      tmpfs: add support for multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps

 arch/powerpc/platforms/cell/spufs/inode.c |   2 +-
 arch/s390/hypfs/inode.c                   |   4 +-
 drivers/android/binderfs.c                |   8 +-
 drivers/infiniband/hw/qib/qib_fs.c        |   3 +-
 drivers/misc/ibmasm/ibmasmfs.c            |   2 +-
 drivers/misc/ibmvmc.c                     |   2 +-
 drivers/usb/core/devio.c                  |  16 +--
 drivers/usb/gadget/function/f_fs.c        |   3 +-
 drivers/usb/gadget/legacy/inode.c         |   3 +-
 fs/9p/vfs_inode.c                         |   8 +-
 fs/9p/vfs_inode_dotl.c                    |  12 +-
 fs/adfs/inode.c                           |   4 +-
 fs/affs/amigaffs.c                        |   6 +-
 fs/affs/inode.c                           |  16 +--
 fs/afs/dynroot.c                          |   2 +-
 fs/afs/inode.c                            |   8 +-
 fs/attr.c                                 |   2 +-
 fs/autofs/inode.c                         |   2 +-
 fs/autofs/root.c                          |   6 +-
 fs/bad_inode.c                            |   6 +-
 fs/befs/linuxvfs.c                        |   2 +-
 fs/bfs/dir.c                              |  16 +--
 fs/bfs/inode.c                            |   5 +-
 fs/binfmt_misc.c                          |   3 +-
 fs/btrfs/delayed-inode.c                  |   8 +-
 fs/btrfs/file.c                           |  37 ++---
 fs/btrfs/inode.c                          |  66 +++------
 fs/btrfs/ioctl.c                          |   2 +-
 fs/btrfs/reflink.c                        |   3 +-
 fs/btrfs/super.c                          |   5 +-
 fs/btrfs/transaction.c                    |   3 +-
 fs/btrfs/tree-log.c                       |   4 +-
 fs/btrfs/volumes.c                        |   4 +-
 fs/btrfs/xattr.c                          |   4 +-
 fs/ceph/acl.c                             |   2 +-
 fs/ceph/caps.c                            |   2 +-
 fs/ceph/inode.c                           |  18 +--
 fs/ceph/snap.c                            |   2 +-
 fs/ceph/xattr.c                           |   2 +-
 fs/coda/coda_linux.c                      |   3 +-
 fs/coda/dir.c                             |   2 +-
 fs/coda/file.c                            |   2 +-
 fs/coda/inode.c                           |   5 +-
 fs/configfs/inode.c                       |   7 +-
 fs/cramfs/inode.c                         |   3 +-
 fs/debugfs/inode.c                        |   3 +-
 fs/devpts/inode.c                         |   6 +-
 fs/ecryptfs/inode.c                       |   7 +-
 fs/efivarfs/file.c                        |   2 +-
 fs/efivarfs/inode.c                       |   2 +-
 fs/efs/inode.c                            |   4 +-
 fs/erofs/inode.c                          |  14 +-
 fs/exfat/file.c                           |   6 +-
 fs/exfat/inode.c                          |   6 +-
 fs/exfat/namei.c                          |  26 ++--
 fs/exfat/super.c                          |   3 +-
 fs/ext2/acl.c                             |   2 +-
 fs/ext2/dir.c                             |   6 +-
 fs/ext2/ialloc.c                          |   2 +-
 fs/ext2/inode.c                           |  12 +-
 fs/ext2/ioctl.c                           |   4 +-
 fs/ext2/namei.c                           |   8 +-
 fs/ext2/super.c                           |   2 +-
 fs/ext2/xattr.c                           |   2 +-
 fs/ext4/acl.c                             |   2 +-
 fs/ext4/ext4.h                            |  90 +++++++------
 fs/ext4/extents.c                         |  12 +-
 fs/ext4/ialloc.c                          |   2 +-
 fs/ext4/inline.c                          |   4 +-
 fs/ext4/inode-test.c                      |   6 +-
 fs/ext4/inode.c                           |  18 ++-
 fs/ext4/ioctl.c                           |   9 +-
 fs/ext4/namei.c                           |  26 ++--
 fs/ext4/super.c                           |   4 +-
 fs/ext4/xattr.c                           |   6 +-
 fs/f2fs/dir.c                             |   8 +-
 fs/f2fs/f2fs.h                            |   4 +-
 fs/f2fs/file.c                            |  22 +--
 fs/f2fs/inline.c                          |   2 +-
 fs/f2fs/inode.c                           |  10 +-
 fs/f2fs/namei.c                           |  12 +-
 fs/f2fs/recovery.c                        |   4 +-
 fs/f2fs/super.c                           |   2 +-
 fs/f2fs/xattr.c                           |   2 +-
 fs/fat/fat.h                              |   3 +-
 fs/fat/file.c                             |   2 +-
 fs/fat/inode.c                            |   5 +-
 fs/fat/misc.c                             |  10 +-
 fs/freevxfs/vxfs_inode.c                  |   3 +-
 fs/fuse/control.c                         |   2 +-
 fs/fuse/dir.c                             |  10 +-
 fs/fuse/inode.c                           |  16 +--
 fs/gfs2/acl.c                             |   2 +-
 fs/gfs2/bmap.c                            |  11 +-
 fs/gfs2/dir.c                             |  15 ++-
 fs/gfs2/file.c                            |   2 +-
 fs/gfs2/glops.c                           |   4 +-
 fs/gfs2/inode.c                           |  16 +--
 fs/gfs2/quota.c                           |   2 +-
 fs/gfs2/super.c                           |   4 +-
 fs/gfs2/xattr.c                           |   8 +-
 fs/hfs/catalog.c                          |   8 +-
 fs/hfs/dir.c                              |   2 +-
 fs/hfs/inode.c                            |  13 +-
 fs/hfs/sysdep.c                           |   4 +-
 fs/hfsplus/catalog.c                      |   8 +-
 fs/hfsplus/dir.c                          |   6 +-
 fs/hfsplus/inode.c                        |  18 +--
 fs/hostfs/hostfs_kern.c                   |   3 +-
 fs/hpfs/dir.c                             |   8 +-
 fs/hpfs/inode.c                           |   6 +-
 fs/hpfs/namei.c                           |  29 ++--
 fs/hpfs/super.c                           |   5 +-
 fs/hugetlbfs/inode.c                      |  12 +-
 fs/inode.c                                | 216 ++++++++++++++++++++++++------
 fs/isofs/inode.c                          |   9 +-
 fs/isofs/rock.c                           |  16 +--
 fs/jffs2/dir.c                            |  24 ++--
 fs/jffs2/file.c                           |   3 +-
 fs/jffs2/fs.c                             |  10 +-
 fs/jffs2/os-linux.h                       |   2 +-
 fs/jfs/acl.c                              |   2 +-
 fs/jfs/inode.c                            |   2 +-
 fs/jfs/ioctl.c                            |   2 +-
 fs/jfs/jfs_imap.c                         |   8 +-
 fs/jfs/jfs_inode.c                        |   4 +-
 fs/jfs/namei.c                            |  24 ++--
 fs/jfs/super.c                            |   2 +-
 fs/jfs/xattr.c                            |   2 +-
 fs/kernfs/inode.c                         |   7 +-
 fs/libfs.c                                |  59 +++++---
 fs/minix/bitmap.c                         |   2 +-
 fs/minix/dir.c                            |   6 +-
 fs/minix/inode.c                          |  12 +-
 fs/minix/itree_common.c                   |   4 +-
 fs/minix/namei.c                          |   6 +-
 fs/nfs/callback_proc.c                    |   2 +-
 fs/nfs/fscache.h                          |   4 +-
 fs/nfs/inode.c                            |  22 +--
 fs/nfs/namespace.c                        |   3 +-
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/vfs.c                             |   2 +-
 fs/nilfs2/dir.c                           |   6 +-
 fs/nilfs2/inode.c                         |  12 +-
 fs/nilfs2/ioctl.c                         |   2 +-
 fs/nilfs2/namei.c                         |   8 +-
 fs/nsfs.c                                 |   2 +-
 fs/ntfs/inode.c                           |  15 ++-
 fs/ntfs/mft.c                             |   3 +-
 fs/ntfs3/file.c                           |   8 +-
 fs/ntfs3/frecord.c                        |   3 +-
 fs/ntfs3/inode.c                          |  14 +-
 fs/ntfs3/namei.c                          |  11 +-
 fs/ntfs3/xattr.c                          |   4 +-
 fs/ocfs2/acl.c                            |   6 +-
 fs/ocfs2/alloc.c                          |   6 +-
 fs/ocfs2/aops.c                           |   2 +-
 fs/ocfs2/dir.c                            |   8 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |   4 +-
 fs/ocfs2/dlmglue.c                        |   7 +-
 fs/ocfs2/file.c                           |  18 +--
 fs/ocfs2/inode.c                          |  12 +-
 fs/ocfs2/move_extents.c                   |   6 +-
 fs/ocfs2/namei.c                          |  21 +--
 fs/ocfs2/refcounttree.c                   |  14 +-
 fs/ocfs2/xattr.c                          |   6 +-
 fs/omfs/dir.c                             |   4 +-
 fs/omfs/inode.c                           |   9 +-
 fs/openpromfs/inode.c                     |   5 +-
 fs/orangefs/inode.c                       |   7 +-
 fs/orangefs/namei.c                       |   2 +-
 fs/orangefs/orangefs-kernel.h             |   2 +-
 fs/orangefs/orangefs-utils.c              |   6 +-
 fs/overlayfs/file.c                       |   7 +-
 fs/overlayfs/inode.c                      |   2 +-
 fs/overlayfs/overlayfs.h                  |   2 +-
 fs/overlayfs/util.c                       |   2 +-
 fs/pipe.c                                 |   2 +-
 fs/posix_acl.c                            |   2 +-
 fs/proc/base.c                            |   6 +-
 fs/proc/fd.c                              |   2 +-
 fs/proc/generic.c                         |   2 +-
 fs/proc/inode.c                           |   2 +-
 fs/proc/proc_net.c                        |   2 +-
 fs/proc/proc_sysctl.c                     |   4 +-
 fs/proc/root.c                            |   3 +-
 fs/proc/self.c                            |   2 +-
 fs/proc/thread_self.c                     |   2 +-
 fs/pstore/inode.c                         |   4 +-
 fs/qnx4/inode.c                           |   3 +-
 fs/qnx6/inode.c                           |   3 +-
 fs/ramfs/inode.c                          |   6 +-
 fs/reiserfs/inode.c                       |  12 +-
 fs/reiserfs/ioctl.c                       |   4 +-
 fs/reiserfs/namei.c                       |  18 +--
 fs/reiserfs/stree.c                       |   4 +-
 fs/reiserfs/super.c                       |   2 +-
 fs/reiserfs/xattr.c                       |   5 +-
 fs/reiserfs/xattr_acl.c                   |   2 +-
 fs/romfs/super.c                          |   3 +-
 fs/smb/client/file.c                      |   4 +-
 fs/smb/client/fscache.h                   |   5 +-
 fs/smb/client/inode.c                     |  16 +--
 fs/smb/client/smb2ops.c                   |   3 +-
 fs/smb/server/smb2pdu.c                   |  30 ++---
 fs/smb/server/vfs.c                       |   3 +-
 fs/squashfs/inode.c                       |   2 +-
 fs/stack.c                                |   2 +-
 fs/stat.c                                 |  65 +++++++--
 fs/sysv/dir.c                             |   6 +-
 fs/sysv/ialloc.c                          |   2 +-
 fs/sysv/inode.c                           |   5 +-
 fs/sysv/itree.c                           |   7 +-
 fs/sysv/namei.c                           |   6 +-
 fs/tracefs/inode.c                        |   2 +-
 fs/ubifs/debug.c                          |   4 +-
 fs/ubifs/dir.c                            |  41 +++---
 fs/ubifs/file.c                           |  31 ++---
 fs/ubifs/ioctl.c                          |   2 +-
 fs/ubifs/journal.c                        |   4 +-
 fs/ubifs/super.c                          |   4 +-
 fs/ubifs/ubifs.h                          |   2 +-
 fs/ubifs/xattr.c                          |   6 +-
 fs/udf/ialloc.c                           |   2 +-
 fs/udf/inode.c                            |  17 ++-
 fs/udf/namei.c                            |  24 ++--
 fs/udf/symlink.c                          |   2 +-
 fs/ufs/dir.c                              |   6 +-
 fs/ufs/ialloc.c                           |   2 +-
 fs/ufs/inode.c                            |  23 ++--
 fs/ufs/namei.c                            |   8 +-
 fs/vboxsf/utils.c                         |   6 +-
 fs/xfs/libxfs/xfs_inode_buf.c             |   5 +-
 fs/xfs/libxfs/xfs_trans_inode.c           |   6 +-
 fs/xfs/xfs_acl.c                          |   2 +-
 fs/xfs/xfs_bmap_util.c                    |   6 +-
 fs/xfs/xfs_inode.c                        |   3 +-
 fs/xfs/xfs_inode_item.c                   |   2 +-
 fs/xfs/xfs_iops.c                         |  25 ++--
 fs/xfs/xfs_itable.c                       |   4 +-
 fs/xfs/xfs_super.c                        |   2 +-
 fs/zonefs/super.c                         |   8 +-
 include/linux/fs.h                        | 100 +++++++++++++-
 include/linux/fs_stack.h                  |   2 +-
 ipc/mqueue.c                              |  23 ++--
 kernel/bpf/inode.c                        |   6 +-
 mm/shmem.c                                |  30 ++---
 net/sunrpc/rpc_pipe.c                     |   2 +-
 security/apparmor/apparmorfs.c            |  11 +-
 security/apparmor/policy_unpack.c         |  11 +-
 security/inode.c                          |   2 +-
 security/selinux/selinuxfs.c              |   2 +-
 252 files changed, 1267 insertions(+), 1049 deletions(-)
