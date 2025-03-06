Return-Path: <linux-fsdevel+bounces-43336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9AA54978
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7CB1745F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778B3212B2D;
	Thu,  6 Mar 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSWvHOKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C2210F58;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260651; cv=none; b=kppkVoBSZbEilROks06RuBYkTct37ZbZomhOOesLDAa+G+1MOuTvwzGX9j3nH6ElcZ7uy6xNebIannW6ns1gql9kzAHJ87iZw4SI/6EqgSWdY4UjupGYPaZuCfKIeTQBSZLILLcRGxPgWna0j7m/ddSO45ujjldhNtVCTy6+M7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260651; c=relaxed/simple;
	bh=fhQlgeM7080CJWOaBZsIZyVJ5TKnwevZMcoSC2ybdZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9KFsWTvkGPf5+nRSSPNjQK0K/6wC3ayBoGEu7qgh2aLiwcN9IlHsEB/rZK6VRZ6aTBlhPDH3x7Nlgov8TrhIl9VQ9BI6BfTKbznU263vi2VoKrOq7xf98yLOHH1b3k03vrPAznkDEb7eEsf7cJDZucIHJkd2sGO/uyknv6AdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSWvHOKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CF3CC19421;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260650;
	bh=fhQlgeM7080CJWOaBZsIZyVJ5TKnwevZMcoSC2ybdZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RSWvHOKkqbyq+edYsV7k2bVxXSHxzsUYkV91kPnuucULito4vazQHLKKwxWhq+Z8i
	 vRsSdohj6f8tEgGR6PgBI1mr5vcZqpuzHATgtaCTLzja6B4yNQc+jCrAcPdtx/3G1s
	 pyQx0hXRugt2/x9T6XF0ukiGs9PCE3Ng/unfsHjhCd6aiHbL5fVFLciqJQvVGA3Ntb
	 i2KclE3tpBK/JGiltn5ZES3CWmHxnmXluJPG4p4NIHghy3DR9USYk798XJfTRJWHAR
	 vYoYzX8YoLHVRQpO5IQEgR/XwPNOfnsCZ2ynFrXqo3G4k3dH64zcu3WWtAgQyMsHhl
	 0sSU16wbRZd+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47066C28B23;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 06 Mar 2025 12:29:42 +0100
Subject: [PATCH v2 2/6] signal: Move signal ctl tables into signal.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-jag-mv_ctltables-v2-2-71b243c8d3f8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=fhQlgeM7080CJWOaBZsIZyVJ5TKnwevZMcoSC2ybdZQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfJh2UTXEzu0WgygPeZiXETdqZYBW4AhI+L2
 wex0xcjKUNMuIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnyYdlAAoJELqXzVK3
 lkFPhP0L/0CjZzf6n8ONSUqEp98+SyqFfv+Rse0jy35dqF9Kk6l1XXbkVnLlCBZJAaM5tbbtAkU
 h0NjWh+3SUDMDpUYx2Vmmh/ORpl1HKfpyqCyTCfIouOSFccDQUzaUuccHWwEpV3wEtCFpOLBaQS
 ccuRo7oGzM5b2pqxxz/sk2WlUSavAv7N+YVmF7OKol3J0QyXmeFSAI/lrxCjHHph8NHPGYPeVuC
 drEzm9bJ6tgCuqQZc1Or/KfQoVGdWvmNmxFddMeYcmRhzk4i6R++UZfEHQ0EIUCuzdepJhaSoqa
 xvWc2xhhLAUm7U42cSHHTlHSQzI7MGrBZJZMiDpc+jsKvILWsLkQPAiQkWF0/G1cFJpgV32SAkg
 a741Q8IABMDSRXB03nLZfk6dJ5G1tk3bXgdQHU8Ue2ALJupaqHBNVGCGHBalGT3Noed75KJXQjp
 GB3dtJaX8LPD7XkDrJ/JfR+lYTIOEU9eruRs8C632wFVnrpMTPZtGtboF/oKDkPmAfkV6AhXiY4
 W4=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move print-fatal-signals into its own const ctl table array in
kernel/signal.c. This is part of a greater effort to move ctl tables
into their respective subsystems which will reduce the merge conflicts
in kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/signal.c | 11 +++++++++++
 kernel/sysctl.c |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 875e97f6205a2c9daecf5bece5d53ed09667f747..347b74800f927f70a1912457f96e833cd03c642d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4962,9 +4962,20 @@ static const struct ctl_table signal_debug_table[] = {
 #endif
 };
 
+static const struct ctl_table signal_table[] = {
+	{
+		.procname	= "print-fatal-signals",
+		.data		= &print_fatal_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+};
+
 static int __init init_signal_sysctls(void)
 {
 	register_sysctl_init("debug", signal_debug_table);
+	register_sysctl_init("kernel", signal_table);
 	return 0;
 }
 early_initcall(init_signal_sysctls);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7759b1ed7221f588f49ec3d81b19aeb4d2fdf2f7..6514c13800a453dd970ce60040ca8a791f831e17 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
-#include <linux/signal.h>
 #include <linux/printk.h>
 #include <linux/proc_fs.h>
 #include <linux/security.h>
@@ -1626,13 +1625,6 @@ static const struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-	{
-		.procname	= "print-fatal-signals",
-		.data		= &print_fatal_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 #ifdef CONFIG_SPARC
 	{
 		.procname	= "reboot-cmd",

-- 
2.47.2



