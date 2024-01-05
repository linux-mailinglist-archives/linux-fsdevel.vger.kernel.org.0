Return-Path: <linux-fsdevel+bounces-7452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09AA825213
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A521F24B13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6C2CCD5;
	Fri,  5 Jan 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQP8FqNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4292CCB8
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704450812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMd0XXt/3QLNfEezvmnhp9DcomDZvjf9Rdqwbd2Ah9k=;
	b=JQP8FqNfyboyUf5UfQ/6NkRBd2Y+jRVeagA1Ez10WHWTwT0b4iThhYWpMTvuYRBeY14ol2
	jZzRcoKXDi8dLpQwEiDte6m/+pN/q6tJ5ujsG2gKfmdbeMVIxbFTZeCjmDSKKRwPi0ovFW
	QpQTLHwIlstTFGo0R7lvjoDmfU2PSn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-gwtWkEyAM-C90USw9tPhow-1; Fri, 05 Jan 2024 05:33:23 -0500
X-MC-Unique: gwtWkEyAM-C90USw9tPhow-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAA538DC667;
	Fri,  5 Jan 2024 10:33:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E37AD492BC6;
	Fri,  5 Jan 2024 10:33:16 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	kexec@lists.infradead.org,
	hbathini@linux.ibm.com,
	arnd@arndb.de,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	viro@zeniv.linux.org.uk,
	ebiederm@xmission.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/5] kexec_core: move kdump related codes from crash_core.c to kexec_core.c
Date: Fri,  5 Jan 2024 18:33:01 +0800
Message-ID: <20240105103305.557273-2-bhe@redhat.com>
In-Reply-To: <20240105103305.557273-1-bhe@redhat.com>
References: <20240105103305.557273-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

In commit 6f991cc363a3 ("crash: move a few code bits to setup support
of crash hotplug"), some elfcorehdr processing codes were moved to
kernel/crash_core.c so that they can be shared by kexec_load and
kexec_file_load interface. And later in commit 247262756121 ("crash: add
generic infrastructure for crash hotplug support"), generic code for
crash hotplug support codes were added into kernel/crash_core.c.

In fact, these codes should be put in kernel/kexec_core.c because
both kexec_load and kexec_file_load need them.

So move them from kernel/crash_core.c to kernel/kexec_core.c. No
functionality change is introduced.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  26 ---
 include/linux/kexec.h      |  24 +++
 kernel/crash_core.c        | 404 ------------------------------------
 kernel/kexec_core.c        | 408 +++++++++++++++++++++++++++++++++++++
 4 files changed, 432 insertions(+), 430 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 5126a4fecb44..af304259afa3 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -124,30 +124,4 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
 		bool high)
 {}
 #endif
-
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[] __counted_by(max_nr_ranges);
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
-struct kimage;
-struct kexec_segment;
-
-#define KEXEC_CRASH_HP_NONE			0
-#define KEXEC_CRASH_HP_ADD_CPU			1
-#define KEXEC_CRASH_HP_REMOVE_CPU		2
-#define KEXEC_CRASH_HP_ADD_MEMORY		3
-#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
-#define KEXEC_CRASH_HP_INVALID_CPU		-1U
-
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..6705812f07f5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -227,6 +227,21 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[] __counted_by(max_nr_ranges);
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
@@ -500,6 +515,15 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
 static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..b4f3fdecbe26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -24,9 +24,6 @@
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
-/* Per cpu memory for storing cpu states in case of system crash. */
-note_buf_t __percpu *crash_notes;
-
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -463,187 +460,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
 }
 #endif
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each possible CPU */
-	for_each_possible_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -843,223 +659,3 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
-
-static int __init crash_notes_memory_init(void)
-{
-	/* Allocate memory for saving cpu registers. */
-	size_t size, align;
-
-	/*
-	 * crash_notes could be allocated across 2 vmalloc pages when percpu
-	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
-	 * pages are also on 2 continuous physical pages. In this case the
-	 * 2nd part of crash_notes in 2nd page could be lost since only the
-	 * starting address and size of crash_notes are exported through sysfs.
-	 * Here round up the size of crash_notes to the nearest power of two
-	 * and pass it to __alloc_percpu as align value. This can make sure
-	 * crash_notes is allocated inside one physical page.
-	 */
-	size = sizeof(note_buf_t);
-	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
-
-	/*
-	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
-	 * definitely will be in 2 pages with that.
-	 */
-	BUILD_BUG_ON(size > PAGE_SIZE);
-
-	crash_notes = __alloc_percpu(size, align);
-	if (!crash_notes) {
-		pr_warn("Memory allocation for saving cpu register states failed\n");
-		return -ENOMEM;
-	}
-	return 0;
-}
-subsys_initcall(crash_notes_memory_init);
-
-#ifdef CONFIG_CRASH_HOTPLUG
-#undef pr_fmt
-#define pr_fmt(fmt) "crash hp: " fmt
-
-/*
- * Different than kexec/kdump loading/unloading/jumping/shrinking which
- * usually rarely happen, there will be many crash hotplug events notified
- * during one short period, e.g one memory board is hot added and memory
- * regions are online. So mutex lock  __crash_hotplug_lock is used to
- * serialize the crash hotplug handling specifically.
- */
-DEFINE_MUTEX(__crash_hotplug_lock);
-#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
-#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
-
-/*
- * This routine utilized when the crash_hotplug sysfs node is read.
- * It reflects the kernel's ability/permission to update the crash
- * elfcorehdr directly.
- */
-int crash_check_update_elfcorehdr(void)
-{
-	int rc = 0;
-
-	crash_hotplug_lock();
-	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
-		crash_hotplug_unlock();
-		return 0;
-	}
-	if (kexec_crash_image) {
-		if (kexec_crash_image->file_mode)
-			rc = 1;
-		else
-			rc = kexec_crash_image->update_elfcorehdr;
-	}
-	/* Release lock now that update complete */
-	kexec_unlock();
-	crash_hotplug_unlock();
-
-	return rc;
-}
-
-/*
- * To accurately reflect hot un/plug changes of cpu and memory resources
- * (including onling and offlining of those resources), the elfcorehdr
- * (which is passed to the crash kernel via the elfcorehdr= parameter)
- * must be updated with the new list of CPUs and memories.
- *
- * In order to make changes to elfcorehdr, two conditions are needed:
- * First, the segment containing the elfcorehdr must be large enough
- * to permit a growing number of resources; the elfcorehdr memory size
- * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
- * Second, purgatory must explicitly exclude the elfcorehdr from the
- * list of segments it checks (since the elfcorehdr changes and thus
- * would require an update to purgatory itself to update the digest).
- */
-static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
-{
-	struct kimage *image;
-
-	crash_hotplug_lock();
-	/* Obtain lock while changing crash information */
-	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
-		crash_hotplug_unlock();
-		return;
-	}
-
-	/* Check kdump is not loaded */
-	if (!kexec_crash_image)
-		goto out;
-
-	image = kexec_crash_image;
-
-	/* Check that updating elfcorehdr is permitted */
-	if (!(image->file_mode || image->update_elfcorehdr))
-		goto out;
-
-	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
-		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
-		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
-	else
-		pr_debug("hp_action %u\n", hp_action);
-
-	/*
-	 * The elfcorehdr_index is set to -1 when the struct kimage
-	 * is allocated. Find the segment containing the elfcorehdr,
-	 * if not already found.
-	 */
-	if (image->elfcorehdr_index < 0) {
-		unsigned long mem;
-		unsigned char *ptr;
-		unsigned int n;
-
-		for (n = 0; n < image->nr_segments; n++) {
-			mem = image->segment[n].mem;
-			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-			if (ptr) {
-				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
-					image->elfcorehdr_index = (int)n;
-				kunmap_local(ptr);
-			}
-		}
-	}
-
-	if (image->elfcorehdr_index < 0) {
-		pr_err("unable to locate elfcorehdr segment");
-		goto out;
-	}
-
-	/* Needed in order for the segments to be updated */
-	arch_kexec_unprotect_crashkres();
-
-	/* Differentiate between normal load and hotplug update */
-	image->hp_action = hp_action;
-
-	/* Now invoke arch-specific update handler */
-	arch_crash_handle_hotplug_event(image);
-
-	/* No longer handling a hotplug event */
-	image->hp_action = KEXEC_CRASH_HP_NONE;
-	image->elfcorehdr_updated = true;
-
-	/* Change back to read-only */
-	arch_kexec_protect_crashkres();
-
-	/* Errors in the callback is not a reason to rollback state */
-out:
-	/* Release lock now that update complete */
-	kexec_unlock();
-	crash_hotplug_unlock();
-}
-
-static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
-{
-	switch (val) {
-	case MEM_ONLINE:
-		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
-			KEXEC_CRASH_HP_INVALID_CPU);
-		break;
-
-	case MEM_OFFLINE:
-		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
-			KEXEC_CRASH_HP_INVALID_CPU);
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block crash_memhp_nb = {
-	.notifier_call = crash_memhp_notifier,
-	.priority = 0
-};
-
-static int crash_cpuhp_online(unsigned int cpu)
-{
-	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
-	return 0;
-}
-
-static int crash_cpuhp_offline(unsigned int cpu)
-{
-	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
-	return 0;
-}
-
-static int __init crash_hotplug_init(void)
-{
-	int result = 0;
-
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		register_memory_notifier(&crash_memhp_nb);
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
-		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
-			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
-	}
-
-	return result;
-}
-
-subsys_initcall(crash_hotplug_init);
-#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..ec481e5a9330 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,8 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -49,6 +51,9 @@
 
 atomic_t __kexec_lock = ATOMIC_INIT(0);
 
+/* Per cpu memory for storing cpu states in case of system crash. */
+note_buf_t __percpu *crash_notes;
+
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
@@ -1082,6 +1087,189 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
 	return !res->end ? 0 : resource_size(res);
 }
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
+
+
 ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
@@ -1204,6 +1392,226 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 	final_note(buf);
 }
 
+static int __init crash_notes_memory_init(void)
+{
+	/* Allocate memory for saving cpu registers. */
+	size_t size, align;
+
+	/*
+	 * crash_notes could be allocated across 2 vmalloc pages when percpu
+	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
+	 * pages are also on 2 continuous physical pages. In this case the
+	 * 2nd part of crash_notes in 2nd page could be lost since only the
+	 * starting address and size of crash_notes are exported through sysfs.
+	 * Here round up the size of crash_notes to the nearest power of two
+	 * and pass it to __alloc_percpu as align value. This can make sure
+	 * crash_notes is allocated inside one physical page.
+	 */
+	size = sizeof(note_buf_t);
+	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
+
+	/*
+	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
+	 * definitely will be in 2 pages with that.
+	 */
+	BUILD_BUG_ON(size > PAGE_SIZE);
+
+	crash_notes = __alloc_percpu(size, align);
+	if (!crash_notes) {
+		pr_warn("Memory allocation for saving cpu register states failed\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+subsys_initcall(crash_notes_memory_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * Different than kexec/kdump loading/unloading/jumping/shrinking which
+ * usually rarely happen, there will be many crash hotplug events notified
+ * during one short period, e.g one memory board is hot added and memory
+ * regions are online. So mutex lock  __crash_hotplug_lock is used to
+ * serialize the crash hotplug handling specifically.
+ */
+DEFINE_MUTEX(__crash_hotplug_lock);
+#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
+#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	crash_hotplug_lock();
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+	crash_hotplug_unlock();
+
+	return rc;
+}
+
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	crash_hotplug_lock();
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+	crash_hotplug_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
+
 /*
  * Move into place and start executing a preloaded standalone
  * executable.  If nothing was preloaded return an error.
-- 
2.41.0


