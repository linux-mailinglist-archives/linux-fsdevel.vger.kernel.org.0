Return-Path: <linux-fsdevel+bounces-42256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E83A3FA95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173DB19E210B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977482135D8;
	Fri, 21 Feb 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="LbhPhfYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36043211A26;
	Fri, 21 Feb 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154172; cv=none; b=Ks8xwvJCdCwDb3fxhZJoXb682AnjrC0ZTDSvje4G5ARYHKN+xjzG/PxkGnqBkEGtj7xerfr6AH85wp5R+PQR57JC0xCjrkBw8pXWNl7XHzc11ocBAHZQbeqG/JLI6GxRz95XyFICp1eNnQ5SfKdSnYbvhvdJTths6XvTvtxM6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154172; c=relaxed/simple;
	bh=5xu2DgSOMI3V8WHrDma2TrRQsns4tlbOewE04d9bHWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKT4BfkRE8qzoLZe0FkdfMrnIuH6M+1r8Y+uPNPksWkz0zyGudjRE18z1/vTbOXHKZuLKzHrUjaN6KyG+1zAguBjmpmJpRyLt/1LyuGvUhXhDPkg2c8zaGhDCeMZqjLhQtk8VOUQimksTOJuxbbwFTIZdQTcN6TJOKvzc7JFCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=LbhPhfYM; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154171; x=1771690171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nm9zNepSUdoA1TQLI0kM62WN+98N1j5Ykxo1Wq9f3hY=;
  b=LbhPhfYMRus1+SkF6PaJHW1VumwEoPAibRsMp7wNjKM6WF4R2i0s1AWc
   Gw4ZbnV/VotrBW3NAN9T8qvIXOQGvkpQp8sOk0fLZp3lyCQYbE2RR4OI4
   Td+mZSiOl3jOns0N/dnLkdP7EDrF/uh/q4BIl3WCJPMSWLiGObuCxOgEK
   I=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="379576549"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:14255]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 2f8b5d22-ec9a-4b09-902a-79e210123256; Fri, 21 Feb 2025 16:09:28 +0000 (UTC)
X-Farcaster-Flow-ID: 2f8b5d22-ec9a-4b09-902a-79e210123256
Received: from EX19D003UWB001.ant.amazon.com (10.13.138.92) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:09:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB001.ant.amazon.com (10.13.138.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:09:28 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:09:28 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id A35CC404C9;
	Fri, 21 Feb 2025 16:09:20 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<song@kernel.org>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
Subject: [PATCH v4 03/12] KVM: guest_memfd: Add flag to remove from direct map
Date: Fri, 21 Feb 2025 16:07:16 +0000
Message-ID: <20250221160728.1584559-4-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221160728.1584559-1-roypat@amazon.co.uk>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Add KVM_GMEM_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD() ioctl. When
set, guest_memfd folios will be removed from the direct map after
preparation, with direct map entries only restored when the folios are
freed.

To ensure these folios do not end up in places where the kernel cannot
deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
address_space if KVM_GMEM_NO_DIRECT_MAP is requested.

Note that this flag causes removal of direct map entries for all
guest_memfd folios independent of whether they are "shared" or "private"
(although current guest_memfd only supports either all folios in the
"shared" state, or all folios in the "private" state if
!IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM)). The usecase for removing
direct map entries of also the shared parts of guest_memfd are a special
type of non-CoCo VM where, host userspace is trusted to have access to
all of guest memory, but where Spectre-style transient execution attacks
through the host kernel's direct map should still be mitigated.

Note that KVM retains access to guest memory via userspace
mappings of guest_memfd, which are reflected back into KVM's memslots
via userspace_addr. This is needed for things like MMIO emulation on
x86_64 to work. Previous iterations attempted to instead have KVM
temporarily restore direct map entries whenever such an access to guest
memory was needed, but this turned out to have a significant performance
impact, as well as additional complexity due to needing to refcount
direct map reinsertion operations and making them play nicely with gmem
truncations.

This iteration also doesn't have KVM perform TLB flushes after direct
map manipulations. This is because TLB flushes resulted in a up to 40x
elongation of page faults in guest_memfd (scaling with the number of CPU
cores), or a 5x elongation of memory population. On the one hand, TLB
flushes are not needed for functional correctness (the virt->phys
mapping technically stays "correct",  the kernel should simply to not it
for a while), so this is a correct optimization to make. On the other
hand, it means that the desired protection from Spectre-style attacks is
not perfect, as an attacker could try to prevent a stale TLB entry from
getting evicted, keeping it alive until the page it refers to is used by
the guest for some sensitive data, and then targeting it using a
spectre-gadget.

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/uapi/linux/kvm.h |  2 ++
 virt/kvm/guest_memfd.c   | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 117937a895da..4654c01a0a01 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1573,6 +1573,8 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_GMEM_NO_DIRECT_MAP			(1ULL << 0)
+
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
 
 struct kvm_pre_fault_memory {
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 30b47ff0e6d2..bd7d361c9bb7 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#include <linux/set_memory.h>
 
 #include "kvm_mm.h"
 
@@ -42,8 +43,23 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 	return 0;
 }
 
+static bool kvm_gmem_test_no_direct_map(struct inode *inode)
+{
+	return ((unsigned long) inode->i_private) & KVM_GMEM_NO_DIRECT_MAP;
+}
+
 static inline void kvm_gmem_mark_prepared(struct folio *folio)
 {
+	struct inode *inode = folio_inode(folio);
+
+	if (kvm_gmem_test_no_direct_map(inode)) {
+		int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
+						     false);
+
+		if (!r)
+			folio_set_private(folio);
+	}
+
 	folio_mark_uptodate(folio);
 }
 
@@ -479,6 +495,10 @@ static void kvm_gmem_free_folio(struct folio *folio)
 	kvm_pfn_t pfn = page_to_pfn(page);
 	int order = folio_order(folio);
 
+	if (folio_test_private(folio))
+		WARN_ON_ONCE(set_direct_map_valid_noflush(folio_page(folio, 0),
+							  folio_nr_pages(folio), true));
+
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
 }
 #endif
@@ -552,6 +572,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	/* Unmovable mappings are supposed to be marked unevictable as well. */
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
 
+	if (flags & KVM_GMEM_NO_DIRECT_MAP)
+		mapping_set_no_direct_map(inode->i_mapping);
+
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
@@ -571,7 +594,10 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
 	u64 flags = args->flags;
-	u64 valid_flags = 0;
+	u64 valid_flags = KVM_GMEM_NO_DIRECT_MAP;
+
+	if (!can_set_direct_map())
+		valid_flags &= ~KVM_GMEM_NO_DIRECT_MAP;
 
 	if (flags & ~valid_flags)
 		return -EINVAL;
-- 
2.48.1


