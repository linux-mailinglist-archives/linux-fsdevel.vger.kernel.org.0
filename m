Return-Path: <linux-fsdevel+bounces-58758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A87B3152B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B290B1BC7DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055B72E2663;
	Fri, 22 Aug 2025 10:20:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472C2D9782;
	Fri, 22 Aug 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858041; cv=none; b=e2ifhTLOYkMb+4eSK2dKWazslPLI6nFyBJV+xHHvubOuCH8BGIIhXIx9yqToevndLZe80vHVBypOYm8xPkCkYCJ3IbMoudRp4x2YSH4BNzEedh4RgqWKqpb9iLxSam3JxYniacI2p+I/WRcbLaO4Ttm1L9XCYaLkNUQmCbKv45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858041; c=relaxed/simple;
	bh=W6hpcedkcWK/fNdxM9/tYip/yiX0Wu6MZIyees7Pogw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwbosgiqo8NpdfVLBf29x4rOCC7HmWyI7Oed89CsLmLdC0M8mE8qQCD35EHSfcrTYLso/bJzA1qveOmn1CdDfLeHUXOfoUor+7A6SqkkUGnE2coU9/pqvJvkvPPzMxB01KPYBAlrgKU+wsuyzdXJl2Cfkwei+W1b4QiYXfi5OMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c7bGp5G2dz9sSW;
	Fri, 22 Aug 2025 11:58:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-iQubse_0cd; Fri, 22 Aug 2025 11:58:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c7bGp4Kv4z9sSV;
	Fri, 22 Aug 2025 11:58:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 799BB8B781;
	Fri, 22 Aug 2025 11:58:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Jh8il3hsJZQH; Fri, 22 Aug 2025 11:58:10 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7612B8B775;
	Fri, 22 Aug 2025 11:58:09 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2 04/10] powerpc/uaccess: Move barrier_nospec() out of allow_read_{from/write}_user()
Date: Fri, 22 Aug 2025 11:58:00 +0200
Message-ID: <90ce0c90c53d3132023d753650b1741fab60dcd3.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755856679; l=3128; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=W6hpcedkcWK/fNdxM9/tYip/yiX0Wu6MZIyees7Pogw=; b=DUD1UUmtiwXNWatGhsXc9CjjVSp+31iz3JZAC3Kq7lY2UnNgEKtP/hJS7JrJ7X+vsKhFuWqba zo1szpJqvm5BrN9GBW2DIAx7C5wqNiWIty4eJINj4EQofJ+cdDrJaFQ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
copy_from_user()") added a redundant barrier_nospec() in
copy_from_user(), because powerpc is already calling
barrier_nospec() in allow_read_from_user() and
allow_read_write_user(). But on other architectures that
call to barrier_nospec() was missing. So change powerpc
instead of reverting the above commit and having to fix
other architectures one by one. This is now possible
because barrier_nospec() has also been added in
copy_from_user_iter().

Move barrier_nospec() out of allow_read_from_user() and
allow_read_write_user(). This will also allow reuse of those
functions when implementing masked user access which doesn't
require barrier_nospec().

Don't add it back in raw_copy_from_user() as it is already called
by copy_from_user() and copy_from_user_iter().

Fixes: 74e19ef0ff80 ("uaccess: Add speculation barrier to copy_from_user()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kup.h     | 2 --
 arch/powerpc/include/asm/uaccess.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 2bb03d941e3e..6737416dde9f 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -134,7 +134,6 @@ static __always_inline void kuap_assert_locked(void)
 
 static __always_inline void allow_read_from_user(const void __user *from, unsigned long size)
 {
-	barrier_nospec();
 	allow_user_access(NULL, from, size, KUAP_READ);
 }
 
@@ -146,7 +145,6 @@ static __always_inline void allow_write_to_user(void __user *to, unsigned long s
 static __always_inline void allow_read_write_user(void __user *to, const void __user *from,
 						  unsigned long size)
 {
-	barrier_nospec();
 	allow_user_access(to, from, size, KUAP_READ_WRITE);
 }
 
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4f5a46a77fa2..3987a5c33558 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -301,6 +301,7 @@ do {								\
 	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));	\
 								\
 	might_fault();					\
+	barrier_nospec();					\
 	allow_read_from_user(__gu_addr, __gu_size);		\
 	__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);	\
 	prevent_read_from_user(__gu_addr, __gu_size);		\
@@ -329,6 +330,7 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret;
 
+	barrier_nospec();
 	allow_read_write_user(to, from, n);
 	ret = __copy_tofrom_user(to, from, n);
 	prevent_read_write_user(to, from, n);
@@ -415,6 +417,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 
 	might_fault();
 
+	barrier_nospec();
 	allow_read_write_user((void __user *)ptr, ptr, len);
 	return true;
 }
@@ -431,6 +434,7 @@ user_read_access_begin(const void __user *ptr, size_t len)
 
 	might_fault();
 
+	barrier_nospec();
 	allow_read_from_user(ptr, len);
 	return true;
 }
-- 
2.49.0


