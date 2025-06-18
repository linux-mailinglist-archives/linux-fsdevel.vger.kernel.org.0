Return-Path: <linux-fsdevel+bounces-52076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A57CADF4AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D711BC1664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA42F5498;
	Wed, 18 Jun 2025 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr1feDfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502F302CB3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268481; cv=none; b=a8QM5GTu4femCCS/3wLtL9RVUrhGFYfmVMxjh/6fJzNQ0TlsMzrdPl9/VaI6VlUu8KxCG4wh8m6I60uFpqa8vFTJt7d3DaoJcCJ8kP5zeXZ3GB99GyFHFEHbwYa7i9CNGSE3uAKI230P4UDgoQ2KjwgQHjP2iMF+KoT68yjpBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268481; c=relaxed/simple;
	bh=/I2SWzcXvlUkl4dzsdwEhOqXgULSh4KVorXOxq8r2O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgiJqso6zcf75uDGsK6VBJmT9RX4iKrBTScBmnuu0qvVrZidxPTqp38hLKvN5n1fRIF46SRNteBpnOD96UJvTFobhK/hANw9tutDJDCzFR6Y4604E5Cxh8v7gWQfblMMK6PvRqX2NyensJ1OKbYHyqhSFcaA4fxc56yO5jilSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jr1feDfc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgDxyojJlL5XcnaJgd1JoaTm/pUk71nf1V9W9yKY0aE=;
	b=Jr1feDfc2jMaXhkOQwPameGyiYlovzYNtjrygS64Fmyhq6R3i6PhPnolg7E/bMEtCIKach
	/hoQeJFRDPKVLfh8HwCPj78iY66pNzmntnmIU3MTkCQWoj3tMbUc7vvoErWJ4nxRn+WPiJ
	f53OvIrLIfhSmZLikjYDWUNuqxqhQzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-hzXsnmDXNQaOh-SXaFmfnw-1; Wed, 18 Jun 2025 13:41:17 -0400
X-MC-Unique: hzXsnmDXNQaOh-SXaFmfnw-1
X-Mimecast-MFC-AGG-ID: hzXsnmDXNQaOh-SXaFmfnw_1750268475
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d290d542so43198875e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268475; x=1750873275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgDxyojJlL5XcnaJgd1JoaTm/pUk71nf1V9W9yKY0aE=;
        b=Gg4m8/34/PWVieSgIlIOkJZs1612dx8H0uOuIGcM/B2kRC9FjYXMTLuIwkh/JQXjxN
         ESDMQVD2mCGk6QLnGJg6lBDFjrUm2iaukDeB/UTXWDiFIleOi7e3mQNEPri40UTg0Orq
         +Cj3BdSevoIkRzsW4YQqoQUOQNA4Tk4+vv/By2woqv/zC9BIhPH2ibFj7kJ+1jSQPeoG
         RANPOcPd5CLdpSQ9YpNySXMiJByYelOzh4G/18TXmF2RknI7PIw4XR7t8/k5+iWhAwDp
         bYkpdcKgKEZGwS0VHHFw6XPK8oSVQXIyxvwCRYipTNlS4iI3qeAdF/jVRlV4pxqNnZFY
         Vc8g==
X-Forwarded-Encrypted: i=1; AJvYcCWHfsWR8oQow81y9Fp4ukjRvu4C8rKCTbc4dARv4R7hM7hA21Cq0uzu6DJqF9JhTmIjxnZYHvMhjv6RL037@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vOa5et/fjRpPe8NkoMB/akPiCIUP4Nm6ugwIKe5HIYVfHX1F
	7pkHLrRsnQ+jfRBLSqwltIpL87Gs5oGmshiYye8keO8vf+Vn64PYELqVCMbPXjDMudVywWIPcJx
	GIyCx2R7yjIw7vN06DO32qPW9kWDROHqG9YNM6AaYHd/8QYggxZ98KERdTG93mm7zOqY=
X-Gm-Gg: ASbGncturxGEWt2+7F03T8gR6eJujfbt3iiLo/xtwCHJGE45M5gk4OmyWD01DFkMUO4
	DCKRZRaI2uNYEiAHe37R8ecFe7y5vgn4hDj3yZYkrQtQimEzJbufzZySOwJuPyNVO7DUBasSjjk
	kwN9QfU97a691h4WRSyJSHfcG2pu9NzXKQc/wVNfuA9Z5Bsq91iKRMc0VwMUOnRM1YASjyAIMrt
	QFT5CBsOnvCdhCT4VCgt+Ao7qu+86RS0lvKo4W7ylFIUyWdlMPy2vzPTE8z9vr7N97VapV0t4lo
	DalPkv9cumpqQpl/PYlESF0fBxC2BYEQsgjeYAGNM1G26sl+6C55WTWRBuzfprP0126KCbdsKfj
	9RGBqMA==
X-Received: by 2002:a05:600c:3e19:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-4533ca66cd0mr176797675e9.12.1750268474483;
        Wed, 18 Jun 2025 10:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIk5j0XUOc2qfzy9nY3G7Nge7jrVSGi6o08YDSv4Mte+xl8dtPQDJlCzuSsfiSc9/ShViabA==
X-Received: by 2002:a05:600c:3e19:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-4533ca66cd0mr176797145e9.12.1750268473925;
        Wed, 18 Jun 2025 10:41:13 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e993c95sm3729315e9.26.2025.06.18.10.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:13 -0700 (PDT)
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
Subject: [PATCH RFC 21/29] mm: rename PG_isolated to PG_movable_ops_isolated
Date: Wed, 18 Jun 2025 19:40:04 +0200
Message-ID: <20250618174014.1168640-22-david@redhat.com>
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

Let's rename the flag to make it clearer where it applies (not folios
...).

While at it, define the flag only with CONFIG_MIGRATION.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 16 +++++++++++-----
 mm/compaction.c            |  2 +-
 mm/migrate.c               | 14 +++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 016a6e6fa428a..aa48b05536bca 100644
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
@@ -1146,8 +1143,17 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
  * page_has_movable_ops() instead.
  */
 PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+/*
+ * A movable_ops page has this flag set while it is isolated for migration.
+ * This flag primarily protects against concurrent migration attempts.
+ *
+ * Once migration ended (success or failure), the flag is cleared. The
+ * flag is managed by the migration core.
+ */
+PAGEFLAG(MovableOpsIsolated, movable_ops_isolated, PF_NO_TAIL);
 #else
 PAGEFLAG_FALSE(MovableOps, movable_ops);
+PAGEFLAG_FALSE(MovableOpsIsolated, movable_ops_isolated);
 #endif
 
 /**
diff --git a/mm/compaction.c b/mm/compaction.c
index 86d671a520e91..809e4395cadfc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1051,7 +1051,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!PageLRU(page)) {
 			/* Isolation will grab the page lock. */
 			if (unlikely(page_has_movable_ops(page)) &&
-					!PageIsolated(page)) {
+			    !PageMovableOpsIsolated(page)) {
 				if (locked) {
 					unlock_page_lruvec_irqrestore(locked, flags);
 					locked = NULL;
diff --git a/mm/migrate.c b/mm/migrate.c
index a36030de94f30..f87a998b696e2 100644
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


