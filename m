Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3E1BB49A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 05:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD1D2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 23:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgD1D2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:28:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5DEC09B050
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so23279179ybj.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I4RZCdzOpcoMpbDN2LqRR4S1SmcrD2Kj55dT+NEDBbE=;
        b=X8ZXo00ljasm7AZ1Els7stZGHbJUjQ3cYCjBhSxX4NYkV1i4GJ8fn/Dn9b7txZrs4Y
         rk4PVdLrWzKGTy55PbNAV14mS8eAapCE7OP5rLPuuiM96DTFmYOd2R8B3N+gg8WSfGWv
         YySTyNNFFpF2KM5Vtkzo4AKQytmhpqKUa3MnS/7ninMjf0Ix4zkRnSJbjAH3lccQA0+j
         z266kabr7WqjlEia0jfQlMB5LrckgW/C1smlQe3Lthb8du2UNtYHiw6qieDHzFuWydw/
         71omd7lOenbwJeViL3RPuetWYMY3l4GO7BSCZeqf3sihWLUx95KaDb3dnQkMoSwjUg3f
         4X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I4RZCdzOpcoMpbDN2LqRR4S1SmcrD2Kj55dT+NEDBbE=;
        b=fJL9CC4p3PH3jz2lBBqphcv0a/3rxttj0joaFKRXM010rr0kmS5g7aCS6WuYrRfdC3
         K7E0nvrxTYJGLuRxnQE3lwXebtZ1kk37kViMMjoYMHi4b8cd1zkiJOu1E+PKx+2uK+Ml
         +mtv8tyS/sUahxspoKuj5inRP9tbRnBe0+dVrF8u4r7ODjsvhzAZm/T+CES1kgKigib0
         S1A1plGnohbTs+ovWUzF98hvwl64nxQQEi3prwgJLUe4pjZRkYwh7gsD7UdMJlZe2RuQ
         k+hJqczI/vUsQsrk3RJmo9sOAkfZC5fveX28hoclool6jvw1S25UGi8ZcjDxKOx5E9W8
         sKEg==
X-Gm-Message-State: AGi0Pua8eZGAToDH10nJihVAISR/NDfUK1p6cYjarlCE9FYU+cKI+2CO
        S00G76LSHtiH+IqldwAKvhqqbnMrUw==
X-Google-Smtp-Source: APiQypIcdn/JR5PlTDtT8WHtlwDwffUFy2NKOR9VROQaek1qOXSfTSnx9Q8ThU+1UmQujkYLWnXr/liimA==
X-Received: by 2002:a25:c402:: with SMTP id u2mr41378105ybf.82.1588044481799;
 Mon, 27 Apr 2020 20:28:01 -0700 (PDT)
Date:   Tue, 28 Apr 2020 05:27:41 +0200
In-Reply-To: <20200428032745.133556-1-jannh@google.com>
Message-Id: <20200428032745.133556-2-jannh@google.com>
Mime-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user pointers
 on !MMU
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dump_emit() is for kernel pointers, and VMAs describe userspace memory.
Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
even if it probably doesn't matter much on !MMU systems - especially given
that it looks like we can just use the same get_dump_page() as on MMU if
we move it out of the CONFIG_MMU block.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf_fdpic.c |  8 ------
 mm/gup.c              | 58 +++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c62c17a5c34a9..f5b47076fa762 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1495,14 +1495,11 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 	struct vm_area_struct *vma;
 
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
-#ifdef CONFIG_MMU
 		unsigned long addr;
-#endif
 
 		if (!maydump(vma, cprm->mm_flags))
 			continue;
 
-#ifdef CONFIG_MMU
 		for (addr = vma->vm_start; addr < vma->vm_end;
 							addr += PAGE_SIZE) {
 			bool res;
@@ -1518,11 +1515,6 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 			if (!res)
 				return false;
 		}
-#else
-		if (!dump_emit(cprm, (void *) vma->vm_start,
-				vma->vm_end - vma->vm_start))
-			return false;
-#endif
 	}
 	return true;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 50681f0286ded..76080c4dbff05 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1490,35 +1490,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		up_read(&mm->mmap_sem);
 	return ret;	/* 0 or negative error code */
 }
-
-/**
- * get_dump_page() - pin user page in memory while writing it to core dump
- * @addr: user address
- *
- * Returns struct page pointer of user page pinned for dump,
- * to be freed afterwards by put_page().
- *
- * Returns NULL on any kind of failure - a hole must then be inserted into
- * the corefile, to preserve alignment with its headers; and also returns
- * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
- * allowing a hole to be left in the corefile to save diskspace.
- *
- * Called without mmap_sem, but after all other threads have been killed.
- */
-#ifdef CONFIG_ELF_CORE
-struct page *get_dump_page(unsigned long addr)
-{
-	struct vm_area_struct *vma;
-	struct page *page;
-
-	if (__get_user_pages(current, current->mm, addr, 1,
-			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
-			     NULL) < 1)
-		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
-}
-#endif /* CONFIG_ELF_CORE */
 #else /* CONFIG_MMU */
 static long __get_user_pages_locked(struct task_struct *tsk,
 		struct mm_struct *mm, unsigned long start,
@@ -1565,6 +1536,35 @@ static long __get_user_pages_locked(struct task_struct *tsk,
 }
 #endif /* !CONFIG_MMU */
 
+/**
+ * get_dump_page() - pin user page in memory while writing it to core dump
+ * @addr: user address
+ *
+ * Returns struct page pointer of user page pinned for dump,
+ * to be freed afterwards by put_page().
+ *
+ * Returns NULL on any kind of failure - a hole must then be inserted into
+ * the corefile, to preserve alignment with its headers; and also returns
+ * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
+ * allowing a hole to be left in the corefile to save diskspace.
+ *
+ * Called without mmap_sem, but after all other threads have been killed.
+ */
+#ifdef CONFIG_ELF_CORE
+struct page *get_dump_page(unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	struct page *page;
+
+	if (__get_user_pages(current, current->mm, addr, 1,
+			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
+			     NULL) < 1)
+		return NULL;
+	flush_cache_page(vma, addr, page_to_pfn(page));
+	return page;
+}
+#endif /* CONFIG_ELF_CORE */
+
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 {
-- 
2.26.2.303.gf8c07b1a785-goog

