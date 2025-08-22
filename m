Return-Path: <linux-fsdevel+bounces-58766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B7B3155B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C850B01736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4272F28FF;
	Fri, 22 Aug 2025 10:21:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833A2DFA21;
	Fri, 22 Aug 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858079; cv=none; b=eCvucU5/8zZEET7gG7ziZSZODVmwTcv0NH6f82royg3UilPMPIAP38xPosj2RG5UenE6t5Gt9vEywbFUgHQMIVRjgUncfRKvAMEXZ/DOAd2YI7ECpU2OguZmK/QHbXct6apVIe63veZ2H/vnqC/Tga3g3wrggepJg1ZbeSd/FbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858079; c=relaxed/simple;
	bh=fP9WObzJ/2N9/4EDoUl1xf8kjta+DR6uuNLODyDCEJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A528QEsAnPzU6r6JB6ggMfQxXuPye9OtJHP2q8ZdjX9HWQJk0JNUVvyEcVPyS1uXWCmiDZxPB9dWdKu5Kap14Bmr9U1uxt/h4Q5fVH0f1pTeERXBauvbq7o5sYgxrIJ8Erv93+cYrQK88pf7JgFjd/byuriNtI+NYSnHXJZV7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c7bGs1qmSz9sSb;
	Fri, 22 Aug 2025 11:58:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8vvb6RdR6kp; Fri, 22 Aug 2025 11:58:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c7bGs0pQ7z9sSZ;
	Fri, 22 Aug 2025 11:58:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0240C8B780;
	Fri, 22 Aug 2025 11:58:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OVYa2l6pC0BE; Fri, 22 Aug 2025 11:58:12 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CB6F58B781;
	Fri, 22 Aug 2025 11:58:11 +0200 (CEST)
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
Subject: [PATCH v2 06/10] powerpc/uaccess: Remove {allow/prevent}_{read/write/read_write}_{from/to/}_user()
Date: Fri, 22 Aug 2025 11:58:02 +0200
Message-ID: <ffa271c5c127f277ac8213301da2f16a34bca885.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755856679; l=5380; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=fP9WObzJ/2N9/4EDoUl1xf8kjta+DR6uuNLODyDCEJs=; b=T3sZTJQbWWxSvxnrTMu3Ur0E3ipBuACkn/ijWTup5nP/rhipke3Mwwnj1EIXejhdNUP8CCdp9 d5eMN5XWMP8AtQqVPkELMTCR5a5WQG2m9Ln36oSHSKu+sfZWqRcNB0C
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The six following functions have become simple single-line fonctions
that do not have much added value anymore:
- allow_read_from_user()
- allow_write_to_user()
- allow_read_write_user()
- prevent_read_from_user()
- prevent_write_to_user()
- prevent_read_write_user()

Directly call allow_user_access() and prevent_user_access(), it doesn't
reduce the readability and it removes unnecessary middle functions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: New
---
 arch/powerpc/include/asm/kup.h     | 47 ------------------------------
 arch/powerpc/include/asm/uaccess.h | 30 +++++++++----------
 2 files changed, 15 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index da5f5b47cca0..892ad06bdd8c 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -131,53 +131,6 @@ static __always_inline void kuap_assert_locked(void)
 		kuap_get_and_assert_locked();
 }
 
-static __always_inline void allow_read_from_user(const void __user *from, unsigned long size)
-{
-	allow_user_access(NULL, KUAP_READ);
-}
-
-static __always_inline void allow_write_to_user(void __user *to, unsigned long size)
-{
-	allow_user_access(to, KUAP_WRITE);
-}
-
-static __always_inline void allow_read_write_user(void __user *to, const void __user *from,
-						  unsigned long size)
-{
-	allow_user_access(to, KUAP_READ_WRITE);
-}
-
-static __always_inline void prevent_read_from_user(const void __user *from, unsigned long size)
-{
-	prevent_user_access(KUAP_READ);
-}
-
-static __always_inline void prevent_write_to_user(void __user *to, unsigned long size)
-{
-	prevent_user_access(KUAP_WRITE);
-}
-
-static __always_inline void prevent_read_write_user(void __user *to, const void __user *from,
-						    unsigned long size)
-{
-	prevent_user_access(KUAP_READ_WRITE);
-}
-
-static __always_inline void prevent_current_access_user(void)
-{
-	prevent_user_access(KUAP_READ_WRITE);
-}
-
-static __always_inline void prevent_current_read_from_user(void)
-{
-	prevent_user_access(KUAP_READ);
-}
-
-static __always_inline void prevent_current_write_to_user(void)
-{
-	prevent_user_access(KUAP_WRITE);
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_KUAP_H_ */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 3987a5c33558..698996f34891 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -45,14 +45,14 @@
 	do {							\
 		__label__ __pu_failed;				\
 								\
-		allow_write_to_user(__pu_addr, __pu_size);	\
+		allow_user_access(__pu_addr, KUAP_WRITE);	\
 		__put_user_size_goto(__pu_val, __pu_addr, __pu_size, __pu_failed);	\
-		prevent_write_to_user(__pu_addr, __pu_size);	\
+		prevent_user_access(KUAP_WRITE);		\
 		__pu_err = 0;					\
 		break;						\
 								\
 __pu_failed:							\
-		prevent_write_to_user(__pu_addr, __pu_size);	\
+		prevent_user_access(KUAP_WRITE);		\
 		__pu_err = -EFAULT;				\
 	} while (0);						\
 								\
@@ -302,9 +302,9 @@ do {								\
 								\
 	might_fault();					\
 	barrier_nospec();					\
-	allow_read_from_user(__gu_addr, __gu_size);		\
+	allow_user_access(NULL, KUAP_READ);		\
 	__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);	\
-	prevent_read_from_user(__gu_addr, __gu_size);		\
+	prevent_user_access(KUAP_READ);				\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 								\
 	__gu_err;						\
@@ -331,9 +331,9 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 	unsigned long ret;
 
 	barrier_nospec();
-	allow_read_write_user(to, from, n);
+	allow_user_access(to, KUAP_READ_WRITE);
 	ret = __copy_tofrom_user(to, from, n);
-	prevent_read_write_user(to, from, n);
+	prevent_user_access(KUAP_READ_WRITE);
 	return ret;
 }
 #endif /* __powerpc64__ */
@@ -343,9 +343,9 @@ static inline unsigned long raw_copy_from_user(void *to,
 {
 	unsigned long ret;
 
-	allow_read_from_user(from, n);
+	allow_user_access(NULL, KUAP_READ);
 	ret = __copy_tofrom_user((__force void __user *)to, from, n);
-	prevent_read_from_user(from, n);
+	prevent_user_access(KUAP_READ);
 	return ret;
 }
 
@@ -354,9 +354,9 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	unsigned long ret;
 
-	allow_write_to_user(to, n);
+	allow_user_access(to, KUAP_WRITE);
 	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
-	prevent_write_to_user(to, n);
+	prevent_user_access(KUAP_WRITE);
 	return ret;
 }
 
@@ -367,9 +367,9 @@ static inline unsigned long __clear_user(void __user *addr, unsigned long size)
 	unsigned long ret;
 
 	might_fault();
-	allow_write_to_user(addr, size);
+	allow_user_access(addr, KUAP_WRITE);
 	ret = __arch_clear_user(addr, size);
-	prevent_write_to_user(addr, size);
+	prevent_user_access(KUAP_WRITE);
 	return ret;
 }
 
@@ -397,9 +397,9 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (check_copy_size(from, n, true)) {
 		if (access_ok(to, n)) {
-			allow_write_to_user(to, n);
+			allow_user_access(to, KUAP_WRITE);
 			n = copy_mc_generic((void __force *)to, from, n);
-			prevent_write_to_user(to, n);
+			prevent_user_access(KUAP_WRITE);
 		}
 	}
 
-- 
2.49.0


