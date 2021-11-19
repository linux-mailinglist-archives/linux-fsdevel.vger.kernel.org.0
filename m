Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0B45700D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhKSNxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:53:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:42184 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235799AbhKSNxX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:53:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297831271"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="297831271"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507905274"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:50:13 -0800
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
Subject: [RFC v2 PATCH 13/13] KVM: Enable memfd based page invalidation/fallocate
Date:   Fri, 19 Nov 2021 21:47:39 +0800
Message-Id: <20211119134739.20218-14-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the memory backing store does not get notified when VM is
destroyed so need check if VM is still live in these callbacks.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 virt/kvm/memfd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/virt/kvm/memfd.c b/virt/kvm/memfd.c
index bd930dcb455f..bcfdc685ce22 100644
--- a/virt/kvm/memfd.c
+++ b/virt/kvm/memfd.c
@@ -12,16 +12,38 @@
 #include <linux/memfd.h>
 const static struct guest_mem_ops *memfd_ops;
 
+static bool vm_is_dead(struct kvm *vm)
+{
+	struct kvm *kvm;
+
+	list_for_each_entry(kvm, &vm_list, vm_list) {
+		if (kvm == vm)
+			return false;
+	}
+
+	return true;
+}
+
 static void memfd_invalidate_page_range(struct inode *inode, void *owner,
 					pgoff_t start, pgoff_t end)
 {
 	//!!!We can get here after the owner no longer exists
+	if (vm_is_dead(owner))
+		return;
+
+	kvm_memfd_invalidate_range(owner, inode, start >> PAGE_SHIFT,
+						 end >> PAGE_SHIFT);
 }
 
 static void memfd_fallocate(struct inode *inode, void *owner,
 			    pgoff_t start, pgoff_t end)
 {
 	//!!!We can get here after the owner no longer exists
+	if (vm_is_dead(owner))
+		return;
+
+	kvm_memfd_fallocate_range(owner, inode, start >> PAGE_SHIFT,
+						end >> PAGE_SHIFT);
 }
 
 static const struct guest_ops memfd_notifier = {
-- 
2.17.1

