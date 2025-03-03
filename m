Return-Path: <linux-fsdevel+bounces-42966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B59BA4C80E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D0C3AE920
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955525DAEC;
	Mon,  3 Mar 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4ZXJXXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0825C6F7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019472; cv=none; b=W05/5XiaBbXTIBQhpKn8nVZmhO89fMk2UfQHQ65P2GguRf02I3HVSY2GgjkA3fydJoFJWHVX80A5pGzQHrcrWitiyojQxnfoRA1HldNXMn7n3+MYISUkQDT0yTinH4l6E/2UHmiP1krJR2dEXVvoZXDxWPi/5+MmVGz/qCeLlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019472; c=relaxed/simple;
	bh=cTe4VsxVSEBfasQmvi03CXqpkl+gzCOnVs4Cfv//8Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOdQErIbZe7hVEy5VW57uapImYmrnSK+28X0QUtaMOPfAv89K3JtlRRNguKc9ohaY9xlKuW+QAY5f4Pujj8a7mWhaQoB/8edikogLVvpMt4KLYkrj26o6eKJIwydgbjDnIGUQgozk9KZoL7TtRpaZqYtja92HhF/OL9uZHXHxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4ZXJXXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6h5undxasqJ0N3FiNJqqgjSewvjkbEXc2mo8LWFs/U=;
	b=Q4ZXJXXedtPLx8IzfWI84YRwu/QDaVZK9qanPUxSRjn6ZaJ4hQ2c36dt/B1VgJxcDT8aIV
	VMQqZKt64K1EtCDJ7mzBSLGz/3jmZniRLm0D9Nm5OoakRpwimkwfeC2WsAFVXSdrF+M1Hx
	RlMfqGgMmXIf+6GySvafTu4AFN5ifTE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-hE5J39zWMeuvrUYullCPxQ-1; Mon, 03 Mar 2025 11:31:02 -0500
X-MC-Unique: hE5J39zWMeuvrUYullCPxQ-1
X-Mimecast-MFC-AGG-ID: hE5J39zWMeuvrUYullCPxQ_1741019460
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bbfc1681eso6630465e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019460; x=1741624260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6h5undxasqJ0N3FiNJqqgjSewvjkbEXc2mo8LWFs/U=;
        b=GLWnOVNgJZd+DO/VAZbvwo1Rw7GMbNfAtIt7lXJtZ5qChIyCrikF+oqfHM6A8xQdDk
         py+g+Zi9LGyCz+PxLmpuDzijw2yt43fGQADbxQwTpZuOic40GrTQcj1wvRQiK42Pswko
         mSObaeBJVsSVSqg63xFKLKd3AJ8IIj+CePeCBHfv6xkhg1uCfclhxi9dxfL/6hHmIliG
         bhLcG0UursEwH/xi66oAUoP9ahxIH9kej+U5EUbkTgiPM5uODo0Mej+ut7usvcXo7sCO
         +zTramX0/PC/3Fh6ksKEug9063e0JKjUoSvg5OVA43661o5aWyvAfoQFBafkbUnmbTm8
         H88w==
X-Forwarded-Encrypted: i=1; AJvYcCXKUu/feeNz2cFFQrtcsswWQQl2ODkksnCbLfC+mRXXhr8xYtizZDiXrGt2Av9ydVH0pzOo7A3vVhvnPmF2@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbAvbuGhPxbcWVk6YjfgAFFYJ2lyXRk0SE6BryQt563z/Omll
	xotnyvciD2iOwoY6hcMRfOjEw2HRvBGOhKFwQdqEH1QWu/HH8WvdynvJtiRTlUDdemJdgDYxTCZ
	R+5X1Q4KpHJefgjOWLQh3tgkmieqdSnhqg3I93nQc4+MPl3gc/6Vp6WI66Mg054I=
X-Gm-Gg: ASbGncsBtnvmIYBNpRUj1YqQVvjELBqrYLwuRPWUBuKtBTngNMfbMxlSEp73Axf02Xl
	r/NwmU01j+Rg8CmeSJ2sc2AiQdMcXPlTBUAJ3HcrE53OKsyrO8uCr8t62QePZGDiLK3pOrxOkpQ
	1rl3J1ARPkbsLkaHZrZyjAz7aBFVn62mMX3EzT5CYWVdHeaKZOobQSxoPhNRpwpTYA8JBr1Mw+o
	6ehFatCPAjUY4vwNq54QsTaYwE6+zdHjegcSosihqbY9jQ/ONRUb9/xkhlEz8IB8ZtMdhYcaBTD
	HT/BxjqLeK797q5nVxSIac57y6AY5HgpnhyBFleEh8mWq/9907gORptlCkRvdu7uA1FeepyWyUf
	A
X-Received: by 2002:a05:600c:1387:b0:439:a138:20 with SMTP id 5b1f17b1804b1-43ba675d737mr104551525e9.20.1741019460125;
        Mon, 03 Mar 2025 08:31:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF077jzHsKl488EfYl1BqdHJTJ6b3kDjSKQKMSwBjouvZD2J29Qu4rXpeiVOA7Tvc80mUiuyg==
X-Received: by 2002:a05:600c:1387:b0:439:a138:20 with SMTP id 5b1f17b1804b1-43ba675d737mr104551065e9.20.1741019459654;
        Mon, 03 Mar 2025 08:30:59 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bca3df658sm4293845e9.9.2025.03.03.08.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:59 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 19/20] fs/proc/task_mmu: remove per-page mapcount dependency for smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:12 +0100
Message-ID: <20250303163014.1128035-20-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

When computing the output for smaps / smaps_rollups, in particular when
calculating the USS (Unique Set Size) and the PSS (Proportional Set Size),
we still rely on per-page mapcounts.

To determine private vs. shared, we'll use folio_likely_mapped_shared(),
similar to how we handle PM_MMAP_EXCLUSIVE. Similarly, we might now
under-estimate the USS and count pages towards "shared" that are
actually "private" ("exclusively mapped").

When calculating the PSS, we'll now also use the average per-page
mapcount for large folios: this can result in both, an over-estimation
and an under-estimation of the PSS. The difference is not expected to
matter much in practice, but we'll have to learn as we go.

We can now provide folio_precise_page_mapcount() only with
CONFIG_PAGE_MAPCOUNT, and remove one of the last users of per-page
mapcounts when CONFIG_NO_PAGE_MAPCOUNT is enabled.

Document the new behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst | 22 +++++++++++++++++++---
 fs/proc/internal.h                 |  8 ++++++++
 fs/proc/task_mmu.c                 | 17 +++++++++++++++--
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1aa190017f796..c9e62e8e0685e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -502,9 +502,25 @@ process, its PSS will be 1500.  "Pss_Dirty" is the portion of PSS which
 consists of dirty pages.  ("Pss_Clean" is not included, but it can be
 calculated by subtracting "Pss_Dirty" from "Pss".)
 
-Note that even a page which is part of a MAP_SHARED mapping, but has only
-a single pte mapped, i.e.  is currently used by only one process, is accounted
-as private and not as shared.
+Traditionally, a page is accounted as "private" if it is mapped exactly once,
+and a page is accounted as "shared" when mapped multiple times, even when
+mapped in the same process multiple times. Note that this accounting is
+independent of MAP_SHARED.
+
+In some kernel configurations, the semantics of pages part of a larger
+allocation (e.g., THP) can differ: a page is accounted as "private" if all
+pages part of the corresponding large allocation are *certainly* mapped in the
+same process, even if the page is mapped multiple times in that process. A
+page is accounted as "shared" if any page page of the larger allocation
+is *maybe* mapped in a different process. In some cases, a large allocation
+might be treated as "maybe mapped by multiple processes" even though this
+is no longer the case.
+
+Some kernel configurations do not track the precise number of times a page part
+of a larger allocation is mapped. In this case, when calculating the PSS, the
+average number of mappings per page in this larger allocation might be used
+as an approximation for the number of mappings of a page. The PSS calculation
+will be imprecise in this case.
 
 "Referenced" indicates the amount of memory currently marked as referenced or
 accessed.
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96ea58e843114..8c921bc8652d9 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -143,6 +143,7 @@ unsigned name_to_int(const struct qstr *qstr);
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 13
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 /**
  * folio_precise_page_mapcount() - Number of mappings of this folio page.
  * @folio: The folio.
@@ -173,6 +174,13 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
 
 	return mapcount;
 }
+#else /* !CONFIG_PAGE_MAPCOUNT */
+static inline int folio_precise_page_mapcount(struct folio *folio,
+		struct page *page)
+{
+	BUILD_BUG();
+}
+#endif /* CONFIG_PAGE_MAPCOUNT */
 
 /**
  * folio_average_page_mapcount() - Average number of mappings per page in this
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5043376ebd476..061f16b767118 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -707,6 +707,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	struct folio *folio = page_folio(page);
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
+	bool exclusive;
+	int mapcount;
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
@@ -747,18 +749,29 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 				      dirty, locked, present);
 		return;
 	}
+
+	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
+		mapcount = folio_average_page_mapcount(folio);
+		exclusive = !folio_maybe_mapped_shared(folio);
+	}
+
 	/*
 	 * We obtain a snapshot of the mapcount. Without holding the folio lock
 	 * this snapshot can be slightly wrong as we cannot always read the
 	 * mapcount atomically.
 	 */
 	for (i = 0; i < nr; i++, page++) {
-		int mapcount = folio_precise_page_mapcount(folio, page);
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
+
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
+			mapcount = folio_precise_page_mapcount(folio, page);
+			exclusive = mapcount < 2;
+		}
+
 		if (mapcount >= 2)
 			pss /= mapcount;
 		smaps_page_accumulate(mss, folio, PAGE_SIZE, pss,
-				dirty, locked, mapcount < 2);
+				dirty, locked, exclusive);
 	}
 }
 
-- 
2.48.1


