Return-Path: <linux-fsdevel+bounces-52085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1FADF4E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BDE4A2AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12EF2FCE35;
	Wed, 18 Jun 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9spKc5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2A2FCE3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268572; cv=none; b=g2J/vn7e3K1TG61TRVOqPBq92g09PUqPjqRGVbbyoQR8ZSH7LpjJSEA79qUXL5IPd0SJ/Pzeny6nhYKh71f4SpYGvvvHmxlbl9iccBdre++gBWqkLqn9ph87fyEcnakKQvHNk4JXYM4WggdK/yQqtF66lSwOXE0QaAkcDtkT7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268572; c=relaxed/simple;
	bh=mR4wKIFzNAz9lCxg/2MhGizqJd2oyhLD6gTXEVIJK5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMt/RXQzVUt8g1yKUJPn755+x+iIDUgHwxBgRWn4VieYE6Rv0/wolNf1wH+rZpeV+WbntDrPWa39g7StG4MY+rcPIsuYZKspe2xhS2sgVVTrT00sK47GroEVJyY12ItVmWAI65aSCwt+apwstIIIxV9oZ6pvNIJZK3BhWb1R6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9spKc5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFGM8ws286HsZ+G2nyb5/sPhilYYDV0QN54X+S74Jfc=;
	b=F9spKc5ALjnZdsHQ62YP5JBY7vZpIw7Trt6EC5aNxkhVUHAoSKbY6QNQXURePI2o299jED
	4GM2bvRq6U1JIy2pt9GvBfgjjF/L9CHpCqFwGoV8/KPAPZQkUyg73Qia7OtrXAPFZhr7Nx
	GQCM5C6OkQN14eqSdOwjq8+mEf3LS8U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-xIBz9rdrOVSCUuZm1Y2H_A-1; Wed, 18 Jun 2025 13:41:21 -0400
X-MC-Unique: xIBz9rdrOVSCUuZm1Y2H_A-1
X-Mimecast-MFC-AGG-ID: xIBz9rdrOVSCUuZm1Y2H_A_1750268480
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so3929141f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268480; x=1750873280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFGM8ws286HsZ+G2nyb5/sPhilYYDV0QN54X+S74Jfc=;
        b=gLcXJwR0SdjrIlrzncYzleq1QlJxIzAvrLGPGkFuzrwRGduEr82tdL7d24qlgHp9NM
         UhLulSW1dV00f6YOx+kAypURoq3H0ZfyZVkL9pAynqe3T4cSAd7wGChNY8ksYRp3yu62
         Tg1UuSFBcCBMO8B4CdPAit2i9T7Ad1jeUJosCaWfVybrAd4H79r/D9EjhB9FRgOmkPTm
         XR9ySFe5xprSeloXnNxqHpfj+VXfeFVi9jl9PXv/xm1jpgm3AAusoPvr9hkBWBSONSXv
         InfjKRIUfAQ/y/hIR+6sifyzjkfOqWjkosEpt4zQyRVVtrhAKiCtaZWWLWCouKwgPOs9
         3FLg==
X-Forwarded-Encrypted: i=1; AJvYcCVfLAMTdAkl/l0nkW3R+Xo5sVrSH05y3YUHL/+4/zL91/Aoo+N6EteGHf1j5yPpxk0Hqr+WM2fr6k7nE1/K@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkkBLia3MLCiaQ34oZvMikzWk8VTebjddgaQKYzpUZDa3P1H2
	+wiNwPayQiIiUoXU4kCDcfYBlHwfSTbIQxRGTxfOiwPYcA8oD/0MiMHXgPAzYlb5f7+edI12+ct
	IL05nKCOisnnHENQgCKmC3kJ55mjxoZs+n2zRzPrxG8iU4Es2WsLm5ES5Rfi9CJlHGK8=
X-Gm-Gg: ASbGncvyPlVGqiy1ga7pbOaYMJd2/GV3emRWMjZtL3K3AuuJVnICj7H4LedzM/hGEjV
	GTcH6WpJpDjobtcOVhLRYDpIAjMMMXEEIzeBJm/WP7s27yJA1BSxphEto8JBNTRHf0lmQfd6OX5
	qqD6ob+XRYJIJvke0+bBxjBLCGAy3NX0Od0aucVhxV5my5JypHl2urmG7t6zGc+XrM19wP+RqLQ
	03UcUzHfvmJmmd7RgOzAbQatJg4CRWcMHWsV1eaaKtaPxSjjrhyopbd9pyhPJsit44J/+U387cA
	kkKCKVtEyxpKVRvngLzCnvbpNZdsrlBghuZqXXlR20lza7m/kM1zG2inggdom1JvNOdDs27abGr
	lHF9nqg==
X-Received: by 2002:a05:6000:2f88:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3a572e6be35mr15379301f8f.36.1750268479815;
        Wed, 18 Jun 2025 10:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGgOLn/JzQiVrSw8561br8iJzDS6W98mGXalaJQyvnuLaRLghELBqFwLLjepyMMgs/X1CCpA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3a572e6be35mr15379264f8f.36.1750268479340;
        Wed, 18 Jun 2025 10:41:19 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b62ba7sm17866251f8f.91.2025.06.18.10.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:18 -0700 (PDT)
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
Subject: [PATCH RFC 23/29] mm/page-alloc: remove PageMappingFlags()
Date: Wed, 18 Jun 2025 19:40:06 +0200
Message-ID: <20250618174014.1168640-24-david@redhat.com>
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

We can now simply check for PageAnon() and remove PageMappingFlags().

... and while at it, use the folio instead and operate on
folio->mapping.

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


