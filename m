Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8331F368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 01:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBSAt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 19:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhBSAtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:49:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB8C06178B
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v62so4758881ybb.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YLKfreZGzyZ40jYkVyobB++yF7t36mvNO2MMRpwh5Mo=;
        b=F4rL2A2y6KkWrRZM1eunAfZ6lX3wxUBY3Z5h/OvEQbyVHGWAtW/3Tv7B/CTvrAn88U
         A8zfJtjMObPSWcfj9JseIqRUr9CRg8KvRJ/3pjfLJ+2n6bVGaqBno1fxQ8EWEH0uWEKw
         z2yiTf6S2c+20JX3TDyn9BesfjLoAs01udHYlvJgVi+8GxOVQpag3XizNezw2TUslLiA
         un+PQtagO3sgc8GwBE6h7F7t7Ergl8BWVVhOuhS2b4ScNVTGjKWrZGSL+YdRiLbAnyQs
         YJ3v2oyDOGE9X3DUEBCdZFyRi75K7lnWpEpx8kHAGI4118OEcF4fi8iyWCsDmYeWfXs1
         +p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YLKfreZGzyZ40jYkVyobB++yF7t36mvNO2MMRpwh5Mo=;
        b=BTYP3D9BY1dBeLXIUU7/5yV2jxI0GyxXasinrri+WFo3kPe+Ib2sEBxKi7qjheL1lz
         ESqnspBjUN/VeyrwqMzbEM6ZrE3snoFd97BvL+2inCw56Ie3hBhN1rAjRlHVlnontCJ8
         B3k8/UxB9dmtsLTpzwkDXqXAUqj6z9A4vIB/gdv9hlIqUnMgpF6BHzVwdSe93QO0AxRW
         lP5k8b3gcCBElp6xduAQfmaFRrdKh2H9drpuspqY00cQ+8pmQLDH3ftNlq39ICF0xItp
         WIlEQLIejwJDYjCFYwsyOs2X7kVgd0xupSxAy0fJZVJ8mVktO5knSGB3llkXHe7v69CS
         pt9g==
X-Gm-Message-State: AOAM533X0uXvglT9GAZQBBCLWTqTfxIbiy5vF8YBdSzyO3Xc7f6kejbM
        QOOZ+aWs8mxp6MXDyDnYG8NKqCfu8Or6oqgS9Ecs
X-Google-Smtp-Source: ABdhPJwHe7ylZl2on/KsFZVdo/aHg5L+jaRYxKr0V6jzS0peur4L2JajrBymMRQF219orA8Ci21f0SwzqyQIX0Ql7AX8
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:e939:4cce:117:5af3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:7784:: with SMTP id
 s126mr10722976ybc.475.1613695717644; Thu, 18 Feb 2021 16:48:37 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:48:21 -0800
In-Reply-To: <20210219004824.2899045-1-axelrasmussen@google.com>
Message-Id: <20210219004824.2899045-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v7 3/6] userfaultfd: hugetlbfs: only compile UFFD helpers if
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
index 0388107da4b1..301b6b64c04e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4624,6 +4624,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4754,6 +4755,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 				 int refs, struct page **pages,
-- 
2.30.0.617.g56c4b15f3c-goog

