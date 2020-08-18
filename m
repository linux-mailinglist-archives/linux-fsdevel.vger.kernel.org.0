Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3B247E53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 08:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHRGNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 02:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHRGND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:13:03 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE6C061342
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:13:02 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id v11so7419829edr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pYiZwcWeMz44ELBzcaK4rfrQj2l/TC9LD4qXY23V9zc=;
        b=ol15Y1gPEu6jshFw3dZcjIcrA/HgDsJlPZ3ryMcXexY7BWS86JStwF9tWm+dCA33of
         6OciP+QOqijS3HC7puY0JE4fvfK1Cb6LzBh/JN8W5stoHHjLl/uELMzx7EUD/qN0PR/k
         xNVWwrZ1CXUnl0acWTYLaW9ehc2jB5kKQ+df0uQBu0EDu1JTe6VE56v0s7LyjF3EAoPv
         FnbC/NWuXWtx/VMBlrPBLkFqAFdOGfYichRJD5BdFTIgO1keE73rQTZBCkbhFKbWUo9z
         XKttviCO6j/KDVHPs7YK6fbPyRRt8cHBiGZfTEFKptqcDRHnu7J23ufv6VCZUyIXQbaH
         4rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pYiZwcWeMz44ELBzcaK4rfrQj2l/TC9LD4qXY23V9zc=;
        b=DHohdXuSQXAxGWZ02d8rLhnMWJ+G54Mw0UJC5J+OzRXS/D7RP3AlgXbdB0mAvA7BsK
         apq77GjvDo/r6EroolY4+asNrzZ/mwfPUf6k8Ghc2AyLz/g5h2A8Uoud6iobAwexY2l0
         Ox4Uw/WKx9NNVbr2UYnmDCj40WIY2UfHvNjN0rE7A+Rx7ZDQ7w7iGHbVuNi2ty92ugpT
         YojJhrPNeNmOk2xEMhDsqK95ahSSrgcmLgmloJSVUnF36kbbIaB5q1Zn8etbVzQ5lQ7i
         ye4gwhoVLxqWds75rW4B9ucANxEUgTz9VU4eHeen0/w05h6UDtcixurUidszu1s4naG+
         bGGg==
X-Gm-Message-State: AOAM533oi6BmJM1kgXvYDt/kCWAG2AQQPRGrcQ/hdcQMmGJyeOhTl/QT
        xnKGSybZZyLVQkb0IhGgWVMQGUX3jA==
X-Google-Smtp-Source: ABdhPJwDEQp/gLR2K5vFDVNObgVui1XL8Z3wzGkzBYOIT7RNngti4bpH1ilcjWqRp61Uu9I83ncjTFQ0iA==
X-Received: by 2002:a05:6402:1c88:: with SMTP id cy8mr18905326edb.24.1597731181085;
 Mon, 17 Aug 2020 23:13:01 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:38 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-5-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
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

In both binfmt_elf and binfmt_elf_fdpic, use a new helper
dump_vma_snapshot() to take a snapshot of the VMA list (including the gate
VMA, if we have one) while protected by the mmap_lock, and then use that
snapshot instead of walking the VMA list without locking.

An alternative approach would be to keep the mmap_lock held across the
entire core dumping operation; however, keeping the mmap_lock locked while
we may be blocked for an unbounded amount of time (e.g. because we're
dumping to a FUSE filesystem or so) isn't really optimal; the mmap_lock
blocks things like the ->release handler of userfaultfd, and we don't
really want critical system daemons to grind to a halt just because someone
"gifted" them SCM_RIGHTS to an eternally-locked userfaultfd, or something
like that.

Since both the normal ELF code and the FDPIC ELF code need this
functionality (and if any other binfmt wants to add coredump support in the
future, they'd probably need it, too), implement this with a common helper
in fs/coredump.c.

A downside of this approach is that we now need a bigger amount of kernel
memory per userspace VMA in the normal ELF case, and that we need O(n)
kernel memory in the FDPIC ELF case at all; but 40 bytes per VMA shouldn't
be terribly bad.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c          | 166 ++++++++++++++++-----------------------
 fs/binfmt_elf_fdpic.c    |  86 ++++++++++----------
 fs/coredump.c            |  69 ++++++++++++++++
 include/linux/coredump.h |   9 +++
 4 files changed, 186 insertions(+), 144 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5fd11a25d320..519c38dc9097 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1420,8 +1420,12 @@ static bool always_dump_vma(struct vm_area_struct *vma)
 	return false;
 }
 
+#define DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER 1
+
 /*
  * Decide what to dump of a segment, part, all or none.
+ * The result must be fixed up via vma_dump_size_fixup() once we're in a context
+ * that doesn't hold mmap_lock.
  */
 static unsigned long vma_dump_size(struct vm_area_struct *vma,
 				   unsigned long mm_flags)
@@ -1476,30 +1480,15 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 
 	/*
 	 * If this looks like the beginning of a DSO or executable mapping,
-	 * check for an ELF header.  If we find one, dump the first page to
-	 * aid in determining what was mapped here.
+	 * we'll check for an ELF header. If we find one, we'll dump the first
+	 * page to aid in determining what was mapped here.
+	 * However, we shouldn't sleep on userspace reads while holding the
+	 * mmap_lock, so we just return a placeholder for now that will be fixed
+	 * up later in vma_dump_size_fixup().
 	 */
 	if (FILTER(ELF_HEADERS) &&
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
+	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ))
+		return DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER;
 
 #undef	FILTER
 
@@ -1509,6 +1498,22 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	return vma->vm_end - vma->vm_start;
 }
 
+/*
+ * Fix up vma_dump_size()'s result based on whether this VMA has an ELF header.
+ * The caller must *not* hold mmap_lock.
+ * See vma_dump_size() for context.
+ */
+static void vma_dump_size_fixup(struct core_vma_metadata *meta)
+{
+	char elfmag[SELFMAG];
+
+	if (copy_from_user(elfmag, (void __user *)meta->start, SELFMAG) ||
+	    memcmp(elfmag, ELFMAG, SELFMAG) != 0)
+		meta->dump_size = 0;
+	else
+		meta->dump_size = PAGE_SIZE;
+}
+
 /* An ELF note in memory */
 struct memelfnote
 {
@@ -2220,32 +2225,6 @@ static void free_note_info(struct elf_note_info *info)
 
 #endif
 
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret = tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-/*
- * Helper function for iterating across a vma list.  It ensures that the caller
- * will visit `gate_vma' prior to terminating the search.
- */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret;
-
-	ret = this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma == gate_vma)
-		return NULL;
-	return gate_vma;
-}
-
 static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 			     elf_addr_t e_shoff, int segs)
 {
@@ -2272,9 +2251,8 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 static int elf_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	int segs, i;
+	int vma_count, segs, i;
 	size_t vma_data_size = 0;
-	struct vm_area_struct *vma, *gate_vma;
 	struct elfhdr elf;
 	loff_t offset = 0, dataoff;
 	struct elf_note_info info = { };
@@ -2282,30 +2260,35 @@ static int elf_core_dump(struct coredump_params *cprm)
 	struct elf_shdr *shdr4extnum = NULL;
 	Elf_Half e_phnum;
 	elf_addr_t e_shoff;
-	elf_addr_t *vma_filesz = NULL;
+	struct core_vma_metadata *vma_meta;
+
+	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, vma_dump_size))
+		return 0;
+
+	for (i = 0; i < vma_count; i++) {
+		struct core_vma_metadata *meta = vma_meta + i;
+
+		if (meta->dump_size == DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER) {
+			/*
+			 * We want to select ->dump_size based on whether the
+			 * VMA starts with an ELF header, but that uses
+			 * copy_from_user(), which doesn't work from the
+			 * dump_vma_snapshot() callback because the mmap_lock
+			 * is held there.
+			 * So instead, fix it up here, where we're not holding
+			 * any locks.
+			 */
+			vma_dump_size_fixup(meta);
+		}
+
+		vma_data_size += meta->dump_size;
+	}
 
-	/*
-	 * We no longer stop all VM operations.
-	 * 
-	 * This is because those proceses that could possibly change map_count
-	 * or the mmap / vma pages are now blocked in do_exit on current
-	 * finishing this core dump.
-	 *
-	 * Only ptrace can touch these memory addresses, but it doesn't change
-	 * the map_count or the pages allocated. So no possibility of crashing
-	 * exists while dumping the mm->vm_next areas to the core file.
-	 */
-  
 	/*
 	 * The number of segs are recored into ELF header as 16bit value.
 	 * Please check DEFAULT_MAX_MAP_COUNT definition when you modify here.
 	 */
-	segs = current->mm->map_count;
-	segs += elf_core_extra_phdrs();
-
-	gate_vma = get_gate_vma(current->mm);
-	if (gate_vma != NULL)
-		segs++;
+	segs = vma_count + elf_core_extra_phdrs();
 
 	/* for notes section */
 	segs++;
@@ -2343,24 +2326,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	/*
-	 * Zero vma process will get ZERO_SIZE_PTR here.
-	 * Let coredump continue for register state at least.
-	 */
-	vma_filesz = kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)),
-			      GFP_KERNEL);
-	if (!vma_filesz)
-		goto end_coredump;
-
-	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
-			vma = next_vma(vma, gate_vma)) {
-		unsigned long dump_size;
-
-		dump_size = vma_dump_size(vma, cprm->mm_flags);
-		vma_filesz[i++] = dump_size;
-		vma_data_size += dump_size;
-	}
-
 	offset += vma_data_size;
 	offset += elf_core_extra_data_size();
 	e_shoff = offset;
@@ -2381,21 +2346,23 @@ static int elf_core_dump(struct coredump_params *cprm)
 		goto end_coredump;
 
 	/* Write program headers for segments dump */
-	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
-			vma = next_vma(vma, gate_vma)) {
+	for (i = 0; i < vma_count; i++) {
+		struct core_vma_metadata *meta = vma_meta + i;
 		struct elf_phdr phdr;
 
 		phdr.p_type = PT_LOAD;
 		phdr.p_offset = offset;
-		phdr.p_vaddr = vma->vm_start;
+		phdr.p_vaddr = meta->start;
 		phdr.p_paddr = 0;
-		phdr.p_filesz = vma_filesz[i++];
-		phdr.p_memsz = vma->vm_end - vma->vm_start;
+		phdr.p_filesz = meta->dump_size;
+		phdr.p_memsz = meta->end - meta->start;
 		offset += phdr.p_filesz;
-		phdr.p_flags = vma->vm_flags & VM_READ ? PF_R : 0;
-		if (vma->vm_flags & VM_WRITE)
+		phdr.p_flags = 0;
+		if (meta->flags & VM_READ)
+			phdr.p_flags |= PF_R;
+		if (meta->flags & VM_WRITE)
 			phdr.p_flags |= PF_W;
-		if (vma->vm_flags & VM_EXEC)
+		if (meta->flags & VM_EXEC)
 			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
@@ -2417,9 +2384,10 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!dump_skip(cprm, dataoff - cprm->pos))
 		goto end_coredump;
 
-	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
-			vma = next_vma(vma, gate_vma)) {
-		if (!dump_user_range(cprm, vma->vm_start, vma_filesz[i++]))
+	for (i = 0; i < vma_count; i++) {
+		struct core_vma_metadata *meta = vma_meta + i;
+
+		if (!dump_user_range(cprm, meta->start, meta->dump_size))
 			goto end_coredump;
 	}
 	dump_truncate(cprm);
@@ -2435,7 +2403,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 end_coredump:
 	free_note_info(&info);
 	kfree(shdr4extnum);
-	kvfree(vma_filesz);
+	kvfree(vma_meta);
 	kfree(phdr4note);
 	return has_dumped;
 }
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 76e8c0defdc8..f9d35bc9f0af 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1222,7 +1222,8 @@ struct elf_prstatus_fdpic
  *
  * I think we should skip something. But I am not sure how. H.J.
  */
-static int maydump(struct vm_area_struct *vma, unsigned long mm_flags)
+static unsigned long vma_dump_size(struct vm_area_struct *vma,
+				   unsigned long mm_flags)
 {
 	int dump_ok;
 
@@ -1251,7 +1252,7 @@ static int maydump(struct vm_area_struct *vma, unsigned long mm_flags)
 			kdcore("%08lx: %08lx: %s (DAX private)", vma->vm_start,
 			       vma->vm_flags, dump_ok ? "yes" : "no");
 		}
-		return dump_ok;
+		goto out;
 	}
 
 	/* By default, dump shared memory if mapped from an anonymous file. */
@@ -1260,13 +1261,13 @@ static int maydump(struct vm_area_struct *vma, unsigned long mm_flags)
 			dump_ok = test_bit(MMF_DUMP_ANON_SHARED, &mm_flags);
 			kdcore("%08lx: %08lx: %s (share)", vma->vm_start,
 			       vma->vm_flags, dump_ok ? "yes" : "no");
-			return dump_ok;
+			goto out;
 		}
 
 		dump_ok = test_bit(MMF_DUMP_MAPPED_SHARED, &mm_flags);
 		kdcore("%08lx: %08lx: %s (share)", vma->vm_start,
 		       vma->vm_flags, dump_ok ? "yes" : "no");
-		return dump_ok;
+		goto out;
 	}
 
 #ifdef CONFIG_MMU
@@ -1275,14 +1276,16 @@ static int maydump(struct vm_area_struct *vma, unsigned long mm_flags)
 		dump_ok = test_bit(MMF_DUMP_MAPPED_PRIVATE, &mm_flags);
 		kdcore("%08lx: %08lx: %s (!anon)", vma->vm_start,
 		       vma->vm_flags, dump_ok ? "yes" : "no");
-		return dump_ok;
+		goto out;
 	}
 #endif
 
 	dump_ok = test_bit(MMF_DUMP_ANON_PRIVATE, &mm_flags);
 	kdcore("%08lx: %08lx: %s", vma->vm_start, vma->vm_flags,
 	       dump_ok ? "yes" : "no");
-	return dump_ok;
+
+out:
+	return dump_ok ? vma->vm_end - vma->vm_start : 0;
 }
 
 /* An ELF note in memory */
@@ -1524,31 +1527,30 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 /*
  * dump the segments for an MMU process
  */
-static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
+static bool elf_fdpic_dump_segments(struct coredump_params *cprm,
+				    struct core_vma_metadata *vma_meta,
+				    int vma_count)
 {
-	struct vm_area_struct *vma;
+	int i;
 
-	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
-		unsigned long addr;
+	for (i = 0; i < vma_count; i++) {
+		struct core_vma_metadata *meta = vma_meta + i;
 
-		if (!maydump(vma, cprm->mm_flags))
-			continue;
-
-		if (!dump_user_range(cprm, vma->vm_start,
-				     vma->vma_end - vma->vm_start))
+		if (!dump_user_range(cprm, meta->start, meta->dump_size))
 			return false;
 	}
 	return true;
 }
 
-static size_t elf_core_vma_data_size(unsigned long mm_flags)
+static size_t elf_core_vma_data_size(unsigned long mm_flags,
+				     struct core_vma_metadata *vma_meta,
+				     int vma_count)
 {
-	struct vm_area_struct *vma;
 	size_t size = 0;
+	int i;
 
-	for (vma = current->mm->mmap; vma; vma = vma->vm_next)
-		if (maydump(vma, mm_flags))
-			size += vma->vm_end - vma->vm_start;
+	for (i = 0; i < vma_count; i++)
+		size += vma_meta[i].dump_size;
 	return size;
 }
 
@@ -1562,9 +1564,8 @@ static size_t elf_core_vma_data_size(unsigned long mm_flags)
 static int elf_fdpic_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	int segs;
+	int vma_count, segs;
 	int i;
-	struct vm_area_struct *vma;
 	struct elfhdr *elf = NULL;
 	loff_t offset = 0, dataoff;
 	struct memelfnote psinfo_note, auxv_note;
@@ -1578,18 +1579,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	elf_addr_t e_shoff;
 	struct core_thread *ct;
 	struct elf_thread_status *tmp;
-
-	/*
-	 * We no longer stop all VM operations.
-	 *
-	 * This is because those proceses that could possibly change map_count
-	 * or the mmap / vma pages are now blocked in do_exit on current
-	 * finishing this core dump.
-	 *
-	 * Only ptrace can touch these memory addresses, but it doesn't change
-	 * the map_count or the pages allocated. So no possibility of crashing
-	 * exists while dumping the mm->vm_next areas to the core file.
-	 */
+	struct core_vma_metadata *vma_meta = NULL;
 
 	/* alloc memory for large data structures: too large to be on stack */
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
@@ -1599,6 +1589,9 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!psinfo)
 		goto end_coredump;
 
+	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, vma_dump_size))
+		goto end_coredump;
+
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
 		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
@@ -1618,8 +1611,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	tmp->next = thread_list;
 	thread_list = tmp;
 
-	segs = current->mm->map_count;
-	segs += elf_core_extra_phdrs();
+	segs = vma_count + elf_core_extra_phdrs();
 
 	/* for notes section */
 	segs++;
@@ -1664,7 +1656,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	/* Page-align dumped data */
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	offset += elf_core_vma_data_size(cprm->mm_flags);
+	offset += elf_core_vma_data_size(cprm->mm_flags, vma_meta, vma_count);
 	offset += elf_core_extra_data_size();
 	e_shoff = offset;
 
@@ -1684,23 +1676,26 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		goto end_coredump;
 
 	/* write program headers for segments dump */
-	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
+	for (i = 0; i < vma_count; i++) {
+		struct core_vma_metadata *meta = vma_meta + i;
 		struct elf_phdr phdr;
 		size_t sz;
 
-		sz = vma->vm_end - vma->vm_start;
+		sz = meta->end - meta->start;
 
 		phdr.p_type = PT_LOAD;
 		phdr.p_offset = offset;
-		phdr.p_vaddr = vma->vm_start;
+		phdr.p_vaddr = meta->start;
 		phdr.p_paddr = 0;
-		phdr.p_filesz = maydump(vma, cprm->mm_flags) ? sz : 0;
+		phdr.p_filesz = meta->dump_size;
 		phdr.p_memsz = sz;
 		offset += phdr.p_filesz;
-		phdr.p_flags = vma->vm_flags & VM_READ ? PF_R : 0;
-		if (vma->vm_flags & VM_WRITE)
+		phdr.p_flags = 0;
+		if (meta->flags & VM_READ)
+			phdr.p_flags |= PF_R;
+		if (meta->flags & VM_WRITE)
 			phdr.p_flags |= PF_W;
-		if (vma->vm_flags & VM_EXEC)
+		if (meta->flags & VM_EXEC)
 			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
@@ -1732,7 +1727,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!dump_skip(cprm, dataoff - cprm->pos))
 		goto end_coredump;
 
-	if (!elf_fdpic_dump_segments(cprm))
+	if (!elf_fdpic_dump_segments(cprm, vma_meta, vma_count))
 		goto end_coredump;
 
 	if (!elf_core_write_extra_data(cprm))
@@ -1756,6 +1751,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		thread_list = thread_list->next;
 		kfree(tmp);
 	}
+	kvfree(vma_meta);
 	kfree(phdr4note);
 	kfree(elf);
 	kfree(psinfo);
diff --git a/fs/coredump.c b/fs/coredump.c
index 6042d15acd51..7b4486b701bb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -936,3 +936,72 @@ void dump_truncate(struct coredump_params *cprm)
 	}
 }
 EXPORT_SYMBOL(dump_truncate);
+
+static struct vm_area_struct *first_vma(struct task_struct *tsk,
+					struct vm_area_struct *gate_vma)
+{
+	struct vm_area_struct *ret = tsk->mm->mmap;
+
+	if (ret)
+		return ret;
+	return gate_vma;
+}
+
+/*
+ * Helper function for iterating across a vma list.  It ensures that the caller
+ * will visit `gate_vma' prior to terminating the search.
+ */
+static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+				       struct vm_area_struct *gate_vma)
+{
+	struct vm_area_struct *ret;
+
+	ret = this_vma->vm_next;
+	if (ret)
+		return ret;
+	if (this_vma == gate_vma)
+		return NULL;
+	return gate_vma;
+}
+
+/*
+ * Under the mmap_lock, take a snapshot of relevant information about the task's
+ * VMAs.
+ */
+int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
+		      struct core_vma_metadata **vma_meta,
+		      unsigned long (*dump_size_cb)(struct vm_area_struct *, unsigned long))
+{
+	struct vm_area_struct *vma, *gate_vma;
+	struct mm_struct *mm = current->mm;
+	int i;
+
+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
+
+	gate_vma = get_gate_vma(mm);
+	*vma_count = mm->map_count + (gate_vma ? 1 : 0);
+
+	*vma_meta = kvmalloc_array(*vma_count, sizeof(**vma_meta), GFP_KERNEL);
+	if (!*vma_meta) {
+		mmap_read_unlock(mm);
+		return -ENOMEM;
+	}
+
+	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
+			vma = next_vma(vma, gate_vma), i++) {
+		struct core_vma_metadata *m = (*vma_meta) + i;
+
+		m->start = vma->vm_start;
+		m->end = vma->vm_end;
+		m->flags = vma->vm_flags;
+		m->dump_size = dump_size_cb(vma, cprm->mm_flags);
+	}
+
+	mmap_read_unlock(mm);
+
+	if (WARN_ON(i != *vma_count))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index f0b71a74d0bc..21bbef9bd8d6 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -7,6 +7,12 @@
 #include <linux/fs.h>
 #include <asm/siginfo.h>
 
+struct core_vma_metadata {
+	unsigned long start, end;
+	unsigned long flags;
+	unsigned long dump_size;
+};
+
 /*
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
@@ -18,6 +24,9 @@ extern int dump_align(struct coredump_params *cprm, int align);
 extern void dump_truncate(struct coredump_params *cprm);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
+int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
+		      struct core_vma_metadata **vma_meta,
+		      unsigned long (*dump_size_cb)(struct vm_area_struct *, unsigned long));
 #ifdef CONFIG_COREDUMP
 extern void do_coredump(const kernel_siginfo_t *siginfo);
 #else
-- 
2.28.0.220.ged08abb693-goog

