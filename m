Return-Path: <linux-fsdevel+bounces-42946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBDA4C78D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265843AFDA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BBA23C380;
	Mon,  3 Mar 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPtcLiqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB323957E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019433; cv=none; b=TKGT1byjxyVlNXxNrnK9BLKpQvGCCMpavfISPfaHMhYQ04Wn3TjhQjBc6pAt3vjHQKPdtWd+gXNBmqW28RVHmsNSbkruBr4gA1rXGluGz1JsZHp5PnVwASP+gpJFyN4lS0KjPkMMrbYNWaWHWLc2TesxJbIAl/2DKS/Kvlpk/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019433; c=relaxed/simple;
	bh=PXIkz9IhpVUA0dg2bzzU7MBYAWcAI8b7mocN+X2/mhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4Ggi/4QEmNDvgKowa+tMyTvEoS8l+UKrU+/DXIIwfmT4gLnoKNCQDYvzpoSPsPk3JvCRAEodqPSr6U3jfMYG1WnFBSOwsjj/kt1GjDMLIdRHwTAt2yHLSYcww4bYiZI1090k0+iKfb8r6PQboSCEF25ZLLGoLDHq1WMnSGpBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPtcLiqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXwoThNtp+x7X/3NlVobY8ZdtRlIGCn0KXkmBvKPXvw=;
	b=ZPtcLiqk3EoSTIZ9rVA64vrtoOV0D7yuydEAfs8oXJO7SdOOADSVw3oBAZcscP4r95doED
	YzN5S4VTP18DGrzl2RrxI4ARW2KAXV+V3ULhf8nn6oSalS0/VCq4B18vJc2Iy48LGDSA5W
	Ke/EPn91Y9NVT/X14HBt0jrp+xX5zeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-f8ACHR-7PouIvbrv161mTg-1; Mon, 03 Mar 2025 11:30:22 -0500
X-MC-Unique: f8ACHR-7PouIvbrv161mTg-1
X-Mimecast-MFC-AGG-ID: f8ACHR-7PouIvbrv161mTg_1741019421
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43943bd1409so33929225e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019421; x=1741624221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXwoThNtp+x7X/3NlVobY8ZdtRlIGCn0KXkmBvKPXvw=;
        b=FHP9+qU34ar97r7eII9OsYIcGTkCi8Nzi4rEOPwOPY72QNAJ4faujtAvedvJ+Jz5NE
         jUDnO3VKjz7kezPppeSkMU3oscMRwys6DmiprHdLYqXAMup1WfpP29Bql5rOj3tzl8oU
         xrpVi7bmK4/x/w+/+NHzjN51eiHcBkVeOXPV+6J2pOaoNc3O/hJvuH6nETHAPA6o1g9F
         e4CyjNycAIdO7j13LwovAayqFf0ksAgjpVTSipAMAekC5YrGl+PnXAhYbuvKqbqGq8Zk
         mR5P7i3JLntLaLJ036eVqRd1Ctq9b/UKhsSRaMOGrmFOLlZMWSQLWZOw2oDPKTfNQyJi
         8Ljw==
X-Forwarded-Encrypted: i=1; AJvYcCV+28mTkCAy9BmEqpGFQGwc9WsJujQlcY/YZiz1plKfUuGhcx0Tcp9a8+rJHvyWdQ1bWbznteashLImP9b1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlb2zXXkb58Gv1+m4aDnjYDimObPfHW0qB3uE8wgnYkf4uISSr
	h5vvSUrQVJsxRff/9rvuGM+1gmv1zA/UHmifze6Vf8vLtWQU00sI59i/folwGW16vJ6VZ878ZM/
	ma/aj4F0/RPGicOUvqcc2bahUTCfe7TJSG/HNoJAwZ/lMhAF7cafPElf8+gSGYIM=
X-Gm-Gg: ASbGncvFjTspA5AqybpuOoNfiAK4jvr3XXd8X2hwKL7ilrwVFzFC+nRiyjfWrcatZ5l
	CNh1g69OEaIYiZbFuAUnM4a58pLDqPJqFeO2fFEbQQzdPzsU1g5tzKjt7pQBTrRYSjIj/8s2owU
	kNllBJbAGP5FT1NKzZ6b+UYrx0b+GHU4pfs9fzIHbthv70bubXRTz0qulrWLkTYZNleCOW26he4
	SC3QM9mF8a7UG/Y3fLLDgLiA9n9uh5tQbALROpg6JHei1w7Ot4M6rdDhf/U/ljDcm6wQ7pw3iWw
	NO9hoXVziop76Xnx9TEVMiM6Wm4tDNxTsjQ+p2mhBYP2QG+UD+xs5Z+Pqm/hon7HWzuvAiIqVpo
	y
X-Received: by 2002:a05:600c:5102:b0:43b:c0fa:f9eb with SMTP id 5b1f17b1804b1-43bc0faff85mr39510395e9.17.1741019421462;
        Mon, 03 Mar 2025 08:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuptMXo5vgbefj6sa5a5v3hHufhVKK5lbtZ5OlCKuge8xCX7GzdoorXNmVUyzEzt6+EvCK+w==
X-Received: by 2002:a05:600c:5102:b0:43b:c0fa:f9eb with SMTP id 5b1f17b1804b1-43bc0faff85mr39510065e9.17.1741019421019;
        Mon, 03 Mar 2025 08:30:21 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba58720esm198718765e9.40.2025.03.03.08.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:20 -0800 (PST)
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
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 02/20] mm: factor out large folio handling from folio_nr_pages() into folio_large_nr_pages()
Date: Mon,  3 Mar 2025 17:29:55 +0100
Message-ID: <20250303163014.1128035-3-david@redhat.com>
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

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

While at it, let's consistently return a "long" value from all these
similar functions. Note that we cannot use "unsigned int" (even though
_folio_nr_pages is of that type), because it would break some callers
that do stuff like "-folio_nr_pages()". Both "int" or "unsigned long"
would work as well.

Maybe in the future we'll have the nr_pages readily available for all
large folios, maybe even for small folios, or maybe for none.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b2903bc705997..a743321dc1a5d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1199,6 +1199,18 @@ static inline unsigned int folio_large_order(const struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
+#ifdef CONFIG_64BIT
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+	return folio->_folio_nr_pages;
+}
+#else
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+	return 1L << folio_large_order(folio);
+}
+#endif
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -2141,11 +2153,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
@@ -2160,24 +2168,20 @@ static inline long folio_nr_pages(const struct folio *folio)
  * page.  compound_nr() can be called on a tail page, and is defined to
  * return 1 in that case.
  */
-static inline unsigned long compound_nr(struct page *page)
+static inline long compound_nr(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /**
  * thp_nr_pages - The number of regular pages in this huge page.
  * @page: The head page of a huge page.
  */
-static inline int thp_nr_pages(struct page *page)
+static inline long thp_nr_pages(struct page *page)
 {
 	return folio_nr_pages((struct folio *)page);
 }
-- 
2.48.1


