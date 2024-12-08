Return-Path: <linux-fsdevel+bounces-36703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7609E847F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1431C165253
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C93139566;
	Sun,  8 Dec 2024 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZHLOzbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E438DD1
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733652957; cv=none; b=AZyRY3eCdVwmlJsUwJUmNrDRUwHNa1IWR4oVb1SdiXz+QW1lJ2zkVD4GkwSitAyawc2tApPpI44QUnB/UJd7xyOtFVskSAzf36IeGm2oNFElpX2ahmD9fXHm0NGNgpq+1hMSdHA0CArkO72JXwpqKm/5XxJi1ve1QSrTx26kkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733652957; c=relaxed/simple;
	bh=eKuDDNh7argPDDE0EcWPSszJu+ljYscU6oqO0moeG8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzGzpCyRHnYRDzpiwIWKFgQtBx0//8szc1v8a4shyyKVo5uN0b8lVPPsrCAUS2sf0Fd4toOFUzNH4q2FiR1TJ5Eb97rgPmCe02Bawx544JTo8abtrb9IXFTMcnuIgV/udNXGJhiYaYYMWuufJSkypphnL41bsaXLzH5+EkZSVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZHLOzbD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215ac560292so33568915ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652955; x=1734257755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=QZHLOzbD4ZcLVCcBRpcAqJke+WedEok4n6A90hYsyRb40jrI5eZZxXsg8xG1L/Eu7+
         u+79pgtjzbGi0V5fwSPL0QX8sulsLEqNyJA3Y9gOeOydVyQRxk5WWv0kGnV47Hscu0/H
         GOQXtwoJLH8BvT45u3JJ6kVHlXVivfTh0O2H/I0XL8NolR3FcMpHO1/RXCKq/asR52SF
         FkvNZSl0bAGrqNn0guQGoJrFN8ZZfJ2mqD4c1qRBJCZxK7oLcmxDjFi5jem02I74lXqj
         uxdwBQU+VeL95jo2+aXaIUhCtV2ta14hBihU16MvTtsPu5n/f01YKOoGboeDw5xQBBBG
         J1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652955; x=1734257755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=qAvCJ2jmT7yLOMNCRT2byM7eqz46XhOMrzi4csYLOF8C40kdOqzArwJk27SGZctvfQ
         J3OrY52BRsJed/Dv09ElcV6gmoU2oKnUat8+fK2nG369ORobZj/4YM4nsLwTQR04W4dk
         r7pusk8jmkg/cBcShenZ9lJLt6MOpuZ71ZGr/7wYVCONvxerBhsc2ontIab819ZNaKRF
         2xh7o8VmA+A4jCmesfqa0lPpJda6kgDYaZiz1FfXylHKaZ20bcJw//7V0VjXSTLesHRy
         DJNdERJbiRvcQdRiYzSiBCiBFvjZXgY6UonJ27dEY9wjB0ljm3tJ74rD5nZjWdGpd6sJ
         TNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd9eUGtTQNT8D+IU/o/4Za8CNCMWNmgUO86jFW+rYNs12UVqyAM2JsRWJ1sgeuP1Nq5WEAZPMfB8OMRblL@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmupW5O4TbHUHgSUYnKR5nv8lTOIYQzQcxscYWxSsiRx2d5Nj
	/epWrbdY7ul+t2dBVe7a010h2Sm9Z6lpd7VFnpFfy9LWktPkgycA
X-Gm-Gg: ASbGncsGWWyLsWqgVXzYo9BkRR69ZqbgA9iv5BphdOKV3yGzJICKaqS8z3OqNl9PC+E
	nNLihlezktLazvPgb74IK/y27393aBY0tcYcH9NZ7jrz5nRpmKkfzjGw5wbv7It9S9pRuAls1DJ
	+6gzmnqxnKjrLl2A+TMYieWDQCIBtWMRJINZU3sNB+e5ZfsHmJRFDjgc0kyV5YOIWRIEqFKA5lY
	xPn2xpZ9TSr/dmedBVhzZe5PpGfjpy+qRctv+0NOOcl7YsobVEehyslpQ2AWkWtm2jNGYvh6f+x
	xQB3XJfvwBTwzQi/wtWz
X-Google-Smtp-Source: AGHT+IFQct9SApUaLux90fR0aNxlzm2wMoioHTPd27lhStCGrHuRbObEG0AcO2vIjjIL4fIUoZbNUg==
X-Received: by 2002:a17:902:f54d:b0:215:5bd8:9f7b with SMTP id d9443c01a7336-21614d456b1mr116100605ad.15.1733652955174;
        Sun, 08 Dec 2024 02:15:55 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9ee4sm54638735ad.161.2024.12.08.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:15:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 17ADBDDB022; Sun,  8 Dec 2024 19:15:53 +0900 (JST)
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
Subject: [PATCH v4 02/13] x86/um: nommu: elf loader for fdpic
Date: Sun,  8 Dec 2024 19:15:29 +0900
Message-ID: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
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


