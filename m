Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D640479F6D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjINB5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjINB4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:56:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E4212E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b56dab74bso6570397b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656548; x=1695261348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BhxGep0GRUEwAUAzFvnYRN6yWfiwAK/IRlQcI8pBhpQ=;
        b=e7/6zTFxm8G6xsrAvZUmuDMpnu0BLzpds/1OX8d4vOfYN1DtxBqxwcLOZgHTRIQ/5X
         90pY50iRRJMPwt6alQ5c9vbGFWvGEs4UstLm/cnngn3dD/2KkPueVpTksfVdhYyZhVez
         rDns+Y18pY5OeaYFp0OOk8gPpHOSWm0uElTUebYOKIfBOO+1VilLrSTtn5MGxGBQ+Xne
         gpnqCnn2qCV5Tbl84pluofhKAOLLQGhrI12t8rk3OukGL+dOs2DCj3VxBJhKn142tEUC
         CjTDvqTqQusNrnCMWrRrOGXke/MJ8rN1Bi/ukZCelJvnjzCZV8PrJboUUmOB6cEVmFSC
         hdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656548; x=1695261348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhxGep0GRUEwAUAzFvnYRN6yWfiwAK/IRlQcI8pBhpQ=;
        b=HaHCBqa3ZPd2dIfWh7Zt1L4sbtPLPNz4myHb0uCRbi2/sHhwa/J8Bx6DQ6ZercETMI
         o+OS3VUDPV/DbP75QOh8CHKg3f+kzgUMqBGIQKDwtgki6IZA1+lnCSo33TMfbqk3NlIa
         OCm6hdosvVBA9Bz6RCrslgKuwxUd0nauFF7GpHiCN2NIR6LerZFWnGY46iSP0lFHRM7p
         4BIb+8XPG16/ctkqjmBtGzum76gjM29/C239csTgJzUApY4+x+ba118n+cZIx+Ybuh5G
         6OIcwv9LEMT36yBBCncywYf22+BruQ7sh/Bylp3S79wevok7n8ERE4ad7NdCa+skeh5Y
         8Krw==
X-Gm-Message-State: AOJu0YzzAQOTTJx3WuGJ1eJPIy0Hda6Bpj/vGEtShspTJFgSvw8q30j8
        m68sOaHc5Ri2rqUDh5DtVJRX0HkAznQ=
X-Google-Smtp-Source: AGHT+IFIu1rjOq9FW+JbDj5fY4BKSa/epsGGWccSSMIHRlmCarPy2ezJLxiJZod49VfvzwgQV9RD5huQPI8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4207:0:b0:d81:536d:2978 with SMTP id
 p7-20020a254207000000b00d81536d2978mr74175yba.2.1694656548405; Wed, 13 Sep
 2023 18:55:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:04 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-7-seanjc@google.com>
Subject: [RFC PATCH v12 06/33] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
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

Introduce a "version 2" of KVM_SET_USER_MEMORY_REGION so that additional
information can be supplied without setting userspace up to fail.  The
padding in the new kvm_userspace_memory_region2 structure will be used to
pass a file descriptor in addition to the userspace_addr, i.e. allow
userspace to point at a file descriptor and map memory into a guest that
is NOT mapped into host userspace.

Alternatively, KVM could simply add "struct kvm_userspace_memory_region2"
without a new ioctl(), but as Paolo pointed out, adding a new ioctl()
makes detection of bad flags a bit more robust, e.g. if the new fd field
is guarded only by a flag and not a new ioctl(), then a userspace bug
(setting a "bad" flag) would generate out-of-bounds access instead of an
-EINVAL error.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c       |  2 +-
 include/linux/kvm_host.h |  4 ++--
 include/uapi/linux/kvm.h | 13 +++++++++++++
 virt/kvm/kvm_main.c      | 38 ++++++++++++++++++++++++++++++--------
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c9c81e82e65..8356907079e1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12447,7 +12447,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		struct kvm_userspace_memory_region m;
+		struct kvm_userspace_memory_region2 m;
 
 		m.slot = id | (i << 16);
 		m.flags = 0;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5faba69403ac..4e741ff27af3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1146,9 +1146,9 @@ enum kvm_mr_change {
 };
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem);
+			  const struct kvm_userspace_memory_region2 *mem);
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem);
+			    const struct kvm_userspace_memory_region2 *mem);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 13065dd96132..bd1abe067f28 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -95,6 +95,16 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+/* for KVM_SET_USER_MEMORY_REGION2 */
+struct kvm_userspace_memory_region2 {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+	__u64 pad[16];
+};
+
 /*
  * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
  * userspace, other bits are reserved for kvm internal use which are defined
@@ -1192,6 +1202,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_COUNTER_OFFSET 227
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
+#define KVM_CAP_USER_MEMORY2 230
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1473,6 +1484,8 @@ struct kvm_vfio_spapr_tce {
 					struct kvm_userspace_memory_region)
 #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
 #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
+#define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
+					 struct kvm_userspace_memory_region2)
 
 /* enable ucontrol for s390 */
 struct kvm_s390_ucas_mapping {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8d21757cd5e9..7c0e38752526 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1571,7 +1571,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	}
 }
 
-static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
+static int check_memory_region_flags(const struct kvm_userspace_memory_region2 *mem)
 {
 	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
 
@@ -1973,7 +1973,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
  * Must be called holding kvm->slots_lock for write.
  */
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem)
+			    const struct kvm_userspace_memory_region2 *mem)
 {
 	struct kvm_memory_slot *old, *new;
 	struct kvm_memslots *slots;
@@ -2077,7 +2077,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem)
+			  const struct kvm_userspace_memory_region2 *mem)
 {
 	int r;
 
@@ -2089,7 +2089,7 @@ int kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
-					  struct kvm_userspace_memory_region *mem)
+					  struct kvm_userspace_memory_region2 *mem)
 {
 	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
@@ -4559,6 +4559,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 {
 	switch (arg) {
 	case KVM_CAP_USER_MEMORY:
+	case KVM_CAP_USER_MEMORY2:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
 	case KVM_CAP_INTERNAL_ERROR_DATA:
@@ -4814,6 +4815,14 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 	return fd;
 }
 
+#define SANITY_CHECK_MEM_REGION_FIELD(field)					\
+do {										\
+	BUILD_BUG_ON(offsetof(struct kvm_userspace_memory_region, field) !=		\
+		     offsetof(struct kvm_userspace_memory_region2, field));	\
+	BUILD_BUG_ON(sizeof_field(struct kvm_userspace_memory_region, field) !=		\
+		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
+} while (0)
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4836,15 +4845,28 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
 		break;
 	}
+	case KVM_SET_USER_MEMORY_REGION2:
 	case KVM_SET_USER_MEMORY_REGION: {
-		struct kvm_userspace_memory_region kvm_userspace_mem;
+		struct kvm_userspace_memory_region2 mem;
+		unsigned long size;
+
+		if (ioctl == KVM_SET_USER_MEMORY_REGION)
+			size = sizeof(struct kvm_userspace_memory_region);
+		else
+			size = sizeof(struct kvm_userspace_memory_region2);
+
+		/* Ensure the common parts of the two structs are identical. */
+		SANITY_CHECK_MEM_REGION_FIELD(slot);
+		SANITY_CHECK_MEM_REGION_FIELD(flags);
+		SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
+		SANITY_CHECK_MEM_REGION_FIELD(memory_size);
+		SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
 
 		r = -EFAULT;
-		if (copy_from_user(&kvm_userspace_mem, argp,
-						sizeof(kvm_userspace_mem)))
+		if (copy_from_user(&mem, argp, size))
 			goto out;
 
-		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
+		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
 		break;
 	}
 	case KVM_GET_DIRTY_LOG: {
-- 
2.42.0.283.g2d96d420d3-goog

