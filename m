Return-Path: <linux-fsdevel+bounces-49058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327DAB7A01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18606176B55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AE3259C85;
	Wed, 14 May 2025 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecg/7N6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C7256C88
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266230; cv=none; b=nXGTHQBTlw7Z817VfqU5W/aNQSsQ2uvURAwVotURviVhzwLybMJ3RSoxHxLPWmooNRNhBCww96U3VOXP8te6kF5iNKcEeITYLM6VmkEBA/95jXhZZhBe6z3ly6k2E07TJcDrjWGoquHtrbP8INYwZKw0/bgn+sno4hfE3BAncbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266230; c=relaxed/simple;
	bh=JtCHgpy0nnZ9AybihcEVe9TWyhmxkNRuz0XK1RE8q5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPVyjnCCEKZfnRGSmNs1nY8sFfG1zytv+BWHKdo8FHQDb0BmSBYn7u5wJGIjtGu8TMFl03jRFQJikppPtEMfIDO/++7Ao2sgFO1y4n8oTKLpKP/VegPQrM3Wx2ESK+A8RIIb/ZCpuNtUx758sdZhPZhWkhksCjUVnj1inzCEcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecg/7N6j; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b20027d9ac0so145806a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266228; x=1747871028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGxf10xTbolob6ARtbQFmrKdEey0c2iLS6uYVAPHbb0=;
        b=ecg/7N6jr0tfsB4ivTK/RhHFVIF9I4gJjgNy1SzfJm0ym9RBTCxr4/bwPtaE9qP/sP
         UKJxACGq7Yqlv+fASu94LM8/CFjcZwx035SvNi7qIA+xO+es1wbYyhio5qXkuTxqofyj
         px3Pw4C97KsFcnbNOofmyq0EsOQC0VJMyVeMPh9wLHSQUamq9/CcvYogLVPzEkgCDK7i
         IWEB+0FuoUIUVy1tL8LFk0ifJw8ku/u8KGevunZuM+3vaImVV1aYjBp9iLccEKELcGLb
         EZq1VHf61JRtKUBL5Bm3QtpMt3AykZVPtAhdODmbzpjRvr14WA16yCz52p1+Pk5xTa9n
         T3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266228; x=1747871028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGxf10xTbolob6ARtbQFmrKdEey0c2iLS6uYVAPHbb0=;
        b=NT4ZcVnEhAzLJ3teks4H4c6xMR+WtJxi20VK2DXI8JJq87Oubis67vQWX2r+nfHs7V
         769QFNuoHxEOj8MrEnj9h1y3vLfS+Nnq54rn5VJjldbmHl9DaMOxKs+hpcTQSF7cXkgj
         gWgtE/YyeMdnDC6vtVKaqKooJU1RuTSq0EK22NpBrKF+qh+bWdB9FWMvhxuWcWTLk9su
         HYDL7T9CY0MRdPVWlvGMzSW+mB0v4hcfJhPt1XYMbhyXmgqVRHFsOTXicflO6KQeEEFy
         zFZvJJPN8w18LWhi1XUQcejGT3RUUGTXbGSm3K4uaj9Offl3sxMmoJJ4lBKK82pODEgP
         fbZA==
X-Forwarded-Encrypted: i=1; AJvYcCU36SLRYDHJ8aU8BYn1zyL677B7JrgkVpYm/Dq/xk0tFxj29nmksCYs+4Oi9hjsE8ev5P+VtnlJ4oS0X6U5@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLcR6lDNH/TCuOcQdlfEABhfaofgyhSEvyDs0dH9fb7L8/K0m
	5lqn/gZfVptHqiVSLNCHdzLP4KAkRuZdH0LLwCbJ3f6XWKAU+g7KGJje6fYmG9LLFnxdWfEiVLm
	shFHozPnMdqWzeGQ4/v2TSw==
X-Google-Smtp-Source: AGHT+IF3s18X1WXVSpREAFxwZmEiWRkEzf4FnXZJnpCpoYmdbOqB9rnOiNcmfKVh8wkeRqqYO9tvfAUew5Jususlyg==
X-Received: from pjbta5.prod.google.com ([2002:a17:90b:4ec5:b0:2ff:5752:a78f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c1:b0:2ee:9b09:7d3d with SMTP id 98e67ed59e1d1-30e51786009mr630115a91.19.1747266228378;
 Wed, 14 May 2025 16:43:48 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:12 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate from
 custom allocator
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

If a custom allocator is requested at guest_memfd creation time, pages
from the custom allocator will be used to back guest_memfd.

Change-Id: I59df960b3273790f42fe5bea54a234f40962eb75
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/memory.c            |   1 +
 virt/kvm/guest_memfd.c | 142 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 132 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ba3ea0a82f7f..3af45e96913c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7249,6 +7249,7 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
 	else
 		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
 }
+EXPORT_SYMBOL_GPL(folio_zero_user);
 
 static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 				   unsigned long addr_hint,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index c65d93c5a443..24d270b9b725 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -478,15 +478,13 @@ static inline void kvm_gmem_mark_prepared(struct folio *folio)
  * leaking host data and the up-to-date flag is set.
  */
 static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
-				  gfn_t gfn, struct folio *folio)
+				  gfn_t gfn, struct folio *folio,
+				  unsigned long addr_hint)
 {
-	unsigned long nr_pages, i;
 	pgoff_t index;
 	int r;
 
-	nr_pages = folio_nr_pages(folio);
-	for (i = 0; i < nr_pages; i++)
-		clear_highpage(folio_page(folio, i));
+	folio_zero_user(folio, addr_hint);
 
 	/*
 	 * Preparing huge folios should always be safe, since it should
@@ -554,7 +552,9 @@ static int kvm_gmem_filemap_add_folio(struct address_space *mapping,
  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
+	size_t allocated_size;
 	struct folio *folio;
+	pgoff_t index_floor;
 	int ret;
 
 repeat:
@@ -581,8 +581,10 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 			return ERR_PTR(ret);
 		}
 	}
+	allocated_size = folio_size(folio);
 
-	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
+	index_floor = round_down(index, folio_nr_pages(folio));
+	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index_floor);
 	if (ret) {
 		folio_put(folio);
 
@@ -598,7 +600,17 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 		return ERR_PTR(ret);
 	}
 
-	__folio_set_locked(folio);
+	spin_lock(&inode->i_lock);
+	inode->i_blocks += allocated_size / 512;
+	spin_unlock(&inode->i_lock);
+
+	/*
+	 * folio is the one that is allocated, this gets the folio at the
+	 * requested index.
+	 */
+	folio = page_folio(folio_file_page(folio, index));
+	folio_lock(folio);
+
 	return folio;
 }
 
@@ -736,6 +748,92 @@ static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
 	spin_unlock(&inode->i_lock);
 }
 
+/**
+ * kvm_gmem_zero_range() - Zeroes all sub-pages in range [@start, @end).
+ *
+ * @mapping: the filemap to remove this range from.
+ * @start: index in filemap for start of range (inclusive).
+ * @end: index in filemap for end of range (exclusive).
+ *
+ * The pages in range may be split. truncate_inode_pages_range() isn't the right
+ * function because it removes pages from the page cache; this function only
+ * zeroes the pages.
+ */
+static void kvm_gmem_zero_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end)
+{
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &start, end - 1, &fbatch)) {
+		unsigned int i;
+
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *f;
+			size_t nr_bytes;
+
+			f = fbatch.folios[i];
+			nr_bytes = offset_in_folio(f, end << PAGE_SHIFT);
+			if (nr_bytes == 0)
+				nr_bytes = folio_size(f);
+
+			folio_zero_segment(f, 0, nr_bytes);
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+}
+
+/**
+ * kvm_gmem_truncate_inode_range() - Truncate pages in range [@lstart, @lend).
+ *
+ * @inode: inode to truncate from.
+ * @lstart: offset in inode for start of range (inclusive).
+ * @lend: offset in inode for end of range (exclusive).
+ *
+ * Removes full (huge)pages from the filemap and zeroing incomplete
+ * (huge)pages. The pages in the range may be split.
+ */
+static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
+					  loff_t lend)
+{
+	pgoff_t full_hpage_start;
+	size_t nr_per_huge_page;
+	pgoff_t full_hpage_end;
+	size_t nr_pages;
+	pgoff_t start;
+	pgoff_t end;
+	void *priv;
+
+	priv = kvm_gmem_allocator_private(inode);
+	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
+
+	start = lstart >> PAGE_SHIFT;
+	end = min(lend, i_size_read(inode)) >> PAGE_SHIFT;
+
+	full_hpage_start = round_up(start, nr_per_huge_page);
+	full_hpage_end = round_down(end, nr_per_huge_page);
+
+	if (start < full_hpage_start) {
+		pgoff_t zero_end = min(full_hpage_start, end);
+
+		kvm_gmem_zero_range(inode->i_mapping, start, zero_end);
+	}
+
+	if (full_hpage_end > full_hpage_start) {
+		nr_pages = full_hpage_end - full_hpage_start;
+		kvm_gmem_truncate_inode_aligned_pages(inode, full_hpage_start,
+						      nr_pages);
+	}
+
+	if (end > full_hpage_end && end > full_hpage_start) {
+		pgoff_t zero_start = max(full_hpage_end, start);
+
+		kvm_gmem_zero_range(inode->i_mapping, zero_start, end);
+	}
+}
+
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
@@ -752,7 +850,12 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin(gmem, start, end);
 
-	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+	if (kvm_gmem_has_custom_allocator(inode)) {
+		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
+	} else {
+		/* Page size is PAGE_SIZE, so use optimized truncation function. */
+		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+	}
 
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_end(gmem, start, end);
@@ -776,6 +879,16 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 
 	start = offset >> PAGE_SHIFT;
 	end = (offset + len) >> PAGE_SHIFT;
+	if (kvm_gmem_has_custom_allocator(inode)) {
+		size_t nr_pages;
+		void *p;
+
+		p = kvm_gmem_allocator_private(inode);
+		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
+
+		start = round_down(start, nr_pages);
+		end = round_down(end, nr_pages);
+	}
 
 	r = 0;
 	for (index = start; index < end; ) {
@@ -1570,7 +1683,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 
 	*pfn = folio_file_pfn(folio, index);
 	if (max_order)
-		*max_order = 0;
+		*max_order = folio_order(folio);
 
 	*is_prepared = folio_test_uptodate(folio);
 	return folio;
@@ -1597,8 +1710,15 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		goto out;
 	}
 
-	if (!is_prepared)
-		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+	if (!is_prepared) {
+		/*
+		 * Use the same address as hugetlb for zeroing private pages
+		 * that won't be mapped to userspace anyway.
+		 */
+		unsigned long addr_hint = folio->index << PAGE_SHIFT;
+
+		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio, addr_hint);
+	}
 
 	folio_unlock(folio);
 
-- 
2.49.0.1045.g170613ef41-goog


