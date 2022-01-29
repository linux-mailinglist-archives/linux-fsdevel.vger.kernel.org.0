Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4F4A2AFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 02:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352038AbiA2BaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 20:30:25 -0500
Received: from smtpbg703.qq.com ([203.205.195.89]:39840 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352040AbiA2BaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:30:25 -0500
X-QQ-mid: bizesmtp39t1643419806tfarf4de
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jan 2022 09:29:59 +0800 (CST)
X-QQ-SSF: 0140000000200090G000B00A0000000
X-QQ-FEAT: rGalpAd1/BlEA/zBvRekuz/XIvnVtE4Ns1uHaCpFydDbHIh8ksboKD0Vt9DdY
        HUwcB+ZPC2CE5XXHUd7nlRP3wnNE72WbKw22re3f91Y/xpr65kjwa04Poy0gc0RiO0A9noY
        wBtyrYaNwUHBh+NZUNkqo/gN3WvciCChQk9Dz8xV4ovd4MN9biLNYDy6KeI8Vp7GSUggc9f
        v3HdJPgdPWRsvTJBVEJ8Dtz0PV2rLTI4ysCrgkBBWZz5RvGAcuc0H/YOkubJoO0QSCg4Ttl
        Khuuoy2Ltuc10415KcSwYErdBJHHZwnJpMBiMbjngfurV0hfbN9qYAndPvR2dxr9QKTcVLG
        msGYM//K6lELBlmyr8=
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yzaikin@google.com, mcgrof@kernel.org,
        akpm@linux-foundation.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH v2] mm: move page-writeback sysctls to is own file
Date:   Sat, 29 Jan 2022 09:29:55 +0800
Message-Id: <20220129012955.26594-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

So move the page-writeback sysctls to its own file.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fec248ab1fec..dc2b94e6a94f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -345,28 +345,13 @@ void wb_domain_exit(struct wb_domain *dom);
 extern struct wb_domain global_wb_domain;

 /* These are exported to sysctl. */
-extern int dirty_background_ratio;
-extern unsigned long dirty_background_bytes;
-extern int vm_dirty_ratio;
-extern unsigned long vm_dirty_bytes;
 extern unsigned int dirty_writeback_interval;
 extern unsigned int dirty_expire_interval;
 extern unsigned int dirtytime_expire_interval;
-extern int vm_highmem_is_dirtyable;
 extern int laptop_mode;

-int dirty_background_ratio_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_background_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_ratio_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
 int dirtytime_interval_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);

 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..34371bcb8ffa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -100,8 +100,6 @@
 static const int six_hundred_forty_kb = 640 * 1024;
 #endif

-/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
-static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;

 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
@@ -2401,55 +2399,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
-	{
-		.procname	= "dirty_background_ratio",
-		.data		= &dirty_background_ratio,
-		.maxlen		= sizeof(dirty_background_ratio),
-		.mode		= 0644,
-		.proc_handler	= dirty_background_ratio_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "dirty_background_bytes",
-		.data		= &dirty_background_bytes,
-		.maxlen		= sizeof(dirty_background_bytes),
-		.mode		= 0644,
-		.proc_handler	= dirty_background_bytes_handler,
-		.extra1		= SYSCTL_LONG_ONE,
-	},
-	{
-		.procname	= "dirty_ratio",
-		.data		= &vm_dirty_ratio,
-		.maxlen		= sizeof(vm_dirty_ratio),
-		.mode		= 0644,
-		.proc_handler	= dirty_ratio_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "dirty_bytes",
-		.data		= &vm_dirty_bytes,
-		.maxlen		= sizeof(vm_dirty_bytes),
-		.mode		= 0644,
-		.proc_handler	= dirty_bytes_handler,
-		.extra1		= (void *)&dirty_bytes_min,
-	},
-	{
-		.procname	= "dirty_writeback_centisecs",
-		.data		= &dirty_writeback_interval,
-		.maxlen		= sizeof(dirty_writeback_interval),
-		.mode		= 0644,
-		.proc_handler	= dirty_writeback_centisecs_handler,
-	},
-	{
-		.procname	= "dirty_expire_centisecs",
-		.data		= &dirty_expire_interval,
-		.maxlen		= sizeof(dirty_expire_interval),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
@@ -2621,13 +2570,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-	{
-		.procname	= "laptop_mode",
-		.data		= &laptop_mode,
-		.maxlen		= sizeof(laptop_mode),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
 	{
 		.procname	= "vfs_cache_pressure",
 		.data		= &sysctl_vfs_cache_pressure,
@@ -2725,17 +2667,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-#ifdef CONFIG_HIGHMEM
-	{
-		.procname	= "highmem_is_dirtyable",
-		.data		= &vm_highmem_is_dirtyable,
-		.maxlen		= sizeof(vm_highmem_is_dirtyable),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_MEMORY_FAILURE
 	{
 		.procname	= "memory_failure_early_kill",
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 91d163f8d36b..f630681df9d2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -70,30 +70,33 @@ static long ratelimit_pages = 32;
 /*
  * Start background writeback (via writeback threads) at this percentage
  */
-int dirty_background_ratio = 10;
+static int dirty_background_ratio = 10;

 /*
  * dirty_background_bytes starts at 0 (disabled) so that it is a function of
  * dirty_background_ratio * the amount of dirtyable memory
  */
-unsigned long dirty_background_bytes;
+static unsigned long dirty_background_bytes;

 /*
  * free highmem will not be subtracted from the total free memory
  * for calculating free ratios if vm_highmem_is_dirtyable is true
  */
-int vm_highmem_is_dirtyable;
+static int vm_highmem_is_dirtyable;

 /*
  * The generator of dirty data starts writeback at this percentage
  */
-int vm_dirty_ratio = 20;
+static int vm_dirty_ratio = 20;
+
+/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
+static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;

 /*
  * vm_dirty_bytes starts at 0 (disabled) so that it is a function of
  * vm_dirty_ratio * the amount of dirtyable memory
  */
-unsigned long vm_dirty_bytes;
+static unsigned long vm_dirty_bytes;

 /*
  * The interval between `kupdate'-style writebacks
@@ -503,7 +506,7 @@ bool node_dirty_ok(struct pglist_data *pgdat)
 	return nr_pages <= limit;
 }

-int dirty_background_ratio_handler(struct ctl_table *table, int write,
+static int dirty_background_ratio_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -514,7 +517,7 @@ int dirty_background_ratio_handler(struct ctl_table *table, int write,
 	return ret;
 }

-int dirty_background_bytes_handler(struct ctl_table *table, int write,
+static int dirty_background_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -525,7 +528,7 @@ int dirty_background_bytes_handler(struct ctl_table *table, int write,
 	return ret;
 }

-int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
+static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int old_ratio = vm_dirty_ratio;
@@ -539,7 +542,7 @@ int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }

-int dirty_bytes_handler(struct ctl_table *table, int write,
+static int dirty_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned long old_bytes = vm_dirty_bytes;
@@ -1996,7 +1999,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 /*
  * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
  */
-int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
+static int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	unsigned int old_interval = dirty_writeback_interval;
@@ -2081,6 +2084,79 @@ static int page_writeback_cpu_online(unsigned int cpu)
 	return 0;
 }

+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_page_writeback_sysctls[] = {
+    {
+        .procname   = "dirty_background_ratio",
+        .data       = &dirty_background_ratio,
+        .maxlen     = sizeof(dirty_background_ratio),
+        .mode       = 0644,
+        .proc_handler   = dirty_background_ratio_handler,
+        .extra1     = SYSCTL_ZERO,
+        .extra2     = SYSCTL_ONE_HUNDRED,
+    },
+    {
+        .procname   = "dirty_background_bytes",
+        .data       = &dirty_background_bytes,
+        .maxlen     = sizeof(dirty_background_bytes),
+        .mode       = 0644,
+        .proc_handler   = dirty_background_bytes_handler,
+        .extra1     = SYSCTL_LONG_ONE,
+    },
+    {
+        .procname   = "dirty_ratio",
+        .data       = &vm_dirty_ratio,
+        .maxlen     = sizeof(vm_dirty_ratio),
+        .mode       = 0644,
+        .proc_handler   = dirty_ratio_handler,
+        .extra1     = SYSCTL_ZERO,
+        .extra2     = SYSCTL_ONE_HUNDRED,
+    },
+    {
+        .procname   = "dirty_bytes",
+        .data       = &vm_dirty_bytes,
+        .maxlen     = sizeof(vm_dirty_bytes),
+        .mode       = 0644,
+        .proc_handler   = dirty_bytes_handler,
+        .extra1     = (void *)&dirty_bytes_min,
+    },
+    {
+        .procname   = "dirty_writeback_centisecs",
+        .data       = &dirty_writeback_interval,
+        .maxlen     = sizeof(dirty_writeback_interval),
+        .mode       = 0644,
+        .proc_handler   = dirty_writeback_centisecs_handler,
+    },
+    {
+        .procname   = "dirty_expire_centisecs",
+        .data       = &dirty_expire_interval,
+        .maxlen     = sizeof(dirty_expire_interval),
+        .mode       = 0644,
+        .proc_handler   = proc_dointvec_minmax,
+        .extra1     = SYSCTL_ZERO,
+    },
+#ifdef CONFIG_HIGHMEM
+	{
+		.procname	= "highmem_is_dirtyable",
+		.data		= &vm_highmem_is_dirtyable,
+		.maxlen		= sizeof(vm_highmem_is_dirtyable),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
+	{
+		.procname	= "laptop_mode",
+		.data		= &laptop_mode,
+		.maxlen		= sizeof(laptop_mode),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_jiffies,
+	},
+	{}
+};
+#endif
+
 /*
  * Called early on to tune the page writeback dirty limits.
  *
@@ -2105,6 +2181,9 @@ void __init page_writeback_init(void)
 			  page_writeback_cpu_online, NULL);
 	cpuhp_setup_state(CPUHP_MM_WRITEBACK_DEAD, "mm/writeback:dead", NULL,
 			  page_writeback_cpu_online);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", vm_page_writeback_sysctls);
+#endif
 }

 /**
--
2.20.1



