Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6535906A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhDHXnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhDHXnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:46 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C0C061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n15so2099997qvo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vPRUOYIolP6Zcf38F8T1KJCfFhHdJ3+UjhE2Kl0rYHk=;
        b=quRxZdtCDPR6OhkaUBqKezAnyT6r8AW9F0E7tfBCP1bYDJm9ipupmhQTfWf9kyG8xt
         m+SRz2SscoDX7EKEaGoKp6HuzxgAH9yyaAZnP1bqfMzue9WosB9yW8iN1l8qLendN2u1
         SajVcyh9h5+huUD1MAQQtB5RQml42Fd9SPwoJOUPopR/TD0Rb1xJKaaw7UHHj8+VQOHo
         V90Oya1oHmZ/yMZm3KOejvvgtvJeOqsPh/uMFmWHV6u4s66e2Oj6tsTt+PntFWwuwGbK
         U1vk1/unTU4bvIaSYQBJUJ1gBFp0dRJM3bnsdhNxGOPJs+aWVKzxhR86usPdXp74qQBT
         OU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vPRUOYIolP6Zcf38F8T1KJCfFhHdJ3+UjhE2Kl0rYHk=;
        b=GkQzZa7lzfhRXulBbElDgkvg4SDWFpfFTae/Q9VPWWgOmRSKY97LFi8UFFUgCU5odG
         i9SB+7V/JIcw8pIPovB+i2P1zbQ/0nDj718xhQP1vTs6JH7k1RGfGl0pxS1q8qCa5V4C
         wQMuioeGIp88pXl2rLfJ7d0RfaCSqO8T5MKboCColyVVTsObHpPIsHuUoxdPnyY/k3dZ
         fXJxNH/z2WC53ygbqcyLj6tt93tlMdhQJo5RTTL/Km73NoCHjeFgGmuJMwAg7ptadp5+
         9vXFMSdk/RLSMeH8FwiBCbvZW9iB5VQNBgtW5TUoeaQCYIlNBaPnFblUPUd8dArAXgx2
         BHMA==
X-Gm-Message-State: AOAM53058xTimx/+BDPD4C+z7Yb1kzdn3TKetcy/oG9bgCIxB2TNnMNC
        4wC+PMdo3i0t92jhs2ReawC0b+iNB5PzEINAZNCK
X-Google-Smtp-Source: ABdhPJwULITQJfoF7WCDXR8cK9vKqqgb+uM2S+dG1ktXyeGLc7FDRrwd7Mn2cbdmOUuWSvSi21YeCNDU0IeWdmpFA6Zw
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:905:: with SMTP id
 dj5mr11624979qvb.34.1617925413457; Thu, 08 Apr 2021 16:43:33 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:19 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 1/9] userfaultfd/hugetlbfs: avoid including userfaultfd_k.h in hugetlb.h
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

Minimizing header file inclusion is desirable. In this case, we can do
so just by forward declaring the enumeration our signature relies upon.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 5 ++++-
 mm/hugetlb.c            | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1d3246b31a41..dfb749eaf348 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,7 +11,6 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
-#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -136,6 +135,8 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
+enum mcopy_atomic_mode;
+
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
@@ -315,6 +316,8 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 }
 
 #ifdef CONFIG_USERFAULTFD
+enum mcopy_atomic_mode;
+
 static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						pte_t *dst_pte,
 						struct vm_area_struct *dst_vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9973dec4976c..3b93bbf8c80f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb_cgroup.h>
 #include <linux/node.h>
 #include <linux/page_owner.h>
+#include <linux/userfaultfd_k.h>
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
-- 
2.31.1.295.g9ea45b61b8-goog

