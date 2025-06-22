Return-Path: <linux-fsdevel+bounces-52425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21AAE3260
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0F21890777
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C90F21B9FD;
	Sun, 22 Jun 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jisSHjhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDB218596;
	Sun, 22 Jun 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628007; cv=none; b=ZYrn9A4uYVIfd/v8qgCtt8Eo7pw7KctFj7GQlJN6jLdiVrP0EcnEYA1YcbVrH3IJfA0bJMsBYh4c01ghhI8WKPOKHh8nCVsWgt4EfftTrSpBxHS/Kno0w0odbVxAdqvAoJwrL0aEYf1Ls7QhM/epNQdY4Ji/71By5xROgodevk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628007; c=relaxed/simple;
	bh=fm+AK3tlrTe+gYqKBawZVsKJTfAyjuWAJWdKg3VZFJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxAYmvHdRSq76jTUxngVTZmKrihy5+XlVSD9qYEaMYInvz1JRlO/5zUkWQSWIEt1W1G5336SvSH7Z4ls80qV8BRXYAgUQBYmHLmXsKNSdW2IuMbx+wu6ydQn99XDko3y1C1wGMU6/1h1EZgBoGnQ85p2+nBd0HUJaA2J7XqDEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jisSHjhP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23602481460so30259185ad.0;
        Sun, 22 Jun 2025 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628006; x=1751232806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=jisSHjhPBZKH94qCgVft8NrvEpm9pRsHMmHaIxYqwCpzbFvwQbESV5vdCqSK52PX2o
         DEjuiWcAzwbpLdcmENsG8E2y952IAcPzOA3TckS0m7Gi/C0JoRQxipHC5JieThYVjSSs
         nrMDGyLMGgdd2qm4zZSm7VfVUS+xEWP3cGIR20lkSnGp2MFc0gEOi0QzTEMTm8Y9wnwx
         zqnluQSTXJIjuEvXEDcIuy75z48MXZhusk+lfGNbmlvfzfDNzM0XNO+rN1aadGTWowYO
         4rp1/+2qCXf/DIrOdbxeGb7vS16HMYu3fXO2Dhm15chsj1m05h5w5+P4MA4fMuvLK4cx
         hhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628006; x=1751232806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=Y74bElSnY7p/emPE4MHn2rk9/AAxycrQ/46jBMzQZDo76b6+f72lHq48c1PMmC0EY7
         p1/f2GDgLPAImtI1ZGqFwQPfk3s+bsHUgTHbNqzQhsI2j6aqhkTEgY2gCqGdywPjmOwr
         7v/TAGDWGCcvP4ULD38FyVC5KBDIZmP3uddv8TjzfaAGWdDEQOEp0eN5ajhM/GJcat7i
         IjnpsBUJqarMUyWpg0+Zo7buJfysgp2r0gHvS/2FHCgKg9kdpOTdinTa2y/gQQFhxMXg
         NVphJq6YBxJvmZG0V9FmK6DLTWUt49KOb7JBK9XLOqWK+OyWjKsjaln/jSlByObImmKt
         4TuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfvMvNQEwwrTAW/wsWkaSjGxI+i5dAehS8UPvvzhZxLl8g6u8PZsEyRUrj1coTLhifKgg1A36jRxzlQUkL@vger.kernel.org, AJvYcCXmfrYIWi526Bnvy6ec9ltB6TuilxhlId6G8ft88/6LLLraE0aWrZ0ay3f3dKywlTrmy3QB1o7/1sPzk+aX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xc6EJxXAhs0u68wl0+4EcSDbm30wkrqtNQIUxk87jaZdivGU
	eXwIb7D0jbztWgC2KCp+xn3x+bWSaKD+HGxedfVmNMiUY6dhE/WYo91X
X-Gm-Gg: ASbGnctNtjMg/h95Oq+jX7o+CYQ2zVC/Pq/6qSpd2SjKZAF5G79qUiUNR1eDYQ9fynv
	yyApDjisfa5YQBVE4JL0bHPEWvqkXyRKMuu9SrNDpELFdk7ATrHSpuUm/kbm/qlWDFTjLgV4h2e
	qeYsa4N/t330JmTunOLYxClZfsXYz4+GG9liA8SRh9aDzNApiD/7vz78Feb4m9S1gO09u58D8Ud
	NDmbIxSwuTNztsXwoyXsVFYZIsHkSCpx3YBw+4k7vjD7LY3oXNa9GxDquHtk+vaMFuW8Z4W2tjI
	VpdTb3R6ttL1ihwQKDYMizUoNyfTX0nRS+Ny4nwnmBWOXXUhdfRQXQ0AIoY+Qc0LUj6d4GWbZRS
	vuqn8v14WdQ2RVQ9mQ+T/CWZorWeChtYZ
X-Google-Smtp-Source: AGHT+IE/OyFdRvoMZNChjYSNeiwAt0sGgB2Kp3DYDGisjy/68Lf7lJEd62sOTC8wwxO80U6hLupeeg==
X-Received: by 2002:a17:902:ec85:b0:234:f825:b2c3 with SMTP id d9443c01a7336-237d983d1e7mr177001775ad.17.1750628005666;
        Sun, 22 Jun 2025 14:33:25 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83d5c97sm67821005ad.70.2025.06.22.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:24 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2359AEF1EA6; Mon, 23 Jun 2025 06:33:16 +0900 (JST)
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
Subject: [PATCH v10 01/13] x86/um: nommu: elf loader for fdpic
Date: Mon, 23 Jun 2025 06:32:59 +0900
Message-ID: <e09d413c2c32673469730d90a5852f94ddd18cf2.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
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
index 4d0e4239f3cc..e9661846b4a3 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -17,6 +17,11 @@ typedef struct mm_context {
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


