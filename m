Return-Path: <linux-fsdevel+bounces-61879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48369B7F3EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3F522D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F5264614;
	Wed, 17 Sep 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04v/c5wL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpwvaGR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F83839FCE;
	Wed, 17 Sep 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088086; cv=none; b=oRVpHPdSGsx5Ob2Ke7bPLF9ZrEo0qJB47MPR5WTFg21qscNt/nuckQCmw382likdSBDhs5yNYMx4PbksTXxE0Fxf8yglc9Ott1H0MuvvWmQlxAq7imcoOA+Kj0azvm1GJo4mqn6Me+CF4Qqw5Wb2zqb3bDKyIs6/0Spi+sBeUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088086; c=relaxed/simple;
	bh=62rhUpJkZL7jbHvQiVeg+t7ATdtdORtcoqE+Jg3Tbwo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=TNXthlq7pwltyeFrY1MHCYBusCOC238eaNOMl7MyNCEgFTiH4ch39t3XRDQwbsfin5cP4XeEm8W8uUz1C+rEOoRLiJrpOTZHJSr9qwM6g+NCb8Lrl+e0HBRMYwfv8lmPq63u5YMIsEbeZQiuXMQ5LHs3RtyzlgpnhTiBtF0tToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04v/c5wL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpwvaGR/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758088082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=xpKjZAE80H4GNebrsZS/MW8m8KLs2QPMqTC7iL4j2lg=;
	b=04v/c5wLjN/EEQafgGY+oDwRsFZSNIy1Eg1ETOEblnJHoY9Npd5jWNYJ4G0ML/EKcdAjsw
	78SdlxibZw4pFkh+JmCVw0vn6xoqHisLavZVq1wCrgOpsXL4yfhX7YBcw3N2PNxHfvH4GD
	FvQcD0uGntFdRMnVNaACKNHnhHgFYnXf2vYQfldHTGOcCsdE2rwy1mqctgClJ9fMtcDyeD
	SeUnNeTNy9gvKoMB7KSUV3RwfJkiLIymmw31w/+B9Y/P23/wQ7a/eWJvaxp+zOcBXinuEi
	PseqAgwJTKPikBMj6GsCene3O/aeosZKXhrhdPgh3q2IPOPpt8QRQG6YKwFpmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758088082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=xpKjZAE80H4GNebrsZS/MW8m8KLs2QPMqTC7iL4j2lg=;
	b=YpwvaGR/hOcTOCdIjXiofkasT5LIYsnhJ8NrUCvS8o5V575d/Oa+L6Hn6M2FPc+I4mXDVQ
	7Hm9SWpcflikgmDQ==
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
In-Reply-To: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk>
Date: Wed, 17 Sep 2025 07:48:00 +0200
Message-ID: <875xdhaaun.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16 2025 at 22:26, Russell King wrote:
> On Tue, Sep 16, 2025 at 06:33:09PM +0200, Thomas Gleixner wrote:
>> When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
>> for no real good reason. This prevents using get_user(u64) in generic code.
>
> I'm sure you will eventually discover the reason when you start getting
> all the kernel build bot warnings that will result from a cast from a
> u64 to a pointer.

I really don't know which cast you are talking about.

  	u64 __user *uaddr =  ...;
	u64 val;

        ....
        unsafe_get_user(val, uaddr, fault);

The only casts in this macro maze are in __get_user_err():

 1) Casting the uaddr pointer to unsigned long:

     unsigned long __gu_addr = (unsigned long)(ptr);

    which is correct because a *u64 pointer is still only 32bit wide on a
    32bit machine, no?

 2) Casting the result:

    (x) = (__typeof__(*(ptr)))__gu_val;

    which is casting to the type to which the pointer points to,
    i.e. u64 in this case.

I definitely checked the ASM result after I successfully compiled the
above w/o warnings. It compiles to:

 ad0:	ee032f10 	mcr	15, 0, r2, cr3, cr0, {0}
 ad4:	e3a00000 	mov	r0, #0
 ad8:	e4b3e000 	ldrt	lr, [r3], #0
 adc:	e2833004 	add	r3, r3, #4
 ae0:	e4b32000 	ldrt	r2, [r3], #0
 ae4:	ee03cf10 	mcr	15, 0, ip, cr3, cr0, {0}
 ae8:	e16f0f10 	clz	r0, r0
 aec:	e581e000 	str	lr, [r1]
 af0:	e5812004 	str	r2, [r1, #4]

which is magically correct despite the fact that I missed to change the
type of __gu_val to 'unsigned long long'. I just noticed when I tried to
figure out which cast you were referring to.

The wonderful and surprising world of macro preprocessing. :)

That unsigned long long is not hurtful as the compiler is smart enough
to optimize it away when __get_user_err() is invoked to read an u8 from
user:

 b18:	ee033f10 	mcr	15, 0, r3, cr3, cr0, {0}
 b1c:	e3a03000 	mov	r3, #0
 b20:	e4f04000 	ldrbt	r4, [r0], #0
 b24:	ee032f10 	mcr	15, 0, r2, cr3, cr0, {0}
 b28:	e16f0f13 	clz	r0, r3
 b2c:	e5c14000 	strb	r4, [r1]

which is exactly the same result as before this change.

Thanks,

        tglx

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -286,7 +286,7 @@ extern int __put_user_8(void *, unsigned
 #define __get_user_err(x, ptr, err, __t)				\
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr);			\
-	unsigned long __gu_val;						\
+	unsigned long long __gu_val;					\
 	unsigned int __ua_flags;					\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\


