Return-Path: <linux-fsdevel+bounces-38928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9160AA0A173
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 08:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297A116A711
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2BA188596;
	Sat, 11 Jan 2025 07:12:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A515DBB3;
	Sat, 11 Jan 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579551; cv=none; b=iAr/aF6vWMH0Wp6FKtEku3Q98/XnAZP+21/K+CWiunfTVB2iwLNk87aV7BRuBZojCO0QTbaqXfWhkBPxVxSf8j5RoAtTuBpVXBnbc2U1zSApwwntUCZaTaupHdUC0YRUQKOCbF4+IhxWm+J8P051BWnFCMR7YYyxW9ZnihtuZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579551; c=relaxed/simple;
	bh=HXovYQjYYkHFWEMgBUrmy0EjJmQ2n503EepH3Dl/9sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6WCQLOCV5hs8+4E2XUvlA1/xDXjyiMegfQ4UNOwhOiBIYJKqm5075pZMYJ9JncTgT6zUheKS725FIYZ4UPKudLK0mX0DCFuOETl/qF3er1XcYNPUOBaw8ZPT30uDSxiGnBondiMNsWCTRmZfLL0VCeTH+hArRiL4zbGKjJvuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YVV6R4bKjzrS4r;
	Sat, 11 Jan 2025 15:10:39 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D196180064;
	Sat, 11 Jan 2025 15:12:20 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Jan
 2025 15:12:17 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<joel.granados@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v5 -next 01/16] mm: vmstat: move sysctls to mm/vmstat.c
Date: Sat, 11 Jan 2025 15:07:36 +0800
Message-ID: <20250111070751.2588654-2-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111070751.2588654-1-yukaixiong@huawei.com>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100016.china.huawei.com (7.202.181.102)

This moves all vmstat related sysctls to its own file, removes useless
extern variable declarations, and do some related clean-ups. To avoid
compiler warnings when CONFIG_PROC_FS is not defined, add the macro
definition CONFIG_PROC_FS ahead CONFIG_NUMA in vmstat.c.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v4:
 - const qualify struct ctl_table vmstat_table
v3:
 - change the title
 - change sysctl_stat_interval to static type
---
---
 include/linux/vmstat.h | 11 -----------
 kernel/sysctl.c        | 28 ---------------------------
 mm/vmstat.c            | 44 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 9f3a04345b86..4751e3ecc467 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -10,15 +10,8 @@
 #include <linux/static_key.h>
 #include <linux/mmdebug.h>
 
-extern int sysctl_stat_interval;
-
 #ifdef CONFIG_NUMA
-#define ENABLE_NUMA_STAT   1
-#define DISABLE_NUMA_STAT   0
-extern int sysctl_vm_numa_stat;
 DECLARE_STATIC_KEY_TRUE(vm_numa_stat_key);
-int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
 struct reclaim_stat {
@@ -304,10 +297,6 @@ void quiet_vmstat(void);
 void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
-struct ctl_table;
-int vmstat_refresh(const struct ctl_table *, int write, void *buffer, size_t *lenp,
-		loff_t *ppos);
-
 void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *);
 
 int calculate_pressure_threshold(struct zone *zone);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7ae7a4136855..f1ab251fc2d0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -49,7 +49,6 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
-#include <linux/vmstat.h>
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
 #include <linux/reboot.h>
@@ -2071,17 +2070,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO_HUNDRED,
 	},
-#ifdef CONFIG_NUMA
-	{
-		.procname	= "numa_stat",
-		.data		= &sysctl_vm_numa_stat,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 	{
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
@@ -2147,22 +2135,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-#ifdef CONFIG_SMP
-	{
-		.procname	= "stat_interval",
-		.data		= &sysctl_stat_interval,
-		.maxlen		= sizeof(sysctl_stat_interval),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "stat_refresh",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0600,
-		.proc_handler	= vmstat_refresh,
-	},
-#endif
 #ifdef CONFIG_MMU
 	{
 		.procname	= "mmap_min_addr",
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..39704b5b17e0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -31,8 +31,10 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_PROC_FS
 #ifdef CONFIG_NUMA
-int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
+#define ENABLE_NUMA_STAT 1
+static int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
 
 /* zero numa counters within a zone */
 static void zero_zone_numa_counters(struct zone *zone)
@@ -74,7 +76,7 @@ static void invalid_numa_statistics(void)
 
 static DEFINE_MUTEX(vm_numa_stat_lock);
 
-int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
+static int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret, oldval;
@@ -102,6 +104,7 @@ int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 #endif
+#endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
 DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
@@ -1938,7 +1941,7 @@ static const struct seq_operations vmstat_op = {
 
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
-int sysctl_stat_interval __read_mostly = HZ;
+static int sysctl_stat_interval __read_mostly = HZ;
 static int vmstat_late_init_done;
 
 #ifdef CONFIG_PROC_FS
@@ -1947,7 +1950,7 @@ static void refresh_vm_stats(struct work_struct *work)
 	refresh_cpu_vm_stats(true);
 }
 
-int vmstat_refresh(const struct ctl_table *table, int write,
+static int vmstat_refresh(const struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
@@ -2196,6 +2199,38 @@ static int __init vmstat_late_init(void)
 late_initcall(vmstat_late_init);
 #endif
 
+#ifdef CONFIG_PROC_FS
+static const struct ctl_table vmstat_table[] = {
+#ifdef CONFIG_SMP
+	{
+		.procname	= "stat_interval",
+		.data		= &sysctl_stat_interval,
+		.maxlen		= sizeof(sysctl_stat_interval),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_jiffies,
+	},
+	{
+		.procname	= "stat_refresh",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0600,
+		.proc_handler	= vmstat_refresh,
+	},
+#endif
+#ifdef CONFIG_NUMA
+	{
+		.procname	= "numa_stat",
+		.data		= &sysctl_vm_numa_stat,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_vm_numa_stat_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
+};
+#endif
+
 struct workqueue_struct *mm_percpu_wq;
 
 void __init init_mm_internals(void)
@@ -2227,6 +2262,7 @@ void __init init_mm_internals(void)
 	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
 	proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
 	proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
+	register_sysctl_init("vm", vmstat_table);
 #endif
 }
 
-- 
2.34.1


