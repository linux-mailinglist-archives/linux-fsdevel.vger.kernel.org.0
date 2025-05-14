Return-Path: <linux-fsdevel+bounces-49052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86769AB79DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD284C79B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40025229C;
	Wed, 14 May 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwowlui7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268A251780
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266221; cv=none; b=G9pnQhoMC9JyCM2aBXAtOCzTk+B4KXhTyB/RPj6hlEIJTm9hOP1f5ebwG4DCVtptI3d7QPC15890eUdlmxGThKF8mtyuQPqXLmIBAvm4Meh9TLP5zos2Lz++lYx5KkeJOgKB00HjfLTHV9dwOz+GBOnJBZe4VWCYva0hoRLTJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266221; c=relaxed/simple;
	bh=VN6Zy91LaMiTbU6A7di8uTmOZRNoQlpEPvLShP2HHx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQsWIL22K24CjngrfUpO3NOIdmZB4MSUvgzV5KiN0m41o1ME0pQRFlo94FieMrg5Q67AQg6taTvdpmDVEdvCHcbRgnb0i7D02iCVJ97aGSZRDU0+LD0im4osFuW0v/cMalLEplGcCpgR0ysafIX9Lx5rGHhBBmy58yivPxWd8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwowlui7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b269789425bso262921a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266219; x=1747871019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjDNmSUtedoYx4zVHC06mLM1phpXgQwReFmVa/WU1hs=;
        b=uwowlui7Ww0uHOqUJdsSdieK6tzzSnYW1m3kcEE+SdU49ghYQexl1gy5lOrJ2t3Aag
         A8Y3tVar8D+uyo81+ljRrO06eD7AQshMg/pV70KSwmJvp1VxAVOU2qBfAeIbZx1WjJKZ
         45gI2HGzOn+3hfJhr7A/HLOKvaK7ITrfo0lbSuWMtXpp1pOfH+qQt+BRUReukZ5BT/Xc
         4g/KLtHBmQrRrhvI8buuowdzpCIXWKiFNBXopXk/1tkSZm6aHK9XX/9fcKN0CohE98GU
         LDmfTIys6RbDkB9rKU762zFAVZWnLVe2nFJBXowJyFr8Zmgg2SVKAeNWuOyd/ODZbMpn
         14vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266219; x=1747871019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjDNmSUtedoYx4zVHC06mLM1phpXgQwReFmVa/WU1hs=;
        b=G1y5mV+Z0h+rlAOSh/ubndX/C2PWXI9vRfM9bm7csJWN8f7bFa4jTd1owiDKZWbTIM
         bMLJcnOn42V4EmMpWDxQbuZscAKlgMrwzbl8zHRievp0NlYMNUN0gEc0EQznaOmBW0o9
         71EQ173ALiI9W/9iIe6aritbo7u24GzNujVQqww6j+/v4LIxi9uUy5aGfPA25zdFWt/e
         vtJE4fo6Gr47x56qJD4ALXy1T7enTgM14edg1S2tKSI9ck7HEtrMaNMcOV0nXDiicgx8
         H6KCK/M8sTi8qex7xmq/ArpBEBt922RDUqZLAQc299iSSMKhIPsdnfb/PH0IZSia5i+F
         GRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCTAh1/dnBen7KyfQ7H0SXOA+4rvPBhrs1iUS3Z1v06C49py9G57FnAUo9Ely8PomDcuJSBPJfhaOEoWr6@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJoMDVdoT02f4OFdEdOwddhz/ZPdmDC7RQBcqDzdoHLLeBe+z
	RXiGenho5cUTZqUQmmNldgViV9Z1beeg/zNAcCQL63e0SZzYVoup/Z4+frtVt7IREbm8zAZXMje
	TEUI76L6+Azy94Psh8PMBAw==
X-Google-Smtp-Source: AGHT+IF1YPUusmAbmb3ZD3GPQhCrYy6/top7yw+u+NgqlU9DG8yUspI8ex9oYsbLJOClXn04qHIYKawEAR+7VdCYWQ==
X-Received: from pfbbd12.prod.google.com ([2002:a05:6a00:278c:b0:740:555:f7af])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3949:b0:1ee:dded:e5b with SMTP id adf61e73a8af0-215ff11a531mr7641318637.24.1747266219362;
 Wed, 14 May 2025 16:43:39 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:06 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <779107f1ff8c79095ca0b2d7921e4c54e20861ad.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 27/51] mm: hugetlb: Expose hugetlb_subpool_{get,put}_pages()
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

This will allow hugetlb subpools to be used by guestmem_hugetlb.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I909355935f2ab342e65e7bfdc106bedd1dc177c9
---
 include/linux/hugetlb.h | 3 +++
 mm/hugetlb.c            | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c59264391c33..e6b90e72d46d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -119,6 +119,9 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 					      long min_hpages, bool use_surplus);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
+long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta);
+long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta);
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d22c5a8fd441..816f257680be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -205,8 +205,7 @@ void hugepage_put_subpool(struct hugepage_subpool *spool)
  * only be different than the passed value (delta) in the case where
  * a subpool minimum size must be maintained.
  */
-static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
-				      long delta)
+long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta)
 {
 	long ret = delta;
 
@@ -250,8 +249,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
  * The return value may only be different than the passed value (delta)
  * in the case where a subpool minimum size must be maintained.
  */
-static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
-				       long delta)
+long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta)
 {
 	long ret = delta;
 	unsigned long flags;
-- 
2.49.0.1045.g170613ef41-goog


