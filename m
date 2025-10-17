Return-Path: <linux-fsdevel+bounces-64524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CABEB830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B44E41FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1433374A;
	Fri, 17 Oct 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSt2fnLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8A33DEEB
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731972; cv=none; b=MskGWrEEMajBBX6O5zyUd1JatzB6Bp9tnNZA5yaSYaVj4AkhLaXa78LXmLeY4BkX8GMZRlnRfS9XCUT/xXDqCp1h2NNr2Mva3EqCU5fzJ4opCUIs2ILOD7wiDPep8qt8ogFzfDRTt5td/q+7SHVtAdYq9IyOOKO3c3SAXpvvcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731972; c=relaxed/simple;
	bh=f7R6AXOIMWVVUyOenjO6qf79gdh/r7j1fAfifaWW+sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ldeXzeVn6Estb9J98u74h0QHnqfhptmRD9f7gFIe9mF2NuuDdUuyYSTi5MwhIOEo0GXIs6HeVfH7qzDyb2vVcYclbjQPJo65ieISDvVK9hGCTTFYd9YmkgS2PpbZrvX/RyBOtIHfiJ4bubOWtbjyhrXAXj3fD3c+fBHmv9ElTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSt2fnLy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6a2409137dso1976583a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731967; x=1761336767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2MJNKUzyfpWZ1q1vEvG9dwdn9W10ieDvSTaPXJMXFQ=;
        b=PSt2fnLygLWFraKKyULwodCWbsqJxuTp6cBe4+6hAVG47bidVRHSxCXffFkYwJE6Lj
         FpJfxf/4FaOuBYfNM28wOvhBmIgxJ+vFK2I4zHVniNFNuYYZv6n0Ur/zSJEXMvEHVa/o
         Dc6cCbj69E1gyuNtdDkYb9GaNQlOHphbCEq/Oehsx5SuBMc7V5Azysf5KjqUXj4OvMxW
         nZBY+80PimCTwyKhNAgxmSGDvLEBGjAVCjQu41OeryOQbQkNuW4tO/ZWkdo0zsAeWRZ+
         hnEvTA1pa4b4Cku+VGEue/tYsOz2y4ahwlxnc8GIPixcP6Hwf7EB7r51LKJJ4pglKOnE
         VCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731967; x=1761336767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2MJNKUzyfpWZ1q1vEvG9dwdn9W10ieDvSTaPXJMXFQ=;
        b=XKY0NIvMtT/uB0oO79/i6GoyQLuIvcxE2n/9CypMriZRhlmCqAOqyIF4h0crvhCRAR
         2MHp0qTpE6qUmTxjGVQGymxeL2i1yYxUl/0+j3tc/NvHJNxICDzmIyiFGx6fin3ymeP5
         fhuT0wY8a4uLyNDaaQFioE2DzkgBfUd5Hyg5rUafG6syXVYNDlo6pEqdT6H8hk1R7fXf
         S/gLzgFoSatO59iuB47V4MCMuy4yzcEaSUnJq5Da2FXU9aVRMGxaJ8FgXM/e68hmo2/3
         RYdQ3zikrCZQRNMPiqIxjEK4ISPSzTzbiDR2OlRErpb0akhWJhKSj7B8f+CEhm4caCqB
         0k+A==
X-Forwarded-Encrypted: i=1; AJvYcCWwBx1Cp7oPRWjeWx2SWVlRlc8HV7giTq9KiDs6hyU3wD7AfhFc4GpfgoRQ+zcAPIbVPCcpZixkCZkvYU3l@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+p9rMtplJbVui9qWNvqem/ee3M4dImI51GUEkvP2PuCECdyQ
	jcvNWED9Qsab1jNRAlWdtfvPvhh7+L1OPBeMoKOaGry49Vlo10SFovlFTRBcOByebL9dD3MdzCf
	uoOUoNp/5W31xp5PYnYhjK/O1ow==
X-Google-Smtp-Source: AGHT+IFtb+WIe5Ojg24HFTpIMzVd4i2DEaeT3jlneCzRUkfycGPiLZfNyMXO+QnJ48jhgWddsus/04aVcLybN/OzNQ==
X-Received: from plxe8.prod.google.com ([2002:a17:902:ef48:b0:269:ba45:78f9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f605:b0:26e:62c9:1cc4 with SMTP id d9443c01a7336-290c9c89da2mr55093245ad.4.1760731967098;
 Fri, 17 Oct 2025 13:12:47 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:52 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <5a4dfc265a46959953e6c24730d22584972b1179.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 11/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

For shared to private conversions, if refcounts on any of the folios
within the range are elevated, fail the conversion with -EAGAIN.

At the point of shared to private conversion, all folios in range are
also unmapped. The filemap_invalidate_lock() is held, so no faulting
can occur. Hence, from that point on, only transient refcounts can be
taken on the folios associated with that guest_memfd.

Hence, it is safe to do the conversion from shared to private.

After conversion is complete, refcounts may become elevated, but that
is fine since users of transient refcounts don't actually access
memory.

For private to shared conversions, there are no refcount checks. any
transient refcounts are expected to drop their refcounts soon. The
conversion process will spin waiting for these transient refcounts to
go away.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst |  48 +++++++-
 include/linux/kvm_host.h       |  10 ++
 include/uapi/linux/kvm.h       |   9 +-
 virt/kvm/Kconfig               |   2 +-
 virt/kvm/guest_memfd.c         | 197 ++++++++++++++++++++++++++++++---
 virt/kvm/kvm_main.c            |  15 +--
 6 files changed, 250 insertions(+), 31 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a812769d79bf6..156ee69fa9067 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -117,7 +117,7 @@ description:
       x86 includes both i386 and x86_64.
 
   Type:
-      system, vm, or vcpu.
+      system, vm, vcpu or guest_memfd.
 
   Parameters:
       what parameters are accepted by the ioctl.
@@ -6518,11 +6518,22 @@ the capability to be present.
 ---------------------------------
 
 :Capability: KVM_CAP_MEMORY_ATTRIBUTES2
-:Architectures: x86
-:Type: vm ioctl
+:Architectures: all
+:Type: vm, guest_memfd ioctl
 :Parameters: struct kvm_memory_attributes2 (in/out)
 :Returns: 0 on success, <0 on error
 
+Errors:
+
+  ========== ===============================================================
+  EINVAL     The specified `offset` or `size` were invalid (e.g. not
+             page aligned, causes an overflow, or size is zero).
+  EFAULT     The parameter address was invalid.
+  EAGAIN     Some page within requested range had unexpected refcounts. The
+             offset of the page will be returned in `error_offset`.
+  ENOMEM     Ran out of memory trying to track private/shared state
+  ========== ===============================================================
+
 KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
 KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
 userspace.  The original (pre-extension) fields are shared with
@@ -6533,15 +6544,42 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
 ::
 
   struct kvm_memory_attributes2 {
-	__u64 address;
+	/* in */
+	union {
+		__u64 address;
+		__u64 offset;
+	};
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[4];
+	/* out */
+	__u64 error_offset;
+	__u64 reserved[3];
   };
 
   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
+Set attributes for a range of offsets within a guest_memfd to
+KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
+memory range for guest_use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
+supported, after a successful call to set
+KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
+into host userspace and will only be mappable by the guest.
+
+To allow the range to be mappable into host userspace again, call
+KVM_SET_MEMORY_ATTRIBUTES2 on the guest_memfd again with
+KVM_MEMORY_ATTRIBUTE_PRIVATE unset.
+
+If this ioctl returns -EAGAIN, the offset of the page with unexpected
+refcounts will be returned in `error_offset`. This can occur if there
+are transient refcounts on the pages, taken by other parts of the
+kernel.
+
+Userspace is expected to figure out how to remove all known refcounts
+on the shared pages, such as refcounts taken by get_user_pages(), and
+try the ioctl again. A possible source of these long term refcounts is
+if the guest_memfd memory was pinned in IOMMU page tables.
+
 See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
 
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b48632ee242b3..962055309084c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2515,6 +2515,16 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 }
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+#ifdef kvm_arch_has_private_mem
+	if (!kvm || kvm_arch_has_private_mem(kvm))
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
+
+	return 0;
+}
+
 typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
 DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c300e38c7c9cd..cdb00866efe49 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -964,6 +964,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
 #define KVM_CAP_MEMORY_ATTRIBUTES2 245
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 246
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1622,11 +1623,15 @@ struct kvm_pre_fault_memory {
 #define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd6, struct kvm_memory_attributes2)
 
 struct kvm_memory_attributes2 {
-	__u64 address;
+	union {
+		__u64 address;
+		__u64 offset;
+	};
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[4];
+	__u64 error_offset;
+	__u64 reserved[3];
 };
 
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 395996977fe5a..b3473aec4d24d 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -117,7 +117,7 @@ config KVM_VM_MEMORY_ATTRIBUTES
        bool
 
 config KVM_GUEST_MEMFD
-       depends on KVM_GENERIC_MMU_NOTIFIER
+       select KVM_MEMORY_ATTRIBUTES
        select XARRAY_MULTI
        bool
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index dab2b3ce78bc8..5ec38e9395d22 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -73,6 +73,21 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
 	return !kvm_gmem_is_private_mem(inode, index);
 }
 
+static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
+					  pgoff_t index, size_t nr_pages,
+					  u64 attributes)
+{
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	mt_for_each(mt, entry, index, end) {
+		if (xa_to_value(entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -219,10 +234,12 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 
 static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
 {
-	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
-		return KVM_FILTER_SHARED;
-
-	return KVM_FILTER_PRIVATE;
+	/*
+	 * TODO: Limit invalidations based on the to-be-invalidated range, i.e.
+	 *       invalidate shared/private if and only if there can possibly be
+	 *       such mappings.
+	 */
+	return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
 }
 
 static void __kvm_gmem_invalidate_begin(struct gmem_file *f, pgoff_t start,
@@ -583,11 +600,172 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_memory_attributes);
 
+static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
+					    size_t nr_pages, pgoff_t *err_index)
+{
+	struct address_space *mapping = inode->i_mapping;
+	const int filemap_get_folios_refcount = 1;
+	pgoff_t last = start + nr_pages - 1;
+	struct folio_batch fbatch;
+	bool safe = true;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {
+
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+
+			if (folio_ref_count(folio) !=
+			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
+				safe = false;
+				*err_index = folio->index;
+				break;
+			}
+		}
+
+		folio_batch_release(&fbatch);
+	}
+
+	return safe;
+}
+
+/*
+ * Preallocate memory for attributes to be stored on a maple tree, pointed to
+ * by mas.  Adjacent ranges with attributes identical to the new attributes
+ * will be merged.  Also sets mas's bounds up for storing attributes.
+ *
+ * This maintains the invariant that ranges with the same attributes will
+ * always be merged.
+ */
+static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
+				    pgoff_t start, size_t nr_pages)
+{
+	pgoff_t end = start + nr_pages;
+	pgoff_t last = end - 1;
+	void *entry;
+
+	/* Try extending range. entry is NULL on overflow/wrap-around. */
+	mas_set_range(mas, end, end);
+	entry = mas_find(mas, end);
+	if (entry && xa_to_value(entry) == attributes)
+		last = mas->last;
+
+	mas_set_range(mas, start - 1, start - 1);
+	entry = mas_find(mas, start - 1);
+	if (entry && xa_to_value(entry) == attributes)
+		start = mas->index;
+
+	mas_set_range(mas, start, last);
+	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
+}
+
+static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
+				     size_t nr_pages, uint64_t attrs,
+				     pgoff_t *err_index)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct gmem_inode *gi = GMEM_I(inode);
+	pgoff_t end = start + nr_pages;
+	struct maple_tree *mt;
+	struct ma_state mas;
+	int r;
+
+	mt = &gi->attributes;
+
+	filemap_invalidate_lock(mapping);
+
+	mas_init(&mas, mt, start);
+
+	if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs))
+		goto done;
+
+	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
+	if (r) {
+		*err_index = start;
+		goto out;
+	}
+
+	unmap_mapping_pages(mapping, start, nr_pages, false);
+
+	if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages, err_index)) {
+		mas_destroy(&mas);
+		r = -EAGAIN;
+		goto out;
+	}
+
+	kvm_gmem_invalidate_begin(inode, start, end);
+
+	mas_store_prealloc(&mas, xa_mk_value(attrs));
+
+	kvm_gmem_invalidate_end(inode, start, end);
+done:
+	r = 0;
+out:
+	filemap_invalidate_unlock(mapping);
+	return r;
+}
+
+static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
+{
+	struct gmem_file *f = file->private_data;
+	struct inode *inode = file_inode(file);
+	struct kvm_memory_attributes2 attrs;
+	pgoff_t err_index;
+	size_t nr_pages;
+	pgoff_t index;
+	int r;
+
+	if (copy_from_user(&attrs, argp, sizeof(attrs)))
+		return -EFAULT;
+
+	if (attrs.flags)
+		return -EINVAL;
+	if (attrs.attributes & ~kvm_supported_mem_attributes(f->kvm))
+		return -EINVAL;
+	if (attrs.size == 0 || attrs.offset + attrs.size < attrs.offset)
+		return -EINVAL;
+	if (!PAGE_ALIGNED(attrs.offset) || !PAGE_ALIGNED(attrs.offset))
+		return -EINVAL;
+
+	if (attrs.offset > inode->i_size ||
+	    attrs.offset + attrs.size > inode->i_size)
+		return -EINVAL;
+
+	nr_pages = attrs.size >> PAGE_SHIFT;
+	index = attrs.offset >> PAGE_SHIFT;
+	r = __kvm_gmem_set_attributes(inode, index, nr_pages, attrs.attributes,
+				      &err_index);
+	if (r) {
+		attrs.error_offset = err_index << PAGE_SHIFT;
+
+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
+			return -EFAULT;
+	}
+
+	return r;
+}
+
+static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,
+			   unsigned long arg)
+{
+	switch (ioctl) {
+	case KVM_SET_MEMORY_ATTRIBUTES2:
+		if (vm_memory_attributes)
+			return -ENOTTY;
+
+		return kvm_gmem_set_attributes(file, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
+	.unlocked_ioctl	= kvm_gmem_ioctl,
 };
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -943,20 +1121,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
 				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
 {
-	pgoff_t end = index + nr_pages - 1;
-	void *entry;
-
 	if (vm_memory_attributes)
 		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
 						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
 						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
-	mt_for_each(&gi->attributes, entry, index, end) {
-		if (xa_to_value(entry) != attributes)
-			return false;
-	}
-
-	return true;
+	return kvm_gmem_range_has_attributes(&gi->attributes, index, nr_pages,
+					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
 }
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dd84b377e46db..3506a2f2be041 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2435,16 +2435,6 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
-static u64 kvm_supported_mem_attributes(struct kvm *kvm)
-{
-#ifdef kvm_arch_has_private_mem
-	if (!kvm || kvm_arch_has_private_mem(kvm))
-		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
-#endif
-
-	return 0;
-}
-
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
@@ -4971,6 +4961,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		return 1;
 	case KVM_CAP_GUEST_MEMFD_FLAGS:
 		return kvm_gmem_get_supported_flags(kvm);
+	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
+		if (vm_memory_attributes)
+			return 0;
+
+		return kvm_supported_mem_attributes(kvm);
 #endif
 	default:
 		break;
-- 
2.51.0.858.gf9c4a03a3a-goog


