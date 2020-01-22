Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831761454A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAVNAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 08:00:46 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20177 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgAVNAn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:00:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482lrS0DFgz9v4T8;
        Wed, 22 Jan 2020 14:00:40 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=o9cOnFWn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l9lUUoeq3LIb; Wed, 22 Jan 2020 14:00:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482lrR6HWFz9v4T4;
        Wed, 22 Jan 2020 14:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579698039; bh=hKGhpEY/x7wBpxih4NYfDSLkqEe5Ff+wX5RSYhSgSVk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=o9cOnFWnAqB4L16AUF6H2qiIduMP60GsCai6G6umaXoGH29mIiBYnpts6GXxd+ZLn
         qBAh7Zw9paYWGRVSsaBmE53dVBBu7I55rQ2toxAF2h2cvmKHl/Qm99GuoqfbaZ31Q7
         TBFyub2p0GKCAA390AbUix6DOhU5DsXK6nIaLZIQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 333DC8B801;
        Wed, 22 Jan 2020 14:00:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CTXiePye0Yze; Wed, 22 Jan 2020 14:00:41 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CCCE28B800;
        Wed, 22 Jan 2020 14:00:40 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C5305651E0; Wed, 22 Jan 2020 13:00:40 +0000 (UTC)
Message-Id: <35afa6bd5d0d645294afa4078e52f16765e494e9.1579697910.git.christophe.leroy@c-s.fr>
In-Reply-To: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 6/6] powerpc: Implement user_access_begin and friends
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 22 Jan 2020 13:00:40 +0000 (UTC)
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
 arch/powerpc/include/asm/uaccess.h | 92 ++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index cafad1960e76..ea67bbd56bd4 100644
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
@@ -428,4 +477,27 @@ extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 			   size_t len);
 
+static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+	allow_read_write_user((void __user *)ptr, ptr, len);
+	return true;
+}
+#define user_access_begin	user_access_begin
+
+static inline void user_access_end(void)
+{
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_SELF);
+}
+#define user_access_end		user_access_end
+
+static inline unsigned long user_access_save(void) { return 0UL; }
+static inline void user_access_restore(unsigned long flags) { }
+
+#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
+#define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user_allowed(x,p),e)
+#define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user_allowed(x,p),e)
+#define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(raw_copy_to_user_allowed(d,s,l),e)
+
 #endif	/* _ARCH_POWERPC_UACCESS_H */
-- 
2.25.0

