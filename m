Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA975126E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjGLVNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGLVMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:51 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [IPv6:2001:41d0:203:375::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ACF2D73
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lo2RRNBnyaoiZ+EfE4rFmefG4+0kR7n+T09cgyOTBQ=;
        b=l8EM9EHxBN/y1vZKIFN+DNG488i6JRiZy3MV2koOiyLQz8GFBav8S3PigvkKWFSxiY3hhN
        M5NnHuRsrs5pn8ULLNO0xh+CVGu2z/YVGpTj/SSdScRfFKJQxPABD2g39OO4IXPCI7EnPP
        y3naJ0heMwozUr4gKr9BSDBK9wJwISA=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 12/20] bcache: move closures to lib/
Date:   Wed, 12 Jul 2023 17:11:07 -0400
Message-Id: <20230712211115.2174650-13-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

Prep work for bcachefs - being a fork of bcache it also uses closures

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Acked-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/Kconfig                     | 10 +-----
 drivers/md/bcache/Makefile                    |  4 +--
 drivers/md/bcache/bcache.h                    |  2 +-
 drivers/md/bcache/super.c                     |  1 -
 drivers/md/bcache/util.h                      |  3 +-
 .../md/bcache => include/linux}/closure.h     | 17 +++++----
 lib/Kconfig                                   |  3 ++
 lib/Kconfig.debug                             |  9 +++++
 lib/Makefile                                  |  2 ++
 {drivers/md/bcache => lib}/closure.c          | 35 +++++++++----------
 10 files changed, 43 insertions(+), 43 deletions(-)
 rename {drivers/md/bcache => include/linux}/closure.h (97%)
 rename {drivers/md/bcache => lib}/closure.c (88%)

diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index 529c9d04e9..b2d10063d3 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -4,6 +4,7 @@ config BCACHE
 	tristate "Block device as cache"
 	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	select CRC64
+	select CLOSURES
 	help
 	Allows a block device to be used as cache for other devices; uses
 	a btree for indexing and the layout is optimized for SSDs.
@@ -19,15 +20,6 @@ config BCACHE_DEBUG
 	Enables extra debugging tools, allows expensive runtime checks to be
 	turned on.
 
-config BCACHE_CLOSURES_DEBUG
-	bool "Debug closures"
-	depends on BCACHE
-	select DEBUG_FS
-	help
-	Keeps all active closures in a linked list and provides a debugfs
-	interface to list them, which makes it possible to see asynchronous
-	operations that get stuck.
-
 config BCACHE_ASYNC_REGISTRATION
 	bool "Asynchronous device registration"
 	depends on BCACHE
diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
index 5b87e59676..054e8a33a7 100644
--- a/drivers/md/bcache/Makefile
+++ b/drivers/md/bcache/Makefile
@@ -2,6 +2,6 @@
 
 obj-$(CONFIG_BCACHE)	+= bcache.o
 
-bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
-	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
+bcache-y		:= alloc.o bset.o btree.o debug.o extents.o io.o\
+	journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
 	util.o writeback.o features.o
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index aebb7ef10e..c8b4914ad8 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -179,6 +179,7 @@
 #define pr_fmt(fmt) "bcache: %s() " fmt, __func__
 
 #include <linux/bio.h>
+#include <linux/closure.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -192,7 +193,6 @@
 #include "bcache_ondisk.h"
 #include "bset.h"
 #include "util.h"
-#include "closure.h"
 
 struct bucket {
 	atomic_t	pin;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 7e9d19fd21..35c701d542 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2911,7 +2911,6 @@ static int __init bcache_init(void)
 		goto err;
 
 	bch_debug_init();
-	closure_debug_init();
 
 	bcache_is_reboot = false;
 
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 6f3cb7c921..f61ab1bada 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -4,6 +4,7 @@
 #define _BCACHE_UTIL_H
 
 #include <linux/blkdev.h>
+#include <linux/closure.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched/clock.h>
@@ -13,8 +14,6 @@
 #include <linux/workqueue.h>
 #include <linux/crc64.h>
 
-#include "closure.h"
-
 struct closure;
 
 #ifdef CONFIG_BCACHE_DEBUG
diff --git a/drivers/md/bcache/closure.h b/include/linux/closure.h
similarity index 97%
rename from drivers/md/bcache/closure.h
rename to include/linux/closure.h
index c88cdc4ae4..0ec9e7bc8d 100644
--- a/drivers/md/bcache/closure.h
+++ b/include/linux/closure.h
@@ -155,7 +155,7 @@ struct closure {
 
 	atomic_t		remaining;
 
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 #define CLOSURE_MAGIC_DEAD	0xc054dead
 #define CLOSURE_MAGIC_ALIVE	0xc054a11e
 
@@ -184,15 +184,13 @@ static inline void closure_sync(struct closure *cl)
 		__closure_sync(cl);
 }
 
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 
-void closure_debug_init(void);
 void closure_debug_create(struct closure *cl);
 void closure_debug_destroy(struct closure *cl);
 
 #else
 
-static inline void closure_debug_init(void) {}
 static inline void closure_debug_create(struct closure *cl) {}
 static inline void closure_debug_destroy(struct closure *cl) {}
 
@@ -200,21 +198,21 @@ static inline void closure_debug_destroy(struct closure *cl) {}
 
 static inline void closure_set_ip(struct closure *cl)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	cl->ip = _THIS_IP_;
 #endif
 }
 
 static inline void closure_set_ret_ip(struct closure *cl)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	cl->ip = _RET_IP_;
 #endif
 }
 
 static inline void closure_set_waiting(struct closure *cl, unsigned long f)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	cl->waiting_on = f;
 #endif
 }
@@ -243,6 +241,7 @@ static inline void closure_queue(struct closure *cl)
 	 */
 	BUILD_BUG_ON(offsetof(struct closure, fn)
 		     != offsetof(struct work_struct, func));
+
 	if (wq) {
 		INIT_WORK(&cl->work, cl->work.func);
 		BUG_ON(!queue_work(wq, &cl->work));
@@ -255,7 +254,7 @@ static inline void closure_queue(struct closure *cl)
  */
 static inline void closure_get(struct closure *cl)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	BUG_ON((atomic_inc_return(&cl->remaining) &
 		CLOSURE_REMAINING_MASK) <= 1);
 #else
@@ -271,7 +270,7 @@ static inline void closure_get(struct closure *cl)
  */
 static inline void closure_init(struct closure *cl, struct closure *parent)
 {
-	memset(cl, 0, sizeof(struct closure));
+	cl->fn = NULL;
 	cl->parent = parent;
 	if (parent)
 		closure_get(parent);
diff --git a/lib/Kconfig b/lib/Kconfig
index 5c2da561c5..f78bc8b425 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -505,6 +505,9 @@ config ASSOCIATIVE_ARRAY
 
 	  for more information.
 
+config CLOSURES
+	bool
+
 config HAS_IOMEM
 	bool
 	depends on !NO_IOMEM
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc68..3ee25d5dae 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1637,6 +1637,15 @@ config DEBUG_NOTIFIERS
 	  This is a relatively cheap check but if you care about maximum
 	  performance, say N.
 
+config DEBUG_CLOSURES
+	bool "Debug closures (bcache async widgits)"
+	depends on CLOSURES
+	select DEBUG_FS
+	help
+	Keeps all active closures in a linked list and provides a debugfs
+	interface to list them, which makes it possible to see asynchronous
+	operations that get stuck.
+
 config BUG_ON_DATA_CORRUPTION
 	bool "Trigger a BUG when data corruption is detected"
 	select DEBUG_LIST
diff --git a/lib/Makefile b/lib/Makefile
index 876fcdeae3..7798910135 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -248,6 +248,8 @@ obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
 obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
 
+obj-$(CONFIG_CLOSURES) += closure.o
+
 obj-$(CONFIG_DQL) += dynamic_queue_limits.o
 
 obj-$(CONFIG_GLOB) += glob.o
diff --git a/drivers/md/bcache/closure.c b/lib/closure.c
similarity index 88%
rename from drivers/md/bcache/closure.c
rename to lib/closure.c
index d8d9394a6b..b38ded00b9 100644
--- a/drivers/md/bcache/closure.c
+++ b/lib/closure.c
@@ -6,13 +6,12 @@
  * Copyright 2012 Google, Inc.
  */
 
+#include <linux/closure.h>
 #include <linux/debugfs.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/seq_file.h>
 #include <linux/sched/debug.h>
 
-#include "closure.h"
-
 static inline void closure_put_after_sub(struct closure *cl, int flags)
 {
 	int r = flags & CLOSURE_REMAINING_MASK;
@@ -45,6 +44,7 @@ void closure_sub(struct closure *cl, int v)
 {
 	closure_put_after_sub(cl, atomic_sub_return(v, &cl->remaining));
 }
+EXPORT_SYMBOL(closure_sub);
 
 /*
  * closure_put - decrement a closure's refcount
@@ -53,6 +53,7 @@ void closure_put(struct closure *cl)
 {
 	closure_put_after_sub(cl, atomic_dec_return(&cl->remaining));
 }
+EXPORT_SYMBOL(closure_put);
 
 /*
  * closure_wake_up - wake up all closures on a wait list, without memory barrier
@@ -74,6 +75,7 @@ void __closure_wake_up(struct closure_waitlist *wait_list)
 		closure_sub(cl, CLOSURE_WAITING + 1);
 	}
 }
+EXPORT_SYMBOL(__closure_wake_up);
 
 /**
  * closure_wait - add a closure to a waitlist
@@ -93,6 +95,7 @@ bool closure_wait(struct closure_waitlist *waitlist, struct closure *cl)
 
 	return true;
 }
+EXPORT_SYMBOL(closure_wait);
 
 struct closure_syncer {
 	struct task_struct	*task;
@@ -127,8 +130,9 @@ void __sched __closure_sync(struct closure *cl)
 
 	__set_current_state(TASK_RUNNING);
 }
+EXPORT_SYMBOL(__closure_sync);
 
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 
 static LIST_HEAD(closure_list);
 static DEFINE_SPINLOCK(closure_list_lock);
@@ -144,6 +148,7 @@ void closure_debug_create(struct closure *cl)
 	list_add(&cl->all, &closure_list);
 	spin_unlock_irqrestore(&closure_list_lock, flags);
 }
+EXPORT_SYMBOL(closure_debug_create);
 
 void closure_debug_destroy(struct closure *cl)
 {
@@ -156,8 +161,7 @@ void closure_debug_destroy(struct closure *cl)
 	list_del(&cl->all);
 	spin_unlock_irqrestore(&closure_list_lock, flags);
 }
-
-static struct dentry *closure_debug;
+EXPORT_SYMBOL(closure_debug_destroy);
 
 static int debug_show(struct seq_file *f, void *data)
 {
@@ -181,7 +185,7 @@ static int debug_show(struct seq_file *f, void *data)
 			seq_printf(f, " W %pS\n",
 				   (void *) cl->waiting_on);
 
-		seq_printf(f, "\n");
+		seq_puts(f, "\n");
 	}
 
 	spin_unlock_irq(&closure_list_lock);
@@ -190,18 +194,11 @@ static int debug_show(struct seq_file *f, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(debug);
 
-void  __init closure_debug_init(void)
+static int __init closure_debug_init(void)
 {
-	if (!IS_ERR_OR_NULL(bcache_debug))
-		/*
-		 * it is unnecessary to check return value of
-		 * debugfs_create_file(), we should not care
-		 * about this.
-		 */
-		closure_debug = debugfs_create_file(
-			"closures", 0400, bcache_debug, NULL, &debug_fops);
+	debugfs_create_file("closures", 0400, NULL, NULL, &debug_fops);
+	return 0;
 }
-#endif
+late_initcall(closure_debug_init)
 
-MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
-MODULE_LICENSE("GPL");
+#endif
-- 
2.40.1

