Return-Path: <linux-fsdevel+bounces-64448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88FBE7FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84A0189B4BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2C320CD5;
	Fri, 17 Oct 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxmzYTBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXLovSJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC4320A39;
	Fri, 17 Oct 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695760; cv=none; b=RCTPPwaMzKe/RTI4ksEqu7/RNJ/7NNbZKbhynSz5oy6szrFY/hXjQoBdbcLlxT9uZbKeJnXJnyCaQw2AfpAQ2n9nUsNH/Kmdi1wbj/gMrR3OZH/KNYJIIH2d1Nv2ZB5ZEv+TqhVNtsfrR/s1SM/KHw6wT9RhwajoxnouysTF5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695760; c=relaxed/simple;
	bh=A3pdkVAofqRGXnioJKEyMVyfLGqb8bD7W/o454hellk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BShd1dXseUsQlV5yGoYZybFfC1Sw1slB9zHdQZK552vtRX5U4LXEL2RFvlICBtW/i0/0v9qOeTEuttA845v0y+ycuigVWC8hv+A1B2BgeCkqUgMKsp7M1Ad/vvP3sm6vE5QId8+4tfe1lMNrWdGhzFwrsDC77v+E/rEs/pFS0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxmzYTBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXLovSJd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251017093030.506939239@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760695757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=imtHkr/s1EgDhFpHdqDFKeA7fLJRHDRNr716F17Aia0=;
	b=IxmzYTBfKeP9PdlygwW7c3ZP9RsEre+9I9Ey2tCdF2r4gM5hRSxvZOgB2ZLVGOdPGXmKU1
	+c28eI+CQpneZgUdj/lriB9ag5dTOGtuqXD15nxa5UXlpIpMczCKiocdjT0TVrERWiHUyx
	B1W1XHif/HWSLsDJ1nx87OhoXNRPlg8O5YXz2UGSMHh3EdLm4J1Uj7udO1S/MhoJ2JUuwm
	YRwTS4vWjwKj+jetDYmTFxWTdSdvwVOj336LD4FgupH+XPVMUYSslfG3wlPbFb8EhUw/kW
	9X4Sd0io6pZfWY+0dDBIBCP78dmmq/qY+yUiuFO6HoBDI1YBYics9RbbUuLpQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760695757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=imtHkr/s1EgDhFpHdqDFKeA7fLJRHDRNr716F17Aia0=;
	b=tXLovSJd0rwq2r5yozTcKThhOnpAdq0BuaTsusGQM16gqfWgKUw8QGS1yKgXpz/pjSKgCv
	yXO1lDz+ddt6kiAA==
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
Subject: [patch V3 11/12] x86/futex: Convert to scoped masked user access
References: <20251017085938.150569636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 12:09:16 +0200 (CEST)

Replace the open coded implementation with the scoped masked user access
guards

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
V3: Adapt to scope changes
V2: Convert to scoped masked access
    Use RW access functions - Christophe
---
 arch/x86/include/asm/futex.h |   75 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)
---
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -46,38 +46,31 @@ do {								\
 } while(0)
 
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
-		u32 __user *uaddr)
+						       u32 __user *uaddr)
 {
-	if (can_do_masked_user_access())
-		uaddr = masked_user_access_begin(uaddr);
-	else if (!user_access_begin(uaddr, sizeof(u32)))
-		return -EFAULT;
-
-	switch (op) {
-	case FUTEX_OP_SET:
-		unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
-		break;
-	case FUTEX_OP_ADD:
-		unsafe_atomic_op1(LOCK_PREFIX "xaddl %0, %2", oval,
-				   uaddr, oparg, Efault);
-		break;
-	case FUTEX_OP_OR:
-		unsafe_atomic_op2("orl %4, %3", oval, uaddr, oparg, Efault);
-		break;
-	case FUTEX_OP_ANDN:
-		unsafe_atomic_op2("andl %4, %3", oval, uaddr, ~oparg, Efault);
-		break;
-	case FUTEX_OP_XOR:
-		unsafe_atomic_op2("xorl %4, %3", oval, uaddr, oparg, Efault);
-		break;
-	default:
-		user_access_end();
-		return -ENOSYS;
+	scoped_masked_user_rw_access(uaddr, Efault) {
+		switch (op) {
+		case FUTEX_OP_SET:
+			unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
+			break;
+		case FUTEX_OP_ADD:
+			unsafe_atomic_op1(LOCK_PREFIX "xaddl %0, %2", oval, uaddr, oparg, Efault);
+			break;
+		case FUTEX_OP_OR:
+			unsafe_atomic_op2("orl %4, %3", oval, uaddr, oparg, Efault);
+			break;
+		case FUTEX_OP_ANDN:
+			unsafe_atomic_op2("andl %4, %3", oval, uaddr, ~oparg, Efault);
+			break;
+		case FUTEX_OP_XOR:
+			unsafe_atomic_op2("xorl %4, %3", oval, uaddr, oparg, Efault);
+			break;
+		default:
+			return -ENOSYS;
+		}
 	}
-	user_access_end();
 	return 0;
 Efault:
-	user_access_end();
 	return -EFAULT;
 }
 
@@ -86,21 +79,19 @@ static inline int futex_atomic_cmpxchg_i
 {
 	int ret = 0;
 
-	if (can_do_masked_user_access())
-		uaddr = masked_user_access_begin(uaddr);
-	else if (!user_access_begin(uaddr, sizeof(u32)))
-		return -EFAULT;
-	asm volatile("\n"
-		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
-		"2:\n"
-		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
-		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
-		: "r" (newval), "1" (oldval)
-		: "memory"
-	);
-	user_access_end();
-	*uval = oldval;
+	scoped_masked_user_rw_access(uaddr, Efault) {
+		asm volatile("\n"
+			     "1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
+			     "2:\n"
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
+			     : "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+			     : "r" (newval), "1" (oldval)
+			     : "memory");
+		*uval = oldval;
+	}
 	return ret;
+Efault:
+	return -EFAULT;
 }
 
 #endif


