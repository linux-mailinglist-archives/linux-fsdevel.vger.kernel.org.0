Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E23F9FF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhH0TUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhH0TUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:20:30 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B59C06124C
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:19:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j11-20020a0cf9cb000000b00375f0642d2dso141565qvo.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h6rO3EhHNNFkOGFC1QBuBIktP4uiheREsetuLrE0mas=;
        b=SfWTdZnZoEs/+lLm00I5gLoulDxOn1fXjXO0E5IIi1afYvpHo3zBWGy/CqsTMGxACM
         E3IWLuziyXsUqX1nr9RwEE9kMVMZZh2JvrKOU6TpwqVoArVR7BLJG6fqMTn8hs+/oWXW
         lJ80GqO7xFSTkCvBMBfber5ujyxQhkUSmOXb3HyJUsxK7DcY03cDBXL0yWHIyL23odxT
         9XW4ILVhxfAngNhO9DEBrA9SkCbZQGt/4jq1Izd58MfwLtzsKGhh++QYPvDRWx1MyRwz
         a7ihUM3SQL2GY/V4h69Py2Xkp6FMPfhE55jbm13lcZPxluf9sU2MbKgYdQsjwWpFJvkK
         0JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h6rO3EhHNNFkOGFC1QBuBIktP4uiheREsetuLrE0mas=;
        b=SwgVnfMefLKLBcR2qzwkQuAEQC2UhyVGkL/bjhAJ2GO9x4yO4Qyh4CimiN/G84zLvL
         q0OvXkX41nArI190pBcluBPFxG/Dc1tudS4/Fnq7YU/bsUGURA1tIEOuJ2X8w3UbZ9fB
         qiCTn3WwlWZaMX8T/KE4VFuf/SOnww8PeNZxhyv114GhP1NEVfadVoceIEWkLf62kWnJ
         IbvCJ9D7fwYteXxKmdtYTGcQT0TmKvA5okA2qqnIQcuSS3dsPgq5t86g9qNyMU8VdF9U
         EwzOPjnNBDNzvdsQO74BI55/54/T5qVI9Yg9eUbanH7UTmN3nuMPJbnyKHuc4sltmAUJ
         Rvvg==
X-Gm-Message-State: AOAM531vMn4f7gVTkMpwyx9eBgqoQ7B4jwXWbpdes8XCZqtaM6J7a/iy
        og/UPhSmOHzWOoCuvB9FKPcgF8cWdQ0=
X-Google-Smtp-Source: ABdhPJzQc6Q/uj1nznzYASgRtCGmMi4LFyP+LXHElMFzzUqJGPvP31PT+8lURuIIP93k5/RyAgq+IhQf7Uc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:fd8e:f32b:a64b:dd89])
 (user=surenb job=sendgmr) by 2002:a05:6214:1366:: with SMTP id
 c6mr8066321qvw.30.1630091950697; Fri, 27 Aug 2021 12:19:10 -0700 (PDT)
Date:   Fri, 27 Aug 2021 12:18:57 -0700
In-Reply-To: <20210827191858.2037087-1-surenb@google.com>
Message-Id: <20210827191858.2037087-3-surenb@google.com>
Mime-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v8 2/3] mm: add a field to store names for private anonymous memory
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Cross <ccross@google.com>

In many userspace applications, and especially in VM based applications
like Android uses heavily, there are multiple different allocators in use.
 At a minimum there is libc malloc and the stack, and in many cases there
are libc malloc, the stack, direct syscalls to mmap anonymous memory, and
multiple VM heaps (one for small objects, one for big objects, etc.).
Each of these layers usually has its own tools to inspect its usage;
malloc by compiling a debug version, the VM through heap inspection tools,
and for direct syscalls there is usually no way to track them.

On Android we heavily use a set of tools that use an extended version of
the logic covered in Documentation/vm/pagemap.txt to walk all pages mapped
in userspace and slice their usage by process, shared (COW) vs.  unique
mappings, backing, etc.  This can account for real physical memory usage
even in cases like fork without exec (which Android uses heavily to share
as many private COW pages as possible between processes), Kernel SamePage
Merging, and clean zero pages.  It produces a measurement of the pages
that only exist in that process (USS, for unique), and a measurement of
the physical memory usage of that process with the cost of shared pages
being evenly split between processes that share them (PSS).

If all anonymous memory is indistinguishable then figuring out the real
physical memory usage (PSS) of each heap requires either a pagemap walking
tool that can understand the heap debugging of every layer, or for every
layer's heap debugging tools to implement the pagemap walking logic, in
which case it is hard to get a consistent view of memory across the whole
system.

Tracking the information in userspace leads to all sorts of problems.
It either needs to be stored inside the process, which means every
process has to have an API to export its current heap information upon
request, or it has to be stored externally in a filesystem that
somebody needs to clean up on crashes.  It needs to be readable while
the process is still running, so it has to have some sort of
synchronization with every layer of userspace.  Efficiently tracking
the ranges requires reimplementing something like the kernel vma
trees, and linking to it from every layer of userspace.  It requires
more memory, more syscalls, more runtime cost, and more complexity to
separately track regions that the kernel is already tracking.

This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show a
userspace-provided name for anonymous vmas.  The names of named anonymous
vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>].

Userspace can set the name for a region of memory by calling
prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)name);
Setting the name to NULL clears it. The name length limit is 64 bytes
including NUL-terminator (to have some reasonable limit and because the
longest name used in Android has 50 chars) and is checked to contain only
printable characters.

The name is stored in a pointer in the shared union in vm_area_struct
that points to a null terminated string. Anonymous vmas with the same
name (equivalent strings) and are otherwise mergeable will be merged.
The name pointers are not shared between vmas even if they contain the
same name. The name pointer is stored in a union with fields that are
only used on file-backed mappings, so it does not increase memory usage.

The patch is based on the original patch developed by Colin Cross, more
specifically on its latest version [1] posted upstream by Sumit Semwal.
It used a userspace pointer to store vma names. In that design, name
pointers could be shared between vmas. However during the last upstreaming
attempt, Kees Cook raised concerns [2] about this approach and suggested
to copy the name into kernel memory space, perform validity checks [3]
and store as a string referenced from vm_area_struct.
One big concern is about fork() performance which would need to strdup
anonymous vma names. Dave Hansen suggested experimenting with worst-case
scenario of forking a process with 64k vmas having longest possible names
[4]. I ran this experiment on an ARM64 Android device and recorded a
worst-case regression of almost 40% when forking such a process. This
regression is addressed in the followup patch which replaces the pointer
to a name with a refcounted structure that allows sharing the name pointer
between vmas of the same name. Instead of duplicating the string during
fork() or when splitting a vma it increments the refcount.

[1] https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.semwal@linaro.org/
[2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
[3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook/
[4] https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a8e95@intel.com/

Signed-off-by: Colin Cross <ccross@google.com>
[surenb: rebased over v5.14-rc7, replaced userpointer with a kernel copy
and added input sanitization. The bulk of the work here was done by Colin
Cross, therefore, with his permission, keeping him as the author]
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/filesystems/proc.rst |   2 +
 fs/proc/task_mmu.c                 |  14 +++-
 fs/userfaultfd.c                   |   7 +-
 include/linux/mm.h                 |  13 +++-
 include/linux/mm_types.h           |  48 +++++++++++--
 include/uapi/linux/prctl.h         |   3 +
 kernel/fork.c                      |   2 +
 kernel/sys.c                       |  48 +++++++++++++
 mm/madvise.c                       | 112 +++++++++++++++++++++++++++--
 mm/mempolicy.c                     |   3 +-
 mm/mlock.c                         |   2 +-
 mm/mmap.c                          |  38 +++++-----
 mm/mprotect.c                      |   2 +-
 13 files changed, 261 insertions(+), 33 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 042c418f4090..a067eec54ef1 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -431,6 +431,8 @@ is not associated with a file:
  [stack]                    the stack of the main process
  [vdso]                     the "virtual dynamic shared object",
                             the kernel system call handler
+[anon:<name>]               an anonymous mapping that has been
+                            named by userspace
  =======                    ====================================
 
  or if empty, the mapping is anonymous.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..2ce5b3c4e7fc 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -308,6 +308,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 
 	name = arch_vma_name(vma);
 	if (!name) {
+		const char *anon_name;
+
 		if (!mm) {
 			name = "[vdso]";
 			goto done;
@@ -319,8 +321,18 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 			goto done;
 		}
 
-		if (is_stack(vma))
+		if (is_stack(vma)) {
 			name = "[stack]";
+			goto done;
+		}
+
+		anon_name = vma_anon_name(vma);
+		if (anon_name) {
+			seq_pad(m, ' ');
+			seq_puts(m, "[anon:");
+			seq_write(m, anon_name, strlen(anon_name));
+			seq_putc(m, ']');
+		}
 	}
 
 done:
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5c2d806e6ae5..5057843fb71a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -876,7 +876,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX);
+				 NULL_VM_UFFD_CTX, vma_anon_name(vma));
 		if (prev)
 			vma = prev;
 		else
@@ -1440,7 +1440,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 ((struct vm_userfaultfd_ctx){ ctx }));
+				 ((struct vm_userfaultfd_ctx){ ctx }),
+				 vma_anon_name(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
@@ -1617,7 +1618,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX);
+				 NULL_VM_UFFD_CTX, vma_anon_name(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..45c003fae7fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2548,7 +2548,7 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 extern struct vm_area_struct *vma_merge(struct mm_struct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx);
+	struct mempolicy *, struct vm_userfaultfd_ctx, const char *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
@@ -3283,5 +3283,16 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+#ifdef CONFIG_ADVISE_SYSCALLS
+int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
+			  unsigned long len_in, const char *name);
+#else
+static inline int
+madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
+		      unsigned long len_in, const char *name) {
+	return 0;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 52bbd2b7cb46..26a30f7a5228 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -342,11 +342,19 @@ struct vm_area_struct {
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
+	 *
+	 * For private anonymous mappings, a pointer to a null terminated string
+	 * containing the name given to the vma, or NULL if unnamed.
 	 */
-	struct {
-		struct rb_node rb;
-		unsigned long rb_subtree_last;
-	} shared;
+
+	union {
+		struct {
+			struct rb_node rb;
+			unsigned long rb_subtree_last;
+		} shared;
+		/* Serialized by mmap_sem. */
+		char *anon_name;
+	};
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -801,4 +809,36 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/*
+ * mmap_lock should be read-locked when calling vma_anon_name() and while using
+ * the returned pointer.
+ */
+extern const char *vma_anon_name(struct vm_area_struct *vma);
+
+/*
+ * mmap_lock should be read-locked for orig_vma->vm_mm.
+ * mmap_lock should be write-locked for new_vma->vm_mm or new_vma should be
+ * isolated.
+ */
+extern void dup_vma_anon_name(struct vm_area_struct *orig_vma,
+			      struct vm_area_struct *new_vma);
+
+/*
+ * mmap_lock should be write-locked or vma should have been isolated under
+ * write-locked mmap_lock protection.
+ */
+extern void free_vma_anon_name(struct vm_area_struct *vma);
+
+/* mmap_lock should be read-locked */
+static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
+					 const char *name)
+{
+	const char *vma_name = vma_anon_name(vma);
+
+	if (likely(!vma_name))
+		return name == NULL;
+
+	return name && !strcmp(name, vma_name);
+}
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 967d9c55323d..968582cd91b5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -267,4 +267,7 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+#define PR_SET_VMA		0x53564d41
+# define PR_SET_VMA_ANON_NAME		0
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 44f4c2d83763..e086f56a4628 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -366,12 +366,14 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		new->vm_next = new->vm_prev = NULL;
+		dup_vma_anon_name(orig, new);
 	}
 	return new;
 }
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	free_vma_anon_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index ef1a78f5d71c..c48267a8b857 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2298,6 +2298,51 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
+#ifdef CONFIG_MMU
+
+#define ANON_VMA_NAME_MAX_LEN	64
+
+static int prctl_set_vma(unsigned long opt, unsigned long addr,
+			 unsigned long size, unsigned long arg)
+{
+	struct mm_struct *mm = current->mm;
+	char *name, *pch;
+	int error;
+
+	switch (opt) {
+	case PR_SET_VMA_ANON_NAME:
+		name = strndup_user((const char __user *)arg,
+				    ANON_VMA_NAME_MAX_LEN);
+
+		if (IS_ERR(name))
+			return PTR_ERR(name);
+
+		for (pch = name; *pch != '\0'; pch++) {
+			if (!isprint(*pch)) {
+				kfree(name);
+				return -EINVAL;
+			}
+		}
+
+		mmap_write_lock(mm);
+		error = madvise_set_anon_name(mm, addr, size, name);
+		mmap_write_unlock(mm);
+		kfree(name);
+		break;
+	default:
+		error = -EINVAL;
+	}
+
+	return error;
+}
+#else /* CONFIG_MMU */
+static int prctl_set_vma(unsigned long opt, unsigned long start,
+			 unsigned long size, unsigned long arg)
+{
+	return -EINVAL;
+}
+#endif
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2567,6 +2612,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_SET_VMA:
+		error = prctl_set_vma(arg2, arg3, arg4, arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/mm/madvise.c b/mm/madvise.c
index 359cd3fa612c..bc029f3fca6a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -18,6 +18,7 @@
 #include <linux/fadvise.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
 #include <linux/fs.h>
@@ -62,19 +63,74 @@ static int madvise_need_mmap_write(int behavior)
 	}
 }
 
+static inline bool has_vma_anon_name(struct vm_area_struct *vma)
+{
+	return !vma->vm_file && vma->anon_name;
+}
+
+const char *vma_anon_name(struct vm_area_struct *vma)
+{
+	if (!has_vma_anon_name(vma))
+		return NULL;
+
+	mmap_assert_locked(vma->vm_mm);
+
+	return vma->anon_name;
+}
+
+void dup_vma_anon_name(struct vm_area_struct *orig_vma,
+		       struct vm_area_struct *new_vma)
+{
+	if (!has_vma_anon_name(orig_vma))
+		return;
+
+	new_vma->anon_name = kstrdup(orig_vma->anon_name, GFP_KERNEL);
+}
+
+void free_vma_anon_name(struct vm_area_struct *vma)
+{
+	if (!has_vma_anon_name(vma))
+		return;
+
+	kfree(vma->anon_name);
+	vma->anon_name = NULL;
+}
+
+/* mmap_lock should be write-locked */
+static void replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
+{
+	if (!name) {
+		free_vma_anon_name(vma);
+		return;
+	}
+
+	if (vma->anon_name) {
+		/* Should never happen, to dup use dup_vma_anon_name() */
+		WARN_ON(vma->anon_name == name);
+
+		/* Same name, nothing to do here */
+		if (!strcmp(name, vma->anon_name))
+			return;
+
+		free_vma_anon_name(vma);
+	}
+	vma->anon_name = kstrdup(name, GFP_KERNEL);
+}
+
 /*
- * Update the vm_flags on regiion of a vma, splitting it or merging it as
+ * Update the vm_flags on region of a vma, splitting it or merging it as
  * necessary.  Must be called with mmap_sem held for writing;
  */
 static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct vm_area_struct **prev, unsigned long start,
-			      unsigned long end, unsigned long new_flags)
+			      unsigned long end, unsigned long new_flags,
+			      const char *name)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
 
-	if (new_flags == vma->vm_flags) {
+	if (new_flags == vma->vm_flags && is_same_vma_anon_name(vma, name)) {
 		*prev = vma;
 		return 0;
 	}
@@ -82,7 +138,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx);
+			  vma->vm_userfaultfd_ctx, name);
 	if (*prev) {
 		vma = *prev;
 		goto success;
@@ -115,10 +171,30 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	 * vm_flags is protected by the mmap_lock held in write mode.
 	 */
 	vma->vm_flags = new_flags;
+	if (!vma->vm_file)
+		replace_vma_anon_name(vma, name);
 
 	return 0;
 }
 
+static int madvise_vma_anon_name(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end,
+				 unsigned long name)
+{
+	int error;
+
+	/* Only anonymous mappings can be named */
+	if (vma->vm_file)
+		return -EINVAL;
+
+	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
+				   (const char *)name);
+	if (error == -ENOMEM)
+		error = -EAGAIN;
+	return error;
+}
+
 #ifdef CONFIG_SWAP
 static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	unsigned long end, struct mm_walk *walk)
@@ -948,7 +1024,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	}
 
-	error = madvise_update_vma(vma, prev, start, end, new_flags);
+	error = madvise_update_vma(vma, prev, start, end, new_flags,
+				   vma_anon_name(vma));
 
 out:
 	if (error == -ENOMEM)
@@ -1123,6 +1200,31 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 	return unmapped_error;
 }
 
+int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
+			  unsigned long len_in, const char *name)
+{
+	unsigned long end;
+	unsigned long len;
+
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+	len = (len_in + ~PAGE_MASK) & PAGE_MASK;
+
+	/* Check to see whether len was rounded up from small -ve to zero */
+	if (len_in && !len)
+		return -EINVAL;
+
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+
+	if (end == start)
+		return 0;
+
+	return madvise_walk_vmas(mm, start, end, (unsigned long)name,
+				 madvise_vma_anon_name);
+}
+
 /*
  * The madvise(2) system call.
  *
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..cc21ca7e9d40 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -811,7 +811,8 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
-				 new_pol, vma->vm_userfaultfd_ctx);
+				 new_pol, vma->vm_userfaultfd_ctx,
+				 vma_anon_name(vma));
 		if (prev) {
 			vma = prev;
 			next = vma->vm_next;
diff --git a/mm/mlock.c b/mm/mlock.c
index 16d2ee160d43..c878515680af 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -511,7 +511,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx);
+			  vma->vm_userfaultfd_ctx, vma_anon_name(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
diff --git a/mm/mmap.c b/mm/mmap.c
index ca54d36d203a..baf00fbb1f4c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1032,7 +1032,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
  */
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
 				struct file *file, unsigned long vm_flags,
-				struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+				const char *anon_name)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -1050,6 +1051,8 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
 		return 0;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
 		return 0;
+	if (!is_same_vma_anon_name(vma, anon_name))
+		return 0;
 	return 1;
 }
 
@@ -1082,9 +1085,10 @@ static int
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		     struct anon_vma *anon_vma, struct file *file,
 		     pgoff_t vm_pgoff,
-		     struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+		     struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		     const char *anon_name)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		if (vma->vm_pgoff == vm_pgoff)
 			return 1;
@@ -1103,9 +1107,10 @@ static int
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		    struct anon_vma *anon_vma, struct file *file,
 		    pgoff_t vm_pgoff,
-		    struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+		    struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		     const char *anon_name)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		pgoff_t vm_pglen;
 		vm_pglen = vma_pages(vma);
@@ -1116,9 +1121,9 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 }
 
 /*
- * Given a mapping request (addr,end,vm_flags,file,pgoff), figure out
- * whether that can be merged with its predecessor or its successor.
- * Or both (it neatly fills a hole).
+ * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
+ * figure out whether that can be merged with its predecessor or its
+ * successor.  Or both (it neatly fills a hole).
  *
  * In most cases - when called for mmap, brk or mremap - [addr,end) is
  * certain not to be mapped by the time vma_merge is called; but when
@@ -1163,7 +1168,8 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			unsigned long end, unsigned long vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
 			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+			const char *anon_name)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
@@ -1193,7 +1199,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			mpol_equal(vma_policy(prev), policy) &&
 			can_vma_merge_after(prev, vm_flags,
 					    anon_vma, file, pgoff,
-					    vm_userfaultfd_ctx)) {
+					    vm_userfaultfd_ctx, anon_name)) {
 		/*
 		 * OK, it can.  Can we now merge in the successor as well?
 		 */
@@ -1202,7 +1208,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 				can_vma_merge_before(next, vm_flags,
 						     anon_vma, file,
 						     pgoff+pglen,
-						     vm_userfaultfd_ctx) &&
+						     vm_userfaultfd_ctx, anon_name) &&
 				is_mergeable_anon_vma(prev->anon_vma,
 						      next->anon_vma, NULL)) {
 							/* cases 1, 6 */
@@ -1225,7 +1231,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			mpol_equal(policy, vma_policy(next)) &&
 			can_vma_merge_before(next, vm_flags,
 					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx)) {
+					     vm_userfaultfd_ctx, anon_name)) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err = __vma_adjust(prev, prev->vm_start,
 					 addr, prev->vm_pgoff, NULL, next);
@@ -1766,7 +1772,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Can we just expand an old mapping?
 	 */
 	vma = vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX);
+			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 	if (vma)
 		goto out;
 
@@ -1825,7 +1831,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
 			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
@@ -3087,7 +3093,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 
 	/* Can we just expand an old private anonymous mapping? */
 	vma = vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
+			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 	if (vma)
 		goto out;
 
@@ -3280,7 +3286,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		return NULL;	/* should never get here */
 	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx);
+			    vma->vm_userfaultfd_ctx, vma_anon_name(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..a48ff8e79f48 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -464,7 +464,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*pprev = vma_merge(mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx);
+			   vma->vm_userfaultfd_ctx, vma_anon_name(vma));
 	if (*pprev) {
 		vma = *pprev;
 		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
-- 
2.33.0.259.gc128427fd7-goog

