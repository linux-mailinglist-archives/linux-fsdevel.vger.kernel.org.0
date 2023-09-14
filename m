Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7579F761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjINCBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjINCAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:00:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDDD3C21
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so554655276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656596; x=1695261396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SX/tmvtGQjfAKzRzM0R+P9Auz7l4k5LFyR/Je4f49mI=;
        b=PRgJ6YpHOaKVRlDoPySlO4aMKExyWpve/MqaWc1CCOHhwAK0eqqhATR61Oe0RNK+YU
         MgOf6j6hpXZEWpcV8brQDxyFuBHdcrosapbTD8gpNHpkexGuLmbiq1TSE22Y5XCALogQ
         QEtACQ8T2JJEGAayr6fo4KY7QPtQVtjduRe6uYIpaL98j081/m92F5sNeOfBWRIvuGUE
         A2Hj1en+NZQi3tSjBx12qgSQ6u2e1E7YvA/JjVvrXWnR28OIGmTfodjFIBatTzHuicgh
         pnk7gc9GggmnLF6NAbccKKO13inqy/WkXtuuVHVrvYKey4LTYnH2CF9o8o0fTl8FxRGJ
         QnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656596; x=1695261396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX/tmvtGQjfAKzRzM0R+P9Auz7l4k5LFyR/Je4f49mI=;
        b=UW4+ihKFcUDANaolMib5hSwrQ56iaqJACf2u/67phS5O/MZjwQjYn2trb5y7cuQ20v
         kcEs5LHeQYasoEOMiLZo0wa3eG1CzAZx9pOmP1Jpm8VNyJNVsM1mwXN217nw8eXov7yq
         Ji4G6Kd3j4STVdJYhsTCLaymLl4IZxLyaFROL0v6DAC3lup5Jh1xQvczJ1Iu20KIjV89
         U0LZAfKvbJ1+z1uUEaRw8FiOf5CO5XsIHYo7sXt2VQE8s+9zuT+PBOOT38TIOSfWeiZj
         b1T7ADBiNdD1NxIU+/Zfvqny/QeoC7Ptq1hVne8t1mFV9gl4EldhKEPVA+Ec6idSCg1V
         vPkg==
X-Gm-Message-State: AOJu0YykgJQvVNC4uRzZUZwNXxyyhQ2G6Ry5TFJx6o5Av3Oo+FNwBWl/
        50unoNb3kRaRE3bv/+nz3EFzl/VVwVk=
X-Google-Smtp-Source: AGHT+IHERRdQQcWN7mkCNgIgj9nlxuSe44izkSe/zW2QZGFwDrBBBoEw/nSNmj2b/8hHFzwPazIBLLDdPVQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:905:b0:d64:f7ec:6d5d with SMTP id
 bu5-20020a056902090500b00d64f7ec6d5dmr96462ybb.10.1694656596047; Wed, 13 Sep
 2023 18:56:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:28 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-31-seanjc@google.com>
Subject: [RFC PATCH v12 30/33] KVM: selftests: Add KVM_SET_USER_MEMORY_REGION2 helper
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Add helpers to invoke KVM_SET_USER_MEMORY_REGION2 directly so that tests
can validate of features that are unique to "version 2" of "set user
memory region", e.g. do negative testing on gmem_fd and gmem_offset.

Provide a raw version as well as an assert-success version to reduce
the amount of boilerplate code need for basic usage.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  7 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index b608fbb832d5..edc0f380acc0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -522,6 +522,13 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 			       uint64_t gpa, uint64_t size, void *hva);
 int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				uint64_t gpa, uint64_t size, void *hva);
+void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				uint32_t flags, uint64_t gpa, uint64_t size,
+				void *hva, uint32_t gmem_fd, uint64_t gmem_offset);
+int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				 uint32_t flags, uint64_t gpa, uint64_t size,
+				 void *hva, uint32_t gmem_fd, uint64_t gmem_offset);
+
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	enum vm_mem_backing_src_type src_type,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 68afea10b469..8fc70c021c1c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -873,6 +873,35 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 		    errno, strerror(errno));
 }
 
+int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				 uint32_t flags, uint64_t gpa, uint64_t size,
+				 void *hva, uint32_t gmem_fd, uint64_t gmem_offset)
+{
+	struct kvm_userspace_memory_region2 region = {
+		.slot = slot,
+		.flags = flags,
+		.guest_phys_addr = gpa,
+		.memory_size = size,
+		.userspace_addr = (uintptr_t)hva,
+		.gmem_fd = gmem_fd,
+		.gmem_offset = gmem_offset,
+	};
+
+	return ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION2, &region);
+}
+
+void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				uint32_t flags, uint64_t gpa, uint64_t size,
+				void *hva, uint32_t gmem_fd, uint64_t gmem_offset)
+{
+	int ret = __vm_set_user_memory_region2(vm, slot, flags, gpa, size, hva,
+					       gmem_fd, gmem_offset);
+
+	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno = %d (%s)",
+		    errno, strerror(errno));
+}
+
+
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-- 
2.42.0.283.g2d96d420d3-goog

