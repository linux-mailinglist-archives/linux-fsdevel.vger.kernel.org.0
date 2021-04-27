Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8236CED2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 00:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhD0Wxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 18:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbhD0Wxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39CC061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id f17-20020a05621400d1b029019a6fc802f7so26838714qvs.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FTz4sAVELY25ur3y3zh25/LIVC29V1NHLernxhEpksk=;
        b=LxAPGHlGbrMgunid1ooA/vjrhhJR5oSB+V2PhBO7vBjRAXFyX8DWethZ1rjPIvogiO
         3UwIk1zUCLOAMiY4/PmRvwOoVLheBXoQwG7UZX9u3Bf1HPevTflZv9dRPMSSNpiAAyMV
         fCsIwpKNi9Uw6beNh6QPWFzv9C0z1hFKUfzfwzJZUrPWB00iztOfGRZfEUisaYCRuYT7
         2VidqwCMATurBcu0zZGANjzuEM0Cw/85F6NUT6xNQdOyZk4eFsbrq6J8G/LwOGeeT97Z
         dpoH6xE/d1eRt8vgUcLSoH63YYCtpMQob7IWacFFAms7WAbL0EYHcKw0DL8th1LsUw6T
         UZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FTz4sAVELY25ur3y3zh25/LIVC29V1NHLernxhEpksk=;
        b=tLx5eh6VubnkRE8VqTBxHnGDu3Wn/s7PbJynwe5/KaQj2WpztJFfT9aYVMBPDFQLCH
         CQnut8BjhZne7dtMvnWhaXI8XTg7afdCGOYt8/YivI43TBDCvb5FNszYlinle/UdpBWU
         IW+xyMwzJuJUqCj06j05AfodXXPAZ8MWIkoVd85NgqGkhT0FgkluDc2Y+RT9CC+vz/Un
         DBH3KCP4iTPpQkV70IXv7eldiWV/YbGkWlh2D2vWqcsw3B/jT2ODe8PXAQ9y221DuuV9
         GlV1yT4oMLCXM655L1ymzJmAddn503+FfRj+YB5QBjF+stU3pD8OGVb/IfQ+kgoqNgKz
         KAhg==
X-Gm-Message-State: AOAM532QO/j9q0g0Yoox8fKfPEQudDieAUaRCC1i0s0+uhgRAm8RDHJz
        2zvgSU1ugi6c8DKb+vbEFAtGUEEE6SlrIRMDD88u
X-Google-Smtp-Source: ABdhPJxXNFdTX9Ek4gXlmyQ5HP6m6zy9X1v0lDV+9qBphMCOd3Q9ReUv6ac1b89nerJIEoBK/BbaxwJOd7eqNvRRd/dl
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:eacb:: with SMTP id
 y11mr25998072qvp.57.1619563970289; Tue, 27 Apr 2021 15:52:50 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:35 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 01/10] userfaultfd/hugetlbfs: avoid including
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
Acked-by: Hugh Dickins <hughd@google.com>
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
2.31.1.498.g6c1eba8ee3d-goog

