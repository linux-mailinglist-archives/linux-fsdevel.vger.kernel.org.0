Return-Path: <linux-fsdevel+bounces-49065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E693FAB7A16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBDD7A4E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4466263F42;
	Wed, 14 May 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcZycVHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAFC25D1EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266242; cv=none; b=gH7FMxbeLrjyP+FHQYktm2I8X/hjp+PGvpdog6emHGUY+cpNouA3VaIFKWso+pKRixcSGPZMwlY4oEmG99gmjSdm8/EfHuPQF4lGkf8bycGF+/cMbbUDcQQolLhzpVNt8pQP4dI4Cj0Yuo69eyPQ5iX1u4SmFygoEKcxOM+UPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266242; c=relaxed/simple;
	bh=3P1w96IQ4XSGB18Ay+axlVK9B9zTFk4aMEWu6OYLYcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYpvs6osX7beGgJXb3zDB4bTL4W6WUb29LqD45gMarYvgxDFcVE+iYZJLblL5erkZJDSfBaxhvGNTN0Ep6tyO6maJNt3KJu5AuVYzLqiWg3ZZX8+m/207uPH1N4wzcOPVV9JEUYJv40WTcMdffEpBjUd/Cg9a+ceTJCi+9rYKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcZycVHj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26cdc70befso168849a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266240; x=1747871040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w59iMjR8iadMOYtl6Kc2hNNZvpxUqRzRIVqBODddmXk=;
        b=xcZycVHjw4RW8M98HOF38surOmCoUT/RcVNXxjoYmXfH9icQ7eV6ADwT8IiFkZlj5M
         Pk/ljf6tJvphd+g9iL+9GgoaEQQ1SCdsP7SlLy83xGR49hnpp3B4lUIzg6GqE+3NQUko
         IkrPuY3oW7qPqNp2nCBX0w6YGUo1TdNZP4Mnv9aASeFQyQIrQFP4cZ9T1U3Shl67Hn8V
         JkV7EYXDaQWTOD6u0/rxSR4HOqBCszHwJ+yza/kDK/NWsCN9qrGd0SjmVGXzIZserK7/
         9kJ5zDqZFQH8jWudyy9kwytRoOMm0lLjhnJgRtDsByPmbTGlSX1ElftINp8ZsEgIsjXe
         d9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266240; x=1747871040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w59iMjR8iadMOYtl6Kc2hNNZvpxUqRzRIVqBODddmXk=;
        b=I/OCjCT4EfWSSGburW84GQDDLpVkw3Y+g27duWHJ+qudXN9Lrc4RdiSmNxI6UnB0jq
         qpnwbJVJNEs2e04zxS50TTwcaHtwD44DFinNq9dK6w2CpWBXKse+fyRXQUGkNqormNsW
         YXJIC4/DR2iEBxtj80MncWFEobWUNSUXXzFRn2XXkmv16b83ueMFO5Ik0rNMXMn3lPHO
         noLyWEiOBnlhx6TmL24ESG2XmAdClNTGTqWKSGm1HEQlhUVsNnbyAhimozLf/ZYOxBPO
         zovg5m86FYirugx0ZVyo9R7vAb1a2a3KoNryA10hez0vRg0l4usSXjMjONCucboPif+K
         eJRA==
X-Forwarded-Encrypted: i=1; AJvYcCV2i5n0uQK2CPGx9KsnxMFUmZA9zJKpzSEHfq7+R7cz32r+SPHsoxqZnA4N+xGBkypz8Xx+0JQNca4xoKba@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMG6+INL5YavBxD/7xhLnmQs0brQSPkR4BBUcdvj4BJmmYR23
	K2F+sD4f7ZLtxMPFpflnbOMLOjQAkJF38nebb09qsBpNOzLgMzHWr1SccbU4NOYURgx7HUlKod5
	oCeZrNVLQJa/riXrL9b4YZg==
X-Google-Smtp-Source: AGHT+IGyLkn3nqeNKfrPwmXh8d7PdkrS0NNj4rvg8/rg8+lUUn5fqkFx2CkNgkz2N4cDBWoYAECpFAIq4YtOUG++oA==
X-Received: from pjbsy6.prod.google.com ([2002:a17:90b:2d06:b0:2e0:915d:d594])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38cc:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-30e2e5dcdcamr9260937a91.18.1747266239615;
 Wed, 14 May 2025 16:43:59 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:19 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <3f48795c0c34f4faf661394e5ad9805f9014ae23.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 40/51] KVM: guest_memfd: Update kvm_gmem_mapping_order
 to account for page status
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

kvm_gmem_mapping_order() should return the maximum mapping order for a
gfn if a page were to be faulted in for that gfn.

For inodes that support a custom allocator, the maximum mapping order
should be determined by the custom allocator in conjunction with
guest_memfd.

This patch updates kvm_gmem_mapping_order() to take into account that
for the guestmem_hugetlb custom allocator, pages are split if any page
in a huge page range is shared.

Change-Id: I5c061af6cefdcbd708a4334cd58edc340afcf44e
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 72 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 04b1513c2998..8b5fe1360e58 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -709,19 +709,27 @@ static int kvm_gmem_split_folio_in_filemap(struct inode *inode, struct folio *fo
 	return ret;
 }
 
+static inline bool kvm_gmem_should_split_at_index(struct inode *inode,
+						  pgoff_t index)
+{
+	pgoff_t index_floor;
+	size_t nr_pages;
+	void *priv;
+
+	priv = kvm_gmem_allocator_private(inode);
+	nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
+	index_floor = round_down(index, nr_pages);
+
+	return kvm_gmem_has_some_shared(inode, index_floor, nr_pages);
+}
+
 static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
 						      struct folio *folio)
 {
-	size_t to_nr_pages;
-	void *priv;
-
 	if (!kvm_gmem_has_custom_allocator(inode))
 		return 0;
 
-	priv = kvm_gmem_allocator_private(inode);
-	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_page(priv);
-
-	if (kvm_gmem_has_some_shared(inode, folio->index, to_nr_pages))
+	if (kvm_gmem_should_split_at_index(inode, folio->index))
 		return kvm_gmem_split_folio_in_filemap(inode, folio);
 
 	return 0;
@@ -890,6 +898,12 @@ static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
 
 #else
 
+static inline bool kvm_gmem_should_split_at_index(struct inode *inode,
+						  pgoff_t index)
+{
+	return false;
+}
+
 static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
 						      struct folio *folio)
 {
@@ -1523,7 +1537,7 @@ static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
 	return get_file_active(&slot->gmem.file);
 }
 
-static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
+static pgoff_t kvm_gmem_get_index(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
@@ -2256,14 +2270,52 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
 /**
- * Returns the mapping order for this @gfn in @slot.
+ * kvm_gmem_mapping_order() - Get the mapping order for this @gfn in @slot.
+ *
+ * @slot: the memslot that gfn belongs to.
+ * @gfn: the gfn to look up mapping order for.
  *
  * This is equal to max_order that would be returned if kvm_gmem_get_pfn() were
  * called now.
+ *
+ * Return: the mapping order for this @gfn in @slot.
  */
 int kvm_gmem_mapping_order(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return 0;
+	struct inode *inode;
+	struct file *file;
+	int ret;
+
+	file = kvm_gmem_get_file((struct kvm_memory_slot *)slot);
+	if (!file)
+		return 0;
+
+	inode = file_inode(file);
+
+	ret = 0;
+	if (kvm_gmem_has_custom_allocator(inode)) {
+		bool should_split;
+		pgoff_t index;
+
+		index = kvm_gmem_get_index(slot, gfn);
+
+		filemap_invalidate_lock_shared(inode->i_mapping);
+		should_split = kvm_gmem_should_split_at_index(inode, index);
+		filemap_invalidate_unlock_shared(inode->i_mapping);
+
+		if (!should_split) {
+			size_t nr_pages;
+			void *priv;
+
+			priv = kvm_gmem_allocator_private(inode);
+			nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
+
+			ret = ilog2(nr_pages);
+		}
+	}
+
+	fput(file);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_mapping_order);
 
-- 
2.49.0.1045.g170613ef41-goog


