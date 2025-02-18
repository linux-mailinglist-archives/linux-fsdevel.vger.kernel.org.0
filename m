Return-Path: <linux-fsdevel+bounces-41978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8AA397D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E7B1894BB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FA23BF91;
	Tue, 18 Feb 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq4wG/wX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93376233155;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=JYPOFLlLfiNUrfb3GQWfqN1iB1tA0U5RMAeViR/dDOuklld6mN03gmzn+lyqK7sHF08LE0Cf1fxp1HQ0+rAX47DSX9fqJs/2hUG43oS92OdUIUUPRHK8phfYqJTLLsq1eGOLfERWsk9dQpb+uH0YXWCLkQxcHn/2z8XCGQFkvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=ec+FA3bJhRbXcy44mL0olZwg4DCvtazy/yRT+8kvChY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ylxz5PwX4C39Z/zYoaY8xTIQU/PlL5CDitVGYXp8ngQMU1KS45Hp7fFhUaap6zZQTjVaoaBADKKJb4RPvf/R+5tdgBHW21NnFinlvGR1iZX7FarpWxkNLGtQHUuqPTOXNBOtwQqWkhl/hbtGC17ksuG/6QCUTReGvDtqYI3Xxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq4wG/wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0275C4CEF5;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872606;
	bh=ec+FA3bJhRbXcy44mL0olZwg4DCvtazy/yRT+8kvChY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mq4wG/wX0fCB0VL5nhi+lFBk/iJXk0oNlnvWSvD2yVB7MdbNX44SUp4Kqlk4apwvD
	 S9Od0pQJIlk32D0wQs+tiQnHKc37Ay1Pfr0q1Q8N+BQv28A2x+NsvTBy9PfVNAp/1y
	 TBmlFaKEBPs8sWyKz3dUs130DmI/fEmRck4esvLGjmDfRgq+TAOX3RyudbXWKEMhGc
	 ZsclT/zcw6BcBpr6PR6OdfUcNUoPcQDq/ay7X/KoCPsKjLqeQgBOQVz43IU3NE2roV
	 1Yg0htV8iUny+PxDDIKIlSUwB9DhGCB/8f+TghMK/RkJJmov6/p6QYkzRwEX+YxzKY
	 OU5bEdZETAcoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFCCC021AF;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:21 +0100
Subject: [PATCH 5/8] events: Move perf_event sysctls into kernel/events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
In-Reply-To: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-64da2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10332;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ec+FA3bJhRbXcy44mL0olZwg4DCvtazy/yRT+8kvChY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVl4I3BgQWKHSlxKcgbAbttCoqSWTuqv6
 E2K55ipFuPqeokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlZAAoJELqXzVK3
 lkFPov4L/RxARj9V/wFZMdAdHvvAdNNNOGecvUbb5RcX9LmCIH1ffYRA+vpEsrxQr81qFqysDjN
 Vedrg2sG3GXwbK+AvI7bbh5a/qrrtSURVs1JSqWyVHc3olvazvg6RwBFXprR/Iwqqv7MVKDWlMu
 N7duPFpbjZqFRP/g3KxlBKUc80Sy2A42bP3H1Qmx1g4lDI2AJqf0Ozkrpw3D77p+eFUs7Mrp8hI
 5n6DCzWKHSIVWF2qmMR7T35tdEftGxSw+uFU8DPZCBv9AQxpSjz4OnUmTXoNdBMEjPZ8gJc+vyf
 77WXvsBXxN3/GQwY1dI1pa8rxTTrUgO7MhvvxN8xd/1oJKecjUtMbdehbgdCpV7xdF1NGvwWdGx
 hsS5Be3VxuZ+cHM+xUgMV7WHSZOLlU7KFyzi7guNab1Ncr8xS7+eDIshIyfJIbNTj91LNiVbOBS
 AEpcfTffEUYJOxygd7R5/GqX7eSLArk2LJVCHd8SusvHNbUJGQX6cPCrqv4WoEHKFIW27QGmmX8
 mg=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move ctl tables to two files:
* perf_event_{paranoid,mlock_kb,max_sample_rate} and
  perf_cpu_time_max_percent into kernel/events/core.c
* perf_event_max_{stack,context_per_stack} into
  kernel/events/callchain.c

Make static variables and functions that are fully contained in core.c
and callchain.cand remove them from include/linux/perf_event.h.
Additionally six_hundred_forty_kb is moved to callchain.c.

Two new sysctl tables are added ({callchain,events_core}_sysctl_table)
with their respective sysctl registration functions.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/perf_event.h |  9 -------
 kernel/events/callchain.c  | 38 ++++++++++++++++++++++-----
 kernel/events/core.c       | 57 ++++++++++++++++++++++++++++++++++++-----
 kernel/sysctl.c            | 64 ----------------------------------------------
 4 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..a92ade5d62be 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1646,19 +1646,10 @@ static inline int perf_callchain_store(struct perf_callchain_entry_ctx *ctx, u64
 }
 
 extern int sysctl_perf_event_paranoid;
-extern int sysctl_perf_event_mlock;
 extern int sysctl_perf_event_sample_rate;
-extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
-int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int perf_event_max_stack_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-
 /* Access to perf_event_open(2) syscall. */
 #define PERF_SECURITY_OPEN		0
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 8a47e52a454f..6c83ad674d01 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -22,6 +22,7 @@ struct callchain_cpus_entries {
 
 int sysctl_perf_event_max_stack __read_mostly = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack __read_mostly = PERF_MAX_CONTEXTS_PER_STACK;
+static const int six_hundred_forty_kb = 640 * 1024;
 
 static inline size_t perf_callchain_entry__sizeof(void)
 {
@@ -266,12 +267,8 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	return entry;
 }
 
-/*
- * Used for sysctl_perf_event_max_stack and
- * sysctl_perf_event_max_contexts_per_stack.
- */
-int perf_event_max_stack_handler(const struct ctl_table *table, int write,
-				 void *buffer, size_t *lenp, loff_t *ppos)
+static int perf_event_max_stack_handler(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *value = table->data;
 	int new_value = *value, ret;
@@ -292,3 +289,32 @@ int perf_event_max_stack_handler(const struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static const struct ctl_table callchain_sysctl_table[] = {
+	{
+		.procname	= "perf_event_max_stack",
+		.data		= &sysctl_perf_event_max_stack,
+		.maxlen		= sizeof(sysctl_perf_event_max_stack),
+		.mode		= 0644,
+		.proc_handler	= perf_event_max_stack_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&six_hundred_forty_kb,
+	},
+	{
+		.procname	= "perf_event_max_contexts_per_stack",
+		.data		= &sysctl_perf_event_max_contexts_per_stack,
+		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
+		.mode		= 0644,
+		.proc_handler	= perf_event_max_stack_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_THOUSAND,
+	},
+};
+
+static int __init init_callchain_sysctls(void)
+{
+	register_sysctl_init("kernel", callchain_sysctl_table);
+	return 0;
+}
+core_initcall(init_callchain_sysctls);
+
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..3c3d95312c28 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -452,8 +452,8 @@ static struct kmem_cache *perf_event_cache;
  */
 int sysctl_perf_event_paranoid __read_mostly = 2;
 
-/* Minimum for 512 kiB + 1 user control page */
-int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
+/* Minimum for 512 kiB + 1 user control page. 'free' kiB per user. */
+static int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024);
 
 /*
  * max perf event sample rate
@@ -463,6 +463,7 @@ int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free'
 #define DEFAULT_CPU_TIME_MAX_PERCENT	25
 
 int sysctl_perf_event_sample_rate __read_mostly	= DEFAULT_MAX_SAMPLE_RATE;
+static int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
 
 static int max_samples_per_tick __read_mostly	= DIV_ROUND_UP(DEFAULT_MAX_SAMPLE_RATE, HZ);
 static int perf_sample_period_ns __read_mostly	= DEFAULT_SAMPLE_PERIOD_NS;
@@ -484,7 +485,7 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
-int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
+static int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -506,9 +507,7 @@ int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
 	return 0;
 }
 
-int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
-
-int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
+static int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
@@ -528,6 +527,52 @@ int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
 	return 0;
 }
 
+static const struct ctl_table events_core_sysctl_table[] = {
+	/*
+	 * User-space relies on this file as a feature check for
+	 * perf_events being enabled. It's an ABI, do not remove!
+	 */
+	{
+		.procname	= "perf_event_paranoid",
+		.data		= &sysctl_perf_event_paranoid,
+		.maxlen		= sizeof(sysctl_perf_event_paranoid),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "perf_event_mlock_kb",
+		.data		= &sysctl_perf_event_mlock,
+		.maxlen		= sizeof(sysctl_perf_event_mlock),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "perf_event_max_sample_rate",
+		.data		= &sysctl_perf_event_sample_rate,
+		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
+		.mode		= 0644,
+		.proc_handler	= perf_event_max_sample_rate_handler,
+		.extra1		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "perf_cpu_time_max_percent",
+		.data		= &sysctl_perf_cpu_time_max_percent,
+		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
+		.mode		= 0644,
+		.proc_handler	= perf_cpu_time_max_percent_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+};
+
+static int __init init_events_core_sysctls(void)
+{
+	register_sysctl_init("kernel", events_core_sysctl_table);
+	return 0;
+}
+core_initcall(init_events_core_sysctls);
+
+
 /*
  * perf samples are done in some very critical code paths (NMIs).
  * If they take too much CPU time, the system can lock up and not
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index dc3747cc72d4..fdc92d80e841 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -51,7 +51,6 @@
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
 #include <linux/reboot.h>
-#include <linux/perf_event.h>
 #include <linux/oom.h>
 #include <linux/kmod.h>
 #include <linux/capability.h>
@@ -87,12 +86,6 @@ EXPORT_SYMBOL_GPL(sysctl_long_vals);
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and maximum */
-
-#ifdef CONFIG_PERF_EVENTS
-static const int six_hundred_forty_kb = 640 * 1024;
-#endif
-
-
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
@@ -1869,63 +1862,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_PERF_EVENTS
-	/*
-	 * User-space scripts rely on the existence of this file
-	 * as a feature check for perf_events being enabled.
-	 *
-	 * So it's an ABI, do not remove!
-	 */
-	{
-		.procname	= "perf_event_paranoid",
-		.data		= &sysctl_perf_event_paranoid,
-		.maxlen		= sizeof(sysctl_perf_event_paranoid),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "perf_event_mlock_kb",
-		.data		= &sysctl_perf_event_mlock,
-		.maxlen		= sizeof(sysctl_perf_event_mlock),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "perf_event_max_sample_rate",
-		.data		= &sysctl_perf_event_sample_rate,
-		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
-		.mode		= 0644,
-		.proc_handler	= perf_event_max_sample_rate_handler,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "perf_cpu_time_max_percent",
-		.data		= &sysctl_perf_cpu_time_max_percent,
-		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
-		.mode		= 0644,
-		.proc_handler	= perf_cpu_time_max_percent_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "perf_event_max_stack",
-		.data		= &sysctl_perf_event_max_stack,
-		.maxlen		= sizeof(sysctl_perf_event_max_stack),
-		.mode		= 0644,
-		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&six_hundred_forty_kb,
-	},
-	{
-		.procname	= "perf_event_max_contexts_per_stack",
-		.data		= &sysctl_perf_event_max_contexts_per_stack,
-		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
-		.mode		= 0644,
-		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
-	},
-#endif
 #ifdef CONFIG_TREE_RCU
 	{
 		.procname	= "panic_on_rcu_stall",

-- 
2.44.2



