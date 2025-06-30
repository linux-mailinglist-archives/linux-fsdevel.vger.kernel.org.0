Return-Path: <linux-fsdevel+bounces-53343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3FAEDE16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39C63AC520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A628D829;
	Mon, 30 Jun 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4robiDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F728C2C2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288456; cv=none; b=YbbqGvro5khpfzt3rtJ58+bDnm4r2DipDytlpwlBvbVB1NrWvNk8Og4jbMc8LkU4w6R/OCe1YZIvXwL9qYNwOG+KJV1wbWYKfMf9PEdaJrVbKEIm4v9tpMBxs1CHv74Jh5l8aMpzZ5P239Tsn43MhOcM/Kk/K2vDWUk8g41oJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288456; c=relaxed/simple;
	bh=bzT3f8SbOSFmP0mAT3t54D4YW+inx1tEVm83+OWEEC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGSUeQQfrldQVxmehcOltH61TJc2fnC+8vGlMjJfZwbtymCMAs0gteeL9N9Gf+5z1vatTsGxUrZWcJRD/g+Z087o7sjRx9uWT9tM0X6JXx/cK/dzfksm6oxXbyF1ITSV8GNkQxlIhw7fo3PKYDnM36Gi6O7Lnx4iAJSZ490AMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4robiDc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLSy27pHIWSaumHdHZbZB7d4Xse7WARvWeqJ4bM0kJg=;
	b=e4robiDcw0cQ8WdvJTYeg38sSIGLC4n3HPUCRd4zrnpW/AFuBcJpQfj9e5Su1zSm0naDjN
	4pPZU5UJ1xYvqQrKew6s+e7RI7rQE97oLGqPW75wfJaGpO/sgC37tafG2d1qYbpI0uU73k
	rMq3K8IsoyujboBdkL7gR3BMcYgD1jM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-_PCxIp1-Nv6uIeld8Nmirw-1; Mon, 30 Jun 2025 09:00:47 -0400
X-MC-Unique: _PCxIp1-Nv6uIeld8Nmirw-1
X-Mimecast-MFC-AGG-ID: _PCxIp1-Nv6uIeld8Nmirw_1751288447
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1588029f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288446; x=1751893246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLSy27pHIWSaumHdHZbZB7d4Xse7WARvWeqJ4bM0kJg=;
        b=RYwzApEb1T4w7R43/n+dnpFNwieY9btE6+ySobAFsxFPQgqfQ2BU/+Nq+ZFfVIpIdH
         S58Vp4XEgIs+di1JcaeHZ1tCS2mz+WFTa1My8HDKlY/t7MayS62JUfv8WX1ApXvRgTs2
         GlcYmBb3F/jsJt2x9Ufep8KPa6j3iLdE/a+9+nLwuVN2sx3YcNUVz/ZvAPURUl5dLDgW
         FUR8AEGM3i761NupYJjYfLxIzAJOtyXeCN6ORCbUoVszGS75EOc5nNl//vLrc6wX9SQY
         CSpanVQ7r+A570FfEhCzpIhqM9WzZ1PEmRRx/WaFsR8bXPyasbEGBd1Su8MRr4SCJ+Z0
         ddNg==
X-Forwarded-Encrypted: i=1; AJvYcCVtE2l0PVQETbXbuXwXtfpVMA1zavxv3vjljAApdtHoA0pHRf/rr/3P7++4R3APutaL+ubePLOq5Nj/7lMM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzddd2qw1Eu8phjKX8VQDkqhV8tIL+9hEwgSlSymGEk2MO3GZzg
	fyU8eaKHd1WnROQBvO/yrCqkF+9ANLCWHqRGgAq1T54Bc/Yb/Ss7AqNCkOowcU+IC8/9UWelQlN
	zwFJe7cXvuPuAtIwJqtSNvyYc2B2xOyKFhM7uYtpRyrQdH3FFml5fqs4m/ROO4C6iKog=
X-Gm-Gg: ASbGnctzTZM1jS54mAoJ6MZlkJdYCaM4SjLhRtWZbfR/PtHxHBjSAsEzYYpAH9cWGMs
	w6IifF8GZ+1UXV/ZaE3x5N4HvXXy1QW2kTupeN7jjE9w5s1TrP1tQL603eiU9s9YQ/gt9uG7zDd
	KmTWxMR9ZWq88BKLIKgvscB864i0fbV14Z6tCZ5JV7iuaIqfbK2msT+oGgXWAse5cltHGCRDDvo
	Y9wYuaIGKEha0LnBm6QicM+ZSy+ETG+PNsNgF31B3P+UFr1ropnufgb8igoxMG9igtndRT8JILL
	CLp3WNS6p9CyYP5pn/BIJxDGriuy9xgxnqWDTbxlgFeYmZ31NzwTariiMvsXFx6WhzNf2NynmtG
	Fru1VGZ4=
X-Received: by 2002:a05:6000:440b:b0:3a5:287b:da02 with SMTP id ffacd0b85a97d-3a8fe4bd16fmr7883164f8f.40.1751288445812;
        Mon, 30 Jun 2025 06:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZT4aB5+IKBjQnh+yncb7ZFTxj1NuN2dDZeVwVJqvRnlRrWkNRGfP/el4NU32fGgywSRoLtA==
X-Received: by 2002:a05:6000:440b:b0:3a5:287b:da02 with SMTP id ffacd0b85a97d-3a8fe4bd16fmr7883079f8f.40.1751288445063;
        Mon, 30 Jun 2025 06:00:45 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c7e72c1sm10293032f8f.1.2025.06.30.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:44 -0700 (PDT)
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
Subject: [PATCH v1 11/29] mm/migrate: move movable_ops page handling out of move_to_new_folio()
Date: Mon, 30 Jun 2025 14:59:52 +0200
Message-ID: <20250630130011.330477-12-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's move that handling directly into migrate_folio_move(), so we can
simplify move_to_new_folio(). While at it, fixup the documentation a
bit.

Note that unmap_and_move_huge_page() does not care, because it only
deals with actual folios. (we only support migration of
individual movable_ops pages)

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 63 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0898ddd2f661f..22c115710d0e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1024,11 +1024,12 @@ static int fallback_migrate_folio(struct address_space *mapping,
 }
 
 /*
- * Move a page to a newly allocated page
- * The page is locked and all ptes have been successfully removed.
+ * Move a src folio to a newly allocated dst folio.
  *
- * The new page will have replaced the old page if this function
- * is successful.
+ * The src and dst folios are locked and the src folios was unmapped from
+ * the page tables.
+ *
+ * On success, the src folio was replaced by the dst folio.
  *
  * Return value:
  *   < 0 - error code
@@ -1037,34 +1038,30 @@ static int fallback_migrate_folio(struct address_space *mapping,
 static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
+	struct address_space *mapping = folio_mapping(src);
 	int rc = -EAGAIN;
-	bool is_lru = !__folio_test_movable(src);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
 	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
 
-	if (likely(is_lru)) {
-		struct address_space *mapping = folio_mapping(src);
-
-		if (!mapping)
-			rc = migrate_folio(mapping, dst, src, mode);
-		else if (mapping_inaccessible(mapping))
-			rc = -EOPNOTSUPP;
-		else if (mapping->a_ops->migrate_folio)
-			/*
-			 * Most folios have a mapping and most filesystems
-			 * provide a migrate_folio callback. Anonymous folios
-			 * are part of swap space which also has its own
-			 * migrate_folio callback. This is the most common path
-			 * for page migration.
-			 */
-			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
-								mode);
-		else
-			rc = fallback_migrate_folio(mapping, dst, src, mode);
+	if (!mapping)
+		rc = migrate_folio(mapping, dst, src, mode);
+	else if (mapping_inaccessible(mapping))
+		rc = -EOPNOTSUPP;
+	else if (mapping->a_ops->migrate_folio)
+		/*
+		 * Most folios have a mapping and most filesystems
+		 * provide a migrate_folio callback. Anonymous folios
+		 * are part of swap space which also has its own
+		 * migrate_folio callback. This is the most common path
+		 * for page migration.
+		 */
+		rc = mapping->a_ops->migrate_folio(mapping, dst, src,
+							mode);
+	else
+		rc = fallback_migrate_folio(mapping, dst, src, mode);
 
-		if (rc != MIGRATEPAGE_SUCCESS)
-			goto out;
+	if (rc == MIGRATEPAGE_SUCCESS) {
 		/*
 		 * For pagecache folios, src->mapping must be cleared before src
 		 * is freed. Anonymous folios must stay anonymous until freed.
@@ -1074,10 +1071,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 
 		if (likely(!folio_is_zone_device(dst)))
 			flush_dcache_folio(dst);
-	} else {
-		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 	}
-out:
 	return rc;
 }
 
@@ -1328,20 +1322,23 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	int rc;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__folio_test_movable(src);
 	struct list_head *prev;
 
 	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
 	prev = dst->lru.prev;
 	list_del(&dst->lru);
 
+	if (unlikely(__folio_test_movable(src))) {
+		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
+		if (rc)
+			goto out;
+		goto out_unlock_both;
+	}
+
 	rc = move_to_new_folio(dst, src, mode);
 	if (rc)
 		goto out;
 
-	if (unlikely(!is_lru))
-		goto out_unlock_both;
-
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
-- 
2.49.0


