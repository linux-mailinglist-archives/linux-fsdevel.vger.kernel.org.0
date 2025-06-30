Return-Path: <linux-fsdevel+bounces-53349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC7EAEDE37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBFF3B0EAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A128FFD2;
	Mon, 30 Jun 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDZzmIWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF728F508
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288473; cv=none; b=nisdm8iAk5zhcrMoikP9mspMzyMWaEw59HMW/Kf/C8baLBaLf5LoEIEg65boDZbv7h5qsNvURxTg1EgI6WXskQgqu2Qx+yRIAWHFeI7unbbff3N41MSIxBIQX9azXGXloJJSsv35LnSE2PO3sf2gOXaA5aN+xZYzM7yRI4q28dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288473; c=relaxed/simple;
	bh=iVcKD9ZKy+q0IZPfhKWFJvDMMmEVnhfUGzTuz3ApUIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lyx3C7P5ETCZPkA1bfl0g22jDH3Yjr/JhQziMpxjG/t4WVDob7P7d3ETBKTRf5XqVV4awSBVVjHRIcMgCGWzdj2eZiB4zq5lL0ztX8BRK1MInnPcDcZmM0dGNNZwasnahBdobu+IxAWlglPa5vOFOIbNVL/gT9mLBs3Pa08bKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDZzmIWS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIzDkBhnyPsIOakhHuAsjx3fJM8m9J+HURfbhEZ1A0M=;
	b=VDZzmIWSbX3G9KlJMwOl3DbTqoYlps5DlVtS8ERMD/xpoZVArHNhIrhrEorgmYCSSIY9PJ
	ZgNJ/j8u2qCBzVICw/kRkQeBE4//2RzgUy5ClKkW2PVXQEIg7rYg6u4ipddUj72mPPuGIp
	hJjlZ/HdpRU1sS0QgeEt7Aqy54x4GvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-uojRrIClPtqzpXrcM3fDDQ-1; Mon, 30 Jun 2025 09:01:06 -0400
X-MC-Unique: uojRrIClPtqzpXrcM3fDDQ-1
X-Mimecast-MFC-AGG-ID: uojRrIClPtqzpXrcM3fDDQ_1751288465
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450de98b28eso25044755e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288465; x=1751893265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIzDkBhnyPsIOakhHuAsjx3fJM8m9J+HURfbhEZ1A0M=;
        b=A2yxkES6YRLfS6+KN5YiVG4fHvrfluvLXtzDzatseKRfLmvSme5Nm6IH5yMLsGjG4g
         rruvomotIWpbEeY0YqMV8vrFBayCyTSvKfF/1TwxGkJmXQfgqkcBALMZZ3Jj9A0vod3M
         //e7+9XHl+byM7HsIbGiLnBy+W76/skmJ1RH/OHj43Ejyip+sQ8INLy42TF/ruEH6gX3
         BakC85ykMOeT1UEhRlW/2iiBRXSEAUcsva+SuzA7MHZ2Kr64FG/1P1jNq1VCROS1rSKF
         8YAI+bLA5WefogAgs+WihMgmL9O9zmXMcEfm0c0aTOm4DsT4thfPEyTrat4uQPk1NlV6
         NORA==
X-Forwarded-Encrypted: i=1; AJvYcCX4gQ4uvcyS+Y8hPSUCNOAkd4iNS8mJ/XWSMybQZdl+Mtk3CdPltieGLJIoCdAwo6u4z23p79Y/J4prRHs3@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTGmXppyfo1dIQ10+NnCDH45lOXIpfTqeenjEF/LAyROyVnku
	3iOmoAxCRQg5TN2Lifz6rxqsIY7g0PW++1v3/60LetUuvVRgyyHnJgyvstIdyXZNsB+o7xkjjpj
	1SSgTnfaxbjE6kD1sEkV+m0XYySjMX7NmABnynSkjxHG3/tpSiR5dTCI3k/ZQNZ8GNDY=
X-Gm-Gg: ASbGnctBsLt0e26n7CPgfiGA4F8DTTPcnYbgTyDVFbDrxdJVOz/MXkESkBSJIRQT19s
	kDxUJ3Ja3J4t40VgBDygLwUdHjVyysMbr12U3PCXr+Ql/F83rJobovOp//DqTEhay3y/21nzn3J
	uJAmkPCTW+TeDcm8i9EFjk4MTrzFDOol8bvLELTOReEazQovUfRmYwJ+Ab/AoBH9EXT7fcN3pvX
	2LESDsF/ma/+I4Zt10f+5cZImQDZyzzK0MXNje0EhKOYqhkHOFioM7/NfM2V4N6+UA1IsNWRjsV
	MqKK6dv1qYwM01gIpuiGqJJLi9eNARSAubRNTKuEgsjUJOlEqaQ3tK2fX453J3b1vNEvUleobXX
	5+yR7hU8=
X-Received: by 2002:a05:600c:1994:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4538f309394mr135241175e9.14.1751288463761;
        Mon, 30 Jun 2025 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7zExQWNaFUjIE00JTRK6K+i5BO8qjO8BpI1TRkHw1kVlVhDi4cL0K0LNLq7UFrw8vD2WvGA==
X-Received: by 2002:a05:600c:1994:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4538f309394mr135239205e9.14.1751288462959;
        Mon, 30 Jun 2025 06:01:02 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad247sm170241515e9.26.2025.06.30.06.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:02 -0700 (PDT)
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
Subject: [PATCH v1 17/29] mm/page_isolation: drop __folio_test_movable() check for large folios
Date: Mon, 30 Jun 2025 14:59:58 +0200
Message-ID: <20250630130011.330477-18-david@redhat.com>
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

Currently, we only support migration of individual movable_ops pages, so
we can not run into that.

Reviewed-by: Zi Yan <ziy@nvidia.com>
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


