Return-Path: <linux-fsdevel+bounces-53356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC3AEDE47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC5B189E51A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36948292B5A;
	Mon, 30 Jun 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bej5uMMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD3292B58
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288489; cv=none; b=EAaPNA/coadMsKk9+bnTj56jlz/XG2S7B+9TWsFL7sBDcjvUCz7gPSjlE13fRcSPIa5pklOOsmRfnMU82j40WgrcRjVBCGe5fs8isqlRikn55Qe9B8XXGqcQWhDSyuGGfrKrjaqRMvdglhDuudfWvVTv16w5zYX2uOHimegU2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288489; c=relaxed/simple;
	bh=dmz2lbFNKy/5bI6qe76v2+ePPpX7/2WN9a22IrkHZ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP5qgur3zJTXWIK0Q+74vglOEXa8kWX11KLypAR6ZrXPWdKt+nMHUuiznXKlWfknj9HdhzIqQgTs/p9nc1r2EywiBa9ObuokrQ0awpAf8t9EkggF+pNo2ndSPt9/Qf9MgDoB7mF/27QPFRKA3aDw4EaIFrJx3JidOd+C7yrFZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bej5uMMS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QasDl39udqF142inQM/Baaw9xGb/E/13xzKchOHRQc=;
	b=Bej5uMMS5kYaG3COP+S0QRNMQh2OxxllQ8OsZ1Y6iJKksAVWHyFRMoOTq53Xel0Dq7gz/8
	Q54oSsCsbsx9OLOopYyT2A33Y7GyZlrs7M9ChEkGj5Voqr2yzNHCycBdfpqzEuvNv9jvzj
	WN2rE4zuUoz/rucJTSB08f8JAEzC0BU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-mTFXikjmMd2md3_pXf_prA-1; Mon, 30 Jun 2025 09:01:24 -0400
X-MC-Unique: mTFXikjmMd2md3_pXf_prA-1
X-Mimecast-MFC-AGG-ID: mTFXikjmMd2md3_pXf_prA_1751288483
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453817323afso26457325e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288482; x=1751893282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QasDl39udqF142inQM/Baaw9xGb/E/13xzKchOHRQc=;
        b=pVt0DEvZC8qsLiIaQpNE4Ftl88LITgxJNhhym5SmNo4+vu19qpM7DQ0+1oJ+bIv9yn
         VEZsRui7TpFQLErpS2kKTZLYJpiBtZyfb6sC1SqdZVjWXMwjEp2Pc/L39+KwXy7Pt41Q
         oRSSVfX8ZdYjaaqlwmrX5FMxQhk0zjy3hCHYUkZUrNz+f9uRMKqEQaNY660LIL20B6q2
         DeRpYMwN8KRujCiQTXpp+6JhMndYen61t7sjk8Lc/xThmDr3b9gQgJGkoOB1En91ztaD
         /Bs5YRCgMugclF52FKI/tbspktAgf2lv8bzOAlGDLRWA17ssm0V97dL3h4SznNc7/aPb
         YRFw==
X-Forwarded-Encrypted: i=1; AJvYcCXr1ZfklO1H6kUjZo5Md8bYG/qafxeasH5rUDxoNwjl+72hVTqCtcdu8msDd5pWEbuGnJJssNXKWwujKXWh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GS6p1hU2kSviYyhzv4ISynourXo7VLVQAFkaeoKuZm44tTYr
	1sBl4fWvmMjic2cUTd9Myy5xo1VNg5uCSxj0x+BJO6lRHVTzhywZzQk+tKQfm4FZB+hIgx2vGyP
	xTus0q3MWMkek1zASjZNzDXk17k3uxl/hjH8+xW3oKR03qe9MKIZ6kzsuYRj3Tl3xcik=
X-Gm-Gg: ASbGncvzmh+JUeOfxjfBMkaAAVgr9Sm8+x+cO5sgGJsuepzYzWF610tnqtNx9JVTzNN
	Is1qrPDfLq4+Mqbl9CbPHFNjzZqq1F3q5ZHCQhFg+7uYcnC/Hd4S61vShciTk8XIrgp8h23hqw0
	WwhBDuVy8eEUGYSxkQfDsz35VlXK8ylhPH5CBSDLQlr69+JZRBW5YO+n67u5gwsnIShpyOaviQa
	MDz5WL03ELkU26ZLtTO2NWf+X4tRBazuIZ5ENlGemVult0XbpK6GNYYZgq/4kasgcqfBkd+/Icl
	Qkll6Psdt1YWeSLQ9TIh5QRzM0taxibyEVb6NqyS9MFA7taEszwZESx/OTV4B1S/Pcry6YBDrEd
	qnrvDA78=
X-Received: by 2002:a05:600c:8b6f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4538f9b3107mr110835055e9.6.1751288481840;
        Mon, 30 Jun 2025 06:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBR/gPcUn8RUWOgibmcJHz2SRyFZ4ktYe9xvVAqHy7XBBioQHhn6lWeSN3C2mJi+xEdsRK1w==
X-Received: by 2002:a05:600c:8b6f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4538f9b3107mr110833985e9.6.1751288480607;
        Mon, 30 Jun 2025 06:01:20 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad0fesm169286405e9.25.2025.06.30.06.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:20 -0700 (PDT)
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
Subject: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
Date: Mon, 30 Jun 2025 15:00:04 +0200
Message-ID: <20250630130011.330477-24-david@redhat.com>
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

We can now simply check for PageAnon() and remove PageMappingFlags().

... and while at it, use the folio instead and operate on
folio->mapping.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 mm/page_alloc.c            | 7 +++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index abed972e902e1..f539bd5e14200 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -723,11 +723,6 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline bool PageMappingFlags(const struct page *page)
-{
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
-}
-
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a134b9fa9520e..a0ebcc5f54bb2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1375,10 +1375,9 @@ __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
-	if (PageMappingFlags(page)) {
-		if (PageAnon(page))
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-		page->mapping = NULL;
+	if (folio_test_anon(folio)) {
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+		folio->mapping = NULL;
 	}
 	if (unlikely(page_has_type(page)))
 		page->page_type = UINT_MAX;
-- 
2.49.0


