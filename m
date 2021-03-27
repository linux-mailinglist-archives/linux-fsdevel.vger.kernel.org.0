Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1E34B98F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 22:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhC0VnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 17:43:00 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:56144 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhC0Vmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:42:32 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 256E681FE6;
        Sun, 28 Mar 2021 00:42:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1616881349;
        bh=pJmGGwiVXgJTm/dJaxSL0ql78Y05YkznHysMAfgZMVg=;
        h=From:To:CC:Subject:Date;
        b=ZY4DvZbypYxwrbE6WB/z/L52Ph+CmOnkUA6wGytFL4v3j73NFvOBgDh/rvB/cawa/
         EJ5GfygpGPA0LkFqRTtkMmvT/YBaG4MrIcyQsae08YLNF5xElrcQlLqSMGIbEkGT5N
         AhObpCIskBDPz5TC4+K2gI24UDx3p8vhVQbT5mQg=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 00:42:28 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        <dan.carpenter@oracle.com>, <hch@lst.de>, <ebiggers@kernel.org>,
        <andy.lavr@gmail.com>, <kari.argillander@gmail.com>,
        <oleksandr@natalenko.name>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v25 00/10] NTFS read-write driver GPL implementation by Paragon Software
Date:   Sun, 28 Mar 2021 00:40:13 +0300
Message-ID: <20210327214023.3214923-1-almaz.alexandrovich@paragon-software.com>
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
- fixed directory bitmap for 2MB cluster size
- fixed rw_semaphore init for directories

v20:
- fixed issue with incorrect hidden/system attribute setting on
  root subdirectories
- use kvmalloc instead of kmalloc for runs array
- fixed index behavior on volumes with cluster size more than 4k
- current build info is added into module info instead of printing on insmod

v21:
- fixes for clang CFI checks
- fixed sb->s_maxbytes for 32bit clusters
- user.DOSATTRIB is no more intercepted by ntfs3
- corrected xattr limits;  is used
- corrected CONFIG_NTFS3_64BIT_CLUSTER usage
- info about current build is added into module info and printing
on insmod (by Andy Lavr's request)
note: v21 is applicable for 'linux-next' not older than 2021.01.28

v22:
- ntfs_cmp_names() fixed
- raise warning if 'nls->uni2char' fails
- hot fix free clusters code optimized
- use clang-format 11.0 instead of 10.0 to format code

v23:
- corrections for Kernel Test Robot warnings
- kmem_cache_create() utilized to allocate memory in bitmap.c
- cosmetics and comments thru the code

v24:
- BIO_MAX_PAGES -> BIO_MAX_VECS (fix for build issue of v23 vs linux-next)
- minor optimization for LogFile: do not fill it with -1, if it's already there
- index.c: removed 'inline' in definition of hdr_find_split() and hdr_insert_head()

v25:
- restore fs/Makefile in patch
- refactor ntfs_create_inode() to use error-valued pointer
- use mi_get_ref to fill MFT_REF
- minimize checkpatch.pl warnings: replace LogFile with \x24LogFile when printing

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
 fs/ntfs3/Kconfig                    |   46 +
 fs/ntfs3/Makefile                   |   34 +
 fs/ntfs3/attrib.c                   | 2083 +++++++++++
 fs/ntfs3/attrlist.c                 |  456 +++
 fs/ntfs3/bitfunc.c                  |  135 +
 fs/ntfs3/bitmap.c                   | 1519 ++++++++
 fs/ntfs3/debug.h                    |   64 +
 fs/ntfs3/dir.c                      |  594 +++
 fs/ntfs3/file.c                     | 1130 ++++++
 fs/ntfs3/frecord.c                  | 3071 ++++++++++++++++
 fs/ntfs3/fslog.c                    | 5208 +++++++++++++++++++++++++++
 fs/ntfs3/fsntfs.c                   | 2543 +++++++++++++
 fs/ntfs3/index.c                    | 2641 ++++++++++++++
 fs/ntfs3/inode.c                    | 2033 +++++++++++
 fs/ntfs3/lib/decompress_common.c    |  332 ++
 fs/ntfs3/lib/decompress_common.h    |  352 ++
 fs/ntfs3/lib/lib.h                  |   26 +
 fs/ntfs3/lib/lzx_decompress.c       |  683 ++++
 fs/ntfs3/lib/xpress_decompress.c    |  155 +
 fs/ntfs3/lznt.c                     |  452 +++
 fs/ntfs3/namei.c                    |  578 +++
 fs/ntfs3/ntfs.h                     | 1237 +++++++
 fs/ntfs3/ntfs_fs.h                  | 1087 ++++++
 fs/ntfs3/record.c                   |  609 ++++
 fs/ntfs3/run.c                      | 1111 ++++++
 fs/ntfs3/super.c                    | 1502 ++++++++
 fs/ntfs3/upcase.c                   |  105 +
 fs/ntfs3/xattr.c                    | 1050 ++++++
 32 files changed, 30952 insertions(+)
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


base-commit: 931294922e65a23e1aad6398b9ae02df74044679
-- 
2.25.4

