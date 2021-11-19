Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB6456FF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhKSNwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:52:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:30298 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235710AbhKSNwL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:52:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233134234"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="233134234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507904885"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:49:00 -0800
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
Subject: [RFC v2 PATCH 04/13] KVM: Add fd-based memslot data structure and utils
Date:   Fri, 19 Nov 2021 21:47:30 +0800
Message-Id: <20211119134739.20218-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For fd-based memslot store the file references for shared fd and the
private fd (if any) in the memslot structure. Since there is no 'hva'
concept we cannot call hva_to_pfn() to get a pfn, instead kvm_memfd_ops
is added to get_pfn/put_pfn from the memory backing stores that provide
these fds.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 99e9f9969703..1d4ac0c9b63b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -424,6 +424,12 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
  */
 #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
 
+struct kvm_memfd_ops {
+	kvm_pfn_t (*get_pfn)(struct kvm_memory_slot *slot, struct file *file,
+			     gfn_t gfn, bool alloc, int *order);
+	void (*put_pfn)(kvm_pfn_t pfn);
+};
+
 struct kvm_memory_slot {
 	gfn_t base_gfn;
 	unsigned long npages;
@@ -433,6 +439,9 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+	struct file *file;
+	struct file *priv_file;
+	struct kvm_memfd_ops *memfd_ops;
 };
 
 static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
@@ -1310,6 +1319,20 @@ static inline int memslot_id(struct kvm *kvm, gfn_t gfn)
 	return gfn_to_memslot(kvm, gfn)->id;
 }
 
+static inline bool memslot_is_memfd(const struct kvm_memory_slot *slot)
+{
+	if (slot && slot->memfd_ops)
+		return true;
+	return false;
+}
+
+static inline bool memslot_has_private(const struct kvm_memory_slot *slot)
+{
+	if (slot && slot->priv_file)
+		return true;
+	return false;
+}
+
 static inline gfn_t
 hva_to_gfn_memslot(unsigned long hva, struct kvm_memory_slot *slot)
 {
-- 
2.17.1

