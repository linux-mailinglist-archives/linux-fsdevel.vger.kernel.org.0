Return-Path: <linux-fsdevel+bounces-57753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B0B24EB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C821B66CC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F22857C1;
	Wed, 13 Aug 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mhpjbX6+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERqB2XkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F23283C83;
	Wed, 13 Aug 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100632; cv=none; b=KGnOb+AUTLE7hu5kKZ6ZOuF0KCt6pnHALJpBAj6v3Iz5LEDY1ZoGQRoQFoBf5ZYEIWH38/mN3uixipGUscGIbdym7vJ3kXu1aBhE0lcel9OlumAk5qRSsKlDkUBBNU39WOH3Ra3uBsjZa+b4cMWVuhqbKHuGcpo/bU9rM/Uv9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100632; c=relaxed/simple;
	bh=HMVPXQ0rOq/78Eb5uJi9J/1ezoTUG5/Y1PDPve+dHCY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ftuh5f9FX1ssPKpubxRqsf3kGDa6mHeqDhp96UXyqswAv06mTKEKG6DhUrQbuegdiwWfI4QPRWfeORNqC4TGvo7X971m3ZxAZnwpxVmecPO/jxRwvjVdyDhDWGD5UEte7Loor5KCVjP2qEJ91pnE5l2ePHaE+7apL8i+cZGY8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mhpjbX6+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERqB2XkY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813151939.729465198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755100628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W3JEWO9z4dg0s3Ftac3NmVQUvi1aIqzsrct00cg4b+4=;
	b=mhpjbX6+9agjfkAAKxWhIP6W4D0xGsuOrHQ8NR0hyun++2NmdRymGI0x3x2yGnhOBu/cSW
	273SQ2IGOtysIvV9O47Od0smVyYfL/PelEcIYXqwVK9pqHByGNJr1LDq2Vl2UJGoY6jrFx
	mYZCLQW1bq8QvfII1i6KRObzD4LzVHw1xDISNCnEPqbHRnVMQlCuXnfJ1Hy6b4kFAGOvvj
	m6pYPcr44gmWyMyaqIQK/NAlyYRXWwfebngZ/x8C/g3N2LSUk21dzdB+OD4+D/3RNR5FXU
	FLM40Flhlr7HLQMTG4pCNH25sPxqGPGcjQsAqg5tFYqYHQ0ZN/keQqFtw74Z+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755100628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W3JEWO9z4dg0s3Ftac3NmVQUvi1aIqzsrct00cg4b+4=;
	b=ERqB2XkYLBeHGiE7c9AMXgUAAdNLjrEbom6gz5p6ssMP5sRlRETvS7KmCr+MFb+mAYmSrD
	aoZmK6p6sfTTl4Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch 3/4] x86/futex: Use user_*_masked_begin()
References: <20250813150610.521355442@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 17:57:07 +0200 (CEST)

Replace the can_do_masked_user_access() conditional with the generic macro.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/futex.h |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -48,9 +48,7 @@ do {								\
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
-	if (can_do_masked_user_access())
-		uaddr = masked_user_access_begin(uaddr);
-	else if (!user_access_begin(uaddr, sizeof(u32)))
+	if (!user_write_masked_begin(uaddr))
 		return -EFAULT;
 
 	switch (op) {
@@ -74,7 +72,7 @@ static __always_inline int arch_futex_at
 		user_access_end();
 		return -ENOSYS;
 	}
-	user_access_end();
+	user_write_access_end();
 	return 0;
 Efault:
 	user_access_end();
@@ -86,9 +84,7 @@ static inline int futex_atomic_cmpxchg_i
 {
 	int ret = 0;
 
-	if (can_do_masked_user_access())
-		uaddr = masked_user_access_begin(uaddr);
-	else if (!user_access_begin(uaddr, sizeof(u32)))
+	if (!user_write_masked_begin(uaddr))
 		return -EFAULT;
 	asm volatile("\n"
 		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
@@ -98,7 +94,7 @@ static inline int futex_atomic_cmpxchg_i
 		: "r" (newval), "1" (oldval)
 		: "memory"
 	);
-	user_access_end();
+	user_write_access_end();
 	*uval = oldval;
 	return ret;
 }


