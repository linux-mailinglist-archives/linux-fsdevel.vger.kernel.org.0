Return-Path: <linux-fsdevel+bounces-66686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EFC28CAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 10:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F14188AEDE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FB263F30;
	Sun,  2 Nov 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs4UtvcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E9224244
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076993; cv=none; b=qrHTNy+gJy0HQbgYucNG4yUxK9i/8zFs7wu1fANqkCzXQnay3HVbmSd7xeL2k4Ph9otKsWsi63+tzFMXS3h6fhY9s+1DEqRe8zFIi/hHWxF60S901tMRNQ/2/E4xuSBCCRtAWsg+nubPhGgNQBL9FR1MCizQ6q26Qf+RjtIWmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076993; c=relaxed/simple;
	bh=vzlHvi1hpehuDtzoLI80fmGg0yF2KnaOx/kv6IzWt0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmxfWV3qzpLp/Hjwm2YQWxliag5DrWT28ANMFO5m3pL0nQ+oEEX5MXWwq/VmRzwMXNEQXgJgMm8UNBKKqyJNmGfbsnF+xlC24+pP48efUsUssxjw8hHFPWmk7n+eSDTa+LmYkLC+n9US/JeZYDg7Mh9TNOPsu03YjQLIWHWVlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs4UtvcD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781010ff051so2795176b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076992; x=1762681792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GAo7QPFRSMtQ+F+v51lXmGXWMCiRMzi5C8xvTtplUQ=;
        b=cs4UtvcDGXTvL6TbJgVEIK56EgbSZ8sB+rNtGI6/iKvRuGqIH33Bhl6XOD1cyL0kc4
         FL+EFAGGx6zs19kz+G5X9X3nTVb2BVC3XD0oeoMeMBICYBpVB21R1DDTzmW5OEa2P793
         NFBAWz87Z3OTE2VDYDkQp4cR4VUrJhXFaALegcYv60R6sEPPNTC9z6gxnbmGhlZe5VGp
         1yJFAoZ0kTZtJ8ApMGOFSD1nR3LQ5eAj64ecm8bMAHrWsWHjvduDz+GkADcR7kyqog1A
         00PQ73zo8HMUT80gdTT6bVXssDXq8GxaYl5vJfrImCL3nVtHsAzmTFxZ5cJbaNyBUh68
         xLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076992; x=1762681792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GAo7QPFRSMtQ+F+v51lXmGXWMCiRMzi5C8xvTtplUQ=;
        b=ryp6yhzafichv59aqbUftwsMksSfMxG9xoC3R7MljJ7IHLIaCrcPdGIKQ2EmsqFk5r
         z667L0fd3cosFQl35ZEHx1FbXQoqndHEkKda8wXJkEzQR+t5f9UfiHu4g2F0ULgW/ENw
         +r0iYwqygLv9pCxkeHJmdzCPXyMUEXDqoQRbwygCND9HJ6ucZCKzAhXtFyZ6UR3eilLM
         DNSB40+htUXDB9wv8dIWnuQrca7flLJBFCUqUqrLL279DOvoszVEyJ9f1R1YuETxeFvD
         oa1DUXTubWLBNyU4rUpKTatrACGoogCXyawup8T8BwWPcfZ1Ptq6p1+gW9LXrtruVdvd
         Hg2g==
X-Forwarded-Encrypted: i=1; AJvYcCWQxeHKY9H6LFIVrd1HiE4NDQcNi2mc8mdOmAvPXMu/ZwzNmROk6c2FK2CtpyDcHIMaQtGQODeb5MRpCS7J@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/FC5Drjc+c2vpEiVHe4K2jdKTsiedu9dovgwFTH6Vxpu2AV2
	/1J6JE4KKcTlL/KXzceBngfOWb5TrOvmv0Y7Lmhsq4AJ0pkrpNCiNvzn
X-Gm-Gg: ASbGncsmws+lrF+PtL1xwcE4GhBLUWGDpbeLQf5wuBQoKwgz0OvZCOoYhXXjSev7BSW
	vKyHuI6ICpNZQDiZP9hAyVzHVUiQVUFfvI7HkrncDmawxiQsBk6wVqYj9H/DYvnsFBuQLdaxRPg
	dmSfEUwAIP3y2/fAg5IoJhOyuafQpVIO3wPFtCEFDiN88Cl2OYPwk+iyQnIrEwK4c8QEkUkjnz5
	Qw+tuUKiRzZUm/KwZcf/Dq33VwZT1Z/jAofR77SEcJveyYvieU+RaXFxxiEIG72bcvF4DP6DPNG
	Tzv9i1xHZQM5viLZ6Q5HNThkl2VIC0JkFlM3F82PBe/rs53KQVhe+qNswWR7K4KwP7vTGCa91CX
	d/a8IN5wThk+S9DWoZTOYHGRhnAM6bYBYcOzOSeZCcBWjNyfs8DwPUG5yrfkhEvDQUGUEOLy8wQ
	zhPuovs1qHdSkLqfM5bIl1NpB6EWXmRJZMKWc6tiu/tuzZbA==
X-Google-Smtp-Source: AGHT+IFjPZCZPoz2w60NDnASz0MjN7TYV8NIqgCnj6gVUAWRi7VL8ewmGqOYXuj4ykHVff4Lv7oBqw==
X-Received: by 2002:a05:6a00:1793:b0:7aa:d434:69d6 with SMTP id d2e1a72fcca58-7aad443af35mr506394b3a.10.1762076991691;
        Sun, 02 Nov 2025 01:49:51 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a9bad978c4sm2738154b3a.13.2025.11.02.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:50 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0072711237FF; Sun,  2 Nov 2025 18:49:42 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 01/13] x86/um: nommu: elf loader for fdpic
Date: Sun,  2 Nov 2025 18:49:26 +0900
Message-ID: <d0537389ac18acb03ae3bdaf25473d56f7e74f4f.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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
Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 07d48738b402..82a919132aff 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -21,6 +21,11 @@ typedef struct mm_context {
 	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 86d74f9d33cf..62e9916078ec 100644
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
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7741..0a92bebd5f75 100644
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


