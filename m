Return-Path: <linux-fsdevel+bounces-67527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA2C4290F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 09:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851633B1170
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A8B2E03E6;
	Sat,  8 Nov 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqTs+69F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F04288C22
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589158; cv=none; b=DOWWupmdU5+lTpr9dl5iHRCF4EyuVQS1u0/SIWuIDJzTh2o+EyjFlJ0xUlSepvgjGcKsyI3e9wibHqSgHIgSzcGrFXqb67b3M8EJF2LOe75NjuSR9SCpFmM5LMOagK8bRj9TqrTTe9FH+s0RsqZ8Rm7bNpMUMlrIg+i6Qh/pHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589158; c=relaxed/simple;
	bh=CvYzjfP7rw4yGGJRdX8B4balTna1wcyExbLjMjY+2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxrib6CwtcN99mbDIHRrMoDa+R5drr99mnU3L45Pp8okc2RhZ/ZmQ+lH7vxFIhGSvXqhc8Lf2HCugsFkQxpN8y+aejKb18K+z7sO3tOPxy99NKToz2HmbrHGsO6mPw7sQC3rUkilHCyZvqDauJaoYm8eF9bibpS3FSTHGmaM8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqTs+69F; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b994baabfcfso926588a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 00:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589156; x=1763193956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=gqTs+69FF3kfegUNdsmb18tTgXgdmSAcwoBmMo2qY9VZ15WHGKOa4bNugon5P4NFtV
         In69Hm9lejo6f6eP+dUFGpx5UufFPKv5ynI8vdiSqtwoCDF4OxoGvLUe883EYB5b5w/A
         pPk3EzsZg3LhYKhqh6k5fQJ0PaRPIy0kwerWgVO3Cna3vXQ/L5vWJhzaujkFXZVk9LgC
         WbSDJOWbM77DmUYySQLqEzF+hONP2fIZfGnbmeTxUonIL8636xLQwaM5BRQasFnbMUUb
         N6AgSHss9MziDejNG1b0xXcnMu+twLJMyQiAPg5ePA2td6N9WiY4A4VVoKMQZ0ijoMYT
         JonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589156; x=1763193956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=ie0+2BRU/CLCap8Wfohh9Cdup8mWwJyBeLtljYbGnX39oCrqGubtABERrgTn+l4PnD
         CeicgIpSYaDjrE/Jcsdta2/fYYMv5tmQLXCQqXUevi3nYU0KL73s0wzeV3S/BNEJaVN2
         Tl+M/gTYh1SJYYbw6V6LRBGM7BeUEH4WCQDbMddIEdBQFv16+v8XBr11S5rYZIt9bC4T
         0/79fS9Hm+dIRs11d8bipR36jhm0H+6qiFLiEWJgYQ+1stgnbCxACl6w8iio8xCdOfM8
         01GR/QHojVMsRR8dagf2QZCff0Nxc7x3oX3iKtzncXYZpli8jFGVWdYfGPnmmxW2nLgG
         DIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE2LYFLad2v+nyKfZ0MnqpHPgNTDhmWV1Rl7L2pk1d4KdcyJJ+kKtKmhPPPvpBXGc5Zv5h9V/WWKAiGNkj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1h56DOetHAaD3ds3girexxsheyKm6R1Ie+edBysWcTNf9oZHn
	f2JvsK1lxQ8n3KEUCOMfOEeYX6L+Dj0Q6dwzkRvyKkdS0picvE3qmG5o
X-Gm-Gg: ASbGncsFujm7zChRXVw4AuGab7ZrR9kjIC7tLaxgM17XLfiVGlgt1UMzWgx3T2n6Ms/
	4c8lCq0aChlGy9cgOS0CfAZ7aXBz8ZRuJ9Xu5z4sKXc+L/TXkWpmmttLl1hw/eWI73ps/8eDZ/o
	oFCSdn+jZq4GRRDPbMF0Mdox+nLMfT9ERF1XF1uRfOi95YyRjndaqDeLERm19ebysO17JOCz80k
	TGzKF8z2bNaEhwGkugFOucdgQQPN/jEAHESUzOVv32GD+BHfHDMwOG/Zihi4TZUs1GVKbILVPW3
	smAtiM9joR3xVVTvOJlN1KWSUghWJMJIn2r5QfrN1qA+gibY1XSE+M3H8Ah1KiGP/rqYnMM1VVn
	xuUS+qVRWbdejH/3V9Qb/5o0ojL4UZX5mQPNZmfcWscPDneF+SLEozZWjk4S6jQToO4PZE5jrMM
	019UytxzwbM19821W/u6fRh9nPdC6VjXYYAZpTh1paA+CoqJJQQ7A7T91Md0FlsCLYPy4=
X-Google-Smtp-Source: AGHT+IFNIgTTAZ2Vl2vkAxBvJV+q8EYjnppJ5K0pIHpzL9Ue02aCEVYgWqO6SIqSBUirhrY7QzbLaw==
X-Received: by 2002:a17:903:ac6:b0:295:269d:87cf with SMTP id d9443c01a7336-297e5619d74mr21459175ad.5.1762589156346;
        Sat, 08 Nov 2025 00:05:56 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm83340945ad.7.2025.11.08.00.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:05:55 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0019311388C7; Sat,  8 Nov 2025 17:05:53 +0900 (JST)
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
Subject: [PATCH v13 01/13] x86/um: nommu: elf loader for fdpic
Date: Sat,  8 Nov 2025 17:05:36 +0900
Message-ID: <59210140957e95ab0df73125bfdb035913a468b1.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
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
index 22d0111b543b..388fe669886c 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -158,8 +159,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
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


