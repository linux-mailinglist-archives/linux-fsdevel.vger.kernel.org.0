Return-Path: <linux-fsdevel+bounces-49064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059DAB7A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519333A44E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30D2638BC;
	Wed, 14 May 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+4E1C+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2B25D208
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266241; cv=none; b=IQXrHYBP7Def26c0h14My7og+8aGig8RJrHqHJu4nRkAbISXyAZAOD2abm6Rhyvto92dNu5i8/ylSt6+qZxDdsmYOZK2/Hu/+xbhV2IN6nkQZh3j378Ue5NpUM/1rWCeBJy4KGe9fjN0SRSYEli0z2XTUxaQqWlYueb8+6kp1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266241; c=relaxed/simple;
	bh=102GvifG4zt1ttrSz67mMu9EOxHXu/R1+sbn9BQTSZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fSWWpFTJjJ6vEbIkwrfbOP/+I9ny++t4MMormQhFUJ3+fuESqozDVHDrj0TYuPpyU8FvROTpWiW+q7P0OT+mg/YYHk8oiDmOrW7RMVMNQaokLT1ZVUVYstoJshUS2SWsgbc+A0FtMvz3NfLhwv0MaPzAVbS3oObxhvk9yu7y6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+4E1C+O; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e540fa2d0so2715915ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266238; x=1747871038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmGFcMqll2ZECWkoZDuet36vvCpdEEo2q3JYb5OCRKk=;
        b=N+4E1C+O66u/2AsRaBgT91MJS9ng42C+9NjRXQ3YNyKU42nyuFhpbcN/JwWuKvlEPU
         en9fcu8azoG/a1PQ9ifKcy0UelB0dOwmMHBEn3F8BobX7Y0NcbQu84cWord+3mL4H/ln
         xiQIdnqLrpcgCGVHBFog50fU327p7AhtoEDvulCt5TV1Ze50XVp/fOCRUloIh8ssPVQ5
         QIVgG7r7e36Z6YwJl7QyeK0b4B+WCmU4koDKATAzizKCStQeElL5CQBd25B78Mmo1UDa
         xfPtDymGbD34ZlOi7ghcLmQfbgRHlM3lNj5NTX7DORFiAHu4VCebVNrob22VaWRdbc6f
         K2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266238; x=1747871038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmGFcMqll2ZECWkoZDuet36vvCpdEEo2q3JYb5OCRKk=;
        b=J1odJZ8pBF7yZ75WNQHSmmaYWrh+P24NI46ZcsI5dsvbQaxshmfu8KOHRISCWEIBeg
         ZTtqzeD5YSLvWxEBK4nZNWwofKBOHW9s2X++DEw6vdpF6HaS0TztCupFxakaLz4fVKte
         uKx3oy5hZ+06IVS+juz2klUq5x08Ly5ToDUzTLKIh4tBnmjIpUTIvlUMBYmGVsOUoXfF
         ZKu3wPTXX5ltDNYIuuyDskNP/qlVnzcdk/3WrWT/cIVT9G530zHMKV9o02kJZZaO8az0
         BDOY7PLjCo/gd+hKa92y9rQlxqv6pDMDEQKPEfP0MAHY5NGjx6jyoSf4Bv3JZ4AiTLri
         wdKA==
X-Forwarded-Encrypted: i=1; AJvYcCUeeAPty4+i3kUybUwjJPvdXzM9lUsGCJ1hh+vo6P2uXIMMPfg1NhHXubQriVSYk9mG3Vc7tiJMSGBspX+e@vger.kernel.org
X-Gm-Message-State: AOJu0YytvfVIUxatHI7DwkUY8MB14m7HqonDwG9sr7vQMiWMHWMWpPwP
	o8NSJBFp7MKcwqZepONE1XfBcdLHbMqeGKxJ+sUdKOtBVN25/uvkizGsmTb9WDY6qzm4WqUfXO+
	5D8kqPpUoZT1ubzt0XhKtCw==
X-Google-Smtp-Source: AGHT+IGyG3aK+TPRgSsxWpjag/A4ruHzJ2SmD21jLoxWwmPBfdNpP7Yc+Ypfwlkx2TEetNXBaMC3rrsf4RqZeQwBkA==
X-Received: from pjbsz11.prod.google.com ([2002:a17:90b:2d4b:b0:308:7499:3dfc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:228a:b0:223:60ce:2451 with SMTP id d9443c01a7336-231b5e26004mr6306905ad.15.1747266237995;
 Wed, 14 May 2025 16:43:57 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:18 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <625bd9c98ad4fd49d7df678f0186129226f77d7d.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 39/51] KVM: guest_memfd: Merge and truncate on fallocate(PUNCH_HOLE)
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

Merge and truncate on fallocate(PUNCH_HOLE), but if the file is being
closed, defer merging to folio_put() callback.

Change-Id: Iae26987756e70c83f3b121edbc0ed0bc105eec0d
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index cb426c1dfef8..04b1513c2998 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -859,6 +859,35 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
 	return ret;
 }
 
+static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
+					   size_t nr_pages)
+{
+	struct folio *f;
+	pgoff_t unused;
+	long num_freed;
+
+	unmap_mapping_pages(inode->i_mapping, index, nr_pages, false);
+
+	if (!kvm_gmem_has_safe_refcount(inode->i_mapping, index, nr_pages, &unused))
+		return -EAGAIN;
+
+	f = filemap_get_folio(inode->i_mapping, index);
+	if (IS_ERR(f))
+		return 0;
+
+	/* Leave just filemap's refcounts on the folio. */
+	folio_put(f);
+
+	WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
+
+	num_freed = folio_nr_pages(f);
+	folio_lock(f);
+	truncate_inode_folio(inode->i_mapping, f);
+	folio_unlock(f);
+
+	return num_freed;
+}
+
 #else
 
 static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
@@ -874,6 +903,12 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
 	return 0;
 }
 
+static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
+					   size_t nr_pages)
+{
+	return 0;
+}
+
 #endif
 
 #else
@@ -1182,8 +1217,10 @@ static long kvm_gmem_truncate_indices(struct address_space *mapping,
  *
  * Removes folios beginning @index for @nr_pages from filemap in @inode, updates
  * inode metadata.
+ *
+ * Return: 0 on success and negative error otherwise.
  */
-static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
+static long kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
 						  pgoff_t index,
 						  size_t nr_pages)
 {
@@ -1191,19 +1228,34 @@ static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
 	long num_freed;
 	pgoff_t idx;
 	void *priv;
+	long ret;
 
 	priv = kvm_gmem_allocator_private(inode);
 	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
 
+	ret = 0;
 	num_freed = 0;
 	for (idx = index; idx < index + nr_pages; idx += nr_per_huge_page) {
-		num_freed += kvm_gmem_truncate_indices(
-			inode->i_mapping, idx, nr_per_huge_page);
+		if (mapping_exiting(inode->i_mapping) ||
+		    !kvm_gmem_has_some_shared(inode, idx, nr_per_huge_page)) {
+			num_freed += kvm_gmem_truncate_indices(
+				inode->i_mapping, idx, nr_per_huge_page);
+		} else {
+			ret = kvm_gmem_merge_truncate_indices(inode, idx,
+							      nr_per_huge_page);
+			if (ret < 0)
+				break;
+
+			num_freed += ret;
+			ret = 0;
+		}
 	}
 
 	spin_lock(&inode->i_lock);
 	inode->i_blocks -= (num_freed << PAGE_SHIFT) / 512;
 	spin_unlock(&inode->i_lock);
+
+	return ret;
 }
 
 /**
@@ -1252,8 +1304,10 @@ static void kvm_gmem_zero_range(struct address_space *mapping,
  *
  * Removes full (huge)pages from the filemap and zeroing incomplete
  * (huge)pages. The pages in the range may be split.
+ *
+ * Return: 0 on success and negative error otherwise.
  */
-static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
+static long kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
 					  loff_t lend)
 {
 	pgoff_t full_hpage_start;
@@ -1263,6 +1317,7 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
 	pgoff_t start;
 	pgoff_t end;
 	void *priv;
+	long ret;
 
 	priv = kvm_gmem_allocator_private(inode);
 	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
@@ -1279,10 +1334,11 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
 		kvm_gmem_zero_range(inode->i_mapping, start, zero_end);
 	}
 
+	ret = 0;
 	if (full_hpage_end > full_hpage_start) {
 		nr_pages = full_hpage_end - full_hpage_start;
-		kvm_gmem_truncate_inode_aligned_pages(inode, full_hpage_start,
-						      nr_pages);
+		ret = kvm_gmem_truncate_inode_aligned_pages(
+			inode, full_hpage_start, nr_pages);
 	}
 
 	if (end > full_hpage_end && end > full_hpage_start) {
@@ -1290,6 +1346,8 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
 
 		kvm_gmem_zero_range(inode->i_mapping, zero_start, end);
 	}
+
+	return ret;
 }
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
@@ -1298,6 +1356,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	pgoff_t start = offset >> PAGE_SHIFT;
 	pgoff_t end = (offset + len) >> PAGE_SHIFT;
 	struct kvm_gmem *gmem;
+	long ret;
 
 	/*
 	 * Bindings must be stable across invalidation to ensure the start+end
@@ -1308,8 +1367,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin_and_zap(gmem, start, end);
 
+	ret = 0;
 	if (kvm_gmem_has_custom_allocator(inode)) {
-		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
+		ret = kvm_gmem_truncate_inode_range(inode, offset, offset + len);
 	} else {
 		/* Page size is PAGE_SIZE, so use optimized truncation function. */
 		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
@@ -1320,7 +1380,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	filemap_invalidate_unlock(inode->i_mapping);
 
-	return 0;
+	return ret;
 }
 
 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
-- 
2.49.0.1045.g170613ef41-goog


