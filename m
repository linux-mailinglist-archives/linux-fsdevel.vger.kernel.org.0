Return-Path: <linux-fsdevel+bounces-24983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01394786C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0572829A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D1149000;
	Mon,  5 Aug 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BZaZ630C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81314D2B3;
	Mon,  5 Aug 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850523; cv=none; b=e6iPHAgcjL4CC6msKYTkXVrJR/BmoVBSQNGQb1tng3izZNRtcMYjcctoQmhpug0x92Hx/vG+/3Q9tXzD7L8CCJL2YIdwFAPXxH8Ke+iNzl+cZk5Gz+mfEDCrm6Dj/hQ3HCm4Kc6oB8EPTHh4Js4R+Esu98dgx7+ogxWCeyu9mPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850523; c=relaxed/simple;
	bh=EmW4BPUo26OKPsT+/gBshLdYldAX2g0Wn1GmRbHCE6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBGHfLy0wUE9iXbbGt1fBLobLkG/UeFOWJBvq7QASsTaCD0CTa1NeVlqaE6Bfiw6m5iinSO3GJvltNAUkv2a/LRuzZT8AEgogZo2/GzkktDO56Gb8gb+hCDa0s02V8F3LA5w4D7Q8Ly5GYEiXWxQTrI181X7u9epQ9+28gQrK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BZaZ630C; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850522; x=1754386522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wges4MT0n6I9CyO780W2I1CcNRjpe5PQ75LHC+blwyY=;
  b=BZaZ630Czllo7tAoiVOI93WyGbuSy0ixVXym56SPOhUnTDUtsCCWRwaL
   KBFL1+H3FhMKGYhSOaIpQt+VKzy/5T8LDu9lrkawq2NJQt+M49ghByb7o
   BLVImtlqykFutxqfqo4hb832aAsumYILUioDCfrZlDkl/E83Ub+XURFGe
   M=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="318022324"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:35:09 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:19549]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.223:2525] with esmtp (Farcaster)
 id 73411eaf-fd8d-4133-a679-10dbf0f4e67a; Mon, 5 Aug 2024 09:35:08 +0000 (UTC)
X-Farcaster-Flow-ID: 73411eaf-fd8d-4133-a679-10dbf0f4e67a
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:35:08 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:34:58 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: James Gowans <jgowans@amazon.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Anthony
 Yznaga" <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-fsdevel@vger.kernel.org>, Usama Arif
	<usama.arif@bytedance.com>, <kvm@vger.kernel.org>, Alexander Graf
	<graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant
	<pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: [PATCH 06/10] kexec/kho: Add addr flag to not initialise memory
Date: Mon, 5 Aug 2024 11:32:41 +0200
Message-ID: <20240805093245.889357-7-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Smuggle a flag on the address field. If set the memory region being
reserved via KHO will be marked as no init in memblocks so it will not
get struct pages, will not get given to the buddy allocator and will not
be part of the direct map.

This allows drivers to pass memory ranges which the driver has allocated
itself from memblocks, independent of the kernel's mm and struct page
based memory management.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 include/uapi/linux/kexec.h |  6 ++++++
 kernel/kexec_kho_in.c      | 12 +++++++++++-
 kernel/kexec_kho_out.c     |  4 ++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index ad9e95b88b34..1c031a261c2c 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -52,6 +52,12 @@
 
 /* KHO passes an array of kho_mem as "mem cache" to the new kernel */
 struct kho_mem {
+	/*
+	 * Use the last bits for flags; addrs should be at least word
+	 * aligned.
+	 */
+#define KHO_MEM_ADDR_FLAG_NOINIT	BIT(0)
+#define KHO_MEM_ADDR_FLAG_MASK		(BIT(1) - 1)
 	__u64 addr;
 	__u64 len;
 };
diff --git a/kernel/kexec_kho_in.c b/kernel/kexec_kho_in.c
index 5f8e0d9f9e12..943d9483b009 100644
--- a/kernel/kexec_kho_in.c
+++ b/kernel/kexec_kho_in.c
@@ -75,6 +75,11 @@ __init void kho_populate_refcount(void)
 	 */
 	for (offset = 0; offset < mem_len; offset += sizeof(struct kho_mem)) {
 		struct kho_mem *mem = mem_virt + offset;
+
+		/* No struct pages for this region; nothing to claim. */
+		if (mem->addr & KHO_MEM_ADDR_FLAG_NOINIT)
+			continue;
+
 		u64 start_pfn = PFN_DOWN(mem->addr);
 		u64 end_pfn = PFN_UP(mem->addr + mem->len);
 		u64 pfn;
@@ -183,8 +188,13 @@ void __init kho_reserve_previous_mem(void)
 	/* Then populate all preserved memory areas as reserved */
 	for (off = 0; off < mem_len; off += sizeof(struct kho_mem)) {
 		struct kho_mem *mem = mem_virt + off;
+		__u64 addr = mem->addr & ~KHO_MEM_ADDR_FLAG_MASK;
 
-		memblock_reserve(mem->addr, mem->len);
+		memblock_reserve(addr, mem->len);
+		if (mem->addr & KHO_MEM_ADDR_FLAG_NOINIT) {
+			memblock_reserved_mark_noinit(addr, mem->len);
+			memblock_mark_nomap(addr, mem->len);
+		}
 	}
 
 	/* Unreserve the mem cache - we don't need it from here on */
diff --git a/kernel/kexec_kho_out.c b/kernel/kexec_kho_out.c
index 2cf5755f5e4a..4d9da501c5dc 100644
--- a/kernel/kexec_kho_out.c
+++ b/kernel/kexec_kho_out.c
@@ -175,6 +175,10 @@ static int kho_alloc_mem_cache(struct kimage *image, void *fdt)
 			const struct kho_mem *mem = &mems[i];
 			ulong mstart = PAGE_ALIGN_DOWN(mem->addr);
 			ulong mend = PAGE_ALIGN(mem->addr + mem->len);
+
+			/* Re-apply flags lost during round down. */
+			mstart |= mem->addr & KHO_MEM_ADDR_FLAG_MASK;
+
 			struct kho_mem cmem = {
 				.addr = mstart,
 				.len = (mend - mstart),
-- 
2.34.1


