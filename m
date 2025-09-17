Return-Path: <linux-fsdevel+bounces-61939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB5B7FAC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A654A4BDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB632E749;
	Wed, 17 Sep 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="htgrVUpN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrkryvZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92231618F;
	Wed, 17 Sep 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117316; cv=none; b=AXhZJqWqoB1IHUGamW05OqbHTP1DFtEkrO3uNyGCxV81MrJ+FlPOcxBX5Ir56H2jUg00uLyolL8wZZML+iwC17V/EOX59Oqne/m5JCWwZsFXcCh5cpalHCTLcodtpQo6fa2yWGcUEiAodWUun+sQZbFsaOPGn1cSVI3Qd5M2YfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117316; c=relaxed/simple;
	bh=1AGIHscYWBRNoy3EWBTKwv6GY+iVKr3IBEs5X3T5hv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rX6EsspUkmmkPMP3MoRFIqpv3HApgyAa24YroagRDPLDoY+MVduBK8CWOwTS/NKhL8q6ZEm38SRTtCeU3UZkC/C1r0eoiS185KUFW6vxhDoFg+2/FhncszgyQU0SxIsk73jRdeK6up/Az8GoCyKHe7yWmWgd6T8hkRXSW7kZPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=htgrVUpN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrkryvZt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6wijLJ6yPSQGb++9TSkyHX8aU2wWOVN2uZhv4Iw/Sg=;
	b=htgrVUpNqPrUTT6sap0+RKqY8mN+zAHUnhbm4XiqKktMI6nALNkdAU+PveIoIqDoof0yds
	R4dyZ6gGiKCQ3a4Nc7BxZsrZbq5o/1dkdzJF89dWlE5bxo4FGU/DKQdxc5qDuSx6IWcGwM
	xZEpals5M7jmJahtYkM4UjQYIPTbzm5isG7uJSgBVtgWxjaRLMmk23+XcwGBF+MSQzvI6v
	2xxzUsP6k3TCT4jllVI0Y9goiWTEesxDYvzKvvSHvkD6tWS4IEfh3tWH92htAE4rcDWsrG
	2MkzKaMJXJwz1o/1Bq7TybNJcwhwXYa8hgnaznHEUEb/wPH+Ds+SHmBFP6B91A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6wijLJ6yPSQGb++9TSkyHX8aU2wWOVN2uZhv4Iw/Sg=;
	b=rrkryvZtbzDTZhErhLp6hLKXjabdn0poRB3ciKeE+zajjGUOV6BUMtFyRPOGkyL5t1KOhm
	b17M+ZxIpGo64yBQ==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <lkp@intel.com>, linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
In-Reply-To: <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk> <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
Date: Wed, 17 Sep 2025 15:55:10 +0200
Message-ID: <87y0qd89q9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17 2025 at 10:41, Russell King wrote:
> On Wed, Sep 17, 2025 at 07:48:00AM +0200, Thomas Gleixner wrote:
>
> Putting together a simple test case, where the only change is making
> __gu_val an unsigned long long:
>
> t.c: In function =E2=80=98get_ptr=E2=80=99:
> t.c:40:15: warning: cast to pointer from integer of different size [-Wint=
-to-pointer-cast]
>    40 |         (x) =3D (__typeof__(*(ptr)))__gu_val;                    =
         \
>       |               ^
> t.c:21:9: note: in expansion of macro =E2=80=98__get_user_err=E2=80=99
>    21 |         __get_user_err((x), (ptr), __gu_err, TUSER());           =
       \
>       |         ^~~~~~~~~~~~~~
> t.c:102:16: note: in expansion of macro =E2=80=98__get_user=E2=80=99
>   102 |         return __get_user(p, ptr);
>       |                ^~~~~~~~~~
>
> In order for the code you are modifying to be reachable, you need to
> build with CONFIG_CPU_SPECTRE disabled. This is produced by:
>
> int get_ptr(void **ptr)
> {
>         void *p;
>
>         return __get_user(p, ptr);
> }

Duh, yes. I hate get_user() and I did not notice, because the
allmodconfig build breaks early due to frame size checks, so I was too
lazy to find that config knob and built only a couple of things and an
artificial test case for u64.

But it actually can be solved solvable by switching the casting to:

    (x) =3D *(__force __typeof__(*(ptr)) *) &__gu_val;

Not pretty, but after upping the frame size limit it builds an
allmodconfig kernel.

The proper thing to use the corresponding sized values within the case
$SIZE sections i.e.:

	size 1: {
       		u8 __gu_val;
                __get_user_asm_byte(__gu_val, __gu_addr, err, __t);
                (x) =3D *(__force __typeof__(*(ptr)) *) &__gu_val;
		break;
	}
        ...

See below.

> Feel free to try to solve this, but I can assure you that you certainly
> are not the first. Several people have already tried.

Obviously not hard enough. :)

Thanks,

        tglx
---
Subject: ARM: uaccess: Implement missing __get_user_asm_dword()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 12 Sep 2025 20:16:11 +0200

When CONFIG_CPU_SPECTRE=3Dn then get_user() is missing the 8 byte ASM varia=
nt
for no real good reason. This prevents using get_user(u64) in generic code.

Implement it as a sequence of two 4-byte reads with LE/BE awareness and
fixup the size switch case to make get_user(*ptr, **usrptr) work.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Closes: https://lore.kernel.org/oe-kbuild-all/202509120155.pFgwfeUD-lkp@int=
el.com/
---
V2a: Solve the *ptr issue vs. unsigned long long - Russell
V2: New patch to fix the 0-day fallout
---
 arch/arm/include/asm/uaccess.h |   50 ++++++++++++++++++++++++++++++++++++=
-----
 1 file changed, 44 insertions(+), 6 deletions(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -286,19 +286,41 @@ extern int __put_user_8(void *, unsigned
 #define __get_user_err(x, ptr, err, __t)				\
 do {									\
 	unsigned long __gu_addr =3D (unsigned long)(ptr);			\
-	unsigned long __gu_val;						\
 	unsigned int __ua_flags;					\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
 	__ua_flags =3D uaccess_save_and_enable();				\
 	switch (sizeof(*(ptr))) {					\
-	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err, __t); break;	\
-	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err, __t); break;	\
-	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err, __t); break;	\
-	default: (__gu_val) =3D __get_user_bad();				\
+	case 1:	{							\
+		u8 __gu_val;						\
+		__get_user_asm_byte(__gu_val, __gu_addr, err, __t);	\
+		(x) =3D *(__force __typeof__(*(ptr)) *) &__gu_val;	\
+		break;							\
+	}								\
+	case 2:	{							\
+		u16 __gu_val;						\
+		__get_user_asm_half(__gu_val, __gu_addr, err, __t);	\
+		(x) =3D *(__force __typeof__(*(ptr)) *) &__gu_val;	\
+		break;							\
+	}								\
+	case 4:	{							\
+		u32 __gu_val;						\
+		__get_user_asm_word(__gu_val, __gu_addr, err, __t);	\
+		(x) =3D *(__force __typeof__(*(ptr)) *) &__gu_val;	\
+		break;							\
+	}								\
+	case 8:	{							\
+		u64 __gu_val;						\
+		__get_user_asm_dword(__gu_val, __gu_addr, err, __t);	\
+		(x) =3D *(__force __typeof__(*(ptr)) *) &__gu_val;	\
+		break;							\
+	}								\
+	default: {							\
+		unsigned long __gu_val;					\
+		(__gu_val) =3D __get_user_bad();				\
+	}								\
 	}								\
 	uaccess_restore(__ua_flags);					\
-	(x) =3D (__typeof__(*(ptr)))__gu_val;				\
 } while (0)
 #endif
=20
@@ -353,6 +375,22 @@ do {									\
 #define __get_user_asm_word(x, addr, err, __t)			\
 	__get_user_asm(x, addr, err, "ldr" __t)
=20
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
+	(x) =3D ((u64)__w1 << 32) | (u64) __w0;				\
+})
+
 #define __put_user_switch(x, ptr, __err, __fn)				\
 	do {								\
 		const __typeof__(*(ptr)) __user *__pu_ptr =3D (ptr);	\



