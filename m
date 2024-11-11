Return-Path: <linux-fsdevel+bounces-34190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF209C3857
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C48E282253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6519155335;
	Mon, 11 Nov 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7l3T/Uz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F74A933
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306471; cv=none; b=QLRaQVNg5Ch5YYmmG/nJgFIrxRarDAVhtIGkTPQG1f1qmomiLV1+Xo8fbEkcxk5Pmls/iY80UYkrdT/0drnQIW/FJYuiY/MPlNEd0LoBMfdkMOMiKx9l0SErby1QTuAGjAs9hprmrdumrceKxeTp8YmsW+oyom0hndkmSIztQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306471; c=relaxed/simple;
	bh=G9EmF+0U43TyP3yqFZHh1/jQ40jHWSoJmoQ0KBtyI7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eguV42GiyhHcv7KdlxmfIZ079fjdOACNThPx/+A+o7ElTVdHcUyCKixu+rrNzi5YyhJy0FhKTb5s8XF0Esii5m7EI0Yhew0TBpTlCccCzlhsMA25iWvxUnDBpoFq4sSXiVZnVhIgjU7ExbUKEyi5XpTWZjq/sDTF1G1dbxxNu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7l3T/Uz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72061bfec2dso3832256b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 22:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306469; x=1731911269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOVZBEb1qaBKyIOwwQleK43822fSZbq/jfSKIeFdX6E=;
        b=W7l3T/UzA03APVISDKzhBt/4q92vGXajhrT4U1ea3cmyoSOM4CEz9Isqi3IJRK4FrD
         SGXmp7H7BIooojL9TkHxAt/kNKgm5TOSUTqi/mnom6+iDYNRzFbeYDn12y7XgqYXFVYB
         gjh3ZinRaLnyA1/xsW0dt2W1EvazUV1dpmOI1NU1AvsU64FOt+HwLnVIMdIkLwXWYam/
         Sg5sMzP9aNgdZAp8Atq5yVyoLC+s6eOx61/WQT7RhCFdqzpQJrwplBVURYDGyjIrmgH2
         Zeu8NNbU/Uwm1AHGz11oysdaHCSNhH9oRY2Ev829gHD4ZNhovMC4cGUl47ym1b0Uz8eT
         KFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306469; x=1731911269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOVZBEb1qaBKyIOwwQleK43822fSZbq/jfSKIeFdX6E=;
        b=NFPOL0XgaKU1MOXSKgtK1bYjpala14gISfpVYWtC2NSeCrqnsRr8zKe53jwIUd8Wte
         /0nDYy0Yo0Qu6HYUyZJSHMG1JQ2jzcFR1j9/4QHHYu9HVG40wnxV+VPtuv2+lYwTabuE
         dxzJFcEhh0Y4g2CO1uMT944bI358pEmJ38PXPhX7gkI9/vr5Mu5rf55Um6HSC+qxZgW9
         eDZR9/NW9hl3Z6kG7cD1mUli3F6/wMXFwUFx8DQrnEEuM0A1YTPkQypUuoAMkz4AkpgG
         AY2LBCNb+nvMayrSExvV2nAA+olIP4UW+L/29OY58NX3M32ZO721LnHQUIyQu33rcvrK
         S6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWxisBRomx2+G1Op3ARiiGbaERd6eoyZi+urpWLNrc6OkFXzNKwAbxzgBB5CVyKzCA7wfEZQP1+uvqSVycX@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJ5wPmSChvmOhtdWxBhIUFZxtKgdwKk7rwCekzjbi7CCntM0y
	gEjCHMtlLx9pFsnzzWDS3Dq4HfDfGJ/bEOqSGeT851uGKfaRBbAu
X-Google-Smtp-Source: AGHT+IHr4mrXQCJG6ehz4R575ji8XJjfRwnS/MkIAJ3E4bPBw/vNBMDgKXMb0Ui2eNQcCUFveGlOmw==
X-Received: by 2002:a05:6a20:4324:b0:1db:f06e:f666 with SMTP id adf61e73a8af0-1dc22b91c5emr16383347637.41.1731306469013;
        Sun, 10 Nov 2024 22:27:49 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f8f5d3sm7819534a91.27.2024.11.10.22.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:27:48 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 43199DBA916; Mon, 11 Nov 2024 15:27:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
Date: Mon, 11 Nov 2024 15:27:02 +0900
Message-ID: <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
loader, FDPIC ELF loader.  In this commit, we added necessary
definitions in the arch, as UML has not been used so far.  It also
updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/Kbuild           |  1 +
 arch/um/include/asm/mmu.h            |  5 +++++
 arch/um/include/asm/ptrace-generic.h |  6 ++++++
 arch/x86/um/asm/elf.h                |  8 ++++++--
 arch/x86/um/asm/module.h             | 24 ------------------------
 fs/Kconfig.binfmt                    |  2 +-
 6 files changed, 19 insertions(+), 27 deletions(-)
 delete mode 100644 arch/x86/um/asm/module.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 18f902da8e99..cf8260fdcfe5 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
+generic-y += module.h
 generic-y += module.lds.h
 generic-y += param.h
 generic-y += parport.h
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a3eaca41ff61..01422b761aa0 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -14,6 +14,11 @@ typedef struct mm_context {
 	/* Address range in need of a TLB sync */
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #endif
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 4696f24d1492..4ff844bcb1cd 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define PTRACE_GETFDPIC		31
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+#endif
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 62ed5d68a978..33f69f1eac10 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -190,8 +191,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
-
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
+} while (0)
 #endif
 
 typedef unsigned long elf_greg_t;
diff --git a/arch/x86/um/asm/module.h b/arch/x86/um/asm/module.h
deleted file mode 100644
index a3b061d66082..000000000000
--- a/arch/x86/um/asm/module.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_MODULE_H
-#define __UM_MODULE_H
-
-/* UML is simple */
-struct mod_arch_specific
-{
-};
-
-#ifdef CONFIG_X86_32
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#else
-
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-
-#endif
-
-#endif
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index bd2f530e5740..419ba0282806 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.43.0


