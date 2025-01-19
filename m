Return-Path: <linux-fsdevel+bounces-39605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC00A16136
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFD318854EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0151AB6C8;
	Sun, 19 Jan 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYtK18WA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C613C80E;
	Sun, 19 Jan 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737282743; cv=none; b=R28LPG9/ThxCg3bmhzFK3KG89tqXKFd0WG552BwxqPS+tizW0IC0ZPVSQtUbBslIb5ru5hNXeIsKULCfDiXTE1jrOa5/pSVCf0CnMJ+nJ3BFHL4ksoYCZ6GAjZA4QuNgAdHd344dmINbJyeJoFdq2/EWIFQaeu3s/LR9R/vjl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737282743; c=relaxed/simple;
	bh=C1px8JJapmSFUy2oHrsC9B7E69dtnURw/kmkeZu/JcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqB3oG+bFp0MavRrALAUpqCnzOOnao894ViRY1dACzV/qo80WESCa6ijJcF/8qs/lsKVkqoNei3dyOFJ5rWk5uDyAiZ1Qxf26yhrdxupzUM8OycSiROlw9kMYKqFKDi21ZVdvNSELA1OUxq7Se63/JSPkSONFVIi08uSJK6zqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYtK18WA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so6429394a12.3;
        Sun, 19 Jan 2025 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737282739; x=1737887539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvHEce2KZ6M7l87KhRuxkVU7gcIO0QFn/8QdpwPork0=;
        b=fYtK18WAAhCB65xrn0TGU0CYHhoB1hx20cISCK166JJo2+QTKgn3qbQLhwZLnY7ttM
         PbvEgfMwP/1Hu6bsEQthKK01Vz9GjeqAFuEfBP28hdvDUN03plXeDr2+TtS8V6nRL6Dq
         eXJfZqql3WlhaFRS1aWplt+dnCq2wQs8QTgVyJaPgYd8rqa856iRnmF8O3Cxq4YtbFAg
         1RoPr5OQk8NeApqR0SCCV4qDKxIs9nnyoA6eT7v2bbBgCUU4r/LIifnhYV5xI2F+dl3R
         zOTt3TfNIF+Ax3tN/7k55y59/5JMGdivRZjnO5MhEJKTD+i5dV8taLmPrhIPORgW6ere
         pTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737282739; x=1737887539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvHEce2KZ6M7l87KhRuxkVU7gcIO0QFn/8QdpwPork0=;
        b=EcBbnBY+fe0DoUn52zxRgM/3BE3hIT5zatYqirByzRbdhKCJ++dSIgqTtYd78RIMwy
         JFRR8c1W/aITFJJino/lXDUHkz7aRgD/fdUxmQNRlEUfxOgUz9efC8oBcQTNRSuCEt7M
         UobedgOx6Xr5UXIq49c7tR51d7EPgzDDTNBhH7tytouQ6blVJEzmhuRSFAQwe0uCQ7AZ
         p0CizbzwGGVXCDjxLMHYtixb1WtBMGGn+JJCKAjhnuMUGQRDHwRWoM8V+j20+xGHLK0j
         FI8I1c/kGu3BL6XIDBZiulb/5JZRk17sXCnyv2z4YavWsEQhEVe+yZAxBCiMQZHbPT0M
         iZFw==
X-Forwarded-Encrypted: i=1; AJvYcCWEQ3QHdI2pU+Jjb4AEBaZitKhXvpxXb4xfcipien851ni0dlQ/gp83pI+36bZ4MvkH9g5/3MoC+YNF9Zmv@vger.kernel.org, AJvYcCXwX0wK1eEVh13d88l4MMuJ66Dj1ugXc95jmqJA3v3SiCRleLbLIDBQP37GYg7cXuHWHPIeIpHbd3/NELPM@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAWDs0Qn5G826L8mZQqfapVCFiYHTrCsZi2or1IViYf9rwndJ
	L/vvTUxf7SxMll4NwQy+jF5dyNQlMzQiHs9V4wXE9SQluAXUW/+7UwCwtw==
X-Gm-Gg: ASbGncur9zZvrhypqz2TOikLsIQueMdpJ51d3AwXD6baInAt51vtCebh0rJ8bs+hKUF
	0fJ77j1GP7wf/xTC03EPT9qjzwCeP7JoEBUZDqw+vSR0zp8WX33+kk78TVCtfI3MCUcRDVl/0Ks
	TqLCWNoUvk6qkqjmpEDyFdCPMeVPJUakmDZqdOFvcfXpAeH7oPUzhOToGn6EV6EzdUdiP+wT4D1
	DqKmSHXVo19Ilq1N5FoPGTjTw5yREdMxSD+SNioJFPdjQ/QD/WNtGq6b6Eve7uL5a2rfUH2nR/z
	GBh0jfBpbQSn
X-Google-Smtp-Source: AGHT+IFyvGpNyjIy0/3HeMvg3lEOOpOJzY9yuG5BK+QF3krIrmnM1Mc3TFDlW7zYT8+DboitvUvU4w==
X-Received: by 2002:a05:6402:2744:b0:5d0:bcdd:ff90 with SMTP id 4fb4d7f45d1cf-5db7d2e7e43mr7811481a12.2.1737282739174;
        Sun, 19 Jan 2025 02:32:19 -0800 (PST)
Received: from f.. (cst-prg-69-191.cust.vodafone.cz. [46.135.69.191])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73684dd3sm4289503a12.46.2025.01.19.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 02:32:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tavianator@tavianator.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RESEND PATCH] fs: avoid mmap sem relocks when coredumping with many missing pages
Date: Sun, 19 Jan 2025 11:32:05 +0100
Message-ID: <20250119103205.2172432-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dumping processes with large allocated and mostly not-faulted areas is
very slow.

Borrowing a test case from Tavian Barnes:

int main(void) {
    char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
            MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
    printf("%p %m\n", mem);
    if (mem != MAP_FAILED) {
            mem[0] = 1;
    }
    abort();
}

That's 1TB of almost completely not-populated area.

On my test box it takes 13-14 seconds to dump.

The profile shows:
-   99.89%     0.00%  a.out
     entry_SYSCALL_64_after_hwframe
     do_syscall_64
     syscall_exit_to_user_mode
     arch_do_signal_or_restart
   - get_signal
      - 99.89% do_coredump
         - 99.88% elf_core_dump
            - dump_user_range
               - 98.12% get_dump_page
                  - 64.19% __get_user_pages
                     - 40.92% gup_vma_lookup
                        - find_vma
                           - mt_find
                                4.21% __rcu_read_lock
                                1.33% __rcu_read_unlock
                     - 3.14% check_vma_flags
                          0.68% vma_is_secretmem
                       0.61% __cond_resched
                       0.60% vma_pgtable_walk_end
                       0.59% vma_pgtable_walk_begin
                       0.58% no_page_table
                  - 15.13% down_read_killable
                       0.69% __cond_resched
                    13.84% up_read
                 0.58% __cond_resched

Almost 29% of the time is spent relocking the mmap semaphore between
calls to get_dump_page() which find nothing.

Whacking that results in times of 10 seconds (down from 13-14).

While here make the thing killable.

The real problem is the page-sized iteration and the real fix would
patch it up instead. It is left as an exercise for the mm-familiar
reader.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Minimally tested, very plausible I missed something.

sent again because the previous thing has myself in To -- i failed to
fix up the oneliner suggested by lore.kernel.org. it seem the original
got lost.

 arch/arm64/kernel/elfcore.c |  3 ++-
 fs/coredump.c               | 38 +++++++++++++++++++++++++++++++------
 include/linux/mm.h          |  2 +-
 mm/gup.c                    |  5 ++---
 4 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 2e94d20c4ac7..b735f4c2fe5e 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -27,9 +27,10 @@ static int mte_dump_tag_range(struct coredump_params *cprm,
 	int ret = 1;
 	unsigned long addr;
 	void *tags = NULL;
+	int locked = 0;
 
 	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
-		struct page *page = get_dump_page(addr);
+		struct page *page = get_dump_page(addr, &locked);
 
 		/*
 		 * get_dump_page() returns NULL when encountering an empty
diff --git a/fs/coredump.c b/fs/coredump.c
index d48edb37bc35..84cf76f0d5b6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -925,14 +925,23 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 {
 	unsigned long addr;
 	struct page *dump_page;
+	int locked, ret;
 
 	dump_page = dump_page_alloc();
 	if (!dump_page)
 		return 0;
 
+	ret = 0;
+	locked = 0;
 	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
 		struct page *page;
 
+		if (!locked) {
+			if (mmap_read_lock_killable(current->mm))
+				goto out;
+			locked = 1;
+		}
+
 		/*
 		 * To avoid having to allocate page tables for virtual address
 		 * ranges that have never been used yet, and also to make it
@@ -940,21 +949,38 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		 * NULL when encountering an empty page table entry that would
 		 * otherwise have been filled with the zero page.
 		 */
-		page = get_dump_page(addr);
+		page = get_dump_page(addr, &locked);
 		if (page) {
+			if (locked) {
+				mmap_read_unlock(current->mm);
+				locked = 0;
+			}
 			int stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
 			put_page(page);
-			if (stop) {
-				dump_page_free(dump_page);
-				return 0;
-			}
+			if (stop)
+				goto out;
 		} else {
 			dump_skip(cprm, PAGE_SIZE);
 		}
+
+		if (dump_interrupted())
+			goto out;
+
+		if (!need_resched())
+			continue;
+		if (locked) {
+			mmap_read_unlock(current->mm);
+			locked = 0;
+		}
 		cond_resched();
 	}
+	ret = 1;
+out:
+	if (locked)
+		mmap_read_unlock(current->mm);
+
 	dump_page_free(dump_page);
-	return 1;
+	return ret;
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 75c9b4f46897..7df0d9200d8c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2633,7 +2633,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
 
 struct kvec;
-struct page *get_dump_page(unsigned long addr);
+struct page *get_dump_page(unsigned long addr, int *locked);
 
 bool folio_mark_dirty(struct folio *folio);
 bool folio_mark_dirty_lock(struct folio *folio);
diff --git a/mm/gup.c b/mm/gup.c
index 2304175636df..f3be2aa43543 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2266,13 +2266,12 @@ EXPORT_SYMBOL(fault_in_readable);
  * Called without mmap_lock (takes and releases the mmap_lock by itself).
  */
 #ifdef CONFIG_ELF_CORE
-struct page *get_dump_page(unsigned long addr)
+struct page *get_dump_page(unsigned long addr, int *locked)
 {
 	struct page *page;
-	int locked = 0;
 	int ret;
 
-	ret = __get_user_pages_locked(current->mm, addr, 1, &page, &locked,
+	ret = __get_user_pages_locked(current->mm, addr, 1, &page, locked,
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	return (ret == 1) ? page : NULL;
 }
-- 
2.43.0


