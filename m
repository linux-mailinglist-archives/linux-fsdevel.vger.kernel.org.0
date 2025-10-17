Return-Path: <linux-fsdevel+bounces-64464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C2BE8269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9826566497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BD31DDAB;
	Fri, 17 Oct 2025 10:50:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231EB31DDB9;
	Fri, 17 Oct 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698234; cv=none; b=gVuTlxZXrdQAnR0NOV3UB6OsYTszhqHdizo9TKWpLVY0II48SStE9sQKh9TX39snrIHlnDfAB9D1fKH3DwBRRcfHjDytVj5jAH5TIlRHvqnGZBSf6HK9q0HoYcR7txZq3G2jhd5HYiiGmwinGTPHQqr1mA6BLGs5xKhpPPk0E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698234; c=relaxed/simple;
	bh=1n3jix8GAFus2icu2hVBBUdHzlbbrlmGYrh+XGB2nFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5g+egbTfTHq5tVAqmQHtL3dFj9sUat8z4aU24iROMK84oUBbmHkc6nd72t6v9GMoAMyHygQVHFv840KpUkMeyio9bdkhCgEg9aaSMPx62u1yeZj7/gNV3OSKi3t3nT0FnvWmAqItjp45Jkp81XFreDa7vV4S9oI7SFd+Uj+s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cp17z4S6Bz9sSv;
	Fri, 17 Oct 2025 12:21:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Oi-5uUs2W2I; Fri, 17 Oct 2025 12:21:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cp17z2zZkz9sSt;
	Fri, 17 Oct 2025 12:21:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FC4B8B780;
	Fri, 17 Oct 2025 12:21:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2LwN0z7fCh8C; Fri, 17 Oct 2025 12:21:35 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 119018B776;
	Fri, 17 Oct 2025 12:21:34 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 10/10] powerpc/uaccess: Implement masked user access
Date: Fri, 17 Oct 2025 12:21:06 +0200
Message-ID: <179dbcda9eb3bdc5d314c949047db6ef8fd8a2ee.1760529207.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760529207.git.christophe.leroy@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9919; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=1n3jix8GAFus2icu2hVBBUdHzlbbrlmGYrh+XGB2nFw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR8kphynq246FJOj/j+fKEfe4+m+oukT3uw3FIjYO6cm itXXOoOdpSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJ/Cxk+GcsHXm1Zp/tpl2c Tc9Xq/JP/dO+3dou1Szm21H/fXHVP7cy/E9MWSBbKqYvyW+arBNbdmmBpZzUC2ndCr913YufnX6 Zxg4A
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Masked user access avoids the address/size verification by access_ok().
Allthough its main purpose is to skip the speculation in the
verification of user address and size hence avoid the need of spec
mitigation, it also has the advantage of reducing the amount of
instructions required so it even benefits to platforms that don't
need speculation mitigation, especially when the size of the copy is
not know at build time.

So implement masked user access on powerpc. The only requirement is
to have memory gap that faults between the top user space and the
real start of kernel area.

On 64 bits platforms the address space is divided that way:

	0xffffffffffffffff	+------------------+
				|                  |
				|   kernel space   |
 		 		|                  |
	0xc000000000000000	+------------------+  <== PAGE_OFFSET
				|//////////////////|
				|//////////////////|
	0x8000000000000000	|//////////////////|
				|//////////////////|
				|//////////////////|
	0x0010000000000000	+------------------+  <== TASK_SIZE_MAX
				|                  |
				|    user space    |
				|                  |
	0x0000000000000000	+------------------+

Kernel is always above 0x8000000000000000 and user always
below, with a gap in-between. It leads to a 3 instructions sequence:

  20:	7c 69 fe 76 	sradi   r9,r3,63
  24:	7c 69 48 78 	andc    r9,r3,r9
  28:	79 23 00 4c 	rldimi  r3,r9,0,1

This sequence leaves r3 unmodified when it is below 0x8000000000000000
and clamps it to 0x8000000000000000 if it is above.

On 32 bits it is more tricky. In theory user space can go up to
0xbfffffff while kernel will usually start at 0xc0000000. So a gap
needs to be added in-between. Allthough in theory a single 4k page
would suffice, it is easier and more efficient to enforce a 128k gap
below kernel, as it simplifies the masking.

e500 has the isel instruction which allows selecting one value or
the other without branch and that instruction is not speculative, so
use it. Allthough GCC usually generates code using that instruction,
it is safer to use inline assembly to be sure. The result is:

  14:	3d 20 bf fe 	lis     r9,-16386
  18:	7c 03 48 40 	cmplw   r3,r9
  1c:	7c 69 18 5e 	iselgt  r3,r9,r3

On other ones, when kernel space is over 0x80000000 and user space
is below, the logic in mask_user_address_simple() leads to a
3 instruction sequence:

  70:	7c 69 fe 70 	srawi   r9,r3,31
  74:	7c 69 48 78 	andc    r9,r3,r9
  78:	51 23 00 7e 	rlwimi  r3,r9,0,1,31

This is the default on powerpc 8xx.

When the limit between user space and kernel space is not 0x80000000,
mask_user_address_32() is used and a 6 instructions sequence is
generated:

  24:	54 69 7c 7e 	srwi    r9,r3,17
  28:	21 29 57 ff 	subfic  r9,r9,22527
  2c:	7d 29 fe 70 	srawi   r9,r9,31
  30:	75 2a b0 00 	andis.  r10,r9,45056
  34:	7c 63 48 78 	andc    r3,r3,r9
  38:	7c 63 53 78 	or      r3,r3,r10

The constraint is that TASK_SIZE be aligned to 128K in order to get
the most optimal number of instructions.

When CONFIG_PPC_BARRIER_NOSPEC is not defined, fallback on the
test-based masking as it is quicker than the 6 instructions sequence
but not quicker than the 3 instructions sequences above.

As an exemple, allthough barrier_nospec() voids on the 8xx, this
change has the following impact on strncpy_from_user(): the length of
the function is reduced from 488 to 340 bytes:

Start of the function with the patch:

00000000 <strncpy_from_user>:
   0:	7c ab 2b 79 	mr.     r11,r5
   4:	40 81 01 48 	ble     14c <strncpy_from_user+0x14c>
   8:	7c 89 fe 70 	srawi   r9,r4,31
   c:	7c 84 48 78 	andc    r4,r4,r9
  10:	51 24 00 00 	rlwimi  r4,r9,0,0,0
  14:	94 21 ff f0 	stwu    r1,-16(r1)
  18:	3d 20 dc 00 	lis     r9,-9216
  1c:	7d 3a c3 a6 	mtspr   794,r9
  20:	2f 8b 00 03 	cmpwi   cr7,r11,3
  24:	40 9d 00 b8 	ble     cr7,dc <strncpy_from_user+0xdc>
...

Start of the function without the patch:

00000000 <strncpy_from_user>:
   0:	7c a0 2b 79 	mr.     r0,r5
   4:	40 81 01 10 	ble     114 <strncpy_from_user+0x114>
   8:	2f 84 00 00 	cmpwi   cr7,r4,0
   c:	41 9c 01 30 	blt     cr7,13c <strncpy_from_user+0x13c>
  10:	3d 20 80 00 	lis     r9,-32768
  14:	7d 24 48 50 	subf    r9,r4,r9
  18:	7f 80 48 40 	cmplw   cr7,r0,r9
  1c:	7c 05 03 78 	mr      r5,r0
  20:	41 9d 01 00 	bgt     cr7,120 <strncpy_from_user+0x120>
  24:	3d 20 80 00 	lis     r9,-32768
  28:	7d 25 48 50 	subf    r9,r5,r9
  2c:	7f 84 48 40 	cmplw   cr7,r4,r9
  30:	38 e0 ff f2 	li      r7,-14
  34:	41 9d 00 e4 	bgt     cr7,118 <strncpy_from_user+0x118>
  38:	94 21 ff e0 	stwu    r1,-32(r1)
  3c:	3d 20 dc 00 	lis     r9,-9216
  40:	7d 3a c3 a6 	mtspr   794,r9
  44:	2b 85 00 03 	cmplwi  cr7,r5,3
  48:	40 9d 01 6c 	ble     cr7,1b4 <strncpy_from_user+0x1b4>
...
 118:	7c e3 3b 78 	mr      r3,r7
 11c:	4e 80 00 20 	blr
 120:	7d 25 4b 78 	mr      r5,r9
 124:	3d 20 80 00 	lis     r9,-32768
 128:	7d 25 48 50 	subf    r9,r5,r9
 12c:	7f 84 48 40 	cmplw   cr7,r4,r9
 130:	38 e0 ff f2 	li      r7,-14
 134:	41 bd ff e4 	bgt     cr7,118 <strncpy_from_user+0x118>
 138:	4b ff ff 00 	b       38 <strncpy_from_user+0x38>
 13c:	38 e0 ff f2 	li      r7,-14
 140:	4b ff ff d8 	b       118 <strncpy_from_user+0x118>
...

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Rewrite mask_user_address_simple() for a smaller result on powerpc64, suggested by Gabriel

v2: Added 'likely()' to the test in mask_user_address_fallback()
---
 arch/powerpc/include/asm/task_size_32.h |  6 +-
 arch/powerpc/include/asm/uaccess.h      | 79 +++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/task_size_32.h b/arch/powerpc/include/asm/task_size_32.h
index 42a64bbd1964f..725ddbf06217f 100644
--- a/arch/powerpc/include/asm/task_size_32.h
+++ b/arch/powerpc/include/asm/task_size_32.h
@@ -13,7 +13,7 @@
 #define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
 #define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
 #define MODULES_BASE	(MODULES_VADDR & ~(UL(SZ_4M) - 1))
-#define USER_TOP	MODULES_BASE
+#define USER_TOP	(MODULES_BASE - SZ_4M)
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_32
@@ -21,11 +21,11 @@
 #define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
 #define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
 #define MODULES_BASE	(MODULES_VADDR & ~(UL(SZ_256M) - 1))
-#define USER_TOP	MODULES_BASE
+#define USER_TOP	(MODULES_BASE - SZ_4M)
 #endif
 
 #ifndef USER_TOP
-#define USER_TOP	ASM_CONST(CONFIG_PAGE_OFFSET)
+#define USER_TOP	((ASM_CONST(CONFIG_PAGE_OFFSET) - SZ_128K) & ~(UL(SZ_128K) - 1))
 #endif
 
 #if CONFIG_TASK_SIZE < USER_TOP
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 49254f7d90691..a045914fd7135 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -2,6 +2,8 @@
 #ifndef _ARCH_POWERPC_UACCESS_H
 #define _ARCH_POWERPC_UACCESS_H
 
+#include <linux/sizes.h>
+
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/extable.h>
@@ -435,6 +437,83 @@ static __must_check __always_inline bool __user_access_begin(const void __user *
 #define user_access_save	prevent_user_access_return
 #define user_access_restore	restore_user_access
 
+/*
+ * Masking the user address is an alternative to a conditional
+ * user_access_begin that can avoid the fencing. This only works
+ * for dense accesses starting at the address.
+ */
+static inline void __user *mask_user_address_simple(const void __user *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
+	unsigned long sh = BITS_PER_LONG - 1;
+	unsigned long mask = (unsigned long)((long)addr >> sh);
+
+	addr = ((addr & ~mask) & ((1UL << sh) - 1)) | ((mask & 1UL) << sh);
+
+	return (void __user *)addr;
+}
+
+static inline void __user *mask_user_address_isel(const void __user *ptr)
+{
+	unsigned long addr;
+
+	asm("cmplw %1, %2; iselgt %0, %2, %1" : "=r"(addr) : "r"(ptr), "r"(TASK_SIZE) : "cr0");
+
+	return (void __user *)addr;
+}
+
+/* TASK_SIZE is a multiple of 128K for shifting by 17 to the right */
+static inline void __user *mask_user_address_32(const void __user *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
+	unsigned long mask = (unsigned long)((long)((TASK_SIZE >> 17) - 1 - (addr >> 17)) >> 31);
+
+	addr = (addr & ~mask) | (TASK_SIZE & mask);
+
+	return (void __user *)addr;
+}
+
+static inline void __user *mask_user_address_fallback(const void __user *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
+
+	return (void __user *)(likely(addr < TASK_SIZE) ? addr : TASK_SIZE);
+}
+
+static inline void __user *mask_user_address(const void __user *ptr)
+{
+#ifdef MODULES_VADDR
+	const unsigned long border = MODULES_VADDR;
+#else
+	const unsigned long border = PAGE_OFFSET;
+#endif
+
+	if (IS_ENABLED(CONFIG_PPC64))
+		return mask_user_address_simple(ptr);
+	if (IS_ENABLED(CONFIG_E500))
+		return mask_user_address_isel(ptr);
+	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
+		return mask_user_address_simple(ptr);
+	if (IS_ENABLED(CONFIG_PPC_BARRIER_NOSPEC))
+		return mask_user_address_32(ptr);
+	return mask_user_address_fallback(ptr);
+}
+
+static __always_inline void __user *__masked_user_access_begin(const void __user *p,
+							       unsigned long dir)
+{
+	void __user *ptr = mask_user_address(p);
+
+	might_fault();
+	allow_user_access(ptr, dir);
+
+	return ptr;
+}
+
+#define masked_user_access_begin(p) __masked_user_access_begin(p, KUAP_READ_WRITE)
+#define masked_user_read_access_begin(p) __masked_user_access_begin(p, KUAP_READ)
+#define masked_user_write_access_begin(p) __masked_user_access_begin(p, KUAP_WRITE)
+
 #define unsafe_get_user(x, p, e) do {					\
 	__long_type(*(p)) __gu_val;				\
 	__typeof__(*(p)) __user *__gu_addr = (p);		\
-- 
2.49.0


