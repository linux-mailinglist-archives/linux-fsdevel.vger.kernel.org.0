Return-Path: <linux-fsdevel+bounces-56313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E6B1574B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624AA560E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DB1E3772;
	Wed, 30 Jul 2025 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwhsSKMK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8681E1DFE
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840458; cv=none; b=SGyT2iuimberWL4u7us9eJ1/8Ahut/aCz7jNHOhQqbjGrcu93mDTf6D0J9XFSLMFMh8epkA7E8xUyf6EkPtZwqTWSDiMOGpzfG3GuGRcRQ11K5rhQjsa0uRIbN7zIBz86P4m+EN+gCvzaNqSQejeB5UZK2stQNHfhWLfGcZLaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840458; c=relaxed/simple;
	bh=7e3OpqWPWrovTIJpnSCmdCWUz1qDuf3izIJGb+R4LV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKYQ82v+oRumS3yJJin+tQKHerxgNrU58RIq2SsdbMZpxPJ7BtABUoAgaJzNEwAzK0zg80ZuqDBo8OxZgX4iWwnQksp7xKdpe8U6LFp4o9djspFa2aUeW0eOvwFEvWlkGKQ7umeZ1X+Z3p6ewyDDXRM3JZjmDRGRMCL8wexa8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwhsSKMK; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-30561007a95so8550776fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840455; x=1754445255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lG4k0E4CvJtfx+IsGfUl62y++jeAVTOmiRug9CfZGl0=;
        b=GwhsSKMKH/tpM4qWkJLoDFh8KnHt1zTiXLKllRiBo4mKYO8kfq8t22yKgs7xsKv6d1
         OYC9m6bpDSU1yfC11ymmR0p8nR4mfbhL+/C3RxmBMcpw82IDwBE9l8c7dtDOBjFrnkue
         6pqQi1nYAu2ILzzuZUUdugFZcxYu0nxjejwlK2Xf4YmON07Xai9YPXHn6+wTgaEjkJpV
         dEOk5xZ1s3ZAgdJ23ijapMctomtdxnfRK+M55ZzMZ19ilGh9tbxcmuH7qV+acPUtEaX2
         kqkPeSctV30svfLJO4KN09dmBgYBl+f2mJaRkT9EMEFTENrZ1uZ7g4a6wkSR1W7DG0eq
         R0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840455; x=1754445255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG4k0E4CvJtfx+IsGfUl62y++jeAVTOmiRug9CfZGl0=;
        b=iTjz4YoZGFJ4Q0kxsUls5rl4DPIPotnuNwZ1pnY10WImgksnz4pkxG5knQ7M0IYcqw
         JC7xSXPLamn/8V4UuT4fhhMSACZAf+T/iX2JHI2UKw2jizy0uST7JtOAWoncoc706tEh
         WohHWZ33lh33qm5txOU71wOuYOkDzjKUM2K3L18gj16u/88IfZZy/LoJeKbYM+gSGTrF
         u609x9mCb9/lv1Whw+gawSWpAj6BDQNMw6qFtOYnqbDdrRzV2hr/TOcvL+rJy1TDCCbe
         3B+3/46oUz3JJ3Q+nzYhMKyzji1Sl9palHAKMFqSkTpLX9Vao1bxhIT4CAbSIY2g5JR/
         8N5A==
X-Forwarded-Encrypted: i=1; AJvYcCXASNjraqtzWZ6X7oZnvXQ/kRJ9sZWUgx/BeWIHFh64HgD/HdiDNQhSQNtyqwlTHKDzteT+IGvlEBCnJCfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ERzNHnu2yI9mOa4cYTJYJlmExj4I5A22g6FFWgv7fQjLb+SP
	xYzleTWc8RX+z5lk++0YO+lO2+HQFTF8z1zUudj/sPoT2hupZmA/QlY2mRkcgBKkn0JMPQnR5vG
	PJL5sy4B0VHieLKL/iI8uDR4MkUW01bIaLWXvRw==
X-Google-Smtp-Source: AGHT+IG0tvC5LDotzE4hH9WyIoOwyvYrs7/BCy1U6kv/3dvQVm9TUqS7tiYQoXt9Il79jT0w0iUThrNACbuA5DwzifKAIQ==
X-Received: from oabmj8.prod.google.com ([2002:a05:6870:d88:b0:2ff:c14c:6b8e])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:6c07:b0:296:b568:7901 with SMTP id 586e51a60fabf-30785a28004mr901771fac.16.1753840454698;
 Tue, 29 Jul 2025 18:54:14 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:53:59 -0700
In-Reply-To: <20250730015406.32569-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015406.32569-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015406.32569-2-isaacmanjarres@google.com>
Subject: [PATCH 5.10.y 1/4] mm: drop the assumption that VM_SHARED always
 implies writable
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andy Lutomirski <luto@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
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
[isaacmanjarres: resolved merge conflicts due to
due to refactoring that happened in upstream commit
5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")]
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/fs.h |  4 ++--
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      |  2 +-
 mm/filemap.c       |  2 +-
 mm/madvise.c       |  2 +-
 mm/mmap.c          |  6 +++---
 6 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9463dddce6bf..11294a89a53b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -436,7 +436,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @host: Owner, either the inode or the block_device.
  * @i_pages: Cached pages.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -535,7 +535,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e159a11424f1..2bedc9940c47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -666,6 +666,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
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
index 6ece27056fe9..cdf28ac44879 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -561,7 +561,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			if (tmp->vm_flags & VM_DENYWRITE)
 				put_write_access(inode);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				mapping_allow_writable(mapping);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/mm/filemap.c b/mm/filemap.c
index 3b0d8c6dd587..b98af5680bb9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2959,7 +2959,7 @@ int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index a63aa04ec7fa..370d0ef719eb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -848,7 +848,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index 8c188ed3738a..3cc0d56e41ad 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -144,7 +144,7 @@ static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 {
 	if (vma->vm_flags & VM_DENYWRITE)
 		allow_write_access(file);
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -663,7 +663,7 @@ static void __vma_link_file(struct vm_area_struct *vma)
 
 		if (vma->vm_flags & VM_DENYWRITE)
 			put_write_access(file_inode(file));
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(mapping);
 
 		flush_dcache_mmap_lock(mapping);
@@ -2942,7 +2942,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		return -EINVAL;
 
 	/* Map writable and ensure this isn't a sealed memfd. */
-	if (file && (vm_flags & VM_SHARED)) {
+	if (file && is_shared_maywrite(vm_flags)) {
 		int error = mapping_map_writable(file->f_mapping);
 
 		if (error)
-- 
2.50.1.552.g942d659e1b-goog


