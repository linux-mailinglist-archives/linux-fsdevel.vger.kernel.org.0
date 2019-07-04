Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2687B5F934
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGDNfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 09:35:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfGDNfg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:35:36 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8A29EF142BE299BEB541;
        Thu,  4 Jul 2019 21:35:31 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul 2019
 21:35:21 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: [PATCH] erofs: promote erofs from staging
Date:   Thu, 4 Jul 2019 21:34:13 +0800
Message-ID: <20190704133413.43012-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
a reason why erofs can be landed to speed up mobile phone
performance, and which can be probably used for other use cases
such as LiveCD and Docker image as well.

Currently erofs supports 4k LZ4 fixed-size output compression
since LZ4 is the fastest widely-used decompression solution in
the world and 4k leads to unnoticable read amplification for
the worst case. More compression algorithms and cluster sizes
could be added later, which depends on the real requirement.

More informations about erofs itself are available at:
 Documentation/filesystems/erofs.txt
 https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei

erofs-utils (mainly mkfs.erofs now) is available at
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git

Preliminary iomap support has been pending in erofs mailing
list by Chao Yu. The key issue is that current iomap doesn't
support tail-end packing inline data yet, it should be
resolved later.

Thanks to many contributors in the last year, the code is more
clean and improved. We hope erofs can be used in wider use cases
so let's promote erofs out of staging and enhance it more actively.

Share comments about erofs! We think erofs is useful to
community as a part of Linux upstream :)

[1] http://web.archive.org/web/20190627021241/https://consumer.huawei.com/en/emui/
[2] https://lore.kernel.org/lkml/20190624072258.28362-1-hsiangkao@aol.com/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Note that,

This patch is based on commit 5b2736ce361989882636d4b105d1146ca3382f47
of staging-next, the latest erofs code is available at

http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs?h=staging-next

with decompression in-place implementation.

The first formal release of erofs-utils will be released after erofs
is moved into fs/ in case of some major changes raised, the latest
erofs-utils is available in experimental-dip branch of erofs-utils:

git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-dip

Thanks,
Gao Xiang

 .../filesystems/erofs.txt                     |  0
 MAINTAINERS                                   | 14 +++---
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 drivers/staging/erofs/TODO                    | 46 -------------------
 fs/Kconfig                                    |  1 +
 fs/Makefile                                   |  2 +
 {drivers/staging => fs}/erofs/Kconfig         |  0
 {drivers/staging => fs}/erofs/Makefile        |  4 +-
 {drivers/staging => fs}/erofs/compress.h      |  2 +-
 {drivers/staging => fs}/erofs/data.c          |  6 +--
 {drivers/staging => fs}/erofs/decompressor.c  |  2 +-
 {drivers/staging => fs}/erofs/dir.c           |  6 +--
 {drivers/staging => fs}/erofs/erofs_fs.h      | 10 ++--
 {drivers/staging => fs}/erofs/inode.c         |  2 +-
 {drivers/staging => fs}/erofs/internal.h      |  6 +--
 {drivers/staging => fs}/erofs/namei.c         |  2 +-
 {drivers/staging => fs}/erofs/super.c         |  2 +-
 .../erofs/include/linux => fs/erofs}/tagptr.h |  4 +-
 {drivers/staging => fs}/erofs/unzip_pagevec.h |  8 ++--
 {drivers/staging => fs}/erofs/unzip_vle.c     |  6 +--
 {drivers/staging => fs}/erofs/unzip_vle.h     | 10 ++--
 {drivers/staging => fs}/erofs/utils.c         |  6 +--
 {drivers/staging => fs}/erofs/xattr.c         |  6 +--
 {drivers/staging => fs}/erofs/xattr.h         | 10 ++--
 {drivers/staging => fs}/erofs/zmap.c          |  2 +-
 .../include => include}/trace/events/erofs.h  |  0
 27 files changed, 40 insertions(+), 120 deletions(-)
 rename {drivers/staging/erofs/Documentation => Documentation}/filesystems/erofs.txt (100%)
 delete mode 100644 drivers/staging/erofs/TODO
 rename {drivers/staging => fs}/erofs/Kconfig (100%)
 rename {drivers/staging => fs}/erofs/Makefile (68%)
 rename {drivers/staging => fs}/erofs/compress.h (97%)
 rename {drivers/staging => fs}/erofs/data.c (97%)
 rename {drivers/staging => fs}/erofs/decompressor.c (99%)
 rename {drivers/staging => fs}/erofs/dir.c (94%)
 rename {drivers/staging => fs}/erofs/erofs_fs.h (96%)
 rename {drivers/staging => fs}/erofs/inode.c (99%)
 rename {drivers/staging => fs}/erofs/internal.h (99%)
 rename {drivers/staging => fs}/erofs/namei.c (99%)
 rename {drivers/staging => fs}/erofs/super.c (99%)
 rename {drivers/staging/erofs/include/linux => fs/erofs}/tagptr.h (98%)
 rename {drivers/staging => fs}/erofs/unzip_pagevec.h (97%)
 rename {drivers/staging => fs}/erofs/unzip_vle.c (99%)
 rename {drivers/staging => fs}/erofs/unzip_vle.h (94%)
 rename {drivers/staging => fs}/erofs/utils.c (97%)
 rename {drivers/staging => fs}/erofs/xattr.c (98%)
 rename {drivers/staging => fs}/erofs/xattr.h (90%)
 rename {drivers/staging => fs}/erofs/zmap.c (99%)
 rename {drivers/staging/erofs/include => include}/trace/events/erofs.h (100%)

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
similarity index 100%
rename from drivers/staging/erofs/Documentation/filesystems/erofs.txt
rename to Documentation/filesystems/erofs.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index c0a02dccc869..9aa9564c5ff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5957,6 +5957,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	drivers/video/fbdev/s1d13xxxfb.c
 F:	include/video/s1d13xxxfb.h
 
+EROFS FILE SYSTEM
+M:	Gao Xiang <gaoxiang25@huawei.com>
+M:	Chao Yu <yuchao0@huawei.com>
+L:	linux-erofs@lists.ozlabs.org
+S:	Maintained
+F:	fs/erofs/
+
 ERRSEQ ERROR TRACKING INFRASTRUCTURE
 M:	Jeff Layton <jlayton@kernel.org>
 S:	Maintained
@@ -14956,13 +14963,6 @@ M:	H Hartley Sweeten <hsweeten@visionengravers.com>
 S:	Odd Fixes
 F:	drivers/staging/comedi/
 
-STAGING - EROFS FILE SYSTEM
-M:	Gao Xiang <gaoxiang25@huawei.com>
-M:	Chao Yu <yuchao0@huawei.com>
-L:	linux-erofs@lists.ozlabs.org
-S:	Maintained
-F:	drivers/staging/erofs/
-
 STAGING - FIELDBUS SUBSYSTEM
 M:	Sven Van Asbroeck <TheSven73@gmail.com>
 S:	Maintained
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d5f771fafc21..52a14064fd9d 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -112,8 +112,6 @@ source "drivers/staging/gasket/Kconfig"
 
 source "drivers/staging/axis-fifo/Kconfig"
 
-source "drivers/staging/erofs/Kconfig"
-
 source "drivers/staging/fieldbus/Kconfig"
 
 source "drivers/staging/kpc2000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 0da0d3f0b5e4..a356a2a305ac 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,6 +46,5 @@ obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
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
index f1046cf6ad85..529a174cbb9c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -262,6 +262,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/erofs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..01011260ea83 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,5 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_EROFS_FS)		+= erofs/
+
diff --git a/drivers/staging/erofs/Kconfig b/fs/erofs/Kconfig
similarity index 100%
rename from drivers/staging/erofs/Kconfig
rename to fs/erofs/Kconfig
diff --git a/drivers/staging/erofs/Makefile b/fs/erofs/Makefile
similarity index 68%
rename from drivers/staging/erofs/Makefile
rename to fs/erofs/Makefile
index e704d9e51514..978b395f5f2e 100644
--- a/drivers/staging/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-EROFS_VERSION = "1.0pre1"
+EROFS_VERSION = "1.0"
 
 ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-# staging requirement: to be self-contained in its own directory
-ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o zmap.o decompressor.o
diff --git a/drivers/staging/erofs/compress.h b/fs/erofs/compress.h
similarity index 97%
rename from drivers/staging/erofs/compress.h
rename to fs/erofs/compress.h
index c43aa3374d28..8853e0a66eaa 100644
--- a/drivers/staging/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/drivers/staging/erofs/compress.h
+ * linux/fs/erofs/compress.h
  *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/data.c b/fs/erofs/data.c
similarity index 97%
rename from drivers/staging/erofs/data.c
rename to fs/erofs/data.c
index cc31c3e5984c..aac26d62e96e 100644
--- a/drivers/staging/erofs/data.c
+++ b/fs/erofs/data.c
@@ -1,14 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/data.c
+ * linux/fs/erofs/data.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 #include "internal.h"
 #include <linux/prefetch.h>
diff --git a/drivers/staging/erofs/decompressor.c b/fs/erofs/decompressor.c
similarity index 99%
rename from drivers/staging/erofs/decompressor.c
rename to fs/erofs/decompressor.c
index 1fb0abb98dff..90413f0214b0 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/decompressor.c
+ * linux/fs/erofs/decompressor.c
  *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/dir.c b/fs/erofs/dir.c
similarity index 94%
rename from drivers/staging/erofs/dir.c
rename to fs/erofs/dir.c
index dbf6a151886c..f5bedf4e142f 100644
--- a/drivers/staging/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -1,14 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/dir.c
+ * linux/fs/erofs/dir.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 #include "internal.h"
 
diff --git a/drivers/staging/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
similarity index 96%
rename from drivers/staging/erofs/erofs_fs.h
rename to fs/erofs/erofs_fs.h
index 9f61abb7c1ca..25e79cb7592c 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -1,14 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0
- *
- * linux/drivers/staging/erofs/erofs_fs.h
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+/*
+ * linux/fs/erofs/erofs_fs.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is dual-licensed; you may select either the GNU General Public
- * License version 2 or Apache License, Version 2.0. See the file COPYING
- * in the main directory of the Linux distribution for more details.
  */
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
diff --git a/drivers/staging/erofs/inode.c b/fs/erofs/inode.c
similarity index 99%
rename from drivers/staging/erofs/inode.c
rename to fs/erofs/inode.c
index 4c3d8bf8d249..8a1ec719c11d 100644
--- a/drivers/staging/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
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
index 963cc1b8b896..c1704451c0af 100644
--- a/drivers/staging/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -1,6 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * linux/drivers/staging/erofs/internal.h
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/fs/erofs/internal.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/namei.c b/fs/erofs/namei.c
similarity index 99%
rename from drivers/staging/erofs/namei.c
rename to fs/erofs/namei.c
index fd3ae78d0ba5..42941d29b699 100644
--- a/drivers/staging/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
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
index 54494412eba4..ebf4feb08434 100644
--- a/drivers/staging/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/super.c
+ * linux/fs/erofs/super.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/include/linux/tagptr.h b/fs/erofs/tagptr.h
similarity index 98%
rename from drivers/staging/erofs/include/linux/tagptr.h
rename to fs/erofs/tagptr.h
index ccd106dbd48e..be9e52cc2e28 100644
--- a/drivers/staging/erofs/include/linux/tagptr.h
+++ b/fs/erofs/tagptr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Tagged pointer implementation
  *
  * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/unzip_pagevec.h b/fs/erofs/unzip_pagevec.h
similarity index 97%
rename from drivers/staging/erofs/unzip_pagevec.h
rename to fs/erofs/unzip_pagevec.h
index 7af0ba8d8495..e73c08089f5b 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/fs/erofs/unzip_pagevec.h
@@ -1,6 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * linux/drivers/staging/erofs/unzip_pagevec.h
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/fs/erofs/unzip_pagevec.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
@@ -13,7 +13,7 @@
 #ifndef __EROFS_UNZIP_PAGEVEC_H
 #define __EROFS_UNZIP_PAGEVEC_H
 
-#include <linux/tagptr.h>
+#include "tagptr.h"
 
 /* page type in pagevec for unzip subsystem */
 enum z_erofs_page_type {
diff --git a/drivers/staging/erofs/unzip_vle.c b/fs/erofs/unzip_vle.c
similarity index 99%
rename from drivers/staging/erofs/unzip_vle.c
rename to fs/erofs/unzip_vle.c
index f0dab81ff816..2e5ff8939905 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/fs/erofs/unzip_vle.c
@@ -1,14 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/unzip_vle.c
+ * linux/fs/erofs/unzip_vle.c
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 #include "unzip_vle.h"
 #include "compress.h"
diff --git a/drivers/staging/erofs/unzip_vle.h b/fs/erofs/unzip_vle.h
similarity index 94%
rename from drivers/staging/erofs/unzip_vle.h
rename to fs/erofs/unzip_vle.h
index ab509d75aefd..4d2010206aa5 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/fs/erofs/unzip_vle.h
@@ -1,14 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * linux/drivers/staging/erofs/unzip_vle.h
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/fs/erofs/unzip_vle.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 #ifndef __EROFS_FS_UNZIP_VLE_H
 #define __EROFS_FS_UNZIP_VLE_H
diff --git a/drivers/staging/erofs/utils.c b/fs/erofs/utils.c
similarity index 97%
rename from drivers/staging/erofs/utils.c
rename to fs/erofs/utils.c
index 4bbd3bf34acd..eedaf0e84f34 100644
--- a/drivers/staging/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -1,14 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/utils.c
+ * linux/fs/erofs/utils.c
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 
 #include "internal.h"
diff --git a/drivers/staging/erofs/xattr.c b/fs/erofs/xattr.c
similarity index 98%
rename from drivers/staging/erofs/xattr.c
rename to fs/erofs/xattr.c
index df40654b9fbb..4c48430af608 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -1,14 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/xattr.c
+ * linux/fs/erofs/xattr.c
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 #include <linux/security.h>
 #include "xattr.h"
diff --git a/drivers/staging/erofs/xattr.h b/fs/erofs/xattr.h
similarity index 90%
rename from drivers/staging/erofs/xattr.h
rename to fs/erofs/xattr.h
index 35ba5ac2139a..80d6ef8aa09f 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -1,14 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * linux/drivers/staging/erofs/xattr.h
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/fs/erofs/xattr.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
  */
 #ifndef __EROFS_XATTR_H
 #define __EROFS_XATTR_H
diff --git a/drivers/staging/erofs/zmap.c b/fs/erofs/zmap.c
similarity index 99%
rename from drivers/staging/erofs/zmap.c
rename to fs/erofs/zmap.c
index 9c0bd65c46bf..bf3d46585a6f 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/staging/erofs/zmap.c
+ * linux/fs/erofs/zmap.c
  *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/drivers/staging/erofs/include/trace/events/erofs.h b/include/trace/events/erofs.h
similarity index 100%
rename from drivers/staging/erofs/include/trace/events/erofs.h
rename to include/trace/events/erofs.h
-- 
2.17.1

