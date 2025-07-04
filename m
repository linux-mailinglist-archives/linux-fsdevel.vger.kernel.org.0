Return-Path: <linux-fsdevel+bounces-53942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59591AF9064
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE91562284
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426D2FBFFB;
	Fri,  4 Jul 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRe2DMzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A22FA63D
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624786; cv=none; b=L1LMaRSULRojMYGIaiTqkgbJ5AqpvHoAaoXN1Gdtl+lj52nZZ67f648c0YLZ0URxt0Ruvu5EZ7kGc/xFgv9BuocSSvLifBrMQ4BWDhLOCwYmIv4JKyfGAmO0qNjijTtu2lshUqeSEFKRmtUTOvDYPse6RJCtGFhXjhBJq9vrZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624786; c=relaxed/simple;
	bh=CEOWBR0ho45KHBlgU76irVulTR2FPeYP8m0twAminTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDB2gd4QUZBBYk4rAAwXZi+eSS8dHXu3IQPmjM2DBHrFmdSoBdBg0LCHzfIjVihIgjdEZJAKDRX2N9nbH8Mb5j4J4hQKJs0y3x5/cBddbRTwIvXjXtv/oSrirADi4nCzFn8N6cPINZSVQgsf7kjtDcxznxDyuR2ieqRrCf6ThiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRe2DMzt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oECXrV5Dx+HlyT4DmzhVSvU+dpZiU/Jf4ByqsPae79M=;
	b=bRe2DMztSP+dOQPpEDzkZ0OvXJ82XKzpi4MN91WvyoIHei8VmBT7VoC3F+s6vH7k+YkEGr
	Zd5qCucojFyFCJBkQPvzUCE7hRomSXEFgsQVTmk87zq8LI6hWrgGbTkTzSYzYgdpS6X6Am
	VajQsiVcDsIdDu/bQIEJWfsY/wLyDHU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Cy1wibybOoOxYZWj6DXlRA-1; Fri, 04 Jul 2025 06:26:22 -0400
X-MC-Unique: Cy1wibybOoOxYZWj6DXlRA-1
X-Mimecast-MFC-AGG-ID: Cy1wibybOoOxYZWj6DXlRA_1751624781
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso364740f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624781; x=1752229581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oECXrV5Dx+HlyT4DmzhVSvU+dpZiU/Jf4ByqsPae79M=;
        b=tmS5mOw3Ex1/eL5YE34EqVc3w3ZD3QVkA57o+CN1N47BIcHudl4c6YdPcOrqO1C5Re
         D35KBPVq12bxqvL/MZWFza5KzlXnw+cTJX3042ITChLH43Dc8cZSgshLsCceGP1da/dX
         wOfwcDYiOdgqR0bjhw0HibNwMYSuSj/P6tJ0DSRZBZm0xYl9FqKDxd47cL6voOPyfN5E
         yXs3WM37hPWKP7mo8Nhr/i6XO91U+UtGStkK30AvMLZ/DWUhl0Dgi0dY9oCcqQ9a1L3m
         82xw6KKrFGvWSImrc0x4HDnqTgwW4f1RORb5NIkPqDFUtOKRkGwEjI5Aq3r/dpaIcV+q
         lCZg==
X-Forwarded-Encrypted: i=1; AJvYcCUsmFb/E4UKgjq2wkXDP2b3gderObnnLZSJbAMYRU3DaBqMonffc8syNxe56rVZZZrOUZxoCNDXEXo2hSaj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Bn+QhDOAlbNT2Uo4GXrT/QavHMHl4jiYp9ckBRSXUFoy539s
	1rCtzoUxFpNnTu7LYEyDGY38J2E0RMnu7oyUdVfhMkiD5p4JzWHFROkJR8hWhu2DP6NrRv9GTBn
	WvEzvUjz7Cagsp7mjs1/RopEnlFQmHnhq5zrvKXnLs2G1cp8cXcEZ/bNL4g+cxepue+w=
X-Gm-Gg: ASbGncujFXTozA2egWoIm7qGETBBz66tLDbkaFqybvS1Qu4DYHOXHjzEpfSD9wAJX/N
	IC6YZQqNBvdBR7d2azNtUyhjIWRZgPowkAykCJ2RWwGjKNzFHdRLFr2f4OulMBekrNj/qiUnAdd
	W78+yIYR1flsZxPrsf+57kEGRBsnM27NokoufJHLpzryt6Y7qdkn1ciE4pX6vf7WTuk7aQtI1aN
	k9KI3VgqPOcrPTWMBVkYyARVqymNs88gCqOkBQWmN1Z4NzJ06EE81HqldRkmRlaforUuCd1aj6a
	8KlXXp9HPa1JyWD/71wskJJ9lQ6HHwXg2BjBF+OVHGBEH2oWYTLjfttCFWfYscflLcBOcFRDeyM
	V924QwA==
X-Received: by 2002:a05:6000:18a3:b0:3a4:cf10:28f with SMTP id ffacd0b85a97d-3b4965fa4b0mr1306231f8f.31.1751624780773;
        Fri, 04 Jul 2025 03:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbtvCxrQrQrYrJp00fZP6RxGB4BHMLsK8k2E+KsEE1fK7HT/hfJLD1aXJjlmgOs0fjfm/CXw==
X-Received: by 2002:a05:6000:18a3:b0:3a4:cf10:28f with SMTP id ffacd0b85a97d-3b4965fa4b0mr1306179f8f.31.1751624780162;
        Fri, 04 Jul 2025 03:26:20 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d0ae0sm2166343f8f.33.2025.07.04.03.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:19 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v2 18/29] mm: remove __folio_test_movable()
Date: Fri,  4 Jul 2025 12:25:12 +0200
Message-ID: <20250704102524.326966-19-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to page_has_movable_ops(). While at it, cleanup relevant code
a bit.

The data_race() in migrate_folio_unmap() is questionable: we already
hold a page reference, and concurrent modifications can no longer
happen (iow: __ClearPageMovable() no longer exists). Drop it for now,
we'll rework page_has_movable_ops() soon either way to no longer
rely on page->mapping.

Wherever we cast from folio to page now is a clear sign that this
code has to be decoupled.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  6 ------
 mm/migrate.c               | 43 ++++++++++++--------------------------
 mm/vmscan.c                |  6 ++++--
 3 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index c67163b73c5ec..4c27ebb689e3c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -744,12 +744,6 @@ static __always_inline bool PageAnon(const struct page *page)
 	return folio_test_anon(page_folio(page));
 }
 
-static __always_inline bool __folio_test_movable(const struct folio *folio)
-{
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
-			PAGE_MAPPING_MOVABLE;
-}
-
 static __always_inline bool page_has_movable_ops(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
diff --git a/mm/migrate.c b/mm/migrate.c
index 3be7a53c13b66..e307b142ab41a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -219,12 +219,7 @@ void putback_movable_pages(struct list_head *l)
 			continue;
 		}
 		list_del(&folio->lru);
-		/*
-		 * We isolated non-lru movable folio so here we can use
-		 * __folio_test_movable because LRU folio's mapping cannot
-		 * have PAGE_MAPPING_MOVABLE.
-		 */
-		if (unlikely(__folio_test_movable(folio))) {
+		if (unlikely(page_has_movable_ops(&folio->page))) {
 			putback_movable_ops_page(&folio->page);
 		} else {
 			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
@@ -237,26 +232,20 @@ void putback_movable_pages(struct list_head *l)
 /* Must be called with an elevated refcount on the non-hugetlb folio */
 bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	bool isolated, lru;
-
 	if (folio_test_hugetlb(folio))
 		return folio_isolate_hugetlb(folio, list);
 
-	lru = !__folio_test_movable(folio);
-	if (lru)
-		isolated = folio_isolate_lru(folio);
-	else
-		isolated = isolate_movable_ops_page(&folio->page,
-						    ISOLATE_UNEVICTABLE);
-
-	if (!isolated)
-		return false;
-
-	list_add(&folio->lru, list);
-	if (lru)
+	if (page_has_movable_ops(&folio->page)) {
+		if (!isolate_movable_ops_page(&folio->page,
+					      ISOLATE_UNEVICTABLE))
+			return false;
+	} else {
+		if (!folio_isolate_lru(folio))
+			return false;
 		node_stat_add_folio(folio, NR_ISOLATED_ANON +
 				    folio_is_file_lru(folio));
-
+	}
+	list_add(&folio->lru, list);
 	return true;
 }
 
@@ -1140,12 +1129,7 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 static void migrate_folio_done(struct folio *src,
 			       enum migrate_reason reason)
 {
-	/*
-	 * Compaction can migrate also non-LRU pages which are
-	 * not accounted to NR_ISOLATED_*. They can be recognized
-	 * as __folio_test_movable
-	 */
-	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
+	if (likely(!page_has_movable_ops(&src->page)) && reason != MR_DEMOTION)
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
@@ -1164,7 +1148,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	int rc = -EAGAIN;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = data_race(!__folio_test_movable(src));
 	bool locked = false;
 	bool dst_locked = false;
 
@@ -1265,7 +1248,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		goto out;
 	dst_locked = true;
 
-	if (unlikely(!is_lru)) {
+	if (unlikely(page_has_movable_ops(&src->page))) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return MIGRATEPAGE_UNMAP;
 	}
@@ -1330,7 +1313,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	prev = dst->lru.prev;
 	list_del(&dst->lru);
 
-	if (unlikely(__folio_test_movable(src))) {
+	if (unlikely(page_has_movable_ops(&src->page))) {
 		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 		if (rc)
 			goto out;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 331f157a6c62a..935013f73fff6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1658,9 +1658,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	unsigned int noreclaim_flag;
 
 	list_for_each_entry_safe(folio, next, folio_list, lru) {
+		/* TODO: these pages should not even appear in this list. */
+		if (page_has_movable_ops(&folio->page))
+			continue;
 		if (!folio_test_hugetlb(folio) && folio_is_file_lru(folio) &&
-		    !folio_test_dirty(folio) && !__folio_test_movable(folio) &&
-		    !folio_test_unevictable(folio)) {
+		    !folio_test_dirty(folio) && !folio_test_unevictable(folio)) {
 			folio_clear_active(folio);
 			list_move(&folio->lru, &clean_folios);
 		}
-- 
2.49.0


