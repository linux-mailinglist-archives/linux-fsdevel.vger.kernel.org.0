Return-Path: <linux-fsdevel+bounces-62064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2215B82F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 07:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6E9320B26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 05:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01E28314E;
	Thu, 18 Sep 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFLl53Gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB427FB3E
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172586; cv=none; b=izCdny96XPmZp8ONWLxcm2v9VINUvT4DdB8w1WyG8JnaawyQ7zp5RurJ+ftkOEtUttqcZ0PGFwu52rB6fWwjBNaCJ33LVOYsqieMfXxAVzsDa5Y/4jzxdubSyLeMB2qybo68CFUCNgVTzSW5VqHe7W7h3uPar3ZMgOUYGaFKGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172586; c=relaxed/simple;
	bh=Rh8EDyP0VnYAbVERnzfNVnPZO1tV+O/kVhDgVIx4GNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b918lPGTPvGZP/QjTTKWwOFyMYQV6STkwZbZvBRNGgiuZ36o4pwFNKll9/bqox4ulFYLcfdv+0vyzpsk/YGz8EjXa0h3dZHN42kEqhfdGHB0ujakEUT53uXPeytHrqBpznE2ot460zqKahn61LHgmo0qmmCNEkQ3NBMkZw3xDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFLl53Gu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d24db67e0so259594b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172584; x=1758777384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=GFLl53GuPlD4HCdzi4jYtHKBOJPUFem/AoEJqDMe4lIfzEsEQifIyF0rFj30ZBjaEf
         lfMLjkXT3qrJV/pxSDzOiUIxE79iTN/70keU1thcLJNlSondX7qR1FUa15UhQjGafqRl
         S+4lEkmbA+m2ZBdZitesDJrc1fH5vJpugiWYUgTxJLY21YcWQk4jiq1wH03MMdArASKH
         O3C3Buo2HGzZPDBpYTNHBK6AFJjYJVOBDYUPSzzCPUSCnN7Xmz32rDhhjGeIMI1v45Pn
         h7WCoOXrbm28h++Pzb5TD18bo41HQW6UyryYia7N/3bSd5HvrfGTe12VoCXKEaov6XXA
         cZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172584; x=1758777384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=qB97RDgfqK4sSugWJ3dpW2majYfuuBJ7/0Chzv3E5G1zXObHLCjQDFFvLng+/fMDJE
         jVnDJsDmUx/wz8J1b/vnfcxjoOBPCeTWtKdf0X0RpXAXxLtedHl6WfJ4fFos+rOjsLCi
         iyQ/GO/9hOEGf8xvzPrgZJMrTqpF3IqsOiRgscS10gX28Rc1JXTw3GsPD4N8GH7w2bV6
         g8CKc04Bo0lyOVp1Dpcc4/5eL541Tinjc9sMLIQbwkRhv85cNKLpfeeFCIeFI1DwR1js
         7T/Bnk0BjswFy9v/oH3lWLVsig+NxYAsiITHjuK7WYrvHSYUXExHJ32NbxUTUV6T4uHt
         nK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkofSea9rqNGDudcsQ+MpD1oX8z+5TGVBFdrUFc9uwyh+Ceaod4jVpXXmhqkfpa1ZwyNSmuCy/1NeaPY2u@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzmidwI6/v02Z0h/nDZtvcQk9sukR+/qAxIfs7etvaCChwq1x
	K/Y6oJIYNvtcyd3WG3Y8vB7zholSISnodlUFA4BroC1WfWzBOtEXWd34
X-Gm-Gg: ASbGncvxnqovbjBCYpYBQQBA43pWTjlz0a4jfhD4B2Zb3w7MgIMPR7o3k7QYEiESR1U
	SYfVduops9aWUBd4EBDVzNdTW2TPBySyVvFco7u85P/nt1tJZiXgLyziiTKDP1LQnQNvyq0Ph8C
	0LvxDCJvvSRmSdb0luS9S2O8b0jFoX0F1Xe7JDHyj9YT4WOInUrEoem3fVOfPjfQLubZHAH3n8V
	juq3q4FL3pjN3CCl1s+uCs4lVUPy5mBkdqqwqDGK92h6bc+VwQaF0EAqT+WWOpyA7E8PYOtKc4q
	bQ5O5fMQnJGcWtiAwteDZcZxR8+M1P3RRH4I0z25GPBKzWDqS9WeKpz9uLTOUjKHJk1h8/yRAfe
	wuqCVDNCGEO34a3LNKZcP9OcIPfLUlTqUK9bbS0TgOzISZ3OSkwnT1ft5PmR5DSVPWqI+0YdFys
	PxOViBwgsRdyh501HTRdAg8Q==
X-Google-Smtp-Source: AGHT+IEa23dRQySwPPnr5ub15MBlqUEyaqoSvqVGNsNzpQT7Ye8yNYnLRaw4EeZooTnvYHDwu7FgGw==
X-Received: by 2002:a05:6a00:887:b0:772:8694:1d71 with SMTP id d2e1a72fcca58-77bf45c2008mr5267793b3a.0.1758172583863;
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe7607c8sm1093015b3a.58.2025.09.17.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B2BEE1061EE2; Thu, 18 Sep 2025 14:16:20 +0900 (JST)
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
Subject: [PATCH v11 01/14] x86/um: nommu: elf loader for fdpic
Date: Thu, 18 Sep 2025 14:15:54 +0900
Message-ID: <5a4932bbcdbf79facd544fec7e3d6a6969a40aa1.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
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


