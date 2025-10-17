Return-Path: <linux-fsdevel+bounces-64550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48986BEB9EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EA0742168
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46434C99B;
	Fri, 17 Oct 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKPp1/jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65286338915
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732022; cv=none; b=i6wyqDeG273UL1HIgclE1gNV/iPJvgxjweoRyxZESjli6OUENQuqPgsZhUDlsN+NOY1sFIp5U6mt9jTIIIqwCJCVguS8eGG+UZKHCCUcKO0/59Mc0qVYOJkEuSEU5qjIYdzRu3xaUg1tfqV7cDNU2sORWk8cY8KcAkoVz7nv95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732022; c=relaxed/simple;
	bh=VfxgTYzfPcNal3AIP/26nqYp1tsVb9JGusB/JnZZlbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/oNAqS3pgf5UJob8p4NqH75470TVlcFliSW9mxJ+a8GS636GwLcSHkaJwffiDg2Hr7/qHIKfTDWNbO7g0182L5wpqmtyZi8aS+Z+qPr8pcvR1U6K/1k9k1X6EQ6FuUEVTXayoONHoFHrdWHCMpJSl0Df0KsiFDTlb3y6ZO2ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKPp1/jx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a153ba0009so3862843b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732011; x=1761336811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjvPBfWPeDDoysxeGmNxm2XVFXiN0LW7diKaU3jXVt0=;
        b=WKPp1/jx/w6ezl0DMYKz+QZrTxDdERpLqp6Ab7/XaE73h4Qr4CJOf+wXnsM1HoECKD
         FJ0hyq5440pgW7WJrEuiRgjK7mEzX3LfkV2NGuW8109Ea8wVihtjHFkQFqRZcFVPlo2V
         lgdhHtax4NXNrA0ghHjeTd7zsgjvYJ8Jo/L7GM/ah6HHZTaBXbGv2VaYwdarGt6a/UEI
         Us5+Ff5gxr8PYgnwqMFXXPIrWHj2FQmGsf8+jFie59lYTiYot7sYv2AWCO0ZpqP8Uu5B
         hunvVBNqATAmgRpZ1VB8xebcOZcxPdPZlhs8Lkr40Atl/X5wDobknQVmNdHmS/rXnIm9
         nzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732011; x=1761336811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjvPBfWPeDDoysxeGmNxm2XVFXiN0LW7diKaU3jXVt0=;
        b=r7J4GTeMAyt29WvuW5GYG3isbduIrXC1ugHKA8Hv1dR7KUdTxitQS5Mr1X8TN8niKC
         G2SVYZ3fnOLNF2ElnIq1PeQieMi+FAJQ9GF1OnT0NrxHRoCvgxEAD4f1JAQVMMSKs9es
         J88YpJn5KYTc43sXnXdZwmGcevQWkD3GvlzGE2+S5Q6dhbeqKzujeIqRy3Ctkk5ZatMj
         CmkXzA/RFRsJt+eNTH1ednIkCfeYBgjXrPpK7Iv4Mz49Il5QPiH+R8c4SWk6EwHLbhlw
         h5oCuolu9YXE1heU1FLEMfYIl4ErtlPHjCmVdJhbu+GN+3ucfWJ1FSpJnwjuAoIg9LCn
         FUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQT9lK6xea+UhrVVDw2d1BA9fSobVZ5EKq040s1Yc4tvUnEs7G6XxnSWYGoALjmbvUO8heCY2JLT7zx+LX@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVd3dY74/5BAQh4AdIDQJgowJFE+l8p+Jp0e4u5kiwvjl/62j
	IApjfyaOk827VR+Ok7kjJz+Uxa0+jsghU4WzbRozd2/vUfm1ZVe64W0sRGbLncMEH/EYEUtjvnZ
	b4Q24dpp6KAtqoGd7iD1q7pBimQ==
X-Google-Smtp-Source: AGHT+IHIFgvKx4iQssAvfWvw05fzS3tjPMxtqzDzpUfFs2q0tZQVlLhulOrO+VXHlGdzU4khsfJPAu1rlwqetjJf8A==
X-Received: from pjbpj3.prod.google.com ([2002:a17:90b:4f43:b0:332:4129:51b2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9997:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-334a84c81famr6743421637.13.1760732010737;
 Fri, 17 Oct 2025 13:13:30 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:18 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <f326fd44695d94438b6061c0c5881c6a17ad84d3.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 37/37] KVM: selftests: Update private memory exits test
 work with per-gmem attributes
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

Skip setting memory to private in the private memory exits test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Expect an emulated MMIO instead of a memory fault exit when attributes are
per-gmem, as deleting the memslot effectively drops the private status,
i.e. the GPA becomes shared and thus supports emulated MMIO.

Skip the "memslot not private" test entirely, as private vs. shared state
for x86 software-protected VMs comes from the memory attributes themselves,
and so when doing in-place conversions there can never be a disconnect
between the expected and actual states.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/private_mem_kvm_exits_test.c      | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index 13e72fcec8dd2..10be67441d457 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	/* Request to access page privately. */
+	if (!kvm_has_gmem_attributes)
+		vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
 	pthread_create(&vm_thread, NULL,
 		       (void *(*)(void *))run_vcpu_get_exit_reason,
@@ -74,10 +75,26 @@ static void test_private_access_memslot_deleted(void)
 	pthread_join(vm_thread, &thread_return);
 	exit_reason = (uint32_t)(uint64_t)thread_return;
 
-	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	/*
+	 * If attributes are tracked per-gmem, deleting the memslot that points
+	 * at the gmem instance effectively makes the memory shared, and so the
+	 * read should trigger emulated MMIO.
+	 *
+	 * If attributes are tracked per-VM, deleting the memslot shouldn't
+	 * affect the private attribute, and so KVM should generate a memory
+	 * fault exit (emulated MMIO on private GPAs is disallowed).
+	 */
+	if (kvm_has_gmem_attributes) {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MMIO);
+		TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->mmio.len, sizeof(uint64_t));
+		TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
+	} else {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	}
 
 	kvm_vm_free(vm);
 }
@@ -88,6 +105,13 @@ static void test_private_access_memslot_not_private(void)
 	struct kvm_vcpu *vcpu;
 	uint32_t exit_reason;
 
+	/*
+	 * Accessing non-private memory as private with a software-protected VM
+	 * isn't possible when doing in-place conversions.
+	 */
+	if (kvm_has_gmem_attributes)
+		return;
+
 	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
 					   guest_repeatedly_read);
 
-- 
2.51.0.858.gf9c4a03a3a-goog


