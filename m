Return-Path: <linux-fsdevel+bounces-16481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B289E36A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C8284583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8676158877;
	Tue,  9 Apr 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEdQVj2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAA157A7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690741; cv=none; b=m9+d6/tpW8SGvX2kTueAFW7M5FXKhg9oUs8VBf0r/pGSWEb2z2F1H8TUMYJJk1b6fJgvInRKpWJ9BDTglHPoeXR5qe+B2X8VOILXmVFwLWrujGj3WIzlK5CG9walNJhsoWvXKEUWfavKiB5fO53ThJ1nrhbWU4zGWMtupIwfA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690741; c=relaxed/simple;
	bh=R1eBZWi0r7hSbgtg+APm7iwY8f/rz4SnnovRTb8gUI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMNBf1r1yHE6G5rayRXbg+/+QihMBzzohNACJh7h6nm9rvhsS3Zp4HRkwvaAepVSZwSP0DbKo2d7YqUAiXrpLZpqUMKiOZzFEol8OWuu8OQ/v8E/3K/j46FMygZUaG0tWpcfqfANj0QkYAMcceVBzH6V35r8UiW1nfSg2gg0SkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEdQVj2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDf71sS1dWCd5bf/gEaENI1Rp8VJQ5nXZAI6YpNXJLo=;
	b=BEdQVj2FyzU/3MIEV8c33kIb9EYlASUCfxJnsrbkd6kmes5d4WNhBWLDc9q191VTL1N8f6
	hwzqghHWsqgybC01e3mCO3L9JIzfCto3U7A67zFFvT85KhcOaVKWAShC4RyLeehaS9i4sQ
	ubYt0Vb9yHJLm1+pxHFkvFnKiCHQP4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-vMa84eYMNlusTgwrdB_i6w-1; Tue, 09 Apr 2024 15:25:35 -0400
X-MC-Unique: vMa84eYMNlusTgwrdB_i6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 592A9830ED2;
	Tue,  9 Apr 2024 19:25:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A7E840153AE;
	Tue,  9 Apr 2024 19:25:21 +0000 (UTC)
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
Subject: [PATCH v1 10/18] mm/page_alloc: use folio_mapped() in __alloc_contig_migrate_range()
Date: Tue,  9 Apr 2024 21:22:53 +0200
Message-ID: <20240409192301.907377-11-david@redhat.com>
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
absolutely necessary.

For tracing purposes, we use page_mapcount() in
__alloc_contig_migrate_range(). Adding that mapcount to total_mapped sounds
strange: total_migrated and total_reclaimed would count each page only
once, not multiple times.

But then, isolate_migratepages_range() adds each folio only once to the
list. So for large folios, we would query the mapcount of the
first page of the folio, which doesn't make too much sense for large
folios.

Let's simply use folio_mapped() * folio_nr_pages(), which makes more
sense as nr_migratepages is also incremented by the number of pages in
the folio in case of successful migration.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 393366d4a704..40fc0f60e021 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6389,8 +6389,12 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 
 		if (trace_mm_alloc_contig_migrate_range_info_enabled()) {
 			total_reclaimed += nr_reclaimed;
-			list_for_each_entry(page, &cc->migratepages, lru)
-				total_mapped += page_mapcount(page);
+			list_for_each_entry(page, &cc->migratepages, lru) {
+				struct folio *folio = page_folio(page);
+
+				total_mapped += folio_mapped(folio) *
+						folio_nr_pages(folio);
+			}
 		}
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
-- 
2.44.0


