Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203D3727C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 08:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfGXGEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 02:04:34 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37863 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXGEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:04:34 -0400
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B5FF6200008;
        Wed, 24 Jul 2019 06:04:26 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH REBASE v4 05/14] arm64, mm: Make randomization selected by generic topdown mmap layout
Date:   Wed, 24 Jul 2019 01:58:41 -0400
Message-Id: <20190724055850.6232-6-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724055850.6232-1-alex@ghiti.fr>
References: <20190724055850.6232-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commits selects ARCH_HAS_ELF_RANDOMIZE when an arch uses the generic
topdown mmap layout functions so that this security feature is on by
default.
Note that this commit also removes the possibility for arm64 to have elf
randomization and no MMU: without MMU, the security added by randomization
is worth nothing.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig                |  1 +
 arch/arm64/Kconfig          |  1 -
 arch/arm64/kernel/process.c |  8 --------
 mm/util.c                   | 11 +++++++++--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a0bb6fa4d381..d4c1f0551dfe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -705,6 +705,7 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
 config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	bool
 	depends on MMU
+	select ARCH_HAS_ELF_RANDOMIZE
 
 config HAVE_COPY_THREAD_TLS
 	bool
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 14a194e63458..399f595ef852 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -16,7 +16,6 @@ config ARM64
 	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
-	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6a869d9f304f..3f59d0d1632e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -524,14 +524,6 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ~0xf;
 }
 
-unsigned long arch_randomize_brk(struct mm_struct *mm)
-{
-	if (is_compat_task())
-		return randomize_page(mm->brk, SZ_32M);
-	else
-		return randomize_page(mm->brk, SZ_1G);
-}
-
 /*
  * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
  */
diff --git a/mm/util.c b/mm/util.c
index 0781e5575cb3..16f1e56e2996 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -321,7 +321,15 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 }
 
 #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
-#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+	/* Is the current task 32bit ? */
+	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
+}
+
 unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
@@ -335,7 +343,6 @@ unsigned long arch_mmap_rnd(void)
 
 	return rnd << PAGE_SHIFT;
 }
-#endif /* CONFIG_ARCH_HAS_ELF_RANDOMIZE */
 
 static int mmap_is_legacy(struct rlimit *rlim_stack)
 {
-- 
2.20.1

