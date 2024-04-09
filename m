Return-Path: <linux-fsdevel+bounces-16488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E789E391
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B611C20FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE9158848;
	Tue,  9 Apr 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjsN1nVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559F1586FF
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690819; cv=none; b=gTUNPolbzBQ3KdYDMX5PXKnnxqf6PelBv0lIfKgYzpuBa0ojFIe34ApC25B0O9fDblkmZlrY7ydcpBkU31sziqDnNHsSENwiROZHDD/cJvW/LRTqwEuEPOufLnVIQU+LjAQOz9ULCBCjBJgUInS8KHWNDl+p6cvQZPjtgqdvWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690819; c=relaxed/simple;
	bh=sYeMlPL5beHAUJA6nbySpZ8t2Qp6YBalKzijeijJLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbEeVqKmFHJIlgUzEIrj2qhF+TzBUm4XzGALhEr13a5IDPL63goxdUGmuz3SkmxAY2tyfuPi4e1SZUEJ9Fvg6LkP76oVvSZuueyRVux/tI5D3EuimmRZbfOvKBGSLSXwvnsFdwcvWhIQV3yeqqMYdXnG9okcoZ+L5Z0HLmSbYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjsN1nVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BvBZKQ0eVCGMopeE4n6MDTyBxCnbPUcn/eYDU7e+Xc=;
	b=SjsN1nVCrxq51IzKF99oQZ3xa2zHFfkBw5ZlnAc0Vkm3M+lkiawL1v5O/mCzyfmkXvlKyu
	PttXsTr99N+qrKk0/hd0SOgq+ofJt8csIFTSEMGi44QqrAwfKWp3j1ZI9OIwZqIx0Swup8
	5CZi5x9dwwlC2YMblvtE7+3MqglxPDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-3faOSIxmOvCIGn74HLebCA-1; Tue, 09 Apr 2024 15:26:53 -0400
X-MC-Unique: 3faOSIxmOvCIGn74HLebCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76CA5188ACAA;
	Tue,  9 Apr 2024 19:26:52 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C430140B497A;
	Tue,  9 Apr 2024 19:26:40 +0000 (UTC)
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
Subject: [PATCH v1 17/18] mm/debug: print only page mapcount (excluding folio entire mapcount) in __dump_folio()
Date: Tue,  9 Apr 2024 21:23:00 +0200
Message-ID: <20240409192301.907377-18-david@redhat.com>
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

Let's simplify and only print the page mapcount: we already print the
large folio mapcount and the entire folio mapcount for large folios
separately; that should be sufficient to figure out what's happening.

While at it, print the page mapcount also if it had an underflow,
filtering out only typed pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/debug.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index d064db42af54..69e524c3e601 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -55,15 +55,10 @@ static void __dump_folio(struct folio *folio, struct page *page,
 		unsigned long pfn, unsigned long idx)
 {
 	struct address_space *mapping = folio_mapping(folio);
-	int mapcount = atomic_read(&page->_mapcount) + 1;
+	int mapcount = atomic_read(&page->_mapcount);
 	char *type = "";
 
-	/* Open-code page_mapcount() to avoid looking up a stale folio */
-	if (mapcount < 0)
-		mapcount = 0;
-	if (folio_test_large(folio))
-		mapcount += folio_entire_mapcount(folio);
-
+	mapcount = page_type_has_type(mapcount) ? 0 : mapcount + 1;
 	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
-- 
2.44.0


