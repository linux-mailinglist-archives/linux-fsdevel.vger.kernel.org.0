Return-Path: <linux-fsdevel+bounces-43913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EDA5FB6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112701666A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235526A085;
	Thu, 13 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaqHAmOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBF268FCF;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882957; cv=none; b=qTzOIO2waVogmu2Rc8II/gJLDV0i+13ogHkzrTVc7QOukto3Bw/H3hVNIpxWuxbjgxzxAgr2e0sPnib9RV6OnOtGB+kctXS1cTXHyGz0v1t61Y5JFwZbzvtYSwP7W59NKhl6qGpphx8iU6Ra0oKywLR7jRmwT4YO3TvlRRv7+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882957; c=relaxed/simple;
	bh=ZGImg/UYYezAR5D62UZVHcZrdul61TJJRGPzQEXHI0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wj3E8MlsDWWAV2CvMeh1kuy+5nsUiaDn2l9Hz5NaT2+qv5I+WiNdZu3YYH28niSyEetLZvc9fnKVdKF7zMaxGzCwol8pBEqFaVvl7gEPR8MWraiZ5Y2mDLlijLZBgNPJL3xWR2owPCsiOsiXECp/CZ/OqgawrqGnRD7fTZHascE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaqHAmOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5543FC4CEF2;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882957;
	bh=ZGImg/UYYezAR5D62UZVHcZrdul61TJJRGPzQEXHI0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OaqHAmOqtg/qwtLAc8weLUP0c2E8UCW+3nnHlwv/dDeFlmGGWHwMetiYgwaga5X/G
	 LB7FgQCnehnjHW8+bcI9312HCfiqj+T/UkEsy5gTyOXllRJL+0aDQMrDWNZDiN7UQ2
	 +ABxA+O9yEYpp5jTTrwf00ozGCQL0GB7usEHWgzrzFu8O6gWIXXha77SPJ0OfBG+1w
	 UpGvwLv3vbaIzbFtJ0mqV97j0hgS4WdfRK5kNiMPZrNjfWUGt1Srg9cN8+mTWq8ONa
	 bJ52L3sWpDz7f2dDD9XdDmv6EnUll5BBCJdX6kS+BIpVh2NQ77uf1zSLiLewVRrME2
	 btzzJkaio3Ajg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49158C35FF3;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 13 Mar 2025 17:22:25 +0100
Subject: [PATCH v3 3/5] tracing: Move trace sysctls into trace.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-jag-mv_ctltables-v3-3-91f3bb434d27@kernel.org>
References: <20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org>
In-Reply-To: <20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org>
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4358;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ZGImg/UYYezAR5D62UZVHcZrdul61TJJRGPzQEXHI0c=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfTBklj8jEAwyoKKKENR8Ja5tnyAuOwpd3A/
 ikFhAEKdyevC4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn0wZJAAoJELqXzVK3
 lkFPdxkL/1yOtb0UibDXQUSAEASNboEJAvpQhKERr51XWuDXEuao0qL6bQYvaXtIzIIT3HGAu8C
 42xFXcGMEw9cVnz6ea+1SwrXExiXEsrLlqobfwiJDPlE3yXd7z9WphRUvCEHh1rHC9dV5fCvxrY
 vWXTCnnaD5rcr2x2zTwgWk6JqeJlJVQ8c/Rna/80zTzznqg8F+qznXSIkj2ZHMCwp58FfArdSqr
 2ZNNqGfpYZKf4FPnWiGIk9a6IAFZgbWYmlTSAUskQ32Gk6KoMX2sdY2Mqc9d9FwpD4BV/9o+CIF
 6PQ9ZzwRoIUPwGoWJtCImWOwxhNaDKiin8FSrOcUe1yOTPI8fo3QP0y3MZA41d/mVvt/VMutBz3
 rLjfTdHkjVKLuCkhl/+0YMaQeXxwsAQS8WTD4PsVsFuO94A/gTf1+yAxBrxe+UuLdnPKYI4v7Hz
 tN10fTukaz4B53gpnQmkY5m1zhB0e4OX1dO/NIDl930CB08Txn8DNmcewdxYcHRwpezU/PKNJc6
 Bk=
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
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  7 -------
 kernel/sysctl.c        | 24 ------------------------
 kernel/trace/trace.c   | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fbabc3d848b375a114936b635bc695d59ab018a6..59774513ae456a5cc7c3bfe7f93a2189c0e3706e 100644
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
index 6514c13800a453dd970ce60040ca8a791f831e17..baa250e223a26bafc39cb7a7d7635b4f7f5dcf56 100644
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
index 0e6d517e74e0fd19bfb31fcbcb977d57f894c78b..abfc0e56173b9da98236f83c715b155e5e952295 100644
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
2.47.2



