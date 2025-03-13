Return-Path: <linux-fsdevel+bounces-43915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE54A5FBAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85712882DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80AA26A097;
	Thu, 13 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyX2+cwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC5268FDB;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882957; cv=none; b=VEm1ZFj7D5uiETm3fovC+9YYtLNMwZzZm0pdprpNK86r7iZm7xXhxqPuXxpWYQyb5uu5PpWS37+eqzT3TA1vNjs+x+/64tzZFk4vpNZc3QQIJZbb64yyf2NJHou6g+sNWJpm/Eroa4gGEGltvDhFITCjO+FNs12lmf295pH/y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882957; c=relaxed/simple;
	bh=MfSHnyZm0yVz16E71tES1BWKJpkHw6ZtGzY9orpm0ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIwtqk2IQpO+1uAwcJGxTQTtlzW6PhyxrfA0+UpoxYHFLfWeLBqbsd2HoCEMZfjvThKCypvLRJN+OnNSMy6J01hDuLBUxZD3DKBp6hdXm2vOAf0wtCMDUZvVLPWX0Fg0u3qjtw1IE4Xj5hirWU0G+jcPpOqVLbJS5AUAeaqnzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyX2+cwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60965C4CEF3;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882957;
	bh=MfSHnyZm0yVz16E71tES1BWKJpkHw6ZtGzY9orpm0ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyX2+cwmhKdvGCW6WrgOQ7gtPk4B/c733iJojDtU9rMtjtp+I2CdtG9zaAPCFWomz
	 89BVpPjf/ly8+cb4OzqlLiQZ9ok85vJf6wblHWDZDc9Jn3LkMeuBuGsuX+eqsA8WIU
	 kP9AW7vNOslVwRTU4+4CLvduFp/QQsz2O5zefdbjXjMgeByx7Kv/NZ+y+gO/KIohNY
	 9eo0vLSO3E/YKN3i4Gl73vngZy+nQQ5DdjZ7H/KhjvthO4zKaoSsUi+T/IUqRec7TV
	 gEB8+2zPc6HaySnBBjZu6iMtLwJXvj9NLTB96WI4zQJx+Vtdxsjgo2pP0A+TfZctCO
	 06QoS8aAHBp+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A90C282DE;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 13 Mar 2025 17:22:26 +0100
Subject: [PATCH v3 4/5] stack_tracer: move sysctl registration to
 kernel/trace/trace_stack.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-jag-mv_ctltables-v3-4-91f3bb434d27@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=MfSHnyZm0yVz16E71tES1BWKJpkHw6ZtGzY9orpm0ks=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfTBkoivtPbtMABnBvE2KmMz4XYD8Cn2nTWJ
 z4m5ek2+gN2mIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn0wZKAAoJELqXzVK3
 lkFPi2AMAIo1WRv089+BmxGptd/TJePHQVLa7cdoYx+DnuWWEF5qUWkDia4wlCQ1t1NxbD2UnVH
 zE4JGfXONaiyWyoRVHHg8/VGZsPjrsXL/XQvt8sohtDZeKTiHoafh9Itd9zobXxJU6AcRoa5W36
 mEgSjO4nd2+yt6Q2b/5WJVT6/1CpDVYKK93dYuz4kMXY6CB/NvoBM16rhuLoK6xdsYQVaUZ7SWt
 J9R70xYY2E9tLBre+0hMMDj2iCHI6WxJJ0EQI6oP0kk7pLQBYWclmTVwvbp5emqXmtCq2ASLHZh
 Nzr5WHhJOdGKuH6+vOCubjmX8qCKRQ65HhcViojv4DBx+vMFlsQkp1rv8/PHk2H1kKlrlz6nxLu
 iWN7yTNr20CubFYKWcjxemnBI2Ai2kjxvEKh9GgZbjeXCQh9HvIZKxVVzZW0nQJO0UEBOjKJzux
 5iv9+vQ3GKuXOGlCEfXOWAmwXMAktwC5mpYYQGv3ly5K91gW4AO564EaR5X2j/Gya4t3Z6g8227
 RU=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move stack_tracer_enabled into trace_stack_sysctl_table. This is part of
a greater effort to move ctl tables into their respective subsystems
which will reduce the merge conflicts in kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/ftrace.h     |  2 --
 kernel/sysctl.c            | 10 ----------
 kernel/trace/trace_stack.c | 22 +++++++++++++++++++++-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 59774513ae456a5cc7c3bfe7f93a2189c0e3706e..95851a6fb9429346e279739be0045827f486cbad 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -569,8 +569,6 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 
 #ifdef CONFIG_STACK_TRACER
 
-extern int stack_tracer_enabled;
-
 int stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
 		       size_t *lenp, loff_t *ppos);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index baa250e223a26bafc39cb7a7d7635b4f7f5dcf56..dc3747cc72d470662879e4f2b7f2651505b7ca90 100644
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
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 14c6f272c4d8a382070d45e1cf0ee97db38831c9..e34223c8065de544e603440827bcaa76e1894df2 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -32,7 +32,7 @@ static arch_spinlock_t stack_trace_max_lock =
 DEFINE_PER_CPU(int, disable_stack_tracer);
 static DEFINE_MUTEX(stack_sysctl_mutex);
 
-int stack_tracer_enabled;
+static int stack_tracer_enabled;
 
 static void print_max_stack(void)
 {
@@ -578,3 +578,23 @@ static __init int stack_trace_init(void)
 }
 
 device_initcall(stack_trace_init);
+
+
+static const struct ctl_table trace_stack_sysctl_table[] = {
+	{
+		.procname	= "stack_tracer_enabled",
+		.data		= &stack_tracer_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= stack_trace_sysctl,
+	},
+};
+
+static int __init init_trace_stack_sysctls(void)
+{
+	register_sysctl_init("kernel", trace_stack_sysctl_table);
+	return 0;
+}
+subsys_initcall(init_trace_stack_sysctls);
+
+

-- 
2.47.2



