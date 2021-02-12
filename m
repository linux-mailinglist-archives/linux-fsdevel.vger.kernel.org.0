Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736EE31A724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhBLV4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhBLVzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:55:38 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692CC061793
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o8so701766pls.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LiVtqkhHz/r4Zeb2EoTFGJ4n9HyxABq0yJQZLNwm2Q8=;
        b=O7vBRrIx5Dz4nWqloIt5jjd55w0xsLnlt0ZDfNUqgpCSKytSZeYWl0eBlXJzeWpeRO
         mscnUD5ciEeVnFWj+vELioxHhbcdFk8ZcE4meUV7GbG7ACQ9UbH9iHAy7dTBR40KHQN5
         P0hsB2ltoSujvseIWy6uirjIjIg4naFd/PpA4y8/OsQjCl3eTn+PF4YA7JYYQgBZNuWd
         +fufUKzyhCpmV5A54qOsXjtQjiaEHdyjh5wo/oIisoos1/fGTY6VrO+T/UrFGDo4JKnK
         tQPUFUk28KtNK14EG6HH21RO5ZAJLF4s/Zb1WVduHQCLGjGSRkFjoI20fT39Bjs8h2ci
         2C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LiVtqkhHz/r4Zeb2EoTFGJ4n9HyxABq0yJQZLNwm2Q8=;
        b=rcCbPLf2BNSYdhSHt/aNKn0+GGBF15Y/Qjpz9CjSezWHNRiQ/sqBJ0k5ZA2q2CBCiF
         R1bnQ0mWWBCnk95TPupHSNTNxH+1FcikOIGoePKY5rgRSMjeWEirSRKOlgMX09OuSZ6N
         5nkpGPvfQCYAXO2Fo7O2N+ztDowndLLTCp+N78O9RD+VkNspxuGd3f2Nwy7Yi5pbT218
         JFOpJ/ElcOtrWjgzhPzAJe0RWA7/5I8VG3GoUh0sdO7SZLHMlGlf9aKMLf8ErjYBamtw
         ivm7K2Em2Px2FERmd9jG8gqXTBRZjtMHjzM+hbQU19PALGUJo5CQo3bY5VIiXmkq7mma
         qBJQ==
X-Gm-Message-State: AOAM531kkKjCJnZJYNJiXxwBBbDIZrJfRtOmsGYcr59QIc4ZKjxHTAfA
        sZuGgeXTQf/qTwntZRL4zV2WHKN/d9Gemi5AnFhB
X-Google-Smtp-Source: ABdhPJwIyWsSZkVJMhVY+zxGWSXQg/fBoMBEYQ3+treCTWr7uZ5zN8pWhsGxAM08+YjFkTJSWMtS/rr2O9Evf+0i2xFG
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d2f:99bb:c1e0:34ba])
 (user=axelrasmussen job=sendgmr) by 2002:a17:90a:8c18:: with SMTP id
 a24mr2543745pjo.218.1613166864656; Fri, 12 Feb 2021 13:54:24 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:54:00 -0800
In-Reply-To: <20210212215403.3457686-1-axelrasmussen@google.com>
Message-Id: <20210212215403.3457686-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210212215403.3457686-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 4/7] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
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

For background, mm/userfaultfd.c provides a general mcopy_atomic
implementation. But some types of memory (i.e., hugetlb and shmem) need
a slightly different implementation, so they provide their own helpers
for this. In other words, userfaultfd is the only caller of these
functions.

This patch achieves two things:

1. Don't spend time compiling code which will end up never being
referenced anyway (a small build time optimization).

2. In patches later in this series, we extend the signature of these
helpers with UFFD-specific state (a mode enumeration). Once this
happens, we *have to* either not compile the helpers, or unconditionally
define the UFFD-only state (which seems messier to me). This includes
the declarations in the headers, as otherwise they'd yield warnings
about implicitly defining the type of those arguments.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 4 ++++
 mm/hugetlb.c            | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d740c6fd19ae..aa9e1d6de831 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -134,11 +134,13 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+#ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				struct page **pagep);
+#endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
@@ -309,6 +311,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	BUG();
 }
 
+#ifdef CONFIG_USERFAULTFD
 static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						pte_t *dst_pte,
 						struct vm_area_struct *dst_vma,
@@ -319,6 +322,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	BUG();
 	return 0;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 					unsigned long sz)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 93307fb058b7..37b9ff7c2d04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4638,6 +4638,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4768,6 +4769,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 				 int refs, struct page **pages,
-- 
2.30.0.478.g8a0d178c01-goog

