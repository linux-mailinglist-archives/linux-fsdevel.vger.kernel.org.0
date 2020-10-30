Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC72A0911
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJ3PEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:04:48 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:35374 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgJ3PEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:04:47 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 25BD26A;
        Fri, 30 Oct 2020 18:04:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1604070285;
        bh=fhZl7OP2dqz9jup6Nu5SrVMqgLyV9oMKzBF2nI5Z2As=;
        h=From:To:CC:Subject:Date;
        b=Q+HdX69pkHsWrGt6ujFxRJntsZlARXlf5Qms1g7CU9OVseU9eiTuWHF57mHjjZwjb
         fitd6Tr7Wg4cjwTCxuRQsNxkS/BCW3NzBNr/Yj2+O+2QVY1wgO7mi//Vrbp/Y9jawW
         T3oMkYkvVuGkjDQVS6OrtX+hugbgWr//71pVH9Ec=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 30 Oct 2020 18:04:44 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v11 00/10] NTFS read-write driver GPL implementation by Paragon Software
Date:   Fri, 30 Oct 2020 18:02:29 +0300
Message-ID: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
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

 Documentation/filesystems/ntfs3.rst |  112 +
 MAINTAINERS                         |    7 +
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/ntfs3/Kconfig                    |   23 +
 fs/ntfs3/Makefile                   |   11 +
 fs/ntfs3/attrib.c                   | 1400 +++++++
 fs/ntfs3/attrlist.c                 |  463 +++
 fs/ntfs3/bitfunc.c                  |  135 +
 fs/ntfs3/bitmap.c                   | 1504 ++++++++
 fs/ntfs3/debug.h                    |   61 +
 fs/ntfs3/dir.c                      |  610 ++++
 fs/ntfs3/file.c                     | 1153 ++++++
 fs/ntfs3/frecord.c                  | 2696 ++++++++++++++
 fs/ntfs3/fslog.c                    | 5221 +++++++++++++++++++++++++++
 fs/ntfs3/fsntfs.c                   | 2565 +++++++++++++
 fs/ntfs3/index.c                    | 2665 ++++++++++++++
 fs/ntfs3/inode.c                    | 2030 +++++++++++
 fs/ntfs3/lznt.c                     |  452 +++
 fs/ntfs3/namei.c                    |  576 +++
 fs/ntfs3/ntfs.h                     | 1262 +++++++
 fs/ntfs3/ntfs_fs.h                  |  988 +++++
 fs/ntfs3/record.c                   |  613 ++++
 fs/ntfs3/run.c                      | 1190 ++++++
 fs/ntfs3/super.c                    | 1479 ++++++++
 fs/ntfs3/upcase.c                   |   77 +
 fs/ntfs3/xattr.c                    | 1069 ++++++
 27 files changed, 28364 insertions(+)
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
 create mode 100644 fs/ntfs3/lznt.c
 create mode 100644 fs/ntfs3/namei.c
 create mode 100644 fs/ntfs3/ntfs.h
 create mode 100644 fs/ntfs3/ntfs_fs.h
 create mode 100644 fs/ntfs3/record.c
 create mode 100644 fs/ntfs3/run.c
 create mode 100644 fs/ntfs3/super.c
 create mode 100644 fs/ntfs3/upcase.c
 create mode 100644 fs/ntfs3/xattr.c

-- 
2.25.4

