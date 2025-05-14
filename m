Return-Path: <linux-fsdevel+bounces-49041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E51AB79CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737A27AA531
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D622F392;
	Wed, 14 May 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwGpqAg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEB242923
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266204; cv=none; b=L1sJewYg4uk2kaFesRZmLv9Q0BmUF3VsMeDvohi4GA3VUvhNRoYJtahcj6L74RXf3ghc56OEVTseYwPKXcMQ0BNFfJclc3lqEEsE25mRhfvNAHzZx537Gg4PFKHieigGPIefjZN4feYOdGOT5iSzy5RWHu6LiZ76D3PrNEfhOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266204; c=relaxed/simple;
	bh=oDGLsbNd0LFnQpe9m623cVt5GSRtxYpnAP9K0Tz+McI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jwZ7gF2geyqMU7ui/Ppgj0QuW5SKhJBYVkZdlCN61NDxwYcWqYEQeL2D+q2ozrBDZ2sidXNVNmmb3yxnVpzWRFvOsOPfLJ411YwqRj7Std6fDAjIcfDwooaUFRv+E1qYI0WH3YGeSlUPmeBnz4NgEYW1Ycu5DdJT0Btn+26aep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwGpqAg1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22c31b55ac6so5499205ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266202; x=1747871002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsmcesfFZlM8vI9EmxVXAuSJMymuSrAMKnT60ysxEi8=;
        b=VwGpqAg1Lo1nEQSAPNAKq8yobsQbMGlAcDivNdT0yausF9o03kYhUpGhVx02F5XVuz
         6ZO7iOak2Sym4cNKwXWZpgLojHmMzjr7fyqcJUxWBwim3ZbompUgvARsMSnl5A9a8Nys
         V1GfuS8CCXH4OurkveUWEF47uVRgzOwwCnBDubDs7LQa13sLNDbBguGzKPUDbjxnKKcV
         ZpnqETrJFkwGid2hSS6nPiXcg1ixiidcpzMW9VG2rSs6ks/ATcbxv15lvGCICnmDzBhv
         XduNfsSpUF8ATvmsBMmsxE6qhBur0V4gXa6TKJ8nPmWiH3cRS55lHLrT4WzbnkK1wWak
         3Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266202; x=1747871002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsmcesfFZlM8vI9EmxVXAuSJMymuSrAMKnT60ysxEi8=;
        b=KsGvuYOlOFn/iGrlcDUOFDvfNqXj3MT7u5aLeA+6vDRXx9EwyfDHn7dTtNH4IiUBWT
         nGz77hNUzm30gzQs+/mW462TEwhbMVZs/lmeYaUnOxwWYvjLdvqDcYPov8qffPggOp35
         VpWMStI1NCp0PSbZpxsctvGcUQva9B+JMZyPbYuor67TbQOTbT/j2TqggYrDumEKUcKy
         fTIqEK2E9eCy5czX7X5LrDUJUgWGeNlZBKL0DTGwHAfcrPWtfjOy3lTE/lydLjfvBjo+
         USsnPaWe1wIO3mNQiPUWcGLde9NM7K6y/Iu7n3auRgvsoQjpKcf43LOmhBVXvS+jOTo1
         uCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPNGHBMjLci5+xKSghz5o9e5oD7RLJ7XL51+1CQ2Ewx57T4TvDxy2pk55WKJXKulQKdO8MimpOQNvo+R7H@vger.kernel.org
X-Gm-Message-State: AOJu0YwAg6JWeZLUfwkMrX8LDuRP0eksU9Ax1neVjBVMnmmZBOuFwTw1
	jBuaFF203tMEgYkvOLFlr+XaPQ+O1d7mWEHbPSMOBm5pb0K3bEI4IQL6yIcP4HwsVOtOcmf56I3
	7MltUQDjrWGQre8aoYEbzdg==
X-Google-Smtp-Source: AGHT+IF/P4aWlf9UdfQ/8YaI5I5tpZ8zq5xGXr4nPXfnbppEkqE1Ea4GA3jweli9KF4XtKTltUhzxoFBstS+BIdJOA==
X-Received: from plbmb16.prod.google.com ([2002:a17:903:990:b0:223:4788:2e83])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c6:b0:22e:7c70:ed12 with SMTP id d9443c01a7336-231981521a7mr91558935ad.48.1747266201996;
 Wed, 14 May 2025 16:43:21 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:55 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 16/51] mm: hugetlb: Consolidate interpretation of
 gbl_chg within alloc_hugetlb_folio()
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

Previously, gbl_chg was passed from alloc_hugetlb_folio() into
dequeue_hugetlb_folio_vma(), leaking the concept of gbl_chg into
dequeue_hugetlb_folio_vma().

This patch consolidates the interpretation of gbl_chg into
alloc_hugetlb_folio(), also renaming dequeue_hugetlb_folio_vma() to
dequeue_hugetlb_folio() so dequeue_hugetlb_folio() can just focus on
dequeuing a folio.

Change-Id: I31bf48af2400b6e13b44d03c8be22ce1a9092a9c
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6ea1be71aa42..b843e869496f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1364,9 +1364,9 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
-				struct vm_area_struct *vma,
-				unsigned long address, long gbl_chg)
+static struct folio *dequeue_hugetlb_folio(struct hstate *h,
+					   struct vm_area_struct *vma,
+					   unsigned long address)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1374,13 +1374,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	nodemask_t *nodemask;
 	int nid;
 
-	/*
-	 * gbl_chg==1 means the allocation requires a new page that was not
-	 * reserved before.  Making sure there's at least one free page.
-	 */
-	if (gbl_chg && !available_huge_pages(h))
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1398,9 +1391,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 
 	mpol_cond_put(mpol);
 	return folio;
-
-err:
-	return NULL;
 }
 
 /*
@@ -3074,12 +3064,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		goto out_uncharge_cgroup_reservation;
 
 	spin_lock_irq(&hugetlb_lock);
+
 	/*
-	 * glb_chg is passed to indicate whether or not a page must be taken
-	 * from the global free pool (global change).  gbl_chg == 0 indicates
-	 * a reservation exists for the allocation.
+	 * gbl_chg == 0 indicates a reservation exists for the allocation - so
+	 * try dequeuing a page. If there are available_huge_pages(), try using
+	 * them!
 	 */
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
+	folio = NULL;
+	if (!gbl_chg || available_huge_pages(h))
+		folio = dequeue_hugetlb_folio(h, vma, addr);
+
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
-- 
2.49.0.1045.g170613ef41-goog


