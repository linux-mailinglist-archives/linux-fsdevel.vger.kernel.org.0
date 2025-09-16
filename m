Return-Path: <linux-fsdevel+bounces-61786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA799B59DC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EF64E5A4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FFC301702;
	Tue, 16 Sep 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyzLGVu/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9GyDKdnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25A393DF9;
	Tue, 16 Sep 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040400; cv=none; b=JWkAVQFURLYpCLp8VpXGI2zKyJlZJ3oOol2M8iBcB8VZV8wsI9oBN5p5KJG3Mnz83sb8vTSswMJ8Wd6gF66rwCYJB3Qeg54pZpBja3KFDNcxCguGDp+TDBYeMkOnkWJeubE7unF3qnGzH9FU/UAyvDz0AMSxLvmJeCPOFxzLtec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040400; c=relaxed/simple;
	bh=By+6DyNxWx7g1a1/0Lmb8zlNPO1Lu9Z3J3mXom09XE4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=p7ZaDP+Atkoms0daSwpEmCOCy0bCT8UxZax6tDN8A6H/vLogA+/OJp8L2491rVF5yiwby93F8xHn58YfoCyaLWN4lKPpvav9ymoq3qkSDLj/KLVS4v7i/eG8ERLJc0qxLPX5BTXAELOWhmHtN4smP47mVfESLapH16J8KLqOMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyzLGVu/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9GyDKdnj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250916163252.227660125@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758040395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KxCoyZ/tM4V5cgHJsb0XJboqFn+/1+M5A9xLVrNQox0=;
	b=yyzLGVu/ABVBavv4AsytaQMxKIbr+AZPJaqBpVX9jTg7rBhW2P8Ob/yOOhgtFvi47gf5oe
	Sm/hgmy1LtJbYcnJatHSo2nifHh5YzyrJuvrGgFg+YRY099DxREKmHP2lNEQt3gSgvXhO9
	FZXewu40o2mFTUDGRQEkaf+GZxYQbpBQJP0C/DPRJ3dn780vvHqjt9IkcwzKcMKlbIOh1h
	MFynsHg1iaGBfd37RGlFCgbCq7yP4xnzsD5vikVSD4lmda1+eJ0UN/KQYE+3AZDU0++hG3
	rQK/184E5q6BflBIYUE881Uw8p4yGoe3JBFAOUTijn3684OcWY4pC1YSV6lnsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758040395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KxCoyZ/tM4V5cgHJsb0XJboqFn+/1+M5A9xLVrNQox0=;
	b=9GyDKdnjHMYAG3ZLmNN2MzA1nbMshj2uBjzc0VA3S8FnFUJ7/BtFY6a9OLVNNtbnfmlflj
	b4MWhuriSCAu9DDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V2 4/6] futex: Convert to scoped masked user access
References: <20250916163004.674341701@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:33:15 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded implementation with the scoped masked user access
mechanism.

No functional change intended

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
V2: Convert to scoped variant
---
 kernel/futex/futex.h |   37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)
---
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -285,48 +285,19 @@ static inline int futex_cmpxchg_value_lo
  * This does a plain atomic user space read, and the user pointer has
  * already been verified earlier by get_futex_key() to be both aligned
  * and actually in user space, just like futex_atomic_cmpxchg_inatomic().
- *
- * We still want to avoid any speculation, and while __get_user() is
- * the traditional model for this, it's actually slower than doing
- * this manually these days.
- *
- * We could just have a per-architecture special function for it,
- * the same way we do futex_atomic_cmpxchg_inatomic(), but rather
- * than force everybody to do that, write it out long-hand using
- * the low-level user-access infrastructure.
- *
- * This looks a bit overkill, but generally just results in a couple
- * of instructions.
  */
 static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 {
-	u32 val;
-
-	if (can_do_masked_user_access())
-		from = masked_user_access_begin(from);
-	else if (!user_read_access_begin(from, sizeof(*from)))
-		return -EFAULT;
-	unsafe_get_user(val, from, Efault);
-	user_read_access_end();
-	*dest = val;
+	scoped_masked_user_read_access(from, return -EFAULT,
+	       scoped_get_user(*dest, from); );
 	return 0;
-Efault:
-	user_read_access_end();
-	return -EFAULT;
 }
 
 static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
-	if (can_do_masked_user_access())
-		to = masked_user_access_begin(to);
-	else if (!user_write_access_begin(to, sizeof(*to)))
-		return -EFAULT;
-	unsafe_put_user(val, to, Efault);
-	user_write_access_end();
+	scoped_masked_user_write_access(to, return -EFAULT,
+	       scoped_put_user(val, to); );
 	return 0;
-Efault:
-	user_write_access_end();
-	return -EFAULT;
 }
 
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)


