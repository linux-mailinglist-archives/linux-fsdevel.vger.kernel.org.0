Return-Path: <linux-fsdevel+bounces-52073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349EADF498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FE33A3F75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379C301552;
	Wed, 18 Jun 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAea2Qq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F492FFDEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268470; cv=none; b=Lvl1zH/kxXIySqOPr3NDlB0znnhoeE4zVWDVR7tFZrZQHXCU+f8snmnDs5suWKQg6FZX4/eETtyeIz3xSLwvsWP64iMeIr+PbFY8ItL+c9xa1GbBPPhA2RjdEPIiXoVend2h96gtjjX9qzZibG1XvGj+jIwpfM6wwI0TtPyslNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268470; c=relaxed/simple;
	bh=0evh8/P+NmJQ1hFz8tzRv5gkRTQcHLHrxi5Nv+XvqCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg2K/RvjU8nj6z6yItmnPFVXpo6EZCGeHzys7J7bqQIbYw05aGUwJ3RGU5Pjc0tT/G3qH6Bo2ajf2thFccLHugdgUI40SqKAtAirWt22dZ7C8u4meXY4ZkwjlrTdZSseINGyenyWfuPHeZID7mFzACQBWvppfhqhPc5PEwVNIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAea2Qq9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZh2vT8OhFDnKR2hfytPb7VOtq98Q1N4tcWXpFSfOT0=;
	b=XAea2Qq9yZRqSTME6n1ufx6yrhy9bRM30u5adGm2xKCxnwAMCaq1lSsxleYjZ4RCOAOrqS
	+3c8k7OPVgdezXEkc3r9lAFy5LS8Y778qwK/H1TIOid0VbZiCm5Isu9rja7ftBfOa/fgft
	LAhPsBb+Rhl9dduh/NOC7xPptQ8p9Zg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-MuphA_QAPZe5l8BVEbqyow-1; Wed, 18 Jun 2025 13:41:04 -0400
X-MC-Unique: MuphA_QAPZe5l8BVEbqyow-1
X-Mimecast-MFC-AGG-ID: MuphA_QAPZe5l8BVEbqyow_1750268463
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a503f28b09so555081f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268463; x=1750873263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZh2vT8OhFDnKR2hfytPb7VOtq98Q1N4tcWXpFSfOT0=;
        b=igvUucoB2HGoZ4frHuO45hVYfVIAKmIczjEwwCdpzctNtqVjfGhfX8hRQBGHm35e4k
         fVhOB/4+DoNtqDuio/EJs/0jD8cY+B2Xv3yJZdtGU/QysNqqdXN3uu5ioiBesBYLV4ne
         A44b/HAQoW+16AMZp159RPjwGCKoKL17BVXLFCQ1yF1QWuYIiYuibj0X+gH4x40CLJx4
         OugKY5rEWoHZ0oW4IvEHcQG9xDZozbwL8f+IrmSrT2Eyv5B1PcElTQp2l3y0tFqpxD4h
         nQ13Qub1l0/QOsl1ECMwRO59EQFy3DOd/ZO70k0dgm6tbwauj+bZqWKciGpZWZ7XfstA
         CBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGu+IxX8zuXpODR5Hrws2p53filYTAeTSlNjNeStv06Vi0IRKO3iAjRKbNXsJ982n66bFJjkrIxlPiKQst@vger.kernel.org
X-Gm-Message-State: AOJu0YzbP7Ll3XTvO4KktinomeqyZRw3HxcffYHbAP2Hq6D2XfaPLYWu
	nkGMonZruGIoZ6RPYsEWWc7r6mH7U+XVhcH3SZY8Gd7OfJ7Rg15MLNB27gUb7Q92SdBeaQPmpKQ
	fEuYVq255EZrqzunxE1dgG3Rcf7RoxnIx5fG7sL2t6059Ga+WtpF4EF6EmVMvt0d+y7g=
X-Gm-Gg: ASbGnct4RFItRgrUbRIHB5cNUc1VzIAj/lJcJWb+zF2sOO+K3pL5s8MHRK229dYNetb
	tUVrqUBT2nHFvPg96t9HZnhePDu6TC8Y6B0Ws9vDCfqMLCvE6YjMZO10/LsBzr0cnM18YAbgX7A
	VMHV/mBQyeZa1gRscB57AxssD+4iy2PvFd4CCPPu81nObxJK93lhaOizWrGl05DUY6rM6f4pDTa
	wNNwXXSBFcmJV4FtYhJ1+D8iwwF4c7mcp8f2Ow0lop7KWmD4h9LBhy/0Uz1MLT3on4qOBGZwrIA
	yW/7I4GUvk3adC3L7EKBP0KqRhesIIBEIUNNpuC0mpEWlNJXh4BGrt2Zn0NjfJtvc37mZERbk0s
	pfB/QQw==
X-Received: by 2002:a05:6000:2a04:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3a6c971ce8dmr252793f8f.17.1750268462958;
        Wed, 18 Jun 2025 10:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIfeWEl0T3CJLW2Q374pwGp0+w6+6OG/MMLaU0GvL+YMoweLR1hXiYpIsPjINzwYBpzh5jeg==
X-Received: by 2002:a05:6000:2a04:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3a6c971ce8dmr252776f8f.17.1750268462550;
        Wed, 18 Jun 2025 10:41:02 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453596df276sm20306265e9.0.2025.06.18.10.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:02 -0700 (PDT)
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
Subject: [PATCH RFC 17/29] mm/page_isolation: drop __folio_test_movable() check for large folios
Date: Wed, 18 Jun 2025 19:40:00 +0200
Message-ID: <20250618174014.1168640-18-david@redhat.com>
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

Currently, we only support migration of individual non-folio pages, so
we can not run into that.

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


