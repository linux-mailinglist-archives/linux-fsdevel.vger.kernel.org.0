Return-Path: <linux-fsdevel+bounces-65092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEFBBFBEF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD9D1A05E49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C4134676D;
	Wed, 22 Oct 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9i65Wm4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3NMFaOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8C345CCE;
	Wed, 22 Oct 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137354; cv=none; b=pSAKz6hvK4UgOyQ6owiY8saY21uCsjTwb4YvN7r6Pz6w12jCAzNwV/6fnOvM9w3VNvwe0XP02Rmh3aiRSMifUzt3AOXp1egMJPz8OjBhmsqgZBkstgNv9cVWafky2AyYJhQCmn76bIYxZVEvX+uCrJ7eQDnwnvz6Q7UgCbpK+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137354; c=relaxed/simple;
	bh=87O4I+Gs+q+53VRSgJDF74yqnaDGggOQykXNLW0MPKg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YH16wY2ua8PVTdFnesJX0exB/oG+bS5qlkW1RUEvvWID+U/m57n2+wi+/8wt2W3GHJzgRjVpEFH1yRZ72rsXCr2QBedrGiuVpm5X1jyt7hRqx0I9fi7UrVGZTmkAJ8oMaO575CyZLoidUQgrEFS5WhNGFYkjnQ/F6gzFcpY6fPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9i65Wm4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3NMFaOL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103111.980905027@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=riOmJf9FiDkmu6m5dlKP9M/8U5xAklSgvZrcN3Urpuk=;
	b=c9i65Wm4Ndn7xeahqxPTBb1lBCVdU45gHjWmlQg4SLcOj8eWI5HtH7HvaRK1ZUB9k8rBDG
	Gx+1L2LJJs+DE4BUuyz6Xim5IsBGOcpvPeb4SUNSDuQY6R55/sbXPqRaUMCAiy5IS094PX
	lZWMlDtD1VoKF0yg7T1LtnVAYUCmsEfIZ/3UP6zfrlhJaBclsz/Z4EtMyGl7NQ86/R6hqZ
	Z+GDCBGK5+8+cm7t+MbQHYi3nOuNsF10sT8L3BN0VAxIO9btUWTX6jDPdrNue1ezJbyxtY
	LSaElDNUE/TA27K6IKH3FqpttCp8c5IAfDLS7IrI3OfC3bp70o/bRhLrRAomkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=riOmJf9FiDkmu6m5dlKP9M/8U5xAklSgvZrcN3Urpuk=;
	b=N3NMFaOLtlMBqCJ+capZ3I/cpgRy5k1V+/BakEg2gVtf1MEHK6L4ptAYIger3BijJcCLQD
	gGotCKbI0u8BU+Ag==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V4 02/12] uaccess: Provide ASM GOTO safe wrappers for
 unsafe_*_user()
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:04 +0200 (CEST)

ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

bool foo(u32 __user *p, u32 val)
{
	scoped_guard(pagefault)
		unsafe_put_user(val, p, efault);
	return true;
efault:
	return false;
}

 e80:	e8 00 00 00 00       	call   e85 <foo+0x5>
 e85:	65 48 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%rax
 e8d:	83 80 04 14 00 00 01 	addl   $0x1,0x1404(%rax)   // pf_disable++
 e94:	89 37                	mov    %esi,(%rdi)
 e96:	83 a8 04 14 00 00 01 	subl   $0x1,0x1404(%rax)   // pf_disable--
 e9d:	b8 01 00 00 00       	mov    $0x1,%eax           // success
 ea2:	e9 00 00 00 00       	jmp    ea7 <foo+0x27>      // ret
 ea7:	31 c0                	xor    %eax,%eax           // fail
 ea9:	e9 00 00 00 00       	jmp    eae <foo+0x2e>      // ret

which is broken as it leaks the pagefault disable counter on failure.

Clang at least fails the build.

Linus suggested to add a local label into the macro scope and let that
jump to the actual caller supplied error label.

       	__label__ local_label;                                  \
        arch_unsafe_get_user(x, ptr, local_label);              \
	if (0) {                                                \
	local_label:                                            \
		goto label;                                     \

That works for both GCC and clang.

clang:

 c80:	0f 1f 44 00 00       	   nopl   0x0(%rax,%rax,1)	
 c85:	65 48 8b 0c 25 00 00 00 00 mov    %gs:0x0,%rcx
 c8e:	ff 81 04 14 00 00    	   incl   0x1404(%rcx)	   // pf_disable++
 c94:	31 c0                	   xor    %eax,%eax        // set retval to false
 c96:	89 37                      mov    %esi,(%rdi)      // write
 c98:	b0 01                	   mov    $0x1,%al         // set retval to true
 c9a:	ff 89 04 14 00 00    	   decl   0x1404(%rcx)     // pf_disable--
 ca0:	2e e9 00 00 00 00    	   cs jmp ca6 <foo+0x26>   // ret

The exception table entry points correctly to c9a

GCC:

 f70:   e8 00 00 00 00          call   f75 <baz+0x5>
 f75:   65 48 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%rax
 f7d:   83 80 04 14 00 00 01    addl   $0x1,0x1404(%rax)  // pf_disable++
 f84:   8b 17                   mov    (%rdi),%edx
 f86:   89 16                   mov    %edx,(%rsi)
 f88:   83 a8 04 14 00 00 01    subl   $0x1,0x1404(%rax) // pf_disable--
 f8f:   b8 01 00 00 00          mov    $0x1,%eax         // success
 f94:   e9 00 00 00 00          jmp    f99 <baz+0x29>    // ret
 f99:   83 a8 04 14 00 00 01    subl   $0x1,0x1404(%rax) // pf_disable--
 fa0:   31 c0                   xor    %eax,%eax         // fail
 fa2:   e9 00 00 00 00          jmp    fa7 <baz+0x37>    // ret

The exception table entry points correctly to f99

So both compilers optimize out the extra goto and emit correct and
efficient code.

Provide a generic wrapper to do that to avoid modifying all the affected
architecture specific implementation with that workaround.

The only change required for architectures is to rename unsafe_*_user() to
arch_unsafe_*_user(). That's done in subsequent changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/uaccess.h |   72 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -518,7 +518,34 @@ long strncpy_from_user_nofault(char *dst
 		long count);
 long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 
-#ifndef __get_kernel_nofault
+#ifdef arch_get_kernel_nofault
+/*
+ * Wrap the architecture implementation so that @label can be outside of a
+ * cleanup() scope. A regular C goto works correctly, but ASM goto does
+ * not. Clang rejects such an attempt, but GCC silently emits buggy code.
+ */
+#define __get_kernel_nofault(dst, src, type, label)		\
+do {								\
+	__label__ local_label;					\
+	arch_get_kernel_nofault(dst, src, type, local_label);	\
+	if (0) {						\
+	local_label:						\
+		goto label;					\
+	}							\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, label)		\
+do {								\
+	__label__ local_label;					\
+	arch_get_kernel_nofault(dst, src, type, local_label);	\
+	if (0) {						\
+	local_label:						\
+		goto label;					\
+	}							\
+} while (0)
+
+#elif !defined(__get_kernel_nofault) /* arch_get_kernel_nofault */
+
 #define __get_kernel_nofault(dst, src, type, label)	\
 do {							\
 	type __user *p = (type __force __user *)(src);	\
@@ -535,7 +562,8 @@ do {							\
 	if (__put_user(data, p))			\
 		goto label;				\
 } while (0)
-#endif
+
+#endif  /* !__get_kernel_nofault */
 
 /**
  * get_kernel_nofault(): safely attempt to read from a location
@@ -549,7 +577,42 @@ do {							\
 	copy_from_kernel_nofault(&(val), __gk_ptr, sizeof(val));\
 })
 
-#ifndef user_access_begin
+#ifdef user_access_begin
+
+#ifdef arch_unsafe_get_user
+/*
+ * Wrap the architecture implementation so that @label can be outside of a
+ * cleanup() scope. A regular C goto works correctly, but ASM goto does
+ * not. Clang rejects such an attempt, but GCC silently emits buggy code.
+ *
+ * Some architectures use internal local labels already, but this extra
+ * indirection here is harmless because the compiler optimizes it out
+ * completely in any case. This construct just ensures that the ASM GOTO
+ * target is always in the local scope. The C goto 'label' works correct
+ * when leaving a cleanup() scope.
+ */
+#define unsafe_get_user(x, ptr, label)			\
+do {							\
+	__label__ local_label;				\
+	arch_unsafe_get_user(x, ptr, local_label);	\
+	if (0) {					\
+	local_label:					\
+		goto label;				\
+	}						\
+} while (0)
+
+#define unsafe_put_user(x, ptr, label)			\
+do {							\
+	__label__ local_label;				\
+	arch_unsafe_put_user(x, ptr, local_label);	\
+	if (0) {					\
+	local_label:					\
+		goto label;				\
+	}						\
+} while (0)
+#endif /* arch_unsafe_get_user */
+
+#else /* user_access_begin */
 #define user_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
@@ -559,7 +622,8 @@ do {							\
 #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
-#endif
+#endif /* !user_access_begin */
+
 #ifndef user_write_access_begin
 #define user_write_access_begin user_access_begin
 #define user_write_access_end user_access_end


