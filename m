Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6AC255CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgH1OkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 10:40:16 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:57828 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgH1OkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:40:13 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5815D1B9;
        Fri, 28 Aug 2020 17:40:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598625610;
        bh=gp31LCEOPfkg+meKJd+SFbL0vKK/yDq7y6yyetw18pk=;
        h=From:To:CC:Subject:Date;
        b=Y4Ye1fgFUvL+WiGM8Y91YCsNFNIRb3O5buUEU9epvSGt1ZJaMcvDnnCoIJROYWjL2
         QDUOkmgpxc3exr5flnurdWc4xeTQc+yIKNDvZEwlcq3FR6XaY+9xRlsCZAIggBYqKk
         5l8r4VMhq2j70dK/YgCBuevc3wKlC5G2UZQ82VQE=
Received: from localhost.localdomain (172.30.8.44) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 28 Aug 2020 17:40:09 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v3 00/10] NTFS read-write driver GPL implementation by Paragon Software
Date:   Fri, 28 Aug 2020 07:39:28 -0700
Message-ID: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.30.8.44]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Sender: linux-fsdevel-owner@vger.kernel.org
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

 Documentation/filesystems/ntfs3.rst |  103 +
 MAINTAINERS                         |    7 +
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/ntfs3/Kconfig                    |   23 +
 fs/ntfs3/Makefile                   |   11 +
 fs/ntfs3/attrib.c                   | 1285 +++++++
 fs/ntfs3/attrlist.c                 |  462 +++
 fs/ntfs3/bitfunc.c                  |  137 +
 fs/ntfs3/bitmap.c                   | 1545 ++++++++
 fs/ntfs3/debug.h                    |   45 +
 fs/ntfs3/dir.c                      |  642 ++++
 fs/ntfs3/file.c                     | 1214 +++++++
 fs/ntfs3/frecord.c                  | 2378 ++++++++++++
 fs/ntfs3/fslog.c                    | 5222 +++++++++++++++++++++++++++
 fs/ntfs3/fsntfs.c                   | 2218 ++++++++++++
 fs/ntfs3/index.c                    | 2661 ++++++++++++++
 fs/ntfs3/inode.c                    | 2068 +++++++++++
 fs/ntfs3/lznt.c                     |  451 +++
 fs/ntfs3/namei.c                    |  580 +++
 fs/ntfs3/ntfs.h                     | 1249 +++++++
 fs/ntfs3/ntfs_fs.h                  | 1001 +++++
 fs/ntfs3/record.c                   |  615 ++++
 fs/ntfs3/run.c                      | 1188 ++++++
 fs/ntfs3/super.c                    | 1406 ++++++++
 fs/ntfs3/upcase.c                   |   78 +
 fs/ntfs3/xattr.c                    | 1007 ++++++
 27 files changed, 27598 insertions(+)
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
2.25.2

