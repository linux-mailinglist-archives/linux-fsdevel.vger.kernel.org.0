Return-Path: <linux-fsdevel+bounces-53347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E8AEDE25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7893BF41F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFED28DF0C;
	Mon, 30 Jun 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5rurdzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3028CF5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288462; cv=none; b=Sb2VXX9lrWuZa4ybT0dX1me4vDMlCC0mHTGzMrUmCXLQJkY83R94U0T15ifv4Bg7GM/BqoiwJPHi6zqvPGHz3y3VDNOoPYoWCvI1SmGiRTmxiWftbQEfNPZ3rdqjJCtoq2ZI3zPczlA6juT4Uju+z0KSal2sDKsAfKMAcHeVXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288462; c=relaxed/simple;
	bh=UHifpKu5ufl8QF9rCxhzhbIhhsXhSiIoRV9644qN9BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+iVO8eK0HCAE/S3H8Ogu46pRZPnEzeyupvk7vXEQDeLmPSDIosnNPvSUvZI8dORPrfWTS5z+f0HxOJj2hIPn4Citvc/wSjLW+RdaAICc0vqBH8OjHuMqgJwwANYOXoZm1dyiM+xl48YxnBzoqbzki3+3YpxponSSeBeJtB7B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5rurdzV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRChIqxUOgPOieQj0YeNNw03RDlWoIXMOrbpFO40kH0=;
	b=G5rurdzVGwhZHQ87CgluX65vvis+FjieN3xLHL7aqgzbMicHY8tcckwLVIkrvklWYRaRzJ
	K2Svd7duSYvn9EGRlWq/alAC1VBAe1E+hkEMO2Gds+YBE5PTUAHWBhe8rh3h3h5jodVQUa
	ceGOBc0Kz5znT7Up4kFE/VTPfD40IOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-AfakYmdAPNSk1ppGsq7Czg-1; Mon, 30 Jun 2025 09:00:55 -0400
X-MC-Unique: AfakYmdAPNSk1ppGsq7Czg-1
X-Mimecast-MFC-AGG-ID: AfakYmdAPNSk1ppGsq7Czg_1751288455
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so15320985e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288454; x=1751893254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRChIqxUOgPOieQj0YeNNw03RDlWoIXMOrbpFO40kH0=;
        b=woyjLl9z7VDi/RmaCeRgm4zKRKrxcHQpzSRt9N7D5L+hNcsvO4LfIM8ioTeCTEY/dY
         oYpUhCuBoYWtPrq4EL4AP7P4dhN4yr0iIdhDjyg2cc/6ErakZDvSWH36phgR9sNFE/wI
         lsyxi22g7tYeMw3PgcCKN6y3+pdn6YlxDngudfMuNkkI33SO6+EZ+iwPBkNitJ4e5j9Q
         0DlXAa0fN9dGyOBEIoqsqhuXKYVGb8JQOk7L54kHOGdPODGbFxHnIL8L3bszq8YhZYN9
         MLdgAnAphS/3bojV1JBCdyiCMTxc8VCU9lULh/dS96QenV+RFUCnCenIKYIGq0aRMaoy
         8mpg==
X-Forwarded-Encrypted: i=1; AJvYcCXAfEpqFFk6IvW2XArv96GIiJHc1YsilQkwKmEBBkmYfpmSRkWTjLx6mup+PZHftDwlR99DRY9yLK91RhJ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyOk8ceI+I7qoMiHdgVNOUdsRBRTvJ41UKIojjlplXimO8havYn
	vUddaC5MHufybYSLn7feSC90KxyrwFoDSgtzFbcsU3lG3Rg0r618JsLu1Rg3zelj+PRoUN429qO
	L5Xe75GgTepaUo911M9RyeBXzAeIYyX6A8JTOdMAtvhvfHUHJ3DUzJm1UIHQL2YTIAec=
X-Gm-Gg: ASbGncsJFSADP1MKCzHmoTPpNXOhSLAvxcUsmLRC6QEK6SQpM3qwoUy2UF7pknvbzjn
	X9BPNbOJd80Rz+e6QzWiu4DaE6Ug4MW6Vb2bWoZH6JaRxuPo3NFWM5PTb5oZh51OlnOcEUvwjQY
	yejCZrYfkwxALg9ZLcZQwgVdUwM99rCoFK6j7k+XkFfic+SdbWfB9BKc9ujZS8FZwP8+xWHLjNN
	KI6AbxNiQll7maPSToGdrwgOmzFooQcMv2sU8UXG4f2As96Bn2C4YeigJSoC+6YJlRQjTEt3xJW
	k1VJ2BvsMflx1PVEtop3AuZ4XThnzQyhHAY9q8Nb71tijdY5oe+Ets7ZXdX/aSP05MgwZgK6LP9
	IDMjfqt8=
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120798145e9.14.1751288454007;
        Mon, 30 Jun 2025 06:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZHtsc7XNjhOjxkvKCZ2uHLxZSkMRI4G1PqHHBjrp6rzXGUbjSQmg1iO1pCKPy78A7k9Rgqw==
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120797265e9.14.1751288453316;
        Mon, 30 Jun 2025 06:00:53 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e59ab5sm10144896f8f.82.2025.06.30.06.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:52 -0700 (PDT)
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
Subject: [PATCH v1 14/29] mm/migrate: remove __ClearPageMovable()
Date: Mon, 30 Jun 2025 14:59:55 +0200
Message-ID: <20250630130011.330477-15-david@redhat.com>
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

Unused, let's remove it.

The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
still mention it, but that whole docs is destined to get outdated and
updated by somebody that actually speaks that language.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  8 ++------
 mm/compaction.c         | 11 -----------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c99a00d4ca27d..6eeda8eb1e0d8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -35,8 +35,8 @@ struct migration_target_control;
  * @src page.  The driver should copy the contents of the
  * @src page to the @dst page and set up the fields of @dst page.
  * Both pages are locked.
- * If page migration is successful, the driver should call
- * __ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
+ * If page migration is successful, the driver should
+ * return MIGRATEPAGE_SUCCESS.
  * If the driver cannot migrate the page at the moment, it can return
  * -EAGAIN.  The VM interprets this as a temporary migration failure and
  * will retry it later.  Any other error value is a permanent migration
@@ -106,16 +106,12 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #ifdef CONFIG_COMPACTION
 bool PageMovable(struct page *page);
 void __SetPageMovable(struct page *page, const struct movable_operations *ops);
-void __ClearPageMovable(struct page *page);
 #else
 static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
 		const struct movable_operations *ops)
 {
 }
-static inline void __ClearPageMovable(struct page *page)
-{
-}
 #endif
 
 static inline
diff --git a/mm/compaction.c b/mm/compaction.c
index 17455c5a4be05..889ec696ba96a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -137,17 +137,6 @@ void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
-void __ClearPageMovable(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
-	/*
-	 * This page still has the type of a movable page, but it's
-	 * actually not movable any more.
-	 */
-	page->mapping = (void *)PAGE_MAPPING_MOVABLE;
-}
-EXPORT_SYMBOL(__ClearPageMovable);
-
 /* Do not skip compaction more than 64 times */
 #define COMPACT_MAX_DEFER_SHIFT 6
 
-- 
2.49.0


