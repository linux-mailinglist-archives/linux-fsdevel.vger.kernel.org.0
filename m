Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05246307240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 10:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhA1JGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 04:06:18 -0500
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:37232 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhA1JGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:06:00 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 00A4E821D0;
        Thu, 28 Jan 2021 12:05:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1611824702;
        bh=Kc2vUj1fAoM7XiH+uQStJ08c3FNhMRtOe7VO8styaGA=;
        h=From:To:CC:Subject:Date;
        b=Nq0nnxu1tKOC2q6iC8civeEmbqTkBur5pUrKwhYSslLcFKOvL7xGNg9CsZibAj/i6
         MPCg0BzCuAa2CY/J6wyJi0KvfVDHDCk/waFGAaxFuHF6z1/scrNdTJ/djiZFTc3b27
         14LPWC40ZcWhdpYDObqcORzSqHqlF5fY/7jk79wc=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 28 Jan 2021 12:05:01 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        <dan.carpenter@oracle.com>, <hch@lst.de>, <ebiggers@kernel.org>,
        <andy.lavr@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v19 00/10] NTFS read-write driver GPL implementation by Paragon Software
Date:   Thu, 28 Jan 2021 12:04:45 +0300
Message-ID: <20210128090455.3576502-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.30.114.105]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds NTFS Read-Write driver to fs/ntfs3.

Having decades of expertise in commercial file systems development and huge
test coverage, we at Paragon Software GmbH want to make our contribution to
the Open Source Community by providing implementation of NTFS Read-Write
driver for the Linux Kernel.

This is fully functional NTFS Read-Write driver. Current version works with
NTFS(including v3.1) and normal/compressed/sparse files and supports journal replaying.

We plan to support this version after the codebase once merged, and add new
features and fix bugs. For example, full journaling support over JBD will be
added in later updates.

v2:
 - patch splitted to chunks (file-wise)
 - build issues fixed
 - sparse and checkpatch.pl errors fixed
 - NULL pointer dereference on mkfs.ntfs-formatted volume mount fixed
 - cosmetics + code cleanup

v3:
 - added acl, noatime, no_acs_rules, prealloc mount options
 - added fiemap support
 - fixed encodings support
 - removed typedefs
 - adapted Kernel-way logging mechanisms
 - fixed typos and corner-case issues

v4:
 - atomic_open() refactored
 - code style updated
 - bugfixes

v5:
- nls/nls_alt mount options added
- Unicode conversion fixes
- Improved very fragmented files operations
- logging cosmetics

v6:
- Security Descriptors processing changed
  added system.ntfs_security xattr to set
  SD
- atomic_open() optimized
- cosmetics

v7:
- Security Descriptors validity checks added (by Mark Harmstone)
- atomic_open() fixed for the compressed file creation with directio
  case
- remount support
- temporarily removed readahead usage
- cosmetics

v8:
- Compressed files operations fixed

v9:
- Further cosmetics applied as suggested
by Joe Perches

v10:
- operations with compressed/sparse files on very fragmented volumes improved
- reduced memory consumption for above cases

v11:
- further compressed files optimizations: reads/writes are now skipping bufferization
- journal wipe to the initial state optimized (bufferization is also skipped)
- optimized run storage (re-packing cluster metainformation)
- fixes based on Matthew Wilcox feedback to the v10
- compressed/sparse/normal could be set for empty files with 'system.ntfs_attrib' xattr

v12:
- nls_alt mount option removed after discussion with Pali Rohar
- fixed ni_repack()
- fixed resident files transition to non-resident when size increasing

v13:
- nested_lock fix (lockdep)
- out-of-bounds read fix (KASAN warning)
- resident->nonresident transition fixed for compressed files
- load_nls() missed fix applied
- some sparse utility warnings fixes

v14:
- support for additional compression types (we've adapted WIMLIB's
  implementation, authored by Eric Biggers, into ntfs3)

v15:
- kernel test robot warnings fixed
- lzx/xpress compression license headers updated

v16:
- lzx/xpress moved to initial ntfs-3g plugin code
- mutexes instead of a global spinlock for compresions
- FALLOC_FL_PUNCH_HOLE and FALLOC_FL_COLLAPSE_RANGE implemented
- CONFIG_NTFS3_FS_POSIX_ACL added

v17:
- FALLOC_FL_COLLAPSE_RANGE fixed
- fixes for Mattew Wilcox's and Andy Lavr's concerns

v18:
- ntfs_alloc macro splitted into two ntfs_malloc + ntfs_zalloc
- attrlist.c: always use ntfs_cmp_names instead of memcmp; compare entry names
  only for entry with vcn == 0
- dir.c: remove unconditional ni_lock in ntfs_readdir
- fslog.c: corrected error case behavior
- index.c: refactored due to modification of ntfs_cmp_names; use rw_semaphore
  for read/write access to alloc_run and bitmap_run while ntfs_readdir
- run.c: separated big/little endian code in functions
- upcase.c: improved ntfs_cmp_names, thanks to Kari Argillander for idea
  and 'bothcase' implementation

v19:
- fixed directory bitmap for 2MB cluster
- fixed rw_semaphore init for directories

Konstantin Komarov (10):
  fs/ntfs3: Add headers and misc files
  fs/ntfs3: Add initialization of super block
  fs/ntfs3: Add bitmap
  fs/ntfs3: Add file operations and implementation
  fs/ntfs3: Add attrib operations
  fs/ntfs3: Add compression
  fs/ntfs3: Add NTFS journal
  fs/ntfs3: Add Kconfig, Makefile and doc
  fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
  fs/ntfs3: Add MAINTAINERS

 Documentation/filesystems/ntfs3.rst |  107 +
 MAINTAINERS                         |    7 +
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/ntfs3/Kconfig                    |   45 +
 fs/ntfs3/Makefile                   |   31 +
 fs/ntfs3/attrib.c                   | 2085 +++++++++++
 fs/ntfs3/attrlist.c                 |  457 +++
 fs/ntfs3/bitfunc.c                  |  135 +
 fs/ntfs3/bitmap.c                   | 1506 ++++++++
 fs/ntfs3/debug.h                    |   62 +
 fs/ntfs3/dir.c                      |  583 +++
 fs/ntfs3/file.c                     | 1132 ++++++
 fs/ntfs3/frecord.c                  | 3083 ++++++++++++++++
 fs/ntfs3/fslog.c                    | 5204 +++++++++++++++++++++++++++
 fs/ntfs3/fsntfs.c                   | 2535 +++++++++++++
 fs/ntfs3/index.c                    | 2662 ++++++++++++++
 fs/ntfs3/inode.c                    | 2050 +++++++++++
 fs/ntfs3/lib/decompress_common.c    |  332 ++
 fs/ntfs3/lib/decompress_common.h    |  352 ++
 fs/ntfs3/lib/lib.h                  |   26 +
 fs/ntfs3/lib/lzx_decompress.c       |  683 ++++
 fs/ntfs3/lib/xpress_decompress.c    |  155 +
 fs/ntfs3/lznt.c                     |  452 +++
 fs/ntfs3/namei.c                    |  590 +++
 fs/ntfs3/ntfs.h                     | 1238 +++++++
 fs/ntfs3/ntfs_fs.h                  | 1065 ++++++
 fs/ntfs3/record.c                   |  609 ++++
 fs/ntfs3/run.c                      | 1120 ++++++
 fs/ntfs3/super.c                    | 1479 ++++++++
 fs/ntfs3/upcase.c                   |  100 +
 fs/ntfs3/xattr.c                    | 1072 ++++++
 32 files changed, 30959 insertions(+)
 create mode 100644 Documentation/filesystems/ntfs3.rst
 create mode 100644 fs/ntfs3/Kconfig
 create mode 100644 fs/ntfs3/Makefile
 create mode 100644 fs/ntfs3/attrib.c
 create mode 100644 fs/ntfs3/attrlist.c
 create mode 100644 fs/ntfs3/bitfunc.c
 create mode 100644 fs/ntfs3/bitmap.c
 create mode 100644 fs/ntfs3/debug.h
 create mode 100644 fs/ntfs3/dir.c
 create mode 100644 fs/ntfs3/file.c
 create mode 100644 fs/ntfs3/frecord.c
 create mode 100644 fs/ntfs3/fslog.c
 create mode 100644 fs/ntfs3/fsntfs.c
 create mode 100644 fs/ntfs3/index.c
 create mode 100644 fs/ntfs3/inode.c
 create mode 100644 fs/ntfs3/lib/decompress_common.c
 create mode 100644 fs/ntfs3/lib/decompress_common.h
 create mode 100644 fs/ntfs3/lib/lib.h
 create mode 100644 fs/ntfs3/lib/lzx_decompress.c
 create mode 100644 fs/ntfs3/lib/xpress_decompress.c
 create mode 100644 fs/ntfs3/lznt.c
 create mode 100644 fs/ntfs3/namei.c
 create mode 100644 fs/ntfs3/ntfs.h
 create mode 100644 fs/ntfs3/ntfs_fs.h
 create mode 100644 fs/ntfs3/record.c
 create mode 100644 fs/ntfs3/run.c
 create mode 100644 fs/ntfs3/super.c
 create mode 100644 fs/ntfs3/upcase.c
 create mode 100644 fs/ntfs3/xattr.c


base-commit: 76c057c84d286140c6c416c3b4ba832cd1d8984e
-- 
2.25.4

