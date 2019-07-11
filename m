Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF04659D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGKO6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:58:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729143AbfGKO6f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45E9E59E32B6C0A1177B;
        Thu, 11 Jul 2019 22:58:33 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:27 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 10/24] erofs: update Kconfig and Makefile
Date:   Thu, 11 Jul 2019 22:57:41 +0800
Message-ID: <20190711145755.33908-11-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds Makefile and Kconfig for erofs, and
updates Makefile and Kconfig files in the fs directory.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/Kconfig        |  1 +
 fs/Makefile       |  1 +
 fs/erofs/Kconfig  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/Makefile |  9 +++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 fs/erofs/Kconfig
 create mode 100644 fs/erofs/Makefile

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
index c9aea23aba56..6166f533abf7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_EROFS_FS)		+= erofs/
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
new file mode 100644
index 000000000000..bcab58d3f709
--- /dev/null
+++ b/fs/erofs/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config EROFS_FS
+	tristate "EROFS filesystem support"
+	depends on BLOCK
+	help
+	  EROFS (Enhanced Read-Only File System) is a lightweight
+	  read-only file system with modern designs (eg. page-sized
+	  blocks, inline xattrs/data, etc.) for scenarios which need
+	  high-performance read-only requirements, e.g. Android OS
+	  for mobile phones and LIVECDs.
+
+	  It also provides fixed-sized output compression support,
+	  which improves storage density, keeps relatively higher
+	  compression ratios, which is more useful to achieve high
+	  performance for embedded devices with limited memory.
+
+	  If unsure, say N.
+
+config EROFS_FS_DEBUG
+	bool "EROFS debugging feature"
+	depends on EROFS_FS
+	help
+	  Print debugging messages and enable more BUG_ONs which check
+	  filesystem consistency and find potential issues aggressively,
+	  which can be used for Android eng build, for example.
+
+	  For daily use, say N.
+
+config EROFS_FAULT_INJECTION
+	bool "EROFS fault injection facility"
+	depends on EROFS_FS
+	help
+	  Test EROFS to inject faults such as ENOMEM, EIO, and so on.
+	  If unsure, say N.
+
+config EROFS_FS_IO_MAX_RETRIES
+	int "EROFS IO Maximum Retries"
+	depends on EROFS_FS
+	default "5"
+	help
+	  Maximum retry count of IO Errors.
+
+	  If unsure, leave the default value (5 retries, 6 IOs at most).
+
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
new file mode 100644
index 000000000000..ec2795f33dc5
--- /dev/null
+++ b/fs/erofs/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+EROFS_VERSION = "1.0"
+
+ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
+
+obj-$(CONFIG_EROFS_FS) += erofs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o
+
-- 
2.17.1

