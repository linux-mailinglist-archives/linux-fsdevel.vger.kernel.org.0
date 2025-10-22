Return-Path: <linux-fsdevel+bounces-65093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A66BFBF0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1623C1A06480
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB17347FF3;
	Wed, 22 Oct 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAf/WnRL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fX8cSqvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB57345CD2;
	Wed, 22 Oct 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137357; cv=none; b=JK/rGtmFsIrao/5sfoZHdT1S2uqpVrBP/EQPkogPaIcQRKXZOFACjDyv3uOa5rzqizFdGqS6hbvyKUhC3g4nvAN+9x72r8NW6x8N26nruh7WQ+CbPvJJgJUBjSFPwjr6hojw98SvD4i5o3H+ZDmYzIWSksQdANfhZhdJsPQsAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137357; c=relaxed/simple;
	bh=kv2agbdsqIbzMLDcTPxxSBLHwg3H9gA4/g6IZ/c2ULk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RT2ybre2i6A+ORgynxBlP2yF5oVB9ZBqH9doveqltAD0L4auCbJ35PSYU2B/83dzooX6XjOOZZwq4xfUv7dCw3e8h0bKNBzouwDF+9fhGfBJ8FZNo3sfPkpmFyWqQZgYtKlmTsfYjsbVuddIn3W19hBCWg3FUS3Cr55IPCiIwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAf/WnRL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fX8cSqvU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103112.105759469@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DNQHcterXWXQuFWR5KPGbkzD3Sh/vJk9lLVEwO1xPSA=;
	b=vAf/WnRLaiKi9WWTSyH8iUQzQkrzGIljwJslh19+BsVaPrUUzz8NaG/EydNMY5AOh/DPNQ
	FlAdck5UN2A659HwOPkIYdFRxOmypbXSalDO84wkV/SAikEYWifJGPpjoQHalxcV4Lf/74
	OgkhQ3pkA+3fk2fPutZTvbNmP7gx1gUr3DclJycvX75iZF036Cnxq7tl5CMsOBm8DAkZG0
	wFvXbnrq3D20XGC/xN2CIj8+NUzQHTWrFlkDIPqA/TDOqQK+sSj4nfwQQ6rYXxudQKYBUn
	ciZsu5fNoy2U525hHELagiJeV93MjGckgbHPoy6DCobfk74daY6DlAlnC2eJ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DNQHcterXWXQuFWR5KPGbkzD3Sh/vJk9lLVEwO1xPSA=;
	b=fX8cSqvU/uRXynxs8KXcle/JVqevyF+HtGxR5AgUEogTAFIK4EpPFW7QD8ucjN5XqCzEmR
	PFxjDjDc5cEYfhCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org,
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
Subject: [patch V4 04/12] powerpc/uaccess: Use unsafe wrappers for ASM GOTO
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:06 +0200 (CEST)

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
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/uaccess.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -451,7 +451,7 @@ user_write_access_begin(const void __use
 #define user_write_access_begin	user_write_access_begin
 #define user_write_access_end		prevent_current_write_to_user
 
-#define unsafe_get_user(x, p, e) do {					\
+#define arch_unsafe_get_user(x, p, e) do {			\
 	__long_type(*(p)) __gu_val;				\
 	__typeof__(*(p)) __user *__gu_addr = (p);		\
 								\
@@ -459,7 +459,7 @@ user_write_access_begin(const void __use
 	(x) = (__typeof__(*(p)))__gu_val;			\
 } while (0)
 
-#define unsafe_put_user(x, p, e) \
+#define arch_unsafe_put_user(x, p, e)				\
 	__put_user_size_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
 
 #define unsafe_copy_from_user(d, s, l, e) \
@@ -504,11 +504,11 @@ do {									\
 		unsafe_put_user(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e); \
 } while (0)
 
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)		\
 	__get_user_size_goto(*((type *)(dst)),				\
 		(__force type __user *)(src), sizeof(type), err_label)
 
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+#define arch_put_kernel_nofault(dst, src, type, err_label)		\
 	__put_user_size_goto(*((type *)(src)),				\
 		(__force type __user *)(dst), sizeof(type), err_label)
 


