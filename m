Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96EF49271E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiARNWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:22:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:23096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243074AbiARNWo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512164; x=1674048164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sOy+oj7x4sTMI5lpkFFnOHPfnLg7BWRRkoBuCyEaorQ=;
  b=Np55LppTq3hrMiib1ebcFrdgnNG6ARsO+QT8TrGwq2Pd50apOenwWbC9
   9qM6yJ8n/sk+4uxJY8L6PgjBrq74KH4Lwqyz5VSvbLqEct0JUo1vISQ7d
   A/mpKy0/WF10OGJqcOK8cAN90lkeJBeZsWB9YQaOP68tbsLzLAKsTAAqa
   kQs0LpxoU/9XpCsXL8M7o2YKT35dnHxEsuVeuefifDydZYhDNWcEZnRZ6
   gFkhH2G/sYLL2wrqTg1uiSxvMqb/g0cRNQQ07jEnmHParMyCC/WaKWVne
   JtEdBrNXkNbLiZiALi/sJ1nJXcXCcKThx6eoS30D5rgA4sF6yWuJ8W6j8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269193667"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="269193667"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791806"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:35 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 06/12] KVM: Use kvm_userspace_memory_region_ext
Date:   Tue, 18 Jan 2022 21:21:15 +0800
Message-Id: <20220118132121.31388-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new extended memslot structure kvm_userspace_memory_region_ext.
The extended part (private_fd/ private_offset) will be copied from
userspace only when KVM_MEM_PRIVATE is set. Internally old
kvm_userspace_memory_region will still be used for places where the
extended fields are not needed.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/x86.c       | 12 ++++++------
 include/linux/kvm_host.h |  4 ++--
 virt/kvm/kvm_main.c      | 30 ++++++++++++++++++++----------
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c194a8cbd25f..7f8d87463391 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11572,13 +11572,13 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		struct kvm_userspace_memory_region m;
+		struct kvm_userspace_memory_region_ext m;
 
-		m.slot = id | (i << 16);
-		m.flags = 0;
-		m.guest_phys_addr = gpa;
-		m.userspace_addr = hva;
-		m.memory_size = size;
+		m.region.slot = id | (i << 16);
+		m.region.flags = 0;
+		m.region.guest_phys_addr = gpa;
+		m.region.userspace_addr = hva;
+		m.region.memory_size = size;
 		r = __kvm_set_memory_region(kvm, &m);
 		if (r < 0)
 			return ERR_PTR_USR(r);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5011ac35bc50..26118a45f0bb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -977,9 +977,9 @@ enum kvm_mr_change {
 };
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem);
+		const struct kvm_userspace_memory_region_ext *region_ext);
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem);
+		const struct kvm_userspace_memory_region_ext *region_ext);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 168d0ab93c88..ecf94e2548f7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1815,8 +1815,9 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
  * Must be called holding kvm->slots_lock for write.
  */
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem)
+		const struct kvm_userspace_memory_region_ext *region_ext)
 {
+	const struct kvm_userspace_memory_region *mem = &region_ext->region;
 	struct kvm_memory_slot *old, *new;
 	struct kvm_memslots *slots;
 	enum kvm_mr_change change;
@@ -1919,24 +1920,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem)
+		const struct kvm_userspace_memory_region_ext *region_ext)
 {
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
-	r = __kvm_set_memory_region(kvm, mem);
+	r = __kvm_set_memory_region(kvm, region_ext);
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
-					  struct kvm_userspace_memory_region *mem)
+			struct kvm_userspace_memory_region_ext *region_ext)
 {
-	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
+	if ((u16)region_ext->region.slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
-	return kvm_set_memory_region(kvm, mem);
+	return kvm_set_memory_region(kvm, region_ext);
 }
 
 #ifndef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
@@ -4482,14 +4483,23 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SET_USER_MEMORY_REGION: {
-		struct kvm_userspace_memory_region kvm_userspace_mem;
+		struct kvm_userspace_memory_region_ext region_ext;
 
 		r = -EFAULT;
-		if (copy_from_user(&kvm_userspace_mem, argp,
-						sizeof(kvm_userspace_mem)))
+		if (copy_from_user(&region_ext, argp,
+				sizeof(struct kvm_userspace_memory_region)))
 			goto out;
+		if (region_ext.region.flags & KVM_MEM_PRIVATE) {
+			int offset = offsetof(
+				struct kvm_userspace_memory_region_ext,
+				private_offset);
+			if (copy_from_user(&region_ext.private_offset,
+					   argp + offset,
+					   sizeof(region_ext) - offset))
+				goto out;
+		}
 
-		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
+		r = kvm_vm_ioctl_set_memory_region(kvm, &region_ext);
 		break;
 	}
 	case KVM_GET_DIRTY_LOG: {
-- 
2.17.1

