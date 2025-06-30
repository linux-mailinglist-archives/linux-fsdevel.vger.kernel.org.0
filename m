Return-Path: <linux-fsdevel+bounces-53338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D33AEDDE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11768189B68E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416528B7D7;
	Mon, 30 Jun 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnUfTpiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE128B7C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288434; cv=none; b=S4kwYGvVIRU3LGWwZkfnR/0LsZ8X52tu3T10X96Un956SIdHPrat1rpHzIJfC6uOEhTQASMiBO/7Hd8P5SNzWWskx+LngD3FeOrYVChD0TGezOQC1+7zbgDnXnmtxR+x8dGnhUP0+YrYdnOVBtEgTRlJSrbUm/XFUVhbyI6MEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288434; c=relaxed/simple;
	bh=4MxWzYVQT6MaRWyD8DaQIwXKPr34x2kzXAmctRW17zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNiierCJYfWPIQqtjLtmGC+zxMeQx2kkmaO3SkE/CXHVSVwfVzLu/j2wTdSJBYSr7unH4mbAITqltB/oilBOLNB+yd0X/9dwljvZZam/H2laxcwZ63lHiBQG8hcE9TdCQmj/j+T45japxSrmApjbhUQXKBhoEblBmDb5je1DA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnUfTpiS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zonaY4DxD0y8MNMLsQ+Z7vSDV1xV1t770zE0DCe01j4=;
	b=KnUfTpiSLb/kjMvSz7eIA1EEiiVwWsecAWaWTHsM+x8znjM3taGhCkY8UgP9+tdGHvHIx6
	A9MCU7NT/kZdUMgN0iBRS4k8gqvyrBPHRvU2yq8pn4YWkO3ubQQWe5DsMHCYkl0cBIdgn6
	sZ6BgLdmQ5rKx1rIO5Ue+rPKcSlE74U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-37odISDwNhqDJBesx5L-fA-1; Mon, 30 Jun 2025 09:00:30 -0400
X-MC-Unique: 37odISDwNhqDJBesx5L-fA-1
X-Mimecast-MFC-AGG-ID: 37odISDwNhqDJBesx5L-fA_1751288429
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so15316785e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288429; x=1751893229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zonaY4DxD0y8MNMLsQ+Z7vSDV1xV1t770zE0DCe01j4=;
        b=G9Uck1PaNeMtqwG9L5YJyDJo9yA0NvH0E2x7v5RQuvSi8kjZmL5ZfdNIja2K3nAF8Y
         koMgHEtaTrmFmzoGu+DbHBEXV3Q/RZdUvA2FmhTrs5gO4UfH+RgKdnAwf86vmHY4orfZ
         1rWuLlosTQ8iZ3siIEwjLqgJbVzWZlG134mE/mzyXTn2Tf0ZxfSEzEZGAzokt6TZTaBx
         xkpUWQskXAhXiSwP8VJQ2nrSa7ns2bgKVUIGo7LCRRgXq43KYLyzTMy2KKVHRXb5HGML
         JUo9yDBWka2LfYyiSdzJK1BrhNKoihmpjHe3bGIZ28C69afoHRBQ6pREJAZ9dyVYtGrS
         HnjA==
X-Forwarded-Encrypted: i=1; AJvYcCWFSsJIq42HIgwVWxS74DTj9t3ULGA9+ISgNOZqtjXolfDh2SLnMHDl6HsY7BfAYnWbbZjItwOti6CBmcSp@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGN8xUNeCey2R/L++j/cc1upDfEU7AQH43a6tnQnMx6DVziqR
	auKo6t7ezQGZunX5eev5kWNREY4G6jSY8Utx6SjRe2M/bHEWelmT37ISEpe78/SsBbMcYNT7m4m
	QKQhBltC7F9KsOIUHuR0b5QXZABFQ1VrNcgm2nxnhLuNAT6iSv41A/iUbwd1bG4klgHE=
X-Gm-Gg: ASbGncsl3Lv8CdebxYlW+DtLg36nJqUho3AOpvPqiKEeFID0HNXuuDJ+HgYyiyJ/zQD
	0+gFAKFqENhJh6IrZ5KtdDPq6gIxfkB4etZpOj+qSKrpU2HBV2bLb/LBJ7w0aXXhLEDCoNAgUZk
	Y09g+8BLsVW4+CAkmb31sliK6sONxla6aSU/A9OQ1uHHVIa1vA4UDyShv5Dr8Hl8RTdU2cP+1Gj
	dVtVOs5ZKNS9DKtSNs0nlI7acwctNe+l+zD2dyWzpZET5bnpfZaQT0kE1ZZyDz00LdtQQGFqceJ
	r8WX6/s52JQNysKod8fVeLQzLjsMhH54se+fbxBH0sYlSppugCCYj5sX8qwiBUE/BbnFlVgIwPT
	F8xhuy4Y=
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120766605e9.14.1751288428779;
        Mon, 30 Jun 2025 06:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQsOsTnGBejCVgyOLl0Qh2EVLJQ4G+kbMgNeqpJuJaGM9Kh9Xe41tPUK3+55dbuJ7ci0FJ3Q==
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120766035e9.14.1751288428255;
        Mon, 30 Jun 2025 06:00:28 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad0fesm169262535e9.25.2025.06.30.06.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:27 -0700 (PDT)
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
Subject: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky until the page is freed
Date: Mon, 30 Jun 2025 14:59:46 +0200
Message-ID: <20250630130011.330477-6-david@redhat.com>
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

Let the page freeing code handle clearing the page type.

Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b9f19da37b089..bfc6e50bd004b 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
 		__ClearPageMovable(page);
 		set_page_private(page, 0);
 	}
-	__ClearPageOffline(page);
+	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
 /*
-- 
2.49.0


