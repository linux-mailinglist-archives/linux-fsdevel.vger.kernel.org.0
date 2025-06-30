Return-Path: <linux-fsdevel+bounces-53344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DFBAEDE17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAEE3AE1DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996BF28D836;
	Mon, 30 Jun 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh5iVlGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000228C2D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288457; cv=none; b=atqaxq7BKNdW1mhl6XZPOzkl/uFFcyqKsrO8zbi1j4QX17EflIH9WCwaM5kbpjcgoReaXZT+IVOh1YseSRs0qalFaalYyfVMmzp3v5ZBUQT4nf+eu0CKEk/E9J4tmNiAxl5128rYyx3BCY3oZpmmW92SuBaSPEy2CDnWIFE1PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288457; c=relaxed/simple;
	bh=eiWjuQAK343S0iGCo5U1CeA1xAD7ABzULSg4BICmapk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMq2SmhzH/O00nWjexS2NvonZBIEiDXcw8nwwVL6PHs2gkayvTY6GmuQs0oLtzZzwL89JdELZRy6N4o3LON+wY+2VhIyyl8eRirMK8Ui8KcznjsrDYBu1zK4xgf5CEyDtrJDxPaktTd8NYL7I7zv3MZPMPoDC5TKooZCX4eVYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vh5iVlGA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjlP0D3eY9tZf8Nb4qLq/i9Tdq3zqU6lo6GiM8rDh3E=;
	b=Vh5iVlGAKYGrSjxrLte87XYhV3K/lictV79Shvr7NEB8tXvcxkqLBJALV1z1iT7GhrBALz
	KN8odFF7Aqpqsq7sM5KrgGNYA8CyicgmGKSqxtxz2f085zkHzmccwhynfvchDoM2Rmnetp
	1QQ4B33JN+8QHZW/47hp3y/zlOYFoUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-z_Ez-ej0OdCnukCMxY4y8A-1; Mon, 30 Jun 2025 09:00:42 -0400
X-MC-Unique: z_Ez-ej0OdCnukCMxY4y8A-1
X-Mimecast-MFC-AGG-ID: z_Ez-ej0OdCnukCMxY4y8A_1751288441
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451deff247cso25978515e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288441; x=1751893241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjlP0D3eY9tZf8Nb4qLq/i9Tdq3zqU6lo6GiM8rDh3E=;
        b=AJUHyZnETXjeiiaG0e0LfgySwRD/+T2HJwI4Nz80aFDENqYId8Qgu8X26I2P+IyuWq
         DZssd5mTR9n0coHkNU5LJHQU01gcreekBAbiLNh7LB+OPi/s8vPTVOYXHWGtF8wBdNhz
         yfsS5WDaKqHreC7VpDqIpPrdDV2PJEvlpgpMKkX6d44QnTDuwS6ltzEV8cvyEoFMmrmd
         GcDh6L+tvRF9MOJmlKS4z1Hgp2BmB9vMKsSreLjSqY78cP33WKVr8bJ1RCvsVd6K8J7N
         DJCzT0F02nB1pG/MgBECA+dxKJlKyats/I1bcqkpaxhmfdHPHMMSNyUE1FcSLAiY9V/Z
         tijA==
X-Forwarded-Encrypted: i=1; AJvYcCWd4gl/yyJC09E8ImJ3L3lYCSwdpYwMBTzsyJRo8oWjj9MfGo+faJtHXdDT0X4yeZdUPtdtD1fVaW66RpCX@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKq1vHDNWgqmyi0a9HwhBf32SBAslhk0TiuDdlMMcy/24zAWe
	qZatjLYRaaPW1LCVW+GTouTT86tufcqoujKo25lm6/gRJ3TWX9yNeP+ShbOmuGEej4TLF42QgRp
	omN5zqFf71IH1gTtz3v8Z536JRyJzdmWIwM8fK1p/UVFsVqdBqlQYrmxc8m0rovL106w=
X-Gm-Gg: ASbGncsyWeaW+dJMD7AWYOi4namB221GcfCJET2uBD0BQh1/rNA3hbyDqxWyry+L84U
	J725fhdx71pwUB2TOx7V7a1u4xrLsh30NPvbr020PZ2I9JuNhNilSxjQKkZdI17kDwAS7RB6qm8
	GKg7fIKmhKcVcEO+ZeQzojlQmZ0zhieM27Fo5mraUUOGtykOeSPBntvEXAoFLZa0iHjMVs+gWf2
	BmDjJpAlLBoWXnucybsD5J/QIpjasKH0DTzIa5p7G0u3T+R6lDPzFpZ5ccByI81c14meQdRXPYI
	dySbwtpGduFJT1t9AT7PQGUp4rSlnuL6dLXMOz4lESrm8cfS3z4Yh1SmloiwDxLsk4OlL4HDPxx
	0FNF46G0=
X-Received: by 2002:a05:6000:200e:b0:3a6:daff:9e5 with SMTP id ffacd0b85a97d-3a6f31023bdmr13743589f8f.7.1751288440456;
        Mon, 30 Jun 2025 06:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaNYb3ONKvqKvr320nfpncqFiQLJi8PiPIyho0Wzz9N7dVDIemJ3QiyBdfpFdZCgx38anKxQ==
X-Received: by 2002:a05:6000:200e:b0:3a6:daff:9e5 with SMTP id ffacd0b85a97d-3a6f31023bdmr13743499f8f.7.1751288439567;
        Mon, 30 Jun 2025 06:00:39 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e52ca4sm10445235f8f.58.2025.06.30.06.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:39 -0700 (PDT)
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
Subject: [PATCH v1 09/29] mm/migrate: factor out movable_ops page handling into migrate_movable_ops_page()
Date: Mon, 30 Jun 2025 14:59:50 +0200
Message-ID: <20250630130011.330477-10-david@redhat.com>
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

Let's factor it out, simplifying the calling code.

The assumption is that flush_dcache_page() is not required for
movable_ops pages: as documented for flush_dcache_folio(), it really
only applies when the kernel wrote to pagecache pages / pages in
highmem. movable_ops callbacks should be handling flushing
caches if ever required.

Note that we can now change folio_mapping_flags() to folio_test_anon()
to make it clearer, because movable_ops pages will never take that path.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d97f7cd137e63..0898ddd2f661f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -159,6 +159,45 @@ static void putback_movable_ops_page(struct page *page)
 	folio_put(folio);
 }
 
+/**
+ * migrate_movable_ops_page - migrate an isolated movable_ops page
+ * @page: The isolated page.
+ *
+ * Migrate an isolated movable_ops page.
+ *
+ * If the src page was already released by its owner, the src page is
+ * un-isolated (putback) and migration succeeds; the migration core will be the
+ * owner of both pages.
+ *
+ * If the src page was not released by its owner and the migration was
+ * successful, the owner of the src page and the dst page are swapped and
+ * the src page is un-isolated.
+ *
+ * If migration fails, the ownership stays unmodified and the src page
+ * remains isolated: migration may be retried later or the page can be putback.
+ *
+ * TODO: migration core will treat both pages as folios and lock them before
+ * this call to unlock them after this call. Further, the folio refcounts on
+ * src and dst are also released by migration core. These pages will not be
+ * folios in the future, so that must be reworked.
+ *
+ * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
+ * code.
+ */
+static int migrate_movable_ops_page(struct page *dst, struct page *src,
+		enum migrate_mode mode)
+{
+	int rc = MIGRATEPAGE_SUCCESS;
+
+	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
+	/* If the page was released by it's owner, there is nothing to do. */
+	if (PageMovable(src))
+		rc = page_movable_ops(src)->migrate_page(dst, src, mode);
+	if (rc == MIGRATEPAGE_SUCCESS)
+		ClearPageIsolated(src);
+	return rc;
+}
+
 /*
  * Put previously isolated pages back onto the appropriate lists
  * from where they were once taken off for compaction/migration.
@@ -1023,51 +1062,20 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 								mode);
 		else
 			rc = fallback_migrate_folio(mapping, dst, src, mode);
-	} else {
-		const struct movable_operations *mops;
 
-		/*
-		 * In case of non-lru page, it could be released after
-		 * isolation step. In that case, we shouldn't try migration.
-		 */
-		VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
-		if (!folio_test_movable(src)) {
-			rc = MIGRATEPAGE_SUCCESS;
-			folio_clear_isolated(src);
+		if (rc != MIGRATEPAGE_SUCCESS)
 			goto out;
-		}
-
-		mops = folio_movable_ops(src);
-		rc = mops->migrate_page(&dst->page, &src->page, mode);
-		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
-				!folio_test_isolated(src));
-	}
-
-	/*
-	 * When successful, old pagecache src->mapping must be cleared before
-	 * src is freed; but stats require that PageAnon be left as PageAnon.
-	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		if (__folio_test_movable(src)) {
-			VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
-
-			/*
-			 * We clear PG_movable under page_lock so any compactor
-			 * cannot try to migrate this page.
-			 */
-			folio_clear_isolated(src);
-		}
-
 		/*
-		 * Anonymous and movable src->mapping will be cleared by
-		 * free_pages_prepare so don't reset it here for keeping
-		 * the type to work PageAnon, for example.
+		 * For pagecache folios, src->mapping must be cleared before src
+		 * is freed. Anonymous folios must stay anonymous until freed.
 		 */
-		if (!folio_mapping_flags(src))
+		if (!folio_test_anon(src))
 			src->mapping = NULL;
 
 		if (likely(!folio_is_zone_device(dst)))
 			flush_dcache_folio(dst);
+	} else {
+		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 	}
 out:
 	return rc;
-- 
2.49.0


