Return-Path: <linux-fsdevel+bounces-1376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83A7D9C01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26B21C2108C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711211EB39;
	Fri, 27 Oct 2023 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al1HfaZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438918654
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A35C433C7;
	Fri, 27 Oct 2023 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698418007;
	bh=Is8861coE2dMv1ozjLxtkdJ2o33KTHb/T1OB32cPMlI=;
	h=From:To:Cc:Subject:Date:From;
	b=Al1HfaZlOyDX0AmQ6zkklGZSoiEFZg6G/MY0wPwA6qCyN9wZLByEbwgCCpizGCJnw
	 LkYO73cNmSSqta9nN100y8U7QczB3MfZxqjqSlpQ9TGXN/HF/y63D8GGz9xcDRsF9L
	 BEdkYb6MH82s0Ib1Croi2IybVsInVjs76mWflxtOQfSvMbXR/s6TvvGBltpWtJLLKM
	 ddC1JCnuk1+IYw3hAXN8sBGFlhpdq5Vd4jdEUvkcnV7HQTJJkztioWDr5Y3WR0h+2J
	 mVxIvcCrdSAcZjr5kZ7MMxKHX+AcOCbzTq+Dopz4cbAd4zEcERcgVbzf0qIfzhD9kn
	 DyLdo0FUtwYeA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] vfs xattr updates
Date: Fri, 27 Oct 2023 16:44:00 +0200
Message-Id: <20231027-vfs-xattr-6eeea5632c93@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5883; i=brauner@kernel.org; h=from:subject:message-id; bh=L23UqZR0i6BQlmP1jQpRywpoX9dfv6WXNEUHjt3dBWk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRan6n8YDzxrXO+/dKAVk7R6sYweYELntOzjseZCbeV7rz2 5sS3jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0tzH8z9cR+n0gWfCFrK/gtijOKx MC4iOEk+uXdk9RaTT227r2KcMfzgRZixUpbzZOF+Z32Rr1xHU6g9ZkweYD3GI8hrsT3XSZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
The 's_xattr' field of 'struct super_block' currently requires a mutable
table of 'struct xattr_handler' entries (although each handler itself is
const). However, no code in vfs actually modifies the tables.

This changes the type of 's_xattr' to allow const tables, and modifies
existing file systems to move their tables to .rodata. This is desirable
because these tables contain entries with function pointers in them;
moving them to .rodata makes it considerably less likely to be modified
accidentally or maliciously at runtime.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.xattr

for you to fetch changes up to a640d888953cd18e8542283653c20160b601d69d:

  const_structs.checkpatch: add xattr_handler (2023-10-12 17:14:11 +0200)

Please consider pulling these changes from the signed vfs-6.7.xattr tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.xattr

----------------------------------------------------------------
Thomas Weißschuh (1):
      const_structs.checkpatch: add xattr_handler

Wedson Almeida Filho (29):
      xattr: make the xattr array itself const
      ext4: move ext4_xattr_handlers to .rodata
      9p: move xattr-related structs to .rodata
      afs: move afs_xattr_handlers to .rodata
      btrfs: move btrfs_xattr_handlers to .rodata
      ceph: move ceph_xattr_handlers to .rodata
      ecryptfs: move ecryptfs_xattr_handlers to .rodata
      erofs: move erofs_xattr_handlers and xattr_handler_map to .rodata
      ext2: move ext2_xattr_handlers and ext2_xattr_handler_map to .rodata
      f2fs: move f2fs_xattr_handlers and f2fs_xattr_handler_map to .rodata
      fuse: move fuse_xattr_handlers to .rodata
      gfs2: move gfs2_xattr_handlers_max to .rodata
      hfs: move hfs_xattr_handlers to .rodata
      hfsplus: move hfsplus_xattr_handlers to .rodata
      jffs2: move jffs2_xattr_handlers to .rodata
      jfs: move jfs_xattr_handlers to .rodata
      kernfs: move kernfs_xattr_handlers to .rodata
      nfs: move nfs4_xattr_handlers to .rodata
      ntfs3: move ntfs_xattr_handlers to .rodata
      ocfs2: move ocfs2_xattr_handlers and ocfs2_xattr_handler_map to .rodata
      orangefs: move orangefs_xattr_handlers to .rodata
      reiserfs: move reiserfs_xattr_handlers to .rodata
      smb: move cifs_xattr_handlers to .rodata
      squashfs: move squashfs_xattr_handlers to .rodata
      ubifs: move ubifs_xattr_handlers to .rodata
      xfs: move xfs_xattr_handlers to .rodata
      overlayfs: move xattr tables to .rodata
      shmem: move shmem_xattr_handlers to .rodata
      net: move sockfs_xattr_handlers to .rodata

 fs/9p/xattr.c                    | 8 ++++----
 fs/9p/xattr.h                    | 2 +-
 fs/afs/internal.h                | 2 +-
 fs/afs/xattr.c                   | 2 +-
 fs/btrfs/xattr.c                 | 2 +-
 fs/btrfs/xattr.h                 | 2 +-
 fs/ceph/super.h                  | 2 +-
 fs/ceph/xattr.c                  | 2 +-
 fs/ecryptfs/ecryptfs_kernel.h    | 2 +-
 fs/ecryptfs/inode.c              | 2 +-
 fs/erofs/xattr.c                 | 2 +-
 fs/erofs/xattr.h                 | 4 ++--
 fs/ext2/xattr.c                  | 4 ++--
 fs/ext2/xattr.h                  | 2 +-
 fs/ext4/xattr.c                  | 2 +-
 fs/ext4/xattr.h                  | 2 +-
 fs/f2fs/xattr.c                  | 4 ++--
 fs/f2fs/xattr.h                  | 2 +-
 fs/fuse/fuse_i.h                 | 2 +-
 fs/fuse/xattr.c                  | 2 +-
 fs/gfs2/super.h                  | 4 ++--
 fs/gfs2/xattr.c                  | 4 ++--
 fs/hfs/attr.c                    | 2 +-
 fs/hfs/hfs_fs.h                  | 2 +-
 fs/hfsplus/xattr.c               | 2 +-
 fs/hfsplus/xattr.h               | 2 +-
 fs/jffs2/xattr.c                 | 2 +-
 fs/jffs2/xattr.h                 | 2 +-
 fs/jfs/jfs_xattr.h               | 2 +-
 fs/jfs/xattr.c                   | 2 +-
 fs/kernfs/inode.c                | 2 +-
 fs/kernfs/kernfs-internal.h      | 2 +-
 fs/nfs/nfs.h                     | 2 +-
 fs/nfs/nfs4_fs.h                 | 2 +-
 fs/nfs/nfs4proc.c                | 2 +-
 fs/ntfs3/ntfs_fs.h               | 2 +-
 fs/ntfs3/xattr.c                 | 2 +-
 fs/ocfs2/xattr.c                 | 4 ++--
 fs/ocfs2/xattr.h                 | 2 +-
 fs/orangefs/orangefs-kernel.h    | 2 +-
 fs/orangefs/xattr.c              | 2 +-
 fs/overlayfs/super.c             | 4 ++--
 fs/reiserfs/reiserfs.h           | 2 +-
 fs/reiserfs/xattr.c              | 4 ++--
 fs/smb/client/cifsfs.h           | 2 +-
 fs/smb/client/xattr.c            | 2 +-
 fs/squashfs/squashfs.h           | 2 +-
 fs/squashfs/xattr.c              | 2 +-
 fs/ubifs/ubifs.h                 | 2 +-
 fs/ubifs/xattr.c                 | 2 +-
 fs/xattr.c                       | 6 +++---
 fs/xfs/xfs_xattr.c               | 2 +-
 fs/xfs/xfs_xattr.h               | 2 +-
 include/linux/fs.h               | 2 +-
 include/linux/pseudo_fs.h        | 2 +-
 mm/shmem.c                       | 2 +-
 net/socket.c                     | 2 +-
 scripts/const_structs.checkpatch | 1 +
 58 files changed, 71 insertions(+), 70 deletions(-)

