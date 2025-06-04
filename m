Return-Path: <linux-fsdevel+bounces-50624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D547BACE10A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A6A17255D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC329188E;
	Wed,  4 Jun 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="qFFBj5JE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m.syntacore.com (m.syntacore.com [178.249.69.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6E290D80;
	Wed,  4 Jun 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.249.69.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050030; cv=none; b=poy5lmqdvwJyCEqpwYP8L3wkm3pUyzleWmNqJohrmY+H3+M/RUVINIliBVLEpboyQ5G81H9aggfRjtYCASmyjQXC92WaLbVNiMC3e5IclB1pxcn79IS61ruTgOY+N5jHt2rl4FAE56l1TLu4G4eHw4szUXRwybMmBVK1elUgjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050030; c=relaxed/simple;
	bh=Bz52cWmM5E063diqhU/tvNAwMpsAg2SFm+DiQ9Dj94Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCnX9oz5riIH1R9aeAsmkbYoCehd7Uh2Ih/ECs19I68IeS42h/H30wy/MD7z0zDR7tZ5KkiRYUF1pGsGw9jTdKvTOpV5n6ugReWebZXjXb18pNKfWh6uAVb6GmS5wmhQCTtsJppppBySPnuDkAveswjQLM0CTK9A/5VH8bFrGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=pass smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=qFFBj5JE; arc=none smtp.client-ip=178.249.69.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntacore.com
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
	by m.syntacore.com (Postfix) with ESMTP id 386171A0004;
	Wed,  4 Jun 2025 15:07:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 386171A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
	t=1749049663; bh=cFvYaW2WkbtOra3S0g7FSljIzV4LxrpuqkAbvhUZRVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=qFFBj5JEyV6NX3EeyzhabNsOKCgp9jJ9AFkzUYTr7lX9o+e4rwwXk5S81XGzUfEi1
	 LNQDEBsNDZs6a6o1xuli/VYrLGk4xDpdU11Z8sRU9LiqoRrk/sjtVcJDUm3rMlPP6F
	 6xFw521QT9wRVQVhk1boOFiMCUOHRs1gXCSxK+bMJyLcQ7sGz9hkWl42jKqdkBrIAv
	 IVZpAhBMUcCFAVLRde+a/IgzLNAKMTuWC3JYRG9wJ9wDKHrROMXu95QlNFG6ZyDZ7l
	 GpqCr/eSzO4xhWXg3rxXh6nlXf8urJZZKLfcFQceCqN1gNzeTvzzfyjeLHaKHVYOU5
	 gAdYVUb0Ohnmg==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com [10.76.202.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by m.syntacore.com (Postfix) with ESMTPS;
	Wed,  4 Jun 2025 15:07:41 +0000 (UTC)
Received: from localhost (10.199.25.251) by S-SC-EXCH-01.corp.syntacore.com
 (10.76.202.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Jun
 2025 18:06:55 +0300
From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
To: Kees Cook <kees@kernel.org>, <linux-mm@kvack.org>
CC: Svetlana Parfenova <svetlana.parfenova@syntacore.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC] binfmt_elf: preserve original ELF e_flags in core dumps
Date: Wed, 4 Jun 2025 22:05:02 +0700
Message-ID: <20250604150502.622178-1-svetlana.parfenova@syntacore.com>
X-Mailer: git-send-email 2.39.5
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/06/04 12:53:00 #27536686
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Preserve the original ELF e_flags from the executable in the core dump
header instead of relying on compile-time defaults (ELF_CORE_EFLAGS or
value from the regset view). This ensures that ABI-specific flags in
the dump file match the actual binary being executed.

Save the e_flags field during ELF binary loading (in load_elf_binary())
into the mm_struct, and later retrieve it during core dump generation
(in fill_note_info()). Use this saved value to populate the e_flags in
the core dump ELF header.

Add a new Kconfig option, CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS, to guard
this behavior. Although motivated by a RISC-V use case, the mechanism is
generic and can be applied to all architectures.

This change is needed to resolve a debugging issue encountered when
analyzing core dumps with GDB for RISC-V systems. GDB inspects the
e_flags field to determine whether optional register sets such as the
floating-point unit are supported. Without correct flags, GDB may warn
and ignore valid register data:

    warning: Unexpected size of section '.reg2/213' in core file.

As a result, floating-point registers are not accessible in the debugger,
even though they were dumped. Preserving the original e_flags enables
GDB and other tools to properly interpret the dump contents.

Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
---
 fs/Kconfig.binfmt        |  9 +++++++++
 fs/binfmt_elf.c          | 26 ++++++++++++++++++++------
 include/linux/mm_types.h |  5 +++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index bd2f530e5740..45bed2041542 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -184,4 +184,13 @@ config EXEC_KUNIT_TEST
 	  This builds the exec KUnit tests, which tests boundary conditions
 	  of various aspects of the exec internals.
 
+config CORE_DUMP_USE_PROCESS_EFLAGS
+	bool "Preserve ELF e_flags from executable in core dumps"
+	depends on BINFMT_ELF && ELF_CORE && RISCV
+	default n
+	help
+	  Save the ELF e_flags from the process executable at load time
+	  and use it in the core dump header. This ensures the dump reflects
+	  the original binary ABI.
+
 endmenu
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 4c1ea6b52a53..baf749e431a1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1297,6 +1297,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
+#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
+	/* stash e_flags for use in core dumps */
+	mm->saved_e_flags = elf_ex->e_flags;
+#endif
+
 	/**
 	 * DOC: "brk" handling
 	 *
@@ -1870,6 +1875,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	struct elf_thread_core_info *t;
 	struct elf_prpsinfo *psinfo;
 	struct core_thread *ct;
+	u16 machine;
+	u32 flags;
 
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
@@ -1897,17 +1904,24 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
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
 
+#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
+	flags = dump_task->mm->saved_e_flags;
+#endif
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
index 56d07edd01f9..5487d6ba6fcb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1059,6 +1059,11 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
+#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
+		/* the ABI-related flags from the ELF header. Used for core dump */
+		unsigned long saved_e_flags;
+#endif
+
 		struct percpu_counter rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
-- 
2.39.5


