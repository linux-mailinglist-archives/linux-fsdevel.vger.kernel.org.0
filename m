Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28222548A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgH0PKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgH0Lu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A2C0611E2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v11so6935127ybm.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ChG9OT8YpBy/wCXjoQcT7mcfe51RwJeE1qaxZBpgE38=;
        b=RsIoKu7HEtzc9XeEV23ejUsVaV3p8UmK+EwpIFL+HE1NwTMaR+TNkUTDPoDM4vO1ol
         GnAOgjIkY16Wfq9AM4ulWMMd4u+srziLQ3FZ80tRRY5bqSV4SEd2nILFG8h/pKzqKlOW
         biLLwesuG5kKNLdlvNx56XbAyPxHopJ2anheErk+et3xVsx25DHjW4wVoF1fMT8xX+0d
         gvzOfEeKy4UrSF6YUxrOiO6WxaOoEt5JXUXFwhPWDdQmU5M4PKXRTKqpOhIVsTbNvFCk
         DRSqhzIazVx39HPgVQx8FwZr8x4saxoU0DnIl3Y1LvRjEEqfvA6qn8+BxW0xGN6HuikU
         8b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ChG9OT8YpBy/wCXjoQcT7mcfe51RwJeE1qaxZBpgE38=;
        b=o08Aji9XDLrvpjaedRKNbAcMa5++p+ny33wRfydDyLkjLd6UE7CErsA3zPWPaGHDez
         C99DZz7cS5hkE9zLmuFIFkJCjBP3YEgbcP+WDYfT64tB8c4IlY7Mk6rq+uri51/O8CtJ
         o5T5GHfDNO/Lvyp5xKKsEWhuxVVRw3kMAdMvrT2jXLrjrNEUpjS6phixnO34zZYwezRW
         ndETKNrNV+pBDPwRHP66FZilF/XUAxY37WMKxUHjGCCQHRO2fbIKvTFx28xVi6kjFomu
         bLPOgZ31JHcGXBiltw9UX8PxUXc6zP4G7QkpkuG6W+iVXaeRELzNhbuv1kOH30xRwCwk
         Nzug==
X-Gm-Message-State: AOAM531AboJJTR8fWUqftgCOzm2ISF8MvCnfGRVb7Uu1fONNs+lxovP/
        43QspXLAmAzqtMhv3naDbi1Sg4eIcw==
X-Google-Smtp-Source: ABdhPJwZD09uB5UfiGVB8q5Jr2M8er9OffaZKarHfoLl/X0H6SsrqCeMwjLDkIaGpXiSy6zG6H68lkvLHw==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a25:ad5a:: with SMTP id l26mr26698371ybe.510.1598528998652;
 Thu, 27 Aug 2020 04:49:58 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:30 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-6-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 5/7] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
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

There currently is a data race between stack expansion and anything that
reads ->vm_start or ->vm_end under the mmap_lock held in read mode; to
mitigate that for core dumping, take the mmap_lock in write mode when
taking a snapshot of the VMA hierarchy.
(If we only took the mmap_lock in read mode, we could end up with a
corrupted core dump if someone does get_user_pages_remote() concurrently.
Not really a major problem, but taking the mmap_lock either way works here,
so we might as well avoid the issue.)
(This doesn't do anything about the existing data races with stack
expansion in other mm code.)

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c          | 100 +++++++++------------------------------
 fs/binfmt_elf_fdpic.c    |  67 +++++++++++---------------
 fs/coredump.c            |  81 ++++++++++++++++++++++++++++++-
 include/linux/coredump.h |  10 +++-
 4 files changed, 138 insertions(+), 120 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 03478005a128..40ec0b9b4b4f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2100,32 +2100,6 @@ static void free_note_info(struct elf_note_info *info)
 
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
@@ -2152,9 +2126,8 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 static int elf_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	int segs, i;
-	size_t vma_data_size = 0;
-	struct vm_area_struct *vma, *gate_vma;
+	int vma_count, segs, i;
+	size_t vma_data_size;
 	struct elfhdr elf;
 	loff_t offset = 0, dataoff;
 	struct elf_note_info info = { };
@@ -2162,30 +2135,16 @@ static int elf_core_dump(struct coredump_params *cprm)
 	struct elf_shdr *shdr4extnum = NULL;
 	Elf_Half e_phnum;
 	elf_addr_t e_shoff;
-	elf_addr_t *vma_filesz = NULL;
+	struct core_vma_metadata *vma_meta;
+
+	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, &vma_data_size))
+		return 0;
 
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
@@ -2223,24 +2182,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 
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
@@ -2261,21 +2202,23 @@ static int elf_core_dump(struct coredump_params *cprm)
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
 
@@ -2297,9 +2240,10 @@ static int elf_core_dump(struct coredump_params *cprm)
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
@@ -2315,7 +2259,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 end_coredump:
 	free_note_info(&info);
 	kfree(shdr4extnum);
-	kvfree(vma_filesz);
+	kvfree(vma_meta);
 	kfree(phdr4note);
 	return has_dumped;
 }
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f531c6198864..be4062b8ba75 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1454,29 +1454,21 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
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
-		unsigned long size = vma_dump_size(vma, cprm->mm_flags);
+	for (i = 0; i < vma_count; i++) {
+		struct core_vma_metadata *meta = vma_meta + i;
 
-		if (!dump_user_range(cprm, vma->vm_start, size))
+		if (!dump_user_range(cprm, meta->start, meta->dump_size))
 			return false;
 	}
 	return true;
 }
 
-static size_t elf_core_vma_data_size(unsigned long mm_flags)
-{
-	struct vm_area_struct *vma;
-	size_t size = 0;
-
-	for (vma = current->mm->mmap; vma; vma = vma->vm_next)
-		size += vma_dump_size(vma, mm_flags);
-	return size;
-}
-
 /*
  * Actual dumper
  *
@@ -1487,9 +1479,8 @@ static size_t elf_core_vma_data_size(unsigned long mm_flags)
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
@@ -1503,18 +1494,8 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
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
+	size_t vma_data_size;
 
 	/* alloc memory for large data structures: too large to be on stack */
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
@@ -1524,6 +1505,9 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!psinfo)
 		goto end_coredump;
 
+	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, &vma_data_size))
+		goto end_coredump;
+
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
 		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
@@ -1543,8 +1527,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	tmp->next = thread_list;
 	thread_list = tmp;
 
-	segs = current->mm->map_count;
-	segs += elf_core_extra_phdrs();
+	segs = vma_count + elf_core_extra_phdrs();
 
 	/* for notes section */
 	segs++;
@@ -1589,7 +1572,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	/* Page-align dumped data */
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	offset += elf_core_vma_data_size(cprm->mm_flags);
+	offset += vma_data_size;
 	offset += elf_core_extra_data_size();
 	e_shoff = offset;
 
@@ -1609,23 +1592,26 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
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
-		phdr.p_filesz = vma_dump_size(vma, cprm->mm_flags);
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
 
@@ -1657,7 +1643,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!dump_skip(cprm, dataoff - cprm->pos))
 		goto end_coredump;
 
-	if (!elf_fdpic_dump_segments(cprm))
+	if (!elf_fdpic_dump_segments(cprm, vma_meta, vma_count))
 		goto end_coredump;
 
 	if (!elf_core_write_extra_data(cprm))
@@ -1681,6 +1667,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		thread_list = thread_list->next;
 		kfree(tmp);
 	}
+	kvfree(vma_meta);
 	kfree(phdr4note);
 	kfree(elf);
 	kfree(psinfo);
diff --git a/fs/coredump.c b/fs/coredump.c
index 4ef4c49a65b7..0cd9056d79cc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -971,7 +971,8 @@ static bool always_dump_vma(struct vm_area_struct *vma)
 /*
  * Decide how much of @vma's contents should be included in a core dump.
  */
-unsigned long vma_dump_size(struct vm_area_struct *vma, unsigned long mm_flags)
+static unsigned long vma_dump_size(struct vm_area_struct *vma,
+				   unsigned long mm_flags)
 {
 #define FILTER(type)	(mm_flags & (1UL << MMF_DUMP_##type))
 
@@ -1037,3 +1038,81 @@ unsigned long vma_dump_size(struct vm_area_struct *vma, unsigned long mm_flags)
 whole:
 	return vma->vm_end - vma->vm_start;
 }
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
+		      size_t *vma_data_size_ptr)
+{
+	struct vm_area_struct *vma, *gate_vma;
+	struct mm_struct *mm = current->mm;
+	int i;
+	size_t vma_data_size = 0;
+
+	/*
+	 * Once the stack expansion code is fixed to not change VMA bounds
+	 * under mmap_lock in read mode, this can be changed to take the
+	 * mmap_lock in read mode.
+	 */
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	gate_vma = get_gate_vma(mm);
+	*vma_count = mm->map_count + (gate_vma ? 1 : 0);
+
+	*vma_meta = kvmalloc_array(*vma_count, sizeof(**vma_meta), GFP_KERNEL);
+	if (!*vma_meta) {
+		mmap_write_unlock(mm);
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
+		m->dump_size = vma_dump_size(vma, cprm->mm_flags);
+
+		vma_data_size += m->dump_size;
+	}
+
+	mmap_write_unlock(mm);
+
+	if (WARN_ON(i != *vma_count))
+		return -EFAULT;
+
+	*vma_data_size_ptr = vma_data_size;
+	return 0;
+}
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index bfecb8d79a7f..e58e8c207782 100644
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
@@ -16,9 +22,11 @@ extern int dump_skip(struct coredump_params *cprm, size_t nr);
 extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 extern void dump_truncate(struct coredump_params *cprm);
-unsigned long vma_dump_size(struct vm_area_struct *vma, unsigned long mm_flags);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
+int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
+		      struct core_vma_metadata **vma_meta,
+		      size_t *vma_data_size_ptr);
 #ifdef CONFIG_COREDUMP
 extern void do_coredump(const kernel_siginfo_t *siginfo);
 #else
-- 
2.28.0.297.g1956fa8f8d-goog

