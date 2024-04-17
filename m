Return-Path: <linux-fsdevel+bounces-17114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24808A7F8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33501C20DEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2AB132C39;
	Wed, 17 Apr 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw9cpU46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CA130A50
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345811; cv=none; b=ttx8Dkzf8GPaPqX3E4uNxJKyGEXO+ZAxtac0m2SziNYrGEj63gR+SezN6B3Q93m/zKKiBp9RcMzf5a5q9CgOPCiAoYJv3CT7NtGxJNL9r6UBpSBPbg94f5O+xj4fTHH1m5jgMgUSSES2vp3THnV2utz5wtCcxoVDWZRBJwq3UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345811; c=relaxed/simple;
	bh=6/aOw9dUqBfjPQSRan8VN1NA3JWXNdX0DKCTq/jBgsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAOSRWGRI6trbAkse4WiAXtt25/Gl8Qi6Q4G0fjjtNYOwjN37zwJi6ngBsw4AbPDOZ7GoZk01d8rgvd6AZV4ab5xofA5aeaP5hManZZAmV+aYItgnOGVLtsSEWZM2gO5D3qX36l8uEa7XKuHFYzLFqYSgRgbOZWlvDTddDU7ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw9cpU46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713345808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KJlX59pWoV+9ju0XmT0Dv5XXIefdKD1ijqlf4oKq4Q=;
	b=Vw9cpU46y2hTURrcIT2GKbfwqcM+6DcxQPHzIkOwZtnzccuZfKSMTmyfxYF0Hf2Z7NrbsE
	9B/VBkaVPdZwxxZyS+TgbgIB/hV5t4gdBGUo+8bu3IRNKEcGK0Z78/kVWtcM3dfriYwZ4U
	44KKx3pP/p6gM+VEa1y+/ZrmQUpmFbA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Tteg5mGVN_yPaHS7lxTX6w-1; Wed,
 17 Apr 2024 05:23:25 -0400
X-MC-Unique: Tteg5mGVN_yPaHS7lxTX6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1D1938116ED;
	Wed, 17 Apr 2024 09:23:24 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F31922166B32;
	Wed, 17 Apr 2024 09:23:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 2/2] fs/proc/task_mmu: convert smaps_hugetlb_range() to work on folios
Date: Wed, 17 Apr 2024 11:23:13 +0200
Message-ID: <20240417092313.753919-3-david@redhat.com>
In-Reply-To: <20240417092313.753919-1-david@redhat.com>
References: <20240417092313.753919-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Let's get rid of another page_mapcount() check and simply use
folio_likely_mapped_shared(), which is precise for hugetlb folios.

While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
vm_normal_page(), just like we do in pagemap_hugetlb_range().

No functional change intended.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cd6e45e0cde8e..f4259b7edfded 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -730,19 +730,20 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	struct page *page = NULL;
-	pte_t ptent = ptep_get(pte);
+	pte_t ptent = huge_ptep_get(pte);
+	struct folio *folio = NULL;
 
 	if (pte_present(ptent)) {
-		page = vm_normal_page(vma, addr, ptent);
+		folio = page_folio(pte_page(ptent));
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
-			page = pfn_swap_entry_to_page(swpent);
+			folio = pfn_swap_entry_folio(swpent);
 	}
-	if (page) {
-		if (page_mapcount(page) >= 2 || hugetlb_pmd_shared(pte))
+	if (folio) {
+		if (folio_likely_mapped_shared(folio) ||
+		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
 			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
-- 
2.44.0


