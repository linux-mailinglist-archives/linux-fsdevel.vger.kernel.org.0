Return-Path: <linux-fsdevel+bounces-41977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60CA397D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF21E188B5CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5112623BF9A;
	Tue, 18 Feb 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1O7vfVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C48233D89;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=pLKfARksbFjwyC5REsk7oCcHwQbt37rRhs+il/vF8SmSPXaWMJcSvLThxe/QR/XrLG0n7lC8mVWr8L/Oo/trd87mIYI/CeC53NYveD6f7Tjy+2CBy1DErXUAD+uSEKqNPiuvTqU0nwVzoAPXAMYTPi3oKxaERbaiwd5sLe5mF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=25VrcofxjXYiWPL+NpeDoZmrthXGZql9I+TZr94WN1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pde5P+kYfohFQH6MFmjEQcD358p2v7hyGzVj+amk9/QRolL7Eyrw6OAD8KpMlhn3Ot+UZz8zd3pMlX0b4aa7NhmhLeC0eUhiG7NsKw9ZM8jKc3CCwFviWZEEGYetwqJ7vvXVrI39linE0PQhRY5S5nF1prShHZOiD5wBmniAEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1O7vfVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35171C4AF51;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872606;
	bh=25VrcofxjXYiWPL+NpeDoZmrthXGZql9I+TZr94WN1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t1O7vfVvEjL21CvHAqne4UhEdRzvJaXiNYil7mgmm9x44BZBd1W6Y1uCfPBOnqhwL
	 1RFaRWdenTWu8GUoprIpS7nV8zMJ3DM+2u7Tdt/5e90/ohrHQkg5bq/i1L8K3IKsHs
	 ZuPWSJQi/BU8DGF6WZhFTIqiaMBGORw9tCHtc+U8tgifRHAPvJV7EVvm/nydcmmS01
	 4ecEs5J6pYRVkakXmLzie9sopp5t0ShkVU65fznUq7weu8CX36AXhHBOLkX+Qoc6fO
	 j1xT1AGV+Jdl789v3OoweOkkLbWovTxvUu+GmWuzgkmyltkm31lg2OSCPBGJ9p/b3R
	 6BL9WgBr2+VHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A9C021AD;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:24 +0100
Subject: [PATCH 8/8] x86: Move sysctls into arch/x86
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-8-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6910;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=25VrcofxjXYiWPL+NpeDoZmrthXGZql9I+TZr94WN1U=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVumUM7VC3nkKjqPjxD72KDdRR6LD1mMS
 aDvYqAAB3iMY4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlbAAoJELqXzVK3
 lkFPVIIL/izMcYoC1vEgjhYCHqFpAP7CLDIpIwXauJG2W7wUCFoIwUCBuPHBZj6KYSXDyNu8X7T
 G07ju4giBhkZofL8eCOhuasU8ZN+at3aFEXf5fICqFDRS3TvXik4Z6yK43mTYZXs9MVRThtZRxf
 PaKruze8Nn89HxOdekRSpFl6UYsufRMHOA+nJ0EaATUd/X62cOvDvsysHXG+HFVz/gU1359eNU7
 Cpj/W39YNxVDAJPM0xOYuoQmFd0U6iBBrxwxq6aN3VAZLJzLpYzuL+4ZUrmw6aaZZPm8MnCY9dl
 bq8q1h6VKx/CzaUT0KoCAc63XIjmywKIdO/UOm723JUAdqttspUYzcemKmhLYblQWbDCA+TIRc3
 XIp586nZ2T+iHo5+Dr63JwJFPd3FjJEP4e9nQhyv6xnKUUCyMDwM/Rm4rqblg8A+ixRIIh0GzOC
 0/m2pTkTNc06RWRYqOj5WGwYe5koNsO/aCDJQqN+3HSkJahp8yLHPFCUeAsegkvcgTqKbKzlco7
 XA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the following sysctl tables into arch/x86/kernel/setup.c:
panic_on_{unrecoverable_nmi,io_nmi}, bootloader_{type,version},
io_delay_type, unknown_nmi_panic, acpi_realmode_flags.

Variables moved from include/linux to arch/x86/include/asm because there
is no longer need for them outside arch/x86/kernel: acpi_realmode_flags,
panic_on_{unrecoverable_nmi,io_nmi}.

Include asm/nmi.h in arch/s86/kernel/setup.h in order to bring in
panic_on_{io_nmi,unrecovered_nmi}

Remove the asm/{nmi.h,io.h} includes from sysctl.c

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 arch/x86/include/asm/setup.h |  1 +
 arch/x86/include/asm/traps.h |  2 --
 arch/x86/kernel/setup.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h         |  1 -
 kernel/sysctl.c              | 60 ----------------------------------------
 5 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 85f4fde3515c..a8d676bba5de 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -46,6 +46,7 @@ void setup_bios_corruption_check(void);
 void early_platform_quirks(void);
 
 extern unsigned long saved_video_mode;
+extern unsigned long acpi_realmode_flags;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 1f1deaecd364..869b88061801 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,8 +35,6 @@ static inline int get_si_code(unsigned long condition)
 		return TRAP_BRKPT;
 }
 
-extern int panic_on_unrecovered_nmi;
-
 void math_emulate(struct math_emu_info *);
 
 bool fault_in_kernel_space(unsigned long address);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..9f8ff3aad4f4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -56,6 +56,9 @@
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
+#if defined(CONFIG_X86_LOCAL_APIC)
+#include <asm/nmi.h>
+#endif
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -146,6 +149,69 @@ static size_t ima_kexec_buffer_size;
 /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
 int bootloader_type, bootloader_version;
 
+static const struct ctl_table x86_sysctl_table[] = {
+	{
+		.procname	= "panic_on_unrecovered_nmi",
+		.data		= &panic_on_unrecovered_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "panic_on_io_nmi",
+		.data		= &panic_on_io_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "bootloader_type",
+		.data		= &bootloader_type,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "bootloader_version",
+		.data		= &bootloader_version,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "io_delay_type",
+		.data		= &io_delay_type,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#if defined(CONFIG_X86_LOCAL_APIC)
+	{
+		.procname       = "unknown_nmi_panic",
+		.data           = &unknown_nmi_panic,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+#endif
+#if defined(CONFIG_ACPI_SLEEP)
+	{
+		.procname	= "acpi_video_flags",
+		.data		= &acpi_realmode_flags,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+#endif
+};
+
+static int __init init_x86_sysctl(void)
+{
+	register_sysctl_init("kernel", x86_sysctl_table);
+	return 0;
+}
+arch_initcall(init_x86_sysctl);
+
 /*
  * Setup options
  */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640..a70e62d69dc7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -330,7 +330,6 @@ static inline bool acpi_sci_irq_valid(void)
 }
 
 extern int sbf_port;
-extern unsigned long acpi_realmode_flags;
 
 int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7f505f9ace87..bf098028ba68 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -65,10 +65,6 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_X86
-#include <asm/nmi.h>
-#include <asm/io.h>
-#endif
 #ifdef CONFIG_RT_MUTEXES
 #include <linux/rtmutex.h>
 #endif
@@ -1716,16 +1712,6 @@ static const struct ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
 	},
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
-	{
-		.procname       = "unknown_nmi_panic",
-		.data           = &unknown_nmi_panic,
-		.maxlen         = sizeof (int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-#endif
-
 #if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
 	defined(CONFIG_DEBUG_STACKOVERFLOW)
 	{
@@ -1736,43 +1722,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#if defined(CONFIG_X86)
-	{
-		.procname	= "panic_on_unrecovered_nmi",
-		.data		= &panic_on_unrecovered_nmi,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "panic_on_io_nmi",
-		.data		= &panic_on_io_nmi,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "bootloader_type",
-		.data		= &bootloader_type,
-		.maxlen		= sizeof (int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "bootloader_version",
-		.data		= &bootloader_version,
-		.maxlen		= sizeof (int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "io_delay_type",
-		.data		= &io_delay_type,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #if defined(CONFIG_MMU)
 	{
 		.procname	= "randomize_va_space",
@@ -1782,15 +1731,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#if	defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
-	{
-		.procname	= "acpi_video_flags",
-		.data		= &acpi_realmode_flags,
-		.maxlen		= sizeof (unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-#endif
 #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
 	{
 		.procname	= "ignore-unaligned-usertrap",

-- 
2.44.2



