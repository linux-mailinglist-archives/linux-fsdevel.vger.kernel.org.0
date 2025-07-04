Return-Path: <linux-fsdevel+bounces-53941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB781AF9060
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DF17812A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCE2F7D1A;
	Fri,  4 Jul 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4styRkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEE2F94B6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624784; cv=none; b=uctykq3M3/YgkMRjvzHPdxdmvtQ+sLnc0MdSLAGkL40LYTfARz7a628Mss7MiB+impIL/DU4GvtgrpmpXHlVT4Dmy/jE2LiO6iGfqb0AV8J7UEAfgXUJo80I7WEqcWs6OdYQ67zJ/luuwfEs/jh0B949IfEDSsFAH/q4v6786ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624784; c=relaxed/simple;
	bh=C6jPkBseruyPYB2V4vPia4YjzGxO7oc6LRdQsocjdPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO4lE9aaXH+MiOUTxIV5dRisgvsPfvMChR91Kn1pFFgE62swNtlBJOiSF0gfhH1wP1Dg9BAqi+ytBdpqHnryD6a6VJXBnaCJlSIP+NENilqL6lXqgEP5UtrDx/7lI2sU6emYD8EpwB4tPRZdbwrzu4ZB2ebypNlMmH47UXarJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4styRkI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJheLoKLsD44QkJTGnHlicWVVgB1MKf4t1jgEN3k6qA=;
	b=N4styRkIr9z0upGkGDn660w4JPR6bT7PqVfX02GjZvibaYMWLtLqfk9J7a2seGgCcW0Q9y
	JFF+HjwoIOy5nhtiie3QXuwyKUGQYiCc/NXLjgdzWYN8n+atXpergZuj6WQ9Uiuib7/3Qw
	Id2UtKH/Q50iI/R60p14srBP8iudiMo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-cxXVqO3bN26sfc45XyYknw-1; Fri, 04 Jul 2025 06:26:19 -0400
X-MC-Unique: cxXVqO3bN26sfc45XyYknw-1
X-Mimecast-MFC-AGG-ID: cxXVqO3bN26sfc45XyYknw_1751624778
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so416087f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624778; x=1752229578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJheLoKLsD44QkJTGnHlicWVVgB1MKf4t1jgEN3k6qA=;
        b=N719Rvz+PGnFv16pSbjar0me+JC4M8iBjtzHrKSw1k9rOTfcLoC6lE/C9RjnmnXB+x
         k9nIFLKTSfk5yKl2OBsPieRBDBoFYWQXXPdi27EhKqE0vLEp7Y1zUB99SAyODXns2S/7
         m8d5vdUI4hzjTRwvxpAYvwuEnzEW/91xXiTmaqdQlgLxJ/khBdWSC6kpA8XIB6wDcy7K
         xfuEaUwtX5hXsXscy34193QSsRgSFYrDYd0vbrq4fymjSHeI4eJGw3Tz2dL+pfEz4cz4
         URqvuOfxf3RHL512/KuwjWmx41LaL4dyQOvtRAYkWuDtlyc/+ac6tAJNBIgl0TwxRSYG
         TQTg==
X-Forwarded-Encrypted: i=1; AJvYcCWsOw6joGuQiFsBQh0kUYdrT/5g6OHBJPqkrnNsk24Nh/xtOsJwqz+zc9yykZxEb+LEZEniSvHrofQfz6G8@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXEjvhRuyV0HZ1qmNRUK9h8mhFTj1EJwYnMeWWYPrn4u2Wstp
	eizgmI9WCx3DCZlgCgAxsrbLfktSfSoiLsdEd399YY0153VVmCwa1WPyPHZ4AtZCCYTyVIUDyWM
	Y+EpngwoIbKvqNrxWtFOIhT0kuJU0xS/Sk44rcUsIQQq1607YR+jlFXfQzenCiWN9yGY=
X-Gm-Gg: ASbGncveqPx/RcBw82E0lFXEYw65xfNCcEjEnf5kStL/JNYikEu9JHHmmHF7U7EtRi/
	2HMB1M8jJXQxxK9BA9ZV5PQJY888xqHpZYu7+kDTGqO0dUCuIVJnzfEDZbONQ4YI0byepIPXbY4
	uxkfzTF02q8UMv2EFz7jtAN1Aoq8MM/Enc2MaJd2CMISiju+Vr5OgGpMseUHWLRU2VV26b50Ylb
	KL/HjfiV2bnx56dporT0bm73Vigml1c99rrqT3D+1I0Xo4nWxI+CAAIs8wSHV7lCPCTVXiX3o5T
	jc4M1NsuWDf9qkfFremi9uu4wJaAxZT72smVEsPzKIefG5ljhrW2tnxgtMx8aIasHWnJSJEiLzQ
	3XPqHXQ==
X-Received: by 2002:a05:6000:2f85:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b497019684mr1247071f8f.22.1751624777980;
        Fri, 04 Jul 2025 03:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsIhm+puni7M70O9UOfmv7nAn160MUBp8IUwHGoHgLCi+2FqWLpmioUQXF2wdRtw6a1cigug==
X-Received: by 2002:a05:6000:2f85:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b497019684mr1247037f8f.22.1751624777474;
        Fri, 04 Jul 2025 03:26:17 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9969a8bsm51842365e9.2.2025.07.04.03.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:16 -0700 (PDT)
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
Subject: [PATCH v2 17/29] mm/page_isolation: drop __folio_test_movable() check for large folios
Date: Fri,  4 Jul 2025 12:25:11 +0200
Message-ID: <20250704102524.326966-18-david@redhat.com>
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

Currently, we only support migration of individual movable_ops pages, so
we can not run into that.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b97b965b3ed01..f72b6cd38b958 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -92,7 +92,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 				h = size_to_hstate(folio_size(folio));
 				if (h && !hugepage_migration_supported(h))
 					return page;
-			} else if (!folio_test_lru(folio) && !__folio_test_movable(folio)) {
+			} else if (!folio_test_lru(folio)) {
 				return page;
 			}
 
-- 
2.49.0


