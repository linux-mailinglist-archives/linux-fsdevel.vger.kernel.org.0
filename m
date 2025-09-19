Return-Path: <linux-fsdevel+bounces-62259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF925B8AE92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 20:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E0418974A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38F25DD0B;
	Fri, 19 Sep 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXdhu2Fz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEtW+YsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BE34BA40;
	Fri, 19 Sep 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306459; cv=none; b=ZCZROvI5g3nzEoCkg8L0LdjD9g5nhabZ5AIOYIXpvS73RGXwdjn6ZrEhdJVFQuoW95DkZdixh8Tzoe0w7dqsbdYwFo+w2oYof9blkOuJyT1XOSXHcUu2RyPS9JD1vJK7Dcga01Zm2APtQv5ZcDlP88R6M+Bcd0g2D7aKOcd6MN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306459; c=relaxed/simple;
	bh=0oKhf9H/k7koggsl3lirtiUd4RzmGFeXGeZu4pUEecg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPfmOdEWisnSRDyoBupBeg4U2PaHLKxuhN3i0uWBvg6XWimJDnKu9l+QIK8kZejfNYP5216RO5rSlyddALS8179hE8Ynj9rx1+vybpGxq4Rakpl5T5orV6fCYQFCiJXvXpYDH0z6KBLSKC3ryGg9fMysNN5Gd10Mt/tjyBYHB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXdhu2Fz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EEtW+YsE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758306455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d9RBmI2iX1ZX7Pcl3gagxnA4YyfCeH7uHTQOBr1mgec=;
	b=GXdhu2FzEMNv+9P0OmuXv3lu2UlSEj+3hva8irx706eOUEvt8MONPtaRD5qUyw8hqLkyUe
	tRYHysAoof5su+qo3ytGTqEu1xQXq43cLUbDTETKZYvohRiNFax9s1Wn6G0/mTdDVP/VwF
	dIyky3OVenLfCELQPiiGRHJBmSMcKNBY40S3Cv5S2M6I5LHunpW6g3bgztGNdQYGlXYCVG
	rluSrdYuQ8qnGL5kyGJ5FoEFpgAfkyAnmvuak31DMnFlV536wFsXyjY0a9sM77jDocldeh
	KSx5SAmM0YrR6TTx031rSS0MoMvgm75gL2V+0+UI+kLoxceUsXeQwhD+iCWMQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758306455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d9RBmI2iX1ZX7Pcl3gagxnA4YyfCeH7uHTQOBr1mgec=;
	b=EEtW+YsEucAZH23H4LnoTix/0YV5g6BXxI+zZX4U68FNcAEE5qKUH2st++0/6TSBh/qZR7
	x9v9Ao7pdxDVWBAg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, kernel test robot <lkp@intel.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Nathan
 Chancellor <nathan@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [patch V2a 1/6] ARM: uaccess: Implement missing __get_user_asm_dword()
In-Reply-To: <20250916163252.037251747@linutronix.de>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.037251747@linutronix.de>
Date: Fri, 19 Sep 2025 20:27:33 +0200
Message-ID: <878qia8fhm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM
variant.  This prevents using get_user(u64) in generic code.

Implement it as a sequence of two 4-byte reads with LE/BE awareness and
make the data type for the intermediate variable to read into dependend
on the target type. For 8,16,32 bit use unsigned long and for 64 bit
unsigned long long

The __long_type() macro and the idea to solve it was lifted from
PowerPC. Thanks to Christophe for pointing it out.

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

