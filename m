Return-Path: <linux-fsdevel+bounces-52074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67DADF49B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF71BC16AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA53009AE;
	Wed, 18 Jun 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9qBgmDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224F301520
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268471; cv=none; b=B/5ezFmCRvCf9cI4UF20K5SMQrDNlgLQVQp8Pq2ksb/xDkCEZtJ1TN9N/E1xueEibtPk/FNtwDdwxeYZ6HGMV+U2fgVTGmBWNDKDJuh2Ue4AAq1mJHxFd8hKe2d7aeKRta2XVfgBxxRV0S0M7tiJHJGNsU6V84+B9ompVEs2MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268471; c=relaxed/simple;
	bh=N7jwckJ4mxd6ChT2/w7Hj4rKkzFB4g5Ru3Zj9zwCqwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKqgNtCvGHmt2X5FKf4BgrxCBPYIV9RGB7ze3jsvCoCorKGO70jp+QvPy5f3QYpeAHrPa29VG6BRiRdykVft5bc094FuUB+3J9n6xXwOzWNNouf7Sq2BUOHYC0nWD5ceq3515Iex/wlshFb9ZIUwAtu+u/bIcv2atPxFlSB1RYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9qBgmDg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNETPXN7225Q+hZzTHNEAHzgtHhIrhZYYBe8I562/sc=;
	b=D9qBgmDg4xr32XRz1vuSQ+tn22V+UU9Wwdmfz1brnVfsqUDvKK7xZwJ3//r2/6Mv3a72Di
	GM9ak0GC6Dh44pXSAbQ7Zuutax6FAPV5dJNo+Q4yjp0PvCSrjeqAEoIEwy61SHyrw7cwso
	+htu+EwofpBfghMgVEcVgKv0jnbdFSU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-z5JnbEYOODSWprq17cr1aA-1; Wed, 18 Jun 2025 13:41:06 -0400
X-MC-Unique: z5JnbEYOODSWprq17cr1aA-1
X-Mimecast-MFC-AGG-ID: z5JnbEYOODSWprq17cr1aA_1750268466
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso43920455e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268466; x=1750873266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNETPXN7225Q+hZzTHNEAHzgtHhIrhZYYBe8I562/sc=;
        b=Ic2UebaDoTAOtp3BMqgeyR83yvPE6X3JWZhkQ0mdA749gJeWQ5LInycvdxJnySu2Wh
         wZGdfyXYb4BIQY0fbTVQIX+qckWg2VGlMOxJvwuRGhxDP79e9W2bFPkrywq2b27FLvzC
         RAfmzaXy/Le0kkm+OfJZjEjpLHE0t0IKmPNfDZ+9c84w2USQwq4uyjGp1OXMhMfT8k1t
         cYDs1YC8cZsNEAFfPZTXpeJYswc1Usdn57cDZKmuh3f6MmcKI1v6Z4ec1UuZN9SOgIRY
         1A1p/cmorWXDW4+8UMHs15L5vw+hMnEawWexWZAI4M6IWZMROK8gwcU6rhC5TCPZd3cE
         LYTg==
X-Forwarded-Encrypted: i=1; AJvYcCWwm02zkXVb6yCoI+cw6Caa12Qim6Lxnj3szROgjQEzsdsYOEnu7GbLg7w6stg6MIFQ/wIlB6+J7/GId7eo@vger.kernel.org
X-Gm-Message-State: AOJu0YyDi2T+VGUP6j40zaIlU4+tjpsLtIunJBkQrwqCJGEZwSZWQeEB
	SmFkC+swTjGnCOQsazacH5FRwFrwC9W8+U9dG+UQ+3JK/D6LL6foIS2rBBd+fwGSsf4m+MEHNqU
	QBZZbWmsngeJuNxGYhlIgULGgESyNDXw7RMtvpBV4wDcdHm5++KaYIK1H3U4Ft4BOeyY=
X-Gm-Gg: ASbGncs3BBsO8Uyb2AUDSA1zEZ+fu/GA18MlanEZTzWgB+u0gbYShsfF8v5N0eSBUhy
	QXpX9zTNbYUi/f2RCOLzlROnJeOQaLEzjzIUs8wpggi8O8ZHLlo1K0BEzCsxO64WBonAwM/QZbt
	LnMI8M3SqZ2V32x/eydz514yHIAGkiIdDCNnI4MgzYjWllLangYXkGnhxdgSvLqbNen8vAHlmjm
	AjDyvZGLsy4JLy3GoHmaeU49fqliQYoulJNMgs4dzIL4Nkimi7GKl1F6brCBR0kDMzb522DxBP+
	Nj2fubHX69H3xb9czbzYT57x/4N2L1cn5MfNUFN3d99oBiLryN47YnZEYzU0G53M0glfdaQr1pU
	pBIenFg==
X-Received: by 2002:a05:6000:2a84:b0:3a5:8934:b10d with SMTP id ffacd0b85a97d-3a58934b44emr4899280f8f.10.1750268465669;
        Wed, 18 Jun 2025 10:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGweIJH7UFdL4iF+vDHHDFBTBiRTPsGiwY+Mamaq8n4uKw+sdUC4NhASQWA8g0N93X4/5Zu1g==
X-Received: by 2002:a05:6000:2a84:b0:3a5:8934:b10d with SMTP id ffacd0b85a97d-3a58934b44emr4899213f8f.10.1750268465236;
        Wed, 18 Jun 2025 10:41:05 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b18f96sm17611143f8f.66.2025.06.18.10.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:04 -0700 (PDT)
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
Subject: [PATCH RFC 18/29] mm: remove __folio_test_movable()
Date: Wed, 18 Jun 2025 19:40:01 +0200
Message-ID: <20250618174014.1168640-19-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
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
index 5f97369eac2f9..37e722fbfee70 100644
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
+	if (unlikely(page_has_movable_ops(&dst->page))) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return MIGRATEPAGE_UNMAP;
 	}
@@ -1330,7 +1313,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	prev = dst->lru.prev;
 	list_del(&dst->lru);
 
-	if (unlikely(__folio_test_movable(src))) {
+	if (unlikely(page_has_movable_ops(&src->page))) {
 		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 		goto out_unlock_both;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index efc818a0bbecb..e5d04c98af976 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1651,9 +1651,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
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


