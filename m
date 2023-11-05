Return-Path: <linux-fsdevel+bounces-2015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEFE7E150E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3083DB20EA4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FAA1D53E;
	Sun,  5 Nov 2023 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahemZGjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2F182D1
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:34:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A681BC
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699202039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpAyzch4SMhVm07huny7JwIkxifLeCPTk8Ue/HnXSEE=;
	b=ahemZGjnJfzdeo2/PwmFlfX/2btX6Fj7PukiDwO5fLBBHfkZg3DDsZ82W+dvA1N7HI69Px
	nM9JgTEF4SAIUX75RB3iro1JgqGrWSLYTMe/ubo/2PkIZThgogIMZeoXA4jUE6bfXIKZV5
	jG2ZfrimEBAf6y3cJO9fO6mD9pphdC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-od76qxppNEesJ1zoRU0obA-1; Sun, 05 Nov 2023 11:33:52 -0500
X-MC-Unique: od76qxppNEesJ1zoRU0obA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CEF2810FC1;
	Sun,  5 Nov 2023 16:33:50 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 626972166B26;
	Sun,  5 Nov 2023 16:33:43 +0000 (UTC)
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
Subject: [PATCH 23/34] KVM: selftests: Convert lib's mem regions to KVM_SET_USER_MEMORY_REGION2
Date: Sun,  5 Nov 2023 17:30:26 +0100
Message-ID: <20231105163040.14904-24-pbonzini@redhat.com>
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

Use KVM_SET_USER_MEMORY_REGION2 throughout KVM's selftests library so that
support for guest private memory can be added without needing an entirely
separate set of helpers.

Note, this obviously makes selftests backwards-incompatible with older KVM
versions from this point forward.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20231027182217.3615211-26-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 967eaaeacd75..9f144841c2ee 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -44,7 +44,7 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
 struct userspace_mem_region {
-	struct kvm_userspace_memory_region region;
+	struct kvm_userspace_memory_region2 region;
 	struct sparsebit *unused_phy_pages;
 	int fd;
 	off_t offset;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f09295d56c23..3676b37bea38 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -453,8 +453,9 @@ void kvm_vm_restart(struct kvm_vm *vmp)
 		vm_create_irqchip(vmp);
 
 	hash_for_each(vmp->regions.slot_hash, ctr, region, slot_node) {
-		int ret = ioctl(vmp->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
-		TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
+		int ret = ioctl(vmp->fd, KVM_SET_USER_MEMORY_REGION2, &region->region);
+
+		TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
 			    "  rc: %i errno: %i\n"
 			    "  slot: %u flags: 0x%x\n"
 			    "  guest_phys_addr: 0x%llx size: 0x%llx",
@@ -657,7 +658,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 	}
 
 	region->region.memory_size = 0;
-	vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
+	vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
 
 	sparsebit_free(&region->unused_phy_pages);
 	ret = munmap(region->mmap_start, region->mmap_size);
@@ -1014,8 +1015,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->region.guest_phys_addr = guest_paddr;
 	region->region.memory_size = npages * vm->page_size;
 	region->region.userspace_addr = (uintptr_t) region->host_mem;
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
-	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
+	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
 		"  guest_phys_addr: 0x%lx size: 0x%lx",
@@ -1097,9 +1098,9 @@ void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags)
 
 	region->region.flags = flags;
 
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
 
-	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
+	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
 		"  rc: %i errno: %i slot: %u flags: 0x%x",
 		ret, errno, slot, flags);
 }
@@ -1127,9 +1128,9 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa)
 
 	region->region.guest_phys_addr = new_gpa;
 
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
 
-	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION failed\n"
+	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed\n"
 		    "ret: %i errno: %i slot: %u new_gpa: 0x%lx",
 		    ret, errno, slot, new_gpa);
 }
-- 
2.39.1



