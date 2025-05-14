Return-Path: <linux-fsdevel+bounces-49048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18506AB79D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9673017A593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0E2505A2;
	Wed, 14 May 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeIz9LFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A224E4A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266215; cv=none; b=oEoCGxg9Y0UJZye5xnEA+fBC9KaHEfPvFFOJefjulPF6LHVpxx08RDYZacdl2IlATUL4oqNV2ok1g5zj/AofVGd0G6baYskfa+ivcPAMEpwTaFaWzScW60HvEwsJmx4NXVHmPu46xiJZ+4JxIJcTLQyVbpf5QizAU0wW08KStGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266215; c=relaxed/simple;
	bh=9IWf7Q3oE3YTh1nzFjdFC9zybFJm+g92r90fv7ZGhhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=blsWjvhTMF11JVmq8bKTuaTqZUwxy1RAyYfPS6Ea1GzKvhUL4B6G32IOY15VUuIoLq+kn7D8fjS3I4Eh1w/Vumnw8YkHiXPanlV1rrTNEfTGi/J3p93EXLs2TnTdf0244kaBUXf/tLGlSJoGsbPqQF2Wiq/ZU62jhxJSeMClbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeIz9LFD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ad109bc89so371405a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266213; x=1747871013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlApZPNMFWcR7jIJ9KHUoWOXBlzS7oZ5fyFUsGvGlHI=;
        b=yeIz9LFDa9x4TMSfx/RqwFPMOPwhuTRIsn51G/g/NxJFazXL+9Ov2aRjSbs3nxeHF7
         8JRIiu0hh/usStOL12DJhMpcb3sRzRgeAHpMISrzGzjP53khsROs/5FvXgIEN9Tepi4+
         1Bu8mGat4OsLcmepyMJEPpaqAJWo2xdnMMHQJwZDxHyhARWaNRrBuxRQtsLvg+lPtGKh
         qLjobxdd5H1gSRTVlPLvwDbKj+YvEVLHXJigd0TaEEf762VaiRBW4njbAThaCNqdeDCB
         FWD/UqBu5oPOTLlxo8HQYTb4cVc6IrvmvjUP5rVAvZ337cBr+lqyxaR6OUBKZEcxw9eO
         vZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266213; x=1747871013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlApZPNMFWcR7jIJ9KHUoWOXBlzS7oZ5fyFUsGvGlHI=;
        b=hzfgMQtREGzhBvozLyhP2hEbXfDpER+X7mkvIHxKonXSeLG8aDSEGIrITnLul7AOKa
         +0lCJVIA1yqYFMQUmmfKve+3nzVnQG/3khsVF44fF9hSQjMPHo9efDREpTvIwexC0ysp
         GBVIrDbQmo4tk/bBSvA4Xl5Wc9jzHYSEP0eCqd1aVnzX/xLiWNno13gcXxzQ+nSD/6wl
         avolJu2+BU2ZFIVT9oCrA0/R2Jy2p8/fFpe1N2iPdRRq1RTQyqpKuylsLvHf/OcbfqsX
         5rwt3IHDcw1YZxHBqwfSwRWxhiChgeS4mm18F2ipoG+tz/zL+HKBE8Zv6BZCFGrm65cM
         ihvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB+uWLb4oumoMPj7KMgtclb0UOe2uVqXWw02+rZ9E08y1WpLPldHGGfjF2VTyUTmz4W5aLVliHAkl04LUd@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJLqLWUVodFoyXO2hf6+BEICXBkUB44dRXqsU/Uy2k9qL5iCR
	Egmy0hkshhqxRwHau22rRslXl9KhxgWsUgB9fyDblRyrZHIFC3WpGZ3n8nPG41f3ynFs2OllKxX
	x6cpMDUpjcjtUJIf8SdtPsA==
X-Google-Smtp-Source: AGHT+IGpGoT229pDQNLOtvYT1MW+Z5D28EV3QKdaocKPzRw0I86J+skBPLzQ0QgVUYX98zFangxne/p4We6UZ3/4Ig==
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:301:1ea9:63b0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57c4:b0:2fa:15ab:4de7 with SMTP id 98e67ed59e1d1-30e51589dbamr900643a91.12.1747266212707;
 Wed, 14 May 2025 16:43:32 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:02 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <bdd00f8a1919794da94ba366529756bd6b925ade.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 23/51] mm: hugetlb: Refactor out hugetlb_alloc_folio()
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

Refactor out hugetlb_alloc_folio() from alloc_hugetlb_folio(), which
handles allocation of a folio and cgroup charging.

Other than flags to control charging in the allocation process,
hugetlb_alloc_folio() also has parameters for memory policy.

This refactoring as a whole decouples the hugetlb page allocation from
hugetlbfs, (1) where the subpool is stored at the fs mount, (2)
reservations are made during mmap and stored in the vma, and (3) mpol
must be stored at vma->vm_policy (4) a vma must be used for allocation
even if the pages are not meant to be used by host process.

This decoupling will allow hugetlb_alloc_folio() to be used by
guest_memfd in later patches. In guest_memfd, (1) a subpool is created
per-fd and is stored on the inode, (2) no vma-related reservations are
used (3) mpol may not be associated with a vma since (4) for private
pages, the pages will not be mappable to userspace and hence have to
associated vmas.

This could hopefully also open hugetlb up as a more generic source of
hugetlb pages that are not bound to hugetlbfs, with the complexities
of userspace/mmap/vma-related reservations contained just to
hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I60528f246341268acbf0ed5de7752ae2cacbef93
---
 include/linux/hugetlb.h |  12 +++
 mm/hugetlb.c            | 192 ++++++++++++++++++++++------------------
 2 files changed, 118 insertions(+), 86 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8f3ac832ee7f..8ba941d88956 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -698,6 +698,9 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
+struct folio *hugetlb_alloc_folio(struct hstate *h, struct mempolicy *mpol,
+				  pgoff_t ilx, bool charge_cgroup_rsvd,
+				  bool use_existing_reservation);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1099,6 +1102,15 @@ static inline void wait_for_freed_hugetlb_folios(void)
 {
 }
 
+static inline struct folio *hugetlb_alloc_folio(struct hstate *h,
+						struct mempolicy *mpol,
+						pgoff_t ilx,
+						bool charge_cgroup_rsvd,
+						bool use_existing_reservation)
+{
+	return NULL;
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 29d1a3fb10df..5b088fe002a2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2954,6 +2954,101 @@ void wait_for_freed_hugetlb_folios(void)
 	flush_work(&free_hpage_work);
 }
 
+/**
+ * hugetlb_alloc_folio() - Allocates a hugetlb folio.
+ *
+ * @h: struct hstate to allocate from.
+ * @mpol: struct mempolicy to apply for this folio allocation.
+ * @ilx: Interleave index for interpretation of @mpol.
+ * @charge_cgroup_rsvd: Set to true to charge cgroup reservation.
+ * @use_existing_reservation: Set to true if this allocation should use an
+ *                            existing hstate reservation.
+ *
+ * This function handles cgroup and global hstate reservations. VMA-related
+ * reservations and subpool debiting must be handled by the caller if necessary.
+ *
+ * Return: folio on success or negated error otherwise.
+ */
+struct folio *hugetlb_alloc_folio(struct hstate *h, struct mempolicy *mpol,
+				  pgoff_t ilx, bool charge_cgroup_rsvd,
+				  bool use_existing_reservation)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	struct hugetlb_cgroup *h_cg = NULL;
+	struct folio *folio = NULL;
+	nodemask_t *nodemask;
+	gfp_t gfp_mask;
+	int nid;
+	int idx;
+	int ret;
+
+	idx = hstate_index(h);
+
+	if (charge_cgroup_rsvd) {
+		if (hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg))
+			goto out;
+	}
+
+	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg))
+		goto out_uncharge_cgroup_reservation;
+
+	gfp_mask = htlb_alloc_mask(h);
+	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
+
+	spin_lock_irq(&hugetlb_lock);
+
+	if (use_existing_reservation || available_huge_pages(h))
+		folio = dequeue_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
+
+	if (!folio) {
+		spin_unlock_irq(&hugetlb_lock);
+		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
+		if (!folio)
+			goto out_uncharge_cgroup;
+		spin_lock_irq(&hugetlb_lock);
+		list_add(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
+		/* Fall through */
+	}
+
+	if (use_existing_reservation) {
+		folio_set_hugetlb_restore_reserve(folio);
+		h->resv_huge_pages--;
+	}
+
+	hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio);
+
+	if (charge_cgroup_rsvd)
+		hugetlb_cgroup_commit_charge_rsvd(idx, nr_pages, h_cg, folio);
+
+	spin_unlock_irq(&hugetlb_lock);
+
+	gfp_mask = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+	ret = mem_cgroup_charge_hugetlb(folio, gfp_mask);
+	/*
+	 * Unconditionally increment NR_HUGETLB here. If it turns out that
+	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
+	 * decrement NR_HUGETLB.
+	 */
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
+
+	if (ret == -ENOMEM) {
+		free_huge_folio(folio);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return folio;
+
+out_uncharge_cgroup:
+	hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg);
+out_uncharge_cgroup_reservation:
+	if (charge_cgroup_rsvd)
+		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg);
+out:
+	folio = ERR_PTR(-ENOSPC);
+	goto out;
+}
+
 /*
  * NOTE! "cow_from_owner" represents a very hacky usage only used in CoW
  * faults of hugetlb private mappings on top of a non-page-cache folio (in
@@ -2971,16 +3066,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	bool reservation_exists;
 	bool charge_cgroup_rsvd;
 	struct folio *folio;
-	int ret, idx;
-	struct hugetlb_cgroup *h_cg = NULL;
-	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 	struct mempolicy *mpol;
-	nodemask_t *nodemask;
-	gfp_t gfp_mask;
 	pgoff_t ilx;
-	int nid;
-
-	idx = hstate_index(h);
 
 	if (cow_from_owner) {
 		/*
@@ -3020,69 +3107,22 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	}
 	reservation_exists = vma_reservation_exists || subpool_reservation_exists;
 
-	/*
-	 * If a vma_reservation_exists, we can skip charging hugetlb
-	 * reservations since that was charged in hugetlb_reserve_pages() when
-	 * the reservation was recorded on the resv_map.
-	 */
-	charge_cgroup_rsvd = !vma_reservation_exists;
-	if (charge_cgroup_rsvd) {
-		ret = hugetlb_cgroup_charge_cgroup_rsvd(
-			idx, pages_per_huge_page(h), &h_cg);
-		if (ret)
-			goto out_subpool_put;
-	}
-
 	mpol = get_vma_policy(vma, addr, h->order, &ilx);
 
-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
-	if (ret) {
-		mpol_cond_put(mpol);
-		goto out_uncharge_cgroup_reservation;
-	}
-
-	gfp_mask = htlb_alloc_mask(h);
-	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
-
-	spin_lock_irq(&hugetlb_lock);
-
-	folio = NULL;
-	if (reservation_exists || available_huge_pages(h))
-		folio = dequeue_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
-
-	if (!folio) {
-		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
-		if (!folio) {
-			mpol_cond_put(mpol);
-			goto out_uncharge_cgroup;
-		}
-		spin_lock_irq(&hugetlb_lock);
-		list_add(&folio->lru, &h->hugepage_activelist);
-		folio_ref_unfreeze(folio, 1);
-		/* Fall through */
-	}
-
 	/*
-	 * Either dequeued or buddy-allocated folio needs to add special
-	 * mark to the folio when it consumes a global reservation.
+	 * If a vma_reservation_exists, we can skip charging cgroup reservations
+	 * since that was charged during vma reservation. Use a reservation as
+	 * long as it exists.
 	 */
-	if (reservation_exists) {
-		folio_set_hugetlb_restore_reserve(folio);
-		h->resv_huge_pages--;
-	}
-
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
-
-	if (charge_cgroup_rsvd) {
-		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, folio);
-	}
-
-	spin_unlock_irq(&hugetlb_lock);
+	charge_cgroup_rsvd = !vma_reservation_exists;
+	folio = hugetlb_alloc_folio(h, mpol, ilx, charge_cgroup_rsvd,
+				    reservation_exists);
 
 	mpol_cond_put(mpol);
 
+	if (IS_ERR_OR_NULL(folio))
+		goto out_subpool_put;
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	/* If vma accounting wasn't bypassed earlier, follow up with commit. */
@@ -3091,9 +3131,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		/*
 		 * If there is a discrepancy in reservation status between the
 		 * time of vma_needs_reservation() and vma_commit_reservation(),
-		 * then there the page must have been added to the reservation
-		 * map between vma_needs_reservation() and
-		 * vma_commit_reservation().
+		 * then the page must have been added to the reservation map
+		 * between vma_needs_reservation() and vma_commit_reservation().
 		 *
 		 * Adjust for the subpool count incremented above AND
 		 * in hugetlb_reserve_pages for the same page.	Also,
@@ -3115,27 +3154,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	ret = mem_cgroup_charge_hugetlb(folio, gfp);
-	/*
-	 * Unconditionally increment NR_HUGETLB here. If it turns out that
-	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
-	 * decrement NR_HUGETLB.
-	 */
-	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-
-	if (ret == -ENOMEM) {
-		free_huge_folio(folio);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	return folio;
 
-out_uncharge_cgroup:
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
-out_uncharge_cgroup_reservation:
-	if (charge_cgroup_rsvd)
-		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
-						    h_cg);
 out_subpool_put:
 	if (!vma_reservation_exists)
 		hugepage_subpool_put_pages(spool, 1);
-- 
2.49.0.1045.g170613ef41-goog


