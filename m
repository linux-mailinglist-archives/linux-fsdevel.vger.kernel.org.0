Return-Path: <linux-fsdevel+bounces-26664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769295AE81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F951F213BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE841547EA;
	Thu, 22 Aug 2024 07:13:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EC152E1C;
	Thu, 22 Aug 2024 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310817; cv=none; b=LRFwvPdxbe+B9/zP3W4DiMgodZrG0rywXbp3ZRl1Xz1dt1VyOfV/8LC+lUdBuZj0uB2cIbo72HcWYetPa6BH6PepkKSMfVPwb06Gc3+UYsgzJ+6CHfPzTFo942qmk4xbZiGqkiAsdMW6LivctIIwoFm0aOFE5tgg0m7Hm5aCuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310817; c=relaxed/simple;
	bh=PMuEkb4wUUODc8BHWuAMDd3O1VO5F7l6ew490+ETezs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5E0s0yaxc7ts5lcuEtSe1RMOVKepbkn/NIcWjv2QQgUwLWUxSZC7RqhEzcwg1Ppka3GEL2lhIcvctPrZDw/gqmhw06iSc9J08bX7ytGbLXtRCEkyIWgbdLWoUDoEzAK/0Wb4w3sI85WoyC9Wx8HAEf5IwwZ7MckSYgz8zfuzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDv764knz9sSL;
	Thu, 22 Aug 2024 09:13:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teSSTAQ_JMUd; Thu, 22 Aug 2024 09:13:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDv751hwz9sSH;
	Thu, 22 Aug 2024 09:13:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 981318B77E;
	Thu, 22 Aug 2024 09:13:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id deVhGSnWC0EM; Thu, 22 Aug 2024 09:13:23 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D1878B77D;
	Thu, 22 Aug 2024 09:13:22 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 01/17] asm-generic/unaligned.h: Extract common header for vDSO
Date: Thu, 22 Aug 2024 09:13:09 +0200
Message-ID: <a583352e8ae8f6a9a08f9b84a2c543fe43ef94db.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310793; l=2154; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=PMuEkb4wUUODc8BHWuAMDd3O1VO5F7l6ew490+ETezs=; b=SCbozmVIQ2N0YmD5LdvWZtFwtXyTP5t5NaLd+wgmzFt0RkjCtkLWbQu2r6nA/RS5ZBAbgtMi5 NOvPh+CSjVFDGZxHHEvNd8+6dh4WhQuiz0RR1GxQc29ssqo1F2FgOFN
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

getrandom vDSO implementation requires __put_unaligned_t() and
__put_unaligned_t() but including asm-generic/unaligned.h pulls
too many other headers.

Follow the same approach as for most things in include/vdso/,
see for instance commit 8165b57bca21 ("linux/const.h: Extract
common header for vDSO"): Move __get_unaligned_t and __put_unaligned_t
into a new unaligned.h living in the vdso/ include directory.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/unaligned.h | 11 +----------
 include/vdso/unaligned.h        | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)
 create mode 100644 include/vdso/unaligned.h

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index a84c64e5f11e..95acdd70b3b2 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -8,16 +8,7 @@
  */
 #include <linux/unaligned/packed_struct.h>
 #include <asm/byteorder.h>
-
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
-})
-
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
-} while (0)
+#include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
 #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
new file mode 100644
index 000000000000..eee3d2a4dbe4
--- /dev/null
+++ b/include/vdso/unaligned.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_UNALIGNED_H
+#define __VDSO_UNALIGNED_H
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#endif /* __VDSO_UNALIGNED_H */
-- 
2.44.0


