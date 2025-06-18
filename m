Return-Path: <linux-fsdevel+bounces-52059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3118ADF43A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D09177D91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D572F49E8;
	Wed, 18 Jun 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnw2ItgY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F372F3C15
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268434; cv=none; b=Wx2dMNx3FD6OWQyh6ShbP25Quy0UDpTJgv+jT0OzryJ4Dryj7lV3Y8nIngeXdtjFSArIfNKUsT6AlN0grXh7wWF3RTSkxgUSLB3vKaADLXCe0Z5UJT7HIotPlizDUH1tZPbjgpbe0gU4EiCkRBFI9wQjqEWKcuVWMMbvueUkf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268434; c=relaxed/simple;
	bh=LoSKhKhxUdNaBIY5unlgO/URzAbM3vnT3E6jz3vT77c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GokeC3cGhG91RucPXsUUSitzHluGkqgYA6Lmq3vnMHq5LC0247oMjnVf0Hs9e5N9fsPr0SUtqUYdAcIkahcJno3225mBRoLGAMVZ4zhySYoPF12ohlcA9T1wlZ9JWklnDkied03oKJRFVYRo/n/pKDuhB2bnga+0qms+NWqhLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnw2ItgY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7FgUVlGmmQh/Fden7VOoWF093l0D6F2nUhdFZr7YaQ=;
	b=bnw2ItgYneYTNugiLoSh7womXWjhX7+jJWrkBqyrZdc8ohR7pEJXeVxJqQ2msEcWaOJS/n
	UVThEk+LyVvoi/WLXYIuRbRG34RzwtYUC9NsZMSxmCLhlIhWOYif551WXUUYi4KCNAes+B
	v3+hKeGfvq1dpbR4tpQSAjTwz3Ix9mA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-cSvUAjBvMi-miEN4rgGS-Q-1; Wed, 18 Jun 2025 13:40:26 -0400
X-MC-Unique: cSvUAjBvMi-miEN4rgGS-Q-1
X-Mimecast-MFC-AGG-ID: cSvUAjBvMi-miEN4rgGS-Q_1750268425
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso3544943f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268425; x=1750873225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7FgUVlGmmQh/Fden7VOoWF093l0D6F2nUhdFZr7YaQ=;
        b=FGlYVaNX0uN9WVfSg8KTDgiJM/5nr62Dgmx9fgTZBcIyaIkjcPpwNZaiVa5Ga6IKtA
         YqSCoOSRc3/CkHAN+3t6AvwfQy9ageuSylYu4NMSNSnCttgUaDbwfzvKiXofYTIhy+Rq
         2yor6DBvEezOH7w0WnuWWAh634G99QfjQeU1QTmTbqVkDZeES2yF5feyGpi3Ks3VjE7v
         KMMZuEPcSi51yg2pbTCkDQQNl9i4NQ7gD3zFII0UNTkuUi65zA7wxM1wRFgV3/u7eJt/
         sFGhQ+u30g2VeUcjJ4XyNLlBLpjF8Acno7f+6g3E7qCeHlcjefMMcXmEAHKAatQiR1sc
         p51g==
X-Forwarded-Encrypted: i=1; AJvYcCWEPACFDebPfYVqxIL/zqXlObQyuTibX0aFnYfwOewVviptIGE4XKa0OTVvYRJyX+mMG5nWc4G2td/zrmvY@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgrYiTE4JUujPwLeY93Q+NkZ5UO2lZNDkiougq7b1US7l5ZcM
	hLAIkFHeFMXG4y9LHeXwAjm8q1aH1SRFopiCf/xRJGzaKuy9ybS419S7MC7bVDfjYc7dBDl/pE8
	2LWt2MMcDcOoSvvkTAlO5rjA8Tm9zje1/Ij0ic/UgXPZ6rY4ax9UCpXfqJPc96kkoyEI=
X-Gm-Gg: ASbGncuAvqNrlbPxzpKEYsF26BcLbzfBuildH6Gfdfx37OK3m7965dh3R5SSoT8Z1yG
	eCmSscpNknaSqUtUzj0Hf5iCKqtlaCyJAnHpkbXmisWE7erMetMzyIUVwT58TZ7wFEsGs83zIGG
	peAB0IlP7ju7EKrJU86R/kVF57VcMWyvlpdOjRLMDcOaHEgRqt7WJq0o52+BI/XOxFVj5GoAng/
	eipLw6arTOadbmSAmYYQhub8kUauhJMHtWBu6lhlOS3H2qPcvSyXKJqhVDLAH9cTjYw8cQOsGNG
	/PXyiMq2wLRjympr3PjbxNU1IN03viyP7KRR4wa2T2Gn2YtGeW9BCIRcLlBa7/71JbJprUQ74dw
	hoUIqtg==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:ed2f:e80c with SMTP id ffacd0b85a97d-3a5723a3f92mr15706255f8f.31.1750268425272;
        Wed, 18 Jun 2025 10:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEayKPP2LeH5F/Ng3XTSzlfhGIAIvFkyNEolXxAmF4Ok7MzyUOG21uTMpu2qvZTdT619UlY2Q==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:ed2f:e80c with SMTP id ffacd0b85a97d-3a5723a3f92mr15706239f8f.31.1750268424824;
        Wed, 18 Jun 2025 10:40:24 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a547ecsm17734777f8f.17.2025.06.18.10.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:24 -0700 (PDT)
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
Subject: [PATCH RFC 03/29] mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
Date: Wed, 18 Jun 2025 19:39:46 +0200
Message-ID: <20250618174014.1168640-4-david@redhat.com>
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

Let's drop these checks; these are conditions the core migration code
must make sure will hold either way, no need to double check.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index d3df316e5bb7b..5cb7e3de43952 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -168,11 +168,6 @@ static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
 	__ClearPageZsmalloc(zpdesc_page(zpdesc));
 }
 
-static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
-{
-	return PageIsolated(zpdesc_page(zpdesc));
-}
-
 static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 {
 	return page_zone(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 999b513c7fdff..7f1431f2be98f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1719,8 +1719,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
-	VM_BUG_ON_PAGE(PageIsolated(page), page);
-
 	return true;
 }
 
@@ -1739,8 +1737,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
-	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1811,7 +1807,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 }
 
 static const struct movable_operations zsmalloc_mops = {
-- 
2.49.0


