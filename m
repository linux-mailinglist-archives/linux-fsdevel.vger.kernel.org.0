Return-Path: <linux-fsdevel+bounces-53362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A78AEDE6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C421116C2B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C52D29B5;
	Mon, 30 Jun 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWBlwB3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A322C2AB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288512; cv=none; b=JubjkzaF9CV0r0Fz8GB6DbkgYS7L97FrVSFD9ISk5Zgw7jKOB2M8RGuoTG9lslFReJOL47GZQPm05V4m8ah77tTVhAV5qEFWg48MOvgB7oa9+ouLO6CVl6UHj1Hz+TaQJDMjerCbEZdPecL77IMTuV+O20ERTTTCCVduLUbCbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288512; c=relaxed/simple;
	bh=VLtr/75+OgLg5UKJqAhr4SPpTHq3QNsAl+8ocPk3Nhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlClqVbNZqMuBnlGL8v0c8osfdWAzO5TiQZ3ROSnMePEhDhGuluBR8sSS+uVMVxNHxaNKNS2WHxlPgjFFZeAuJBeG1MlOQfV7AynbXDrQT9wyEeDel1azt9zKykFlmjqqeCgop4pMgL3AsTd8Fxo0W7Q5nQdUhaWxityt0Lzsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWBlwB3W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
	b=EWBlwB3WGoLEv1QfIS+GWKIaqpS/bD28PnGP+fSC29rdEBCRj/69ty7qxiiabb0GqldoT7
	T6EBLPqBCBUduoM0+E63zvCHpOykal1RGhvAJXupdSNUgOVFVyji7RArZpJAGvytmCL3GC
	l2fEYh0JsZeBzcIvZL34e8aW6Wn67Rg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-BvtH1lmcPDWHd9EKy8PCEg-1; Mon, 30 Jun 2025 09:01:43 -0400
X-MC-Unique: BvtH1lmcPDWHd9EKy8PCEg-1
X-Mimecast-MFC-AGG-ID: BvtH1lmcPDWHd9EKy8PCEg_1751288502
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so1975987f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288502; x=1751893302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
        b=bCfGpbm8L9XDHmbOOSx7cWXIXc7BfMcMdbLQQ2ArK7ROG7bk6AM3VxSdOOelVh/M28
         oHvlQPiTqRhASDkEYE1GdfiPGr1v4TnXzzqBDdQor9Bi1N2nsyBprNBz6vlabEqXx/2p
         hDhUY2bvV34gqT5yQKyLHpUOd5Bs6T+FeiB534rRu5L90aZyj68DRFO6KNGOLKkd0Qyp
         o9Q7BXJsgPvUvtPo9CJij/p49B+wMLoUVrQOGd7CeGW4pOE+SLpApy8moJB/4NvnhyMG
         ByLRdF7nwdGrdkjOg6yb9YTA2OaTlw2NTwvmdEOous/ykD+PLyS5EhwNLMRPYMLzHsWC
         /XTg==
X-Forwarded-Encrypted: i=1; AJvYcCULx/YX2Rx9bnR67mQkeuLJZqKXrUQBRvN3C6ZHIihY3h/Ys0YuG9gXaig7LV87Ct6y00XATRlVtU4coI91@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pwXUCZvFjcj6HYfmzpbSgNi6VQDAcyKGGxHKtf5KJHdrOiit
	D37vhkes0PtT95KZzd8cnPGeOxzD39FRuOhAWeaanCc8YPsO4yiytIA0GFs1+YfE0UTIQBs0o6H
	hc/CI8efV40UkWlmCNJpGPxKZrHeKo/D0phG1udJpRj9maEh35okYDMqoiWGx933qV7s=
X-Gm-Gg: ASbGncv6nMblNpRhFirTkpc/dzXut85eeNUVoKIKjAZPyQORPZzwmcMdHAjWIsJd2qY
	AYBSxnCI9bi8IZjp+hc+c/Y82FSUhOEqkt26pmdFCaypBW4Lb9nEfIG4oFgcjVolAMMiLZP95f6
	ucq86GolU0C8hpUvOn5NxzUOYxuLOsmHIFIljuHQxLbi3qAE8HUqEc2D6mptWmLOuPl06wGU7Ak
	odtOFMmE+adLa+QOuVzjqPv3f8jbU6yfOjvFe5lti2redbZi8NsGB+9YOurx04YJ44/FpdlnDiS
	cyRG/4wSvlQ3234u9H40Tz9m4BWBWHjvOQM08Yc8g0c9oWWbxYd733rvKP3l6iNEdHvu+UR/eWm
	Ga8VBYwc=
X-Received: by 2002:adf:9c85:0:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3a8ffcca245mr9545871f8f.31.1751288501846;
        Mon, 30 Jun 2025 06:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmBHmttdmK2eq+WBU1B9I2DDaPMLfI/76nbXYnXDHgExr/7iQPmKv6fPJxJBiz140zN+RyvQ==
X-Received: by 2002:adf:9c85:0:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3a8ffcca245mr9545827f8f.31.1751288501169;
        Mon, 30 Jun 2025 06:01:41 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5f943sm10337130f8f.101.2025.06.30.06.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:40 -0700 (PDT)
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
Subject: [PATCH v1 29/29] mm/balloon_compaction: provide single balloon_page_insert() and balloon_mapping_gfp_mask()
Date: Mon, 30 Jun 2025 15:00:10 +0200
Message-ID: <20250630130011.330477-30-david@redhat.com>
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


