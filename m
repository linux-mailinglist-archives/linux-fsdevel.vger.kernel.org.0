Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03831A3C16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgDIVph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:45:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34575 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgDIVpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:45:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so4343299plm.1;
        Thu, 09 Apr 2020 14:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLph60D1SnFnHEB2NFdtxbtWAnKHUye2dDiwcTEr5pU=;
        b=DfKpVEPH9vwNybuJ4FpljBpEPkdjVoIRhpXvLK/OPdIz9hgy/eZB2sKEuB5qCQ95z4
         YjPjWbyniHqYq4yd8Uamt/UGaBtXfm42vKrnFQeXghgnrpBAMN2c6Mf62a/ZjoKp39Vf
         1+LR8DgSDE5Qg8brgvPrAwPl1g/x71IZueSyfka7YME+dbPckcx5qwBBcDUPipMvzAM/
         t2ODcNRCtq6D4lIes2vvuj+7gUtZEHeSDnxEJnOY5Y3x3HUh5ncQfYKSDoNdrG34unLI
         cSl0kPl/psNalcCtvuZKBwFyTIQ+hcP+rVhDgVSofZFD5hFij5QLJ2HrXBN4B7sQ+kAx
         tE/g==
X-Gm-Message-State: AGi0PuZugaEGBu3izLVr0yKzDUgvO28sAb9DqQaOhKh8XneImnXFjiZc
        ZkcHmf8IL1ZH1lB7vBjVdiw=
X-Google-Smtp-Source: APiQypKmaslyoWulwk72NDpUWDybfCIK5dcSrW/r3JU1c/rJvucJcwAs0tETDPvCZSZhhul2HvDzwg==
X-Received: by 2002:a17:90a:82:: with SMTP id a2mr1754386pja.47.1586468734191;
        Thu, 09 Apr 2020 14:45:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id nk12sm116640pjb.41.2020.04.09.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:45:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 29E48404EF; Thu,  9 Apr 2020 21:45:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC v2 1/5] block: move main block debugfs initialization to its own file
Date:   Thu,  9 Apr 2020 21:45:26 +0000
Message-Id: <20200409214530.2413-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200409214530.2413-1-mcgrof@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Single and multiqeueue block devices share some debugfs code. By
moving this into its own file it makes it easier to expand and audit
this shared code.

This patch contains no functional changes.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
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
index 000000000000..634dea4b1507
--- /dev/null
+++ b/block/blk-debugfs.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Shared debugfs mq / non-mq functionality
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

