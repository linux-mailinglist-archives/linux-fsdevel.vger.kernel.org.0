Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D269A688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 09:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBQIGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 03:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQIGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:06:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DEA900D;
        Fri, 17 Feb 2023 00:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72B22B82B22;
        Fri, 17 Feb 2023 08:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B22C433EF;
        Fri, 17 Feb 2023 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676621185;
        bh=uB80br5cLvUYJKSiwD4gOvVoTDFwgK7Ws2Vn3ll5r/g=;
        h=From:To:Cc:Subject:Date:From;
        b=EVzxxPJlM2HMkE2M0Hz+WKD8XCqs9EPRmV5IGnOaQ/V2QybPNZLiTnawUZRVngvhM
         AHD60TT1HiVxXgmjV+dolvi0G8WwCHVJ4hNj1TcN1k4gcnjK+fQiYiE7YDw1rpbPPq
         d91Jo3leZdhPwFwSZqEKT5RoK7wANP8Cq9R+WiIj2UJCYDPHgJS16XONMjZj/bJDqr
         6vbWj/QbXBT/JhIdRpmDaxhpmTZ5EfNUlZIXWmGM7onq1+xiwS2X7DrwckDFzP1DR5
         EFe5esoCS30Ij1PEGrhCHswc81n6QKv5OPZ4V7+fPymzNMFxCOsL9wWYgDUOs+94fQ
         f0uHWftMknDJA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] fs idmapped updates for v6.3
Date:   Fri, 17 Feb 2023 09:05:53 +0100
Message-Id: <20230217080552.1628786-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30016; i=brauner@kernel.org; h=from:subject; bh=uB80br5cLvUYJKSiwD4gOvVoTDFwgK7Ws2Vn3ll5r/g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS/N41wkFbSbLLy2d6yqUK/cfsR9+ManTMls98b1od9uZ1h WlreUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFFGxj+qXJOYiyqCvtasjvS8cCR37 t73Va77289lG2hwHzLI8nwCyNDC0P7KWbNM4tPtn+b2vzfJn8T21VtrnVr7374cmLvpY06nAA=
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
This pull request contains two changesets:

(1) Last cycle we introduced the dedicated struct mnt_idmap type for
    mount idmapping and the required infrastucture in
    256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
    As promised in last cycle's pull request message this converts
    everything to rely on struct mnt_idmap.

    Currently we still pass around the plain namespace that was attached
    to a mount. This is in general pretty convenient but it makes it
    easy to conflate namespaces that are relevant on the filesystem with
    namespaces that are relevant on the mount level. Especially for
    non-vfs developers without detailed knowledge in this area this was
    a potential source for bugs.

    This pull request contains the work to finish the conversion.
    Instead of passing the plain namespace around this updates all
    places that currently take a pointer to a mnt_userns with a pointer
    to struct mnt_idmap.

    Now that the conversion is done all helpers down to the really
    low-level helpers only accept a struct mnt_idmap argument instead of
    two namespace arguments.

    Conflating mount and other idmappings will now cause the compiler to
    complain loudly thus eliminating the possibility of any bugs. This
    makes it impossible for filesystem developers to mix up mount and
    filesystem idmappings as they are two distinct types and require
    distinct helpers that cannot be used interchangeably.

    Everything associated with struct mnt_idmap is moved into a single
    separate file. With that change no code can poke around in struct
    mnt_idmap. It can only be interacted with through dedicated helpers.
    That means all filesystems are and all of the vfs is completely
    oblivious to the actual implementation of idmappings.

    We are now also able to extend struct mnt_idmap as we see fit. For
    example, we can decouple it completely from namespaces for users
    that don't require or don't want to use them at all. We can also
    extend the concept of idmappings so we can cover filesystem specific
    requirements.

    In combination with the vfs{g,u}id_t work we finished in v6.2 this
    makes this feature substantially more robust and thus difficult to
    implement wrong by a given filesystem and also protects the vfs.

(2) Enable idmapped mounts for tmpfs and fulfill a longstanding request.

    A long-standing request from users had been to make it possible to
    create idmapped mounts for tmpfs. For example, to share the host's
    tmpfs mount between multiple sandboxes. This is a prerequisite for
    some advanced Kubernetes cases. Systemd also has a range of
    use-cases to increase service isolation. And there are more users of
    this.

    However, with all of the other work going on this was way down on
    the priority list but luckily someone other than ourselves picked
    this up.

    As usual the patch is tiny as all the infrastructure work had been
    done multiple kernel releases ago. In addition to all the tests that
    we already have I requested that Rodrigo add a dedicated tmpfs
    testsuite for idmapped mounts to xfstests. It is to be included into
    xfstests during the v6.3 development cycle. This should add a slew
    of additional tests.

Note, I had asked the authors of the tmpfs patchset to base the patch
directly on the struct mnt_idmap conversion. It makes the whole branch
cleaner.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.2-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
Since the conversion is a fairly large series there are a couple of
merge conflicts. All of them are straightforward and either Stephen or I
have directly provided the fixes in the links below.

Note that the ntfs3 merge conflicts in (7) and (8) showed up on
Wednesday this week suggesting that the relevant tree either hasn't been
in linux-next before or has taken on last minute fixes that cause
conflicts. It's a bit unfortunate to get merge conflicts this late.
Usually all merge conflicts should have shown up a few weeks before the
merge window opens so it's easy to report all of them when sending the
pull request. We just got lucky we didn't send the pull request before
Wednesday.

Frankly, most of them are simple enough that you could just do it
without even looking at any of the links but of course I listed all of
them and Stephen did provide patches.

There are two conflicts with your mainline tree one in the btrfs code
and another one caused by an earlier pull request during the v6.2
development window in fuse:

(1) btrfs: manual merge of the vfs-idmapping tree with mainline
    https://lore.kernel.org/linux-next/20230119100718.346ffa0e@canb.auug.org.au
(2) fuse: manual merge of the vfs-idmapping tree with mainline
    https://lore.kernel.org/linux-next/20230130103149.7d09e239@canb.auug.org.au

Then there are a few conflicts with trees from other developers:

(1) manual merge of the iversion tree with the vfs-idmapping tree
    https://lore.kernel.org/linux-next/20230119101423.547b48b7@canb.auug.org.au
(2) build failure after merge of the block tree
    https://lore.kernel.org/linux-next/20230120100702.3d50dbb8@canb.auug.org.au
(3) manual merge of the v9fs-ericvh tree with the vfs-idmapping tree
    https://lore.kernel.org/linux-next/20230127112149.283a466f@canb.auug.org.au
(4) manual merge of the f2fs tree with the vfs-idmapping tree 1
    https://lore.kernel.org/linux-next/20230131100728.6efdb3c5@canb.auug.org.au
(5) manual merge of the f2fs tree with the vfs-idmapping tree 2
    https://lore.kernel.org/linux-next/20230131101244.26f85f35@canb.auug.org.au
(6) build failure after merge of the integrity tree
    https://lore.kernel.org/linux-next/20230207115113.21efd917@canb.auug.org.au
(7) manual merge of the ntfs3 tree with the vfs-idmapping tree 1
    https://lore.kernel.org/linux-next/20230216083002.6227ba81@canb.auug.org.au
(8) manual merge of the ntfs3 tree with the vfs-idmapping tree 2
    https://lore.kernel.org/linux-next/20230216085733.5a40fe6b@canb.auug.org.au

Note, that there were two merge issues that were reported and that to
the best of my understanding have been fixed. First, zonefs got a merge
conflict which Damiend managed to resolve after we clarified some
confusion here:
https://lore.kernel.org/linux-next/6073061b-138b-499c-6de1-5196f191b176@opensource.wdc.com

Then there was a build failure on powerpc which I fixed very rearly on:
https://lore.kernel.org/linux-next/20230119102659.5f7d3b39@canb.auug.org.au

I did my best to cover all bases there's still a minimal chance that I
might've missed something given that this series does touch a few
places.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.v6.3

for you to fetch changes up to 7a80e5b8c6fa7d0ae6624bd6aedc4a6a1cfc62fa:

  shmem: support idmapped mounts for tmpfs (2023-01-20 18:46:56 +0100)

Please consider pulling these changes from the signed fs.idmapped.v6.3 tag.

I'm on vacation until v6.2 is released this Sunday but Amir or Seth know
how to reach me quite easily before that in case anything goes wrong.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.v6.3

----------------------------------------------------------------
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

Giuseppe Scrivano (1):
      shmem: support idmapped mounts for tmpfs

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
 mm/shmem.c                                       |  69 ++--
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
 345 files changed, 2621 insertions(+), 2639 deletions(-)
 create mode 100644 fs/mnt_idmapping.c
