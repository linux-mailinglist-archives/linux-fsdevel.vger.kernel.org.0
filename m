Return-Path: <linux-fsdevel+bounces-53342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B863AAEDDF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0058189CAF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B728C5A1;
	Mon, 30 Jun 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdtbMg32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7428AAE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288451; cv=none; b=ultuG8Wb4d6/eBPq0mslOiIvd6HAS8oqV5DsNXZaQUI3Q249pZzyfDLQp/YM4qb1u/4rkSTXVIrHKStfe0YDUziUMSBUaKh1Ykzbkmw+3XQg3Oxg7+urxtZAOOBOnNpwZaWMjlsrDiZAxiB1p1S9xWrUHUCvHERTSiGSR3SiFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288451; c=relaxed/simple;
	bh=rcWuXS8i+J1+1NqCBG24FdrnWnU9/Zr9SBDXhHAAeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJzCAeT+FCV+xTR5m614IeeJXQB84WGnDhsTHk0qZR6g4OlSxXCn9jVsW5rGgfMk5UwrSyr8q0/eQ7rlR8T5cKVwpzf/n4pzRL9vn/95URkXUBHYpgar1Ma3IBG/0P4O4J99sKll4CrgXz8/3lcewtp16KpSswGmObUlUpRPSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdtbMg32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOWsWuhFUlcALOXMJY1BPVzymTvYGz+UAPJ/r3JMpJ4=;
	b=CdtbMg32CABVZMySIuJYkWlfYQXxIj2iPixDmNN7eYvswEt6pfQgaGUaQEmLEBF4v9ILmR
	icFcEZx6zbC/sxQpoVyVX/Y9kL5rWpGA30EAUeIsZkkqS0HPYHLz+qbdXRCi3WrAYpEf5z
	WyOOt+alOTOlxYY8EQS9jOT+nDoYepE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-9FISfhaIOyyrl8B54wq9yg-1; Mon, 30 Jun 2025 09:00:45 -0400
X-MC-Unique: 9FISfhaIOyyrl8B54wq9yg-1
X-Mimecast-MFC-AGG-ID: 9FISfhaIOyyrl8B54wq9yg_1751288444
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so1643281f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288444; x=1751893244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOWsWuhFUlcALOXMJY1BPVzymTvYGz+UAPJ/r3JMpJ4=;
        b=YyhKEuVNfV3IZL0CoFdS+XdjFb7kcryllOa1h7l9qU2nBYOLLyBEARZlxzA6i3hMe1
         hKZJj2GGFxGl+BYD4xG2nbgQKNss0nlXraCNoIpA1ZiuHLRaUF4CQGOJHLGQ+r+ViviJ
         +J/SdWDTI/X7rw6RGBtSrjFYKjAK7nVy/5+X8BTHgRNpWbxjNUUsdrIcnwATY045RHUR
         uIcR/PZc1AzyaExPa+zay1gjAkl4k40BM0hY+4wFHLnMlEIx7+JIDPK8T1tybv0HOwXX
         cJ/SNK2AJlwSHXKC/WmAgmxvKoaitJ4OH8ZcBD7Nf1DiRIMy/9BI+SmK5XdPhenDQkrT
         BzJA==
X-Forwarded-Encrypted: i=1; AJvYcCUluk0tE8wYagsXvZIHydAkJ//aSpg6qLSB3ZQnwYNjvqR8GQ8ck7c2oTQqePycDknkzuiTqdQnAM3lMmlO@vger.kernel.org
X-Gm-Message-State: AOJu0YxxalD+1MBwLm+GOuYJMVSD6AmWBzJ66P7yxMJ3ML28IawAUH9s
	NeiZKpUO+92+4V9KhjaBp/QhSBd73ezwLPz4iVggqsm2l2gxSNyVrFUHPfXx0FbXqBNgjN83+TE
	kFoFRReVNcQ5BtHi0w06LjZuZhbkLbXC7IoSP62wR9794qobjIfxvdTCVrzMCBsUAvz4=
X-Gm-Gg: ASbGncsOehH0O/43uEDJIIifgDu7rsYFIUjkmrhtbIpi34bASTsfji5ZP97RRrmQrXg
	O+om4fFx3xj4ndf0FVbdj08J64SZgCHOUQbMXEc7bOzzlwfhUOs5gydjav7I8PKZcxz3hHOLOaq
	DwZZvOD4Pm+St+N0MPYyxJbz3/GtWSPERPnpyVT7As5xwqgGJvwUziKsGPVK/E4qBqDrWHmRdg0
	qTSM5rMPstv2/a+0L1Bjynl7cuWU1MDArYZC1ajiEdpdT8GH+qteqlZriEc8s/i715IER6G0kDr
	IN4ifSinHMHCz33f2+/o+nOlhjCoNlF78n2KEiTvAE6rj6II2ppjbE9iR0ALmjVxE+Rb/boEUAB
	RvqD95eE=
X-Received: by 2002:a05:6000:2b03:b0:3a4:e6c6:b8bf with SMTP id ffacd0b85a97d-3a8ffeb382fmr7766110f8f.52.1751288443195;
        Mon, 30 Jun 2025 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx8UWJltFtDizxyihu6cXjhn3Ci52lQuk8tR1EGhsL0o4Tf/9IaaIN7lF9qzEV9dDz+LNV9w==
X-Received: by 2002:a05:6000:2b03:b0:3a4:e6c6:b8bf with SMTP id ffacd0b85a97d-3a8ffeb382fmr7766023f8f.52.1751288442367;
        Mon, 30 Jun 2025 06:00:42 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a406489sm136745865e9.27.2025.06.30.06.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:41 -0700 (PDT)
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
Subject: [PATCH v1 10/29] mm/migrate: remove folio_test_movable() and folio_movable_ops()
Date: Mon, 30 Jun 2025 14:59:51 +0200
Message-ID: <20250630130011.330477-11-david@redhat.com>
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

Folios will have nothing to do with movable_ops page migration. These
functions are now unused, so let's remove them.

Reviewed-by: Zi Yan <ziy@nvidia.com>
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


