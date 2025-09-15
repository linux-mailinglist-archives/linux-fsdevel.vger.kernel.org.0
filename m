Return-Path: <linux-fsdevel+bounces-61439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C50B58278
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A311A20841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A9288C3B;
	Mon, 15 Sep 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUADRP39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E7284888
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954817; cv=none; b=PyVFvG7fYkB1ZBNsSxTFp9ZjIU9Y8rQ/YTZYvYokTT2YKMsTbO6hdfhZ8pyp7qNqFJDOVcaGIg5H5apqDEUlMXFzVW98+lKat+Ximx1fRKw8B5L3W5VbpdZmYTnwRVRlfUqKUKbHr/d7eJ5Hfrmbl0sl1FyrY0ua8adB7UHCwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954817; c=relaxed/simple;
	bh=mxgSbuM3vTGaiZBQ17HgKAaGLPJx9xqthCVW+1kVVoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nRp7skZwaMUzxk88WJi7YgOmdHEIJLzDSTpDlriKcP8fVp8xX5u4NkfmvOTRTuI87FtG+igBMRzfoKU4kG7q96S2ZipllKkcvb9nXwkpAo3M3zI0GEZjoFpe/jlQRCekVOO+r3INtahuD1A9BSBEEuJhwteEw3oC4hWTfq/NAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUADRP39; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b522c35db5fso2928035a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954814; x=1758559614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbJK8pWy0CZE0crqWikRoe+l2baB0Rx7jlgQSj60pLY=;
        b=LUADRP39biqSf8B0SAW3o65iokIzW92ZpxTMwpe6NSdZohY2MnahdT5A3GLorR8Xg1
         KLmJ5EFJkLu75AW6Qhmbr3H6iFZ6FrvKVNPAaCbory4+DDebrUf2hLvg750OVAA4uRAo
         7Bn6QPs8w9NVJq8J10Nx7fHJHm8XybkL7FHuzSAHosanrAXqc9FtsU862jxhUWR7Ao61
         PHN7bU6Ah6uwG8YWcEssZusKB1mXeGdS4Elx9oia0O/NONZl7fyMVpK3YRpL7Lxzwtk4
         q8UPl58h1/LpPKKlRC4eSEfWS99GPG9tmok1p3QSfV3bCsbKprI52gSb97GKe1+4r3J8
         J8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954814; x=1758559614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbJK8pWy0CZE0crqWikRoe+l2baB0Rx7jlgQSj60pLY=;
        b=nfMHAT+RHh9cqMBgeKcTdsk2aIdDXS161uKNTlRnN1KEQriUCbLvWBVtipZxmODbGC
         MFWdlZDmLba3QWK37p8i30oeYMnFdpDhDAYBu+6tJw9URjefIECat0ikIYnrr2J94Wzb
         poIbLXykRJqEQMCdJWz3/tdd1jAE7eDfn0Vtyo9dKWtq8J9ARrqpvRC658Z+YtFwmmSz
         jkEzVIEVqK6xqaz/yHOIwXOI/Qrj+S6OzI4gLNL1TfQFJdG+v85srTrKzRIKcQCKnzrt
         Yc8jR/SKUq3oHjaIyCQqvvNmOj9wJfg7iKiyD96SH3PJTHWJAZnMjdfGKddaW+FzD/az
         7bUg==
X-Forwarded-Encrypted: i=1; AJvYcCVbToWBhsTj84rz3us91gIh0GBxf+KQGAnZr+VNgWwTi+tkKDE/JtKAyzzFHD8OKEbHJycAmx8pTbHTRxh0@vger.kernel.org
X-Gm-Message-State: AOJu0YyTm4ov5yjVHOU35DiVQSnZuwdGgjx0k4ESMUe/jcV/2vf+zUY+
	z6H3W9xetLwTRf+WNTdCqk4GmD7Wf3AqsbfmgbjLXz29gY+7pIYkO0tiyLvA5nzZT3QGD12KM++
	P0qgJFMUDxp1rWcys2zgDQe3wgw==
X-Google-Smtp-Source: AGHT+IFj2fssKhkti4Yi38ezbH/JI+2/57SQchOc8iv6dsxeJ23DL0meIXHXVVhUOdfHhPdiopD3vNalm3MQQmXFcA==
X-Received: from pleg2.prod.google.com ([2002:a17:902:e382:b0:25d:f53e:e5a4])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b4c:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-25d26077175mr169658175ad.31.1757954814330;
 Mon, 15 Sep 2025 09:46:54 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:36 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-6-kaleshsingh@google.com>
Subject: [PATCH v2 5/7] mm: harden vma_count against direct modification
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

To make VMA counting more robust, prevent direct modification of the
mm->vma_count field. This is achieved by making the public-facing
member const via a union and requiring all modifications to go
through a new set of helper functions the operate on a private
__vma_count.

While there are no other invariants tied to vma_count currently, this
structural change improves maintainability; as it creates a single,
centralized point for any future logic, such as adding debug checks
or updating related statistics (in subsequent patches).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/mm.h               | 25 +++++++++++++++++++++++++
 include/linux/mm_types.h         |  5 ++++-
 kernel/fork.c                    |  2 +-
 mm/mmap.c                        |  2 +-
 mm/vma.c                         | 12 ++++++------
 tools/testing/vma/vma.c          |  2 +-
 tools/testing/vma/vma_internal.h | 30 +++++++++++++++++++++++++++++-
 7 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 138bab2988f8..8bad1454984c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4219,4 +4219,29 @@ static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)

 void snapshot_page(struct page_snapshot *ps, const struct page *page);

+static inline void vma_count_init(struct mm_struct *mm)
+{
+	ACCESS_PRIVATE(mm, __vma_count) = 0;
+}
+
+static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
+{
+	ACCESS_PRIVATE(mm, __vma_count) += nr_vmas;
+}
+
+static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
+{
+	vma_count_add(mm, -nr_vmas);
+}
+
+static inline void vma_count_inc(struct mm_struct *mm)
+{
+	vma_count_add(mm, 1);
+}
+
+static inline void vma_count_dec(struct mm_struct *mm)
+{
+	vma_count_sub(mm, 1);
+}
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4343be2f9e85..2ea8fc722aa2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1020,7 +1020,10 @@ struct mm_struct {
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
-		int vma_count;			/* number of VMAs */
+		union {
+			const int vma_count;		/* number of VMAs */
+			int __private __vma_count;
+		};

 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
diff --git a/kernel/fork.c b/kernel/fork.c
index 8fcbbf947579..ea9eff416e51 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1037,7 +1037,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm_pgtables_bytes_init(mm);
-	mm->vma_count = 0;
+	vma_count_init(mm);
 	mm->locked_vm = 0;
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
diff --git a/mm/mmap.c b/mm/mmap.c
index c6769394a174..30ddd550197e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1828,7 +1828,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 		 */
 		vma_iter_bulk_store(&vmi, tmp);
 
-		mm->vma_count++;
+		vma_count_inc(mm);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/vma.c b/mm/vma.c
index 64f4e7c867c3..0cd3cb472220 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -352,7 +352,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * (it may either follow vma or precede it).
 		 */
 		vma_iter_store_new(vmi, vp->insert);
-		mm->vma_count++;
+		vma_count_inc(mm);
 	}
 
 	if (vp->anon_vma) {
@@ -383,7 +383,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		}
 		if (vp->remove->anon_vma)
 			anon_vma_merge(vp->vma, vp->remove);
-		mm->vma_count--;
+		vma_count_dec(mm);
 		mpol_put(vma_policy(vp->remove));
 		if (!vp->remove2)
 			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
@@ -1266,7 +1266,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct mm_struct *mm;
 
 	mm = current->mm;
-	mm->vma_count -= vms->vma_count;
+	vma_count_sub(mm, vms->vma_count);
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
@@ -1795,7 +1795,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	vma_start_write(vma);
 	vma_iter_store_new(&vmi, vma);
 	vma_link_file(vma);
-	mm->vma_count++;
+	vma_count_inc(mm);
 	validate_mm(mm);
 	return 0;
 }
@@ -2495,7 +2495,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
-	map->mm->vma_count++;
+	vma_count_inc(map->mm);
 	vma_link_file(vma);
 
 	/*
@@ -2810,7 +2810,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
 
-	mm->vma_count++;
+	vma_count_inc(mm);
 	validate_mm(mm);
 out:
 	perf_event_mmap(vma);
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 69fa7d14a6c2..ee5a1e2365e0 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -261,7 +261,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
 	}
 
 	mtree_destroy(&mm->mm_mt);
-	mm->vma_count = 0;
+	vma_count_init(mm);
 	return count;
 }
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 15525b86145d..6e724ba1adf4 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -251,7 +251,10 @@ struct mutex {};
 
 struct mm_struct {
 	struct maple_tree mm_mt;
-	int vma_count;			/* number of VMAs */
+	union {
+		const int vma_count;		/* number of VMAs */
+		int __vma_count;
+	};
 	unsigned long total_vm;	   /* Total pages mapped */
 	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
 	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
@@ -1526,4 +1529,29 @@ static int vma_count_remaining(const struct mm_struct *mm)
 	return (max_count > vma_count) ? (max_count - vma_count) : 0;
 }
 
+static inline void vma_count_init(struct mm_struct *mm)
+{
+	mm->__vma_count = 0;
+}
+
+static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
+{
+	mm->__vma_count += nr_vmas;
+}
+
+static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
+{
+	vma_count_add(mm, -nr_vmas);
+}
+
+static inline void vma_count_inc(struct mm_struct *mm)
+{
+	vma_count_add(mm, 1);
+}
+
+static inline void vma_count_dec(struct mm_struct *mm)
+{
+	vma_count_sub(mm, 1);
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0.384.g4c02a37b29-goog


