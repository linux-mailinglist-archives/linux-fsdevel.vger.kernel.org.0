Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077382AA93F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 06:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgKHFSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgKHFRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:43 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so3818979wrr.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPwKown6rijKU/resMLFof1ybZMsa9hdWjNdijK4IAw=;
        b=RvN77/FvPkL6ELFkVcuruawPUUXs4Eu10q4/IZ6LpvyQCFbiPmpj0Wf3cgy/jtUEHs
         Akx12E217/MGNzn9lVAg7vEDzZYiUbU5pDg26PplcF3K1djfumBGFHfuPRERkrmr3RI3
         PBb1ofww63bA4DMzg8EyJaW2EAWMSyk9403bVeYKpzKRx7o8w9Dn3y9G5DcPYI9FDFth
         7dEZSBl+k1SEmZogo4t9At872yn55qEW7I7jhwNOXvXzTEW7mNMP/OvrB1J+95aQNkIA
         7nxaX//Vnh8h3fkO4ZCxa/BFZdwVDCFpRXeu0ZeG/KLl+X9JohexfL1q91qOK5ltNBXB
         f9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPwKown6rijKU/resMLFof1ybZMsa9hdWjNdijK4IAw=;
        b=ucI7INkNuyPbPBoGU4NcnfqB+EEO8dHOv/K150szYu6u1fi/cSwLpMh3Zkkg6XgI5t
         a9NjofpQYtFjQXYKk//VlXlhksZDbHMPL87yN8Hg5TA86slJVqsQlWodFGqHniPZVLvR
         k64vVisweNxLckkCj1dwvhLYC1vfejEO+Y1hsokEfNpuNQ8L9dEn89GFjwZpYlYj2tKX
         H3oURKOpFy9Lf6+Ufc2TF1+TuPJc1SP4F7uFU9X1t37lVQKW8H/ZLCeRa8X2Hgdasmyc
         +jrq99Ymefs3+941emsVmsU/ZuwvhatcQT6KRAV2bQfjfcwFPPuAYz1AkWOq1mNevekm
         sP3Q==
X-Gm-Message-State: AOAM532vjgjuqbsroUgmM+AiU1q1owwuqzf5btj9MGUGT/abZcnUwZVW
        tvOywE+3Bb07jjw2Lv2IREarjw==
X-Google-Smtp-Source: ABdhPJyvjbxB3tO4xoXQp6c0Dk8Z3ZzcKlQNG9KtKIWo3F60nja7VGVDZsep5sLmwwdbU6AQ74VhWQ==
X-Received: by 2002:a05:6000:1:: with SMTP id h1mr4145677wrx.127.1604812661018;
        Sat, 07 Nov 2020 21:17:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:40 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/19] elf/vdso: Reuse arch_setup_additional_pages() parameters
Date:   Sun,  8 Nov 2020 05:17:16 +0000
Message-Id: <20201108051730.2042693-7-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both parameters of arch_setup_additional_pages() are currently unused.
commit fc5243d98ac2 ("[S390] arch_setup_additional_pages arguments")
tried to introduce useful arguments, but they still are not used.

Remove old parameters and introduce sysinfo_ehdr argument that will be
used to return vdso address to put as AT_SYSINFO_EHDR tag in auxiliary
vector. The reason to do it is that many architecture have vDSO pointer
saved in their mm->context with the only purpose to use it later
in ARCH_DLINFO. That's the macro for elf loader to setup sysinfo_ehdr
tag.

Return sysinfo_ehdr address that will be later used by ARCH_DLINFO as
an argument. That will allow to drop vDSO pointer from mm.context
and any code responsible to track vDSO position on platforms that
don't use vDSO as a landing in userspace (arm/s390/sparc).

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/include/asm/vdso.h        |  6 ++++--
 arch/arm/kernel/process.c          |  4 ++--
 arch/arm/kernel/vdso.c             | 10 +++++++---
 arch/arm64/kernel/vdso.c           | 17 ++++++++--------
 arch/csky/kernel/vdso.c            |  3 ++-
 arch/hexagon/kernel/vdso.c         |  3 ++-
 arch/mips/kernel/vdso.c            |  3 ++-
 arch/nds32/kernel/vdso.c           |  3 ++-
 arch/nios2/mm/init.c               |  2 +-
 arch/powerpc/kernel/vdso.c         |  3 ++-
 arch/riscv/kernel/vdso.c           |  9 +++++----
 arch/s390/kernel/vdso.c            |  3 ++-
 arch/sh/kernel/vsyscall/vsyscall.c |  3 ++-
 arch/sparc/vdso/vma.c              | 15 +++++++-------
 arch/x86/entry/vdso/vma.c          | 32 +++++++++++++++++-------------
 arch/x86/um/vdso/vma.c             |  2 +-
 fs/binfmt_elf.c                    |  3 ++-
 fs/binfmt_elf_fdpic.c              |  3 ++-
 include/linux/elf.h                | 17 +++++++++++-----
 19 files changed, 84 insertions(+), 57 deletions(-)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 5b85889f82ee..6b2b3b1fe833 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -10,13 +10,15 @@ struct mm_struct;
 
 #ifdef CONFIG_VDSO
 
-void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
+void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
+		      unsigned long *sysinfo_ehdr);
 
 extern unsigned int vdso_total_pages;
 
 #else /* CONFIG_VDSO */
 
-static inline void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
+static inline void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
+				    unsigned long *sysinfo_ehdr)
 {
 }
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d0220da1d1b1..0e90cba8ac7a 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -389,7 +389,7 @@ static const struct vm_special_mapping sigpage_mapping = {
 	.mremap = sigpage_mremap,
 };
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -430,7 +430,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * to be fatal to the process, so no error check needed
 	 * here.
 	 */
-	arm_install_vdso(mm, addr + PAGE_SIZE);
+	arm_install_vdso(mm, addr + PAGE_SIZE, sysinfo_ehdr);
 
  up_fail:
 	mmap_write_unlock(mm);
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 3408269d19c7..710e5ca99a53 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -233,7 +233,8 @@ static int install_vvar(struct mm_struct *mm, unsigned long addr)
 }
 
 /* assumes mmap_lock is write-locked */
-void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
+void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
+		      unsigned long *sysinfo_ehdr)
 {
 	struct vm_area_struct *vma;
 	unsigned long len;
@@ -254,7 +255,10 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 		&vdso_text_mapping);
 
-	if (!IS_ERR(vma))
-		mm->context.vdso = addr;
+	if (IS_ERR(vma))
+		return;
+
+	mm->context.vdso = addr;
+	*sysinfo_ehdr = addr;
 }
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 1b710deb84d6..666338724a07 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -213,8 +213,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
-				    struct linux_binprm *bprm,
-				    int uses_interp)
+				    unsigned long *sysinfo_ehdr)
 {
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	unsigned long gp_flags = 0;
@@ -250,6 +249,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	if (IS_ERR(ret))
 		goto up_fail;
 
+	*sysinfo_ehdr = vdso_base;
+
 	return 0;
 
 up_fail:
@@ -401,8 +402,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
-static int aarch32_setup_additional_pages(struct linux_binprm *bprm,
-					  int uses_interp)
+static int aarch32_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
@@ -412,8 +412,7 @@ static int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 		return ret;
 
 	if (IS_ENABLED(CONFIG_COMPAT_VDSO)) {
-		ret = __setup_additional_pages(VDSO_ABI_AA32, mm, bprm,
-					       uses_interp);
+		ret = __setup_additional_pages(VDSO_ABI_AA32, mm, sysinfo_ehdr);
 		if (ret)
 			return ret;
 	}
@@ -447,7 +446,7 @@ static int __init vdso_init(void)
 }
 arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
@@ -456,9 +455,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	if (is_compat_task())
-		ret = aarch32_setup_additional_pages(bprm, uses_interp);
+		ret = aarch32_setup_additional_pages(sysinfo_ehdr);
 	else
-		ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
+		ret = __setup_additional_pages(VDSO_ABI_AA64, mm, sysinfo_ehdr);
 
 	mmap_write_unlock(mm);
 
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index abc3dbc658d4..f72f76915c59 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -44,7 +44,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	int ret;
 	unsigned long addr;
@@ -68,6 +68,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto up_fail;
 
 	mm->context.vdso = (void *)addr;
+	*sysinfo_ehdr = addr;
 
 up_fail:
 	mmap_write_unlock(mm);
diff --git a/arch/hexagon/kernel/vdso.c b/arch/hexagon/kernel/vdso.c
index b70970ac809f..39e78fe82b99 100644
--- a/arch/hexagon/kernel/vdso.c
+++ b/arch/hexagon/kernel/vdso.c
@@ -46,7 +46,7 @@ arch_initcall(vdso_init);
 /*
  * Called from binfmt_elf.  Create a VMA for the vDSO page.
  */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	int ret;
 	unsigned long vdso_base;
@@ -74,6 +74,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto up_fail;
 
 	mm->context.vdso = (void *)vdso_base;
+	*sysinfo_ehdr = vdso_base;
 
 up_fail:
 	mmap_write_unlock(mm);
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 242dc5e83847..a4a321252df6 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -86,7 +86,7 @@ static unsigned long vdso_base(void)
 	return base;
 }
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
@@ -184,6 +184,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	mm->context.vdso = (void *)vdso_addr;
+	*sysinfo_ehdr = vdso_addr;
 	ret = 0;
 
 out:
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
index e16009a07971..530164221166 100644
--- a/arch/nds32/kernel/vdso.c
+++ b/arch/nds32/kernel/vdso.c
@@ -111,7 +111,7 @@ unsigned long inline vdso_random_addr(unsigned long vdso_mapping_len)
 	return addr;
 }
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
@@ -176,6 +176,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	/*Map vdso to user space */
 	vdso_base += PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
+	*sysinfo_ehdr = vdso_base;
 	vma = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ | VM_EXEC |
 				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 61862dbb0e32..e09e54198ac6 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -104,7 +104,7 @@ static int alloc_kuser_page(void)
 }
 arch_initcall(alloc_kuser_page);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 8dad44262e75..0ec3bbe7fb36 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -122,7 +122,7 @@ struct lib64_elfinfo
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
  */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	struct page **vdso_pagelist;
@@ -211,6 +211,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	mmap_write_unlock(mm);
+	*sysinfo_ehdr = vdso_base;
 	return 0;
 
  fail_mmapsem:
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 678204231700..d5c741e3cde6 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -56,11 +56,10 @@ static int __init vdso_init(void)
 }
 arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_len;
+	unsigned long vdso_base, vvar_base, vdso_len;
 	int ret;
 
 	vdso_len = (vdso_pages + 1) << PAGE_SHIFT;
@@ -89,12 +88,14 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 		goto end;
 	}
 
-	vdso_base += (vdso_pages << PAGE_SHIFT);
+	vvar_base = vdso_base + (vdso_pages << PAGE_SHIFT);
 	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
 		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
 
 	if (unlikely(ret))
 		mm->context.vdso = NULL;
+	else
+		*sysinfo_ehdr = vdso_base;
 end:
 	mmap_write_unlock(mm);
 	return ret;
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 6c9ec9521203..810b72f8985c 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -150,7 +150,7 @@ void vdso_free_per_cpu(struct lowcore *lowcore)
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
  */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -205,6 +205,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	current->mm->context.vdso_base = vdso_base;
+	*sysinfo_ehdr = vdso_base;
 	rc = 0;
 
 out_up:
diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index 1bd85a6949c4..de8df3261b4f 100644
--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -55,7 +55,7 @@ int __init vsyscall_init(void)
 }
 
 /* Setup a VMA at program startup for the vsyscall page */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
@@ -78,6 +78,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto up_fail;
 
 	current->mm->context.vdso = (void *)addr;
+	*sysinfo_ehdr = addr;
 
 up_fail:
 	mmap_write_unlock(mm);
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index cc19e09b0fa1..bf9195fe9bcc 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -346,8 +346,6 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
-struct linux_binprm;
-
 /* Shuffle the vdso up a bit, randomly. */
 static unsigned long vdso_addr(unsigned long start, unsigned int len)
 {
@@ -359,7 +357,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned int len)
 }
 
 static int map_vdso(const struct vdso_image *image,
-		struct vm_special_mapping *vdso_mapping)
+		    struct vm_special_mapping *vdso_mapping,
+		    unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -421,12 +420,14 @@ static int map_vdso(const struct vdso_image *image,
 up_fail:
 	if (ret)
 		current->mm->context.vdso = NULL;
+	else
+		*sysinfo_ehdr = text_start;
 
 	mmap_write_unlock(mm);
 	return ret;
 }
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 
 	if (!vdso_enabled)
@@ -434,11 +435,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #if defined CONFIG_COMPAT
 	if (!(is_32bit_task()))
-		return map_vdso(&vdso_image_64_builtin, &vdso_mapping64);
+		return map_vdso(&vdso_image_64_builtin, &vdso_mapping64, sysinfo_ehdr);
 	else
-		return map_vdso(&vdso_image_32_builtin, &vdso_mapping32);
+		return map_vdso(&vdso_image_32_builtin, &vdso_mapping32, sysinfo_ehdr);
 #else
-	return map_vdso(&vdso_image_64_builtin, &vdso_mapping64);
+	return map_vdso(&vdso_image_64_builtin, &vdso_mapping64, sysinfo_ehdr);
 #endif
 
 }
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index aace862ed9a1..5b9020742e66 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -243,7 +243,8 @@ static const struct vm_special_mapping vvar_mapping = {
  * @image          - blob to map
  * @addr           - request a specific address (zero to map at free addr)
  */
-static int map_vdso(const struct vdso_image *image, unsigned long addr)
+static int map_vdso(const struct vdso_image *image, unsigned long addr,
+		    unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -290,6 +291,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	} else {
 		current->mm->context.vdso = (void __user *)text_start;
 		current->mm->context.vdso_image = image;
+		*sysinfo_ehdr = text_start;
 	}
 
 up_fail:
@@ -342,11 +344,12 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 	return addr;
 }
 
-static int map_vdso_randomized(const struct vdso_image *image)
+static int map_vdso_randomized(const struct vdso_image *image,
+			       unsigned long *sysinfo_ehdr)
 {
 	unsigned long addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
 
-	return map_vdso(image, addr);
+	return map_vdso(image, addr, sysinfo_ehdr);
 }
 #endif
 
@@ -354,6 +357,7 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long unused;
 
 	mmap_write_lock(mm);
 	/*
@@ -372,19 +376,19 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	}
 	mmap_write_unlock(mm);
 
-	return map_vdso(image, addr);
+	return map_vdso(image, addr, &unused);
 }
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static int load_vdso_ia32(void)
+static int load_vdso_ia32(unsigned long *sysinfo_ehdr)
 {
 	if (vdso32_enabled != 1)  /* Other values all mean "disabled" */
 		return 0;
 
-	return map_vdso(&vdso_image_32, 0);
+	return map_vdso(&vdso_image_32, 0, sysinfo_ehdr);
 }
 #else
-static int load_vdso_ia32(void)
+static int load_vdso_ia32(unsigned long *sysinfo_ehdr)
 {
 	WARN_ON_ONCE(1);
 	return -ENODATA;
@@ -392,32 +396,32 @@ static int load_vdso_ia32(void)
 #endif
 
 #ifdef CONFIG_X86_64
-static int load_vdso_64(void)
+static int load_vdso_64(unsigned long *sysinfo_ehdr)
 {
 	if (!vdso64_enabled)
 		return 0;
 
 #ifdef CONFIG_X86_X32_ABI
 	if (in_x32_syscall())
-		return map_vdso_randomized(&vdso_image_x32);
+		return map_vdso_randomized(&vdso_image_x32, sysinfo_ehdr);
 #endif
 
-	return map_vdso_randomized(&vdso_image_64);
+	return map_vdso_randomized(&vdso_image_64, sysinfo_ehdr);
 }
 #else
-static int load_vdso_64(void)
+static int load_vdso_64(unsigned long *sysinfo_ehdr)
 {
 	WARN_ON_ONCE(1);
 	return -ENODATA;
 }
 #endif
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	if (in_ia32_syscall())
-		return load_vdso_ia32();
+		return load_vdso_ia32(sysinfo_ehdr);
 
-	return load_vdso_64();
+	return load_vdso_64(sysinfo_ehdr);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index 76d9f6ce7a3d..77488065f7cc 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -50,7 +50,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	int err;
 	struct mm_struct *mm = current->mm;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b9adbeb59101..049ff514aa19 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -833,6 +833,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long interp_load_addr = 0;
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long reloc_func_desc __maybe_unused = 0;
+	unsigned long sysinfo_ehdr = 0;
 	int executable_stack = EXSTACK_DEFAULT;
 	struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
 	struct elfhdr *interp_elf_ex = NULL;
@@ -1249,7 +1250,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
-	retval = arch_setup_additional_pages(bprm, !!interpreter);
+	retval = arch_setup_additional_pages(&sysinfo_ehdr);
 	if (retval < 0)
 		goto out;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b9a6d1b2b5bb..c9ee3c240855 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -183,6 +183,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 {
 	struct elf_fdpic_params exec_params, interp_params;
 	struct pt_regs *regs = current_pt_regs();
+	unsigned long sysinfo_ehdr = 0;
 	struct elf_phdr *phdr;
 	unsigned long stack_size, entryaddr;
 #ifdef ELF_FDPIC_PLAT_INIT
@@ -375,7 +376,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto error;
 
-	retval = arch_setup_additional_pages(bprm, !!interpreter_name);
+	retval = arch_setup_additional_pages(&sysinfo_ehdr);
 	if (retval < 0)
 		goto error;
 #endif
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 95bf7a1abaef..f9b561bb395d 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -104,13 +104,20 @@ static inline int arch_elf_adjust_prot(int prot,
 }
 #endif
 
-struct linux_binprm;
 #ifdef CONFIG_ARCH_HAS_SETUP_ADDITIONAL_PAGES
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
+/**
+ * arch_setup_additional_pages - Premap VMAs in a new-execed process
+ * @sysinfo_ehdr:	Returns vDSO position to be set in the initial
+ *			auxiliary vector (tag AT_SYSINFO_EHDR) by binfmt
+ *			loader. On failure isn't initialized.
+ *			As address == 0 is never used, it allows to check
+ *			if the tag should be set.
+ *
+ * Return: Zero if successful, or a negative error code on failure.
+ */
+extern int arch_setup_additional_pages(unsigned long *sysinfo_ehdr);
 #else
-static inline int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
+static inline int arch_setup_additional_pages(unsigned long *sysinfo_ehdr);
 {
 	return 0;
 }
-- 
2.28.0

