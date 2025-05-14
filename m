Return-Path: <linux-fsdevel+bounces-49056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEEAB79F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974A6189A92B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CE2561BB;
	Wed, 14 May 2025 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xwVpFHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B10253F07
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266227; cv=none; b=XEOSpQ1Iqz3LF0QFzaluKNUM+CdQEI9UiUMBbG7rwDN8+z5Y3KzQP4Mx/SGVVwjZDcgFXvWl4kcbPbbZhYdAKmlgWOXtogLRTfmUeaR6ig8m6D66USJGgSK0XESQuO96qv7dMs6Ni3jTqR+/X4BR92hCf5nYrX9M2VpvSMO2OUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266227; c=relaxed/simple;
	bh=880XVl+KH7tuOh/Vi4slppYflzAbo1wGOw0YlbCi5yM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=snjyXC7Wyr9K0jgDQKDWTaUMa/rc2lI1Fzad/cBDTdE1ryw20wvso6JTCmtifb6AaTVu0xHpuMto7ytDA1hIiTXfJ+GuABA5mvQdltPgAx9H3i3gsh/w128CaUuzkasARVIC9uDvzkpylLujt5amwbvYtBHVUxFerjwEiJtWJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xwVpFHK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c1a269a12so599553a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266225; x=1747871025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2xHpbJgtJxOVMnodYqV0AgaR/C3WrhDv288edrMISE=;
        b=3xwVpFHKSMmumGg6IWWrYZCj09DbaupqvdpMpHbUttXSsqjHMSNb1ezJicT7uToZ08
         WQTjgosk+89QtTFBJSN9bU/DQsWS2UtRRyDSA/h+gCIoAYxugmHMiZQXgBow+NXiYO/W
         giDpH1ZWa+DwjMxCyCl//ltdvCzbYoGdCA5Ihvl/BQEPd7Rbr6M5uCMkCsI/njkJQW2N
         rBVF6U2L/kVlNx9DxNd9VTWq4NKQF8MEgYL+VMKe8EnE1KHLmhBgbshDtVqpwzeAtqq1
         rw5thxRwJ7hKaniGoQPZwFFGJYFGqbBIeHgF4cg+rbN6SSEPyH1ht6fN4QdgPxIsGWVv
         x4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266225; x=1747871025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2xHpbJgtJxOVMnodYqV0AgaR/C3WrhDv288edrMISE=;
        b=FzrmUc3okDpd7HHcfNIuTHIiN2Tml+TrDWnZ79yNmwoLDLIlb+KhvVu2o19AsFA+aW
         wu+Zm3/AE7WcYH9nO2StBVdyz9b7Rt5JhNHSUuo4HADYLVu9aXWBC/+e6oClx+NVzQgY
         4ayGkV7rlljP7bUzw+bsreXBWI2IPSkzcmbgODbMPUbEGV3RqDBoXq+AcxT+6uvdCUT/
         axMVwjqFPKySe/znrxIoaRty/b4biz1CkgU/Y8G0eV3G5NX1xKvwhUTbTMeoSd+RSNgm
         hLi+I6WTiuRCfMTxW42nVBgaKEZtm3fEbebEXIvz6eqUrMcpnZ7txGSxMcfWuz73Xhhi
         MNjA==
X-Forwarded-Encrypted: i=1; AJvYcCWjrRgJteCNHDRYJf9hccZF5ASlZFlqWHR6by0MMDiFvLj7pTtpZVGEc/8V7TL+Yss33Qz1OYx98boRMhgS@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNetn0WV5UPlqRwlAw66GaM702W3ruKuVUKaAMI0mFuJdCTNW
	QUeFhHSz0ScQV4VEvhgLYr8Ur5ts576V8vlyQPp8yXOAHwZqyUCxRy9wG4GLnH3tJNyDYeKrLzi
	rv0/wFNwpmblNmRJBcD7Xcw==
X-Google-Smtp-Source: AGHT+IEnxUnflQCwANEToR4+zQJiUqjf1j7XWon+tqwv5PtG2ghVVngVh87NrGZhCVUyi9zCtLfCOzjpKjbtnaQ2Wg==
X-Received: from pjn6.prod.google.com ([2002:a17:90b:5706:b0:30a:9720:ea33])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:6c6:b0:30e:ee6:6745 with SMTP id 98e67ed59e1d1-30e2e5b6599mr8868127a91.10.1747266225334;
 Wed, 14 May 2025 16:43:45 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:10 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <4acb9139318e3ae35d61ed7da9d41db2e328dc40.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 31/51] KVM: x86: Set disallow_lpage on base_gfn and
 guest_memfd pgoff misalignment
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

When slot->base_gfn and userspace_addr are not aligned wrt each other,
large page support is disabled for the entire memslot.

This patch applies the same logic for when slot->base_gfn and
gmem.pgoff are not aligned wrt each other.

Change-Id: Iab21b8995e77beae6dbadc3b623a1e9e07e6dce6
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c | 53 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 12433b1e755b..ee0e3420cc17 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12950,6 +12950,46 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
 	return 0;
 }
 
+static inline bool kvm_is_level_aligned(u64 value, int level)
+{
+	return IS_ALIGNED(value, KVM_PAGES_PER_HPAGE(level));
+}
+
+static inline bool
+kvm_should_allow_lpage_for_slot(struct kvm_memory_slot *slot, int level)
+{
+	bool gfn_and_userspace_addr_aligned;
+	unsigned long ugfn;
+
+	ugfn = slot->userspace_addr >> PAGE_SHIFT;
+
+	/*
+	 * If addresses are not aligned wrt each other, then large page mapping
+	 * cannot be allowed for the slot since page tables only allow guest to
+	 * host translations to function at fixed levels.
+	 */
+	gfn_and_userspace_addr_aligned =
+		kvm_is_level_aligned(slot->base_gfn ^ ugfn, level);
+
+	/*
+	 * If slot->userspace_addr is 0 (disabled), 0 is always aligned so the
+	 * check is deferred to gmem.pgoff.
+	 */
+	if (!gfn_and_userspace_addr_aligned)
+		return false;
+
+	if (kvm_slot_has_gmem(slot)) {
+		bool gfn_and_gmem_pgoff_aligned;
+
+		gfn_and_gmem_pgoff_aligned = kvm_is_level_aligned(
+			slot->base_gfn ^ slot->gmem.pgoff, level);
+
+		return gfn_and_gmem_pgoff_aligned;
+	}
+
+	return true;
+}
+
 static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 				      struct kvm_memory_slot *slot)
 {
@@ -12971,7 +13011,6 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 
 	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		struct kvm_lpage_info *linfo;
-		unsigned long ugfn;
 		int lpages;
 		int level = i + 1;
 
@@ -12983,16 +13022,12 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 
 		slot->arch.lpage_info[i - 1] = linfo;
 
-		if (slot->base_gfn & (KVM_PAGES_PER_HPAGE(level) - 1))
+		if (!kvm_is_level_aligned(slot->base_gfn, level))
 			linfo[0].disallow_lpage = 1;
-		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
+		if (!kvm_is_level_aligned(slot->base_gfn + npages, level))
 			linfo[lpages - 1].disallow_lpage = 1;
-		ugfn = slot->userspace_addr >> PAGE_SHIFT;
-		/*
-		 * If the gfn and userspace address are not aligned wrt each
-		 * other, disable large page support for this slot.
-		 */
-		if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1)) {
+
+		if (!kvm_should_allow_lpage_for_slot(slot, level)) {
 			unsigned long j;
 
 			for (j = 0; j < lpages; ++j)
-- 
2.49.0.1045.g170613ef41-goog


