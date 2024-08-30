Return-Path: <linux-fsdevel+bounces-28070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2F966648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CAE1F257AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C501B8EB9;
	Fri, 30 Aug 2024 15:57:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF01B5ED6;
	Fri, 30 Aug 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033455; cv=none; b=Hf9uuRc1CguH4Hpc62y5RvYSZWRMV5DGvc+mOJ9McjQOyRZCRy+1lBZr/hMFgO/ln0lVxgRsMtlD685BybURO9oFCWxVMzFw612Ie1ODHmatxGbeWZNBCxC5XxkyQV7GHG/R7s2DswM/WuTUekMmu3w+YHaL+EbUHAWdbMOxsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033455; c=relaxed/simple;
	bh=utdv6V/SvZxVA50hOk7t/lkGWDvSE1q/kJYchx6i5SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goZq0YYv34HBrD7K0GTmNqO2rJoFDrKn/kcvkDFGoQ3D3j9GCaAlKpQvZA5RYh5HniZUV2wF2YcKqVXBqjs2HOSzoZOe+hjk6nVx4zZa23ImKdK6wj8l1G/JMFPwgez1VsCC2cY9mFwa7Jwb2jg00X5NErn3Y57VcGgBJAxS8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwN7z3h8Qz9sSH;
	Fri, 30 Aug 2024 17:57:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HMgbftnZ8nbN; Fri, 30 Aug 2024 17:57:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwN7y61GNz9sS7;
	Fri, 30 Aug 2024 17:57:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BA8D48B799;
	Fri, 30 Aug 2024 17:57:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Nr-gvXNmG0Cw; Fri, 30 Aug 2024 17:57:18 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C44E88B764;
	Fri, 30 Aug 2024 17:57:17 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 2/5] powerpc/vdso32: Add crtsavres
Date: Fri, 30 Aug 2024 17:57:06 +0200
Message-ID: <8ee8ae8dd7dcd565a46926f164d549b21fcb419c.1725031952.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725031952.git.christophe.leroy@csgroup.eu>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725033425; l=2796; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=utdv6V/SvZxVA50hOk7t/lkGWDvSE1q/kJYchx6i5SU=; b=42jpAPflsOn3qVlMzH5/Gqfu25AjaEU/oJWoPfoeM5YZD4jpO4qqtwcz3emXwiSz6I53fTUGL itD2EsCfXO+CDXfDWiCxQ1kXwwjwpt5ONIwLyuzPLdu4/6bUeFIyJ3Z
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


