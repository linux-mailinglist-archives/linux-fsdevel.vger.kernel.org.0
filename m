Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F2A3661E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhDTWIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhDTWIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:08:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D27FC06138D
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k5-20020a2524050000b02904e716d0d7b1so13313404ybk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BHYviFd/YPB5fVcgCUB7J8bATrNglnMGKIuCG5hxWmE=;
        b=F0MCudZTC5xOkb1RbDntraZ92HIBRT2ez5Xhnsp+DXLuS8Ep5h2F99v8xIdO5zxY1b
         Ofcj74faZHlYP3e+3wnOZD5ZfzF2jLBMby2Jeiefq2bLIQsWDk7/JWsoMukk7UYrpSyV
         nKtYxWXQfTaV3Qb7U4U55Mf1pliJt3K1GW0Xy+qcsjJVyUQxYiAzbRCpwE5AzkhugM65
         dUWgT4kjntrfbW0RMCruU2f51LKy6LcZBAM2caerJaeA0zjRANie+zQxZlILDItwLDj1
         Lrk57AR8MByVdyJgsNEH6mrlEeMHKFgKXZ0fckx77ByEyHiS6pOa0GxHKc+5Bvhh+cqX
         388g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BHYviFd/YPB5fVcgCUB7J8bATrNglnMGKIuCG5hxWmE=;
        b=I2JCvHanOjN9qDXTj1kuNAC/OyI2tp6Aopm0QjLmyvxYu/B7iHEtZUjniemOBM/FDx
         UbP4ALYmkzS/yrhK/qlIm1HVdiClqh0t3fm15z9iZms3G4Bh189dvbzI8VECsG/Ia4JA
         y9Z94bHDnLbCL7Pq0SS4On0MlbicDD2M2/Eb2lR+66Gbzc3YLRIOvBfgSkwk+Tx1hTGf
         HbaiXoL55X687PJsZnP4KPQ8JmMtcjW6O/tuF5C3BWc9vTbEnR2sAU7AeJUn22QMwA+l
         WlhHJZZ4spvVnvgmo09CUBhxsTqBH+YmhtF5dddyRefbKe6Muwl6jyfWG/VEfHdo5N4W
         6efA==
X-Gm-Message-State: AOAM531ASrnvAQKrLJAR5tIFCd3whDvnH48ogo6G67pxdMTn3hL6Wy+K
        UH0P8ssS3p5RUpzBTNuz8DfkIsGU77FoDOxbKMBV
X-Google-Smtp-Source: ABdhPJz8msn+LFt/WywuGSj91p/Qsj7QaNCaSl+USoDSKPtsRqeJe36wlMPHaxC+iC+8Fegj3k+3HwnxarEYbn2SCSQE
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:bd83:: with SMTP id
 f3mr27137266ybh.29.1618956489545; Tue, 20 Apr 2021 15:08:09 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:07:55 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 01/10] userfaultfd/hugetlbfs: avoid including
 userfaultfd_k.h in hugetlb.h
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

Minimizing header file inclusion is desirable. In this case, we can do
so just by forward declaring the enumeration our signature relies upon.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 4 +++-
 mm/hugetlb.c            | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09f1fd12a6fa..ca8868cdac16 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,11 +11,11 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
-#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
 struct mmu_gather;
+enum mcopy_atomic_mode;
 
 #ifndef is_hugepd
 typedef struct { unsigned long pd; } hugepd_t;
@@ -135,6 +135,7 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+
 #ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
@@ -143,6 +144,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				enum mcopy_atomic_mode mode,
 				struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
+
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 54d81d5947ed..b1652e747318 100644
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
2.31.1.368.gbe11c130af-goog

