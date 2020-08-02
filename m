Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04223A3D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHCMIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 08:08:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53238 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHCMIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:08:19 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200803120815epoutp04d4c81d6740e0bd5c8e26c342d135ab10~nwLl04AZY0999609996epoutp04U;
        Mon,  3 Aug 2020 12:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200803120815epoutp04d4c81d6740e0bd5c8e26c342d135ab10~nwLl04AZY0999609996epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596456495;
        bh=2WBgkLxsDeTPNmtuUxW8D2JTNPrc4cq3+DknlqZ+k0M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I4z5p8hIGDOhENavDCg3Lb+U2nwpNCgMJbCcT2Oo9XZJyhdNlIENaBtYYxnLuFbWY
         52nxjhyn+vBVebz+9ohdY06QPT913KCSdFf9WZV2KoknGVa7SlkfeAFZ6Gmm0VxrG8
         Jy3UO3nI7/NelfDDmC1J+sl9S7qoQk79KW8woss0=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200803120814epcas5p46afbcf9a96442d7ed620110adac61d45~nwLk7fkfy1252012520epcas5p4N;
        Mon,  3 Aug 2020 12:08:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.4D.09467.E2EF72F5; Mon,  3 Aug 2020 21:08:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96~ngfp0TD2F0804708047epcas5p3y;
        Sun,  2 Aug 2020 16:58:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200802165825epsmtrp223281b42c2c5ee489579389e6073e44b~ngfpy8fOh2950229502epsmtrp2U;
        Sun,  2 Aug 2020 16:58:25 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-23-5f27fe2ec2f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.A7.08303.1B0F62F5; Mon,  3 Aug 2020 01:58:25 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200802165819epsmtip240ae74d9e1a0130cf77f0e043f0612a6~ngfkZE_zL2814028140epsmtip2e;
        Sun,  2 Aug 2020 16:58:19 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
        keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        adobriyan@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        steve.capper@arm.com, mark.rutland@arm.com,
        vincenzo.frascino@arm.com, anshuman.khandual@arm.com,
        ardb@kernel.org, james.morse@arm.com, broonie@kernel.org,
        maz@kernel.org, kristina.martsenko@arm.com,
        samitolvanen@google.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        daniel.m.jordan@oracle.com, walken@google.com,
        bernd.edlinger@hotmail.de, laoar.shao@gmail.com, avagin@gmail.com,
        john.johansen@canonical.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet narang <v.narang@samsung.com>
Subject: [PATCH 1/1] arm64: add support for PAGE_SIZE aligned kernel stack
Date:   Sun,  2 Aug 2020 22:05:15 +0530
Message-Id: <1596386115-47228-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0xTVxTHva+v7z06qw807gpBRg06mwmaKbt2ottcwtMlizPEJUytjbwh
        G6VdCxtbMFSpZCAolJ8iImBB1pXVdbVUfhQCWmDCtrIVB5PAAktVnLSUIULErTzM/vuc8/3e
        7zknuRQvKI8IppJSUllViixZRAhwa9eWV7dGLm6Wbpu3bkTOFhaVnT6AKk1GAtl7TqCnM1MA
        PdM5SNT3/CEPfVPiwlHJnxMEmqrPA6hitpxEz61aEtVMfYCyrpoINGq/hqGembME6jsnR6Pd
        2Xx0zX2PRObxQT5qbevF0a/NlQTqupKNo7q7TgzdrOzlo4GOagzdaD8LkP3rMQzVNfzNR7pH
        Vgx19l4GqG3xKY4WdaeQ9t7Ot0SMscoImIV5HWAqNPkEc0njxJmbFSMko7UPk0y1OY2p/fk2
        zpgNOQTTU76AM+2XjSTzgz6T8f41jDNTdhfBnLcYAOMzbzgYGC/YncAmJ33OqqL2HBec/K2m
        jqds25V+32vANaAkKhdQFKR3QMddWS4IoILoFgBrctNzgeA/ngZwtO8xyRU+AGtNrZjf5X9Q
        PTHA54RmAAvcxmXXDIClVX8suQg6EhqaW3G/sJbO4cO5rGngL3i0E0BvfyfP71pDH4DmC+dJ
        P+N0BOyoz8H9LKRjoUdTDLh5G2Cvo4jPcUsAzL+TxC3+LnTUCLj2Gviw20JyHAx9j9sI/yxI
        ZwE4bW8EXFEMYJ3Tuxy0F05maTB/EI/eAk3NUVw7FJb8+N3SBTx6FcxfmFi+WQhtVS84AmqH
        ri/HhECf14tz+zBwuAH4MYg+CtstGQUgtOL//GoADGA9q1TLE1n1TuX2FPaLSLVMrk5LSYw8
        oZCbwdKHFe+3gZExT2QnwCjQCSDFE60Ven2bpUHCBNmXX7EqhVSVlsyqO0EIhYteForm+o4F
        0YmyVPZTllWyqhcqRgUEa7C9gUclAaIHVGljbLxicb7ol9hEOziu1+YR2S9dPLPPt7LyweSZ
        6d1lq27ZgHj2mG2bp9Q6MAziTePhNteEqzyzTz/5pj6uXxxqictAkzcKDypi9M7GjiPpyXHy
        Z12HjReOSDT3PU+ioTshbCRjsOBbHraYN/ax6adTr713TrLulrtwzyset52KIYWi28HrC62Z
        61yP5nZdHJq/o2s8JP2n/skbl1Sri1bQtfj79fqosEOSstOKptWvjzcIAla0bRJ/FN78ydDG
        qug4Q2Dl7/s/TPU6ZkXFxi7Qf9jV8LZlhyoibN8VW1OGY1Cp/CzmevT34bWlku4maUxIdvvK
        d7Z2i3D1Sdl2MU+llv0LCqgpFx8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0xTZxyG951+5yLSeSwkO1pBU6dOMuqYU38mHfEWOV6WQGKyaTJLhWMl
        0tL0iIrGWGdFLFc7myFyKWBBmqKuE0SE6sALTIRUQTbGzYiiRi04ZmSMYoD435s8T973j5eR
        yKrxXCZBv08w6jWJCioAVzcq5of/OrRY/ZW3JgS81wX45dhmyL/kosDTFAejIz4E49Y7NLRM
        vJRAha0Dg+3xAAW+sgwEee9yaZioNtNQ7IuB46WXKOjzlBPQNHKCgpZ0HfTdTSWhfLCbBveT
        RyTU1TdjeFibT0FjUSoGR6eXgGv5zSQ8uGknoOrGCQSetH4CHBdek2B9VU1AQ3MBgnr/KAa/
        9QiYu1esUfCuQhfix/6zIj7PlEnx50xezF/L66F5s6eL5u3uZL6k7Tbm3c5TFN+UO4b5GwUu
        mv/t/FF++GkX5n2eDorPuuJE/D/u0OjZOwJU8UJiwn7BuCwyNmBPe7FDYqhfffD5sBObkG2Z
        Bc1gOPYbzj7wgLSgAEbG1iDu/kmrZBrIuVG/D0/nIK7CP0hPS28R98hxEU0CilVyzto6PAmC
        2UqSe9mVPWVJ2E7EtV9sIietIHYz587OoiczZhdxN8tOTdVK2ShuyHQGTU+Ecs13fiZzUKAd
        feJEcwSDqNPqxAjD13rhgFLU6MRkvVYZl6Rzo6lrw8JqUJ1zSNmACAY1II6RKIKl4/6Fapk0
        XpNySDAmqY3JiYLYgOQMVnwm/TeveKeM1Wr2CXsFwSAYP1KCmTHXRMwcD+71/fWsYGXp+sx7
        5rqhH1nrwPPt6Qe+dYZ3RMZGtRZRqaqE5bH4uLXkKKGugifWpMWN2KSa9V3Zpj8N48uhc+Ne
        2wZq17nOV44LS/qEbcUqri37bzLXlrhrUUZ0oZimVhPtW1ercixyc8YW/dbC98eC+u0/vKgN
        Dcwyh3yesm53/5wWrxAm15TYj5wfuVd5Rno5LktyWN+zZntar7yHeH367Ek5U/n/RGQFlMtr
        I/5YNXY5s21Bq1vRK71VfnWL0jP7++7TMjRv28CbLy3apVcWDg6nUJ9qhmPiVz5MT67/vdX1
        lhBbvvgpUBs9r2qtTl51v88SHlJ6NqZIvSBHgcU9mogwiVHUfABDTntUSQMAAA==
X-CMS-MailID: 20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96
References: <CGME20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96@epcas5p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

currently THREAD_SIZE is always in power of 2, which will waste
memory in cases there is need to increase of stack size.

Thus adding support for PAGE_SIZE(not power of 2) stacks for arm64.
User can decide any value 12KB, 16KB, 20 KB etc. based on value
of THREAD_SHIFT. User can set any value which is PAGE_SIZE aligned for
PAGE_ALIGNED_STACK_SIZE config.

Value of THREAD_SIZE is defined as 12KB for now, since with irq stacks
it is enough and it will save 4KB per thread.

IRQ stack size is not changed and alignement of IRQ stack and kernel stack
is maintained same to catch stack overflow faults as earlier.

THREAD_SIZE masking in common files is changed to THREAD_SIZE_ALIGNED.

Co-developed-by: Vaneet narang <v.narang@samsung.com>
Signed-off-by: Vaneet narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm64/Kconfig              |  9 +++++++++
 arch/arm64/include/asm/memory.h | 29 +++++++++++++++++++++++++----
 arch/arm64/kernel/entry.S       |  4 ++--
 arch/arm64/kernel/ptrace.c      |  4 ++--
 drivers/misc/lkdtm/stackleak.c  |  2 +-
 fs/proc/base.c                  |  4 ++--
 include/linux/thread_info.h     |  4 ++++
 kernel/trace/trace_stack.c      |  4 ++--
 8 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c970171..301e068 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -977,6 +977,15 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config	PAGE_ALIGNED_STACK_SIZE
+	int "set per thread stack size (THREAD_SIZE)"
+	default 12288
+	depends on VMAP_STACK && ARM64_4K_PAGES && !KASAN
+	help
+	  Per Thread stack size, value must be PAGE_SIZE aligned.
+	  make sure value should be less than (1 << THREAD_SHIFT),
+	  otherwise increase THREAD_SHIFT also.
+
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 5767836..597071e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -93,6 +93,7 @@
  */
 #if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
 #define THREAD_SHIFT		PAGE_SHIFT
+#define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
 #else
 #define THREAD_SHIFT		MIN_THREAD_SHIFT
 #endif
@@ -101,7 +102,15 @@
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 #endif
 
-#define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
+#define THREAD_SIZE_ALIGNED	(UL(1) << THREAD_SHIFT)
+
+#ifndef THREAD_SIZE
+#if defined(CONFIG_VMAP_STACK) && (CONFIG_PAGE_ALIGNED_STACK_SIZE)
+#define THREAD_SIZE		CONFIG_PAGE_ALIGNED_STACK_SIZE
+#else
+#define THREAD_SIZE		THREAD_SIZE_ALIGNED
+#endif
+#endif
 
 /*
  * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
@@ -109,12 +118,24 @@
  * assembly.
  */
 #ifdef CONFIG_VMAP_STACK
-#define THREAD_ALIGN		(2 * THREAD_SIZE)
+#define THREAD_ALIGN		(2 * THREAD_SIZE_ALIGNED)
 #else
-#define THREAD_ALIGN		THREAD_SIZE
+#define THREAD_ALIGN		THREAD_SIZE_ALIGNED
+#endif
+
+#ifdef CONFIG_PAGE_ALIGNED_STACK_SIZE
+
+#if (THREAD_SIZE_ALIGNED < THREAD_SIZE)
+#error "PAGE_ALIGNED_STACK_SIZE is more than THREAD_SIZE_ALIGNED, increase THREAD_SHIFT"
+#endif
+
+#if (THREAD_SIZE % PAGE_SIZE)
+#error "PAGE_ALIGNED_STACK_SIZE must be PAGE_SIZE align"
+#endif
+
 #endif
 
-#define IRQ_STACK_SIZE		THREAD_SIZE
+#define IRQ_STACK_SIZE		THREAD_SIZE_ALIGNED
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 13458c2..5190573 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -444,12 +444,12 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 
 	/*
 	 * Compare sp with the base of the task stack.
-	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
+	 * If the top ~(THREAD_SIZE_ALIGNED - 1) bits match, we are on a task stack,
 	 * and should switch to the irq stack.
 	 */
 	ldr	x25, [tsk, TSK_STACK]
 	eor	x25, x25, x19
-	and	x25, x25, #~(THREAD_SIZE - 1)
+	and	x25, x25, #~(THREAD_SIZE_ALIGNED - 1)
 	cbnz	x25, 9998f
 
 	ldr_this_cpu x25, irq_stack_ptr, x26
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b82eb50..800bb84 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -120,8 +120,8 @@ int regs_query_register_offset(const char *name)
  */
 static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
 {
-	return ((addr & ~(THREAD_SIZE - 1))  ==
-		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1))) ||
+	return ((addr & ~(THREAD_SIZE_ALIGNED - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE_ALIGNED - 1))) ||
 		on_irq_stack(addr, NULL);
 }
 
diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index d1a5c07..f4ab60a 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -24,7 +24,7 @@ void lkdtm_STACKLEAK_ERASING(void)
 	 */
 	sp = PTR_ALIGN(&i, sizeof(unsigned long));
 
-	left = ((unsigned long)sp & (THREAD_SIZE - 1)) / sizeof(unsigned long);
+	left = ((unsigned long)sp & (THREAD_SIZE_ALIGNED - 1)) / sizeof(unsigned long);
 	sp--;
 
 	/*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index f3b6e12..f89e2c5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3135,9 +3135,9 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
 	unsigned long prev_depth = THREAD_SIZE -
-				(task->prev_lowest_stack & (THREAD_SIZE - 1));
+				(task->prev_lowest_stack & (THREAD_SIZE_ALIGNED - 1));
 	unsigned long depth = THREAD_SIZE -
-				(task->lowest_stack & (THREAD_SIZE - 1));
+				(task->lowest_stack & (THREAD_SIZE_ALIGNED - 1));
 
 	seq_printf(m, "previous stack depth: %lu\nstack depth: %lu\n",
 							prev_depth, depth);
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249..35a73b5 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -43,6 +43,10 @@ enum {
 #define THREAD_ALIGN	THREAD_SIZE
 #endif
 
+#ifndef THREAD_SIZE_ALIGNED
+#define THREAD_SIZE_ALIGNED	THREAD_SIZE
+#endif
+
 #define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 
 /*
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5810fb8..ef3d442 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -159,7 +159,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 	int frame_size = READ_ONCE(tracer_frame);
 	int i, x;
 
-	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
+	this_size = ((unsigned long)stack) & (THREAD_SIZE_ALIGNED - 1);
 	this_size = THREAD_SIZE - this_size;
 	/* Remove the frame of the tracer */
 	this_size -= frame_size;
@@ -211,7 +211,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 	x = 0;
 	start = stack;
 	top = (unsigned long *)
-		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
+		(((unsigned long)start & ~(THREAD_SIZE_ALIGNED - 1)) + THREAD_SIZE);
 
 	/*
 	 * Loop through all the entries. One of the entries may
-- 
1.9.1

