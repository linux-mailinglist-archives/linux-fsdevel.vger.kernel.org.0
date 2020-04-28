Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC131BB4A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 05:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgD1D2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgD1D2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:28:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF160C03C1AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f56so22878177qte.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JjVJ6bVnkDD22Kug2lLArucLeDH63cpRkRDdCvmUsgw=;
        b=sLC5sUwQCO5H8VpQfbr0H4yolym1MeU6fcyvl0GX1tVdSTKXplkYJVOUSPeObsdt1J
         JNFx6+q7V/UcdjF9kl6aGAwR+65DA5naHvrPlRhD9971fShW/szwPgWHYDi486Wz2jsk
         4n54HzCwbsCTB0brNiYnCd28IVesQuXtCTGd1S+kk4pCbbakqRMd6Yy+wfjsX6mVg9Ul
         5/piBlog/ScC96XdEuOmAWtCjjJytAI/OBS1H/Vf1cjHyX7mQZbuEwfvfZYYxbhWQwJV
         4OaucR4dIV8MFcI9nfy1JhV0PUihfy76zcj3UWEktQgJ9dZEPvmmOG5zdCRO4l3kcB+A
         iXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JjVJ6bVnkDD22Kug2lLArucLeDH63cpRkRDdCvmUsgw=;
        b=UbGwbih5RL6ti3lllHqHCf/GABdTB9z7SDahctern9ur5USwNAozVJ7WwKOhBBus5c
         t2R8SkLdwZQzGqM0v7J6DwfiVqDluVKoIsfesbBFjQfNdcEs809evLoHx+30Gzcg/kx6
         BeDc0sPBP3thqw1HKFtD9txy3R1dnBoevAk+NcYs2fG8WRXKzjDuVQjUOVgsn6hhok7V
         ZnnPT0OPHHIangfrd1hRuaOITQ3Ecn9a2LQp5bTTyLnhtrHbaYBibzsswkSDBinH9bqV
         q6NqJwLXG6ZhRJDpss8Ty2o025Mk4ib2SiQ6zNe3e8WxJqAgLH5ImMfZ7Iy45cpiTEkJ
         Ul6w==
X-Gm-Message-State: AGi0PuaNj83UhUPATUhAACjHCe491z0OFbG4dmzpdhrKmZE2vKGD7a1Z
        9PjgGyWlZjU7vdWuuE5L0kozvJhziw==
X-Google-Smtp-Source: APiQypK8E6BiAXKEVW3TpfVgfPj6v9qslU6kHK+WktRMaanVdj0UoaQeTgjCIkPDaA7t5NniPYjJ3E4kEw==
X-Received: by 2002:a0c:f1d1:: with SMTP id u17mr26207196qvl.146.1588044488930;
 Mon, 27 Apr 2020 20:28:08 -0700 (PDT)
Date:   Tue, 28 Apr 2020 05:27:43 +0200
In-Reply-To: <20200428032745.133556-1-jannh@google.com>
Message-Id: <20200428032745.133556-4-jannh@google.com>
Mime-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 3/5] coredump: Refactor page range dumping into common helper
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

Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
into the coredump file. Extract that logic into a common helper.

Any other binfmt that actually wants to create coredumps will probably need
the same function; so stop making get_dump_page() depend on
CONFIG_ELF_CORE.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c          | 22 ++--------------------
 fs/binfmt_elf_fdpic.c    | 18 +++---------------
 fs/coredump.c            | 33 +++++++++++++++++++++++++++++++++
 include/linux/coredump.h |  2 ++
 mm/gup.c                 |  2 --
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b29b84595b09f..fb36469848323 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2323,26 +2323,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma)) {
-		unsigned long addr;
-		unsigned long end;
-
-		end = vma->vm_start + vma_filesz[i++];
-
-		for (addr = vma->vm_start; addr < end; addr += PAGE_SIZE) {
-			struct page *page;
-			int stop;
-
-			page = get_dump_page(addr);
-			if (page) {
-				void *kaddr = kmap(page);
-				stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
-				kunmap(page);
-				put_page(page);
-			} else
-				stop = !dump_skip(cprm, PAGE_SIZE);
-			if (stop)
-				goto cleanup;
-		}
+		if (!dump_user_range(cprm, vma->vm_start, vma_filesz[i++]))
+			goto cleanup;
 	}
 	dump_truncate(cprm);
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f5b47076fa762..938f66f4de9b2 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1500,21 +1500,9 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 		if (!maydump(vma, cprm->mm_flags))
 			continue;
 
-		for (addr = vma->vm_start; addr < vma->vm_end;
-							addr += PAGE_SIZE) {
-			bool res;
-			struct page *page = get_dump_page(addr);
-			if (page) {
-				void *kaddr = kmap(page);
-				res = dump_emit(cprm, kaddr, PAGE_SIZE);
-				kunmap(page);
-				put_page(page);
-			} else {
-				res = dump_skip(cprm, PAGE_SIZE);
-			}
-			if (!res)
-				return false;
-		}
+		if (!dump_user_range(cprm, vma->vm_start,
+				     vma->vma_end - vma->vm_start))
+			return false;
 	}
 	return true;
 }
diff --git a/fs/coredump.c b/fs/coredump.c
index 047f5a11dbee7..3385de8a62302 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -860,6 +860,39 @@ int dump_skip(struct coredump_params *cprm, size_t nr)
 }
 EXPORT_SYMBOL(dump_skip);
 
+#ifdef CONFIG_ELF_CORE
+int dump_user_range(struct coredump_params *cprm, unsigned long start,
+		    unsigned long len)
+{
+	unsigned long addr;
+
+	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
+		struct page *page;
+		int stop;
+
+		/*
+		 * To avoid having to allocate page tables for virtual address
+		 * ranges that have never been used yet, use a helper that
+		 * returns NULL when encountering an empty page table entry that
+		 * would otherwise have been filled with the zero page.
+		 */
+		page = get_dump_page(addr);
+		if (page) {
+			void *kaddr = kmap(page);
+
+			stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
+			kunmap(page);
+			put_page(page);
+		} else {
+			stop = !dump_skip(cprm, PAGE_SIZE);
+		}
+		if (stop)
+			return 0;
+	}
+	return 1;
+}
+#endif
+
 int dump_align(struct coredump_params *cprm, int align)
 {
 	unsigned mod = cprm->pos & (align - 1);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index abf4b4e65dbb9..4289dc21c04ff 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -16,6 +16,8 @@ extern int dump_skip(struct coredump_params *cprm, size_t nr);
 extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 extern void dump_truncate(struct coredump_params *cprm);
+int dump_user_range(struct coredump_params *cprm, unsigned long start,
+		    unsigned long len);
 #ifdef CONFIG_COREDUMP
 extern void do_coredump(const kernel_siginfo_t *siginfo);
 #else
diff --git a/mm/gup.c b/mm/gup.c
index 76080c4dbff05..9a7e83772f1fe 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1550,7 +1550,6 @@ static long __get_user_pages_locked(struct task_struct *tsk,
  *
  * Called without mmap_sem, but after all other threads have been killed.
  */
-#ifdef CONFIG_ELF_CORE
 struct page *get_dump_page(unsigned long addr)
 {
 	struct vm_area_struct *vma;
@@ -1563,7 +1562,6 @@ struct page *get_dump_page(unsigned long addr)
 	flush_cache_page(vma, addr, page_to_pfn(page));
 	return page;
 }
-#endif /* CONFIG_ELF_CORE */
 
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
-- 
2.26.2.303.gf8c07b1a785-goog

