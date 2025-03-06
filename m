Return-Path: <linux-fsdevel+bounces-43338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B640CA54980
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD56C3B1673
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA9212FA9;
	Thu,  6 Mar 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od1hFtev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20A21146F;
	Thu,  6 Mar 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260651; cv=none; b=Gkg6US2bJVG6su2Ppc9+LrpVKNt2xNYtMDyMuhJ+ptSyRn3vapPKIOx4OyXr11TZktQ37p8LT/Cq4Q3Pq5Q/BjAT98oPjX2B3Bz/92vlV38EjbJhVFjCujxu+LvG7oqIVTM8SdBwutt6B5Bix55YLbvOh0SR4E0z0wyT1EZXAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260651; c=relaxed/simple;
	bh=ZGImg/UYYezAR5D62UZVHcZrdul61TJJRGPzQEXHI0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtSslA7T/ukPd4ob7VkjnFS+sncxiajObc5VPg6MnBPF/XECrE8hKZ4gbrq59fzQJ1fPzrZgVIaz+P9W7YzQ4OHcR04qzjqkK0mk6R+5Q/5R62n7KWPNfDmZOgRGXITCu/HMuG0w8vtfcaW5txhv6iH9NZypQFHdTmg8VVkQiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od1hFtev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1BAEC4CEF3;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260650;
	bh=ZGImg/UYYezAR5D62UZVHcZrdul61TJJRGPzQEXHI0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=od1hFtev8vOHDyt+xVc76OXjnrQ+Z7WoOcYWsOOvYWq+fDgJLpUOUAhDaiYqmaSfb
	 cGvNmfoJU95GYGMjkf8ht1MaEDdwGb8oeP3qyJzDSY67b4cwFaEmWQXGeGlxYqc3F2
	 YPPJu6sCVlxP6UuyTRl6InyUhK+UdajwcsfKbWXYBrNV1n0LHdK8/sZLtOa2evAWB0
	 0z+M2NZcxRybOgFSyPrUUFModZovM9dFlpf+bH4caKGel+MRX3w/Y42I/sti+UjuqJ
	 Mewg75Fvcg3x1jjgRkd4BoV1SwfyAmnPZ5brcEgKMGM8y7BlaQtaHb+jFdm2PZAH05
	 64YRIcOCn2peg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA04C28B25;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 06 Mar 2025 12:29:43 +0100
Subject: [PATCH v2 3/6] tracing: Move trace sysctls into trace.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-jag-mv_ctltables-v2-3-71b243c8d3f8@kernel.org>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
In-Reply-To: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-s390@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4358;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ZGImg/UYYezAR5D62UZVHcZrdul61TJJRGPzQEXHI0c=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfJh2ZMHgvJA1hAZ2oP8UKZpf9ClnId1YpxB
 uRWaDd9vXmbQokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnyYdmAAoJELqXzVK3
 lkFPjb4L/2shEqvyQIAHD1M1hHWpj/FmBZw4hdK1zqHCqNR0mh8w3gRieLGnd3MiDmygGsrDxGg
 m2j/mc9NhwXXkgdx+ii3ad4LxpkR52F+9BBAjdCpCbj+3XiJbdbgRZYHr1qIJ/5Lt4A6zFoiLWF
 NZ6dgC+Z9EMpVTqRrmE5Tabk/3aNiEaGWM5soUpk9ScFl6iGDG1wQuuyb1edyAk5LHS1IwUj4yG
 CpOziO/gNCgCaUwN/3AEIaxlnxke0FtU/AFXGhxPrKruW+pC/mayysA1twVpOEPYBh44U7tbbzz
 HtZhbnfQLm/e31B8+F6E/hmFyRgPo+mQcShDo8BBFh/3cA5s4Q/IItTFOS/zR/N76jFHRV/SnrV
 RKpY9+yVFoRWZ/teybEInZ8S+vQIBoHyamQa8fFDwSN4h3NyXYTLrqNIgQqKF8vkhXjsS8eiTXH
 QWnKgGlN8fhlLt27nB+tRDf+w2mT+hWMq4tSlCnlq5ivEUBOnKmArrYVW6f9Kh93FtMiS8Srbq6
 d4=
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



