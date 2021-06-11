Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4323A485E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFKSGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:34 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35812 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhFKSGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:11 -0400
Received: by mail-wm1-f50.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so9177634wms.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1xLi3VLXaVd+7MR45JmRZVZG+RFGXE9B/nll34DSnA=;
        b=X3/tqQoLCiHUAi58LAUz9jsAXvwRmnr7CENWR9q3Dx2ih/ij+zBzm+TGkf7jojaswD
         ZT1HmqbRECppg/GTto8OGmArdXvkqbuD2hMlgYCFvhuKS7JTcN/XMsbSN2KLOSLLatfd
         b7kIapNS5VHAjwFqGw2xxpC+fYSCQ7lkubO5rhVtu+eMSdM9KjVDivavDhtz7Urqi2aY
         1b1yYlyT1ccA622vQuzTO6DkCit4xJU0H71PSQESDIkdXMksYAedqPKtezcAUZuL9a2H
         TQIKJdvQh0Lr7eLhZdeNFuMW3+IqiugRKTxH5OSRpl7fZrw4reiJVv+Muy17KMzxXBNc
         JkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1xLi3VLXaVd+7MR45JmRZVZG+RFGXE9B/nll34DSnA=;
        b=Gd5D8ZIAwwx5v1KpzO+5+6Z/myVky1dGDveU2xO/q81vaY9FWmRpZVcNOZo6bhCDeL
         OkPZYLv2mDnRCh/4+dnG5t8CljCA839fsZNH4RA4gLdNv7Ndet/XWQSb0lQQokAJKFum
         u3sRb/VvJs6SAsq9cYD6y0ZvP7D8lcoxZ74yWw3Ed4GTFsF5UEaQsXDqLoiah++0rNrq
         dCY9M4D9ZrKo4F3G2oh970dJIbLAN+3yo0Zvo+IGKhEsaR6Y2qbeR+mXT75cTUlBP6vf
         ybfbr2fg+JCBY5EzBg6HBV8MRStnm5X0K9mnVtv5zvMWVQYNX7UoMKA1kFMpLgwHH2zB
         zfJw==
X-Gm-Message-State: AOAM533dl5zTmBy6HNPZj9kj1tLXRqcyQg1AT8oRBjdOSvTXGg2bukoP
        hpGW+ANZuc7bhxmWFX4WD0RpvA==
X-Google-Smtp-Source: ABdhPJzlL1y5s5BhGGJshTLid85xopyVEDk+gc4KHIQih/S4UxB461RfAh86fwg9P3in50yG0jM4NQ==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr5353901wmg.23.1623434581495;
        Fri, 11 Jun 2021 11:03:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:01 -0700 (PDT)
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
Subject: [PATCH v3 08/23] elf/vdso: Modify arch_setup_additional_pages() parameters
Date:   Fri, 11 Jun 2021 19:02:27 +0100
Message-Id: <20210611180242.711399-9-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
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
vector. The reason to add this parameter is that many architectures
have vDSO pointer saved in their mm->context with the only purpose
to use it later in ARCH_DLINFO. That's the macro for elf loader
to setup sysinfo_ehdr tag.

Return sysinfo_ehdr address that will be later used by ARCH_DLINFO as
an argument. That will allow to drop vDSO pointer from mm->context
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
 arch/arm64/kernel/vdso.c           | 17 ++++++++---------
 arch/csky/kernel/vdso.c            | 11 ++++++-----
 arch/hexagon/kernel/vdso.c         |  3 ++-
 arch/mips/kernel/vdso.c            |  3 ++-
 arch/nds32/kernel/vdso.c           |  3 ++-
 arch/nios2/mm/init.c               |  2 +-
 arch/powerpc/kernel/vdso.c         | 12 +++++++-----
 arch/riscv/kernel/vdso.c           | 11 ++++++-----
 arch/s390/kernel/vdso.c            |  3 ++-
 arch/sh/kernel/vsyscall/vsyscall.c |  3 ++-
 arch/sparc/vdso/vma.c              | 14 +++++++-------
 arch/x86/entry/vdso/vma.c          | 26 +++++++++++++++-----------
 arch/x86/um/vdso/vma.c             |  2 +-
 fs/binfmt_elf.c                    |  3 ++-
 fs/binfmt_elf_fdpic.c              |  3 ++-
 include/linux/elf.h                | 17 ++++++++++++-----
 19 files changed, 90 insertions(+), 63 deletions(-)

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
index 6324f4db9b02..5897ccb88bca 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -400,7 +400,7 @@ static const struct vm_special_mapping sigpage_mapping = {
 	.mremap = sigpage_mremap,
 };
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -441,7 +441,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * to be fatal to the process, so no error check needed
 	 * here.
 	 */
-	arm_install_vdso(mm, addr + PAGE_SIZE);
+	arm_install_vdso(mm, addr + PAGE_SIZE, sysinfo_ehdr);
 
  up_fail:
 	mmap_write_unlock(mm);
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 015eff0a6e93..de516f8ba85a 100644
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
@@ -252,7 +253,10 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
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
index 1bc8adefa293..c0512c2e8183 100644
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
@@ -248,6 +247,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		return PTR_ERR(ret);
 
 	mm->context.vdso = (void *)vdso_base;
+	*sysinfo_ehdr = vdso_base;
+
 	return 0;
 }
 
@@ -405,8 +406,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
-static int aarch32_setup_additional_pages(struct linux_binprm *bprm,
-					  int uses_interp)
+static int aarch32_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
@@ -416,8 +416,7 @@ static int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 		return ret;
 
 	if (IS_ENABLED(CONFIG_COMPAT_VDSO)) {
-		ret = __setup_additional_pages(VDSO_ABI_AA32, mm, bprm,
-					       uses_interp);
+		ret = __setup_additional_pages(VDSO_ABI_AA32, mm, sysinfo_ehdr);
 		if (ret)
 			return ret;
 	}
@@ -451,7 +450,7 @@ static int __init vdso_init(void)
 }
 arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
@@ -460,9 +459,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	if (is_compat_task())
-		ret = aarch32_setup_additional_pages(bprm, uses_interp);
+		ret = aarch32_setup_additional_pages(sysinfo_ehdr);
 	else
-		ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
+		ret = __setup_additional_pages(VDSO_ABI_AA64, mm, sysinfo_ehdr);
 
 	mmap_write_unlock(mm);
 
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 16c20d64d165..30160e64ee2d 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -52,11 +52,10 @@ static int __init vdso_init(void)
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
@@ -85,12 +84,14 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 		goto end;
 	}
 
-	vdso_base += (vdso_pages << PAGE_SHIFT);
-	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
+	vvar_base = vdso_base + (vdso_pages << PAGE_SHIFT);
+	ret = install_special_mapping(mm, vvar_base, PAGE_SIZE,
 		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
 
 	if (unlikely(ret))
 		mm->context.vdso = NULL;
+	else
+		*sysinfo_ehdr = vdso_base;
 end:
 	mmap_write_unlock(mm);
 	return ret;
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
index 3d0cf471f2fe..9b2e1d2250b4 100644
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
@@ -185,6 +185,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	mm->context.vdso = (void *)vdso_addr;
+	*sysinfo_ehdr = vdso_addr;
 	ret = 0;
 
 out:
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
index 2d1d51a0fc64..1d35a33389e5 100644
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
@@ -185,6 +185,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	mm->context.vdso = (void *)vdso_base;
+	*sysinfo_ehdr = vdso_base;
 
 up_fail:
 	mmap_write_unlock(mm);
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 613fcaa5988a..0164f5cdb255 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -103,7 +103,7 @@ static int alloc_kuser_page(void)
 }
 arch_initcall(alloc_kuser_page);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 76e898b56002..6d6e575630c1 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -190,7 +190,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
  */
-static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+static int __arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	unsigned long vdso_size, vdso_base, mappings_size;
 	struct vm_special_mapping *vdso_spec;
@@ -248,15 +248,17 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	vma = _install_special_mapping(mm, vdso_base + vvar_size, vdso_size,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
 				       VM_MAYWRITE | VM_MAYEXEC, vdso_spec);
-	if (IS_ERR(vma))
+	if (IS_ERR(vma)) {
 		do_munmap(mm, vdso_base, vvar_size, NULL);
-	else
+	} else {
 		mm->context.vdso = (void __user *)vdso_base + vvar_size;
+		*sysinfo_ehdr = vdso_base + vvar_size;
+	}
 
 	return PTR_ERR_OR_ZERO(vma);
 }
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	int rc;
@@ -266,7 +268,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	rc = __arch_setup_additional_pages(bprm, uses_interp);
+	rc = __arch_setup_additional_pages(sysinfo_ehdr);
 	if (rc)
 		mm->context.vdso = NULL;
 
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 25a3b8849599..9cbbad8e48da 100644
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
-	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
+	vvar_base = vdso_base + (vdso_pages << PAGE_SHIFT);
+	ret = install_special_mapping(mm, vvar_base, PAGE_SIZE,
 		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
 
 	if (unlikely(ret))
 		mm->context.vdso = NULL;
+	else
+		*sysinfo_ehdr = vdso_base;
 end:
 	mmap_write_unlock(mm);
 	return ret;
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 8c4e07d533c8..8a72fdedbae9 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -167,7 +167,7 @@ int vdso_getcpu_init(void)
 }
 early_initcall(vdso_getcpu_init); /* Must be called before SMP init */
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	unsigned long vdso_text_len, vdso_mapping_len;
 	unsigned long vvar_start, vdso_text_start;
@@ -204,6 +204,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		rc = PTR_ERR(vma);
 	} else {
 		current->mm->context.vdso_base = vdso_text_start;
+		*sysinfo_ehdr = vdso_text_start;
 		rc = 0;
 	}
 out:
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
index d8a344f6c914..ae635893f9b3 100644
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
@@ -416,6 +415,7 @@ static int map_vdso(const struct vdso_image *image,
 		do_munmap(mm, text_start, image->size, NULL);
 	} else {
 		current->mm->context.vdso = (void __user *)text_start;
+		*sysinfo_ehdr = text_start;
 	}
 
 up_fail:
@@ -423,7 +423,7 @@ static int map_vdso(const struct vdso_image *image,
 	return ret;
 }
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 
 	if (!vdso_enabled)
@@ -431,11 +431,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
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
index 99415ffb9501..f1abe43aadb9 100644
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
@@ -372,41 +376,41 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	}
 	mmap_write_unlock(mm);
 
-	return map_vdso(image, addr);
+	return map_vdso(image, addr, &unused);
 }
 
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
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 	if (in_ia32_syscall()) {
 		if (vdso32_enabled != 1)  /* Other values all mean "disabled" */
 			return 0;
-		return map_vdso(&vdso_image_32, 0);
+		return map_vdso(&vdso_image_32, 0, sysinfo_ehdr);
 	}
 #endif
 
-	return load_vdso_64();
+	return load_vdso_64(sysinfo_ehdr);
 }
 
 bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
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
index dac2713c10ee..62741e55e3d1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -836,6 +836,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long interp_load_addr = 0;
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long reloc_func_desc __maybe_unused = 0;
+	unsigned long sysinfo_ehdr = 0;
 	int executable_stack = EXSTACK_DEFAULT;
 	struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
 	struct elfhdr *interp_elf_ex = NULL;
@@ -1252,7 +1253,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
-	retval = arch_setup_additional_pages(bprm, !!interpreter);
+	retval = arch_setup_additional_pages(&sysinfo_ehdr);
 	if (retval < 0)
 		goto out;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 11cbf20b19da..421a09bc6ee6 100644
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
index 95bf7a1abaef..a8bea5611a4b 100644
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
+static inline int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 {
 	return 0;
 }
-- 
2.31.1

