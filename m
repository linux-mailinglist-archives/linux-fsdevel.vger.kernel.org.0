Return-Path: <linux-fsdevel+bounces-36306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612329E1264
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBC6B25958
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC64168C3F;
	Tue,  3 Dec 2024 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G79EUy6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090172BD1D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199812; cv=none; b=qCdKTDhjJa4kb3H0x700r1lwmb2p7a61kxYL07ibOgnrSYaNHgpnqGp9aPHGSlPAB9snJDS+F40WX8Uw060Z6rpTrLVbMCUw8QI1Dm12bHvT0A9lUj0yl/d+SWcdpBAeC5ViwJVaBg/rW9aZHGVsmIjSHGNZkPtaXTNVXK1/ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199812; c=relaxed/simple;
	bh=gpsT7MwCI1KAtBPmoExqy3TOFuP0AjrIseeyltVINzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4P5WFqcHdQYKQH918f399tBgrjX5CCZT5tZKK5QBCBSNcJ8Nzvu3QzuEeSj93l7+62QPZ3mzsDb0ToaOyJLVKS7YqgSh5ZlG66K0icnHFUZ3lkg6RqL3IxusDAYFAsTvP61kSkC7uekpT8v7dyqbcEs+9EZpPY31dOLkbrNxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G79EUy6N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fcc00285a9so2019955a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 20:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199810; x=1733804610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMDksIbcOLWGwD0vO5eo1YOj8LatyWo9RypORfUk9j4=;
        b=G79EUy6N/e7vP4ssUVAeq+BMLyey386ClK3nCL4MKh18ByD0mlaGxtwa7OR/kp1hFW
         2OX2V6gx74YCkTCs+vFhyP/hN/z/hfwTWpOg6OALse4Z6/3iNL9Jb8zWQ35Dt1ZQMWsl
         sl5vv+lzri9dGbW1W5RtQZsZF2SAdeF8cm864/4LDdxKpt425fcmG1TKAX4FMmqplmq1
         Scz511vdYvwdibBcVVmxS+Oi9wy50CXb1I5TNkb29dSiQKeeDt1StOhcdVKueQTL1YmW
         lRPGZbpQSG6MjOn9TqAS3ACIp9xqVIowwAC9qCU9v7JGhaCkERvOSE5/ym9lGahFzZos
         B9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199810; x=1733804610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMDksIbcOLWGwD0vO5eo1YOj8LatyWo9RypORfUk9j4=;
        b=Pzic3hEiiO0gztl0/IPEa8RfVJgYQx2EYK+dW8HSZOeBK9IrLrtLYh+Syr6GEe8AaR
         d24TlmU0Jt+KAEMj95wllOR+6jobJ2g92UWeDqHUYA3aXUdxlHhxUBDdCALqXdOnVupH
         MnHKgV6upDSZDnDyeEGjBSfqWE3MSkvvtLyqkI0vrk2BnI42Bk1dtUwOgUtsKhMDQzLb
         gVpE7RpXtFqZYboSm11HcfCkK6NoogfPUHD5mirGlO66QVZyzuWi0LyhmkMeh1G0Yc7z
         8BII0sNiHIwIWh2AQjwhE9uH14xFORmyg7KcB1ohuUYB70budBoeABjV5Fn3FaXOYlWB
         AJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTMRD+zY6Nebfv2UdiUQTx536hwrJ1LshsdLFhmbcsFrbd1ntlD17HUFLMfFpp7Wy3VQjZyXIFeNGCRajW@vger.kernel.org
X-Gm-Message-State: AOJu0YymCzjclaBsExIFYAjCK3s4dRskvY1PH2PnhSsY1r8B5TlY7S+E
	XWRxbszqgc3v4w1Icb24m47vEKg/+i56xsFDezZKM/IZ12AAGoKQ
X-Gm-Gg: ASbGnctLEQg2+f+MylguMpy9Bkf5BiJZCi4m0lRn4QGyJPH37WTQZuZMHnWS/i+F8Ar
	7qN0uPFpFb5Z/oC3s12TEBm9pxbN8pP36EKz840rl6UQINIWLjm/DuOpoNjRM+G+/8I1Ek6242k
	/zj/cvy0cSz+Q+6oTJCHaGkhTxRO/K+MDfkY4bcHrVm65FPCxr0nGChg1HangHd6my9kGa89sm5
	SzESaKIKXet3IgDWarYfX34hWnqhK+s74C48v2RzOn2acsdaEu8PjyEPbn/xuOHRlSL76d2WWZ/
	NPVb6r89+OErgDLwsqjX
X-Google-Smtp-Source: AGHT+IE8xdk48VpCN/lmNtJ4mSg7KBUaDEkPOtXNpXZN6KheBo7QC4wgFHpv7a0bXxkvqLx6Sq1RtQ==
X-Received: by 2002:a05:6a20:3941:b0:1e0:d859:e1bd with SMTP id adf61e73a8af0-1e1653a7bb4mr1623878637.1.1733199810346;
        Mon, 02 Dec 2024 20:23:30 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848924sm9701523b3a.180.2024.12.02.20.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:29 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4E210DD39FB; Tue,  3 Dec 2024 13:23:27 +0900 (JST)
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
Subject: [PATCH v3 02/13] x86/um: nommu: elf loader for fdpic
Date: Tue,  3 Dec 2024 13:23:01 +0900
Message-ID: <215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
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
index 428f2c5158c2..04ab3b653a48 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
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


