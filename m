Return-Path: <linux-fsdevel+bounces-1994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B19C7E1497
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0045281049
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBE1641E;
	Sun,  5 Nov 2023 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK5W0dJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80361156F7
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:31:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C12F2
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699201869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l34ekIngaKcFhf0rhv3qmzlwWTTBwpnOE8ik/JX6oMg=;
	b=UK5W0dJ9pRCLgT9meUkKpiAoXl8JfLGKu828W3gR4xncjQAeVZjNmMErjsOAEzLWGYMEgD
	2JYRa65ALYquPJB6z2ZIKjiddd0CUZ7+JvoNdOqFBaZTKgKCTTjY+XldT/+oKpyool7wOk
	59Zxdhd1+mwMqG3anqrbI9Gfgk2TrFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ILi5kzQvOwag3AnT1pmDQg-1; Sun, 05 Nov 2023 11:31:06 -0500
X-MC-Unique: ILi5kzQvOwag3AnT1pmDQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93FA9810FC0;
	Sun,  5 Nov 2023 16:31:04 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE452166B26;
	Sun,  5 Nov 2023 16:30:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 02/34] KVM: Assert that mmu_invalidate_in_progress *never* goes negative
Date: Sun,  5 Nov 2023 17:30:05 +0100
Message-ID: <20231105163040.14904-3-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Sean Christopherson <seanjc@google.com>

Move the assertion on the in-progress invalidation count from the primary
MMU's notifier path to KVM's common notification path, i.e. assert that
the count doesn't go negative even when the invalidation is coming from
KVM itself.

Opportunistically convert the assertion to a KVM_BUG_ON(), i.e. kill only
the affected VM, not the entire kernel.  A corrupted count is fatal to the
VM, e.g. the non-zero (negative) count will cause mmu_invalidate_retry()
to block any and all attempts to install new mappings.  But it's far from
guaranteed that an end() without a start() is fatal or even problematic to
anything other than the target VM, e.g. the underlying bug could simply be
a duplicate call to end().  And it's much more likely that a missed
invalidation, i.e. a potential use-after-free, would manifest as no
notification whatsoever, not an end() without a start().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Message-Id: <20231027182217.3615211-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0524933856d4..5a97e6c7d9c2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -833,6 +833,7 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
 	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
 	 */
 	kvm->mmu_invalidate_in_progress--;
+	KVM_BUG_ON(kvm->mmu_invalidate_in_progress < 0, kvm);
 }
 
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
@@ -863,8 +864,6 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	 */
 	if (wake)
 		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
-
-	BUG_ON(kvm->mmu_invalidate_in_progress < 0);
 }
 
 static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
-- 
2.39.1



