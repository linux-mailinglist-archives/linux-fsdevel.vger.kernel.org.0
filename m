Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6358D3C6F37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhGMLSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMLSH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 534B56023F;
        Tue, 13 Jul 2021 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174917;
        bh=zLRIz5p5ourrK1LiN61koDqQ3x8/edeGXrFSrIxyOGs=;
        h=From:To:Cc:Subject:Date:From;
        b=Y+p/jMdydLbpPOIa6w6s0vQ1875AjmoVTlyYQl8qZxs8FsLWO0lDmcVkrxnMM6sKI
         U8NItXF49aJ1Wf4ER4hs7v/Pgq1bp4klfiNizlYqIj1KpzrpB1FZ4WIf3+EVKzd62c
         j6wo26AkItMCMt2pV1EUmQiMGLoGDlVYDxHoPTIMPGjT0qlyq1VTNGoN2vlrAac8Br
         OnctXgEKzAekP7RcxdP73Y9YYFJgbZwsR/X0xpazfMXYdhXmKl7GTBec5CfYWCCmAL
         izX7rMu1sf/BOeX6tb1MKox1UjUxE04UL5ZavUX1wyR6QbyuF8GN5y/Ubb9+fWzrCv
         RFiLbsgIkyd8A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 00/24] btrfs: support idmapped mounts
Date:   Tue, 13 Jul 2021 13:13:20 +0200
Message-Id: <20210713111344.1149376-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5722; h=from:subject; bh=sdqEN4uw+nlUNPCZNK8c16q/IAiwG0V4khK6UQee5KU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LQ1/OdP5mvPtuTLLq0KuTXy6MshEc83NxmVV096ziv78 Wv8vu6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiMQcZ/uewMVUkvP2Varj8N1/Em7 tNglW79fvqtp66vYTXLebij50M/8t1LYS3S3DyBfN/57ivmbY56M9hl627Z+uvsrRg7b2xghEA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

This series enables the creation of idmapped mounts on btrfs. On the list of
filesystems btrfs was pretty high-up and requested quite often from userspace
(cf. [1]). This series requires just a few changes to the vfs for specific
lookup helpers that btrfs relies on to perform permission checking when looking
up an inode. The changes are required to port some other filesystem as well.

The conversion of the necessary btrfs internals was fairly straightforward. No
invasive changes were needed. I've decided to split up the patchset into very
small individual patches. This hopefully makes the series more readable and
fairly easy to review. The overall changeset is quite small.

All non-filesystem wide ioctls that peform permission checking based on inodes
can be supported on idmapped mounts. There are really just a few restrictions.
This should really only affect the deletion of subvolumes by subvolume id which
can be used to delete any subvolume in the filesystem even though the caller
might not even be able to see the subvolume under their mount. Other than that
behavior on idmapped and non-idmapped mounts is identical for all enabled
ioctls.

The changeset has an associated new testsuite specific to btrfs. The
core vfs operations that btrfs implements are covered by the generic
idmapped mount testsuite. For the ioctls a new testsuite was added. It
is sent alongside this patchset for ease of review but will very likely
be merged independent of it.

All patches are based on v5.14-rc1.

The series can be pulled from:
https://git.kernel.org/brauner/h/fs.idmapped.btrfs
https://github.com/brauner/linux/tree/fs.idmapped.btrfs

The xfstests can be pulled from:
https://git.kernel.org/brauner/xfstests-dev/h/fs.idmapped.btrfs
https://github.com/brauner/xfstests/tree/fs.idmapped.btrfs

Note, the new btrfs xfstests patch is on top of a branch of mine
containing a few more preliminary patches. So if you want to run the
tests, please simply pull the branch and build from there. It's based on
latest xfstests master.

The series has been tested with xfstests including the newly added btrfs
specific test. All tests pass.
There were three unrelated failures that I observed: btrfs/219,
btrfs/2020 and btrfs/235. All three also fail on earlier kernels
without the patch series applied.

Thanks!
Christian

[1]: https://github.com/systemd/systemd/pull/19438#discussion_r622807165

Christian Brauner (23):
  namei: handle mappings in lookup_one_len()
  namei: handle mappings in lookup_one_len_unlocked()
  namei: handle mappings in lookup_positive_unlocked()
  namei: handle mappings in try_lookup_one_len()
  btrfs/inode: handle idmaps in btrfs_new_inode()
  btrfs/inode: allow idmapped rename iop
  btrfs/inode: allow idmapped getattr iop
  btrfs/inode: allow idmapped mknod iop
  btrfs/inode: allow idmapped create iop
  btrfs/inode: allow idmapped mkdir iop
  btrfs/inode: allow idmapped symlink iop
  btrfs/inode: allow idmapped tmpfile iop
  btrfs/inode: allow idmapped setattr iop
  btrfs/inode: allow idmapped permission iop
  btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume
    creation
  btrfs/inode: allow idmapped BTRFS_IOC_{SNAP,SUBVOL}_CREATE{_V2} ioctl
  btrfs/ioctl: allow idmapped BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
  btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with
    subvolids
  btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
  btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
  btrfs/ioctl: allow idmapped BTRFS_IOC_INO_LOOKUP_USER ioctl
  btrfs/acl: handle idmapped mounts
  btrfs/super: allow idmapped btrfs

 arch/s390/hypfs/inode.c            |  2 +-
 drivers/android/binderfs.c         |  4 +-
 drivers/infiniband/hw/qib/qib_fs.c |  5 +-
 fs/afs/dir.c                       |  2 +-
 fs/afs/dir_silly.c                 |  2 +-
 fs/afs/dynroot.c                   |  6 +-
 fs/binfmt_misc.c                   |  2 +-
 fs/btrfs/acl.c                     | 13 +++--
 fs/btrfs/ctree.h                   |  3 +-
 fs/btrfs/inode.c                   | 62 +++++++++++---------
 fs/btrfs/ioctl.c                   | 94 ++++++++++++++++++++----------
 fs/btrfs/super.c                   |  2 +-
 fs/cachefiles/namei.c              |  9 +--
 fs/cifs/cifsfs.c                   |  3 +-
 fs/debugfs/inode.c                 |  9 ++-
 fs/ecryptfs/inode.c                |  3 +-
 fs/exportfs/expfs.c                |  6 +-
 fs/kernfs/mount.c                  |  4 +-
 fs/namei.c                         | 32 ++++++----
 fs/nfs/unlink.c                    |  3 +-
 fs/nfsd/nfs3xdr.c                  |  3 +-
 fs/nfsd/nfs4recover.c              |  7 ++-
 fs/nfsd/nfs4xdr.c                  |  3 +-
 fs/nfsd/nfsproc.c                  |  3 +-
 fs/nfsd/vfs.c                      | 19 +++---
 fs/overlayfs/copy_up.c             | 10 ++--
 fs/overlayfs/dir.c                 | 23 ++++----
 fs/overlayfs/export.c              |  3 +-
 fs/overlayfs/namei.c               | 13 +++--
 fs/overlayfs/readdir.c             | 12 ++--
 fs/overlayfs/super.c               |  8 ++-
 fs/overlayfs/util.c                |  2 +-
 fs/quota/dquot.c                   |  3 +-
 fs/reiserfs/xattr.c                | 14 ++---
 fs/tracefs/inode.c                 |  3 +-
 include/linux/namei.h              | 12 ++--
 ipc/mqueue.c                       |  5 +-
 kernel/bpf/inode.c                 |  2 +-
 security/apparmor/apparmorfs.c     |  5 +-
 security/inode.c                   |  2 +-
 40 files changed, 250 insertions(+), 168 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.30.2

