Return-Path: <linux-fsdevel+bounces-28071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829596664B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F422849D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7641B9B5E;
	Fri, 30 Aug 2024 15:57:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AE1B790F;
	Fri, 30 Aug 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033459; cv=none; b=HWRSshZuyz9qKEhjj6Uq2KkCDwSUKEwL8NHcaBg5PRTZnWIEXzdo63Rx3C/5BR9qLIoL/cOlrUNRS1tTriOWoCecvZp/eSQx3YIWOZ6Ic4O+OuecevF73SqYIRNU4KlrrgoeC8jv0xN+1cTrK8Z43VS7m6f7QWghk0QDrlv+0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033459; c=relaxed/simple;
	bh=8uyRGNGCCgVJfGMmDTrx0v5vR/iTZQuTWlNxnOkFWq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQGiWUrW61bcVtg4Z2PMWX6mTAAL3ZQyQUOPnq3IvWNKJ3+iDmuiSQfu/2wG6tfsfVyFPmVDf3Mzxv+03kMR9mjJJQP1IaQAebMjYt+/L4T1GYEEnhut+td9cg1lvIEtIo9X+20MbsBk9kWZBJhB0VgFiHkaK/HHKrfPG8wNIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwN802ZX5z9sSK;
	Fri, 30 Aug 2024 17:57:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q0mB1JG6GN8s; Fri, 30 Aug 2024 17:57:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwN7z5nMHz9sS7;
	Fri, 30 Aug 2024 17:57:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B41978B799;
	Fri, 30 Aug 2024 17:57:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uyx2pzQ4Hlnz; Fri, 30 Aug 2024 17:57:19 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B7E7C8B794;
	Fri, 30 Aug 2024 17:57:18 +0200 (CEST)
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
Subject: [PATCH v3 3/5] powerpc/vdso: Refactor CFLAGS for CVDSO build
Date: Fri, 30 Aug 2024 17:57:07 +0200
Message-ID: <7c1887fa51ececc322ce1bd66a775a41e87dbc15.1725031952.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725031952.git.christophe.leroy@csgroup.eu>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725033425; l=4208; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=8uyRGNGCCgVJfGMmDTrx0v5vR/iTZQuTWlNxnOkFWq8=; b=Ou6uC5Ey7EcHKFQsu9WPadpyZaZcA98uuLQGZhz2EkTjguuygu/aCnPKJxOYTFzPTTW2nhxai 7S/HmjN2ZjaDWg/Pij9CV+qCtd7P+Ofbb+keJz6knCTIYIjC7IXYElU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In order to avoid two much duplication when we add new VDSO
functionnalities in C like getrandom, refactor common CFLAGS.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Also refactor removed flags
---
 arch/powerpc/kernel/vdso/Makefile | 32 +++++++++++++------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index c07a425b8f78..67fe79d26fae 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -10,28 +10,11 @@ obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o not
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
-  CFLAGS_vgettimeofday-32.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
-  CFLAGS_vgettimeofday-32.o += $(call cc-option, -fno-stack-protector)
-  CFLAGS_vgettimeofday-32.o += -DDISABLE_BRANCH_PROFILING
-  CFLAGS_vgettimeofday-32.o += -ffreestanding -fasynchronous-unwind-tables
-  CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
-  CFLAGS_REMOVE_vgettimeofday-32.o += -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
-  # This flag is supported by clang for 64-bit but not 32-bit so it will cause
-  # an unused command line flag warning for this file.
-  ifdef CONFIG_CC_IS_CLANG
-  CFLAGS_REMOVE_vgettimeofday-32.o += -fno-stack-clash-protection
-  endif
-  CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y)
-  CFLAGS_vgettimeofday-64.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
-  CFLAGS_vgettimeofday-64.o += $(call cc-option, -fno-stack-protector)
-  CFLAGS_vgettimeofday-64.o += -DDISABLE_BRANCH_PROFILING
-  CFLAGS_vgettimeofday-64.o += -ffreestanding -fasynchronous-unwind-tables
-  CFLAGS_REMOVE_vgettimeofday-64.o = $(CC_FLAGS_FTRACE)
 # Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
 # by accident when the VDSO was hand-written asm code, but may not be now that the VDSO is
 # compiler generated. To avoid breaking Go tell GCC not to use r30. Impact on code
 # generation is minimal, it will just use r29 instead.
-  CFLAGS_vgettimeofday-64.o += $(call cc-option, -ffixed-r30)
+  CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y) $(call cc-option, -ffixed-r30)
 endif
 
 # Build rules
@@ -49,6 +32,11 @@ targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
 ccflags-y := -fno-common -fno-builtin
+ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+ccflags-y += $(call cc-option, -fno-stack-protector)
+ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -ffreestanding -fasynchronous-unwind-tables
+ccflags-remove-y := $(CC_FLAGS_FTRACE)
 ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
 ldflags-$(CONFIG_LD_IS_LLD) += $(call cc-option,--ld-path=$(LD),-fuse-ld=lld)
 ldflags-$(CONFIG_LD_ORPHAN_WARN) += -Wl,--orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
@@ -57,6 +45,12 @@ ldflags-$(CONFIG_LD_ORPHAN_WARN) += -Wl,--orphan-handling=$(CONFIG_LD_ORPHAN_WAR
 ldflags-y += $(filter-out $(CC_AUTO_VAR_INIT_ZERO_ENABLER) $(CC_FLAGS_FTRACE) -Wa$(comma)%, $(KBUILD_CFLAGS))
 
 CC32FLAGS := -m32
+CC32FLAGSREMOVE := -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
+  # This flag is supported by clang for 64-bit but not 32-bit so it will cause
+  # an unused command line flag warning for this file.
+ifdef CONFIG_CC_IS_CLANG
+CC32FLAGSREMOVE += -fno-stack-clash-protection
+endif
 LD32FLAGS := -Wl,-soname=linux-vdso32.so.1
 AS32FLAGS := -D__VDSO32__
 
@@ -105,7 +99,7 @@ quiet_cmd_vdso32ld_and_check = VDSO32L $@
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) $(AS32FLAGS) -c -o $@ $<
 quiet_cmd_vdso32cc = VDSO32C $@
-      cmd_vdso32cc = $(VDSOCC) $(c_flags) $(CC32FLAGS) -c -o $@ $<
+      cmd_vdso32cc = $(VDSOCC) $(filter-out $(CC32FLAGSREMOVE), $(c_flags)) $(CC32FLAGS) -c -o $@ $<
 
 quiet_cmd_vdso64ld_and_check = VDSO64L $@
       cmd_vdso64ld_and_check = $(VDSOCC) $(ldflags-y) $(LD64FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^); $(cmd_vdso_check)
-- 
2.44.0


