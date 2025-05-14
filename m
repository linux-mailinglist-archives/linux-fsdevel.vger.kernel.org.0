Return-Path: <linux-fsdevel+bounces-49047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D16AB79F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A893B7BA5A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F9224EF7B;
	Wed, 14 May 2025 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XESTAhq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC422B8BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266214; cv=none; b=W3sFI9VL4Q1o80nu3VXbpbdIUiacR1ip5pNP15j6WUDTq7DWYAFGyHx9kSQJ1XdmOHt/d//OxwxMEMRaaxYlNk5inqW62eWrDEXG4n/7qjvScYxyJeredy0SU292lpHumYfuNeC5JWP/xv0Dqb5orPqZ6uJjahQmzQ3nJKuz5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266214; c=relaxed/simple;
	bh=VXyPJAGKIQGnQGNvuuAB1rMiRT3oZQFz9jJI9V3sruk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nVDSlo3Q1yms3SJ+xb7APNHHxUPegK0m6fwqHGV/RPru+HF7FjU45K7/iUuARJo+j16BNddLbsWDUV1RnEkSNy4GMVdX9W2/IzmNbwT7rcU0ip8t2Tn6nYdRNJT54TqOnHuuqwDb/fs7TCwc2zS7uWsQMDAnOfussgZku9uIcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XESTAhq0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso276195b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266211; x=1747871011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVT2MIxWnWM/XLaHWjsnvPvOi1XED19jnd4mUMbhvto=;
        b=XESTAhq0P6Hi/6wMOWlNTw7SLis3iy7DBQlevQCJiweM/u7HT41F5nuPkv7osU4PeF
         u+8B9eNZwMExk1UCyF8rquCyqQPuQ3ytB80st3CNmAv/i9qsUh79zkh6U/hXHUGpfq2S
         Oon8/gf2hHYWwdBG/DPlURx02LRgGKdBUVUM8SqQkKFMo4/p8Z/0ybalCgAbYmjexdRb
         FyRVyUTVz5BJlqqLYOyKwgzSaDPdxRgj1cFayVVQgGYcKfQuv8+lBlIp3JyLNCFpXDm1
         CqEDQHXMM0MvP6lwFXSVwRSFiUNcevYYeRxAz0K+V4WOK35ZU88AWPC0kF7Z/4lR3EOX
         SqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266211; x=1747871011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVT2MIxWnWM/XLaHWjsnvPvOi1XED19jnd4mUMbhvto=;
        b=OWc5B7xwsGjoKkzKgRZocX6WT8ZEQJN8cNELg77gudNN7pDyE6IeqVYhBfHWEd6GWk
         VShncDwvLbt7eF5kA3OnZi0jx5lNUrsTvP9BaDvjxvp1XYVDcodlq6BU1Iy4dMO98HJb
         IMKlFpLz8vgF+gp8kjBUohU6QZlmaKdj2Zh8gAlNY1XKN21x1hN8Zt5QTGYinxJgSSvE
         qjVkoqSufzxwPyAqD1Qs0PXvIhLJQhIFOaz6PNj+fB9wkT4KH9mkfWxKCpomX4KwuCJi
         u9oTOOvqdh8HBVaJc4Vradq3H8dUL35l7YQ/d2z+8KjdRaBXHb9o8Mzzdjl6aZ3NigAz
         9/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN/84x4d9tezNEGiT4OLJCQS12dALZm7Mtolbs4OIU/1GZWfLNbppNfrYi6Fp/ZYmn2ruFG1ldNN1KxIXn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rqk/MqJ9Hs8ftcLLqXPBrjbv85yvKeCJCY96TY7MZU52t9v1
	PMjt8ULdwcEKZV3MXnRtglu+YzFYa16frQ4TFQ+JINi/ICawg+AWFz0ugHulZ+X9xn+dEthLzFY
	DRPWm6uJZC4KiITPIIh5/rA==
X-Google-Smtp-Source: AGHT+IGlIyq6CGoOQHt7EoQf0Q/6z4roPUZNjH46k/lCxiZd8Az5X5i/aF2lsphu6KPl7WGlY+LsQbU/H8QuAY5yUQ==
X-Received: from pgar21.prod.google.com ([2002:a05:6a02:2e95:b0:b1f:dcda:276e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:700f:b0:1f5:6f61:a0ac with SMTP id adf61e73a8af0-215ff0970a6mr6985221637.5.1747266211396;
 Wed, 14 May 2025 16:43:31 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:01 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <1f64e3c7f04fc725f4da4d57de1ea040b7a56952.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 22/51] mm: hugetlb: Refactor hugetlb allocation functions
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

Refactor dequeue_hugetlb_folio() and alloc_surplus_hugetlb_folio() to
take mpol, nid and nodemask. This decouples allocation of a folio from
a vma.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I890fb46fe8c6349383d8cf89befc68a4994eb416
---
 mm/hugetlb.c | 64 ++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5cc261b90e39..29d1a3fb10df 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1364,34 +1364,22 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct folio *dequeue_hugetlb_folio(struct hstate *h,
-					   struct vm_area_struct *vma,
-					   unsigned long address)
+static struct folio *dequeue_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
+					   struct mempolicy *mpol,
+					   int nid, nodemask_t *nodemask)
 {
 	struct folio *folio = NULL;
-	struct mempolicy *mpol;
-	gfp_t gfp_mask;
-	nodemask_t *nodemask;
-	pgoff_t ilx;
-	int nid;
-
-	gfp_mask = htlb_alloc_mask(h);
-	mpol = get_vma_policy(vma, address, h->order, &ilx);
-	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
 
 	if (mpol_is_preferred_many(mpol)) {
-		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
-							nid, nodemask);
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
 	if (!folio)
-		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
-							nid, nodemask);
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask, nid, nodemask);
 
-	mpol_cond_put(mpol);
 	return folio;
 }
 
@@ -2312,21 +2300,14 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 }
 
 /*
- * Use the VMA's mpolicy to allocate a huge page from the buddy.
+ * Allocate a huge page from the buddy allocator given memory policy and node information.
  */
 static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
-						 struct vm_area_struct *vma,
-						 unsigned long addr)
+						 gfp_t gfp_mask,
+						 struct mempolicy *mpol,
+						 int nid, nodemask_t *nodemask)
 {
 	struct folio *folio = NULL;
-	struct mempolicy *mpol;
-	gfp_t gfp_mask = htlb_alloc_mask(h);
-	int nid;
-	nodemask_t *nodemask;
-	pgoff_t ilx;
-
-	mpol = get_vma_policy(vma, addr, h->order, &ilx);
-	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
 
 	if (mpol_is_preferred_many(mpol)) {
 		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
@@ -2339,7 +2320,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 
 	if (!folio)
 		folio = alloc_surplus_hugetlb_folio_nodemask(h, gfp_mask, nid, nodemask);
-	mpol_cond_put(mpol);
+
 	return folio;
 }
 
@@ -2993,6 +2974,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+	gfp_t gfp_mask;
+	pgoff_t ilx;
+	int nid;
 
 	idx = hstate_index(h);
 
@@ -3032,7 +3018,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 		subpool_reservation_exists = npages_req == 0;
 	}
-
 	reservation_exists = vma_reservation_exists || subpool_reservation_exists;
 
 	/*
@@ -3048,21 +3033,30 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 			goto out_subpool_put;
 	}
 
+	mpol = get_vma_policy(vma, addr, h->order, &ilx);
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
-	if (ret)
+	if (ret) {
+		mpol_cond_put(mpol);
 		goto out_uncharge_cgroup_reservation;
+	}
+
+	gfp_mask = htlb_alloc_mask(h);
+	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
 
 	spin_lock_irq(&hugetlb_lock);
 
 	folio = NULL;
 	if (reservation_exists || available_huge_pages(h))
-		folio = dequeue_hugetlb_folio(h, vma, addr);
+		folio = dequeue_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
 
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_surplus_hugetlb_folio(h, vma, addr);
-		if (!folio)
+		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
+		if (!folio) {
+			mpol_cond_put(mpol);
 			goto out_uncharge_cgroup;
+		}
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&folio->lru, &h->hugepage_activelist);
 		folio_ref_unfreeze(folio, 1);
@@ -3087,6 +3081,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	spin_unlock_irq(&hugetlb_lock);
 
+	mpol_cond_put(mpol);
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	/* If vma accounting wasn't bypassed earlier, follow up with commit. */
-- 
2.49.0.1045.g170613ef41-goog


