Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C57A45D0F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352521AbhKXXSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245001AbhKXXSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0EC061574;
        Wed, 24 Nov 2021 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EmbnGF5E3X7PPKzRoMxBObQ25iaJW1VVEtk3YOxE710=; b=X0Ddn93Ab27SsMBYonlR3fLKSq
        akkQsm9qTnY6+XntvFQHnMgMvkPS7JOq0ixdxuijuSgYIZ2/AirEdectYv8xW8aUrHLqeCRGqo3fl
        o6qquwVdwE/fBU07WdqPC6a7vhKArlQAbMtxCuMW7O1eHZPwQne1eY25CImLk2S3VCGi529/gYO4Y
        ycidYCNtvojzf7lWWE5j9v1V2POFEyk3R9dkZNoTNT1iyG0ltSOZCI+kE5uuXa45FgHt8QNSqR1m7
        YQ0E6IqKJsw2XudW3Kte/KhcfvNOwHi6QMQbwYLyVwzzX+6xgAlnM6xlwQqpwwv2aD8XZddc5SZh5
        rs/F2szg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063zH-Rl; Wed, 24 Nov 2021 23:14:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] stackleak: move stack_erasing sysctl to stackleak.c
Date:   Wed, 24 Nov 2021 15:14:34 -0800
Message-Id: <20211124231435.1445213-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move the stack_erasing sysctl from kernel/sysctl.c to
kernel/stackleak.c and use register_sysctl() to register the
sysctl interface.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: commit log update]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/stackleak.h |  5 -----
 kernel/stackleak.c        | 26 ++++++++++++++++++++++++--
 kernel/sysctl.c           | 14 --------------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index a59db2f08e76..ccaab2043fcd 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -23,11 +23,6 @@ static inline void stackleak_task_init(struct task_struct *t)
 # endif
 }
 
-#ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
-int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void *buffer, size_t *lenp, loff_t *ppos);
-#endif
-
 #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
 static inline void stackleak_task_init(struct task_struct *t) { }
 #endif
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ce161a8e8d97..66b8af394e58 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -16,11 +16,13 @@
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/jump_label.h>
 #include <linux/sysctl.h>
+#include <linux/init.h>
 
 static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 
-int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void *buffer, size_t *lenp, loff_t *ppos)
+#ifdef CONFIG_SYSCTL
+static int stack_erasing_sysctl(struct ctl_table *table, int write,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
@@ -42,6 +44,26 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
 					state ? "enabled" : "disabled");
 	return ret;
 }
+static struct ctl_table stackleak_sysctls[] = {
+	{
+		.procname	= "stack_erasing",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= stack_erasing_sysctl,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init stackleak_sysctls_init(void)
+{
+	register_sysctl_init("kernel", stackleak_sysctls);
+	return 0;
+}
+late_initcall(stackleak_sysctls_init);
+#endif /* CONFIG_SYSCTL */
 
 #define skip_erasing()	static_branch_unlikely(&stack_erasing_bypass)
 #else
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a4bda4a11ea8..5812d76ecee1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -94,9 +94,6 @@
 #if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_LOCK_STAT)
 #include <linux/lockdep.h>
 #endif
-#ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
-#include <linux/stackleak.h>
-#endif
 
 #if defined(CONFIG_SYSCTL)
 
@@ -2441,17 +2438,6 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_INT_MAX,
 	},
-#endif
-#ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
-	{
-		.procname	= "stack_erasing",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0600,
-		.proc_handler	= stack_erasing_sysctl,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
 #endif
 	{ }
 };
-- 
2.33.0

