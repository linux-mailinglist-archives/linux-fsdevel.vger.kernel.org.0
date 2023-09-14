Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A782D79F73D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjINCAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjINB7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:59:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4793AA2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c0c3ccd3d6so4000365ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656586; x=1695261386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yQPra1dQiB3SthC1x0t7SGlDkIN4vOXtCvjVK4W5apc=;
        b=TdMYbtuFLGzrg9+YhxzJTvOj/Bg4p2VNaAzd3I3qEOPE5gO/Tf07JdQStwpG7ufQ0L
         FShE8UrgqImO8b6MqtuI7k0aw8W1SvFDDmRqx2wvqCl31oqLexq3VGFfJhCwu87BND9T
         A376jl/pWr4/WoD3DrXDCcRZsgscbNXeIG7CbXXHInwEPhw2/ULsvkOBDhkhGszV6QWM
         9S7y1JtR4OQoCC4BskE2ncXU+M2CWBXHs6KmUlb8+dIFavtm6JYXnJCyg1JkpE3Ng/MY
         HGLgwkPYvQ1gLm+sjzgQBN0rnwlLXn12EKVuKLCwtV89+M4pYF2/3nE0s1jWvoQhmoQL
         v7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656586; x=1695261386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQPra1dQiB3SthC1x0t7SGlDkIN4vOXtCvjVK4W5apc=;
        b=F1u6WIY7SFlhPLag41YE1HgENe48lXlF87bnDrwSWiIOJJB2uIRva3UaDo1Y5E53iY
         8QtECcrXurWNCJZbTP+Afh09A5DxfIZEGK165UYkpdgoYR/IeOolYwegP/RpihYG0o6U
         66UEIGJTjoKonqlgEPqGAGOThNwOcJKdOggPQ4b7R8fNyWN4wm3jIgZoe/iW/7SiJvG8
         rMW3fKYeA14xbJuc8uC6qnpzhC9SJzNgCroIo0smeRqvK9BcJ81fittGT2jEjNagY0iC
         ZyCnRIGc58/tVpDeIu1veI+M+2elXdj+3QN8dL1un6tpaL3gOSZRzgPr9PqhHMkR6zFK
         nXxw==
X-Gm-Message-State: AOJu0YzrmO6f0d++qpb5meE5X7U6Mwfae2B9ehljd/NDKesFXuNIA4WI
        wyi8nccZxV99yEbn7dhR+5Nu2aQ964A=
X-Google-Smtp-Source: AGHT+IFAHhW5BZGO1uppfpot1pEr0aAhGs0ZmH0MKLDsA+afIocjRRcxvAD33MR5tv+EpN9UJvITdXcpd9o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da8e:b0:1c0:e87e:52b9 with SMTP id
 j14-20020a170902da8e00b001c0e87e52b9mr204011plx.12.1694656585587; Wed, 13 Sep
 2023 18:56:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:23 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-26-seanjc@google.com>
Subject: [RFC PATCH v12 25/33] KVM: selftests: Add helpers to convert guest
 memory b/w private and shared
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

From: Vishal Annapurve <vannapurve@google.com>

Add helpers to convert memory between private and shared via KVM's
memory attributes, as well as helpers to free/allocate guest_memfd memory
via fallocate().  Userspace, i.e. tests, is NOT required to do fallocate()
when converting memory, as the attributes are the single source of true.
The fallocate() helpers are provided so that tests can mimic a userspace
that frees private memory on conversion, e.g. to prioritize memory usage
over performance.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 48 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 ++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 47ea25f9dc97..a0315503ac3e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -333,6 +333,54 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
+					    uint64_t size, uint64_t attributes)
+{
+	struct kvm_memory_attributes attr = {
+		.attributes = attributes,
+		.address = gpa,
+		.size = size,
+		.flags = 0,
+	};
+
+	/*
+	 * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows
+	 * need significant enhancements to support multiple attributes.
+	 */
+	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
+		    "Update me to support multiple attributes!");
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+}
+
+
+static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
+				      uint64_t size)
+{
+	vm_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
+				     uint64_t size)
+{
+	vm_set_memory_attributes(vm, gpa, size, 0);
+}
+
+void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+			    bool punch_hole);
+
+static inline void vm_guest_mem_punch_hole(struct kvm_vm *vm, uint64_t gpa,
+					   uint64_t size)
+{
+	vm_guest_mem_fallocate(vm, gpa, size, true);
+}
+
+static inline void vm_guest_mem_allocate(struct kvm_vm *vm, uint64_t gpa,
+					 uint64_t size)
+{
+	vm_guest_mem_fallocate(vm, gpa, size, false);
+}
+
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
 const char *vm_guest_mode_string(uint32_t i);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 127f44c6c83c..bf2bd5c39a96 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1176,6 +1176,32 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
 	__vm_mem_region_delete(vm, memslot2region(vm, slot), true);
 }
 
+void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+			    bool punch_hole)
+{
+	struct userspace_mem_region *region;
+	uint64_t end = gpa + size - 1;
+	off_t fd_offset;
+	int mode, ret;
+
+	region = userspace_mem_region_find(vm, gpa, gpa);
+	TEST_ASSERT(region && region->region.flags & KVM_MEM_PRIVATE,
+		    "Private memory region not found for GPA 0x%lx", gpa);
+
+	TEST_ASSERT(region == userspace_mem_region_find(vm, end, end),
+		    "fallocate() for guest_memfd must act on a single memslot");
+
+	fd_offset = region->region.gmem_offset +
+		    (gpa - region->region.guest_phys_addr);
+
+	mode = FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_FL_PUNCH_HOLE : 0);
+
+	ret = fallocate(region->region.gmem_fd, mode, fd_offset, size);
+	TEST_ASSERT(!ret, "fallocate() failed to %s at %lx[%lu], fd = %d, mode = %x, offset = %lx\n",
+		     punch_hole ? "punch hole" : "allocate", gpa, size,
+		     region->region.gmem_fd, mode, fd_offset);
+}
+
 /* Returns the size of a vCPU's kvm_run structure. */
 static int vcpu_mmap_sz(void)
 {
-- 
2.42.0.283.g2d96d420d3-goog

