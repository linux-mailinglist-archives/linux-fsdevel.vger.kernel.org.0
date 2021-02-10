Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04B317241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 22:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhBJVXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 16:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhBJVXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:23:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40717C061797
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f3so3341110ybg.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kRLvf5vB2B94MhwPO7YYUfOHDGsbQJYHHOHVbPbULhQ=;
        b=FPJevoAJFyG+2uKP9uuRxeJqwQH0ur/iaVusoEkhj+Bx1UOrfYY4W0hIBsBHbi8mJa
         ywbdhSNJ8URBIRJCjcDmHuT/8bF2lz4Vrz84wFXdly/P4Y7I/5G6lmOGT3uYbh0izi7N
         AhOapE/YgFzOq+U0zEMUb8d5rCxVGQuZGM8ude3fAuV57d2q/D/CSfObtdmlzQGn5IJM
         rDv13Qw7OPnQ+yEXQOxxakvNGpKvQ9GMQNmJdXpXmquGIzXxP0+9UlU2yThBA1aG/3+N
         OE58db/Uxlm7iuU88EwMxaj95/Xer1iz4mBM2GuRHTFCn96cYPKG2uCruk4Cw7q1ffiE
         JgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kRLvf5vB2B94MhwPO7YYUfOHDGsbQJYHHOHVbPbULhQ=;
        b=fo1ckIzmd0+cKTBgbhwxAbIBqIrSviFrp0vSrs9QMmEQk50GwRmWCeqm9DF2S8qKO3
         CHIoNcYxUt4QPM5vVq/S+zuwvWrTSi7w8zbPftmvI9s/VaCK5UMp5xGGaDI7jdx/yklM
         JNCcoC/UBTrADppwIR9PgqgJt3KxxRNo8JWQSGGTxGvu76yA6qS/KxlJG79TijY6SeOb
         /W23xNe8I4goeWZrWZaK8yR2J30NLxM0/AFXkN2IJ5SZO6gaxWjVWmp1d7TGosCTk8TN
         5/izQAffMHExp/jOfq7UYTKwELZKISCL609bETC9C4rKm4WJHoZZF98AcryuiatS/CB/
         8t6Q==
X-Gm-Message-State: AOAM533+gJ6JttMx4GRrA31bbn0QpQ4SBpVnsyzpUhVZrEXmE8Tbjrw9
        9loMXQx4rDH5bKWwkRxDK8y8AHWgF6ae2oNFlbvY
X-Google-Smtp-Source: ABdhPJzivwv7nrvj/6gKQpL2deLi2GknHBT0JPsZvkOHwJjXUm8Le+xrGfh3pQch1ITq0xsAmLz7ScL4fd62Gprhfb+S
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:94ee:de01:168:9f20])
 (user=axelrasmussen job=sendgmr) by 2002:a25:1188:: with SMTP id
 130mr6923358ybr.138.1612992132408; Wed, 10 Feb 2021 13:22:12 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:21:53 -0800
In-Reply-To: <20210210212200.1097784-1-axelrasmussen@google.com>
Message-Id: <20210210212200.1097784-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 03/10] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
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

From: Peter Xu <peterx@redhat.com>

Prepare for it to be called outside of mm/hugetlb.c.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d971e7efd17d..d740c6fd19ae 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1032,4 +1032,12 @@ static inline __init void hugetlb_cma_check(void)
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5710286e1984..e41b77cf6cc2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4927,14 +4927,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
-- 
2.30.0.478.g8a0d178c01-goog

