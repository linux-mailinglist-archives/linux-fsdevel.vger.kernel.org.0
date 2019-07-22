Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04986F77B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 04:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfGVCvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 22:51:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728822AbfGVCvU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:51:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC28A5AF24DE8EB2021C;
        Mon, 22 Jul 2019 10:51:18 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:51:10 +0800
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
Subject: [PATCH v3 14/24] erofs: introduce superblock registration
Date:   Mon, 22 Jul 2019 10:50:33 +0800
Message-ID: <20190722025043.166344-15-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722025043.166344-1-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to introducing shrinker solution for erofs,
let's manage all mounted erofs instances at first.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Makefile   |  2 +-
 fs/erofs/internal.h | 13 +++++++++++++
 fs/erofs/super.c    |  9 +++++++++
 fs/erofs/utils.c    | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/utils.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 9ab4ccc9328e..6a63c5998980 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -5,7 +5,7 @@ EROFS_VERSION = "1.0"
 ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += zmap.o
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 55e794bd31cd..942e3cbe6076 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -61,6 +61,10 @@ typedef u64 erofs_off_t;
 typedef u32 erofs_blk_t;
 
 struct erofs_sb_info {
+#ifdef CONFIG_EROFS_FS_ZIP
+	/* list for all registered superblocks, mainly for shrinker */
+	struct list_head list;
+#endif
 	u32 blocks;
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -404,5 +408,14 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
+/* utils.c */
+#ifdef CONFIG_EROFS_FS_ZIP
+void erofs_shrinker_register(struct super_block *sb);
+void erofs_shrinker_unregister(struct super_block *sb);
+#else
+static inline void erofs_shrinker_register(struct super_block *sb) {}
+static inline void erofs_shrinker_unregister(struct super_block *sb) {}
+#endif
+
 #endif
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9ddb593aef47..c8bd77e3c355 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,6 +356,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	if (unlikely(!sb->s_root))
 		return -ENOMEM;
 
+	erofs_shrinker_register(sb);
+
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
 	return 0;
@@ -387,6 +389,12 @@ static void erofs_kill_sb(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
+/* called when ->s_root is non-NULL */
+static void erofs_put_super(struct super_block *sb)
+{
+	erofs_shrinker_unregister(sb);
+}
+
 static struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
@@ -498,6 +506,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 }
 
 const struct super_operations erofs_sops = {
+	.put_super = erofs_put_super,
 	.alloc_inode = alloc_inode,
 	.free_inode = free_inode,
 	.statfs = erofs_statfs,
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
new file mode 100644
index 000000000000..08c8752895bc
--- /dev/null
+++ b/fs/erofs/utils.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/erofs/utils.c
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "internal.h"
+
+#ifdef CONFIG_EROFS_FS_ZIP
+/* protects the mounted 'erofs_sb_list' */
+static DEFINE_SPINLOCK(erofs_sb_list_lock);
+static LIST_HEAD(erofs_sb_list);
+
+void erofs_shrinker_register(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	spin_lock(&erofs_sb_list_lock);
+	list_add(&sbi->list, &erofs_sb_list);
+	spin_unlock(&erofs_sb_list_lock);
+}
+
+void erofs_shrinker_unregister(struct super_block *sb)
+{
+	spin_lock(&erofs_sb_list_lock);
+	list_del(&EROFS_SB(sb)->list);
+	spin_unlock(&erofs_sb_list_lock);
+}
+#endif
+
-- 
2.17.1

