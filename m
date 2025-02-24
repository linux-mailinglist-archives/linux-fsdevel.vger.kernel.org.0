Return-Path: <linux-fsdevel+bounces-42466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83389A42895
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53735188D011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5714266B4A;
	Mon, 24 Feb 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFgDzAyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04EF26657A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416189; cv=none; b=G66fqKMTDkSETsr7rIoGFJ8fn1GbQdXXe8vHo86gr1LANdgbC7BrQLfIF1F8BgXji9zLtipgHT9i+8ClKOKb/F+LF2RX8Dkk2btpVPakg/DfZttLiaKA0cxr0IlVYDRYu2DuG2Od0dTO72g1eC9fsIO2QVF0+9JnjMkvTRrXj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416189; c=relaxed/simple;
	bh=Ycu3g93agHZ5+lzaLOnuhINjqTNBvJJTMooJF9ouEus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGgDuRIMUfG7eNw+suzh7Oj1BTRiDQMVf6tMe3ksK2vsiEbdtWBJ9eoJ/jiFSfSerWZsynLvlppHirr/iaEMKBWhTc+UydDUAyG8u0DPGUTZJFsxZSZIPDEAIy2BFw6aIyUE6U05MF5s6v0S1IBk2rNn3U+RV5eQnqi+cC7yNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFgDzAyK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
	b=SFgDzAyKQDWb+W6mNJsdHEAsYxSI71T25sgbBw8HGI6MlzyD1nV5/JH/FcwtPDt/Pluy8p
	CHOYaNKEd9kmT3DvO0DMMFWLYuv1+fP4dnYlA1Hc4UddrmupW3hG1Mdr7oEkYkbFLgk+sH
	5xOGq1TLc98cZ7PgTfOyO2/979TKrZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-cgWqEhOmPXylsJf6YXR38Q-1; Mon, 24 Feb 2025 11:56:25 -0500
X-MC-Unique: cgWqEhOmPXylsJf6YXR38Q-1
X-Mimecast-MFC-AGG-ID: cgWqEhOmPXylsJf6YXR38Q_1740416184
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43943bd1409so32729245e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416184; x=1741020984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
        b=U977MbQjHf2mY721f6OWkp3zmKODC+0C8t/mWXLdqNhVCJzCPlU0AJCWwCiuTsSNVn
         ocDuj/ylyAVGHqZuRtYIBo1BKhZ5oUdCYQleVIxmkFOgEyLoi11FmGdYmtbp66LOQuLX
         Y0bqUSMda9mF89/w27R7NjiGA29FbA3lUUIUBNRLsC++sRbutRtK3S77Go7oxiIRs2Nt
         kEUizuzs5VDeWN9w/b0Bt3IQYMliC2B2iWgMWYuJ2JwQ79cOf6bYIHga7CVIu7vmu0yO
         p1syiSlQkduJpz9Od/puHbLifANSRbGtgteZ6OLRPMrWuJwWHfdmum0G0+1rcwRFTtsL
         5iSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDDDYm5YkkBTIv6RrUUDSvoZ9eE4k3C+c6vyKlglHT0L35/3Oys0vSq+s7iil9BM5V7yERdGBUNEhEvdjO@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqVZ54+xNf2OnU5BGdLnRUGmrhhBac8liWvZGmOnfOFJ1N30R
	DcWcNr3j8vKbDYuKACUgFzEzvYLnTA+yN1BGtJ04sVMW82GPNo8MDZRmlZ+Wh2IFHs2mrNuG0qO
	nKYpED2x9Z1b8MBveU0X+K1dctOR6HVc2Ie/crJisJrMtUsqXx8g0sXdqc5B8VReF3t4u5aOeYA
	==
X-Gm-Gg: ASbGncuJl2N+pl7GPURRhyGuvg51ZTJ/3g/ise2t4K9CiakWt5OIbAzqEMy4z8cvy4C
	/cVamAVOc+TWRldA+FTija0dsRwuJimguKzuwbNpxTs/l+1DoGWuOB/Fz6m6awm/GjNs0aG7jfS
	jCGF+U/iENPQLoWb35GvKIRRPsYRTj/+O4cAGcajWX+tVpOJ6kXfxIGW2J6qcxH0Ueng1v6qCOO
	XnYVhNnyMyrYDBk+CKjDDAoZfc8y52cN91J8H7IZl+HNbfNkGRJhzel5z4EasrFhBG24m36lafH
	dEaVtQrKGM8ZYEGGrK5ptCFw5JJu7aIpdm80g0ETvA==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id 5b1f17b1804b1-439ae1e6c15mr101103345e9.9.1740416184313;
        Mon, 24 Feb 2025 08:56:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELVR15SfmZbX6a5/LWsD6f0rg6Y8hiw7+oMACeve7JZ9CA6HteUq/ZR57fRSUerpUCoh+bqg==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id 5b1f17b1804b1-439ae1e6c15mr101103135e9.9.1740416183869;
        Mon, 24 Feb 2025 08:56:23 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b031b613sm111082365e9.33.2025.02.24.08.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:23 -0800 (PST)
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
Subject: [PATCH v2 09/20] mm/rmap: abstract large mapcount operations for large folios (!hugetlb)
Date: Mon, 24 Feb 2025 17:55:51 +0100
Message-ID: <20250224165603.1434404-10-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
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


