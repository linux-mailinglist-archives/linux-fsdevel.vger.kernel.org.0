Return-Path: <linux-fsdevel+bounces-52393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B1AE2F5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 12:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0070A3AFF76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527C1DF73A;
	Sun, 22 Jun 2025 10:20:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5841DEFDD;
	Sun, 22 Jun 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750587655; cv=none; b=mpcI3osKwY0xT/fTTHlt7Wx5HkJz2vyU80D+jBJ4LxJ4ipE1iuphr3306siA/ugqn8tj884tkSScEhMAFq/14M/JIR+k7iLEQzc6kH4E8Ras/T/q86EkxQ3L2LVjUBVV18mW9A38y1Ls2gPOEo/v5k8mhGODWfYH1YfjsBqqbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750587655; c=relaxed/simple;
	bh=wzgi8TIxhTfIFVNyBJ8YVgkDaYmDFZG7Y/RKQLlutyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBWu3fDgpuqhddyqBZuOuL/W9Vdv0mf6VZnXKPnPrq9YZVhILMv4Xa2fZeTv4Vk65BIEOd3ytM78PwL/PvipQWUAobh9o2wxnOiNflb+imALLKxDHdo9X0x0ZK6Fks6GPRjpl501VdP4fYFoIpDlV3+frY3CuLJFvJoFTQkP6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bQ62s3TsWz9sfW;
	Sun, 22 Jun 2025 11:52:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Qu3VT7lXSBd; Sun, 22 Jun 2025 11:52:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bQ62s2Hmfz9sfF;
	Sun, 22 Jun 2025 11:52:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 475B48B765;
	Sun, 22 Jun 2025 11:52:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id l6aql5vCM1zT; Sun, 22 Jun 2025 11:52:53 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 45B4A8B764;
	Sun, 22 Jun 2025 11:52:52 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] powerpc: Move barrier_nospec() out of allow_read_{from/write}_user()
Date: Sun, 22 Jun 2025 11:52:42 +0200
Message-ID: <cf6b49fbfee158221ce22baf8aed43e9dd8d34a2.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750585958; l=2362; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=wzgi8TIxhTfIFVNyBJ8YVgkDaYmDFZG7Y/RKQLlutyc=; b=SHR7GQWRwSWYB89RLRaWxjLnaNArovgMY5ntnQhDOcYsi0NJTaUtpbHESijjCGnb2sXQYAJuB 0/NeP7QB3kqCs4+wyhoCLxM/bIdw6SQ2cEBJrKh7F1NhtihxJN7KIx6
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Move barrier_nospec() out of allow_read_from_user() and
allow_read_write_user() in order to allow reuse of those
functions when implementing masked user access.

Don't add it back in raw_copy_from_user() as it is already done
by callers of raw_copy_from_user().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kup.h     | 2 --
 arch/powerpc/include/asm/uaccess.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 4c70be11b99a..4e2c79df4cdb 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -134,7 +134,6 @@ static __always_inline void kuap_assert_locked(void)
 
 static __always_inline void allow_read_from_user(const void __user *from)
 {
-	barrier_nospec();
 	allow_user_access(NULL, from, KUAP_READ);
 }
 
@@ -145,7 +144,6 @@ static __always_inline void allow_write_to_user(void __user *to)
 
 static __always_inline void allow_read_write_user(void __user *to, const void __user *from)
 {
-	barrier_nospec();
 	allow_user_access(to, from, KUAP_READ_WRITE);
 }
 
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index dd5cf325ecde..89d53d4c2236 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -301,6 +301,7 @@ do {								\
 	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));	\
 								\
 	might_fault();					\
+	barrier_nospec();					\
 	allow_read_from_user(__gu_addr);			\
 	__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);	\
 	prevent_read_from_user(__gu_addr);			\
@@ -329,6 +330,7 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret;
 
+	barrier_nospec();
 	allow_read_write_user(to, from);
 	ret = __copy_tofrom_user(to, from, n);
 	prevent_read_write_user(to, from);
@@ -415,6 +417,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 
 	might_fault();
 
+	barrier_nospec();
 	allow_read_write_user((void __user *)ptr, ptr);
 	return true;
 }
@@ -431,6 +434,7 @@ user_read_access_begin(const void __user *ptr, size_t len)
 
 	might_fault();
 
+	barrier_nospec();
 	allow_read_from_user(ptr);
 	return true;
 }
-- 
2.49.0


