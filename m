Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDAF317242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 22:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBJVYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 16:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbhBJVXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:23:02 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A980C0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 124so2748599qkg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GZiDGzBZc6CdQco6utSqJxvMDhSmOX0vGMrGoDVipFA=;
        b=CSNZplzMVyec7GHEIAFJ1eRCsQNhOq/fj6tcy3OeZYMxVQ0KVyYmb0dTEK7zKHFTGS
         yebuUuuasp9KvEVUdZL5opsPRGziEruE1yuW80GOuHJd8OTK/AQMO0URaaXVNWOY9yE4
         XwdwtnodywYIMXJ5E9ykKtwlxvJbCfYQpihPabgZwv1gJm/69Elh2UqDmzr/MRnIhC89
         RrBQfdi3VBH3neG0sO+qFV+9OgWaH109CixY6+ca6R1+eIxQFqRkHSIbkvO6G12QDnrZ
         EclOhkjUfZdpL44LIIw/9EUTZdEtY13TGdzOUzevn0BlDx3rM1E1JbTX41JR1mf0SBsE
         zYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GZiDGzBZc6CdQco6utSqJxvMDhSmOX0vGMrGoDVipFA=;
        b=mMn6J2nVh29Ct052rcaohoi4Oo+JvdI47xIiwLC4EhB7cCBF4lIh2TBlWqPPSpvKQs
         xpGeUbshYk1/igCG0pfZLVAYnINvawLzDY35mbrpDHocSMkx/ixp6mUopoE9P9yswqNA
         z7jreAQjmsC1I6QTiuJIsZGrIEbedtaU+8eyxN0PxdID2gJeZJkAnh5ZXAtylQiDJpAW
         be7ob8KDXcOVOMxF/mmymEAMRxqL/5FjuF6ID1yzghsuYzlewR3Pd9fdSK7OiF1yNqfr
         XsV799LVv/B+qKfE6A9ivurswTyL0rdxwx16PmIUvY2ArNYVG/8hf/i/OSS++wv13mKP
         yF3Q==
X-Gm-Message-State: AOAM5306SzkrUuLRBVhKHMnIq8oVS+9L9iHydcVFy4I6nOgpYpqM9McC
        +9fsZCWLxhZE2ZeIoALoQHHw+D+a+y2b/6dkCg/Z
X-Google-Smtp-Source: ABdhPJyeUvHSePNxBk4zXDwQilv7B/ls1YQ+N4EzdaCrrLILHIqkJGtRKVUfnXXG71oYRXMNeelVp+MO89+DHWJBPIcN
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:94ee:de01:168:9f20])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:fec3:: with SMTP id
 z3mr4869971qvs.52.1612992134367; Wed, 10 Feb 2021 13:22:14 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:21:54 -0800
In-Reply-To: <20210210212200.1097784-1-axelrasmussen@google.com>
Message-Id: <20210210212200.1097784-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs
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
        Mina Almasry <almasrymina@google.com>,
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
 fs/userfaultfd.c             | 48 ++++++++++++++++++++++++++++++++++++
 include/linux/mmu_notifier.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0be8cdd4425a..1f4a34b1a1e7 100644
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
@@ -1191,6 +1192,50 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
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
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
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
@@ -1449,6 +1494,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
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
2.30.0.478.g8a0d178c01-goog

