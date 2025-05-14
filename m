Return-Path: <linux-fsdevel+bounces-49044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84134AB79C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BAF16C289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2224886F;
	Wed, 14 May 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seZ6CoU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C8245019
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266209; cv=none; b=Hp9uwcOwat5tkA2ilCL7+GDI3rz76oOFWzMSFuCidFhlbtaYapbUAqT0kMQDcNHOM7yzQKMHxM6wzuZjr13lciI+62sielc6vD01CyxHl6rFHwYtaJcTFN914SgreeVOqLpYNOXz6u2DEAldVfn1Y1b0c5NxQcZuV7Jv/1woqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266209; c=relaxed/simple;
	bh=0/T6Mrd1tLR+CRRQguZ0xMQEiqUuznphaf6jJwSvnvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qf+3tbN5ldWDn9gEsSPZhaG3ya+k9LrfEl7MJ9Cmpa6gHgx9Js74qfwoKQzA6ZdEilgo7LgzVua5E0GTD54D8kkJT8f7ECwyUU88a/8aG4JUs96FMVqFjDIHgRg2PlCKJ+CDSBwsyCS4ijW2ijhm1w4IZ+988JoeJ+YLOCTxjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seZ6CoU1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so143502a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266207; x=1747871007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5oaNONcPwTQNIIHvMztjnu28D1ASTydoh1/NvmmsKm4=;
        b=seZ6CoU1cdmBISfwdI2rooQgKJZ1G3ejJasMflQ8Mk1rGgzBnSBvfB42UcOigGlQL4
         P7NIP94bhrMyrZ7/bkBbZMVS8XvMMtPyibvbEEWPSccuh3Df8ssgoLr2hvyBrbfL+3Dj
         3qO54qlwhE/2qYu/oa2Wz+gSkos+TFbojAhhtGOg2pZxBNgfBUGSSn/qa6fq6DuG6QCo
         98lkBIzG1MtyO64jJd336Ur5Zcxq3mhhJiihhdnwC5I4OiINhwq0qJhYQHdLRuOrpEn/
         TU5iYcfLgPAmbBKkHBBqYqahOVU8faB4KktBLo4dXlIokH2VkhITxtVLfRObLLwZOSsN
         hs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266207; x=1747871007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oaNONcPwTQNIIHvMztjnu28D1ASTydoh1/NvmmsKm4=;
        b=AFXyAGJ64g9ZZAKIl7ybcVJD+h6CkLhI4jhHBTEDqKqdttEQOTifrG2OLdwxRXGs7M
         kkrA07TQPSM77Jdm4znPvzfLAGHgAe3q9oN9t9Uyw+bljvhEJ0TDGSOYzZ1xELd+rs05
         SnC81EJxUNvsuqvPNmMRQ/tCR+Q5316IEHWUy8HRSy6H4RdTtqTDr5gQQ4Lq2P0vTaWf
         FM/kZ+PiUXr2XMK1OcOHrrN4nQy73Rg+OAKc1UfOFWheFbRWEb3BVls1qXGWrjBxNuUT
         5NmKfbvw0OxB4xxMFOdkwUHUSZ0+mAtptaFo9ggapH08Ywywt4V+AZ9IanEKw4tedO7f
         NVJA==
X-Forwarded-Encrypted: i=1; AJvYcCVzjlzhK27ldYc3bVLnr+jUZwcq5Y/NZXjfLS10DAZOzto6bc2C0E4pvVJOtwHYGfdbjbK/UTD433jVXO0n@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVCj+FtHsWwPCSfuXGiQFDusC+mc7o+qZfdBsGMjboPsduITv
	/PFp/JukmiwQsIEf5eJZQvAu8nV71qm4j3UZFCuyGGFxchYWXM0suolh1E93XSNRrzxGo66m4yF
	RRnrJC4cZXDoxjctawboOQw==
X-Google-Smtp-Source: AGHT+IFDw6Fhs5VsEhgFA8tXL8E4i6uAaDFqGq3lNYpfsvbH4tE4uhaRVHc3Hip3C1CIUzADwan554jzbkPTgKA3mg==
X-Received: from pgbfm8.prod.google.com ([2002:a05:6a02:4988:b0:b0b:301e:8e96])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6005:b0:1f5:82ae:69d1 with SMTP id adf61e73a8af0-215ff1254b5mr7372409637.20.1747266206677;
 Wed, 14 May 2025 16:43:26 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:58 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <66aa28f888e392f7039de1c20ef854fb05a3c839.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 19/51] mm: hugetlb: Rename alloc_surplus_hugetlb_folio
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

Rename alloc_surplus_hugetlb_folio vs
alloc_surplus_hugetlb_folio_nodemask to align with
dequeue_hugetlb_folio vs dequeue_hugetlb_folio_nodemask.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I38982497eb70aeb174c386ed71bb896d85939eae
---
 mm/hugetlb.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67144af7ab79..b822b204e9b3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2236,7 +2236,7 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * Allocates a fresh surplus page from the page allocator.
  */
-static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
+static struct folio *alloc_surplus_hugetlb_folio_nodemask(struct hstate *h,
 				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
 {
 	struct folio *folio = NULL;
@@ -2312,9 +2312,9 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 /*
  * Use the VMA's mpolicy to allocate a huge page from the buddy.
  */
-static
-struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
-		struct vm_area_struct *vma, unsigned long addr)
+static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
+						 struct vm_area_struct *vma,
+						 unsigned long addr)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -2326,14 +2326,14 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 	if (mpol_is_preferred_many(mpol)) {
 		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
-		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio_nodemask(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
 	if (!folio)
-		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio_nodemask(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
 	return folio;
 }
@@ -2435,14 +2435,14 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 		/* Prioritize current node */
 		if (node_isset(numa_mem_id(), alloc_nodemask))
-			folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+			folio = alloc_surplus_hugetlb_folio_nodemask(h, htlb_alloc_mask(h),
 					numa_mem_id(), NULL);
 
 		if (!folio) {
 			for_each_node_mask(node, alloc_nodemask) {
 				if (node == numa_mem_id())
 					continue;
-				folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+				folio = alloc_surplus_hugetlb_folio_nodemask(h, htlb_alloc_mask(h),
 						node, NULL);
 				if (folio)
 					break;
@@ -3055,7 +3055,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+		folio = alloc_surplus_hugetlb_folio(h, vma, addr);
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
@@ -3868,11 +3868,12 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * First take pages out of surplus state.  Then make up the
 	 * remaining difference by allocating fresh huge pages.
 	 *
-	 * We might race with alloc_surplus_hugetlb_folio() here and be unable
-	 * to convert a surplus huge page to a normal huge page. That is
-	 * not critical, though, it just means the overall size of the
-	 * pool might be one hugepage larger than it needs to be, but
-	 * within all the constraints specified by the sysctls.
+	 * We might race with alloc_surplus_hugetlb_folio_nodemask()
+	 * here and be unable to convert a surplus huge page to a normal
+	 * huge page. That is not critical, though, it just means the
+	 * overall size of the pool might be one hugepage larger than it
+	 * needs to be, but within all the constraints specified by the
+	 * sysctls.
 	 */
 	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, -1))
@@ -3930,10 +3931,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * By placing pages into the surplus state independent of the
 	 * overcommit value, we are allowing the surplus pool size to
 	 * exceed overcommit. There are few sane options here. Since
-	 * alloc_surplus_hugetlb_folio() is checking the global counter,
-	 * though, we'll note that we're not allowed to exceed surplus
-	 * and won't grow the pool anywhere else. Not until one of the
-	 * sysctls are changed, or the surplus pages go out of use.
+	 * alloc_surplus_hugetlb_folio_nodemask() is checking the global
+	 * counter, though, we'll note that we're not allowed to exceed
+	 * surplus and won't grow the pool anywhere else. Not until one
+	 * of the sysctls are changed, or the surplus pages go out of
+	 * use.
 	 *
 	 * min_count is the expected number of persistent pages, we
 	 * shouldn't calculate min_count by using
-- 
2.49.0.1045.g170613ef41-goog


