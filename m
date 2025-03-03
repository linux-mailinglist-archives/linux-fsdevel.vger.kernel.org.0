Return-Path: <linux-fsdevel+bounces-42958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A71A4C7C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5C61884CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BACC2517B2;
	Mon,  3 Mar 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj19pwxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6C250C15
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019459; cv=none; b=VjbbXlMNQG93ftyYkQg76JdX1GWAzBTC7DyB2DK5278Has6VM/AhJYIKqkIetZdPJmP92vli68AmJ/ky9oYqRSaDNatrCBNq+7RrP3ichO05VjBU5KslDgeZ3bC0rdVsAEOeOE89zcONzfg7qclN5f3A16F1eEpuFfFis58K5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019459; c=relaxed/simple;
	bh=Ycu3g93agHZ5+lzaLOnuhINjqTNBvJJTMooJF9ouEus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jysF5O291LATrkLHm81TxOpeDh9t1xlzlBd5ryP48X46Im9FSz/bG17lIu1gbWZvKAuykdM+sqb6djcXKY/i8+U1VLyBXb9Nngf2JTuvWL1+cB82o5TncJWqncni/viMIrwbrmPwngMMc3afl6Z00UUQIy5lstefVDTmPuyo2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj19pwxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
	b=Oj19pwxuhr7w7o54/t+chuRoEa4HGw/nwfFl48FM0bqewxKDMSX0zufAFP4ChLDy+Mmnny
	0LW2IWJbBgenRcUc4UgiUJrfUfFxWGuiAwyABjKowiHiWAwAVeRFKTig6qZCSFB6UfUnU2
	edBLyu37xvDM1cuETrJoQxSeWMbjvlc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-YfQLzCdRMjGvOJ-aZw5NVA-1; Mon, 03 Mar 2025 11:30:39 -0500
X-MC-Unique: YfQLzCdRMjGvOJ-aZw5NVA-1
X-Mimecast-MFC-AGG-ID: YfQLzCdRMjGvOJ-aZw5NVA_1741019438
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438e180821aso24935305e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019438; x=1741624238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
        b=ZtcQtaexvr+nfYUHFv94h36Z26cUUg9xxPnH7iK01igYoXiU4iRH7EI+YHKlGGoRnD
         FO3TJAtEucB7IHfLXMt/n9LpFxa8YgLYh/OvslDw4Y1JPSUyUJ39keY9wPZlQzrreV2X
         O5Rz3T+W4JRkDhP97qeObu8bBecIKBrPEJPOENsWYrWuQ3A1lw/OAroHquUTjv3fTqAP
         zNynUD9rQsk5yWtzfD57PCzJ7/rnM520c5Ob26BR+kSA8XevXtUnxXFkNQDXtNaLGRiT
         orAqxexU5NbOOjy5Hb57AO/4s+SvIirRp8FephC2QsRLkN9Da5L+MBP1z7ONfjKKqkZ5
         0zjA==
X-Forwarded-Encrypted: i=1; AJvYcCU6SjwvMEuUw5QGpqUlJOzhFHSmDkpL2kMAh/4zQsHHJ2Leh7hZp/+VxL+HeyTmr2YaoBKGDUuKp3Pq32Q8@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGrDDvQQREi8YFoMdW54EpYM6f2diR4putG/1KE/M9+XjX/tI
	XA5UoWx/l0xxsZbjwiiof7K49M+rUYlq19apQgmGtwOUzAX+lHJ+cPmn5tM/NOuTSb7D58acWGH
	3kenHdH+ToP1V80mUO5Mfp++v+GR6yfYXRXn50/PM+gMp96I1JOGwuCO8ZQyEDoEd+teP0UKoFQ
	==
X-Gm-Gg: ASbGncu0b7uo6iEymGjYzj6i6IeJY/T5DX7RoMjZCske474QeUtdz8qJeUhiPwrPfLo
	ov5FOs0NqlPmov47EWpcUryhb+VBp/Vt3KkNOhWudqvyqVeQxU4+6jOzc3P7yl3ps33haIjOnfE
	16V2yz4PRBOtD94w3EaCldN57BStf/PTK7bHUtAj3s+KZUT7JKt2VwfTqcNxudGGNl7B5xI0ECZ
	XFpe69A4iWUpGXAjQLLyojylHgVip34GIYak7T83rBu5UnLRbvlvTXGDSqxzugGhzPAbxA42POL
	l5NCXpxlt6GKJhwYlwzdZ9ZEJEXPmHruQIvGTYcCpFov55nDiN6gAHchs18gFOAXJ+Xn9z+s2tr
	C
X-Received: by 2002:a05:600c:4f0c:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43ba66e1f3amr118907875e9.10.1741019438185;
        Mon, 03 Mar 2025 08:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdpz0gqig8RUNxdVw3Ebkq3f5eeFacb1rX/1/2my2Nw7/Vx42fOquiEWgwrBfEGJjD+4uhoA==
X-Received: by 2002:a05:600c:4f0c:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43ba66e1f3amr118907545e9.10.1741019437826;
        Mon, 03 Mar 2025 08:30:37 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc06eba55sm45297035e9.21.2025.03.03.08.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:37 -0800 (PST)
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
Subject: [PATCH v3 09/20] mm/rmap: abstract large mapcount operations for large folios (!hugetlb)
Date: Mon,  3 Mar 2025 17:30:02 +0100
Message-ID: <20250303163014.1128035-10-david@redhat.com>
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

Let's abstract the operations so we can extend these operations easily.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 32 ++++++++++++++++++++++++++++----
 mm/rmap.c            | 14 ++++++--------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e795610bade80..d1e888cc97a58 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -173,6 +173,30 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
+static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
+		struct vm_area_struct *vma)
+{
+	/* Note: mapcounts start at -1. */
+	atomic_set(&folio->_large_mapcount, mapcount - 1);
+}
+
+static inline void folio_add_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_add(diff, &folio->_large_mapcount);
+}
+
+static inline void folio_sub_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_sub(diff, &folio->_large_mapcount);
+}
+
+#define folio_inc_large_mapcount(folio, vma) \
+	folio_add_large_mapcount(folio, 1, vma)
+#define folio_dec_large_mapcount(folio, vma) \
+	folio_sub_large_mapcount(folio, 1, vma)
+
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
 
@@ -352,12 +376,12 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 }
@@ -451,7 +475,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 				ClearPageAnonExclusive(page);
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -461,7 +485,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 			ClearPageAnonExclusive(page);
 		}
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 	return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 8a7d023b02e0c..08846b7eced60 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1266,7 +1266,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		    atomic_add_return_relaxed(first, mapped) < ENTIRELY_MAPPED)
 			nr = first;
 
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -1290,7 +1290,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, vma);
 		break;
 	}
 	return nr;
@@ -1556,14 +1556,12 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 				SetPageAnonExclusive(page);
 		}
 
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, nr - 1);
+		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, 0);
+		folio_set_large_mapcount(folio, 1, vma);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
@@ -1665,7 +1663,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
-		atomic_sub(nr_pages, &folio->_large_mapcount);
+		folio_sub_large_mapcount(folio, nr_pages, vma);
 		do {
 			last += atomic_add_negative(-1, &page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -1678,7 +1676,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
-		atomic_dec(&folio->_large_mapcount);
+		folio_dec_large_mapcount(folio, vma);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
-- 
2.48.1


