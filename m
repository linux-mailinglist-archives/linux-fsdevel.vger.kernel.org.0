Return-Path: <linux-fsdevel+bounces-49073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9BAB7A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D494C7DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819326B097;
	Wed, 14 May 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmD2sQg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130B26A0DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266254; cv=none; b=YcMhh5DM/kXcn91kfhzTHnh7wPefIy5otTs0dYbvXlTXk6VB0n0nJW1KbUQ1XYoy8DmXFvtvDGvT0BUQK5g7EQ2GNI9/EmyKibVMxN3a1AEQJagMsEHeI2rxsbVQEA7scMwRDrMTPdeP57byLcOvrshgFVLtk2vF6t6ygUisnDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266254; c=relaxed/simple;
	bh=aPgC7xelTHDVWDAUkE1HCYXZKLL8arCU43wTrXitw0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVo2pJ/j385uX6bj4tSc0hBzTAzm1qC9ybJN8uWa/rnW1d30pOsiAfwWA0BBaVVqvMmjQgIgOsBGQ4H/kkh3IiTucr+uv+FWY8bm1TmK7rYnJZcOiQeBLwp5F6ZVG1GnypBvU3q9sE+QHoE5ddzKGFJUxMP/APVgDHTXgOHOSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmD2sQg9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e76805fecso6308615ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266252; x=1747871052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIHO3z7qgUdLCctBcJJdIeKM53vTdpjbrMww0TEetmg=;
        b=RmD2sQg9MN8h5oYzAJRutyJer64ydMRG+TvuT3E1XO5U3RDpSX44m5ab4YZckA8SD/
         lNqRd5Ezwo0NGMFaZEzrSHeCwnr7uK5adnfL8taWsrucKC+2SPsfktXffs5w3hZXSJYA
         2gzRunhj8IaQ5F/Kx182nnvw8/OH7Lm5JxDozaRk0J/Sh/8uiqefAqIwS2RKlQnxxjyZ
         hftQ40PTZMF8R7xuCwYi6CcYjRMu4V0VWEGsK6OH/DmqRJBhP5yEPqx0dpDaGloCimxc
         QpDJxiXMutZzfACbKEdgMSBtXI1EXtVQfp+H/tB0qZY0jKsNvfvTSxd7eA3DuLanir8w
         ob7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266252; x=1747871052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIHO3z7qgUdLCctBcJJdIeKM53vTdpjbrMww0TEetmg=;
        b=l6Fa6Q+LtVcFcNMD1QbBzws363+BAgSAYK0gNH6YYEL0EpxS46VFylXjRbTlSiZnNa
         puJvlPoDG9lm8iP5UcxVqlUeJ0Ppfb6eujDAA9WZCX4fF9cjOylkX/rNpNpfOxzVhuvP
         ChuxyaGbELOBtiSVqGJZ4FAhO7JvvuOLihu/fjE3XfYB4ThAY1Wy0ZzQRnXxXDut/NP1
         7TwL9dm9CQMjdRXSBzgx2Q4AAp61SY+eIZ0NYTlfpYEDmA/J2A7CnegmcPD/dNqZ76+9
         5rwMVuV4iwNbXXBTqhXc0sTDW5hfI3zXDtYbbkUncwGikaanp/wvrVGEZmEB++SYXTau
         3UbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpoQLRfVHfr6bYQ3ojvyGkMrRDiAnSbR2uZXfV+q1NvXg54mnZZ9yCfbX62JIpJOgd34js63SRESspoUdg@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRjw2s6GV/9h5VCi7QfZVbFNQnTkZMUrgcSpYJhNwqUy/Io5W
	NSiyOsO4ZSngzolh/slMQnupswIf9Lm7osLHCP9Lbfhs0j0AfnLsbYlSX/Qb97/UpbtDRlYD/K0
	021V4Gr7C/oAVSrzh9vkBGw==
X-Google-Smtp-Source: AGHT+IHmwCzSwN6Nfb7PIWHR4ZLGRIGjOq8g3mWPjJm4bmOxXDdJ3v5NacuKAC2o4rPhtu2Mbj8tJejqtkdzvZ+2iQ==
X-Received: from plgk17.prod.google.com ([2002:a17:902:ce11:b0:22e:15c1:3510])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1744:b0:223:f639:69df with SMTP id d9443c01a7336-231b60fd7e5mr4722055ad.41.1747266252099;
 Wed, 14 May 2025 16:44:12 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:27 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <db8bb0ba64c858913d169f0d3e95a17fabf2096e.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 48/51] KVM: selftests: Update test for various private
 memory backing source types
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

Update private_mem_conversions_test for various private memory backing
source types, testing HugeTLB support in guest_memfd.

Change-Id: I50facb166a282f97570591eb331c3f19676b01cc
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86/private_mem_conversions_test.c    | 42 +++++++++++++------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index ec20bb7e95c8..5a0fd9155ce8 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -450,21 +450,18 @@ static void *__test_mem_conversions(void *params)
 }
 
 static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
+				 enum vm_private_mem_backing_src_type private_mem_src_type,
 				 uint32_t nr_vcpus, uint32_t nr_memslots,
 				 bool back_shared_memory_with_guest_memfd)
 {
-	/*
-	 * Allocate enough memory so that each vCPU's chunk of memory can be
-	 * naturally aligned with respect to the size of the backing store.
-	 */
-	const size_t alignment = max_t(size_t, SZ_2M, get_backing_src_pagesz(src_type));
 	struct test_thread_args *thread_args[KVM_MAX_VCPUS];
-	const size_t per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
-	const size_t memfd_size = per_cpu_size * nr_vcpus;
-	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
+	size_t per_cpu_size;
+	size_t memfd_size;
 	struct kvm_vm *vm;
+	size_t alignment;
+	size_t slot_size;
 	int memfd, i, r;
 	uint64_t flags;
 
@@ -473,6 +470,18 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 		.type = KVM_X86_SW_PROTECTED_VM,
 	};
 
+	/*
+	 * Allocate enough memory so that each vCPU's chunk of memory can be
+	 * naturally aligned with respect to the size of the backing store.
+	 */
+	alignment = max_t(size_t, SZ_2M,
+			  max_t(size_t, get_backing_src_pagesz(src_type),
+				get_private_mem_backing_src_pagesz(
+					private_mem_src_type)));
+	per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
+	memfd_size = per_cpu_size * nr_vcpus;
+	slot_size = memfd_size / nr_memslots;
+
 	TEST_ASSERT(slot_size * nr_memslots == memfd_size,
 		    "The memfd size (0x%lx) needs to be cleanly divisible by the number of memslots (%u)",
 		    memfd_size, nr_memslots);
@@ -483,6 +492,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 	flags = back_shared_memory_with_guest_memfd ?
 			GUEST_MEMFD_FLAG_SUPPORT_SHARED :
 			0;
+	flags |= vm_private_mem_backing_src_alias(private_mem_src_type)->flag;
 	memfd = vm_create_guest_memfd(vm, memfd_size, flags);
 
 	for (i = 0; i < nr_memslots; i++) {
@@ -547,10 +557,13 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 static void usage(const char *cmd)
 {
 	puts("");
-	printf("usage: %s [-h] [-g] [-m nr_memslots] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	printf("usage: %s [-h] [-g] [-m nr_memslots] [-s mem_type] [-p private_mem_type] [-n nr_vcpus]\n",
+	       cmd);
 	puts("");
 	backing_src_help("-s");
 	puts("");
+	private_mem_backing_src_help("-p");
+	puts("");
 	puts(" -n: specify the number of vcpus (default: 1)");
 	puts("");
 	puts(" -m: specify the number of memslots (default: 1)");
@@ -561,6 +574,7 @@ static void usage(const char *cmd)
 
 int main(int argc, char *argv[])
 {
+	enum vm_private_mem_backing_src_type private_mem_src_type = DEFAULT_VM_PRIVATE_MEM_SRC;
 	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
 	bool back_shared_memory_with_guest_memfd = false;
 	uint32_t nr_memslots = 1;
@@ -569,11 +583,14 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "hgm:s:n:")) != -1) {
+	while ((opt = getopt(argc, argv, "hgm:s:p:n:")) != -1) {
 		switch (opt) {
 		case 's':
 			src_type = parse_backing_src_type(optarg);
 			break;
+		case 'p':
+			private_mem_src_type = parse_private_mem_backing_src_type(optarg);
+			break;
 		case 'n':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
 			break;
@@ -590,9 +607,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	test_mem_conversions(src_type, nr_vcpus, nr_memslots,
-			     back_shared_memory_with_guest_memfd);
-
+	test_mem_conversions(src_type, private_mem_src_type, nr_vcpus,
+			     nr_memslots, back_shared_memory_with_guest_memfd);
 
 	return 0;
 }
-- 
2.49.0.1045.g170613ef41-goog


