Return-Path: <linux-fsdevel+bounces-63326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBFBB5876
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 00:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45064852B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333A26FA67;
	Thu,  2 Oct 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7Ccc6C9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B1231858
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443046; cv=none; b=taWR73DTf9sui762qtZCXC56XA20OMVbfTQgYbd+FdCN2DBD2KGwN309zyM6t7LULR9023atnVUC63B4Ft6UfxHmhKupo2qpSlRtUt4HB2EyZfAb9NBm2ZNurBEV33p3+IJBqwuUUVUFnqnF9ZiGY0DH6OBdV4to3J6Yf1/GcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443046; c=relaxed/simple;
	bh=GWw8IAiEAcMR7AL+JCvqAXtD85hNwLZ6n9Dh+9ioVSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hw6+LKT633spAcl9e1O+TX0mXW5ESpl3zBjy+3VNJXpmI4V2fPJUKC4IdqaPK5JBSTvunfPPeQySIkK/WsbPRbxGro2lux74W9c9V+vokdLTPwPGJ0lEUb7qqgbtT579I/qeamAAiKu7SPsgOTByGRuL+LeYY8PlLfgZUP6AvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7Ccc6C9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78106e63bc9so1726749b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759443044; x=1760047844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xi8/GlubGIEdZ+duqPrIqBmO1DB/k+E0Kj0HX5P5EcY=;
        b=h7Ccc6C9e8f9ZlUklPjNNa4+SXs4Zm0/SChX9uoZLOd6h8L07Wtl3IGjDwahvwDuSe
         kSML8pYnnytbrAY2OPvDydNtoXyC7p63X/jW0a10/gKZB/mtCiFCZ+9J2ZyGvgrHjzgM
         wfmTd9+qBE/Hmk3JMjHKUHz9ccVOdf3UBF4M08FfIq4rosFq0ETMwkjmFQ4W33as2BgY
         8W7yxuSyvGgj/fYOl1UVCll10tCHfH+8ld0+89YRJf4zZRQb1BwR9eu5Wnxxj+5PKy5u
         ymdvPoDgcw0sLiTFnjpcKVetNxKzUJDyWyvWnofkd7cvs3TsQ2qzOfhS3Zlerhh/oWLa
         ssRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443044; x=1760047844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xi8/GlubGIEdZ+duqPrIqBmO1DB/k+E0Kj0HX5P5EcY=;
        b=pCiUVK1FPU/etzDnjYBap4kxu6970j8SZsQmdr68OjAKwZpWMOJGSs/QCGYD5TRNcA
         3/W43zeg3Aw1CjW33vuuruuhGyP/w71rz2JwbJixgJrqHmbRq740mUSBMcosSTDJJbhL
         QBKhhTyjv5qK/b0y5/L2QIY0lfk1TLbqFABFz+DgSevyagZilL1XnA3pz1S5iwszIuKI
         njfC0dpKbqsWcnUoUzZU+Np02ZDsSzCavxnaY4T3I7Ziz+6nTmrJrIJPSUMOwVtkVANL
         SaB6LpMWwf9ZwgcTS+ErWjOIgVCxncv2Cx0dJpf0+rqUYqwVUuZwcmt8CzLlba9x6PVY
         dRzA==
X-Forwarded-Encrypted: i=1; AJvYcCX8XBV6c3YsYBLylmYTzqltPjod1jjfTKSSM/bxrSwAP5kyghf5PyzI/kIJsJhaiDGW4VlysnmIF0Gv82bk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RRK9pnlsfZQPaOLbUZBQA8FAYrEBar1z/4KyyO4QAZVFodPx
	1RtXDlS16eYOhXZuW9Coc6YWTE4CsQJDp68mQzDs2dpt9RCTmwKLlL1Lkdt+Plal/wnc2cFMLxk
	0/khEDA==
X-Google-Smtp-Source: AGHT+IFY2COPi/SI+2tZew45JFEEDJ5/bh8axBRWt3QhZcBrGQw8oD/D+HMrLzc+u2Hnjo1OVXWBB8HiVDo=
X-Received: from pfbgm5.prod.google.com ([2002:a05:6a00:6405:b0:78a:f444:b123])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84a:b0:781:d21e:136f
 with SMTP id d2e1a72fcca58-78c98deac4cmr1265878b3a.26.1759443043713; Thu, 02
 Oct 2025 15:10:43 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:10:42 -0700
In-Reply-To: <9a9db594cc0e9d059dd30d2415d0346e09065bb6.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <9a9db594cc0e9d059dd30d2415d0346e09065bb6.1747264138.git.ackerleytng@google.com>
Message-ID: <aN74Yt0XvOkRPnFh@google.com>
Subject: Re: [RFC PATCH v2 10/51] KVM: selftests: Refactor vm_mem_add to be
 more flexible
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 14, 2025, Ackerley Tng wrote:
> enum vm_mem_backing_src_type is encoding too many different
> possibilities on different axes of (1) whether to mmap from an fd, (2)
> granularity of mapping for THP, (3) size of hugetlb mapping, and has
> yet to be extended to support guest_memfd.

I don't disagree (I added the FIXME after all), but IMO what you've done here
doesn't improve the situation, it just punts the mess to tests, i.e. lets the
guest_memfd_conversions test do its thing, but doesn't actually improve anything.

A test has no business dealing with details about "installing" memory or even
mapping the memslot.  The whole point of the core library is to deal with those
details so they don't need to be copy+pasted.  Adding a gmem-backed memslot
shouldn't require this much effort:

	region = vm_mem_region_alloc(vm);

	guest_memfd = vm_mem_region_install_guest_memfd(region, guest_memfd);
	mem = vm_mem_region_mmap(region, memslot_size, MAP_SHARED, guest_memfd, 0);
	vm_mem_region_install_memory(region, memslot_size, PAGE_SIZE);

	region->region.slot = GUEST_MEMFD_SHARING_TEST_SLOT;
	region->region.flags = KVM_MEM_GUEST_MEMFD;
	region->region.guest_phys_addr = GUEST_MEMFD_SHARING_TEST_GPA;
	region->region.guest_memfd_offset = 0;

	vm_mem_region_add(vm, region);

Again, I agree vm_mem_add() is a mess.  But overall, this is a big step backwards.

> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  29 +-
>  .../testing/selftests/kvm/include/test_util.h |   2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 429 +++++++++++-------
>  tools/testing/selftests/kvm/lib/test_util.c   |  25 +
>  4 files changed, 328 insertions(+), 157 deletions(-)

It's also not reviewable.  There is far, far too much going on here.  This is
quite obviously not one logical change.  The changelog is appropriate for the
cover letter of a decently large series, not for a patch that touches core code
of the selftests.

The massive refactoring is also unnecessary, at least for conversions.  With some
prep renames to shorten line lengths, all that is needed at this time is to dup()
the gmem_fd into region->fd when the gmem_fd can be mmap()'d.  It's not just a
clever hack, it's also how we want gmem to be used going forward; and for non-CoCo
VMs, it's the _only_ sane way to use gmem.

The only scenario where a test would want to shove a different userspace address
into the memslot is a test that deliberately tests that exact scenario.  And that
sort of thing belongs in a test; core code should only concern itself with the
scenario that 99 of usage will want.

With this, the test can do:

	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, slot, nr_pages,
		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);

	t->gmem_fd = kvm_slot_to_fd(vm, slot);
	t->mem = addr_gpa2hva(vm, gpa);
	virt_map(vm, GUEST_MEMFD_SHARING_TEST_GVA, gpa, nr_pages);

---
 tools/testing/selftests/kvm/include/kvm_util.h           | 7 ++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c               | 9 +++++----
 .../selftests/kvm/x86/private_mem_conversions_test.c     | 2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 45159638d5dd..de8ae9be1906 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -678,7 +678,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint32_t flags);
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int guest_memfd_fd, uint64_t guest_memfd_offset);
+		int gmem_fd, uint64_t gmem_offset, uint64_t gmem_flags);
 
 #ifndef vm_arch_has_protected_memory
 static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
@@ -711,6 +711,11 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
+static inline int kvm_slot_to_fd(struct kvm_vm *vm, uint32_t slot)
+{
+	return memslot2region(vm, slot)->fd;
+}
+
 #ifndef vcpu_arch_put_guest
 #define vcpu_arch_put_guest(mem, val) do { (mem) = (val); } while (0)
 #endif
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 885a0dd58626..196af025e833 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -944,7 +944,7 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int gmem_fd, uint64_t gmem_offset)
+		int gmem_fd, uint64_t gmem_offset, uint64_t gmem_flags)
 {
 	int ret;
 	struct userspace_mem_region *region;
@@ -1028,7 +1028,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
 		if (gmem_fd < 0) {
-			uint32_t gmem_flags = 0;
 			TEST_ASSERT(!gmem_offset,
 				    "Offset must be zero when creating new guest_memfd");
 			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
@@ -1049,7 +1048,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	}
 
 	region->fd = -1;
-	if (backing_src_is_shared(src_type))
+	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP)
+		region->fd = kvm_dup(gmem_fd);
+	else if (backing_src_is_shared(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
@@ -1116,7 +1117,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint64_t gpa, uint32_t slot, uint64_t npages,
 				 uint32_t flags)
 {
-	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0);
+	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0, 0);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 1969f4ab9b28..41f6b38f0407 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -399,7 +399,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
 			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;

base-commit: 3572aeafd53394f4bf0a61d79c5c1b8cfccc3860
--

