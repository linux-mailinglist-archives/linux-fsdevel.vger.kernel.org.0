Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB851F64C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiEIIDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 04:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiEIHo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 03:44:57 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17B17050;
        Mon,  9 May 2022 00:41:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VCfxsZ3_1652082046;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCfxsZ3_1652082046)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 15:40:47 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v11 11/22] erofs: register fscache volume
Date:   Mon,  9 May 2022 15:40:17 +0800
Message-Id: <20220509074028.74954-12-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new fscache based mode is going to be introduced for erofs, in which
case on-demand read semantics is implemented through fscache.

As the first step, register fscache volume for each erofs filesystem.
That means, data blobs can not be shared among erofs filesystems. In the
following iteration, we are going to introduce the domain semantics, in
which case several erofs filesystems can belong to one domain, and data
blobs can be shared among these erofs filesystems of one domain.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig    | 10 ++++++++++
 fs/erofs/Makefile   |  1 +
 fs/erofs/fscache.c  | 37 +++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h | 16 ++++++++++++++++
 fs/erofs/super.c    |  5 +++++
 5 files changed, 69 insertions(+)
 create mode 100644 fs/erofs/fscache.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f57255ab88ed..85490370e0ca 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -98,3 +98,13 @@ config EROFS_FS_ZIP_LZMA
 	  systems will be readable without selecting this option.
 
 	  If unsure, say N.
+
+config EROFS_FS_ONDEMAND
+	bool "EROFS fscache-based on-demand read support"
+	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
+	default n
+	help
+	  This permits EROFS to use fscache-backed data blobs with on-demand
+	  read support.
+
+	  If unsure, say N.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 8a3317e38e5a..99bbc597a3e9 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -5,3 +5,4 @@ erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
+erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
new file mode 100644
index 000000000000..7a6d0239ebb1
--- /dev/null
+++ b/fs/erofs/fscache.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022, Alibaba Cloud
+ */
+#include <linux/fscache.h>
+#include "internal.h"
+
+int erofs_fscache_register_fs(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct fscache_volume *volume;
+	char *name;
+	int ret = 0;
+
+	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
+	if (!name)
+		return -ENOMEM;
+
+	volume = fscache_acquire_volume(name, NULL, NULL, 0);
+	if (IS_ERR_OR_NULL(volume)) {
+		erofs_err(sb, "failed to register volume for %s", name);
+		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
+		volume = NULL;
+	}
+
+	sbi->volume = volume;
+	kfree(name);
+	return ret;
+}
+
+void erofs_fscache_unregister_fs(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	fscache_relinquish_volume(sbi->volume, NULL, false);
+	sbi->volume = NULL;
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 05a97533b1e9..e4f6a13f161f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -74,6 +74,7 @@ struct erofs_mount_opts {
 	unsigned int max_sync_decompress_pages;
 #endif
 	unsigned int mount_opt;
+	char *fsid;
 };
 
 struct erofs_dev_context {
@@ -146,6 +147,9 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+
+	/* fscache support */
+	struct fscache_volume *volume;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -618,6 +622,18 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+/* fscache.c */
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+int erofs_fscache_register_fs(struct super_block *sb);
+void erofs_fscache_unregister_fs(struct super_block *sb);
+#else
+static inline int erofs_fscache_register_fs(struct super_block *sb)
+{
+	return 0;
+}
+static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
+#endif
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 724d5ff0d78c..fd8daa447237 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -602,6 +602,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (erofs_is_fscache_mode(sb)) {
 		sb->s_blocksize = EROFS_BLKSIZ;
 		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+
+		err = erofs_fscache_register_fs(sb);
+		if (err)
+			return err;
 	} else {
 		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 			erofs_err(sb, "failed to set erofs blksize");
@@ -768,6 +772,7 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev);
+	erofs_fscache_unregister_fs(sb);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
-- 
2.27.0

