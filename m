Return-Path: <linux-fsdevel+bounces-20304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A88D13C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E319CB22B40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363184AECB;
	Tue, 28 May 2024 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSgg9mMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91165502AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873382; cv=none; b=jCd2S0t9fWExH1adlCVBvw8/hoQBc0tVNFpGdhYr2+YNPoPpXds2FEdLb8T71U2pWY1j30XiDP7W+3CffUjrS2GamM4Je2uFBI1BYef/LO//FPGxFjxFGLIJiU900G9kuJ+KdPZMpdF8g+6bJL9MLj9zRF/9D4Bt/WjlZIrG7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873382; c=relaxed/simple;
	bh=5jHsxXd8zdPd706tl2Ubj0ZrdiWpVOv9Lxro+6nHmOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dj5MKH33CkN98gMOMlgnM3knV3SiKqBQ2I7nrT+7JaPfgnB7YEJomNn50S9aACVLB37bsndNFtw/XlpjmkKWO7c/x9gtfgEOz+K14AsxxSSSs3SVfmOLMDtVofHbFJSBDFBdZcL0HX7beddEkFdhGMLRxjA23G6ciZizC/a3iPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSgg9mMT; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716873377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zg6IUZo0bowQYilDFhdb5hKg47g4PTuCJ0DoynV+1Ow=;
	b=fSgg9mMT6NoKlJBxIsFelxj0N7eNK3jUnz48HPuWyvIw8AguYxvmguIM3h+PROaMNThruf
	txlhn+TQX9c9CgwhALfHspAetakAxYX20B/4TxOkshI9scHVPcPx0ns1+p4a6NQ+6hulz6
	tGmLvjIzmk/oIDckYccOzeEoG3TMdIE=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: hughd@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: yang.yang29@zte.com.cn
X-Envelope-To: ran.xiaokai@zte.com.cn
X-Envelope-To: xu.xin16@zte.com.cn
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: zhouchengming@bytedance.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 28 May 2024 13:15:22 +0800
Subject: [PATCH v3 2/2] mm/ksm: fix ksm_zero_pages accounting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-b4-ksm-counters-v3-2-34bb358fdc13@linux.dev>
References: <20240528-b4-ksm-counters-v3-0-34bb358fdc13@linux.dev>
In-Reply-To: <20240528-b4-ksm-counters-v3-0-34bb358fdc13@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, hughd@google.com, aarcange@redhat.com, 
 Stefan Roesch <shr@devkernel.io>, Xiaokai Ran <ran.xiaokai@zte.com.cn>, 
 xu xin <xu.xin16@zte.com.cn>, Yang Yang <yang.yang29@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, zhouchengming@bytedance.com, 
 Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716873365; l=5017;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=5jHsxXd8zdPd706tl2Ubj0ZrdiWpVOv9Lxro+6nHmOc=;
 b=v7pQUR5dWHG0CW3hlK5ixSeteB47vG0GGXUi+MHTgy6Iqr+keE+paN3GabHlhibRUblv0dSGO
 AwnovP9yUvzDbLg6q0J1JWpPPMHN5l5x5yLDJ4esOLuWg9LtJE6s/ku
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
but ksm_zero_pages-- is done from page tables side, where there is no any
accessing protection of ksm_zero_pages.

So we can read very exceptional value of ksm_zero_pages in rare cases,
such as -1, which is very confusing to users.

Fix it by changing to use atomic_long_t, and the same case with the
mm->ksm_zero_pages.

Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
Fixes: 6080d19f0704 ("ksm: add ksm zero pages for each process")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 fs/proc/base.c           |  2 +-
 include/linux/ksm.h      | 17 ++++++++++++++---
 include/linux/mm_types.h |  2 +-
 mm/ksm.c                 | 11 +++++------
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..72a1acd03675 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 	mm = get_task_mm(task);
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
-		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
+		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		mmput(mm);
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 52c63a9c5a9c..11690dacd986 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -33,16 +33,27 @@ void __ksm_exit(struct mm_struct *mm);
  */
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
-extern unsigned long ksm_zero_pages;
+extern atomic_long_t ksm_zero_pages;
+
+static inline void ksm_map_zero_page(struct mm_struct *mm)
+{
+	atomic_long_inc(&ksm_zero_pages);
+	atomic_long_inc(&mm->ksm_zero_pages);
+}
 
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 	if (is_ksm_zero_pte(pte)) {
-		ksm_zero_pages--;
-		mm->ksm_zero_pages--;
+		atomic_long_dec(&ksm_zero_pages);
+		atomic_long_dec(&mm->ksm_zero_pages);
 	}
 }
 
+static inline long mm_ksm_zero_pages(struct mm_struct *mm)
+{
+	return atomic_long_read(&mm->ksm_zero_pages);
+}
+
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24323c7d0bd4..af3a0256fa93 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -985,7 +985,7 @@ struct mm_struct {
 		 * Represent how many empty pages are merged with kernel zero
 		 * pages when enabling KSM use_zero_pages.
 		 */
-		unsigned long ksm_zero_pages;
+		atomic_long_t ksm_zero_pages;
 #endif /* CONFIG_KSM */
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index 9e99cb12d330..34c4820e0d3d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -296,7 +296,7 @@ static bool ksm_use_zero_pages __read_mostly;
 static bool ksm_smart_scan = true;
 
 /* The number of zero pages which is placed by KSM */
-unsigned long ksm_zero_pages;
+atomic_long_t ksm_zero_pages = ATOMIC_LONG_INIT(0);
 
 /* The number of pages that have been skipped due to "smart scanning" */
 static unsigned long ksm_pages_skipped;
@@ -1429,8 +1429,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * the dirty bit in zero page's PTE is set.
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
-		ksm_zero_pages++;
-		mm->ksm_zero_pages++;
+		ksm_map_zero_page(mm);
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
@@ -3374,7 +3373,7 @@ static void wait_while_offlining(void)
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *mm)
 {
-	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
+	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }
 #endif /* CONFIG_PROC_FS */
@@ -3663,7 +3662,7 @@ KSM_ATTR_RO(pages_skipped);
 static ssize_t ksm_zero_pages_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
+	return sysfs_emit(buf, "%ld\n", atomic_long_read(&ksm_zero_pages));
 }
 KSM_ATTR_RO(ksm_zero_pages);
 
@@ -3672,7 +3671,7 @@ static ssize_t general_profit_show(struct kobject *kobj,
 {
 	long general_profit;
 
-	general_profit = (ksm_pages_sharing + ksm_zero_pages) * PAGE_SIZE -
+	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
 				ksm_rmap_items * sizeof(struct ksm_rmap_item);
 
 	return sysfs_emit(buf, "%ld\n", general_profit);

-- 
2.45.1


