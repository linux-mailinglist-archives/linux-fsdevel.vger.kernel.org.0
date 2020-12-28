Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28862E34A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 08:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgL1HGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 02:06:33 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45366 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgL1HGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:06:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wetp.zy@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UJxU7k1_1609139138;
Received: from localhost(mailfrom:wetp.zy@linux.alibaba.com fp:SMTPD_---0UJxU7k1_1609139138)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Dec 2020 15:05:43 +0800
From:   Wetp Zhang <wetp.zy@linux.alibaba.com>
To:     artie.ding@linux.alibaba.com
Cc:     alikernel-developer@linux.alibaba.com,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, dvyukov@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Youquan Song <youquan.song@intel.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>
Subject: [PATCH 04/13] x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups
Date:   Mon, 28 Dec 2020 15:04:50 +0800
Message-Id: <1609139095-26337-5-git-send-email-wetp.zy@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1609139095-26337-1-git-send-email-wetp.zy@linux.alibaba.com>
References: <1609139095-26337-1-git-send-email-wetp.zy@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jann Horn <jannh@google.com>

fix #31317281

commit 75045f77f7a73e617494d7a1fcf4e9c1849cec39 upstream
Backport summary: Backport to kernel 4.19.57 to enhance MCA-R for copyin

Currently, most fixups for attempting to access userspace memory are
handled using _ASM_EXTABLE, which is also used for various other types of
fixups (e.g. safe MSR access, IRET failures, and a bunch of other things).
In order to make it possible to add special safety checks to uaccess fixups
(in particular, checking whether the fault address is actually in
userspace), introduce a new exception table handler ex_handler_uaccess()
and wire it up to all the user access fixups (excluding ones that
already use _ASM_EXTABLE_EX).

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: dvyukov@google.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-5-jannh@google.com
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
---
 arch/x86/include/asm/asm.h     |   6 ++
 arch/x86/include/asm/futex.h   |   6 +-
 arch/x86/include/asm/uaccess.h |  16 +++---
 arch/x86/lib/checksum_32.S     |   4 +-
 arch/x86/lib/copy_user_64.S    |  90 ++++++++++++++---------------
 arch/x86/lib/csum-copy_64.S    |   8 ++-
 arch/x86/lib/getuser.S         |  12 ++--
 arch/x86/lib/putuser.S         |  10 ++--
 arch/x86/lib/usercopy_32.c     | 126 ++++++++++++++++++++---------------------
 arch/x86/lib/usercopy_64.c     |   4 +-
 arch/x86/mm/extable.c          |   8 +++
 11 files changed, 154 insertions(+), 136 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 990770f..13fe8d6 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -130,6 +130,9 @@
 # define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
 
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
@@ -182,6 +185,9 @@
 # define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
 
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index de4d688..13c83fe 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -20,7 +20,7 @@
 		     "3:\tmov\t%3, %1\n"			\
 		     "\tjmp\t2b\n"				\
 		     "\t.previous\n"				\
-		     _ASM_EXTABLE(1b, 3b)			\
+		     _ASM_EXTABLE_UA(1b, 3b)			\
 		     : "=r" (oldval), "=r" (ret), "+m" (*uaddr)	\
 		     : "i" (-EFAULT), "0" (oparg), "1" (0))
 
@@ -36,8 +36,8 @@
 		     "4:\tmov\t%5, %1\n"			\
 		     "\tjmp\t3b\n"				\
 		     "\t.previous\n"				\
-		     _ASM_EXTABLE(1b, 4b)			\
-		     _ASM_EXTABLE(2b, 4b)			\
+		     _ASM_EXTABLE_UA(1b, 4b)			\
+		     _ASM_EXTABLE_UA(2b, 4b)			\
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
 		     : "r" (oparg), "i" (-EFAULT), "1" (0))
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index d7ccff5..58929cf 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -198,8 +198,8 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 		     "4:	movl %3,%0\n"				\
 		     "	jmp 3b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 4b)				\
-		     _ASM_EXTABLE(2b, 4b)				\
+		     _ASM_EXTABLE_UA(1b, 4b)				\
+		     _ASM_EXTABLE_UA(2b, 4b)				\
 		     : "=r" (err)					\
 		     : "A" (x), "r" (addr), "i" (errret), "0" (err))
 
@@ -385,7 +385,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 		     "	xor"itype" %"rtype"1,%"rtype"1\n"		\
 		     "	jmp 2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
+		     _ASM_EXTABLE_UA(1b, 3b)				\
 		     : "=r" (err), ltype(x)				\
 		     : "m" (__m(addr)), "i" (errret), "0" (err))
 
@@ -477,7 +477,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 		     "3:	mov %3,%0\n"				\
 		     "	jmp 2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
+		     _ASM_EXTABLE_UA(1b, 3b)				\
 		     : "=r"(err)					\
 		     : ltype(x), "m" (__m(addr)), "i" (errret), "0" (err))
 
@@ -605,7 +605,7 @@ extern void __cmpxchg_wrong_size(void)
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
 			"\t.previous\n"					\
-			_ASM_EXTABLE(1b, 3b)				\
+			_ASM_EXTABLE_UA(1b, 3b)				\
 			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
 			: "i" (-EFAULT), "q" (__new), "1" (__old)	\
 			: "memory"					\
@@ -621,7 +621,7 @@ extern void __cmpxchg_wrong_size(void)
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
 			"\t.previous\n"					\
-			_ASM_EXTABLE(1b, 3b)				\
+			_ASM_EXTABLE_UA(1b, 3b)				\
 			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
 			: "i" (-EFAULT), "r" (__new), "1" (__old)	\
 			: "memory"					\
@@ -637,7 +637,7 @@ extern void __cmpxchg_wrong_size(void)
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
 			"\t.previous\n"					\
-			_ASM_EXTABLE(1b, 3b)				\
+			_ASM_EXTABLE_UA(1b, 3b)				\
 			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
 			: "i" (-EFAULT), "r" (__new), "1" (__old)	\
 			: "memory"					\
@@ -656,7 +656,7 @@ extern void __cmpxchg_wrong_size(void)
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
 			"\t.previous\n"					\
-			_ASM_EXTABLE(1b, 3b)				\
+			_ASM_EXTABLE_UA(1b, 3b)				\
 			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
 			: "i" (-EFAULT), "r" (__new), "1" (__old)	\
 			: "memory"					\
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 46e71a7..ad8e090 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -273,11 +273,11 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst,
 
 #define SRC(y...)			\
 	9999: y;			\
-	_ASM_EXTABLE(9999b, 6001f)
+	_ASM_EXTABLE_UA(9999b, 6001f)
 
 #define DST(y...)			\
 	9999: y;			\
-	_ASM_EXTABLE(9999b, 6002f)
+	_ASM_EXTABLE_UA(9999b, 6002f)
 
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 020f75c..80cfad6 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -92,26 +92,26 @@ ENTRY(copy_user_generic_unrolled)
 60:	jmp copy_user_handle_tail /* ecx is zerorest also */
 	.previous
 
-	_ASM_EXTABLE(1b,30b)
-	_ASM_EXTABLE(2b,30b)
-	_ASM_EXTABLE(3b,30b)
-	_ASM_EXTABLE(4b,30b)
-	_ASM_EXTABLE(5b,30b)
-	_ASM_EXTABLE(6b,30b)
-	_ASM_EXTABLE(7b,30b)
-	_ASM_EXTABLE(8b,30b)
-	_ASM_EXTABLE(9b,30b)
-	_ASM_EXTABLE(10b,30b)
-	_ASM_EXTABLE(11b,30b)
-	_ASM_EXTABLE(12b,30b)
-	_ASM_EXTABLE(13b,30b)
-	_ASM_EXTABLE(14b,30b)
-	_ASM_EXTABLE(15b,30b)
-	_ASM_EXTABLE(16b,30b)
-	_ASM_EXTABLE(18b,40b)
-	_ASM_EXTABLE(19b,40b)
-	_ASM_EXTABLE(21b,50b)
-	_ASM_EXTABLE(22b,50b)
+	_ASM_EXTABLE_UA(1b,30b)
+	_ASM_EXTABLE_UA(2b,30b)
+	_ASM_EXTABLE_UA(3b,30b)
+	_ASM_EXTABLE_UA(4b,30b)
+	_ASM_EXTABLE_UA(5b,30b)
+	_ASM_EXTABLE_UA(6b,30b)
+	_ASM_EXTABLE_UA(7b,30b)
+	_ASM_EXTABLE_UA(8b,30b)
+	_ASM_EXTABLE_UA(9b,30b)
+	_ASM_EXTABLE_UA(10b,30b)
+	_ASM_EXTABLE_UA(11b,30b)
+	_ASM_EXTABLE_UA(12b,30b)
+	_ASM_EXTABLE_UA(13b,30b)
+	_ASM_EXTABLE_UA(14b,30b)
+	_ASM_EXTABLE_UA(15b,30b)
+	_ASM_EXTABLE_UA(16b,30b)
+	_ASM_EXTABLE_UA(18b,40b)
+	_ASM_EXTABLE_UA(19b,40b)
+	_ASM_EXTABLE_UA(21b,50b)
+	_ASM_EXTABLE_UA(22b,50b)
 ENDPROC(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
@@ -156,8 +156,8 @@ ENTRY(copy_user_generic_string)
 	jmp copy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE(1b,11b)
-	_ASM_EXTABLE(3b,12b)
+	_ASM_EXTABLE_UA(1b,11b)
+	_ASM_EXTABLE_UA(3b,12b)
 ENDPROC(copy_user_generic_string)
 EXPORT_SYMBOL(copy_user_generic_string)
 
@@ -189,7 +189,7 @@ ENTRY(copy_user_enhanced_fast_string)
 	jmp copy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE(1b,12b)
+	_ASM_EXTABLE_UA(1b,12b)
 ENDPROC(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
@@ -319,27 +319,27 @@ ENTRY(__copy_user_nocache)
 	jmp copy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE(1b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(2b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(3b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(4b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(5b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(6b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(7b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(8b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(9b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(10b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(11b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(12b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(13b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(14b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(15b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(16b,.L_fixup_4x8b_copy)
-	_ASM_EXTABLE(20b,.L_fixup_8b_copy)
-	_ASM_EXTABLE(21b,.L_fixup_8b_copy)
-	_ASM_EXTABLE(30b,.L_fixup_4b_copy)
-	_ASM_EXTABLE(31b,.L_fixup_4b_copy)
-	_ASM_EXTABLE(40b,.L_fixup_1b_copy)
-	_ASM_EXTABLE(41b,.L_fixup_1b_copy)
+	_ASM_EXTABLE_UA(1b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(2b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(3b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(4b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(5b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(6b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(7b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(8b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(9b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(10b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(11b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(12b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(13b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(14b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(15b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(16b,.L_fixup_4x8b_copy)
+	_ASM_EXTABLE_UA(20b,.L_fixup_8b_copy)
+	_ASM_EXTABLE_UA(21b,.L_fixup_8b_copy)
+	_ASM_EXTABLE_UA(30b,.L_fixup_4b_copy)
+	_ASM_EXTABLE_UA(31b,.L_fixup_4b_copy)
+	_ASM_EXTABLE_UA(40b,.L_fixup_1b_copy)
+	_ASM_EXTABLE_UA(41b,.L_fixup_1b_copy)
 ENDPROC(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index 45a53df..a4a379e 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -31,14 +31,18 @@
 
 	.macro source
 10:
-	_ASM_EXTABLE(10b, .Lbad_source)
+	_ASM_EXTABLE_UA(10b, .Lbad_source)
 	.endm
 
 	.macro dest
 20:
-	_ASM_EXTABLE(20b, .Lbad_dest)
+	_ASM_EXTABLE_UA(20b, .Lbad_dest)
 	.endm
 
+	/*
+	 * No _ASM_EXTABLE_UA; this is used for intentional prefetch on a
+	 * potentially unmapped kernel address.
+	 */
 	.macro ignore L=.Lignore
 30:
 	_ASM_EXTABLE(30b, \L)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 49b167f..74fdff9 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -132,12 +132,12 @@ bad_get_user_8:
 END(bad_get_user_8)
 #endif
 
-	_ASM_EXTABLE(1b,bad_get_user)
-	_ASM_EXTABLE(2b,bad_get_user)
-	_ASM_EXTABLE(3b,bad_get_user)
+	_ASM_EXTABLE_UA(1b, bad_get_user)
+	_ASM_EXTABLE_UA(2b, bad_get_user)
+	_ASM_EXTABLE_UA(3b, bad_get_user)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(4b,bad_get_user)
+	_ASM_EXTABLE_UA(4b, bad_get_user)
 #else
-	_ASM_EXTABLE(4b,bad_get_user_8)
-	_ASM_EXTABLE(5b,bad_get_user_8)
+	_ASM_EXTABLE_UA(4b, bad_get_user_8)
+	_ASM_EXTABLE_UA(5b, bad_get_user_8)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 96dce5fe..d2e5c9c 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -94,10 +94,10 @@ bad_put_user:
 	EXIT
 END(bad_put_user)
 
-	_ASM_EXTABLE(1b,bad_put_user)
-	_ASM_EXTABLE(2b,bad_put_user)
-	_ASM_EXTABLE(3b,bad_put_user)
-	_ASM_EXTABLE(4b,bad_put_user)
+	_ASM_EXTABLE_UA(1b, bad_put_user)
+	_ASM_EXTABLE_UA(2b, bad_put_user)
+	_ASM_EXTABLE_UA(3b, bad_put_user)
+	_ASM_EXTABLE_UA(4b, bad_put_user)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE(5b,bad_put_user)
+	_ASM_EXTABLE_UA(5b, bad_put_user)
 #endif
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 7add8ba..71fb58d 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -47,8 +47,8 @@ static inline int __movsl_is_ok(unsigned long a1, unsigned long a2, unsigned lon
 		"3:	lea 0(%2,%0,4),%0\n"				\
 		"	jmp 2b\n"					\
 		".previous\n"						\
-		_ASM_EXTABLE(0b,3b)					\
-		_ASM_EXTABLE(1b,2b)					\
+		_ASM_EXTABLE_UA(0b, 3b)					\
+		_ASM_EXTABLE_UA(1b, 2b)					\
 		: "=&c"(size), "=&D" (__d0)				\
 		: "r"(size & 3), "0"(size / 4), "1"(addr), "a"(0));	\
 } while (0)
@@ -153,44 +153,44 @@ static inline int __movsl_is_ok(unsigned long a1, unsigned long a2, unsigned lon
 		       "101:   lea 0(%%eax,%0,4),%0\n"
 		       "       jmp 100b\n"
 		       ".previous\n"
-		       _ASM_EXTABLE(1b,100b)
-		       _ASM_EXTABLE(2b,100b)
-		       _ASM_EXTABLE(3b,100b)
-		       _ASM_EXTABLE(4b,100b)
-		       _ASM_EXTABLE(5b,100b)
-		       _ASM_EXTABLE(6b,100b)
-		       _ASM_EXTABLE(7b,100b)
-		       _ASM_EXTABLE(8b,100b)
-		       _ASM_EXTABLE(9b,100b)
-		       _ASM_EXTABLE(10b,100b)
-		       _ASM_EXTABLE(11b,100b)
-		       _ASM_EXTABLE(12b,100b)
-		       _ASM_EXTABLE(13b,100b)
-		       _ASM_EXTABLE(14b,100b)
-		       _ASM_EXTABLE(15b,100b)
-		       _ASM_EXTABLE(16b,100b)
-		       _ASM_EXTABLE(17b,100b)
-		       _ASM_EXTABLE(18b,100b)
-		       _ASM_EXTABLE(19b,100b)
-		       _ASM_EXTABLE(20b,100b)
-		       _ASM_EXTABLE(21b,100b)
-		       _ASM_EXTABLE(22b,100b)
-		       _ASM_EXTABLE(23b,100b)
-		       _ASM_EXTABLE(24b,100b)
-		       _ASM_EXTABLE(25b,100b)
-		       _ASM_EXTABLE(26b,100b)
-		       _ASM_EXTABLE(27b,100b)
-		       _ASM_EXTABLE(28b,100b)
-		       _ASM_EXTABLE(29b,100b)
-		       _ASM_EXTABLE(30b,100b)
-		       _ASM_EXTABLE(31b,100b)
-		       _ASM_EXTABLE(32b,100b)
-		       _ASM_EXTABLE(33b,100b)
-		       _ASM_EXTABLE(34b,100b)
-		       _ASM_EXTABLE(35b,100b)
-		       _ASM_EXTABLE(36b,100b)
-		       _ASM_EXTABLE(37b,100b)
-		       _ASM_EXTABLE(99b,101b)
+		       _ASM_EXTABLE_UA(1b, 100b)
+		       _ASM_EXTABLE_UA(2b, 100b)
+		       _ASM_EXTABLE_UA(3b, 100b)
+		       _ASM_EXTABLE_UA(4b, 100b)
+		       _ASM_EXTABLE_UA(5b, 100b)
+		       _ASM_EXTABLE_UA(6b, 100b)
+		       _ASM_EXTABLE_UA(7b, 100b)
+		       _ASM_EXTABLE_UA(8b, 100b)
+		       _ASM_EXTABLE_UA(9b, 100b)
+		       _ASM_EXTABLE_UA(10b, 100b)
+		       _ASM_EXTABLE_UA(11b, 100b)
+		       _ASM_EXTABLE_UA(12b, 100b)
+		       _ASM_EXTABLE_UA(13b, 100b)
+		       _ASM_EXTABLE_UA(14b, 100b)
+		       _ASM_EXTABLE_UA(15b, 100b)
+		       _ASM_EXTABLE_UA(16b, 100b)
+		       _ASM_EXTABLE_UA(17b, 100b)
+		       _ASM_EXTABLE_UA(18b, 100b)
+		       _ASM_EXTABLE_UA(19b, 100b)
+		       _ASM_EXTABLE_UA(20b, 100b)
+		       _ASM_EXTABLE_UA(21b, 100b)
+		       _ASM_EXTABLE_UA(22b, 100b)
+		       _ASM_EXTABLE_UA(23b, 100b)
+		       _ASM_EXTABLE_UA(24b, 100b)
+		       _ASM_EXTABLE_UA(25b, 100b)
+		       _ASM_EXTABLE_UA(26b, 100b)
+		       _ASM_EXTABLE_UA(27b, 100b)
+		       _ASM_EXTABLE_UA(28b, 100b)
+		       _ASM_EXTABLE_UA(29b, 100b)
+		       _ASM_EXTABLE_UA(30b, 100b)
+		       _ASM_EXTABLE_UA(31b, 100b)
+		       _ASM_EXTABLE_UA(32b, 100b)
+		       _ASM_EXTABLE_UA(33b, 100b)
+		       _ASM_EXTABLE_UA(34b, 100b)
+		       _ASM_EXTABLE_UA(35b, 100b)
+		       _ASM_EXTABLE_UA(36b, 100b)
+		       _ASM_EXTABLE_UA(37b, 100b)
+		       _ASM_EXTABLE_UA(99b, 101b)
 		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 		       :  "1"(to), "2"(from), "0"(size)
 		       : "eax", "edx", "memory");
@@ -259,26 +259,26 @@ static unsigned long __copy_user_intel_nocache(void *to,
 	       "9:      lea 0(%%eax,%0,4),%0\n"
 	       "16:     jmp 8b\n"
 	       ".previous\n"
-	       _ASM_EXTABLE(0b,16b)
-	       _ASM_EXTABLE(1b,16b)
-	       _ASM_EXTABLE(2b,16b)
-	       _ASM_EXTABLE(21b,16b)
-	       _ASM_EXTABLE(3b,16b)
-	       _ASM_EXTABLE(31b,16b)
-	       _ASM_EXTABLE(4b,16b)
-	       _ASM_EXTABLE(41b,16b)
-	       _ASM_EXTABLE(10b,16b)
-	       _ASM_EXTABLE(51b,16b)
-	       _ASM_EXTABLE(11b,16b)
-	       _ASM_EXTABLE(61b,16b)
-	       _ASM_EXTABLE(12b,16b)
-	       _ASM_EXTABLE(71b,16b)
-	       _ASM_EXTABLE(13b,16b)
-	       _ASM_EXTABLE(81b,16b)
-	       _ASM_EXTABLE(14b,16b)
-	       _ASM_EXTABLE(91b,16b)
-	       _ASM_EXTABLE(6b,9b)
-	       _ASM_EXTABLE(7b,16b)
+	       _ASM_EXTABLE_UA(0b, 16b)
+	       _ASM_EXTABLE_UA(1b, 16b)
+	       _ASM_EXTABLE_UA(2b, 16b)
+	       _ASM_EXTABLE_UA(21b, 16b)
+	       _ASM_EXTABLE_UA(3b, 16b)
+	       _ASM_EXTABLE_UA(31b, 16b)
+	       _ASM_EXTABLE_UA(4b, 16b)
+	       _ASM_EXTABLE_UA(41b, 16b)
+	       _ASM_EXTABLE_UA(10b, 16b)
+	       _ASM_EXTABLE_UA(51b, 16b)
+	       _ASM_EXTABLE_UA(11b, 16b)
+	       _ASM_EXTABLE_UA(61b, 16b)
+	       _ASM_EXTABLE_UA(12b, 16b)
+	       _ASM_EXTABLE_UA(71b, 16b)
+	       _ASM_EXTABLE_UA(13b, 16b)
+	       _ASM_EXTABLE_UA(81b, 16b)
+	       _ASM_EXTABLE_UA(14b, 16b)
+	       _ASM_EXTABLE_UA(91b, 16b)
+	       _ASM_EXTABLE_UA(6b, 9b)
+	       _ASM_EXTABLE_UA(7b, 16b)
 	       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 	       :  "1"(to), "2"(from), "0"(size)
 	       : "eax", "edx", "memory");
@@ -321,9 +321,9 @@ unsigned long __copy_user_intel(void __user *to, const void *from,
 		"3:	lea 0(%3,%0,4),%0\n"				\
 		"	jmp 2b\n"					\
 		".previous\n"						\
-		_ASM_EXTABLE(4b,5b)					\
-		_ASM_EXTABLE(0b,3b)					\
-		_ASM_EXTABLE(1b,2b)					\
+		_ASM_EXTABLE_UA(4b, 5b)					\
+		_ASM_EXTABLE_UA(0b, 3b)					\
+		_ASM_EXTABLE_UA(1b, 2b)					\
 		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
 		: "3"(size), "0"(size), "1"(to), "2"(from)		\
 		: "memory");						\
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 9c5606d..fefe6443 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -37,8 +37,8 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
 		"	jmp 2b\n"
 		".previous\n"
-		_ASM_EXTABLE(0b,3b)
-		_ASM_EXTABLE(1b,2b)
+		_ASM_EXTABLE_UA(0b, 3b)
+		_ASM_EXTABLE_UA(1b, 2b)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
 	clac();
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 45f5d6c..dc72b2d 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -108,6 +108,14 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
+bool ex_handler_uaccess(const struct exception_table_entry *fixup,
+				  struct pt_regs *regs, int trapnr)
+{
+	regs->ip = ex_fixup_addr(fixup);
+	return true;
+}
+EXPORT_SYMBOL(ex_handler_uaccess);
+
 __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
 			      struct pt_regs *regs, int trapnr)
 {
-- 
1.8.3.1

