Return-Path: <linux-fsdevel+bounces-39401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81562A139FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5DC3A0791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1D1DE4F8;
	Thu, 16 Jan 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I35fb7Ys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30224A7F8;
	Thu, 16 Jan 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030964; cv=none; b=BjNWPJMhJAcZiEo2oce1XeLF8UCGdH7JFpQOk3+Asi7mwap5Rdio9XVtW1WIy+xaw2qWYY0V6YfSWH7NghU6EiaeYeytDGZiqpOSffFHAWnYg3FAYtGdgn+aNUVHQqUxwdl/M0tWny6LM6nMI/homzB4DAJg/o+uovXRjQ+aGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030964; c=relaxed/simple;
	bh=KlI2pbKao9Qa90mUL3JH/9QwYAMLTnEujqGL9+A6Z28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM1iRizColSM00T+k5Fn11Lv61hqzcmiIFvR7qii0JHom082gMTpPjDq3TEBhYpLbeuuQ0lrLmOo1ZHDcbLpcBVo3nrE0c+otacW1v7CNGOd/UeAKr3FqNstrBG+fr+WXJIKWTr9DWbtcm35FgxaJ0Tg80ZBdtczMLXp8Vy/03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I35fb7Ys; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so819429f8f.0;
        Thu, 16 Jan 2025 04:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737030961; x=1737635761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9q/Ez/2vi9dG2C4OCPna1JnJ8nRu2IG4tLzEf9zm8Y=;
        b=I35fb7YsLRdxFsF4iPjTAaoBM+2bz8nuoXE3vg8e443KZwlouXiZr2FosVJ8/GeP8c
         PDOn4F41PzrtatWTF6ZzgKol3U4BsiFsPn17GSoAkubqqLDrNNI2QJqTb2Lux8xtAEji
         EO4vHpU+Io0rGHM9/eeNsik/5HPNDjjiotZ6wf1E2+dcvCmdIMQGKMIVQk073FQI0RMS
         VZCe7mMlOXC0K36Jf6EO6IL0nZBO2sFR5atpj77xePmQ+bDeJPD9Km0DtK6V4fXt7DkF
         SEXlpAOSuVTqNtmnBF+jjKdOaFRqQ8bRPOBNMV+sTO44w9pqz492Tl1d1QuF8YjfFT4p
         I5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737030961; x=1737635761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9q/Ez/2vi9dG2C4OCPna1JnJ8nRu2IG4tLzEf9zm8Y=;
        b=YXzwKty1hWCnp/3X+BSm8HQfI22RLvjig2V/Vy5OOsvWq3d3nlkUvq+G2tz+L+5lOq
         nog1aQVBIXmoqziKvDk6nnl5ccKFYpOELQVfqG+uRXZSvUrJYEIM30KOrAwYOoo9UBIL
         rn9FWX9okjOFEP7ebpN/UbqTFAPsSe5VesUnrzkrloIBQLUe548MCcXsLu+h6TAG/eQ5
         ra2Fzi/+MyzxH7BzwEl1qIO0y0DsOgxnRxCmcHjAbmA0OiXo+TNKS55bhugmJZCKWIli
         yWfeC8i4vJxhYpXmiOcj5Fv54MgyOd26EvA8/0f7FCyl5S9BQ6Y5Bsy/pD0T+aJXCy1m
         Sd+w==
X-Forwarded-Encrypted: i=1; AJvYcCU6x3kZGTsZUijrBVo8pD00sXMNELiGo98FqFXDn0D/DAr1bjjKT8lN+yhekzpiZ1GJWGHjd1G3M6iq9hVB@vger.kernel.org, AJvYcCVcVnO6DI7SeqL9KjBtR+rlwrg1HibYwM5gbV2M1s0ru5zx8c52liFj81MjufBH66awZhCphZk6SAmHRkY9@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+Gs4FtC2W0xpFADRTKK4fCczgbaw11FZ212/2Z4jsOyrHfg+
	Ag+lTULSBFoXQEacBEuE48pGmRpjzkJtSmASr96qOxv/YTfeJnqLfulipA==
X-Gm-Gg: ASbGncsPurleEQTsBVpQPn7OFavekk2ycAfwYHMPH4KRD6RDh9Jh/VL36FRCm4ZgVI9
	m8CINmjG6SvcREbX8Eqht7qn9r52/UkFm4qb2vljbaKojDAThgwRkgYbpZkmGuHnTy3KHogX47j
	F/yLaRe8aPILdSxJ8bRVeZlAqw5jWq70oWhvi8BgrrmALFg8JX+SwRSZH/oMaE7sMFa0O6/gTMn
	9TARuE5R1Bw0QuFDRKJoDSIz6GdJjz38R/PxntS84677Yy65QZMKCSBYYLn6Aw7NUefGGkLaq4=
X-Google-Smtp-Source: AGHT+IGI4m/fLHfejrIpVVlpMhiIczCwPT/bKqv1pPV0d0Z/SxHpSiADNw6J4C9ujYxwoik/6BdJfw==
X-Received: by 2002:a05:6000:490e:b0:385:ef39:6cf7 with SMTP id ffacd0b85a97d-38a872ec3c7mr27460021f8f.32.1737030961121;
        Thu, 16 Jan 2025 04:36:01 -0800 (PST)
Received: from f.. (cst-prg-69-191.cust.vodafone.cz. [46.135.69.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383dedsm20688875f8f.35.2025.01.16.04.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 04:36:00 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: mjguzik@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tavianator@tavianator.com,
	viro@zeniv.linux.org.uk,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: [PATCH] fs: avoid mmap sem relocks when coredumping with many missing pages
Date: Thu, 16 Jan 2025 13:35:52 +0100
Message-ID: <20250116123552.1846273-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAGudoHFg4BgeygyKV8tY_2Dk4cv9zwQnU6-n7jSxjwyyXzau6g@mail.gmail.com>
References: <CAGudoHFg4BgeygyKV8tY_2Dk4cv9zwQnU6-n7jSxjwyyXzau6g@mail.gmail.com>
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


