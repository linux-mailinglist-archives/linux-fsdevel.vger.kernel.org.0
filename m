Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE03A661EC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 07:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjAIGq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 01:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjAIGqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:46:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FCEE089;
        Sun,  8 Jan 2023 22:46:19 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.24.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 315D56602CFD;
        Mon,  9 Jan 2023 06:46:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673246778;
        bh=JQzaSeft94fKcTZHvuDEmY5KWznaYxMJmSkGHi+xwMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jobxg6BMU/NWAoTZRTTtlRpr1xMPhjBxUQfhaRXgcLYiJUpcoBTc1ed83xMDvoGmv
         65dl2Iy3GvnGq3MjpmihRhGNu2TPbbpradsfdtYbCOv15534QrHLo0MroCqoBBh+VO
         h+nO3kbOidu5mNLFz5MnmF37VOXMou9kuaSBVwu/1Ztrufavm96N2OObVnOzzcR/kH
         0b59zh7obtrBqDKG2kchpfMwMx3sEUVqpav/L5nC518RPZsH3aMoNmY1maCCizrnAG
         NToeO1z0WdALPg2lueo+2X/KkOnHJOqD6PkHyl2xgShTBPhpdqzGIP+nejHhfyo7rK
         GGIHLhNmexKMQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v7 1/4] userfaultfd: Add UFFD WP Async support
Date:   Mon,  9 Jan 2023 11:45:16 +0500
Message-Id: <20230109064519.3555250-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109064519.3555250-1-usama.anjum@collabora.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new WP Async mode (UFFDIO_WRITEPROTECT_MODE_ASYNC_WP) which resolves
the page faults on its own. It can be used to track that which pages have
been written to from the time the pages were write protected. It is very
efficient way to track the changes as uffd is by nature pte/pmd based.

UFFD WP (UFFDIO_WRITEPROTECT_MODE_WP) sends the page faults to the
userspace where the pages which have been written-to can be tracked. But
it is not efficient. This is why this async version is being added.
After setting the WP Async, the pages which have been written to can be
found in the pagemap file or information can be obtained from the
PAGEMAP_IOCTL (see next patches).

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/userfaultfd.c                 | 150 +++++++++++++++++--------------
 include/uapi/linux/userfaultfd.h |   6 ++
 2 files changed, 90 insertions(+), 66 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 15a5bf765d43..be5e10d15058 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -69,6 +69,7 @@ struct userfaultfd_ctx {
 	unsigned int features;
 	/* released */
 	bool released;
+	bool async;
 	/* memory mappings are changing because of non-cooperative event */
 	atomic_t mmap_changing;
 	/* mm with one ore more vmas attached to this userfaultfd_ctx */
@@ -497,80 +498,93 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	/* take the reference before dropping the mmap_lock */
 	userfaultfd_ctx_get(ctx);
+	if (ctx->async) {
+		// Resolve page fault of this page
+		unsigned long addr = (ctx->features & UFFD_FEATURE_EXACT_ADDRESS) ?
+				      vmf->real_address : vmf->address;
+		struct vm_area_struct *dst_vma = find_vma(ctx->mm, addr);
+		size_t s = PAGE_SIZE;
+
+		if (dst_vma->vm_flags & VM_HUGEPAGE) {
+			s = HPAGE_SIZE;
+			addr &= HPAGE_MASK;
+		}
 
-	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
-	uwq.wq.private = current;
-	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
-				reason, ctx->features);
-	uwq.ctx = ctx;
-	uwq.waken = false;
-
-	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
+		ret = mwriteprotect_range(ctx->mm, addr, s, false, &ctx->mmap_changing);
+	} else {
+		init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
+		uwq.wq.private = current;
+		uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
+					reason, ctx->features);
+		uwq.ctx = ctx;
+		uwq.waken = false;
 
-        /*
-         * Take the vma lock now, in order to safely call
-         * userfaultfd_huge_must_wait() later. Since acquiring the
-         * (sleepable) vma lock can modify the current task state, that
-         * must be before explicitly calling set_current_state().
-         */
-	if (is_vm_hugetlb_page(vma))
-		hugetlb_vma_lock_read(vma);
+		blocking_state = userfaultfd_get_blocking_state(vmf->flags);
 
-	spin_lock_irq(&ctx->fault_pending_wqh.lock);
-	/*
-	 * After the __add_wait_queue the uwq is visible to userland
-	 * through poll/read().
-	 */
-	__add_wait_queue(&ctx->fault_pending_wqh, &uwq.wq);
-	/*
-	 * The smp_mb() after __set_current_state prevents the reads
-	 * following the spin_unlock to happen before the list_add in
-	 * __add_wait_queue.
-	 */
-	set_current_state(blocking_state);
-	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
+		/*
+		 * Take the vma lock now, in order to safely call
+		 * userfaultfd_huge_must_wait() later. Since acquiring the
+		 * (sleepable) vma lock can modify the current task state, that
+		 * must be before explicitly calling set_current_state().
+		 */
+		if (is_vm_hugetlb_page(vma))
+			hugetlb_vma_lock_read(vma);
 
-	if (!is_vm_hugetlb_page(vma))
-		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
-						  reason);
-	else
-		must_wait = userfaultfd_huge_must_wait(ctx, vma,
-						       vmf->address,
-						       vmf->flags, reason);
-	if (is_vm_hugetlb_page(vma))
-		hugetlb_vma_unlock_read(vma);
-	mmap_read_unlock(mm);
+		spin_lock_irq(&ctx->fault_pending_wqh.lock);
+		/*
+		 * After the __add_wait_queue the uwq is visible to userland
+		 * through poll/read().
+		 */
+		__add_wait_queue(&ctx->fault_pending_wqh, &uwq.wq);
+		/*
+		 * The smp_mb() after __set_current_state prevents the reads
+		 * following the spin_unlock to happen before the list_add in
+		 * __add_wait_queue.
+		 */
+		set_current_state(blocking_state);
+		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
-	if (likely(must_wait && !READ_ONCE(ctx->released))) {
-		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
-		schedule();
-	}
+		if (!is_vm_hugetlb_page(vma))
+			must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
+							  reason);
+		else
+			must_wait = userfaultfd_huge_must_wait(ctx, vma,
+							       vmf->address,
+							       vmf->flags, reason);
+		if (is_vm_hugetlb_page(vma))
+			hugetlb_vma_unlock_read(vma);
+		mmap_read_unlock(mm);
+
+		if (likely(must_wait && !READ_ONCE(ctx->released))) {
+			wake_up_poll(&ctx->fd_wqh, EPOLLIN);
+			schedule();
+		}
 
-	__set_current_state(TASK_RUNNING);
+		__set_current_state(TASK_RUNNING);
 
-	/*
-	 * Here we race with the list_del; list_add in
-	 * userfaultfd_ctx_read(), however because we don't ever run
-	 * list_del_init() to refile across the two lists, the prev
-	 * and next pointers will never point to self. list_add also
-	 * would never let any of the two pointers to point to
-	 * self. So list_empty_careful won't risk to see both pointers
-	 * pointing to self at any time during the list refile. The
-	 * only case where list_del_init() is called is the full
-	 * removal in the wake function and there we don't re-list_add
-	 * and it's fine not to block on the spinlock. The uwq on this
-	 * kernel stack can be released after the list_del_init.
-	 */
-	if (!list_empty_careful(&uwq.wq.entry)) {
-		spin_lock_irq(&ctx->fault_pending_wqh.lock);
 		/*
-		 * No need of list_del_init(), the uwq on the stack
-		 * will be freed shortly anyway.
+		 * Here we race with the list_del; list_add in
+		 * userfaultfd_ctx_read(), however because we don't ever run
+		 * list_del_init() to refile across the two lists, the prev
+		 * and next pointers will never point to self. list_add also
+		 * would never let any of the two pointers to point to
+		 * self. So list_empty_careful won't risk to see both pointers
+		 * pointing to self at any time during the list refile. The
+		 * only case where list_del_init() is called is the full
+		 * removal in the wake function and there we don't re-list_add
+		 * and it's fine not to block on the spinlock. The uwq on this
+		 * kernel stack can be released after the list_del_init.
 		 */
-		list_del(&uwq.wq.entry);
-		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
+		if (!list_empty_careful(&uwq.wq.entry)) {
+			spin_lock_irq(&ctx->fault_pending_wqh.lock);
+			/*
+			 * No need of list_del_init(), the uwq on the stack
+			 * will be freed shortly anyway.
+			 */
+			list_del(&uwq.wq.entry);
+			spin_unlock_irq(&ctx->fault_pending_wqh.lock);
+		}
 	}
-
 	/*
 	 * ctx may go away after this if the userfault pseudo fd is
 	 * already released.
@@ -1861,11 +1875,14 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 		return ret;
 
 	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
-			       UFFDIO_WRITEPROTECT_MODE_WP))
+			       UFFDIO_WRITEPROTECT_MODE_WP |
+			       UFFDIO_WRITEPROTECT_MODE_ASYNC_WP))
 		return -EINVAL;
 
-	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
+	mode_wp = uffdio_wp.mode & (UFFDIO_WRITEPROTECT_MODE_WP |
+				    UFFDIO_WRITEPROTECT_MODE_ASYNC_WP);
 	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
+	ctx->async = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_ASYNC_WP;
 
 	if (mode_wp && mode_dontwake)
 		return -EINVAL;
@@ -2126,6 +2143,7 @@ static int new_userfaultfd(int flags)
 	ctx->flags = flags;
 	ctx->features = 0;
 	ctx->released = false;
+	ctx->async = false;
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
 	/* prevent the mm struct to be freed */
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..b89665653861 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -284,6 +284,11 @@ struct uffdio_writeprotect {
  * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
  * any wait thread after the operation succeeds.
  *
+ * UFFDIO_WRITEPROTECT_MODE_ASYNC_WP: set the flag to write protect a
+ * range, the flag is unset automatically when the page is written.
+ * This is used to track which pages have been written to from the
+ * time the memory was write protected.
+ *
  * NOTE: Write protecting a region (WP=1) is unrelated to page faults,
  * therefore DONTWAKE flag is meaningless with WP=1.  Removing write
  * protection (WP=0) in response to a page fault wakes the faulting
@@ -291,6 +296,7 @@ struct uffdio_writeprotect {
  */
 #define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
 #define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
+#define UFFDIO_WRITEPROTECT_MODE_ASYNC_WP	((__u64)1<<2)
 	__u64 mode;
 };
 
-- 
2.30.2

