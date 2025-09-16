Return-Path: <linux-fsdevel+bounces-61787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07474B59DD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6556C7A72B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E131E881;
	Tue, 16 Sep 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqI77ncK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJWEH9EO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EF21D58B;
	Tue, 16 Sep 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040404; cv=none; b=Oqj8Wvd52CaNyh0bTmZF1ne13He1g0syIc26bM42hV1fezTYpFu/vlpCbYdF3XCK7T9AOUE6eZhQMSTjtXhvig5JSaky598mB5e71BxUZQCq5rMqRAVpYjBm+T6MykUxYdGPoMWFN+YLW1CglidgV+mVQ05T4odD9h5zfRHv8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040404; c=relaxed/simple;
	bh=DYq2lXp98iL86huuVJGCtWOvblonl+oOJShJAfJDPJA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ur6JmNTR7X3d3Q/KORWsba7ILdHooTDbxQQX11Z1VGYXhjk8GI2yUZfZrdlaCLRjO2+zvSECCfEWE6xUmWphmTFjpHpflNjF4YEBayJQsldtqEt+CebzXoCo0bw53tANq5TXcvmlJWeg081C39MVVuWGTIxZD+0FmMsMl/nZR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqI77ncK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJWEH9EO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250916163252.290994801@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758040397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BmldD4A75BIJBF70pMggmackAjgs9KxvyTJlUqaikXQ=;
	b=QqI77ncKlEa6nB4I7sYOMDLEumijaVNglOlcMDNn1CMbhZHR0DuknAl6GECIu4yjb0g5dQ
	zHujwHWJZAXfYX515CXgxsR5I6amJZaRLi96MRgw7Xk3VA6P4QJdBFVN9BJcOd01IS73qp
	ePeKSm7d2MTSOAJ9CWxmJFgr2ArN+7ULtoBsBe5qaZSkAjss0ImuLTBHsMVIq8LOLSWG5Y
	69OpWDnQirfnM7HxgVFz2qsfW+oFVncr+d4J1zwdl5zQuhQwv2xoat4x2ncPasKEBWHduu
	l7vilSoxDEFhca/blMbRzCljO7LiUol9D3PiCtGZGe3BMATM7my+qfPnxpiQkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758040397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BmldD4A75BIJBF70pMggmackAjgs9KxvyTJlUqaikXQ=;
	b=QJWEH9EOQbeyB3lz6nAN0qgvWiaE9w4s2qFhRBPAT5xIHc/ZWjWp6uRNQxioA+QCnNj/5N
	z504OvajCpPXBYAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V2 5/6] x86/futex: Convert to scoped masked user access
References: <20250916163004.674341701@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:33:16 +0200 (CEST)

Replace the open coded implementation with the scoped masked user access
mechanism.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
V2:	Convert to scoped masked access
	Use RW access functions - Christophe
---
 arch/x86/include/asm/futex.h |   76 ++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)
---
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -48,37 +48,29 @@ do {								\
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
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
-	}
-	user_access_end();
+	scoped_masked_user_rw_access(uaddr, return -EFAULT, {
+		switch (op) {
+		case FUTEX_OP_SET:
+			unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, scope_fault);
+			break;
+		case FUTEX_OP_ADD:
+			unsafe_atomic_op1(LOCK_PREFIX "xaddl %0, %2", oval,
+					  uaddr, oparg, scope_fault);
+			break;
+		case FUTEX_OP_OR:
+			unsafe_atomic_op2("orl %4, %3", oval, uaddr, oparg, scope_fault);
+			break;
+		case FUTEX_OP_ANDN:
+			unsafe_atomic_op2("andl %4, %3", oval, uaddr, ~oparg, scope_fault);
+			break;
+		case FUTEX_OP_XOR:
+			unsafe_atomic_op2("xorl %4, %3", oval, uaddr, oparg, scope_fault);
+			break;
+		default:
+			return -ENOSYS;
+		}
+	});
 	return 0;
-Efault:
-	user_access_end();
-	return -EFAULT;
 }
 
 static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
@@ -86,20 +78,16 @@ static inline int futex_atomic_cmpxchg_i
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
+	scoped_masked_user_rw_access(uaddr, return -EFAULT, {
+		asm volatile("\n"
+			     "1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
+			     "2:\n"
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
+			     : "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+			     : "r" (newval), "1" (oldval)
+			     : "memory");
+		*uval = oldval;
+	});
 	return ret;
 }
 


