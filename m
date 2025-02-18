Return-Path: <linux-fsdevel+bounces-41974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24CA397D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB16D1893343
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF7523908B;
	Tue, 18 Feb 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjhuPBGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4A23236C;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=dxNhqyVPp47OLezlKkmTjLOeCeG+RR/jC5mVojum2yCuWELc6VttC4ZIX2TPgVpfDv2ONLIQtyVfzBs3r8IJxuBPiFlNznSJUyxH+JOEZQ0bzj2lh/w9bGXzrciBG/MiqnLPdaLRPd5I8iVuHkRHV4Mkbd5zsr/BYDBQTr9qWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=/zlS+ERKpHQA2aoOnRoLZTEBI+gUJf2tLAkgKfYYCdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PS13FPmdMjYKhyh+zA334dFh80jKEfy4u13O1o5+m32mDNdPxysyqwpczKmL4e2Jn7R/s8BYUJjnthuPOpekSh7ZsaFHAQlx2VV1h6bx/2kCn/Qc5nNJk0X6DYyhczndRt0/WhTJgXq9SsHFSENCeIN2yKfnDQeccmPJ4pOG4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjhuPBGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5518C4CEF4;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872606;
	bh=/zlS+ERKpHQA2aoOnRoLZTEBI+gUJf2tLAkgKfYYCdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DjhuPBGJxNIYqaSDxD0vmLIFjXsBaypNsQ2fs4F9xvtVB+3QmPkXkwwgOWa+L2QFH
	 gu987r3eZifQRDv6y2S1D3CFJx517YX2B/eiZhjmc1BGm4io6DD9BksFr5Zb8vUNbl
	 bQj3reOJ75do/9cX5Io0fGNyY0T0EJnnTRg5Xd7QKdfRl7FQr9v2gIl4wllvax3nSu
	 BwK2C6/5va4x5VZNZgOhbC+kufBaZYhKE+9thHC6i3wGA7il8hUCwcSREh3fGd+iiL
	 v5beL8Gi1TGU1GHn+As49+1wdDKCcngOe0RQsccWxqbsSPQHJd5dEFuHAM1Wi+MToO
	 PnooGR1T2OcZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7FC021AE;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:20 +0100
Subject: [PATCH 4/8] stack_tracer: move sysctl registration to
 kernel/trace/trace.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-4-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=/zlS+ERKpHQA2aoOnRoLZTEBI+gUJf2tLAkgKfYYCdU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVgdnOsE2LBo8sB/PcaBKZaaLibVcy9tY
 2cjMrYv0U+1SokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlYAAoJELqXzVK3
 lkFPbOML/0BkZif9lQxXAdndl9X7PkO/IgNY0ckRwVnf7HmurT96PjRSjAl0K33it31UMHgqcww
 TMbcoOexxyIjtASGitj1+XNcHLZQ3Sv+/hr4mMkM7aON5Bk0oorTMMuLax3QcBlwb1vWB/z2oDE
 DMMF+n2jmRDwJzUBj3HXxfvdEZ0YaY+SQcsjUacWIi0e8cVVYrDOCZdEnRvuyRvyQ9qsVzh0Goz
 9rm9S0sPxFmy+KffZNDwhtu7QRiqAsdwMf01NQ5g66X8b411lmdcL3vmkpgTGIihRRvhenvvmEI
 ZKuF75x54ZN4vZBQXSmrSfPlf70tzJfEUBP/JPVZzmxVOMSR4dxYdnk/U1oyUt2ReG5f1tLsWJa
 6Sf61IHCPYcer+yZHZ6xXIZAIMsWOBPWTTlfhhcB2QxSudCyzr87kIOROJFjn+pbmC/KAwu/zLl
 Mx/JbvEHQC6B3qjQaQyxUxyx/gdDc+Rqt92K0r4bXnKeVj4TXZ7bPZld7So6BQBDOCV0Bfjv8C6
 z8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Squash with ftrace:
Move stac_tracer_enabled into trace_sysctl_table while keeping the
CONFIG_STACK_TRACER ifdef. This is part of a greater effort to move ctl
tables into their respective subsystems which will reduce the merge
conflicts in kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c      | 10 ----------
 kernel/trace/trace.c |  9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index baa250e223a2..dc3747cc72d4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -68,7 +68,6 @@
 
 #ifdef CONFIG_X86
 #include <asm/nmi.h>
-#include <asm/stacktrace.h>
 #include <asm/io.h>
 #endif
 #ifdef CONFIG_SPARC
@@ -1674,15 +1673,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_STACK_TRACER
-	{
-		.procname	= "stack_tracer_enabled",
-		.data		= &stack_tracer_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= stack_trace_sysctl,
-	},
-#endif
 #ifdef CONFIG_MODULES
 	{
 		.procname	= "modprobe",
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abfc0e56173b..17b449f9e330 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -166,6 +166,15 @@ static const struct ctl_table trace_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= tracepoint_printk_sysctl,
 	},
+#ifdef CONFIG_STACK_TRACER
+	{
+		.procname	= "stack_tracer_enabled",
+		.data		= &stack_tracer_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= stack_trace_sysctl,
+	},
+#endif
 };
 
 static int __init init_trace_sysctls(void)

-- 
2.44.2



