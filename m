Return-Path: <linux-fsdevel+bounces-53350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F35AEDE32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FF1188A069
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB428FFDB;
	Mon, 30 Jun 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlhHBu6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955128ECE2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288473; cv=none; b=VaO8nkGkTpO97MHuP2Y0185Zs6xZN0KXSE+nlfP5Wody0mA8MNuYyNAjK3WtDbiD9phA7z7vqLyOkYHsYhqhKkKGoChUzFh39q0AoaaCTotT/Oazkl8trmTOmB3oFro4y+kV9wMNmeEicVMLKxWGlfQXUJllmoDY+0GZgPQtkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288473; c=relaxed/simple;
	bh=E2Kk/3B1Zvc/DrpiBo6mfnVkxxScIN5ozXUblSaxVOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSSipCYUdpCWekF224vcWdtpBph5EJBvoEf7t7fyQ9JTn2lh+SkhjcgbhpGfVLDrt6qWCbo2UWnYNFjPYaaej4vEFMutNteJ3Ba05qJS62x6+KSiBlefbL/joHzuMf2ylkCAKqn++P49Z8aUlHMZ4KTGOhAUhNVitVXCFBrs6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlhHBu6w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02uSef5lp6Y5cEfWyIGZlJA9ZbaH5mB3gdVPjlakXLo=;
	b=IlhHBu6w06/LS/0u8ltvZErlxx9Ev/3S1/mkkEZa9a+A1zSK55WlGfWTb+mKZB8wbf6Euv
	tEsdEnqmq3njhG4U59KyCpZflNT6B68kthDlyoB423DTnT8ICAzrCAOYIHAgeQK6/Nz1VP
	tiOQzoBst+TQmjbNqsVBROWHbLiA4KI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-_U18G8TAM5Gc-CIIG2z-2g-1; Mon, 30 Jun 2025 09:01:00 -0400
X-MC-Unique: _U18G8TAM5Gc-CIIG2z-2g-1
X-Mimecast-MFC-AGG-ID: _U18G8TAM5Gc-CIIG2z-2g_1751288459
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450eaae2934so15173455e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288459; x=1751893259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02uSef5lp6Y5cEfWyIGZlJA9ZbaH5mB3gdVPjlakXLo=;
        b=Fnckq+pH4RkkBdp4xw16EnKueQQRdwSg4KR4zEY8CjGA1Lbkaeq88gULszsrjfb6Uq
         iN1iEdqERmGn2BRIC9+qNbOnQEUN0vcpb04h2lXqF96q2iePZwRM0ipH9w2Ixy8kTJLe
         LEGAWpDvZzQi2GYLiyb8LyV34R6+JtfMhZ/l0j4ceDx07tRkEYng2hhe2bz2YeOj7sqY
         8J1ltU1C2ymhDJHIa0fp+5MyeJ0GOcy0+XhYHdQtnwa+pwXzAY0TVBEqyVOHrCTxwXy2
         xo/WjrLYB9VE8xOU4wKpe2nplh6mR65HfJRHE766/twcf8vxHFDOWobDHasDO/3DxUJ7
         VPvw==
X-Forwarded-Encrypted: i=1; AJvYcCUdP1EHbDECOGmSZHOjy0AILREunnhnjEngd2gIf8Zgh/0DTZhGBBD/eesermKU+LKN9zBiJj9IIdDeYn7O@vger.kernel.org
X-Gm-Message-State: AOJu0YwzfIssQ4DohwNjbZsMOM2oYMF06Ls2j4tdDY5ec9bRfCq8mPw5
	cVTFp0dvZV1QKbBGhdCj6ZoRVC/cRHlI+d+/xNfQ5bWFNl4I136RrwQWH4z8v2ppvnPmkoQKBko
	Z7gt74l/EmnyVeePXRST2CFk+5XLTd3d7UzTDr8ELTvDZQW/793N9drRErwCbvRf+Q9c=
X-Gm-Gg: ASbGncuAJCEPv9M7+MdkQBujHYa/3VWJPBK6yZzrpjzqgN+Jc6lGJwcS8+0ky/XPy4R
	8q0qk6K68WIDXghWRJHVSQ8lSg2IWBCECnMm0Ts8d1WJAqoafZBqBJMGqkdP1BglbqJmLEdrOCV
	0UxpSv1a49Uy9teLrvSg89ntG4rx+6IxsmpjOcE6iQcXUDv+apwJgrMXmAywqWNVqqB0r7jqOlC
	77BoEYPcXGndX1IqT4+uhFVQMM040ySBbhUv5a5RNvXEokbx0a7kWd1sP1/do8T8Hf0+QjxQdio
	gaijkFec58pDNO5uCTv3f8hXuBhb11lr3Xn02tRgjBzo1hDAOltpMj3nm0HyMKiA7rzGVUXzMCi
	KDE+cjM4=
X-Received: by 2002:a05:600c:a46:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-4539726acc1mr92868915e9.3.1751288458044;
        Mon, 30 Jun 2025 06:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCs0m13Yqq4GukWpM+4uHJmOOd6amI/nvHYcsB4z72aw1swyUlytQ8Ivx43yHYvtcBEII8eg==
X-Received: by 2002:a05:600c:a46:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-4539726acc1mr92865605e9.3.1751288455974;
        Mon, 30 Jun 2025 06:00:55 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5f8absm10554612f8f.95.2025.06.30.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:55 -0700 (PDT)
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
Subject: [PATCH v1 15/29] mm/migration: remove PageMovable()
Date: Mon, 30 Jun 2025 14:59:56 +0200
Message-ID: <20250630130011.330477-16-david@redhat.com>
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

As __ClearPageMovable() is gone that would have only made
PageMovable()==false but still __PageMovable()==true, now
PageMovable() == __PageMovable().

So we can replace PageMovable() checks by __PageMovable(). In fact,
__PageMovable() cannot change until a page is freed, so we can turn
some PageMovable() into sanity checks for __PageMovable().

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  2 --
 mm/compaction.c         | 15 ---------------
 mm/migrate.c            | 18 ++++++++++--------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6eeda8eb1e0d8..25659a685e2aa 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -104,10 +104,8 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
-bool PageMovable(struct page *page);
 void __SetPageMovable(struct page *page, const struct movable_operations *ops);
 #else
-static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
 		const struct movable_operations *ops)
 {
diff --git a/mm/compaction.c b/mm/compaction.c
index 889ec696ba96a..5c37373017014 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,21 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-bool PageMovable(struct page *page)
-{
-	const struct movable_operations *mops;
-
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (!__PageMovable(page))
-		return false;
-
-	mops = page_movable_ops(page);
-	if (mops)
-		return true;
-
-	return false;
-}
-
 void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 22c115710d0e2..040484230aebc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -87,9 +87,12 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 		goto out;
 
 	/*
-	 * Check movable flag before taking the page lock because
+	 * Check for movable_ops pages before taking the page lock because
 	 * we use non-atomic bitops on newly allocated page flags so
 	 * unconditionally grabbing the lock ruins page's owner side.
+	 *
+	 * Note that once a page has movable_ops, it will stay that way
+	 * until the page was freed.
 	 */
 	if (unlikely(!__PageMovable(page)))
 		goto out_putfolio;
@@ -108,7 +111,8 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	if (unlikely(!folio_trylock(folio)))
 		goto out_putfolio;
 
-	if (!PageMovable(page) || PageIsolated(page))
+	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
+	if (PageIsolated(page))
 		goto out_no_isolated;
 
 	mops = page_movable_ops(page);
@@ -149,11 +153,10 @@ static void putback_movable_ops_page(struct page *page)
 	 */
 	struct folio *folio = page_folio(page);
 
+	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
 	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
 	folio_lock(folio);
-	/* If the page was released by it's owner, there is nothing to do. */
-	if (PageMovable(page))
-		page_movable_ops(page)->putback_page(page);
+	page_movable_ops(page)->putback_page(page);
 	ClearPageIsolated(page);
 	folio_unlock(folio);
 	folio_put(folio);
@@ -189,10 +192,9 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
 {
 	int rc = MIGRATEPAGE_SUCCESS;
 
+	VM_WARN_ON_ONCE_PAGE(!__PageMovable(src), src);
 	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
-	/* If the page was released by it's owner, there is nothing to do. */
-	if (PageMovable(src))
-		rc = page_movable_ops(src)->migrate_page(dst, src, mode);
+	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		ClearPageIsolated(src);
 	return rc;
-- 
2.49.0


