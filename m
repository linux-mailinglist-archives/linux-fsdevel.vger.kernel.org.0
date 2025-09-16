Return-Path: <linux-fsdevel+bounces-61783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7DB59DBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C359D48574A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C127FB2E;
	Tue, 16 Sep 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAZOwPKM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/H9ENHoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5227713;
	Tue, 16 Sep 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040393; cv=none; b=Gd5pQWTo6MJQ178dPxgJTs5HogTxSiFX2I4gMTef9oSMWY2rIGB3b5zyKZMydUCPgbaFocmteJ/YuZexwLrqr+fEQgwyuhW0jZe9Oi/+E0HwRpkPQHXjd5tWEjx7aLCzfujV/BLz69tcStA7s4w//Eh2LIxPhJDclEWCFsc2nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040393; c=relaxed/simple;
	bh=aNA0BOq5pZa4UZHJvNSqUe7oskOnYx6OhDY2Zyl56cA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=j2gpA86x5WjqJCcW+uPOaCnbtpLYz7IH+awEWJxKYD82suMlaWsr1jxZeWiIUOEIgpNKxIEhf9N+b+gIsi8a2ZM/ZinV98Sa1bkkcUzuFTtlYA4TFn+j5NgkyFTI22V0nkUncGQswh9k+11FaYxsIzHccAOF9GDjA3tgzngArss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aAZOwPKM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/H9ENHoj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250916163252.037251747@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758040389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B/RhS9MNlGp3gsd3Y5Hcz+zwOUSn+KCGsE63faUFAJ8=;
	b=aAZOwPKMm4jwayUq+qDJ8DY/iZjvms9gmpOm+ct7FIi2qfXqO2u1fVe2YStaVUIzzWxt9d
	tA8sboL0MDk+yZHp4z5FYKjRwQm14cSPwYvVNV4cZphj4sO5MO0rxwwhUtwG1Phz3gxBVv
	ZFYIud/j3ahpmykVe1dpyXZxMl2FJfFxy+vZxH2rjLe5TRh7eOIG+/2awPBlH+L7wFaChL
	7hkPOhd7tSFEHwu622HJyBogkgSDWOXM+pL+8jvnvMcKRpMhn+0FBL6Y3MD3dkRfqsYCHT
	hf5xIyg4gcU0iS+UN7J6WeLF49JHHSFv2JnDsP9mfoQGUXRdms1Z8nZzc2UXZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758040389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B/RhS9MNlGp3gsd3Y5Hcz+zwOUSn+KCGsE63faUFAJ8=;
	b=/H9ENHojbyZCig4RCbcZB0AcR5KYCv6FUU8ji5Q7CeEhYJ1EZB4nUb9K7XrWSI/58jOkZC
	GD2DBAPopu7XXHDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V2 1/6] ARM: uaccess: Implement missing __get_user_asm_dword()
References: <20250916163004.674341701@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:33:09 +0200 (CEST)

When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
for no real good reason. This prevents using get_user(u64) in generic code.

Implement it as a sequence of two 4-byte reads with LE/BE awareness.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Closes: https://lore.kernel.org/oe-kbuild-all/202509120155.pFgwfeUD-lkp@intel.com/
---
V2: New patch to fix the 0-day fallout
---
 arch/arm/include/asm/uaccess.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -295,6 +295,7 @@ do {									\
 	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err, __t); break;	\
 	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err, __t); break;	\
 	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err, __t); break;	\
+	case 8:	__get_user_asm_dword(__gu_val, __gu_addr, err, __t); break;	\
 	default: (__gu_val) = __get_user_bad();				\
 	}								\
 	uaccess_restore(__ua_flags);					\
@@ -353,6 +354,22 @@ do {									\
 #define __get_user_asm_word(x, addr, err, __t)			\
 	__get_user_asm(x, addr, err, "ldr" __t)
 
+#ifdef __ARMEB__
+#define __WORD0_OFFS	4
+#define __WORD1_OFFS	0
+#else
+#define __WORD0_OFFS	0
+#define __WORD1_OFFS	4
+#endif
+
+#define __get_user_asm_dword(x, addr, err, __t)				\
+	({								\
+	unsigned long __w0, __w1;					\
+	__get_user_asm(__w0, addr + __WORD0_OFFS, err, "ldr" __t);	\
+	__get_user_asm(__w1, addr + __WORD1_OFFS, err, "ldr" __t);	\
+	(x) = ((u64)__w1 << 32) | (u64) __w0;				\
+})
+
 #define __put_user_switch(x, ptr, __err, __fn)				\
 	do {								\
 		const __typeof__(*(ptr)) __user *__pu_ptr = (ptr);	\


