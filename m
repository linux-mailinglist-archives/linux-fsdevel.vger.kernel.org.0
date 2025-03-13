Return-Path: <linux-fsdevel+bounces-43916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF4A5FB77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FA1169834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9376626A0E4;
	Thu, 13 Mar 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCji8syH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8364269839;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882958; cv=none; b=AyFntcLd5KX7pgY/gRLn1AvUjNvZHykFWBNMehForoFOfmjg+PkB+Y0vG9SnL77Q9Fn3hy1e6atv36G4hAoYFqAw51+ERCG2o2kvMRSLAqlFYzCapxvSv9vbtR8yzdioKgqrZjY3rN3EQ1cG6yqHj7wWHC/19xQF4KrJhxzYHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882958; c=relaxed/simple;
	bh=hkSbq8mw9Uv98PWKXr8NFUOiogiYljqa0LH7OwMpcTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfQAqjNP0VwM/iC0gfi8CNVMz85KMaRDEDLBLqWTiiGwFjbgQEbmdeLOPNPVKl2XoeCk7q1dEg+9viyGxAkm9izIb4sNtF0+RohRgA8AEdOAwvcc+MmfcXvVoYmn/pyXzuSgpZNNgnpngcdc+Brt/uPcUORlNQV0ZRC00kQvekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCji8syH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70FE6C4CEF5;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882957;
	bh=hkSbq8mw9Uv98PWKXr8NFUOiogiYljqa0LH7OwMpcTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pCji8syHUUiP/wNAh7ynqqKZAytlDyNabA4+4ZatFkYGeoZDhJUOjYA7yO3csvZa2
	 bL9uwd4EzajibFO43DqTSESeFZah3pcG+Klqpng/nFGpP5jRH1aZ7k1LRlk9OrL9ou
	 N6hvzY8ZIhHFs2mJxxst8iBhtW3aYHZPkXI0fhwqiIT/6b5a9P1CCMppA8gCsNbLfL
	 plWbB7onqnlLOF/QHJRdxO+dvtCmNYZarhfs+P1Nd2INpIR+VTsjEgLdyGphbcWfvd
	 hbGR5hQgbdGCIocbtCfQGSYMUtQNK3OB711U1lWv1bKNDkfBC93djrgMDiETwED6PW
	 teh59i6U8K+kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A01C35FF4;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 13 Mar 2025 17:22:27 +0100
Subject: [PATCH v3 5/5] sparc: mv sparc sysctls into their own file under
 arch/sparc/kernel
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-jag-mv_ctltables-v3-5-91f3bb434d27@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3848;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=hkSbq8mw9Uv98PWKXr8NFUOiogiYljqa0LH7OwMpcTY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfTBkv27n1nFXAthabFOHvM68bJ7QLsY2p7Z
 2GlQp3/K7or0YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn0wZLAAoJELqXzVK3
 lkFPUhwL/2L01Xy0xGbZwBGfwHQRvlt1wWnyv/infvtLOHz9wdgdnBlNC3pvAkzHy4Ol0Ms43D0
 bKmhqK3wIpxatgwTtisllTMk3HbaZ88S+ANApw2u7Max2h44bNgZGBRGdA1IWUnRyUmK+xux3R4
 PsRFA1VTpEVHX3PFQBlT8NgMv++7caoGXPdoev7W2LDE+oiLUnDcwWZrf8pOp6ZJIO3vzYCQ6e2
 B0KgnnBRroxlfKrFB6vpo9Pvt0p9o89lpy/XvIWUGmf0BrqZxkkq2nHiWlD39S0pEHtmHtByVj1
 f94j+LpSpdkghRicozTt+wBq3cT1Lr5ayKbErr0f7ThqiZlDEcG8L3tM6IhitN3aJ/1dcxspu1W
 pqp0y2jxQthhRHlRyeKtqI7w+jHeDN58x8hBeOL2KYV8Tj8uEGDkiSigndBHygE9Wvw6UnHeE8s
 XOkGBmRH+gP4lgJkbPvj/Yg39jbL+P/+lrXk4EE++CPW9CxgiCZYNvZIDsijNyolW5oH2DgAAW6
 No=
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
index 58ea4ef9b622bd18f2160b34762c69b48f3de8c6..3453f330e363cffe430806cd00a32b06202088b3 100644
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
index 0000000000000000000000000000000000000000..4975867d9001b63b25770334116f2038a561c28c
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
index dc3747cc72d470662879e4f2b7f2651505b7ca90..0dc41eea1dbd34396c323118cfd0e3133c6993a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -70,9 +70,6 @@
 #include <asm/nmi.h>
 #include <asm/io.h>
 #endif
-#ifdef CONFIG_SPARC
-#include <asm/setup.h>
-#endif
 #ifdef CONFIG_RT_MUTEXES
 #include <linux/rtmutex.h>
 #endif
@@ -1623,38 +1620,6 @@ static const struct ctl_table kern_table[] = {
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
2.47.2



