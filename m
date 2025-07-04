Return-Path: <linux-fsdevel+bounces-53934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F68AF9038
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85B86E1489
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854C2F5475;
	Fri,  4 Jul 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz7pRfUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2D2F533D
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624762; cv=none; b=bRJ5gnPhnhMxDo58EOXehBv1vNeoik8xiut4FcGovHHrF5iZpiWz5dXFrt6Xdkjl+mjCuAi2uWMGDRI7qGo4yJr8BMAbJ2JsyblwzoX4qXWJt7RivXslajBglIr7sajZlvWwUmMA5iMtxiFY3eWo9N6bpgweolOKzjRGn8i59Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624762; c=relaxed/simple;
	bh=Wr+Kn1AL8lzxIZAskivxC/G+Yen/YkPljMI4x8om+J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF/rrAno51KCzG5S2hkjDlY64sL3lTx2wKFE9vFkbl3NWmeOtXnYWMQlEeO9XI7taJ/rbI3u4pWW5dVx0HJvosHAmAXt2k/SK9RWT3NsaPL7QLJf/OHJVIT5OWF7DJX4C0VG7QqexHKVtBSOXzjxiG7hFnzE0mm7j/wS7LagHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz7pRfUu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZJ0pN+qk8np2TVjDZumvdXYQEUJdQ541mKybIkqdFY=;
	b=gz7pRfUudMau/EDR1GDfJiwnKBy8+IPwj9325vhC5MLE1wnFjCB+9dxa/XOKlKX8CNo7ki
	4N+0MGrO147BluQkXVWpOtb7wNFtvsQnTWtiDOKUN7VQFOOiNwisgfwnCsGo9s3vYWWaTN
	0FIjljEIPYDDkrU7DSLd04dUYX+Uxzw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-fMmfDYoqOoWAmWDiR66HBA-1; Fri, 04 Jul 2025 06:25:58 -0400
X-MC-Unique: fMmfDYoqOoWAmWDiR66HBA-1
X-Mimecast-MFC-AGG-ID: fMmfDYoqOoWAmWDiR66HBA_1751624758
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so499964f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624757; x=1752229557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZJ0pN+qk8np2TVjDZumvdXYQEUJdQ541mKybIkqdFY=;
        b=JXpLKFLhUC1SgbcFqah7qzuJW2Ws2WwJ01Z38vadD1WCvMEV7TS/WE1YUESPLXEyDv
         SKtrUafNMRhvghK83g/atLWP4iFzJUngDV/x2CP9rK2g6jgUyVRJ9HXeRKsw+BYxuQLz
         x7RcSXJF37EfoaL4bBg1XQN+4WNUPyKTdvXZU57EeKR5fc57AqiusiAKicd+8XjU0+kG
         OUfN/gc0CMtWPjkz5kuQ7muxVL6vAlWq8kDAoNhiJ0wZLbGAg1fvUvK/mcvnQ304yLPC
         tLzqeAQYxvY2TtWwoPFth8ZC6tzjzDSB8FS0FusBB+hpx8TuBTAVgveuTRHg+dKfC474
         /PYw==
X-Forwarded-Encrypted: i=1; AJvYcCUSxzdkzYkI3bfagplMw/hLmpitY5TlfUseSPyAHi+GQgVFgPct+IJ5xHSu2EN2RFzHhQojrYBAOK0bbZQS@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUZqDCjrqdkm8gWGjHxki0JO94rjZvHhJ6YLRPAPlgyMBO9E5
	aVxbIAVlshHt9puugZ5gzv9jORu50hVj061tEmxJ2r2h3+8WX+65j/vMF6CfSIxiaRBoRKQlOtA
	atcu4gONvr6Ad2CQQczRLI36XeDzc99+VzLp5YsKe7NCx2QyazjdC2gZHEbtvGZ2/V64=
X-Gm-Gg: ASbGncs3xuFd9xmt/opQ70G0tPdMTuqVpQjmbVMMajztsucArIywQdNTz+QZXVQxu21
	nAbw6VtxgWVV/Wme+wi4PAv2m4ci6lD/T7AIob9TrBf8Hz4EoWJxku5OCjBrIa8zJtY7odZHYYX
	uHX0CGgsAfHnQLlp0UVg3+HFosASCGd+hetOa9rmZDcPRo1doBeIjiWkxX7fhYP5HHMjToMKvdw
	4Ck3LuRE/GqRZ1lKga5FjjRTyRDYu2HV7izhck+79HCbg0o4Lukautol3js06lBF3Vkm8U3Aib+
	HRoZgtDOVNx5cTvJTQ2/rNpKWpBfgpI746LnRerqKZHYR3+Kgk2XouwA5IHEQEoP+8NRXLQ5nLi
	qIuBzlQ==
X-Received: by 2002:a05:6000:40e0:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3b49702e8bbmr1183996f8f.47.1751624757515;
        Fri, 04 Jul 2025 03:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjTF6Bi5YHLD4LeEN00n0rlH4Rvb7Qu4SkJgVJFS3bHVyzx6sYZQQ7vAELvz5hrZ++LyEv3g==
X-Received: by 2002:a05:6000:40e0:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3b49702e8bbmr1183969f8f.47.1751624757061;
        Fri, 04 Jul 2025 03:25:57 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d0fdfsm2172535f8f.32.2025.07.04.03.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:56 -0700 (PDT)
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
Subject: [PATCH v2 10/29] mm/migrate: remove folio_test_movable() and folio_movable_ops()
Date: Fri,  4 Jul 2025 12:25:04 +0200
Message-ID: <20250704102524.326966-11-david@redhat.com>
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

Folios will have nothing to do with movable_ops page migration. These
functions are now unused, so let's remove them.

Note that __folio_test_movable() and friends will be removed separately
next, after more rework.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c0ec7422837bd..c99a00d4ca27d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -118,20 +118,6 @@ static inline void __ClearPageMovable(struct page *page)
 }
 #endif
 
-static inline bool folio_test_movable(struct folio *folio)
-{
-	return PageMovable(&folio->page);
-}
-
-static inline
-const struct movable_operations *folio_movable_ops(struct folio *folio)
-{
-	VM_BUG_ON(!__folio_test_movable(folio));
-
-	return (const struct movable_operations *)
-		((unsigned long)folio->mapping - PAGE_MAPPING_MOVABLE);
-}
-
 static inline
 const struct movable_operations *page_movable_ops(struct page *page)
 {
-- 
2.49.0


