Return-Path: <linux-fsdevel+bounces-62586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1EB9A83B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F7C17C382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73972311596;
	Wed, 24 Sep 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="NFh2T/RL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BA30BF70;
	Wed, 24 Sep 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726700; cv=none; b=gkvPVFVqhJ0S5K1aLXMWObxMy6EU40Y4a5JZsk/UtthPZuWHbvCjl66mE86066fldzduu1+as3ve9KmAXqucWqeQaVQ9TehmZm6bVA8k/9dC1K2GyBEaQmtnEWBVm2Ly7h1zGwyF71uCq2ohY/V88NReKn5JH2aVigbBK2N1P5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726700; c=relaxed/simple;
	bh=ZNfU2/BIASQO3fWfzdEY1q9Zbqul50E24+/no2KCYus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVMhyJ0sM+1YTYCNBMTdEr0k21hUFXO4z50swILITK20vpJTOb0B+DHXd898XkwHIQp3qhpvnup0XIKlzjlQnYkCfsODK1rPHL+VWyG+foqJvkhxrCnU19CtUHWOMwtnubhMVfV84p4oRlFhAOQxcrky+EFMpm6k377i8NY099M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=NFh2T/RL; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4cX0gB5D6vzySS;
	Wed, 24 Sep 2025 17:11:34 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=lm-postout21; i=@campus.lmu.de; t=
	1758726694; bh=Wp7TACVDU5DtOz71qp4hjyzNeEjUGnycsxHnG+BQylo=; b=N
	Fh2T/RLbz+TFVRiGT0AIO5Im68sjhz2y+uv750xV0082ovfwaC8pVk2I4LANYaHn
	LQ8CsTVhJp7503BUjm8n+ATwZTucxV91BVhdilIDMhEHeg7IEPhCYeiV8NSfK7yi
	XKpSzQAeeHaCN5oqWmzY12+dhLMZnnRXB+NqnXfNXnWQIlOEI/Op+fGZZ+HaI9k+
	2zsYO7eryEZCY3/Ioe6UOmyWtcl3nOsjhgbQ9a2+xdePlO+6mIaFTox1ASdGluv6
	u+sZsCKIJl5sRyE77E5ElASJJYDxkJiPt2G5kFe+Y7KY+I8uc0Y92yN2SxhU3uKL
	FWmzxLTGCINR2g3qgBB4A==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.887
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id RrNSY2sLvH92; Wed, 24 Sep 2025 17:11:34 +0200 (CEST)
Received: from spacestation.cable.virginm.net (oxfd-27-b2-v4wan-164230-cust474.vm42.cable.virginm.net [86.22.133.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4cX0g40m58zyXY;
	Wed, 24 Sep 2025 17:11:28 +0200 (CEST)
From: Patrick Roy <patrick.roy@campus.lmu.de>
To: 
Cc: Patrick Roy <roypat@amazon.co.uk>,
	pbonzini@redhat.com,
	corbet@lwn.net,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	shuah@kernel.org,
	seanjc@google.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.co.uk,
	derekmn@amazon.co.uk,
	tabba@google.com,
	ackerleytng@google.com,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v7 01/12] arch: export set_direct_map_valid_noflush to KVM module
Date: Wed, 24 Sep 2025 16:10:41 +0100
Message-ID: <20250924151101.2225820-2-patrick.roy@campus.lmu.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Patrick Roy <roypat@amazon.co.uk>

Use the new per-module export functionality to allow KVM (and only KVM)
access to set_direct_map_valid_noflush(). This allows guest_memfd to
remove its memory from the direct map, even if KVM is built as a module.

Direct map removal gives guest_memfd the same protection that
memfd_secret enjoys, such as hardening against Spectre-like attacks
through in-kernel gadgets.

Cc: linux-arm-kernel@lists.infradead.org
Cc: loongarch@lists.linux.dev
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 arch/arm64/mm/pageattr.c     | 1 +
 arch/loongarch/mm/pageattr.c | 1 +
 arch/riscv/mm/pageattr.c     | 1 +
 arch/s390/mm/pageattr.c      | 1 +
 arch/x86/mm/pat/set_memory.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 04d4a8f676db..4f3cddfab9b0 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -291,6 +291,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 
 	return set_memory_valid(addr, nr, valid);
 }
+EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 /*
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index f5e910b68229..458f5ae6a89b 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -236,3 +236,4 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 
 	return __set_memory(addr, 1, set, clear);
 }
+EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 3f76db3d2769..6db31040cd66 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -400,6 +400,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 
 	return __set_memory((unsigned long)page_address(page), nr, set, clear);
 }
+EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 348e759840e7..8ffd9ef09bc6 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -413,6 +413,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 
 	return __set_memory((unsigned long)page_to_virt(page), nr, flags);
 }
+EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
 
 bool kernel_page_present(struct page *page)
 {
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..87e9c7d2dcdc 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2661,6 +2661,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 
 	return __set_pages_np(page, nr);
 }
+EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
-- 
2.51.0


