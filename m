Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03366B260F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCIOA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjCIOAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA39DDB09;
        Thu,  9 Mar 2023 05:57:44 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA6826603049;
        Thu,  9 Mar 2023 13:57:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370263;
        bh=Y53PvOYyLEJIHqsyUerluPWJieKweUBU42KHuRX9/YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKeNTdPTzFx4AjoUK0J4D0EkJWmBVZhYF/JC6m7IlCiDsBMDHdcsNZVExlXvBnPzy
         5p0teNrRFfCyP5NuVsR4ybmK7NFzuV5obQqJv+Vmkk+Rk0c24sntd+lRSJid3Kj7mp
         GozSm08QKeWvsT/icpfwreel0I0YGYaJWnoFvvi0T6MXv3iU7ApLnYp6Z5rvv/KDBJ
         d1aA0RPzJSDjmHkse6kzYpsZtgQiaU+pjBuLo9Z/mMdkm5ehkuQZjI40AHX+hYM1PX
         5ji6tLidi3jSkFRLul7k/w4svscX5pHgHR7d/S0JVv+Zdzbq58UyqRT3YL/ZQOHadg
         oRxj+llqX5AsA==
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
Subject: [PATCH v11 1/7] userfaultfd: Add UFFD WP Async support
Date:   Thu,  9 Mar 2023 18:57:12 +0500
Message-Id: <20230309135718.1490461-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
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
 fs/userfaultfd.c                 | 25 +++++++++++++++++++++++--
 include/linux/userfaultfd_k.h    |  6 ++++++
 include/uapi/linux/userfaultfd.h | 11 ++++++++++-
 mm/memory.c                      | 27 ++++++++++++++++++++++++---
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index dac0ebe39774..992b0b21cd59 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1446,10 +1446,15 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			goto out_unlock;
 
 		/*
-		 * Note vmas containing huge pages
+		 * Note vmas containing huge pages. Hugetlb isn't supported
+		 * with UFFD_FEATURE_WP_ASYNC.
 		 */
-		if (is_vm_hugetlb_page(cur))
+		ret = -EINVAL;
+		if (is_vm_hugetlb_page(cur)) {
+			if (ctx->features & UFFD_FEATURE_WP_ASYNC)
+				goto out_unlock;
 			basic_ioctls = true;
+		}
 
 		found = true;
 	} for_each_vma_range(vmi, cur, end);
@@ -1874,6 +1879,10 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
 	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
 
+	/* The unprotection is not supported if in async WP mode */
+	if (!mode_wp && (ctx->features & UFFD_FEATURE_WP_ASYNC))
+		return -EINVAL;
+
 	if (mode_wp && mode_dontwake)
 		return -EINVAL;
 
@@ -1957,6 +1966,13 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
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
@@ -1988,6 +2004,10 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
 		goto err_out;
+	if ((features & UFFD_FEATURE_WP_ASYNC) &&
+	    !(features & UFFD_FEATURE_WP_UNPOPULATED))
+		goto err_out;
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
@@ -2000,6 +2020,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 52cb3de88e20..b680c0ec8b85 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -178,6 +178,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
+extern int userfaultfd_wp_async(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -278,6 +279,11 @@ static inline bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline int userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 90c958952bfc..00dbe7d6551b 100644
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
@@ -210,6 +211,13 @@ struct uffdio_api {
 	 * (i.e. empty ptes).  This will be the default behavior for shmem
 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
 	 * when userfault write-protection mode is registered.
+	 *
+	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
+	 * asynchronous mode is supported in which the write fault is
+	 * automatically resolved and write-protection is un-set. It only
+	 * supports anon and shmem (hugetlb isn't supported). It only takes
+	 * effect when a vma is registered with write-protection mode. Otherwise
+	 * the flag is ignored. It depends on UFFD_FEATURE_WP_UNPOPULATED.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -225,6 +233,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_WP_ASYNC			(1<<14)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/memory.c b/mm/memory.c
index 8d135a814c60..341071c2c49a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3348,11 +3348,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
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

