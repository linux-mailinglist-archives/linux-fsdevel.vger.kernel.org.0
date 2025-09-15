Return-Path: <linux-fsdevel+bounces-61438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF5B58270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65573B778B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBE2727ED;
	Mon, 15 Sep 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwPWWf17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CB57C9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954801; cv=none; b=BBwGwA18lGXVhLvrGB4hD0/Pp67y9jgyChD2rwbDuuzJ15cyU0CuxSZDGjdOzf2YjhSadg2XcKWvHsAPTP4YpCraY7ZrCuLapZ2BLAbx+u9ZVLO15BUBVSLbN6ndvX2ACLTwcYXdjq3wzi9c2jyWHvWR/yguIlvLPkMFs9XKoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954801; c=relaxed/simple;
	bh=Wm5kVy+QK3aYdtcEt135qslNE4sqGTNT0KRjz0cm82A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GcPv5selo1Q2YZ5emv0wAx1pH+YIrQ6fZ+Mi/e7+0VFgLQAlnUFfp/op90ikgSmnFdUTIdr7IqJtdbssd+9vEGB41SzG27TkO0fy8vijvbP3hiK0KT5TXRPw1AXIyIg9gVKNP3AkvpCcBykNIGUu4RZza8AkGd/tI8nZombIHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwPWWf17; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24456ebed7bso58565935ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954799; x=1758559599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uec6c9hHTVF7EYZ252n3iiXGzXanDu3XqGzsoJcRFg=;
        b=cwPWWf178tua5mD0wIhxdd+PSC2PkLrO63zLECIDoL9b4rmjfWTzwozfE5hxw6EviN
         AQmObY1Zv2SzVDz4AUFdiBA4v5+RmQufRoNuGb+k17PUdymD1SJ6SfyDBJ6bxlJie9h7
         88OaLrSeATBJ3w162YyB603AGPujPcbM/BrohEFYI2ZDDdlc7VSuI02pvgn7n5jxo0MA
         VJ3M1GumJyB0ezDoyRbTRrG+hJ6873pJKZU2Tow0/Ht/7XghNjE3vskoSnm0xJ0fJQB+
         k9xevCPOEUyhZjI0vyUBzxO4VpqetyIzRhdXQDA06AUzDhxY+htNRJZ0eitLJfx49w5z
         acJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954799; x=1758559599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uec6c9hHTVF7EYZ252n3iiXGzXanDu3XqGzsoJcRFg=;
        b=SAEnl7Ik2hz+r7Sua/2ODsEgm0tGP5ygvzKDAZzR1DufSywQOdZPhHi7nGLvyl0jVc
         M4iYURa8WqytiAcWUzgAtDqUH6sAPLLcTIu4fwb5+EMA+O2QKA66wYuIsaJyU1Y2LM7r
         wWM04vx1VngBdL54APgqNMpv++h63bqNRWAKMgqFzETMk0RnwfE7UR7zfyvFGSXpQ4Qd
         85QjsAkMP61OEZ2TzFz5P+55+zAb1VDk3BOHLdxs1R81ISS7bI6VP1OIDGy2Kkineu1R
         OzilmQSnMuVGS0TzkVF6Jkwq1T8PqHxpvN9vbNwhMwjGUau5I26pnkVCUZ2nZmKkrJVw
         H6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9OjtY5XNF8m/3jJN54X5ubXa1dcYvhK/ivw+1lUUizVccY38e0h4AcPMoP5FH4KW/rzRjJsh73WId+79W@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp76hEZfeGZ9J3XvRNM2UA2hrgAyseX7wOaYBTtX8yJwrHwOzf
	ofrWK+9mtFqkK7JuKM+dEIDFIvDWAoAAQVFJy7xsRCnbTQ7Enay1QqmRomCh1RrDFiNwJtnMsx+
	1XHzthuoQd5ovb6TWUPsXFoC8gQ==
X-Google-Smtp-Source: AGHT+IE0Au7KtYKMn6v6+XfekUxenGOOYdpGtRed0ASYQgDdnt6D91OKFdMUEycPdM3BioeBGvXFHcpGg9KCP0jNrA==
X-Received: from plbmz4.prod.google.com ([2002:a17:903:3504:b0:266:c070:158d])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4ce:b0:25d:510:622c with SMTP id d9443c01a7336-25d2da0f07fmr167476645ad.28.1757954798904;
 Mon, 15 Sep 2025 09:46:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:35 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-5-kaleshsingh@google.com>
Subject: [PATCH v2 4/7] mm: rename mm_struct::map_count to vma_count
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A mechanical rename of the mm_struct->map_count field to
vma_count; no functional change is intended.

The name "map_count" is ambiguous within the memory management subsystem,
as it can be confused with the folio/page->_mapcount field, which tracks
PTE references.

The new name, vma_count, is more precise as this field has always
counted the number of vm_area_structs associated with an mm_struct.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

 Changes in v2:
  - map_count is easily confused with _mapcount rename to vma_count, per David

 fs/binfmt_elf.c                  |  2 +-
 fs/coredump.c                    |  2 +-
 include/linux/mm_types.h         |  2 +-
 kernel/fork.c                    |  2 +-
 mm/debug.c                       |  2 +-
 mm/mmap.c                        |  6 +++---
 mm/nommu.c                       |  6 +++---
 mm/vma.c                         | 24 ++++++++++++------------
 tools/testing/vma/vma.c          | 32 ++++++++++++++++----------------
 tools/testing/vma/vma_internal.h |  6 +++---
 10 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 264fba0d44bd..52449dec12cb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1643,7 +1643,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 	data[0] = count;
 	data[1] = PAGE_SIZE;
 	/*
-	 * Count usually is less than mm->map_count,
+	 * Count usually is less than mm->vma_count,
 	 * we need to move filenames down.
 	 */
 	n = cprm->vma_count - count;
diff --git a/fs/coredump.c b/fs/coredump.c
index 60bc9685e149..8881459c53d9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1731,7 +1731,7 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)

 	cprm->vma_data_size = 0;
 	gate_vma = get_gate_vma(mm);
-	cprm->vma_count = mm->map_count + (gate_vma ? 1 : 0);
+	cprm->vma_count = mm->vma_count + (gate_vma ? 1 : 0);

 	cprm->vma_meta = kvmalloc_array(cprm->vma_count, sizeof(*cprm->vma_meta), GFP_KERNEL);
 	if (!cprm->vma_meta) {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 08bc2442db93..4343be2f9e85 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1020,7 +1020,7 @@ struct mm_struct {
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
-		int map_count;			/* number of VMAs */
+		int vma_count;			/* number of VMAs */

 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
diff --git a/kernel/fork.c b/kernel/fork.c
index c4ada32598bd..8fcbbf947579 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1037,7 +1037,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm_pgtables_bytes_init(mm);
-	mm->map_count = 0;
+	mm->vma_count = 0;
 	mm->locked_vm = 0;
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
diff --git a/mm/debug.c b/mm/debug.c
index b4388f4dcd4d..40fc9425a84a 100644
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
index af88ce1fbb5f..c6769394a174 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1308,7 +1308,7 @@ void exit_mmap(struct mm_struct *mm)
 		vma = vma_next(&vmi);
 	} while (vma && likely(!xa_is_zero(vma)));
 
-	BUG_ON(count != mm->map_count);
+	BUG_ON(count != mm->vma_count);
 
 	trace_exit_mmap(mm);
 destroy:
@@ -1517,7 +1517,7 @@ static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
  */
 int vma_count_remaining(const struct mm_struct *mm)
 {
-	const int map_count = mm->map_count;
+	const int map_count = mm->vma_count;
 	const int max_count = sysctl_max_map_count;
 
 	return (max_count > map_count) ? (max_count - map_count) : 0;
@@ -1828,7 +1828,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 		 */
 		vma_iter_bulk_store(&vmi, tmp);
 
-		mm->map_count++;
+		mm->vma_count++;
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/nommu.c b/mm/nommu.c
index dd75f2334812..9ab2e5ca736d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -576,7 +576,7 @@ static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *mm)
 
 static void cleanup_vma_from_mm(struct vm_area_struct *vma)
 {
-	vma->vm_mm->map_count--;
+	vma->vm_mm->vma_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
 		struct address_space *mapping;
@@ -1198,7 +1198,7 @@ unsigned long do_mmap(struct file *file,
 		goto error_just_free;
 
 	setup_vma_to_mm(vma, current->mm);
-	current->mm->map_count++;
+	current->mm->vma_count++;
 	/* add the VMA to the tree */
 	vma_iter_store_new(&vmi, vma);
 
@@ -1366,7 +1366,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
 	vma_iter_store_new(vmi, new);
-	mm->map_count++;
+	mm->vma_count++;
 	return 0;
 
 err_vmi_preallocate:
diff --git a/mm/vma.c b/mm/vma.c
index df0e8409f63d..64f4e7c867c3 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -352,7 +352,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * (it may either follow vma or precede it).
 		 */
 		vma_iter_store_new(vmi, vp->insert);
-		mm->map_count++;
+		mm->vma_count++;
 	}
 
 	if (vp->anon_vma) {
@@ -383,7 +383,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		}
 		if (vp->remove->anon_vma)
 			anon_vma_merge(vp->vma, vp->remove);
-		mm->map_count--;
+		mm->vma_count--;
 		mpol_put(vma_policy(vp->remove));
 		if (!vp->remove2)
 			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
@@ -683,13 +683,13 @@ void validate_mm(struct mm_struct *mm)
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
@@ -1266,7 +1266,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct mm_struct *mm;
 
 	mm = current->mm;
-	mm->map_count -= vms->vma_count;
+	mm->vma_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
@@ -1340,14 +1340,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->start > vms->vma->vm_start) {

 		/*
-		 * Make sure that map_count on return from munmap() will
+		 * Make sure that vma_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
 		    !vma_count_remaining(vms->vma->vm_mm)) {
 			error = -ENOMEM;
-			goto map_count_exceeded;
+			goto vma_count_exceeded;
 		}
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
@@ -1461,7 +1461,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 modify_vma_failed:
 	reattach_vmas(mas_detach);
 start_split_failed:
-map_count_exceeded:
+vma_count_exceeded:
 	return error;
 }
 
@@ -1795,7 +1795,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	vma_start_write(vma);
 	vma_iter_store_new(&vmi, vma);
 	vma_link_file(vma);
-	mm->map_count++;
+	mm->vma_count++;
 	validate_mm(mm);
 	return 0;
 }
@@ -2495,7 +2495,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
-	map->mm->map_count++;
+	map->mm->vma_count++;
 	vma_link_file(vma);

 	/*
@@ -2810,7 +2810,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;

-	mm->map_count++;
+	mm->vma_count++;
 	validate_mm(mm);
 out:
 	perf_event_mmap(vma);
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
index 52cd7ddc73f4..15525b86145d 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -251,7 +251,7 @@ struct mutex {};

 struct mm_struct {
 	struct maple_tree mm_mt;
-	int map_count;			/* number of VMAs */
+	int vma_count;			/* number of VMAs */
 	unsigned long total_vm;	   /* Total pages mapped */
 	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
 	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
@@ -1520,10 +1520,10 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
 /* Helper to get VMA count capacity */
 static int vma_count_remaining(const struct mm_struct *mm)
 {
-	const int map_count = mm->map_count;
+	const int vma_count = mm->vma_count;
 	const int max_count = sysctl_max_map_count;

-	return (max_count > map_count) ? (max_count - map_count) : 0;
+	return (max_count > vma_count) ? (max_count - vma_count) : 0;
 }

 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0.384.g4c02a37b29-goog


