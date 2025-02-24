Return-Path: <linux-fsdevel+bounces-42462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20AFA4292E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02AC3B4CE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC95265CD3;
	Mon, 24 Feb 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9oA5ZKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E626562D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416182; cv=none; b=A3UhRvf30plE0lMQf3bIMABpVAffasFdebq/4ePX8hsKNGw5F5a3rjEY+6h0+peU/WgBQh0HnbrFCcA0UUyzvy2Eo7/iwwjRAk2y5pbZYdhUlgMCFguYGKPSgwuUSwt8z5E6VqYa+8qNGrePA327F8nSgmlBxjFeRrCadOncWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416182; c=relaxed/simple;
	bh=jCFgdCkbqHJ9MbrS7XN0TCcs0JBnjj+yrJRy9PI9wEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLbzgRyjrUtqNSWuxhw397NMxM3W/lFw4CwZ7cEMa5m5ykwtIDzaTbRj5kRTi4AFbj+7DBRdgsF5d9AouKEHE02qf5Bx8nKgq4pKEI4R0tnq4y9sLTZl3cIi07clG3RMeVTj6ivHQb6hYOezS6phdHndvPX7LiEJ66Mf/hBWkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9oA5ZKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9Kk0sDLIOZEo9TGeBWuftLWUgUisx0QoodxZudqT8w=;
	b=Q9oA5ZKsA44ub9JNuQCuXz6BwKkCQfoBqaNzo5lqaKcztpDtckkDde8njeFuOO11lZ1o/H
	Ye+BiUh+8nVSTa1aJrFPCdaJAGdgZ6meQ/qa740ShC+83cxtz+XbPV0hlu+yKK5MIplvnD
	6QHTGPrFGdLc4FaUsd0OHByPXGQVT/0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-tBX0xm-LNx2g4K9fD-UKjg-1; Mon, 24 Feb 2025 11:56:17 -0500
X-MC-Unique: tBX0xm-LNx2g4K9fD-UKjg-1
X-Mimecast-MFC-AGG-ID: tBX0xm-LNx2g4K9fD-UKjg_1740416176
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so23537745e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416176; x=1741020976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9Kk0sDLIOZEo9TGeBWuftLWUgUisx0QoodxZudqT8w=;
        b=qHNDBt2y0g7jai5P87xYns9AMNLNTOdRPQbw4ltuwlO/hT/+9JjQIxMo7s/xs+DEtv
         QP81oP/wjIm4uHrtze/LC+4fP4YL1MwWrZrgGS+SD10CYUykxObMywfHf3bDZMMSPT3z
         uR0Q3IGu5LUWbO0flW2uJ/hfD8/A7BwlcjzPb/z1ff2NN1FxV/sb4U9n28AnCeeulUzv
         n0S1sD+B9CKBbwP4/yN4ItSoySIV/erApIPRk9tqn37K6qYjEVqrAfxAjQVyQlTyNGOQ
         kyfoMfKFSNzVGMOB7yi8bT2XPY1rzkl2IUbNrtB2/x76mRXnQKr6NRLqNLdKVqAGqgin
         Yolw==
X-Forwarded-Encrypted: i=1; AJvYcCVc6Cov3Fh6ctws7D+aCx95m/B7DKQwYoJYJT+5sXqnOLaqsO2/8SD2NRxd/RCeFMm+CHxkMcw7anYy40x3@vger.kernel.org
X-Gm-Message-State: AOJu0YyVo21U+SNvvrk4m+4ou8DwvkfL/q9Dl4mDZxz/xpP8lYVmGj3E
	x8GHyPoL5sWkfW9LUxqU3zaGuCy5vtatJIplTUii9PT9heVGHpXvJmpTzLAD7ZGXGepspoqclPW
	RWEPemFrfXVh0I+naksRc2XEqDarJuhbRdu1XBLD8IcrKASgupviRwoHHU5S3gfI=
X-Gm-Gg: ASbGncvKijdCoVQVNuFkAlJNCjFChg8Qe1ooB6HniAt8U324ji5Yvo5sW2OLuBsEKyz
	QMKGm6HrOnrEGIM8YjjNFb5NEuTtH3ctbAlTOTGi0mQ7rZMqx4O74spOsefFN+9pS09SF/iNKot
	1UOvCXsP56us6LQQLAMPnqssEt9rbVpKO37vqw4u46/qdK0X7MZWLYsr0pdm4AdaqEcpRN3WVlt
	LonjSvITktlfkStiD8UkAg1lXPNCRd1asMLC4bCZthgILtBbpwgXebozuNr7zSEkJlGz4BJ9XE5
	D+7AladQyOMgSjkfFI6NGCmxvqBPgybvoZeNIjJn/w==
X-Received: by 2002:a05:600c:5949:b0:439:8345:17a6 with SMTP id 5b1f17b1804b1-439a30d38e9mr130585475e9.12.1740416176144;
        Mon, 24 Feb 2025 08:56:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy0+PSAOTGdTFyYGF1ZzYS11kOEi6LhvuqHcevrUwSSRUG4LJeLXU4Rq4oj/c975sX5HkQ4A==
X-Received: by 2002:a05:600c:5949:b0:439:8345:17a6 with SMTP id 5b1f17b1804b1-439a30d38e9mr130585275e9.12.1740416175731;
        Mon, 24 Feb 2025 08:56:15 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b02ce404sm113163905e9.7.2025.02.24.08.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:15 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 05/20] mm: move _pincount in folio to page[2] on 32bit
Date: Mon, 24 Feb 2025 17:55:47 +0100
Message-ID: <20250224165603.1434404-6-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

For order-1 folios (never anon folios!) on 32bit, we will now also use the
GUP_PIN_COUNTING_BIAS approach. A fully-mapped order-1 folio requires
2 references. With GUP_PIN_COUNTING_BIAS being 1024, we'd detect such
folios as "maybe pinned" with 512 full mappings, instead of 1024 for
order-0. As anon folios are out of the picture (which are the most relevant
users of checking for pinnings on *mapped* pages) and we are talking about
32bit, this is not expected to cause any trouble.

In __dump_page(), copy one additional folio page if we detect a folio
with an order > 1, so we can dump the pincount on order > 1 folios
reliably.

Note that THPs on 32bit are not particularly common (and we don't care
too much about performance), but we want to keep it working reliably,
because likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", fortunately the 32bit
specifics will likely go away again; even small folios could then have a
pincount and folio_has_pincount() would essentially always return
"true".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 11 +++++++++--
 include/linux/mm_types.h |  5 +++++
 mm/debug.c               | 10 +++++++++-
 mm/gup.c                 |  8 ++++----
 mm/internal.h            |  3 ++-
 mm/page_alloc.c          | 14 +++++++++++---
 6 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6b6373a864dd..1a4ee028a851e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2004,6 +2004,13 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
+static inline bool folio_has_pincount(const struct folio *folio)
+{
+	if (IS_ENABLED(CONFIG_64BIT))
+		return folio_test_large(folio);
+	return folio_order(folio) > 1;
+}
+
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
  * @folio: The folio.
@@ -2020,7 +2027,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  * get that many refcounts, and b) all the callers of this routine are
  * expected to be able to deal gracefully with a false positive.
  *
- * For large folios, the result will be exactly correct. That's because
+ * For most large folios, the result will be exactly correct. That's because
  * we have more tracking data available: the _pincount field is used
  * instead of the GUP_PIN_COUNTING_BIAS scheme.
  *
@@ -2031,7 +2038,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  */
 static inline bool folio_maybe_dma_pinned(struct folio *folio)
 {
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		return atomic_read(&folio->_pincount) > 0;
 
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1d9c68c551d42..31f466d8485bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,7 +387,9 @@ struct folio {
 					atomic_t _large_mapcount;
 					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
+#ifdef CONFIG_64BIT
 					atomic_t _pincount;
+#endif /* CONFIG_64BIT */
 				};
 				unsigned long _usable_1[4];
 			};
@@ -406,6 +408,9 @@ struct folio {
 			unsigned long _head_2;
 	/* public: */
 			struct list_head _deferred_list;
+#ifndef CONFIG_64BIT
+			atomic_t _pincount;
+#endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
diff --git a/mm/debug.c b/mm/debug.c
index 2d1bd67d957bc..83ef3bd0ccd32 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -79,12 +79,17 @@ static void __dump_folio(struct folio *folio, struct page *page,
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
 	if (folio_test_large(folio)) {
+		int pincount = 0;
+
+		if (folio_has_pincount(folio))
+			pincount = atomic_read(&folio->_pincount);
+
 		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
 				folio_order(folio),
 				folio_mapcount(folio),
 				folio_entire_mapcount(folio),
 				folio_nr_pages_mapped(folio),
-				atomic_read(&folio->_pincount));
+				pincount);
 	}
 
 #ifdef CONFIG_MEMCG
@@ -146,6 +151,9 @@ static void __dump_page(const struct page *page)
 	if (idx < MAX_FOLIO_NR_PAGES) {
 		memcpy(&folio, foliop, 2 * sizeof(struct page));
 		nr_pages = folio_nr_pages(&folio);
+		if (nr_pages > 1)
+			memcpy(&folio.__page_2, &foliop->__page_2,
+			       sizeof(struct page));
 		foliop = &folio;
 	}
 
diff --git a/mm/gup.c b/mm/gup.c
index e5040657870ea..2944fe8cf3174 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -109,7 +109,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 		if (is_zero_folio(folio))
 			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
-		if (folio_test_large(folio))
+		if (folio_has_pincount(folio))
 			atomic_sub(refs, &folio->_pincount);
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
@@ -164,7 +164,7 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
 		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
-		if (folio_test_large(folio)) {
+		if (folio_has_pincount(folio)) {
 			folio_ref_add(folio, refs);
 			atomic_add(refs, &folio->_pincount);
 		} else {
@@ -223,7 +223,7 @@ void folio_add_pin(struct folio *folio)
 	 * page refcount field at least once, so that the page really is
 	 * pinned.
 	 */
-	if (folio_test_large(folio)) {
+	if (folio_has_pincount(folio)) {
 		WARN_ON_ONCE(atomic_read(&folio->_pincount) < 1);
 		folio_ref_inc(folio);
 		atomic_inc(&folio->_pincount);
@@ -575,7 +575,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 * is pinned.  That's why the refcount from the earlier
 	 * try_get_folio() is left intact.
 	 */
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		atomic_add(refs, &folio->_pincount);
 	else
 		folio_ref_add(folio,
diff --git a/mm/internal.h b/mm/internal.h
index 7f6d5def00fa0..d33db24c8b17b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -723,7 +723,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	atomic_set(&folio->_pincount, 0);
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+		atomic_set(&folio->_pincount, 0);
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 05a2a9492cdb0..3dff99cc54161 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -959,9 +959,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
-		if (unlikely(atomic_read(&folio->_pincount))) {
-			bad_page(page, "nonzero pincount");
-			goto out;
+		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
 		}
 		break;
 	case 2:
@@ -970,6 +972,12 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "on deferred list");
 			goto out;
 		}
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
+		}
 		break;
 	case 3:
 		/* the third tail page: hugetlb specifics overlap ->mappings */
-- 
2.48.1


