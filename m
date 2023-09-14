Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F779F6EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjINB5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjINB4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:56:18 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4C268E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:58 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c40ac5b6e7so2355125ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656558; x=1695261358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yIE8nMi3JnNDmDb0GBSv5tarA9FMsQImAxg8v1w+0oc=;
        b=MnXZmeiUieKXNzRCfa6asiQizyToKdvTomM905O5rfpO2C1lyz3o6XgaJ4Qi0v6nmK
         s6lN+W35naCc6GKn5MROgw44d0MnkQlJCU6HjqQKro3/SnweeeRGi03tZO279psS0YN6
         g1TLEvhnFuLURt3mMBmGwXVqP9xwH7d8CINEMOWyDJ+vF/wkNwsemgHzQYIttE631dKM
         ey2UX6hSJ8pfSbsZydluGE/hlhkZZqLBdKEwcjBHn1xSQ8FsgKOV7wltX5Mfw3eUxO+T
         MQGc3oPINlsw9pO5euCmDG7jQ42ka/0DiHXAKhbn189AXC86SNGQgEYi5keTtevStUkG
         F29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656558; x=1695261358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIE8nMi3JnNDmDb0GBSv5tarA9FMsQImAxg8v1w+0oc=;
        b=fTS4nnOWIOAxfbp1bHxTYwkReQOzHzLSuc/aDYMngapvz8E/sKeqpbU2erR6XodkZR
         vwI6mKe1qMLtfNCjDd2mV+9Q4xiphx7womBB6UdFo5aR4LZ8IwQG6uYeVDzyxue0uYUT
         pD9dhlApfUF2VuqIBdJmEYgja8tIKfUdsjO9jlF1vGot/gMqQBfKtewHMSvLPZXe8yyC
         Esi2Rf4QxAox0OaSbzrmTyLxon/HO6ZIJ7XVuUhkGHVKgONxj5869tq8gtukvxAHo1kc
         vt4YfKwqmk9nnbEJp1YFzK8Y8XTyzX4osPejALz9D9ITGOQPW+RXjbQZyMCblkqTXK+v
         4NcQ==
X-Gm-Message-State: AOJu0Yygfy7vHdvXhkcH/mdYxMI8A2IVvFlQoSH/5959+0jScLGW6JeW
        ggv0CMdqPiZuDchzhE7+/E6BP5du6TI=
X-Google-Smtp-Source: AGHT+IF443gBTAAUA2YuGDTpz8JAOdzRRFMiPageKRcJ4kGF2KTWVEAjNOGI96kb6BUMaL6QDKcvpM+ucQQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fb83:b0:1c0:ac09:4032 with SMTP id
 lg3-20020a170902fb8300b001c0ac094032mr144133plb.9.1694656557750; Wed, 13 Sep
 2023 18:55:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:09 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-12-seanjc@google.com>
Subject: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
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

In confidential computing usages, whether a page is private or shared is
necessary information for KVM to perform operations like page fault
handling, page zapping etc. There are other potential use cases for
per-page memory attributes, e.g. to make memory read-only (or no-exec,
or exec-only, etc.) without having to modify memslots.

Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
userspace to operate on the per-page memory attributes.
  - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
    a guest memory range.
  - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
    memory attributes.

Use an xarray to store the per-page attributes internally, with a naive,
not fully optimized implementation, i.e. prioritize correctness over
performance for the initial implementation.

Because setting memory attributes is roughly analogous to mprotect() on
memory that is mapped into the guest, zap existing mappings prior to
updating the memory attributes.  Opportunistically provide an arch hook
for the post-set path (needed to complete invalidation anyways) in
anticipation of x86 needing the hook to update metadata related to
determining whether or not a given gfn can be backed with various sizes
of hugepages.

It's possible that future usages may not require an invalidation, e.g.
if KVM ends up supporting RWX protections and userspace grants _more_
protections, but again opt for simplicity and punt optimizations to
if/when they are needed.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
Cc: Fuad Tabba <tabba@google.com>
Cc: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst |  60 ++++++++++
 include/linux/kvm_host.h       |  18 +++
 include/uapi/linux/kvm.h       |  14 +++
 virt/kvm/Kconfig               |   4 +
 virt/kvm/kvm_main.c            | 212 +++++++++++++++++++++++++++++++++
 5 files changed, 308 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e28a13439a95..c44ef5295a12 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6070,6 +6070,56 @@ writes to the CNTVCT_EL0 and CNTPCT_EL0 registers using the SET_ONE_REG
 interface. No error will be returned, but the resulting offset will not be
 applied.
 
+4.139 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
+-----------------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: u64 memory attributes bitmask(out)
+:Returns: 0 on success, <0 on error
+
+Returns supported memory attributes bitmask. Supported memory attributes will
+have the corresponding bits set in u64 memory attributes bitmask.
+
+The following memory attributes are defined::
+
+  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
+4.140 KVM_SET_MEMORY_ATTRIBUTES
+-----------------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_attributes(in/out)
+:Returns: 0 on success, <0 on error
+
+Sets memory attributes for pages in a guest memory range. Parameters are
+specified via the following structure::
+
+  struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+  };
+
+The user sets the per-page memory attributes to a guest memory range indicated
+by address/size, and in return KVM adjusts address and size to reflect the
+actual pages of the memory range have been successfully set to the attributes.
+If the call returns 0, "address" is updated to the last successful address + 1
+and "size" is updated to the remaining address size that has not been set
+successfully. The user should check the return value as well as the size to
+decide if the operation succeeded for the whole range or not. The user may want
+to retry the operation with the returned address/size if the previous range was
+partially successful.
+
+Both address and size should be page aligned and the supported attributes can be
+retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
+
+The "flags" field may be used for future extensions and should be set to 0s.
+
 5. The kvm_run structure
 ========================
 
@@ -8498,6 +8548,16 @@ block sizes is exposed in KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES as a
 64-bit bitmap (each bit describing a block size). The default value is
 0, to disable the eager page splitting.
 
+8.41 KVM_CAP_MEMORY_ATTRIBUTES
+------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
+:Architectures: x86
+:Type: vm
+
+This capability indicates KVM supports per-page memory attributes and ioctls
+KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES are available.
+
 9. Known KVM API problems
 =========================
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b5373cee2b08..9b695391b11c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -256,6 +256,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 union kvm_mmu_notifier_arg {
 	pte_t pte;
+	unsigned long attributes;
 };
 
 struct kvm_gfn_range {
@@ -808,6 +809,9 @@ struct kvm {
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
+#endif
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	struct xarray mem_attr_array;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -2344,4 +2348,18 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
 }
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+}
+
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long attrs);
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range);
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range);
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d2d913acf0df..f8642ff2eb9d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1227,6 +1227,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_USER_MEMORY2 230
+#define KVM_CAP_MEMORY_ATTRIBUTES 231
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -2293,4 +2294,17 @@ struct kvm_s390_zpci_op {
 /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
 #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
 
+/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
+#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
+#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, struct kvm_memory_attributes)
+
+struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+};
+
+#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ecae2914c97e..5bd7fcaf9089 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -96,3 +96,7 @@ config KVM_GENERIC_HARDWARE_ENABLING
 config KVM_GENERIC_MMU_NOTIFIER
        select MMU_NOTIFIER
        bool
+
+config KVM_GENERIC_MEMORY_ATTRIBUTES
+       select KVM_GENERIC_MMU_NOTIFIER
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a41f8658dfe0..2726938b684b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1218,6 +1218,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_init(&kvm->mem_attr_array);
+#endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
 	spin_lock_init(&kvm->gpc_lock);
@@ -1391,6 +1394,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	}
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_destroy(&kvm->mem_attr_array);
+#endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
 	hardware_disable_all();
@@ -2389,6 +2395,188 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+/*
+ * Returns true if _all_ gfns in the range [@start, @end) have attributes
+ * matching @attrs.
+ */
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long attrs)
+{
+	XA_STATE(xas, &kvm->mem_attr_array, start);
+	unsigned long index;
+	bool has_attrs;
+	void *entry;
+
+	rcu_read_lock();
+
+	if (!attrs) {
+		has_attrs = !xas_find(&xas, end);
+		goto out;
+	}
+
+	has_attrs = true;
+	for (index = start; index < end; index++) {
+		do {
+			entry = xas_next(&xas);
+		} while (xas_retry(&xas, entry));
+
+		if (xas.xa_index != index || xa_to_value(entry) != attrs) {
+			has_attrs = false;
+			break;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	return has_attrs;
+}
+
+static u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+	return 0;
+}
+
+static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
+						 struct kvm_mmu_notifier_range *range)
+{
+	struct kvm_gfn_range gfn_range;
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	struct kvm_memslot_iter iter;
+	bool found_memslot = false;
+	bool ret = false;
+	int i;
+
+	gfn_range.arg = range->arg;
+	gfn_range.may_block = range->may_block;
+
+	/*
+	 * If/when KVM supports more attributes beyond private .vs shared, this
+	 * _could_ set only_{private,shared} appropriately if the entire target
+	 * range already has the desired private vs. shared state (it's unclear
+	 * if that is a net win).  For now, KVM reaches this point if and only
+	 * if the private flag is being toggled, i.e. all mappings are in play.
+	 */
+	gfn_range.only_private = false;
+	gfn_range.only_shared = false;
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end) {
+			slot = iter.slot;
+			gfn_range.slot = slot;
+
+			gfn_range.start = max(range->start, slot->base_gfn);
+			gfn_range.end = min(range->end, slot->base_gfn + slot->npages);
+			if (gfn_range.start >= gfn_range.end)
+				continue;
+
+			if (!found_memslot) {
+				found_memslot = true;
+				KVM_MMU_LOCK(kvm);
+				if (!IS_KVM_NULL_FN(range->on_lock))
+					range->on_lock(kvm);
+			}
+
+			ret |= range->handler(kvm, &gfn_range);
+		}
+	}
+
+	if (range->flush_on_ret && ret)
+		kvm_flush_remote_tlbs(kvm);
+
+	if (found_memslot)
+		KVM_MMU_UNLOCK(kvm);
+}
+
+/* Set @attributes for the gfn range [@start, @end). */
+static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long attributes)
+{
+	struct kvm_mmu_notifier_range pre_set_range = {
+		.start = start,
+		.end = end,
+		.handler = kvm_arch_pre_set_memory_attributes,
+		.on_lock = kvm_mmu_invalidate_begin,
+		.flush_on_ret = true,
+		.may_block = true,
+	};
+	struct kvm_mmu_notifier_range post_set_range = {
+		.start = start,
+		.end = end,
+		.arg.attributes = attributes,
+		.handler = kvm_arch_post_set_memory_attributes,
+		.on_lock = kvm_mmu_invalidate_end,
+		.may_block = true,
+	};
+	unsigned long i;
+	void *entry;
+	int r = 0;
+
+	entry = attributes ? xa_mk_value(attributes) : NULL;
+
+	mutex_lock(&kvm->slots_lock);
+
+	/* Nothing to do if the entire range as the desired attributes. */
+	if (kvm_range_has_memory_attributes(kvm, start, end, attributes))
+		goto out_unlock;
+
+	/*
+	 * Reserve memory ahead of time to avoid having to deal with failures
+	 * partway through setting the new attributes.
+	 */
+	for (i = start; i < end; i++) {
+		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		if (r)
+			goto out_unlock;
+	}
+
+	kvm_handle_gfn_range(kvm, &pre_set_range);
+
+	for (i = start; i < end; i++) {
+		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+				    GFP_KERNEL_ACCOUNT));
+		KVM_BUG_ON(r, kvm);
+	}
+
+	kvm_handle_gfn_range(kvm, &post_set_range);
+
+out_unlock:
+	mutex_unlock(&kvm->slots_lock);
+
+	return r;
+}
+static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
+					   struct kvm_memory_attributes *attrs)
+{
+	gfn_t start, end;
+
+	/* flags is currently not used. */
+	if (attrs->flags)
+		return -EINVAL;
+	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
+		return -EINVAL;
+	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
+		return -EINVAL;
+	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
+		return -EINVAL;
+
+	start = attrs->address >> PAGE_SHIFT;
+	end = (attrs->address + attrs->size) >> PAGE_SHIFT;
+
+	/*
+	 * xarray tracks data using "unsigned long", and as a result so does
+	 * KVM.  For simplicity, supports generic attributes only on 64-bit
+	 * architectures.
+	 */
+	BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
+
+	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
+}
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
 	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
@@ -4587,6 +4775,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #ifdef CONFIG_HAVE_KVM_MSI
 	case KVM_CAP_SIGNAL_MSI:
 #endif
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_CAP_MEMORY_ATTRIBUTES:
+#endif
 #ifdef CONFIG_HAVE_KVM_IRQFD
 	case KVM_CAP_IRQFD:
 #endif
@@ -5015,6 +5206,27 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES: {
+		u64 attrs = kvm_supported_mem_attributes(kvm);
+
+		r = -EFAULT;
+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_SET_MEMORY_ATTRIBUTES: {
+		struct kvm_memory_attributes attrs;
+
+		r = -EFAULT;
+		if (copy_from_user(&attrs, argp, sizeof(attrs)))
+			goto out;
+
+		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
+		break;
+	}
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 	case KVM_CREATE_DEVICE: {
 		struct kvm_create_device cd;
 
-- 
2.42.0.283.g2d96d420d3-goog

