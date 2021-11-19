Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124ED457004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhKSNw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:52:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:30354 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235663AbhKSNw7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:52:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233134344"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="233134344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507905127"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:49:49 -0800
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
Subject: [RFC v2 PATCH 10/13] KVM: Match inode for invalidation of fd-based slot
Date:   Fri, 19 Nov 2021 21:47:36 +0800
Message-Id: <20211119134739.20218-11-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Different fd/priv_fd can have the same userspace_addr so start/end
is meaningful only when they are used together with fd/priv_fd.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 virt/kvm/kvm_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 090afbadb03f..65055ac460eb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -479,6 +479,7 @@ typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
 struct kvm_useraddr_range {
 	unsigned long start;
 	unsigned long end;
+	struct inode *inode;
 	pte_t pte;
 	gfn_handler_t handler;
 	on_lock_fn_t on_lock;
@@ -520,6 +521,17 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
 		kvm_for_each_memslot(slot, slots) {
 			unsigned long useraddr_start, useraddr_end;
 
+			/*
+			 * Skip the slot if range->inode is not the same as
+			 * that in slot->file or slot->priv_file.
+			 */
+			if (range->inode &&
+			    (!slot->file ||
+			     slot->file->f_inode != range->inode) &&
+			    (!slot->priv_file ||
+			     slot->priv_file->f_inode != range->inode))
+				continue;
+
 			useraddr_start = max(range->start, slot->userspace_addr);
 			useraddr_end = min(range->end, slot->userspace_addr +
 						  (slot->npages << PAGE_SHIFT));
@@ -818,6 +830,7 @@ int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 	const struct kvm_useraddr_range useraddr_range = {
 		.start		= start,
 		.end		= end,
+		.inode		= inode,
 		.pte		= __pte(0),
 		.handler	= kvm_unmap_gfn_range,
 		.on_lock	= (void *)kvm_null_fn,
-- 
2.17.1

