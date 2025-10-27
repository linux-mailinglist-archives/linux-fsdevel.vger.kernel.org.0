Return-Path: <linux-fsdevel+bounces-65676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFAEC0C6A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4036C4ED8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70962F6908;
	Mon, 27 Oct 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7URCY0T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ORfe7vG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54C258CF0;
	Mon, 27 Oct 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554631; cv=none; b=pXvrZWEoFlJen6IAaG+e2ahW9Bc4vJHwr+XeNUhTWDw4nhGRyOi1w/q3iTQWN6PZxrWOnzbki1FMGP76Oiq/SNZACYG92F3FcddK3WwbIuMua+VvaA4idqL/FXz3j7IsB4if7x/i8oe9sIyfJdCg65FaLszbeeE773tgMWnkVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554631; c=relaxed/simple;
	bh=1JN45mC64c47dz9TU2Ot3j2U1wNiqKWBKgn8OQGE8ow=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QK1ZQoVL3Arr0SRnthICbhoa0krQaM0o7LEQhNzmEg1nuZDLqq4PRpJMxWfPxaF7lXrbJ1ZpTuJMul2Z/1arkF/LRt8YujdU0FiUh1hm4M1MFbBpjWF9Q6Aw7ujlioJZ52UdHtaB6cZhuCQ0TORpd/HwqkABNgzonBbSj6CYOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7URCY0T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ORfe7vG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027083745.294359925@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=EKzyB0lrI1vv7+y80GeaggsaapcXMx0ewLMg7+vmnx4=;
	b=f7URCY0TR9ngNx+ZE1kYF399YPHlCW2R464N5D1nINUxLVUiedaieiKbYdrtnyP5kNjN0S
	5KssZ03JP1lyw2KPiALYSsZa/q6vKSn+CzHBkjnk8xqYfH4muQNFqw+T+qRjnc/0hhq9Bo
	wRHycNe6JmU69bMgYxKgtgYHCEMMDBGovCmj7rIKGpZHQyN3jBty20W+u10BfNO7bpjM43
	xrTn92A+2N2yyo9uiLanEt0BYKc2uAacE6bah1ytK26+xwgY33tfuL/iEWw3gufhZYW/UN
	O1ArHPyolf7kgV5C7h1MKCVG4+OuP21b9CnAxz7kJXdHu5zqs+gl9xYoYdanFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=EKzyB0lrI1vv7+y80GeaggsaapcXMx0ewLMg7+vmnx4=;
	b=6ORfe7vGObPfrhxyRUXWtMNjB8eOm7ffGS2wmPG+hUOUXR0gNG822D5Mj2JN/tv/It+Bhy
	5UL5oCN2ZCcSYcDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [patch V5 03/12] x86/uaccess: Use unsafe wrappers for ASM GOTO
References: <20251027083700.573016505@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:43:46 +0100 (CET)

ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

bool foo(u32 __user *p, u32 val)
{
	scoped_guard(pagefault)
		unsafe_put_user(val, p, efault);
	return true;
efault:
	return false;
}

It ends up leaking the pagefault disable counter in the fault path. clang
at least fails the build.

Rename unsafe_*_user() to arch_unsafe_*_user() which makes the generic
uaccess header wrap it with a local label that makes both compilers emit
correct code. Same for the kernel_nofault() variants.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/uaccess.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -528,18 +528,18 @@ static __must_check __always_inline bool
 #define user_access_save()	smap_save()
 #define user_access_restore(x)	smap_restore(x)
 
-#define unsafe_put_user(x, ptr, label)	\
+#define arch_unsafe_put_user(x, ptr, label)	\
 	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define unsafe_get_user(x, ptr, err_label)					\
+#define arch_unsafe_get_user(x, ptr, err_label)					\
 do {										\
 	__inttype(*(ptr)) __gu_val;						\
 	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), err_label);		\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 } while (0)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define unsafe_get_user(x, ptr, err_label)					\
+#define arch_unsafe_get_user(x, ptr, err_label)					\
 do {										\
 	int __gu_err;								\
 	__inttype(*(ptr)) __gu_val;						\
@@ -618,11 +618,11 @@ do {									\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)		\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), err_label)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	int __kr_err;							\
 									\
@@ -633,7 +633,7 @@ do {									\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+#define arch_put_kernel_nofault(dst, src, type, err_label)		\
 	__put_user_size(*((type *)(src)), (__force type __user *)(dst),	\
 			sizeof(type), err_label)
 


