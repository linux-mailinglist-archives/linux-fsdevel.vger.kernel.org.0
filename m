Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0619725334A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHZPQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHZPPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:47 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70110C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:46 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id fy10so1139063ejb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=37TD1tOgbExZK4EAyJ2auNMattkG66IuBeoEm2InRhU=;
        b=EJaKPT+xdclNdzHyydB1wtD1f+JDKjLl0qDGYs/FfexMadEImdY6NbC9BpnQwNrpHM
         LkUSZYbx+9RUly980dt+z2mRNdOG3IbnwGhnUj4glyILCZ0N/jYte6+8NS03h1RlX0rd
         r3CIvAT8ajv3eqk1/JhxLYJIpzv+WTIYy/s8nkt7JCLLVf+OzXJ4bU+ZJ6YOy5JMa0Bk
         dXb+vpQGMQ5fMAY6yR2HvUUdC5QYsUzGd5rj4FciLVfkj7Tk8ky3X2ORz+eBuBCOUFkK
         T4TQvr1uvJ3sLQaCBbckv5jnLmhBWKh9jmcLxktaFyzUL50NN/IE0SwiX2wWUc7MHUtk
         MSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=37TD1tOgbExZK4EAyJ2auNMattkG66IuBeoEm2InRhU=;
        b=hHNFWREdghZXNjipwYvLTZ8RdKWX+lT+2yb8RHu0JWsD48y2zmrYgzcbGt9faj/0o9
         6dqoVrieMN20JFsWaoyvuhprdqSuygWrzcIrCRHh/0nNyIA+n4Zw2BqjuMQjvty+HUUn
         pWNfEE7xv+nFWfXQDSq03IHHhSg8UcKO9JlH2P+a5ukb/3yGse87HAuTUi+mCUCRWTvS
         GinapGGts+lszj521GfWagAnCvUXydTrHPUmP8GiBRC+OBmkq17lHSPpsP8fdtRwMH71
         lnfNONpC9IOiSrp2VvnmNrvu7g53YdhyU9a4vGisSyFydnm4/BaasVFpzUSm5JPfdy7f
         k/FQ==
X-Gm-Message-State: AOAM532AGYc+hB9JaNc1dkGEidfwv8NEt9Xs/ofG24GEaVhzu0qU/KWJ
        u3SH6N7z23ftPlJdrmgtecO+IMGesg==
X-Google-Smtp-Source: ABdhPJzt8BeQRY53dXQK6w4X+lfLoMxsOd+cnH57xkDOTHWo+hlkWgtx2J1Byi3ymA4q0Sa382PLimiVAw==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a50:fe17:: with SMTP id f23mr13811629edt.364.1598454944949;
 Wed, 26 Aug 2020 08:15:44 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:46 +0200
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
Message-Id: <20200826151448.3404695-4-jannh@google.com>
Mime-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 3/5] coredump: Refactor page range dumping into common helper
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

Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
into the coredump file. Extract that logic into a common helper.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c          | 22 ++--------------------
 fs/binfmt_elf_fdpic.c    | 18 +++---------------
 fs/coredump.c            | 34 ++++++++++++++++++++++++++++++++++
 include/linux/coredump.h |  2 ++
 4 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13d053982dd7..5fd11a25d320 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2419,26 +2419,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 
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
-				goto end_coredump;
-		}
+		if (!dump_user_range(cprm, vma->vm_start, vma_filesz[i++]))
+			goto end_coredump;
 	}
 	dump_truncate(cprm);
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a53f83830986..76e8c0defdc8 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1534,21 +1534,9 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
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
index 5e24c06092c9..6042d15acd51 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -876,6 +876,40 @@ int dump_skip(struct coredump_params *cprm, size_t nr)
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
+		 * ranges that have never been used yet, and also to make it
+		 * easy to generate sparse core files, use a helper that returns
+		 * NULL when encountering an empty page table entry that would
+		 * otherwise have been filled with the zero page.
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
index 7a899e83835d..f0b71a74d0bc 100644
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
-- 
2.28.0.297.g1956fa8f8d-goog

