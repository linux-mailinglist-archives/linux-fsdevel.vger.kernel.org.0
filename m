Return-Path: <linux-fsdevel+bounces-26676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD995AEDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448921C23F1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7F1865E7;
	Thu, 22 Aug 2024 07:14:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAA185E50;
	Thu, 22 Aug 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310867; cv=none; b=j6l2OMBHkCvKdCEuM4o7K+iJjxW6mck5JMIFBnCxmsqZxGCf/Tq8rvZ4l+dZ+BHD+rXPKCU4MQLw/OEjvFPQmuHLH8OiJaDZLkiONzR0IptToQL75+iYIAiNrceDmM5/y+qiO9CFq1ShVlQsLmEYtc7h+9i4ReC1iymhZdfAfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310867; c=relaxed/simple;
	bh=5h3KLlzEytDPiSde0fgrOqrQ+VHGwL8x+UTMWMemKqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfUr8fL67ScAtACTmiQ8ub2xh8OrDBqZGVJQMXrErJc4n3KTtfeOWi+eorU0tMKG/f5WTUBtU/F082SA88yqfHKAtDUx3ym8DKPxVu2sXuemAnYt/6vOBpOaNvcQkDwW2KY9iDpUZAiJcgdjtd9w70p3DyqkclUEg8IyGJ561Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvN3xV2z9sT0;
	Thu, 22 Aug 2024 09:13:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1TLfFxSNw26; Thu, 22 Aug 2024 09:13:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvN33L7z9sSy;
	Thu, 22 Aug 2024 09:13:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 581FF8B77E;
	Thu, 22 Aug 2024 09:13:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7wUGeZI3I6WA; Thu, 22 Aug 2024 09:13:36 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FFC78B77D;
	Thu, 22 Aug 2024 09:13:35 +0200 (CEST)
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
Subject: [PATCH v2 13/17] selftests: vdso: Don't hard-code location of vDSO sources
Date: Thu, 22 Aug 2024 09:13:21 +0200
Message-ID: <a40d859dba5654239650eec44d75ab45c98221f4.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=1792; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=5h3KLlzEytDPiSde0fgrOqrQ+VHGwL8x+UTMWMemKqA=; b=52c+474v8h2re77BqeSjmwGjfxeWNjA9JNg5DuQ62lSQwt3zIwXGDzTZYrzUEJRgw6cHNO+Iw rQyliGCUE71CPHt6eiUIZGbf2GQ3Zpk6iL8sVydNdOYcLKgGcfx+LkJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Architectures use different location for vDSO sources:
	arch/mips/vdso
	arch/sparc/vdso
	arch/arm64/kernel/vdso
	arch/riscv/kernel/vdso
	arch/csky/kernel/vdso
	arch/x86/um/vdso
	arch/x86/entry/vdso
	arch/powerpc/kernel/vdso
	arch/arm/vdso
	arch/loongarch/vdso

Don't hard-code vdso sources location in selftest Makefile,
instead create a vdso/ symbolic link in tools/arch/$arch/ and
update Makefile accordingly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/arch/x86/vdso                   | 1 +
 tools/testing/selftests/vDSO/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 120000 tools/arch/x86/vdso

diff --git a/tools/arch/x86/vdso b/tools/arch/x86/vdso
new file mode 120000
index 000000000000..7eb962fd3454
--- /dev/null
+++ b/tools/arch/x86/vdso
@@ -0,0 +1 @@
+../../../arch/x86/entry/vdso/
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 3de8e7e052ae..c9a819cacbf2 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -40,7 +40,7 @@ $(OUTPUT)/vdso_test_getrandom: parse_vdso.c
 $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          -isystem $(top_srcdir)/include/uapi
 
-$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/arch/$(ARCH)/entry/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -isystem $(top_srcdir)/arch/$(ARCH)/include \
                                       -isystem $(top_srcdir)/include \
-- 
2.44.0


