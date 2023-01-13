Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3CF6695F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjAMLwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241396AbjAMLwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BC3C0C6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D9F7B82125
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0756DC433F0;
        Fri, 13 Jan 2023 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610582;
        bh=WNl4ToSvbveP1faMNW8kAMnIaW0HUBoTX4+k3fTaR0Q=;
        h=From:Subject:Date:To:Cc:From;
        b=uieffSos5kl0uXXOrWqKKoikhBg8q4ewScGQR+5QmUcrKpgtC+uR0jHl7CKu2L2GS
         ow50AKUhDJVvWijD2tC/BBLkgYY/D43wJE4zUuuvMi9Twl4BS0I9VznPZiYU6pcN+D
         BY2Ni6F82Bn53oXxV3+PkP3/IrU4BSqOa0bYOJKoSJmdrgf84YtyfZmR1deW0O6TPY
         VqN2DEnc34Q6JWCV/RY6xhuI3eYUdlOMmwOPdoaWoIGsTZWOkCo7UUUWyjrc/mFV7f
         I2r1q+6gFk/oqrelzHNTHWfiljaNyWFkKlZsoerlTQaKLp5UzD5lIAz5huEmI0qgs/
         kcH8Phe1Ljsyw==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/25] fs: finish conversion to mnt_idmap
Date:   Fri, 13 Jan 2023 12:49:09 +0100
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADdFwWMC/0XOQQrDIBCF4auEWXdETUlpr1JKUTM2LmLECaEQc
 vdqIOnyH/geswJTDsTwaFbItAQOUyyhLg24wcQPYehLg5a6lUq16LlcRpMS9TjG+b0HuikulCv
 Gq7Ja2vutk7qDMmMNE9psohvqkGdxeHF68feVpEw+fPevnq9t+wFAONt/pQAAAA==
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=24952; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WNl4ToSvbveP1faMNW8kAMnIaW0HUBoTX4+k3fTaR0Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA38fOIJ++XUvY5P45/VtnAwa7zemuZqc6L2MJemqVnu
 7Y3bOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSZsPwv/Zb0uEolaMSNx84LbDZo1
 emz2i093aZwzLvA0ccEmeK3mdkuH16DX+nhJ9o9TEx38bwK441t7Y75j4vW+X6X+YM1451/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

Last cycle we introduced struct mnt_idmap in
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts")
and converted the posix acl high-level helpers over in
5a6f52d20ce3 ("acl: conver higher-level helpers to rely on mnt_idmap").

This series converts all places that currently still pass around a plain
namespace attached to a mount to passing around a separate type eliminating
all bugs that can arise from conflating filesystem and mount idmappings.
After this series nothing will have changed semantically.

Currently, functions that map filesystem wide {g,u}ids into a mount
specific idmapping take two namespace pointers, the pointer to the mount
idmapping and the pointer to the filesystem idmapping. As they are of the
same type it is easy to accidently pass a mount idmapping as a filesystem
idmapping and vica versa. In addition, as the mount idmapping is of the
same type as the filesystem idmapping, it can be passed to all {g,u}id
translation functions. This is a source of bugs. We fixed a few such bugs
already and in fact this series starts with a similar bugfix.

With the introduction of struct mnt_idmap last cycle we can now eliminate
all these bugs. Instead of two namespace arguments all functions that map
filesystem wide {g,u}ids into mount specific idmappings now take a struct
mnt_idmap and a filesystem namespace argument. This lets the compiler catch
any error where a mount idmapping is conflated with a filesystem idmapping.

Similarly, since all functions that generate filesystem wide k{g,u}id_ts
only accept a namespace as an argument it is impossible to pass a mount
idmapping to them eliminating the possibility of accidently generating
nonsense {g,u}ids.

At the end of this conversion struct mnt_idmap becomes opaque to nearly all
of the vfs and to all filesystems. It's moved into separate file and this file
is the only place where it is accessed. In addition to type safety, easier
maintenance, and easier handling and development for filesystem developers it
also makes it possible to extend idmappings in the future such that we can
allow userspace to set up idmapping without having to go through the detour of
using namespaces at all.

Note, that this is an additional improvement on top of the introduction of
the vfs{g,u}id_t conversion we did in earlier cycles which already makes it
impossible to conflate filesystem wide k{g,u}id_t with mount specific
vfs{g,u}id_t.

The series is available in the Git repository at:

ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.mnt_idmap.conversion.v1

Fstests, selftests, and LTP pass without regressions.

Thanks!
Christian

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Christian Brauner (25):
      f2fs: project ids aren't idmapped
      fs: port vfs_*() helpers to struct mnt_idmap
      fs: port ->setattr() to pass mnt_idmap
      fs: port ->getattr() to pass mnt_idmap
      fs: port ->create() to pass mnt_idmap
      fs: port ->symlink() to pass mnt_idmap
      fs: port ->mkdir() to pass mnt_idmap
      fs: port ->mknod() to pass mnt_idmap
      fs: port ->rename() to pass mnt_idmap
      fs: port ->tmpfile() to pass mnt_idmap
      fs: port ->get_acl() to pass mnt_idmap
      fs: port ->set_acl() to pass mnt_idmap
      fs: port ->fileattr_set() to pass mnt_idmap
      fs: port ->permission() to pass mnt_idmap
      fs: port xattr to mnt_idmap
      fs: port acl to mnt_idmap
      fs: port inode_init_owner() to mnt_idmap
      fs: port inode_owner_or_capable() to mnt_idmap
      fs: port privilege checking helpers to mnt_idmap
      quota: port to mnt_idmap
      fs: port i_{g,u}id_{needs_}update() to mnt_idmap
      fs: port i_{g,u}id_into_vfs{g,u}id() to mnt_idmap
      fs: port fs{g,u}id helpers to mnt_idmap
      fs: port vfs{g,u}id helpers to mnt_idmap
      fs: move mnt_idmap

 Documentation/filesystems/locking.rst            |  24 +-
 Documentation/filesystems/vfs.rst                |  24 +-
 MAINTAINERS                                      |   2 +-
 arch/powerpc/platforms/cell/spufs/inode.c        |   8 +-
 drivers/android/binderfs.c                       |   4 +-
 drivers/base/devtmpfs.c                          |  12 +-
 fs/9p/acl.c                                      |  10 +-
 fs/9p/acl.h                                      |   4 +-
 fs/9p/v9fs.h                                     |   2 +-
 fs/9p/v9fs_vfs.h                                 |   2 +-
 fs/9p/vfs_inode.c                                |  38 +-
 fs/9p/vfs_inode_dotl.c                           |  32 +-
 fs/9p/xattr.c                                    |   2 +-
 fs/Makefile                                      |   2 +-
 fs/adfs/adfs.h                                   |   2 +-
 fs/adfs/inode.c                                  |   4 +-
 fs/affs/affs.h                                   |  10 +-
 fs/affs/inode.c                                  |   6 +-
 fs/affs/namei.c                                  |   8 +-
 fs/afs/dir.c                                     |  16 +-
 fs/afs/inode.c                                   |   6 +-
 fs/afs/internal.h                                |   6 +-
 fs/afs/security.c                                |   2 +-
 fs/afs/xattr.c                                   |   4 +-
 fs/attr.c                                        | 129 ++++---
 fs/autofs/root.c                                 |  14 +-
 fs/bad_inode.c                                   |  20 +-
 fs/bfs/dir.c                                     |   6 +-
 fs/btrfs/acl.c                                   |   4 +-
 fs/btrfs/acl.h                                   |   2 +-
 fs/btrfs/btrfs_inode.h                           |   2 +-
 fs/btrfs/inode.c                                 |  52 +--
 fs/btrfs/ioctl.c                                 |  70 ++--
 fs/btrfs/ioctl.h                                 |   2 +-
 fs/btrfs/tests/btrfs-tests.c                     |   2 +-
 fs/btrfs/xattr.c                                 |   4 +-
 fs/cachefiles/interface.c                        |   4 +-
 fs/cachefiles/namei.c                            |  12 +-
 fs/cachefiles/xattr.c                            |  10 +-
 fs/ceph/acl.c                                    |   4 +-
 fs/ceph/dir.c                                    |  12 +-
 fs/ceph/inode.c                                  |  14 +-
 fs/ceph/super.h                                  |   8 +-
 fs/ceph/xattr.c                                  |   2 +-
 fs/cifs/cifsacl.c                                |   4 +-
 fs/cifs/cifsfs.c                                 |   4 +-
 fs/cifs/cifsfs.h                                 |  14 +-
 fs/cifs/cifsproto.h                              |   4 +-
 fs/cifs/dir.c                                    |   4 +-
 fs/cifs/inode.c                                  |  18 +-
 fs/cifs/link.c                                   |   2 +-
 fs/cifs/xattr.c                                  |   2 +-
 fs/coda/coda_linux.h                             |   6 +-
 fs/coda/dir.c                                    |  10 +-
 fs/coda/inode.c                                  |   6 +-
 fs/coda/pioctl.c                                 |   4 +-
 fs/configfs/configfs_internal.h                  |   4 +-
 fs/configfs/dir.c                                |   2 +-
 fs/configfs/inode.c                              |   4 +-
 fs/configfs/symlink.c                            |   4 +-
 fs/coredump.c                                    |   8 +-
 fs/crypto/policy.c                               |   2 +-
 fs/debugfs/inode.c                               |   6 +-
 fs/ecryptfs/crypto.c                             |   2 +-
 fs/ecryptfs/inode.c                              |  70 ++--
 fs/ecryptfs/mmap.c                               |   2 +-
 fs/efivarfs/inode.c                              |   4 +-
 fs/erofs/inode.c                                 |   4 +-
 fs/erofs/internal.h                              |   2 +-
 fs/exec.c                                        |  14 +-
 fs/exfat/exfat_fs.h                              |   4 +-
 fs/exfat/file.c                                  |  10 +-
 fs/exfat/namei.c                                 |   6 +-
 fs/exportfs/expfs.c                              |   4 +-
 fs/ext2/acl.c                                    |   4 +-
 fs/ext2/acl.h                                    |   2 +-
 fs/ext2/ext2.h                                   |   6 +-
 fs/ext2/ialloc.c                                 |   2 +-
 fs/ext2/inode.c                                  |  20 +-
 fs/ext2/ioctl.c                                  |   6 +-
 fs/ext2/namei.c                                  |  12 +-
 fs/ext2/xattr_security.c                         |   2 +-
 fs/ext2/xattr_trusted.c                          |   2 +-
 fs/ext2/xattr_user.c                             |   2 +-
 fs/ext4/acl.c                                    |   4 +-
 fs/ext4/acl.h                                    |   2 +-
 fs/ext4/ext4.h                                   |  16 +-
 fs/ext4/ialloc.c                                 |   6 +-
 fs/ext4/inode.c                                  |  28 +-
 fs/ext4/ioctl.c                                  |  20 +-
 fs/ext4/namei.c                                  |  32 +-
 fs/ext4/symlink.c                                |   4 +-
 fs/ext4/xattr_hurd.c                             |   2 +-
 fs/ext4/xattr_security.c                         |   2 +-
 fs/ext4/xattr_trusted.c                          |   2 +-
 fs/ext4/xattr_user.c                             |   2 +-
 fs/f2fs/acl.c                                    |  14 +-
 fs/f2fs/acl.h                                    |   2 +-
 fs/f2fs/f2fs.h                                   |   8 +-
 fs/f2fs/file.c                                   |  50 +--
 fs/f2fs/namei.c                                  |  50 +--
 fs/f2fs/recovery.c                               |   6 +-
 fs/f2fs/xattr.c                                  |   6 +-
 fs/fat/fat.h                                     |   4 +-
 fs/fat/file.c                                    |  26 +-
 fs/fat/namei_msdos.c                             |   6 +-
 fs/fat/namei_vfat.c                              |   6 +-
 fs/fcntl.c                                       |   2 +-
 fs/fuse/acl.c                                    |   6 +-
 fs/fuse/dir.c                                    |  32 +-
 fs/fuse/file.c                                   |   3 +-
 fs/fuse/fuse_i.h                                 |   4 +-
 fs/fuse/ioctl.c                                  |   2 +-
 fs/fuse/xattr.c                                  |   4 +-
 fs/gfs2/acl.c                                    |   4 +-
 fs/gfs2/acl.h                                    |   2 +-
 fs/gfs2/file.c                                   |   4 +-
 fs/gfs2/inode.c                                  |  58 +--
 fs/gfs2/inode.h                                  |   4 +-
 fs/gfs2/xattr.c                                  |   2 +-
 fs/hfs/attr.c                                    |   2 +-
 fs/hfs/dir.c                                     |   6 +-
 fs/hfs/hfs_fs.h                                  |   2 +-
 fs/hfs/inode.c                                   |   6 +-
 fs/hfsplus/dir.c                                 |  14 +-
 fs/hfsplus/hfsplus_fs.h                          |   4 +-
 fs/hfsplus/inode.c                               |  14 +-
 fs/hfsplus/xattr.c                               |   2 +-
 fs/hfsplus/xattr_security.c                      |   2 +-
 fs/hfsplus/xattr_trusted.c                       |   2 +-
 fs/hfsplus/xattr_user.c                          |   2 +-
 fs/hostfs/hostfs_kern.c                          |  20 +-
 fs/hpfs/hpfs_fn.h                                |   2 +-
 fs/hpfs/inode.c                                  |   6 +-
 fs/hpfs/namei.c                                  |  10 +-
 fs/hugetlbfs/inode.c                             |  22 +-
 fs/init.c                                        |  14 +-
 fs/inode.c                                       |  57 ++-
 fs/internal.h                                    |  15 +-
 fs/ioctl.c                                       |  16 +-
 fs/jffs2/acl.c                                   |   4 +-
 fs/jffs2/acl.h                                   |   2 +-
 fs/jffs2/dir.c                                   |  20 +-
 fs/jffs2/fs.c                                    |   6 +-
 fs/jffs2/os-linux.h                              |   2 +-
 fs/jffs2/security.c                              |   2 +-
 fs/jffs2/xattr_trusted.c                         |   2 +-
 fs/jffs2/xattr_user.c                            |   2 +-
 fs/jfs/acl.c                                     |   4 +-
 fs/jfs/file.c                                    |  12 +-
 fs/jfs/ioctl.c                                   |   2 +-
 fs/jfs/jfs_acl.h                                 |   2 +-
 fs/jfs/jfs_inode.c                               |   2 +-
 fs/jfs/jfs_inode.h                               |   4 +-
 fs/jfs/namei.c                                   |  10 +-
 fs/jfs/xattr.c                                   |   4 +-
 fs/kernfs/dir.c                                  |   4 +-
 fs/kernfs/inode.c                                |  18 +-
 fs/kernfs/kernfs-internal.h                      |   6 +-
 fs/ksmbd/ndr.c                                   |   6 +-
 fs/ksmbd/ndr.h                                   |   2 +-
 fs/ksmbd/oplock.c                                |   6 +-
 fs/ksmbd/smb2pdu.c                               | 122 +++---
 fs/ksmbd/smb_common.c                            |   4 +-
 fs/ksmbd/smbacl.c                                |  72 ++--
 fs/ksmbd/smbacl.h                                |  12 +-
 fs/ksmbd/vfs.c                                   | 172 ++++-----
 fs/ksmbd/vfs.h                                   |  36 +-
 fs/ksmbd/vfs_cache.c                             |   4 +-
 fs/libfs.c                                       |  20 +-
 fs/minix/bitmap.c                                |   2 +-
 fs/minix/file.c                                  |   6 +-
 fs/minix/inode.c                                 |   4 +-
 fs/minix/minix.h                                 |   2 +-
 fs/minix/namei.c                                 |  14 +-
 fs/mnt_idmapping.c                               | 273 ++++++++++++++
 fs/namei.c                                       | 450 +++++++++++------------
 fs/namespace.c                                   | 118 +-----
 fs/nfs/dir.c                                     |  14 +-
 fs/nfs/inode.c                                   |   6 +-
 fs/nfs/internal.h                                |  10 +-
 fs/nfs/namespace.c                               |  10 +-
 fs/nfs/nfs3_fs.h                                 |   2 +-
 fs/nfs/nfs3acl.c                                 |   2 +-
 fs/nfs/nfs4proc.c                                |  10 +-
 fs/nfsd/nfs2acl.c                                |   4 +-
 fs/nfsd/nfs3acl.c                                |   4 +-
 fs/nfsd/nfs3proc.c                               |   2 +-
 fs/nfsd/nfs4recover.c                            |   6 +-
 fs/nfsd/nfsfh.c                                  |   2 +-
 fs/nfsd/nfsproc.c                                |   2 +-
 fs/nfsd/vfs.c                                    |  41 ++-
 fs/nilfs2/inode.c                                |  12 +-
 fs/nilfs2/ioctl.c                                |   2 +-
 fs/nilfs2/namei.c                                |  10 +-
 fs/nilfs2/nilfs.h                                |   6 +-
 fs/ntfs/inode.c                                  |   6 +-
 fs/ntfs/inode.h                                  |   2 +-
 fs/ntfs3/file.c                                  |  12 +-
 fs/ntfs3/inode.c                                 |   6 +-
 fs/ntfs3/namei.c                                 |  24 +-
 fs/ntfs3/ntfs_fs.h                               |  16 +-
 fs/ntfs3/xattr.c                                 |  24 +-
 fs/ocfs2/acl.c                                   |   4 +-
 fs/ocfs2/acl.h                                   |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                           |  14 +-
 fs/ocfs2/file.c                                  |  20 +-
 fs/ocfs2/file.h                                  |   6 +-
 fs/ocfs2/ioctl.c                                 |   2 +-
 fs/ocfs2/ioctl.h                                 |   2 +-
 fs/ocfs2/namei.c                                 |  18 +-
 fs/ocfs2/refcounttree.c                          |   4 +-
 fs/ocfs2/xattr.c                                 |   6 +-
 fs/omfs/dir.c                                    |   6 +-
 fs/omfs/file.c                                   |   6 +-
 fs/omfs/inode.c                                  |   2 +-
 fs/open.c                                        |  35 +-
 fs/orangefs/acl.c                                |   4 +-
 fs/orangefs/inode.c                              |  18 +-
 fs/orangefs/namei.c                              |   8 +-
 fs/orangefs/orangefs-kernel.h                    |   8 +-
 fs/orangefs/xattr.c                              |   2 +-
 fs/overlayfs/dir.c                               |  12 +-
 fs/overlayfs/export.c                            |   4 +-
 fs/overlayfs/file.c                              |   8 +-
 fs/overlayfs/inode.c                             |  46 +--
 fs/overlayfs/namei.c                             |   6 +-
 fs/overlayfs/overlayfs.h                         |  55 +--
 fs/overlayfs/ovl_entry.h                         |   4 +-
 fs/overlayfs/readdir.c                           |   4 +-
 fs/overlayfs/super.c                             |   4 +-
 fs/overlayfs/util.c                              |  14 +-
 fs/posix_acl.c                                   | 104 +++---
 fs/proc/base.c                                   |  22 +-
 fs/proc/fd.c                                     |   8 +-
 fs/proc/fd.h                                     |   2 +-
 fs/proc/generic.c                                |  10 +-
 fs/proc/internal.h                               |   4 +-
 fs/proc/proc_net.c                               |   4 +-
 fs/proc/proc_sysctl.c                            |  12 +-
 fs/proc/root.c                                   |   4 +-
 fs/quota/dquot.c                                 |  10 +-
 fs/ramfs/file-nommu.c                            |   8 +-
 fs/ramfs/inode.c                                 |  16 +-
 fs/reiserfs/acl.h                                |   2 +-
 fs/reiserfs/inode.c                              |  10 +-
 fs/reiserfs/ioctl.c                              |   4 +-
 fs/reiserfs/namei.c                              |  12 +-
 fs/reiserfs/reiserfs.h                           |   4 +-
 fs/reiserfs/xattr.c                              |  12 +-
 fs/reiserfs/xattr.h                              |   2 +-
 fs/reiserfs/xattr_acl.c                          |   6 +-
 fs/reiserfs/xattr_security.c                     |   2 +-
 fs/reiserfs/xattr_trusted.c                      |   2 +-
 fs/reiserfs/xattr_user.c                         |   2 +-
 fs/remap_range.c                                 |   6 +-
 fs/stat.c                                        |  24 +-
 fs/sysv/file.c                                   |   6 +-
 fs/sysv/ialloc.c                                 |   2 +-
 fs/sysv/itree.c                                  |   4 +-
 fs/sysv/namei.c                                  |  12 +-
 fs/sysv/sysv.h                                   |   2 +-
 fs/tracefs/inode.c                               |   2 +-
 fs/ubifs/dir.c                                   |  18 +-
 fs/ubifs/file.c                                  |   8 +-
 fs/ubifs/ioctl.c                                 |   2 +-
 fs/ubifs/ubifs.h                                 |   8 +-
 fs/ubifs/xattr.c                                 |   2 +-
 fs/udf/file.c                                    |   6 +-
 fs/udf/ialloc.c                                  |   2 +-
 fs/udf/namei.c                                   |  12 +-
 fs/udf/symlink.c                                 |   4 +-
 fs/ufs/ialloc.c                                  |   2 +-
 fs/ufs/inode.c                                   |   6 +-
 fs/ufs/namei.c                                   |  10 +-
 fs/ufs/ufs.h                                     |   2 +-
 fs/utimes.c                                      |   2 +-
 fs/vboxsf/dir.c                                  |   8 +-
 fs/vboxsf/utils.c                                |   6 +-
 fs/vboxsf/vfsmod.h                               |   4 +-
 fs/xattr.c                                       |  83 +++--
 fs/xfs/xfs_acl.c                                 |   4 +-
 fs/xfs/xfs_acl.h                                 |   2 +-
 fs/xfs/xfs_file.c                                |   2 +-
 fs/xfs/xfs_inode.c                               |  32 +-
 fs/xfs/xfs_inode.h                               |   8 +-
 fs/xfs/xfs_ioctl.c                               |   8 +-
 fs/xfs/xfs_ioctl.h                               |   2 +-
 fs/xfs/xfs_ioctl32.c                             |   2 +-
 fs/xfs/xfs_iops.c                                |  85 +++--
 fs/xfs/xfs_iops.h                                |   2 +-
 fs/xfs/xfs_itable.c                              |  14 +-
 fs/xfs/xfs_itable.h                              |   2 +-
 fs/xfs/xfs_pnfs.c                                |   2 +-
 fs/xfs/xfs_qm.c                                  |   2 +-
 fs/xfs/xfs_symlink.c                             |   8 +-
 fs/xfs/xfs_symlink.h                             |   2 +-
 fs/xfs/xfs_xattr.c                               |   2 +-
 fs/zonefs/super.c                                |  10 +-
 include/linux/capability.h                       |   9 +-
 include/linux/evm.h                              |  26 +-
 include/linux/fileattr.h                         |   2 +-
 include/linux/fs.h                               | 174 +++++----
 include/linux/ima.h                              |  22 +-
 include/linux/lsm_hook_defs.h                    |  14 +-
 include/linux/lsm_hooks.h                        |   2 +-
 include/linux/mnt_idmapping.h                    | 226 ++----------
 include/linux/mount.h                            |   2 -
 include/linux/namei.h                            |   6 +-
 include/linux/nfs_fs.h                           |   6 +-
 include/linux/posix_acl.h                        |  24 +-
 include/linux/quotaops.h                         |  10 +-
 include/linux/security.h                         |  46 ++-
 include/linux/xattr.h                            |  20 +-
 ipc/mqueue.c                                     |   6 +-
 kernel/auditsc.c                                 |   4 +-
 kernel/bpf/inode.c                               |   8 +-
 kernel/capability.c                              |  10 +-
 kernel/cgroup/cgroup.c                           |   2 +-
 mm/madvise.c                                     |   2 +-
 mm/mincore.c                                     |   2 +-
 mm/secretmem.c                                   |   4 +-
 mm/shmem.c                                       |  40 +-
 net/socket.c                                     |   6 +-
 net/unix/af_unix.c                               |   8 +-
 security/apparmor/apparmorfs.c                   |   2 +-
 security/apparmor/domain.c                       |   4 +-
 security/apparmor/file.c                         |   2 +-
 security/apparmor/lsm.c                          |  16 +-
 security/commoncap.c                             |  68 ++--
 security/integrity/evm/evm_crypto.c              |  10 +-
 security/integrity/evm/evm_main.c                |  46 +--
 security/integrity/evm/evm_secfs.c               |   2 +-
 security/integrity/ima/ima.h                     |  10 +-
 security/integrity/ima/ima_api.c                 |   6 +-
 security/integrity/ima/ima_appraise.c            |  18 +-
 security/integrity/ima/ima_asymmetric_keys.c     |   2 +-
 security/integrity/ima/ima_main.c                |  26 +-
 security/integrity/ima/ima_policy.c              |  14 +-
 security/integrity/ima/ima_queue_keys.c          |   2 +-
 security/integrity/ima/ima_template_lib.c        |   2 +-
 security/security.c                              |  46 +--
 security/selinux/hooks.c                         |  22 +-
 security/smack/smack_lsm.c                       |  30 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h |   2 +-
 345 files changed, 2602 insertions(+), 2629 deletions(-)
---
base-commit: 292a089d78d3e2f7944e60bb897c977785a321e3
change-id: 20230113-fs-idmapped-mnt_idmap-conversion-41b20b976026

