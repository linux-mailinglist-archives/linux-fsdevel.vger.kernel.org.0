Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444917A1F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfG3HOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 03:14:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727425AbfG3HOo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:14:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 80FC9391C9FF9BDBB2F9;
        Tue, 30 Jul 2019 15:14:36 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 30 Jul
 2019 15:14:30 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "David Sterba" <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, "Jan Kara" <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v5 00/24] erofs: promote erofs from staging
Date:   Tue, 30 Jul 2019 15:13:49 +0800
Message-ID: <20190730071413.11871-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

( Add more linuxfs folks... )

Hi,

We'd like to hear if there are potential suggestions or
maybe objections of EROFS upstreaming stuffs. If any,
we still have time and we can improve it in this round.

As related materials mentioned before, the goal of EROFS is
to save extra storage space with guaranteed end-to-end
performance for read-only files, which has better performance
over exist Linux compression filesystems based on fixed-sized
output compression and inplace decompression. It even has
better performance in a large compression ratio range compared
with generic uncompressed filesystems with proper CPU-storage
combinations. And we think this direction is right and we have
a dedicated kernel team working on it, enough testers and
beta / end users using it.

EROFS has been applied to 10+ million HUAWEI mobile phones 
(Yes, the number is still increasing by time) and it seems
like a success. It can be used in more wider scenarios.
We think it's useful for Linux / Android OS community and
it's the time moving out of staging.

EROFS is a self-contained filesystem driver. Although there
are still some TODOs, we will keep on developping / tuning
EROFS with the evolution of Linux kernel as the other
in-kernel filesystems.

Kindly share your comments about EROFS. Thank you in advance!

Thanks,
Gao Xiang

Changelog from v4:
 o rebase on Linus 5.3-rc1;

 o keep up with "staging: erofs: updates according to erofs-outofstaging v4"
   in order to get main code bit-for-bit identical with staging tree:
    https://lore.kernel.org/lkml/20190729065159.62378-1-gaoxiang25@huawei.com/

It can also be found in git at tag "erofs_2019-07-29" at:
 https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/

The latest fs code is available at:
 https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/tree/fs/erofs?h=erofs-outofstaging

Changelog from v3:
 o use GPL-2.0-only for SPDX-License-Identifier suggested by Stephen;

 o kill all kconfig cache strategies and turn them into mount options
   "cache_strategy={disable|readahead|readaround}" suggested by Ted.
   As the first step, cached pages can still be usable after cache is
   disabled by remounting, and these pages will be fallen out over
   time, which can be refined in the later version if some requirement
   is needed. Update related document as well;

 o turn on CONFIG_EROFS_FS_SECURITY by default suggested by David;

 o kill CONFIG_EROFS_FS_IO_MAX_RETRIES and fold it into code; turn
   EROFS_FS_USE_VM_MAP_RAM into a module parameter ("use_vmap")
   suggested by David.

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

Changelog from v1:
 o resend the whole filesystem into a patchset suggested by Greg;
 o code is more cleaner, especially for decompression frontend.

--8<----(original cover)----

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

Kindly share comments about EROFS! We think EROFS is useful to
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
Cc: David Sterba <dsterba@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Darrick J . Wong <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jan Kara <jack@suse.cz>
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

 Documentation/filesystems/erofs.txt |  221 +++++
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/erofs/Kconfig                    |   98 ++
 fs/erofs/Makefile                   |   11 +
 fs/erofs/compress.h                 |   62 ++
 fs/erofs/data.c                     |  429 ++++++++
 fs/erofs/decompressor.c             |  359 +++++++
 fs/erofs/dir.c                      |  147 +++
 fs/erofs/erofs_fs.h                 |  316 ++++++
 fs/erofs/inode.c                    |  326 +++++++
 fs/erofs/internal.h                 |  552 +++++++++++
 fs/erofs/namei.c                    |  251 +++++
 fs/erofs/super.c                    |  666 +++++++++++++
 fs/erofs/tagptr.h                   |  110 +++
 fs/erofs/utils.c                    |  335 +++++++
 fs/erofs/xattr.c                    |  700 +++++++++++++
 fs/erofs/xattr.h                    |   94 ++
 fs/erofs/zdata.c                    | 1408 +++++++++++++++++++++++++++
 fs/erofs/zdata.h                    |  195 ++++
 fs/erofs/zmap.c                     |  462 +++++++++
 fs/erofs/zpvec.h                    |  159 +++
 include/trace/events/erofs.h        |  256 +++++
 include/uapi/linux/magic.h          |    1 +
 24 files changed, 7160 insertions(+)
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

