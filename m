Return-Path: <linux-fsdevel+bounces-32724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441709AE46B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623D21C21E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477991D1739;
	Thu, 24 Oct 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II7RILky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569B1D1E72
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771800; cv=none; b=NE/QxsmP1Ay5MfrOKONW/dYSI73+MKUVkyhqIeUXp++ov2wTtLxB0nItM44J93a6k1pivAD4bFKs1k3wJxgmX29yNAG58FuIcOJfEHux2W3i/4ylYBnBVr+9lQfM9eeC9TFlbncaEh1/endpybwLyjGKEp6yvMoQF23ChT86Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771800; c=relaxed/simple;
	bh=1x4d11aIFG1EZdWmBSrSH52hZelRmwZOy9d/XQFCGPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiKjXFcdWL7XckfRGDy7+dTp21EWYweTBJXPscU1DvhG74wqiXj4jNZbiSPsCkqZCkdron80ZBKv+szuSCg5Q3vSPL9dmVjJBdmR0Cg1AVpzoMwd0JglqnCYQjre5Nb1Fkxhxz0mK6gj1Db+02ep8x8F8wWSkGAIyatTXyvcxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II7RILky; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e74900866so589840b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771798; x=1730376598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIytQe80ylla7Sl/fe5LxDRRHtWVNhv8vhvelm/o17c=;
        b=II7RILky/BD+W2OHkzJsK/T5pc3hrrbg2Hz1HWVGM7uvKJoYbYCg0kQWXp2sNnVbZh
         qISRb1Z3oKaUrsuzy4VwZ5XQsf9VbJAuOyrvT9toVuNL+I+YwAkfxQ8W/HpluZ6h7poG
         QX1TLXY5gVQw3vg4jtxylTmYRdRUt3eJuDMip50agvX5ng3ZY7igL38Wl2BJGEkz0arL
         s3O9jKaIWEJGXvuaaPa6x/CLckla/8VLS4JkQV+GCAYJQ8sbPJpgY1QPOFJc6rrbfCp0
         mKP5Nz5MzGnXtxNYREnzFsdNvwiCQu8yhBw/lrtxgVyqO8Oohip+B0ctyjl+y6YgH35v
         ymXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771798; x=1730376598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIytQe80ylla7Sl/fe5LxDRRHtWVNhv8vhvelm/o17c=;
        b=PmILX+xXzfrTN4w+chC/exef3q0qem30zutP13PR4mn/BDqmU4KbqCoIpjI8lrVIBR
         CxCCb08enFKaaL/CHUgq4lJ0edClXzKJey+CWCXiLO0C9VgH3oaor/K0kJqma1gKu786
         kkcWTNHf4p/RMZ1RJl5LYz7fkD73XReRxEwvq1HdwL1inqfJXiS3kH5X7Sf6wmDDF5RO
         YqJVfwsqyGvfOcVqzKEatC30kJ2QVFxsLOSFLVkecGm+WoAbIuBzglTP82ZXbG64L5as
         wMbpslzVRA4glc/RlEQgk8FOFIswyG76NHvFUOHeZsGgXpRgEKbNw/ckBx6FbqMYUbq6
         B5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcxYX6Xdg4e6YdUL3p9Vqe1N4aY0FC2agGnToo4U3n4OdDpnYogLOEu5Tysf6AB02PIvK8opbsRGqVsW/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uxweTSyQUqMiJwh9NbhsLJsMm+iBbGPiZ1FsEGtomSu4W0pY
	RiG+rDBVLc1ufEq2poogQBWXOxot+buOG4js9GGTuEDmXT7I9670
X-Google-Smtp-Source: AGHT+IEWx31qom/T9NynWTwcS94S2CIs7HjdghwcESDW4t/deHJ+ZjzUUv7QSQwXyIjcl4756ZTDog==
X-Received: by 2002:a05:6a20:43a7:b0:1d8:d3b4:7a73 with SMTP id adf61e73a8af0-1d9898fda0cmr2115741637.4.1729771797871;
        Thu, 24 Oct 2024 05:09:57 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda22fsm8492096a12.88.2024.10.24.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:09:57 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4C46BD5124B; Thu, 24 Oct 2024 21:09:55 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 02/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 24 Oct 2024 21:09:10 +0900
Message-ID: <db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
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
 arch/um/include/asm/mmu.h            |  5 +++++
 arch/um/include/asm/ptrace-generic.h | 17 +++++++++++++++++
 arch/x86/um/asm/elf.h                |  9 +++++++--
 arch/x86/um/asm/module.h             | 19 +------------------
 fs/Kconfig.binfmt                    |  2 +-
 5 files changed, 31 insertions(+), 21 deletions(-)

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
index 4696f24d1492..fefa7631394e 100644
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
@@ -44,6 +50,17 @@ extern void clear_flushed_tls(struct task_struct *task);
 extern int syscall_trace_enter(struct pt_regs *regs);
 extern void syscall_trace_leave(struct pt_regs *regs);
 
+#ifndef CONFIG_MMU
+#include <asm-generic/bug.h>
+
+static inline const struct user_regset_view *task_user_regset_view(
+	struct task_struct *task)
+{
+	WARN_ON_ONCE(true);
+	return 0;
+}
+#endif
+
 #endif
 
 #endif
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 6052200fe925..4f87980bc9e9 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -8,6 +8,8 @@
 #include <asm/user.h>
 #include <skas.h>
 
+#define ELF_FDPIC_CORE_EFLAGS  0
+
 #ifdef CONFIG_X86_32
 
 #define R_386_NONE	0
@@ -188,8 +190,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
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
index a3b061d66082..4f7be1481979 100644
--- a/arch/x86/um/asm/module.h
+++ b/arch/x86/um/asm/module.h
@@ -2,23 +2,6 @@
 #ifndef __UM_MODULE_H
 #define __UM_MODULE_H
 
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
+#include <asm-generic/module.h>
 
 #endif
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


