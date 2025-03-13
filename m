Return-Path: <linux-fsdevel+bounces-43911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D430A5FB6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F93E165FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820FA26A084;
	Thu, 13 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+rPjJfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3121268FC9;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882957; cv=none; b=fCU+uoQDyCZCNFn2ePoJfJ88v4ISjo2eTQyeNMhzMSfdqzjSqbSl+HicyKXHXLZt2T8fseg8yqMEiQhxRJmzQ5rx/32ZNL815+tqNqRqfzLKGzcPQ4V4yB8HJUfvmnElepfQXP0bHFmP/z9MHgjODuQV3nJxeBVHsqlR4IMxUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882957; c=relaxed/simple;
	bh=99SvQXLjoPiWd0/gxkEdf3AsdJ/IenQsyJp3SptYBS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSD61TXVQAaLxHfc72XiF2DTfzvP5Sk7U8367KINnXjYgFQm2SCzEkdhmFH6eeLL5ncQT1KI9KqQ6nmWLell5OO58fFirNM4hZA2DdGZgc2A1MgZR2TrrpRkg7cP9izZHYMeAqs6b5UlYr7qmNqZHj5YsjBH5M+cNvbKCQ0HhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+rPjJfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35A2AC4CEEA;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882957;
	bh=99SvQXLjoPiWd0/gxkEdf3AsdJ/IenQsyJp3SptYBS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e+rPjJfNZRP3RNYfOziJX8ZIx9x/X9P0zrRIzSkcTA72NDNCfNlk2Y65A2/+uBXJK
	 QI1ScIbFu6G6GqXrWEEB7ncokaCHVn8ffBwUB2jmojmKTL93/OJmDf1BWXNsmgxqYn
	 aKUZsP0GuIhYCPasm2p8E53X9XZiKoPb6YQwCFWWtMeSwQfKFzg/CfmeuRQbxv2m3C
	 VMxIHkRkX17h+j3+TM4ZvdpbbQMCIhpyM2+M3kB/O6gN5/iVwwZK3yhRbxvStUi989
	 DGATr6F5HAfk+bb04JeaZ2gwYyjwps6qPxJbKPALN2TiXuSxHd43CF1YXovO4EG/Hp
	 PJmYTZOoH4Gkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D1C282DE;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 13 Mar 2025 17:22:23 +0100
Subject: [PATCH v3 1/5] panic: Move panic ctl tables into panic.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-jag-mv_ctltables-v3-1-91f3bb434d27@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3223;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=99SvQXLjoPiWd0/gxkEdf3AsdJ/IenQsyJp3SptYBS0=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfTBki52Ay4X1MNDbXJN+xBjgEAqwuoqLgsZ
 wucLRs1EkUuOYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn0wZIAAoJELqXzVK3
 lkFPE3gL/iS8YOsZuV5Wwt/XmvzPRNawgQ99iH2WAmO2xsfejsM8ubgObFTFQzfjqJ4PgmE0hFb
 i/Z8oF/qZ7ErQqxqREl1zbfIoDSewcIkbRKkjZnbWCIC1nnTznkg4yDBCItp2iUL0e1C+d/D9RC
 r58Qom/3jMWPJnz3+4s3EdxsmhU5fuKMUW5L7Taxd5kQ+jyaCGmEcmn2Ur/sV2odOpJP4dGB8Rn
 mu7natQ5G4AF6q/+Ks3dEGgvpjF+u1bmGK0eprBlSuYVkNZqBKPaCPZg9yK18VpkJiyJp3b4WEF
 AitFdryDXwRIqcGeh7wFX18xHBNtTttpC41wIXRifiArYummUuJSiAxf4oXWHgs/v8N02eVWgdr
 rXpdPq8l7bzr8QJXy2zy9LpqM5RTJ9t2Ba7qoIbCIG5ylAPIOeiLOusDRhAXphGrA7ff6WePjSN
 8wELoqBr/+7bbdekdTGXZynwxAACHqhphUDy30SuxOICyl8gSrhozHAuqmqXhnJp4RgsV/JoXj6
 WM=
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
index d8635d5cecb2505da1c08a4f70814e9b87ac3b37..f9bf88f4c26216cd5a93754378a36ea1e841472a 100644
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
index cb57da499ebb1216cefb3705694ab62028fee03e..7759b1ed7221f588f49ec3d81b19aeb4d2fdf2f7 100644
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
2.47.2



