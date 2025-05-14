Return-Path: <linux-fsdevel+bounces-49049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E856AB79D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD7C4C625C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8042512EC;
	Wed, 14 May 2025 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fv7pt8SF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745924F5A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266216; cv=none; b=YiZe0S40/GV90SvMw06CUFN0MUljnHRD2Is2MkY8usOH9+/C/TDlod4FPCbVKp31RTQSxgPfIQTOj4/vKsXeR0/faXfof3aIw32AGshCJ4fhsMLKGLyfuWRSFldittQnVlFa1YZR4/yD8N7ME2l1OPWq1s+F1IhTHjdA8I0J5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266216; c=relaxed/simple;
	bh=rKA0+onq+gdXn1ctPMqhGi1Qv0qirbMzMXdMeL/6v5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6NlYZfnrl0GPZTk/uSr5KF4DrO6J27MET1p1In/3TG+iROF5u+lsC7rie+Wb4ociDyIaobaOnzXmURMEOvRweXVm4X33+cWDFhII1OOAi0RQAPy/F9ys3/927RaUFZHHOqrBboPyDMQK5+JP+xSQW5bk7Y4DNguWbwfjjxvDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fv7pt8SF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b258f4ed829so307784a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266214; x=1747871014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tc8r/LLWs1XCr5lU0UzhDkU/KqodMLVECq9VtOKJK+U=;
        b=fv7pt8SFkm6rtPdXGFrfPaqS8HDpyry3/FEpyDaoReaSLfACiwIytKC3vVqXkJi3OQ
         3gVVJVMfqpFrp2PdWV0AInO3vQhQb5XomAvOPFAlgKsnp/kgZwKxbPDZ/4AH+HBIyqlI
         jImL1rbkP2LzFvCSOKzUddivZJ4vFeCcZMFdsXEbFWrSE+/tySSUueOrNoHceBL1+naU
         /BNXysm6300dlhPj2ydiMY7Zuc2Myz8k3Tdet5a1nClNvFPeGgrs13s9PQxHSeIgxgU3
         z3Ap/bJC7pvg6+igAgnDQZQoRpGen1n+aOrGLl43uAP7RBGB37MguwXvsQ2SIJNKGRTL
         JCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266214; x=1747871014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tc8r/LLWs1XCr5lU0UzhDkU/KqodMLVECq9VtOKJK+U=;
        b=vboygs7FCVE9zWf8BCUaMdyZxYCT45sby+4WqPFEdCudDsYvt7ayXlJ/U/pLyFvjVu
         BY+fapGkDkQCcCAN2cOPcv3TJxAV/Udm85crXFjQV32GjV82WPoCiMcwLqKQWNh3/8LC
         s0GazoSRVMEUxSugJ7J4ppQdqNamEI01h4OCaaasnjw2+Cx9NecRwooX4UCe8IjTPEMY
         D+epsXSaCaHovDEgbGC+j5f1OzN1alYEkfOASilQiGNXeedWxYVvIwstMjue7tZKBhjv
         A5J4IhxNsJ3OSNMLDrf1UbOx9dp/xZGAkokSclQ7o84r3MPpwgkNCAeR0vcNa9bBLCKn
         0w7g==
X-Forwarded-Encrypted: i=1; AJvYcCX0voOZ7WMgPJOCwv5w5jNxx8qrn86pJl3ZQob5plfYK44zT8qnusu/qf5Jwm2FU++yBkgrCm9bgFrwXYF4@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSBKqIZ4gg1mfRI32bp72rwSwrxLYOpsOem0xprhh4ybi3CeR
	wc+JK67unCpqzaJOHHkYTMTqpFIH8rUHiSuvtUkhaSXkmO27kTXVpw1ziNKnH1yIy6FZFnEn27J
	YP/gOgwMAgNHvd+5CzFoyqg==
X-Google-Smtp-Source: AGHT+IF0TxGX5QDuiZ5fF+gyFVLYwkxQqYFd22OI+c7HWH/Uv05Rw/kMdg1Ug4u6l3WRzY2e8Z7/iM3iEM1ERmAmvQ==
X-Received: from pjbeu14.prod.google.com ([2002:a17:90a:f94e:b0:2fc:2f33:e07d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c2cb:b0:2ff:52e1:c49f with SMTP id 98e67ed59e1d1-30e51930f33mr611504a91.26.1747266214289;
 Wed, 14 May 2025 16:43:34 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:03 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <3f2ac9240cd39295e7341d408548719818d5ea91.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 24/51] mm: hugetlb: Add option to create new subpool
 without using surplus
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

__hugetlb_acct_memory() today does more than just memory
accounting. When there's insufficient HugeTLB pages,
__hugetlb_acct_memory() will attempt to get surplus pages.

This change adds a flag to disable getting surplus pages if there are
insufficient HugeTLB pages.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Id79fdeaa236b4fed38fc3c20482b03fff729198f
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 77 +++++++++++++++++++++++++++++++----------
 3 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e4de5425838d..609a88950354 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1424,7 +1424,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ctx->max_hpages != -1 || ctx->min_hpages != -1) {
 		sbinfo->spool = hugepage_new_subpool(ctx->hstate,
 						     ctx->max_hpages,
-						     ctx->min_hpages);
+						     ctx->min_hpages, true);
 		if (!sbinfo->spool)
 			goto out_free;
 	}
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8ba941d88956..c59264391c33 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -116,7 +116,7 @@ extern int hugetlb_max_hstate __read_mostly;
 	for ((h) = hstates; (h) < &hstates[hugetlb_max_hstate]; (h)++)
 
 struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
-						long min_hpages);
+					      long min_hpages, bool use_surplus);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5b088fe002a2..d22c5a8fd441 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -115,6 +115,7 @@ static int num_fault_mutexes __ro_after_init;
 struct mutex *hugetlb_fault_mutex_table __ro_after_init;
 
 /* Forward declaration */
+static int __hugetlb_acct_memory(struct hstate *h, long delta, bool use_surplus);
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
@@ -162,7 +163,7 @@ static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
 }
 
 struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
-						long min_hpages)
+					      long min_hpages, bool use_surplus)
 {
 	struct hugepage_subpool *spool;
 
@@ -176,7 +177,8 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 	spool->hstate = h;
 	spool->min_hpages = min_hpages;
 
-	if (min_hpages != -1 && hugetlb_acct_memory(h, min_hpages)) {
+	if (min_hpages != -1 &&
+	    __hugetlb_acct_memory(h, min_hpages, use_surplus)) {
 		kfree(spool);
 		return NULL;
 	}
@@ -2382,35 +2384,64 @@ static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
 	return NULL;
 }
 
-/*
- * Increase the hugetlb pool such that it can accommodate a reservation
- * of size 'delta'.
+/**
+ * hugetlb_hstate_reserve_pages() - Reserve @requested number of hugetlb pages
+ * from hstate @h.
+ *
+ * @h: the hstate to reserve from.
+ * @requested: number of hugetlb pages to reserve.
+ *
+ * If there are insufficient available hugetlb pages, no reservations are made.
+ *
+ * Return: the number of surplus pages required to meet the @requested number of
+ *         hugetlb pages.
  */
-static int gather_surplus_pages(struct hstate *h, long delta)
+static int hugetlb_hstate_reserve_pages(struct hstate *h, long requested)
+	__must_hold(&hugetlb_lock)
+{
+	long needed;
+
+	needed = (h->resv_huge_pages + requested) - h->free_huge_pages;
+	if (needed <= 0) {
+		h->resv_huge_pages += requested;
+		return 0;
+	}
+
+	return needed;
+}
+
+/**
+ * gather_surplus_pages() - Increase the hugetlb pool such that it can
+ * accommodate a reservation of size @requested.
+ *
+ * @h: the hstate in concern.
+ * @requested: The requested number of hugetlb pages.
+ * @needed: The number of hugetlb pages the pool needs to be increased by, based
+ *          on current number of reservations and free hugetlb pages.
+ *
+ * Return: 0 if successful or negative error otherwise.
+ */
+static int gather_surplus_pages(struct hstate *h, long requested, long needed)
 	__must_hold(&hugetlb_lock)
 {
 	LIST_HEAD(surplus_list);
 	struct folio *folio, *tmp;
 	int ret;
 	long i;
-	long needed, allocated;
+	long allocated;
 	bool alloc_ok = true;
 	int node;
 	nodemask_t *mbind_nodemask, alloc_nodemask;
 
+	if (needed == 0)
+		return 0;
+
 	mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
 	if (mbind_nodemask)
 		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_mems_allowed);
 	else
 		alloc_nodemask = cpuset_current_mems_allowed;
 
-	lockdep_assert_held(&hugetlb_lock);
-	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
-	if (needed <= 0) {
-		h->resv_huge_pages += delta;
-		return 0;
-	}
-
 	allocated = 0;
 
 	ret = -ENOMEM;
@@ -2448,7 +2479,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * because either resv_huge_pages or free_huge_pages may have changed.
 	 */
 	spin_lock_irq(&hugetlb_lock);
-	needed = (h->resv_huge_pages + delta) -
+	needed = (h->resv_huge_pages + requested) -
 			(h->free_huge_pages + allocated);
 	if (needed > 0) {
 		if (alloc_ok)
@@ -2469,7 +2500,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * before they are reserved.
 	 */
 	needed += allocated;
-	h->resv_huge_pages += delta;
+	h->resv_huge_pages += requested;
 	ret = 0;
 
 	/* Free the needed pages to the hugetlb pool */
@@ -5284,7 +5315,7 @@ unsigned long hugetlb_total_pages(void)
 	return nr_total_pages;
 }
 
-static int hugetlb_acct_memory(struct hstate *h, long delta)
+static int __hugetlb_acct_memory(struct hstate *h, long delta, bool use_surplus)
 {
 	int ret = -ENOMEM;
 
@@ -5316,7 +5347,12 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	 * above.
 	 */
 	if (delta > 0) {
-		if (gather_surplus_pages(h, delta) < 0)
+		long needed = hugetlb_hstate_reserve_pages(h, delta);
+
+		if (!use_surplus && needed > 0)
+			goto out;
+
+		if (gather_surplus_pages(h, delta, needed) < 0)
 			goto out;
 
 		if (delta > allowed_mems_nr(h)) {
@@ -5334,6 +5370,11 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	return ret;
 }
 
+static int hugetlb_acct_memory(struct hstate *h, long delta)
+{
+	return __hugetlb_acct_memory(h, delta, true);
+}
+
 static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 {
 	struct resv_map *resv = vma_resv_map(vma);
-- 
2.49.0.1045.g170613ef41-goog


