Return-Path: <linux-fsdevel+bounces-41973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFBA397F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9907F7A5975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA13238D3C;
	Tue, 18 Feb 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg0r8JyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDD22D7B1;
	Tue, 18 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=frNBt1snvwtD7qCCUyKs58FEpKvaVjg0wYBedHhGNajJYxkF4vXA244IxQmw6meXsg91lzFcSNEVtGpdVHyB9KzJdof4+zd60sU4Srtok93CbAVh9x+PVIUQgePyRPYl7jAjlxvVNOhO3zOV/pnwa+a9oXIQ9WTnFeI/f6FY/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=bNOhzTe2prG7ApNrzEgxiz1fkHFIuGiO+IoM7HFyf6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1JQvZg5vUGYq8EtPa601mG+2IsAqiVj9qsFJFTbaBvHD5687HKx+zFyczTyNZ8a5ED0roakpivsP/fgJhSKr7yF7f/JoLSf5s4PYxo1EmtmSpJKGJ/iz8nKNDTEmT97/BbV+8elWuHHaLGYwW4W1WlEFJrBdYmHVsu31Vvevcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg0r8JyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDC74C4AF0B;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872605;
	bh=bNOhzTe2prG7ApNrzEgxiz1fkHFIuGiO+IoM7HFyf6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tg0r8JyGfalSHtuPxOPpDJOJd/eVr2t83fDrx8ZUQS/AcUBxpr+MEZDisVIhSqUA0
	 BLCJjHTRX13/9Wm+utObTLrcG9wYvanaPzmsHSvdE5kIKaWwYrRcXwPhW5+RRNKsIN
	 zAjbs2OuuiUBfg8NB+olJY6MkxyC6mkrpsw4mDi8pghzg362Sy9QSR7/S0jEU9JwJl
	 Fhct8cHfRFFiMeWxyY28IayLd2FUWpxQK0n/TgBZQ60JR2ixwnd0Bg0XCE5hxg99Kg
	 e4Qy1bRWa6HHn1C91PTFeY4clmfzPchKss9YKmtBZCKxMNBLolfBoLyaMykcKOKfF/
	 EFZ8TyXOobPrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F4C021AD;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 18 Feb 2025 10:56:18 +0100
Subject: [PATCH 2/8] signal: Move signal ctl tables into signal.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-jag-mv_ctltables-v1-2-cd3698ab8d29@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=bNOhzTe2prG7ApNrzEgxiz1fkHFIuGiO+IoM7HFyf6g=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVePspv5KFWYMyxxLrq5NdT/+kjWQWT00
 rb5ohuXmdhRRYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlXAAoJELqXzVK3
 lkFP/xwL/iWUKDAOOAgg2CCZDNJ/yTk7qhzst2m5RCQY9Y9zkZd8qKFneoSuZFOUv47OcPnifVs
 PRXUs74ZHqQKYph9Cc+Lxv1aQ/ur/PUH9bxmz2ZaXGaLF7WrOymkU8yQJf+YHZLE8RAxjeOL6rt
 cYouRwqv6R4TQUOt947+voVAO/nYSGPzQ6gce4vukbpBnEou2q05GRROklOEs7HtAuAKQ8LL9sz
 s9LunTmFGywtFwEXwfxl8tgrWi88kRV6TKTLhCCwwHVh5lW8g0Ee24SvTIDuvQqwYib7KBtXlyI
 J6XG8Puogwm2gxIEuR+whFOP9c9prA/d6sLn5ItTocmOUzF7oKb1a4HFtpoxjI7nNVNWye1z7LR
 AzxihVlvEG6A8lpIx7lxKdbaD7DOkbbSTLfARmcA9nl4C2cakCWzx8hI57bcJUrJmDRqMolX+qm
 LmCj5YMEOQfmswhrtpm6mEpxZElhKQ/QruoIC34NUUc5tQkBqW7VxMxIEX7kTXV63PjbIzceDX8
 I8=
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
index 875e97f6205a..347b74800f92 100644
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
index 7759b1ed7221..6514c13800a4 100644
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
2.44.2



