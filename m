Return-Path: <linux-fsdevel+bounces-48590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C04AB140D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37A69829E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295AF292093;
	Fri,  9 May 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC4gZAQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB4290DA4;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=qr9Qsy5dzoXoG6B6kyybgdsXpB4E0yuJYM2z3VCO7O/TbVKiz0j6Fh63Iq4uFylsoiAoe5/CYU/1e6yZbnX3jh28V12BgrfixM9pO8Nx4suaf96bNCzvY82HpFHczb4EumlAZtf8HzE5rYqZp3Y5L0kzqFs1LlwvjHQ+wwS9bjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=GOjBhs9Ib0MUGQiJvmUAWG/9445JnpsIsFkQfqoyx1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rqj+VZ9aO57Bc+AT8uW/vfhhJ9NZ9vDDZdaQ8cmfI09qxJyA6u0wCK0jq8KDbRXAQ/YASe0bB3Gkq0REWoDdDVpWPXoLQEgbop/730wfUBkr41nJUme/f0YKewYq1h6ek4WXti3maS7FqCLJl/Rqi7NghKmaIoSv9R17sqYNZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC4gZAQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D37EAC4AF0C;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795305;
	bh=GOjBhs9Ib0MUGQiJvmUAWG/9445JnpsIsFkQfqoyx1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HC4gZAQShIHAHu307mqxvEK8mAnN8Vv63k3tMZ2cwycpJwIEFpTfyFyxcAPGJE2HK
	 8yiVGp0cZGkA8bOWargqzwe5t+erz/ixFfzTsS9x9pVuOktbwPNI2mXAd8jAOGZYFe
	 i5Mr0WEkKhjhW7/Ae29ajrcx25uEjm5KqtTkaKbbjViPF6QLmYmlq2PRNKobbpASeb
	 xDPkN1D33Ab04nDMvSh649jyInBCBFdD9DFE7h7UnBrM5BCF0TE5tGwu0bOVuty8UQ
	 QR3E/52JdkeVxJhg/9Q0qpWgQasvN13SwZr1vn0m08XD8hjsPRb3vffWdm3xZngpoy
	 3MucbEhkc/crA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFCC3ABCD;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:07 +0200
Subject: [PATCH 03/12] rcu: Move rcu_stall related sysctls into
 rcu/tree_stall.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-3-d0ad83f5f4c3@kernel.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3493;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=GOjBhs9Ib0MUGQiJvmUAWG/9445JnpsIsFkQfqoyx1M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+yIcQI+tvF5Nf2VvFXZdiynCbCQ6sUxEe
 0XfrKJsz2Y0mokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfsiAAoJELqXzVK3
 lkFP8AML/RLD37zpvtcqTs+AdQPaL/oilhjcYTEBWeV8O06muca2S+v/BCsYCHrWuQ6fuJwa6/L
 kNbBLnGE+/FLg4WqWCSxa9qYc1k6W31LyVk59M9YYpqwr65nWtTVxh+/rW3vNW4mIkmUmVMI85r
 JlmwBQps6LBgQvg9L2r1wpbIDmLQIBSaAu4Y4eLl4hIm7PFgSEY1LTbb3augTLNmTa0Tf6ZdfxO
 ViMZAvqBzzfRBdv9SwhA88E33eptU37Nx8MnxQNMm5NXfA2iJGb/NsQLx5DPDVQtjKl3WO+Jygx
 p64kuZlSl/FL0HLbSl4x1jvWNjeU5tZLuQMc3qgTZSVVYN9M8o3OtF9Vlm/rO38Gw+WwnSUQGrC
 mf0gFT1fa+Ba/CF5rJR9SBN3yRcg0+q6xbHDu0igMPFC1UZDN2bAu4XfPlagJH2dZKiiCl8z4np
 oWou1P5hkekOj6omNQ3SYmiTLPHkF9KQFZwP6rJU9a64iDjk2AU0ibgezMgzA9eystZgCvVX+C4
 HE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move sysctl_panic_on_rcu_stall and sysctl_max_rcu_stall_to_panic into
the kernel/rcu subdirectory. Make these static in tree_stall.h and
removed them as extern from panic.h as their scope is now confined into
one file.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/panic.h   |  2 --
 kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++++++--
 kernel/sysctl.c         | 20 --------------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 2494d51707ef422dfe191e484c0676e428a2de09..33ecead16b7c1af46aac07fb10b88beed5074b18 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -27,8 +27,6 @@ extern int panic_on_warn;
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
 
-extern int sysctl_panic_on_rcu_stall;
-extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 925fcdad5dea22cfc8b0648546b78870cee485a6..5a0009b7e30b5a057856a3544f841712625699ce 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -17,8 +17,37 @@
 // Controlling CPU stall warnings, including delay calculation.
 
 /* panic() on RCU Stall sysctl. */
-int sysctl_panic_on_rcu_stall __read_mostly;
-int sysctl_max_rcu_stall_to_panic __read_mostly;
+static int sysctl_panic_on_rcu_stall __read_mostly;
+static int sysctl_max_rcu_stall_to_panic __read_mostly;
+
+static const struct ctl_table rcu_stall_sysctl_table[] = {
+	{
+		.procname	= "panic_on_rcu_stall",
+		.data		= &sysctl_panic_on_rcu_stall,
+		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "max_rcu_stall_to_panic",
+		.data		= &sysctl_max_rcu_stall_to_panic,
+		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+};
+
+static int __init init_rcu_stall_sysctl(void)
+{
+	register_sysctl_init("kernel", rcu_stall_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_rcu_stall_sysctl);
 
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a22f35013da0d838ef421fc5d192f00d1e70fb0f..fd76f0e1d490940a67d72403d72d204ff13d888a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1706,26 +1706,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_TREE_RCU
-	{
-		.procname	= "panic_on_rcu_stall",
-		.data		= &sysctl_panic_on_rcu_stall,
-		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "max_rcu_stall_to_panic",
-		.data		= &sysctl_max_rcu_stall_to_panic,
-		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-#endif
 };
 
 int __init sysctl_init_bases(void)

-- 
2.47.2



