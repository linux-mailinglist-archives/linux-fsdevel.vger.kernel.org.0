Return-Path: <linux-fsdevel+bounces-52067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F928ADF47C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D906167047
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA32FE33B;
	Wed, 18 Jun 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJk6bjMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF692FE399
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268455; cv=none; b=c4Qsu+11JWV70a9d5McwGVLOvoc+6uygHJRS1uPWkkTa73WB1puOcXWtaHcQPAWG4oO/rkn1CNzNuzK6jhDonu1EA2el6uVcfpa3QpzJoamlW08GHau24nizuTWTvBW86c17KxvmBMCJD+qw52GcPPDLuGcoYPt93ug9Mgg20TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268455; c=relaxed/simple;
	bh=kK+1H5O+WM/ACnNcL3KxA88ivXOG9CXAUU38rvMnDO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+eKwaloCauzt6cYSWTg/Wi+eamB2RmiXj03/tlq2rJnOa2y4viVzVydmaRb+9QlgnYi8xQorhb0DQWRhk2Vb1koKP+hNJLWCWfKWS1OuOnZMOhtStLrpmvE/LyZPji9JLay6DMDep1+6Ht5mgACBb00b9Pb6rqZk293jHY6a1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJk6bjMP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdGmEg3KxJkHEQxrZBJZz4koG+H5rtVXjjGZN1RlWcM=;
	b=aJk6bjMPWbz4fo9tanBF/Bn1ScFgtQCU8aABBU+OXvHWGl/p9U0IyOfT+Rf3hWWsryJZna
	MttHCiRmfO03kAVsZKY0plHGlrtW+zqLnDHw5y4VkLsuYXqhTVJ8PT6KaLFmMV+En1/jL/
	i8lHCQ3oSmt7j6MxqmziS2CoGv+6Z/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-zio-VCxsOFGWPRLAuyyayQ-1; Wed, 18 Jun 2025 13:40:47 -0400
X-MC-Unique: zio-VCxsOFGWPRLAuyyayQ-1
X-Mimecast-MFC-AGG-ID: zio-VCxsOFGWPRLAuyyayQ_1750268447
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso43919135e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268447; x=1750873247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdGmEg3KxJkHEQxrZBJZz4koG+H5rtVXjjGZN1RlWcM=;
        b=oenun0bCjdK+boAs0/lfOHnup6SNudTfh6+w2mNXwEcfH6Z8YNTMKoPde+JtP1Zlb7
         8E8PpRYu95EZimKKDFgG1ww+6Snp16KMOvMbpP0LLXKN+X8fJBLfrHG5k1vzLArzrCW6
         hpHqsMAXBsdpDS8VPtvQ3cjOQJAzsanoslehTaXQ4Qy/Q4xvwYkXDY+Z7BDFU2882128
         pJZ+OZYZs2fVa6p1SJ5ayOnYYO04NiUztsBKPhz7YoQNc8cxkdMIck1sKsAd2G2iIV3o
         XznhXlr3LLlyaVsFNTdGezzjyrLqU5shQTC9VVvptWP8JGL80O2Xr4VrWhNBvy6hqlnu
         y+lg==
X-Forwarded-Encrypted: i=1; AJvYcCXZP6pe3Og9HvgKAhI6MVzW7WQyJaVnXcIirm/cWt4S+NOfSYcXR8qGzmmsdqBotyryVCMekZBY9HRZY/sb@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOk6O6k7GZ+UItydnfSQg1dn5wywWmbePwqTNoTC2cZIS3mRK
	h0G0KdwvrB7nC/5uismyy/bbb4MWVbUCljLuWbYpaJj4Sct0uxWfnU9rTUTOgiQjtnpya7MgC81
	Fn0wjs5mqZ5SBFzndB+hOMsRHQkl0YwCQq9UzIPOaV5ir35/rpzyXVEf+2Od11Gi1S6SvO45yJv
	RfFw==
X-Gm-Gg: ASbGncs01dMnqKI4Cn2fKHRAhkvY9kuhjpycy7B0yYfSBfT9/eoj9OeOC3ufyZ3n5oE
	noEyhl6FpaBQDajuWS6187si5oBp609b/6ERe8XLCpaX7cFfcIMGZJmK7K5frfInImie0u2++Ww
	OrP7NYWU0Pn/qh3Du69c1L7WlXhEICsvHLGswAYk/Z596U1b1w52/UJvUMNBMfAKPmyCvrT2Ddo
	RVsW4r2FDVp7Teci04HWZ98TAbm5/lc2ysQN+8ePbi6+67nLwDHBE+aKMHDobWVe65uNUxZQdyG
	SM73IXE/y26twCRRhGSBLI9qYFqLwHj/RgyNT880zYNdns5yNtjqwFNwtkt2z8Eizq2RE9gNJzG
	UsyQdBw==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154403275e9.11.1750268446595;
        Wed, 18 Jun 2025 10:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXftk3ZXBXIBGlT1RpZSgQfC+IysEY/Lblmm+ealanQwQ/CfiKMmfIF1BFjPpj67LfRQmzUw==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154402755e9.11.1750268446175;
        Wed, 18 Jun 2025 10:40:46 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e97aa15sm3975415e9.2.2025.06.18.10.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:45 -0700 (PDT)
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
Subject: [PATCH RFC 11/29] mm/migrate: move movable_ops page handling out of move_to_new_folio()
Date: Wed, 18 Jun 2025 19:39:54 +0200
Message-ID: <20250618174014.1168640-12-david@redhat.com>
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

Let's move that handling directly into migrate_folio_move(), so we can
simplify move_to_new_folio(). While at it, fixup the documentation a
bit.

Note that unmap_and_move_huge_page() does not care, because it only
deals with actual folios. (we only support migration of
individual movable_ops pages)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 61 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 456e41dad83a2..db807f9bbf975 100644
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
 
@@ -1328,20 +1322,21 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
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


