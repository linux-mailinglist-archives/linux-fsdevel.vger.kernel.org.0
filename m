Return-Path: <linux-fsdevel+bounces-56300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A2B156CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 02:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB4178AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86E218859B;
	Wed, 30 Jul 2025 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pN8gaGw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24E187554
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837118; cv=none; b=XUvLCSoD65XsWd4wGCm61EjI+UbstL75je0TzpPsimtOA32hNUc8PPI78xb3srKpBsRpPagpKH+L8r6Faf3S4xft5sloJ7kSaPP+uLByr+61XuFIBwYWqJG7ljmMGMvjKitnTbfSuSscmcSWXRXWC3XCn07zbFhKyKaxjMSXPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837118; c=relaxed/simple;
	bh=pcC7UYan9t6G5rTddrYrXXeusTE6A9iNrN8k35inOfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DgfO6wB31ySY01sqIGu0EVzJ66sL4MjehE/BMdGPrpLF5rJexke0Lru1Cxup5cDV8o7BN5O3dhH+9AU4sL45jWN2NaXav+3SOBNrFP8Y2S+kALYR1NrIhU7YUXykOD8oDkNMh8XIzGj8lf8u6g08LuhJk87rFWiInJZPqdsHqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pN8gaGw8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f112c90aso344697a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753837116; x=1754441916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05zj0+Q+MKMGwc697BcOisoUJr9tGqN15IKwcysHRAw=;
        b=pN8gaGw8sfjGDgIMFJyp50BvKcQzGc6yVFZyVtFVmDJgQVrOB9e5dV2DNtWr83o/lo
         o6tvNkm5/xCk84UKZ7BwejQ7/EDdAG+ELzXYMNgBQCzjXfuh0AcOY4MIseM1uaZ/2pPh
         AuHVrj59BW5SU/dWKsuCch/P/sstMzNH7+a/rjv3Lp8eM5vMEPeSzWekJxR9n8Cp5nV5
         hWN2LxqpbvzM/iVllProPvhFzN71ZfgaCClMQRTmIrbvNS9Vsj6/F6SsVasevnib67bW
         44Jqrb1TDYKCbsRf8OS+MtcRjQ21c6daulbrmZ8fvQqVqjGDYo+9hTMJJjrlOKyT9t8h
         YggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753837116; x=1754441916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05zj0+Q+MKMGwc697BcOisoUJr9tGqN15IKwcysHRAw=;
        b=r2Ib+bsZV5lbTW8kPyx1/oEuS3oqmmDRKSXAaBC7hIqG2M8aZUU0WTgaQ946bY3TH9
         gCT55bvtdjg/YBrQ5FRUF+4srnK8QrxdmnlkoWmBttiBl3mnITPCfu4ZBBqCisC8BkaU
         RnJawL7Ki47RCNBhNbnnQ+i0q3oJv+4vSPrw1+WOtrO4gHg0Y5FsRQHOxcpOmZJffBni
         +YkZ0DQkZNF5p7fWpjgDUDqhmpGP75BrnbwWdTDqzCmqTaJ2nHmqTbvZPLGd+M9fpWRV
         SPrt/0N9Gcrk2wDgMLXDYB+k7NuUqOYbHS1Sm/MpUVTp0xxHGYsEdXDCkrb44g5rd18e
         eHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0im9hFnc5hnk/Ggu/KM5h8tecOjyLfbzW1dQTn1Gy0/P/rZ/hcHt1/wZzv9TlOfpUmXc2hO7ydlA1NDtn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9m4nkgmjCVAsckABr792byfa5NvDwz59h6tTzMOfUWgSlRx6
	It8luRj65eN210+UiOqInRsaChyul+UxZOHkzfXk0LmcvB7PX1LkWFXnSmL+ncczAIiUVodRHRz
	ZUIvhsj5JcWCzBFfQTFS1qtU/pDD2uo6oVEdbMw==
X-Google-Smtp-Source: AGHT+IGWEjzOhQFYUAsEeOg6aONv1hOYMAFaYzjzUDUBEthSw7afXLd4o0cXyx997qVkvbfXma0R0HZEHo009a/07XIOQA==
X-Received: from pglf36.prod.google.com ([2002:a63:1024:0:b0:b42:c17:47ac])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210d:b0:225:9ac1:7c6b with SMTP id adf61e73a8af0-23dadafe765mr10380648637.4.1753837115424;
 Tue, 29 Jul 2025 17:58:35 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:58:06 -0700
In-Reply-To: <20250730005818.2793577-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730005818.2793577-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730005818.2793577-2-isaacmanjarres@google.com>
Subject: [PATCH 5.4.y 1/3] mm: drop the assumption that VM_SHARED always
 implies writable
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lstoakes@gmail.com>

[ Upstream commit e8e17ee90eaf650c855adb0a3e5e965fd6692ff1 ]

Patch series "permit write-sealed memfd read-only shared mappings", v4.

The man page for fcntl() describing memfd file seals states the following
about F_SEAL_WRITE:-

    Furthermore, trying to create new shared, writable memory-mappings via
    mmap(2) will also fail with EPERM.

With emphasis on 'writable'.  In turns out in fact that currently the
kernel simply disallows all new shared memory mappings for a memfd with
F_SEAL_WRITE applied, rendering this documentation inaccurate.

This matters because users are therefore unable to obtain a shared mapping
to a memfd after write sealing altogether, which limits their usefulness.
This was reported in the discussion thread [1] originating from a bug
report [2].

This is a product of both using the struct address_space->i_mmap_writable
atomic counter to determine whether writing may be permitted, and the
kernel adjusting this counter when any VM_SHARED mapping is performed and
more generally implicitly assuming VM_SHARED implies writable.

It seems sensible that we should only update this mapping if VM_MAYWRITE
is specified, i.e.  whether it is possible that this mapping could at any
point be written to.

If we do so then all we need to do to permit write seals to function as
documented is to clear VM_MAYWRITE when mapping read-only.  It turns out
this functionality already exists for F_SEAL_FUTURE_WRITE - we can
therefore simply adapt this logic to do the same for F_SEAL_WRITE.

We then hit a chicken and egg situation in mmap_region() where the check
for VM_MAYWRITE occurs before we are able to clear this flag.  To work
around this, perform this check after we invoke call_mmap(), with careful
consideration of error paths.

Thanks to Andy Lutomirski for the suggestion!

[1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
[2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238

This patch (of 3):

There is a general assumption that VMAs with the VM_SHARED flag set are
writable.  If the VM_MAYWRITE flag is not set, then this is simply not the
case.

Update those checks which affect the struct address_space->i_mmap_writable
field to explicitly test for this by introducing
[vma_]is_shared_maywrite() helper functions.

This remains entirely conservative, as the lack of VM_MAYWRITE guarantees
that the VMA cannot be written to.

Link: https://lkml.kernel.org/r/cover.1697116581.git.lstoakes@gmail.com
Link: https://lkml.kernel.org/r/d978aefefa83ec42d18dfa964ad180dbcde34795.1697116581.git.lstoakes@gmail.com
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/fs.h |  4 ++--
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      |  2 +-
 mm/filemap.c       |  2 +-
 mm/madvise.c       |  2 +-
 mm/mmap.c          | 10 +++++-----
 6 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d3648a55590c..c5985d72d60e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -430,7 +430,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @host: Owner, either the inode or the block_device.
  * @i_pages: Cached pages.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -553,7 +553,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap_pgoff
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap_pgoff
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d3657b630db..47d56c96447a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -549,6 +549,17 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
 	return !vma->vm_ops;
 }
 
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/kernel/fork.c b/kernel/fork.c
index e71f96bff1dc..ad3e6e91d828 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -566,7 +566,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			if (tmp->vm_flags & VM_DENYWRITE)
 				atomic_dec(&inode->i_writecount);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				atomic_inc(&mapping->i_mmap_writable);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/mm/filemap.c b/mm/filemap.c
index f1ed0400c37c..af3efb23262b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2876,7 +2876,7 @@ int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index ac8d68c488b5..3f5331c96ad5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -839,7 +839,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index eeebbb20accf..cb712ae731cd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -141,7 +141,7 @@ static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 {
 	if (vma->vm_flags & VM_DENYWRITE)
 		atomic_inc(&file_inode(file)->i_writecount);
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -619,7 +619,7 @@ static void __vma_link_file(struct vm_area_struct *vma)
 
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file_inode(file)->i_writecount);
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			atomic_inc(&mapping->i_mmap_writable);
 
 		flush_dcache_mmap_lock(mapping);
@@ -1785,7 +1785,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			if (error)
 				goto free_vma;
 		}
-		if (vm_flags & VM_SHARED) {
+		if (is_shared_maywrite(vm_flags)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
 				goto allow_write_and_free_vma;
@@ -1823,7 +1823,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
-		if (vm_flags & VM_SHARED)
+		if (is_shared_maywrite(vm_flags))
 			mapping_unmap_writable(file->f_mapping);
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
@@ -1864,7 +1864,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
+	if (is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 allow_write_and_free_vma:
 	if (vm_flags & VM_DENYWRITE)
-- 
2.50.1.552.g942d659e1b-goog


