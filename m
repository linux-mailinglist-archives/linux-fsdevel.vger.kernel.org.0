Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8347FD10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhL0MzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:00 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58404 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236813AbhL0My5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:54:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.vxTIo_1640609693;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.vxTIo_1640609693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:54:54 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/23] erofs: register global fscache volume
Date:   Mon, 27 Dec 2021 20:54:29 +0800
Message-Id: <20211227125444.21187-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All erofs instances will share one global fscache volume.

In this using scenario, one erofs instance could be mounted from one (or
multiple) blob files instead of blkdev. The number of blob files that
each erofs instance could correspond to is limited, since these blob
files are quite large in size. For example, when used for container
image distribution, one erofs instance used for container image for
node.js will correspond to ~20 blob files in total. Thus in densely
employed environment, there could be as many as hundreds of containers
and thus thousands of fscache cookies under one fscache volume.

Then as for cachefiles backend, the hash table managing all cookies
under one volume contains 32K slots. Thus the hashing functionality shall
scale well in this case. Besides, cachefiles backend will scatter
backing files under 256 fan sub-directoris, and thus the scalability of
looking up backing files shall also not be an issue.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Makefile   |  2 +-
 fs/erofs/fscache.c  | 21 +++++++++++++++++++++
 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    |  7 +++++++
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/fscache.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 756fe2d65272..f9a3609625aa 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o fscache.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
new file mode 100644
index 000000000000..cdbbe3f15a20
--- /dev/null
+++ b/fs/erofs/fscache.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021, Alibaba Cloud
+ */
+#include "internal.h"
+
+static struct fscache_volume *volume;
+
+int __init erofs_fscache_init(void)
+{
+	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
+	if (!volume)
+		return -EINVAL;
+
+	return 0;
+}
+
+void erofs_fscache_cleanup(void)
+{
+	fscache_relinquish_volume(volume, NULL, false);
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c9ee8c247202..d464642e9d35 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
+#include <linux/fscache.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -569,6 +570,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+/* fscache.c */
+int erofs_fscache_init(void);
+void erofs_fscache_cleanup(void);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 80c00c34eafc..517d74f3c303 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -876,6 +876,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto zip_err;
 
+	err = erofs_fscache_init();
+	if (err)
+		goto fscache_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -883,6 +887,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_fscache_cleanup();
+fscache_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
 	z_erofs_lzma_exit();
@@ -901,6 +907,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
 
+	erofs_fscache_cleanup();
 	z_erofs_exit_zip_subsystem();
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
-- 
2.27.0

