Return-Path: <linux-fsdevel+bounces-49059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94320AB7A02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AE71BA6863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246025A32C;
	Wed, 14 May 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gaBvw8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA7258CDC
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266232; cv=none; b=gffDPSZaeg+jfaojJfghItEevSVej845Kg8xNtiXSYUxNt2Urqyrn98f1ldCpvodvL1RjobN9lxMDES70JC6OnZZor1ygUSUk0RgGSDz5SHJvULIiaEUjpUYWstvLRxTs1+2NVutpn2FGeF4q5Ql+mpKnKi+NYSB7miE5TF1XKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266232; c=relaxed/simple;
	bh=gRuj5LhnHp77MQo/x7/Xu8VS5sA+MCNxmDYy3otphfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAKtRs3JARP72MLrBJ3b+euIYg895YX8QlUKAocJErS5Hi3Ku38JUh1ENTVS/pIuQP4nyJfD/FWT8rhqMk3L3x3aqncYcE07ZfdSNpxmTZXXABp7z+K+V8ijUqFwSFqy63d+qBhpUWf4v5qPtJ7YLkRjKGQImLN20fjvyLVdqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gaBvw8e; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26cdc70befso168733a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266230; x=1747871030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=McES21oaKednLCm3MuTlWlFGQGSEQ+X7XTmzybNd4qs=;
        b=1gaBvw8eU/8mGgSmFw7AsC9I1Igv6ccHbHeUe1txNdFdWNBVOy0Y5ezW0/m268kN5X
         HJDtACB4PWkYsnZxzFNlHcF2BK6gHJ6TG1ZntpYDiZC+ZS8bBFA1GscrTT/qm5Iwvoy1
         Yjx5kwvmBFi1cdsjfw200a5PVF8vJkdgvxsCEOblus0VL5dwLiKKnmO+nZEsU8md6myW
         TFzZHEwjSvMJMBfcRLbNEwZvci4JDdMB/HMuZ5BAqdx55qeEtZ3GNTRb27CMsPwh1ZW5
         vF+hj81y/pggTo3oASoCRH12hkeqtx9NNZdXajl9e//UXtmjEVpnw+qR8YsOd4kyD3ed
         DOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266230; x=1747871030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McES21oaKednLCm3MuTlWlFGQGSEQ+X7XTmzybNd4qs=;
        b=Tv73t54pMocgJ6jsLDu8iqrpqptmPLq2oFGPWHc37rudQlT4NIItYad2vLYGqFf9bh
         vC2kfcgnjfjufNELR/BAKBJ+xFXOqargu03ycmkO4Ozvr04cNNgaRdFe934XC9FKhLgp
         AFJWaHLS2F9zM3S8VZepDCC65cugrWC4CPSrLeKkSHCp+R/gWqrqJ71cAQ55LQ+4ok9g
         RTvc8sZDbB1+f9/iSHK9QUNOZlixYgECVNzim02WOlT00MfGMnT5o30wWvOknzgE9JBX
         q8WJawtwmY/KZ9n9CzuDBy2qPrlokDLpYECW88IWAXph6NThuZ7vgkeU/FJb2qE/W5X0
         7gFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHT6iSQSNwICZnKDuowpccvO/znW5vJv6XWDhUfWG7kWz/iPCOM7CSsBRwB0kil2f/oBymycJ9I7Z1OrB+@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuNC9g2P55yS96PtgLcCevcQvVBRx2gtr/srWo0w/FFQauI1d
	Bt7K+1TbqT5h7ysV5DsakizxJ1jiBJZl0onJc69i0OpRmLnzaDZ5eYdZiktNQbP0H/Fq3f+zoiY
	pZznAI1rWmBpcYSf1KM1URA==
X-Google-Smtp-Source: AGHT+IE/wZXTpXwDl+Su1tSGiLVncuSuLdWOUOGA11KTtFzjP3WVcRBqQXBLgSVDxBHYoQCHOkJf5vIDaeKDk1aLpQ==
X-Received: from pgdr2.prod.google.com ([2002:a63:9b02:0:b0:b16:a617:f449])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9144:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-215ff094408mr8084312637.8.1747266229924;
 Wed, 14 May 2025 16:43:49 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:13 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <45c797aa925e0d2830978105cdf12d6c39f0bd1f.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 34/51] mm: hugetlb: Add functions to add/delete folio
 from hugetlb lists
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

These functions are introduced in hugetlb.c so the private
hugetlb_lock can be accessed.

These functions will be used in splitting and merging pages in a later
patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>

Change-Id: I42f8feda40cbd28e5fd02e54fa58145d847a220e
---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e6b90e72d46d..e432ccfe3e63 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -156,6 +156,8 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
+void hugetlb_folio_list_add(struct folio *folio, struct list_head *list);
+void hugetlb_folio_list_del(struct folio *folio);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 816f257680be..6e326c09c505 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7473,6 +7473,28 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	return 0;
 }
 
+void hugetlb_folio_list_add(struct folio *folio, struct list_head *list)
+{
+	/*
+	 * hstate's hugepage_activelist is guarded by hugetlb_lock, hence hold
+	 * hugetlb_lock while modifying folio-> lru.
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	list_add(&folio->lru, list);
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+void hugetlb_folio_list_del(struct folio *folio)
+{
+	/*
+	 * hstate's hugepage_activelist is guarded by hugetlb_lock, hence hold
+	 * hugetlb_lock while modifying folio-> lru.
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	list_del(&folio->lru);
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 static unsigned long page_table_shareable(struct vm_area_struct *svma,
 				struct vm_area_struct *vma,
-- 
2.49.0.1045.g170613ef41-goog


