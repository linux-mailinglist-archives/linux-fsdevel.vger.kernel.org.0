Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769B0359071
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhDHXnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhDHXnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E3C061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g7so3558273ybm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJrBKic6BWLSUzVU0etk70MUxAfaDA5mu3HMcg/WB2s=;
        b=ic+SugPMZft+1nzSi4Yef4EU2Ccy8KcK3OzqNulnPL8gkFYK92kKgxPDtoqnaitbq1
         sL7Zz0Wg8X4Ux3qEN51dsekfArXaBoa37tMzdIs2ORXk/KM83dsMJCHF5DKpsgK7IwWw
         xfsl2OgAD7uWHV9JWdMHHUHIBH6IukevDzfj43G5TijUVbesqk5OxyCfGUW10QaxvhJo
         ++gG0U2pixyy2dbD+TzlnaTkoLx0uBsZ6hgOnsReJTVElIz8zKjURLKfzkQZwgLCZA7F
         I2E21NbyhbJi91WQqlLXpecYru25fOB4bOFna/WqtTzB8DaRNpR1PGZPXT7hLvXdGizB
         pkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJrBKic6BWLSUzVU0etk70MUxAfaDA5mu3HMcg/WB2s=;
        b=a2lTr/guvvqTgGndaypmFSxyp6oXr1MLNbDu3sJIQXYSFYeXGD4HllG6FysYTauk7I
         uEAhM1usARYpAAe7nE3Uy9eaj7e5z9Fy1Z5HRQpa5TyuWnSlYfoZvMY/cLbB+iR3J1H/
         9dhEKoT+kyu9y8JmLqRhg+NsQZDzqvZIx+K/F1o20x7gsh5OALMMoXMhL2adQO6LS7wN
         4VSnvHKuxGHGu6sehFAJ3vpznIvC3R3793d9UVo0xP2IzPGy4QPahxw3VQIDZKF4BKF3
         9GQA9H1mjsU6gfPTsAw+5B/3VyWjhoTYpLPSJqlfxqmDlalQortVybAJSADi9X8IkfWD
         oOvw==
X-Gm-Message-State: AOAM532kkI2d2lZDPGnrTLHy7QZR2n59iJDD7wZdOtH41AUFdqqBOwL+
        atGdw5qIQWlGSsi+APdhQtBLWj+9zk77SZAQPZPQ
X-Google-Smtp-Source: ABdhPJxpp4lDpLiYYEnpqNp54PjbYV/IE4p232ydPzXfrLRRoYXvEvVTNo4kRm16OanUNhbB9X3yYs7J9+1UroUEsKtN
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6e87:: with SMTP id
 j129mr15135621ybc.215.1617925416939; Thu, 08 Apr 2021 16:43:36 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:21 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 3/9] userfaultfd/shmem: support minor fault registration for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
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

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 |  6 +++---
 include/uapi/linux/userfaultfd.h |  7 ++++++-
 mm/memory.c                      |  8 +++++---
 mm/shmem.c                       | 20 ++++++++++++++++----
 4 files changed, 30 insertions(+), 11 deletions(-)

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
index c8e357627318..a1e5ff55027e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3929,9 +3929,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
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
index c21f20cc4204..99c54b165c16 100644
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
@@ -1802,6 +1802,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	pgoff_t hindex = index;
 	gfp_t huge_gfp;
 	int error;
+	bool swapped;
 	int once = 0;
 	int alloced = 0;
 
@@ -1820,16 +1821,27 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
-	if (xa_is_value(page)) {
+	swapped = xa_is_value(page);
+	if (swapped) {
 		error = shmem_swapin_page(inode, index, &page,
 					  sgp, gfp, vma, fault_type);
 		if (error == -EEXIST)
 			goto repeat;
-
 		*pagep = page;
-		return error;
+		if (error)
+			return error;
 	}
 
+	if (page && vma && userfaultfd_minor(vma)) {
+		unlock_page(page);
+		put_page(page);
+		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		return 0;
+	}
+
+	if (swapped)
+		return 0;
+
 	if (page)
 		hindex = page->index;
 	if (page && sgp == SGP_WRITE)
-- 
2.31.1.295.g9ea45b61b8-goog

