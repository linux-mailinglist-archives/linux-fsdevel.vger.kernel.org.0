Return-Path: <linux-fsdevel+bounces-16487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647F89E38A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95631F21DEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FE1586E4;
	Tue,  9 Apr 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoZfT7Bb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A87157A60
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690810; cv=none; b=bMMtrPPMwRp6UMxJyqvaa3aR4F5NXhV7GoFJzbYb/eh4GDFgTJbR+89msrssgcrZ2Ai8EyflFqQQHDvp4eUOvDgIksnC/i1fucMTgvVKbrqNXRlpEMVs7C9eZom3LKgVJ+mlJb4tuJ4bWPQn3NwVftojyV7f4qVXk7YpTY5J1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690810; c=relaxed/simple;
	bh=a+SVwgdqFyED+L8M3oTlZBiNzAQkOllWBVsreg72suk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOIoZy/svPIZyzG6cWe1FFxzfCOS1KIf+fWoboC90iV+fE818LXiDrNuAKXQHVTqAwecunjyEI9Du+7qqVyGALW+Nre7seBIl241pmo+c11CZWLOsrL2jFhaj+uC+buHrL36Atn3bs747SsSK3D90O+GMRRIa8fdXExWxYZMWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoZfT7Bb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFT5r3M4f3jd1xpIDzMU21YnNFkRRFHEv0eJ+fAnhKQ=;
	b=MoZfT7BbkVFdjihTJtYi5xsmlRFK4ypACmsdUOB2tt8uEgw7UdEz26X3zplCeDMkToEfWz
	ebvjjRliBDf7F0ZgNDSK3ZGfNed1goz9b6S+pOWl54ULbmdCwxqxpoqju1Sy7TBXnbXbA6
	FroTmbvtJxVyfopaGuQ0eedrzAexFT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-WsCdNN_cNKiuXalsvr_glg-1; Tue, 09 Apr 2024 15:26:44 -0400
X-MC-Unique: WsCdNN_cNKiuXalsvr_glg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89ACA811001;
	Tue,  9 Apr 2024 19:26:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA6940B4979;
	Tue,  9 Apr 2024 19:26:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 16/18] xtensa/mm: convert check_tlb_entry() to sanity check folios
Date: Tue,  9 Apr 2024 21:22:59 +0200
Message-ID: <20240409192301.907377-17-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary. So let's convert check_tlb_entry() to perform
sanity checks on folios instead of pages.

This essentially already happened: page_count() is mapped to
folio_ref_count(), and page_mapped() to folio_mapped() internally.
However, we would have printed the page_mapount(), which
does not really match what page_mapped() would have checked.

Let's simply print the folio mapcount to avoid using page_mapcount(). For
small folios there is no change.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/xtensa/mm/tlb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index 4f974b74883c..d8b60d6e50a8 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -256,12 +256,13 @@ static int check_tlb_entry(unsigned w, unsigned e, bool dtlb)
 					dtlb ? 'D' : 'I', w, e, r0, r1, pte);
 			if (pte == 0 || !pte_present(__pte(pte))) {
 				struct page *p = pfn_to_page(r1 >> PAGE_SHIFT);
-				pr_err("page refcount: %d, mapcount: %d\n",
-						page_count(p),
-						page_mapcount(p));
-				if (!page_count(p))
+				struct folio *f = page_folio(p);
+
+				pr_err("folio refcount: %d, mapcount: %d\n",
+					folio_ref_count(f), folio_mapcount(f));
+				if (!folio_ref_count(f))
 					rc |= TLB_INSANE;
-				else if (page_mapcount(p))
+				else if (folio_mapped(f))
 					rc |= TLB_SUSPICIOUS;
 			} else {
 				rc |= TLB_INSANE;
-- 
2.44.0


