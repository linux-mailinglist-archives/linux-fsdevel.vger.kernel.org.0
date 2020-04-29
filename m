Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7081BD66D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD2Hqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:46:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36234 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2Hqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:46:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id a31so432801pje.1;
        Wed, 29 Apr 2020 00:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8dSq6ES2jPXw5+HnmMcnSKKoOvoW5PINzIJYL/yYY4=;
        b=TDJ7aFZPCHG0AODkSGqu2hB8yqjXpvA54mpugq0T7jKPXX7bIvgVzeURLYwaB+52Y/
         m1oCsGQq8E5op0c/dHM+0ryMxIIy6FaOwMB3NUSR2tzGoT5eemoZZPWUumiqNg4LlNPk
         uB/dojXXbeFju+02WcJapdfYNovU2eazWHBv0rFS21H2qeY597aPaa3fdIqW+4mfxPE4
         6beiM6xIEn1ENStA6Y3igmF8LJ2TzBtlftQwytAdJmzGHjl1Iw5e8asx32johksb92nG
         Yfa1HKvzT7yGKuYtqfV/G/EOO5VZZULy6K6yAgrgrxGW82lcgQkGtYA0QVNJm9jAgkzJ
         9xrQ==
X-Gm-Message-State: AGi0PubX5lMODNnhBEUpJckVnt26Y+NRUwIxFOn10dIDKkevqUVtcu3I
        JftO3yjSz3x3nQnEU9Yqbdg=
X-Google-Smtp-Source: APiQypKnDao+pl7grXlaGqzpC6Us6sQ/cc5Bx3+Kf4IjSfI/lLruTTPQF6zXoAlX0W6PyZPP+Le1Kg==
X-Received: by 2002:a17:902:b711:: with SMTP id d17mr32928427pls.333.1588146393824;
        Wed, 29 Apr 2020 00:46:33 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c84sm427219pfb.153.2020.04.29.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:46:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D74F941381; Wed, 29 Apr 2020 07:46:29 +0000 (UTC)
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
Subject: [PATCH v3 2/6] block: move main block debugfs initialization to its own file
Date:   Wed, 29 Apr 2020 07:46:23 +0000
Message-Id: <20200429074627.5955-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074627.5955-1-mcgrof@kernel.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
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
index 8a27c772982e..4b26f686e249 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,10 +49,6 @@
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
-#ifdef CONFIG_DEBUG_FS
-struct dentry *blk_debugfs_root;
-#endif
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
@@ -1828,10 +1824,7 @@ int __init blk_dev_init(void)
 
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
index 73bd3b1c6938..ec16e8a6049e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -456,5 +456,12 @@ struct request_queue *__blk_alloc_queue(int node_id);
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

