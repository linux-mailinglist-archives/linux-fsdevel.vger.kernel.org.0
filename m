Return-Path: <linux-fsdevel+bounces-49035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43633AB79B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F182C7AE7A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D782367C3;
	Wed, 14 May 2025 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fh/HsReV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5F235059
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266195; cv=none; b=OBPPIQSC0Qphtvo79f+PCALcwDis4xBxg0x7hOCOSFQ1IYz3z2MQFaUE7xfXfcnic0ZHidIOJw4pxbDnia9TWYLeRtzBm/3tgS9q5z8T01lXkd1yihbgibqeXTQDeqAkruyWTeePGt/8JFo5Wfs2Ann/QPbw2DJTQtf9ezT/rAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266195; c=relaxed/simple;
	bh=0PD4qw71a92H20thWZwCchz9FaTYnYvvVR8PnCp4a7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEa1B2pvuvUI9GTvyMezLlKnbCN0Axl+DBKjD3uLhbJFsPxPtSWpnYStxOzcqDNdkl6tTSHEUrZyv73y5McerEA5cNrugZzZ6I/HpJ7B9FRNDcZ+7lkq/vhfR2w0zbNOtdPp9w9/XdGwDesaVTcmNEBIJ7z2TEsZCNQ9Ie5pv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fh/HsReV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c8c9070d2so551610a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266193; x=1747870993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAI1pIUqm+SvgqmPkfJ097xIdC/ZKJ3Eqw0mKmDTKDI=;
        b=fh/HsReVyuPLUFANj2xxf9xTbtrLfJzKbUKdap8B2sBewWV9LPKKZ3sp+2ST6sjxuf
         4L3KZC3T+WxfS9Er2LzheOD0+S3f0K696S4XwQZCaeRcpQ+Ee1jaRENSB/201ea8kQjE
         rxeoxASCNFJO6l6pHZkiXy46+KBH8+qckeS98vcwtbKdektbDo2bmm0fzymRLjRWfUOg
         AL1K064zLnPUluK5Jfg22XBkpuJIrLYNJrR2l+SkXYT4Hu+c/7KdkGB9GqfY1fdO9oKO
         h4PwYDXcwt31ZyCuy6s/stsVjcm1r/qgffmpen05ePyA+wTLyGOlkmA+93CCwBFN6Yao
         yniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266193; x=1747870993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAI1pIUqm+SvgqmPkfJ097xIdC/ZKJ3Eqw0mKmDTKDI=;
        b=toNiYIsPnGCxeHPrcy+lFBgU8E4aRGY6mCZdmSI8lIIxZ7ltwXEm3CDk6PZ1J05Z5t
         MjONSWHh0TOs+9N+3/rHHmE/SgFLyJdbaiVql7mgSz8CnFOooVhIgQmtmXnn8dJQ4NcA
         ioiimr0veMAtRaitEp+VFAA+MoWm6Xu4tsYwTGDJCXfzwTwAqVZ83dTIy9yX32zFuyoO
         PDxgGILLnxzFo3+2m16hGA/htWoBSOTwstxF7LgEDbjTt0pEcqZCpmBqcttV9Ue1Nrwa
         sBq/IXj8o57Gv8xdZ6n9yoss3CIUYmEfz5kJV95iHPIZGmAU3wYMccJHOeF8odAJt24I
         cBUw==
X-Forwarded-Encrypted: i=1; AJvYcCVIfgpJL0ez2K7FGg5BLiOsWjUT53JVSHczASTxasS7eWT0EcqMMB8Oqc5kuVwbmG6szMT01fpsRbRmKaZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dxUdBYbD9mLP0WeIZqJL5EOBcCTCT980L9Dtj2gGDO8j2dBw
	2x8luLpOU3bAFIqk5rcIi1lsWPQ93fWOYfndP57oEJ7MGkRu8mtwB3h4OcqM60AVty4Livr+3F8
	0l0LFctBnTmXUofv0X/lCFA==
X-Google-Smtp-Source: AGHT+IEzWKRHvJxFpPHhQwCbO4gUf/opoh8fdITiyrUsafwAX3adeMMi56ilVeaSPhJ42tnf1R8Ds40TdZQq21f91w==
X-Received: from pjuw5.prod.google.com ([2002:a17:90a:d605:b0:30a:7d22:be7b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d647:b0:30c:540b:9b6 with SMTP id 98e67ed59e1d1-30e2e419501mr9812590a91.0.1747266192909;
 Wed, 14 May 2025 16:43:12 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:49 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <9a9db594cc0e9d059dd30d2415d0346e09065bb6.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 10/51] KVM: selftests: Refactor vm_mem_add to be more flexible
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

enum vm_mem_backing_src_type is encoding too many different
possibilities on different axes of (1) whether to mmap from an fd, (2)
granularity of mapping for THP, (3) size of hugetlb mapping, and has
yet to be extended to support guest_memfd.

When guest_memfd supports mmap() and we also want to support testing
with mmap()ing from guest_memfd, the number of combinations make
enumeration in vm_mem_backing_src_type difficult.

This refactor separates out vm_mem_backing_src_type from
userspace_mem_region. For now, vm_mem_backing_src_type remains a
possible way for tests to specify, on the command line, the
combination of backing memory to test.

vm_mem_add() is now the last place where vm_mem_backing_src_type is
interpreted, to

1. Check validity of requested guest_paddr
2. Align mmap_size appropriately based on the mapping's page_size and
   architecture
3. Install memory appropriately according to mapping's page size

mmap()ing an alias seems to be specific to userfaultfd tests and could
be refactored out of struct userspace_mem_region and localized in
userfaultfd tests in future.

This paves the way for replacing vm_mem_backing_src_type with multiple
command line flags that would specify backing memory more
flexibly. Future tests are expected to use vm_mem_region_alloc() to
allocate a struct userspace_mem_region, then use more fundamental
functions like vm_mem_region_mmap(), vm_mem_region_madvise_thp(),
kvm_memfd_create(), vm_create_guest_memfd(), and other functions in
vm_mem_add() to flexibly build up struct userspace_mem_region before
finally adding the region to the vm with vm_mem_region_add().

Change-Id: Ibb37af8a1a3bbb6de776426302433c5d9613ee76
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  29 +-
 .../testing/selftests/kvm/include/test_util.h |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 429 +++++++++++-------
 tools/testing/selftests/kvm/lib/test_util.c   |  25 +
 4 files changed, 328 insertions(+), 157 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 373912464fb4..853ab68cff79 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -35,11 +35,26 @@ struct userspace_mem_region {
 	struct sparsebit *protected_phy_pages;
 	int fd;
 	off_t offset;
-	enum vm_mem_backing_src_type backing_src_type;
+	/*
+	 * host_mem is mmap_start aligned upwards to an address suitable for the
+	 * architecture. In most cases, host_mem and mmap_start are the same,
+	 * except for s390x, where the host address must be aligned to 1M (due
+	 * to PGSTEs).
+	 */
+#ifdef __s390x__
+#define S390X_HOST_ADDRESS_ALIGNMENT 0x100000
+#endif
 	void *host_mem;
+	/* host_alias is to mmap_alias as host_mem is to mmap_start */
 	void *host_alias;
 	void *mmap_start;
 	void *mmap_alias;
+	/*
+	 * mmap_size is possibly larger than region.memory_size because in some
+	 * cases, host_mem has to be adjusted upwards (see comment for host_mem
+	 * above). In those cases, mmap_size has to be adjusted upwards so that
+	 * enough memory is available in this memslot.
+	 */
 	size_t mmap_size;
 	struct rb_node gpa_node;
 	struct rb_node hva_node;
@@ -582,6 +597,18 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 				 uint64_t gpa, uint64_t size, void *hva,
 				 uint32_t guest_memfd, uint64_t guest_memfd_offset);
 
+struct userspace_mem_region *vm_mem_region_alloc(struct kvm_vm *vm);
+void *vm_mem_region_mmap(struct userspace_mem_region *region, size_t length,
+			 int flags, int fd, off_t offset);
+void vm_mem_region_install_memory(struct userspace_mem_region *region,
+				  size_t memslot_size, size_t alignment);
+void vm_mem_region_madvise_thp(struct userspace_mem_region *region, int advice);
+int vm_mem_region_install_guest_memfd(struct userspace_mem_region *region,
+				      int guest_memfd);
+void *vm_mem_region_mmap_alias(struct userspace_mem_region *region, int flags,
+			       size_t alignment);
+void vm_mem_region_add(struct kvm_vm *vm, struct userspace_mem_region *region);
+
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	enum vm_mem_backing_src_type src_type,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 77d13d7920cb..b4a03784ac4f 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -149,6 +149,8 @@ size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
+int backing_src_should_madvise(uint32_t i);
+int get_backing_src_madvise_advice(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 815bc45dd8dc..58a3365f479c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -824,15 +824,12 @@ void kvm_vm_free(struct kvm_vm *vmp)
 	free(vmp);
 }
 
-int kvm_memfd_alloc(size_t size, bool hugepages)
+int kvm_create_memfd(size_t size, unsigned int flags)
 {
-	int memfd_flags = MFD_CLOEXEC;
-	int fd, r;
+	int fd;
+	int r;
 
-	if (hugepages)
-		memfd_flags |= MFD_HUGETLB;
-
-	fd = memfd_create("kvm_selftest", memfd_flags);
+	fd = memfd_create("kvm_selftest", flags);
 	TEST_ASSERT(fd != -1, __KVM_SYSCALL_ERROR("memfd_create()", fd));
 
 	r = ftruncate(fd, size);
@@ -844,6 +841,16 @@ int kvm_memfd_alloc(size_t size, bool hugepages)
 	return fd;
 }
 
+int kvm_memfd_alloc(size_t size, bool hugepages)
+{
+	int memfd_flags = MFD_CLOEXEC;
+
+	if (hugepages)
+		memfd_flags |= MFD_HUGETLB;
+
+	return kvm_create_memfd(size, memfd_flags);
+}
+
 static void vm_userspace_mem_region_gpa_insert(struct rb_root *gpa_tree,
 					       struct userspace_mem_region *region)
 {
@@ -953,185 +960,295 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 		    errno, strerror(errno));
 }
 
+/**
+ * Allocates and returns a struct userspace_mem_region.
+ */
+struct userspace_mem_region *vm_mem_region_alloc(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
 
-/* FIXME: This thing needs to be ripped apart and rewritten. */
-void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
-		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+	/* Allocate and initialize new mem region structure. */
+	region = calloc(1, sizeof(*region));
+	TEST_ASSERT(region != NULL, "Insufficient Memory");
+
+	region->unused_phy_pages = sparsebit_alloc();
+	if (vm_arch_has_protected_memory(vm))
+		region->protected_phy_pages = sparsebit_alloc();
+
+	region->fd = -1;
+	region->region.guest_memfd = -1;
+
+	return region;
+}
+
+static size_t compute_page_size(int mmap_flags, int madvise_advice)
+{
+	if (mmap_flags & MAP_HUGETLB) {
+		int size_flags = (mmap_flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK;
+
+		if (!size_flags)
+			return get_def_hugetlb_pagesz();
+
+		return 1ULL << size_flags;
+	}
+
+	return madvise_advice == MADV_HUGEPAGE ? get_trans_hugepagesz() : getpagesize();
+}
+
+/**
+ * Calls mmap() with @length, @flags, @fd, @offset for @region.
+ *
+ * Think of this as the struct userspace_mem_region wrapper for the mmap()
+ * syscall.
+ */
+void *vm_mem_region_mmap(struct userspace_mem_region *region, size_t length,
+			 int flags, int fd, off_t offset)
+{
+	void *mem;
+
+	if (flags & MAP_SHARED) {
+		TEST_ASSERT(fd != -1,
+			    "Ensure that fd is provided for shared mappings.");
+		TEST_ASSERT(
+			region->fd == fd || region->region.guest_memfd == fd,
+			"Ensure that fd is opened before mmap, and is either "
+			"set up in region->fd or region->region.guest_memfd.");
+	}
+
+	mem = mmap(NULL, length, PROT_READ | PROT_WRITE, flags, fd, offset);
+	TEST_ASSERT(mem != MAP_FAILED, "Couldn't mmap anonymous memory");
+
+	region->mmap_start = mem;
+	region->mmap_size = length;
+	region->offset = offset;
+
+	return mem;
+}
+
+/**
+ * Installs mmap()ed memory in @region->mmap_start as @region->host_mem,
+ * checking constraints.
+ */
+void vm_mem_region_install_memory(struct userspace_mem_region *region,
+				  size_t memslot_size, size_t alignment)
+{
+	TEST_ASSERT(region->mmap_size >= memslot_size,
+		    "mmap()ed memory insufficient for memslot");
+
+	region->host_mem = align_ptr_up(region->mmap_start, alignment);
+	region->region.userspace_addr = (uint64_t)region->host_mem;
+	region->region.memory_size = memslot_size;
+}
+
+
+/**
+ * Calls madvise with @advice for @region.
+ *
+ * Think of this as the struct userspace_mem_region wrapper for the madvise()
+ * syscall.
+ */
+void vm_mem_region_madvise_thp(struct userspace_mem_region *region, int advice)
 {
 	int ret;
+
+	TEST_ASSERT(
+		region->host_mem && region->mmap_size,
+		"vm_mem_region_madvise_thp() must be called after vm_mem_region_mmap()");
+
+	ret = madvise(region->host_mem, region->mmap_size, advice);
+	TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx",
+		    region->host_mem, region->mmap_size);
+}
+
+/**
+ * Installs guest_memfd by setting it up in @region.
+ *
+ * Returns the guest_memfd that was installed in the @region.
+ */
+int vm_mem_region_install_guest_memfd(struct userspace_mem_region *region,
+				      int guest_memfd)
+{
+	/*
+	 * Install a unique fd for each memslot so that the fd can be closed
+	 * when the region is deleted without needing to track if the fd is
+	 * owned by the framework or by the caller.
+	 */
+	guest_memfd = dup(guest_memfd);
+	TEST_ASSERT(guest_memfd >= 0, __KVM_SYSCALL_ERROR("dup()", guest_memfd));
+	region->region.guest_memfd = guest_memfd;
+
+	return guest_memfd;
+}
+
+/**
+ * Calls mmap() to create an alias for mmap()ed memory at region->host_mem,
+ * exactly the same size the was mmap()ed.
+ *
+ * This is used mainly for userfaultfd tests.
+ */
+void *vm_mem_region_mmap_alias(struct userspace_mem_region *region, int flags,
+			       size_t alignment)
+{
+	region->mmap_alias = mmap(NULL, region->mmap_size,
+				  PROT_READ | PROT_WRITE, flags, region->fd, 0);
+	TEST_ASSERT(region->mmap_alias != MAP_FAILED,
+		    __KVM_SYSCALL_ERROR("mmap()",  (int)(unsigned long)MAP_FAILED));
+
+	region->host_alias = align_ptr_up(region->mmap_alias, alignment);
+
+	return region->host_alias;
+}
+
+static void vm_mem_region_assert_no_duplicate(struct kvm_vm *vm, uint32_t slot,
+					      uint64_t gpa, size_t size)
+{
 	struct userspace_mem_region *region;
-	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
-	size_t mem_size = npages * vm->page_size;
-	size_t alignment;
-
-	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
-
-	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
-		"Number of guest pages is not compatible with the host. "
-		"Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
-
-	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
-		"address not on a page boundary.\n"
-		"  guest_paddr: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, vm->page_size);
-	TEST_ASSERT((((guest_paddr >> vm->page_shift) + npages) - 1)
-		<= vm->max_gfn, "Physical range beyond maximum "
-		"supported physical address,\n"
-		"  guest_paddr: 0x%lx npages: 0x%lx\n"
-		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, npages, vm->max_gfn, vm->page_size);
 
 	/*
 	 * Confirm a mem region with an overlapping address doesn't
 	 * already exist.
 	 */
-	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
-	if (region != NULL)
-		TEST_FAIL("overlapping userspace_mem_region already "
-			"exists\n"
-			"  requested guest_paddr: 0x%lx npages: 0x%lx "
-			"page_size: 0x%x\n"
-			"  existing guest_paddr: 0x%lx size: 0x%lx",
-			guest_paddr, npages, vm->page_size,
-			(uint64_t) region->region.guest_phys_addr,
-			(uint64_t) region->region.memory_size);
+	region = userspace_mem_region_find(vm, gpa, gpa + size - 1);
+	if (region != NULL) {
+		TEST_FAIL("overlapping userspace_mem_region already exists\n"
+			  "  requested gpa: 0x%lx size: 0x%lx"
+			  "  existing gpa: 0x%lx size: 0x%lx",
+			  gpa, size,
+			  (uint64_t) region->region.guest_phys_addr,
+			  (uint64_t) region->region.memory_size);
+	}
 
 	/* Confirm no region with the requested slot already exists. */
-	hash_for_each_possible(vm->regions.slot_hash, region, slot_node,
-			       slot) {
+	hash_for_each_possible(vm->regions.slot_hash, region, slot_node, slot) {
 		if (region->region.slot != slot)
 			continue;
 
-		TEST_FAIL("A mem region with the requested slot "
-			"already exists.\n"
-			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
-			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
-			slot, guest_paddr, npages,
-			region->region.slot,
-			(uint64_t) region->region.guest_phys_addr,
-			(uint64_t) region->region.memory_size);
+		TEST_FAIL("A mem region with the requested slot already exists.\n"
+			  "  requested slot: %u paddr: 0x%lx size: 0x%lx\n"
+			  "  existing slot: %u paddr: 0x%lx size: 0x%lx",
+			  slot, gpa, size,
+			  region->region.slot,
+			  (uint64_t) region->region.guest_phys_addr,
+			  (uint64_t) region->region.memory_size);
 	}
+}
 
-	/* Allocate and initialize new mem region structure. */
-	region = calloc(1, sizeof(*region));
-	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = mem_size;
+/**
+ * Add a @region to @vm. All necessary fields in region->region should already
+ * be populated.
+ *
+ * Think of this as the struct userspace_mem_region wrapper for the
+ * KVM_SET_USER_MEMORY_REGION2 ioctl.
+ */
+void vm_mem_region_add(struct kvm_vm *vm, struct userspace_mem_region *region)
+{
+	uint64_t npages;
+	uint64_t gpa;
+	int ret;
 
-#ifdef __s390x__
-	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
-	alignment = 0x100000;
-#else
-	alignment = 1;
-#endif
+	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
 
-	/*
-	 * When using THP mmap is not guaranteed to returned a hugepage aligned
-	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
-	 * because mmap will always return an address aligned to the HugeTLB
-	 * page size.
-	 */
-	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		alignment = max(backing_src_pagesz, alignment);
+	npages = region->region.memory_size / vm->page_size;
+	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
+		    "Number of guest pages is not compatible with the host. "
+		    "Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
 
-	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
+	gpa = region->region.guest_phys_addr;
+	TEST_ASSERT((gpa % vm->page_size) == 0,
+		    "Guest physical address not on a page boundary.\n"
+		    "  gpa: 0x%lx vm->page_size: 0x%x",
+		    gpa, vm->page_size);
+	TEST_ASSERT((((gpa >> vm->page_shift) + npages) - 1) <= vm->max_gfn,
+		    "Physical range beyond maximum supported physical address,\n"
+		    "  gpa: 0x%lx npages: 0x%lx\n"
+		    "  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		    gpa, npages, vm->max_gfn, vm->page_size);
 
-	/* Add enough memory to align up if necessary */
-	if (alignment > 1)
-		region->mmap_size += alignment;
+	vm_mem_region_assert_no_duplicate(vm, region->region.slot, gpa,
+					  region->mmap_size);
 
-	region->fd = -1;
-	if (backing_src_is_shared(src_type))
-		region->fd = kvm_memfd_alloc(region->mmap_size,
-					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
-
-	region->mmap_start = mmap(NULL, region->mmap_size,
-				  PROT_READ | PROT_WRITE,
-				  vm_mem_backing_src_alias(src_type)->flag,
-				  region->fd, 0);
-	TEST_ASSERT(region->mmap_start != MAP_FAILED,
-		    __KVM_SYSCALL_ERROR("mmap()", (int)(unsigned long)MAP_FAILED));
-
-	TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
-		    region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
-		    "mmap_start %p is not aligned to HugeTLB page size 0x%lx",
-		    region->mmap_start, backing_src_pagesz);
-
-	/* Align host address */
-	region->host_mem = align_ptr_up(region->mmap_start, alignment);
-
-	/* As needed perform madvise */
-	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
-	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
-		ret = madvise(region->host_mem, mem_size,
-			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
-		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
-			    region->host_mem, mem_size,
-			    vm_mem_backing_src_alias(src_type)->name);
-	}
-
-	region->backing_src_type = src_type;
-
-	if (flags & KVM_MEM_GUEST_MEMFD) {
-		if (guest_memfd < 0) {
-			uint32_t guest_memfd_flags = 0;
-			TEST_ASSERT(!guest_memfd_offset,
-				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
-		} else {
-			/*
-			 * Install a unique fd for each memslot so that the fd
-			 * can be closed when the region is deleted without
-			 * needing to track if the fd is owned by the framework
-			 * or by the caller.
-			 */
-			guest_memfd = dup(guest_memfd);
-			TEST_ASSERT(guest_memfd >= 0, __KVM_SYSCALL_ERROR("dup()", guest_memfd));
-		}
-
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
-	} else {
-		region->region.guest_memfd = -1;
-	}
-
-	region->unused_phy_pages = sparsebit_alloc();
-	if (vm_arch_has_protected_memory(vm))
-		region->protected_phy_pages = sparsebit_alloc();
-	sparsebit_set_num(region->unused_phy_pages,
-		guest_paddr >> vm->page_shift, npages);
-	region->region.slot = slot;
-	region->region.flags = flags;
-	region->region.guest_phys_addr = guest_paddr;
-	region->region.memory_size = npages * vm->page_size;
-	region->region.userspace_addr = (uintptr_t) region->host_mem;
 	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
-		"  rc: %i errno: %i\n"
-		"  slot: %u flags: 0x%x\n"
-		"  guest_phys_addr: 0x%lx size: 0x%lx guest_memfd: %d",
-		ret, errno, slot, flags,
-		guest_paddr, (uint64_t) region->region.memory_size,
-		region->region.guest_memfd);
+		    "  rc: %i errno: %i\n"
+		    "  slot: %u flags: 0x%x\n"
+		    "  guest_phys_addr: 0x%lx size: 0x%llx guest_memfd: %d",
+		    ret, errno, region->region.slot, region->region.flags,
+		    gpa, region->region.memory_size,
+		    region->region.guest_memfd);
+
+	sparsebit_set_num(region->unused_phy_pages, gpa >> vm->page_shift, npages);
 
 	/* Add to quick lookup data structures */
 	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
 	vm_userspace_mem_region_hva_insert(&vm->regions.hva_tree, region);
-	hash_add(vm->regions.slot_hash, &region->slot_node, slot);
+	hash_add(vm->regions.slot_hash, &region->slot_node, region->region.slot);
+}
 
-	/* If shared memory, create an alias. */
-	if (region->fd >= 0) {
-		region->mmap_alias = mmap(NULL, region->mmap_size,
-					  PROT_READ | PROT_WRITE,
-					  vm_mem_backing_src_alias(src_type)->flag,
-					  region->fd, 0);
-		TEST_ASSERT(region->mmap_alias != MAP_FAILED,
-			    __KVM_SYSCALL_ERROR("mmap()",  (int)(unsigned long)MAP_FAILED));
+void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
+		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+{
+	struct userspace_mem_region *region;
+	size_t mapping_page_size;
+	size_t memslot_size;
+	int madvise_advice;
+	size_t mmap_size;
+	size_t alignment;
+	int mmap_flags;
+	int memfd;
 
-		/* Align host alias address */
-		region->host_alias = align_ptr_up(region->mmap_alias, alignment);
+	memslot_size = npages * vm->page_size;
+
+	mmap_flags = vm_mem_backing_src_alias(src_type)->flag;
+	madvise_advice = get_backing_src_madvise_advice(src_type);
+	mapping_page_size = compute_page_size(mmap_flags, madvise_advice);
+
+	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, mapping_page_size));
+
+	alignment = mapping_page_size;
+#ifdef __s390x__
+	alignment = max(alignment, S390X_HOST_ADDRESS_ALIGNMENT);
+#endif
+
+	region = vm_mem_region_alloc(vm);
+
+	memfd = -1;
+	if (backing_src_is_shared(src_type)) {
+		unsigned int memfd_flags = MFD_CLOEXEC;
+
+		if (src_type == VM_MEM_SRC_SHARED_HUGETLB)
+			memfd_flags |= MFD_HUGETLB;
+
+		memfd = kvm_create_memfd(memslot_size, memfd_flags);
 	}
+	region->fd = memfd;
+
+	mmap_size = align_up(memslot_size, alignment);
+	vm_mem_region_mmap(region, mmap_size, mmap_flags, memfd, 0);
+	vm_mem_region_install_memory(region, memslot_size, alignment);
+
+	if (backing_src_should_madvise(src_type))
+		vm_mem_region_madvise_thp(region, madvise_advice);
+
+	if (backing_src_is_shared(src_type))
+		vm_mem_region_mmap_alias(region, mmap_flags, alignment);
+
+	if (flags & KVM_MEM_GUEST_MEMFD) {
+		if (guest_memfd < 0) {
+			TEST_ASSERT(
+				guest_memfd_offset == 0,
+				"Offset must be zero when creating new guest_memfd");
+			guest_memfd = vm_create_guest_memfd(vm, memslot_size, 0);
+		}
+
+		vm_mem_region_install_guest_memfd(region, guest_memfd);
+	}
+
+	region->region.slot = slot;
+	region->region.flags = flags;
+	region->region.guest_phys_addr = guest_paddr;
+	region->region.guest_memfd_offset = guest_memfd_offset;
+	vm_mem_region_add(vm, region);
 }
 
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae837..24dc90693afd 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -308,6 +308,31 @@ size_t get_backing_src_pagesz(uint32_t i)
 	}
 }
 
+int backing_src_should_madvise(uint32_t i)
+{
+	switch (i) {
+	case VM_MEM_SRC_ANONYMOUS:
+	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_ANONYMOUS_THP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int get_backing_src_madvise_advice(uint32_t i)
+{
+	switch (i) {
+	case VM_MEM_SRC_ANONYMOUS:
+	case VM_MEM_SRC_SHMEM:
+		return MADV_NOHUGEPAGE;
+	case VM_MEM_SRC_ANONYMOUS_THP:
+		return MADV_NOHUGEPAGE;
+	default:
+		return 0;
+	}
+}
+
 bool is_backing_src_hugetlb(uint32_t i)
 {
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
-- 
2.49.0.1045.g170613ef41-goog


