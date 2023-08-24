Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C77871F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbjHXOlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbjHXOlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166A1BE;
        Thu, 24 Aug 2023 07:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8BB63192;
        Thu, 24 Aug 2023 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE901C433C7;
        Thu, 24 Aug 2023 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888078;
        bh=hGVu59LZaQzRaVqjsWmHNiouCz0owI2YhWpcbujj/sw=;
        h=From:To:Cc:Subject:Date:From;
        b=MuMkeTuHGS2EShhN/Rt75shrLuVg8mxTfqy/1vtthgYINeKtXlyLC3waoJ+Ijl9R4
         zuEnKHA5EpRRwUbwTas5Q/Y55OviAe9l8i3HGNqimhr3cJigA3V+vy03axMSbbs10W
         ga+KG9nticBZUDBAukuV1OrPwturtZLkCKtDZYS0vsPlddR1zPplTGwg1w1XMGTR37
         c3hwFJXtaB1AA8rppV//eTW7R0etprlHf2Cy5X1h50/mv/4RL2cQ+HJjTSYrWJrN8P
         XEsHDWvqjRA7ST2sErJAGYsaXElY2IW6iAXkS4i4/+cn1qAhc1XfJqUZrQyE2IEyBX
         mV9DmWSTUz6Cw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] super updates
Date:   Thu, 24 Aug 2023 16:41:04 +0200
Message-Id: <20230824-prall-intakt-95dbffdee4a0@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16842; i=brauner@kernel.org; h=from:subject:message-id; bh=OhIEyXyyzZEuuCCRJyXyOvNzetylSclihF/TXa/Avuo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8zzgXWL/dwq/kiK66/qV4x9oVzc8k3KZtXiOQbOCukbbJ etqujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlst2b4K/H/sJqUgfG1NV8FH0j6nz v08dCkmlmZsg55ubceX9Lp7GZk+LNEq0/y17nqkxX1d7yV6+Ld7oatd+T+ybSxyjdsyqbNrAA=
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
This pull request contains the super rework that was ready for this
cycle. The first part changes the order of how we open block devices and
allocate superblocks, contains various cleanups, simplifications, and a
new mechanism to wait on superblock state changes.

This unblocks work to ultimately limit the number of writers to a block
device. Jan has already scheduled follow-up work that will be ready for
v6.7 and allows us to restrict the number of writers to a given block
device. That series builds on this work right here.

The second part contains filesystem freezing updates.

Tree Organization
=================

The filesystem freezing work was done by Darrick and he provided me with
two tags to pull from. So this pull request right here contains two
subtrees. The generic superblock changes are first. The two filesystem
freezing related tags are merged into it:

* The 'vfs-6.6-merge-2' tag brings in the generic filesystem freezing
  changes. Resulting merge conflicts have been resolved.

* The 'vfs-6.6-merge-3' brings in the xfs changes that make use of the
  new filesystem freezing changes.

Should you decide to not pull this then Darrick can provide you with the
two tags for the filesystem freezing changes separately.

A few changes, including Darrick's pull requests have been pulled in
only fairly recently but they have all been in -next.

Overview
========

The generic superblock changes are rougly organized as follows (skipping
over additional minor cleanups):

(1) Removal of the bd_super member from struct block_device.
    This was a very odd back pointer to struct super_block with unclear
    rules. For all relevant places we have other means to get the same
    information so just get rid of this.
(2) Simplify rules for superblock cleanup.
    Roughly, everything that is allocated during fs_context
    initialization and that's stored in fs_context->s_fs_info needs to
    be cleaned up by the fs_context->free() implementation before the
    superblock allocation function has been called successfully.

    After sget_fc() returned fs_context->s_fs_info has been transferred
    to sb->s_fs_info at which point sb->kill_sb() if fully responsible
    for cleanup. Adhering to these rules means that cleanup of
    sb->s_fs_info in fill_super() is to be avoided as it's brittle and
    inconsistent. Cleanup shouldn't be duplicated between
    sb->put_super() as sb->put_super() is only called if sb->s_root has
    been set aka when the filesystem has been successfully born
    (SB_BORN). That complexity should be avoided.

    This also means that block devices are to be closed in sb->kill_sb()
    instead of sb->put_super(). More details in the lower section.
(3) Make it possible to lookup or create a superblock before opening
    block devices

    There's a subtle dependency on (2) as some filesystems did rely on
    fill_super() to be called in order to correctly clean up
    sb->s_fs_info. All these filesystems have been fixed.
(4) Switch most filesystem to follow the same logic as the generic mount
    code now does as outlined in (3).
(5) Use the superblock as the holder of the block device.
    We can now easily go back from block device to owning superblock.
(6) Export and extend the generic fs_holder_ops and use them as holder
    ops everywhere and remove the filesystem specific holder ops.
(7) Call from the block layer up into the filesystem layer when the
    block device is removed, allowing to shut down the filesystem
    without risk of deadlocks.
(8) Get rid of get_super().
    We can now easily go back from the block device to owning superblock
    and can call up from the block layer into the filesystem layer when
    the device is removed. So no need to wade through all registered
    superblock to find the owning superblock anymore.

Optional Details
================

These outlined changes solve a long-standing deadlock and also interact
with general locking requirements between the block and fs layer. That's
probably worth describing a little bit.

The locking rules are such that sb->s_umount nests in
gendisk->open_mutex which is acquired when block devices are opened.
When a new superblock is allocated or an existing superblock is found
sb->s_umount is acquired and held until the superblock is fully
initialized. Since block devices where opened before superblock lookup
or allocation happened the locking order was guaranteed.

But now that we first allocate a new superbock we return with
sb->s_umount of the newly created superblock held. So calling into the
block layer to open block devices would cause us to violate
aforementioned locking order.

In order to preserve locking order sb->s_umount is now dropped before
opening block devices and reacquired before the filesystem provided
fill_super() method is called. This is safe because the superblock isn't
yet SB_BORN and is ignored by all iterators.

This is straightforward but has consequences. Iterators over
super_blocks (global list of superblocks) and fs_supers (list of
superblocks for a given filesystem type) that grab a temporary reference
to the superblock can now also grab sb->s_umount while the creator of
the superblock is opening block devices before they have managed to
reacquire sb->s_umount to call fill_super().

So whereas before such iterators or concurrent mounters would have
simply slept on s_umount until SB_BORN was set or the superblock was
discard due to initalization failure they would now spin.

Especially since the task that created the new superblock could be
sleeping on bdev_lock or open_mutex one iterator or concurrent mounter
waiting on SB_BORN will always spin somewhere.

This is all caused by requiring sb->s_umount to be held to check whether
the superblock is still alive or has been SB_BORN yet. To fix this
properly a method to wait on nascent superblocks to either become born
(SB_BORN) or dying (SB_DYING) without requiring s_umount to be held is
added using a wait_var_event() mechanism. This allows concurrent
iterators and mounters to sleep and be woken when the superblock is
SB_BORN or SB_DYING. This allows for other simplifications as well. A
few of them are already included with more to come next cycle.

A caller realizing that a superblock isn't SB_BORN yet adds itself to a
waitqueue and will be woken if the superblock is SB_BORN or SB_DYING.

This also allows us to fix another long-standing issue properly. As
mentioned in the overview this work changes where block devices are
closed. Before this series block devices where closed in sb->put_super()
which is called with sb->s_umount held from generic_shutdown_super()
which itself is called from deactivate_locked_super().

To close block device blkdev_put() must be used which can cause
sb->s_umount to be acquired when device changes are triggered that would
cause the block device to be invalidated. But since blkdev_put() was
called from sb->put_super() with sb->s_umount held this would deadlock.

To fix this closing block devices has been moved from sb->put_super()
into sb->kill_sb() which is called from deactivate_locked_super() after
generic_shutdown_super() has removed the superblock from the superblocks
list of the filesystem type and given up sb->s_umount.

This brings another problem to the table. Before, closing block devices
with sb->s_umount held from sb->put_super() guaranteed that a concurrent
mounter slept on sb->s_umount until the block device was closed.

However, sb->kill_sb() doesn't hold sb->s_umount anymore (otherwise
the aforementioned deadlock would just occur earlier so nothing would be
fixed). This may cause a concurrent mounter to fail with EBUSY in case
blkdev_put() hadn't finished yet. While that's probably not a big deal
it is something that can be avoided with the new mechanism.

To fix this, the removal of the superblock from the list of superblocks
of the filesystem type is moved from generic_shutdown_super() into
deactivate_locked_super() after sb->s_umount has been given up and
sb->kill_sb() has been called.

This is fine since generic_shutdown_super() wakes anyone waiting on
SB_DYING. This includes all iterators that don't need to wait for the
devices to be closed. They just care about whether the superblock is
still alive.

Any concurrent mounter on the other hand is made to wait for SB_DEAD.
This gets sent after block devices have been closed and the superblock
has been removed from the list of superblocks for the filesystem type.

Overall this should leave us in a much better state overall.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All generic super patches are based on v6.5-rc1 and have been sitting in
linux-next. Darrick's trees bring in v6.5-rc2. No build failures or
warnings were observed. All old and new tests in selftests, and LTP pass
without regressions.

/* Conflicts */
It will also have conflicts with the following trees:

(1) linux-next: manual merge of the vfs-brauner tree with the xfs tree
    https://lore.kernel.org/lkml/20230823093852.7bf03b7e@canb.auug.org.au

(2) Re: linux-next: manual merge of the vfs-brauner tree with the ext4 tree
    https://lore.kernel.org/lkml/20230821102559.35c8ef51@canb.auug.org.au

    The link to the "Re:" is intentional as it contains the correct
    conflict resolution.

(3) linux-next: manual merge of the block tree with the djw-vfs, vfs-brauner trees
    https://lore.kernel.org/lkml/20230822131541.7667f165@canb.auug.org.au

(4) This will also cause a minor merge conflict with the v6.6-vfs.ctime
    tag which I would recommend to merge first should you decide to
    pull this. My proposed conflict resolution is below:

diff --cc fs/ext4/super.c
index cb1ff47af156,60d2815a0b7e..73547d2334fd
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@@ -7278,8 -7271,8 +7271,8 @@@ static struct file_system_type ext4_fs_
        .name                   = "ext4",
        .init_fs_context        = ext4_init_fs_context,
        .parameters             = ext4_param_specs,
-       .kill_sb                = kill_block_super,
+       .kill_sb                = ext4_kill_sb,
 -      .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 +      .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
  };
  MODULE_ALIAS_FS("ext4");

diff --cc fs/xfs/xfs_super.c
index 4b10edb2c972,8fee15292499..c79eac048456
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@@ -2008,8 -2032,8 +2032,8 @@@ static struct file_system_type xfs_fs_t
        .name                   = "xfs",
        .init_fs_context        = xfs_init_fs_context,
        .parameters             = xfs_fs_parameters,
-       .kill_sb                = kill_block_super,
+       .kill_sb                = xfs_kill_sb,
 -      .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 +      .fs_flags               = FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
  };
  MODULE_ALIAS_FS("xfs");

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super

for you to fetch changes up to cd4284cfd3e11c7a49e4808f76f53284d47d04dd:

  Merge tag 'vfs-6.6-merge-3' of ssh://gitolite.kernel.org/pub/scm/fs/xfs/xfs-linux (2023-08-23 13:09:22 +0200)

Please consider pulling these changes from the signed v6.6-vfs.super tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.super

----------------------------------------------------------------
Christian Brauner (7):
      super: use locking helpers
      super: make locking naming consistent
      super: wait for nascent superblocks
      super: wait until we passed kill super
      super: use higher-level helper for {freeze,thaw}
      Merge tag 'vfs-6.6-merge-2' of ssh://gitolite.kernel.org/pub/scm/fs/xfs/xfs-linux
      Merge tag 'vfs-6.6-merge-3' of ssh://gitolite.kernel.org/pub/scm/fs/xfs/xfs-linux

Christoph Hellwig (38):
      fs: stop using bdev->bd_super in mark_buffer_write_io_error
      ext4: don't use bdev->bd_super in __ext4_journal_get_write_access
      ocfs2: stop using bdev->bd_super for journal error logging
      fs, block: remove bdev->bd_super
      xfs: reformat the xfs_fs_free prototype
      xfs: remove a superfluous s_fs_info NULL check in xfs_fs_put_super
      xfs: free the xfs_mount in ->kill_sb
      xfs: remove xfs_blkdev_put
      xfs: close the RT and log block devices in xfs_free_buftarg
      xfs: close the external block devices in xfs_mount_free
      xfs: document the invalidate_bdev call in invalidate_bdev
      ext4: close the external journal device in ->kill_sb
      exfat: don't RCU-free the sbi
      exfat: free the sbi and iocharset in ->kill_sb
      ntfs3: rename put_ntfs ntfs3_free_sbi
      ntfs3: don't call sync_blockdev in ntfs_put_super
      ntfs3: free the sbi in ->kill_sb
      fs: export setup_bdev_super
      nilfs2: use setup_bdev_super to de-duplicate the mount code
      ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more robust
      fs: use the super_block as holder when mounting file systems
      fs: stop using get_super in fs_mark_dead
      fs: export fs_holder_ops
      ext4: drop s_umount over opening the log device
      ext4: use fs_holder_ops for the log device
      xfs: drop s_umount over opening the log and RT devices
      xfs use fs_holder_ops for the log and RT devices
      nbd: call blk_mark_disk_dead in nbd_clear_sock_ioctl
      block: simplify the disk_force_media_change interface
      floppy: call disk_force_media_change when changing the format
      amiflop: don't call fsync_bdev in FDFMTBEG
      dasd: also call __invalidate_device when setting the device offline
      block: drop the "busy inodes on changed media" log message
      block: consolidate __invalidate_device and fsync_bdev
      block: call into the file system for bdev_mark_dead
      block: call into the file system for ioctl BLKFLSBUF
      fs: remove get_super
      fs: simplify invalidate_inodes

Darrick J. Wong (3):
      fs: distinguish between user initiated freeze and kernel initiated freeze
      fs: wait for partially frozen filesystems
      xfs: stabilize fs summary counters for online fsck

Jan Kara (1):
      fs: open block device after superblock creation

 Documentation/filesystems/vfs.rst |   6 +-
 block/bdev.c                      |  69 ++--
 block/disk-events.c               |  23 +-
 block/genhd.c                     |  45 +--
 block/ioctl.c                     |   9 +-
 block/partitions/core.c           |   5 +-
 drivers/block/amiflop.c           |   1 -
 drivers/block/floppy.c            |   2 +-
 drivers/block/loop.c              |   6 +-
 drivers/block/nbd.c               |   8 +-
 drivers/s390/block/dasd.c         |   7 +-
 fs/buffer.c                       |  11 +-
 fs/cramfs/inode.c                 |   8 +-
 fs/exfat/exfat_fs.h               |   2 -
 fs/exfat/super.c                  |  39 +-
 fs/ext4/ext4_jbd2.c               |   3 +-
 fs/ext4/super.c                   |  69 ++--
 fs/f2fs/gc.c                      |   8 +-
 fs/f2fs/super.c                   |   7 +-
 fs/fs-writeback.c                 |   4 +-
 fs/gfs2/super.c                   |  12 +-
 fs/gfs2/sys.c                     |   4 +-
 fs/inode.c                        |  17 +-
 fs/internal.h                     |   4 +-
 fs/ioctl.c                        |   8 +-
 fs/nilfs2/super.c                 |  81 ++--
 fs/ntfs3/super.c                  |  33 +-
 fs/ocfs2/journal.c                |   6 +-
 fs/romfs/super.c                  |  10 +-
 fs/super.c                        | 765 ++++++++++++++++++++++++++------------
 fs/xfs/scrub/fscounters.c         | 188 ++++++++--
 fs/xfs/scrub/scrub.c              |   6 +-
 fs/xfs/scrub/scrub.h              |   1 +
 fs/xfs/scrub/trace.h              |  26 ++
 fs/xfs/xfs_buf.c                  |   7 +-
 fs/xfs/xfs_super.c                | 136 ++++---
 include/linux/blk_types.h         |   1 -
 include/linux/blkdev.h            |  15 +-
 include/linux/fs.h                |  18 +-
 include/linux/fs_context.h        |   2 +
 40 files changed, 1043 insertions(+), 629 deletions(-)
