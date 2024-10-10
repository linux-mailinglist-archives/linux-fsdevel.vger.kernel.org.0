Return-Path: <linux-fsdevel+bounces-31576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A42998962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F37DB27E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C361CC141;
	Thu, 10 Oct 2024 14:11:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379B1CB322;
	Thu, 10 Oct 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569500; cv=none; b=lv4VdsA9Hqjr0Q41y40VTNRzZUjZkYzdOfQ3kQiA6x5LwTbjJppuwfIKPvUnAXT2kLSICOsI0YP8ARncDmJrzLcmhmBoiIhrvl583m/JqOM8Xpxc1n4yuZNO9e4yoj3Sbl0TF+/t9VU4t1kD1mk39oZxW45hJ3JcJ0B2yPknYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569500; c=relaxed/simple;
	bh=UJ+x75BBdiY+1MErZMJVo7hyFVYKnh1GuT3vNeeZeyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQtxqsQII3f7ZSPjxtTnzA66Y2Cz/GQFrI8dUfqWtnsdirJDV/nWjzKG0K2cgl8ttap+Cl3rtylR0WEtmsz2rFBoKdjIOBfzyYViPrHgHqsva7rIwBFrtog3b6tmursveSkqDGaiA8IGc/ZDvkVF3we+grWLlEuSL5drnqv5hFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XPWqk51SGz1SCPQ;
	Thu, 10 Oct 2024 22:10:26 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id F2A901A0188;
	Thu, 10 Oct 2024 22:11:33 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 22:11:30 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>
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
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH v3 -next 01/15] mm: vmstat: move sysctls to mm/vmstat.c
Date: Thu, 10 Oct 2024 23:22:01 +0800
Message-ID: <20241010152215.3025842-2-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010152215.3025842-1-yukaixiong@huawei.com>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
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
v3:
 - change the title
 - change sysctl_stat_interval to static type
---
 include/linux/vmstat.h | 11 -----------
 kernel/sysctl.c        | 28 ---------------------------
 mm/vmstat.c            | 44 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index d2761bf8ff32..b2ccb6845595 100644
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
index 79e6cb1d5c48..726b866af57b 100644
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
@@ -2081,17 +2080,6 @@ static struct ctl_table vm_table[] = {
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
@@ -2157,22 +2145,6 @@ static struct ctl_table vm_table[] = {
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
index bb081ae4d0ae..25cb31545bc0 100644
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
@@ -1928,7 +1931,7 @@ static const struct seq_operations vmstat_op = {
 
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
-int sysctl_stat_interval __read_mostly = HZ;
+static int sysctl_stat_interval __read_mostly = HZ;
 static int vmstat_late_init_done;
 
 #ifdef CONFIG_PROC_FS
@@ -1937,7 +1940,7 @@ static void refresh_vm_stats(struct work_struct *work)
 	refresh_cpu_vm_stats(true);
 }
 
-int vmstat_refresh(const struct ctl_table *table, int write,
+static int vmstat_refresh(const struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
@@ -2175,6 +2178,38 @@ static int __init vmstat_late_init(void)
 late_initcall(vmstat_late_init);
 #endif
 
+#ifdef CONFIG_PROC_FS
+static struct ctl_table vmstat_table[] = {
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
@@ -2206,6 +2241,7 @@ void __init init_mm_internals(void)
 	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
 	proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
 	proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
+	register_sysctl_init("vm", vmstat_table);
 #endif
 }
 
-- 
2.34.1


