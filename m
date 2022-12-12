Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3330964A018
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiLLNUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 08:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiLLNTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:19:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC9B17;
        Mon, 12 Dec 2022 05:19:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38689B80D3B;
        Mon, 12 Dec 2022 13:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71F7C433EF;
        Mon, 12 Dec 2022 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670851185;
        bh=2O1iRYGWL1q5znTFkVBifHJE+LYbc8hsQJjJbgDShoI=;
        h=From:To:Cc:Subject:Date:From;
        b=A1+FQv+dyO78rP2RXD6TIWhQXjQB9UQ59yeEkeuju5IZPr7a7uM0p4hAaM5U/ZO+E
         fKJUMp10cag+dq0VyEl0HwTkAg1o+XXzBSKkqVISZup2i8C9VP2W79atE6f+P3AwLH
         RrGcPkRKSxtQXBptA+qt/Z0c2G7x/SoLU1EfQdhFJHT8nRB6QjhMSbw+evQkWMqOyA
         /Ps5kURDAWEZ00Enm24egGGAwI0sKwdX1Fu33NcYK2pKBdHgv7sKSLoWqkpRIH8yiU
         riiNYYpt2O1Wd0DZLgeRQNIoHl0N0aR0FyFsLxbt87DY4cJPK+K4c7fyzU+3dcBU5t
         7glz7oMb/JGdw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs idmapped updates for v6.2
Date:   Mon, 12 Dec 2022 14:19:15 +0100
Message-Id: <20221212131915.176194-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14397; i=brauner@kernel.org; h=from:subject; bh=2O1iRYGWL1q5znTFkVBifHJE+LYbc8hsQJjJbgDShoI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRP1/K2dPtwnN3kcmn1qvtu0z/VH3NjmpmbFfJd5Pdsgzkc dZdDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS0svwvzZyqn3A4bQ0Z78rRf/03O VFjs9OX/o8kP3sr5Cnk6/l2DD8LzveVhQlej0y4pnIX6dLN/9km6VzHc1v3xN5it/28rtZfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
Last cycle we've already made the interaction with idmapped mounts more robust
and type safe by introducing the vfs{g,u}id_t type. This cycle we concluded the
conversion and removed the legacy helpers.

Currently we still pass around the plain namespace that was attached to a
mount. This is in general pretty convenient but it makes it easy to conflate
namespaces that are relevant on the filesystem- with namespaces that are
relevent on the mount level. Especially for filesystem developers without
detailed knowledge in this area this can be a potential source for bugs.

Instead of passing the plain namespace we introduce a dedicated type struct
mnt_idmap and replace the pointer with a pointer to a struct mnt_idmap. There
are no semantic or size changes for the mount struct caused by this.

We then start converting all places aware of idmapped mounts to rely on struct
mnt_idmap. Once the conversion is done all helpers down to the really low-level
make_vfs{g,u}id() and from_vfs{g,u}id() will take a struct mnt_idmap argument
instead of two namespace arguments. This way it becomes impossible to conflate
the two removing and thus eliminating the possibility of any bugs. Fwiw, I
fixed some issues in that area a while ago in ntfs3 and ksmbd in the past.
Afterwards only low-level code can ultimately use the associated namespace for
any permission checks. Even most of the vfs can be completely obivious about
this ultimately and filesystems will never interact with it in any form in the
future.

A struct mnt_idmap currently encompasses a simple refcount and pointer to the
relevant namespace the mount is idmapped to. If a mount isn't idmapped then it
will point to a static nop_mnt_idmap and if it doesn't that it is idmapped. As
usual there are no allocations or anything happening for non-idmapped mounts.
Everthing is carefully written to be a nop for non-idmapped mounts as has
always been the case.

If an idmapped mount is created a struct mnt_idmap is allocated and a reference
taken on the relevant namespace. Each mount that gets idmapped or inherits the
idmap simply bumps the reference count on struct mnt_idmap. Just a reminder
that we only allow a mount to change it's idmapping a single time and only if
it hasn't already been attached to the filesystems and has no active writers.

The actual changes are fairly straightforward but this will have huge benefits
for maintenance and security in the long run even if it causes some churn.

Note that this also makes it possible to extend struct mount_idmap in the
future. For example, it would be possible to place the namespace pointer in an
anonymous union together with an idmapping struct. This would allow us to
expose an api to userspace that would let it specify idmappings directly
instead of having to go through the detour of setting up namespaces at all.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.1-rc1 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests in fstests,
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.mnt_idmap.v6.2

for you to fetch changes up to 5a6f52d20ce3cd6d30103a27f18edff337da191b:

  acl: conver higher-level helpers to rely on mnt_idmap (2022-10-31 17:48:12 +0100)

Please note the tag contains all other branches for this cycle merged in.
They're on the list at:
(1) vfsuid updates for v6.2
    https://lore.kernel.org/lkml/20221212123348.169903-1-brauner@kernel.org
(2) setgid inheritance updates for v6.2
    https://lore.kernel.org/lkml/20221212112053.99208-1-brauner@kernel.org
(3) acl updates for v6.2
    https://lore.kernel.org/lkml/20221212111919.98855-1-brauner@kernel.org

The
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts")
introduces the infrastructure and
5a6f52d20ce3 ("acl: conver higher-level helpers to rely on mnt_idmap")
builds upon the acl work to convert over a first set of high-level helpers that
don't cause a lot of churn because they have been newly introduced this cycle.

Since it touches the core idmapping header it would cause really a lot of
conflicts with the vfsuid patchset. While I'm aware that you usually don't mind
it would've made things a lot more annoying. So the vfsuid changes are merged
in as well which bring in the setgid changes.

I really prefer splitting pull requests into topcis rather than large patch
dumps but then I run into limits when there's dependencies between the
different topics involved. So far I haven't found out an optimal way of doing
this and I hope this way here is still acceptable. If you have a better way or
would provide me a different tag or branch I'm happy to do so.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.mnt_idmap.v6.2

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: remove privs in ovl_copyfile()
      ovl: remove privs in ovl_fallocate()

Christian Brauner (51):
      attr: add in_group_or_capable()
      fs: move should_remove_suid()
      attr: add setattr_should_drop_sgid()
      attr: use consistent sgid stripping checks
      Merge branch 'fs.ovl.setgid' into for-next
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
      Merge branch 'fs.acl.rework' into for-next
      mnt_idmapping: add missing helpers
      fs: use type safe idmapping helpers
      caps: use type safe idmapping helpers
      apparmor: use type safe idmapping helpers
      ima: use type safe idmapping helpers
      fuse: port to vfs{g,u}id_t and associated helpers
      ovl: port to vfs{g,u}id_t and associated helpers
      fs: remove unused idmapping helpers
      Merge branch 'fs.vfsuid.conversion' into for-next
      acl: make vfs_posix_acl_to_xattr() static
      Merge branch 'fs.acl.rework' into for-next
      cifs: check whether acl is valid early
      Merge branch 'fs.acl.rework' into for-next
      fs: introduce dedicated idmap type for mounts
      acl: conver higher-level helpers to rely on mnt_idmap

 Documentation/filesystems/locking.rst |  10 +-
 Documentation/filesystems/porting.rst |   4 +-
 Documentation/filesystems/vfs.rst     |   5 +-
 Documentation/trace/ftrace.rst        |   2 +-
 fs/9p/acl.c                           | 295 +++++++-------
 fs/9p/acl.h                           |   8 +-
 fs/9p/vfs_inode_dotl.c                |   4 +
 fs/9p/xattr.c                         |   7 +-
 fs/9p/xattr.h                         |   2 -
 fs/attr.c                             |  74 +++-
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
 fs/coredump.c                         |   4 +-
 fs/ecryptfs/inode.c                   |  32 ++
 fs/erofs/inode.c                      |   6 +-
 fs/erofs/namei.c                      |   2 +-
 fs/exec.c                             |  16 +-
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
 fs/fuse/acl.c                         |   5 +-
 fs/fuse/dir.c                         |   4 +-
 fs/fuse/file.c                        |   2 +-
 fs/fuse/fuse_i.h                      |   2 +-
 fs/gfs2/acl.c                         |   3 +-
 fs/gfs2/acl.h                         |   2 +-
 fs/gfs2/inode.c                       |   6 +-
 fs/inode.c                            |  72 ++--
 fs/internal.h                         |  35 +-
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
 fs/namei.c                            |  44 +--
 fs/namespace.c                        | 176 +++++++--
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
 fs/ocfs2/file.c                       |   8 +-
 fs/ocfs2/namei.c                      |   2 +-
 fs/open.c                             |   8 +-
 fs/orangefs/acl.c                     |  47 +--
 fs/orangefs/inode.c                   |  47 ++-
 fs/orangefs/namei.c                   |   2 +-
 fs/orangefs/orangefs-kernel.h         |   8 +-
 fs/orangefs/orangefs-utils.c          |  10 +-
 fs/overlayfs/copy_up.c                |  38 ++
 fs/overlayfs/dir.c                    |  22 +-
 fs/overlayfs/file.c                   |  28 +-
 fs/overlayfs/inode.c                  | 187 +++++++--
 fs/overlayfs/overlayfs.h              |  42 +-
 fs/overlayfs/super.c                  | 107 +----
 fs/overlayfs/util.c                   |   9 +-
 fs/posix_acl.c                        | 725 +++++++++++++++++-----------------
 fs/reiserfs/acl.h                     |   6 +-
 fs/reiserfs/file.c                    |   2 +-
 fs/reiserfs/inode.c                   |   2 +-
 fs/reiserfs/namei.c                   |   4 +-
 fs/reiserfs/xattr_acl.c               |  11 +-
 fs/remap_range.c                      |   2 +-
 fs/stat.c                             |   7 +-
 fs/xattr.c                            | 116 +++---
 fs/xfs/xfs_acl.c                      |   3 +-
 fs/xfs/xfs_acl.h                      |   2 +-
 fs/xfs/xfs_iops.c                     |  16 +-
 include/linux/evm.h                   |  49 +++
 include/linux/fs.h                    |  56 +--
 include/linux/ima.h                   |  24 ++
 include/linux/lsm_hook_defs.h         |   6 +
 include/linux/lsm_hooks.h             |  12 +
 include/linux/mnt_idmapping.h         | 108 ++---
 include/linux/mount.h                 |   9 +-
 include/linux/posix_acl.h             |  41 +-
 include/linux/posix_acl_xattr.h       |  47 ++-
 include/linux/security.h              |  29 ++
 include/linux/xattr.h                 |   6 +
 io_uring/xattr.c                      |   8 +-
 kernel/capability.c                   |   4 +-
 mm/shmem.c                            |   2 +-
 security/apparmor/domain.c            |   8 +-
 security/apparmor/file.c              |   4 +-
 security/apparmor/lsm.c               |  25 +-
 security/commoncap.c                  |  51 +--
 security/integrity/evm/evm_main.c     | 147 ++++---
 security/integrity/ima/ima_appraise.c |   9 +
 security/integrity/ima/ima_policy.c   |  34 +-
 security/security.c                   |  42 ++
 security/selinux/hooks.c              |  22 ++
 security/smack/smack_lsm.c            |  71 ++++
 131 files changed, 2291 insertions(+), 1439 deletions(-)
