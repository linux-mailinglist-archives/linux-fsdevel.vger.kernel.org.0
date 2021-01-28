Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6904F30817C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhA1Ww0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhA1Wus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:50:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE91C061793
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 33so4882370pgv.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1emyqdFZVCXAT6rTF3qK5V6G85egQi2sq8wmP9IwMVM=;
        b=MXK6OLFrEwQXO2YXIDCKrYrqQU0p23E8NbH13hMb1MKTaIDOmtNbiJXDynuZXIWU+J
         CZz0tqM1e1C0hVXGiVA16Y2U3CW7cDG8ob9xyuQi6o2VYUXDFRaZZ+Y0NbagMmtBo1Yg
         UbqJm7XQqA6X98024gvHfReNBimEqhXmvKE9z4pxe+5o1/z3P+GiYOOJbojW1fd+DQmp
         zQG+GtIlAQWMFXhFx1Lrune47/qQkHdKo8goSTH44aR2uPoCtDNUKSMRCrXcG8JdKy04
         IQ4rFBC3uNNzpmC1Ax2QVykwy6PKTdrqeABIiLdfL71vDtgSeAdvuJpuO0CwbGP/NWKy
         SC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1emyqdFZVCXAT6rTF3qK5V6G85egQi2sq8wmP9IwMVM=;
        b=kFw1YEjn7NqFFgt4lRh5VlyIYZgICNsq4LNxIsLN2G+s9Z3oUHECRKzJuQCd/GQB8Q
         ztKPJxhZL2caNulaq3xB+lQrVlLU59JArs9Rw9do2uGI6LfJK9zRJ+NJ14fBUwJl5Amd
         j57SKZIDxOP6oFRz6vs/pHPp0m/FrSSCLKN3nQ1Ah9Jaul0EH0EdsppZK7QhM8qwtPtF
         a6Fl8K07X5l0xCiu4KFREfiy9yRBoOUKKfY9+Qcf0NJEqKzccwasrunfWHstAOXsYcet
         tb1GSxmeKbHNnZkmfNo/zsV0kLHpfXQyd5SOZynVmIQoeoR7iZbtl6p4gx7+Byx8EoWD
         KLbg==
X-Gm-Message-State: AOAM533SfF/GUXFTZLInIN5hhL5FfTCzKT/6YBQtZJLy1pf/EGIt8KQt
        a60xsszRClhkJGk/QhphvKrAwCfxoN7NxdTdZ2RC
X-Google-Smtp-Source: ABdhPJy2AWzpjbkJyC9BUFrsn7a8+arXqW+pyqWvvyOr+EhpF0/Cpbfcd+FemA0g7l8T/FJG3kizRtfZGkYBXn0pkSiK
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a63:fd10:: with SMTP id
 d16mr1520502pgh.333.1611874113566; Thu, 28 Jan 2021 14:48:33 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:48:14 -0800
In-Reply-To: <20210128224819.2651899-1-axelrasmussen@google.com>
Message-Id: <20210128224819.2651899-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 4/9] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs
 when register wp
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
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
userfaultfd-wp is always based on pgtable entries, so they cannot be shared.

Walk the hugetlb range and unshare all such mappings if there is, right before
UFFDIO_REGISTER will succeed and return to userspace.

This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
is completely disabled for userfaultfd-wp registered range.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c             | 45 ++++++++++++++++++++++++++++++++++++
 include/linux/mmu_notifier.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 894cc28142e7..2c6706ac2504 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/mm.h>
+#include <linux/mmu_notifier.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -1190,6 +1191,47 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	}
 }
 
+/*
+ * This function will unconditionally remove all the shared pmd pgtable entries
+ * within the specific vma for a hugetlbfs memory range.
+ */
+static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HUGETLB_PAGE
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long address;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	/*
+	 * No need to call adjust_range_if_pmd_sharing_possible(), because
+	 * we're going to operate on the whole vma
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_HUGETLB_UNSHARE,
+				0, vma, mm, vma->vm_start, vma->vm_end);
+	mmu_notifier_invalidate_range_start(&range);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	for (address = vma->vm_start; address < vma->vm_end; address += sz) {
+		ptep = huge_pte_offset(mm, address, sz);
+		if (!ptep)
+			continue;
+		ptl = huge_pte_lock(h, mm, ptep);
+		huge_pmd_unshare(mm, vma, &address, ptep);
+		spin_unlock(ptl);
+	}
+	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/vm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+#endif
+}
+
 static void __wake_userfault(struct userfaultfd_ctx *ctx,
 			     struct userfaultfd_wake_range *range)
 {
@@ -1448,6 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b8200782dede..ff50c8528113 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -51,6 +51,7 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_SOFT_DIRTY,
 	MMU_NOTIFY_RELEASE,
 	MMU_NOTIFY_MIGRATE,
+	MMU_NOTIFY_HUGETLB_UNSHARE,
 };
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
-- 
2.30.0.365.g02bc693789-goog

