Return-Path: <linux-fsdevel+bounces-49030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C40AB7999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4738C6B94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F8226D07;
	Wed, 14 May 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xa3c01dQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701C22DFB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266187; cv=none; b=KFkmdSipUaTqmDGOpg+jdt37vMsyZEoxTzexZVQ0eCTyenhmH+9ITG8QJYM/ssmt5N8MuYj8uaXLrkHweWAhUyjgl+jOUmEvPjp8DM0DGEakFVvTDogZ/KarH0StcOzLcQp/bCw78wf4cxvhmQD/SPpoOCHSQR6LOLSA4E+vICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266187; c=relaxed/simple;
	bh=yFnnXEcxo12WsAYC+UUgVp00wNV+FZx0rdKhgEEFr3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGllVjHDITciJgQ/0/uaPIqmWWtteqza/uKkO9OYQtFy6iZE7FSBOVuXgtsJD5yJREbCqJMjPBtzVO8k3fa0tXlC1YxAoNMYMIMuqTggawjDpHMr8TEqh4XLylSoErfxlxe3YkbWUQhCslQS7KSr8/w1Lp/nnWzZ93KFAispHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xa3c01dQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742951722b3so273091b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266185; x=1747870985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qICii8cPsGiem7fxgV97oCJmZqO43/DxZp5vXdV3WTg=;
        b=Xa3c01dQCn5Dak1WEOtMZq4hwERvrChCE72+LI2a6GqzHXeYi0YS250vkwAS0g+IaS
         5cDby+XvMq/4UG2LbTMST9qKhbndwwWJbD95XngrFoICTGdHtJxGruLhkRjg/fUUGC6z
         43ssm7ZFdYloBUXR5cT3hiUzBXSqWhvLO57CkF0NXrbrbETzwt8LuVvtxBFQV5fHheAp
         /zH3MHVw5Q/y4F+QzKwDERMxaysfvbp+tOwCXD17mZssah95axLcfae7tIh/BkkMzdl/
         6yJDtajscVrLT6A5Q4tlC0UXO7rfQnVx6Gwe91km4QkfDCJvszFobJ+zp1EHzM6TD9Au
         Qw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266185; x=1747870985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qICii8cPsGiem7fxgV97oCJmZqO43/DxZp5vXdV3WTg=;
        b=ocOPvyF4U9vBXW31Hgp2xm1ZusGOFhQk84kXMrG4+byVpYUM5G3Lo65viafbDElBtv
         jjr4S6To/gXzOhxyZMvHyJlEFerfESxltD8prJdu5CPpmBQJ22MHwsar0uIokucK2UNW
         W8Daz+seenBpxfDVVDBDYhi1dmyUZKZIQ0Lh9CMMYbsM8qXV4k8SLJ2Ug+TkRRkR8gOr
         BuzYDYyjJZx5L6ugOtRO65kopak8Z+oUxviOQ5tha/kHcz9pCCobrSpbfN45pV+iLKhV
         2odB+pqQdqo5mz2rFx+IPTJQvnfjOkaYu1C6FignuTozsO8HovflnMabA8u1kGpR/lCE
         rxyg==
X-Forwarded-Encrypted: i=1; AJvYcCWugkcxmFGssNpyW578cJm/LPC1XcTIhU8xp4qWbAEN1G8qDfkKh1MpfNODkPzPolhP+siWFtL6sMF3wXD8@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWIkJzI2zIVuLAznQ7nv4VnYANI32L4ic66RU8gowqxXCX1oM
	LSZ09y150oA7zZF+UGtr2sG4Ob0oPx1oLoTopiUcGx48+5/RxO3IqbZtYBbx4M0X/YnnO55OZZN
	tK4kTatIIsp3kPrEc4QkQPg==
X-Google-Smtp-Source: AGHT+IF9uxV4jKBR2ISNh3Rht7TIwj9ihxeO9BED9Bzl3yQgQuek7HskgQIB9opFNDkTcfi2+w8NurKVBa9O265TBw==
X-Received: from pfbcb11.prod.google.com ([2002:a05:6a00:430b:b0:730:7e2d:df69])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d09:b0:740:6f86:a0e6 with SMTP id d2e1a72fcca58-742984dafa0mr801571b3a.6.1747266184935;
 Wed, 14 May 2025 16:43:04 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:44 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <37f60bbd7d408cf6d421d0582462488262c720ab.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 05/51] KVM: guest_memfd: Skip LRU for guest_memfd folios
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

filemap_add_folio(), called from filemap_grab_folio(), adds the folio
onto some LRU list, which is not necessary for guest_memfd since
guest_memfd folios don't participate in any swapping.

This patch reimplements part of filemap_add_folio() to avoid adding
allocated guest_memfd folios to the filemap.

With shared to private conversions dependent on refcounts, avoiding
usage of LRU ensures that LRU lists no longer take any refcounts on
guest_memfd folios and significantly reduces the chance of elevated
refcounts during conversion.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ia2540d9fc132d46219e6e714fd42bc82a62a27fa
---
 mm/filemap.c           |  1 +
 mm/memcontrol.c        |  2 +
 virt/kvm/guest_memfd.c | 91 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b90cbeb4a1a..bed7160db214 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -954,6 +954,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
+EXPORT_SYMBOL_GPL(__filemap_add_folio);
 
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c96c1f2b9cf5..1def80570738 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4611,6 +4611,7 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__mem_cgroup_charge);
 
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
@@ -4785,6 +4786,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	uncharge_folio(folio, &ug);
 	uncharge_batch(&ug);
 }
+EXPORT_SYMBOL_GPL(__mem_cgroup_uncharge);
 
 void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f802116290ce..6f6c4d298f8f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -466,6 +466,38 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
+static int __kvm_gmem_filemap_add_folio(struct address_space *mapping,
+					struct folio *folio, pgoff_t index)
+{
+	void *shadow = NULL;
+	gfp_t gfp;
+	int ret;
+
+	gfp = mapping_gfp_mask(mapping);
+
+	__folio_set_locked(folio);
+	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
+	__folio_clear_locked(folio);
+
+	return ret;
+}
+
+/*
+ * Adds a folio to the filemap for guest_memfd. Skips adding the folio to any
+ * LRU list.
+ */
+static int kvm_gmem_filemap_add_folio(struct address_space *mapping,
+					     struct folio *folio, pgoff_t index)
+{
+	int ret;
+
+	ret = __kvm_gmem_filemap_add_folio(mapping, folio, index);
+	if (!ret)
+		folio_set_unevictable(folio);
+
+	return ret;
+}
+
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -477,8 +509,46 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
+	struct folio *folio;
+	gfp_t gfp;
+	int ret;
+
+repeat:
+	folio = filemap_lock_folio(inode->i_mapping, index);
+	if (!IS_ERR(folio))
+		return folio;
+
+	gfp = mapping_gfp_mask(inode->i_mapping);
+
 	/* TODO: Support huge pages. */
-	return filemap_grab_folio(inode->i_mapping, index);
+	folio = filemap_alloc_folio(gfp, 0);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	ret = mem_cgroup_charge(folio, NULL, gfp);
+	if (ret) {
+		folio_put(folio);
+		return ERR_PTR(ret);
+	}
+
+	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
+	if (ret) {
+		folio_put(folio);
+
+		/*
+		 * There was a race, two threads tried to get a folio indexing
+		 * to the same location in the filemap. The losing thread should
+		 * free the allocated folio, then lock the folio added to the
+		 * filemap by the winning thread.
+		 */
+		if (ret == -EEXIST)
+			goto repeat;
+
+		return ERR_PTR(ret);
+	}
+
+	__folio_set_locked(folio);
+	return folio;
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -956,23 +1026,28 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+static void kvm_gmem_invalidate(struct folio *folio)
+{
+	kvm_pfn_t pfn = folio_pfn(folio);
+
+	kvm_arch_gmem_invalidate(pfn, pfn + folio_nr_pages(folio));
+}
+#else
+static inline void kvm_gmem_invalidate(struct folio *folio) {}
+#endif
+
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
+	folio_clear_unevictable(folio);
 
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+	kvm_gmem_invalidate(folio);
 }
-#endif
 
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.free_folio = kvm_gmem_free_folio,
-#endif
 };
 
 static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
-- 
2.49.0.1045.g170613ef41-goog


