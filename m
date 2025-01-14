Return-Path: <linux-fsdevel+bounces-39132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CDA10575
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 12:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6B83A264F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81085234CF4;
	Tue, 14 Jan 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv/VH+y+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E9234CEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854267; cv=none; b=j+2eJclnKmRRlqvLVdFg51WUszaTm6tkaUKn83DvIOriBO8rOOWLSae8BiCJTMWazNh+28XN6papRw00qarO0vP5e5MWYTACPMrbHJB6bz/2i7W0It3IzNPJQq3kQN3Vl8GldrNOj8YNh2sh/vq9RI8YOhDUCyzxgdpDgDrE/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854267; c=relaxed/simple;
	bh=Xn2RaNaReEp4HS2lM2B2ydz2zvsDs19KOeICSn68auQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EExw6yZqbePH0LDNhlTttuQ/+n7Gql979AA1uiitqgDrp8YM2A+qehdLPSO2Q2jHnFJXtharn9H7MNy6FOdWFXSzCR7v5H0FeL/4gm14FWvfPiwnGV6QK9Ait5IEXB+gpJu5t1MJwMS+GvAQnIJDHUGaHhd3yv46R+KSSECmVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv/VH+y+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f44353649aso7112864a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 03:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854264; x=1737459064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=Fv/VH+y+5M36dMoX57gRiSrqC5F4+btjSVzSd+ACYa2fZhil2UVxUiYcViMoi7Px21
         h6owbDCC+36Ij6huoA5ce16BqWbwxXrjuCt7wZxcExXWBGyyo/jzfrRq/JbYHzdzr5bI
         nbArgD5vKqXmR9laWPTyCYE8IvJEpVm5Sk654fPiK7Z03DufJgroK7mzl3jcvdZy9tkH
         ACVd0B7wLORxF+9p350rr5kCVRxXReLdv3kZWY5XsRyaFR3R8pT3GzVtytyssRahUh9t
         rmb8Wd1LIMuK0JlnDBvc0tU3iMpPie895iCY5Nqx2iT2+p97hriJq3yTxy40Q7EU/q1F
         bw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854264; x=1737459064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=mVtkK2eQNvu5XjIIHdP07sMSMF/oYEh86eQtreWIHrKpqO6jvjU8GF5acG8xReEPlI
         qB7LQf934K4AKhZHthUFpugGEgTheeKSeKBR7LcvxmHAVR6C29K5KFxViKg+wVen0UUS
         lKuO0ILiKM7GIT7kizFUcapaQ2pwFyTSRqeN6Tc/nNhflMdZqTXqLLAhaf1kD1Lzo2da
         +0gGPku9APtfN8lJnT/ZHoMuI46b9qvPLxs2Zy2nbp+dCSoZ5wnhOoQrjrL71SRZCF6M
         eSQLu+qLUuiWFOXKvukHsp73nWkwYKk/d50W6s7u+gL8IMjQYxJ7c0r/zm1cFGNIYTR+
         7hKA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Fik2pZiSWhDko9JJuhirul80uBpMr5dAY96NkWUPOaI4s5F+Z4VYKCleFc7cDY/zdgqNCjt47JtBzZ0j@vger.kernel.org
X-Gm-Message-State: AOJu0YzVei1emfVA+VFAIpblNgUClXeBnum77MtnNSek5gJY4mXwDQa9
	I6X32C0fAjIhnbXVgvTaLiC20NzDa8+evX7u7LHUCcHptw9kS+CM
X-Gm-Gg: ASbGncvOyiVlSmT8V0nkXnujNJJf30NrqQAY3CY8SLW/KvgElzYSPUBoCi2g2Z7TsF/
	WF50/iKXTp6qe2m7X3Y6OczqLx09ZKrRASuhxf9nFV/Ife1NGWCpe2mLMSCf0dr4YW2QeT6FU//
	CDgl5ZhjMVHZDcedCrQKWd4kSC1m9AqSw6ubG4slxJ+ArSzb6TAOo1OX3uFkVfoy0i0fCRhtNc7
	mDAUms1YgetjbJbHwnWqARJPLqgquIs+S+73RrGKcuq/FrNn6Gvo3/P+mzJW1Xxdeortfc0H0SV
	511CWhYomuOyl/HpqebGO+lBaJey
X-Google-Smtp-Source: AGHT+IFUwZHNFEc67jBbRXeFTOn0tcZ1umDdW5kX+lEEHYdmJnaChB7NhkDCIdArY2EVW1a5YS/C9A==
X-Received: by 2002:a17:90b:5208:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f548eba9c4mr42260944a91.12.1736854263922;
        Tue, 14 Jan 2025 03:31:03 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22ee09sm65234765ad.200.2025.01.14.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:03 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5DC8BE1AB50; Tue, 14 Jan 2025 20:31:01 +0900 (JST)
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
Subject: [PATCH v6 02/13] x86/um: nommu: elf loader for fdpic
Date: Tue, 14 Jan 2025 20:30:40 +0900
Message-ID: <d9dd391ee565aa3ad1b8ceba5689caf888f6bd85.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
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


