Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9E7A25E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjIOShq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjIOShj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E87115;
        Fri, 15 Sep 2023 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0N1cmjHcEJag2AtHK/yNA0zjVT3A3o3O6S0qHTVMYWc=; b=LKxDO16wvao6WY4341Zd7gqp8a
        6tJ5yZe5JeqT3FGPaCbZo8YtdIVWyxnH8Ht3EXolZ98oXnKIy8ke2Jfebv75l2ca9l/SXyijqolLI
        GnypR8ReWzvNkFGWZEC1Y4LqTpv+aM6shDYXLlkz3SWyFjtbgxWn4D7ehYPC+Nf1p8sJycvegvvrp
        6zNq6PsIlrqyya0zVORpXsfPamwV6SJNBOHUfreeJl7/dwEoZldZ5dEqNdvreqC3D19HwO2znGurS
        Te0aY/RPjQbzJatIzYB8JOZl88C4ZHTSQlT8KVb1JPC0gFMVItO7W8o6S8JlxCy182jcIHdLjFIl+
        uDseTJ7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIh-KO; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 07/17] bitops: Add xor_unlock_is_negative_byte()
Date:   Fri, 15 Sep 2023 19:36:57 +0100
Message-Id: <20230915183707.2707298-8-willy@infradead.org>
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

Replace clear_bit_and_unlock_is_negative_byte() with
xor_unlock_is_negative_byte().  We have a few places that like to lock
a folio, set a flag and unlock it again.  Allow for the possibility of
combining the latter two operations for efficiency.  We are guaranteed
that the caller holds the lock, so it is safe to unlock it with the xor.
The caller must guarantee that nobody else will set the flag without
holding the lock; it is not safe to do this with the PG_dirty flag,
for example.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/powerpc/include/asm/bitops.h             | 17 ++++--------
 arch/x86/include/asm/bitops.h                 | 11 ++++----
 .../asm-generic/bitops/instrumented-lock.h    | 27 ++++++++++---------
 include/asm-generic/bitops/lock.h             | 21 ++++-----------
 kernel/kcsan/kcsan_test.c                     |  8 +++---
 kernel/kcsan/selftest.c                       |  8 +++---
 mm/filemap.c                                  |  5 ++++
 mm/kasan/kasan_test.c                         |  7 ++---
 8 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 7e0f0322912b..40cc3ded60cb 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -234,32 +234,25 @@ static inline int arch_test_and_change_bit(unsigned long nr,
 }
 
 #ifdef CONFIG_PPC64
-static inline unsigned long
-clear_bit_unlock_return_word(int nr, volatile unsigned long *addr)
+static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *p)
 {
 	unsigned long old, t;
-	unsigned long *p = (unsigned long *)addr + BIT_WORD(nr);
-	unsigned long mask = BIT_MASK(nr);
 
 	__asm__ __volatile__ (
 	PPC_RELEASE_BARRIER
 "1:"	PPC_LLARX "%0,0,%3,0\n"
-	"andc %1,%0,%2\n"
+	"xor %1,%0,%2\n"
 	PPC_STLCX "%1,0,%3\n"
 	"bne- 1b\n"
 	: "=&r" (old), "=&r" (t)
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
 
-	return old;
+	return (old & BIT_MASK(7)) != 0;
 }
 
-/*
- * This is a special function for mm/filemap.c
- * Bit 7 corresponds to PG_waiters.
- */
-#define arch_clear_bit_unlock_is_negative_byte(nr, addr)		\
-	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(7))
+#define arch_xor_unlock_is_negative_byte arch_xor_unlock_is_negative_byte
 
 #endif /* CONFIG_PPC64 */
 
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 2edf68475fec..f03c0a50ec3a 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -94,18 +94,17 @@ arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 	asm volatile(__ASM_SIZE(btr) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
-static __always_inline bool
-arch_clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
+static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *addr)
 {
 	bool negative;
-	asm volatile(LOCK_PREFIX "andb %2,%1"
+	asm volatile(LOCK_PREFIX "xorb %2,%1"
 		CC_SET(s)
 		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
-		: "ir" ((char) ~(1 << nr)) : "memory");
+		: "iq" ((char)mask) : "memory");
 	return negative;
 }
-#define arch_clear_bit_unlock_is_negative_byte                                 \
-	arch_clear_bit_unlock_is_negative_byte
+#define arch_xor_unlock_is_negative_byte arch_xor_unlock_is_negative_byte
 
 static __always_inline void
 arch___clear_bit_unlock(long nr, volatile unsigned long *addr)
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index eb64bd4f11f3..e8ea3aeda9a9 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -58,27 +58,30 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
-#if defined(arch_clear_bit_unlock_is_negative_byte)
+#if defined(arch_xor_unlock_is_negative_byte)
 /**
- * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
- *                                     byte is negative, for unlock.
- * @nr: the bit to clear
- * @addr: the address to start counting from
+ * xor_unlock_is_negative_byte - XOR a single byte in memory and test if
+ * it is negative, for unlock.
+ * @mask: Change the bits which are set in this mask.
+ * @addr: The address of the word containing the byte to change.
  *
+ * Changes some of bits 0-6 in the word pointed to by @addr.
  * This operation is atomic and provides release barrier semantics.
+ * Used to optimise some folio operations which are commonly paired
+ * with an unlock or end of writeback.  Bit 7 is used as PG_waiters to
+ * indicate whether anybody is waiting for the unlock.
  *
- * This is a bit of a one-trick-pony for the filemap code, which clears
- * PG_locked and tests PG_waiters,
+ * Return: Whether the top bit of the byte is set.
  */
-static inline bool
-clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
+static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *addr)
 {
 	kcsan_release();
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
-	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
+	instrument_atomic_write(addr, sizeof(long));
+	return arch_xor_unlock_is_negative_byte(mask, addr);
 }
 /* Let everybody know we have it. */
-#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
+#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
 #endif
 
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H */
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 40913516e654..6a638e89d130 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -66,27 +66,16 @@ arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 	raw_atomic_long_set_release((atomic_long_t *)p, old);
 }
 
-/**
- * arch_clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
- *                                          byte is negative, for unlock.
- * @nr: the bit to clear
- * @addr: the address to start counting from
- *
- * This is a bit of a one-trick-pony for the filemap code, which clears
- * PG_locked and tests PG_waiters,
- */
-#ifndef arch_clear_bit_unlock_is_negative_byte
-static inline bool arch_clear_bit_unlock_is_negative_byte(unsigned int nr,
-							  volatile unsigned long *p)
+#ifndef arch_xor_unlock_is_negative_byte
+static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *p)
 {
 	long old;
-	unsigned long mask = BIT_MASK(nr);
 
-	p += BIT_WORD(nr);
-	old = raw_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_xor_release(mask, (atomic_long_t *)p);
 	return !!(old & BIT(7));
 }
-#define arch_clear_bit_unlock_is_negative_byte arch_clear_bit_unlock_is_negative_byte
+#define arch_xor_unlock_is_negative_byte arch_xor_unlock_is_negative_byte
 #endif
 
 #include <asm-generic/bitops/instrumented-lock.h>
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 0ddbdab5903d..1333d23ac4ef 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -700,10 +700,10 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&test_mutex), false);
 	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&test_mutex), true);
 
-#ifdef clear_bit_unlock_is_negative_byte
-	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
-	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
-	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+#ifdef xor_unlock_is_negative_byte
+	KCSAN_EXPECT_READ_BARRIER(xor_unlock_is_negative_byte(1, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xor_unlock_is_negative_byte(1, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(xor_unlock_is_negative_byte(1, &test_var), true);
 #endif
 	kcsan_nestable_atomic_end();
 }
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 8679322450f2..619be7417420 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -228,10 +228,10 @@ static bool __init test_barrier(void)
 	spin_lock(&test_spinlock);
 	KCSAN_CHECK_RW_BARRIER(spin_unlock(&test_spinlock));
 
-#ifdef clear_bit_unlock_is_negative_byte
-	KCSAN_CHECK_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
-	KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
-	KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
+#ifdef xor_unlock_is_negative_byte
+	KCSAN_CHECK_RW_BARRIER(xor_unlock_is_negative_byte(1, &test_var));
+	KCSAN_CHECK_READ_BARRIER(xor_unlock_is_negative_byte(1, &test_var));
+	KCSAN_CHECK_WRITE_BARRIER(xor_unlock_is_negative_byte(1, &test_var));
 #endif
 	kcsan_nestable_atomic_end();
 
diff --git a/mm/filemap.c b/mm/filemap.c
index e3843cf1d8e1..2db7c5da9e03 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1484,6 +1484,11 @@ void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter)
 }
 EXPORT_SYMBOL_GPL(folio_add_wait_queue);
 
+#ifdef xor_unlock_is_negative_byte
+#define clear_bit_unlock_is_negative_byte(nr, p)	\
+	xor_unlock_is_negative_byte(1 << nr, p)
+#endif
+
 #ifndef clear_bit_unlock_is_negative_byte
 
 /*
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index b61cc6a42541..c1de091dfc92 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1098,9 +1098,10 @@ static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
 	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_change_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = test_bit(nr, addr));
 
-#if defined(clear_bit_unlock_is_negative_byte)
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =
-				clear_bit_unlock_is_negative_byte(nr, addr));
+#if defined(xor_unlock_is_negative_byte)
+	if (nr < 7)
+		KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =
+				xor_unlock_is_negative_byte(1 << nr, addr));
 #endif
 }
 
-- 
2.40.1

