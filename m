Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67258712FF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbjEZWWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbjEZWWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 18:22:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D5BB;
        Fri, 26 May 2023 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7I+m1g7na/yjhxthJGIYbRam59qypHh9f0/DcF7s0Gw=; b=dTUKjzHilPPj4bODYepSmnAgwc
        w+I1BnJkTV6SLiZU1ESKgv3XJ/LpPQLmmg2i0wDMbTMVXOwuR3r6JPDkCIaaNtYDLfPRhYzZs/nvS
        UQIVNecH2dRYmp28N3EtL/kAILDyt78RGKD+sSMi+aljzmL1YF4zBY6kyBh13xgIQmNYrU8r70EXi
        uyJ/ku2pbhwvF5XZKjt8dSDHlAvO7F1TqOHEKw4uXgf2fesaLtoCtPHf2rF76DECaW2AW8tQmYNlQ
        JMzsAQpbwWkUmiFxDcwqFH9mR4ukBp6tla30VYj1dFy2mTiWi5w65dnfLYYw9AQTb46ZL4ik1mikq
        v2//tw0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2fp1-0047Un-2S;
        Fri, 26 May 2023 22:22:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        dave.hansen@intel.com, arnd@arndb.de, bp@alien8.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, christophe.jaillet@wanadoo.fr,
        kirill.shutemov@linux.intel.com, jroedel@suse.de
Cc:     j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 2/2] signal: move show_unhandled_signals sysctl to its own file
Date:   Fri, 26 May 2023 15:22:06 -0700
Message-Id: <20230526222207.982107-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526222207.982107-1-mcgrof@kernel.org>
References: <20230526222207.982107-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The show_unhandled_signals sysctl is the only sysctl for debug
left on kernel/sysctl.c. We've been moving the syctls out from
kernel/sysctl.c so to help avoid merge conflicts as the shared
array gets out of hand.

This change incurs simplifies sysctl registration by localizing
it where it should go for a penalty in size of increasing the
kernel by 23 bytes, we accept this given recent cleanups have
actually already saved us 1465 bytes in the prior commits.

./scripts/bloat-o-meter vmlinux.3-remove-dev-table vmlinux.4-remove-debug-table
add/remove: 3/1 grow/shrink: 0/1 up/down: 177/-154 (23)
Function                                     old     new   delta
signal_debug_table                             -     128    +128
init_signal_sysctls                            -      33     +33
__pfx_init_signal_sysctls                      -      16     +16
sysctl_init_bases                             85      59     -26
debug_table                                  128       -    -128
Total: Before=21256967, After=21256990, chg +0.00%

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/signal.c | 23 +++++++++++++++++++++++
 kernel/sysctl.c | 14 --------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..5ba4150c01a7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -45,6 +45,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cgroup.h>
 #include <linux/audit.h>
+#include <linux/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -4771,6 +4772,28 @@ static inline void siginfo_buildtime_checks(void)
 #endif
 }
 
+#if defined(CONFIG_SYSCTL)
+static struct ctl_table signal_debug_table[] = {
+#ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
+	{
+		.procname	= "exception-trace",
+		.data		= &show_unhandled_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+#endif
+	{ }
+};
+
+static int __init init_signal_sysctls(void)
+{
+	register_sysctl_init("debug", signal_debug_table);
+	return 0;
+}
+early_initcall(init_signal_sysctls);
+#endif /* CONFIG_SYSCTL */
+
 void __init signals_init(void)
 {
 	siginfo_buildtime_checks();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a7fdb828afb6..43240955dcad 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2331,24 +2331,10 @@ static struct ctl_table vm_table[] = {
 	{ }
 };
 
-static struct ctl_table debug_table[] = {
-#ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
-	{
-		.procname	= "exception-trace",
-		.data		= &show_unhandled_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-#endif
-	{ }
-};
-
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
 	register_sysctl_init("vm", vm_table);
-	register_sysctl_init("debug", debug_table);
 
 	return 0;
 }
-- 
2.39.2

