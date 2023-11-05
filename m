Return-Path: <linux-fsdevel+bounces-2025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4637E152A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF3B1C20BC0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE218E05;
	Sun,  5 Nov 2023 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT4jtxvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737E154B4
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:35:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729622D5B
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699202116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3cPw9fVJCr14nLNRz67sgxMTBasbZijMDuS/BBzhTY=;
	b=NT4jtxvXdcdUXKERd1fmTTRAa7DswFboQ9rmN9V3Ps6JLPy11JMCFn4rzr3MJtUnatesPh
	b9FEJQswOsOeYhjqMZGi0kI02piPuQlJ4ONmaeyXhhTSfIbKbRQiww2bE7ap2l4XVvsasb
	1lO8gp5XuUNzXQZqoMv7J8w22M75IpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-u2wPgqfeNgKSVK3J8tJjNw-1; Sun, 05 Nov 2023 11:35:12 -0500
X-MC-Unique: u2wPgqfeNgKSVK3J8tJjNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF79D80C344;
	Sun,  5 Nov 2023 16:35:10 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 101EF2166B26;
	Sun,  5 Nov 2023 16:35:03 +0000 (UTC)
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
Subject: [PATCH 34/34] KVM: selftests: Add a memory region subtest to validate invalid flags
Date: Sun,  5 Nov 2023 17:30:37 +0100
Message-ID: <20231105163040.14904-35-pbonzini@redhat.com>
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

Add a subtest to set_memory_region_test to verify that KVM rejects invalid
flags and combinations with -EINVAL.  KVM might or might not fail with
EINVAL anyways, but we can at least try.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20231031002049.3915752-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/kvm/set_memory_region_test.c    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 1891774eb6d4..343e807043e1 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -326,6 +326,53 @@ static void test_zero_memory_regions(void)
 }
 #endif /* __x86_64__ */
 
+static void test_invalid_memory_region_flags(void)
+{
+	uint32_t supported_flags = KVM_MEM_LOG_DIRTY_PAGES;
+	const uint32_t v2_only_flags = KVM_MEM_GUEST_MEMFD;
+	struct kvm_vm *vm;
+	int r, i;
+
+#ifdef __x86_64__
+	supported_flags |= KVM_MEM_READONLY;
+
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
+		vm = vm_create_barebones_protected_vm();
+	else
+#endif
+		vm = vm_create_barebones();
+
+	if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) & KVM_MEMORY_ATTRIBUTE_PRIVATE)
+		supported_flags |= KVM_MEM_GUEST_MEMFD;
+
+	for (i = 0; i < 32; i++) {
+		if ((supported_flags & BIT(i)) && !(v2_only_flags & BIT(i)))
+			continue;
+
+		r = __vm_set_user_memory_region(vm, MEM_REGION_SLOT, BIT(i),
+						MEM_REGION_GPA, MEM_REGION_SIZE, NULL);
+
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x%lx", BIT(i));
+
+		if (supported_flags & BIT(i))
+			continue;
+
+		r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, BIT(i),
+						 MEM_REGION_GPA, MEM_REGION_SIZE, NULL, 0, 0);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION2 should have failed on unsupported flag 0x%lx", BIT(i));
+	}
+
+	if (supported_flags & KVM_MEM_GUEST_MEMFD) {
+		r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT,
+						 KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_GUEST_MEMFD,
+						 MEM_REGION_GPA, MEM_REGION_SIZE, NULL, 0, 0);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION2 should have failed, dirty logging private memory is unsupported");
+	}
+}
+
 /*
  * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
  * tentative to add further slots should fail.
@@ -491,6 +538,8 @@ int main(int argc, char *argv[])
 	test_zero_memory_regions();
 #endif
 
+	test_invalid_memory_region_flags();
+
 	test_add_max_memory_regions();
 
 	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&
-- 
2.39.1



