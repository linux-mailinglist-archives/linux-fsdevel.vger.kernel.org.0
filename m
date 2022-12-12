Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E89649D70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 12:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiLLLWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 06:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiLLLVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:21:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37922640;
        Mon, 12 Dec 2022 03:19:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B69760F97;
        Mon, 12 Dec 2022 11:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63189C433EF;
        Mon, 12 Dec 2022 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670843974;
        bh=mRaqERebZbDDBpldKv8EixhFOw6NSML6BFi90OjI42A=;
        h=From:To:Cc:Subject:Date:From;
        b=Qy2sEfAPGlSqhZ6Cic1cYh2j+VtvcCh0EVyGGwJ1K2IqCpELXN2bD9AEk1eHYZWtz
         QE5MlZlRq/2ZX5StvWthOSNXiGCz8kC4OPq7c0AwJUlIBZZO2QiGpVwTHq2NcmArtU
         ASMJOE/ypAfUzOPXdF/s/SVPGVKilj8zWsOHsjJkvu89XA5m54oPPYmJ0em7r2PeTf
         qtm4QIgOSjY8stMavWZV/U/iWffmwUOeViDjGZxn0ClJ4hQtVEJVk89MrJl5jtIYVs
         LGGdZxEL4anbzlNr6qgvkUfiTuOpPOfby6SAqR6yN6fRvmwRBKs694imMlyQN4MDOO
         2xM9QU6qdWj4w==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] acl updates for v6.2
Date:   Mon, 12 Dec 2022 12:19:19 +0100
Message-Id: <20221212111919.98855-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16149; i=brauner@kernel.org; h=from:subject; bh=mRaqERebZbDDBpldKv8EixhFOw6NSML6BFi90OjI42A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRP59NOFWXgmPP2+c+ThsV2ehudUg4U1e3e6v+oZVtyqVrK RK7qjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlotzD8D7RdOO078/LXhw9Nqgry2f km/Z55omvouUihCfbmPIv+bWdk2Gp+rKfUqvnI+dbV18pEljiHuC5ZF/rUbHJCrqmq/NtkJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains the work that builds a dedicated vfs posix acl api. The origins
of this work trace back to v5.19 but it took quite a while to understand the
various filesystem specific implementations in sufficient detail and also come
up with an acceptable solution.

As we discussed and seen multiple times the current state of how posix acls are
handled isn't nice and comes with a lot of problems. For a long and detailed
explanation for just some of the issues [1] provides a good summary.

The current way of handling posix acls via the generic xattr api is error
prone, hard to maintain, and type unsafe for the vfs until we call into the
filesystem's dedicated get and set inode operations.

It is already the case that posix acls are special-cased to death all the way
through the vfs. There are an uncounted number of hacks that operate on the
uapi posix acl struct instead of the dedicated vfs struct posix_acl. And the
vfs must be involved in order to interpret and fixup posix acls before storing
them to the backing store, caching them, reporting them to userspace, or for
permission checking.

Currently a range of hacks and duct tape exist to make this work. As with most
things this is really no ones fault it's just something that happened over
time. But the code is hard to understand and difficult to maintain and one is
constantly at risk of introducing bugs and regressions when having to touch it.

Instead of continuing to hack posix acls through the xattr handlers this series
builds a dedicated posix acl api solely around the get and set inode
operations. Going forward, the vfs_get_acl(), vfs_remove_acl(), and
vfs_set_acl() helpers must be used in order to interact with posix acls. They
operate directly on the vfs internal struct posix_acl instead of abusing the
uapi posix acl struct as we currently do. In the end this removes all of the
hackiness, makes the codepaths easier to maintain, and gets us type safety.

This series passes the LTP and xfstests suites without any regressions. For
xfstests the following combinations were tested:

* xfs
* ext4
* btrfs
* overlayfs
* overlayfs on top of idmapped mounts
* orangefs
* (limited) cifs

There's more simplifications for posix acls that we can make in the future if
the basic api has made it.

A few implementation details:

* The series makes sure to retain exactly the same security and integrity module
  permission checks. See [2] for annotated callchains. Especially for the
  integrity modules this api is a win because right now they convert the uapi
  posix acl struct passed to them via a void pointer into the vfs struct
  posix_acl format to perform permission checking on the mode.

  There's a new dedicated security hook for setting posix acls which passes the
  vfs struct posix_acl not a void pointer. Basing checking on the posix acl
  stored in the uapi format is really unreliable. The vfs currently hacks around
  directly in the uapi struct storing values that frankly the security and
  integrity modules can't correctly interpret as evidenced by bugs we reported
  and fixed in this area. It's not necessarily even their fault it's just that
  the format we provide to them is sub optimal.

* Some filesystems like 9p and cifs need access to the dentry in order to get
  and set posix acls which is why they either only partially or not even at all
  implement get and set inode operations. For example, cifs allows setxattr()
  and getxattr() operations but doesn't allow permission checking based on posix
  acls because it can't implement a get acl inode operation.

  Thus, this patch series updates the set acl inode operation to take a dentry
  instead of an inode argument. However, for the get acl inode operation we
  can't do this as the old get acl method is called in e.g.,
  generic_permission() and inode_permission(). These helpers in turn are called
  in various filesystem's permission inode operation. So passing a dentry
  argument to the old get acl inode operation would amount to passing a dentry
  to the permission inode operation which we shouldn't and probably can't do.

  So instead of extending the existing inode operation Christoph suggested to
  add a new one. He also requested to ensure that the get and set acl inode
  operation taking a dentry are consistently named. So for this version the old
  get acl operation is renamed to ->get_inode_acl() and a new ->get_acl() inode
  operation taking a dentry is added. With this we can give both 9p and cifs get
  and set acl inode operations and in turn remove their complex custom posix
  xattr handlers.

  In the future I hope to get rid of the inode method duplication but it isn't
  like we have never had this situation. Readdir is just one example. And
  frankly, the overall gain in type safety and the more pleasant api wise are
  simply too big of a benefit to not accept this duplication for a while.

* We've done a full audit of every codepaths using variant of the current
  generic xattr api to get and set posix acls and surprisingly it isn't
  that many places. There's of course always a chance that we might have missed
  some and if so I'm sure we'll find them soon enough.

  The crucial codepaths to be converted are obviously stacking filesystems such
  as ecryptfs and overlayfs.

  For a list of all callers currently using generic xattr api helpers see [2]
  including comments whether they support posix acls or not.

* The old vfs generic posix acl infrastructure doesn't obey the create and
  replace semantics promised on the setxattr(2) manpage. This patch series
  doesn't address this. It really is something we should revisit later though.

The patches in this PR are roughly organized as follows:

(1) Change existing set acl inode operation to take a dentry argument.
   (Intended to be a non-functional change.)

(2) Rename existing get acl method.
    (Intended to be a non-functional change.)

(3) Implement get and set acl inode operations for filesystems that couldn't
    implement one before because of the missing dentry. That's mostly 9p and
    cifs.
    (Intended to be a non-functional change.)

(4) Build posix acl api, i.e., add vfs_get_acl(), vfs_remove_acl(), and
    vfs_set_acl() including security and integrity hooks.
    (Intended to be a non-functional change.)

(5) Implement get and set acl inode operations for stacking filesystems.
    (Intended to be a non-functional change.)

(6) Switch posix acl handling in stacking filesystems to new posix acl api now
    that all filesystems it can stack upon support it.

(7) Switch vfs to new posix acl api
    (semantical change)

(8) Remove all now unused helpers

(9) Additional regression fixes reported after we merged this into linux-next
    after v6.1-rc1:
    e40df4281b86 orangefs: fix mode handling
    5b52aebef895 ovl: call posix_acl_release() after error checking
    16257cf6658d evm: remove dead code in evm_inode_set_acl()
    cb2144d66b0b cifs: check whether acl is valid early

Thanks to Seth for a lot of good discussion around this and encouragement and
input from Christoph.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.2-rc1 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests in fstests,
selftests, and LTP pass without regressions. But a series like this has of
course regression potential and it's almost impossible to run fstests for all
filesystems that are touched. For a bunch of them I wouldn't even know how to
test them. Even just runing orangefs was a lot of additional time and work. So
we'll need to watch out for any issues.

/* Conflicts */
Please note, that linux-next reported a build failure with the NTFS3 tree. The
NTFS3 tree contains changes to their POSIX ACL handling that rely on a helper
that got renamed in this series. Stephen reported and posted an accurate simple
patch to fix this. He suggested to simply point you to the reported failure and
the patch:

https://lore.kernel.org/lkml/20221115101756.5d311f25@canb.auug.org.au

There were no merge conflicts when doing a test merge with current mainline
based on the v6.1 pushed yesterday.
mainline.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.rework.v6.2

for you to fetch changes up to d6fdf29f7b99814d3673f2d9f4649262807cb836:

  posix_acl: Fix the type of sentinel in get_acl (2022-12-02 10:01:28 +0100)

Please consider pulling these changes from the signed fs.acl.rework.v6.2 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.acl.rework.v6.2

----------------------------------------------------------------
Christian Brauner (35):
      orangefs: rework posix acl handling when creating new filesystem objects
      fs: pass dentry to set acl method
      fs: rename current get acl method
      fs: add new get acl method
      cifs: implement get acl method
      cifs: implement set acl method
      9p: implement get acl method
      9p: implement set acl method
      security: add get, remove and set acl hook
      selinux: implement get, set and remove acl hook
      smack: implement get, set and remove acl hook
      integrity: implement get and set acl hook
      evm: add post set acl hook
      internal: add may_write_xattr()
      acl: add vfs_set_acl()
      acl: add vfs_get_acl()
      acl: add vfs_remove_acl()
      ksmbd: use vfs_remove_acl()
      ecryptfs: implement get acl method
      ecryptfs: implement set acl method
      ovl: implement get acl method
      ovl: implement set acl method
      ovl: use posix acl api
      xattr: use posix acl api
      evm: remove evm_xattr_acl_change()
      ecryptfs: use stub posix acl handlers
      ovl: use stub posix acl handlers
      cifs: use stub posix acl handlers
      9p: use stub posix acl handlers
      acl: remove a slew of now unused helpers
      acl: make vfs_posix_acl_to_xattr() static
      cifs: check whether acl is valid early
      evm: remove dead code in evm_inode_set_acl()
      ovl: call posix_acl_release() after error checking
      orangefs: fix mode handling

Uros Bizjak (1):
      posix_acl: Fix the type of sentinel in get_acl

 Documentation/filesystems/locking.rst |  10 +-
 Documentation/filesystems/porting.rst |   4 +-
 Documentation/filesystems/vfs.rst     |   5 +-
 fs/9p/acl.c                           | 295 +++++++-------
 fs/9p/acl.h                           |   8 +-
 fs/9p/vfs_inode_dotl.c                |   4 +
 fs/9p/xattr.c                         |   7 +-
 fs/9p/xattr.h                         |   2 -
 fs/bad_inode.c                        |   4 +-
 fs/btrfs/acl.c                        |   3 +-
 fs/btrfs/ctree.h                      |   2 +-
 fs/btrfs/inode.c                      |   8 +-
 fs/ceph/acl.c                         |   3 +-
 fs/ceph/dir.c                         |   2 +-
 fs/ceph/inode.c                       |   4 +-
 fs/ceph/super.h                       |   2 +-
 fs/cifs/cifsacl.c                     | 139 +++++++
 fs/cifs/cifsfs.c                      |   4 +
 fs/cifs/cifsproto.h                   |  20 +-
 fs/cifs/cifssmb.c                     | 206 ++++++----
 fs/cifs/xattr.c                       |  68 +---
 fs/ecryptfs/inode.c                   |  32 ++
 fs/erofs/inode.c                      |   6 +-
 fs/erofs/namei.c                      |   2 +-
 fs/ext2/acl.c                         |   3 +-
 fs/ext2/acl.h                         |   2 +-
 fs/ext2/file.c                        |   2 +-
 fs/ext2/inode.c                       |   2 +-
 fs/ext2/namei.c                       |   4 +-
 fs/ext4/acl.c                         |   3 +-
 fs/ext4/acl.h                         |   2 +-
 fs/ext4/file.c                        |   2 +-
 fs/ext4/ialloc.c                      |   2 +-
 fs/ext4/inode.c                       |   2 +-
 fs/ext4/namei.c                       |   4 +-
 fs/f2fs/acl.c                         |   4 +-
 fs/f2fs/acl.h                         |   2 +-
 fs/f2fs/file.c                        |   4 +-
 fs/f2fs/namei.c                       |   4 +-
 fs/fuse/acl.c                         |   3 +-
 fs/fuse/dir.c                         |   4 +-
 fs/fuse/fuse_i.h                      |   2 +-
 fs/gfs2/acl.c                         |   3 +-
 fs/gfs2/acl.h                         |   2 +-
 fs/gfs2/inode.c                       |   6 +-
 fs/internal.h                         |  21 +
 fs/jffs2/acl.c                        |   3 +-
 fs/jffs2/acl.h                        |   2 +-
 fs/jffs2/dir.c                        |   2 +-
 fs/jffs2/file.c                       |   2 +-
 fs/jffs2/fs.c                         |   2 +-
 fs/jfs/acl.c                          |   3 +-
 fs/jfs/file.c                         |   4 +-
 fs/jfs/jfs_acl.h                      |   2 +-
 fs/jfs/namei.c                        |   2 +-
 fs/ksmbd/smb2pdu.c                    |   8 +-
 fs/ksmbd/smbacl.c                     |   6 +-
 fs/ksmbd/vfs.c                        |  21 +-
 fs/ksmbd/vfs.h                        |   4 +-
 fs/namei.c                            |   4 +-
 fs/nfs/nfs3_fs.h                      |   2 +-
 fs/nfs/nfs3acl.c                      |   9 +-
 fs/nfs/nfs3proc.c                     |   4 +-
 fs/nfsd/nfs2acl.c                     |   8 +-
 fs/nfsd/nfs3acl.c                     |   8 +-
 fs/nfsd/nfs4acl.c                     |   4 +-
 fs/nfsd/vfs.c                         |   4 +-
 fs/ntfs3/file.c                       |   4 +-
 fs/ntfs3/namei.c                      |   4 +-
 fs/ntfs3/ntfs_fs.h                    |   4 +-
 fs/ntfs3/xattr.c                      |   9 +-
 fs/ocfs2/acl.c                        |   3 +-
 fs/ocfs2/acl.h                        |   2 +-
 fs/ocfs2/file.c                       |   4 +-
 fs/ocfs2/namei.c                      |   2 +-
 fs/orangefs/acl.c                     |  47 +--
 fs/orangefs/inode.c                   |  54 ++-
 fs/orangefs/namei.c                   |   2 +-
 fs/orangefs/orangefs-kernel.h         |   7 +-
 fs/overlayfs/copy_up.c                |  38 ++
 fs/overlayfs/dir.c                    |  22 +-
 fs/overlayfs/inode.c                  | 187 +++++++--
 fs/overlayfs/overlayfs.h              |  42 +-
 fs/overlayfs/super.c                  | 107 +----
 fs/posix_acl.c                        | 725 +++++++++++++++++-----------------
 fs/reiserfs/acl.h                     |   6 +-
 fs/reiserfs/file.c                    |   2 +-
 fs/reiserfs/inode.c                   |   2 +-
 fs/reiserfs/namei.c                   |   4 +-
 fs/reiserfs/xattr_acl.c               |  11 +-
 fs/xattr.c                            |  85 ++--
 fs/xfs/xfs_acl.c                      |   3 +-
 fs/xfs/xfs_acl.h                      |   2 +-
 fs/xfs/xfs_iops.c                     |  16 +-
 include/linux/evm.h                   |  49 +++
 include/linux/fs.h                    |  10 +-
 include/linux/ima.h                   |  24 ++
 include/linux/lsm_hook_defs.h         |   6 +
 include/linux/lsm_hooks.h             |  12 +
 include/linux/posix_acl.h             |  41 +-
 include/linux/posix_acl_xattr.h       |  47 ++-
 include/linux/security.h              |  29 ++
 include/linux/xattr.h                 |   6 +
 mm/shmem.c                            |   2 +-
 security/integrity/evm/evm_main.c     | 146 ++++---
 security/integrity/ima/ima_appraise.c |   9 +
 security/security.c                   |  42 ++
 security/selinux/hooks.c              |  22 ++
 security/smack/smack_lsm.c            |  71 ++++
 109 files changed, 1820 insertions(+), 1117 deletions(-)
