Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5553C74AD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfGYJ54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 05:57:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391171AbfGYJ5y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:57:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8E17950D09272F859AF;
        Thu, 25 Jul 2019 17:57:51 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 17:57:45 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "David Sterba" <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v4 17/24] erofs: introduce per-CPU buffers implementation
Date:   Thu, 25 Jul 2019 17:56:51 +0800
Message-ID: <20190725095658.155779-18-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725095658.155779-1-gaoxiang25@huawei.com>
References: <20190725095658.155779-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces per-CPU buffers in order for
the upcoming generic decompression framework to use.

Note that I tried to use in-kernel per-CPU buffer or
per-CPU page approaches to clean up further, however
noticeable performanace regression (about 2% for
sequential read) was observed.

Let's leave it as-is for now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Kconfig    | 14 ++++++++++++++
 fs/erofs/internal.h | 25 +++++++++++++++++++++++++
 fs/erofs/utils.c    | 12 ++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index a475fbebb831..5f8787c0cf89 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -81,3 +81,17 @@ config EROFS_FS_ZIP
 
 	  If you don't want to enable compression feature, say N.
 
+config EROFS_FS_CLUSTER_PAGE_LIMIT
+	int "EROFS Cluster Pages Hard Limit"
+	depends on EROFS_FS_ZIP
+	range 1 256
+	default "1"
+	help
+	  Indicates maximum # of pages of a compressed
+	  physical cluster.
+
+	  For example, if files in a image were compressed
+	  into 8k-unit, hard limit should not be configured
+	  less than 2. Otherwise, the image will be refused
+	  to mount on this kernel.
+
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3d908dcaadad..410e1b7ef82e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -224,6 +224,16 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	return v;
 }
 #endif	/* !CONFIG_SMP */
+
+#ifdef CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT
+#define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
+#else
+#define Z_EROFS_CLUSTER_MAX_PAGES       1
+#endif	/* !CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT */
+
+#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
+#else
+#define EROFS_PCPUBUF_NR_PAGES          0
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
@@ -482,6 +492,21 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c */
+#if (EROFS_PCPUBUF_NR_PAGES > 0)
+void *erofs_get_pcpubuf(unsigned int pagenr);
+#define erofs_put_pcpubuf(buf) do { \
+	(void)&(buf);	\
+	preempt_enable();	\
+} while (0)
+#else
+static inline void *erofs_get_pcpubuf(unsigned int pagenr)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+#define erofs_put_pcpubuf(buf) do {} while (0)
+#endif
+
 #ifdef CONFIG_EROFS_FS_ZIP
 int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 56f27fe901b7..ffaa226746b8 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -9,6 +9,18 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
+#if (EROFS_PCPUBUF_NR_PAGES > 0)
+static struct {
+	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
+} ____cacheline_aligned_in_smp erofs_pcpubuf[NR_CPUS];
+
+void *erofs_get_pcpubuf(unsigned int pagenr)
+{
+	preempt_disable();
+	return &erofs_pcpubuf[smp_processor_id()].data[pagenr * PAGE_SIZE];
+}
+#endif
+
 #ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
-- 
2.17.1

