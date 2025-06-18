Return-Path: <linux-fsdevel+bounces-52070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D807CADF48D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78810170A48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B7D3009A6;
	Wed, 18 Jun 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4qXCSVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8132FFDE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268463; cv=none; b=J0QkOABL/9OA4CfqNKCmWCFE0wsbv8WPPEK0x4WxGe3AGxEBuJvNFv+S9GymbBxVDzX04PuPL4ZcWnkzosVXpeTjO0jCkDkKeFNuW3kBVqpe4AULwfggXlSsHBESjS15l8pEdoJpx2GLNR9c1+1kY5wNg4SVYYOKNoYb6nkKiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268463; c=relaxed/simple;
	bh=ltmtOsj6PvpW+vjN7IqM0EXe8b45WiKSrK0SISC1AKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPTsjXBFZS1X17tItlW5Tnhn8wma8AMemUYBMr+QF1p3SCd1X34s5MPdNxbO7C40n36x5mFc7N7eeF4wi8jB/yEKRXt2OX1mr91KJnA5BrtrcLlMo9BYpV87pbvHpTwwaQP3lE8TLGmekcNPcop1nx+SRW0XFZPbxMZokCOFILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4qXCSVT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R518sUXauciWuWBIWO47EfDSUo24r+YyG2S8Z5J8Wko=;
	b=N4qXCSVTOqS0jmWYH8loTM3Uk4emj/K3JX/PUFypyYUko4RxqE1/MjxjURE8tTI06Wp2n3
	WM7zz4AabxtD0FBbHI20CDp0/mMIme7TAoHX2+KYut2eFrtF1NQk4F4i/ZsUGWoqm4X0+F
	TLtKWC8xikiMpOI2Aro095CFCxrqHlc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-unA0L1ObOR2xpMt9C7z8zg-1; Wed, 18 Jun 2025 13:40:56 -0400
X-MC-Unique: unA0L1ObOR2xpMt9C7z8zg-1
X-Mimecast-MFC-AGG-ID: unA0L1ObOR2xpMt9C7z8zg_1750268455
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso43919675e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268455; x=1750873255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R518sUXauciWuWBIWO47EfDSUo24r+YyG2S8Z5J8Wko=;
        b=gI5rkalAVYO132+aUDvwEULL/7wdxO/pac8NEOrWkFka1tUB4qMv7JAop/zN41Us9x
         skmBRHHjCalSeBhf8gg3kG1no+TLb4hWSDvQ0u7gBqa8POlyGZApGaZoooIE96TVirxg
         3WqyHrcVp0LytjA14Tvwhn1LXgv0GaeFs1KYAR8kuOivGdCPqD7QO+8y2oT1r9NQnfYt
         cXAnCFGPewO8YPLYqAX8iTOQkotkNGnXbx4ttzPIqQ4hsk+7Wx+r9A0xvhQco2QRMn2z
         Gmn/GO4Fn1ibpHBomQFDr6kdAd96bJLhu4f2XR1+eDNDWquDWC+vqHhLVT0vACl+wyt/
         LqTw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZkLo3TNbGvy8+RM29tJmuXdZhdIB16DCNDsHcFNEUfXv1DHN0RBeWdlPRki36ShVdBOrMwK4lN5m1dxd@vger.kernel.org
X-Gm-Message-State: AOJu0YxHl100YQM+d4a6xJXVzhe8vgYyWnxM+/QzGMMuU+T56QTQdsa3
	TWr4qjwq9XaIDiYIsaSIijy5a+9JZPYQ/zZ5mLPQ6wGmAEumm68Mw2i50GQ59v1g6I3ftJZfn/s
	1Uv1rftQJWNuCTWM0kfNMnYSeZoFewhht4IrJvfR2ZLQgtGjSE63yGUQvgSwWJMhHU6Y=
X-Gm-Gg: ASbGncuSP6ZP1nypQeSBMT1PJrisDVfq/xAmwvlI7mHkV8Fb9FCvVersyjCdIUT95XB
	7CcBbpFO4xybAFf7DDTe5g3XHJYsr7Wk3grpGtyikjTDYb70INpi+S5iMc7DIh2DG1XbqynCbfz
	tMz5SAjY/1TKaBuFBYU6vVvf/NW5NgC7zoLxoeEO3kOLnpV3zT13E/dvbB6gjcp+2AzefQ9ci/y
	Pw346k4+MNaDvM8Y5v42kv2C3ABdGOaYepTuwaUt3I/UoPHHgPp0OWpLqtvofJ3oEiTXEOx4nup
	7MipqdOQFC2R9ZKJZK/2ks71Zzw3SqfavAR7CUgksV+atybcJg8tMz+uOtP/VkRqRsciSkBZnwU
	PGF7iBw==
X-Received: by 2002:a05:600c:8509:b0:450:cf46:5510 with SMTP id 5b1f17b1804b1-4533cb53b27mr169412755e9.29.1750268454851;
        Wed, 18 Jun 2025 10:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECPQIWD9z7ds8IhVmKE9L3mk+qhph5JCu6Oi2OcOPUlhg6wunpBLWb7MobaQ8CxMoDDmzTIg==
X-Received: by 2002:a05:600c:8509:b0:450:cf46:5510 with SMTP id 5b1f17b1804b1-4533cb53b27mr169412335e9.29.1750268454440;
        Wed, 18 Jun 2025 10:40:54 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e983b14sm3703725e9.13.2025.06.18.10.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:53 -0700 (PDT)
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
Subject: [PATCH RFC 14/29] mm/migrate: remove __ClearPageMovable()
Date: Wed, 18 Jun 2025 19:39:57 +0200
Message-ID: <20250618174014.1168640-15-david@redhat.com>
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

Unused, let's remove it.

The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
still mention it, but that whole docs is destined to get outdated and
updated by somebody that actually speaks that language.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  4 ----
 mm/compaction.c         | 11 -----------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c99a00d4ca27d..fb6e9612e9f0b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
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


