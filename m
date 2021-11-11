Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC10144D7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhKKOSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:18:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:20974 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233796AbhKKOSc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:18:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="256621684"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="256621684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555758"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:15:32 -0800
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
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [RFC PATCH 5/6] kvm: x86: add KVM_EXIT_MEMORY_ERROR exit
Date:   Thu, 11 Nov 2021 22:13:44 +0800
Message-Id: <20211111141352.26311-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently support to exit to userspace for private/shared memory
conversion.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c   | 20 ++++++++++++++++++++
 include/uapi/linux/kvm.h | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index af5ecf4ef62a..780868888aa8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3950,6 +3950,17 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 
 	slot = __kvm_vcpu_gfn_to_memslot(vcpu, gfn, private);
 
+	/*
+	 * Exit to userspace to map the requested private/shared memory region
+	 * if there is no memslot and (a) the access is private or (b) there is
+	 * an existing private memslot.  Emulated MMIO must be accessed through
+	 * shared GPAs, thus a memslot miss on a private GPA is always handled
+	 * as an implicit conversion "request".
+	 */
+	if (!slot &&
+	    (private || __kvm_vcpu_gfn_to_memslot(vcpu, gfn, true)))
+		goto out_convert;
+
 	/* Don't expose aliases for no slot GFNs or private memslots */
 	if ((cr2_or_gpa & vcpu_gpa_stolen_mask(vcpu)) &&
 	    !kvm_is_visible_memslot(slot)) {
@@ -3994,6 +4005,15 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, NULL,
 				    write, writable, hva);
 	return false;
+
+out_convert:
+	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
+	vcpu->run->mem.type = private ? KVM_EXIT_MEM_MAP_PRIVATE
+				      : KVM_EXIT_MEM_MAP_SHARE;
+	vcpu->run->mem.u.map.gpa = cr2_or_gpa;
+	vcpu->run->mem.u.map.size = PAGE_SIZE;
+	return true;
+
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8d20caae9180..470c472a9451 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -233,6 +233,18 @@ struct kvm_xen_exit {
 	} u;
 };
 
+struct kvm_memory_exit {
+#define KVM_EXIT_MEM_MAP_SHARE          1
+#define KVM_EXIT_MEM_MAP_PRIVATE        2
+	__u32 type;
+	union {
+		struct {
+			__u64 gpa;
+			__u64 size;
+		} map;
+	} u;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -272,6 +284,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
 #define KVM_EXIT_TDVMCALL         35
+#define KVM_EXIT_MEMORY_ERROR	  36
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -455,6 +468,8 @@ struct kvm_run {
 			__u64 subfunc;
 			__u64 param[4];
 		} tdvmcall;
+		/* KVM_EXIT_MEMORY_ERROR */
+		struct kvm_memory_exit mem;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.17.1

