Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB675FF5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGXSyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXSyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0410E2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2AZT1+3agWdrOE7nqGCVHOcFr0jkcGTHBHWs2FPeDAM=; b=n5GXwO6Dr8M+Aa3h7HKboWgfbn
        O6jzDiQok9xwJwtnCZMhuc2dh0YtV6FQJWpLd1iAAgzkjij5vatuLMlggbmcGT/XPMZ5rEC1vbHG+
        dIDesgUfaQ31ZEBPWNRwAWCW7XVkC7uAv34PynBov/6Mr3o2ot8lA2yNDCI2J/npI4AdVaRoHR24h
        msmW+juCmkG/E4EQ2AvmRvbvwxI7rZZVKE+YjdaOaFJRREPwbl1O4kwNhrasi+oMpo2IRxx8u2dYI
        KNnMexdkEPHhY7srT/Gv6v0BYss34lJgRGAKi58np38ju4aZRpssnyqcmRTW7YggNW3h9jdjWCyBC
        98GOUPDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iR1-25; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 01/10] mm: Remove CONFIG_PER_VMA_LOCK ifdefs
Date:   Mon, 24 Jul 2023 19:54:01 +0100
Message-Id: <20230724185410.1124082-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724185410.1124082-1-willy@infradead.org>
References: <20230724185410.1124082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide lock_vma_under_rcu() when CONFIG_PER_VMA_LOCK is not defined
to eliminate ifdefs in the users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/mm/fault.c   | 2 --
 arch/powerpc/mm/fault.c | 4 ----
 arch/riscv/mm/fault.c   | 4 ----
 arch/s390/mm/fault.c    | 2 --
 arch/x86/mm/fault.c     | 4 ----
 include/linux/mm.h      | 6 ++++++
 6 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8c80f7b8a5f..2e5d1e238af9 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -587,7 +587,6 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_PER_VMA_LOCK
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
@@ -616,7 +615,6 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		return 0;
 	}
 lock_mmap:
-#endif /* CONFIG_PER_VMA_LOCK */
 
 retry:
 	vma = lock_mm_and_find_vma(mm, addr, regs);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 82954d0e6906..b1723094d464 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -469,7 +469,6 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
-#ifdef CONFIG_PER_VMA_LOCK
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
@@ -502,7 +501,6 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 		return user_mode(regs) ? 0 : SIGBUS;
 
 lock_mmap:
-#endif /* CONFIG_PER_VMA_LOCK */
 
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
@@ -552,9 +550,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	mmap_read_unlock(current->mm);
 
-#ifdef CONFIG_PER_VMA_LOCK
 done:
-#endif
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 6ea2cce4cc17..046732fcb48c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -283,7 +283,6 @@ void handle_page_fault(struct pt_regs *regs)
 		flags |= FAULT_FLAG_WRITE;
 	else if (cause == EXC_INST_PAGE_FAULT)
 		flags |= FAULT_FLAG_INSTRUCTION;
-#ifdef CONFIG_PER_VMA_LOCK
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
@@ -311,7 +310,6 @@ void handle_page_fault(struct pt_regs *regs)
 		return;
 	}
 lock_mmap:
-#endif /* CONFIG_PER_VMA_LOCK */
 
 retry:
 	vma = lock_mm_and_find_vma(mm, addr, regs);
@@ -368,9 +366,7 @@ void handle_page_fault(struct pt_regs *regs)
 
 	mmap_read_unlock(mm);
 
-#ifdef CONFIG_PER_VMA_LOCK
 done:
-#endif
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b953625a517..a063774ba584 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -407,7 +407,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		access = VM_WRITE;
 	if (access == VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-#ifdef CONFIG_PER_VMA_LOCK
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 	vma = lock_vma_under_rcu(mm, address);
@@ -433,7 +432,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		goto out;
 	}
 lock_mmap:
-#endif /* CONFIG_PER_VMA_LOCK */
 	mmap_read_lock(mm);
 
 	gmap = NULL;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 56b4f9faf8c4..2e861b9360c7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1328,7 +1328,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
-#ifdef CONFIG_PER_VMA_LOCK
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
@@ -1359,7 +1358,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 lock_mmap:
-#endif /* CONFIG_PER_VMA_LOCK */
 
 retry:
 	vma = lock_mm_and_find_vma(mm, address, regs);
@@ -1419,9 +1417,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
-#ifdef CONFIG_PER_VMA_LOCK
 done:
-#endif
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a5d68baea231..89f80e2c6ed9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -753,6 +753,12 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 	mmap_assert_locked(vmf->vma->vm_mm);
 }
 
+static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
+		unsigned long address)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_PER_VMA_LOCK */
 
 /*
-- 
2.39.2

