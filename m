Return-Path: <linux-fsdevel+bounces-37136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF87C9EE3DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B0E188A71C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30802101AF;
	Thu, 12 Dec 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l06NHYWZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A91F949
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998457; cv=none; b=h4ZsnJs/3mgsLmb/9BhK6k6H78d5hFkulZ0S2DM07/xHYMaJpvz8OAQ0ufJ5iV0ZjDeHuKkCyQSgD8LEczz60nIL9uK0WE6EcBl61z65p18ntPibxm/z6Pd58ns+kVutnoNhhnU9+XVf8ysI7NQ+G9+qxnVr1LLuWVDDo6i/cZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998457; c=relaxed/simple;
	bh=eKuDDNh7argPDDE0EcWPSszJu+ljYscU6oqO0moeG8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeqeN7KVBD9qRgjGoz6rRzzXeCPRWrcvQc/E2Mdmo/dejwcZdX8bL5koiPvqSD/aSDKGtcBszgGiy2WSTge4YYu9lyKlQVHxQc5QMmoGMkLbZtxemu3O1lobF71JkjMt6U8UOxX2AM+TXn3IXoulF/si4QsBojtttccO7OPF2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l06NHYWZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so281274a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998455; x=1734603255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=l06NHYWZaG1l897PP4CJ1CQE+j2RdZoVwo9aNvxU9WWxTXwrnNQDGellnfk+wAI5Wz
         udcaIYauzTIhQ+ZwnziC4cYNS+ihHnQ9X9FCGUX1AP2QGn/Re3B0A5pJFsp1b74uTi/U
         /lf5Xitu8m5exEbev5UyE+CMp1zmRKTjHIreXLyl7EfnGVIjQblLrFdfMKnwCvWfc5XX
         gba9C2c/ncc1rEEAHnHieAb2vqmE5QDWV0nEA5tC17VVD+Sk52idd1oZYVpsjIela4ce
         aRbcUAlvxAp5CY1TY156UTPde+7yXwo1jTPDQ7Uzas+26aKkJ0CgVStY2h8ivNoQ0lLS
         VUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998455; x=1734603255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=SBrucqYVjH4BGwI7fCULTKvYQfwooRcWfUX93v69/Y1o6Ism5pHXScx3L6VSOURhyu
         mBmrFXm8kwIY4J3aCKcn8g1aSyc1D/LvYzVZjpUWlKw9xdkLX9WaHDfyl568hlwtm4O0
         UAs3QPIeMYHXLhIn8bJ8y+FRoxdzBHn7ssYqEMhjVd9h05/ZpbfPdQeJhUgUry2FDmUE
         3bRfC0yGg/bgcyESnFjRPCroCGAVeaURZco/vHN+YKQVJX/apcXQpoNtbHR7rMnr1yqa
         kS8CbfB4UAgMaWX3WRPNCJwDPYnTE2A703nXj5kDp/6NGa/StZUw+ie8FPFCfLCU3DDl
         omfg==
X-Forwarded-Encrypted: i=1; AJvYcCVxu9jdiPhJxDZUW3t8/Kn3e9hJPS8jsOChiAg4zT+BYVbhRPCDHDHllRd6lXGHLMHm/ZHCdJC/sNnX8nhN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1m7xFNfw5pzxPo2kqIA5E55KCU908SgrPPc3QaZyRw/U18Ma
	daAZM8GXrJKezxeMgIJerU3bYrU+P1mb374Yb8SlbckoDR0AsQTK
X-Gm-Gg: ASbGncvi2AgbfEUgPi4g1kvBLKDBQmnilAm5MbXDOQDgScnz+KoN98kpvnPjFMI9B+m
	zhThy+vdhd6ypfUamQ1e3t78cTq8SpZkEN1M+b6rT5YkGkbx1j0V5h675acU1DSWSFJS+SxAgDo
	HO5FuduF6w/HDKyyy3T9cxs7ePztsTWBEcVSax4sjQWMXwfY1h5mdiGFvRgeVTO0LLum2tDurCk
	UtPZl/h2dg/8iNaKRWnxhi2rSkXGQWXLnjECl+jh532CMf+KgHglU3HgetoZNa0w761vCnk6cvm
	b8jzzGthkNoL43n5G9hLeyuRD10=
X-Google-Smtp-Source: AGHT+IFVhbe01ozM68JjhYH4Ulu2767FV6uMDBATKo9A5IIcvIgwdzomTiXfbfiCL1mxVboFbfpF4Q==
X-Received: by 2002:a05:6a21:398f:b0:1e1:b12e:edb8 with SMTP id adf61e73a8af0-1e1cebb7f15mr4365029637.30.1733998454879;
        Thu, 12 Dec 2024 02:14:14 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3e2d63fbsm8473250a12.6.2024.12.12.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:14 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2DA5FDDEEC0; Thu, 12 Dec 2024 19:14:12 +0900 (JST)
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
Subject: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 12 Dec 2024 19:12:09 +0900
Message-ID: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
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


