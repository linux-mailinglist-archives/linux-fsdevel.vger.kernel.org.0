Return-Path: <linux-fsdevel+bounces-65683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7ADC0C6C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FB93A6698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8862FD7BB;
	Mon, 27 Oct 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4Kw5Ywe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5fUpbazZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46D2FC86F;
	Mon, 27 Oct 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554645; cv=none; b=LGkXYgD7ddabYtt8JtJjY9b9K3psYaA6Wv0LRO8DI5mafMQ1EMmKVYiKd1sWm4fvfh+1No4O2MQOrrx1lQtLhZ01K+4Ca+9fRYuGT3JOOigaINZ0dVHxhnZWY2YQbrzEB+aZslpY9v+KyP/iYMKhs2Rr8shblu4gHulyher/lQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554645; c=relaxed/simple;
	bh=RHzrkT+vZzf5UcXSprmKWB9t7GIHeTbjDsxtqxDPTmE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o9WJPIaFHNdLOQU/Doi3xTk7CxNemBmz10ymKDjNO2mnrSLfcjNZ7yUsXBnI7L61vffZ+d5+bKTuefBHjmdd8NBYOeM7rPLpMFvKMk1A7lM3Cdj7mSzLHlk1W7XzITgz2F7HtAyEUkguauESnd55oLVeF1L3A9LenpwB5xJ3p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4Kw5Ywe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5fUpbazZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027083745.736737934@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=435+37KhAU0mhng1XnAbeS2nHoeU+rxEjwbVMsKftxA=;
	b=I4Kw5Ywek/IX9WMSt/JXEa6snrzGFocVq/IjZtkNm1ANMjiG+drhyzT6KMpNFoZ81+hpq6
	7eExgfokt10EBfmMcQQqV3fHS7o+tZ1wKnuLPw3dhoCmS+7DNc4GlQebCPGHmHeHNEXGGv
	dHUpqGVUsaIl7lhAhzePlzvZ9TZmCnQJkRaIhw6kSszp+Oe3T28gR/NmuCpMOdRMmdbgWK
	49R4Iz46M9aRnw8O5tqYDlJeRDC1t10xoiAaSTGN43wU0DwX72QRSrd7bLWPPaoJLnpDRt
	WsrcrnhgR+2dkKcsStXQmlVjHMHAgmZ8OHZztJdfAQhnJWROQZ2fWyeT4rsVLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=435+37KhAU0mhng1XnAbeS2nHoeU+rxEjwbVMsKftxA=;
	b=5fUpbazZrmkMXN7jn9+9G33jFnKwKg6Vab+X7NXNyTTxhdWjb/TPTSoWsl2TtGRcijzTye
	9yPo5IrGwO3RP/DA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 kernel test robot <lkp@intel.com>,
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
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V5 10/12] futex: Convert to get/put_user_inline()
References: <20251027083700.573016505@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:00 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded implementation with the new get/put_user_inline()
helpers. This might be replaced by a regular get/put_user(), but that needs
a proper performance evaluation.

No functional change intended

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
V5: Rename again and remove the helpers
V4: Rename once moar
V3: Adapt to scope changes
V2: Convert to scoped variant
---
 kernel/futex/core.c  |    4 +--
 kernel/futex/futex.h |   58 ++-------------------------------------------------
 2 files changed, 5 insertions(+), 57 deletions(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -581,7 +581,7 @@ int get_futex_key(u32 __user *uaddr, uns
 	if (flags & FLAGS_NUMA) {
 		u32 __user *naddr = (void *)uaddr + size / 2;
 
-		if (futex_get_value(&node, naddr))
+		if (get_user_inline(node, naddr))
 			return -EFAULT;
 
 		if ((node != FUTEX_NO_NODE) &&
@@ -601,7 +601,7 @@ int get_futex_key(u32 __user *uaddr, uns
 			node = numa_node_id();
 			node_updated = true;
 		}
-		if (node_updated && futex_put_value(node, naddr))
+		if (node_updated && put_user_inline(node, naddr))
 			return -EFAULT;
 	}
 
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -281,63 +281,11 @@ static inline int futex_cmpxchg_value_lo
 	return ret;
 }
 
-/*
- * This does a plain atomic user space read, and the user pointer has
- * already been verified earlier by get_futex_key() to be both aligned
- * and actually in user space, just like futex_atomic_cmpxchg_inatomic().
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
- */
-static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
-{
-	u32 val;
-
-	if (can_do_masked_user_access())
-		from = masked_user_access_begin(from);
-	else if (!user_read_access_begin(from, sizeof(*from)))
-		return -EFAULT;
-	unsafe_get_user(val, from, Efault);
-	user_read_access_end();
-	*dest = val;
-	return 0;
-Efault:
-	user_read_access_end();
-	return -EFAULT;
-}
-
-static __always_inline int futex_put_value(u32 val, u32 __user *to)
-{
-	if (can_do_masked_user_access())
-		to = masked_user_access_begin(to);
-	else if (!user_write_access_begin(to, sizeof(*to)))
-		return -EFAULT;
-	unsafe_put_user(val, to, Efault);
-	user_write_access_end();
-	return 0;
-Efault:
-	user_write_access_end();
-	return -EFAULT;
-}
-
+/* Read from user memory with pagefaults disabled */
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
-	int ret;
-
-	pagefault_disable();
-	ret = futex_get_value(dest, from);
-	pagefault_enable();
-
-	return ret;
+	guard(pagefault)();
+	return get_user_inline(*dest, from);
 }
 
 extern void __futex_unqueue(struct futex_q *q);


