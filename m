Return-Path: <linux-fsdevel+bounces-62585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9AAB9A82E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02019173D01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71A30DECF;
	Wed, 24 Sep 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="ODVVf16t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9D30BF76;
	Wed, 24 Sep 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726700; cv=none; b=SqRWkjHMq5ZoxtS7VagP22Ha8gpfkmAhHyXwE4F00sdcXircsFUf50OXXup/eAdHDWQ5mIw9UfyjOeVgUTzNHkJvSsO2Xn6PE7jcPABnJ5V+gd2IIicexTNG/DmMoSFFbJF9JZYBxOSYPjrZoGt9g/lg6dWyysAveQvSrBKoe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726700; c=relaxed/simple;
	bh=Jm4TOb5za1zdWiB64CehdYksvd0hcBd/a5OjGHq8lgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1RWwz8HuuOSfa5LPhl5x5+iJlSVzKgfScXHourIfTFKhsYJ3NDLdiT5oqFPzsfUOmm1QEMM5kBo5Q8iZjhZZIiyABF6rqmQSxghwUBmDEWUzpt6CPUDm3ElBQ8kWihOUKcEOqMoHfZTd+/i7o+MlKYKYAI6uI3Uwp9JKsRDPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=ODVVf16t; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4cX0gC2JbmzyXw;
	Wed, 24 Sep 2025 17:11:35 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=lm-postout21; i=@campus.lmu.de; t=
	1758726694; bh=PniUGv6KoWbLzxsjGhaF2BGkvfN+PIVzF8ZJsy2VjBA=; b=O
	DVVf16tZeBkXRSEs6iGwxx6zvctrHP/AC9H8er/qVLBHLuRg9EsPYFGS6Bm0q0Ko
	xrIDIInKp/Vg9CF6EQWrcMmJyBIGN/AMaHx2eciRriASoNydsugm9L1ekQkk83Jg
	6Db40+b9eoQdOUvkN4MCa/pjZycSZNi2aW7GXxY8Omk2+ARuVZAaYj5lTyV6TlaF
	ygoKE/C4K7l0DOq28xRAdHrG6/BSVJwcdvaZQkrm0hWYNhxYxPoD/IEGb6RyaVUF
	BCHdmnhCuhu53AxwYSL9MXKT/pf4IoUWmfvm7/IJRj7+osaXVq0BVKEStckCWu3u
	nbrgR6tiUZxLTlFCEQ3Cw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.887
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id GcnblPIRe1mz; Wed, 24 Sep 2025 17:11:34 +0200 (CEST)
Received: from spacestation.cable.virginm.net (oxfd-27-b2-v4wan-164230-cust474.vm42.cable.virginm.net [86.22.133.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4cX0g74qG5zyY6;
	Wed, 24 Sep 2025 17:11:31 +0200 (CEST)
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
	ackerleytng@google.com
Subject: [PATCH v7 02/12] x86/tlb: export flush_tlb_kernel_range to KVM module
Date: Wed, 24 Sep 2025 16:10:42 +0100
Message-ID: <20250924151101.2225820-3-patrick.roy@campus.lmu.de>
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

After direct map removal, a TLB flush can be done to ensure that the
just-unmapped memory cannot be accessed through stale TLB entries. This
is particularly useful on modern hardware, where one can not rely on
timely TLB-eviction to ensure these entries go away.

This export is only needed on x86, as arm64 (the only other architecture
supporting guest_memfd currently) does not allow building KVM as a
module.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 arch/x86/include/asm/tlbflush.h | 3 ++-
 arch/x86/mm/tlb.c               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 00daedfefc1b..6f57f7eb621b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -317,7 +317,6 @@ extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
@@ -483,6 +482,8 @@ static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 #endif
 #endif /* !MODULE */
 
+extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+
 static inline void __native_tlb_flush_global(unsigned long cr4)
 {
 	native_write_cr4(cr4 ^ X86_CR4_PGE);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f80111e6f1..dee5018bceeb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1541,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 	put_flush_tlb_info();
 }
+EXPORT_SYMBOL_FOR_MODULES(flush_tlb_kernel_range, "kvm");
 
 /*
  * This can be used from process context to figure out what the value of
-- 
2.51.0


