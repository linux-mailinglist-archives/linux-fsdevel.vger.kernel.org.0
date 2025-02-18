Return-Path: <linux-fsdevel+bounces-41972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C863CA397CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26428188ADFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46481238D25;
	Tue, 18 Feb 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swFHRr0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC78200111;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=Ol9mT9LX8holFdakJKC3JbOzKT92vQolgjytzPhQEhlfVMyDCi9rI/JdK65DTRRgfHEkGIRPD8JJ6PxgO6lcv1uOmrk5QN/kkKPOnRowC8knPsRCbmE6gUL7NlKpYPIbbBfzTCXGnyFWWV4K9w5ncNR+f50cXFgkQkow4SKhwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=NyFjle3l0026Gd8PBKMPo4EmMXIGmeeTI/HzQnjZhwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOUkPDDWJiz2up0RWG/5MFwf8fDt6K8cVq6UPb4T3IcTp3YQP60dRAEn7dff0oB0pmwMPJh02ZAUXb3JgX5HjqOkScwfUnKlc53R6V0bnkbJxC3ttqQqMO5LjNOc7y8DUV1btb8qvSd/ggMS4rOvuFAr29aGgfH3JorsF9UC12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swFHRr0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A93C3C4CEE8;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872605;
	bh=NyFjle3l0026Gd8PBKMPo4EmMXIGmeeTI/HzQnjZhwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=swFHRr0tDDufCCwCcsmIuxhpVCjoWLszRL/1eJdiJg6oXKm87Kv7AJt6wcfTaSmcX
	 fq972tanKzPkgD6kSLevKopQ9pBsqeHV6wiJ9cdhNBMOohMpnF4H2u3OGqzeZudZ0Y
	 E/h0F2SMeYWytLUBLkgeH5zJfBVgJfbTt/i787BdPv6LG5APnTir1sgZ2b607DiM/a
	 TyUhnOFZLMPB2NvNechpgtN9Od7s9FVG8xUhCwr3fnilKTpsGd/dzOlAhXbCWbQfL4
	 CLNJenH6NTW2iiWgXVEMfxXCrm7I3iBs/n6G9aZpWmZZZKkd7T1P3JiyCKhIQjfUd4
	 dIrkVYtYBG3Xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BCFC021A9;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:17 +0100
Subject: [PATCH 1/8] panic: Move panic ctl tables into panic.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-1-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=NyFjle3l0026Gd8PBKMPo4EmMXIGmeeTI/HzQnjZhwo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVcAzJMiraNriDVA+Jt05tU4vLaM0b9zm
 pQ2Aq7OP5eX/YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlXAAoJELqXzVK3
 lkFPLfAL/20rjwkdDzYb51zKDdgXrnBcdHhkgJERVMP5kLuoDZPIpCzZp0dzglrDGrmWlA8rhxN
 NQU/dO9PP0QZrfy/Hfe2s8RXLT20avONnO7wYWu18KpWrTsp6TWbmJ7Zw3nAzDrGhpM+kO8VE2z
 IQntkQdUb1PWcV5Vm2G5GzZ01F6vKIVWYRw/z/gNZQF8csmvMOmkOIu+irJCgNCzhygDkPmhzDY
 efozZo2EblyEvFTgKPaP2s13syORR3hbJc4QjhOP57eR3WBTD+0GSaFFL0rIEGk++DJCX9VXFjM
 Cud8ZlqEMrbXPiE4LIWZsa5ce4O2Ik2fAPxhBwPWwE27VcFmVwE08vnP+EurCOP7EBMst60ZQPC
 KFowdYMyOAKk6890XxRSNZ2dYj/lWpNAjY6wgZPxVb9COHxmqfmT22EGGtdlw5rOJM0bMQop0PP
 vEgf8A6vjycLBM+VlS8tZpT/YLtLex21joa/9v6Wvmj7UWlN+ibSIzK/WRs1HVOWVIhWAVmnBQ6
 Qs=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move panic, panic_on_oops, panic_print, panic_on_warn into
kerne/panic.c. This is part of a greater effort to move ctl tables into
their respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/panic.c  | 30 ++++++++++++++++++++++++++++++
 kernel/sysctl.c | 31 -------------------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..f9bf88f4c262 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -96,6 +96,36 @@ static const struct ctl_table kern_panic_table[] = {
 		.extra2         = SYSCTL_ONE,
 	},
 #endif
+	{
+		.procname	= "panic",
+		.data		= &panic_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "panic_on_oops",
+		.data		= &panic_on_oops,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "panic_print",
+		.data		= &panic_print,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "panic_on_warn",
+		.data		= &panic_on_warn,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname       = "warn_limit",
 		.data           = &warn_limit,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb57da499ebb..7759b1ed7221 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -26,7 +26,6 @@
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
 #include <linux/signal.h>
-#include <linux/panic.h>
 #include <linux/printk.h>
 #include <linux/proc_fs.h>
 #include <linux/security.h>
@@ -1610,13 +1609,6 @@ int proc_do_static_key(const struct ctl_table *table, int write,
 }
 
 static const struct ctl_table kern_table[] = {
-	{
-		.procname	= "panic",
-		.data		= &panic_timeout,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 #ifdef CONFIG_PROC_SYSCTL
 	{
 		.procname	= "tainted",
@@ -1803,20 +1795,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{
-		.procname	= "panic_on_oops",
-		.data		= &panic_on_oops,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "panic_print",
-		.data		= &panic_print,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
 	{
 		.procname	= "ngroups_max",
 		.data		= (void *)&ngroups_max,
@@ -1990,15 +1968,6 @@ static const struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 #endif
-	{
-		.procname	= "panic_on_warn",
-		.data		= &panic_on_warn,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
 #ifdef CONFIG_TREE_RCU
 	{
 		.procname	= "panic_on_rcu_stall",

-- 
2.44.2



