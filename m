Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D123D79F737
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjINCAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjINB7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:59:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389843A93
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:24 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26d3d868529so480975a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656584; x=1695261384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OxMDE800j4aiJ8tPuJinoyPTmv5S2+AxjnM5iapuS4E=;
        b=FucLK6jgThnbThqsRQE/A82cSy07H0MKukXuQwYUqhMUFFr3G8UzGD19mx4JChbjok
         r7Tmq9UT4AtW9IYWyqZxv0q7vOZaQYn4o153d9QQ11h8UxRM3+bPnYiSD9MvDEiEdli/
         ICtSTjQWe4jiBIbhAZ6yJzhaUL3KPRlWPxy97+8cT+3kKkn6vzudDpNuEJFqD/BhD5Hq
         88klEM0+EF7Od0556pB2azdKsQPy0laRLuQbNf4IC0evPLn19tVPY0eCrr1/Reii2fNe
         LVsp6eIYvn74bmVopCMYaM4/mnKMKXubDYqVH0XK6hS1+kXCaRoQ3oHFxnm/jouJW7WK
         Y68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656584; x=1695261384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxMDE800j4aiJ8tPuJinoyPTmv5S2+AxjnM5iapuS4E=;
        b=cWcsl2/S3RkutsYtU23NVSKg5UCNWY6gxzfpVZtIU+2Ke8X9158Urpr5yawpXIJ22D
         Yz6Vvw6OYPXM2qrKpyZLdYXXkCcGVUkdg6KFrQ8U4HWe+5313i66IcmkF18L8a68MTT2
         ZTcYEzpwhIL2IIQbpfnbEOWrYb3FdJ2rwpAidZC5TJgCvnfUDHxcfxsKsCca3DopPr6I
         CaedrzDo1rKb3k3LS437aXm83FJgJXnsV0GI5mSUe2Up9yX2KGpxE2LW3IF4bNw9A7oQ
         dbEUuTyXBj+Wcj19jfy/m4wDxFFzizK681uAUAYyu8GRhJQdZ61JKzTSLDlJ70XPhxrf
         VsYQ==
X-Gm-Message-State: AOJu0YxuED5eb9rws5afkeu8LkuyVJV1uq3GWymAYOZIKh791DiUIKxL
        AUEqx9D+GTsv+QVRdQLYPJAay5Iexxs=
X-Google-Smtp-Source: AGHT+IHrJ+akemSkjusv3tsEKJ81jQid3VaDO1GbVbcTPU4KobK5t8Z1M2fJ9kpEYdnobHHBOeyWBEN2WZU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50b:b0:1c3:29c4:c4e8 with SMTP id
 b11-20020a170902d50b00b001c329c4c4e8mr224068plg.4.1694656583660; Wed, 13 Sep
 2023 18:56:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:22 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-25-seanjc@google.com>
Subject: [RFC PATCH v12 24/33] KVM: selftests: Add support for creating
 private memslots
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for creating "private" memslots via KVM_CREATE_GUEST_MEMFD and
KVM_SET_USER_MEMORY_REGION2.  Make vm_userspace_mem_region_add() a wrapper
to its effective replacement, vm_mem_add(), so that private memslots are
fully opt-in, i.e. don't require update all tests that add memory regions.

Pivot on the KVM_MEM_PRIVATE flag instead of the validity of the "gmem"
file descriptor so that simple tests can let vm_mem_add() do the heavy
lifting of creating the guest memfd, but also allow the caller to pass in
an explicit fd+offset so that fancier tests can do things like back
multiple memslots with a single file.  If the caller passes in a fd, dup()
the fd so that (a) __vm_mem_region_delete() can close the fd associated
with the memory region without needing yet another flag, and (b) so that
the caller can safely close its copy of the fd without having to first
destroy memslots.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 23 +++++
 .../testing/selftests/kvm/include/test_util.h |  5 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 85 ++++++++++++-------
 3 files changed, 82 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9f144841c2ee..47ea25f9dc97 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -431,6 +431,26 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 
 void vm_create_irqchip(struct kvm_vm *vm);
 
+static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
+					uint64_t flags)
+{
+	struct kvm_create_guest_memfd gmem = {
+		.size = size,
+		.flags = flags,
+	};
+
+	return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &gmem);
+}
+
+static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
+					uint64_t flags)
+{
+	int fd = __vm_create_guest_memfd(vm, size, flags);
+
+	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd));
+	return fd;
+}
+
 void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 			       uint64_t gpa, uint64_t size, void *hva);
 int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
@@ -439,6 +459,9 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	enum vm_mem_backing_src_type src_type,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
 	uint32_t flags);
+void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
+		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+		uint32_t flags, int gmem_fd, uint64_t gmem_offset);
 
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 7e614adc6cf4..7257f2243ab9 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -142,6 +142,11 @@ static inline bool backing_src_is_shared(enum vm_mem_backing_src_type t)
 	return vm_mem_backing_src_alias(t)->flag & MAP_SHARED;
 }
 
+static inline bool backing_src_can_be_huge(enum vm_mem_backing_src_type t)
+{
+	return t != VM_MEM_SRC_ANONYMOUS && t != VM_MEM_SRC_SHMEM;
+}
+
 /* Aligns x up to the next multiple of size. Size must be a power of 2. */
 static inline uint64_t align_up(uint64_t x, uint64_t size)
 {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3676b37bea38..127f44c6c83c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -669,6 +669,8 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 		TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
 		close(region->fd);
 	}
+	if (region->region.gmem_fd >= 0)
+		close(region->region.gmem_fd);
 
 	free(region);
 }
@@ -870,36 +872,15 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 		    errno, strerror(errno));
 }
 
-/*
- * VM Userspace Memory Region Add
- *
- * Input Args:
- *   vm - Virtual Machine
- *   src_type - Storage source for this region.
- *              NULL to use anonymous memory.
- *   guest_paddr - Starting guest physical address
- *   slot - KVM region slot
- *   npages - Number of physical pages
- *   flags - KVM memory region flags (e.g. KVM_MEM_LOG_DIRTY_PAGES)
- *
- * Output Args: None
- *
- * Return: None
- *
- * Allocates a memory area of the number of pages specified by npages
- * and maps it to the VM specified by vm, at a starting physical address
- * given by guest_paddr.  The region is created with a KVM region slot
- * given by slot, which must be unique and < KVM_MEM_SLOTS_NUM.  The
- * region is created with the flags given by flags.
- */
-void vm_userspace_mem_region_add(struct kvm_vm *vm,
-	enum vm_mem_backing_src_type src_type,
-	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-	uint32_t flags)
+/* FIXME: This thing needs to be ripped apart and rewritten. */
+void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
+		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+		uint32_t flags, int gmem_fd, uint64_t gmem_offset)
 {
 	int ret;
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
+	size_t mem_size = npages * vm->page_size;
 	size_t alignment;
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
@@ -952,7 +933,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	/* Allocate and initialize new mem region structure. */
 	region = calloc(1, sizeof(*region));
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = npages * vm->page_size;
+	region->mmap_size = mem_size;
 
 #ifdef __s390x__
 	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
@@ -999,14 +980,47 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	/* As needed perform madvise */
 	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
 	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
-		ret = madvise(region->host_mem, npages * vm->page_size,
+		ret = madvise(region->host_mem, mem_size,
 			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
 		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
-			    region->host_mem, npages * vm->page_size,
+			    region->host_mem, mem_size,
 			    vm_mem_backing_src_alias(src_type)->name);
 	}
 
 	region->backing_src_type = src_type;
+
+	if (flags & KVM_MEM_PRIVATE) {
+		if (gmem_fd < 0) {
+			uint32_t gmem_flags = 0;
+
+			/*
+			 * Allow hugepages for the guest memfd backing if the
+			 * "normal" backing is allowed/required to be huge.
+			 */
+			if (src_type != VM_MEM_SRC_ANONYMOUS &&
+			    src_type != VM_MEM_SRC_SHMEM)
+				gmem_flags |= KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+
+			TEST_ASSERT(!gmem_offset,
+				    "Offset must be zero when creating new guest_memfd");
+			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
+		} else {
+			/*
+			 * Install a unique fd for each memslot so that the fd
+			 * can be closed when the region is deleted without
+			 * needing to track if the fd is owned by the framework
+			 * or by the caller.
+			 */
+			gmem_fd = dup(gmem_fd);
+			TEST_ASSERT(gmem_fd >= 0, __KVM_SYSCALL_ERROR("dup()", gmem_fd));
+		}
+
+		region->region.gmem_fd = gmem_fd;
+		region->region.gmem_offset = gmem_offset;
+	} else {
+		region->region.gmem_fd = -1;
+	}
+
 	region->unused_phy_pages = sparsebit_alloc();
 	sparsebit_set_num(region->unused_phy_pages,
 		guest_paddr >> vm->page_shift, npages);
@@ -1019,9 +1033,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
-		"  guest_phys_addr: 0x%lx size: 0x%lx",
+		"  guest_phys_addr: 0x%lx size: 0x%lx guest_memfd: %d\n",
 		ret, errno, slot, flags,
-		guest_paddr, (uint64_t) region->region.memory_size);
+		guest_paddr, (uint64_t) region->region.memory_size,
+		region->region.gmem_fd);
 
 	/* Add to quick lookup data structures */
 	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
@@ -1042,6 +1057,14 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	}
 }
 
+void vm_userspace_mem_region_add(struct kvm_vm *vm,
+				 enum vm_mem_backing_src_type src_type,
+				 uint64_t guest_paddr, uint32_t slot,
+				 uint64_t npages, uint32_t flags)
+{
+	vm_mem_add(vm, src_type, guest_paddr, slot, npages, flags, -1, 0);
+}
+
 /*
  * Memslot to region
  *
-- 
2.42.0.283.g2d96d420d3-goog

