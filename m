Return-Path: <linux-fsdevel+bounces-52084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6AFADF4CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BA13A8CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAD30611C;
	Wed, 18 Jun 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOHUXsvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7730555E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268501; cv=none; b=qd28BCS365/9OkiU64Jyg3sCFl9k0NWRJX7BUKWs/ZK++7NSgAcuFRsFvYS+zRWpA005eKGvwCq5h/WPcZEsrF4CKXstKBzO1Z4uAsjkWfP/k5SBOLkhTaxmIUMw+O+mJzw28Oy4an911Lj4IvUTGKk8d11+KufQj/6B/OqOisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268501; c=relaxed/simple;
	bh=VLtr/75+OgLg5UKJqAhr4SPpTHq3QNsAl+8ocPk3Nhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1SUl1bK/0vJj7x/Dw5sGZ3+ph/avqXrD/3iQt/7knLv+D6L5VHjenUcAnCMOmvBYfFtxDu3MM23MNTM5bfSj2mRSXCcoMyCQKVk+1fhKLYUtmss/IjN/YO/t0yC9hTTOgocJmbPgc6eDDZ177fcmfZVDEyw2AWgL/oFB/KtAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOHUXsvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
	b=KOHUXsvt6EfgH50KD+7ARdFPOE0YXqETJTvRsIig+fEnuwT5ecEki/0ZSeuC70FLXd9BJX
	ONCNVjyv+cNxwfTkv5BCZCV4mhEXH84r0XyEH5NIUWgP1P8JJfM79HrDuKHn0fCc8sm8Je
	bsTeTYoRUEXXtHO8IVV9VJ9YoF0RP/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-ingXx809PdSVGnXGDiGurA-1; Wed, 18 Jun 2025 13:41:38 -0400
X-MC-Unique: ingXx809PdSVGnXGDiGurA-1
X-Mimecast-MFC-AGG-ID: ingXx809PdSVGnXGDiGurA_1750268496
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704d22so46555945e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268496; x=1750873296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
        b=L0EIvmZUJmAex/cf+fIMA5RweA2iDfCfPbDkwrZl4ZwwNn6MTkFeEzVVF6si72mbvq
         fe8hd2OfFoIkKLGBwEy06WJtLvrCu1r7exYD0+VxQgSBxzWP3xikZwCRtuCaLsN9e0uK
         RjzJ3w2e08cY7cUVTyoEIWlh8okMcoprR8pYhMyDLvbRYHWzA9AIsk+jMiufqO3W+wrH
         lkRxAEaxuCbi40gcJUubi15+irU8qraCMYvB23Ka52qzBy8dmLqJbLbyaKweq7d/dvzz
         veUZCGUfrQTJ5Y3hJmPgBw35e03MZwXUmuUmcpgNZOjXSG0zMU77MYxauVVmk7w5Ftof
         EOVg==
X-Forwarded-Encrypted: i=1; AJvYcCXo4rgFL+FdI127MW4axmN+E4LyJLx3uYW/RbtGtWvqsdaVbhA8D/707aayh0WDLVcaMLwa4BPCN1+yfPEd@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUnE0nmLCjyL92dHKPrkQ1HIGqQpps2sz8u0gDEHCHdR40DGf
	X/3oOqeuakBoykjRTpzc0Kje5l3L9skLxHI0EeOS9khFBRzgGeFjKTNfA15196015R5WKboUCEv
	YSHBnPGH4SEjbcJntBGAKWjdoha4PY9WZ64ISgCidrcdNxf0OJMQs7PDEZlnZmv+Q2tY=
X-Gm-Gg: ASbGncvfwtIUIVhmrf46aCos2fEiUQEclMRjvX4jPqoYk+iFATJ6yRXI4RdiihQVyJk
	uTZJke4V4JOddlRcWgRhtWrKJAUirZHDPcnZJcp7NVegvWFYRT7E2KtthoY5a/42n5X1KstXScy
	1YIPlIebYmr7SzQQ8uyEOeKnHjKd1f9vyulBAGUZp7sy+DVivKKhlF6bcZGyMqW5mae1AmQqvV5
	7eJeTJsQVXfbV6tUKSxhfBxPyBRrPO6mdA4buLqHSGNMjXgAFgMY1aXGRe86KScav1lw6mPqEmc
	mbMvEqXVdlM2szAl/yURtfq7UPcgBo2iXW2fWB4fh6FiQFo7GFbc5WQG/k1eoeFzlaC/aI5GGpI
	lIaDZaQ==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154424115e9.11.1750268496117;
        Wed, 18 Jun 2025 10:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJSoFqz4Qx4eaIpu3abT7lqqTMcn+cWB1r/wxQDnmsMcckQg5l2MzM3eBNzoSDxLAyECFAg==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154423805e9.11.1750268495716;
        Wed, 18 Jun 2025 10:41:35 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535eac8edbsm3459385e9.24.2025.06.18.10.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:35 -0700 (PDT)
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
Subject: [PATCH RFC 29/29] mm/balloon_compaction: provide single balloon_page_insert() and balloon_mapping_gfp_mask()
Date: Wed, 18 Jun 2025 19:40:12 +0200
Message-ID: <20250618174014.1168640-30-david@redhat.com>
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

Let's just special-case based on IS_ENABLED(CONFIG_BALLOON_COMPACTION
like we did for balloon_page_finalize().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 42 +++++++++++-------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 2fecfead91d26..7cfe48769239e 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -77,6 +77,15 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 
 #ifdef CONFIG_BALLOON_COMPACTION
 extern const struct movable_operations balloon_mops;
+/*
+ * balloon_page_device - get the b_dev_info descriptor for the balloon device
+ *			 that enqueues the given page.
+ */
+static inline struct balloon_dev_info *balloon_page_device(struct page *page)
+{
+	return (struct balloon_dev_info *)page_private(page);
+}
+#endif /* CONFIG_BALLOON_COMPACTION */
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
@@ -91,41 +100,20 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	SetPageMovableOps(page);
-	set_page_private(page, (unsigned long)balloon);
-	list_add(&page->lru, &balloon->pages);
-}
-
-/*
- * balloon_page_device - get the b_dev_info descriptor for the balloon device
- *			 that enqueues the given page.
- */
-static inline struct balloon_dev_info *balloon_page_device(struct page *page)
-{
-	return (struct balloon_dev_info *)page_private(page);
-}
-
-static inline gfp_t balloon_mapping_gfp_mask(void)
-{
-	return GFP_HIGHUSER_MOVABLE;
-}
-
-#else /* !CONFIG_BALLOON_COMPACTION */
-
-static inline void balloon_page_insert(struct balloon_dev_info *balloon,
-				       struct page *page)
-{
-	__SetPageOffline(page);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
+		SetPageMovableOps(page);
+		set_page_private(page, (unsigned long)balloon);
+	}
 	list_add(&page->lru, &balloon->pages);
 }
 
 static inline gfp_t balloon_mapping_gfp_mask(void)
 {
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		return GFP_HIGHUSER_MOVABLE;
 	return GFP_HIGHUSER;
 }
 
-#endif /* CONFIG_BALLOON_COMPACTION */
-
 /*
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
-- 
2.49.0


