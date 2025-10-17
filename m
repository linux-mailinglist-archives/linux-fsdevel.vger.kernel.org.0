Return-Path: <linux-fsdevel+bounces-64466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 210CEBE8272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEF0656774A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526CC328B72;
	Fri, 17 Oct 2025 10:50:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DAA31691F;
	Fri, 17 Oct 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698243; cv=none; b=KfTOCsLwm27nGPHrJyVrzSds61fmH/QuX0c0W352JyBcUR8koo2nT4iXSGzRPlCODQFmXh3NwjvCIkqu1IXXzpBG51ykzghCNCRzCuJqjw2AbSP971rylQwDsZQFcmsx9ZrgCzsXjYwcO+in+/zGih8LKx0V+HgQahg7Wj8azy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698243; c=relaxed/simple;
	bh=y3f64tKhN7ET5qx1JK+lbghEU+YrDp/rltVLgFdTK8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyfggiZuuvgU9w8MeJ4bC6j7G+DVak2yOhgskEKpS1uoWL0QRFDZUHGR1K+t/+qs32alJZsaOyaV6EnXE1BXlVU+KVnpGNV38sKlyHG/nihMxC9ns/xD6Dodw4AY0yzTAGjD7ZrozLY1qdj+eW9V5EfMqLCcizhR11fqP+G05OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cp17t6Wdvz9sSh;
	Fri, 17 Oct 2025 12:21:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XWBO7AuKPMGU; Fri, 17 Oct 2025 12:21:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cp17t5YRjz9sSg;
	Fri, 17 Oct 2025 12:21:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A8CC18B786;
	Fri, 17 Oct 2025 12:21:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5Sd_UtXEJfxn; Fri, 17 Oct 2025 12:21:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D0DA8B776;
	Fri, 17 Oct 2025 12:21:29 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 06/10] powerpc/uaccess: Remove {allow/prevent}_{read/write/read_write}_{from/to/}_user()
Date: Fri, 17 Oct 2025 12:21:02 +0200
Message-ID: <17a008d24903f50a2ae55df795d1c51c684f5183.1760529207.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760529207.git.christophe.leroy@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5385; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=y3f64tKhN7ET5qx1JK+lbghEU+YrDp/rltVLgFdTK8s=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR8kpj86PdGjql6NumX9O8vYD6j3V247N7WC7qpSss09 mXxrk5a2lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmsmsKwx+u+tgFOa471AyZ G1/U2XzimNz+yyZlj1Lb5PzbRce4FFQZGWaqa6q68lh9ecXJtbF1ik1C58Hds04knZSMXNURV66 cxAQA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
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
index 3963584ac1cf1..4a4145a244f29 100644
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
 #endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_KUAP_H_ */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 3987a5c33558b..698996f348914 100644
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


