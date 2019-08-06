Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1964482F10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfHFJt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 05:49:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732079AbfHFJt6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:49:58 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D20BEE76F0AB788BFF58;
        Tue,  6 Aug 2019 17:49:55 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 6 Aug 2019
 17:49:48 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>
Subject: [PATCH RFC] erofs: move erofs out of staging
Date:   Tue, 6 Aug 2019 17:49:25 +0800
Message-ID: <20190806094925.228906-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EROFS filesytem has been merged into linux-staging tree for a year.

During the past year, EROFS was greatly improved by many contributors,
self-tested, betaed by a large number of our internal users, and
successfully applied to 10+ million mobile phones as a part of EMUI
9.1 [1] which are already on the market.

Decompression inplace and compacted indexes have been merged for
linux-5.3, which improves its read performance and becomes a part of
EROFS. A brief meterial about EROFS at Open Source Summit China 2019 [2]
and a USENIX ATC'19 paper [3] describing most of its design are
available as well.

Again, the goal of EROFS is to save extra storage space with guaranteed
end-to-end performance for read-only files and we have a dedicated
kernel team keeping on working on this filesystem in order to make
it better.

EROFS behaves as a block-based filesystem driver, the main code is ~7KLOC,
self-contained and stable enough to move out of staging. We will keep
on developping / tuning EROFS with the evolution of Linux kernel
as the other in-kernel filesystems.

Recently, the related topic [4] got a few suggestions from fs people,
and now it turns into silence again for a period of time. Perhaps it's
a good signal since no strong objections raised here. Regretfully
no explicit ACK of this topic till now as well and I have been looking
forward to get some external ACKs of this stuff all the time, sincerely...

As Pavel suggested earlier [5], it is better to do it as one commit
since git can do moves and all histories will be saved in this way.

Let's promote it from staging and enhance it more actively!

[1] http://web.archive.org/web/20190326175036/https://consumer.huawei.com/en/emui/
[2] https://sched.co/Nru2
[3] https://www.usenix.org/conference/atc19/presentation/gao
[4] https://lore.kernel.org/linux-fsdevel/20190802125347.166018-1-gaoxiang25@huawei.com/
[5] https://lore.kernel.org/linux-fsdevel/20190714104940.GA1282@xo-6d-61-c0.localdomain/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Pavel Machek <pavel@denx.de>
Cc: David Sterba <dsterba@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Darrick J . Wong <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Fang Wei <fangwei1@huawei.com>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <devel@driverdev.osuosl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Hi folks,

This patch is marked as a RFC patch since it's still some early
for linux-5.4-rc1.

However, I, Chao and other people currently working on EROFS
stuffs would like to know what the next step is. We already proved
the advantage of our compression solution and do good enough
as a part of staging driver.

EROFS was initially developped myself as a homebrew in my leisure
time in the end of 2017 in order to demo fixed-sized output compression,
I persuaded my boss to try to work on this new solution for system
partitions on our Android products at the very beginning of 2018 after
we failed to switch to squashfs suggested by Google in 2016. Chao and
other colleagues were joined into this project at that time. Chao was
happy to be the co-maintainer of linux kernel EROFS as well. This work
was very cautious at the very high level of HUAWEI but it turns to be
a success now.

We also persuaded our bosses to make a decision of open-source this
filesystem at the early stage since we know it's hard to maintain as
an out-of-tree Linux filesystem in the long term and we are happy to
apply it into wider use cases. For example, use it into desktop
distrbutions or Docker images.

On the one hand, as words documented in "Documentation/process/2.Process.rst",
entry into staging is not the end of the story and distributors also
tend to be relatively reluctant to enable staging drivers as well.

On the other hand, there are many cooking stuffs of EROFS on the way
from Chao (iomap), Guifu (erofs-fuse) and me (new algorithm support),
but we'd like to get whether EROFS can be a part of Linux mainstream
at least to play with it even further.

Please kindly share comments about EROFS, thanks!

Thanks,
Gao Xiang

 .../filesystems/erofs.txt                     |  4 --
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 drivers/staging/erofs/TODO                    | 46 -------------------
 fs/Kconfig                                    |  1 +
 fs/Makefile                                   |  1 +
 {drivers/staging => fs}/erofs/Kconfig         |  0
 {drivers/staging => fs}/erofs/Makefile        |  4 +-
 {drivers/staging => fs}/erofs/compress.h      |  2 +-
 {drivers/staging => fs}/erofs/data.c          |  2 +-
 {drivers/staging => fs}/erofs/decompressor.c  |  2 +-
 {drivers/staging => fs}/erofs/dir.c           |  2 +-
 {drivers/staging => fs}/erofs/erofs_fs.h      |  3 +-
 {drivers/staging => fs}/erofs/inode.c         |  2 +-
 {drivers/staging => fs}/erofs/internal.h      |  3 +-
 {drivers/staging => fs}/erofs/namei.c         |  2 +-
 {drivers/staging => fs}/erofs/super.c         |  2 +-
 {drivers/staging => fs}/erofs/tagptr.h        |  0
 {drivers/staging => fs}/erofs/utils.c         |  2 +-
 {drivers/staging => fs}/erofs/xattr.c         |  2 +-
 {drivers/staging => fs}/erofs/xattr.h         |  2 +-
 {drivers/staging => fs}/erofs/zdata.c         |  2 +-
 {drivers/staging => fs}/erofs/zdata.h         |  2 +-
 {drivers/staging => fs}/erofs/zmap.c          |  2 +-
 {drivers/staging => fs}/erofs/zpvec.h         |  2 +-
 .../include => include}/trace/events/erofs.h  |  0
 include/uapi/linux/magic.h                    |  1 +
 27 files changed, 21 insertions(+), 73 deletions(-)
 rename {drivers/staging/erofs/Documentation => Documentation}/filesystems/erofs.txt (98%)
 delete mode 100644 drivers/staging/erofs/TODO
 rename {drivers/staging => fs}/erofs/Kconfig (100%)
 rename {drivers/staging => fs}/erofs/Makefile (68%)
 rename {drivers/staging => fs}/erofs/compress.h (97%)
 rename {drivers/staging => fs}/erofs/data.c (99%)
 rename {drivers/staging => fs}/erofs/decompressor.c (99%)
 rename {drivers/staging => fs}/erofs/dir.c (98%)
 rename {drivers/staging => fs}/erofs/erofs_fs.h (99%)
 rename {drivers/staging => fs}/erofs/inode.c (99%)
 rename {drivers/staging => fs}/erofs/internal.h (99%)
 rename {drivers/staging => fs}/erofs/namei.c (99%)
 rename {drivers/staging => fs}/erofs/super.c (99%)
 rename {drivers/staging => fs}/erofs/tagptr.h (100%)
 rename {drivers/staging => fs}/erofs/utils.c (99%)
 rename {drivers/staging => fs}/erofs/xattr.c (99%)
 rename {drivers/staging => fs}/erofs/xattr.h (98%)
 rename {drivers/staging => fs}/erofs/zdata.c (99%)
 rename {drivers/staging => fs}/erofs/zdata.h (99%)
 rename {drivers/staging => fs}/erofs/zmap.c (99%)
 rename {drivers/staging => fs}/erofs/zpvec.h (98%)
 rename {drivers/staging/erofs/include => include}/trace/events/erofs.h (100%)

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
similarity index 98%
rename from drivers/staging/erofs/Documentation/filesystems/erofs.txt
rename to Documentation/filesystems/erofs.txt
index 0eab600ca7ca..38aa9126ec98 100644
--- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -49,10 +49,6 @@ Bugs and patches are welcome, please kindly help us and send to the following
 linux-erofs mailing list:
 >> linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
 
-Note that EROFS is still working in progress as a Linux staging driver,
-Cc the staging mailing list as well is highly recommended:
->> Linux Driver Project Developer List <devel@driverdev.osuosl.org>
-
 Mount options
 =============
 
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7c96a01eef6c..d972ec8e71fb 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -112,8 +112,6 @@ source "drivers/staging/gasket/Kconfig"
 
 source "drivers/staging/axis-fifo/Kconfig"
 
-source "drivers/staging/erofs/Kconfig"
-
 source "drivers/staging/fieldbus/Kconfig"
 
 source "drivers/staging/kpc2000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fcaac9693b83..6018b9a4a077 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_ISDN_CAPI)		+= isdn/
diff --git a/drivers/staging/erofs/TODO b/drivers/staging/erofs/TODO
deleted file mode 100644
index a8608b2f72bd..000000000000
--- a/drivers/staging/erofs/TODO
+++ /dev/null
@@ -1,46 +0,0 @@
-
-EROFS is still working in progress, thus it is not suitable
-for all productive uses. play at your own risk :)
-
-TODO List:
- - add the missing error handling code
-   (mainly existed in xattr and decompression submodules);
-
- - finalize erofs ondisk format design  (which means that
-   minor on-disk revisions could happen later);
-
- - documentation and detailed technical analysis;
-
- - general code review and clean up
-   (including confusing variable names and code snippets);
-
- - support larger compressed clustersizes for selection
-   (currently erofs only works as expected with the page-sized
-    compressed cluster configuration, usually 4KB);
-
- - support more lossless data compression algorithms
-   in addition to LZ4 algorithms in VLE approach;
-
- - data deduplication and other useful features.
-
-The following git tree provides the file system user-space
-tools under development (ex, formatting tool mkfs.erofs):
->> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
-
-The open-source development of erofs-utils is at the early stage.
-Contact the original author Li Guifu <bluce.liguifu@huawei.com> and
-the co-maintainer Fang Wei <fangwei1@huawei.com> for the latest news
-and more details.
-
-Code, suggestions, etc, are welcome. Please feel free to
-ask and send patches,
-
-To:
-  linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
-  Gao Xiang                  <gaoxiang25@huawei.com>
-  Chao Yu                    <yuchao0@huawei.com>
-
-Cc: (for linux-kernel upstream patches)
-  Greg Kroah-Hartman         <gregkh@linuxfoundation.org>
-  linux-staging mailing list <devel@driverdev.osuosl.org>
-
diff --git a/fs/Kconfig b/fs/Kconfig
index bfb1c6095c7a..669d46550e6d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,6 +261,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/erofs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index d60089fd689b..b2e4973a0bea 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_EROFS_FS)		+= erofs/
diff --git a/drivers/staging/erofs/Kconfig b/fs/erofs/Kconfig
similarity index 100%
rename from drivers/staging/erofs/Kconfig
rename to fs/erofs/Kconfig
diff --git a/drivers/staging/erofs/Makefile b/fs/erofs/Makefile
similarity index 68%
rename from drivers/staging/erofs/Makefile
rename to fs/erofs/Makefile
index 5cdae21cb5af..46f2aa4ba46c 100644
--- a/drivers/staging/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-EROFS_VERSION = "1.0pre1"
+EROFS_VERSION = "1.0"
 
 ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-# staging requirement: to be self-contained in its own directory
-ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
diff --git a/drivers/staging/erofs/compress.h b/fs/erofs/compress.h
similarity index 97%
rename from drivers/staging/erofs/compress.h
rename to fs/erofs/compress.h
index 043013f9ef1b..57035b7646ef 100644
--- a/drivers/staging/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/compress.h
+ * linux/fs/erofs/compress.h
  *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/data.c b/fs/erofs/data.c
similarity index 99%
rename from drivers/staging/erofs/data.c
rename to fs/erofs/data.c
index 75b859e48084..4d0123ef15f5 100644
--- a/drivers/staging/erofs/data.c
+++ b/fs/erofs/data.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/data.c
+ * linux/fs/erofs/data.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/decompressor.c b/fs/erofs/decompressor.c
similarity index 99%
rename from drivers/staging/erofs/decompressor.c
rename to fs/erofs/decompressor.c
index 5361a2bbedb6..1e9e1359e40c 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/decompressor.c
+ * linux/fs/erofs/decompressor.c
  *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/dir.c b/fs/erofs/dir.c
similarity index 98%
rename from drivers/staging/erofs/dir.c
rename to fs/erofs/dir.c
index 2fbfc4935077..7cf7da8574c4 100644
--- a/drivers/staging/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/dir.c
+ * linux/fs/erofs/dir.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
similarity index 99%
rename from drivers/staging/erofs/erofs_fs.h
rename to fs/erofs/erofs_fs.h
index e82e833985e4..25bda459f2e6 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
 /*
- * linux/drivers/staging/erofs/erofs_fs.h
+ * linux/fs/erofs/erofs_fs.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
@@ -10,7 +10,6 @@
 #define __EROFS_FS_H
 
 /* Enhanced(Extended) ROM File System */
-#define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
 /*
diff --git a/drivers/staging/erofs/inode.c b/fs/erofs/inode.c
similarity index 99%
rename from drivers/staging/erofs/inode.c
rename to fs/erofs/inode.c
index 286729143365..2c771063889b 100644
--- a/drivers/staging/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/inode.c
+ * linux/fs/erofs/inode.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/internal.h b/fs/erofs/internal.h
similarity index 99%
rename from drivers/staging/erofs/internal.h
rename to fs/erofs/internal.h
index 118e7c7e4d4d..f4b50b59cda3 100644
--- a/drivers/staging/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/internal.h
+ * linux/fs/erofs/internal.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
@@ -16,6 +16,7 @@
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
 #include <linux/cleancache.h>
+#include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "erofs_fs.h"
diff --git a/drivers/staging/erofs/namei.c b/fs/erofs/namei.c
similarity index 99%
rename from drivers/staging/erofs/namei.c
rename to fs/erofs/namei.c
index 8e06526da023..ccce53d46547 100644
--- a/drivers/staging/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/namei.c
+ * linux/fs/erofs/namei.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/super.c b/fs/erofs/super.c
similarity index 99%
rename from drivers/staging/erofs/super.c
rename to fs/erofs/super.c
index f65a1ff9f42f..95187619b3e3 100644
--- a/drivers/staging/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/super.c
+ * linux/fs/erofs/super.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/tagptr.h b/fs/erofs/tagptr.h
similarity index 100%
rename from drivers/staging/erofs/tagptr.h
rename to fs/erofs/tagptr.h
diff --git a/drivers/staging/erofs/utils.c b/fs/erofs/utils.c
similarity index 99%
rename from drivers/staging/erofs/utils.c
rename to fs/erofs/utils.c
index 814c2ee037ae..c48e417d3926 100644
--- a/drivers/staging/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/utils.c
+ * linux/fs/erofs/utils.c
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/xattr.c b/fs/erofs/xattr.c
similarity index 99%
rename from drivers/staging/erofs/xattr.c
rename to fs/erofs/xattr.c
index b29177a17347..148ceaf72790 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/xattr.c
+ * linux/fs/erofs/xattr.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/xattr.h b/fs/erofs/xattr.h
similarity index 98%
rename from drivers/staging/erofs/xattr.h
rename to fs/erofs/xattr.h
index 63cc87e3d3f4..d4213fff57e7 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/xattr.h
+ * linux/fs/erofs/xattr.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/zdata.c b/fs/erofs/zdata.c
similarity index 99%
rename from drivers/staging/erofs/zdata.c
rename to fs/erofs/zdata.c
index 2d7aaf98f7de..24be7d98bce3 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/zdata.c
+ * linux/fs/erofs/zdata.c
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/zdata.h b/fs/erofs/zdata.h
similarity index 99%
rename from drivers/staging/erofs/zdata.h
rename to fs/erofs/zdata.h
index e11fe1959ca2..506ca46727db 100644
--- a/drivers/staging/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/zdata.h
+ * linux/fs/erofs/zdata.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/zmap.c b/fs/erofs/zmap.c
similarity index 99%
rename from drivers/staging/erofs/zmap.c
rename to fs/erofs/zmap.c
index aeed5c674d9e..d887ea6d4fd5 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/zmap.c
+ * linux/fs/erofs/zmap.c
  *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/zpvec.h b/fs/erofs/zpvec.h
similarity index 98%
rename from drivers/staging/erofs/zpvec.h
rename to fs/erofs/zpvec.h
index 9798f5627786..bb7689e67836 100644
--- a/drivers/staging/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/zpvec.h
+ * linux/fs/erofs/zpvec.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/include/trace/events/erofs.h b/include/trace/events/erofs.h
similarity index 100%
rename from drivers/staging/erofs/include/trace/events/erofs.h
rename to include/trace/events/erofs.h
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 1274c692e59c..903cc2d2750b 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -19,6 +19,7 @@
 #define SQUASHFS_MAGIC		0x73717368
 #define ECRYPTFS_SUPER_MAGIC	0xf15f
 #define EFS_SUPER_MAGIC		0x414A53
+#define EROFS_SUPER_MAGIC_V1	0xE0F5E1E2
 #define EXT2_SUPER_MAGIC	0xEF53
 #define EXT3_SUPER_MAGIC	0xEF53
 #define XENFS_SUPER_MAGIC	0xabba1974
-- 
2.17.1

