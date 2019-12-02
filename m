Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9510E6C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 09:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLBIOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 03:14:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfLBIOX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:23 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90F8DFAE075D8D407738;
        Mon,  2 Dec 2019 16:14:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:10 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 3/7] sched/core, x86: Make struct thread_info arch specific again
Date:   Mon, 2 Dec 2019 16:35:15 +0800
Message-ID: <20191202083519.23138-4-yi.zhang@huawei.com>
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

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit c8061485a0d7569a865a3cc3c63347b0f42b3765 upstream.

The following commit:

  c65eacbe290b ("sched/core: Allow putting thread_info into task_struct")

... made 'struct thread_info' a generic struct with only a
single ::flags member, if CONFIG_THREAD_INFO_IN_TASK_STRUCT=y is
selected.

This change however seems to be quite x86 centric, since at least the
generic preemption code (asm-generic/preempt.h) assumes that struct
thread_info also has a preempt_count member, which apparently was not
true for x86.

We could add a bit more #ifdefs to solve this problem too, but it seems
to be much simpler to make struct thread_info arch specific
again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
bit easier for architectures that have a couple of arch specific stuff
in their thread_info definition.

The arch specific stuff _could_ be moved to thread_struct. However
keeping them in thread_info makes it easier: accessing thread_info
members is simple, since it is at the beginning of the task_struct,
while the thread_struct is at the end. At least on s390 the offsets
needed to access members of the thread_struct (with task_struct as
base) are too large for various asm instructions.  This is not a
problem when keeping these members within thread_info.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: keescook@chromium.org
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/1476901693-8492-2-git-send-email-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>

[ zhangyi: skip defination of INIT_THREAD_INFO and struct thread_info ]

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 include/linux/thread_info.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 2813de75a96e..897e835379d8 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -13,17 +13,6 @@
 struct timespec;
 struct compat_timespec;
 
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-struct thread_info {
-	u32			flags;		/* low level flags */
-};
-
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.flags		= 0,			\
-}
-#endif
-
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 #define current_thread_info() ((struct thread_info *)current)
 #endif
-- 
2.17.2

