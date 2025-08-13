Return-Path: <linux-fsdevel+bounces-57752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF1B24EC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DB272079C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD325283FD8;
	Wed, 13 Aug 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5FSc9KA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dAcHbCpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285832820B7;
	Wed, 13 Aug 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100631; cv=none; b=mU35JuPFYKz+xZKZgCiQEVTNQFgjtxJEl0PxLYJgih5DFjOF8fQB63k0xjWyzqqVUT27xLg10tRCLqdJlJ+0HSw7yAHcolqninhJegf1LG4kSZMrJw3LtxhO7xOwcSwis5JBOlXNJ+kjaakRZ+WTJmvEeMnERT/EVUDV36uKqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100631; c=relaxed/simple;
	bh=eEUM+5EM4B2eR+IxtkYCkwoUeH2x8G8mzcR5ViIdagA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RxtcZOpeNOTFs/xQK6wl22sECT1KJrguCDPBu5FatcA9Ip9OtNajSEZbXAwKmir0BIl3503yZC09eRU9KE50YaYuHYRnnViQGkZ6NLS1lOtm2XEfhzo78SbautxOpvLtEEtbm6Lp5e7vxA1kUjfXPqZLnanv0PqR82DQdZ7c4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5FSc9KA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dAcHbCpa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813151939.665160414@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755100626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kXIA9O9VFvP6Sq94okyOBlAMhSF0lSbvZzSGAd3q/Aw=;
	b=C5FSc9KAJLpiPF3qL+OQEYHXbn4u+uZ22swh9DRVtJdabjEzOtkogY0HhgbudrxzjC7iAi
	XL0PKRFDvhpqvP55A5umABj5wmxpTxuaKsR6+aHXAKsUjLwGQzO36pHQyXMyZFWptvig04
	MnjxLawiETEMdbeAlmmHgLASg0HyBVzSejvnUjtoPP2b6wZ5wS8azMwCS0YCWXvMOG7Y/R
	IZan6Ks471gKv1MQ4WSiqlEfFYTg3qDlhqH93hHYdAInqzFSVNsgo4xrWqTLPboNSEYM3+
	unumk1+kOPRMYJOsz9cyjYzvnZpVrRiWiDxXn0chzxk3a1zfJ4b7b15zCYRBpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755100626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kXIA9O9VFvP6Sq94okyOBlAMhSF0lSbvZzSGAd3q/Aw=;
	b=dAcHbCpaTa7XW+3x4SFFZQHg+cjV0ngJor9WAlxKfBL5C1cvdHxSfB/0e/m4rfeMlZfJf+
	5BtW2372fo6w0yBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch 2/4] futex: Convert to get/put_user_masked_u32()
References: <20250813150610.521355442@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 17:57:05 +0200 (CEST)

Use the generic variants for futex_put/get_value() instead of the open
coded implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
 kernel/futex/futex.h |   37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -285,48 +285,15 @@ static inline int futex_cmpxchg_value_lo
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
-	return 0;
-Efault:
-	user_read_access_end();
-	return -EFAULT;
+	return get_user_masked_u32(dest, from);
 }
 
 static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
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
+	return put_user_masked_u32(val, to);
 }
 
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)


