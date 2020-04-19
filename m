Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25561AFDC1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgDSTq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:46:26 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40274 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgDSTpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:43 -0400
Received: by mail-pj1-f67.google.com with SMTP id a22so3475529pjk.5;
        Sun, 19 Apr 2020 12:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6zFNIw10vgpvTX2Zn0RR00QHrc+pqJgnMvwYTYZ65c=;
        b=gcFAIB6IpOolxYN7xaroQI0p1Bj0Q616EeI6dpoWhOdJnLYvzW4TCt5zqHVszqboPb
         nRciDBwQr6iIP0AZqZuSoHm+wslvjneMo1RDmYvGQTKrefP6pv+ohBizw86vxHT5/oyb
         c3uYhfsx81pFfSWczKZ4NTRGbbUC/TpR8JJMWgmFRd9zr36JXM2cOn48zBZ1DBrjjuVa
         49Eq43yb8NjiC/2u1B9yuKK3uiS6rS/gPlr+wVXkbQBKTYJbQNteOKgy68+jQ+1eWXgz
         nIgwAcWKMGADGJ4LmVUGDAUMDrXp76GWpk2BQBpBI3uv6hCEspTCpfMaTd6ZaJ1Hn3hr
         s32Q==
X-Gm-Message-State: AGi0PublMAwLieWZgSTb4+re5HziQdFDYF7i+qS0Gex7xP5pClq1bjRO
        FyOjDdyc/rWpxHxL1m16ank=
X-Google-Smtp-Source: APiQypIlsNOV5Ts+IvXr65G+RjFeJz8dWYTQcX7sXrFlOO+fyRvy9LWo2BPInwdwLagGF64+QL93qg==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr14197849ple.123.1587325541529;
        Sun, 19 Apr 2020 12:45:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r26sm20777722pfq.75.2020.04.19.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 898B9404EF; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
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
Subject: [PATCH v2 01/10] block: move main block debugfs initialization to its own file
Date:   Sun, 19 Apr 2020 19:45:20 +0000
Message-Id: <20200419194529.4872-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

make_request-based drivers and and request-based drivers share some
some debugfs code. By moving this into its own file it makes it easier
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
 block/Makefile      |  1 +
 block/blk-core.c    |  9 +--------
 block/blk-debugfs.c | 15 +++++++++++++++
 block/blk.h         |  7 +++++++
 4 files changed, 24 insertions(+), 8 deletions(-)
 create mode 100644 block/blk-debugfs.c

diff --git a/block/Makefile b/block/Makefile
index 206b96e9387f..1d3ab20505d8 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
 
+obj-$(CONFIG_DEBUG_FS)		+= blk-debugfs.o
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715e..5aaae7a1b338 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -48,10 +48,6 @@
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
-#ifdef CONFIG_DEBUG_FS
-struct dentry *blk_debugfs_root;
-#endif
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
@@ -1796,10 +1792,7 @@ int __init blk_dev_init(void)
 
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
index 0a94ec68af32..86a66b614f08 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -487,5 +487,12 @@ struct request_queue *__blk_alloc_queue(int node_id);
 int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		bool *same_page);
+#ifdef CONFIG_DEBUG_FS
+void blk_debugfs_register(void);
+#else
+static inline void blk_debugfs_register(void)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
 
 #endif /* BLK_INTERNAL_H */
-- 
2.25.1

