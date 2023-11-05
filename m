Return-Path: <linux-fsdevel+bounces-2027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F437E1530
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B351F215E7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F25262BC;
	Sun,  5 Nov 2023 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgaRyQ/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892726283
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:35:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3010E2
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699202130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZW+m7fzifdbbb8Tiv4ZhouifvIpC5SDmH0wH7ReCao=;
	b=MgaRyQ/MgGhUQg00I7eL+uZNuQdOVzbbc84+3su6abLGuaOJ4g+pggTcTgS3YleJSovihr
	LFEuEFWd+xApNVmboOiY1O9y1AUEtTiUC1mERPWLtytWk5DDz4Z4Ro+gExqLXG6nvOVPUb
	R7NEujJfjSMFRk/lgxOJ3fRpEn22Uek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-vnKJsSWtOUuKYV4SpqWoPg-1; Sun, 05 Nov 2023 11:35:27 -0500
X-MC-Unique: vnKJsSWtOUuKYV4SpqWoPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AA34185A782;
	Sun,  5 Nov 2023 16:35:25 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AD9D2166B26;
	Sun,  5 Nov 2023 16:35:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 36/34] KVM: Add transparent hugepage support for dedicated guest memory
Date: Sun,  5 Nov 2023 17:30:39 +0100
Message-ID: <20231105163040.14904-37-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Sean Christopherson <seanjc@google.com>

Extended guest_memfd to allow backing guest memory with transparent
hugepages.  Require userspace to opt-in via a flag even though there's no
known/anticipated use case for forcing small pages as THP is optional,
i.e. to avoid ending up in a situation where userspace is unaware that
KVM can't provide hugepages.

For simplicity, require the guest_memfd size to be a multiple of the
hugepage size, e.g. so that KVM doesn't need to do bounds checking when
deciding whether or not to allocate a huge folio.

When reporting the max order when KVM gets a pfn from guest_memfd, force
order-0 pages if the hugepage is not fully contained by the memslot
binding, e.g. if userspace requested hugepages but punches a hole in the
memslot bindings in order to emulate x86's VGA hole.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20231027182217.3615211-18-seanjc@google.com>
[Allow even with CONFIG_TRANSPARENT_HUGEPAGE; dropped momentarily due to
 uneasiness about the API. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst                |  7 ++
 include/uapi/linux/kvm.h                      |  2 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 15 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  9 +++
 .../kvm/x86_64/private_mem_conversions_test.c |  7 +-
 virt/kvm/guest_memfd.c                        | 70 ++++++++++++++++---
 6 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 38882263278d..c13ede498369 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6318,6 +6318,8 @@ and cannot be resized  (guest_memfd files do however support PUNCH_HOLE).
 	__u64 reserved[6];
   };
 
+  #define KVM_GUEST_MEMFD_ALLOW_HUGEPAGE         (1ULL << 0)
+
 Conceptually, the inode backing a guest_memfd file represents physical memory,
 i.e. is coupled to the virtual machine as a thing, not to a "struct kvm".  The
 file itself, which is bound to a "struct kvm", is that instance's view of the
@@ -6334,6 +6336,11 @@ most one mapping per page, i.e. binding multiple memory regions to a single
 guest_memfd range is not allowed (any number of memory regions can be bound to
 a single guest_memfd file, but the bound ranges must not overlap).
 
+If KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is set in flags, KVM will attempt to allocate
+and map hugepages for the guest_memfd file.  This is currently best effort.  If
+KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is set, the size must be aligned to the maximum
+transparent hugepage size supported by the kernel
+
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
 5. The kvm_run structure
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e9cb2df67a1d..b4ba4b53b834 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2316,4 +2316,6 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_GUEST_MEMFD_ALLOW_HUGEPAGE		(1ULL << 0)
+
 #endif /* __LINUX_KVM_H */
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ea0ae7e25330..c15de9852316 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -123,6 +123,7 @@ static void test_invalid_punch_hole(int fd, size_t page_size, size_t total_size)
 
 static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
 {
+	uint64_t valid_flags = 0;
 	size_t page_size = getpagesize();
 	uint64_t flag;
 	size_t size;
@@ -135,9 +136,23 @@ static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
 			    size);
 	}
 
+	if (thp_configured()) {
+		for (size = page_size * 2; size < get_trans_hugepagesz(); size += page_size) {
+			fd = __vm_create_guest_memfd(vm, size, KVM_GUEST_MEMFD_ALLOW_HUGEPAGE);
+			TEST_ASSERT(fd == -1 && errno == EINVAL,
+				    "guest_memfd() with non-hugepage-aligned page size '0x%lx' should fail with EINVAL",
+				    size);
+		}
+
+		valid_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+	}
+
 	for (flag = 1; flag; flag <<= 1) {
 		uint64_t bit;
 
+		if (flag & valid_flags)
+			continue;
+
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		TEST_ASSERT(fd == -1 && errno == EINVAL,
 			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d05d95cc3693..ed81a00e5df1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1022,6 +1022,15 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	if (flags & KVM_MEM_GUEST_MEMFD) {
 		if (guest_memfd < 0) {
 			uint32_t guest_memfd_flags = 0;
+
+			/*
+			 * Allow hugepages for the guest memfd backing if the
+			 * "normal" backing is allowed/required to be huge.
+			 */
+			if (src_type != VM_MEM_SRC_ANONYMOUS &&
+			    src_type != VM_MEM_SRC_SHMEM)
+				guest_memfd_flags |= KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+
 			TEST_ASSERT(!guest_memfd_offset,
 				    "Offset must be zero when creating new guest_memfd");
 			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 4d6a37a5d896..f707fd401a4f 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -380,6 +380,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
+	uint64_t memfd_flags;
 	struct kvm_vm *vm;
 	int memfd, i, r;
 
@@ -395,7 +396,11 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	if (backing_src_can_be_huge(src_type))
+		memfd_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+	else
+		memfd_flags = 0;
+	memfd = vm_create_guest_memfd(vm, memfd_size, memfd_flags);
 
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e65f4170425c..3e48e8997626 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -13,14 +13,44 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index, unsigned order)
+{
+	pgoff_t npages = 1UL << order;
+	pgoff_t huge_index = round_down(index, npages);
+	unsigned long flags = (unsigned long)inode->i_private;
+	struct address_space *mapping  = inode->i_mapping;
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	struct folio *folio;
+
+	if (!(flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE))
+		return NULL;
+
+	if (filemap_range_has_page(mapping, (loff_t)huge_index << PAGE_SHIFT,
+				   (loff_t)(huge_index + npages - 1) << PAGE_SHIFT))
+		return NULL;
+
+	folio = filemap_alloc_folio(gfp, order);
+	if (!folio)
+		return NULL;
+
+	if (filemap_add_folio(mapping, folio, huge_index, gfp)) {
+		folio_put(folio);
+		return NULL;
+	}
+
+	return folio;
+}
+
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
 	struct folio *folio;
 
-	/* TODO: Support huge pages. */
-	folio = filemap_grab_folio(inode->i_mapping, index);
-	if (IS_ERR_OR_NULL(folio))
-		return NULL;
+	folio = kvm_gmem_get_huge_folio(inode, index, PMD_ORDER);
+	if (!folio) {
+		folio = filemap_grab_folio(inode->i_mapping, index);
+		if (IS_ERR_OR_NULL(folio))
+			return NULL;
+	}
 
 	/*
 	 * Use the up-to-date flag to track whether or not the memory has been
@@ -366,6 +396,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	inode->i_mode |= S_IFREG;
 	inode->i_size = size;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_large_folios(inode->i_mapping);
 	mapping_set_unmovable(inode->i_mapping);
 	/* Unmovable mappings are supposed to be marked unevictable as well. */
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
@@ -389,7 +420,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
 	u64 flags = args->flags;
-	u64 valid_flags = 0;
+	u64 valid_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
 
 	if (flags & ~valid_flags)
 		return -EINVAL;
@@ -397,6 +428,13 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (size <= 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	BUILD_BUG_ON(PMD_SIZE != HPAGE_PMD_SIZE);
+#endif
+	if ((flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE) &&
+	    !IS_ALIGNED(size, PMD_SIZE))
+		return -EINVAL;
+
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
@@ -491,7 +529,7 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
 {
-	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
+	pgoff_t index, huge_index;
 	struct kvm_gmem *gmem;
 	struct folio *folio;
 	struct page *page;
@@ -504,6 +542,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	gmem = file->private_data;
 
+	index = gfn - slot->base_gfn + slot->gmem.pgoff;
 	if (WARN_ON_ONCE(xa_load(&gmem->bindings, index) != slot)) {
 		r = -EIO;
 		goto out_fput;
@@ -523,9 +562,24 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	page = folio_file_page(folio, index);
 
 	*pfn = page_to_pfn(page);
-	if (max_order)
-		*max_order = 0;
+	if (!max_order)
+		goto success;
 
+	*max_order = compound_order(compound_head(page));
+	if (!*max_order)
+		goto success;
+
+	/*
+	 * The folio can be mapped with a hugepage if and only if the folio is
+	 * fully contained by the range the memslot is bound to.  Note, the
+	 * caller is responsible for handling gfn alignment, this only deals
+	 * with the file binding.
+	 */
+	huge_index = ALIGN(index, 1ull << *max_order);
+	if (huge_index < ALIGN(slot->gmem.pgoff, 1ull << *max_order) ||
+	    huge_index + (1ull << *max_order) > slot->gmem.pgoff + slot->npages)
+		*max_order = 0;
+success:
 	r = 0;
 
 out_unlock:
-- 
2.39.1


