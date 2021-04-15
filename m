Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E36A361262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhDOSsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhDOSsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D38C06138C
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so3467865ybw.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QUApq8UPhLnVOskfaex0nbVtMhAbaCtXI1eHuCuwzK0=;
        b=Y24xjdSehME3uPSbOxZhgaGyOVJUE3siM4RXKAlUq2C/sPUhMInXnaOjWmiVtcmR5x
         StHOYh2kOi4TpmaKKY8Yw4jHJV1+TJU9hXuQ+rm8Oh+UjMGEBd9g/GmJsrgtn1gUNXZ1
         1PSeZY6yAZdjJfcyrnNq70NfWNiXoLyex02LJqIwBAtbrQPIoGqkNVD4oZWVran5MCGI
         AqNgFpwe0onN47beUZPM/bVxZ2oMTqwTPdWJ6/8zJIDW7QLX8HnYA/a5xef4Te4jrHfe
         Gv6RdSc0Abx17Osl29g9KgyIVVwacoFK4LtZNsUEmvDwD9+SCmSq3qTUY/e4ktk9wEli
         +IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QUApq8UPhLnVOskfaex0nbVtMhAbaCtXI1eHuCuwzK0=;
        b=pbK+tngU9gayvHX9xuo3h5dFBnAKhRryUSlH+q8Y+JKrnbeWfBro581rkxF2Hcv5u6
         TlvpV3iZ24xScbFaMYLClD9baXmeWSK8g778Wtix9KEoxianEttS8pPuBrcaSU4kDQ61
         dTsalXeliIbWG/hf3KTzPqsqRr3zC5JKYkWmq0gbaW7PAq2oe3FdrvYmj8Lsda5Q//kM
         JzE9yX/E4OOm27O+/e2UhxKSFQ1ftEE2CkNqrhrGHSLGRFMa5DpD8AC4pv/zgn7SPRdA
         LC4FwHJs0x3ABFbVyTwftIPobr36kGsqCyIEd8b8QK8OysvIHEnbSUpvdiGF8FDoSTb8
         ctRw==
X-Gm-Message-State: AOAM531oDZouRoDUZhi9Obo5jmkhdO214Pi9u9vfC/a49RZhdjlU9Gmg
        COLnkx+uYolWn2320BaKpA3kzBWGBXsUvFD6quOH
X-Google-Smtp-Source: ABdhPJx4VajWNU1JxEuPN3PCOQjFHvibPqiEX2huiN0IADIrQFOawAtK995l4DQrP69z6mqZ6J8tB0Iph8yimDbIyExL
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b098:: with SMTP id
 f24mr6393018ybj.210.1618512463076; Thu, 15 Apr 2021 11:47:43 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:26 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 04/10] userfaultfd/shmem: support minor fault registration
 for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch allows shmem-backed VMAs to be registered for minor faults.
Minor faults are appropriately relayed to userspace in the fault path,
for VMAs with the relevant flag.

This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
minor faults, though, so userspace doesn't yet have a way to resolve
such faults.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 |  6 +++---
 include/uapi/linux/userfaultfd.h |  7 ++++++-
 mm/memory.c                      |  8 +++++---
 mm/shmem.c                       | 12 +++++++++++-
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f..9f3b8684cf3c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_UFFD_MINOR) {
-		/* FIXME: Add minor fault interception for shmem. */
-		if (!is_vm_hugetlb_page(vma))
+		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
 			return false;
 	}
 
@@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
+	uffdio_api.features &=
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index bafbeb1a2624..159a74e9564f 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -31,7 +31,8 @@
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
-			   UFFD_FEATURE_MINOR_HUGETLBFS)
+			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -185,6 +186,9 @@ struct uffdio_api {
 	 * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
 	 * can be intercepted (via REGISTER_MODE_MINOR) for
 	 * hugetlbfs-backed pages.
+	 *
+	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
+	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -196,6 +200,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/memory.c b/mm/memory.c
index 4e358601c5d6..cc71a445c76c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3972,9 +3972,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * something).
 	 */
 	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		ret = do_fault_around(vmf);
-		if (ret)
-			return ret;
+		if (likely(!userfaultfd_minor(vmf->vma))) {
+			ret = do_fault_around(vmf);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = __do_fault(vmf);
diff --git a/mm/shmem.c b/mm/shmem.c
index b72c55aa07fc..30c0bb501dc9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1785,7 +1785,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache.
  *
- * vmf and fault_type are only supplied by shmem_fault:
+ * vma, vmf, and fault_type are only supplied by shmem_fault:
  * otherwise they are NULL.
  */
 static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
@@ -1820,6 +1820,16 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
+
+	if (page && vma && userfaultfd_minor(vma)) {
+		if (!xa_is_value(page)) {
+			unlock_page(page);
+			put_page(page);
+		}
+		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		return 0;
+	}
+
 	if (xa_is_value(page)) {
 		error = shmem_swapin_page(inode, index, &page,
 					  sgp, gfp, vma, fault_type);
-- 
2.31.1.368.gbe11c130af-goog

