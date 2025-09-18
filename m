Return-Path: <linux-fsdevel+bounces-58764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B8B31550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0F6AE5461
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0BD2E1737;
	Fri, 22 Aug 2025 10:21:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D32EF65A;
	Fri, 22 Aug 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858068; cv=none; b=qPTdeGw/64bULAdrOnfmRSSiOHfoznylsAzIYCo5E1RaIK29rRPLy3oq3mKZx1j99KAGtPya8K9sVhaimmXit7B0nO3RMn27ctYPsRNIl8TSvD4UR5HiWxIWgTiS3u3gXziEGxkYIofCO8xOYJC0iUxG6SXt/HbVf50+7Mdt1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858068; c=relaxed/simple;
	bh=pN4mv5SfPTESXIT1PtFDsmVlUJhI6vGXL0aiUyNtU/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNK6ZSsIXhqN59phJ0DZXCchtOGypDaIPe8t8dycRi2d1LE52hu2RA5RqwyJPyFReHQqgOCVJePLszqbmag1rRUhsP3W57gDP2M0M1ZZaE7jTa+flnsFezENyke83WSTlGmA/lJ44RqidduS+Id2+xLbYXkFrCqHftkU5oDh/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c7bGr0ZKTz9sSY;
	Fri, 22 Aug 2025 11:58:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2kEh4GEi-xJ; Fri, 22 Aug 2025 11:58:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c7bGq6d9sz9sSX;
	Fri, 22 Aug 2025 11:58:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C7E138B775;
	Fri, 22 Aug 2025 11:58:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kyxvRiMS9UjN; Fri, 22 Aug 2025 11:58:11 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 771E88B780;
	Fri, 22 Aug 2025 11:58:10 +0200 (CEST)
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
Subject: [PATCH v2 05/10] powerpc/uaccess: Remove unused size and from parameters from allow_access_user()
Date: Fri, 22 Aug 2025 11:58:01 +0200
Message-ID: <987c04688a537710c212fb35f2676311da94c1b2.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755856679; l=5354; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=pN4mv5SfPTESXIT1PtFDsmVlUJhI6vGXL0aiUyNtU/g=; b=Bu4ikyLq1pN/L5W86rytn1JbsXSSu+bIHrWJqiGv9PK5Fq01x2XJ3sPr+KkWnmzmy52dACItS CmDpj3q3eZeCPHC21wM4V6/xEYsKrnmPpK5zktbf8Gm3JFSTp1DQzhm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Since commit 16132529cee5 ("powerpc/32s: Rework Kernel Userspace
Access Protection") the size parameter is unused on all platforms.

And the 'from' parameter has never been used.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Also remove 'from' param.
---
 arch/powerpc/include/asm/book3s/32/kup.h     | 3 +--
 arch/powerpc/include/asm/book3s/64/kup.h     | 6 ++----
 arch/powerpc/include/asm/kup.h               | 9 ++++-----
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 3 +--
 arch/powerpc/include/asm/nohash/kup-booke.h  | 3 +--
 5 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 4e14a5427a63..6718b7e40eef 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -97,8 +97,7 @@ static __always_inline unsigned long __kuap_get_and_assert_locked(void)
 }
 #define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      u32 size, unsigned long dir)
+static __always_inline void allow_user_access(void __user *to, unsigned long dir)
 {
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
 
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 497a7bd31ecc..3b8706007fa1 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -353,8 +353,7 @@ __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	return (regs->amr & AMR_KUAP_BLOCK_READ) == AMR_KUAP_BLOCK_READ;
 }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      unsigned long size, unsigned long dir)
+static __always_inline void allow_user_access(void __user *to, unsigned long dir)
 {
 	unsigned long thread_amr = 0;
 
@@ -383,8 +382,7 @@ static __always_inline unsigned long get_kuap(void)
 
 static __always_inline void set_kuap(unsigned long value) { }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      unsigned long size, unsigned long dir)
+static __always_inline void allow_user_access(void __user *to, unsigned long dir)
 { }
 
 #endif /* !CONFIG_PPC_KUAP */
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 6737416dde9f..da5f5b47cca0 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -72,8 +72,7 @@ static __always_inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned
  * platforms.
  */
 #ifndef CONFIG_PPC_BOOK3S_64
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      unsigned long size, unsigned long dir) { }
+static __always_inline void allow_user_access(void __user *to, unsigned long dir) { }
 static __always_inline void prevent_user_access(unsigned long dir) { }
 static __always_inline unsigned long prevent_user_access_return(void) { return 0UL; }
 static __always_inline void restore_user_access(unsigned long flags) { }
@@ -134,18 +133,18 @@ static __always_inline void kuap_assert_locked(void)
 
 static __always_inline void allow_read_from_user(const void __user *from, unsigned long size)
 {
-	allow_user_access(NULL, from, size, KUAP_READ);
+	allow_user_access(NULL, KUAP_READ);
 }
 
 static __always_inline void allow_write_to_user(void __user *to, unsigned long size)
 {
-	allow_user_access(to, NULL, size, KUAP_WRITE);
+	allow_user_access(to, KUAP_WRITE);
 }
 
 static __always_inline void allow_read_write_user(void __user *to, const void __user *from,
 						  unsigned long size)
 {
-	allow_user_access(to, from, size, KUAP_READ_WRITE);
+	allow_user_access(to, KUAP_READ_WRITE);
 }
 
 static __always_inline void prevent_read_from_user(const void __user *from, unsigned long size)
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 46bc5925e5fd..86621fee746d 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -49,8 +49,7 @@ static __always_inline void uaccess_end_8xx(void)
 	    "i"(SPRN_MD_AP), "r"(MD_APG_KUAP), "i"(MMU_FTR_KUAP) : "memory");
 }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      unsigned long size, unsigned long dir)
+static __always_inline void allow_user_access(void __user *to, unsigned long dir)
 {
 	uaccess_begin_8xx(MD_APG_INIT);
 }
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
index 0c7c3258134c..a8fab0349704 100644
--- a/arch/powerpc/include/asm/nohash/kup-booke.h
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -73,8 +73,7 @@ static __always_inline void uaccess_end_booke(void)
 	    "i"(SPRN_PID), "r"(0), "i"(MMU_FTR_KUAP) : "memory");
 }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      unsigned long size, unsigned long dir)
+static __always_inline void allow_user_access(void __user *to, unsigned long dir)
 {
 	uaccess_begin_booke(current->thread.pid);
 }
-- 
2.49.0


