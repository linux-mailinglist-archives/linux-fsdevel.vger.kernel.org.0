Return-Path: <linux-fsdevel+bounces-39653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E7A16682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC94A169E43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAF185924;
	Mon, 20 Jan 2025 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayLLQ7Jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B82770C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737352830; cv=none; b=WGaTlruo/F9CZJ+WaViSE9JTy4QlnEFAzMBfPcHT2KbWWPRVW7caDyyxtsAzEOZggAGfJP4rQVNYNZnFyvUhq9d1NEQ9zEgRk/cDtYpjUVimE+z3UhoZY6PPhgUCexjlEhNXtosajO34066a9PQYYacZyeYTwGn+W8EiHrxfcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737352830; c=relaxed/simple;
	bh=Xn2RaNaReEp4HS2lM2B2ydz2zvsDs19KOeICSn68auQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB3QqVoNNSwROeuVK5rj6yKOpXu9qKPx7/7FR8+Xd3aK8M+2pvsaBiei/JAP21pR9MorivQCwpjWPYW1/v0KhBSYf8nlMj7w6D9uQ8whdGoL3Kj/liUeUqiWI9dxr3Qnd9VQSgCRvdapR2ts8HDFjwUlDY4jsu5zJn/Oa7v91r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayLLQ7Jj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166360285dso77642285ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 22:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352827; x=1737957627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=ayLLQ7JjTeA+nvGxVZIfRxlYkitBNIsTna/FDDpiau4zmpTsGLLv0/LxvHmsqgDf34
         UZ43K60IdH6YCUmcOVTnbYpfGd1TtL49PXPqzvb+G1LO+c1MwvAl2+sCUm1XlBnUzRjs
         OJWKWlzxRI+V61xWlVfrGgqpwNHYa2fkv/5mlMBVrV0d4O14gIRxdB6mvN3emiePwt/6
         ExBLkyFld85KX3Oi2O2iJajWojgLfoP6qnwA7tRG300JoIJBmzLP4V6+flRROkU8bYF6
         41YoTxpQVG79f7tnzyRvwBqHbGiCy4tMiaKp9G7RTK3ktFlwF/AlOodOxGLkkiFkpQ8G
         2QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352827; x=1737957627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=H4AAiIq8PKSlK/MllhBIiN8bvt5r6YBcbGO/3bDgO1iIi55E0s8L4f4F+0Al3z87p6
         4DtWHHLfFdIe4OHzq4DFYNiT1qlJsApMp6NyQwhe4Uoja6oMS/TWCpfZF9I6giY3Qo7l
         M32eprspfjt95E9ODsWBORF/SVkmyIzBkLlS6UdX/pMJzoRKqsxqvTojdEkIxWWdmr5F
         RWjfHAMh3+KUnCJ/hNeQ7Yax0FlBMSltPnQKfbZgalkPPsIrKzBT44ARe3E4C1UIM9Pg
         y8u8vFopt6Gb1gRTlCZiPcluiGkhzCVoE5NtN226nUcTEF0AgwMDyp8IlxJfcvP+gz9d
         bIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWde2najgLJm8gM3wvY0VaN5puN2l3csqMTDeHm8pIwH9vGOoBpNQbaJ935OPhKYVjYx+8ErYugdyDoq45f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1KP5IM9DOdSmmZlRocJzT5gbTAxyaK3GAv/sUlwPiapPu3RT
	3IyepGKQbnQTepnsDNk+HoDS8rFmr+hZKIG+8Qb5uvgBFtJoClN+
X-Gm-Gg: ASbGncs9xAQxFwWwWFJlFvVYGb9XjH6Aye01j/4tbasOAX7IhnlO5lSalSugP7gQKPB
	7Dp7rYpt7gURh5WkLN/9Rs+pLMNaVN3g5u2QcIbCf6Ntv0LLvCG6hPSaaaZD9Ae90MVDPWmLxP7
	CSeKQGYnly0x1NiedsbgnQtD6ESAhymu0gIKePn2yuaQbRVLe4Te2NhkC+4vTJXIdYkku+I3Ofb
	jExg2MJuMpI/1JHJERGfgNjYL4kIcCF8vaRRSvtB7OIlNfCwOcAk9lFlKisonvqt+3PhyNA7Ivu
	lpKkXfjJDFRdi+PckX0+BYqzWVXCC0SsVb5rjTmGmw==
X-Google-Smtp-Source: AGHT+IEHeuTXy8q3JvsQ/TcxbAalRbkjb77Hq4RpM8tf7n3KtZQMqCH3X3otCgb8yHvy546rNESfFA==
X-Received: by 2002:a05:6a00:4fcb:b0:727:99a8:cd31 with SMTP id d2e1a72fcca58-72daf97b5d3mr18400418b3a.14.1737352826972;
        Sun, 19 Jan 2025 22:00:26 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9b9966sm6149948b3a.86.2025.01.19.22.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 8684EE27526; Mon, 20 Jan 2025 15:00:22 +0900 (JST)
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
Subject: [PATCH v7 02/13] x86/um: nommu: elf loader for fdpic
Date: Mon, 20 Jan 2025 15:00:04 +0900
Message-ID: <d9dd391ee565aa3ad1b8ceba5689caf888f6bd85.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
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


