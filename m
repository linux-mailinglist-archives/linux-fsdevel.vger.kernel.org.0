Return-Path: <linux-fsdevel+bounces-56852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D89B1C9CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0718804D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7029AB0E;
	Wed,  6 Aug 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="Ef/RJIoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m.syntacore.com (m.syntacore.com [178.249.69.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80F28B7ED;
	Wed,  6 Aug 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.249.69.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497766; cv=none; b=ItByJovufy52lswWFh94JYaYsoC4Qxl7fz4X9GUTw6VX/B22vVZatVzS4XviSpDpsorybLhl59p1oCMCd43cku8v+gBddD7kR24rwp0bjgqDcET/Gn/4itWKYjSWV0xc7X2g8I6dT8g1eRXKDQfWXwuHO8tKxw2MZJcA42sBGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497766; c=relaxed/simple;
	bh=iqHVJ6febXLW4XyotD34sJBr3bmiASMz08Or3VFk0BA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSXpBJw5TnLD/t6TFdW8kSLkEXPGELE5emkuJM9wevSDovM0YWMdj7NUua4lE+/YfZjOF/QYC8UtGVFedePPd8m9L+OO8IjsGO0GQGGMU+ezbLue1Wt+cBdq2vHVHGnz2+rmHjd6NDxyoDPVPX6smHs0ahCZ4dTUv+J91CjyFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=pass smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=Ef/RJIoN; arc=none smtp.client-ip=178.249.69.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntacore.com
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
	by m.syntacore.com (Postfix) with ESMTP id 5664B1A0004;
	Wed,  6 Aug 2025 16:19:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 5664B1A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
	t=1754497155; bh=U6FTpKiOoyRjzi4zEir5vSNswrtfpJfF7RjfrB5z0zs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Ef/RJIoNJbs8EZgWhpfBfkBP9vpaJvH9f08yilVqXmt6XAnNeo3IlyE9Ifj3KZYO1
	 fk4AgYgfGCtS02Qdnhy2rktbsvSoZlY9ZH2UD1u6Q88xHcUiW6BgAUGLliWm4QaGwn
	 tvppdrKUJw+ztzH8SKrAiAdV7o/2FvFJDSXt7E8alQJxu2f+UmGoXSm6q7gDlPUVj0
	 AYs7O9nafqTs0mrGWxxBm3TedeYsCBzjZXKLk466X+OewqkeBBmnwU/C6NGjxn2u4+
	 GAxxMfsUOxfgjE5dTT0sWYwreGmlwQdyplt62HDfY6p9fkGshVnvd84SeVegfIHwrL
	 5QRRHp+koFaeA==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com [10.76.202.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by m.syntacore.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 16:19:13 +0000 (UTC)
Received: from localhost (10.178.118.36) by S-SC-EXCH-01.corp.syntacore.com
 (10.76.202.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 6 Aug
 2025 19:18:47 +0300
From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<kees@kernel.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<svetlana.parfenova@syntacore.com>
Subject: [RFC RESEND] binfmt_elf: preserve original ELF e_flags in core dumps
Date: Wed, 6 Aug 2025 22:18:14 +0600
Message-ID: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
X-Mailer: git-send-email 2.50.1
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/08/06 13:33:00 #27636797
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
index caeddccaa1fe..e5e06e11f9fc 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1290,6 +1290,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -1804,6 +1809,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	struct elf_thread_core_info *t;
 	struct elf_prpsinfo *psinfo;
 	struct core_thread *ct;
+	u16 machine;
+	u32 flags;
 
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
@@ -1831,17 +1838,24 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
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
index d6b91e8a66d6..39921b32e4f5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1098,6 +1098,11 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
+#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
+		/* the ABI-related flags from the ELF header. Used for core dump */
+		unsigned long saved_e_flags;
+#endif
+
 		struct percpu_counter rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
-- 
2.50.1


