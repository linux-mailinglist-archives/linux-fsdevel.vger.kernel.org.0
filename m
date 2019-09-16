Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40008B3455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 07:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfIPFU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 01:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfIPFU4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:20:56 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A222067B;
        Mon, 16 Sep 2019 05:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568611255;
        bh=0Zp0/Naz0WUbXJutjSKemevgHRocsO7EMFcWzb2dl1Y=;
        h=Date:From:To:Cc:Subject:From;
        b=awni9dksgHmJx9gTvqey0ukMhUw0fPydoBJv1SubKwoyxuqe/OomgiDpv4zwSvTWq
         6IrShbxft+Mr7JZGQUrgh1plwzdI2vlB6mlsPM2p3hP/7vnJMyzgYN+WqvIrmSoljM
         YtEjpk63iNa20lYgzpkEpwq/Bpbx8ft2uu4xPGEg=
Date:   Sun, 15 Sep 2019 22:20:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fs-verity for 5.4
Message-ID: <20190916052053.GB8269@sol.localdomain>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 95ae251fe82838b85c6d37e5a1775006e2a42ae0:

  f2fs: add fs-verity support (2019-08-12 19:33:51 -0700)

----------------------------------------------------------------
Hi Linus,

Please consider pulling fs-verity for 5.4.

fs-verity is a filesystem feature that provides Merkle tree based
hashing (similar to dm-verity) for individual readonly files, mainly for
the purpose of efficient authenticity verification.

This pull request includes:

(a) The fs/verity/ support layer and documentation.

(b) fs-verity support for ext4 and f2fs.

Compared to the original fs-verity patchset from last year, the UAPI to
enable fs-verity on a file has been greatly simplified.  Lots of other
things were cleaned up too.

fs-verity is planned to be used by two different projects on Android;
most of the userspace code is in place already.  Another userspace tool
("fsverity-utils"), and xfstests, are also available.  e2fsprogs and
f2fs-tools already have fs-verity support.  Other people have shown
interest in using fs-verity too.

I've tested this on ext4 and f2fs with xfstests, both the existing tests
and the new fs-verity tests.  This has also been in linux-next since
July 30 with no reported issues except a couple minor ones I found
myself and folded in fixes for.

Ted and I will be co-maintaining fs-verity.


There will be some fairly straightforward merge conflicts with the ext4
and f2fs trees.  I've tested the resolution of these in linux-next.

This will also "silently" conflict (compiler warning only) with the key
ACLs patchset, if you merge it again this cycle.  The resolution is to
translate the key permissions to an ACL in fs/verity/signature.c.  I
suggest using the resolution in linux-next, which I've tested.  This
resolution avoids making any behavior changes; note that some of the old
permissions map to multiple new permissions.

----------------------------------------------------------------
Eric Biggers (17):
      fs-verity: add a documentation file
      fs-verity: add MAINTAINERS file entry
      fs-verity: add UAPI header
      fs: uapi: define verity bit for FS_IOC_GETFLAGS
      fs-verity: add Kconfig and the helper functions for hashing
      fs-verity: add inode and superblock fields
      fs-verity: add the hook for file ->open()
      fs-verity: add the hook for file ->setattr()
      fs-verity: add data verification hooks for ->readpages()
      fs-verity: implement FS_IOC_ENABLE_VERITY ioctl
      fs-verity: implement FS_IOC_MEASURE_VERITY ioctl
      fs-verity: add SHA-512 support
      fs-verity: support builtin file signatures
      ext4: add basic fs-verity support
      ext4: add fs-verity read support
      ext4: update on-disk format documentation for fs-verity
      f2fs: add fs-verity support

 Documentation/filesystems/ext4/inodes.rst   |   6 +-
 Documentation/filesystems/ext4/overview.rst |   1 +
 Documentation/filesystems/ext4/super.rst    |   2 +
 Documentation/filesystems/ext4/verity.rst   |  41 ++
 Documentation/filesystems/fsverity.rst      | 726 ++++++++++++++++++++++++++++
 Documentation/filesystems/index.rst         |   1 +
 Documentation/ioctl/ioctl-number.rst        |   1 +
 MAINTAINERS                                 |  12 +
 fs/Kconfig                                  |   2 +
 fs/Makefile                                 |   1 +
 fs/ext4/Makefile                            |   1 +
 fs/ext4/ext4.h                              |  23 +-
 fs/ext4/file.c                              |   4 +
 fs/ext4/inode.c                             |  55 ++-
 fs/ext4/ioctl.c                             |  13 +
 fs/ext4/readpage.c                          | 211 ++++++--
 fs/ext4/super.c                             |  18 +-
 fs/ext4/sysfs.c                             |   6 +
 fs/ext4/verity.c                            | 367 ++++++++++++++
 fs/f2fs/Makefile                            |   1 +
 fs/f2fs/data.c                              |  75 ++-
 fs/f2fs/f2fs.h                              |  20 +-
 fs/f2fs/file.c                              |  43 +-
 fs/f2fs/inode.c                             |   5 +-
 fs/f2fs/super.c                             |   3 +
 fs/f2fs/sysfs.c                             |  11 +
 fs/f2fs/verity.c                            | 247 ++++++++++
 fs/f2fs/xattr.h                             |   2 +
 fs/verity/Kconfig                           |  55 +++
 fs/verity/Makefile                          |  10 +
 fs/verity/enable.c                          | 377 +++++++++++++++
 fs/verity/fsverity_private.h                | 185 +++++++
 fs/verity/hash_algs.c                       | 280 +++++++++++
 fs/verity/init.c                            |  61 +++
 fs/verity/measure.c                         |  57 +++
 fs/verity/open.c                            | 356 ++++++++++++++
 fs/verity/signature.c                       | 157 ++++++
 fs/verity/verify.c                          | 281 +++++++++++
 include/linux/fs.h                          |  11 +
 include/linux/fsverity.h                    | 211 ++++++++
 include/uapi/linux/fs.h                     |   1 +
 include/uapi/linux/fsverity.h               |  40 ++
 42 files changed, 3910 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/verity.rst
 create mode 100644 Documentation/filesystems/fsverity.rst
 create mode 100644 fs/ext4/verity.c
 create mode 100644 fs/f2fs/verity.c
 create mode 100644 fs/verity/Kconfig
 create mode 100644 fs/verity/Makefile
 create mode 100644 fs/verity/enable.c
 create mode 100644 fs/verity/fsverity_private.h
 create mode 100644 fs/verity/hash_algs.c
 create mode 100644 fs/verity/init.c
 create mode 100644 fs/verity/measure.c
 create mode 100644 fs/verity/open.c
 create mode 100644 fs/verity/signature.c
 create mode 100644 fs/verity/verify.c
 create mode 100644 include/linux/fsverity.h
 create mode 100644 include/uapi/linux/fsverity.h
