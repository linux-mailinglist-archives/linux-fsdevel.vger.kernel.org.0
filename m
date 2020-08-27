Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D412548A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgH0PKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgH0Lt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:49:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD0C061239
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c78so4563565ybf.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W92EWp10cYvF5yPv3rgiIaePnIXh3IWgRNGaRIqgcR4=;
        b=ZeJkuoAcd8dJY7+fCilJDkM8V8M3SmcWQgU+So846yMM9f6jM9riCbwbPfREaF0dY5
         azjiHNKp8O7adw/N9CKVBPXtpdMW0qDR/FRcGjNgwiA7Xg4YAVSd/KrxNo/DMShAhT2R
         gvt3WhIEAlZTrCYDYGy9B3J/DwPtkqHRIFxRzdItRltKvJZQ6pF8lrkxptpCzwuOFdYe
         UxEuUIK+0+Pu7M6s2hyfeNVbO0IZ3zA1ZSkfIAezur4pqLLvO+lceOPtxc4LafsGYadB
         YDTG6C+Tz8L/0lfYzwSactKMTE8n+Q1nBDRoze+VAVJKqPB+hOKuq88CjDzXHrCFqY/c
         nb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W92EWp10cYvF5yPv3rgiIaePnIXh3IWgRNGaRIqgcR4=;
        b=IzL+EmX+49eluWdL+coRw0bXki4t9zWwHZ0jL968Wpoc7TmQsrqEt7SFbGUzyIFlKw
         h+9hM1sCd1fvh5hCIFT1uSCyMjWeWHeLbpBKRxOLKJUvVkBHqZuLwAGho2rYijgbTX0W
         FQ0UcqyWlPeeLUf0vRMr0K1fyvqQ2LQz4xKGiarUFmNicfqK63dsce0pweHnvyPBc0Gu
         vleDzBMgo2X3js5b28rjyolJk5n0iz3j2F8d6IsT9+MzVWJSz+zEI7tS/mxTq5kvnc3C
         x4rtVjAS7XJUfBbELCbnLyUBvlzJNyRp6nUzuyh96sVX0LYQI+3bZx4k2FNiCUygTvpA
         7DpA==
X-Gm-Message-State: AOAM532a/VnuPvzzpT6lWiJBrxeKJnf5Kl+r5Axu9DrwADjw0+DaYnGT
        ikVqNXqevxzcksFxQurO5lZM8J4rRw==
X-Google-Smtp-Source: ABdhPJxBMYeNdBT4AqELwSCvlFMkpdIbIdV0PyZym4hTP8g2vL+hg+JfUQWtBxMn/GgdmqZygND6iAfo1A==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a25:14c3:: with SMTP id 186mr28815290ybu.114.1598528983701;
 Thu, 27 Aug 2020 04:49:43 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:26 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-2-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 1/7] binfmt_elf_fdpic: Stop using dump_emit() on user
 pointers on !MMU
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
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

One small change we have to make in get_dump_page() is to use
__get_user_pages_locked() instead of __get_user_pages(), since the
latter doesn't exist on nommu. On mmu builds, __get_user_pages_locked()
will just call __get_user_pages() for us.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf_fdpic.c |  8 ------
 mm/gup.c              | 57 +++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 50f845702b92..a53f83830986 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1529,14 +1529,11 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
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
@@ -1552,11 +1549,6 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
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
index ae096ea7583f..92519e5a44b3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1495,35 +1495,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		mmap_read_unlock(mm);
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
- * Called without mmap_lock, but after all other threads have been killed.
- */
-#ifdef CONFIG_ELF_CORE
-struct page *get_dump_page(unsigned long addr)
-{
-	struct vm_area_struct *vma;
-	struct page *page;
-
-	if (__get_user_pages(current->mm, addr, 1,
-			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
-			     NULL) < 1)
-		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
-}
-#endif /* CONFIG_ELF_CORE */
 #else /* CONFIG_MMU */
 static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 		unsigned long nr_pages, struct page **pages,
@@ -1569,6 +1540,34 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
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
+ * Called without mmap_lock, but after all other threads have been killed.
+ */
+#ifdef CONFIG_ELF_CORE
+struct page *get_dump_page(unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	struct page *page;
+
+	if (__get_user_pages_locked(current->mm, addr, 1, &page, &vma, NULL,
+				    FOLL_FORCE | FOLL_DUMP | FOLL_GET) < 1)
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
2.28.0.297.g1956fa8f8d-goog

