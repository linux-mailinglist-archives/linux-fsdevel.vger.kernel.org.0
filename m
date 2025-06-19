Return-Path: <linux-fsdevel+bounces-52144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E352ADFA75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A36C189B574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586F199FB0;
	Thu, 19 Jun 2025 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqBZX073"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71D186284;
	Thu, 19 Jun 2025 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750295080; cv=none; b=bi19hxrnxCqM6Vno3Cj69I/+I4XN9E33DVScwzgB8WzugDFX6W1ZW8jIMzZNuzy5MZv9OHuUGtRWgOdiJZVHgMBSPYlViM86wq41U5/SbtnLytXJt6Is9UTnv0S8nJ5jU8RSYKRMyODkc9NzjvksthS6FkxHkOSYxpNgPCJHyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750295080; c=relaxed/simple;
	bh=fm+AK3tlrTe+gYqKBawZVsKJTfAyjuWAJWdKg3VZFJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yzu+DVZlAFATL9UCVHoKw+Tt/XLrysuMvbRbDYQ4j7f7I3HYdTIqcU9yh6He0SfQM4U6XGSBkQyCv5Och9/z1kNTsJqKTa3DyS/9a9M+lwpEukIzRxNq5VC6IwnaAxDSQwUcikMxrjJCVoDn4+naa1R5noE4JCbUSIwuuMeq41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqBZX073; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so173654b3a.3;
        Wed, 18 Jun 2025 18:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295078; x=1750899878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=fqBZX07303MtdYip6cMYoxX/PXbNGBBYlT7+5p9RZmKIDkEDNRKiAi3K0IsWKGWzxL
         NqmARN8Ye94CJG8c47xKuFLX9kQovj4jp1UCN4QAz8TNdpGGUm7I9lk0Zv36CZXWUIzo
         HyAfkz7aCKgPQh9TDcfmrcfmDfRgE2dpkTnPLUwj5XW4DN/ByS0PWyy/wXYQzMFZbnFN
         4PSn5EdNR+9eFZbOw5KgkP6dze2++z4hxiY1Y4pbyUzsllzvmKVGGFfMQVyqg+ZBqIB/
         qJXmzUryvUf+B7iOJo7KgJ6xvH9/jajrtWOEGmKOLzuoJfceZ3ZL207MWR8tJdjcyRlg
         FfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295078; x=1750899878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=qrtpkSidNBbliz0R/eWDzuGl6zHa62hj1q9S+gQ4tslMn0WHJpaa8pvaJRi/TDXFDd
         M/4haW/aGD3gu9JtZ+bupGUR6kIzYdnvT04GGSOlHdFR0QBqfr67DhJ1Hq68aX41Xr30
         QBit9fCqj3zL5XMyBvN1uxunRZTAfuXbS6nBM1HgmraiD/iDFn2oLLLD/+NrXi4UMk5O
         hHpmSFY6oKqo/GA/j5lwKR2Kx6DSZ5sFb50/Q//+MNy7zEcsunX8/8ec8OJ6R3LApu1R
         wXe4k4EfkEVjHtod6CxEeMkk5vmrZKZL0BkPWzd6s8wsCpwqEshATsLGYXih5kDsN0Hh
         Ww9w==
X-Forwarded-Encrypted: i=1; AJvYcCV51YmJVqyEcozu7MQS09/cfR2eAA/lOy80rwkneIvO+itEr+w1Uo6zOLAtaRX5R00wxs/V9181wdCdtnj+@vger.kernel.org, AJvYcCVlIB2U2HTG5/oHH/N8UzIIuevnHYtb/Ylfkc2htQovK8T6OUmL9tkn6HtN16DDv1yq6sncnBIkbdK4iUD6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1h8XDyERTghWknYFm7gC699EAOxv0eCO5v5NPfByH9duEzizl
	Z0W7OSYzpVWl+CBw7IaEBj/z40OEfQ+RPpitOxPixqCjhZXzowcGLlmY
X-Gm-Gg: ASbGncuNviCJlQmL1Z6zDdYdv1TJOLnZNsVgjeHciZbKN5lDrr7HZATAglz8KW+mtGC
	dZUhE7ixKBqKBKvn7p28Ap1/EXEcadVlPiqmyZDU7Qz6FlOepmLGT9Dv+pjbdpKS3pERbpMSs4T
	ZniG3N8hV09x1VHy9p9CL//WOoRugIpFElp1SnJYzfAzmJjE7TifIvQ6v2TReMaR9n2G5JcWkN2
	sK58FX4/WIvYXRhkVn01lp7YmlYHYhMDJFKghlIp3OIrQALDMB+zfJ0lnJ7euRRWWnRZTwo6ay6
	/t3mDhQYhZqJzI38dcE8dNkgBagRPD2gaEUR9SBVFkezpjVH5E/gkZuiDi7pyHRS7Vz1yKSwJec
	wHQfl9vrvFi539CtxqRVmrHzCHUQJrsHU
X-Google-Smtp-Source: AGHT+IHB2DycC27BBHn6mGZ870nAohm4fuY2R4YYnJOfQvt0vJB8Xb8OYArORQprvedXyVNuZmFy3g==
X-Received: by 2002:a05:6a00:21c3:b0:742:a334:466a with SMTP id d2e1a72fcca58-7489cf97ddbmr27854811b3a.12.1750295078389;
        Wed, 18 Jun 2025 18:04:38 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900829f7sm11794405b3a.87.2025.06.18.18.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:37 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1F350ED652A; Thu, 19 Jun 2025 10:04:30 +0900 (JST)
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
Subject: [PATCH v9 01/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 19 Jun 2025 10:04:05 +0900
Message-ID: <e09d413c2c32673469730d90a5852f94ddd18cf2.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
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


