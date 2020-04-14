Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5D1A7267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405271AbgDNET0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:19:26 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53327 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405226AbgDNETH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:19:07 -0400
Received: by mail-pj1-f67.google.com with SMTP id cl8so3568836pjb.3;
        Mon, 13 Apr 2020 21:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOqFz/6SfoYIxdIaKsZbQKuFZCTl+d+PmNjeRcAeYWw=;
        b=FYGcpJmOjbezTz22wbul39ZMILTTgMIifA26EiIiCom8QQ29f9m6alYVnFvqjfJAoY
         INLniVquV5SH0p1m9/a1AH7UnUPnswOH1KkV8g5je0f0XhWr7hauReCWdqc60hH3LKrO
         wVk5y7yZR9waZ/WBRI4NvNAjkFF8fvARHx6dBY4wPhgMauTDVohc/HPpqaCrvmpEgu8l
         LUSC1NgFTytqUPhdKht89a1GH4ZotbalWcI6By/7MoLoCbYKgslQga0S87tLRdWny3bT
         LmSRN9XOkgNwkuM5zRqPOeJ/gskm4hcIxrTBf35vfPzb7kGouwsfR0t5FlP3IMcZsIXR
         ZcmA==
X-Gm-Message-State: AGi0PubkN3PSd8iKUdhJ1v70Y1vj2sTiruOk9ZEXA/5l3Mo/GsjyWF8w
        DNzPo9d4AdR6zDxBAnnisgk=
X-Google-Smtp-Source: APiQypIp2fwAykCaBVO3uyfeOBBSTJASxml0yVcrV1SDyvghPVLTQxgkubQP+6PzT2wAG+Ag3J1d9w==
X-Received: by 2002:a17:902:c814:: with SMTP id u20mr1357265plx.85.1586837946598;
        Mon, 13 Apr 2020 21:19:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x7sm7854126pjg.26.2020.04.13.21.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:19:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D6D8B40605; Tue, 14 Apr 2020 04:19:03 +0000 (UTC)
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
Subject: [PATCH 1/5] block: move main block debugfs initialization to its own file
Date:   Tue, 14 Apr 2020 04:18:58 +0000
Message-Id: <20200414041902.16769-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200414041902.16769-1-mcgrof@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
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

