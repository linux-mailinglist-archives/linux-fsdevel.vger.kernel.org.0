Return-Path: <linux-fsdevel+bounces-42951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0FA4C77E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96D7165CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8D24419B;
	Mon,  3 Mar 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRZ2N5gE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048D2417E5
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019443; cv=none; b=jtvQ8KFVpUVivKD+nma5QDLhUIn1TGmUsY2QF55s5pr+91aliitYbzui6XXkyBHum3/Gruu6iWKCmqpaYyQ1gGQOg5mF2CHpUXYwcrSipwZ+O7mxxo1kOJLEMSXhh20/h1K2tZD85ZJhd52WLzTQI51kBS1GkeikjRhD6SKq2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019443; c=relaxed/simple;
	bh=XS+18kAaoj7sIS9sU7RTWYBo+sPOl6gKdkav3g44shQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCH69wWPItgKtQPSYZG/2/T12kjgRdwOrau+yBF5lodjitJKISI9UrhP/OzGq+wMPGoOyOy2QI14TDh3NOBofz2hN6ZuCM+Ak1AigbZZttFxBD4ZwpSTcqe8GEG4e3LXOHuT8CDwbgyJDMCH9y6x4uN2VG8Csok4i46bKZ51dE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRZ2N5gE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZRGaM3lOA1apQzTwMmA5Ztu3DsqGrxsLDUuGH3sRgQ=;
	b=QRZ2N5gE7hbhUQ6ep+pVTrmeOTa0nQAaIQXKrtjSDDuLPwPvn/VvXEuBE+f5OzhBq0d0Ww
	vmVDOscA8NbeWIn8inb/QxlFSAXq4pjLzpL+tHkfW+67D2THcj1i3a8P3t6BhmyhOhyaqH
	SsmHZo0PTSNHJpsNnOdczXD7He2XPLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-OkNioLW2MGyNz6OVoFd-HQ-1; Mon, 03 Mar 2025 11:30:29 -0500
X-MC-Unique: OkNioLW2MGyNz6OVoFd-HQ-1
X-Mimecast-MFC-AGG-ID: OkNioLW2MGyNz6OVoFd-HQ_1741019428
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bbfc1681eso6625725e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019428; x=1741624228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZRGaM3lOA1apQzTwMmA5Ztu3DsqGrxsLDUuGH3sRgQ=;
        b=mfY6pUHpGHdWeqKir0gkkGMKSvJXznhBqa14WKuYq3hXNBvPQoGqeW0eCAwiWEAxWx
         jt1ThQZy+x0Wsn9PqFiW94oh81KCfDH5vBAzGLUCdLdweAP3vuPgUy/ipJTDxVfwwsMv
         /FALLbyR1ZYJekZCbYoV9+2wkujapsUKMnufDTHSM5jFAw2NDiFTEpOjGUXhPiJYVoGd
         POY0QIWLtjyYl5dOfejanI9haV4O4Kkt44+aL8jZAh650BJvzfzM0q7/1cOC5ik1HEC7
         3SyiYD8VwnaNNbFTFIMH1yFbAvVkolMyD5RzkF4IJNdbjve8CoioocWc7WRTuZ5O7ji5
         RZOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGrkB+BTi2ZyHxCh3sLHfOgDVjvpukPxfUBqyuzsePcfNXrgAVbOu2lz5HIJ2x2RrkSUC99PUwl7HTHzEb@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkZwJb+unuxXI9MgzJ+BRoDLu17SqlJzb24yEcxgDLN4eG4AM
	pDemV3MYipWPIDl8ZXeM0Z9NbP8NyFrQ+nPmsPpTIVCdC9TMPp6MeEfDnn7TNai64fSWGD9Smh6
	i2RGc5IatWh0BArQnUkuV8HRLQr0kSbv7BZwQKnBBHjWfyoiDDCS8TvXUzrRbda8=
X-Gm-Gg: ASbGncvQJhr84ok4yMKPioHcNmbOlT8FhNmN0hkIptpwYnj6Eqk2S7Vaj9KrexL+ruA
	WcT6gpKdRhmpZEPhkL6oFs6RSnI2mYNRs6CQNrQv5/HPMB9s/m/sWeR4yLlmZF1D201w7GHf9cK
	EjAKxuNaB3HxAqP1ARyNntidgiXPL5SEBHE7gNu+ugEvh68ETvNHyGmW4yqRwE511OSUoTnl6Ps
	JrcDgWYCwM5TikVk/N6KT6hoWqyWhXhvlQX6ES5wG8OHWT29JrNaUQzkLxTMwrwG+DGXYdmlZnA
	csR3lTc+ZBq6xX+4O/79IKlELL02ZjxvkvqFLsdZRxYM/wFHI38GLvUjTbDlss4B61LMlD9gKoh
	b
X-Received: by 2002:a05:600c:a0b:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43ba675dc1emr98608015e9.21.1741019428079;
        Mon, 03 Mar 2025 08:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6dZzZR0lDpQGPMEmueLq9IDDBNY6mKLfVqXKdpTe4yUOjFN5iEduxrBBHG4nXUacNUeptAQ==
X-Received: by 2002:a05:600c:a0b:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43ba675dc1emr98607715e9.21.1741019427652;
        Mon, 03 Mar 2025 08:30:27 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc52369f2sm28653165e9.38.2025.03.03.08.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:27 -0800 (PST)
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
Subject: [PATCH v3 05/20] mm: move _pincount in folio to page[2] on 32bit
Date: Mon,  3 Mar 2025 17:29:58 +0100
Message-ID: <20250303163014.1128035-6-david@redhat.com>
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

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

For order-1 folios (never anon folios!) on 32bit, we will now also use the
GUP_PIN_COUNTING_BIAS approach. A fully-mapped order-1 folio requires
2 references. With GUP_PIN_COUNTING_BIAS being 1024, we'd detect such
folios as "maybe pinned" with 512 full mappings, instead of 1024 for
order-0. As anon folios are out of the picture (which are the most relevant
users of checking for pinnings on *mapped* pages) and we are talking about
32bit, this is not expected to cause any trouble.

In __dump_page(), copy one additional folio page if we detect a folio
with an order > 1, so we can dump the pincount on order > 1 folios
reliably.

Note that THPs on 32bit are not particularly common (and we don't care
too much about performance), but we want to keep it working reliably,
because likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", fortunately the 32bit
specifics will likely go away again; even small folios could then have a
pincount and folio_has_pincount() would essentially always return
"true".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 11 +++++++++--
 include/linux/mm_types.h |  5 +++++
 mm/debug.c               | 10 +++++++++-
 mm/gup.c                 |  8 ++++----
 mm/internal.h            |  3 ++-
 mm/page_alloc.c          | 14 +++++++++++---
 6 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 694704217df8a..c1414491c0de2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2004,6 +2004,13 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
+static inline bool folio_has_pincount(const struct folio *folio)
+{
+	if (IS_ENABLED(CONFIG_64BIT))
+		return folio_test_large(folio);
+	return folio_order(folio) > 1;
+}
+
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
  * @folio: The folio.
@@ -2020,7 +2027,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  * get that many refcounts, and b) all the callers of this routine are
  * expected to be able to deal gracefully with a false positive.
  *
- * For large folios, the result will be exactly correct. That's because
+ * For most large folios, the result will be exactly correct. That's because
  * we have more tracking data available: the _pincount field is used
  * instead of the GUP_PIN_COUNTING_BIAS scheme.
  *
@@ -2031,7 +2038,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  */
 static inline bool folio_maybe_dma_pinned(struct folio *folio)
 {
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		return atomic_read(&folio->_pincount) > 0;
 
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1d9c68c551d42..31f466d8485bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,7 +387,9 @@ struct folio {
 					atomic_t _large_mapcount;
 					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
+#ifdef CONFIG_64BIT
 					atomic_t _pincount;
+#endif /* CONFIG_64BIT */
 				};
 				unsigned long _usable_1[4];
 			};
@@ -406,6 +408,9 @@ struct folio {
 			unsigned long _head_2;
 	/* public: */
 			struct list_head _deferred_list;
+#ifndef CONFIG_64BIT
+			atomic_t _pincount;
+#endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
diff --git a/mm/debug.c b/mm/debug.c
index 2d1bd67d957bc..83ef3bd0ccd32 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -79,12 +79,17 @@ static void __dump_folio(struct folio *folio, struct page *page,
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
 	if (folio_test_large(folio)) {
+		int pincount = 0;
+
+		if (folio_has_pincount(folio))
+			pincount = atomic_read(&folio->_pincount);
+
 		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
 				folio_order(folio),
 				folio_mapcount(folio),
 				folio_entire_mapcount(folio),
 				folio_nr_pages_mapped(folio),
-				atomic_read(&folio->_pincount));
+				pincount);
 	}
 
 #ifdef CONFIG_MEMCG
@@ -146,6 +151,9 @@ static void __dump_page(const struct page *page)
 	if (idx < MAX_FOLIO_NR_PAGES) {
 		memcpy(&folio, foliop, 2 * sizeof(struct page));
 		nr_pages = folio_nr_pages(&folio);
+		if (nr_pages > 1)
+			memcpy(&folio.__page_2, &foliop->__page_2,
+			       sizeof(struct page));
 		foliop = &folio;
 	}
 
diff --git a/mm/gup.c b/mm/gup.c
index e5040657870ea..2944fe8cf3174 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -109,7 +109,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 		if (is_zero_folio(folio))
 			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
-		if (folio_test_large(folio))
+		if (folio_has_pincount(folio))
 			atomic_sub(refs, &folio->_pincount);
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
@@ -164,7 +164,7 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
 		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
-		if (folio_test_large(folio)) {
+		if (folio_has_pincount(folio)) {
 			folio_ref_add(folio, refs);
 			atomic_add(refs, &folio->_pincount);
 		} else {
@@ -223,7 +223,7 @@ void folio_add_pin(struct folio *folio)
 	 * page refcount field at least once, so that the page really is
 	 * pinned.
 	 */
-	if (folio_test_large(folio)) {
+	if (folio_has_pincount(folio)) {
 		WARN_ON_ONCE(atomic_read(&folio->_pincount) < 1);
 		folio_ref_inc(folio);
 		atomic_inc(&folio->_pincount);
@@ -575,7 +575,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 * is pinned.  That's why the refcount from the earlier
 	 * try_get_folio() is left intact.
 	 */
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		atomic_add(refs, &folio->_pincount);
 	else
 		folio_ref_add(folio,
diff --git a/mm/internal.h b/mm/internal.h
index bcda1f604038f..378464246f259 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -721,7 +721,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	atomic_set(&folio->_pincount, 0);
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+		atomic_set(&folio->_pincount, 0);
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2fc03cb13e49d..594a552c735cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -963,9 +963,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
-		if (unlikely(atomic_read(&folio->_pincount))) {
-			bad_page(page, "nonzero pincount");
-			goto out;
+		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
 		}
 		break;
 	case 2:
@@ -974,6 +976,12 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "on deferred list");
 			goto out;
 		}
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
+		}
 		break;
 	case 3:
 		/* the third tail page: hugetlb specifics overlap ->mappings */
-- 
2.48.1


