Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8736620E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDTWKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhDTWIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:08:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF40CC06138B
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g21-20020ac858150000b02901ba6163708bso2098192qtg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QUApq8UPhLnVOskfaex0nbVtMhAbaCtXI1eHuCuwzK0=;
        b=go415UuMQZc9Zin/DWljWc8XS2D43ct53uUZqRvif920L9paMAYqU8DAomFyOgMzKy
         BASyq6I6UBR+/DPIvFLjEmsDFvBoeoZ8ZRqAX2l59ua7fWNbLvGvrhRxeGBTRF0jfteS
         70u3jBHIPKb/9Fp7miWXNnTGQ+RuVwC3KWRNfByHS7cGBdjkut5Ve2iijXJfv/YyRKEd
         DFUg/i50NODl/vWSwTyUkQezOd3vv3pPewiisUw3YwuocrFoFn/VnpTq0HEB1N7vAnIO
         z3HzvKXFWBQIEl7E2RHB32Ym368rCk4ECwgyz7C+Todyzdc2OTqQCeObDg2ncNld7X6n
         3ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QUApq8UPhLnVOskfaex0nbVtMhAbaCtXI1eHuCuwzK0=;
        b=oRm30TKCxEdausbQmQXtiJeY/taOSPc6lNWB2mDBXg2BXJ+A/mNd/K44tlnd3wRGs2
         NoNbjEk6OoN6guACcUvq0g40xxd5lNLEQSKZ358CcRF1Am3w5rJ3XvVwtGQeeZlavYgK
         u+RmERnaCdL/wBuZ9TDpr167lI14rpr+dH5c5OAFT0a93q07pwElSJO5qlkKxzNXX80b
         USktnPmEBRVuWMEKP+VtOgkdkgIerCgGL2pCqJfXzDv+ZS/JplIlxhCnlNEpPo1oEClc
         C8rOanptZjTREUg2uXmbUToaOV7JlZ93QhCetZuQQufH+Hg7U+4K2Jc1keFukn1ptC+g
         ChOg==
X-Gm-Message-State: AOAM5339RPm1MdNhn/oDbadLYgKU+SHQhgPZlVrQwIMIqiIRpKn+A/jM
        MdxLgsRcjfSldIlD0nn5seI8LvWSQEQle+xDVM5q
X-Google-Smtp-Source: ABdhPJysgqqNiiBX50a+ZoqyZ0kCGo4tvrGC3ywuggc7gqC2iDuh1na9Bbn6xDQ61bim3z6mT/0+24eR3Btt/RkfuRrA
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:18d:: with SMTP id
 q13mr4532886qvr.60.1618956496024; Tue, 20 Apr 2021 15:08:16 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:07:58 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 04/10] userfaultfd/shmem: support minor fault registration
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

