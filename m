Return-Path: <linux-fsdevel+bounces-43914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595ACA5FB85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E25188420A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AFC26A088;
	Thu, 13 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdoaeJP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D8268FDA;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882957; cv=none; b=ih6PwS7QQ0UFAI3ChJCRw1JYac69xCz6zQhT+UEL5fU8mbBoAUq9zxbis3EtzB+tkMrmR6X/ATrQkC23s+cDscRgNju1ZEyYEjX7IhJqTovizeg5zy+rXeMcOpqmoaFGDOu1wwROnIIFsSM1goACIe4CuWm76RJ7nVc/x3EpQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882957; c=relaxed/simple;
	bh=fhQlgeM7080CJWOaBZsIZyVJ5TKnwevZMcoSC2ybdZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aG5sPi4UV66fbASFeqc4fGxgFT5flDzs7PuoN9LAQa29C1WuZF7+6NwEE1+S+KO+oWyu3Go4LFxrh/iEls9ZD1tWFgpMS1XambgyvxIWwH6wTaYmMSjxZMj2PE/DoQvVA6LTr/+hpySd4Q89Q1Nmuqus5M3RoodKoAXNZ2qPt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdoaeJP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49AF6C4CEEB;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882957;
	bh=fhQlgeM7080CJWOaBZsIZyVJ5TKnwevZMcoSC2ybdZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mdoaeJP0nqabI+BeT8YIonLfd0f5QB5YbO+dreqyDa7iJVKxcwEuMVcIr746ViIYG
	 Ig7M0JFTw+X1tMsdk0ewpzDEB0CHz4bEF+Upic9KiIJnMa2gPjsdjiFwhDtOGkxx7w
	 n/AiZMKGlEdAtqctsZqwGSYVO8NpkDSlVxKq3Ghtr12o7OM7wEE7UL/aXzT3Mx/pr9
	 NwTdFhdZ5zsdalBQZvQzjMJ7BKXPD1lQ6aKDiRvWdxZUY9Z3ffl2ftw4ILcolIYMlh
	 iTM9SgSZnvWzXtufYsbnWVC+gSbNg+Xr8oLb3bLekZ6pEMR+aJ2M+pV/w24LvK+pYb
	 fudHRJME/gkNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D93C35FF4;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 13 Mar 2025 17:22:24 +0100
Subject: [PATCH v3 2/5] signal: Move signal ctl tables into signal.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-jag-mv_ctltables-v3-2-91f3bb434d27@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=fhQlgeM7080CJWOaBZsIZyVJ5TKnwevZMcoSC2ybdZQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfTBkkHnWszfEhy1e1lBTDKXa5AVaVkp4UmM
 Mf3INLp/NWLE4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn0wZJAAoJELqXzVK3
 lkFPeKgMAI2vXzhLEtEoUGaLnXiuYrqG/XYoXCD+SLcm00pOPFPqons9QovrJlAapqzvcqCQzFA
 HNlFrhEfHgB7xls52RQjy6TWlfE0J4Y0nTA6GzJUbfkSrwdeAGoF3U/w1Oit2JhyYvd23Lh9tE1
 jrlgCCI/EoDZPLNP8I+CFLudtZAK0E6jqnCnhShWMj+/77np2jK3vtemPnQfMVTuUsDKFPIURnk
 KyRDBivTYPucZ2xF8jaEo1dju1lURmq7e+zGY3HwBJCyB/3ANZnhxGN/ysxDcCK6gL+CmoOZLiF
 ufex5uNJkfxo3nVyrhjYWcU0ag6H+SRnScwf9si9hRfaedc1+BTyW643ctz6W9zlK8wMgNhWiTi
 Wzq7RUPf7ghdguR9pvBLk8KPiBe5rqFCTHIvWa3plO2D0PrBCVq1dXw0ev+ze+cccljLResrI2g
 ltEqwYGXWc/syYoM1LLVj/cZDDP63E0fX8ExFlA+PEbQGu0vvZQa/gtNwNctjtpwSyxCFG+NId6
 9o=
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



