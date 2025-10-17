Return-Path: <linux-fsdevel+bounces-64444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0385BE7FEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FB56676A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F92B31B13D;
	Fri, 17 Oct 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bb4OS4Rv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TPB8HmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE670314D00;
	Fri, 17 Oct 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695753; cv=none; b=JNdeKgH4zC/Q14LsoEYAOYqDTeXBVGBY2CQBcm9l8vlJ5svX7+hclc6rLEMZ+cwUXQ+N8q9glwx9TmPChR5loVHC/6rdF94ueNpHRKnCF3ojDwafGcKR1+70wt/NIgy36t9QuIPu5xbDub4ZouAmJqmcmpFhfeCQCwRpfWwVMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695753; c=relaxed/simple;
	bh=IVl4st+feujIvIlnJSP0Fen+YcHRaDBvibuIWgq5NI8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o2SIdeI/7yHNT+pSbqK0GpattQXDra9acnmuYUkmfq2sljD5O8a8E3ky4fDu50fnY0/65BSz904KOOSKIq3bkf5diFK3dJ9Om4rlns74fN2lOSa+EoCaNteEWnt3GuX41pyAQ8AZLA6DhCMkTOIctZwXxRgqRQJ7KSvBAsqEuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bb4OS4Rv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TPB8HmZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251017093030.253004391@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760695749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RdcDfhtq167IZPh3ARC9oWqCjxt0RAIa6pkCu2pnJd0=;
	b=Bb4OS4RvAADRftzUP18ntCc+l3Mb2pJChmeCE+m6oV682xSpbE6Il1GzeQChn2Tf3ObOcZ
	WObwc3uW3CVwKN4JXne2ZL8dmGoovgMiMj4Frjn1Z8bSmA3X5PWeApgjgn8dO6n9o94WQ3
	P33rw3cDrlo05oz5pkGxGhWL8+GKzhkFIqTnfjbxLdUjXmhkmftn84uB4GYKbZxHFV6OPz
	2V7Tlti6oi2z0qr7/tjXFjhGSF9hTDPDNrhb6No+HO9cLrXqxbYZCkeV2SfAqZfrAOiB5M
	DxLWbtY9dAeqaDKvkv+bGg3HyeDqkx19oJXOigUJgQt2Y/wivk76WZXUZcfCng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760695749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RdcDfhtq167IZPh3ARC9oWqCjxt0RAIa6pkCu2pnJd0=;
	b=3TPB8HmZ3uCcpKtaZzu7+E2zBu47MJZK4maEFOd1rl22pH918pBZ/AuoYYfoC7FNJW5E8i
	kTR4lwYEKyPPjbCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [patch V3 07/12] uaccess: Provide scoped masked user access regions
References: <20251017085938.150569636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 12:09:08 +0200 (CEST)

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
    	scoped_masked_user_read_access(from, Efault)
		unsafe_get_user(val, from, Efault);
	return 0;
  Efault:
	return -EFAULT;

The scope guarantees the proper cleanup for the access mode is invoked both
in the success and the failure (fault) path.

The scoped_masked_user_$MODE_access() macros are implemented as self
terminating nested for() loops. Thanks to Andrew Cooper for pointing me at
them. The scope can therefore be left with 'break', 'goto' and 'return'.
Even 'continue' "works" due to the self termination mechanism. Both GCC and
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
handed in to scoped_masked_user_$MODE_access() can be modified to point to
a guaranteed faulting user address. This modification is only scope local
as the pointer is aliased inside the scope. When the scope is left the
alias is not longer in effect. IOW the original pointer value is preserved
so it can be used e.g. for fixup or diagnostic purposes in the fault path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
V3: Make it a nested for() loop
    Get rid of the code in macro parameters - Linus
    Provide sized variants - Mathieu
V2: Remove the shady wrappers around the opening and use scopes with automatic cleanup
---
 include/linux/uaccess.h |  197 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

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
 
@@ -633,6 +642,194 @@ static inline void user_access_restore(u
 #define user_read_access_end user_access_end
 #endif
 
+/* Define RW variant so the below _mode macro expansion works */
+#define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
+#define user_rw_access_begin(u, s)	user_access_begin(u, s)
+#define user_rw_access_end()		user_access_end()
+
+/* Scoped user access */
+#define USER_ACCESS_GUARD(_mode)					\
+static __always_inline void __user *					\
+class_masked_user_##_mode##_begin(void __user *ptr)			\
+{									\
+	return ptr;							\
+}									\
+									\
+static __always_inline void						\
+class_masked_user_##_mode##_end(void __user *ptr)			\
+{									\
+	user_##_mode##_access_end();					\
+}									\
+									\
+DEFINE_CLASS(masked_user_ ##_mode## _access, void __user *,		\
+	     class_masked_user_##_mode##_end(_T),			\
+	     class_masked_user_##_mode##_begin(ptr), void __user *ptr)	\
+									\
+static __always_inline class_masked_user_##_mode##_access_t		\
+class_masked_user_##_mode##_access_ptr(void __user *scope)		\
+{									\
+	return scope;							\
+}
+
+USER_ACCESS_GUARD(read)
+USER_ACCESS_GUARD(write)
+USER_ACCESS_GUARD(rw)
+#undef USER_ACCESS_GUARD
+
+/**
+ * __scoped_user_access_begin - Start the masked user access
+ * @_mode:	The mode of the access class (read, write, rw)
+ * @_uptr:	The pointer to access user space memory
+ * @_size:	Size of the access
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * Internal helper for __scoped_masked_user_access(). Don't use directly
+ */
+#define __scoped_user_access_begin(_mode, _uptr, _size, _elbl)		\
+({									\
+	typeof((_uptr)) ____ret;					\
+									\
+	if (can_do_masked_user_access()) {				\
+		____ret = masked_user_##_mode##_access_begin((_uptr));	\
+	} else {							\
+		____ret = _uptr;					\
+		if (!user_##_mode##_access_begin(_uptr, (_size)))	\
+			goto _elbl;					\
+	}								\
+	____ret;							\
+})
+
+/**
+ * __scoped_masked_user_access - Open a scope for masked user access
+ * @_mode:	The mode of the access class (read, write, rw)
+ * @_uptr:	The pointer to access user space memory
+ * @_size:	Size of the access
+ * @_elbl:	Error label to goto when the access region is rejected. It
+ *		must be placed outside the scope.
+ *
+ * If the user access function inside the scope requires a fault label, it
+ * can use @_elvl or a difference label outside the scope, which requires
+ * that user access which is implemented with ASM GOTO has been properly
+ * wrapped. See unsafe_get_user() for reference.
+ *
+ *	scoped_masked_user_rw_access(ptr, efault) {
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
+ * which is determined by @_uptr and @_size is not a valid user space
+ * address, i.e. < TASK_SIZE, the scope sets the pointer to a faulting user
+ * space address and does not terminate early. This optimizes for the good
+ * case and lets the performance uncritical bad case go through the fault.
+ *
+ * The eventual modification of the pointer is limited to the scope.
+ * Outside of the scope the original pointer value is unmodified, so that
+ * the original pointer value is available for diagnostic purposes in an
+ * out of scope fault path.
+ *
+ * Nesting scoped masked user access into a masked user access scope is
+ * invalid and fails the build. Nesting into other guards, e.g. pagefault
+ * is safe.
+ *
+ * Don't use directly. Use the scoped_masked_user_$MODE_access() instead.
+*/
+#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
+for (bool ____stop = false; !____stop; ____stop = true)						\
+	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\
+	     !____stop; ____stop = true)							\
+		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
+		     ____stop = true)					\
+			/* Force modified pointer usage within the scope */			\
+			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\
+				if (1)
+
+/**
+ * scoped_masked_user_read_access_size - Start a scoped user read access with given size
+ * @_usrc:	Pointer to the user space address to read from
+ * @_size:	Size of the access starting from @_usrc
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_read_access_size(_usrc, _size, _elbl)		\
+	__scoped_masked_user_access(read, (_usrc), (_size), _elbl)
+
+/**
+ * scoped_masked_user_read_access - Start a scoped user read access
+ * @_usrc:	Pointer to the user space address to read from
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * The size of the access starting from @_usrc is determined via sizeof(*@_usrc)).
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_read_access(_usrc, _elbl)				\
+	scoped_masked_user_read_access_size((_usrc), sizeof(*(_usrc)), _elbl)
+
+/**
+ * scoped_masked_user_read_end - End a scoped user read access
+ *
+ * Ends the scope opened with scoped_masked_user_read_access[_size]()
+ */
+#define scoped_masked_user_read_end()	__scoped_masked_user_end()
+
+/**
+ * scoped_masked_user_write_access_size - Start a scoped user write access with given size
+ * @_udst:	Pointer to the user space address to write to
+ * @_size:	Size of the access starting from @_udst
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_write_access_size(_udst, _size, _elbl)		\
+	__scoped_masked_user_access(write, (_udst),  (_size), _elbl)
+
+/**
+ * scoped_masked_user_write_access - Start a scoped user write access
+ * @_udst:	Pointer to the user space address to write to
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * The size of the access starting from @_udst is determined via sizeof(*@_udst)).
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_write_access(_udst, _elbl)				\
+	scoped_masked_user_write_access_size((_udst), sizeof(*(_udst)), _elbl)
+
+/**
+ * scoped_masked_user_rw_access_size - Start a scoped user read/write access with given size
+ * @_uptr	Pointer to the user space address to read from and write to
+ * @_size:	Size of the access starting from @_uptr
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_rw_access_size(_uptr, _size, _elbl)			\
+	__scoped_masked_user_access(rw, (_uptr), (_size), _elbl)
+
+/**
+ * scoped_masked_user_rw_access - Start a scoped user read/write access
+ * @_uptr	Pointer to the user space address to read from and write to
+ * @_elbl:	Error label to goto when the access region is rejected.
+ *
+ * The size of the access starting from @_uptr is determined via sizeof(*@_uptr)).
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_rw_access(_uptr, _elbl)				\
+	scoped_masked_user_rw_access_size((_uptr), sizeof(*(_uptr)), _elbl)
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


