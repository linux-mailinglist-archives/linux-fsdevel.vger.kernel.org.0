Return-Path: <linux-fsdevel+bounces-41971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622EA397D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2796A172AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281A23770A;
	Tue, 18 Feb 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsAAAuDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1118E743;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=itoUYTDg+vzLIOuO/CDMQsNSQnW8ly8WXfXtuzpcwUvXWhSffkIWXkqIh+pRrfFd8UaZoB+HbCSIzC8ES1FjufY6eOB0n93C9ZWifa57urMFpK1vcbsD1V2dh5lR8oQqOB9Thu4LPzOP5shopdtlGYBIlxkTmMuW9oc/NAMTXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=gKOcrGpQjahVvJdglNWmSaswvExwnbWiiSjSH90VtpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwrcND5wrnqPPmcHDA2aeTStrXbmHd+gP0Z6Kqln5oUhq4nvaax2+MItt9hDopb00ufhGZ6wt5GZ2ckwXSCD+xY+s8m90pG0ocdgwTcuI/wJTmQs5rN3Ryr3v4B8+VZLYMbHHJzokICID22SQxAvlYUoETr/P8oogIa3Yy7Ij0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsAAAuDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6103C4CEF0;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872605;
	bh=gKOcrGpQjahVvJdglNWmSaswvExwnbWiiSjSH90VtpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fsAAAuDUrmTBpjf+pPR7mbS+SCq/vkH2zq/1nUArctmJSEhpXQaGCLTRsO1lEjITT
	 yUREgDThnSIf+e3NvsnzKLR7oojEzmy36xjSo2gJIvdK+xvOqZybKW+Fmkt5wXv+zH
	 2WEtIe6URfhy3zia00dCQf2k+67D52yFXuMwYH9hudxB7jvfC4xbIfvxnMU/BJSelk
	 t8jnfB5wFK/fX439Xvj+mYoSv+2bTKUeI6shdsp0gUfStGEgYTUuLWbMVfQVzVmZqu
	 ufBRMhwTww2nNjVba9gwRtyS2NMvw3XhyrG1ckv3LMaW2G/q25Nr18zkOfWd1wWB5O
	 31cDuFMuVUsFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD80C02198;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:19 +0100
Subject: [PATCH 3/8] ftrace: Move trace sysctls into trace.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-3-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4133;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=gKOcrGpQjahVvJdglNWmSaswvExwnbWiiSjSH90VtpI=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WViZ+1Utx9MJcRoUlK2QW6VYygMERf4Hj
 Ahbcaguu2zpRYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlYAAoJELqXzVK3
 lkFPUJQL/jbOqbjXit8Gy+oxvkYPcsV3ssL8il7SReg2PhRCFIkA8a31a0iIhDGRtpwXwz0dq/L
 CTmsWNMTMapxBbmyinvlCTFCMcpOx/B3JWFdM6uyNCy10Xs8H5VU9U3TTQz6rtqj6z8Jmn5Xcv8
 N1iJ+rsM0qDsa/wx8gf/A/HeVwZTKfj+VIHAgVfT5TDGFEzx22C2VSNzhPSIrqz7EdPifNzrche
 xdbRsDR4QYqveSKRYOetQqkaond55zNApIJDcYyAwlm0C4uCz0YkP5M2g8x2T1Wty6sF4bNIJEV
 MNHmOB0GLYo799ehS0P5B7D5Bp9JYw+HO90bKQ972uCB5tkrT/rKCvvCvpVIvLNuMnQOfnv9Gf/
 KeqL8S5Bxe/pNyeTSdwDzuMwaQg0jNgs1IT5V66G+5GNJH8k4P7ifO11fAXVH2uCAMx33e+lFHn
 GomuRYKFW6gRomNXfz3vj++4G17yWSAJ7co6mnb6DNf0+cg1LAjG9QhSrMvJl0tqlx2P+Hk8HX5
 o0=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move trace ctl tables into their own const array in
kernel/trace/trace.c. The sysctl table register is called with
subsys_initcall placing if after its original place in proc_root_init.
This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/ftrace.h |  7 -------
 kernel/sysctl.c        | 24 ------------------------
 kernel/trace/trace.c   | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fbabc3d848b3..59774513ae45 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1298,16 +1298,9 @@ static inline void unpause_graph_tracing(void) { }
 #ifdef CONFIG_TRACING
 enum ftrace_dump_mode;
 
-#define MAX_TRACER_SIZE		100
-extern char ftrace_dump_on_oops[];
 extern int ftrace_dump_on_oops_enabled(void);
-extern int tracepoint_printk;
 
 extern void disable_trace_on_warning(void);
-extern int __disable_trace_on_warning;
-
-int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
-			     void *buffer, size_t *lenp, loff_t *ppos);
 
 #else /* CONFIG_TRACING */
 static inline void  disable_trace_on_warning(void) { }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6514c13800a4..baa250e223a2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -51,7 +51,6 @@
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
 #include <linux/reboot.h>
-#include <linux/ftrace.h>
 #include <linux/perf_event.h>
 #include <linux/oom.h>
 #include <linux/kmod.h>
@@ -1684,29 +1683,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= stack_trace_sysctl,
 	},
 #endif
-#ifdef CONFIG_TRACING
-	{
-		.procname	= "ftrace_dump_on_oops",
-		.data		= &ftrace_dump_on_oops,
-		.maxlen		= MAX_TRACER_SIZE,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
-	{
-		.procname	= "traceoff_on_warning",
-		.data		= &__disable_trace_on_warning,
-		.maxlen		= sizeof(__disable_trace_on_warning),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "tracepoint_printk",
-		.data		= &tracepoint_printk,
-		.maxlen		= sizeof(tracepoint_printk),
-		.mode		= 0644,
-		.proc_handler	= tracepoint_printk_sysctl,
-	},
-#endif
 #ifdef CONFIG_MODULES
 	{
 		.procname	= "modprobe",
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0..abfc0e56173b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -117,6 +117,7 @@ static int tracing_disabled = 1;
 
 cpumask_var_t __read_mostly	tracing_buffer_mask;
 
+#define MAX_TRACER_SIZE		100
 /*
  * ftrace_dump_on_oops - variable to dump ftrace buffer on oops
  *
@@ -139,7 +140,40 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
 char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
 
 /* When set, tracing will stop when a WARN*() is hit */
-int __disable_trace_on_warning;
+static int __disable_trace_on_warning;
+
+int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos);
+static const struct ctl_table trace_sysctl_table[] = {
+	{
+		.procname	= "ftrace_dump_on_oops",
+		.data		= &ftrace_dump_on_oops,
+		.maxlen		= MAX_TRACER_SIZE,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
+	{
+		.procname	= "traceoff_on_warning",
+		.data		= &__disable_trace_on_warning,
+		.maxlen		= sizeof(__disable_trace_on_warning),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "tracepoint_printk",
+		.data		= &tracepoint_printk,
+		.maxlen		= sizeof(tracepoint_printk),
+		.mode		= 0644,
+		.proc_handler	= tracepoint_printk_sysctl,
+	},
+};
+
+static int __init init_trace_sysctls(void)
+{
+	register_sysctl_init("kernel", trace_sysctl_table);
+	return 0;
+}
+subsys_initcall(init_trace_sysctls);
 
 #ifdef CONFIG_TRACE_EVAL_MAP_FILE
 /* Map of enums to their values, for "eval_map" file */

-- 
2.44.2



