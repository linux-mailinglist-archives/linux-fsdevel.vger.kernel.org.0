Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C165B9D57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIOOgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIOOfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:35:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E913241D07;
        Thu, 15 Sep 2022 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663252493; x=1694788493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0iTL7qFpKCg0CL7PXnYLUJ7HzbQvUn8wMbNEMyKZCps=;
  b=b29bq2og8/+2bGelFvoM0y93sPmBCGwvQCUWutwZYRTAA2wApEMMI2L4
   8J68goliQav0Spu1B1VKdfgD7iCKxj57K6/wE3oEDkPeB7GKswIWu4y8t
   zKDdg9DjvtelCh80rXwKzP7zO7LRxBeHFYZXdJO19CTucsedrokqpOQfD
   qCcSEP6O7mioF3ZmiXuJEOq2KAjzw3W/HJNPVX5R651ZWXHlaadqIFIUJ
   wW5anrtVb5v6u6x7umKJXaN5ATiDkqITuwwdpyAtbl742bOVHfaC7PpWZ
   N5LTo40TZ44otDKUA0K/aCBH2k6dv0l+CvsqxE6qhGIQQTSV/CdV3ShSG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299541057"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="299541057"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 07:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="945977174"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 07:34:42 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: [PATCH v8 5/8] KVM: Register/unregister the guest private memory regions
Date:   Thu, 15 Sep 2022 22:29:10 +0800
Message-Id: <20220915142913.2213336-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If CONFIG_HAVE_KVM_PRIVATE_MEM=y, userspace can register/unregister the
guest private memory regions through KVM_MEMORY_ENCRYPT_{UN,}REG_REGION
ioctls. The patch reuses existing SEV ioctl number but differs that the
address in the region for KVM_PRIVATE_MEM case is gpa while for SEV case
it's hva. Which usages should the ioctls go is determined by the newly
added kvm_arch_has_private_mem(). Architecture which supports
KVM_PRIVATE_MEM should override this function.

The current implementation defaults all memory to private. The shared
memory regions are stored in a xarray variable for memory efficiency and
zapping existing memory mappings is also a side effect of these two
ioctls when defined.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 Documentation/virt/kvm/api.rst  | 17 ++++++--
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu.h              |  2 -
 include/linux/kvm_host.h        | 13 ++++++
 virt/kvm/kvm_main.c             | 73 +++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1a6c003b2a0b..c0f800d04ffc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4715,10 +4715,19 @@ Documentation/virt/kvm/x86/amd-memory-encryption.rst.
 This ioctl can be used to register a guest memory region which may
 contain encrypted data (e.g. guest RAM, SMRAM etc).
 
-It is used in the SEV-enabled guest. When encryption is enabled, a guest
-memory region may contain encrypted data. The SEV memory encryption
-engine uses a tweak such that two identical plaintext pages, each at
-different locations will have differing ciphertexts. So swapping or
+Currently this ioctl supports registering memory regions for two usages:
+private memory and SEV-encrypted memory.
+
+When private memory is enabled, this ioctl is used to register guest private
+memory region and the addr/size of kvm_enc_region represents guest physical
+address (GPA). In this usage, this ioctl zaps the existing guest memory
+mappings in KVM that fallen into the region.
+
+When SEV-encrypted memory is enabled, this ioctl is used to register guest
+memory region which may contain encrypted data for a SEV-enabled guest. The
+addr/size of kvm_enc_region represents userspace address (HVA). The SEV
+memory encryption engine uses a tweak such that two identical plaintext pages,
+each at different locations will have differing ciphertexts. So swapping or
 moving ciphertext of those pages will not result in plaintext being
 swapped. So relocating (or migrating) physical backing pages for the SEV
 guest will require some additional steps.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2c96c43c313a..cfad6ba1a70a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -37,6 +37,7 @@
 #include <asm/hyperv-tlfs.h>
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
+#define __KVM_HAVE_ZAP_GFN_RANGE
 
 #define KVM_MAX_VCPUS 1024
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 6bdaacb6faa0..c94b620bf94b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -211,8 +211,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	return -(u32)fault & errcode;
 }
 
-void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
-
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_post_init_vm(struct kvm *kvm);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2125b50f6345..d65690cae80b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -260,6 +260,15 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
+#ifdef __KVM_HAVE_ZAP_GFN_RANGE
+void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
+#else
+static inline void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start
+						      gfn_t gfn_end)
+{
+}
+#endif
+
 enum {
 	OUTSIDE_GUEST_MODE,
 	IN_GUEST_MODE,
@@ -795,6 +804,9 @@ struct kvm {
 	struct notifier_block pm_notifier;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+	struct xarray mem_attr_array;
+#endif
 };
 
 #define kvm_err(fmt, ...) \
@@ -1454,6 +1466,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 int kvm_arch_create_vm_debugfs(struct kvm *kvm);
+bool kvm_arch_has_private_mem(struct kvm *kvm);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fa9dd2d2c001..de5cce8c82c7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -937,6 +937,47 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+#define KVM_MEM_ATTR_SHARED	0x0001
+static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
+				     bool is_private)
+{
+	gfn_t start, end;
+	unsigned long index;
+	void *entry;
+	int r;
+
+	if (size == 0 || gpa + size < gpa)
+		return -EINVAL;
+	if (gpa & (PAGE_SIZE - 1) || size & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	start = gpa >> PAGE_SHIFT;
+	end = (gpa + size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
+
+	/*
+	 * Guest memory defaults to private, kvm->mem_attr_array only stores
+	 * shared memory.
+	 */
+	entry = is_private ? NULL : xa_mk_value(KVM_MEM_ATTR_SHARED);
+
+	for (index = start; index < end; index++) {
+		r = xa_err(xa_store(&kvm->mem_attr_array, index, entry,
+				    GFP_KERNEL_ACCOUNT));
+		if (r)
+			goto err;
+	}
+
+	kvm_zap_gfn_range(kvm, start, end);
+
+	return r;
+err:
+	for (; index > start; index--)
+		xa_erase(&kvm->mem_attr_array, index);
+	return r;
+}
+#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
+
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
 				unsigned long state,
@@ -1165,6 +1206,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+	xa_init(&kvm->mem_attr_array);
+#endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
 	spin_lock_init(&kvm->gpc_lock);
@@ -1338,6 +1382,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
 		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
 	}
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+	xa_destroy(&kvm->mem_attr_array);
+#endif
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
 	kvm_arch_free_vm(kvm);
@@ -1541,6 +1588,11 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	}
 }
 
+bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
+{
+	return false;
+}
+
 static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
 {
 	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
@@ -4703,6 +4755,24 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
 		break;
 	}
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+	case KVM_MEMORY_ENCRYPT_REG_REGION:
+	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
+		struct kvm_enc_region region;
+		bool set = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
+
+		if (!kvm_arch_has_private_mem(kvm))
+			goto arch_vm_ioctl;
+
+		r = -EFAULT;
+		if (copy_from_user(&region, argp, sizeof(region)))
+			goto out;
+
+		r = kvm_vm_ioctl_set_mem_attr(kvm, region.addr,
+					      region.size, set);
+		break;
+	}
+#endif
 	case KVM_GET_DIRTY_LOG: {
 		struct kvm_dirty_log log;
 
@@ -4856,6 +4926,9 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_get_stats_fd(kvm);
 		break;
 	default:
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+arch_vm_ioctl:
+#endif
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
 out:
-- 
2.25.1

