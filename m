Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26925449B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgH0Lyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgH0Lu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D41C0611E0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id n128so4553920qke.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E0DOGeEY62qLZ7uSRf9UfIpHkq96+GdwwPXcN18hEJ0=;
        b=pIw2KrxmoMV7baKQC5k3kTG9I/MArgQOkxCEyQg7puGJNupue/a7c2lTegkZWYpXVj
         MRoJDyBaISNiyxzjuMP2fAquo3bkxD+e3+sH+Yd1wAM03gSei7kjZIP/QrKrNYOCYXQK
         IBbYHcuB8qgRiist7/ix7HynPAXoB1j25Lww9igyKbfY12dDMb4gNWRmIxvFqnkL3c0b
         NBPxrFxAYADJVPolcWPSkobKgiUocNZEkcAIYX0Sk5a1Z1OPIe2DlKk/Rrw1qC/l3tML
         lkmyTkfxZ/Vd/6xkglPtQkPmQw3NhD0MMoGzP2oJC97CBNez/q+Q6jyD9yjvqJj41FFx
         nN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E0DOGeEY62qLZ7uSRf9UfIpHkq96+GdwwPXcN18hEJ0=;
        b=uLB8TOZLdBHkZzBccG59FW1oK71zWeeNSH4QGWriN0OkfFLv9MkjAHT9SH+PbDsfZL
         PKMAxfKqAaVYTCzf0y9LAoEp2f/Vto5GUXidhu4TUor+p1YihJIJh5sh/t6Vhf6tU6cc
         z6ZfQTxGRi36pmpvA8E1pC0CA5LP+GZxaIfaNlATPJ55IDJWAstmK3in0++wY09xOaNz
         vRRVb9E8YriabvttDjePEcRmC6c9tnVP8CiDMI9w1TfWVwXmGUzuoers1moFDkip3mt5
         7du0hBklKhO01mulP0HWPztMF9HrajxqoEMqERSFxN76eLKYHQbhKzc5C9XUAsTwCQdo
         5Sbw==
X-Gm-Message-State: AOAM531rQP0Phnu22NhEttDZAvYuPgXVV31sCKmatyNSC1/dGIi7v3Ga
        sOFUeZH77Cp9husDicsXtd/yukx8xA==
X-Google-Smtp-Source: ABdhPJx4bULUmnyYEEBJ3ZbFaInsMrqKtXp7IHbERfvfk/Yok8RrNFYczmlckohS0u+OxxH3yv4/+3jxKA==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a0c:f4cb:: with SMTP id o11mr18241148qvm.3.1598528994972;
 Thu, 27 Aug 2020 04:49:54 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:29 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-5-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 4/7] coredump: Rework elf/elf_fdpic vma_dump_size() into
 common helper
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the moment, the binfmt_elf and binfmt_elf_fdpic code have slightly
different code to figure out which VMAs should be dumped, and if so,
whether the dump should contain the entire VMA or just its first page.

Eliminate duplicate code by reworking the binfmt_elf version into a generic
core dumping helper in coredump.c.

As part of that, change the heuristic for detecting executable/library
header pages to check whether the inode is executable instead of looking at
the file mode.
This is less problematic in terms of locking because it lets us avoid
get_user() under the mmap_sem. (And arguably it looks nicer and makes more
sense in generic code.)

Adjust a little bit based on the binfmt_elf_fdpic version:
->anon_vma is only meaningful under CONFIG_MMU, otherwise we have to assume
that the VMA has been written to.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c          | 120 ---------------------------------------
 fs/binfmt_elf_fdpic.c    |  83 ++-------------------------
 fs/coredump.c            | 101 ++++++++++++++++++++++++++++++++
 include/linux/coredump.h |   1 +
 4 files changed, 106 insertions(+), 199 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5fd11a25d320..03478005a128 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1389,126 +1389,6 @@ static int load_elf_library(struct file *file)
  * Jeremy Fitzhardinge <jeremy@sw.oz.au>
  */
 
-/*
- * The purpose of always_dump_vma() is to make sure that special kernel mappings
- * that are useful for post-mortem analysis are included in every core dump.
- * In that way we ensure that the core dump is fully interpretable later
- * without matching up the same kernel and hardware config to see what PC values
- * meant. These special mappings include - vDSO, vsyscall, and other
- * architecture specific mappings
- */
-static bool always_dump_vma(struct vm_area_struct *vma)
-{
-	/* Any vsyscall mappings? */
-	if (vma == get_gate_vma(vma->vm_mm))
-		return true;
-
-	/*
-	 * Assume that all vmas with a .name op should always be dumped.
-	 * If this changes, a new vm_ops field can easily be added.
-	 */
-	if (vma->vm_ops && vma->vm_ops->name && vma->vm_ops->name(vma))
-		return true;
-
-	/*
-	 * arch_vma_name() returns non-NULL for special architecture mappings,
-	 * such as vDSO sections.
-	 */
-	if (arch_vma_name(vma))
-		return true;
-
-	return false;
-}
-
-/*
- * Decide what to dump of a segment, part, all or none.
- */
-static unsigned long vma_dump_size(struct vm_area_struct *vma,
-				   unsigned long mm_flags)
-{
-#define FILTER(type)	(mm_flags & (1UL << MMF_DUMP_##type))
-
-	/* always dump the vdso and vsyscall sections */
-	if (always_dump_vma(vma))
-		goto whole;
-
-	if (vma->vm_flags & VM_DONTDUMP)
-		return 0;
-
-	/* support for DAX */
-	if (vma_is_dax(vma)) {
-		if ((vma->vm_flags & VM_SHARED) && FILTER(DAX_SHARED))
-			goto whole;
-		if (!(vma->vm_flags & VM_SHARED) && FILTER(DAX_PRIVATE))
-			goto whole;
-		return 0;
-	}
-
-	/* Hugetlb memory check */
-	if (is_vm_hugetlb_page(vma)) {
-		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
-			goto whole;
-		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
-			goto whole;
-		return 0;
-	}
-
-	/* Do not dump I/O mapped devices or special mappings */
-	if (vma->vm_flags & VM_IO)
-		return 0;
-
-	/* By default, dump shared memory if mapped from an anonymous file. */
-	if (vma->vm_flags & VM_SHARED) {
-		if (file_inode(vma->vm_file)->i_nlink == 0 ?
-		    FILTER(ANON_SHARED) : FILTER(MAPPED_SHARED))
-			goto whole;
-		return 0;
-	}
-
-	/* Dump segments that have been written to.  */
-	if (vma->anon_vma && FILTER(ANON_PRIVATE))
-		goto whole;
-	if (vma->vm_file == NULL)
-		return 0;
-
-	if (FILTER(MAPPED_PRIVATE))
-		goto whole;
-
-	/*
-	 * If this looks like the beginning of a DSO or executable mapping,
-	 * check for an ELF header.  If we find one, dump the first page to
-	 * aid in determining what was mapped here.
-	 */
-	if (FILTER(ELF_HEADERS) &&
-	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ)) {
-		u32 __user *header = (u32 __user *) vma->vm_start;
-		u32 word;
-		/*
-		 * Doing it this way gets the constant folded by GCC.
-		 */
-		union {
-			u32 cmp;
-			char elfmag[SELFMAG];
-		} magic;
-		BUILD_BUG_ON(SELFMAG != sizeof word);
-		magic.elfmag[EI_MAG0] = ELFMAG0;
-		magic.elfmag[EI_MAG1] = ELFMAG1;
-		magic.elfmag[EI_MAG2] = ELFMAG2;
-		magic.elfmag[EI_MAG3] = ELFMAG3;
-		if (unlikely(get_user(word, header)))
-			word = 0;
-		if (word == magic.cmp)
-			return PAGE_SIZE;
-	}
-
-#undef	FILTER
-
-	return 0;
-
-whole:
-	return vma->vm_end - vma->vm_start;
-}
-
 /* An ELF note in memory */
 struct memelfnote
 {
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 76e8c0defdc8..f531c6198864 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1215,76 +1215,6 @@ struct elf_prstatus_fdpic
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
 
-/*
- * Decide whether a segment is worth dumping; default is yes to be
- * sure (missing info is worse than too much; etc).
- * Personally I'd include everything, and use the coredump limit...
- *
- * I think we should skip something. But I am not sure how. H.J.
- */
-static int maydump(struct vm_area_struct *vma, unsigned long mm_flags)
-{
-	int dump_ok;
-
-	/* Do not dump I/O mapped devices or special mappings */
-	if (vma->vm_flags & VM_IO) {
-		kdcore("%08lx: %08lx: no (IO)", vma->vm_start, vma->vm_flags);
-		return 0;
-	}
-
-	/* If we may not read the contents, don't allow us to dump
-	 * them either. "dump_write()" can't handle it anyway.
-	 */
-	if (!(vma->vm_flags & VM_READ)) {
-		kdcore("%08lx: %08lx: no (!read)", vma->vm_start, vma->vm_flags);
-		return 0;
-	}
-
-	/* support for DAX */
-	if (vma_is_dax(vma)) {
-		if (vma->vm_flags & VM_SHARED) {
-			dump_ok = test_bit(MMF_DUMP_DAX_SHARED, &mm_flags);
-			kdcore("%08lx: %08lx: %s (DAX shared)", vma->vm_start,
-			       vma->vm_flags, dump_ok ? "yes" : "no");
-		} else {
-			dump_ok = test_bit(MMF_DUMP_DAX_PRIVATE, &mm_flags);
-			kdcore("%08lx: %08lx: %s (DAX private)", vma->vm_start,
-			       vma->vm_flags, dump_ok ? "yes" : "no");
-		}
-		return dump_ok;
-	}
-
-	/* By default, dump shared memory if mapped from an anonymous file. */
-	if (vma->vm_flags & VM_SHARED) {
-		if (file_inode(vma->vm_file)->i_nlink == 0) {
-			dump_ok = test_bit(MMF_DUMP_ANON_SHARED, &mm_flags);
-			kdcore("%08lx: %08lx: %s (share)", vma->vm_start,
-			       vma->vm_flags, dump_ok ? "yes" : "no");
-			return dump_ok;
-		}
-
-		dump_ok = test_bit(MMF_DUMP_MAPPED_SHARED, &mm_flags);
-		kdcore("%08lx: %08lx: %s (share)", vma->vm_start,
-		       vma->vm_flags, dump_ok ? "yes" : "no");
-		return dump_ok;
-	}
-
-#ifdef CONFIG_MMU
-	/* By default, if it hasn't been written to, don't write it out */
-	if (!vma->anon_vma) {
-		dump_ok = test_bit(MMF_DUMP_MAPPED_PRIVATE, &mm_flags);
-		kdcore("%08lx: %08lx: %s (!anon)", vma->vm_start,
-		       vma->vm_flags, dump_ok ? "yes" : "no");
-		return dump_ok;
-	}
-#endif
-
-	dump_ok = test_bit(MMF_DUMP_ANON_PRIVATE, &mm_flags);
-	kdcore("%08lx: %08lx: %s", vma->vm_start, vma->vm_flags,
-	       dump_ok ? "yes" : "no");
-	return dump_ok;
-}
-
 /* An ELF note in memory */
 struct memelfnote
 {
@@ -1529,13 +1459,9 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 	struct vm_area_struct *vma;
 
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
-		unsigned long addr;
-
-		if (!maydump(vma, cprm->mm_flags))
-			continue;
+		unsigned long size = vma_dump_size(vma, cprm->mm_flags);
 
-		if (!dump_user_range(cprm, vma->vm_start,
-				     vma->vma_end - vma->vm_start))
+		if (!dump_user_range(cprm, vma->vm_start, size))
 			return false;
 	}
 	return true;
@@ -1547,8 +1473,7 @@ static size_t elf_core_vma_data_size(unsigned long mm_flags)
 	size_t size = 0;
 
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next)
-		if (maydump(vma, mm_flags))
-			size += vma->vm_end - vma->vm_start;
+		size += vma_dump_size(vma, mm_flags);
 	return size;
 }
 
@@ -1694,7 +1619,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		phdr.p_offset = offset;
 		phdr.p_vaddr = vma->vm_start;
 		phdr.p_paddr = 0;
-		phdr.p_filesz = maydump(vma, cprm->mm_flags) ? sz : 0;
+		phdr.p_filesz = vma_dump_size(vma, cprm->mm_flags);
 		phdr.p_memsz = sz;
 		offset += phdr.p_filesz;
 		phdr.p_flags = vma->vm_flags & VM_READ ? PF_R : 0;
diff --git a/fs/coredump.c b/fs/coredump.c
index 6042d15acd51..4ef4c49a65b7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -936,3 +936,104 @@ void dump_truncate(struct coredump_params *cprm)
 	}
 }
 EXPORT_SYMBOL(dump_truncate);
+
+/*
+ * The purpose of always_dump_vma() is to make sure that special kernel mappings
+ * that are useful for post-mortem analysis are included in every core dump.
+ * In that way we ensure that the core dump is fully interpretable later
+ * without matching up the same kernel and hardware config to see what PC values
+ * meant. These special mappings include - vDSO, vsyscall, and other
+ * architecture specific mappings
+ */
+static bool always_dump_vma(struct vm_area_struct *vma)
+{
+	/* Any vsyscall mappings? */
+	if (vma == get_gate_vma(vma->vm_mm))
+		return true;
+
+	/*
+	 * Assume that all vmas with a .name op should always be dumped.
+	 * If this changes, a new vm_ops field can easily be added.
+	 */
+	if (vma->vm_ops && vma->vm_ops->name && vma->vm_ops->name(vma))
+		return true;
+
+	/*
+	 * arch_vma_name() returns non-NULL for special architecture mappings,
+	 * such as vDSO sections.
+	 */
+	if (arch_vma_name(vma))
+		return true;
+
+	return false;
+}
+
+/*
+ * Decide how much of @vma's contents should be included in a core dump.
+ */
+unsigned long vma_dump_size(struct vm_area_struct *vma, unsigned long mm_flags)
+{
+#define FILTER(type)	(mm_flags & (1UL << MMF_DUMP_##type))
+
+	/* always dump the vdso and vsyscall sections */
+	if (always_dump_vma(vma))
+		goto whole;
+
+	if (vma->vm_flags & VM_DONTDUMP)
+		return 0;
+
+	/* support for DAX */
+	if (vma_is_dax(vma)) {
+		if ((vma->vm_flags & VM_SHARED) && FILTER(DAX_SHARED))
+			goto whole;
+		if (!(vma->vm_flags & VM_SHARED) && FILTER(DAX_PRIVATE))
+			goto whole;
+		return 0;
+	}
+
+	/* Hugetlb memory check */
+	if (is_vm_hugetlb_page(vma)) {
+		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
+			goto whole;
+		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
+			goto whole;
+		return 0;
+	}
+
+	/* Do not dump I/O mapped devices or special mappings */
+	if (vma->vm_flags & VM_IO)
+		return 0;
+
+	/* By default, dump shared memory if mapped from an anonymous file. */
+	if (vma->vm_flags & VM_SHARED) {
+		if (file_inode(vma->vm_file)->i_nlink == 0 ?
+		    FILTER(ANON_SHARED) : FILTER(MAPPED_SHARED))
+			goto whole;
+		return 0;
+	}
+
+	/* Dump segments that have been written to.  */
+	if ((!IS_ENABLED(CONFIG_MMU) || vma->anon_vma) && FILTER(ANON_PRIVATE))
+		goto whole;
+	if (vma->vm_file == NULL)
+		return 0;
+
+	if (FILTER(MAPPED_PRIVATE))
+		goto whole;
+
+	/*
+	 * If this is the beginning of an executable file mapping,
+	 * dump the first page to aid in determining what was mapped here.
+	 */
+	if (FILTER(ELF_HEADERS) &&
+	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ) &&
+	    (READ_ONCE(file_inode(vma->vm_file)->i_mode) & 0111) != 0)
+		return PAGE_SIZE;
+
+#undef	FILTER
+
+	return 0;
+
+whole:
+	return vma->vm_end - vma->vm_start;
+}
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index f0b71a74d0bc..bfecb8d79a7f 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -16,6 +16,7 @@ extern int dump_skip(struct coredump_params *cprm, size_t nr);
 extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 extern void dump_truncate(struct coredump_params *cprm);
+unsigned long vma_dump_size(struct vm_area_struct *vma, unsigned long mm_flags);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
 #ifdef CONFIG_COREDUMP
-- 
2.28.0.297.g1956fa8f8d-goog

