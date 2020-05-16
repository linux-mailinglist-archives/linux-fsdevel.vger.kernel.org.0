Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA631D5E21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEPDUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 23:20:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53092 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEPDUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 23:20:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id a5so1774528pjh.2;
        Fri, 15 May 2020 20:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gac/mN4AfeIMEChEWmK6V+U1QgypRl3Zka9putsz1Sw=;
        b=q4Y9mQvSsAaiCgaARCjAtEpPftmEpEAEVYLGaqgYvuK+g+ntnxvStS82rq5gGyhZgu
         6/E+Hlb8mmHOefpjkBONcbpNSPq6NjQYkmjjs+NdLTfZR02n5y+JxJJitjlEYs0y5Iqa
         m9IdjTZEBUy6UpU/n07S9fRULk0MrWCe5f2ayQFGNuPfHZQsQ8U9HC7Ccg5yJF9vtwTC
         OoJ9GKrUBBrYDLDRGAy/537iEQNPXeD2PfQmw0bRMObeM7QG1yUf6+yIUC7TFrMIE01D
         Olv7opYVUyCGWRYRRjAxWBi1Tm22umLp8hLWrxHLlHrBV9l9dKpoxi3hi9RveEiB37mb
         kyjw==
X-Gm-Message-State: AOAM532jB1tYP4ajy0ixVRNWu47+tUpHg8CkTLhw5V7mfJQb1CHhzm6w
        omfuIM6s42TtTFP2W0L9K+A=
X-Google-Smtp-Source: ABdhPJyncY/IKQFIEvzxiRDm4PnXBpNSJHnsTrum9DzXHAoTK2J8fwsz7eoAFaECZ1/ypXxv4IzkiQ==
X-Received: by 2002:a17:90a:138c:: with SMTP id i12mr6728153pja.36.1589599204708;
        Fri, 15 May 2020 20:20:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p2sm2737476pgh.25.2020.05.15.20.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:20:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 46CD441DAB; Sat, 16 May 2020 03:19:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v5 4/7] block: move main block debugfs initialization to its own file
Date:   Sat, 16 May 2020 03:19:53 +0000
Message-Id: <20200516031956.2605-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200516031956.2605-1-mcgrof@kernel.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

make_request-based drivers and and request-based drivers share some
debugfs code. By moving this into its own file it makes it easier
to expand and audit this shared code.

This patch contains no functional changes.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/Makefile      | 10 +++++++---
 block/blk-core.c    |  9 +--------
 block/blk-debugfs.c | 15 +++++++++++++++
 block/blk.h         |  8 ++++++++
 4 files changed, 31 insertions(+), 11 deletions(-)
 create mode 100644 block/blk-debugfs.c

diff --git a/block/Makefile b/block/Makefile
index 78719169fb2a..ec4b17f9dd93 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
+			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
+			debugfs.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
@@ -32,8 +33,11 @@ obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
 obj-$(CONFIG_BLK_MQ_RDMA)	+= blk-mq-rdma.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
-obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
-obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
+
+debugfs-$(CONFIG_DEBUG_FS)		+= blk-debugfs.o
+debugfs-$(CONFIG_BLK_DEBUG_FS)		+= blk-mq-debugfs.o
+debugfs-$(CONFIG_BLK_DEBUG_FS_ZONED)	+= blk-mq-debugfs-zoned.o
+
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 8a785d16033b..d40648958767 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -51,10 +51,6 @@
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
-#ifdef CONFIG_DEBUG_FS
-struct dentry *blk_debugfs_root;
-#endif
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
@@ -1880,10 +1876,7 @@ int __init blk_dev_init(void)
 
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
-
-#ifdef CONFIG_DEBUG_FS
-	blk_debugfs_root = debugfs_create_dir("block", NULL);
-#endif
+	blk_debugfs_register();
 
 	return 0;
 }
diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
new file mode 100644
index 000000000000..19091e1effc0
--- /dev/null
+++ b/block/blk-debugfs.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Shared request-based / make_request-based functionality
+ */
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/debugfs.h>
+
+struct dentry *blk_debugfs_root;
+
+void blk_debugfs_register(void)
+{
+	blk_debugfs_root = debugfs_create_dir("block", NULL);
+}
diff --git a/block/blk.h b/block/blk.h
index fc00537026a0..ee309233f95e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -458,4 +458,12 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+#ifdef CONFIG_DEBUG_FS
+void blk_debugfs_register(void);
+#else
+static inline void blk_debugfs_register(void)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif /* BLK_INTERNAL_H */
-- 
2.26.2

