Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950675893A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGRXtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGRXtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:49:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8641BDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c850943cf9aso5385920276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724121; x=1692316121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Egm/XxJ8ddWbI/DaWjAWd8f37iIZoXJS+wUVmFcRAns=;
        b=jmuY9roKZMyFhtYvPEoDziDnCcR7JdYNk6MHm5cFsWzUI97GEXVLYK1GdjIllbAuc8
         4ySkYVESTYqTzNduR8YSId27LdhHiTgoO/QliIr5NJBmEYoJ3hqAD7mwOWzvFkUx4Bii
         goVBiLBONUuy9TatGLx00I5NjhWHSEHqUSiN1WkdO1FULfalsZjiiUrIy35lsmGM8gg5
         0R9io78Au8wj9A4RGlGH7FDc+jn67CVyDvAeFJPAeD6X9/PbcbAdX5be8ZMA4OH8wO2X
         REDfKC9pVZc7WTJWTP+0UyFThTKKDkHpI7he51JmdU9wLJq3gXsen7d9rft5gMUHTkyh
         wERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724121; x=1692316121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egm/XxJ8ddWbI/DaWjAWd8f37iIZoXJS+wUVmFcRAns=;
        b=Ws/P3j0JVb8paY+Lcn+aJpgvF4h6XbBW1RLMrjSx3zH6IT5wD9LXKIG5q68U1QvlTV
         n1nBWDFHlBA9QY8Pdf+DDYeQPr0ytxH6p6M0o4VbIg6iZNakXA7zyNLSarJm3QdRyCkz
         1kn0vuCkAsLu3+rHl8xcTCIw7HbPn52OCW5WRbF7ebszjN1sibvJeJRyLCi8GTHXy+Tc
         BWx6fr/Ow5l7BTNCV0TljcVxr/ml1WDw+/vOSPUmmDQ2PjbPoagrVCAjV8mKAVkLyT/Q
         /hcP+QlCSPRrAwa2DYVydS0AFmHdFS1sif3som85QcjVeHB9gUQvq37BSWLEV0e/YCPE
         NYBg==
X-Gm-Message-State: ABy/qLa8jg99HhK35plTgAKRO1UG/F89Pu4TTV34X4BK8+gjgy0NHjI2
        FPeAOq3RQ+oaES/EKTaA51/pXkasfGM=
X-Google-Smtp-Source: APBJJlFh2D+dQAa/XLO1xU2e6kFsryQ3DCD95rOJdVXmpZcOUWfUGVGQg2QmRxbQ3p6/rJNCJuKy9Jt0/xg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1005:b0:c5d:2623:560e with SMTP id
 w5-20020a056902100500b00c5d2623560emr14047ybt.12.1689724121300; Tue, 18 Jul
 2023 16:48:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:48 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-6-seanjc@google.com>
Subject: [RFC PATCH v11 05/29] KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to CONFIG_KVM_GENERIC_MMU_NOTIFIER
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h   |  2 --
 arch/arm64/kvm/Kconfig              |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 --
 arch/mips/kvm/Kconfig               |  2 +-
 arch/powerpc/include/asm/kvm_host.h |  2 --
 arch/powerpc/kvm/Kconfig            |  8 ++++----
 arch/powerpc/kvm/powerpc.c          |  4 +---
 arch/riscv/include/asm/kvm_host.h   |  2 --
 arch/riscv/kvm/Kconfig              |  2 +-
 arch/x86/include/asm/kvm_host.h     |  2 --
 arch/x86/kvm/Kconfig                |  2 +-
 include/linux/kvm_host.h            |  8 +++++---
 virt/kvm/Kconfig                    |  4 ++++
 virt/kvm/kvm_main.c                 | 10 +++++-----
 14 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8b6096753740..50d89d400bf1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -912,8 +912,6 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index f531da6b362e..a650b46f4f2f 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -22,7 +22,7 @@ menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 04cedf9f8811..22a41d941bf3 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -810,8 +810,6 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn);
 pgd_t *kvm_pgd_alloc(void);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 /* Emulation */
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
 int kvm_get_badinstr(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index a8cdba75f98d..c04987d2ed2e 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -25,7 +25,7 @@ config KVM
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_MMIO
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select INTERVAL_TREE
 	select KVM_GENERIC_HARDWARE_ENABLING
 	help
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 14ee0dece853..4b5c3f2acf78 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -62,8 +62,6 @@
 
 #include <linux/mmu_notifier.h>
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 #define HPTEG_CACHE_NUM			(1 << 15)
 #define HPTEG_HASH_BITS_PTE		13
 #define HPTEG_HASH_BITS_PTE_LONG	12
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 902611954200..b33358ee6424 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -42,7 +42,7 @@ config KVM_BOOK3S_64_HANDLER
 config KVM_BOOK3S_PR_POSSIBLE
 	bool
 	select KVM_MMIO
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 
 config KVM_BOOK3S_HV_POSSIBLE
 	bool
@@ -85,7 +85,7 @@ config KVM_BOOK3S_64_HV
 	tristate "KVM for POWER7 and later using hypervisor mode in host"
 	depends on KVM_BOOK3S_64 && PPC_POWERNV
 	select KVM_BOOK3S_HV_POSSIBLE
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select CMA
 	help
 	  Support running unmodified book3s_64 guest kernels in
@@ -194,7 +194,7 @@ config KVM_E500V2
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
 	select KVM_MMIO
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	help
 	  Support running unmodified E500 guest kernels in virtual machines on
 	  E500v2 host processors.
@@ -211,7 +211,7 @@ config KVM_E500MC
 	select KVM
 	select KVM_MMIO
 	select KVM_BOOKE_HV
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	help
 	  Support running unmodified E500MC/E5500/E6500 guest kernels in
 	  virtual machines on E500MC/E5500/E6500 host processors.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 5cf9e5e3112a..f97fbac7eac9 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -635,9 +635,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 		r = hv_enabled;
 #else
-#ifndef KVM_ARCH_WANT_MMU_NOTIFIER
-		BUILD_BUG();
-#endif
+		BUILD_BUG_ON(!IS_ENABLED(CONFIG_KVM_GENERIC_MMU_NOTIFIER));
 		r = 1;
 #endif
 		break;
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 2d8ee53b66c7..6ddaf0b9278c 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -249,8 +249,6 @@ struct kvm_vcpu_arch {
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 #define KVM_RISCV_GSTAGE_TLB_MIN_ORDER		12
 
 void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index dfc237d7875b..ae2e05f050ec 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -30,7 +30,7 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
 	select KVM_XFER_TO_GUEST_WORK
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	help
 	  Support hosting virtualized guest machines.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 28bd38303d70..f9a927296d85 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2110,8 +2110,6 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_cpu_has_extint(struct kvm_vcpu *v);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 89ca7f4c1464..a7eb2bdbfb18 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -24,7 +24,7 @@ config KVM
 	depends on HIGH_RES_TIMERS
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_IRQFD
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 90a0be261a5c..d2d3e083ec7f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -255,7 +255,9 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+struct kvm_gfn_range;
+
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -784,7 +786,7 @@ struct kvm {
 	struct hlist_head irq_ack_notifier_list;
 #endif
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
@@ -1916,7 +1918,7 @@ extern const struct _kvm_stats_desc kvm_vm_stats_desc[];
 extern const struct kvm_stats_header kvm_vcpu_stats_header;
 extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 {
 	if (unlikely(kvm->mmu_invalidate_in_progress))
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index b74916de5183..2fa11bd26cfc 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -95,3 +95,7 @@ config HAVE_KVM_PM_NOTIFIER
 
 config KVM_GENERIC_HARDWARE_ENABLING
        bool
+
+config KVM_GENERIC_MMU_NOTIFIER
+       select MMU_NOTIFIER
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8101b11a13ba..53346bc2902a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -510,7 +510,7 @@ void kvm_destroy_vcpus(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 {
 	return container_of(mn, struct kvm, mmu_notifier);
@@ -938,14 +938,14 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
 }
 
-#else  /* !(CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER) */
+#else  /* !CONFIG_KVM_GENERIC_MMU_NOTIFIER */
 
 static int kvm_init_mmu_notifier(struct kvm *kvm)
 {
 	return 0;
 }
 
-#endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
+#endif /* CONFIG_KVM_GENERIC_MMU_NOTIFIER */
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
@@ -1265,7 +1265,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_debugfs:
 	kvm_coalesced_mmio_free(kvm);
 out_no_coalesced_mmio:
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	if (kvm->mmu_notifier.ops)
 		mmu_notifier_unregister(&kvm->mmu_notifier, current->mm);
 #endif
@@ -1325,7 +1325,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->buses[i] = NULL;
 	}
 	kvm_coalesced_mmio_free(kvm);
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
 	/*
 	 * At this point, pending calls to invalidate_range_start()
-- 
2.41.0.255.g8b1d071c50-goog

