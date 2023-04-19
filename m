Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8496E7813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjDSLH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjDSLHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:07:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB76EAD;
        Wed, 19 Apr 2023 04:07:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.37.187.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C45A96603261;
        Wed, 19 Apr 2023 12:07:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681902468;
        bh=o6p3wXTxhFNhx+4PpUybSE97qNV/lC6eWw9YubDqMS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kS1c5bSoIbhjxK178wcyE909edRU5PgNnv+9sl5j3k8/Z4W1XFB+BIlBKDehVS7Dw
         ijvLJDOTPgZRxChxNbardue8LMolzx8Edbk1WNtSy+GF3fnQ8q230H6NKgNqi6KAGG
         J65OMQowRi3Ogrg508/4dD7jiFezmWST7Oe8L5eYgjh/uqn/H3bDDpcWKlVnNe5feL
         OBnUvRp7B64DdKf2apNmn5Og/vCxCKhx9/wHuUnehKof7v+Aa3N/6layXXiCemsC34
         5tUD0RLx2TUNgeJQq9PHc4XV8vEbykEHy2W0TfpmpM3FFm8I/kUL92NBWJZzLvgFfb
         0FRXA18VtRAcQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v15 1/5] userfaultfd: UFFD_FEATURE_WP_ASYNC
Date:   Wed, 19 Apr 2023 16:07:12 +0500
Message-Id: <20230419110716.4113627-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419110716.4113627-1-usama.anjum@collabora.com>
References: <20230419110716.4113627-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

This patch adds a new userfaultfd-wp feature UFFD_FEATURE_WP_ASYNC, that
allows userfaultfd wr-protect faults to be resolved by the kernel directly.

It can be used like a high accuracy version of soft-dirty, without vma
modifications during tracking, and also with ranged support by default
rather than for a whole mm when reset the protections due to existence of
ioctl(UFFDIO_WRITEPROTECT).

Several goals of such a dirty tracking interface:

1. All types of memory should be supported and tracable. This is nature
   for soft-dirty but should mention when the context is userfaultfd,
   because it used to only support anon/shmem/hugetlb. The problem is for
   a dirty tracking purpose these three types may not be enough, and it's
   legal to track anything e.g. any page cache writes from mmap.

2. Protections can be applied to partial of a memory range, without vma
   split/merge fuss.  The hope is that the tracking itself should not
   affect any vma layout change.  It also helps when reset happens because
   the reset will not need mmap write lock which can block the tracee.

3. Accuracy needs to be maintained.  This means we need pte markers to work
   on any type of VMA.

One could question that, the whole concept of async dirty tracking is not
really close to fundamentally what userfaultfd used to be: it's not "a
fault to be serviced by userspace" anymore. However, using userfaultfd-wp
here as a framework is convenient for us in at least:

1. VM_UFFD_WP vma flag, which has a very good name to suite something like
   this, so we don't need VM_YET_ANOTHER_SOFT_DIRTY. Just use a new
   feature bit to identify from a sync version of uffd-wp registration.

2. PTE markers logic can be leveraged across the whole kernel to maintain
   the uffd-wp bit as long as an arch supports, this also applies to this
   case where uffd-wp bit will be a hint to dirty information and it will
   not go lost easily (e.g. when some page cache ptes got zapped).

3. Reuse ioctl(UFFDIO_WRITEPROTECT) interface for either starting or
   resetting a range of memory, while there's no counterpart in the old
   soft-dirty world, hence if this is wanted in a new design we'll need a
   new interface otherwise.

We can somehow understand that commonality because uffd-wp was
fundamentally a similar idea of write-protecting pages just like
soft-dirty.

This implementation allows WP_ASYNC to imply WP_UNPOPULATED, because so far
WP_ASYNC seems to not usable if without WP_UNPOPULATE.  This also gives us
chance to modify impl of WP_ASYNC just in case it could be not depending on
WP_UNPOPULATED anymore in the future kernels. It's also fine to imply that
because both features will rely on PTE_MARKER_UFFD_WP config option, so
they'll show up together (or both missing) in an UFFDIO_API probe.

vma_can_userfault() now allows any VMA if the userfaultfd registration is
only about async uffd-wp. So we can track dirty for all kinds of memory
including generic file systems (like XFS, EXT4 or BTRFS).

One trick worth mention in do_wp_page() is that we need to manually update
vmf->orig_pte here because it can be used later with a pte_same() check -
this path always has FAULT_FLAG_ORIG_PTE_VALID set in the flags.

The major defect of this approach of dirty tracking is we need to populate
the pgtables when tracking starts. Soft-dirty doesn't do it like that.
It's unwanted in the case where the range of memory to track is huge and
unpopulated (e.g., tracking updates on a 10G file with mmap() on top,
without having any page cache installed yet). One way to improve this is
to allow pte markers exist for larger than PTE level for PMD+. That will
not change the interface if to implemented, so we can leave that for later.

Co-developed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
Changes in v12:
- Peter added the hugetlb support and revamped some other implementation
- Transferred the authorship to Peter
- Merge documentation to this patch

Changes in v11:
- Fix return code in userfaultfd_register() and minor changes here and
  there
- Rebase on top of next-20230307
- Base patches on UFFD_FEATURE_WP_UNPOPULATED https://lore.kernel.org/all/20230306213925.617814-1-peterx@redhat.com
- UFFD_FEATURE_WP_ASYNC depends on UFFD_FEATURE_WP_UNPOPULATED to work
  (correctly)

Changes in v10:
- Build fix
- Update comments and add error condition to return error from uffd
  register if hugetlb pages are present when wp async flag is set

Changes in v9:
- Correct the fault resolution with code contributed by Peter

Changes in v7:
- Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
- Handle automatic page fault resolution in better way (thanks to Peter)
---
 Documentation/admin-guide/mm/userfaultfd.rst | 35 ++++++++++++++++++++
 fs/userfaultfd.c                             | 26 ++++++++++++---
 include/linux/userfaultfd_k.h                | 21 +++++++++++-
 include/uapi/linux/userfaultfd.h             |  9 ++++-
 mm/hugetlb.c                                 | 32 ++++++++++--------
 mm/memory.c                                  | 27 +++++++++++++--
 6 files changed, 128 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 7c304e432205..4b7f43fbbe18 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -244,6 +244,41 @@ write-protected (so future writes will also result in a WP fault). These ioctls
 support a mode flag (``UFFDIO_COPY_MODE_WP`` or ``UFFDIO_CONTINUE_MODE_WP``
 respectively) to configure the mapping this way.
 
+If the userfaultfd context has ``UFFD_FEATURE_WP_ASYNC`` feature bit set,
+any vma registered with write-protection will work in async mode rather
+than the default sync mode.
+
+In async mode, there will be no message generated when a write operation
+happens, meanwhile the write-protection will be resolved automatically by
+the kernel.  It can be seen as a more accurate version of soft-dirty
+tracking and it can be different in a few ways:
+
+  - The dirty result will not be affected by vma changes (e.g. vma
+    merging) because the dirty is only tracked by the pte.
+
+  - It supports range operations by default, so one can enable tracking on
+    any range of memory as long as page aligned.
+
+  - Dirty information will not get lost if the pte was zapped due to
+    various reasons (e.g. during split of a shmem transparent huge page).
+
+  - Due to a reverted meaning of soft-dirty (page clean when uffd-wp bit
+    set; dirty when uffd-wp bit cleared), it has different semantics on
+    some of the memory operations.  For example: ``MADV_DONTNEED`` on
+    anonymous (or ``MADV_REMOVE`` on a file mapping) will be treated as
+    dirtying of memory by dropping uffd-wp bit during the procedure.
+
+The user app can collect the "written/dirty" status by looking up the
+uffd-wp bit for the pages being interested in /proc/pagemap.
+
+The page will not be under track of uffd-wp async mode until the page is
+explicitly write-protected by ``ioctl(UFFDIO_WRITEPROTECT)`` with the mode
+flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
+that was tracked by async mode userfaultfd-wp is invalid.
+
+When userfaultfd-wp async mode is used alone, it can be applied to all
+kinds of memory.
+
 QEMU/KVM
 ========
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..3ab021521a96 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -123,6 +123,11 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 	return ctx->features & UFFD_FEATURE_INITIALIZED;
 }
 
+static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
+{
+	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
+}
+
 /*
  * Whether WP_UNPOPULATED is enabled on the uffd context.  It is only
  * meaningful when userfaultfd_wp()==true on the vma and when it's
@@ -1332,6 +1337,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
+	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1405,7 +1411,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
-		if (!vma_can_userfault(cur, vm_flags))
+		if (!vma_can_userfault(cur, vm_flags, wp_async))
 			goto out_unlock;
 
 		/*
@@ -1464,7 +1470,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vm_flags));
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
 		       vma->vm_userfaultfd_ctx.ctx != ctx);
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
@@ -1563,6 +1569,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
+	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1616,7 +1623,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * provides for more strict behavior to notice
 		 * unregistration errors.
 		 */
-		if (!vma_can_userfault(cur, cur->vm_flags))
+		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
 
 		found = true;
@@ -1629,7 +1636,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
+		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1966,6 +1973,11 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	return ret;
 }
 
+bool userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return userfaultfd_wp_async_ctx(vma->vm_userfaultfd_ctx.ctx);
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -1999,6 +2011,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
 		goto err_out;
+
+	/* WP_ASYNC relies on WP_UNPOPULATED, choose it unconditionally */
+	if (features & UFFD_FEATURE_WP_ASYNC)
+		features |= UFFD_FEATURE_WP_UNPOPULATED;
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
@@ -2011,6 +2028,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index d78b01524349..ce4f9d18de3e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -157,11 +157,22 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 }
 
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
+				     unsigned long vm_flags,
+				     bool wp_async)
 {
+	vm_flags &= __VM_UFFD_FLAGS;
+
 	if ((vm_flags & VM_UFFD_MINOR) &&
 	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
 		return false;
+
+	/*
+	 * If wp async enabled, and WP is the only mode enabled, allow any
+	 * memory type.
+	 */
+	if (wp_async && (vm_flags == VM_UFFD_WP))
+		return true;
+
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
@@ -171,6 +182,8 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
 		return false;
 #endif
+
+	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
 	    vma_is_shmem(vma);
 }
@@ -193,6 +206,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
+extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -293,6 +307,11 @@ static inline bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 66dd4cd277bd..cfb87a112a9f 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -39,7 +39,8 @@
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
-			   UFFD_FEATURE_WP_UNPOPULATED)
+			   UFFD_FEATURE_WP_UNPOPULATED |	\
+			   UFFD_FEATURE_WP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -210,6 +211,11 @@ struct uffdio_api {
 	 * (i.e. empty ptes).  This will be the default behavior for shmem
 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
 	 * when userfault write-protection mode is registered.
+	 *
+	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
+	 * asynchronous mode is supported in which the write fault is
+	 * automatically resolved and write-protection is un-set.
+	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -225,6 +231,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_WP_ASYNC			(1<<14)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 155bb6712be1..0d0efd96449e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6150,21 +6150,27 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	/* Handle userfault-wp first, before trying to lock more pages */
 	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = haddr,
-			.real_address = address,
-			.flags = flags,
-		};
+		if (!userfaultfd_wp_async(vma)) {
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+			};
 
-		spin_unlock(ptl);
-		if (pagecache_folio) {
-			folio_unlock(pagecache_folio);
-			folio_put(pagecache_folio);
+			spin_unlock(ptl);
+			if (pagecache_folio) {
+				folio_unlock(pagecache_folio);
+				folio_put(pagecache_folio);
+			}
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
-		hugetlb_vma_unlock_read(vma);
-		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		return handle_userfault(&vmf, VM_UFFD_WP);
+
+		entry = huge_pte_clear_uffd_wp(entry);
+		set_huge_pte_at(mm, haddr, ptep, entry);
+		/* Fallthrough to CoW */
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 1c5b231fe6e3..60f1a4e348b5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3331,11 +3331,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
+	pte_t pte;
 
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_WP);
+			if (!userfaultfd_wp_async(vma)) {
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				return handle_userfault(vmf, VM_UFFD_WP);
+			}
+
+			/*
+			 * Nothing needed (cache flush, TLB invalidations,
+			 * etc.) because we're only removing the uffd-wp bit,
+			 * which is completely invisible to the user.
+			 */
+			pte = pte_clear_uffd_wp(*vmf->pte);
+
+			set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
+			/*
+			 * Update this to be prepared for following up CoW
+			 * handling
+			 */
+			vmf->orig_pte = pte;
 		}
 
 		/*
@@ -4824,8 +4841,11 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 
 	if (vma_is_anonymous(vmf->vma)) {
 		if (likely(!unshare) &&
-		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
+		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
+			if (userfaultfd_wp_async(vmf->vma))
+				goto split;
 			return handle_userfault(vmf, VM_UFFD_WP);
+		}
 		return do_huge_pmd_wp_page(vmf);
 	}
 
@@ -4837,6 +4857,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 		}
 	}
 
+split:
 	/* COW or write-notify handled on pte level: split pmd. */
 	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
 
-- 
2.39.2

