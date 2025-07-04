Return-Path: <linux-fsdevel+bounces-53949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4FAF908C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03084189F514
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDC2FD868;
	Fri,  4 Jul 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxjtwtOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339E2FD5A7
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624804; cv=none; b=oLYnn6EL4MOb1p6IP5G6LhQzv4V2XE/+n5rRF2F/jcYlEpN7wLCkE96+Gi5XW4hBo4UVGqZzOtg3UF4FvbM78CD7ao9E1bTV7Cp0e5JKfcGpjN0kDRgoQoBiH8KfcE0tQhpdkYPWa8xGOtr+QyYfJXq6BhK+ahBVOHbWnUiYDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624804; c=relaxed/simple;
	bh=E7QNy7Hdv+Y8vIwxIlhZiDTu7KEk+npvDBgCx+4vSO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjFJ4jKizMtgYgLRpPpAWdjgiHRPAeK0jW6+HlpE2a8QlZHphgBgSTQlVPf/6ee3E2Mt+7wrLAMQrOYHBbv/1BKkIyMmLBOw7EHbWZCE3zykL64MTftQRjHeoPtyoMFVPF3bNOFo2rTzgVo4rf4wEbilYBPtqLVwoJsSpLK2Y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxjtwtOB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJaNSOUY9l76maSUsyNVNOCD+/VPGSxzGfUbWAq4maw=;
	b=VxjtwtOB/X0IPPDaEVLwvXMHqPwLNLrRmwpUZbId9BrF/qjVx2YryyyxEg0D+cLxo53Ypk
	JqmkolI65KN/x4mWLQKB6xIa+n793QJJWffDIoX5gkS2VFo3Wr5NxAQcyNGzIn5VOsW540
	enaT1QBFoQyBwuU+8klWU3rn3K9yUgA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-NF3Z0XXZNeO_jAAVvEn8rg-1; Fri, 04 Jul 2025 06:26:41 -0400
X-MC-Unique: NF3Z0XXZNeO_jAAVvEn8rg-1
X-Mimecast-MFC-AGG-ID: NF3Z0XXZNeO_jAAVvEn8rg_1751624800
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so4257735e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624800; x=1752229600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJaNSOUY9l76maSUsyNVNOCD+/VPGSxzGfUbWAq4maw=;
        b=uSl9QMUoOKS19thSVmvE0fP76vylg8Nrx89dLkTlXVxP9W/bWBqH8LqItSwf58fjUV
         1Holjf5zgl3X3lbdpG2GomYeXcvfy2w1040RILzc4oe3N7m6ouPRzFWLJ3G6XozoSXhP
         C5zfviNCvvRa8KkJ956qlpnIm/CNZwYllH/vMZmpXA9/O9JZ+OxRTnjQfFTRSqkNugfO
         owHrq7gquAd7qFcVrv7g5vDlsiOteFpBurWW/Zx9CE6gGsRiLbtCuY8EbY4bcqp83Pg4
         SFxTu4Z64+f1m6isx/bnHuHSPXN6xolPUSuHXC++w+XL1EzSPuv5bBwC1zaFLBLAof5e
         iOcA==
X-Forwarded-Encrypted: i=1; AJvYcCX2RqtAGsZUJlEaOonCr04ajwUwBIM9ygqxdzqrXlVcezwhO4qq6BsCTZgCQTI8ly+eUeGsTscTrMcuHbKE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve6VY+pDu28tMttsHFUegqsIYy4okvfAqUsS7coju8LKqVh10
	VYIfhk3aY7HqvQtfk/3GpYQ+erYMM+hMAprfPqZdtPwvAi44/J0RU0K1wn5B8OZPta7SlrKC5iK
	rRZKD2iwEPq2yuSnP+cm4OWOJUk5mmpWLBbRc+/IF7VzeBUTSoOrynZZnGKkhh6l8qzo=
X-Gm-Gg: ASbGnctxDF8X2aFRxqLUPnTXPFwe89RjCUHola90A/nAyIFnrN/cNLtGrB/aB/jR5k1
	SZMndXOQDdM3DvgfBYwFlfHA1mDcP4CbzY89EU7HJj3TDsnTt+da/NAg1O6wAIxkBH72MHP/vuS
	CKn58JDgpG3YiCtbPPoV/1Vod9ODx2KhMFV+FeLb4BsLgHLJc43LD3OmXdACVzkjejveY4sijWN
	xeC79cGG+LD543rDmqsTdO2KRJuj6euUfEYaK2h5FXUP0w+77PfFVqtYef5keNpK11mq8JgcTXD
	2dlM9y+tuN9CVYvYD1W1tvl+I+2/VKiz0QmBu7aAVFFs5Hy54sjB4JUVeE7OJ5oA2LcXTgOg5q6
	iJRYpFQ==
X-Received: by 2002:a05:6000:24c1:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3b4964dbbcemr1548395f8f.36.1751624799713;
        Fri, 04 Jul 2025 03:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG//N9DaWJpqR05PkmLCvqepmh6sjEbIjzOMJ6H89vpgrAi3DitTSNnZ5FWKxlekTJwwx1oMQ==
X-Received: by 2002:a05:6000:24c1:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3b4964dbbcemr1548348f8f.36.1751624799228;
        Fri, 04 Jul 2025 03:26:39 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b1628d6csm23008015e9.10.2025.07.04.03.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:38 -0700 (PDT)
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
Subject: [PATCH v2 25/29] mm: simplify folio_expected_ref_count()
Date: Fri,  4 Jul 2025 12:25:19 +0200
Message-ID: <20250704102524.326966-26-david@redhat.com>
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

Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
folio_test_anon() test only.

... but staring at the users, this function should never even have been
called on movable_ops pages. E.g.,
* __buffer_migrate_folio() does not make sense for them
* folio_migrate_mapping() does not make sense for them
* migrate_huge_page_move_mapping() does not make sense for them
* __migrate_folio() does not make sense for them
* ... and khugepaged should never stumble over them

Let's simply refuse typed pages (which includes slab) except hugetlb,
and WARN.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef40f68c1183d..805108d7bbc31 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2167,13 +2167,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(folio_test_slab(folio)))
+	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
 		/* One reference per page from the swapcache. */
 		ref_count += folio_test_swapcache(folio) << order;
-	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */
-- 
2.49.0


