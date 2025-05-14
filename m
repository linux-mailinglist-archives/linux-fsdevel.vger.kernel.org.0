Return-Path: <linux-fsdevel+bounces-49067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCCAB7A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42003B3038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4C267B13;
	Wed, 14 May 2025 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sXv9Gz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B9264F99
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266245; cv=none; b=k5MZMixzLzUByzcnK0wMHdJXlVhw6ulrG5352BE7CAab1vq2r9GmUNpAm+VK0tmlV6sDuShetD3I55h3eym4L4BRD15j9bDiD0wfhOERj1JkF8Y1FeM+s7N3j0nZuvV3cZMC+5n4XTD/NHpBw8+hpbl44Oksac2h9rfIBJR9XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266245; c=relaxed/simple;
	bh=1rVfuYi1WHYEYjmdy8cIEb5msrK0n7swdg38Pr4wEeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqNyG0hwgS8LRP2jHd8GAo/RQyfSTNXOAyNkdptzQlsGjkvRi38H7VotSv1fJNxhEJzGq07UU5Q8rbFGeHhXg0EADWsBPCMI7QKEyuZh0/h0tICarEZkL/hF1+SnEVXCmMZ09Nkp/YR+gHO2T6oPzAvfsIESID93sIaUQrZItz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sXv9Gz1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c06465976so357350a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266243; x=1747871043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BduUPNqb61B8Eivz+AJ2LgpTa1Bu3K7jmzRP1k+UIFk=;
        b=4sXv9Gz1PxEr5sP04dFyv8besvyc183ZakczXBAeV4rW8ysPxeGZgt+7W9rm3iDaLI
         DkDMGilK9RYcrp7CclKmiJmncD8H09ZyKuzmqHSpMdeyTCTc165txTZUjS5cCEH5aQzk
         juLdteZq2t0zoMIvotQhK5M7l3CdYv9LM/U9dslM/4TDezuvFE5SNzoyFrDwXbQ37gyv
         F3m5RxwMtnGb9iX9QeYGaEcK60hVTUHKFrUiBQ1LZbvEtIAeSx7FeA4vqfBYMZL3Fcmo
         OINjqK7oJhEIdxxOXJ8qbTNDhkyQYXhveme4R5Va0UrOA+R+YJOCiA7ugb4EG8vdQ4LU
         wPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266243; x=1747871043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BduUPNqb61B8Eivz+AJ2LgpTa1Bu3K7jmzRP1k+UIFk=;
        b=ZRzBVIl9b6KRqOOCKVv5CQ2D/EJ6MFrki4cLOVzUP3QulfNxoEkDZAqHYQMZVIWiz8
         xlSVZqAuh8WmLWaTi360c3zwiwaW/hZFtjzBCn2AP+7EqpPv4M7y4OuCTbNimEDng/Fh
         Tf39NeLzj5kYkAyvcG7lA+1vBiuVEFOXkjN+orQYPJsBZcmeEIo97Ecj4+BG5ovV0ACo
         lNdHtS6jI9Z5S/wNpXQM96cAd1Ly6OIm6dTOR89JC2bv9U/aFXRJKd18f2DuhnAwCBTo
         mRFfYfI+zgNFX898vii2Rq2aDBzP6SzbB1efG5pXDtD8RBMgxUaKBQRQ9ufG8yGyUTt+
         aJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCVGygBCW3nlsccAbXE7PmTgopPAMsbkGNw0BTIPDHssBvwfEoxzzXBNS/VicwvY4IF9UAowMKwYAbS8yyCI@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHDmR+RVgXBTqiDEHSxunx9rBfUAoIJCYn09Lpg2wgwk7lut+
	Y2A3nNWSv8nDE9JIlJw0NBaIskyQA64KM1FAoKcXPZNvYNFWOZNzBXmdppvC+gQWH+dm3r4DLKB
	UhK3yie+KE826/rcM+cbeVw==
X-Google-Smtp-Source: AGHT+IEjnuIuPh++1YsJBYPVFxGMfCMSkD+n47vqKHsfozYjZZGvfWXQQGTInhBsTuWssNrzOA4VxrkjA/1Su+uotw==
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:301:1ea9:63b0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c6:b0:2fa:15ab:4dff with SMTP id 98e67ed59e1d1-30e2e643c54mr7245629a91.31.1747266242805;
 Wed, 14 May 2025 16:44:02 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:21 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <322b245180f09076c5cbbac0d68ea27c0a8c878b.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 42/51] KVM: selftests: Add basic selftests for
 hugetlb-backed guest_memfd
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

Add tests for 2MB and 1GB page sizes, and update the invalid flags
test for GUEST_MEMFD_FLAG_HUGETLB.

In tests, touch every page but not every byte in page to save time
while testing.

Change-Id: I7d80a12b991a064cfd796e3c6e11f9a95fd16ec1
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 94 +++++++++++++------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 1e79382fd830..c8acccaa9e1d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -13,6 +13,8 @@
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
+#include <linux/guestmem.h>
+#include <linux/sizes.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -38,6 +40,7 @@ static void test_file_read_write(int fd)
 static void test_faulting_allowed(int fd, size_t page_size, size_t total_size)
 {
 	const char val = 0xaa;
+	size_t increment;
 	char *mem;
 	size_t i;
 	int ret;
@@ -45,21 +48,25 @@ static void test_faulting_allowed(int fd, size_t page_size, size_t total_size)
 	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	TEST_ASSERT(mem != MAP_FAILED, "mmaping() guest memory should pass.");
 
-	memset(mem, val, total_size);
-	for (i = 0; i < total_size; i++)
+	increment = page_size >> 1;
+
+	for (i = 0; i < total_size; i += increment)
+		mem[i] = val;
+	for (i = 0; i < total_size; i += increment)
 		TEST_ASSERT_EQ(mem[i], val);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
 			page_size);
 	TEST_ASSERT(!ret, "fallocate the first page should succeed");
 
-	for (i = 0; i < page_size; i++)
+	for (i = 0; i < page_size; i += increment)
 		TEST_ASSERT_EQ(mem[i], 0x00);
-	for (; i < total_size; i++)
+	for (; i < total_size; i += increment)
 		TEST_ASSERT_EQ(mem[i], val);
 
-	memset(mem, val, total_size);
-	for (i = 0; i < total_size; i++)
+	for (i = 0; i < total_size; i += increment)
+		mem[i] = val;
+	for (i = 0; i < total_size; i += increment)
 		TEST_ASSERT_EQ(mem[i], val);
 
 	ret = munmap(mem, total_size);
@@ -209,7 +216,7 @@ static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
 	size_t size;
 	int fd;
 
-	for (size = 1; size < page_size; size++) {
+	for (size = 1; size < page_size; size += (page_size >> 1)) {
 		fd = __vm_create_guest_memfd(vm, size, guest_memfd_flags);
 		TEST_ASSERT(fd == -1 && errno == EINVAL,
 			    "guest_memfd() with non-page-aligned page size '0x%lx' should fail with EINVAL",
@@ -217,28 +224,33 @@ static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
 	}
 }
 
-static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
+static void test_create_guest_memfd_multiple(struct kvm_vm *vm,
+					     uint64_t guest_memfd_flags,
+					     size_t page_size)
 {
 	int fd1, fd2, ret;
 	struct stat st1, st2;
 
-	fd1 = __vm_create_guest_memfd(vm, 4096, 0);
+	fd1 = __vm_create_guest_memfd(vm, page_size, guest_memfd_flags);
 	TEST_ASSERT(fd1 != -1, "memfd creation should succeed");
 
 	ret = fstat(fd1, &st1);
 	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
-	TEST_ASSERT(st1.st_size == 4096, "memfd st_size should match requested size");
+	TEST_ASSERT(st1.st_size == page_size, "memfd st_size should match requested size");
 
-	fd2 = __vm_create_guest_memfd(vm, 8192, 0);
+	fd2 = __vm_create_guest_memfd(vm, page_size * 2, guest_memfd_flags);
 	TEST_ASSERT(fd2 != -1, "memfd creation should succeed");
 
 	ret = fstat(fd2, &st2);
 	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
-	TEST_ASSERT(st2.st_size == 8192, "second memfd st_size should match requested size");
+	TEST_ASSERT(st2.st_size == page_size * 2,
+		    "second memfd st_size should match requested size");
+
 
 	ret = fstat(fd1, &st1);
 	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
-	TEST_ASSERT(st1.st_size == 4096, "first memfd st_size should still match requested size");
+	TEST_ASSERT(st1.st_size == page_size,
+		    "first memfd st_size should still match requested size");
 	TEST_ASSERT(st1.st_ino != st2.st_ino, "different memfd should have different inode numbers");
 
 	close(fd2);
@@ -449,21 +461,13 @@ static void test_guest_memfd_features(struct kvm_vm *vm, size_t page_size,
 	close(fd);
 }
 
-static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
-			   bool expect_mmap_allowed)
+static void test_guest_memfd_features_for_page_size(struct kvm_vm *vm,
+						    uint64_t guest_memfd_flags,
+						    size_t page_size,
+						    bool expect_mmap_allowed)
 {
-	struct kvm_vm *vm;
-	size_t page_size;
+	test_create_guest_memfd_multiple(vm, guest_memfd_flags, page_size);
 
-	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
-		return;
-
-	vm = vm_create_barebones_type(vm_type);
-
-	test_create_guest_memfd_multiple(vm);
-	test_bind_guest_memfd_wrt_userspace_addr(vm);
-
-	page_size = getpagesize();
 	if (guest_memfd_flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
 		test_guest_memfd_features(vm, page_size, guest_memfd_flags,
 					  expect_mmap_allowed, true);
@@ -479,6 +483,34 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
 		test_guest_memfd_features(vm, page_size, guest_memfd_flags,
 					  expect_mmap_allowed, false);
 	}
+}
+
+static void test_with_type(unsigned long vm_type, uint64_t base_flags,
+			   bool expect_mmap_allowed)
+{
+	struct kvm_vm *vm;
+	uint64_t flags;
+
+	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
+		return;
+
+	vm = vm_create_barebones_type(vm_type);
+
+	test_bind_guest_memfd_wrt_userspace_addr(vm);
+
+	printf("Test guest_memfd with 4K pages for vm_type %ld\n", vm_type);
+	test_guest_memfd_features_for_page_size(vm, base_flags, getpagesize(), expect_mmap_allowed);
+	printf("\tPASSED\n");
+
+	printf("Test guest_memfd with 2M pages for vm_type %ld\n", vm_type);
+	flags = base_flags | GUEST_MEMFD_FLAG_HUGETLB | GUESTMEM_HUGETLB_FLAG_2MB;
+	test_guest_memfd_features_for_page_size(vm, flags, SZ_2M, expect_mmap_allowed);
+	printf("\tPASSED\n");
+
+	printf("Test guest_memfd with 1G pages for vm_type %ld\n", vm_type);
+	flags = base_flags | GUEST_MEMFD_FLAG_HUGETLB | GUESTMEM_HUGETLB_FLAG_1GB;
+	test_guest_memfd_features_for_page_size(vm, flags, SZ_1G, expect_mmap_allowed);
+	printf("\tPASSED\n");
 
 	kvm_vm_release(vm);
 }
@@ -486,9 +518,14 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
 static void test_vm_with_gmem_flag(struct kvm_vm *vm, uint64_t flag,
 				   bool expect_valid)
 {
-	size_t page_size = getpagesize();
+	size_t page_size;
 	int fd;
 
+	if (flag == GUEST_MEMFD_FLAG_HUGETLB)
+		page_size = get_def_hugetlb_pagesz();
+	else
+		page_size = getpagesize();
+
 	fd = __vm_create_guest_memfd(vm, page_size, flag);
 
 	if (expect_valid) {
@@ -550,6 +587,9 @@ static void test_gmem_flag_validity(void)
 	/* After conversions are supported, all VM types support shared mem. */
 	uint64_t valid_flags = GUEST_MEMFD_FLAG_SUPPORT_SHARED;
 
+	if (kvm_has_cap(KVM_CAP_GMEM_HUGETLB))
+		valid_flags |= GUEST_MEMFD_FLAG_HUGETLB;
+
 	test_vm_type_gmem_flag_validity(VM_TYPE_DEFAULT, valid_flags);
 
 #ifdef __x86_64__
-- 
2.49.0.1045.g170613ef41-goog


