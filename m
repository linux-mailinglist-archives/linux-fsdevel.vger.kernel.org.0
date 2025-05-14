Return-Path: <linux-fsdevel+bounces-49043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D6AB79C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07DD3BABC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C924729F;
	Wed, 14 May 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpZy8O7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B11245037
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266207; cv=none; b=A+YkS97813Z1UzeYdiBENFJ8avI3xP5aKx5vHvreV+4UzNH54/nkHyso4ASNXXeSM96+d3BcIlC2TgQ9j6RdrYFghEx7IwEjQNWoznllamkmpSpnDtwbyPb9W8pfz7EJVOT3bBOdPk8y2MKO0YYi+ZqfKVyZoHNll5L1HT4ZFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266207; c=relaxed/simple;
	bh=kJAGQDoBsHG15Auu5vrc1qww/RHpjpxO2Cg3G3Gx12c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KLy2/f1Be3UcRGggXfXcdWMoowRS+Wt7+IOYfCvdSv/+E6ha81E1fyNlmWmh3taQAiXXrvD/Z4+VVa9iIKb0771LSl+Cr3cPp9MEb6cKiIDeQMY7qdb4ddoxmhvbnDRldRyH15Zl2FJJfsbR/GNeWNxjmotjBbF0HkzYHIgOO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QpZy8O7P; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1442e039eeso156715a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266205; x=1747871005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gu1hE3sOpXQcmnP4gjBDOWYVUzePLag+pWRkAyBiM5E=;
        b=QpZy8O7PiIxqMO0/JYlNqTGIwg7x3/ZNio5WCO1JQMbch4ZEfovFQTPoe92h+I5mFy
         e7WmTPbLPo2HGmH7jQ6E/F/uEkEoSSiI1jq1VjPOCOt947H9l0M7C2vVOaoq2fnRZrHb
         lpxTlxrOXucXjOmDfqHjztltl39HFU1leiCAA4W741RkpKusnibrf9XvDSdheiFtwmRx
         hIwVPBN6BTwKzCig8kPKa4fm86KPe9kMOJteEeCMpFg56QAKVw1I57zOlbjREjQsVWfN
         8sp1eyMoaJDvyEDzJe9GUYXA0Z2e4sVkaHzfrA3GjBesOwFI712y7jRk7c7nijdCGHHe
         E3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266205; x=1747871005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gu1hE3sOpXQcmnP4gjBDOWYVUzePLag+pWRkAyBiM5E=;
        b=OQCOwryN6nTzfHnmDQtPeE4twS5QKiyWIGGL6YDOREef6BUEEcmxOOg1xPFMa1bgnc
         HRice9OWYOeNCB0yx8BF/akv0DFdm5FUKxZCeXgP0YBLlfU6YxR2eHIX8Od/atATJw62
         CX/cG8MwSOwQ92ahMx3X8jGfQEm7xJEelkmM8Y8eYmoycU1PVizUcVHR0N+g17/7/qB6
         wSHV3CoZwtBBXEAvjjs5RiSR0875SK7InBpF2W/HQ67ldqQ50rDRrtabsbPbs5b6Rljf
         5OsNs2ZaRvsh2A7LgEJb6ail7XfZ4r9z3wzc7sWvBXTxD6b4GDdT+SB1plILb7DfrH9L
         k6iA==
X-Forwarded-Encrypted: i=1; AJvYcCVAAAlWtRVPCWapWABX8o5O5tBhzxX9/OUzjM0ZkTx3+Odyw0XAuLUuVDjJ7tTNpJo9O0ys1F7FIiffKa1b@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzr8i8zqSqHVfL8w/cqbRscTB51Cxy4ou9Yv39bmrDparrH6nH
	cfq99tX/x/fsSQ3/+KgV6j+c50nyN6naWpFasqHgbd5CljNQenbjnWGkuO6D6jFhz0pLJJfSVu8
	imgWyutacwPnkZkDXgYUfKQ==
X-Google-Smtp-Source: AGHT+IHrutaRsnjMWCkKIi090WWBQzOHOSc5C6RScHY9wSl72p4og14yPX1uNLmn95Ao7YjcjSzx202Z6voCwDWGow==
X-Received: from pjbeu14.prod.google.com ([2002:a17:90a:f94e:b0:2fc:2f33:e07d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2dc3:b0:30a:883a:ea5b with SMTP id 98e67ed59e1d1-30e2e5c84f4mr9725120a91.17.1747266205029;
 Wed, 14 May 2025 16:43:25 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:57 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <782bb82a0d2d62b616daebb77dc3d9e345fb76fa.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 18/51] mm: hugetlb: Cleanup interpretation of
 map_chg_state within alloc_hugetlb_folio()
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

Interpreting map_chg_state inline, within alloc_hugetlb_folio(),
improves readability.

Instead of having cow_from_owner and the result of
vma_needs_reservation() compute a map_chg_state, and then interpreting
map_chg_state within alloc_hugetlb_folio() to determine whether to

+ Get a page from the subpool or
+ Charge cgroup reservations or
+ Commit vma reservations or
+ Clean up reservations

This refactoring makes those decisions just based on whether a
vma_reservation_exists. If a vma_reservation_exists, the subpool had
already been debited and the cgroup had been charged, hence
alloc_hugetlb_folio() should not double-debit or double-charge. If the
vma reservation can't be used (as in cow_from_owner), then the vma
reservation effectively does not exist and vma_reservation_exists is
set to false.

The conditions for committing reservations or cleaning are also
updated to be paired with the corresponding conditions guarding
reservation creation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I22d72a2cae61fb64dc78e0a870b254811a06a31e
---
 mm/hugetlb.c | 94 ++++++++++++++++++++++------------------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 597f2b9f62b5..67144af7ab79 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2968,25 +2968,6 @@ void wait_for_freed_hugetlb_folios(void)
 	flush_work(&free_hpage_work);
 }
 
-typedef enum {
-	/*
-	 * For either 0/1: we checked the per-vma resv map, and one resv
-	 * count either can be reused (0), or an extra needed (1).
-	 */
-	MAP_CHG_REUSE = 0,
-	MAP_CHG_NEEDED = 1,
-	/*
-	 * Cannot use per-vma resv count can be used, hence a new resv
-	 * count is enforced.
-	 *
-	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
-	 * that currently vma_needs_reservation() has an unwanted side
-	 * effect to either use end() or commit() to complete the
-	 * transaction.	 Hence it needs to differenciate from NEEDED.
-	 */
-	MAP_CHG_ENFORCED = 2,
-} map_chg_state;
-
 /*
  * NOTE! "cow_from_owner" represents a very hacky usage only used in CoW
  * faults of hugetlb private mappings on top of a non-page-cache folio (in
@@ -3000,46 +2981,45 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	bool subpool_reservation_exists;
+	bool vma_reservation_exists;
 	bool reservation_exists;
+	bool charge_cgroup_rsvd;
 	struct folio *folio;
-	long retval;
-	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 
 	idx = hstate_index(h);
 
-	/* Whether we need a separate per-vma reservation? */
 	if (cow_from_owner) {
 		/*
 		 * Special case!  Since it's a CoW on top of a reserved
 		 * page, the private resv map doesn't count.  So it cannot
 		 * consume the per-vma resv map even if it's reserved.
 		 */
-		map_chg = MAP_CHG_ENFORCED;
+		vma_reservation_exists = false;
 	} else {
 		/*
 		 * Examine the region/reserve map to determine if the process
-		 * has a reservation for the page to be allocated.  A return
-		 * code of zero indicates a reservation exists (no change).
+		 * has a reservation for the page to be allocated and debit the
+		 * reservation.  If the number of pages required is 0,
+		 * reservation exists.
 		 */
-		retval = vma_needs_reservation(h, vma, addr);
-		if (retval < 0)
+		int npages_req = vma_needs_reservation(h, vma, addr);
+
+		if (npages_req < 0)
 			return ERR_PTR(-ENOMEM);
-		map_chg = retval ? MAP_CHG_NEEDED : MAP_CHG_REUSE;
+
+		vma_reservation_exists = npages_req == 0;
 	}
 
 	/*
-	 * Whether we need a separate global reservation?
-	 *
-	 * Processes that did not create the mapping will have no
-	 * reserves as indicated by the region/reserve map. Check
-	 * that the allocation will not exceed the subpool limit.
-	 * Or if it can get one from the pool reservation directly.
+	 * Debit subpool only if a vma reservation does not exist.  If
+	 * vma_reservation_exists, the vma reservation was either moved from the
+	 * subpool or taken directly from hstate in hugetlb_reserve_pages()
 	 */
 	subpool_reservation_exists = false;
-	if (map_chg) {
+	if (!vma_reservation_exists) {
 		int npages_req = hugepage_subpool_get_pages(spool, 1);
 
 		if (npages_req < 0)
@@ -3047,13 +3027,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 		subpool_reservation_exists = npages_req == 0;
 	}
-	reservation_exists = !map_chg || subpool_reservation_exists;
+
+	reservation_exists = vma_reservation_exists || subpool_reservation_exists;
 
 	/*
-	 * If this allocation is not consuming a per-vma reservation,
-	 * charge the hugetlb cgroup now.
+	 * If a vma_reservation_exists, we can skip charging hugetlb
+	 * reservations since that was charged in hugetlb_reserve_pages() when
+	 * the reservation was recorded on the resv_map.
 	 */
-	if (map_chg) {
+	charge_cgroup_rsvd = !vma_reservation_exists;
+	if (charge_cgroup_rsvd) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
 			idx, pages_per_huge_page(h), &h_cg);
 		if (ret)
@@ -3091,10 +3074,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	}
 
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
-	/* If allocation is not consuming a reservation, also store the
-	 * hugetlb_cgroup pointer on the page.
-	 */
-	if (map_chg) {
+
+	if (charge_cgroup_rsvd) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
 						  h_cg, folio);
 	}
@@ -3103,25 +3084,27 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	hugetlb_set_folio_subpool(folio, spool);
 
-	if (map_chg != MAP_CHG_ENFORCED) {
-		/* commit() is only needed if the map_chg is not enforced */
-		retval = vma_commit_reservation(h, vma, addr);
+	/* If vma accounting wasn't bypassed earlier, follow up with commit. */
+	if (!cow_from_owner) {
+		int ret = vma_commit_reservation(h, vma, addr);
 		/*
-		 * Check for possible race conditions. When it happens..
-		 * The page was added to the reservation map between
-		 * vma_needs_reservation and vma_commit_reservation.
-		 * This indicates a race with hugetlb_reserve_pages.
+		 * If there is a discrepancy in reservation status between the
+		 * time of vma_needs_reservation() and vma_commit_reservation(),
+		 * then there the page must have been added to the reservation
+		 * map between vma_needs_reservation() and
+		 * vma_commit_reservation().
+		 *
 		 * Adjust for the subpool count incremented above AND
 		 * in hugetlb_reserve_pages for the same page.	Also,
 		 * the reservation count added in hugetlb_reserve_pages
 		 * no longer applies.
 		 */
-		if (unlikely(map_chg == MAP_CHG_NEEDED && retval == 0)) {
+		if (unlikely(!vma_reservation_exists && ret == 0)) {
 			long rsv_adjust;
 
 			rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 			hugetlb_acct_memory(h, -rsv_adjust);
-			if (map_chg) {
+			if (charge_cgroup_rsvd) {
 				spin_lock_irq(&hugetlb_lock);
 				hugetlb_cgroup_uncharge_folio_rsvd(
 				    hstate_index(h), pages_per_huge_page(h),
@@ -3149,14 +3132,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
 out_uncharge_cgroup_reservation:
-	if (map_chg)
+	if (charge_cgroup_rsvd)
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg);
 out_subpool_put:
-	if (map_chg)
+	if (!vma_reservation_exists)
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
-	if (map_chg != MAP_CHG_ENFORCED)
+	/* If vma accounting wasn't bypassed earlier, cleanup. */
+	if (!cow_from_owner)
 		vma_end_reservation(h, vma, addr);
 	return ERR_PTR(-ENOSPC);
 }
-- 
2.49.0.1045.g170613ef41-goog


