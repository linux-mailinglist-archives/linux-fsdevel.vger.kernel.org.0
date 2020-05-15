Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4933F1D44AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 06:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOEeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 00:34:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbgEOEeA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 00:34:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1FD342BBD8552EB7953C;
        Fri, 15 May 2020 12:33:58 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 12:33:47 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH 2/4] proc/sysctl: add shared variables -1
Date:   Fri, 15 May 2020 12:33:42 +0800
Message-ID: <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
used in both sysctl_writes_strict and hung_task_warnings.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/proc/proc_sysctl.c     | 2 +-
 include/linux/sysctl.h    | 1 +
 kernel/hung_task_sysctl.c | 3 +--
 kernel/sysctl.c           | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d45..acae1fa 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -23,7 +23,7 @@
 static const struct inode_operations proc_sys_dir_operations;
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, INT_MAX };
+const int sysctl_vals[] = { 0, 1, INT_MAX, -1 };
 EXPORT_SYMBOL(sysctl_vals);
 
 /* Support for permanently empty directories */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa844..6d741d6 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -41,6 +41,7 @@
 #define SYSCTL_ZERO	((void *)&sysctl_vals[0])
 #define SYSCTL_ONE	((void *)&sysctl_vals[1])
 #define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
+#define SYSCTL_NEG_ONE	((void *)&sysctl_vals[3])
 
 extern const int sysctl_vals[];
 
diff --git a/kernel/hung_task_sysctl.c b/kernel/hung_task_sysctl.c
index 5b10d4e..62a51f5 100644
--- a/kernel/hung_task_sysctl.c
+++ b/kernel/hung_task_sysctl.c
@@ -14,7 +14,6 @@
  * and hung_task_check_interval_secs
  */
 static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
-static int neg_one = -1;
 static struct ctl_table hung_task_sysctls[] = {
 	{
 		.procname	= "hung_task_panic",
@@ -55,7 +54,7 @@
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
+		.extra1		= SYSCTL_NEG_ONE,
 	},
 	{}
 };
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 20adae0..01fc559 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,7 +124,6 @@
 static int sixty = 60;
 #endif
 
-static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
@@ -540,7 +539,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
+		.extra1		= SYSCTL_NEG_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-- 
1.8.5.6

