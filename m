Return-Path: <linux-fsdevel+bounces-26680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B095AF1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B41B255C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95532188586;
	Thu, 22 Aug 2024 07:14:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C3187FEF;
	Thu, 22 Aug 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310884; cv=none; b=u4MdGpRUMhEjvA7Yb+nsqYncTbV/+H1RmLB9XrExyuTx3BzuFQca3YSopd0UXaIMBAiV8TxJHpZJQytigrQcRkHH7W1R1n12cJT/kYFbRPKwpxCDEOVjtaR+ZXcQgTzNykp/ttA+YlCIXBkXCpfdoVuuW3nlWmB4f20tf9TSgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310884; c=relaxed/simple;
	bh=yXWU/vOrVCh1tH6IvVskRabYNHCoI2MUD+0kW8f8BRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2NRfjVnzkrq+s41/HWxNTmlvZjAgOKieInbMf1QybnyvJf0uLMMfxWHxibt/MtUXuwKefXjN/oVEeK7ZxdXVdFS0WU3PJiDdIY+aXYXUKfFxHnByZVe1zeOWDvQQZ+bsOkstiiYNwinL9P2eG2I1+sR3k6bZabmz4K9CnkV7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvS5M5gz9sTD;
	Thu, 22 Aug 2024 09:13:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BXvRolJCPmB; Thu, 22 Aug 2024 09:13:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvS4Ts4z9sSy;
	Thu, 22 Aug 2024 09:13:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 898D68B763;
	Thu, 22 Aug 2024 09:13:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id M06ncktVG1Is; Thu, 22 Aug 2024 09:13:40 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7999F8B77D;
	Thu, 22 Aug 2024 09:13:39 +0200 (CEST)
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
Subject: [PATCH v2 17/17] selftests: vdso: Add support for vdso_test_random for powerpc
Date: Thu, 22 Aug 2024 09:13:25 +0200
Message-ID: <7a612370f645d6f8defd4dc8c1ebf31ee39dfb1f.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310795; l=2831; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=yXWU/vOrVCh1tH6IvVskRabYNHCoI2MUD+0kW8f8BRY=; b=KS6Wqd4DIG71241Ra4HKWqyJqfA08PcnWHdqJqXSzHx1GQ2rQRMw4i3n5nKIJ8DUdMbYpgKlH PcZJDDWZcGgD4/4e4J7ugbtDnH9tX2JYCnkXxsBKExFDkk4hm1KeDA9
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Add the necessary symbolic link and tell Makefile to build
vdso_test_random for powerpc.

In makefile, don't use $(uname_M) which is wrong when cross-building
for powerpc on an x86_64.

Implement the required VDSO_CALL macro to correctly handle errors.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/arch/powerpc/vdso                  |  1 +
 tools/testing/selftests/vDSO/Makefile    |  6 ++++
 tools/testing/selftests/vDSO/vdso_call.h | 40 ++++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 120000 tools/arch/powerpc/vdso

diff --git a/tools/arch/powerpc/vdso b/tools/arch/powerpc/vdso
new file mode 120000
index 000000000000..d31004bf8f55
--- /dev/null
+++ b/tools/arch/powerpc/vdso
@@ -0,0 +1 @@
+../../../arch/powerpc/kernel/vdso/
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 10ffdda3f2fa..7e7c9fd200d3 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -17,6 +17,12 @@ ifneq ($(SODIUM),)
 TEST_GEN_PROGS += vdso_test_chacha
 endif
 endif
+ifeq ($(ARCH),powerpc)
+TEST_GEN_PROGS += vdso_test_getrandom
+ifneq ($(SODIUM),)
+TEST_GEN_PROGS += vdso_test_chacha
+endif
+endif
 
 CFLAGS := -std=gnu99
 
diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftests/vDSO/vdso_call.h
index ca5db2220925..2a33c25756dc 100644
--- a/tools/testing/selftests/vDSO/vdso_call.h
+++ b/tools/testing/selftests/vDSO/vdso_call.h
@@ -7,6 +7,46 @@
 #ifndef __VDSO_CALL_H__
 #define __VDSO_CALL_H__
 
+#ifdef __powerpc__
+
+#define LOADARGS_5(fn, __arg1, __arg2, __arg3, __arg4, __arg5) do { 	\
+	_r0 = fn;							\
+	_r3 = (long)__arg1;						\
+	_r4 = (long)__arg2;						\
+	_r5 = (long)__arg3;						\
+	_r6 = (long)__arg4;						\
+	_r7 = (long)__arg5;						\
+} while (0)
+
+#define VDSO_CALL(fn, nr, args...) ({					\
+	register void *_r0 asm ("r0");					\
+	register long _r3 asm ("r3");					\
+	register long _r4 asm ("r4");					\
+	register long _r5 asm ("r5");					\
+	register long _r6 asm ("r6");					\
+	register long _r7 asm ("r7");					\
+	register long _r8 asm ("r8");					\
+	register long _rval asm ("r3");					\
+									\
+	LOADARGS_##nr(fn, args);					\
+									\
+	asm volatile(							\
+		"	mtctr %0\n"					\
+		"	bctrl\n"					\
+		"	bns+	1f\n"					\
+		"	neg	3, 3\n"					\
+		"1:"							\
+		: "+r" (_r0), "=r" (_r3), "+r" (_r4), "+r" (_r5),	\
+		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
+		: "r" (_rval)						\
+		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
+		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
+	);								\
+	_rval;								\
+})
+
+#else
 #define VDSO_CALL(fn, nr, args...)	fn(args)
+#endif
 
 #endif
-- 
2.44.0


