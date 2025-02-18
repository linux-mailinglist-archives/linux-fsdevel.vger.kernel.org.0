Return-Path: <linux-fsdevel+bounces-41975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31512A397DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD16164A49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239923BF83;
	Tue, 18 Feb 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiLJJgU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3F233128;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=hIxwNtkpkudDRbQyhYIFQSaNTrfN45RPy6Rnkt0Mu/KieNJB9O8vEuUkzfRxaj8ilLEzN3Em3V9Ruj/c/MhG17Dq3U6OoEEZE9KT5WEmIn7Ocpl6k5m3Z0t6KqkSLAL/mbSHhWSTnqs8kTnDK7y0DdCvdGcnmpr/rExlFtni7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=N7FQbtF5ltXkGtvDBPbDBnYnA6Jue7K/KSgw9wenOFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNluq0Tn3xHzlWat78lZ2WMDHH9swkN3X8spkiLkDSv3UbFR9AO6ECt9PAtrVWH90qSgjx0pwH6fH2WHeP65A8u1UPqRLO4znIqJBN6G23SBS+qRDhfj7JqXFmAD2+GpSTWkllWz4HEsHRM8Z1HrvG3CbzQhvXqGJKT9Xrdpmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiLJJgU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B00CC116B1;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872606;
	bh=N7FQbtF5ltXkGtvDBPbDBnYnA6Jue7K/KSgw9wenOFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PiLJJgU09VgdMcmCHRHUjALxcJXfrbvT47Lfk8/1IQHkViiDlPVIoxnpFfrSQUI/1
	 mpoZ/zZr+9EiZREmqHSr9ZJNwdJN/SjoR3Iu7o7l3ticBq+qYXsihacBzGXVwSa1lF
	 2w4UOrxBU8qxaFVW6uyk42Ud5JEIHuVP4qBDUCTezhviBeJT52YzcdodGKnJqWI6TN
	 OUNm88jB7lANyq870kMpFZCO+xcwxyVYrESgVQQMuxXw2PLMyPdVrZIYsrKxr6pzzE
	 tVq6qrwO+JduFv7LRaUyC2vUwmCM/lFUm9tnDUTibgVRYQXEnSnt0J60nGPtDOViqR
	 8+eWf7T2pKllw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E67DC02198;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
From: joel granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:23 +0100
Subject: [PATCH 7/8] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-7-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=N7FQbtF5ltXkGtvDBPbDBnYnA6Jue7K/KSgw9wenOFM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVrYqtwc7VEBWPUryeCr6UzTsodifa1V4
 CuoLFfpqs2PiokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlaAAoJELqXzVK3
 lkFPBUsL/ilaJN/M2x5LmYQCnoB9tWZ3Y9gdJo92ZebGWWbZVzMlVOy16V+EWORPHSxFTyNq0jJ
 2DFlqm0+J41KgFUgCXXkWhavZqVV5QpGkCZQ1eUDsrSEISgNu+kpYhqllYTAcEQyLah33jm1Yld
 7z1SSWbm/mAPk/tRV39wZn6V8y4IVW+jczx6nUO/ekNqLAGg7dwYQAIepv7UixCMB2EgYqpqw0N
 hBxmxHbhhdZstJGF+K5o8WZP6faE9ntyK1g42n8WZ/ENwjae2FiPTU5pI/D2f/HRybg4MrdvwY2
 rcHQNzklx6KvCw1s/KFJyPvxdgpcVLqeMEtqoUwc0n6svbJZtgyUy/dwFePwTBQ+TXiuOjZYC/A
 07u47HcjEy2ajf3BNZNfGYdvpJkUCnMn1lzU1R8BGGDgvPgwYWFKBIaCzQv78MkEe56Qo8y2qsq
 F0BnjOlkTFv1ecsfXZp3j6g8LlwO0jFg1b0L1gLh2AI/mIY99tSmoFdAvUomc+StqFRyZypCkM5
 lE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move s390 sysctls (spin_retry and userprocess_debug) into their own
files under arch/s390. We create two new sysctl tables
(2390_{fault,spin}_sysctl_table) which will be initialized with
arch_initcall placing them after their original place in proc_root_init.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: joel granados <joel.granados@kernel.org>
---
 arch/s390/lib/spinlock.c | 23 +++++++++++++++++++++++
 arch/s390/mm/fault.c     | 17 +++++++++++++++++
 kernel/sysctl.c          | 18 ------------------
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index a81a01c44927..4483fdc9d472 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -17,6 +17,10 @@
 #include <asm/alternative.h>
 #include <asm/asm.h>
 
+#if defined(CONFIG_SMP)
+#include <linux/sysctl.h>
+#endif
+
 int spin_retry = -1;
 
 static int __init spin_retry_init(void)
@@ -37,6 +41,25 @@ static int __init spin_retry_setup(char *str)
 }
 __setup("spin_retry=", spin_retry_setup);
 
+#if defined(CONFIG_SMP)
+static const struct ctl_table s390_spin_sysctl_table[] = {
+	{
+		.procname	= "spin_retry",
+		.data		= &spin_retry,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+};
+
+static int __init init_s390_spin_sysctls(void)
+{
+	register_sysctl_init("kernel", s390_spin_sysctl_table);
+	return 0;
+}
+arch_initcall(init_s390_spin_sysctls);
+#endif
+
 struct spin_wait {
 	struct spin_wait *next, *prev;
 	int node_id;
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9b681f74dccc..507da355bf68 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -175,6 +175,23 @@ static void dump_fault_info(struct pt_regs *regs)
 
 int show_unhandled_signals = 1;
 
+static const struct ctl_table s390_fault_sysctl_table[] = {
+	{
+		.procname	= "userprocess_debug",
+		.data		= &show_unhandled_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+};
+
+static int __init init_s390_fault_sysctls(void)
+{
+	register_sysctl_init("kernel", s390_fault_sysctl_table);
+	return 0;
+}
+arch_initcall(init_s390_fault_sysctls);
+
 void report_user_fault(struct pt_regs *regs, long signr, int is_mm_fault)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b63d53e592d8..7f505f9ace87 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1702,15 +1702,6 @@ static const struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_MAXOLDUID,
 	},
-#ifdef CONFIG_S390
-	{
-		.procname	= "userprocess_debug",
-		.data		= &show_unhandled_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 	{
 		.procname	= "ngroups_max",
 		.data		= (void *)&ngroups_max,
@@ -1791,15 +1782,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#if defined(CONFIG_S390) && defined(CONFIG_SMP)
-	{
-		.procname	= "spin_retry",
-		.data		= &spin_retry,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #if	defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
 	{
 		.procname	= "acpi_video_flags",

-- 
2.44.2



