Return-Path: <linux-fsdevel+bounces-65099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36247BFBF5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3201A0683F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572334889C;
	Wed, 22 Oct 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KACg23qg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zp+bUtbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6234677D;
	Wed, 22 Oct 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137370; cv=none; b=LVpEFig0xZzVCO5r5qubNttb0iH8DMFHn42CSTAAvgnU3BFDf0bI2gtydugzN7lLL8bAFVHe5C3lvCgnqkCa1lQjpaPTORQzRXK/GlPfm2YsI5EOVn3Lkw2vardJ5e4cGgRo/D62lQ9D2hH/2ZcekoPLb1TOGeItkudtEowzfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137370; c=relaxed/simple;
	bh=ayo+bEGTx89l93m5cFVtFn3rRxx45tVRUcaklRv3XSM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hihI5WwUevF2HP1S13jJVXd3gT08QwKvyHr36/TSy7rfLZpttWKjrZ+CJJAqO0sJtYi5d46RplpzdPMiUplYeE+kAoYXqj88eM8RQ+X8Qlbc7wvAd+xjWrfDr2yO8TlcM8AhkQjYh0CvnM+Na9DYADib2CCrvc+1p6+otLVzQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KACg23qg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zp+bUtbt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103112.294959046@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZrsCoY/QONubl8AjZs982M2i5AjJzlGkiHAIdVey4uk=;
	b=KACg23qgbkFGXQoo0kqi+ZPz8Baad0b1shJNImHpfDMP/nf+7eWWrQ1QpqjxUaIFzCHe7R
	23+x5ZTQyyoTHcohqSI/yGLNBN14P5UxLJWmYMo2ZRzK5mcSGBtbK3EP1UuT1Y3L067aey
	YeGIy9U/g7RPf2hMqwMjdEBSju6kRqYjGbmNRAFdamCORzwncQOSdo4Rn/CABzCadW1V/6
	r8jH+C3ywmb3Qre5cpcmoGW3y4t/p1Gzb1PW0nIDrIWOQhxoNB5iNi7dkmoSova61L7gig
	HaiEXsWdPrKBOnq4N0SX3Sqs6VKMbD5Ju+UGLWfugaM1NBk4Ev/6pMN/tn0SHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZrsCoY/QONubl8AjZs982M2i5AjJzlGkiHAIdVey4uk=;
	b=zp+bUtbtBsddzgv+Dhge+Da3J0tXeQv9UILGjSAPdB4LQVAAanZhTFOKFzMlv2SlJRapup
	vlFayivX/jGk6XBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
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
Subject: [patch V4 07/12] uaccess: Provide scoped user access regions
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:10 +0200 (CEST)

User space access regions are tedious and require similar code patterns all
over the place:

     	if (!user_read_access_begin(from, sizeof(*from)))
		return -EFAULT;
	unsafe_get_user(val, from, Efault);
	user_read_access_end();
	return 0;
Efault:
	user_read_access_end();
	return -EFAULT;

This got worse with the recent addition of masked user access, which
optimizes the speculation prevention:

	if (can_do_masked_user_access())
		from = masked_user_read_access_begin((from));
	else if (!user_read_access_begin(from, sizeof(*from)))
		return -EFAULT;
	unsafe_get_user(val, from, Efault);
	user_read_access_end();
	return 0;
Efault:
	user_read_access_end();
	return -EFAULT;

There have been issues with using the wrong user_*_access_end() variant in
the error path and other typical Copy&Pasta problems, e.g. using the wrong
fault label in the user accessor which ends up using the wrong accesss end
variant. 

These patterns beg for scopes with automatic cleanup. The resulting outcome
is:
    	scoped_user_read_access(from, Efault)
		unsafe_get_user(val, from, Efault);
	return 0;
  Efault:
	return -EFAULT;

The scope guarantees the proper cleanup for the access mode is invoked both
in the success and the failure (fault) path.

The scoped_user_$MODE_access() macros are implemented as self terminating
nested for() loops. Thanks to Andrew Cooper for pointing me at them. The
scope can therefore be left with 'break', 'goto' and 'return'.  Even
'continue' "works" due to the self termination mechanism. Both GCC and
clang optimize all the convoluted macro maze out and the above results with
clang in:

 b80:	f3 0f 1e fa          	       endbr64
 b84:	48 b8 ef cd ab 89 67 45 23 01  movabs $0x123456789abcdef,%rax
 b8e:	48 39 c7    	               cmp    %rax,%rdi
 b91:	48 0f 47 f8          	       cmova  %rax,%rdi
 b95:	90                   	       nop
 b96:	90                   	       nop
 b97:	90                   	       nop
 b98:	31 c9                	       xor    %ecx,%ecx
 b9a:	8b 07                	       mov    (%rdi),%eax
 b9c:	89 06                	       mov    %eax,(%rsi)
 b9e:	85 c9                	       test   %ecx,%ecx
 ba0:	0f 94 c0             	       sete   %al
 ba3:	90                   	       nop
 ba4:	90                   	       nop
 ba5:	90                   	       nop
 ba6:	c3                   	       ret

Which looks as compact as it gets. The NOPs are placeholder for STAC/CLAC.
GCC emits the fault path seperately:

 bf0:	f3 0f 1e fa          	       endbr64
 bf4:	48 b8 ef cd ab 89 67 45 23 01  movabs $0x123456789abcdef,%rax
 bfe:	48 39 c7             	       cmp    %rax,%rdi
 c01:	48 0f 47 f8          	       cmova  %rax,%rdi
 c05:	90                   	       nop
 c06:	90                   	       nop
 c07:	90                   	       nop
 c08:	31 d2                	       xor    %edx,%edx
 c0a:	8b 07                	       mov    (%rdi),%eax
 c0c:	89 06                	       mov    %eax,(%rsi)
 c0e:	85 d2                	       test   %edx,%edx
 c10:	75 09                	       jne    c1b <afoo+0x2b>
 c12:	90                   	       nop
 c13:	90                   	       nop
 c14:	90                   	       nop
 c15:	b8 01 00 00 00       	       mov    $0x1,%eax
 c1a:	c3                   	       ret
 c1b:	90                   	       nop
 c1c:	90                   	       nop
 c1d:	90                   	       nop
 c1e:	31 c0                	       xor    %eax,%eax
 c20:	c3                   	       ret


The fault labels for the scoped*() macros and the fault labels for the
actual user space accessors can be shared and must be placed outside of the
scope.

If masked user access is enabled on an architecture, then the pointer
handed in to scoped_user_$MODE_access() can be modified to point to a
guaranteed faulting user address. This modification is only scope local as
the pointer is aliased inside the scope. When the scope is left the alias
is not longer in effect. IOW the original pointer value is preserved so it
can be used e.g. for fixup or diagnostic purposes in the fault path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>
---
V4: Remove the _masked_ naming as it's actually confusing - David
    Remove underscores and make _tmpptr void - David
    Add comment about access size and range - David
    Shorten local variables and remove a few unneeded brackets - Mathieu
V3: Make it a nested for() loop
    Get rid of the code in macro parameters - Linus
    Provide sized variants - Mathieu
V2: Remove the shady wrappers around the opening and use scopes with automatic cleanup
---
 include/linux/uaccess.h |  192 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/cleanup.h>
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
@@ -35,9 +36,17 @@
 
 #ifdef masked_user_access_begin
  #define can_do_masked_user_access() 1
+# ifndef masked_user_write_access_begin
+#  define masked_user_write_access_begin masked_user_access_begin
+# endif
+# ifndef masked_user_read_access_begin
+#  define masked_user_read_access_begin masked_user_access_begin
+#endif
 #else
  #define can_do_masked_user_access() 0
  #define masked_user_access_begin(src) NULL
+ #define masked_user_read_access_begin(src) NULL
+ #define masked_user_write_access_begin(src) NULL
  #define mask_user_address(src) (src)
 #endif
 
@@ -633,6 +642,189 @@ static inline void user_access_restore(u
 #define user_read_access_end user_access_end
 #endif
 
+/* Define RW variant so the below _mode macro expansion works */
+#define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
+#define user_rw_access_begin(u, s)	user_access_begin(u, s)
+#define user_rw_access_end()		user_access_end()
+
+/* Scoped user access */
+#define USER_ACCESS_GUARD(_mode)				\
+static __always_inline void __user *				\
+class_user_##_mode##_begin(void __user *ptr)			\
+{								\
+	return ptr;						\
+}								\
+								\
+static __always_inline void					\
+class_user_##_mode##_end(void __user *ptr)			\
+{								\
+	user_##_mode##_access_end();				\
+}								\
+								\
+DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
+	     class_user_##_mode##_end(_T),			\
+	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
+								\
+static __always_inline class_user_##_mode##_access_t		\
+class_user_##_mode##_access_ptr(void __user *scope)		\
+{								\
+	return scope;						\
+}
+
+USER_ACCESS_GUARD(read)
+USER_ACCESS_GUARD(write)
+USER_ACCESS_GUARD(rw)
+#undef USER_ACCESS_GUARD
+
+/**
+ * __scoped_user_access_begin - Start a scoped user access
+ * @mode:	The mode of the access class (read, write, rw)
+ * @uptr:	The pointer to access user space memory
+ * @size:	Size of the access
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * Internal helper for __scoped_user_access(). Don't use directly
+ */
+#define __scoped_user_access_begin(mode, uptr, size, elbl)		\
+({									\
+	typeof(uptr) __retptr;						\
+									\
+	if (can_do_masked_user_access()) {				\
+		__retptr = masked_user_##mode##_access_begin(uptr);	\
+	} else {							\
+		__retptr = uptr;					\
+		if (!user_##mode##_access_begin(uptr, size))		\
+			goto elbl;					\
+	}								\
+	__retptr;							\
+})
+
+/**
+ * __scoped_user_access - Open a scope for user access
+ * @mode:	The mode of the access class (read, write, rw)
+ * @uptr:	The pointer to access user space memory
+ * @size:	Size of the access
+ * @elbl:	Error label to goto when the access region is rejected. It
+ *		must be placed outside the scope
+ *
+ * If the user access function inside the scope requires a fault label, it
+ * can use @elvl or a different label outside the scope, which requires
+ * that user access which is implemented with ASM GOTO has been properly
+ * wrapped. See unsafe_get_user() for reference.
+ *
+ *	scoped_user_rw_access(ptr, efault) {
+ *		unsafe_get_user(rval, &ptr->rval, efault);
+ *		unsafe_put_user(wval, &ptr->wval, efault);
+ *	}
+ *	return 0;
+ *  efault:
+ *	return -EFAULT;
+ *
+ * The scope is internally implemented as a autoterminating nested for()
+ * loop, which can be left with 'return', 'break' and 'goto' at any
+ * point.
+ *
+ * When the scope is left user_##@_mode##_access_end() is automatically
+ * invoked.
+ *
+ * When the architecture supports masked user access and the access region
+ * which is determined by @uptr and @size is not a valid user space
+ * address, i.e. < TASK_SIZE, the scope sets the pointer to a faulting user
+ * space address and does not terminate early. This optimizes for the good
+ * case and lets the performance uncritical bad case go through the fault.
+ *
+ * The eventual modification of the pointer is limited to the scope.
+ * Outside of the scope the original pointer value is unmodified, so that
+ * the original pointer value is available for diagnostic purposes in an
+ * out of scope fault path.
+ *
+ * Nesting scoped user access into a user access scope is invalid and fails
+ * the build. Nesting into other guards, e.g. pagefault is safe.
+ *
+ * The masked variant does not check the size of the access and relies on a
+ * mapping hole (e.g. guard page) to catch an out of range pointer, the
+ * first access to user memory inside the scope has to be within
+ * @uptr ... @uptr + PAGE_SIZE - 1
+ *
+ * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
+ */
+#define __scoped_user_access(mode, uptr, size, elbl)					\
+for (bool done = false; !done; done = true)						\
+	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
+	     !done; done = true)							\
+		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
+			/* Force modified pointer usage within the scope */		\
+			for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
+
+/**
+ * scoped_user_read_access_size - Start a scoped user read access with given size
+ * @usrc:	Pointer to the user space address to read from
+ * @size:	Size of the access starting from @usrc
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * For further information see __scoped_user_access() above.
+ */
+#define scoped_user_read_access_size(usrc, size, elbl)		\
+	__scoped_user_access(read, usrc, size, elbl)
+
+/**
+ * scoped_user_read_access - Start a scoped user read access
+ * @usrc:	Pointer to the user space address to read from
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * The size of the access starting from @usrc is determined via sizeof(*@usrc)).
+ *
+ * For further information see __scoped_user_access() above.
+ */
+#define scoped_user_read_access(usrc, elbl)				\
+	scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
+
+/**
+ * scoped_user_write_access_size - Start a scoped user write access with given size
+ * @udst:	Pointer to the user space address to write to
+ * @size:	Size of the access starting from @udst
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * For further information see __scoped_user_access() above.
+ */
+#define scoped_user_write_access_size(udst, size, elbl)			\
+	__scoped_user_access(write, udst, size, elbl)
+
+/**
+ * scoped_user_write_access - Start a scoped user write access
+ * @udst:	Pointer to the user space address to write to
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * The size of the access starting from @udst is determined via sizeof(*@udst)).
+ *
+ * For further information see __scoped_user_access() above.
+ */
+#define scoped_user_write_access(udst, elbl)				\
+	scoped_user_write_access_size(udst, sizeof(*(udst)), elbl)
+
+/**
+ * scoped_user_rw_access_size - Start a scoped user read/write access with given size
+ * @uptr	Pointer to the user space address to read from and write to
+ * @size:	Size of the access starting from @uptr
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * For further information see __scoped_user_access() above.
+ */
+#define scoped_user_rw_access_size(uptr, size, elbl)			\
+	__scoped_user_access(rw, uptr, size, elbl)
+
+/**
+ * scoped_user_rw_access - Start a scoped user read/write access
+ * @uptr	Pointer to the user space address to read from and write to
+ * @elbl:	Error label to goto when the access region is rejected
+ *
+ * The size of the access starting from @uptr is determined via sizeof(*@uptr)).
+ *
+ * For further information see __scoped_user_access() above.
+ */
+#define scoped_user_rw_access(uptr, elbl)				\
+	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


