Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80F7A25FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjIOSh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjIOShY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3110F7;
        Fri, 15 Sep 2023 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+IWZ1pVUhVN3z1l/dMaghxmkHDofRoTXIwAAX7e84tQ=; b=Awtg9B4S8FOkho5cI1bYeYXr32
        A/lwQ5v9+ST7XpFne3FVrkJIjX06WHJGZy2Y7Oj1GLuEmQ9UeWtFKxUjWWZMnYt2ag8KVz7no2bwE
        W8QZNKYkP7R60whmbRDnpmstn62QkRsWjNboQ1TW8GqF8DM3ky4xq4AoUb74B4yjrgNeaG9kjVj4e
        HcoQleM1nqwQ0SgcP3HXZPwj0KrtX281KtSA0luMyEXxgD0YlMW8z+npKLjXGRSqX4ihLSPW+jkFf
        khB6bdSTKNthkTudWwDaZhahi2HRBEeoeY7zOAzBUDFqQN6DZul7mOHVmhY2asnTyjCqGiTxC9kHE
        4K55kgBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgk-00BMJ0-6E; Fri, 15 Sep 2023 18:37:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 14/17] mm: Delete checks for xor_unlock_is_negative_byte()
Date:   Fri, 15 Sep 2023 19:37:04 +0100
Message-Id: <20230915183707.2707298-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Architectures which don't define their own use the one in
asm-generic/bitops/lock.h.  Get rid of all the ifdefs around "maybe we
don't have it".

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/bitops.h               |  1 -
 arch/m68k/include/asm/bitops.h                |  1 -
 arch/mips/include/asm/bitops.h                |  1 -
 arch/riscv/include/asm/bitops.h               |  1 -
 .../asm-generic/bitops/instrumented-lock.h    |  5 ----
 include/asm-generic/bitops/lock.h             |  1 -
 kernel/kcsan/kcsan_test.c                     |  3 --
 kernel/kcsan/selftest.c                       |  3 --
 mm/filemap.c                                  | 30 +------------------
 mm/kasan/kasan_test.c                         |  3 --
 10 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index 138930e8a504..29de3c623f65 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -305,7 +305,6 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 
 	return (old & BIT(7)) != 0;
 }
-#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
 
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 909ebe7cab5d..ec82bb734aef 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -331,7 +331,6 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 		: "memory");
 	return result;
 }
-#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
 
 /*
  *	The true 68020 and more advanced processors support the "bfffo"
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index d98a05c478f4..89f73d1a4ea4 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -301,7 +301,6 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 
 	return res;
 }
-#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
 
 #undef __bit_op
 #undef __test_bit_op
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 15e3044298a2..65f6eee4ab8d 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -202,7 +202,6 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 		: "memory");
 	return (res & BIT(7)) != 0;
 }
-#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
 
 #undef __test_and_op_bit
 #undef __op_bit
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index e8ea3aeda9a9..542d3727ee4e 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -58,7 +58,6 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
-#if defined(arch_xor_unlock_is_negative_byte)
 /**
  * xor_unlock_is_negative_byte - XOR a single byte in memory and test if
  * it is negative, for unlock.
@@ -80,8 +79,4 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 	instrument_atomic_write(addr, sizeof(long));
 	return arch_xor_unlock_is_negative_byte(mask, addr);
 }
-/* Let everybody know we have it. */
-#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
-#endif
-
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H */
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 6a638e89d130..14d4ec8c5152 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -75,7 +75,6 @@ static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 	old = raw_atomic_long_fetch_xor_release(mask, (atomic_long_t *)p);
 	return !!(old & BIT(7));
 }
-#define arch_xor_unlock_is_negative_byte arch_xor_unlock_is_negative_byte
 #endif
 
 #include <asm-generic/bitops/instrumented-lock.h>
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 1333d23ac4ef..015586217875 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -699,12 +699,9 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_RW_BARRIER(spin_unlock(&test_spinlock), true);
 	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&test_mutex), false);
 	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&test_mutex), true);
-
-#ifdef xor_unlock_is_negative_byte
 	KCSAN_EXPECT_READ_BARRIER(xor_unlock_is_negative_byte(1, &test_var), true);
 	KCSAN_EXPECT_WRITE_BARRIER(xor_unlock_is_negative_byte(1, &test_var), true);
 	KCSAN_EXPECT_RW_BARRIER(xor_unlock_is_negative_byte(1, &test_var), true);
-#endif
 	kcsan_nestable_atomic_end();
 }
 
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 619be7417420..84a1200271af 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -227,12 +227,9 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_RW_BARRIER(arch_spin_unlock(&arch_spinlock));
 	spin_lock(&test_spinlock);
 	KCSAN_CHECK_RW_BARRIER(spin_unlock(&test_spinlock));
-
-#ifdef xor_unlock_is_negative_byte
 	KCSAN_CHECK_RW_BARRIER(xor_unlock_is_negative_byte(1, &test_var));
 	KCSAN_CHECK_READ_BARRIER(xor_unlock_is_negative_byte(1, &test_var));
 	KCSAN_CHECK_WRITE_BARRIER(xor_unlock_is_negative_byte(1, &test_var));
-#endif
 	kcsan_nestable_atomic_end();
 
 	return ret;
diff --git a/mm/filemap.c b/mm/filemap.c
index 2db7c5da9e03..330e21da6863 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1484,34 +1484,6 @@ void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter)
 }
 EXPORT_SYMBOL_GPL(folio_add_wait_queue);
 
-#ifdef xor_unlock_is_negative_byte
-#define clear_bit_unlock_is_negative_byte(nr, p)	\
-	xor_unlock_is_negative_byte(1 << nr, p)
-#endif
-
-#ifndef clear_bit_unlock_is_negative_byte
-
-/*
- * PG_waiters is the high bit in the same byte as PG_lock.
- *
- * On x86 (and on many other architectures), we can clear PG_lock and
- * test the sign bit at the same time. But if the architecture does
- * not support that special operation, we just do this all by hand
- * instead.
- *
- * The read of PG_waiters has to be after (or concurrently with) PG_locked
- * being cleared, but a memory barrier should be unnecessary since it is
- * in the same byte as PG_locked.
- */
-static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem)
-{
-	clear_bit_unlock(nr, mem);
-	/* smp_mb__after_atomic(); */
-	return test_bit(PG_waiters, mem);
-}
-
-#endif
-
 /**
  * folio_unlock - Unlock a locked folio.
  * @folio: The folio.
@@ -1527,7 +1499,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
+	if (xor_unlock_is_negative_byte(1 << PG_locked, folio_flags(folio, 0)))
 		folio_wake_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(folio_unlock);
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index c1de091dfc92..b241b57427b1 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1097,12 +1097,9 @@ static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
 	KUNIT_EXPECT_KASAN_FAIL(test, test_and_change_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_change_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = test_bit(nr, addr));
-
-#if defined(xor_unlock_is_negative_byte)
 	if (nr < 7)
 		KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =
 				xor_unlock_is_negative_byte(1 << nr, addr));
-#endif
 }
 
 static void kasan_bitops_generic(struct kunit *test)
-- 
2.40.1

