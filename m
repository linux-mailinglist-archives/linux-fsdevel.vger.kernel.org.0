Return-Path: <linux-fsdevel+bounces-41976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F900A397D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78251894611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8323AE8B;
	Tue, 18 Feb 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv3mnkDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122B233136;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=TcKh4qaSqu5hJolY0UAuWy2pLssDlqG1iSk3kURYa9h5zaj4fdZIXfEL/EowTAHNLWiH35d+Ym7/S1i5E8ZCpVvzOXrH77oA5zXavbFW/1XbpykNYIw8pRbAuqkbIFlYqrr+sCEA2vtGokh1jqvnTKxH/llHm9OEDm5pHEToRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=W9D1x5RI31lDx3p+LX5++XnrPbNPs0OdXkbg0azO5zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9QnlaFSYb/aaqmYbddboZY5ujszvX7qQbdxUOdlSkXgdHah5DFThkDtr+6kJYYZUBADsYDEspZ3L6MWgiCvwHnYjvLTlCXIkShj/45ChtZocma7gqBAlI2p2fIi1i1Vw47SvstRa4l0gNhGSz37CgjYbS04/PUN2RfE4NBSddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv3mnkDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08387C4CEFB;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872606;
	bh=W9D1x5RI31lDx3p+LX5++XnrPbNPs0OdXkbg0azO5zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dv3mnkDquQqjl201BGORQ7zSF97LR8HJU1ZXrHU1IDXzkrNK6d+IEyy51pii6Fw/d
	 Vb2shTGXVHzLzJ5JOifx6i2oCfPM5N+aGl6XCw9pUKiug38P9MWkErzsLzOFwpO11l
	 95t4lYewdCYoDWxs/4EwlUrEaewkH6G1YUpcMQT0hq7chnwjhHTbC3PRF7eY/K+Gky
	 I0oWWqyWEUPleO3MY8Sp6cmNBpS4b4y1IzSf7B4PjAOxvaRyt+dyc/Uidu4zK14aQP
	 Qysg9tWYxuRvzxvcSB0Cx5/VgVROs0cIeHYlpSZB/haLbjyrzua3Z44o2uPp0t5T6g
	 WKbMTKttivfLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E1AC021AA;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:22 +0100
Subject: [PATCH 6/8] sparc: mv sparc sysctls into their own file under
 arch/sparc/kernel
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-6-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3680;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=W9D1x5RI31lDx3p+LX5++XnrPbNPs0OdXkbg0azO5zg=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVqTdU3OmlPVNS3l8Ja/Z2IQKVamKk9d7
 nVMVgnpwno2SIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlaAAoJELqXzVK3
 lkFPkB8MAJTy8l0YojZMRVO2pk2av6uMJ/lqppw/sG19vlr94QoANJIAlDvZ6a02ouwtBS5yiDQ
 OJd2LuJATMT9/074vJzWN1EMSBLWQM/BDxT4up6IKKCFN1XwF7URrZ2O5+DEesNEYl+S2qXcKs3
 OWhJS6mm8rzxYo8Faw/o94dZPdkz7hCu8dVzgFks20DvZh734/Zphu6+PrnkKenOmMyg+opVgNq
 GpmmnVwdjLsE/BEDgrNl1SpzYjpiQ7KhPmrirfehqlnR7LOmgsyfYedZXj2IzQhLRYi7vDcLoio
 r9TnixsuLQgS6BO2BkKeijFrrHAXKpqyHZmZCDvl3MZyCcHFhqUljbxmp1glUS1od+PXW2tJv3y
 tsHB5TXeOuAxna9jcjiXOZaMf4zySQM00GhDKP1cdd+gJpxVCLBv6LBYxZJqQ/ff5UyH9MC0UZB
 UXbAmV6tL4VN84xj5VgTM3Ep+XWOVx9cuwz+bN9I3rPAr807EJ8xvzArYjktRwb8RizLGzvx7W5
 Mo=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move sparc sysctls (reboot-cmd, stop-a, scons-poweroff and tsb-ratio)
into a new file (arch/sparc/kernel/setup.c). This file will be included
for both 32 and 64 bit sparc. Leave "tsb-ratio" under SPARC64 ifdef as
it was in kernel/sysctl.c. The sysctl table register is called with
arch_initcall placing it after its original place in proc_root_init.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 arch/sparc/kernel/Makefile |  1 +
 arch/sparc/kernel/setup.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c            | 35 -----------------------------------
 3 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 58ea4ef9b622..3453f330e363 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -35,6 +35,7 @@ obj-y                   += process.o
 obj-y                   += signal_$(BITS).o
 obj-y                   += sigutil_$(BITS).o
 obj-$(CONFIG_SPARC32)   += ioport.o
+obj-y                   += setup.o
 obj-y                   += setup_$(BITS).o
 obj-y                   += idprom.o
 obj-y                   += sys_sparc_$(BITS).o
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
new file mode 100644
index 000000000000..4975867d9001
--- /dev/null
+++ b/arch/sparc/kernel/setup.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/setup.h>
+#include <linux/sysctl.h>
+
+static const struct ctl_table sparc_sysctl_table[] = {
+	{
+		.procname	= "reboot-cmd",
+		.data		= reboot_command,
+		.maxlen		= 256,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
+	{
+		.procname	= "stop-a",
+		.data		= &stop_a_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "scons-poweroff",
+		.data		= &scons_pwroff,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#ifdef CONFIG_SPARC64
+	{
+		.procname	= "tsb-ratio",
+		.data		= &sysctl_tsb_ratio,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
+};
+
+
+static int __init init_sparc_sysctls(void)
+{
+	register_sysctl_init("kernel", sparc_sysctl_table);
+	return 0;
+}
+
+arch_initcall(init_sparc_sysctls);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fdc92d80e841..b63d53e592d8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -69,9 +69,6 @@
 #include <asm/nmi.h>
 #include <asm/io.h>
 #endif
-#ifdef CONFIG_SPARC
-#include <asm/setup.h>
-#endif
 #ifdef CONFIG_RT_MUTEXES
 #include <linux/rtmutex.h>
 #endif
@@ -1616,38 +1613,6 @@ static const struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-#ifdef CONFIG_SPARC
-	{
-		.procname	= "reboot-cmd",
-		.data		= reboot_command,
-		.maxlen		= 256,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
-	{
-		.procname	= "stop-a",
-		.data		= &stop_a_enabled,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "scons-poweroff",
-		.data		= &scons_pwroff,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
-#ifdef CONFIG_SPARC64
-	{
-		.procname	= "tsb-ratio",
-		.data		= &sysctl_tsb_ratio,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #ifdef CONFIG_PARISC
 	{
 		.procname	= "soft-power",

-- 
2.44.2



