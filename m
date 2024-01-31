Return-Path: <linux-fsdevel+bounces-9682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB9844697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315C2B22D26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596E12F586;
	Wed, 31 Jan 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABusZBeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21312DDBE
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723784; cv=none; b=KTqbmwo8vvVqpPB9vy+DTsOgrU2z4OCnWef2hAXbq/5f3qJU20gw5zHsbPRavA29Rtg2EshzX783EvRjQSPMDHVBkjVlE0BhWEXUpkqw6mvlooIzScsmmApIav8FjqwXponMfuT5V2B7jd6KAklpS0bjf56pYUndTkxcI12vJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723784; c=relaxed/simple;
	bh=EhgEjKxWnSdS0yhq+4TYSWstLhucBksIGp1I76DMSbs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j/jEclsG/+USIsiQBePRnp2/L8OHECEYjNKQ+hUZi7RsQ9CFgVY4AB6hwdQxEbaa2wM7vK84igUH5/DO2ZN7aZV9WHeS43WnkxeFTkzVGAOSV6JdGZm8YIyyynns2XV7fu8EJSUhd66QSHILYupVea0XjPPp6QNmaOv3hqOM7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABusZBeV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040b27151eso400107b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706723781; x=1707328581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCByHLn0az29T/ST8c+YfQsbX2Bxnb2yCgdqjn90lwk=;
        b=ABusZBeVvkjvMu174jYmFSMOMS2QtcSe/P0lExUE3w8mIOKdT/lOywdCOnxs+G56/f
         uTGOIlVvW9UpgAQbRK3QEs3fOgvjl+pyf0K4BPr/8LJavfPCPXhSTkoe2WF8DpT2owsr
         iISk/izeJta5Sazu5Q6vnEf+zt/Qb9xBKZhnfkjEkookCHZBlryG2EPdWrqJUWNIWXN0
         3hgUO+rs0gKi8yJxRnEy0dbb9roUe/eQRz4u1aPFQp9uob8PhK6V1PqEZ8dOA0sZqZCo
         tdKjHj/vGb48lm1suWQuWklJsxeaPi+//T2eFpYOHl+hhZ6LFx/0/sRirClW9laHCdkJ
         HBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723781; x=1707328581;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCByHLn0az29T/ST8c+YfQsbX2Bxnb2yCgdqjn90lwk=;
        b=vISiu15tVVFMnTtUfeOg8bLTxGAiyQZPv4nHbGvxz6Jy1WlXhpFVrmAccHX7zNfRIU
         1x5kaFyWpRh1CxnZOhp0eT4tPd7LYvqLjb+xC2Dkl/gENP9b/UyRSRBlPl7ObkXgoFcd
         3zZNwQu4OhhAlz3CPL8gghnipGBY646A7FR0ZmEPp1bbkk9ewnjozNCQXPiuMD5INNB0
         US4cGCqn1agaZ7b9nWz3cTdEsj6oXLopjsCcMMmqNhDIe2v2LWwU8AURJMiAKxiqPgBg
         M+1+i1mxB65DLgXxWZ5xdPJTEGAtek5GxiT8nSts35KqpQlA7OIOTSSTkThYB/K//IA/
         D+5g==
X-Gm-Message-State: AOJu0YxVA1u2mF1GnSZ2t8wdr+6EQRQMrZ58CHJJ2msfcGYsx4ASHtm3
	w7przElqTKlQ9wIYYOlH1G3ZjX94X6Hkp5+F5xpo5mbEDs9iT3B9BODBXh5AcpNf2IZot7ok5u7
	yqQ==
X-Google-Smtp-Source: AGHT+IE1n60RugQOzQULYwOhEaJv2HO9AtQ3jXHu8wpAwOVVAkN13vRAKSD9bgTo4IjB/XxJUscAyJfsWAM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1af6:3bbe:455c:bdbd])
 (user=surenb job=sendgmr) by 2002:a05:6902:2303:b0:dc2:2d2c:962a with SMTP id
 do3-20020a056902230300b00dc22d2c962amr631113ybb.8.1706723781432; Wed, 31 Jan
 2024 09:56:21 -0800 (PST)
Date: Wed, 31 Jan 2024 09:56:18 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131175618.2417291-1-surenb@google.com>
Subject: [PATCH v2 1/1] userfaultfd: handle zeropage moves by UFFDIO_MOVE
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, dan.carpenter@linaro.org, surenb@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Current implementation of UFFDIO_MOVE fails to move zeropages and returns
EBUSY when it encounters one. We can handle them by mapping a zeropage
at the destination and clearing the mapping at the source. This is done
both for ordinary and for huge zeropages.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202401300107.U8iMAkTl-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]
- Added missing double_pt_unlock in move_zeropage_pte, per Dan Carpenter
- Added Reported-by and Closes tags per bug report [2]

Applies cleanly over mm-unstable branch.

[1] https://lore.kernel.org/all/20240125001328.335127-1-surenb@google.com/
[2] https://lore.kernel.org/all/202401300107.U8iMAkTl-lkp@intel.com/

 mm/huge_memory.c | 105 +++++++++++++++++++++++++++--------------------
 mm/userfaultfd.c |  44 ++++++++++++++++----
 2 files changed, 98 insertions(+), 51 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f005f0424735..016e20bd813e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2200,13 +2200,18 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	}
 
 	src_page = pmd_page(src_pmdval);
-	if (unlikely(!PageAnonExclusive(src_page))) {
-		spin_unlock(src_ptl);
-		return -EBUSY;
-	}
 
-	src_folio = page_folio(src_page);
-	folio_get(src_folio);
+	if (!is_huge_zero_pmd(src_pmdval)) {
+		if (unlikely(!PageAnonExclusive(src_page))) {
+			spin_unlock(src_ptl);
+			return -EBUSY;
+		}
+
+		src_folio = page_folio(src_page);
+		folio_get(src_folio);
+	} else
+		src_folio = NULL;
+
 	spin_unlock(src_ptl);
 
 	flush_cache_range(src_vma, src_addr, src_addr + HPAGE_PMD_SIZE);
@@ -2214,19 +2219,22 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 				src_addr + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-	folio_lock(src_folio);
+	if (src_folio) {
+		folio_lock(src_folio);
 
-	/*
-	 * split_huge_page walks the anon_vma chain without the page
-	 * lock. Serialize against it with the anon_vma lock, the page
-	 * lock is not enough.
-	 */
-	src_anon_vma = folio_get_anon_vma(src_folio);
-	if (!src_anon_vma) {
-		err = -EAGAIN;
-		goto unlock_folio;
-	}
-	anon_vma_lock_write(src_anon_vma);
+		/*
+		 * split_huge_page walks the anon_vma chain without the page
+		 * lock. Serialize against it with the anon_vma lock, the page
+		 * lock is not enough.
+		 */
+		src_anon_vma = folio_get_anon_vma(src_folio);
+		if (!src_anon_vma) {
+			err = -EAGAIN;
+			goto unlock_folio;
+		}
+		anon_vma_lock_write(src_anon_vma);
+	} else
+		src_anon_vma = NULL;
 
 	dst_ptl = pmd_lockptr(mm, dst_pmd);
 	double_pt_lock(src_ptl, dst_ptl);
@@ -2235,45 +2243,54 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		err = -EAGAIN;
 		goto unlock_ptls;
 	}
-	if (folio_maybe_dma_pinned(src_folio) ||
-	    !PageAnonExclusive(&src_folio->page)) {
-		err = -EBUSY;
-		goto unlock_ptls;
-	}
+	if (src_folio) {
+		if (folio_maybe_dma_pinned(src_folio) ||
+		    !PageAnonExclusive(&src_folio->page)) {
+			err = -EBUSY;
+			goto unlock_ptls;
+		}
 
-	if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
-	    WARN_ON_ONCE(!folio_test_anon(src_folio))) {
-		err = -EBUSY;
-		goto unlock_ptls;
-	}
+		if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
+		    WARN_ON_ONCE(!folio_test_anon(src_folio))) {
+			err = -EBUSY;
+			goto unlock_ptls;
+		}
 
-	folio_move_anon_rmap(src_folio, dst_vma);
-	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+		folio_move_anon_rmap(src_folio, dst_vma);
+		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
 
-	src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-	/* Folio got pinned from under us. Put it back and fail the move. */
-	if (folio_maybe_dma_pinned(src_folio)) {
-		set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
-		err = -EBUSY;
-		goto unlock_ptls;
-	}
+		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+		/* Folio got pinned from under us. Put it back and fail the move. */
+		if (folio_maybe_dma_pinned(src_folio)) {
+			set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
+			err = -EBUSY;
+			goto unlock_ptls;
+		}
 
-	_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
-	/* Follow mremap() behavior and treat the entry dirty after the move */
-	_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
+		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
+		/* Follow mremap() behavior and treat the entry dirty after the move */
+		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
+	} else {
+		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+		_dst_pmd = mk_huge_pmd(src_page, dst_vma->vm_page_prot);
+	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
 	src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
 	pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
 unlock_ptls:
 	double_pt_unlock(src_ptl, dst_ptl);
-	anon_vma_unlock_write(src_anon_vma);
-	put_anon_vma(src_anon_vma);
+	if (src_anon_vma) {
+		anon_vma_unlock_write(src_anon_vma);
+		put_anon_vma(src_anon_vma);
+	}
 unlock_folio:
 	/* unblock rmap walks */
-	folio_unlock(src_folio);
+	if (src_folio)
+		folio_unlock(src_folio);
 	mmu_notifier_invalidate_range_end(&range);
-	folio_put(src_folio);
+	if (src_folio)
+		folio_put(src_folio);
 	return err;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ae80c3714829..9cc93cc1330b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -959,6 +959,33 @@ static int move_swap_pte(struct mm_struct *mm,
 	return 0;
 }
 
+static int move_zeropage_pte(struct mm_struct *mm,
+			     struct vm_area_struct *dst_vma,
+			     struct vm_area_struct *src_vma,
+			     unsigned long dst_addr, unsigned long src_addr,
+			     pte_t *dst_pte, pte_t *src_pte,
+			     pte_t orig_dst_pte, pte_t orig_src_pte,
+			     spinlock_t *dst_ptl, spinlock_t *src_ptl)
+{
+	pte_t zero_pte;
+
+	double_pt_lock(dst_ptl, src_ptl);
+	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
+	    !pte_same(ptep_get(dst_pte), orig_dst_pte)) {
+		double_pt_unlock(dst_ptl, src_ptl);
+		return -EAGAIN;
+	}
+
+	zero_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
+					 dst_vma->vm_page_prot));
+	ptep_clear_flush(src_vma, src_addr, src_pte);
+	set_pte_at(mm, dst_addr, dst_pte, zero_pte);
+	double_pt_unlock(dst_ptl, src_ptl);
+
+	return 0;
+}
+
+
 /*
  * The mmap_lock for reading is held by the caller. Just move the page
  * from src_pmd to dst_pmd if possible, and return true if succeeded
@@ -1041,6 +1068,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	}
 
 	if (pte_present(orig_src_pte)) {
+		if (is_zero_pfn(pte_pfn(orig_src_pte))) {
+			err = move_zeropage_pte(mm, dst_vma, src_vma,
+					       dst_addr, src_addr, dst_pte, src_pte,
+					       orig_dst_pte, orig_src_pte,
+					       dst_ptl, src_ptl);
+			goto out;
+		}
+
 		/*
 		 * Pin and lock both source folio and anon_vma. Since we are in
 		 * RCU read section, we can't block, so on contention have to
@@ -1404,19 +1439,14 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 				err = -ENOENT;
 				break;
 			}
-			/* Avoid moving zeropages for now */
-			if (is_huge_zero_pmd(*src_pmd)) {
-				spin_unlock(ptl);
-				err = -EBUSY;
-				break;
-			}
 
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
 			    !pmd_none(dst_pmdval)) {
 				struct folio *folio = pfn_folio(pmd_pfn(*src_pmd));
 
-				if (!folio || !PageAnonExclusive(&folio->page)) {
+				if (!folio || (!is_huge_zero_page(&folio->page) &&
+					       !PageAnonExclusive(&folio->page))) {
 					spin_unlock(ptl);
 					err = -EBUSY;
 					break;
-- 
2.43.0.429.g432eaa2c6b-goog


