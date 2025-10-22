Return-Path: <linux-fsdevel+bounces-65089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297ABFBED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1513A34CDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E183112DD;
	Wed, 22 Oct 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1KJk30u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9duIHEc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA5346A10;
	Wed, 22 Oct 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137353; cv=none; b=tPsEfu+oGUxkLqXI+3u0edGeO2SRtgHS9/jZfLbbgQhkFn0EgkierRRKrXncT9szQpqDI/av07WtITjwsYbM8Yah04adDO/RXln8uutwLgQHgj1zVqvnU4M0AloRitSxUuMegiHkSNsgx/NnpEJwKTYpGYP/MXHT6Q715RNgvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137353; c=relaxed/simple;
	bh=B6FY70g1YU4tpzw5guto+VK5McncnWIMenNCFYwqfSs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Hb2NiYv2XjmUL/nfVbEU2fRUDCcWBmecl12PRgR1fBAxLxUGZcqaz1R2olxDNZR9eKFqLPvGkUOpOw6L06ZkN1OkDVlpMBslpIXw/ZU06CUVZUKiB62L5LnPA6fu+fr4h03mg2VUIQLHr4DqPDiPdNQjxrcyvMzFjpw7WAyogYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U1KJk30u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9duIHEc7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103111.917094276@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fZFzuFe1kZwWOtUDwXLfQwu5MJAw6qMRRDC36ZwVfYw=;
	b=U1KJk30ufn2daIIfpJLCyMNcDD+IEHyiM35RXdJyNFqli00qUJLPFpmDIOujbK1fxDdH2L
	tjiUEaiE7IgsNIT5KsXJt1G9zm/AJp4Lsh1G3ywv7kDU9dk0C4AE0gfNPZl4PR3dfJ6NmE
	58SsfnZoc59jDBYsUIakGUJ2m+BspUW3Slu7AHVDiiYVJ9cadbiruMSAouVuJOl2uyL6Eo
	v9MFcoSjMPvFojzkQ1BmeeFxP3+3k1h5BlhwTqljGQY1SShNXeAEzN8iFLWW2VqNOuoMAc
	D0S5mgGpOsd8ckS2gxrI5IGG5xyaNCdATH1d7uIyR+mjuOcs6oOu9DUSSdinnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fZFzuFe1kZwWOtUDwXLfQwu5MJAw6qMRRDC36ZwVfYw=;
	b=9duIHEc7jKDi/buS4tMXry00HW91mCoD9cY348w5IsDS561BCWYuWi4kka8K69tlaLPq+w
	6je/OLsxmDQeH4DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [patch V4 01/12] ARM: uaccess: Implement missing
 __get_user_asm_dword()
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:03 +0200 (CEST)

When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
for no real good reason. This prevents using get_user(u64) in generic code.

Implement it as a sequence of two 4-byte reads with LE/BE awareness and
make the unsigned long (or long long) type for the intermediate variable to
read into dependend on the the target type.

The __long_type() macro and idea was lifted from PowerPC. Thanks to
Christophe for pointing it out.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Closes: https://lore.kernel.org/oe-kbuild-all/202509120155.pFgwfeUD-lkp@intel.com/
---
V2a: Solve the *ptr issue vs. unsigned long long - Russell/Christophe
V2: New patch to fix the 0-day fallout
---
 arch/arm/include/asm/uaccess.h |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -283,10 +283,17 @@ extern int __put_user_8(void *, unsigned
 	__gu_err;							\
 })
 
+/*
+ * This is a type: either unsigned long, if the argument fits into
+ * that type, or otherwise unsigned long long.
+ */
+#define __long_type(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
+
 #define __get_user_err(x, ptr, err, __t)				\
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr);			\
-	unsigned long __gu_val;						\
+	__long_type(x) __gu_val;					\
 	unsigned int __ua_flags;					\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
@@ -295,6 +302,7 @@ do {									\
 	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err, __t); break;	\
 	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err, __t); break;	\
 	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err, __t); break;	\
+	case 8:	__get_user_asm_dword(__gu_val, __gu_addr, err, __t); break;	\
 	default: (__gu_val) = __get_user_bad();				\
 	}								\
 	uaccess_restore(__ua_flags);					\
@@ -353,6 +361,22 @@ do {									\
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


