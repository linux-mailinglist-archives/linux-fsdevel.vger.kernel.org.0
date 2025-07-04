Return-Path: <linux-fsdevel+bounces-53927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE1AAF9007
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C201CA592A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF472EE974;
	Fri,  4 Jul 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HID+IQ6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCE2F364B
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624741; cv=none; b=alC97NWnGhSNW5E9T5cLAS1AXj0GupCvcBDKYEWgXbBOF/+VOwFxFvBYgCMVDf4MVL7Ay9TuV16rDtyuiHkB78rBlhRjunD224nzGXGTWnvnWLhra1xnol/LGDOjbXR8gIciiqs3ErAyM40fn5kKAIJdwslg0eC/uBWyg0P1wFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624741; c=relaxed/simple;
	bh=yirVZfO+dHe5+EJCXh68ilzI6s3sApzRdgd2Lx9ZJLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYhO73MFBG0SNkXObI8fAfNbzcDJ3U0p/J28eAEWbwJvuzOj14f5OKrxuoV05PuwbCfnOi3yzkOpfxUuUH4c3Utbt0qMpih5tLTSsEfYZEENEHJCZNLesYlpDNQCyb4hWA7+JmxzD+tjJLi/7ewv2MlLqf27lzKt40+mEuydYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HID+IQ6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km36h+57LoMclmINdAl2JdQwpEFbx1KUS9NaV7ZwoS0=;
	b=HID+IQ6np8J+4Q66FIGqHzB62Of8Do8DLto8/eOeMErlRy1cWwSC/hoodhBR9/gAZ1XZpj
	+wc8QzXsOSH/DiRVFZWVrfWJR3/571Uv7e1V+WGTgQY2ZxYvETJV/vyF+C/JBNo7usuy+N
	F1DsNHuWg0ap0H0aTi/d/TERl0c6j0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-tNuhZ1ZTNMKY1CYqmSRkUw-1; Fri, 04 Jul 2025 06:25:38 -0400
X-MC-Unique: tNuhZ1ZTNMKY1CYqmSRkUw-1
X-Mimecast-MFC-AGG-ID: tNuhZ1ZTNMKY1CYqmSRkUw_1751624737
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d5600a54so6348535e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624737; x=1752229537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km36h+57LoMclmINdAl2JdQwpEFbx1KUS9NaV7ZwoS0=;
        b=sibl2zI7FysOPu0m7CwYutphmUBbKOAQVDk3kvsqWf15IDnfQ0YHQAQhmemT8BERGI
         xS0YousTzvp18iX4/xvziCafhY/RH/x+7276HVuCFa4mR9PDNq8sTCMrfyVjP2UwQqdU
         yzDKKanT77JEmyh1r0jUpovgpUplP1UUcGbYAAfZIEii831Vv5IHg7hC5VuZN3ELkogj
         cLyx4TCiQEgoAshH1NhoW3JCx7Y2TmtJ0L4Ur27BeXrD1LFUfQpmOsJgENHQpv4t7aBV
         legyiMCezGOCmP/YRrPRseM15pTQkWx4vAxsufxSnI0L108y2q6tXCs4PcVtQhxkMpsx
         6koA==
X-Forwarded-Encrypted: i=1; AJvYcCUNTNGLB7B9HxA+yo4HWoq9qh0VY23H2V+5IT8vZm4zzvTE9pAK+aRdz/iGxJFZEtIoG+g6ic8KccAoz2x0@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2VhFSNAHdedHviIcbuSXJe6bsBTbYjgAdCELU1Y6rnmNlQ7Z
	ndpTX1dihVqvRTL3voGc+C9G37zwKrHgksO032BA5XybBrI3W/eEycWy6Cla+hr5hfFxgZnOD+b
	mknpc1WRyIa0ZqoJAL43qkhTssACwnOWoUe+UJW69G0jYvnIVHI54aMnaceHMUKoa9cA=
X-Gm-Gg: ASbGnct4PK8dzkHnVlmTxKDsDChocUePrWYtMYQdGLgyvavA/visI6TAwfNM0CIFs1e
	8q1E06L5EFWJhF6XawJXyGxkczgIdIsOLWsdh+KW1YAQH5mmR5WPQo2EYiOIikEng8YlBaxpQyp
	/Z/tHbLsMM+B/iScMu+5muD3CAVK+N98DbVpZRUP6huhBW4gxFfJ5CuC2TGkrB+fQBjkAr8L5H6
	JbYwqr7gXrzRm/mhfSWw7+Zs9YdvFwlZUGIGTP7RDcY7kX+QI5PiU7li/MGxD6imhHPLqgac9Pj
	GY2Gje91atuaiAZ8OM8tTSuYILwP4jvX52OzGd5J8AmUvMR8hDIqvgQRCB/YE1ZhltXgpowN2RH
	JhH0xUw==
X-Received: by 2002:a05:600c:348d:b0:453:608:a18b with SMTP id 5b1f17b1804b1-454b3096211mr21111035e9.9.1751624736381;
        Fri, 04 Jul 2025 03:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYWTkwuG63kWN2pUNG4mMJ/rp0CK4ANHmE+tpQrKYs+JLvfC5kMT/JJWZ4Z30efeBW784Wqg==
X-Received: by 2002:a05:600c:348d:b0:453:608:a18b with SMTP id 5b1f17b1804b1-454b3096211mr21110415e9.9.1751624735911;
        Fri, 04 Jul 2025 03:25:35 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d080csm2111024f8f.23.2025.07.04.03.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:35 -0700 (PDT)
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
Subject: [PATCH v2 03/29] mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
Date: Fri,  4 Jul 2025 12:24:57 +0200
Message-ID: <20250704102524.326966-4-david@redhat.com>
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

Let's drop these checks; these are conditions the core migration code
must make sure will hold either way, no need to double check.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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


