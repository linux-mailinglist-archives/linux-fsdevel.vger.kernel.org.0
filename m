Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF16F790
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 04:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfGVCvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 22:51:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbfGVCvG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:51:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96089897D014893929C1;
        Mon, 22 Jul 2019 10:51:03 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:50:52 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 00/24] erofs: promote erofs from staging
Date:   Mon, 22 Jul 2019 10:50:19 +0800
Message-ID: <20190722025043.166344-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changelog from v2:
 o kill sbi->dev_name and clean up all failure handling in
   fill_super() suggested by Al.
   Note that the initialzation of managed_cache is now moved
   after s_root is assigned since it's more preferred to iput()
   in .put_super() and all inodes should be evicted before
   the end of generic_shutdown_super(sb);

 o fold in the following staging patches (and thanks):
   staging: erofs:converting all 'unsigned' to 'unsigned int'
   staging: erofs: Remove function erofs_kill_sb()
    - However it was revoked due to erofs_kill_sb reused...
   staging: erofs: avoid opened loop codes
   staging: erofs: support bmap

 o move EROFS_SUPER_MAGIC_V1 from linux/fs/erofs/erofs_fs.h to
   include/uapi/linux/magic.h for userspace utilities.

This patchset is slightly different from what it is in the staging
tree since I move/rename compression/shrinker stuffes and do more
cleanup in patchset v2 for better review, complete code are also
available at:
 https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/tree/fs/erofs?h=erofs-outofstaging

Changelog from v1:
 o resend the whole filesystem into a patchset suggested by Greg;
 o code is more cleaner, especially for decompression frontend.

--8<----------

Hi,

EROFS file system has been in Linux-staging for about a year.
It has been proved to be stable enough to move out of staging
by 10+ millions of HUAWEI Android mobile phones on the market
from EMUI 9.0.1, and it was promoted as one of the key features
of EMUI 9.1 [1], including P30(pro).

EROFS is a read-only file system designed to save extra storage
space with guaranteed end-to-end performance by applying
fixed-size output compression, inplace I/O and decompression
inplace technologies [2] to Linux filesystem.

In our observation, EROFS is one of the fastest Linux compression
filesystem using buffered I/O in the world. It will support
direct I/O in the future if needed. EROFS even has better read
performance in a large CR range compared with generic uncompressed
file systems with proper CPU-storage combination, which is
a reason why EROFS can be landed to speed up mobile phone
performance, and which can be probably used for other use cases
such as LiveCD and Docker image as well.

Currently EROFS supports 4k LZ4 fixed-size output compression
since LZ4 is the fastest widely-used decompression solution in
the world and 4k leads to unnoticable read amplification for
the worst case. More compression algorithms and cluster sizes
could be added later, which depends on the real requirement.

More information about EROFS itself are available at:
 Documentation/filesystems/erofs.txt
 https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei

erofs-utils (mainly mkfs.erofs now) is available at
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git

Preliminary iomap support has been pending in EROFS mailing
list by Chao Yu. The key issue is that current iomap doesn't
support tail-end packing inline data yet, it should be
resolved later.

Thanks to many contributors in the last year, the code is more
clean and improved. We hope EROFS can be used in wider use cases
so let's promote erofs out of staging and enhance it more actively.

Share comments about EROFS! We think EROFS is useful to
community as a part of Linux upstream.

Thank you very much,
Gao Xiang

[1] http://web.archive.org/web/20190627021241/https://consumer.huawei.com/en/emui/
[2] https://lore.kernel.org/lkml/20190624072258.28362-1-hsiangkao@aol.com/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Gao Xiang (24):
  erofs: add on-disk layout
  erofs: add erofs in-memory stuffs
  erofs: add super block operations
  erofs: add raw address_space operations
  erofs: add inode operations
  erofs: support special inode
  erofs: add directory operations
  erofs: add namei functions
  erofs: support tracepoint
  erofs: update Kconfig and Makefile
  erofs: introduce xattr & posixacl support
  erofs: introduce tagged pointer
  erofs: add compression indexes support
  erofs: introduce superblock registration
  erofs: introduce erofs shrinker
  erofs: introduce workstation for decompression
  erofs: introduce per-CPU buffers implementation
  erofs: introduce pagevec for decompression subsystem
  erofs: add erofs_allocpage()
  erofs: introduce generic decompression backend
  erofs: introduce LZ4 decompression inplace
  erofs: introduce the decompression frontend
  erofs: introduce cached decompression
  erofs: add document

 Documentation/filesystems/erofs.txt |  211 ++++
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/erofs/Kconfig                    |  154 +++
 fs/erofs/Makefile                   |   11 +
 fs/erofs/compress.h                 |   89 ++
 fs/erofs/data.c                     |  423 ++++++++
 fs/erofs/decompressor.c             |  329 ++++++
 fs/erofs/dir.c                      |  147 +++
 fs/erofs/erofs_fs.h                 |  316 ++++++
 fs/erofs/inode.c                    |  326 ++++++
 fs/erofs/internal.h                 |  566 +++++++++++
 fs/erofs/namei.c                    |  250 +++++
 fs/erofs/super.c                    |  555 +++++++++++
 fs/erofs/tagptr.h                   |  110 ++
 fs/erofs/utils.c                    |  416 ++++++++
 fs/erofs/xattr.c                    |  700 +++++++++++++
 fs/erofs/xattr.h                    |   93 ++
 fs/erofs/zdata.c                    | 1440 +++++++++++++++++++++++++++
 fs/erofs/zdata.h                    |  201 ++++
 fs/erofs/zmap.c                     |  462 +++++++++
 fs/erofs/zpvec.h                    |  159 +++
 include/trace/events/erofs.h        |  256 +++++
 include/uapi/linux/magic.h          |    1 +
 24 files changed, 7217 insertions(+)
 create mode 100644 Documentation/filesystems/erofs.txt
 create mode 100644 fs/erofs/Kconfig
 create mode 100644 fs/erofs/Makefile
 create mode 100644 fs/erofs/compress.h
 create mode 100644 fs/erofs/data.c
 create mode 100644 fs/erofs/decompressor.c
 create mode 100644 fs/erofs/dir.c
 create mode 100644 fs/erofs/erofs_fs.h
 create mode 100644 fs/erofs/inode.c
 create mode 100644 fs/erofs/internal.h
 create mode 100644 fs/erofs/namei.c
 create mode 100644 fs/erofs/super.c
 create mode 100644 fs/erofs/tagptr.h
 create mode 100644 fs/erofs/utils.c
 create mode 100644 fs/erofs/xattr.c
 create mode 100644 fs/erofs/xattr.h
 create mode 100644 fs/erofs/zdata.c
 create mode 100644 fs/erofs/zdata.h
 create mode 100644 fs/erofs/zmap.c
 create mode 100644 fs/erofs/zpvec.h
 create mode 100644 include/trace/events/erofs.h

-- 
2.17.1

