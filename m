Return-Path: <linux-fsdevel+bounces-26672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF595AEC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CD4286191
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA0183CD2;
	Thu, 22 Aug 2024 07:14:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D6183CB6;
	Thu, 22 Aug 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310850; cv=none; b=L6blD2QGo5Wj45cQXWEtfCGKjIdvU4XC0LAyYy3+QmIcLbh28TFQB0WCeIViRoRZDEudskOICGTb5iHY49JvjExbJyYH2A+EqlcIwIx1jwNYoR+rCKq5ae0sBLRQwkQYyUjrYb2WzbLrBtGzh6iP9NqtUS6Txcf42BQ+bEMYzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310850; c=relaxed/simple;
	bh=utdv6V/SvZxVA50hOk7t/lkGWDvSE1q/kJYchx6i5SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1cWeYa3YzA0xgnFvM5z+V8dEFjlvPjPfcVVwJaanVqx5/kEpEwsv5Lh9n7ZpN7rru1KGB43io853NnLEWnLMIWwGZQ/BHbDHOjw8gZ2+Mw4Sy6NY84hTrbfMpyym+CORfJyAbN/7zWfTnEtKekAYNBOzOKAL2tbYvM5Cm6H3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvJ1ts2z9sSZ;
	Thu, 22 Aug 2024 09:13:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J19dfRjWyl6q; Thu, 22 Aug 2024 09:13:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvJ14jHz9sSH;
	Thu, 22 Aug 2024 09:13:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 13A3D8B77D;
	Thu, 22 Aug 2024 09:13:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mXHlUX_aoLcN; Thu, 22 Aug 2024 09:13:31 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 02F3A8B77E;
	Thu, 22 Aug 2024 09:13:30 +0200 (CEST)
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
Subject: [PATCH v2 09/17] powerpc/vdso32: Add crtsavres
Date: Thu, 22 Aug 2024 09:13:17 +0200
Message-ID: <3730201dbc5add4d3a87c0ce80dd1dddf938d13a.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=2796; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=utdv6V/SvZxVA50hOk7t/lkGWDvSE1q/kJYchx6i5SU=; b=SZIg9brB+vtPlEI/uhJ6lsYxQKnhHvbMUlfNQ42Zutu1csaGNwZMYx5RZ2ib0CRRFeQMaLt+k d2yQvcpbkvsCMYHUVfLugVTmTgBTZPnr1GTiaE51BS2+woZrEdRxKII
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 08c18b63d965 ("powerpc/vdso32: Add missing _restgpr_31_x to fix
build failure") added _restgpr_31_x to the vdso for gettimeofday, but
the work on getrandom shows that we will need more of those functions.

Remove _restgpr_31_x and link in crtsavres.o so that we get all
save/restore functions when optimising the kernel for size.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso/Makefile       |  5 ++++-
 arch/powerpc/kernel/vdso/gettimeofday.S | 13 -------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 1425b6edc66b..c07a425b8f78 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -43,6 +43,7 @@ else
 endif
 
 targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
+targets += crtsavres-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
@@ -68,7 +69,7 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/crtsavres-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
 $(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
 	$(call if_changed,vdso64ld_and_check)
@@ -76,6 +77,8 @@ $(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o
 # assembly rules for the .S files
 $(obj-vdso32): %-32.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
+$(obj)/crtsavres-32.o: %-32.o: $(srctree)/arch/powerpc/lib/crtsavres.S FORCE
+	$(call if_changed_dep,vdso32as)
 $(obj)/vgettimeofday-32.o: %-32.o: %.c FORCE
 	$(call if_changed_dep,vdso32cc)
 $(obj-vdso64): %-64.o: %.S FORCE
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 48fc6658053a..67254ac9c8bb 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -118,16 +118,3 @@ V_FUNCTION_END(__kernel_clock_getres)
 V_FUNCTION_BEGIN(__kernel_time)
 	cvdso_call __c_kernel_time call_time=1
 V_FUNCTION_END(__kernel_time)
-
-/* Routines for restoring integer registers, called by the compiler.  */
-/* Called with r11 pointing to the stack header word of the caller of the */
-/* function, just beyond the end of the integer restore area.  */
-#ifndef __powerpc64__
-_GLOBAL(_restgpr_31_x)
-_GLOBAL(_rest32gpr_31_x)
-	lwz	r0,4(r11)
-	lwz	r31,-4(r11)
-	mtlr	r0
-	mr	r1,r11
-	blr
-#endif
-- 
2.44.0


