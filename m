Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7085A705820
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEPT6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEPT6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B3B9;
        Tue, 16 May 2023 12:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A627C6335A;
        Tue, 16 May 2023 19:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB60C433AA;
        Tue, 16 May 2023 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267126;
        bh=xc18BzdyEBvkv9q714vehn9HK+Lcx4FXD845Ti/vhSs=;
        h=From:To:Cc:Subject:Date:From;
        b=BOqU+Ti0UooqqPQiNy+cEs7ojWA6srPcBXzScAld2/LM/flNge0wEJQ1IDViuzpk8
         JFqXrVUteaLPL3MK4aUhli2xC3CY0v65zf/k2y9AB7g3Uui7Ri+9R1k0Y3YSFQbrkY
         rXn4S2QZwF850darHW8kivTUZPDgtYyYAH2jCchPbbvn5SFWjbMySlgk/ZpkjxLwOT
         dZRw3AboHiPlHtskv9wpSENZDBYKiq21KCJK1q3VxEVbJ3numV5C0ebXww9nU4qP3O
         63KmTxzjAarWjUokVC72OOBrS5hxQAcQBUCEk89HPrQZJsIfTywAE+H1VKKSqagjVX
         smEY2U2R/5+gg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] procfs: consolidate arch_report_meminfo declaration
Date:   Tue, 16 May 2023 21:57:29 +0200
Message-Id: <20230516195834.551901-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The arch_report_meminfo() function is provided by four architectures,
with a __weak fallback in procfs itself. On architectures that don't
have a custom version, the __weak version causes a warning because
of the missing prototype.

Remove the architecture specific prototypes and instead add one
in linux/proc_fs.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/pgtable.h    | 3 ---
 arch/powerpc/include/asm/pgtable.h   | 3 ---
 arch/s390/include/asm/pgtable.h      | 3 ---
 arch/s390/mm/pageattr.c              | 1 +
 arch/x86/include/asm/pgtable.h       | 1 +
 arch/x86/include/asm/pgtable_types.h | 3 ---
 arch/x86/mm/pat/set_memory.c         | 1 +
 include/linux/proc_fs.h              | 2 ++
 8 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index e715df5385d6..5656395c95ee 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -472,9 +472,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-struct seq_file;
-extern void arch_report_meminfo(struct seq_file *m);
-
 #endif /* !__ASSEMBLY__ */
 
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9972626ddaf6..6a88bfdaa69b 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -165,9 +165,6 @@ static inline bool is_ioremap_addr(const void *x)
 
 	return addr >= IOREMAP_BASE && addr < IOREMAP_END;
 }
-
-struct seq_file;
-void arch_report_meminfo(struct seq_file *m);
 #endif /* CONFIG_PPC64 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 6822a11c2c8a..c55f3c3365af 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -42,9 +42,6 @@ static inline void update_page_count(int level, long count)
 		atomic_long_add(count, &direct_pages_count[level]);
 }
 
-struct seq_file;
-void arch_report_meminfo(struct seq_file *m);
-
 /*
  * The S390 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 5ba3bd8a7b12..ca5a418c58a8 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -4,6 +4,7 @@
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
 #include <linux/hugetlb.h>
+#include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 15ae4d6ba476..5700bb337987 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -27,6 +27,7 @@
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
 bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
 
+struct seq_file;
 void ptdump_walk_pgd_level(struct seq_file *m, struct mm_struct *mm);
 void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 				   bool user);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 447d4bee25c4..ba3e2554799a 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -513,9 +513,6 @@ extern void native_pagetable_init(void);
 #define native_pagetable_init        paging_init
 #endif
 
-struct seq_file;
-extern void arch_report_meminfo(struct seq_file *m);
-
 enum pg_level {
 	PG_LEVEL_NONE,
 	PG_LEVEL_4K,
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7159cf787613..d1515756e369 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 #include <linux/debugfs.h>
 #include <linux/pfn.h>
 #include <linux/percpu.h>
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0260f5ea98fe..e981ef830252 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -158,6 +158,8 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task);
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
 
+extern void arch_report_meminfo(struct seq_file *m);
+
 #else /* CONFIG_PROC_FS */
 
 static inline void proc_root_init(void)
-- 
2.39.2

