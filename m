Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CE31A721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBLVzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhBLVzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:55:01 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575BC061788
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m5so1053228pjg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fpqa0kXnD6kS3MA9sd4m+N+7CcpsXi1WCIN8v0AwHd8=;
        b=CXE7n5gu3fRPXEsL5tnMLb/r7x4kb+xJi4lJ2ganTbzN3MVu5ChjuWjJsPh4a4GLGd
         jpR6yU7eHsEjKGTkk5zrAFb537iiXdKDwyNa9JUlT1lbV9d8pGtqsHNsdMttuR0/35fq
         g9G39Qj7KCYJvcZzrtVhrtMj0Q7ugRO/7Ps6HvOKDHy/DFen93Y6KWt5AZhsSKe+n/JJ
         jU8Ls7FW/Ig+g+qSIibEVT/sW6S6DsU7ptdTK14lNxlXksC2g1wPpwocGfSsrqAiUDpI
         oyksqeQw33hOIkbTHV380D+1ynLvFXW8CiNciW6LQGTwU1lCkbgTUKwKoz8wiL1GiWzz
         df/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fpqa0kXnD6kS3MA9sd4m+N+7CcpsXi1WCIN8v0AwHd8=;
        b=SKuu//B3SoUGLu+dcy9XoWQvvPgUU5ycvKqZx1M02UsQLRYu5FT1PbbLzB01Za/lV5
         ArW6urCd/hTxFqbWQUM2jhhh3w1OQiVwOt+UFqowh6rMV4TPU6gq9kbNuzxhffYqBBX5
         j3l8TT9YWpQMU0/SfJH9fdnUcQej6bpW+xu2Nx21EyRh9KsJzvUvvwf3r9naHwUgfBN4
         I02e4+Fx3Av+tgJBgk6QZ8fQymASFL3pO7fvm49l07wKzP4IQxJVDuBQ+8bL+2veNz3x
         MN62jBi2wcSYJotXH50RERibPZS3zkLKzD6S5/csNbalLELQLj+HoxEQ+5G29UznENkL
         igTg==
X-Gm-Message-State: AOAM532yaS+9/og+ZnzrG7QlQr8BCBFKOV8dMtqKvzo4MCziIYG1j9Ws
        WeohWJ4TRub4vq9heQYV5/Z1rrEDxVjZXwlgSsFq
X-Google-Smtp-Source: ABdhPJx5gACt6fHpzSxD1mt3KUSvMtM+l7lyNZvJvbveFvEU2cR9zjuQhF6I/jlAB422DN9lHfPJzRvq3RV3OeDDp5Mm
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d2f:99bb:c1e0:34ba])
 (user=axelrasmussen job=sendgmr) by 2002:a17:90a:df17:: with SMTP id
 gp23mr2957388pjb.55.1613166860543; Fri, 12 Feb 2021 13:54:20 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:53:58 -0800
In-Reply-To: <20210212215403.3457686-1-axelrasmussen@google.com>
Message-Id: <20210212215403.3457686-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210212215403.3457686-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 2/7] userfaultfd: add minor fault registration mode
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This feature allows userspace to intercept "minor" faults. By "minor"
faults, I mean the following situation:

Let there exist two mappings (i.e., VMAs) to the same page(s). One of
the mappings is registered with userfaultfd (in minor mode), and the
other is not. Via the non-UFFD mapping, the underlying pages have
already been allocated & filled with some contents. The UFFD mapping
has not yet been faulted in; when it is touched for the first time,
this results in what I'm calling a "minor" fault. As a concrete
example, when working with hugetlbfs, we have huge_pte_none(), but
find_lock_page() finds an existing page.

This commit adds the new feature flag used to enable this behavior. In
the hugetlb fault path, if we find that we have huge_pte_none(), but
find_lock_page() does indeed find an existing page, then we have a
"minor" fault, and if the VMA is UFFD-registered (with VM_UFFD_MISSING),
*and* this feature is enabled, we call into userfaultfd to handle it.

Why not add a new registration mode instead? After all, this being a
feature flag instead has drawbacks:

- You can't handle *only* minor faults, but *not* missing faults.
- This is a per-FD option, not a per-registration option, so if you want
  minor faults for some VMAs but not others, you need to open a separate
  FD for those two configurations.
- The userfaultfd_minor() check is more expensive, as we have to examine
  the userfaultfd_ctx.
- handle_userfault()'s "reason" argument is no longer 1:1 with VM_*
  flags, which has to be dealt with (complexity).

Basically, it comes down to the fact that we can't really add a new VM_*
flag. There are no unused bits left. :) With the current design of UFFD,
we don't write down the requested registration mode anywhere except this
flag either - there isn't any extended context we can check. So, I think
this is the only way.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 37 ++++++++++++++++++++------------
 include/linux/mm.h               |  2 +-
 include/linux/userfaultfd_k.h    |  9 ++++++++
 include/uapi/linux/userfaultfd.h | 15 +++++++++----
 mm/hugetlb.c                     | 32 +++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8d663eae0266..edfdb8f1c740 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -178,6 +178,18 @@ static void userfaultfd_ctx_put(struct userfaultfd_ctx *ctx)
 	}
 }
 
+bool userfaultfd_minor(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
+	unsigned int features = ctx ? ctx->features : 0;
+	bool minor_hugetlbfs = (features & UFFD_FEATURE_MINOR_HUGETLBFS);
+
+	if (!userfaultfd_missing(vma))
+		return false;
+
+	return is_vm_hugetlb_page(vma) && minor_hugetlbfs;
+}
+
 static inline void msg_init(struct uffd_msg *msg)
 {
 	BUILD_BUG_ON(sizeof(struct uffd_msg) != 32);
@@ -197,24 +209,21 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
 	msg_init(&msg);
 	msg.event = UFFD_EVENT_PAGEFAULT;
 	msg.arg.pagefault.address = address;
+	/*
+	 * These flags indicate why the userfault occurred:
+	 * - UFFD_PAGEFAULT_FLAG_WP indicates a write protect fault.
+	 * - UFFD_PAGEFAULT_FLAG_MINOR indicates a minor fault.
+	 * - Neither of these flags being set indicates a MISSING fault.
+	 *
+	 * Separately, UFFD_PAGEFAULT_FLAG_WRITE indicates it was a write
+	 * fault. Otherwise, it was a read fault.
+	 */
 	if (flags & FAULT_FLAG_WRITE)
-		/*
-		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
-		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WRITE
-		 * was not set in a UFFD_EVENT_PAGEFAULT, it means it
-		 * was a read fault, otherwise if set it means it's
-		 * a write fault.
-		 */
 		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
 	if (reason == UFFD_REASON_WP)
-		/*
-		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
-		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WP was
-		 * not set in a UFFD_EVENT_PAGEFAULT, it means it was
-		 * a missing fault, otherwise if set it means it's a
-		 * write protect fault.
-		 */
 		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WP;
+	if (reason == UFFD_REASON_MINOR)
+		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_MINOR;
 	if (features & UFFD_FEATURE_THREAD_ID)
 		msg.arg.pagefault.feat.ptid = task_pid_vnr(current);
 	return msg;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 89fca443e6f1..3ddc465e31b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -272,7 +272,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_MAYSHARE	0x00000080
 
 #define VM_GROWSDOWN	0x00000100	/* general info on the segment */
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
+#define VM_UFFD_MISSING	0x00000200	/* missing or minor fault tracking */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
 #define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index cc1554e7162f..4e03268c65ec 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -15,6 +15,8 @@ enum uffd_trigger_reason {
 	UFFD_REASON_MISSING,
 	/* A write protect fault occurred. */
 	UFFD_REASON_WP,
+	/* A minor fault occurred. */
+	UFFD_REASON_MINOR,
 };
 
 #ifdef CONFIG_USERFAULTFD
@@ -79,6 +81,8 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_WP;
 }
 
+bool userfaultfd_minor(struct vm_area_struct *vma);
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
@@ -140,6 +144,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_minor(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 5f2d88212f7c..6b038d56bca7 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -22,12 +22,13 @@
 #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
 			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
-			   UFFD_FEATURE_EVENT_REMOVE |	\
+			   UFFD_FEATURE_EVENT_REMOVE |		\
 			   UFFD_FEATURE_EVENT_UNMAP |		\
 			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
-			   UFFD_FEATURE_THREAD_ID)
+			   UFFD_FEATURE_THREAD_ID |		\
+			   UFFD_FEATURE_MINOR_HUGETLBFS)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -125,8 +126,9 @@ struct uffd_msg {
 #define UFFD_EVENT_UNMAP	0x16
 
 /* flags for UFFD_EVENT_PAGEFAULT */
-#define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
-#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
+#define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* write fault */
+#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* write-protect fault */
+#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* minor fault */
 
 struct uffdio_api {
 	/* userland asks for an API number and the features to enable */
@@ -171,6 +173,10 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_THREAD_ID pid of the page faulted task_struct will
 	 * be returned, if feature is not requested 0 will be returned.
+	 *
+	 * If requested, UFFD_FEATURE_MINOR_HUGETLBFS indicates that hugetlbfs
+	 * memory registered with REGISTER_MODE_MISSING will *also* receive
+	 * events for minor faults, not just missing faults.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -181,6 +187,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
+#define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2a90e0b4bf47..93307fb058b7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4366,6 +4366,38 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				VM_FAULT_SET_HINDEX(hstate_index(h));
 			goto backout_unlocked;
 		}
+
+		/* Check for page in userfault range. */
+		if (userfaultfd_minor(vma)) {
+			u32 hash;
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.flags = flags,
+				/*
+				 * Hard to debug if it ends up being used by a
+				 * callee that assumes something about the
+				 * other uninitialized fields... same as in
+				 * memory.c
+				 */
+			};
+
+			unlock_page(page);
+
+			/*
+			 * hugetlb_fault_mutex and i_mmap_rwsem must be dropped
+			 * before handling userfault.  Reacquire after handling
+			 * fault to make calling code simpler.
+			 */
+
+			hash = hugetlb_fault_mutex_hash(mapping, idx);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			i_mmap_unlock_read(mapping);
+			ret = handle_userfault(&vmf, UFFD_REASON_MINOR);
+			i_mmap_lock_read(mapping);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			goto out;
+		}
 	}
 
 	/*
-- 
2.30.0.478.g8a0d178c01-goog

