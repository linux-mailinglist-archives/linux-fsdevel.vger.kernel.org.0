Return-Path: <linux-fsdevel+bounces-49057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE2AB79FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352B93B6A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3422586DA;
	Wed, 14 May 2025 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFAeQFce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE1255F3B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266229; cv=none; b=qRRh8XR9odCz0ogEF4I9d+oDn3TvzKndTfqsnbvWzbgAkn+xD0wbxFa4yvaObNR7zecUqWSsaPYTjPHe8eOdfrhrDwDnbzWtPKzuTjQAhZ4R7GWjLCAi2fIpyNlO9DIYkTLY/KEGZXrlEHN2Ara41SROQlBOg7ayviwt7JEYhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266229; c=relaxed/simple;
	bh=BMRs/VwumQxe5F8MpsL0eBoWD/J4YJWeRXXnxzz4k0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FF3La288Sq2FrVCokD14k9Biqbxo/Nk072uBPRbGlxPxqg1W9CMtaIEuR96B4JLdD43Sn5AtS/DaKuSydlBdlDnpAUhweko+LvuIGuG7olOZ4EqVCFK3J2UvlFpfwAtsXt6XULD8/T69Yf9l7m53tDf8amX6UGBAyptlob9db1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFAeQFce; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a7cc8c52eso423847a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266227; x=1747871027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcjm16puorCPBtthqT8mNitWd+IfzDcCRMmhCOBHoD8=;
        b=IFAeQFcebEeXnnWAygSMY4msp12BT2J17sVw3WP6LWG48NeIidJPlEpWeZYyISdRy3
         6f9n9JvDDpfFO/FNM0VXElTMrJiXzGquITfb5PQ8dR2z8kK/8sw5GnPgjx6lTV/Vx1+x
         nB9dajL9jrXly5GC4Qbk+hVnbu1crVuEkFhXnMiwVlm3u6UQW2XQpd258LGFnkcU6/DC
         LfzhRol9vxPJpQIEVRJmCXayLrML65lCrSqdsq7L+7b1Cohz0k30c8ZndYp0PyR9k2kN
         0ylykiA3H7SIhkfN19fg9Qc3FgETbcIMqrj31xZA10Fpgu0YSBougIw7SSd/7oQaiJ1Y
         ud4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266227; x=1747871027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcjm16puorCPBtthqT8mNitWd+IfzDcCRMmhCOBHoD8=;
        b=R1Jt5idyAFspUJhY+fBkPpmt/E8bJVCSOpB4XUDDChUU86w4u0NAd4jICqdYsMxq/6
         hSOlzmHN2BrWfdT7CiJd3sz4DammaFLvbzlhAwdPumClqS1cmoHeEWUpbX6tThsouCYP
         ip6b/KeCxcJpoSawDpqNB9X1aoo4rENrrsHohyadbJDkoSq9qLqbpQWa5VT4bwa31fAs
         o/cvTHIqSbuKXNIwIVzOzHIT3uYIKF9i8vaTn7DA4B0IUfhDFnFL2C9MBxvOHQiRjF4O
         kV0V38bdLJN48irpy4AZ7Bg0ZhCBRYGlkBxG2eF27KNj+f67IG11fK5eNXMoaFQDLID7
         R3FA==
X-Forwarded-Encrypted: i=1; AJvYcCWDH3JNhGYZhQkVdF4mBuAMw7LyVPhYENvxBZyQrVVYuCVWqWz+KCegkwN/ktl324gkWUWCNDhEmFAE5lNb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KH53Bhmvz4uGWUGL6vd5uw2g2MXmOyMFfaMqhAEUiuXa7dee
	zGBexh/N/djwAZysteKutNNfID3WM+1OtBQ8EWtMKMD01pTAadiREbUdDVUZ/mY90KmylOUe9zC
	arez3HnpQNN5C2TR8E08LSA==
X-Google-Smtp-Source: AGHT+IGWVoQymI4B6hVxU1Vt4i2GsQrw+x1ntpHu1NnHoUmQ350L2ODuv1v00PBSIq3/k4CuQkSvhD8J7IuL5NzAmA==
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:301:1ea9:63b0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38c7:b0:30e:37be:698d with SMTP id 98e67ed59e1d1-30e37be6bcemr5417459a91.31.1747266226813;
 Wed, 14 May 2025 16:43:46 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:11 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 32/51] KVM: guest_memfd: Support guestmem_hugetlb as
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

This patch adds support for guestmem_hugetlb as the first custom
allocator in guest_memfd.

If requested at guest_memfd creation time, the custom allocator will
be used in initialization and cleanup.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Change-Id: I1eb9625dc761ecadcc2aa21480cfdfcf9ab7ce67
---
 include/uapi/linux/kvm.h |   1 +
 virt/kvm/Kconfig         |   5 +
 virt/kvm/guest_memfd.c   | 203 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 199 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 433e184f83ea..af486b2e4862 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1571,6 +1571,7 @@ struct kvm_memory_attributes {
 
 #define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
 #define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
+#define GUEST_MEMFD_FLAG_HUGETLB	(1UL << 2)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 14ffd9c1d480..ff917bb57371 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -133,3 +133,8 @@ config KVM_GMEM_SHARED_MEM
        select KVM_GMEM
        bool
        prompt "Enables in-place shared memory for guest_memfd"
+
+config KVM_GMEM_HUGETLB
+       select KVM_PRIVATE_MEM
+       depends on GUESTMEM_HUGETLB
+       bool "Enables using a custom allocator with guest_memfd, see CONFIG_GUESTMEM_HUGETLB"
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8c9c9e54616b..c65d93c5a443 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -3,11 +3,14 @@
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
 #include <linux/fs.h>
+#include <linux/guestmem.h>
 #include <linux/kvm_host.h>
 #include <linux/maple_tree.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 
+#include <uapi/linux/guestmem.h>
+
 #include "kvm_mm.h"
 
 static struct vfsmount *kvm_gmem_mnt;
@@ -22,6 +25,10 @@ struct kvm_gmem_inode_private {
 #ifdef CONFIG_KVM_GMEM_SHARED_MEM
 	struct maple_tree shareability;
 #endif
+#ifdef CONFIG_KVM_GMEM_HUGETLB
+	const struct guestmem_allocator_operations *allocator_ops;
+	void *allocator_private;
+#endif
 };
 
 enum shareability {
@@ -40,6 +47,44 @@ static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
 	return inode->i_mapping->i_private_data;
 }
 
+#ifdef CONFIG_KVM_GMEM_HUGETLB
+
+static const struct guestmem_allocator_operations *
+kvm_gmem_allocator_ops(struct inode *inode)
+{
+	return kvm_gmem_private(inode)->allocator_ops;
+}
+
+static void *kvm_gmem_allocator_private(struct inode *inode)
+{
+	return kvm_gmem_private(inode)->allocator_private;
+}
+
+static bool kvm_gmem_has_custom_allocator(struct inode *inode)
+{
+	return kvm_gmem_allocator_ops(inode) != NULL;
+}
+
+#else
+
+static const struct guestmem_allocator_operations *
+kvm_gmem_allocator_ops(struct inode *inode)
+{
+	return NULL;
+}
+
+static void *kvm_gmem_allocator_private(struct inode *inode)
+{
+	return NULL;
+}
+
+static bool kvm_gmem_has_custom_allocator(struct inode *inode)
+{
+	return false;
+}
+
+#endif
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -510,7 +555,6 @@ static int kvm_gmem_filemap_add_folio(struct address_space *mapping,
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
 	struct folio *folio;
-	gfp_t gfp;
 	int ret;
 
 repeat:
@@ -518,17 +562,24 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	if (!IS_ERR(folio))
 		return folio;
 
-	gfp = mapping_gfp_mask(inode->i_mapping);
+	if (kvm_gmem_has_custom_allocator(inode)) {
+		void *p = kvm_gmem_allocator_private(inode);
 
-	/* TODO: Support huge pages. */
-	folio = filemap_alloc_folio(gfp, 0);
-	if (!folio)
-		return ERR_PTR(-ENOMEM);
+		folio = kvm_gmem_allocator_ops(inode)->alloc_folio(p);
+		if (IS_ERR(folio))
+			return folio;
+	} else {
+		gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
 
-	ret = mem_cgroup_charge(folio, NULL, gfp);
-	if (ret) {
-		folio_put(folio);
-		return ERR_PTR(ret);
+		folio = filemap_alloc_folio(gfp, 0);
+		if (!folio)
+			return ERR_PTR(-ENOMEM);
+
+		ret = mem_cgroup_charge(folio, NULL, gfp);
+		if (ret) {
+			folio_put(folio);
+			return ERR_PTR(ret);
+		}
 	}
 
 	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
@@ -611,6 +662,80 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
 	}
 }
 
+/**
+ * kvm_gmem_truncate_indices() - Truncates all folios beginning @index for
+ * @nr_pages.
+ *
+ * @mapping: filemap to truncate pages from.
+ * @index: the index in the filemap to begin truncation.
+ * @nr_pages: number of PAGE_SIZE pages to truncate.
+ *
+ * Return: the number of PAGE_SIZE pages that were actually truncated.
+ */
+static long kvm_gmem_truncate_indices(struct address_space *mapping,
+				      pgoff_t index, size_t nr_pages)
+{
+	struct folio_batch fbatch;
+	long truncated;
+	pgoff_t last;
+
+	last = index + nr_pages - 1;
+
+	truncated = 0;
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &index, last, &fbatch)) {
+		unsigned int i;
+
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *f = fbatch.folios[i];
+
+			truncated += folio_nr_pages(f);
+			folio_lock(f);
+			truncate_inode_folio(f->mapping, f);
+			folio_unlock(f);
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	return truncated;
+}
+
+/**
+ * kvm_gmem_truncate_inode_aligned_pages() - Removes entire folios from filemap
+ * in @inode.
+ *
+ * @inode: inode to remove folios from.
+ * @index: start of range to be truncated. Must be hugepage aligned.
+ * @nr_pages: number of PAGE_SIZE pages to be iterated over.
+ *
+ * Removes folios beginning @index for @nr_pages from filemap in @inode, updates
+ * inode metadata.
+ */
+static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
+						  pgoff_t index,
+						  size_t nr_pages)
+{
+	size_t nr_per_huge_page;
+	long num_freed;
+	pgoff_t idx;
+	void *priv;
+
+	priv = kvm_gmem_allocator_private(inode);
+	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
+
+	num_freed = 0;
+	for (idx = index; idx < index + nr_pages; idx += nr_per_huge_page) {
+		num_freed += kvm_gmem_truncate_indices(
+			inode->i_mapping, idx, nr_per_huge_page);
+	}
+
+	spin_lock(&inode->i_lock);
+	inode->i_blocks -= (num_freed << PAGE_SHIFT) / 512;
+	spin_unlock(&inode->i_lock);
+}
+
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
@@ -940,6 +1065,13 @@ static void kvm_gmem_free_inode(struct inode *inode)
 {
 	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
 
+	/* private may be NULL if inode creation process had an error. */
+	if (private && kvm_gmem_has_custom_allocator(inode)) {
+		void *p = kvm_gmem_allocator_private(inode);
+
+		kvm_gmem_allocator_ops(inode)->inode_teardown(p, inode->i_size);
+	}
+
 	kfree(private);
 
 	free_inode_nonrcu(inode);
@@ -959,8 +1091,24 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 #endif
 }
 
+static void kvm_gmem_evict_inode(struct inode *inode)
+{
+	truncate_inode_pages_final_prepare(inode->i_mapping);
+
+	if (kvm_gmem_has_custom_allocator(inode)) {
+		size_t nr_pages = inode->i_size >> PAGE_SHIFT;
+
+		kvm_gmem_truncate_inode_aligned_pages(inode, 0, nr_pages);
+	} else {
+		truncate_inode_pages(inode->i_mapping, 0);
+	}
+
+	clear_inode(inode);
+}
+
 static const struct super_operations kvm_gmem_super_operations = {
 	.statfs		= simple_statfs,
+	.evict_inode	= kvm_gmem_evict_inode,
 	.destroy_inode	= kvm_gmem_destroy_inode,
 	.free_inode	= kvm_gmem_free_inode,
 };
@@ -1062,6 +1210,12 @@ static void kvm_gmem_free_folio(struct folio *folio)
 {
 	folio_clear_unevictable(folio);
 
+	/*
+	 * No-op for 4K page since the PG_uptodate is cleared as part of
+	 * freeing, but may be required for other allocators to reset page.
+	 */
+	folio_clear_uptodate(folio);
+
 	kvm_gmem_invalidate(folio);
 }
 
@@ -1115,6 +1269,25 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 	if (err)
 		goto out;
 
+#ifdef CONFIG_KVM_GMEM_HUGETLB
+	if (flags & GUEST_MEMFD_FLAG_HUGETLB) {
+		void *allocator_priv;
+		size_t nr_pages;
+
+		allocator_priv = guestmem_hugetlb_ops.inode_setup(size, flags);
+		if (IS_ERR(allocator_priv)) {
+			err = PTR_ERR(allocator_priv);
+			goto out;
+		}
+
+		private->allocator_ops = &guestmem_hugetlb_ops;
+		private->allocator_private = allocator_priv;
+
+		nr_pages = guestmem_hugetlb_ops.nr_pages_in_folio(allocator_priv);
+		inode->i_blkbits = ilog2(nr_pages << PAGE_SHIFT);
+	}
+#endif
+
 	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
@@ -1210,6 +1383,10 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	return err;
 }
 
+/* Mask of bits belonging to allocators and are opaque to guest_memfd. */
+#define SUPPORTED_CUSTOM_ALLOCATOR_MASK \
+	(GUESTMEM_HUGETLB_FLAG_MASK << GUESTMEM_HUGETLB_FLAG_SHIFT)
+
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
@@ -1222,6 +1399,12 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
 		valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
 
+	if (IS_ENABLED(CONFIG_KVM_GMEM_HUGETLB) &&
+	    flags & GUEST_MEMFD_FLAG_HUGETLB) {
+		valid_flags |= GUEST_MEMFD_FLAG_HUGETLB |
+			       SUPPORTED_CUSTOM_ALLOCATOR_MASK;
+	}
+
 	if (flags & ~valid_flags)
 		return -EINVAL;
 
-- 
2.49.0.1045.g170613ef41-goog


