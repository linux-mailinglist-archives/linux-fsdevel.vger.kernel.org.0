Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF567935C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 09:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjAXIop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 03:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjAXIom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:44:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C7532533;
        Tue, 24 Jan 2023 00:44:41 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4E1D6602E2B;
        Tue, 24 Jan 2023 08:44:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674549879;
        bh=m/++XbQn9BatMFvanRp2XUIOa0zCFwRYse69T8hHq3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBW0lX/oQGiGf6RmlizOjOfaR7O9XvMYK0Ybxo3oXOnEJr2A80AStD0iglUEUaiE9
         h6TIqMPwPx0t0gL+dH18QDgZgBgAghyuEI+veHKt7sOKaKKgaAgNviYWQvmpMxbZHl
         wuddkQF1DzY+FA+zg3B1Qxw9sYPr3cLs2km9v/Q3EFnUCV2++W21yrxVy/sv4ZrHky
         1tWRq0JlGBvfQMpTBkforZU4Fghyfn0eh6blchhWnyp++sK7SFAkLTXCYPZG8IdW2F
         K1HKDDhFoSKH7UBSXDAsczZ+Qiw9ioI5FcVOibaRLRwwDeh8JFr0Mu5pGVDyzF+ydK
         yzbVjt8eJK/mg==
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
Subject: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
Date:   Tue, 24 Jan 2023 13:43:20 +0500
Message-Id: <20230124084323.1363825-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230124084323.1363825-1-usama.anjum@collabora.com>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
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

Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
faults on its own. It can be used to track that which pages have been
written-to from the time the pages were write-protected. It is very
efficient way to track the changes as uffd is by nature pte/pmd based.

UFFD synchronous WP sends the page faults to the userspace where the
pages which have been written-to can be tracked. But it is not efficient.
This is why this asynchronous version is being added. After setting the
WP Async, the pages which have been written to can be found in the pagemap
file or information can be obtained from the PAGEMAP_IOCTL.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v7:
- Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
- Handle automatic page fault resolution in better way (thanks to Peter)
---
 fs/userfaultfd.c                 | 11 +++++++++++
 include/linux/userfaultfd_k.h    |  6 ++++++
 include/uapi/linux/userfaultfd.h |  8 +++++++-
 mm/memory.c                      | 29 +++++++++++++++++++++++++++--
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 15a5bf765d43..b82af02092ce 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1867,6 +1867,10 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
 	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
 
+	/* Write protection cannot be disabled in case of aync WP */
+	if (!mode_wp && (ctx->features & UFFD_FEATURE_WP_ASYNC))
+		return -EINVAL;
+
 	if (mode_wp && mode_dontwake)
 		return -EINVAL;
 
@@ -1950,6 +1954,13 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	return ret;
 }
 
+int userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
+
+	return (ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC));
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 9df0b9a762cc..5db51fccae1d 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
+extern int userfaultfd_wp_async(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -274,6 +275,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 	return false;
 }
 
+int userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..f4252ef40071 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -38,7 +38,8 @@
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
-			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
+			   UFFD_FEATURE_WP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -203,6 +204,10 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
 	 * write-protection mode is supported on both shmem and hugetlbfs.
+	 *
+	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
+	 * asynchronous mode is supported in which the write fault is automatically
+	 * resolved and write-protection is un-set.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -217,6 +222,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
+#define UFFD_FEATURE_WP_ASYNC			(1<<13)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/memory.c b/mm/memory.c
index 4000e9f017e0..8c03b133d483 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+			if (userfaultfd_wp_async(vma)) {
+				/*
+				 * Nothing needed (cache flush, TLB invalidations,
+				 * etc.) because we're only removing the uffd-wp bit,
+				 * which is completely invisible to the user. This
+				 * falls through to possible CoW.
+				 */
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
+					   pte_clear_uffd_wp(*vmf->pte));
+				return 0;
+			}
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return handle_userfault(vmf, VM_UFFD_WP);
 		}
@@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 
 	if (vma_is_anonymous(vmf->vma)) {
 		if (likely(!unshare) &&
-		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
-			return handle_userfault(vmf, VM_UFFD_WP);
+		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
+			if (userfaultfd_wp_async(vmf->vma)) {
+				/*
+				 * Nothing needed (cache flush, TLB invalidations,
+				 * etc.) because we're only removing the uffd-wp bit,
+				 * which is completely invisible to the user. This
+				 * falls through to possible CoW.
+				 */
+				set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
+					   pmd_clear_uffd_wp(*vmf->pmd));
+				return 0;
+			} else {
+				return handle_userfault(vmf, VM_UFFD_WP);
+			}
+		}
 		return do_huge_pmd_wp_page(vmf);
 	}
 
-- 
2.30.2

