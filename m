Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5A758992
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGRXws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjGRXvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0C2D7C
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b895fa8929so32404775ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724152; x=1692316152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pGQ5gVRuMnBz+jdxpSwzxuVc9EOZlP96OVaeomtmpkk=;
        b=2IP+YPfxNvjiaW9VMbkPph4zWt8don45lFKbHWgoQYVJCSZxgSAoTrJwRk0xU3bSB/
         sJB5qD3FZVt8Ze6IV9hIaNYVvM6HbxMbldM07upaECnO4CedX1dugCNr5s9x/FmwtvtO
         si2av9K7pfZJ/7gTkPujf/XMubSer7Qe7Hk25O62UufmOcyJqVk+8eCPNK70zpezhYfY
         A9rO9H29+732lNEvb2WPSKb4tVXPWyzzY8EtOEkscIvFTwv6KnE4TjP9uoIgqNV/+oaA
         QzM/AXzRRDUz2a5t+BshOVSOVX+X2P43Bg9zMlMkd6w4tV0d4azrL5OFMA3XvIN7BoSE
         3brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724152; x=1692316152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGQ5gVRuMnBz+jdxpSwzxuVc9EOZlP96OVaeomtmpkk=;
        b=JA92+7Zsl0cWFOnSf5rnhA6Y4mmygvUB0kOIzC+ZK1tpiqDD1GvS82Jgyb9Bzzvh1j
         Naif8s419scj+k5NjpHIA3JanpbPD8G3lbPFnIhs96hvlR9fuZvO3PxFv4oT4bR32pvd
         l9XdU2ldWCeQBCXu8yxLP0cIWQpOMhHD1RyDh6bQ2FVUj654+So5QXmEhzssiyRxoY43
         sY6Fy1ILJL/bGoB7sAQlMFLUUEsx3r/ubZK71mGlPJNILeMWS60WEDYArvsixtJCQ7ge
         uXJRiBiJffy+kwh3O0NkCeSkykhKrR8v4ejp6/N+hj4VKcpbA1MqE/my5MMxiOTDllgB
         aQcg==
X-Gm-Message-State: ABy/qLYwczyD+7av9VxolVF8Tw7zrBewRrDzf83E/yB2UNvXeIGD9sVB
        /Nopag4h+NMcLhZQaaR/JxC0xI5VI6w=
X-Google-Smtp-Source: APBJJlGQidXExDXOvSIttpWwi+Oy77zoM8uyPE3vIg+QQ5r0vSYyBiY+n22aaCj4624S2+uneMtj6gNdfj0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e841:b0:1b5:2b14:5f2c with SMTP id
 t1-20020a170902e84100b001b52b145f2cmr6941plg.4.1689724152040; Tue, 18 Jul
 2023 16:49:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:45:04 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-22-seanjc@google.com>
Subject: [RFC PATCH v11 21/29] KVM: selftests: Add helpers to convert guest
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vishal Annapurve <vannapurve@google.com>

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 48 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 ++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index f1de6a279561..1819787b773b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -312,6 +312,54 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
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
index b93717e62325..1283e24b76f1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1171,6 +1171,32 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
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
2.41.0.255.g8b1d071c50-goog

