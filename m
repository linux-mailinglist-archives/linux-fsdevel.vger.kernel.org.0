Return-Path: <linux-fsdevel+bounces-64529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09ABEB88D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDE9189AA1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DC334C01;
	Fri, 17 Oct 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLFcSj+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0F339B44
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731981; cv=none; b=HP2/H9DpprdlHbICEVAigaguvlpUVBcV3w+VaBE4RGtEGfr1fHQONzp72PmVtb1OlHORtWtm1PESDvOKOnhPOTv6EMRwf4l1nnFm4RKNm3k2DlghRIfaZp9vU1gYW+fVtkUyIGcPTw6hoTnqUMSoe2bz+UBDTj8TsFo8IBlzbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731981; c=relaxed/simple;
	bh=sZ5H+zHTHSNfIlVrFkaHh5egYLM8pq0dUeGZ7JIG6Xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQ+KiNt4axW2cSyIgsrVa4qBI44Bd9sfX8R12fJ3jujBWrTtSaf3IPZspHZuRSY++KZeZ2YAeiP7mRoFuu+2XONDRqLpPKUe+iVmSPXm3JDG2dAt056CRg46fz9iOsyK5L/4yxWFCrFrliVljXJNj6AT+K6WJ/ftBtHQPaCRg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLFcSj+h; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6a2409137dso1976634a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731975; x=1761336775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZrm0bBpyP9vTvkArtXHnxbGIMZ4Py8QfqHZJRCW2ZI=;
        b=wLFcSj+hmP1puoYVeIR8Un+lRCiSCRYs80iK0L9BE39FzMmWWrsHyyZkxw3SaOgaJM
         fENX9zhHL4LofGWWnRFlRzunRWx6ieMeNNne2pMFi/lSDsEjMsFBnTYNSAVI48gYTQK0
         2WTpRRYa25a3jMEUgsOyASQiguk4r+k80EA5C3Kx4SVhMLkavT76Jj+q6PcF01MQduNp
         n3sDzOqtdwTEBWhvD91PGjEu6Y18jgm7Hgdn0wxIL1YJxzs07IlKN7X8czkvV+Ssytlt
         M8ff3kHuE33zYlHHKuduuMvzp6MwtYIbfV0PeudT0n7qNQ6Amig2dlO/9+iir9/1cLXl
         QHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731975; x=1761336775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZrm0bBpyP9vTvkArtXHnxbGIMZ4Py8QfqHZJRCW2ZI=;
        b=HvmQvBL0mP5KnIVGVRkwMUA8DGFuY2dm/vxjvxVn+x20n8vY8KFrKWZXdC9h8cvgNi
         mn/QCXymm9NQmOIJ+YQxHOFEYGn4AvUpamRXZnbBgWEZC7an70NS/Q2vg+YJ7gkSfpzd
         5J4lMLn0ISoxbps3+OgE9UThvxEwCD8McK6kn9bsFnNs2rfYFsJdWn+Vz2Y9hYcFlAC1
         iPPLB5xYbiGDY0pB8Q2gpaSwaKpVa/Z+wiIemVZzTooU1Xwlm7L15aFx3MhUzumyx1cG
         FQmcTVtTL028tvuBC07VqOMd+fep74ZVBkaHy2kS1bEgf7USV0REgZnODfmNOxwfNLJ8
         7VyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU2NYIj0U1u+mZWYtjHS9IqV0+Ch9SosrqqAnKBywPNchVEuIYrzuVVJNJQRJHRda/z5Dc+SN9+WnXtZi9@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYyUrN0yWXAD6cgg0gk6a2FRX2PzX6eDdDhOMON2yNyZ6uKrL
	Te26Y4wxegpyLew/972mCW5ycas9I41IIacNYSG2+x4aAv2zQJKlPBuM0Hdja8KU61yqd7Gnhki
	xATYbgn43S6NtNDz55g8w1ZtR1Q==
X-Google-Smtp-Source: AGHT+IHeEcTma0Vf9iP7bayAuL5X24WwVW+rZLP1mtrjCO7SF8PjjpL45P1H1MJ3MINmLICN5Aa9w6/jdnFaODUMng==
X-Received: from pleg12.prod.google.com ([2002:a17:902:e38c:b0:268:4e0:9c09])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec83:b0:276:305b:14a7 with SMTP id d9443c01a7336-290ca30d76dmr61848425ad.33.1760731975492;
 Fri, 17 Oct 2025 13:12:55 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:57 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <727482ec42baa50cb1488ad89d02e732defda3db.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 16/37] KVM: selftests: Add support for mmap() on
 guest_memfd in core library
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

From: Sean Christopherson <seanjc@google.com>

Accept gmem_flags in vm_mem_add() to be able to create a guest_memfd within
vm_mem_add().

When vm_mem_add() is used to set up a guest_memfd for a memslot, set up the
provided (or created) gmem_fd as the fd for the user memory region. This
makes it available to be mmap()-ed from just like fds from other memory
sources. mmap() from guest_memfd using the provided gmem_flags and
gmem_offset.

Add a kvm_slot_to_fd() helper to provide convenient access to the file
descriptor of a memslot.

Update existing callers of vm_mem_add() to pass 0 for gmem_flags to
preserve existing behavior.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[For guest_memfds, mmap() using gmem_offset instead of 0 all the time.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  7 ++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c     | 18 ++++++++++--------
 .../kvm/x86/private_mem_conversions_test.c     |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 45159638d5dde..de8ae9be19067 100644
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
index 8b714270cf381..19c0445c0b296 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -944,12 +944,13 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int gmem_fd, uint64_t gmem_offset)
+		int gmem_fd, uint64_t gmem_offset, uint64_t gmem_flags)
 {
 	int ret;
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t mem_size = npages * vm->page_size;
+	off_t mmap_offset;
 	size_t alignment;
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
@@ -1028,8 +1029,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
 		if (gmem_fd < 0) {
-			uint32_t gmem_flags = 0;
-
 			TEST_ASSERT(!gmem_offset,
 				    "Offset must be zero when creating new guest_memfd");
 			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
@@ -1050,13 +1049,16 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	}
 
 	region->fd = -1;
-	if (backing_src_is_shared(src_type))
+	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP)
+		region->fd = kvm_dup(gmem_fd);
+	else if (backing_src_is_shared(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
-	region->mmap_start = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
-				      vm_mem_backing_src_alias(src_type)->flag,
-				      region->fd);
+	mmap_offset = flags & KVM_MEM_GUEST_MEMFD ? gmem_offset : 0;
+	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
+					vm_mem_backing_src_alias(src_type)->flag,
+					region->fd, mmap_offset);
 
 	TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
 		    region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
@@ -1117,7 +1119,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint64_t gpa, uint32_t slot, uint64_t npages,
 				 uint32_t flags)
 {
-	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0);
+	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0, 0);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 1969f4ab9b280..41f6b38f04071 100644
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
-- 
2.51.0.858.gf9c4a03a3a-goog


