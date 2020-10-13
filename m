Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A137228C6D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgJMBeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgJMBe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0CC0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x7so13231099wrl.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QI03JfUdAeqx8H20V8QB+drTDnXgJr9KGaylcrY6E98=;
        b=YoPP5GksBayPf3YA7iKAhJRnUEw9hLY1epr3iRj1JZcb8AczM+hA8gE9m8KN3op2hH
         oJsdXJN/juKuz/IX0LfynhImiuc5BXLZODpopg9/dKr6AO5DRbo9eA+/Tnk/Gabp3M32
         tkI9HX8Xfzgr1+RZ8d30CYRYuDbqOlpwz4S6/cLFPpzLykgpt4SgsKyVRhuDvdZU7s4v
         NAO+0SFtu8dVFDXQeh+Auwyk497u1Pq+RVy+QnuzyxP0dcf8CWnY74eu++KCgV7f6NBm
         tPhM5ye4nI4QHXHZl0BXKrOGmccM9xxAGF+qOIqP9KaDmawf/AP/lR7OtcjlGuH0ZUil
         +mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QI03JfUdAeqx8H20V8QB+drTDnXgJr9KGaylcrY6E98=;
        b=pktax9aiJnDs2JwgkQCLVRXHU/NT01UnK8WOnQCXSyQvGfbZPWPG1cKJJ+zyr1wXV6
         XtLw5ul5IyGe6/1BP+oZLUABmJRivhnRipilZ0L8sk3xOAVfCsweaT6ZdGvCnQvz0Dvc
         p0bbyHEWV65m48YoBBfWaXmkfWEL1bE8upAdNugdle6yLNoKZrARNUkFGOFm47sb0EM9
         1tcv/RFgEtMiu/dm8SQqfpMs8wENmSYusAdDZkBjKj4HFArTY/JPqKlzWu3GtvEfnWEA
         7X/RRC5HpErCNu9seDoWnBdK9kyzYHBj1Ny/xDrgrvzhZbGXaJAd72Q2e2ahArIQLe/K
         0k2Q==
X-Gm-Message-State: AOAM533c7yAzcVKniz5Oy4eZxuRgj32djgExYrUFqzboIYv7VlG4GRau
        dibGlJiWcRXqoNBT/uICrWK8cA==
X-Google-Smtp-Source: ABdhPJzRUrGoqc2gRFrRPbwBQLI+3EviW230fK5qUbXR+5lWN/w2oMhECQzgHSMuyap8rQ2Z9wPpZQ==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr7124845wrn.68.1602552868235;
        Mon, 12 Oct 2020 18:34:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:27 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 6/6] mm: Forbid splitting special mappings
Date:   Tue, 13 Oct 2020 02:34:16 +0100
Message-Id: <20201013013416.390574-7-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013013416.390574-1-dima@arista.com>
References: <20201013013416.390574-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't allow splitting of vm_special_mapping's.
It affects vdso/vvar areas. Uprobes have only one page in xol_area so
they aren't affected.

Those restrictions were enforced by checks in .mremap() callbacks.
Restrict resizing with generic .split() callback.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/vdso.c    |  9 ---------
 arch/arm64/kernel/vdso.c  | 41 +++------------------------------------
 arch/mips/vdso/genvdso.c  |  4 ----
 arch/s390/kernel/vdso.c   | 11 +----------
 arch/x86/entry/vdso/vma.c | 17 ----------------
 mm/mmap.c                 | 12 ++++++++++++
 6 files changed, 16 insertions(+), 78 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index fddd08a6e063..3408269d19c7 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -50,15 +50,6 @@ static const struct vm_special_mapping vdso_data_mapping = {
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-	unsigned long vdso_size;
-
-	/* without VVAR page */
-	vdso_size = (vdso_total_pages - 1) << PAGE_SHIFT;
-
-	if (vdso_size != new_size)
-		return -EINVAL;
-
 	current->mm->context.vdso = new_vma->vm_start;
 
 	return 0;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index d4202a32abc9..a1a4220a405b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -82,17 +82,9 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-static int __vdso_remap(enum vdso_abi abi,
-			const struct vm_special_mapping *sm,
-			struct vm_area_struct *new_vma)
+static int vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
 {
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-	unsigned long vdso_size = vdso_info[abi].vdso_code_end -
-				  vdso_info[abi].vdso_code_start;
-
-	if (vdso_size != new_size)
-		return -EINVAL;
-
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
 	return 0;
@@ -223,17 +215,6 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
-static int vvar_mremap(const struct vm_special_mapping *sm,
-		       struct vm_area_struct *new_vma)
-{
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-
-	if (new_size != VVAR_NR_PAGES * PAGE_SIZE)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -284,14 +265,6 @@ static int __setup_additional_pages(enum vdso_abi abi,
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
-#ifdef CONFIG_COMPAT_VDSO
-static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	return __vdso_remap(VDSO_ABI_AA32, sm, new_vma);
-}
-#endif /* CONFIG_COMPAT_VDSO */
-
 enum aarch32_map {
 	AA32_MAP_VECTORS, /* kuser helpers */
 #ifdef CONFIG_COMPAT_VDSO
@@ -313,11 +286,10 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VVAR] = {
 		.name = "[vvar]",
 		.fault = vvar_fault,
-		.mremap = vvar_mremap,
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = aarch32_vdso_mremap,
+		.mremap = vdso_mremap,
 	},
 #endif /* CONFIG_COMPAT_VDSO */
 	[AA32_MAP_SIGPAGE] = {
@@ -465,12 +437,6 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	return __vdso_remap(VDSO_ABI_AA64, sm, new_vma);
-}
-
 enum aarch64_map {
 	AA64_MAP_VVAR,
 	AA64_MAP_VDSO,
@@ -480,7 +446,6 @@ static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	[AA64_MAP_VVAR] = {
 		.name	= "[vvar]",
 		.fault = vvar_fault,
-		.mremap = vvar_mremap,
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
diff --git a/arch/mips/vdso/genvdso.c b/arch/mips/vdso/genvdso.c
index abb06ae04b40..09e30eb4be86 100644
--- a/arch/mips/vdso/genvdso.c
+++ b/arch/mips/vdso/genvdso.c
@@ -263,10 +263,6 @@ int main(int argc, char **argv)
 	fprintf(out_file, "	const struct vm_special_mapping *sm,\n");
 	fprintf(out_file, "	struct vm_area_struct *new_vma)\n");
 	fprintf(out_file, "{\n");
-	fprintf(out_file, "	unsigned long new_size =\n");
-	fprintf(out_file, "	new_vma->vm_end - new_vma->vm_start;\n");
-	fprintf(out_file, "	if (vdso_image.size != new_size)\n");
-	fprintf(out_file, "		return -EINVAL;\n");
 	fprintf(out_file, "	current->mm->context.vdso =\n");
 	fprintf(out_file, "	(void *)(new_vma->vm_start);\n");
 	fprintf(out_file, "	return 0;\n");
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index c4baefaa6e34..291ead792d64 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -59,17 +59,8 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *vma)
 {
-	unsigned long vdso_pages;
-
-	vdso_pages = vdso64_pages;
-
-	if ((vdso_pages << PAGE_SHIFT) != vma->vm_end - vma->vm_start)
-		return -EINVAL;
-
-	if (WARN_ON_ONCE(current->mm != vma->vm_mm))
-		return -EFAULT;
-
 	current->mm->context.vdso_base = vma->vm_start;
+
 	return 0;
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..0c942b31825d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -89,30 +89,14 @@ static void vdso_fix_landing(const struct vdso_image *image,
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
 	const struct vdso_image *image = current->mm->context.vdso_image;
 
-	if (image->size != new_size)
-		return -EINVAL;
-
 	vdso_fix_landing(image, new_vma);
 	current->mm->context.vdso = (void __user *)new_vma->vm_start;
 
 	return 0;
 }
 
-static int vvar_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	const struct vdso_image *image = new_vma->vm_mm->context.vdso_image;
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-
-	if (new_size != -image->sym_vvar_start)
-		return -EINVAL;
-
-	return 0;
-}
-
 #ifdef CONFIG_TIME_NS
 static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
@@ -252,7 +236,6 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
-	.mremap = vvar_mremap,
 };
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index a62cb3ccafce..41100f6505ff 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3389,6 +3389,17 @@ static int special_mapping_mremap(struct vm_area_struct *new_vma,
 	return 0;
 }
 
+static int special_mapping_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Forbid splitting special mappings - kernel has expectations over
+	 * the number of pages in mapping. Together with VM_DONTEXPAND
+	 * the size of vma should stay the same over the special mapping's
+	 * lifetime.
+	 */
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct special_mapping_vmops = {
 	.close = special_mapping_close,
 	.fault = special_mapping_fault,
@@ -3396,6 +3407,7 @@ static const struct vm_operations_struct special_mapping_vmops = {
 	.name = special_mapping_name,
 	/* vDSO code relies that VVAR can't be accessed remotely */
 	.access = NULL,
+	.may_split = special_mapping_split,
 };
 
 static const struct vm_operations_struct legacy_special_mapping_vmops = {
-- 
2.28.0

