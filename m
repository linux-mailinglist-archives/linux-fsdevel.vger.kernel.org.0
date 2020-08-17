Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6227A245E04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHQHdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHQHc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92282C06138A;
        Mon, 17 Aug 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/MO4DTudRyJml2PEcTkiDQoSZEGIOk2ndLlyDYzXwmU=; b=ZssG71vQjYRFDhpof6qnVhvxXc
        AfSPOcgNiyBuI49fEkrSSOCjIZaGxwQr2zh7PqtQ6o2w6gJR7T7cS1xEiCpPab6q12KN9khedu6BL
        VE4KJBH9pOSO3RMEJYs6W0G937PDS/nNFKX79Bx1KVqVyZAwB1CDwzgbwMgwFUydRB/ck3iWvXw4E
        8+wuqx5KSULMpp2TXJK5rH19yGFic/x5/xyUlTabeL6bl93mNoxYR122NnFpyPlRGSg27P0U3ghIZ
        V/xDASLpyC5vYqEcza8LLKSl+PWiNCUObwy1ABxGG2i403F6Gdnxh6tMX7nfw1C/JuW0EQD/HBzCo
        mtDcQ1eg==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Zd3-0000wS-2Y; Mon, 17 Aug 2020 07:32:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/11] x86: move PAGE_OFFSET, TASK_SIZE & friends to page_{32,64}_types.h
Date:   Mon, 17 Aug 2020 09:32:08 +0200
Message-Id: <20200817073212.830069-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At least for 64-bit this moves them closer to some of the defines
they are based on, and it prepares for using the TASK_SIZE_MAX
definition from assembly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/page_32_types.h | 11 +++++++
 arch/x86/include/asm/page_64_types.h | 38 +++++++++++++++++++++
 arch/x86/include/asm/processor.h     | 49 ----------------------------
 3 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 565ad755c785e2..26236925fb2c36 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -41,6 +41,17 @@
 #define __VIRTUAL_MASK_SHIFT	32
 #endif	/* CONFIG_X86_PAE */
 
+/*
+ * User space process size: 3GB (default).
+ */
+#define IA32_PAGE_OFFSET	PAGE_OFFSET
+#define TASK_SIZE		PAGE_OFFSET
+#define TASK_SIZE_LOW		TASK_SIZE
+#define TASK_SIZE_MAX		TASK_SIZE
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#define STACK_TOP		TASK_SIZE
+#define STACK_TOP_MAX		STACK_TOP
+
 /*
  * Kernel image size is limited to 512 MB (see in arch/x86/kernel/head_32.S)
  */
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 288b065955b729..996595c9897e0a 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -58,6 +58,44 @@
 #define __VIRTUAL_MASK_SHIFT	47
 #endif
 
+/*
+ * User space process size.  This is the first address outside the user range.
+ * There are a few constraints that determine this:
+ *
+ * On Intel CPUs, if a SYSCALL instruction is at the highest canonical
+ * address, then that syscall will enter the kernel with a
+ * non-canonical return address, and SYSRET will explode dangerously.
+ * We avoid this particular problem by preventing anything executable
+ * from being mapped at the maximum canonical address.
+ *
+ * On AMD CPUs in the Ryzen family, there's a nasty bug in which the
+ * CPUs malfunction if they execute code from the highest canonical page.
+ * They'll speculate right off the end of the canonical space, and
+ * bad things happen.  This is worked around in the same way as the
+ * Intel problem.
+ *
+ * With page table isolation enabled, we map the LDT in ... [stay tuned]
+ */
+#define TASK_SIZE_MAX	((1UL << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
+
+#define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
+
+/* This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define IA32_PAGE_OFFSET	((current->personality & ADDR_LIMIT_3GB) ? \
+					0xc0000000 : 0xFFFFe000)
+
+#define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
+					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
+#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
+					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
+#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
+					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
+
+#define STACK_TOP		TASK_SIZE_LOW
+#define STACK_TOP_MAX		TASK_SIZE_MAX
+
 /*
  * Maximum kernel image size is limited to 1 GiB, due to the fixmap living
  * in the next 1 GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S).
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d87994c24..1618eeb08361a9 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -782,17 +782,6 @@ static inline void spin_lock_prefetch(const void *x)
 })
 
 #ifdef CONFIG_X86_32
-/*
- * User space process size: 3GB (default).
- */
-#define IA32_PAGE_OFFSET	PAGE_OFFSET
-#define TASK_SIZE		PAGE_OFFSET
-#define TASK_SIZE_LOW		TASK_SIZE
-#define TASK_SIZE_MAX		TASK_SIZE
-#define DEFAULT_MAP_WINDOW	TASK_SIZE
-#define STACK_TOP		TASK_SIZE
-#define STACK_TOP_MAX		STACK_TOP
-
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
@@ -802,44 +791,6 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-/*
- * User space process size.  This is the first address outside the user range.
- * There are a few constraints that determine this:
- *
- * On Intel CPUs, if a SYSCALL instruction is at the highest canonical
- * address, then that syscall will enter the kernel with a
- * non-canonical return address, and SYSRET will explode dangerously.
- * We avoid this particular problem by preventing anything executable
- * from being mapped at the maximum canonical address.
- *
- * On AMD CPUs in the Ryzen family, there's a nasty bug in which the
- * CPUs malfunction if they execute code from the highest canonical page.
- * They'll speculate right off the end of the canonical space, and
- * bad things happen.  This is worked around in the same way as the
- * Intel problem.
- *
- * With page table isolation enabled, we map the LDT in ... [stay tuned]
- */
-#define TASK_SIZE_MAX	((1UL << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
-
-#define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
-
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define IA32_PAGE_OFFSET	((current->personality & ADDR_LIMIT_3GB) ? \
-					0xc0000000 : 0xFFFFe000)
-
-#define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
-					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
-#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-
-#define STACK_TOP		TASK_SIZE_LOW
-#define STACK_TOP_MAX		TASK_SIZE_MAX
-
 #define INIT_THREAD  {						\
 	.addr_limit		= KERNEL_DS,			\
 }
-- 
2.28.0

