Return-Path: <linux-fsdevel+bounces-17113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D58A7F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC466281901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1912FF72;
	Wed, 17 Apr 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg4wF9Ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0C1292F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345808; cv=none; b=JRIvjTjoRzoMVoqR9wUyDkTQLZHif3kRr2JZFA+NMPPBpco2h4c+aZcIljWHWWpius1DpxP0MMpiYNESQ+adinE2soVN/h6QV+BpL/VykTwWmHlZ6PV+4qcvZzWOBPO0DFyiD5XJqB4QGq9DQbmROpKpRvcuvd0ECAJaCWrXYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345808; c=relaxed/simple;
	bh=kR7NgpoqseIcWNXCbEV890XSu1aVULd4AJRo63fLdGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl/W3WaXNNe/iCCWI+Gy9O9q8W+8d//mM/0B5UX4m3UrpvrFSa7uGhUqhbB8vW0n+WUZ+3clDb/dIRgJjnMw9sbjCcoacsMowSLmxTDQfnIRGdwF0/mEiqOamt7KuLdf8a0cJ2QSargxzex+NyqN4Nn1W5fTDg3ZN4EnldgztKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wg4wF9Ao; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713345806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XkSYCF8J11KhT1kD3yECHdoktxsLGeadBVxc6aZ2IU=;
	b=Wg4wF9Aom6kZ2+PyDTER/dfp92rfjmzHcZNGwihGFAaILgBXmgr4d70OZ/3zxGT1D4EgyB
	qTdiId2bR72IrMLWnwxaXn7Jja40YQJuZMPJ13VOhqvrXR1E9n5qhqcqxHjGN6SyWYJtUb
	sOUX2qVToUZkhWon8vr26mP3O7KrCJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-pdv014c2NOGreuXLt_k0MQ-1; Wed, 17 Apr 2024 05:23:22 -0400
X-MC-Unique: pdv014c2NOGreuXLt_k0MQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91F0A830E7D;
	Wed, 17 Apr 2024 09:23:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F22C2166B36;
	Wed, 17 Apr 2024 09:23:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 1/2] fs/proc/task_mmu: convert pagemap_hugetlb_range() to work on folios
Date: Wed, 17 Apr 2024 11:23:12 +0200
Message-ID: <20240417092313.753919-2-david@redhat.com>
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

While at it, also check for PMD table sharing, like we do in
smaps_hugetlb_range().

No functional change intended, except that we would now detect hugetlb
folios shared via PMD table sharing correctly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8ff79bd427ec6..cd6e45e0cde8e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1578,12 +1578,13 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 
 	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
-		struct page *page = pte_page(pte);
+		struct folio *folio = page_folio(pte_page(pte));
 
-		if (!PageAnon(page))
+		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 
-		if (page_mapcount(page) == 1)
+		if (!folio_likely_mapped_shared(folio) &&
+		    !hugetlb_pmd_shared(ptep))
 			flags |= PM_MMAP_EXCLUSIVE;
 
 		if (huge_pte_uffd_wp(pte))
-- 
2.44.0


