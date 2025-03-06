Return-Path: <linux-fsdevel+bounces-43339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26111A54983
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933CE174628
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBFA213E9E;
	Thu,  6 Mar 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ler7t8+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D68211497;
	Thu,  6 Mar 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260651; cv=none; b=XOr9H12UPUZrWg9NCyl/rtuXJEnFfdjTN7hXvl2PJUTyLtZbYJUbR31/cVklFcwB5eoqYbHI15Vb5sAiUn3eA40Ovd6lrEK/Dhw7FH1r5YRRzLjJKg/3AjC4MDguWVlw6g4wBr3XES3TyaNgQYeS4FwSwkgW25rPxjWGEdNueHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260651; c=relaxed/simple;
	bh=r81yvisX8P4UQm9F7N7hhZ732PaheqwD7Ks9SFpA+WU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGZ/YGQe5rWNkInhN+Y5sTGVtrenmmk5yA6Nhk0uFtWnKce9uIp4qFQ6xw8QshZAqVoaCApkefPNVKcRYA7XlcXcqGbIJ33m+BbL2wwElrFi6c8qt1sOhVv3kmpOsGpLUZW/XGilVEViY4lBosn4SidnZkxwfUOOc6DQpw4Uk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ler7t8+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04DD3C4AF0C;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260651;
	bh=r81yvisX8P4UQm9F7N7hhZ732PaheqwD7Ks9SFpA+WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ler7t8+SANzyxeocUaVFF0itfXjdU/AePkZgfwecSb9/3uHn9EJLYdOl7yEWWt26X
	 gfbgXEaTJbubb6zSFxiE3MJRKjpQXwfLp+1G9BSGiWCqMOTvaKavbo8xZt0/BrR1yQ
	 xn/1Ptu59MizrbpA03exoCIx/1pM/xhK+vQSaXF1DemvPMQ4BB+ko4e3aWSoWZmJSo
	 h+loNjGifVudVHzlXFeQCHsKVqs/vwkDcO70Zfm/Qg1PgQ/lR7aNYQu7I7CYExK744
	 r8T5gba64BoDYPfa2j0BfACWYY/s14KBueIuTPUCOSNxF9bxT0pNglBNMAlCWu/Ipr
	 eqkJb6AowxlqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968BAC282D1;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
From: joel granados <joel.granados@kernel.org>
Date: Thu, 06 Mar 2025 12:29:46 +0100
Subject: [PATCH v2 6/6] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-jag-mv_ctltables-v2-6-71b243c8d3f8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3591;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=r81yvisX8P4UQm9F7N7hhZ732PaheqwD7Ks9SFpA+WU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfJh2hk9Sl4d4/rt7M4Iv2CUUdgG9l340yBQ
 6BGtdUWhlaPu4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnyYdoAAoJELqXzVK3
 lkFPr9cL/joKGCY8wwMfNbIM/wGecy7g3xyX2KarUDFaSjpCcTGPnu4HHo8U403Jd27W/skMAG9
 oVpxYveO27v7tBMjjMuxmOZ2oslc37sV8r1ghd2AHHxFE5PgLHtp7EfmYoySst59SKwIxWndwjd
 pVILJ97rkV8dNy4VuIkf7vRkIY8TpezV37Bg3nOiStdEeBer8CwF8/YNWojUb6oF0liBQjLvBRm
 /n81HLHBv64bVKMcW/82pwTrAvtP4Skk4na6AF25lC0iSWmP3k6iPhLrV4XCy+EbJnQx4XYhmOd
 8/AZE8B8v7esZrpw0FYYg3004UQ6mS9KpGFBjcNCE/pxhBPfeC+MRj24JINqy1oT/bZpXK3fr8H
 AMu//ZLi/gEZ7QS6vGYkolT5M0Bvq6tqF3sOhc9tEp5zdaTOCasIU05PpbNWFzq0JbHpFvox1Lh
 3bc6S5+/kikkHL42qGx9Ze7F2QAn/4jFnKdY7QjIHiCbAv/SWJhKXtDQLxZ6maCcIhK1UKBDPI7
 W4=
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
kernel/sysctl.c.

Signed-off-by: joel granados <joel.granados@kernel.org>
---
 arch/s390/lib/spinlock.c | 18 ++++++++++++++++++
 arch/s390/mm/fault.c     | 17 +++++++++++++++++
 kernel/sysctl.c          | 18 ------------------
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index a81a01c449272ebad77cb031992078ac8e255eb8..6870b9e03456c34a1dc5c0c706f8e8bf1c4140e8 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <asm/alternative.h>
 #include <asm/asm.h>
+#include <linux/sysctl.h>
 
 int spin_retry = -1;
 
@@ -37,6 +38,23 @@ static int __init spin_retry_setup(char *str)
 }
 __setup("spin_retry=", spin_retry_setup);
 
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
+
 struct spin_wait {
 	struct spin_wait *next, *prev;
 	int node_id;
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9b681f74dccc1f525bafe150acf91e666a60d2bd..507da355bf68271c30115a797368f950707a2d8e 100644
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
index 0dc41eea1dbd34396c323118cfd0e3133c6993a1..34c525ad0e0e0fe3b64c2ec730e443a75b55f3a3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1709,15 +1709,6 @@ static const struct ctl_table kern_table[] = {
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
@@ -1798,15 +1789,6 @@ static const struct ctl_table kern_table[] = {
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
2.47.2



