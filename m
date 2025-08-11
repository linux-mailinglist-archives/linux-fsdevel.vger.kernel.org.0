Return-Path: <linux-fsdevel+bounces-57294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0AB2049F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF203B0B99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B159487BF;
	Mon, 11 Aug 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="II4M1Au5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m.syntacore.com (m.syntacore.com [178.249.69.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FD1E9915;
	Mon, 11 Aug 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.249.69.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906062; cv=none; b=M4aDnwkDWFBN+sLTuUCMc3cQj+XdmYcrszYS6ziIpm0MQy8vWZ2f426ckj+ujAQaZsJe8ANlO6BgNgbnb+4KwXaq/uUrlcoNZsY6jgvwrFQGUt48lKGrGkPmgrHBc9h73DuFcYKD2PaRSoRELqz+bdzful+HpIOxTjypXGznH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906062; c=relaxed/simple;
	bh=pUd7FJZjb9vD/sMqYt3SK9aUrLM1dmAyN/zx4Hb3z2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGt9wqTU3BvgEfKnudNT/pxv/v2rkNreyvQ611/0Oa8uro8mVlO2ZjZJx6GBDKmtkLhTIw06ix21CM9Y7QqOqTJigxDjvgen6XoN2zptfd+Mib/hCICTA4UGhh3NBCoYqzsjQKMsIGRhITltpvikILlBFF3GeEQucIBJJONTEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=pass smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=II4M1Au5; arc=none smtp.client-ip=178.249.69.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntacore.com
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
	by m.syntacore.com (Postfix) with ESMTP id 55E9B1A0002;
	Mon, 11 Aug 2025 09:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 55E9B1A0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
	t=1754906052; bh=yni3jeui56qGM7gspd6IrxvigH7pPMoqhQ6Dvk9afrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=II4M1Au5GdLYynSnkzM0etPYEfbzel+cAmL5VNpBSPhKia3TEM4hdjcbl50Icmb1u
	 c1B6I1/sG69NHrP4EcJD9VOQUCTSFLrXy2c1fIwfRLkBHwTK0wt80VCe3L+2wbVLNU
	 FhAJDzP0DJlSytaVeDs3sRgeMm6NAPNEOiHXCAfbI+AzX/Mf0nEXSrHjIcUJXbIIz5
	 K14W+d+wJPFWkkaTZyw7ywofojaWv/E58Qz8KMSCEdMlIjQD/c0a68dpTskxJIlO7u
	 8+J1hh4uH1AxkRTK0x8Gmsv0qcnGwSNGd2oyP4hE0mMafYr7a05tTCExLpP+DvrvDe
	 Ud3oI+bWPrfdg==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com [10.76.202.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by m.syntacore.com (Postfix) with ESMTPS;
	Mon, 11 Aug 2025 09:54:10 +0000 (UTC)
Received: from localhost (10.199.23.86) by S-SC-EXCH-01.corp.syntacore.com
 (10.76.202.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 12:53:14 +0300
From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<kees@kernel.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<svetlana.parfenova@syntacore.com>
Subject: [RFC RESEND v2] binfmt_elf: preserve original ELF e_flags for core dumps
Date: Mon, 11 Aug 2025 15:53:28 +0600
Message-ID: <20250811095328.256869-1-svetlana.parfenova@syntacore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/08/11 08:26:00 #27653044
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Some architectures, such as RISC-V, use the ELF e_flags field to encode
ABI-specific information (e.g., ISA extensions, fpu support). Debuggers
like GDB rely on these flags in core dumps to correctly interpret
optional register sets. If the flags are missing or incorrect, GDB may
warn and ignore valid data, for example:

    warning: Unexpected size of section '.reg2/213' in core file.

This can prevent access to fpu or other architecture-specific registers
even when they were dumped.

Save the e_flags field during ELF binary loading (in load_elf_binary())
into the mm_struct, and later retrieve it during core dump generation
(in fill_note_info()). A new macro ELF_CORE_USE_PROCESS_EFLAGS allows
architectures to enable this behavior - currently just RISC-V.

Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
---
Changes in v2:
 - Remove usage of Kconfig option.
 - Add an architecture-optional macro to set process e_flags. Enabled
   by defining ELF_CORE_USE_PROCESS_EFLAGS. Defaults to no-op if not
   used.

 arch/riscv/include/asm/elf.h |  1 +
 fs/binfmt_elf.c              | 34 ++++++++++++++++++++++++++++------
 include/linux/mm_types.h     |  3 +++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index c7aea7886d22..5d9f0ac851ee 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -20,6 +20,7 @@
  * These are used to set parameters in the core dumps.
  */
 #define ELF_ARCH	EM_RISCV
+#define ELF_CORE_USE_PROCESS_EFLAGS
 
 #ifndef ELF_CLASS
 #ifdef CONFIG_64BIT
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index caeddccaa1fe..e52b1e077218 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -66,6 +66,14 @@
 #define elf_check_fdpic(ex) false
 #endif
 
+#ifdef ELF_CORE_USE_PROCESS_EFLAGS
+#define elf_coredump_get_process_eflags(dump_task, e_flags) \
+	(*(e_flags) = (dump_task)->mm->saved_e_flags)
+#else
+#define elf_coredump_get_process_eflags(dump_task, e_flags) \
+	do { (void)(dump_task); (void)(e_flags); } while (0)
+#endif
+
 static int load_elf_binary(struct linux_binprm *bprm);
 
 /*
@@ -1290,6 +1298,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
+	/* stash e_flags for use in core dumps */
+	mm->saved_e_flags = elf_ex->e_flags;
+
 	/**
 	 * DOC: "brk" handling
 	 *
@@ -1804,6 +1815,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	struct elf_thread_core_info *t;
 	struct elf_prpsinfo *psinfo;
 	struct core_thread *ct;
+	u16 machine;
+	u32 flags;
 
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
@@ -1831,17 +1844,26 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		return 0;
 	}
 
-	/*
-	 * Initialize the ELF file header.
-	 */
-	fill_elf_header(elf, phdrs,
-			view->e_machine, view->e_flags);
+	machine = view->e_machine;
+	flags = view->e_flags;
 #else
 	view = NULL;
 	info->thread_notes = 2;
-	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
+	machine = ELF_ARCH;
+	flags = ELF_CORE_EFLAGS;
 #endif
 
+	/*
+	 * Override ELF e_flags with value taken from process,
+	 * if arch wants to.
+	 */
+	elf_coredump_get_process_eflags(dump_task, &flags);
+
+	/*
+	 * Initialize the ELF file header.
+	 */
+	fill_elf_header(elf, phdrs, machine, flags);
+
 	/*
 	 * Allocate a structure for each thread.
 	 */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8a66d6..e46f554f8d91 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1098,6 +1098,9 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
+		/* the ABI-related flags from the ELF header. Used for core dump */
+		unsigned long saved_e_flags;
+
 		struct percpu_counter rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
-- 
2.50.1


