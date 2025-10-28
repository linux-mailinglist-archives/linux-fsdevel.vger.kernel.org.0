Return-Path: <linux-fsdevel+bounces-65958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77939C17006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 22:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578A93BED8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3B358D14;
	Tue, 28 Oct 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4giIUTAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDA358D0F
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686779; cv=none; b=eQXUpJJ3oA639eQNL/9siuPttWpukNG+49vfrvLzHcA6C1+ILjPe8MBKorgEIfkS8gakx+tZ5UA2ECQUzxpnkQo95F4F14s5swLEpvTuxuLHmoYx6kky0P7F15aONdiWUpIb8ew1HJ/L74sZw0vKj0OipfQnAZglwcydc6KU5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686779; c=relaxed/simple;
	bh=8O5mYHptaqQBQe4yK2KIyzOFtSZyLkvvmfMFSG05Cvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7IRgSV76hCsuz908lINaJ/O+hGWNujL/u/JbkwscOtqqm+Z/q+z6CvaJnmY76ZikNSyNu4cMjEThv/zy0FgztItWJixtsDXdt6sKtpDbI/ZkXSiGJ7LqmI+/hWshl7Q6Jt1Jrmxxw3ACX+du9LX8Um8SQFfAOyfJclilYR2xGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4giIUTAT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290bd7c835dso61075595ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686777; x=1762291577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+j8zhoyklgSghm0fkzA4ZWTIhpnJZIgaxeAaI4yI5tk=;
        b=4giIUTATT9lHIIWknfySjFSpe7aodrWCr2Amd63eQvijeGcZdunt0kCVMkxGjiYoH4
         +awBaDvrsrdo3V8HZIkHydUle/TZpusd40bwaBI0KEag3tlnpXx75OdvUmgaKSvUM5to
         Lo1ck+T6KZ4KuOQPmoV7djPf2EHZ+Z40FvSMFYM6e/HC2KVqiVVW/2RCgtLmknCjoRv6
         KOTEvUVr/XAd1c2/TX9zrrKrZBfrr3E6zvoNd2Q7aXnMdcLVn7PwzkM4GyYW73jPru6a
         PJZvOT/qBXvu4vU7NquhFkGxrqEBHKU1YrWhLwsEgrcqcPIgIUNaVMBLsCAfs/PCU2xZ
         1juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686777; x=1762291577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+j8zhoyklgSghm0fkzA4ZWTIhpnJZIgaxeAaI4yI5tk=;
        b=v37IkoxzRwr8X/RssEh/wwkPh8vsjPPXg/biyjzGvGwMn5TdgSZREHztUGL1B/jp3w
         yklQozfePe0iTyFUGEtHwe5PF3190jWXApfMBYogLsg4yq9bDTuBqx5TylCkJ8vVHj4N
         X8MfDhV2hdW8wQgBUlK/OU+2KsUMZ3vcDZpTPnFZ9DVEaJENIBS+agxtKLimoCnd9UwH
         x0ZIbH+G693w0PQvjiPJiSqASXt3kgGRLFfBcvMjgwXUeM7fYnL3wzitKGQ+3b3s9h0m
         gwluEwf9vE04oiWTPeDjWosX1dXZ+5e1tU5gI2BHTxVb2uu3EXWAWlNEzKlhoa8Cb3oi
         OTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ty7ARGgNtFOMRBKCKuArDfANRU5DaKl1/+On+sF2Kue5MctXdebDIsVEuuXo5gnm7yVofZ572cNT+TRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZPPI5+8hfcShUESpAjcgkb8hprX95EdKGdWRt7OceX8zltXh
	PhO7Um/tt/SuWGFGNldGiR6Pvp8dTS25557rUTrGEpiIA3kXP4ulCZRMgBUVcWTtg5IYCU93Ymr
	ppbL3jhginlMZm3sslitU5G08Lg==
X-Google-Smtp-Source: AGHT+IGvJTcAodqjN68/cwhmvyNqJA89FwIXn0dFOb/T2m6hISvMSs8SoSnw6SBju5uM62L8KYA8GGXsErxvKEdp5A==
X-Received: from plow16.prod.google.com ([2002:a17:903:1b10:b0:290:9a4e:6b11])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f542:b0:267:9931:dbfb with SMTP id d9443c01a7336-294deedb108mr6935075ad.54.1761686776729;
 Tue, 28 Oct 2025 14:26:16 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:24:35 -0700
In-Reply-To: <20251028212528.681081-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212528.681081-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212528.681081-5-kaleshsingh@google.com>
Subject: [PATCH v4 4/5] mm: rename mm_struct::map_count to vma_count
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perform a mechanical rename of mm_struct->map_count to vma_count.

The name "map_count" is ambiguous. It can be confused with other counters
like the page mapcount (page->_mapcount), which tracks PTE references.

The new name, vma_count, is more precise and self-documenting, as this
field has always counted the number of vm_area_structs associated with
an mm_struct. This change improves code clarity and readability.

While at it, update the BUG_ON() in exit_mmap() to a WARN_ON_ONCE() to
avoid crashing the kernel on a simple accounting mismatch. No other
functional change is intended.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
 - Update the new max_vma_count_tests.c to use the vma_count name.

Changes in v3:
  - Change vma_count BUG_ON() in exit_mmap() to WARN_ON_ONCE,
    per David and Lorenzo
  - Collect Reviewed-by tags

 fs/binfmt_elf.c                               |  2 +-
 fs/coredump.c                                 |  2 +-
 include/linux/mm_types.h                      |  2 +-
 kernel/fork.c                                 |  2 +-
 mm/debug.c                                    |  2 +-
 mm/mmap.c                                     |  6 ++--
 mm/mremap.c                                   |  4 +--
 mm/nommu.c                                    |  8 ++---
 mm/vma.c                                      | 30 ++++++++---------
 .../selftests/mm/max_vma_count_tests.c        | 28 ++++++++--------
 tools/testing/vma/vma.c                       | 32 +++++++++----------
 tools/testing/vma/vma_internal.h              |  2 +-
 12 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e4653bb99946..a5acfe97612d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1660,7 +1660,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 	data[0] = count;
 	data[1] = PAGE_SIZE;
 	/*
-	 * Count usually is less than mm->map_count,
+	 * Count usually is less than mm->vma_count,
 	 * we need to move filenames down.
 	 */
 	n = cprm->vma_count - count;
diff --git a/fs/coredump.c b/fs/coredump.c
index b5fc06a092a4..5e0859813141 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1733,7 +1733,7 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 
 	cprm->vma_data_size = 0;
 	gate_vma = get_gate_vma(mm);
-	cprm->vma_count = mm->map_count + (gate_vma ? 1 : 0);
+	cprm->vma_count = mm->vma_count + (gate_vma ? 1 : 0);
 
 	cprm->vma_meta = kvmalloc_array(cprm->vma_count, sizeof(*cprm->vma_meta), GFP_KERNEL);
 	if (!cprm->vma_meta) {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5021047485a9..2a102f4899ed 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1085,7 +1085,7 @@ struct mm_struct {
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
-		int map_count;			/* number of VMAs */
+		int vma_count;			/* number of VMAs */
 
 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
diff --git a/kernel/fork.c b/kernel/fork.c
index dd0bb5fe4305..b2c2ca8a0a9d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1038,7 +1038,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm_pgtables_bytes_init(mm);
-	mm->map_count = 0;
+	mm->vma_count = 0;
 	mm->locked_vm = 0;
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
diff --git a/mm/debug.c b/mm/debug.c
index 64ddb0c4b4be..a35e2912ae53 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -204,7 +204,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
-		mm->map_count,
+		mm->vma_count,
 		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
 		(u64)atomic64_read(&mm->pinned_vm),
 		mm->data_vm, mm->exec_vm, mm->stack_vm,
diff --git a/mm/mmap.c b/mm/mmap.c
index 5a967a307099..647a676c0ab4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -383,7 +383,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * sysctl_max_map_count limit by one. This behavior is preserved to
 	 * avoid breaking existing applications.
 	 */
-	if (max_vma_count() - mm->map_count < 0)
+	if (max_vma_count() - mm->vma_count < 0)
 		return -ENOMEM;
 
 	/*
@@ -1314,7 +1314,7 @@ void exit_mmap(struct mm_struct *mm)
 		vma = vma_next(&vmi);
 	} while (vma && likely(!xa_is_zero(vma)));
 
-	BUG_ON(count != mm->map_count);
+	WARN_ON_ONCE(count != mm->vma_count);
 
 	trace_exit_mmap(mm);
 destroy:
@@ -1822,7 +1822,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 		 */
 		vma_iter_bulk_store(&vmi, tmp);
 
-		mm->map_count++;
+		mm->vma_count++;
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/mremap.c b/mm/mremap.c
index 02c38fd957e4..4874729cd65c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (max_vma_count() - current->mm->map_count < 4)
+	if (max_vma_count() - current->mm->vma_count < 4)
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
@@ -1814,7 +1814,7 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * the threshold. In other words, is the current map count + 6 at or
 	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if (max_vma_count() - current->mm->map_count < 6)
+	if (max_vma_count() - current->mm->vma_count < 6)
 		return -ENOMEM;
 
 	return 0;
diff --git a/mm/nommu.c b/mm/nommu.c
index ae2b20cc324a..ef05d5abbe9f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -577,7 +577,7 @@ static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *mm)
 
 static void cleanup_vma_from_mm(struct vm_area_struct *vma)
 {
-	vma->vm_mm->map_count--;
+	vma->vm_mm->vma_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
 		struct address_space *mapping;
@@ -1199,7 +1199,7 @@ unsigned long do_mmap(struct file *file,
 		goto error_just_free;
 
 	setup_vma_to_mm(vma, current->mm);
-	current->mm->map_count++;
+	current->mm->vma_count++;
 	/* add the VMA to the tree */
 	vma_iter_store_new(&vmi, vma);
 
@@ -1317,7 +1317,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	mm = vma->vm_mm;
-	if (max_vma_count() - mm->map_count < 1)
+	if (max_vma_count() - mm->vma_count < 1)
 		return -ENOMEM;
 
 	region = kmem_cache_alloc(vm_region_jar, GFP_KERNEL);
@@ -1367,7 +1367,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
 	vma_iter_store_new(vmi, new);
-	mm->map_count++;
+	mm->vma_count++;
 	return 0;
 
 err_vmi_preallocate:
diff --git a/mm/vma.c b/mm/vma.c
index 768d216beed3..fbb8d1a0449d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -354,7 +354,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * (it may either follow vma or precede it).
 		 */
 		vma_iter_store_new(vmi, vp->insert);
-		mm->map_count++;
+		mm->vma_count++;
 	}
 
 	if (vp->anon_vma) {
@@ -385,7 +385,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		}
 		if (vp->remove->anon_vma)
 			anon_vma_merge(vp->vma, vp->remove);
-		mm->map_count--;
+		mm->vma_count--;
 		mpol_put(vma_policy(vp->remove));
 		if (!vp->remove2)
 			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
@@ -594,7 +594,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (max_vma_count() - vma->vm_mm->map_count < 1)
+	if (max_vma_count() - vma->vm_mm->vma_count < 1)
 		return -ENOMEM;
 
 	return __split_vma(vmi, vma, addr, new_below);
@@ -685,13 +685,13 @@ void validate_mm(struct mm_struct *mm)
 		}
 #endif
 		/* Check for a infinite loop */
-		if (++i > mm->map_count + 10) {
+		if (++i > mm->vma_count + 10) {
 			i = -1;
 			break;
 		}
 	}
-	if (i != mm->map_count) {
-		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
+	if (i != mm->vma_count) {
+		pr_emerg("vma_count %d vma iterator %d\n", mm->vma_count, i);
 		bug = 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
@@ -1268,7 +1268,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct mm_struct *mm;
 
 	mm = current->mm;
-	mm->map_count -= vms->vma_count;
+	mm->vma_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
@@ -1342,14 +1342,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->start > vms->vma->vm_start) {
 
 		/*
-		 * Make sure that map_count on return from munmap() will
+		 * Make sure that vma_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    max_vma_count() - vms->vma->vm_mm->map_count < 1) {
+		    max_vma_count() - vms->vma->vm_mm->vma_count < 1) {
 			error = -ENOMEM;
-			goto map_count_exceeded;
+			goto vma_count_exceeded;
 		}
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
@@ -1463,7 +1463,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 modify_vma_failed:
 	reattach_vmas(mas_detach);
 start_split_failed:
-map_count_exceeded:
+vma_count_exceeded:
 	return error;
 }
 
@@ -1781,7 +1781,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	vma_start_write(vma);
 	vma_iter_store_new(&vmi, vma);
 	vma_link_file(vma, /* hold_rmap_lock= */false);
-	mm->map_count++;
+	mm->vma_count++;
 	validate_mm(mm);
 	return 0;
 }
@@ -2498,7 +2498,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
-	map->mm->map_count++;
+	map->mm->vma_count++;
 	vma_link_file(vma, map->hold_file_rmap_lock);
 
 	/*
@@ -2819,7 +2819,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * typically extends the existing brk VMA rather than creating a new one.
 	 * See also the comment in do_mmap().
 	 */
-	if (max_vma_count() - mm->map_count < 0)
+	if (max_vma_count() - mm->vma_count < 0)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
@@ -2857,7 +2857,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
 
-	mm->map_count++;
+	mm->vma_count++;
 	validate_mm(mm);
 out:
 	perf_event_mmap(vma);
diff --git a/tools/testing/selftests/mm/max_vma_count_tests.c b/tools/testing/selftests/mm/max_vma_count_tests.c
index e20cafaefc82..79404cb22df2 100644
--- a/tools/testing/selftests/mm/max_vma_count_tests.c
+++ b/tools/testing/selftests/mm/max_vma_count_tests.c
@@ -18,7 +18,7 @@
 #include "../kselftest_harness.h"
 #include "vm_util.h"
 
-#define DEFAULT_MAX_MAP_COUNT		65530
+#define DEFAULT_MAX_VMA_COUNT		65530
 #define TEST_AREA_NR_PAGES		3
 #define TEST_AREA_PROT			(PROT_NONE)
 #define EXTRA_MAP_PROT			(PROT_NONE)
@@ -42,9 +42,9 @@ static int get_max_vma_count(void);
 static bool set_max_vma_count(int val);
 static int get_current_vma_count(void);
 static bool is_test_area_mapped(char *test_area, int test_area_size);
-static bool lower_max_map_count_if_needed(max_vma_count_data_t *self,
+static bool lower_max_vma_count_if_needed(max_vma_count_data_t *self,
 					  struct __test_metadata *_metadata);
-static void restore_max_map_count_if_needed(max_vma_count_data_t *self,
+static void restore_max_vma_count_if_needed(max_vma_count_data_t *self,
 					    struct __test_metadata *_metadata);
 static bool free_vma_slots(max_vma_count_data_t *self, int slots_to_free);
 static void create_reservation(max_vma_count_data_t *self,
@@ -98,9 +98,9 @@ FIXTURE_SETUP(max_vma_count)
 
 	self->test_area_size = TEST_AREA_NR_PAGES * psize();
 
-	if (!lower_max_map_count_if_needed(self, _metadata)) {
+	if (!lower_max_vma_count_if_needed(self, _metadata)) {
 		SKIP(return,
-		     "max_map_count too high and cannot be lowered. Please rerun as root.");
+		     "max_vma_count too high and cannot be lowered. Please rerun as root.");
 	}
 
 	initial_vma_count = get_current_vma_count();
@@ -127,7 +127,7 @@ FIXTURE_TEARDOWN(max_vma_count)
 	 * mapping cleanup to process teardown for simplicity.
 	 */
 
-	restore_max_map_count_if_needed(self, _metadata);
+	restore_max_vma_count_if_needed(self, _metadata);
 }
 
 static bool mmap_anon(max_vma_count_data_t *self)
@@ -542,7 +542,7 @@ TEST_HARNESS_MAIN
 
 /* --- Utilities --- */
 
-static bool lower_max_map_count_if_needed(max_vma_count_data_t *self,
+static bool lower_max_vma_count_if_needed(max_vma_count_data_t *self,
 			      struct __test_metadata *_metadata)
 {
 	self->max_vma_count = get_max_vma_count();
@@ -550,19 +550,19 @@ static bool lower_max_map_count_if_needed(max_vma_count_data_t *self,
 	ASSERT_GT(self->max_vma_count, 0);
 
 	self->original_max_vma_count = 0;
-	if (self->max_vma_count > DEFAULT_MAX_MAP_COUNT) {
+	if (self->max_vma_count > DEFAULT_MAX_VMA_COUNT) {
 		self->original_max_vma_count = self->max_vma_count;
 		TH_LOG("Max VMA count: %d; lowering to default %d for test...",
-		       self->max_vma_count, DEFAULT_MAX_MAP_COUNT);
+		       self->max_vma_count, DEFAULT_MAX_VMA_COUNT);
 
-		if (!set_max_vma_count(DEFAULT_MAX_MAP_COUNT))
+		if (!set_max_vma_count(DEFAULT_MAX_VMA_COUNT))
 			return false;
-		self->max_vma_count = DEFAULT_MAX_MAP_COUNT;
+		self->max_vma_count = DEFAULT_MAX_VMA_COUNT;
 	}
 	return true;
 }
 
-static void restore_max_map_count_if_needed(max_vma_count_data_t *self,
+static void restore_max_vma_count_if_needed(max_vma_count_data_t *self,
 					    struct __test_metadata *_metadata)
 {
 	if (!self->original_max_vma_count)
@@ -572,7 +572,7 @@ static void restore_max_map_count_if_needed(max_vma_count_data_t *self,
 		return;
 
 	if (!set_max_vma_count(self->original_max_vma_count))
-		TH_LOG("Failed to restore max_map_count to %d",
+		TH_LOG("Failed to restore max_vma_count to %d",
 			self->original_max_vma_count);
 }
 
@@ -617,7 +617,7 @@ static int get_current_vma_count(void)
 
 		/*
 		 * The [vsyscall] mapping is a special mapping that
-		 * doesn't count against the max_map_count limit.
+		 * doesn't count against the max_vma_count limit.
 		 * Ignore it here to match the kernel's accounting.
 		 */
 		if (strcmp(vma_name, "[vsyscall]") != 0)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 656e1c75b711..69fa7d14a6c2 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -261,7 +261,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
 	}
 
 	mtree_destroy(&mm->mm_mt);
-	mm->map_count = 0;
+	mm->vma_count = 0;
 	return count;
 }
 
@@ -500,7 +500,7 @@ static bool test_merge_new(void)
 	INIT_LIST_HEAD(&vma_d->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_d.same_vma, &vma_d->anon_vma_chain);
 	ASSERT_FALSE(merged);
-	ASSERT_EQ(mm.map_count, 4);
+	ASSERT_EQ(mm.vma_count, 4);
 
 	/*
 	 * Merge BOTH sides.
@@ -519,7 +519,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 3);
+	ASSERT_EQ(mm.vma_count, 3);
 
 	/*
 	 * Merge to PREVIOUS VMA.
@@ -536,7 +536,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 3);
+	ASSERT_EQ(mm.vma_count, 3);
 
 	/*
 	 * Merge to NEXT VMA.
@@ -555,7 +555,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_pgoff, 6);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 3);
+	ASSERT_EQ(mm.vma_count, 3);
 
 	/*
 	 * Merge BOTH sides.
@@ -573,7 +573,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 2);
+	ASSERT_EQ(mm.vma_count, 2);
 
 	/*
 	 * Merge to NEXT VMA.
@@ -591,7 +591,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_pgoff, 0xa);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 2);
+	ASSERT_EQ(mm.vma_count, 2);
 
 	/*
 	 * Merge BOTH sides.
@@ -608,7 +608,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 1);
+	ASSERT_EQ(mm.vma_count, 1);
 
 	/*
 	 * Final state.
@@ -967,7 +967,7 @@ static bool test_vma_merge_new_with_close(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->vm_ops, &vm_ops);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 2);
+	ASSERT_EQ(mm.vma_count, 2);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
@@ -1017,7 +1017,7 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma->vm_pgoff, 2);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
-	ASSERT_EQ(mm.map_count, 2);
+	ASSERT_EQ(mm.vma_count, 2);
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1045,7 +1045,7 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_next->vm_pgoff, 2);
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
-	ASSERT_EQ(mm.map_count, 1);
+	ASSERT_EQ(mm.vma_count, 1);
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1079,7 +1079,7 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma->vm_pgoff, 6);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 2);
+	ASSERT_EQ(mm.vma_count, 2);
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1108,7 +1108,7 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
-	ASSERT_EQ(mm.map_count, 1);
+	ASSERT_EQ(mm.vma_count, 1);
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1138,7 +1138,7 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
-	ASSERT_EQ(mm.map_count, 1);
+	ASSERT_EQ(mm.vma_count, 1);
 
 	/* Clear down and reset. We should have deleted prev and next. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1540,7 +1540,7 @@ static bool test_merge_extend(void)
 	ASSERT_EQ(vma->vm_end, 0x4000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_TRUE(vma_write_started(vma));
-	ASSERT_EQ(mm.map_count, 1);
+	ASSERT_EQ(mm.vma_count, 1);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
@@ -1652,7 +1652,7 @@ static bool test_mmap_region_basic(void)
 			     0x24d, NULL);
 	ASSERT_EQ(addr, 0x24d000);
 
-	ASSERT_EQ(mm.map_count, 2);
+	ASSERT_EQ(mm.vma_count, 2);
 
 	for_each_vma(vmi, vma) {
 		if (vma->vm_start == 0x300000) {
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 41d354a699c5..d89b26e81679 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -261,7 +261,7 @@ typedef struct {
 
 struct mm_struct {
 	struct maple_tree mm_mt;
-	int map_count;			/* number of VMAs */
+	int vma_count;			/* number of VMAs */
 	unsigned long total_vm;	   /* Total pages mapped */
 	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
 	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
-- 
2.51.1.851.g4ebd6896fd-goog


