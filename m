Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100E4146896
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAWNAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 08:00:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30497 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgAWNAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:00:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483Mn95Q9Nz9vB4m;
        Thu, 23 Jan 2020 13:59:57 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rm/2qf+r; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VPNpAqKhQ0dN; Thu, 23 Jan 2020 13:59:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483Mn94NDjz9vB4X;
        Thu, 23 Jan 2020 13:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579784397; bh=2yOjkw9m1uEpm7zxUYT3EfexfCnLtwBekkcTKmBrIPM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=rm/2qf+rqZuvCf1awr06co0x+fEcX5QE2mHwQBjSCJnbwrMeCOpTSobLhNzccUXkE
         HRlhiYNqKu5ahG7q8SqKcHXpfTjYu/Pezk7rlv8AUF2HrMAxURRSpzDBAgWHxLEhgQ
         Yd5qEOuoKomtvWt/Bcm8qv1HSJOeigH+pwocxVG8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D79468B82C;
        Thu, 23 Jan 2020 13:59:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p7cn4rlmlrk1; Thu, 23 Jan 2020 13:59:58 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C1FA8B826;
        Thu, 23 Jan 2020 13:59:58 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 638C9651C0; Thu, 23 Jan 2020 12:59:58 +0000 (UTC)
Message-Id: <4cf9d1d96e2d4f7c196eb492501362b533f0fd4b.1579783936.git.christophe.leroy@c-s.fr>
In-Reply-To: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 7/7] powerpc: Implement user_access_begin and friends
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 23 Jan 2020 12:59:58 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Today, when a function like strncpy_from_user() is called,
the userspace access protection is de-activated and re-activated
for every word read.

By implementing user_access_begin and friends, the protection
is de-activated at the beginning of the copy and re-activated at the
end.

Implement user_access_begin(), user_access_end() and
unsafe_get_user(), unsafe_put_user() and unsafe_copy_to_user()

For the time being, we keep user_access_save() and
user_access_restore() as nops.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: adapted to the new format of user_access_begin/end()
---
 arch/powerpc/include/asm/uaccess.h | 100 ++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index cafad1960e76..30204e80df1b 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -91,9 +91,14 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 	__put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
 #define __get_user(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
+	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), true)
 #define __put_user(x, ptr) \
-	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
+	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), true)
+
+#define __get_user_allowed(x, ptr) \
+	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
+#define __put_user_allowed(x, ptr) \
+	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), false)
 
 #define __get_user_inatomic(x, ptr) \
 	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
@@ -138,10 +143,9 @@ extern long __put_user_bad(void);
 		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
 #endif /* __powerpc64__ */
 
-#define __put_user_size(x, ptr, size, retval)			\
+#define __put_user_size_allowed(x, ptr, size, retval)		\
 do {								\
 	retval = 0;						\
-	allow_write_to_user(ptr, size);				\
 	switch (size) {						\
 	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
 	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
@@ -149,17 +153,26 @@ do {								\
 	  case 8: __put_user_asm2(x, ptr, retval); break;	\
 	  default: __put_user_bad();				\
 	}							\
+} while (0)
+
+#define __put_user_size(x, ptr, size, retval)			\
+do {								\
+	allow_write_to_user(ptr, size);				\
+	__put_user_size_allowed(x, ptr, size, retval);		\
 	prevent_write_to_user(ptr, size);			\
 } while (0)
 
-#define __put_user_nocheck(x, ptr, size)			\
+#define __put_user_nocheck(x, ptr, size, allow)			\
 ({								\
 	long __pu_err;						\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
 	if (!is_kernel_addr((unsigned long)__pu_addr))		\
 		might_fault();					\
 	__chk_user_ptr(ptr);					\
-	__put_user_size((x), __pu_addr, (size), __pu_err);	\
+	if (allow)								\
+		__put_user_size((x), __pu_addr, (size), __pu_err);		\
+	else									\
+		__put_user_size_allowed((x), __pu_addr, (size), __pu_err);	\
 	__pu_err;						\
 })
 
@@ -236,13 +249,12 @@ extern long __get_user_bad(void);
 		: "b" (addr), "i" (-EFAULT), "0" (err))
 #endif /* __powerpc64__ */
 
-#define __get_user_size(x, ptr, size, retval)			\
+#define __get_user_size_allowed(x, ptr, size, retval)		\
 do {								\
 	retval = 0;						\
 	__chk_user_ptr(ptr);					\
 	if (size > sizeof(x))					\
 		(x) = __get_user_bad();				\
-	allow_read_from_user(ptr, size);			\
 	switch (size) {						\
 	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
 	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
@@ -250,6 +262,12 @@ do {								\
 	case 8: __get_user_asm2(x, ptr, retval);  break;	\
 	default: (x) = __get_user_bad();			\
 	}							\
+} while (0)
+
+#define __get_user_size(x, ptr, size, retval)			\
+do {								\
+	allow_read_from_user(ptr, size);			\
+	__get_user_size_allowed(x, ptr, size, retval);		\
 	prevent_read_from_user(ptr, size);			\
 } while (0)
 
@@ -260,7 +278,7 @@ do {								\
 #define __long_type(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
-#define __get_user_nocheck(x, ptr, size)			\
+#define __get_user_nocheck(x, ptr, size, allow)			\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
@@ -269,7 +287,10 @@ do {								\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
 	barrier_nospec();					\
-	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	if (allow)								\
+		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);		\
+	else									\
+		__get_user_size_allowed(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
 })
@@ -387,6 +408,34 @@ static inline unsigned long raw_copy_to_user(void __user *to,
 	return ret;
 }
 
+static inline unsigned long
+raw_copy_to_user_allowed(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	if (__builtin_constant_p(n) && (n) <= 8) {
+		ret = 1;
+
+		switch (n) {
+		case 1:
+			__put_user_size_allowed(*(u8 *)from, (u8 __user *)to, 1, ret);
+			break;
+		case 2:
+			__put_user_size_allowed(*(u16 *)from, (u16 __user *)to, 2, ret);
+			break;
+		case 4:
+			__put_user_size_allowed(*(u32 *)from, (u32 __user *)to, 4, ret);
+			break;
+		case 8:
+			__put_user_size_allowed(*(u64 *)from, (u64 __user *)to, 8, ret);
+			break;
+		}
+		if (ret == 0)
+			return 0;
+	}
+
+	return __copy_tofrom_user(to, (__force const void __user *)from, n);
+}
+
 static __always_inline unsigned long __must_check
 copy_to_user_mcsafe(void __user *to, const void *from, unsigned long n)
 {
@@ -428,4 +477,35 @@ extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 			   size_t len);
 
+static __must_check inline unsigned long
+user_access_begin(const void __user *ptr, size_t len, bool write)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return 0;
+	return allow_user_access((void __user *)ptr, ptr, len, write ? KUAP_RW : KUAP_R);
+}
+#define user_access_begin	user_access_begin
+
+static inline void user_access_end(unsigned long key)
+{
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_32)) {
+		void __user *ptr = (__force void __user *)(key & 0xf0000000);
+		u32 size = (key << 28) - (key & 0xf0000000);
+
+		prevent_user_access(ptr, ptr, size, key & 0xf000000f ? KUAP_RW : KUAP_R);
+	} else {
+		prevent_user_access(NULL, NULL, ~0UL, KUAP_RW);
+	}
+}
+#define user_access_end		user_access_end
+
+static inline unsigned long user_access_save(void) { return 0UL; }
+static inline void user_access_restore(unsigned long flags) { }
+
+#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
+#define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
+#define unsafe_put_user(x, p, e) unsafe_op_wrap(__put_user_allowed(x, p), e)
+#define unsafe_copy_to_user(d, s, l, e) \
+	unsafe_op_wrap(raw_copy_to_user_allowed(d, s, l), e)
+
 #endif	/* _ARCH_POWERPC_UACCESS_H */
-- 
2.25.0

