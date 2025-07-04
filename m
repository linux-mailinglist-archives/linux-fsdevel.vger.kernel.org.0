Return-Path: <linux-fsdevel+bounces-53944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20AAF907A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63DE1CA6966
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67142FBFF5;
	Fri,  4 Jul 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMfYfOfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438ED2F3C04
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624794; cv=none; b=VlYT22TxIrotRgaR3wHzSPzZO3SxrCkktNoXZhLZKSGeOehmxptbRyctHlQeWCvXHiFpBiQwMnzcUFJ3VxhzpZMUbOm5cOWCQ5D+F2QS2rr0HDGgf2fSncBZt/ZnFVFbPCZUH4ep76YEgi8IQOL+mo4t9PDQnkYkmYcX8lBKuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624794; c=relaxed/simple;
	bh=jqBiKE3ljFPLtpUV52bcJzPXSrwMCijt0l7mZnej4RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBULW5ucalseuu/scWLN1uKaJYvnIbOgXgD/ZV4UEGjFQTitaD9t6OzSw+jlT7+O+LQ0I2UVmX3shJ912dlebeIGVIYcp+BFWbTmPFu7LjAqqa9R+eOKYATnBB5OQgf1tfTGDROFugTwZ0/Gpa4g/UxBf9WChEab1zVEww3gsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMfYfOfh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIfhqplW92Whs4rQ5a+bzpcvmYNnoFDclaHeGz5GfJE=;
	b=JMfYfOfhNVuRV1MugkJIuX9/kuuZAB/gpWi9jgYRhx6vYVxzzw8jhgd+amM6GzHJuWHS6o
	H45OCIAnk/qLYC+wJD8tAynrtBc8mBEn+ioWyfLV51t/MkozZvuuWg7nyVlEUV1W/cg2RZ
	07Pl9WPIb7I0L+wVCXvIpEGDbgGbyKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-m0JgLHInP-mhvqLXWXUYLA-1; Fri, 04 Jul 2025 06:26:30 -0400
X-MC-Unique: m0JgLHInP-mhvqLXWXUYLA-1
X-Mimecast-MFC-AGG-ID: m0JgLHInP-mhvqLXWXUYLA_1751624789
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso364784f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624789; x=1752229589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIfhqplW92Whs4rQ5a+bzpcvmYNnoFDclaHeGz5GfJE=;
        b=dQJp7KgYXgCJoPxLiPtM/0PC6yI+QDYvk51EzP1YUM9vdc4KYI2Y/jCbbnRORfFHZq
         iGVw4kxtg//3/6q6BtSHoaX18Y5k6DINWLkY4uoAHXIiYPWcMtm0+uwzRFp0LzY24q+y
         bZxU82/bHhJhTnYPd6FRiH3cQrmpaMCY6EuVdlZN3siHy7RtE8nQSP9SM+0Nw3iW49PY
         2BEvkKpBb+IgYZYPI+bmFciL3JU3EiWMJsnzJ0UcM5dvtbZN6/zaCahM4vDoF+f9ujwU
         ihXbNZ4DIwAU70WAeoOuNeb7b+RgLUddeiN29LYK3FJ9w1H8RUCHTMYE9XG5/IDYGtSe
         jVZA==
X-Forwarded-Encrypted: i=1; AJvYcCUOigrI3OBwhejvCjSQO1fxmAyM4W49In8nHfOrtKdu0MZLubCWL2gRQzx1fmKZCN3rZDrZS2ZExDa4Ft2p@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYCmEb4L+11CVtKb9Fyi/0TpS7Ow6Ywsv/M5Mhxz3TC4F13Km
	tpsnFlRL/CJya+mwE8T8wTQL1MrqqU0wcqbSik9GULTl0PChZqb4s7mwGdUZSzelUNZzCw+6R1B
	UDfO3HTDtV5DLHirurssnAviajxMh8szxFljHtWKlRLPlVjSEXF0EYPqgHuBAM9/yHMk=
X-Gm-Gg: ASbGncsrz2KgvMMcmWtd+kWbqia7kmDOtsaiibVgYCMbBzB4eoJQsqPiY3BdqM6BSeG
	FTsxakdfPlEO0246Ghw9Lu1n1vYQqOaoEjP52siZ30ndv4+81h1vb/ju6bE0hrP+moyTEiwHUE9
	1+tKb93rl+1tQ3zHwt7m0Y5q3tOz9ipnsKk4+DS8R62Qxaoi/pjDjOwMeGDhi8mVXTwt4BxL613
	cFDQA8jWmXqllr3TmTsSF0yNXtF8Q3Wny618vHzQ5BLaR70yP9z/cKb5icG6aClIAsd4wBB5lX8
	FHg35KT4tKhZl8y2/3hQotnkVKjWV9EQAqj96DaP/n5Pw1dNyhwoMWo8enj4MYZB4a5bv7X6Iut
	MfxSfqA==
X-Received: by 2002:a05:6000:3ce:b0:3b2:ef53:5818 with SMTP id ffacd0b85a97d-3b4964eb1dfmr1524569f8f.5.1751624788881;
        Fri, 04 Jul 2025 03:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6/dh0H9/LpgMHN6+E5K8aCm2QgibuKB8jFRjnybENn7lard2NaLBEO46u6eT1pnDUCzj4ag==
X-Received: by 2002:a05:6000:3ce:b0:3b2:ef53:5818 with SMTP id ffacd0b85a97d-3b4964eb1dfmr1524493f8f.5.1751624788372;
        Fri, 04 Jul 2025 03:26:28 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9bde954sm50967885e9.33.2025.07.04.03.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:27 -0700 (PDT)
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
Subject: [PATCH v2 21/29] mm: rename PG_isolated to PG_movable_ops_isolated
Date: Fri,  4 Jul 2025 12:25:15 +0200
Message-ID: <20250704102524.326966-22-david@redhat.com>
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

Let's rename the flag to make it clearer where it applies (not folios
...).

While at it, define the flag only with CONFIG_MIGRATION.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 16 +++++++++++-----
 mm/compaction.c            |  2 +-
 mm/migrate.c               | 14 +++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5f2b570735852..8b0e5c7371e67 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -167,10 +167,9 @@ enum pageflags {
 	/* Remapped by swiotlb-xen. */
 	PG_xen_remapped = PG_owner_priv_1,
 
-	/* non-lru isolated movable page */
-	PG_isolated = PG_reclaim,
-
 #ifdef CONFIG_MIGRATION
+	/* movable_ops page that is isolated for migration */
+	PG_movable_ops_isolated = PG_reclaim,
 	/* this is a movable_ops page (for selected typed pages only) */
 	PG_movable_ops = PG_uptodate,
 #endif
@@ -1126,8 +1125,6 @@ static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
 
 bool is_free_buddy_page(const struct page *page);
 
-PAGEFLAG(Isolated, isolated, PF_ANY);
-
 #ifdef CONFIG_MIGRATION
 /*
  * This page is migratable through movable_ops (for selected typed pages
@@ -1147,9 +1144,18 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
  */
 TESTPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
 SETPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+/*
+ * A movable_ops page has this flag set while it is isolated for migration.
+ * This flag primarily protects against concurrent migration attempts.
+ *
+ * Once migration ended (success or failure), the flag is cleared. The
+ * flag is managed by the migration core.
+ */
+PAGEFLAG(MovableOpsIsolated, movable_ops_isolated, PF_NO_TAIL);
 #else /* !CONFIG_MIGRATION */
 TESTPAGEFLAG_FALSE(MovableOps, movable_ops);
 SETPAGEFLAG_NOOP(MovableOps, movable_ops);
+PAGEFLAG_FALSE(MovableOpsIsolated, movable_ops_isolated);
 #endif /* CONFIG_MIGRATION */
 
 /**
diff --git a/mm/compaction.c b/mm/compaction.c
index 349f4ea0ec3e5..bf021b31c7ece 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1051,7 +1051,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!PageLRU(page)) {
 			/* Isolation code will deal with any races. */
 			if (unlikely(page_has_movable_ops(page)) &&
-					!PageIsolated(page)) {
+			    !PageMovableOpsIsolated(page)) {
 				if (locked) {
 					unlock_page_lruvec_irqrestore(locked, flags);
 					locked = NULL;
diff --git a/mm/migrate.c b/mm/migrate.c
index fde6221562399..7fd3d38410c42 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -135,7 +135,7 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 		goto out_putfolio;
 
 	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
-	if (PageIsolated(page))
+	if (PageMovableOpsIsolated(page))
 		goto out_no_isolated;
 
 	mops = page_movable_ops(page);
@@ -146,8 +146,8 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 		goto out_no_isolated;
 
 	/* Driver shouldn't use the isolated flag */
-	VM_WARN_ON_ONCE_PAGE(PageIsolated(page), page);
-	SetPageIsolated(page);
+	VM_WARN_ON_ONCE_PAGE(PageMovableOpsIsolated(page), page);
+	SetPageMovableOpsIsolated(page);
 	folio_unlock(folio);
 
 	return true;
@@ -177,10 +177,10 @@ static void putback_movable_ops_page(struct page *page)
 	struct folio *folio = page_folio(page);
 
 	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
-	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
+	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(page), page);
 	folio_lock(folio);
 	page_movable_ops(page)->putback_page(page);
-	ClearPageIsolated(page);
+	ClearPageMovableOpsIsolated(page);
 	folio_unlock(folio);
 	folio_put(folio);
 }
@@ -216,10 +216,10 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
 	int rc = MIGRATEPAGE_SUCCESS;
 
 	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
-	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
+	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(src), src);
 	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
-		ClearPageIsolated(src);
+		ClearPageMovableOpsIsolated(src);
 	return rc;
 }
 
-- 
2.49.0


