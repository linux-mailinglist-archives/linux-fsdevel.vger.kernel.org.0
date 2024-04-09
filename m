Return-Path: <linux-fsdevel+bounces-16474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAB89E344
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9801F2374A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B7157E78;
	Tue,  9 Apr 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi6bZy47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE25157A4C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690654; cv=none; b=kD3yP40LJVpgDhJwS0u+/lK0uZls1Tnf+tG6R/w6WoS7L1DLKywxIHIt7FxnX2sQAFwdDyq0XoJY0waLz3N0kh9eE5H641pP7Y6ibXVJe1EEhoY0KeUgN3GH8t3+6arh4I5DPFJBuAqW9lCXyeT7ohpUw3U2clkqnsj622r+lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690654; c=relaxed/simple;
	bh=A67TbDz2qCguWtpXjavdA9CUCuXT3t/vnWxh8asQyzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YClXwgmiTjjXgWlBKq6LB2qNsHHMvhCpmZOWomI9A77Nzu7fqFiWM+h9bQ5BRopumLKhG9OqEy0zsVOlbMTC7ClZHc/6g9hiUCWP7EfWWahGS8G3CGpU0RBgHRcxClAhpqAdSLp8O7rdo2o6Zjgl2LXwI3XvMTS++iju18mmxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi6bZy47; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DanfdMkK2y8X/5UQWi5wxydKuxMzBBZcoNekt2NzNQo=;
	b=Fi6bZy47nGOs56Cal9c8pHL4W4LzICBjqtqUX99MWdQvINFjtD7vEO2OyPkf2tBaRD3UDA
	yUJp0XHsc+B9XPy/+zLhemDNPZqREmZjebGI29czrCJRYKPd7yxafc0L03WGRWvQTKA/1j
	5oSwC5dxdEtji0QjTIpq+oOEGGVhVc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-eJSj8LVjMUGt1dEE8jgGSA-1; Tue, 09 Apr 2024 15:24:08 -0400
X-MC-Unique: eJSj8LVjMUGt1dEE8jgGSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E743E806604;
	Tue,  9 Apr 2024 19:24:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CAAC40B4982;
	Tue,  9 Apr 2024 19:24:00 +0000 (UTC)
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
Subject: [PATCH v1 03/18] mm/rmap: add fast-path for small folios when adding/removing/duplicating
Date: Tue,  9 Apr 2024 21:22:46 +0200
Message-ID: <20240409192301.907377-4-david@redhat.com>
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

Let's add a fast-path for small folios to all relevant rmap functions.
Note that only RMAP_LEVEL_PTE applies.

This is a preparation for tracking the mapcount of large folios in a
single value.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 13 +++++++++++++
 mm/rmap.c            | 26 ++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 9549d78928bb..327f1ca5a487 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -322,6 +322,11 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 
 	switch (level) {
 	case RMAP_LEVEL_PTE:
+		if (!folio_test_large(folio)) {
+			atomic_inc(&page->_mapcount);
+			break;
+		}
+
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -405,6 +410,14 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 				if (PageAnonExclusive(page + i))
 					return -EBUSY;
 		}
+
+		if (!folio_test_large(folio)) {
+			if (PageAnonExclusive(page))
+				ClearPageAnonExclusive(page);
+			atomic_inc(&page->_mapcount);
+			break;
+		}
+
 		do {
 			if (PageAnonExclusive(page))
 				ClearPageAnonExclusive(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 56b313aa2ebf..4bde6d60db6c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1172,15 +1172,18 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 
 	switch (level) {
 	case RMAP_LEVEL_PTE:
+		if (!folio_test_large(folio)) {
+			nr = atomic_inc_and_test(&page->_mapcount);
+			break;
+		}
+
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
-			if (first && folio_test_large(folio)) {
+			if (first) {
 				first = atomic_inc_return_relaxed(mapped);
-				first = (first < ENTIRELY_MAPPED);
+				if (first < ENTIRELY_MAPPED)
+					nr++;
 			}
-
-			if (first)
-				nr++;
 		} while (page++, --nr_pages > 0);
 		break;
 	case RMAP_LEVEL_PMD:
@@ -1514,15 +1517,18 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 
 	switch (level) {
 	case RMAP_LEVEL_PTE:
+		if (!folio_test_large(folio)) {
+			nr = atomic_add_negative(-1, &page->_mapcount);
+			break;
+		}
+
 		do {
 			last = atomic_add_negative(-1, &page->_mapcount);
-			if (last && folio_test_large(folio)) {
+			if (last) {
 				last = atomic_dec_return_relaxed(mapped);
-				last = (last < ENTIRELY_MAPPED);
+				if (last < ENTIRELY_MAPPED)
+					nr++;
 			}
-
-			if (last)
-				nr++;
 		} while (page++, --nr_pages > 0);
 		break;
 	case RMAP_LEVEL_PMD:
-- 
2.44.0


