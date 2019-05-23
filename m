Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808B1282CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfEWQUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfEWQUf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:20:35 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697812175B;
        Thu, 23 May 2019 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558628434;
        bh=FknFkuMqIQswK6dizRqW42viEu1UgGSSCdsOrOtPEl4=;
        h=From:To:Cc:Subject:Date:From;
        b=w2vprKRs36OU0mlW6tCtu/R0ScUiml1J+XkD5QpTz49lwK92Ff8FYyXBzhcERt0Xw
         qjLECrAkRM3bGAZRrvBTTyqAGWm2FPCYcswdDanEQtDYltpVjzrWak1F4NCAu27d1o
         P3cmKKMMuuIioJq8nr2Kqa7cUdCAfOXXo7e0VRhw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-api@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH v3 00/15] fs-verity: read-only file-based authenticity protection
Date:   Thu, 23 May 2019 09:17:56 -0700
Message-Id: <20190523161811.6259-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This is a redesigned version of the fs-verity patchset, implementing
Ted's suggestion to build the Merkle tree in the kernel
(https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
This greatly simplifies the UAPI, since the verity metadata no longer
needs to be transferred to the kernel.  Now to enable fs-verity on a
file, one simply calls FS_IOC_ENABLE_VERITY, passing it this structure:

	struct fsverity_enable_arg {
		__u32 version;
		__u32 hash_algorithm;
		__u32 block_size;
		__u32 salt_size;
		__u64 salt_ptr;
		__u32 sig_size;
		__u32 __reserved1;
		__u64 sig_ptr;
		__u64 __reserved2[11];
	};

The filesystem then builds the file's Merkle tree and stores it in a
filesystem-specific location associated with the file.  Afterwards,
FS_IOC_MEASURE_VERITY can be used to retrieve the file measurement
("root hash").  The way the file measurement is computed is also
effectively part of the API (it has to be), but it's logically
independent of where/how the filesystem stores the Merkle tree.

The API is fully documented in Documentation/filesystems/fsverity.rst,
along with other aspects of fs-verity.  I also added an FAQ section that
answers frequently asked questions about fs-verity, e.g. why isn't it
all at the VFS level, why isn't it part of IMA, why does the Merkle tree
need to be stored on-disk, etc.

Overview
--------

This patchset implements fs-verity for ext4 and f2fs.  fs-verity is
similar to dm-verity, but implemented on a per-file basis: a Merkle tree
is used to measure (hash) a read-only file's data as it is paged in.
ext4 and f2fs hide this Merkle tree beyond the end of the file, but
other filesystems can implement it differently if desired.

In general, fs-verity is intended for use on writable filesystems;
dm-verity is still recommended on read-only ones.

Similar to fscrypt, most of the code is in fs/verity/, and not too many
filesystem-specific changes are needed.  The Merkle tree is built by the
filesystem when the FS_IOC_ENABLE_VERITY ioctl is executed.

fs-verity provides a file measurement (hash) in constant time and
verifies data on-demand.  Thus, it is useful for efficiently verifying
the authenticity of large files of which only a small portion may be
accessed, such as Android application package (APK) files.  It may also
be useful in "audit" use cases where file hashes are logged.

fs-verity also provides better protection against malicious disks than
an ahead-of-time hash, since fs-verity re-verifies data each time it's
paged in.  Note, however, that any authenticity guarantee is still
dependent on verification of the file measurement and other relevant
metadata in a way that makes sense for the overall system; fs-verity is
only a tool to help with this.

This patchset doesn't yet include IMA support for fs-verity file
measurements.  This is planned and we'd like to collaborate with the IMA
maintainers.  Although fs-verity can be used on its own without IMA,
fs-verity is primarily a lower level feature (think of it as a way of
hashing a file), so some users may still need IMA's policy mechanism.
However, an optional in-kernel signature verification mechanism within
fs-verity itself is also included.

This patchset is based on v5.2-rc1.  It can also be found in git at tag
fsverity_2019-05-23 of:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git

fs-verity has a userspace utility:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git

xfstests for fs-verity can be found at branch "fsverity" of:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git

For f2fs, fs-verity is supported by f2fs-tools v1.11.0+.  For ext4,
e2fsprogs v1.44.5+ has basic fs-verity support, but an additional fix
for e2fsck is needed too: https://marc.info/?l=linux-ext4&m=155862547309706&w=2

Examples of setting up fs-verity protected files can be found in the
README.md file of fsverity-utils.

Other useful references include:

  - Documentation/filesystems/fsverity.rst, added by the first patch.

  - LWN coverage of v1 patchset: https://lwn.net/Articles/763729/

  - LWN coverage of v2 patchset: https://lwn.net/Articles/775872/

  - Presentation at Linux Security Summit North America 2018:
      - Slides: https://schd.ws/hosted_files/lssna18/af/fs-verity%20slide%20deck.pdf
      - Video: https://www.youtube.com/watch?v=Aw5h6aBhu6M

  - Notes from discussion at LSFMM 2018: https://lwn.net/Articles/752614/

Changed since v2:

  - Large redesign: the Merkle tree is now built by
    FS_IOC_ENABLE_VERITY, rather than being provided by userspace.  The
    fsverity_operations provide an interface for filesystems to read and
    write the Merkle tree from/to a filesystem-specific location.

  - Lot of refactoring, cleanups, and documentation improvements.

  - Many simplifications, such as simplifying the fsverity_descriptor
    format, dropping CRC-32 support, and limiting the salt size.

  - ext4 and f2fs now store an xattr that gives the location of the
    fsverity_descriptor, so loading it is more straightforward.

  - f2fs no longer counts the verity metadata in the on-disk i_size,
    making it consistent with ext4.

  - Replaced the filesystem-specific fs-verity kconfig options with
    CONFIG_FS_VERITY.

  - Replaced the filesystem-specific verity bit checks with IS_VERITY().

Changed since v1:

  - Added documentation file.

  - Require write permission for FS_IOC_ENABLE_VERITY, rather than
    CAP_SYS_ADMIN.

  - Eliminated dependency on CONFIG_BLOCK and clarified that filesystems
    can verify a page at a time rather than a bio at a time.

  - Fixed conditions for verifying holes.

  - ext4 now only allows fs-verity on extent-based files.

  - Eliminated most of the assumptions that the verity metadata is
    stored beyond EOF, in case filesystems want to do things
    differently.

  - Other cleanups.

Eric Biggers (15):
  fs-verity: add a documentation file
  fs-verity: add MAINTAINERS file entry
  fs-verity: add UAPI header
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
  f2fs: add fs-verity support

 Documentation/filesystems/fsverity.rst | 683 +++++++++++++++++++++++++
 Documentation/filesystems/index.rst    |   1 +
 Documentation/ioctl/ioctl-number.txt   |   1 +
 MAINTAINERS                            |  12 +
 fs/Kconfig                             |   2 +
 fs/Makefile                            |   1 +
 fs/ext4/Makefile                       |   1 +
 fs/ext4/ext4.h                         |  21 +-
 fs/ext4/file.c                         |   4 +
 fs/ext4/inode.c                        |  48 +-
 fs/ext4/ioctl.c                        |  12 +
 fs/ext4/readpage.c                     | 209 ++++++--
 fs/ext4/super.c                        |  18 +-
 fs/ext4/sysfs.c                        |   6 +
 fs/ext4/verity.c                       | 272 ++++++++++
 fs/ext4/xattr.h                        |   2 +
 fs/f2fs/Makefile                       |   1 +
 fs/f2fs/data.c                         |  72 ++-
 fs/f2fs/f2fs.h                         |  21 +-
 fs/f2fs/file.c                         |  38 ++
 fs/f2fs/inode.c                        |   5 +-
 fs/f2fs/super.c                        |   3 +
 fs/f2fs/sysfs.c                        |  11 +
 fs/f2fs/verity.c                       | 224 ++++++++
 fs/f2fs/xattr.h                        |   2 +
 fs/verity/Kconfig                      |  55 ++
 fs/verity/Makefile                     |  10 +
 fs/verity/enable.c                     | 336 ++++++++++++
 fs/verity/fsverity_private.h           | 191 +++++++
 fs/verity/hash_algs.c                  | 279 ++++++++++
 fs/verity/init.c                       |  61 +++
 fs/verity/measure.c                    |  57 +++
 fs/verity/open.c                       | 353 +++++++++++++
 fs/verity/signature.c                  | 207 ++++++++
 fs/verity/verify.c                     | 283 ++++++++++
 include/linux/fs.h                     |  11 +
 include/linux/fsverity.h               | 183 +++++++
 include/uapi/linux/fsverity.h          |  40 ++
 38 files changed, 3678 insertions(+), 58 deletions(-)
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

-- 
2.21.0

