Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46B10E6C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 09:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLBIOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 03:14:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfLBIOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96B92106611D16A3E7B5;
        Mon,  2 Dec 2019 16:14:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:09 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 2/7] sched/core: Add try_get_task_stack() and put_task_stack()
Date:   Mon, 2 Dec 2019 16:35:14 +0800
Message-ID: <20191202083519.23138-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191202083519.23138-1-yi.zhang@huawei.com>
References: <20191202083519.23138-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit c6c314a613cd7d03fb97713e0d642b493de42e69 upstream.

There are a few places in the kernel that access stack memory
belonging to a different task.  Before we can start freeing task
stacks before the task_struct is freed, we need a way for those code
paths to pin the stack.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jann Horn <jann@thejh.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/17a434f50ad3d77000104f21666575e10a9c1fbd.1474003868.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 include/linux/sched.h | 16 ++++++++++++++++
 init/Kconfig          |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d6b2e77aad3f..761247c966a5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2858,11 +2858,19 @@ static inline struct thread_info *task_thread_info(struct task_struct *task)
 {
 	return &task->thread_info;
 }
+
+/*
+ * When accessing the stack of a non-current task that might exit, use
+ * try_get_task_stack() instead.  task_stack_page will return a pointer
+ * that could get freed out from under you.
+ */
 static inline void *task_stack_page(const struct task_struct *task)
 {
 	return task->stack;
 }
+
 #define setup_thread_stack(new,old)	do { } while(0)
+
 static inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 	return task->stack;
@@ -2898,6 +2906,14 @@ static inline unsigned long *end_of_stack(struct task_struct *p)
 }
 
 #endif
+
+static inline void *try_get_task_stack(struct task_struct *tsk)
+{
+	return task_stack_page(tsk);
+}
+
+static inline void put_task_stack(struct task_struct *tsk) {}
+
 #define task_stack_end_corrupted(task) \
 		(*(end_of_stack(task)) != STACK_END_MAGIC)
 
diff --git a/init/Kconfig b/init/Kconfig
index 5dec7d424980..f9fb621c9562 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -33,6 +33,9 @@ config THREAD_INFO_IN_TASK
 	  make this work, an arch will need to remove all thread_info fields
 	  except flags and fix any runtime bugs.
 
+	  One subtle change that will be needed is to use try_get_task_stack()
+	  and put_task_stack() in save_thread_stack_tsk() and get_wchan().
+
 menu "General setup"
 
 config BROKEN
-- 
2.17.2

