Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45353247E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 01:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhBYA2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 19:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhBYA2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:28:31 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B68C06178B
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 16:27:14 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id n1so2873323qvi.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=szGEt3o0qFpaHEBZZQO0VSXzDMyxQL5PtuhdO6ERPgY=;
        b=Lp3/iorZZRf87wK8lw+ZvUPIx9o0DFr4xrVXJ/N3bh/eB45JduZ1xLbUThQmY9bH9i
         G2nywxd9BVfQG5pYSAKlSiruy7YYsA0r4xLoM5VOCLYVsKIlWubbjGO5KUYeFsFhKV2+
         /D/Z8/wLOYmtkejORlwoGRdLixCgthOdd1iUm3GPNYwe1odWflIqdQO51HUeMtZzHJSV
         ZTpjw+rFWMfB6bF7hVHQS1hl3o3gBQ/L2upx5hUK30AelL7by144ElLjJKR3O4EJVbsl
         W745ioaG7iRoIUlZYsR2cBHwTUZhEda/ECoLuEZZdC3/39nWSUgITIM7GjDUVCNubZ9K
         vQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=szGEt3o0qFpaHEBZZQO0VSXzDMyxQL5PtuhdO6ERPgY=;
        b=ERcAlZYODFM5xTtVJTuHICquX7ywmjkPuB2Eb3dO7d8fHVKGkwhi1cchEIHP3WGFF8
         2oRW+N9iq9RKr6AajvYN6srDVAH3VFwBa8mZ9g2A4uEh6NmKH/DR3q2m3zeaXr3zJxCb
         /MQOiLuQD2PeCWJxSLfTwGx8Sz/LKTvo3WUR1nlFd1AyYzY9q7A8GlfTPw+ybQLBhkYo
         o2geXiaCb1UiYCTRj2azaH1kTYLzq62Q9gBKZRWuUicGxLnyu/jxN32xbVG9iUzyAh4y
         H7U65rDO9gtg9yFxziPZPjMEXSiNPfAi8Gz79dQFPx1fNzeaKqeW470KbT7fd9mM+l7b
         DE7A==
X-Gm-Message-State: AOAM5329xTmVSqtbKMrsd8Bswxz0UT0SytcX3ZFAyCHxWfVn7vJh/al5
        sl4tcYUrnM3I/HvfkCnwBuZEV1HpkqtCnheM4Hd3
X-Google-Smtp-Source: ABdhPJxI4rMGlKtA+XXKxz1Z7iAglwLRN/JytqM/Yaf6FmF+vk8PgomBM79UxeXQCK82ovvLJdDWTdq9cOLYjCuq4y7u
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:f65:: with SMTP id
 iy5mr352301qvb.32.1614212833596; Wed, 24 Feb 2021 16:27:13 -0800 (PST)
Date:   Wed, 24 Feb 2021 16:26:55 -0800
In-Reply-To: <20210225002658.2021807-1-axelrasmussen@google.com>
Message-Id: <20210225002658.2021807-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225002658.2021807-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v8 3/6] userfaultfd: hugetlbfs: only compile UFFD helpers if
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
index ef5b55dbeb9a..7e6d2f126df3 100644
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
@@ -310,6 +312,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	BUG();
 }
 
+#ifdef CONFIG_USERFAULTFD
 static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						pte_t *dst_pte,
 						struct vm_area_struct *dst_vma,
@@ -320,6 +323,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	BUG();
 	return 0;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 					unsigned long sz)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1d314b769cb5..9f17dc32d88f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4626,6 +4626,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4756,6 +4757,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 				 int refs, struct page **pages,
-- 
2.30.0.617.g56c4b15f3c-goog

