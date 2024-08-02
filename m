Return-Path: <linux-fsdevel+bounces-24883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C7946101
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D25E1F22629
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180322139BF;
	Fri,  2 Aug 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNc5jSD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4C1537A4
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614174; cv=none; b=d4glri1aiH6D52hkW4vgjFvoUOhI3XKaf6XTfAHh7urP73CGrQL30Z3Jft5pk5FN5Rj+d+4CjWkSQUE0jDfXUeu12edQbdvLl7af3JbzoCYf5ERjDAPv6eEZ3du+a4K82K8KER9s+BWYDdVv8LYv3hePkK5F/yAbNZt+N9oRQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614174; c=relaxed/simple;
	bh=P92AymmJj/Ft8pl2A+91m7BSNQa3s/9+AJd/Q8AkboU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L951cjdCj210Rgld//LrjVZfxcsc9wSVUSaWCcC7hr4zjsR9Zk3EDpqQWQk4rJbCDUJKFp0wPmHa7JEXPowHZGbq0jaU0VljewOWh7oMTFRi9boWgaV5Kj+Q9j/lUjY48tRJZgYlzw3KEPFL3V5HkSZ5+TcX1mG/XW6OM0iIJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNc5jSD5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsokb2QZ1A8J7FAYTpU1vDg99kVkubfGaPDc1WAA3q4=;
	b=DNc5jSD59Y3qcdx/d0gyQ56dL/4GlXHbdOylKEPNkLFkFRTorpg7vENjzIpYvnmqckm5Zb
	j5KgtvHCMoYon6aLE1FYHn+D7PK4PaPH71sJIDkRb3E3cjq0hrT6Bwq2DyYS2/YrMGOByV
	soRMVwNUELTVrP+prw3z3Tq8wD8Cp0U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-NNjgzyEROca_nRik9KEcaw-1; Fri,
 02 Aug 2024 11:56:08 -0400
X-MC-Unique: NNjgzyEROca_nRik9KEcaw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CD5B19560B1;
	Fri,  2 Aug 2024 15:56:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 241AD300018D;
	Fri,  2 Aug 2024 15:55:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 05/11] mm/ksm: convert get_mergeable_page() from follow_page() to folio_walk
Date: Fri,  2 Aug 2024 17:55:18 +0200
Message-ID: <20240802155524.517137-6-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's use folio_walk instead, for example avoiding taking temporary
folio references if the folio does not even apply and getting rid of
one more follow_page() user.

Note that zeropages obviously don't apply: old code could just have
specified FOLL_DUMP. Anon folios are never secretmem, so we don't care
about losing the check in follow_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 14d9e53b1ec2..742b005f3f77 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -767,26 +767,28 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 	struct mm_struct *mm = rmap_item->mm;
 	unsigned long addr = rmap_item->address;
 	struct vm_area_struct *vma;
-	struct page *page;
+	struct page *page = NULL;
+	struct folio_walk fw;
+	struct folio *folio;
 
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (!vma)
 		goto out;
 
-	page = follow_page(vma, addr, FOLL_GET);
-	if (IS_ERR_OR_NULL(page))
-		goto out;
-	if (is_zone_device_page(page))
-		goto out_putpage;
-	if (PageAnon(page)) {
+	folio = folio_walk_start(&fw, vma, addr, 0);
+	if (folio) {
+		if (!folio_is_zone_device(folio) &&
+		    folio_test_anon(folio)) {
+			folio_get(folio);
+			page = fw.page;
+		}
+		folio_walk_end(&fw, vma);
+	}
+out:
+	if (page) {
 		flush_anon_page(vma, page, addr);
 		flush_dcache_page(page);
-	} else {
-out_putpage:
-		put_page(page);
-out:
-		page = NULL;
 	}
 	mmap_read_unlock(mm);
 	return page;
-- 
2.45.2


